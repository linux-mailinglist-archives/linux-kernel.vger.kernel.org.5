Return-Path: <linux-kernel+bounces-18007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C718256E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E802847B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12242E658;
	Fri,  5 Jan 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGlt87AR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7AE2E405;
	Fri,  5 Jan 2024 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e36e29685so10177415e9.3;
        Fri, 05 Jan 2024 07:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704469435; x=1705074235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7oFiBYSi0X0BqYWXmeQdyz8VDhVzA5CtmmB2oZD2HHs=;
        b=FGlt87ARSoVwJiJLkeflBF4euPbRZxtJfLVfvL6mCW7yYBi11zhfiHr/LZUb5loA61
         KwdcneUR5MwpqHLLEXb4fP83zWHl2lwUUYGS3HY8ytYq+ifP/X9oF5zf6K3FH6pn6aDM
         t/Xw8UBiv4cbVMNHrhk5MbFUhePpapq2h3JuEz7s+m0KzLb3G8iIcWJ1HCubA2F+VmLM
         vcpCp+/U5bqMTozRhLagOTNpFGTYXIs5Ai4dRki7WPykhltet3UP/bTAxzI/gdbBVIWA
         0kgyQCPArjltY6us1F/46McL4/qUJW2T/ZkmudqZgfH4qmJhEYTTNAk0aV8a+JPPC6l+
         Is8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704469435; x=1705074235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oFiBYSi0X0BqYWXmeQdyz8VDhVzA5CtmmB2oZD2HHs=;
        b=vsr0deuUC2/iw2w6deYDBUz/nUXfn1HNZKTmkXIzMB8tdW7fkQa3LCpWm0Eg9df0Eg
         soAiTWUQa1Qvpoch0xi/z1ASEz3Fl/EiEy1/ZRL8I0252H9Vg1m0/s3B/CunHEaGY96U
         PnJ+u4ytW0wEA5zU1RCgiTZXNrES6xRHjiXnaHfLmcT1KtsSvAJTASnyNLnQhalYT2aS
         ztBI8cnhGAd6zLbtX2Gd7BSUHwkfROaT05lkWkctj0CoDa5kqR7dI9kowt2M0zp/tqpN
         zn7PwLUvU7rC5r/bcbNnvYfq1bYlterB3mxNC3TIqHB6CwNgJPbRLdBGfOHBWZ3rjlc/
         jBSA==
X-Gm-Message-State: AOJu0Ywi2FivlvVE2rdSh91LDUo0hkfJLFyUYp/JIQQ2vStzcDWu7q23
	1htaCb10eDk6pBxTSxZahQc=
X-Google-Smtp-Source: AGHT+IEXdlvvHmmHah/RvKx+ANf7Wxv5COH+nObouIhj0XDftZkX4qSq5d4J1OYQ9IC/gUoulYz2aA==
X-Received: by 2002:a05:600c:2294:b0:40d:88ea:5c3a with SMTP id 20-20020a05600c229400b0040d88ea5c3amr1267563wmf.141.1704469434606;
        Fri, 05 Jan 2024 07:43:54 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d414b000000b00336aa190139sm1606474wrq.5.2024.01.05.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:43:53 -0800 (PST)
Date: Fri, 5 Jan 2024 16:43:51 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stefan Eichenberger <eichest@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: add driver for the Marvell
 88Q2220 PHY
Message-ID: <20240105154351.GA39937@debian>
References: <28cc73bf-ed6d-49d8-b80b-4fbf5fa0442f@lunn.ch>
 <20231217111538.GA3591@debian>
 <ZX78ucHcNyEatXLD@eichest-laptop>
 <20231218090932.GA4319@debian>
 <ZYAqxPZHICtZO15O@eichest-laptop>
 <20231219081117.GA3479@debian>
 <ZYFfzei3SJSts5E/@eichest-laptop>
 <5d545a9b-feda-4908-8f74-9218806451c1@lunn.ch>
 <20240105124221.GA30964@debian>
 <c7b1b220-4a76-4cc0-b68d-cec5977ebadb@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7b1b220-4a76-4cc0-b68d-cec5977ebadb@lunn.ch>

Am Fri, Jan 05, 2024 at 03:00:58PM +0100 schrieb Andrew Lunn:
> On Fri, Jan 05, 2024 at 01:42:21PM +0100, Dimitri Fedrau wrote:
> > Am Tue, Dec 19, 2023 at 04:57:50PM +0100 schrieb Andrew Lunn:
> > > > I am not sure that it will be accepted by the maintainers if you use a
> > > > lot of registers that are not documented.
> > > 
> > > Sometimes there is no choice, there is no documentation except the
> > > vendor crap driver which we try to clean up as much as possible, but
> > > we still end up with lots of magic numbers.
> > >
> > 
> > Hi Andrew, hi Stefan,
> > 
> > tried to reduce the init sequence. This worked for me:
> > 
> > static int mv88q222x_config_init(struct phy_device *phydev)
> > {
> > 	int ret;
> > 
> > 	/* send_s detection threshold, slave and master */
> > 	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8032, 0x2020);
> > 	if (ret < 0)
> > 		return ret;
> > 
> > 	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0xa28);
> > 	if (ret < 0)
> > 		return ret;
> > 
> > 	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0xc28);
> > 	if (ret < 0)
> > 		return ret;
> > 
> > 	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xffe4, 0xc);
> > 	if (ret < 0)
> > 		return ret;
> > 
> > 	return mv88q2xxx_config_init(phydev);
> > }
> > 
> > The four register writes were required to make the PHY work in 1000Mbit forced
> > mode. When using autonegotiation or 100Mbit forced mode they weren't needed.
> > It was enough to write them once in mv88q222x_config_init as you can
> > see. Thanks Stefan for the hint with the first three register writes, it
> > helped a lot.
> 
> Hi Dimitri
> 
Hi Andrew,

> Do we need to reduce the init sequence? Since this is all undocumented
> magic which nobody understands, it would be safer to just keep with
> the Marvell vendor crap code dump. Unless we really do need to change
> it.
>
You are right, it would be safer to use the vendor code. But when
looking at the vendor code, the init sequence changed a lot from rev. B0
to rev. B1 of the PHY. There are some additional register writes, but
mostly the order of the register writes changed. I don't know if this is
going to be worse in the future. Maintaining different revisions will
probably take some effort or at least result in bloated code. We probably
don't need all of the init sequence. I'm not sure how to deal with it,
keeping the init sequence at a minimum is probably a good idea.

> 	Andrew

Best regards,
Dimitri

