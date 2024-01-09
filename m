Return-Path: <linux-kernel+bounces-20492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E94827FAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911351C213FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649DDB65F;
	Tue,  9 Jan 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYgxkeiv"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD113AE2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e4d515c9aso7599915e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 23:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704786278; x=1705391078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WyKODR2ZEbBQIYSooTDZKjG3f6gcw+Ofatu+7Ljk1dY=;
        b=RYgxkeivLxpnYAMqvkEwQoz8NF2H6X6hLfnvCtUuyE/+Yw86Yb+/RB4Xb9zA7KbJUD
         Ji1tIcjZPOBY+9957YAYh6XKmyibDaRTCRz50eJyLNTd6P6kyzN5kyLwaLPsostxrSRn
         WYJwPl/YcJxqxTnq+RjPQyDx21eiX4I15V6nKpaIykyn83TQjQ/3MauO+4lKOhn2Fyh5
         au0sGXREv2cXNWFJ8MoVcLrE6PyvzArdjN1xRzXu3h9jGBm0E8BLgfF7NhAvXnhuFnAw
         UvlqcbmAaULR+v69TU8jt3cwklHF84BIBVzV3hp+02cXh3GGAsgJqRL+0Lidc7HQ9Sb4
         TSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704786278; x=1705391078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyKODR2ZEbBQIYSooTDZKjG3f6gcw+Ofatu+7Ljk1dY=;
        b=afstS1czCdKerecnlSO7E5Qbn3vVS8hRn3XKW7uC5Y2wzpCh9I68jdlTNn3n8pLyzK
         8mFEcQv/Rmxq/0zHFlsVYdOJR0HIgarw94SXVs6/ONDA6+WIfPMQYliKBCE/lVJRkvBq
         f+uNr5nyC8h5R2dnEMdI+HTH5suH/xDHWP9yG0LD1SU7DsLGczLDbg3uHtxmSkN/+tnL
         MHQfWyoY90h4cDq1xWvU5jID5LAs8Re5ON2Gal5OFERRWaoyPiQ/iuCOPoTJZZYctBZE
         jQIre0pl+uyemVs057kGKVAqZZMkveaiscXqwMvT0pRXFiBoctTMBHy3oPNq9rOEW/iY
         H1Uw==
X-Gm-Message-State: AOJu0Yxifb8gB/zaNJ85DEe5va1McBuDHCkfbS52Hq2zZVh2pRsyida0
	JOv1OKIrzrMBn0j1RjePASYQqZxvBXzIgg==
X-Google-Smtp-Source: AGHT+IE93+FidJZLfj+S844MOIXQn4WyHNFdclFvkYFvlBheufM5UFgj73m1IZZY8RtzG6vp0gbYvA==
X-Received: by 2002:a05:600c:5207:b0:40e:45be:3a44 with SMTP id fb7-20020a05600c520700b0040e45be3a44mr1780522wmb.141.1704786277810;
        Mon, 08 Jan 2024 23:44:37 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id j40-20020a05600c1c2800b0040e451fd602sm7544385wms.33.2024.01.08.23.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 23:44:37 -0800 (PST)
Date: Tue, 9 Jan 2024 10:44:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steve French <smfrench@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/3] cifs: make cifs_chan_update_iface() a void function
Message-ID: <aefa9618-b6d0-412c-ae6f-7839233bdd27@moroto.mountain>
References: <b628a706-d356-4629-a433-59dfda24bb94@moroto.mountain>
 <eac139a7-76d4-4067-8c25-15e30692aaf9@moroto.mountain>
 <4c6b12c9-0502-400a-b2ba-dad89ef4f652@wanadoo.fr>
 <CAH2r5mu0BnSuOcbG9L=Y0Hhe6GAtOxUJ1R4wkVmXn7A-Vgxndw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mu0BnSuOcbG9L=Y0Hhe6GAtOxUJ1R4wkVmXn7A-Vgxndw@mail.gmail.com>

On Mon, Jan 08, 2024 at 10:41:35PM -0600, Steve French wrote:
> added the trivial change Christophe Suggested
> 

Thanks, Steve.

regards,
dan carpenter


