Return-Path: <linux-kernel+bounces-63843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D36985355F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C48B245EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15835F563;
	Tue, 13 Feb 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7Yp4wZg"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E25FB9F;
	Tue, 13 Feb 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839773; cv=none; b=AIc39+BfXPiiaLKsE04r41WSd6cmC1+PLOMbiJKFaqPc8S4eN+x9DSXBYdlzWq53mzppVC+kdj55N3KKNklO9VsK6B5HmC7fFRjsK6DGSN1gEDPDXLOsLBTqVi+Tqiph0sMM1SZ/1Pd+aFftfV0FhUGjHjIKdNOnd7XKTb9LUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839773; c=relaxed/simple;
	bh=uL1C1DrPiTp18kKPAC/wiagnbgzzO+VcDLIioE0B69M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWO6E00eIxwbbYIk5r3U1xBdwGcRlMDdvI46jPJ41+lfZR81+aUWyutO3rPbWK56wsMXGjCL/JHFzXCB8g/D34wFCbAKc3UsQ69bNRgFHrSteQm+anOE6NSo7FwLKZJzcsAQf6tNDqfWCe/aqQB+t1EwikcfhBWEzHMckhrJf18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7Yp4wZg; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d107900457so12025381fa.1;
        Tue, 13 Feb 2024 07:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707839769; x=1708444569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts7g4FdQ8KFT7BBMWJWC8kqPZD0iQK0XaVo73DXEYZk=;
        b=A7Yp4wZgc9sKddneg7gC2wDEvbRWHZAbnbQhHzF92aBL3u1QwXTq8o1THkiSOOwtap
         uyUM0IeLixk2T6jrMmcTqd53m/RNid05CDgZL2lBFYEggBAAikkHDX00GqCW23wJ7lrp
         Iv7G6KGOy/ZCAXw+rO52FjCNjIE95gt39xbnTcjR/Kb3TfFe1QPMgOrKX3u9PxvwwxPC
         y7BGHfBeniVCJq5GFP8AJJd6yaMCeoVIJkdpVMGFvposeE+ygn+a+zqLe0q+Ebzduluy
         q3ONnBTjfS9KsqsjUW0kncGMMKQeaQnoYoliXLzjJEoRyfatEX2nGAUVEG6NKmxPSgFy
         DE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839769; x=1708444569;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts7g4FdQ8KFT7BBMWJWC8kqPZD0iQK0XaVo73DXEYZk=;
        b=Qng9gbe8gi6FkomP44YAZlFCQNKJgUsR2BdIe2T3hhxkyOiS1zwdFeEpbRZvckSZpt
         CpRl7kLAHesPIYmtzS4IOFyTxKBiHFCCcKRdUKcWrq6IqQk4NtDQiU+Rwh+o72/vLt3a
         2JS87+OqC/VORfgo84SnyGVwzD+i3uEhmd30c7dMzUudg1f2mXq+XPhoLEQMsmLWXF3V
         l+FWYed3R/ZZ8yZeXdSn+IVQDjq1sWdI6tjRthu8fwqI6azk4w091oREuYa/1tHvS9we
         GJDEdxSBafU3sHyvXMwYkTvJBU+iZiBrHiM6y7/zkVn9B3osq2pC9Z3a/6FQWsWCXXM5
         SZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwyU71VhIICk0N/U/ZMmNoz+Fa7Oc9c0hNt4qGB134nub+oVtJCgB5zcbRFy8LNoUXMvi0NuiUmeA9DycH/0rC342eaQ6MJCyCVdgBuRDOTEGBwoM7nMohA9g36d3JZN7Mz3Qn
X-Gm-Message-State: AOJu0YxxszIRU7lmHMj7eQEPVKtE9r81nz5CiZltWO9P+pBSMkXlelB7
	wTIVdUnQICiIdWIiRtCbaPrfU3tdCpvi4XGtN4pxaB/q7Hj4wKAF
X-Google-Smtp-Source: AGHT+IGJ9s6tMtOjh+oGmHPpVkNbrMW3NsMxeKrk/tUAmXPMIAoLJ4l0wWELtTXsMNQWdvuSG7aFSw==
X-Received: by 2002:a2e:b750:0:b0:2d0:bc40:2aa1 with SMTP id k16-20020a2eb750000000b002d0bc402aa1mr60517ljo.10.1707839769045;
        Tue, 13 Feb 2024 07:56:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX19csgBjvK5yA4KjZ1xdHBJYK+zmGRpQ3Zjp2A+W5c1CxRVZ1VugkJvkYm63GFoAAnrDx0jF8Sva0+Yf9/v/B3CWmTjivV1SyXqnU5RsaNKYxVq/bn4OVSFD2ezTjG7Bp8AIb19erKd7gxBu20C4LYdaNS4Wn3CTJ96D7FmhVZ0QM+8u9u38CRQ1xDo//Q0yoqwUTtP1F++SUGgaUwJIGM7G8dJZk+YYHp+uAqfMmQx+qdYbS7I+TfZmP5SXzo3Ogu43OhH3epFwH0pWqOY7ojKPNeoNXICNVpYgfq+nMr+kRc/Bo0R7Ea9mSXOdqMbNJan1HnBxuR/jCC
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id l13-20020a056000022d00b0033b1b1da2adsm9910836wrz.99.2024.02.13.07.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:56:08 -0800 (PST)
Message-ID: <65cb9118.050a0220.8421f.c47a@mx.google.com>
X-Google-Original-Message-ID: <ZcuRFG5I-tsgbUJU@Ansuel-XPS.>
Date: Tue, 13 Feb 2024 16:56:04 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR111 and AQR111B0 PHY
 ID
References: <20240213133558.1836-1-ansuelsmth@gmail.com>
 <233cd45b-28d5-477d-a193-8273684953aa@lunn.ch>
 <65cb7a25.5d0a0220.de7b7.a1f3@mx.google.com>
 <a10c3b55-c6c3-4982-b294-d6e5b9383e31@lunn.ch>
 <65cb87a3.5d0a0220.69795.6a1d@mx.google.com>
 <12f27e82-6981-4a13-bdc0-77054bf964e9@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12f27e82-6981-4a13-bdc0-77054bf964e9@lunn.ch>

On Tue, Feb 13, 2024 at 04:46:47PM +0100, Andrew Lunn wrote:
> > With the amount of things we are noticing on these PHY it can be
> > anything from Marvell itself, from OEM messing up with the Provision to
> > a buf in the FW itself...
> 
> Ideally, we want to get Marvell to release one universal firmware for
> each PHY. Get the OEM out of the picture. This is something i said to
> then Aquantia years ago, that provisioning is going to make driver
> support a real problem. Seems like i predicted it correctly :-(
>

I can totally see them answer to this request with:
OEM should just attach a SPI to the PHY if major modification are
needed, making us (Marvell) releasing an universal firmware irrelevant
since it should be handled internally by the Aquantia PHY.

Reality is that on Router or more Consumer devices where OEM try to cut
cost everywhere, FW are getting placed on NAND partition or even part of
the OEM FW and then userspace tools are used to setup and load the
Aquantia PHY FW.

This cause the side effect of OEM building one Aquantia PHY FW and then
fixing the Provision data at runtime making all the idea of Marvell to
include these configuration values in the FW broken. (example OEM build
one Aquantia PHY FW for all kind of PHY ID and then apply specific
fixup to setup 10base-r or uxsgmii based on what is actually present on
the board on the MAC side) (yes the PHY can support both and there is a
way to tweak this... this is actually required on AQR112 and other
version that we currently don't support, ideally it should be handled by
the FW internally but reality is that we have case where the FW
provision one mode and the other is actually present in the system)

-- 
	Ansuel

