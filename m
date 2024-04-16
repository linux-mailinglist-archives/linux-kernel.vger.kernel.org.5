Return-Path: <linux-kernel+bounces-147299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7438A7229
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4FA1C20D75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025BE1332A6;
	Tue, 16 Apr 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2YJ9Wb5"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18681F956;
	Tue, 16 Apr 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288190; cv=none; b=E3lESUj6OtDRbLsJLa0yn9068nlWmNQWCfCXpdtuQMIvIYs4cSej1cW8odhUDXXft/rjllpoVzHluGNbgffSKUK6F8Ct5P1M76Ucs8ZdRoEMIDvpkaXuOestpJBKR1nTRTUInABRI3zh17j7Yv9bRWCv11bacz2ABtanO9VAQaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288190; c=relaxed/simple;
	bh=ArUCSRqNmGEw8rmmjqJGD98DKnfu9AYGkJRy6KCgyfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSqtka/4sFB/O43mBsIHVzp1aIHTdNIzyvFK8HQFqR1vf4DIK2IaiQ+OwIMnXLCw+DqAspVNQuzfgwYoHfe3tGWDBVTF3bu1Y1cTcVf5t2P68Fu7bWiLx0qkmwMHddfSVr9T2f69OS/DKlm631UuRMazkDCfpKwqEQRbPD7mF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2YJ9Wb5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-346406a5fb9so3645264f8f.1;
        Tue, 16 Apr 2024 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713288187; x=1713892987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfOLZpMeXfJa6rDqZGEVapwFnrzCpl98X6KMQ4708WQ=;
        b=C2YJ9Wb5ci9a0aSLdZZ124XJI3HqCoQQ3UOaaXeIzOHoZZ4AicINoHnUcxUsESfnA8
         X7gNw1sf1mR1xmZG1O43XReAJYhaFdIy6F7qzAOI/TKFCt7UGs4pDtlSse7mGrknbw9q
         xBsfj6yxuO8W/M/gww21PYb92WzRZY/9njVnk4U549pvSUkR9IhcAN0ZKFe+JqkIqAef
         ydjR+//5zaYqJBEnQ70lo1u2G/03LcKCIY4n80eSWcui7IwLkgTi5GkQE02O6AUeC++t
         njEaW+X2jTquvcMSP4ZPwcNQZiZtPGB/UXQbt2GIoovIlK5NQ69uQaNTy+Yn0UnxY8LJ
         fP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713288187; x=1713892987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfOLZpMeXfJa6rDqZGEVapwFnrzCpl98X6KMQ4708WQ=;
        b=Rr4ww4g6PfYz7Ask4bquKrm/Z9fcMZk+GgQWda0yqwUIrMr9rzLeO+Lbl1+Qs9Hta1
         VHE/TN5rLmkDX5lMgGgFjkSHXtgrsIMELfAGZNhk/r2SkDPsxV5dvmK+/ZMa3U2R3IKS
         TmhciETgEmoe+YYpzZNXN1BXqhUxbm64eT8SDmcxq3Zcmf4A9yVSzMeo+/kad6szmmz3
         W+CF453nwAhsM16Tu46IyY1oVivG0JkXp2MOO21ggjSQM0cAf7YzkWLTYQ2v99AkOX/3
         Fxg/k7IuH5ULiWgqVe5gSe9JGiu6/QjeCvycScBH/FESU1bbhddtqZq/GKTGumasOlR0
         mjvw==
X-Forwarded-Encrypted: i=1; AJvYcCV9F2PMe5FQCNoP8ynhNSk3honwGdMAOq3GzUgpUIpjqvqyAMB01O5B9xB3scNgQrupAmiTTusRICdPx0bdPSy7NRyUempynCx9fI8Zh3rAH5xEbvZXhe4iipixBinztYS6KBSlcGgD7+AYIyYobPS5I+AHyb6CphN30zbs885KBA==
X-Gm-Message-State: AOJu0YxjnJTgoRGkzy21+95Pieq1AOi/hcihDrX2BSFQQiH5i8rPwrW5
	ioxoawTRB/Q8T4hBvadEkpfu4cmas4s1xJx+DC1MoQimUSK1xnQc
X-Google-Smtp-Source: AGHT+IGgLm8EIhUJ/q/yCHBTVvUxDzLr8JF02sctu/06RASyE7wRUZZF9ypXANrgXZrxVIZywbv5zA==
X-Received: by 2002:a05:600c:4f14:b0:418:a0eb:5343 with SMTP id l20-20020a05600c4f1400b00418a0eb5343mr1241748wmq.23.1713288186586;
        Tue, 16 Apr 2024 10:23:06 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:ac34:e164:f0a1:f75a])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b004189c69a414sm2488458wmb.41.2024.04.16.10.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:23:06 -0700 (PDT)
Date: Tue, 16 Apr 2024 19:23:03 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, michael@walle.cc,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <Zh6z90iCpLqF4fla@eichest-laptop>
References: <20240416121032.52108-1-eichest@gmail.com>
 <20240416121032.52108-3-eichest@gmail.com>
 <3f7f278f-e490-47f1-971c-ecf44a70cee4@lunn.ch>
 <Zh6clAtI3NO+nMEi@eichest-laptop>
 <5ed39628-4ac0-4c4e-9a16-fd4bf9a6db29@lunn.ch>
 <Zh6mIv1Ee+1h21Xo@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh6mIv1Ee+1h21Xo@shell.armlinux.org.uk>

Hi Russell and Andrew,

On Tue, Apr 16, 2024 at 05:24:02PM +0100, Russell King (Oracle) wrote:
> On Tue, Apr 16, 2024 at 06:02:08PM +0200, Andrew Lunn wrote:
> > On Tue, Apr 16, 2024 at 05:43:16PM +0200, Stefan Eichenberger wrote:
> > > Hi Andrew,
> > > 
> > > Thanks a lot for the feedback.
> > > 
> > > On Tue, Apr 16, 2024 at 03:46:19PM +0200, Andrew Lunn wrote:
> > > > On Tue, Apr 16, 2024 at 02:10:32PM +0200, Stefan Eichenberger wrote:
> > > > > Add a new device tree property to disable SGMII autonegotiation and
> > > > > instead use the option to match the SGMII speed to what was negotiated
> > > > > on the twisted pair interface (tpi).
> > > > 
> > > > Could you explain this is more detail.
> > > > 
> > > > SGMII always runs its clocks at 1000Mbps. The MAC needs to duplicate
> > > > the symbols 100 times when running at 10Mbs, and 10 times when running
> > > > at 100Mbps.
> > > 
> > > Currently, the mxl-gpy driver uses SGMII autonegotiation for 10 Mbps,
> > > 100 Mbps, and 1000 Mbps. For our Ethernet controller, which is on an
> > > Octeon TX2 SoC, this means that we have to enable "in-band-status" on
> > > the controller. This will work for all three speed settings. However, if
> > > we have a link partner that can do 2.5 Gbps, the mxl-gpy driver will
> > > disable SGMII autonegotiation in gpy_update_interface. This is not
> > > supported by this Ethernet controller because in-band-status is still
> > > enabled. Therefore, we will not be able to transfer data at 2.5 Gbps,
> > > the SGMII link will not go into a working state.
> > 
> > This is where i expect Russel to point out that SGMII does not support
> > 2.5G. What you actually mean is that the PHY swaps to 2500BaseX. And
> > 2500BaseX does not perform speed negotiation, since it only supports
> > 2500. So you also need the MAC to swap to 2500BaseX.
> 
> Yes, absolutely true that SGMII does not support 2.5G... and when
> operating faster, than 2500base-X is normally used.
> 
> How, 2500base-X was slow to be standardised, and consequently different
> manufacturers came up with different ideas. The common theme is that
> it's 1000base-X up-clocked by 2.5x. Where the ideas differ is whether
> in-band negotiation is supported or not. This has been a pain point for
> a while now.
> 
> As I mentioned in my previous two messages, I have an experimental
> patch series that helps to address this.
> 
> The issue is that implementations mix manufacturers, so we need to
> know the capabilities of the PHY and the capabilities of the PCS, and
> then hope that we can find some common ground between their
> requirements.
> 
> There is then the issue that if you're not using phylink, then...
> guess what... you either need to convert to use phylink or implement
> the logic in your own MAC driver to detect what the PHY is doing
> and what its capabilities are - but I think from what you've said,
> you are using phylink.

Thanks for the patch series and the explanation. In our use case we have
the mismatch between the PHY and the mvpp2 driver in 2500BaseX mode. If
I understand the patches correctly, the PHY should just return in its
query_inband function that it does not support inband when 2500BaseX is
configured as it is done for the Marvell phy driver. I will try to test
this on my end and give feedback, unfortunately it will become next week
as I won't have access to my test setup until then.

@Russell: I hope it is nothing serious with your health and wish you a
fast recovery!

Best regards,
Stefan

