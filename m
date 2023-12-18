Return-Path: <linux-kernel+bounces-3008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9922816608
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6998C1F21F71
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDD363D6;
	Mon, 18 Dec 2023 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGNFH4hg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D366FA5;
	Mon, 18 Dec 2023 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-425a116f1cdso26551071cf.0;
        Sun, 17 Dec 2023 21:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702877021; x=1703481821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXl3wOFqM2CSVNd+66EEJwPvOL1LNVJZxBeNfFMTBSM=;
        b=GGNFH4hg6BMpQcAjNNoiBNgSInWLULKCsTGC/cEy3jxArCtFyZ7e6dtNwBoNwhqLfY
         Y31Y42Lw++HpEzIw78kGf4WwG4vcLu5jbm/McN9WlqEl71sDo/79BwgrwmJYMitQs5sh
         9zJOmnmHWH9IrAtOZT2rBAW6SnkmwT/2Ab8kAfVtxyVC+oYwAwV6/tNgZoaIH1at/VXQ
         Fqq50EZPEaB7QvQyA0gHi53ERaGaT/G+aAwIzyA41Z4aVup7k5bpVi4CmDHgTx2iLJmN
         MTXW0KDplns76KTFEeX3KVdnpFfkABOHeCnJqSCimrbtAPc1LiueGxW3pMB+jJKaJ2pr
         T31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702877021; x=1703481821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXl3wOFqM2CSVNd+66EEJwPvOL1LNVJZxBeNfFMTBSM=;
        b=K1nH0ExB1vsmxF2xZrgX90AxaVMFKWB1GMTWa0KS4+Sc1d8AKc3WdsjI7tbwPcPnNd
         amwTckmbsl5mbnQ8J1Vkf+h5wY72T+7fZnDJ7E9HaIGNJIyuqFsDEvJJuEtB10xxziTc
         5JVIU+vq1SDjvslxQqDJgRQK0p/L/KiKhZ4ITaPS5DAqoTZ98tDoE/0aQojyvYEUbPGJ
         e06qmvR7Sb4s0jOuNKnLLWvJUo0AFA/y50JMAun7HK6Lj59FoGiTTwQTH2GOvKPiWDCy
         pZWz9V2JkpEnYbb/Nl/9R6gxFQ+ks0WxA9UOz2d8kKUX8GqD8yTTCXEhMjAI2vGvqumE
         z8qQ==
X-Gm-Message-State: AOJu0YyAPbQC1d4qxtuRE0G4x69oDusjdBsVLf90bAMUD4zd8WdYC1ku
	m3xVNwVePkq2TijmCiaLzWY=
X-Google-Smtp-Source: AGHT+IHDdUhVaGmO76KoEpbpCO+h9TEe81AmbrDQJPIixHJ3109OZKp+oGo8KSAjVPCayGR5qVjxzg==
X-Received: by 2002:ac8:5ad1:0:b0:425:823d:2d27 with SMTP id d17-20020ac85ad1000000b00425823d2d27mr24455905qtd.115.1702877021444;
        Sun, 17 Dec 2023 21:23:41 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id m26-20020ac8445a000000b00423e1b606bbsm8928996qtn.69.2023.12.17.21.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 21:23:40 -0800 (PST)
Date: Mon, 18 Dec 2023 00:23:30 -0500
From: Abdel Alkuor <alkuor@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: Add AMS AS6200 temperature sensor
Message-ID: <ZX/XUpHl+5ZiAcou@abdel>
References: <149032e99136a9fe47c3533b57a71092646e497d.1702744180.git.alkuor@gmail.com>
 <63e352150ed51eefce90ca4058af5459730174b2.1702744180.git.alkuor@gmail.com>
 <aa93010a-7ab0-4b9d-bb5d-25ea15b81120@roeck-us.net>
 <ZX4frjGqOGb4zMmx@abdel>
 <c606c40b-8571-4618-827a-555ceab3ae74@roeck-us.net>
 <ZX6AQg1vz/Zz6JeG@abdel>
 <fbcceae6-2daf-4855-b8f2-f7a832a53339@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbcceae6-2daf-4855-b8f2-f7a832a53339@roeck-us.net>

On Sat, Dec 16, 2023 at 10:06:03PM -0800, Guenter Roeck wrote:
> On 12/16/23 20:59, Abdel Alkuor wrote:
> > On Sat, Dec 16, 2023 at 05:40:35PM -0800, Guenter Roeck wrote:
> > > On 12/16/23 14:07, Abdel Alkuor wrote:
> > > > On Sat, Dec 16, 2023 at 10:46:53AM -0800, Guenter Roeck wrote:
> > > > > On 12/16/23 08:39, Abdel Alkuor wrote:
> >       ...
> >     }
> > 
> > Based on that, the new tmp112 set_mask and clr_mask would look like this instead,
> >    [tmp112] = {
> >    	.set_mask = 3 << 6,	/* 8 samples / second */
> >    	.clr_mask = 1 << 15,	/* no one-shot mode*/
> > 	.config_reg_16bits = 1,
> >    	...
> >    }
> > 
> 
> Yes, you are correct, we'll need something like that. lm75_update_interval()
> tries to solve the problem for tmp112, but that doesn't work with
> set_mask/clear_mask. We should have a separate function lm75_read_config(),
> though, to hide the complexity.
>
I'll fix tmp112 parameters in another patch as as6200 patch 2 in v2
implements 2bytes read/write for the configure reg.
https://marc.info/?l=linux-hwmon&m=170287522119545&w=2

On another note, I checked all the supported chips in lm75 to see
which ones support an alert bit, only 3 chips support it; tmp112(bit 5 in the second byte),
tmp100, and tmp101 (bit 7 in the first byte).

Thanks,
Abdel

