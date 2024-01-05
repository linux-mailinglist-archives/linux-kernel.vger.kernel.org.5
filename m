Return-Path: <linux-kernel+bounces-18079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B034582586B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643951F22616
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F191E52E;
	Fri,  5 Jan 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAmNlzfd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDFE1E4BD;
	Fri,  5 Jan 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbd6e37af4so1230676b6e.1;
        Fri, 05 Jan 2024 08:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704472815; x=1705077615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stYajyWPWMqAHb+0oqEiVrcD5n0SgOsrMnrQbqDRt/0=;
        b=lAmNlzfd5zCGcvJJhMurgtIRq21e5vA9pOhhp+osZWD07uJB7EQPN1DGvH94KqYPAR
         /OwpR5TRxIOcSxxgXIZW9tsBAfUwJGAWo/O4d9zKwHXwNOsAXtjDk7oh47nX/FSUL2T2
         C2J1CPF/spIQZM2eU7J7PX5nXaO33kPGjiIqnDZf9GjbYmlDsJmpOEg3+riN371SPjAP
         GZLBlYz+Ap0C4w2ehJ1TAMtBDmuW9Xs6xKn8leyOc1vbpJZZk5Ecg3xGa1NswNQaFUxd
         NY8l10rduLlsSwcOzk8WO+F2rhlRIsS7zAmJO7dAFtsj2k+SZ7cxKdEIc2nQyl8dIhFT
         V1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704472815; x=1705077615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stYajyWPWMqAHb+0oqEiVrcD5n0SgOsrMnrQbqDRt/0=;
        b=QwIaD0bLZZRbwkOG3M13t2PVzskD5Cq3nxoi/e8MJ9hubJ4fpvc1IZm/Zrtf7CFxLM
         QUO2dj1l+V6XtzTcW5CS4UhBPlmujmDZeZQ5hpAFfF5XBcSHc8WITBe2c4YpycQ1goz8
         SNG95JQDVj7Vjv4zgAqFc1C+pYZhiGyKHRh5Jx7B/gpuAuN4FkCbnEPlH0Le19IhfXdF
         OLxfckPOyTr4jGZ9HY989FNpakO3j1jpCXwEHZjLglhpx+e81d+52/ge6Yz/yVABWhNd
         VuWL/LKCykTNHpqAr3xDMyrz2E/+aeHuNPAcDPl7ufFuhGjqXWs/jB85vyFVrmLdm+cJ
         QWSw==
X-Gm-Message-State: AOJu0YxZ5rh8BETwn0fuohvz9sjXBpGbsbT8w01555h9u8qsZsm9i3Oo
	vLy07Tp5Xk1/bUx+KRL/cMA=
X-Google-Smtp-Source: AGHT+IER7Mmfrirshqi4PsQW5EUqzJ9Q4bZbTOoO2VyzvwoQMJ+wSxBxm2g9U+dIoom8qX6b5lHWyg==
X-Received: by 2002:a05:6808:1521:b0:3bb:bd59:df86 with SMTP id u33-20020a056808152100b003bbbd59df86mr2699492oiw.86.1704472815201;
        Fri, 05 Jan 2024 08:40:15 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id ez16-20020ad45910000000b0067f81a1494esm726626qvb.55.2024.01.05.08.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:40:14 -0800 (PST)
Date: Fri, 5 Jan 2024 11:40:05 -0500
From: Abdel Alkuor <alkuor@gmail.com>
To: Jai Luthra <j-luthra@ti.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Abdel Alkuor <abdelalkuor@geotab.com>, rogerq@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	vigneshr@ti.com, d-gole@ti.com, nm@ti.com
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Message-ID: <ZZgw5SNZiG4VlhZD@abdel>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
 <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
 <f463e49d-9e69-4bff-a663-3ce7c1093202@wolfvision.net>
 <nza4s2kjmcptz6epbyegwy6wh32buyxm5evnk2jultqblgzs4b@6mzuklpqhby7>
 <6e63a1f0-8ed6-41cf-b1bc-34b49099eedf@wolfvision.net>
 <4erwnvyyammnsdihwpvqcmm4v4fcyxozltocklsbnbfdhacoye@le7x2giuxrwv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4erwnvyyammnsdihwpvqcmm4v4fcyxozltocklsbnbfdhacoye@le7x2giuxrwv>

On Fri, Jan 05, 2024 at 03:40:54PM +0530, Jai Luthra wrote:
Hi Jai and Jvaier,
> > My biggest concern is that we are sending GAID for the tps25750 under
> > the same circumstances. Could we not have the same problem with that
> > device? We would be resetting the PD controller and the SoC would stop
> > getting power as well, right? Or is there anything device-specific that
> > would avoid that?
> > 
> 
> Yes I would guess same problem can happen depending on probe order of 
> the remote-endpoint node, but I don't see any upstream platform using 
> ti,tps25750 compatible, so I have no way to confirm.
> 
> Maybe Abdel can comment on how it works, as he added the GAID reset for 
> tps25750.
> 
Ops, that's an oversight from my side. In our case, fwnode_usb_role_switch_get()
returns NULL but if it does return -EPROBE_DEFER, we will end up with
the same issue you're seeing.

The purpose of the reset is to remove any applied patch so we don't
leave USB-C PD controller in some kind of operable state when the device
fails to be probed. GO2P command forces PD controller to retrun to PTCH
mode but unfortunately that doesn't work in all cases unless ADCINx pins
configurations are set in "NegotiateHighVoltage" option, so I opted into 
using the hard reset instead regardless of ADCINx configurations.

> > > If you have a better architecture in mind that can reset only when PTCH 
> > > has been applied and not for other probe defers, feel free to send it on 
> > > top of it.
> > > 
> > 
> > I added the cold reset to have the same behavior upon probe failures for
> > both devices, given that they use the same command. But if that can
> > cause problems, let's leave the reset alone...
> > 
I think in this case, we might want to apply the patch as the last
thing in the probe or check for EPROBE_DEFER before issuing a hard
reset.

Also, I think if the patch is being applied using EEPROM, I don't
believe we need to issue a hard reset ever as the patch would be applied
automatically after that.

Thanks,
Abdel



