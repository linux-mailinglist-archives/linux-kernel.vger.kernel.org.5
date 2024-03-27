Return-Path: <linux-kernel+bounces-121447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A957D88EAC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55492B37755
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F52C13B5A5;
	Wed, 27 Mar 2024 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEah4EQD"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A91148318;
	Wed, 27 Mar 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550222; cv=none; b=m0mQo+eHzfgSotp6/wfE+AjO3jHX8df/HMNIBYikp9+3wcDjDouWc/DLxv5jnbg/G9Wj3DrbPPmOC2zeNj3A5xL7VYct+xi7NMioJpXU3/zVbNA+E0Avle0rLsN60c56+mjiaTmf6o2Rq5SOL70xH7ATqiIEvh/l8IZGtmBO2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550222; c=relaxed/simple;
	bh=tZ6iiB+i0ZmyFNFdU1jD5N+tUlziWC4f0Hs3sdUC4Rw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGpqHIvsyvBxp+05+bOREbx2HMJZZFR38ynAZWIaB00uDxLeXNShxRr4TaMZ0EVpaLs7PUP20pqDOQ+gL6rsJNoDetoSOtiGIOmYZ/BbJVXgSZ4SL1TWIbbBYZCv6lNWtbeQpgukRHNHnKT0yblQ6F8y8On6aq4wms9KktJQHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEah4EQD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-341cce3e5f0so3035929f8f.1;
        Wed, 27 Mar 2024 07:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711550219; x=1712155019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2QlBuDPO4NDedXxsV0KoGnPJolaV0ADmz/BaiLD5HCQ=;
        b=TEah4EQDXUSV8dt5iNk3CeM2wvNbFUiEy7MYRnTtOLLnnSCeEH/UIUxr0oJMI34V4M
         7A152E3Elf6pUbeEcXB5AXx7Q3FcNyrWq38wXdXgjEPNooE7s6u3hNjHYOnQ9MrcvGRw
         aDW/SWX+WkEqwF0YHkMam96XrNX3RitOcZwKMsf08ONnZ+m+rNztddi/ftYuBkVKGBtJ
         IKklj8jjgIRVWnQM7KEnWhngcp0lJ8qsQ0koMmyQURefpL3Zt7pcDnVT7K7kzgOXmpVb
         MNFfNysZtCVLXNZE44x7T6za2llNHEHkwhJS+DT054kZz5p6YHwqONuE9SIIPELqdojc
         z0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711550219; x=1712155019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2QlBuDPO4NDedXxsV0KoGnPJolaV0ADmz/BaiLD5HCQ=;
        b=qbfWRSY9QrjZ3BeIRyP67G2FeJqfpRVuGG3oSJyT6qhkSpzf1SlEodrqefZObqeNGO
         OEiojfEI9Je1dWc+pn/ditaG8WjijgD4t6jGONy5D6KW90e0IIghFlyh9jqSr3beHB4b
         6ogxVzj4uxfVLQaig3UpSXIYHunl4fYcICa3lKTC6xcfFUO0a18zhaLzg2ZH6dg8FETH
         xLT+rpgk85xYlxTI/WDdJPgP4otMPZ0LgBvQvgEb7bpdiHhMPbOzXBIl7DCU5Tpcgxy8
         DomJUPmX8Hix4t0cC89kg0wmAxrLVUv6SPUpOeTeeToXfAwVBoyad1599EeHPdJkOdKO
         EyuA==
X-Forwarded-Encrypted: i=1; AJvYcCXCGo66CvcBTt7GJLmjKcsUZvSuL6Dv7xuLHfDkLJkiUTa6xVdex/R9m9sbtTFQMfEjTOUtD1og5rE6A7Jn2M870w5pUCSeKeAwSsadFybhhoLWL1TUA7fHpVKkI0CkQH0mzEWW
X-Gm-Message-State: AOJu0Yw/XvduqvcnTMRcvGat/0WthMgd5l94HCYvAJulc7xfIrktgxUL
	mKpNQzgQKJMsG1gbT/H9QTLPzjR1EvABG2adLJe7hpnHVgQOP8NF
X-Google-Smtp-Source: AGHT+IHIbyFyKXy/IZRZSRFF7DCQjRg/SHOr/w5jI1d9TxuX7iA2NeciNy2jNtJ3pwQ508N84aKcww==
X-Received: by 2002:a05:6000:1b8a:b0:341:bbf2:4c36 with SMTP id r10-20020a0560001b8a00b00341bbf24c36mr135699wru.27.1711550218658;
        Wed, 27 Mar 2024 07:36:58 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-247-253-192.retail.telecomitalia.it. [95.247.253.192])
        by smtp.gmail.com with ESMTPSA id bn15-20020a056000060f00b00341e2802a30sm1479190wrb.98.2024.03.27.07.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 07:36:58 -0700 (PDT)
Message-ID: <66042f0a.050a0220.374bd.5e4a@mx.google.com>
X-Google-Original-Message-ID: <ZgQvBopKexcur9H9@Ansuel-XPS.>
Date: Wed, 27 Mar 2024 15:36:54 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mtd: limit OTP NVMEM Cell parse to non Nand devices
References: <20240322040951.16680-1-ansuelsmth@gmail.com>
 <44a377b11208ff33045f12f260b667dd@milecki.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44a377b11208ff33045f12f260b667dd@milecki.pl>

On Wed, Mar 27, 2024 at 03:26:55PM +0100, Rafał Miłecki wrote:
> On 2024-03-22 05:09, Christian Marangi wrote:
> > MTD OTP logic is very fragile and can be problematic with some specific
> > kind of devices.
> > 
> > NVMEM across the years had various iteration on how Cells could be
> > declared in DT and MTD OTP probably was left behind and
> > add_legacy_fixed_of_cells was enabled without thinking of the
> > consequences.
> 
> Er... thank you?
>

Probably made some bad assumption and sorry for it!

> 
> > That option enables NVMEM to scan the provided of_node and treat each
> > child as a NVMEM Cell, this was to support legacy NVMEM implementation
> > and don't cause regression.
> > 
> > This is problematic if we have devices like Nand where the OTP is
> > triggered by setting a special mode in the flash. In this context real
> > partitions declared in the Nand node are registered as OTP Cells and
> > this cause probe fail with -EINVAL error.
> > 
> > This was never notice due to the fact that till now, no Nand supported
> > the OTP feature. With commit e87161321a40 ("mtd: rawnand: macronix: OTP
> > access for MX30LFxG18AC") this changed and coincidentally this Nand is
> > used on an FritzBox 7530 supported on OpenWrt.
> 
> So as you noticed this problem was *exposed* by adding OTP support for
> Macronix NAND chips.
> 
> 
> > Alternative and more robust way to declare OTP Cells are already
> > prossible by using the fixed-layout node or by declaring a child node
> > with the compatible set to "otp-user" or "otp-factory".
> > 
> > To fix this and limit any regression with other MTD that makes use of
> > declaring OTP as direct child of the dev node, disable
> > add_legacy_fixed_of_cells if we detect the MTD type is Nand.
> > 
> > With the following logic, the OTP NVMEM entry is correctly created with
> > no Cells and the MTD Nand is correctly probed and partitions are
> > correctly exposed.
> > 
> > Fixes: 2cc3b37f5b6d ("nvmem: add explicit config option to read old
> > syntax fixed OF cells")
> 
> It's not that commit however that introduced the problem. Introducing
> "add_legacy_fixed_of_cells" just added a clean way of enabling parsing
> of old cells syntax. Even before my commit NVMEM subsystem was looking
> for NVMEM cells in NAND devices.
> 
> I booted kernel 6.6 which has commit e87161321a40 ("mtd: rawnand:
> macronix: OTP > access for MX30LFxG18AC") but does NOT have commit
> 2cc3b37f5b6d ("nvmem: add explicit config option to read old syntax
> fixed OF cells").
> 
> Look at this log from Broadcom Northstar (Linux 6.6):
> [    0.410107] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xdc
> [    0.416531] nand: Macronix MX30LF4G18AC
> [    0.420409] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB
> size: 64
> [    0.428022] iproc_nand 18028000.nand-controller: detected 512MiB total,
> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-8
> [    0.438991] Scanning device for bad blocks
> [    0.873598] Bad eraseblock 738 at 0x000005c40000
> [    1.030279] random: crng init done
> [    1.854895] Bad eraseblock 2414 at 0x000012dc0000
> [    2.657354] Bad eraseblock 3783 at 0x00001d8e0000
> [    2.662967] Bad eraseblock 3785 at 0x00001d920000
> [    2.848418] nvmem user-otp1: nvmem: invalid reg on
> /nand-controller@18028000/nand@0
> [    2.856126] iproc_nand 18028000.nand-controller: error -EINVAL: Failed to
> register OTP NVMEM device
> 
> So to summary it up:
> 1. Problem exists since much earlier and wasn't introduced by 2cc3b37f5b6d
> 2. Commit 2cc3b37f5b6d just gives you a clean way of solving this issue
> 3. Problem was exposed by commit e87161321a40
> 4. We miss fix for v6.6 which doesn't have 2cc3b37f5b6d (it hit v6.7)
> 

So the thing was broken all along? Maybe the regression was introduced
when OF support for NVMEM cell was introduced? (and OF scan was enabled
by default?)

Anyway Sorry for adding the wrong fixes, maybe Miquel can remote the
commit from mtd/fixes and fix the problematic fixes tag?

> 
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel

