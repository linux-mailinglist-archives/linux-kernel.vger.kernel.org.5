Return-Path: <linux-kernel+bounces-123060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F05890194
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943031C2BA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20212E1C8;
	Thu, 28 Mar 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckIldkLP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2812DD94;
	Thu, 28 Mar 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635637; cv=none; b=ZKsLEJwzc8SDaJX9tRkl4FVe8udeIbVA4o5xZGViz0+KG1DfE6hB4qH57OPeJAawiq29+tuqqGdmB6UScYsUq+kXZjknWKGfGWaZRpepcfLwRp3v6Pv3FOIIXu3Ux3MxA3m2TxIowz2Yiw5MphTJkdNKTv+fnvWPErIhZx5IUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635637; c=relaxed/simple;
	bh=0UIMhPUe3OrZBg9U2y37PNZwfEGqSD0OKBPdydUBswY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj+yHulmNcIzc9ki5VcXQbENKvsXfOoV/DH+FXHW+TNWe98tTOeguGfqO+K+PyDqZQhbfW3ES1VBUabyHBwh16jDH2C2nd2EEdgIJYaV+lO1eanw0sIPOeSgukRlpSr68cq3tCT8j1UDWclOAiugGXvu2+yTDpzKPNrYTmiRz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckIldkLP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41493e0fbf2so6990065e9.1;
        Thu, 28 Mar 2024 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711635634; x=1712240434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FNCcePXE5FzwzG6BnzCkSEJiu6TlTQYchrGdLQhulyQ=;
        b=ckIldkLPs4vKeVr2g6xxedQWjjy6TEfHsSx5+lyZid4Bh++x0H+YuxEcQcfoKF4qip
         QorS5sQpzBX+2LzGz/uTNvwzhoN6xbrlgnMQYouFdYyWR8ByOQ25vGpfPwFbZ40tHb8C
         p1qLyOMvWKzzbhH/gZXaH3RPC/OpDaqBysCYslMObKE1dnW0IPtpQsy7HoXpWQwtiRKL
         q3wPZuJMMmwKQy1Ki1vJ+vOqzeqv0TvYoxX1jxaQZwzgEywjCufp1QLNaxRX/S0f3zu4
         rxVuD1Zw0HMe/ca+sbT3mxKVE3i1BDC3e08rU6XxON8xdMMWpCx91EaCwME1Lk7xjIII
         q+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635634; x=1712240434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNCcePXE5FzwzG6BnzCkSEJiu6TlTQYchrGdLQhulyQ=;
        b=XhPf/Wp1F4NeXIJuKhI+ULM5F8zZn1o010RGXDTs02c/fdKiI55idb0440XPTkyq5x
         nha9Moags3E2cD0QaI7+zeSdSPrJEIIzKd2QRemGPDb3yimDS8rjGLnMu6hcWpHYL/fC
         r2iEGN4Fz3xpoGV+8E9buiYZmOtKfv6RnYpqv9opXaWC1e81ijehr9xXp9L8zoCWFuD1
         i1RRpwAYFocalfggP5dsmgn9bc3jrNEGwFYkDpJDhVKKtc2qT/WfiRP+LR+y+TyNNp9+
         yeTjgbTWT9a9tdkOkxohoEXFIEeHbbspHS/3fx7iftooCcFyJk4Gf8n3CNxZunsDIEFA
         KZVA==
X-Forwarded-Encrypted: i=1; AJvYcCWYQKVrCFgiOU+eUZw6CbqDaQkP6CWu+UvcJOXhDeuPOmDPycPYGONPkL4mTMsLfwEQYjCdUNj7/JBfVs2pmGDTMpx0fUw2AnHA/A0RFSoaQxJLLIgJpzxAyIPHGYPDVQ9FPiie
X-Gm-Message-State: AOJu0YzpE2KdqERAQkLVW25QPNxm6fGLCj+AoZorlNXh4djpA9PuBqL+
	Yo1qw/+GIVl8nVELs8JWZmafSEbQ7fD5eSi/bQeWHqSH2MTUqit2
X-Google-Smtp-Source: AGHT+IGfQLk8jtmCdcy+/N2UZ2hPobovqUovkG1ihPFWtaN1VE308abwCnD9v+ubcZPF66caCh1HUQ==
X-Received: by 2002:adf:ea81:0:b0:341:afa0:6d10 with SMTP id s1-20020adfea81000000b00341afa06d10mr2291731wrm.61.1711635633876;
        Thu, 28 Mar 2024 07:20:33 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-1-248-55.retail.telecomitalia.it. [87.1.248.55])
        by smtp.gmail.com with ESMTPSA id bp8-20020a5d5a88000000b00343300a4eb8sm1528932wrb.49.2024.03.28.07.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:20:33 -0700 (PDT)
Message-ID: <66057cb1.5d0a0220.b68f2.5cbf@mx.google.com>
X-Google-Original-Message-ID: <ZgV8rZBCXn_BLvE7@Ansuel-XPS.>
Date: Thu, 28 Mar 2024 15:20:29 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
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
 <66042f0a.050a0220.374bd.5e4a@mx.google.com>
 <20240327163129.18c95cfe@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327163129.18c95cfe@xps-13>

On Wed, Mar 27, 2024 at 04:31:29PM +0100, Miquel Raynal wrote:
> Hi Christian,
> 
> ansuelsmth@gmail.com wrote on Wed, 27 Mar 2024 15:36:54 +0100:
> 
> > On Wed, Mar 27, 2024 at 03:26:55PM +0100, Rafał Miłecki wrote:
> > > On 2024-03-22 05:09, Christian Marangi wrote:  
> > > > MTD OTP logic is very fragile and can be problematic with some specific
> > > > kind of devices.
> > > > 
> > > > NVMEM across the years had various iteration on how Cells could be
> > > > declared in DT and MTD OTP probably was left behind and
> > > > add_legacy_fixed_of_cells was enabled without thinking of the
> > > > consequences.  
> > > 
> > > Er... thank you?
> > >  
> > 
> > Probably made some bad assumption and sorry for it!
> 
> Well, "not thinking about all consequences" seems always legitimate to
> me, we are not robots. Anyway, I agree we should drop this sentence.
>
> > > > That option enables NVMEM to scan the provided of_node and treat each
> > > > child as a NVMEM Cell, this was to support legacy NVMEM implementation
> > > > and don't cause regression.
> > > > 
> > > > This is problematic if we have devices like Nand where the OTP is
> > > > triggered by setting a special mode in the flash. In this context real
> > > > partitions declared in the Nand node are registered as OTP Cells and
> > > > this cause probe fail with -EINVAL error.
> > > > 
> > > > This was never notice due to the fact that till now, no Nand supported
> > > > the OTP feature. With commit e87161321a40 ("mtd: rawnand: macronix: OTP
> > > > access for MX30LFxG18AC") this changed and coincidentally this Nand is
> > > > used on an FritzBox 7530 supported on OpenWrt.  
> > > 
> > > So as you noticed this problem was *exposed* by adding OTP support for
> > > Macronix NAND chips.
> > > 
> > >   
> > > > Alternative and more robust way to declare OTP Cells are already
> > > > prossible by using the fixed-layout node or by declaring a child node
> > > > with the compatible set to "otp-user" or "otp-factory".
> > > > 
> > > > To fix this and limit any regression with other MTD that makes use of
> > > > declaring OTP as direct child of the dev node, disable
> > > > add_legacy_fixed_of_cells if we detect the MTD type is Nand.
> > > > 
> > > > With the following logic, the OTP NVMEM entry is correctly created with
> > > > no Cells and the MTD Nand is correctly probed and partitions are
> > > > correctly exposed.
> > > > 
> > > > Fixes: 2cc3b37f5b6d ("nvmem: add explicit config option to read old
> > > > syntax fixed OF cells")  
> > > 
> > > It's not that commit however that introduced the problem. Introducing
> > > "add_legacy_fixed_of_cells" just added a clean way of enabling parsing
> > > of old cells syntax. Even before my commit NVMEM subsystem was looking
> > > for NVMEM cells in NAND devices.
> > > 
> > > I booted kernel 6.6 which has commit e87161321a40 ("mtd: rawnand:
> > > macronix: OTP > access for MX30LFxG18AC") but does NOT have commit
> > > 2cc3b37f5b6d ("nvmem: add explicit config option to read old syntax
> > > fixed OF cells").
> > > 
> > > Look at this log from Broadcom Northstar (Linux 6.6):
> > > [    0.410107] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xdc
> > > [    0.416531] nand: Macronix MX30LF4G18AC
> > > [    0.420409] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB
> > > size: 64
> > > [    0.428022] iproc_nand 18028000.nand-controller: detected 512MiB total,
> > > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-8
> > > [    0.438991] Scanning device for bad blocks
> > > [    0.873598] Bad eraseblock 738 at 0x000005c40000
> > > [    1.030279] random: crng init done
> > > [    1.854895] Bad eraseblock 2414 at 0x000012dc0000
> > > [    2.657354] Bad eraseblock 3783 at 0x00001d8e0000
> > > [    2.662967] Bad eraseblock 3785 at 0x00001d920000
> > > [    2.848418] nvmem user-otp1: nvmem: invalid reg on
> > > /nand-controller@18028000/nand@0
> > > [    2.856126] iproc_nand 18028000.nand-controller: error -EINVAL: Failed to
> > > register OTP NVMEM device
> > > 
> > > So to summary it up:
> > > 1. Problem exists since much earlier and wasn't introduced by 2cc3b37f5b6d
> > > 2. Commit 2cc3b37f5b6d just gives you a clean way of solving this issue
> > > 3. Problem was exposed by commit e87161321a40
> > > 4. We miss fix for v6.6 which doesn't have 2cc3b37f5b6d (it hit v6.7)
> > >   
> > 
> > So the thing was broken all along? Maybe the regression was introduced
> > when OF support for NVMEM cell was introduced? (and OF scan was enabled
> > by default?)
> > 
> > Anyway Sorry for adding the wrong fixes, maybe Miquel can remote the
> > commit from mtd/fixes and fix the problematic fixes tag?
> 
> Yes, please send a v4 (with the sentence above updated) and I will drop
> v3.
> 

Thanks a lot! I asked Rafal some suggestion for a better fixes tag and I
will send v4.

-- 
	Ansuel

