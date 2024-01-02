Return-Path: <linux-kernel+bounces-14642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 699C4822018
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DADA1F237C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38D154A7;
	Tue,  2 Jan 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOoj0bTU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5816401;
	Tue,  2 Jan 2024 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cdc159034eso3100419a12.0;
        Tue, 02 Jan 2024 09:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704215354; x=1704820154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcUsAzPUG+M3E2aYd59xb5UnEJS/MFzlJwMjKILMSKY=;
        b=HOoj0bTUbQGdtDnY2Pzkd02Pr1yBuGZY2CL5Yi0HCVoyrKAE416XDGit9hLXKNp6Nq
         sZKQ6JzG7suUs9OEkgtD/ZJVDZ9bBNTXWFhY9KhOpsPhtaVONqJBMIkM35R7Oi7uvAdf
         KLLXNyoKwMaxNS1nFSnlahCIzzqIKT7Zr9y4YIlcnTapzVcqoD7AN+cXRjRuypKce0MU
         duQH8XQ6Qt6h6gp7HgAFbePBtfIcXyKtqsA5p7Iro77cCadKooH9MauQaQBuhKpigZSe
         fyfMlloeX3QXBab42msksseRELZgxcud2jK1SwNRXv/gWl/NsmtV/jyF1s5oRcGcTIN4
         HqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704215354; x=1704820154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcUsAzPUG+M3E2aYd59xb5UnEJS/MFzlJwMjKILMSKY=;
        b=AUz5NFcuPZHJNda1WbpPWlBq/Vi6t3V4YBpyeWpKMin3/s9Og2Vi5yK15SWKwtiC8X
         31MQkYoF1XM6yABB6aJplt/j4Ngg/gKTKcfgYjRf4h70bVLaJa98ynrfmVD8+EACfvg+
         V7NzgDy40xsETa1Tyz6twKgYb8uyM1okhoJ7V40fYQ3yDvWZpqHUfjxICzx0X6dGiX9i
         Ck+6w5wVXXamjRuYDGXmWgAS4BgAYnVaJNwvkp+o+KHuIZRTw0IO7vyTPpwUZSgR0bCj
         LmsTedt/w73XjleepTEPyt98qlyCwCjhoRo+GFOXsGj/pWNan5fiQvJitkgD210BytcX
         ncsQ==
X-Gm-Message-State: AOJu0Yw2E2BWlDESTAN1ihWbzyCeetJ+AVaC0KO0NdC9NtN+TGNZblJq
	G6HWdlx9lgS2G7kAkiZGSrSFM/bNA20=
X-Google-Smtp-Source: AGHT+IHHx0cl0TxNJ4JnFBMLIWlu2tuK1IcLRSXIlR/eimKHEXIJ0nvFXMp8tfQi6e1pxF0qg/1x2w==
X-Received: by 2002:a17:903:2292:b0:1d4:bd0c:207d with SMTP id b18-20020a170903229200b001d4bd0c207dmr1247817plh.66.1704215353591;
        Tue, 02 Jan 2024 09:09:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902fe1800b001d0c41b1d03sm22198693plj.32.2024.01.02.09.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 09:09:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Jan 2024 09:09:12 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suniel Mahesh <sunil@amarulasolutions.com>,
	Kyle Tso <kyletso@google.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	USB list <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: USB PD TYPEC - FUSB302B port controller hard reset issue
Message-ID: <5458c2f4-b212-4e35-b870-f15fb724f41a@roeck-us.net>
References: <CAM+7aWvGerEdUnsKboUg9+EoL=66k3nULHCnQgHyxsWQhUwmpw@mail.gmail.com>
 <ZZPbeUbMM3J4pH/K@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZPbeUbMM3J4pH/K@kuha.fi.intel.com>

On Tue, Jan 02, 2024 at 11:46:34AM +0200, Heikki Krogerus wrote:
> Hi Suniel,
> 
> On Tue, Dec 26, 2023 at 04:14:48PM +0530, Suniel Mahesh wrote:
> > Hi Guenter Roeck / Heikki Krogerus and all,
> > 
> > 1.
> > I am testing USB TYPEC PD on a Rockchip Rk3399 SOC based target which has a
> > FUSB302B TYPEC port controller.
> > 
> > 2.
> > My source is a wall charger which is based on Gallium Nitride (GaN II)
> > technology and has four ports as follows:
> > 
> > USB-C1: 100W PD3.0, 5V/3A, 9V/3A, 12V/3A, 15V/3A. 20V/5A. PPS: 3.3V-11V/4A
> > USB-C2: 100W PD3.0. 5V/3A. 9V/3A. 12V/3A, 15V/3A. 20V/5A PPS:3.3-11V/4A
> > USB-C3: 20W PD3.0, 5V/3A, 9V/2.22A, 12V/1.67A
> > USB-A: 18W QC3.0. 5V/3A, 9V/2A, 12V/1.5A
> > 
> > 3.
> > i am using latest linux-next and enabled all the relevant configs,
> > especially:
> > CONFIG_TYPEC=y
> > CONFIG_TYPEC_TCPM=y
> > CONFIG_TYPEC_FUSB302=y
> 
> Which kernel version?
> 
> > 4.
> > DT node is as follows when i use USB-C1 of wall charger:
> > 
> >  connector {
> >                         compatible = "usb-c-connector";
> >                         label = "USB-C";
> >                         data-role = "dual";
> >                         power-role = "sink";
> >                         try-power-role = "sink";
> >                         op-sink-microwatt = <1000000>;
> >                         sink-pdos = <PDO_FIXED(5000, 3000,
> > PDO_FIXED_USB_COMM)
> >                                     PDO_FIXED(12000, 3000,
> > PDO_FIXED_USB_COMM)>;
> >                 };
> 
> What do you mean by "when i use USB-C1..."? Why is the above valid
> only then and not with the other PD contracts?
> 
> > Issue:
> > The board power well most of the time, but may be in 1 out of 5 cold boots,
> > FUSB302B is getting a hard reset, as
> > FUSB302B INTERRUPTA register bit I_HARDRST is getting set.
> > 
> > After some digging, found out that the above behaviour is accounted to when
> > something is wrong with the CRC of
> > the received packet (SOP - Start of Packet)
> 
> How did you determine that the problem is a bad CRC?
> 
> > This behaviour is seen i.e. FUSB302B getting a hard reset more on the
> > USB-C3 port.
> > 
> > Any pointers on how to solve this issue.
> 
> Guenter, do you have time to take a look at this?
> 

As far as I can see, the bit means that a hard reset request has been
received from the charger. What else can the code do but to execute
that hard reset ? On a higher level, if there is a communication problem
due to bad CRC (i.e., a bad communication link) between the wall charger
and the development system, I am not sure if there is anything we can do
in software to remedy the problem.

Secondary question: Is this a regression ? The original e-mail states
that it was seen with the "latest linux-next". If it is a regression, it
should be possible to bisect it. However, the only recent commit which
might affect reset behavior is a6fe37f428c1 ("usb: typec: tcpm: Skip hard
reset when in error recovery"). If anything I would assume that this
commit would improve the situation, not make it worse.

Thanks,
Guenter

