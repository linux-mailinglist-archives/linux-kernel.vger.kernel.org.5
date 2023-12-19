Return-Path: <linux-kernel+bounces-4961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C50818468
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718B21C23CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B1913ADE;
	Tue, 19 Dec 2023 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMv0NyoO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A738134CE;
	Tue, 19 Dec 2023 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3367601a301so107695f8f.2;
        Tue, 19 Dec 2023 01:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702978119; x=1703582919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Scqu9aLul3d40yf89yFc7htHbz4wP0Hxm789V3ogC0=;
        b=NMv0NyoOMb4wxFbRn5tzNNitEKdehfvIbEG7ib7rATbTIjsKxSTADtPWJyuC5Fp2c1
         V6UwD7H4nOriNbrWzeUclS3pqvbysqb7Sk8l9ovgKPZoa0KA2W6rZzxH2pEjtXbuDlB4
         wr2B7odxYD9kSPFyOrtHcQ4Kblvl6qtTcLPQ2pVPK/bR+A1q9BTzaBMn20mHXJ9QejeR
         hOT67bt0ambSzJO7xmiqjoKlLLN40HKFuJlIVTLb649zvSauKzTVxLHxjUPhH9QhOZ44
         PCW/XPklFWNEaYvkrcYuvqPaqyrDDmpSsQjMOQ8Jshst/9VNhD9rvxusx4lrortBM7rG
         4hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702978119; x=1703582919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Scqu9aLul3d40yf89yFc7htHbz4wP0Hxm789V3ogC0=;
        b=JShxCPnGTsKgpc8WB7XbAhPsN6kf0EKHP9p77GOdPjFbh9Q9aMPYNjZ3a6+RvHU7en
         3749F51g5hCuKGxURgS8WGTuP+HRlNe4fnGewBQvzW6hRfX/RIjfB1yLUSl7Lcr7OxKC
         MXk19gRkUu2DAHzn7qpgzgtW8o0NtcNH/Qdha7ZUDjI9gaeW9K7sMkc37PBadbcM0JOX
         q3q42qVugJqN1s3TMqlq8R5Odk1XNJrAX/M5o959FzX7lcgtjiiOEHTWhCP7U+5VwX/r
         4PY2dPtfaUrKDuH2rLUSk8xzalfqhOypytZx8ZILv0n8War9oJCSllVYB+gpZ6qvL63C
         kVCA==
X-Gm-Message-State: AOJu0Yzj4c7o1wYtC5TFn1q+Y2GHCBbgfwlJmgMkgbz8azzEYLbzkIuK
	uXjNoeF78eZLZn54MZnyQVs=
X-Google-Smtp-Source: AGHT+IE2gTkTPSLhl2k7jRqi9z3IGhZXDlO+tHjdPhOPRIGDDaa0Hvv9OEIC+PpCoK/r6WoG0MxS1w==
X-Received: by 2002:a05:6000:128a:b0:336:60fa:908b with SMTP id f10-20020a056000128a00b0033660fa908bmr2332980wrx.132.1702978119120;
        Tue, 19 Dec 2023 01:28:39 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6809000000b00336757c93c9sm536123wru.48.2023.12.19.01.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:28:38 -0800 (PST)
Date: Tue, 19 Dec 2023 10:28:37 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <eichest@gmail.com>
Subject: Re: [PATCH 1/2] net: phy: Add BaseT1 auto-negotiation constants
Message-ID: <20231219092837.GB3479@debian>
References: <20231218221814.69304-1-dima.fedrau@gmail.com>
 <89f68405-2506-420b-952f-a168ebcb4d73@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f68405-2506-420b-952f-a168ebcb4d73@lunn.ch>

Am Tue, Dec 19, 2023 at 12:45:01AM +0100 schrieb Andrew Lunn:
> On Mon, Dec 18, 2023 at 11:18:13PM +0100, Dimitri Fedrau wrote:
> > Added constants for advertising 100BT1 and 1000BT1 in register BASE-T1
> > auto-negotiation advertisement register [31:16] (Register 7.515)
> 
> Hi Dimitri
> 
> These two patches look good, but...
> 
> Please take a read of:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq
> 
I probably should have sent them with subject-prefix "PATCH net-next" !?

> Also, its normal to include a user for new APIs. Do you have a driver
> which will make use of this to advertisement modes?
> 
Yes, I'm currently trying to push a driver for the Marvell88Q2220
100BASE-T1/1000BASE-T1 PHY. It supports autonegotiation and with an
additional patch to function genphy_c45_baset1_an_config_aneg which is
not part of the series it is possible to set the advertised speed.
I probably should send all patches as a series including the driver ?

> Thanks
> 	Andrew

Best regards,
Dimitri

