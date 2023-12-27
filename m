Return-Path: <linux-kernel+bounces-11883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB9F81ECE9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A937B22245
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10975690;
	Wed, 27 Dec 2023 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="wRBQpcU0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A453A2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2046b2cd2d3so2505642fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 23:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703661912; x=1704266712; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rlmtxuw1kYY8GVgYzzd0HTJPJ+7vbZfSEFgBhzg17jo=;
        b=wRBQpcU0PGijYSCaNwDtVMPCzw3JcETdxCACgD4JFmu0DT7NLB2Ouy88f9V6iVzosv
         F7EuxBx3+soKY/1nx3/i5WMYiBE0i5W53qHCqvUNKUrdRJnyN92Y0t3vJTsKWrpwEhNr
         61/xTqLt4y+UwN5drBkoDqHIG4yDPS1LV0qwdzpXpzFCtMvQ9C431XPkmo3CFysUmOkf
         uUAU3yJI2o2LxXk7NvUoiCxhLJmvc5yVbhvUAa7gOW1IGq4KdpZ2bV8hk5SyBUaeD513
         0iGBpmEMhu3vzIokJJZen0A8fkXApN8U8UkVgQ2g9YAICcuZ0PprD3r5mRld8VC64ChY
         XJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703661912; x=1704266712;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rlmtxuw1kYY8GVgYzzd0HTJPJ+7vbZfSEFgBhzg17jo=;
        b=TOkvhqcSzhyUx0Xfi+vDe9TzuIxerlafqEv3e5GCm0Ze3qDlxjSeo0rg2nCm9Tub3m
         x1nTIJvVRAo+zrg4He/fAwo8FDnBEhTERCBkZCMReZDCeEBOzp5zJqowyk/WOs2sQVFK
         UatsGnfAEJxNlES3iHW8f4GmX9ePgP09zXb+Ji97+LAgdlthnL1sL7HZYzZOuQtnDVaP
         HdvDA/BY1uXezobNVDyTugLuxOJF7BuSAxgl8FCZV8mp9RjFhW9zI+//sLolut0HpJjM
         u0PwewtjXnVuIo3TxY3cTLl2pLkuRnuv97yL64ApA9h2h197nTGi5faqHqklIx8xnPKB
         guNQ==
X-Gm-Message-State: AOJu0YyFBT1iPkXRU1iTNICQ5TbSN6MJckFCidnTg1VyP5cFYix+gGZv
	3t0NYmUCb8D+M8xtDFKTEsvpvSU/ikskqg==
X-Google-Smtp-Source: AGHT+IF7znp/AwmYDdxA7jyqY9qzWPLuT8fC912Ygsnhfb3tdSVxmeAabe4WmnIQOm1u2EUdKy1faA==
X-Received: by 2002:a05:6870:219e:b0:203:27f8:b5e6 with SMTP id l30-20020a056870219e00b0020327f8b5e6mr10860036oae.117.1703661911136;
        Tue, 26 Dec 2023 23:25:11 -0800 (PST)
Received: from smtpclient.apple ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id g33-20020a635221000000b0058ee60f8e4dsm10657162pgb.34.2023.12.26.23.25.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2023 23:25:10 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
From: Li Feng <fengli@smartx.com>
In-Reply-To: <20231226103743-mutt-send-email-mst@kernel.org>
Date: Wed, 27 Dec 2023 15:26:30 +0800
Cc: Jens Axboe <axboe@kernel.dk>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E148FC5-F9A9-4A86-99F1-8D0B93412181@smartx.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
 <20231226103743-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)



> On Dec 26, 2023, at 23:38, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
>> I don't have ideas right now to answer Christoph/Paolo's question.
>=20
> Paolo did some testing on this thread and posted some concerns.
> Do you disagree with his analysis?

Paolo gave a very detailed data analysis. Indeed, in some low queue =
depth
scenarios, the data dropped somewhat. However, I suspect that it may be=20=

caused by other problems (such as test fluctuations) rather than the =
benefits=20
brought by deadline.=20

BTW, I think 128 queue depth test is a very important and common =
performance
test item for storage devices.

Thanks,
Li

>=20
> --=20
> MST
>=20


