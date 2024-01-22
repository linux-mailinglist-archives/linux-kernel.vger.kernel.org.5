Return-Path: <linux-kernel+bounces-34036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBD1837234
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD3A2910A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8FC3F8D2;
	Mon, 22 Jan 2024 19:01:50 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AB1EEFB;
	Mon, 22 Jan 2024 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950110; cv=none; b=M4YJvXTLlPi12zcU4ggzd4YExBuHo1mERzY9y2m7LhCIe+lZcMJEX2PMR6AchbshTDXahsQAp5qvOKBAQ+nDmR95xEIAHTqXqAiswqO5pbMp+UqFVEBkWVI27aH22GBi/VcdBTUHQSmbf1Oy+S8aIQhsacVd9vatNzemV6sVLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950110; c=relaxed/simple;
	bh=mYDzATFdSZLIrUKuLjaf6al+ufc/N9bEaNgJX9sx+qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqHIytcOUbMc3feSZdxA4xhp5ng5SFmx1oElh+Za9QTR5qj5J9uUbX6mvNMFaPxacjeGe05CwYlXxLKHMudcLRlpOkz3SXGI12QXXqoN9lvdlVWOKfzs3OgcD4mQgyHruC7wOWiZMGDflixK9j7XbE3XcLqedkTCrO6V8mNwnCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a27733ae1dfso368178066b.3;
        Mon, 22 Jan 2024 11:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705950107; x=1706554907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5HXJODmOOJRvsIZW/uuOAT4F9Guqycs6nvFMJM+skQ=;
        b=hJN5oX9/ZuLwK40Gf5eP9mpvhCkp48b/aUv3vusQAYYAAJ+z/MmijKgunTvxL6Fy4R
         C8MBNhplZjGxs9GZ9lkxKrbraYozC6/AnoSlqs8K2zmD6h83VEcABIIYskSXRd4S2OmK
         oKS2NrK7nLCZ+DPCi7+R6H5d0mD8tkmNO+hBZh9QipjgK2oeZPdxlUKQNQlM737hCZ0o
         cV59VzFFx5m61XnPgsUDZdnwpw7kHDIm7JeUmdZ65yZg38DlqmVkow2ghdWIS9TsytpI
         /W1yv3ERyhPQ1vgeOPQdjSs3y63FS2+YGHHMjutJ94WcKDlSlUSTEkNixAd9dWEiT+lp
         3vPg==
X-Gm-Message-State: AOJu0YxUoXlEEeDN/UmgXwYG91lYLoGnaeR1w7qLZ22s4WLoRAw9GJ7u
	LOHY2O0KrjeTN20dR/tm+bQGsZqQxtdq/bpHq7hf4H/1hBkBVM+v
X-Google-Smtp-Source: AGHT+IHuXCLP08KAopDaK2QmU3OaqcAX90CqqOJaRFmeSICBxlPCt3WBhnD+otXlvoO8zyclS3KaWw==
X-Received: by 2002:a17:906:2b01:b0:a2f:5848:99f8 with SMTP id a1-20020a1709062b0100b00a2f584899f8mr1092335ejg.80.1705950106624;
        Mon, 22 Jan 2024 11:01:46 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id d26-20020a1709067f1a00b00a27a7fa8691sm13653235ejr.137.2024.01.22.11.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:01:46 -0800 (PST)
Date: Mon, 22 Jan 2024 11:01:44 -0800
From: Breno Leitao <leitao@debian.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>, dsahern@kernel.org,
	weiwan@google.com,
	"open list:BROADCOM BCM4908 ETHERNET DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 04/22] net: fill in MODULE_DESCRIPTION()s for
 Broadcom bgmac
Message-ID: <Za67mLGJ86qpt1St@gmail.com>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-5-leitao@debian.org>
 <4eff5139-b5ed-46a5-accb-5b2fea9ab212@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eff5139-b5ed-46a5-accb-5b2fea9ab212@broadcom.com>

On Mon, Jan 22, 2024 at 10:50:32AM -0800, Florian Fainelli wrote:
> On 1/22/24 10:45, Breno Leitao wrote:
> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to the Broadcom iProc GBit driver.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >   drivers/net/ethernet/broadcom/bcm4908_enet.c    | 1 +
> >   drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c | 1 +
> >   drivers/net/ethernet/broadcom/bgmac-bcma.c      | 1 +
> >   drivers/net/ethernet/broadcom/bgmac-platform.c  | 1 +
> >   drivers/net/ethernet/broadcom/bgmac.c           | 1 +
> >   5 files changed, 5 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
> > index 3e7c8671cd11..a6bc5ce70230 100644
> > --- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
> > +++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
> > @@ -793,5 +793,6 @@ static struct platform_driver bcm4908_enet_driver = {
> >   };
> >   module_platform_driver(bcm4908_enet_driver);
> > +MODULE_DESCRIPTION("Broadcom iProc GBit Ethernet driver");
> 
> This should be:
> 
> Broadcom BCM4908 Gigabit Ethernet driver

Thanks. I will update in v2.

