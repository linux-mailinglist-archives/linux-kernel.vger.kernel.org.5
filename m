Return-Path: <linux-kernel+bounces-62160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C635F851C79
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09566B2182A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C493FB29;
	Mon, 12 Feb 2024 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK+0kKd6"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EBD3FB01;
	Mon, 12 Feb 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761357; cv=none; b=BFiC2SajjWuW+IAx5gnGtBa7gA+WGZthNEjltNf2Hx3jPCy5+zyHG8dTdzLPZSBrAOQr3HuZ8Gg7VHJTaxntbwc8g4ALa0rpqbRDXU4LYlEXnASmyDMNYYlcXMVKiSp0oBwQ1yC3GcjY3c3soKD6Q5snQ2VsoDEFZBfzmoJkDzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761357; c=relaxed/simple;
	bh=3fdalMzMN7ukZh9oZ+8vAMKHDZRZYLFauerZnk2PYS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmPxbWoZdInc757dlbWPE7e29nOnC2cm/Y4LKX5VjqAzCunpJqZEIHMFzuzARyNr+GJRRGKnhkTy89/P+RCBNjYD+i5Ccq8MQnI+MdkZe2EvN0Y8uohkjAwspFuD7J3vOi120TiKTJC5jenIZIatUt3e03PwGD7ziUIo3KHb+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UK+0kKd6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so2866939a12.1;
        Mon, 12 Feb 2024 10:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707761356; x=1708366156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tlK519Xw8dMf6gYDy2OSlQP4gUjAd3QrxBkYgmt3+0Q=;
        b=UK+0kKd6K/edXVzjrDizmzHKvwIxCNZGc3A9wWo0gaZHzsEkWq51c0duJJpev73kqq
         8XRv8IfLblwkuHO3fhXz+IZhrjeA8vSllHCrXJ/z7wsN1RCW44v4JD8AP6erUjMhFu12
         UQlGZap69J3doTxDd5Amc7j6RJ59EnHUIxTajgtDEDEYSXJd2mwSg/jU+ME93ar2KpGm
         NqewEt7gi5F/m/2BfXc6AqH+YC+spVFPDkPn0I/zuGohMz2Su6E6CtazF98MnrP2++n8
         O6+8u/GXjLZhOcaT2F+w0wpkz/6B/Efo7L7Dw2kLjRjMcon8vhHlW4pcY2EpNodw6KoZ
         zvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707761356; x=1708366156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlK519Xw8dMf6gYDy2OSlQP4gUjAd3QrxBkYgmt3+0Q=;
        b=TuB6/dkb8bIUw1KxVjNxc2WdFIK6BAM4aD+qfEYBamKDBOpSrhVkSZH4BttjNM4i6I
         HUyxzMlt4bT74Ip9h6rBWTbg30NvYe6UHGtXkWlpPQbT7/ao03MYP63P/vYjowI6WPb8
         ibAc0GRMdLaZVjdtlJPSDr6E0/+LaSn+1qKxCdfcITTPALXO8ml9jFHMlNKq7M+cH1pw
         H4X0Cj71p56Fw/tSOAXFWkITkD1W17pNpkQTlZGJLLDiJ8vWwXS5NYtkApgl5hKDdQJY
         0bSKK1mK1LVGAPyoj7+TX9l7mZb/P6PKwDpUn37bkZ9GZq+pnTsWoQYYUsWMEkgLRD7W
         nj1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJIgvFkKlCRzHv2WuFEIZ8KPLhfGTzW2tLDcaraGY3A560/iXTZJY4HJW0rH+EqRXDiDNprH2DbqXGlUwLFUQxcjHH7s8vDT5YKTFFBgpJcUQaPiBYDJ0Sz1Ep19O4X0dCWGfF5ZeZYJX1M9u4sJuKS5eRcNRMTRMRS2NiPP79kKAL0g==
X-Gm-Message-State: AOJu0YxvxslYbVTj5aDElIdJsxOj6mpMTWO51nxBco/TByeRHrjcUKj/
	5niY2hSYoWnyJVvWQuzZu22GGSl7L+79ACYCjOlNKfSFc4AKuFP5pMlu3M7h2U21phJeT/M9hnR
	6qKl4RO5m7bMPJg5HBQ66p4OpkPI=
X-Google-Smtp-Source: AGHT+IHHkcMjHqzSiMwKs8wUwiY+t9nb8ZJveVjPVPbYXb+S/1cjD9t4+R/FyDDara4HnqWYseDqoBvV2QhwYatjG78=
X-Received: by 2002:a17:90a:9a8a:b0:296:c78e:c0bc with SMTP id
 e10-20020a17090a9a8a00b00296c78ec0bcmr6289126pjp.9.1707761355657; Mon, 12 Feb
 2024 10:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212115043.1725918-1-robimarko@gmail.com> <c97d10fa-39c5-4e5e-93ce-1610635cb4d4@lunn.ch>
In-Reply-To: <c97d10fa-39c5-4e5e-93ce-1610635cb4d4@lunn.ch>
From: Robert Marko <robimarko@gmail.com>
Date: Mon, 12 Feb 2024 19:09:04 +0100
Message-ID: <CAOX2RU6OwiymM_O_62VETgkBNUQP1TuOKJmm0D1ZUXBA7ZPJNA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: qca807x: move interface mode check to .config_init_once
To: Andrew Lunn <andrew@lunn.ch>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ansuelsmth@gmail.com, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 15:51, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Feb 12, 2024 at 12:49:34PM +0100, Robert Marko wrote:
> > Currently, we are checking whether the PHY package mode matches the
> > individual PHY interface modes at PHY package probe time, but at that time
> > we only know the PHY package mode and not the individual PHY interface
> > modes as of_get_phy_mode() that populates it will only get called once the
> > netdev to which PHY-s are attached to is being probed and thus this check
> > will always fail and return -EINVAL.
> >
> > So, lets move this check to .config_init_once as at that point individual
> > PHY interface modes should be populated.
>
> Just for my own understanding, not directly about this patch...
>
> priv->package_mode is about PSGMII vs QSGMII for one of the SERDES
> interfaces? We expect the individual PHYs sharing that interface to
> also indicate PSGMII or QSGMII?

Yes, that is the idea, all of the individual PHY-s in the package
should be indicating
the same PHY interface mode.

>
> But what about the other SERDES, which can be connected to an SFP
> cage. You would normally set that to SGMII, or 1000BaseX. When an SFP
> module is inserted, the correct interface mode is then determined from
> the contests of the EEPROM and the PCS needs to be reconfigured. So
> i'm just wondering how this check works in this situation?

I just went to retest SFP support and it works as intended, as soon as the SFP
is inserted, PHY will get reconfigured to "combo" mode so that fifth PHY can
support both fiber (100Base-FX or 1000Base-X) or regular copper connections.

So, the check will not interfere with SFP support.

Regards,
Robert
>
>     Andrew

