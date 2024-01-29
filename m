Return-Path: <linux-kernel+bounces-42412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843A7840108
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2FA1F218C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF08454F95;
	Mon, 29 Jan 2024 09:12:17 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48E54BF4;
	Mon, 29 Jan 2024 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519537; cv=none; b=pNrgVqymLUHV5sdN0DhN8v7iDk43mwN7tTKukPrNOiC1UPNV+Vio5T7lo+5eOzZphXg/O6qjSH+r7gmpp/TbBtqMpGmXXd4pZmk1eNlM+Oxc/M5Rkv2Y2rP1kLA+0NZlIiYU3/UXp9mOs/8Aa0KdR9TNAT4RrGIyVgDy/VvCtZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519537; c=relaxed/simple;
	bh=hizOf/AG0n8v+6aHvs+7Jk1CsFOATbCe8wcFKayypHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hzl2zq7pPqpokkGlMZVtssTjEI8SRDnmQKex6rgtLNBkImeUYSh2+wvBNaU7m/xaTMMFcToxvRFxMEk7El62XkBsSiyOgPWtfjp7R35bCgJgHj+yWmvuAg6UzGo+GWfgmsZ36W0egljqTSR+U9YXM5JYaL638O/T+9hGAoU4CeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3510d79ae9so238458066b.0;
        Mon, 29 Jan 2024 01:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519534; x=1707124334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSjO3HKbWnEMbJmXXm/e24jmZWp6ocvyyX3F4jrYdE4=;
        b=w58Hyp3QZghY5z792kRrWfxTJWVb8qSmS6qPiTIdiqS9ODFX/sjHYJmq7hfaLbKuWk
         UPpfSOvZ3h/jgsM4l24oQvrUncuNZ9Gsj5JfQ4a8isCljQRkgnCnqOkvLPZ5tBMEfhZB
         ewOeg6R/c/nwaN4DS1cc2q39KmPXj/NPGM8kCCzF5tvUz5GrobMtOHj7DiCaYtdk5CCK
         6/5MZfHBWDJiVbYdNazBYvzFq8mE32svvYem5Af4EsqNzI9a0xh73p9R9c2Iup0B+ZN9
         1uq9oo2NHaGaIKb7HayZF98v76KS7e9MZsuWqKTJ13jrmSZkF+DtPIuOrhFDyPaxkO+X
         WV7g==
X-Gm-Message-State: AOJu0YyuoPD/ASISyu+jTUSfThO+gXUpkpC8P2cTZBUxKMCBi63xvhgy
	EbuDgmOC00+uqASRvyaeDTQzXUjAG7sR9t6I/3v0anI9p9rGcFL+k92gZjaL/gg=
X-Google-Smtp-Source: AGHT+IHRDOlr0hBuTVIQp1aTTICQGvqt/BKT1loMjeNsNkg37vRqmdFtNGwsyFG/cxJtR1qxmasncA==
X-Received: by 2002:a17:906:3b07:b0:a35:f158:d0b with SMTP id g7-20020a1709063b0700b00a35f1580d0bmr137667ejf.74.1706519533598;
        Mon, 29 Jan 2024 01:12:13 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a311082cd00sm3675483ejc.37.2024.01.29.01.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:12:13 -0800 (PST)
Date: Mon, 29 Jan 2024 01:12:09 -0800
From: Breno Leitao <leitao@debian.org>
To: Arend van Spriel <aspriel@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, kuba@kernel.org, davem@davemloft.net,
	abeni@redhat.com, edumazet@google.com,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>, dsahern@kernel.org,
	weiwan@google.com, linux-wireless@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 17/22] net: fill in MODULE_DESCRIPTION()s for
 Broadcom WLAN
Message-ID: <Zbdr6ZiAvyco+dDS@gmail.com>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-18-leitao@debian.org>
 <877ck0eeqi.fsf@kernel.org>
 <18d4a071678.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18d4a071678.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>

On Sat, Jan 27, 2024 at 09:26:35AM +0100, Arend van Spriel wrote:
> On January 23, 2024 7:38:36 AM Kalle Valo <kvalo@kernel.org> wrote:
> 
> > Breno Leitao <leitao@debian.org> writes:
> > 
> > > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > > Add descriptions to the Broadcom FullMac WLAN drivers.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > > drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c | 1 +
> > > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c | 1 +
> > > drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c | 1 +
> > > 3 files changed, 3 insertions(+)
> > > 
> > > diff --git
> > > a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
> > > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
> > > index d55f3271d619..c1f91dc151c2 100644
> > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
> > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
> > > @@ -20,6 +20,7 @@ static void __exit brcmf_bca_exit(void)
> > > brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_BCA, THIS_MODULE);
> > > }
> > > 
> > > +MODULE_DESCRIPTION("Broadcom FullMAC WLAN BCA driver");
> > 
> > It would be good to spell out BCA. I don't even know what it means :)
> 
> If my memory don't fail me it is Broadband Carrier Access. Basically it's
> the AP side of the Broadcom wifi business.
> 
> > 
> > 
> > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
> > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
> > > @@ -20,6 +20,7 @@ static void __exit brcmf_cyw_exit(void)
> > > brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_CYW, THIS_MODULE);
> > > }
> > > 
> > > +MODULE_DESCRIPTION("Broadcom FullMAC WLAN CYW driver");
> > 
> > Same for CYW.
> 
> A bit easier: Cypress Wifi.
> 
> Kalle does apparently knows what WCC stands for ;-p To be honest I am not
> sure but it is the mobility business.
> 
> So these modules a not standalone modules hence I didn't bother adding a
> description. My bad. These are plugin modules so to speak so if I can make a
> suggestion here please rephrase to something like:
> 
> BCA: "Broadcom FullMAC WLAN driver plugin for Broadcom AP chipsets" and
> WCC: "... for Broadcom mobility chipsets" and
> CYW: "... for Cypress/Infineon chipsets".

Thanks Arend, I will update accordingly.


