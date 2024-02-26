Return-Path: <linux-kernel+bounces-81154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7D9867138
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD8C28FB01
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F003D208B6;
	Mon, 26 Feb 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyLnGBqz"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D514280
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943031; cv=none; b=Fpkib3lHqJbWkTxHbdvSXcHgtZ8Y1XnifSbGzyxiXLvBRQMYJNgqeAjb8pAD/7jHs04LSWrf2fpyrUP8Xg3yowM7XW79sV0ilyi6AtDnKXaE1QPifq43IUuis1DCUlRSwl3pNYFkvfT5QHZ36V2kIJlYTnd4L9hOIx2lLx727xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943031; c=relaxed/simple;
	bh=nIlN/jtpPeQnxwEmEu5CghCABz2PEFjtvaRZ1Mc+Nz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFbMMIuN45+gxc+Srg/6LNTIWvFlcwFxnkrpESoXHWqOosJZR/S34ICDPO2Y7UtQLgXSXUzS83I9VD/qS1KpRLvwf4PG+ODS2Bt3yuTFS2WLfIqXF/AxjuGs86R+gRdQKBdUiOwdyMDtNrTE1Fn6p+LJOSHNOYG46GOLkbvpNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VyLnGBqz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41298159608so12369105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708943028; x=1709547828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xlfTscgQB9POTfBUx30Xla8SuM0B8+WvX4CUIan6AuI=;
        b=VyLnGBqza2gKXCx7VCfcTpLM3pyceNeRbjEJOY2GQoXwmBrXj5vA4qw3NrT/nWNn4C
         WVWd3pdvTvxrVD1VgWgyIpameEDMY/aUmI1dyl9kkVOEPMunildjQUVEFvIOjUuNbVp3
         jlnU73K1GKct9W+7kjkYooR0jJ5dYLW6Yxrn6C+0ci3JBgjv7THulDrX9nqgbgUVwhVP
         OwIgKSvRqSqOaLv4RtkUgaCuc3ImwS/r/dYslCRYgpFi0RxhZrqoJ8ofNmOCsZ40Wnda
         Nhn3PQ9zbEE2/HbrbYdz3dshAGRwSYkK/nkY/TapaL+RqlyswgKVPMO1FoyHJvmp1mGo
         iQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708943028; x=1709547828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlfTscgQB9POTfBUx30Xla8SuM0B8+WvX4CUIan6AuI=;
        b=FbLeKQVXtv7Rk9kQROQZc6JTuJBgb0ILcaU48HSmPGAuw5BKuEmSLeEqWsuVQgQtad
         cVpOws3xIxsj1Vp7p892A9DRqeP7IFw0XmVduFxpH7fjvNjsBZzTbIReqSF79BCtLOvG
         GwvTOO+TcnHyZmi9PlGSVDnp/BeG7oIyQqiHYj+NLaD+R0iTGVQ9chYKLpu29MStZXoc
         KxzFa7eI8bA5VntNhlZ6aNPkD74whbwnmDyHFaKNbRhZ0sQMuT96kawZ0x6MmZIMoVvi
         pv5rFmDMm9m+wbas/pPiPod6BLphJjy+FPTW3KyD0De93CsupSygAcqSjBrhVSfdBxAI
         W/cg==
X-Forwarded-Encrypted: i=1; AJvYcCWd1X8mBASmJbS/YmETomomazw3++rqa8hf9jOoHK7ZiDvIEPMMk5DF0Kx6Um/mhGoegRPS4Updf5GPSBZZubwEgzL0GXHkD1Ua6j/R
X-Gm-Message-State: AOJu0Yyzw3PSdyHWE6UeOT5nGFEUUPD66CRb+Rjtg59AtMcte6aIyykz
	KscyqU1uHZwcFD5OVr9K9MKbPtLKjvePDcSsvdib4YuELohYg8oqRGx8CPuu2Cs=
X-Google-Smtp-Source: AGHT+IHOYrGSl/T75n+H59MRt4wltRF4iyb6EgTFzU5G4WEZznntNnYPfL0Uq4b/7PjoKUHydY9afQ==
X-Received: by 2002:a05:600c:3ba6:b0:412:94a3:2843 with SMTP id n38-20020a05600c3ba600b0041294a32843mr5818110wms.15.1708943027842;
        Mon, 26 Feb 2024 02:23:47 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b004125f34fd7csm11415118wmi.31.2024.02.26.02.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:23:47 -0800 (PST)
Date: Mon, 26 Feb 2024 13:23:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meir Elisha <meir6264@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Staging: rtl8723bs: Remove spaces before tabs in
 rtw_set_auth
Message-ID: <96ab1a91-7682-4aed-a522-ceaed0dbf56c@moroto.mountain>
References: <20240226075225.44881-1-meir6264@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226075225.44881-1-meir6264@gmail.com>

On Mon, Feb 26, 2024 at 09:52:25AM +0200, Meir Elisha wrote:
> Remove spaces before tabs to improve coding style.
> 
> Signed-off-by: Meir Elisha <meir6264@gmail.com>
> ---
> Changes in v3: subject and description changed, revert dead code changes
> Changes in v2: remove dead code
> 

Sorry that I was not clear.  This needs to be split into two patches:
[patch 1] delete dead code
[patch 2] remove spaces before tabs

regards,
dan carpenter


