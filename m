Return-Path: <linux-kernel+bounces-109899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB2688577F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794D7282AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE44556B68;
	Thu, 21 Mar 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf8Sgnky"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81F1CA9A;
	Thu, 21 Mar 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711017263; cv=none; b=kRb43vHB3NLDo+iudA5peS8cX+B81lussEJ5KQdxphjYU3NK6qzOmRb/+okcxymscszjv5goHSPr7yu3YSftT+c834qpWtnysSjbsLnjPBEAZrLFZKib7VJ+lguo+VeEMsf1LZEp2LXoOt0VIC7QJ0qC8/q/L/uuxXgz/eXPHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711017263; c=relaxed/simple;
	bh=VOi+PZbV9b+AJm91llBcxlZV4MlF+wjNnLpe9He3k4U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugJHGfZftI/Z1VY6rN1EXB5gSddvWrJue5dJ4KCcmrFTVxzPisJUDv9tREJP1k6B66f08E+qgezKPnEH6QOjTJywUQUGYPCtskZIs/iLiqNnbnYXjcs9Xj4diaWjdJweahlU+X1dZg8Vce6xzV3+2UIDRgEXOIbr4PwL1UdPscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf8Sgnky; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso13144381fa.2;
        Thu, 21 Mar 2024 03:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711017260; x=1711622060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NHG19S00nW0KrNYH2WSzHwN8S/SHdrN0ELw9d3lEmaU=;
        b=Pf8Sgnky+RpTU8uNqAULmUoqPc7racMy/dxoWq5+OSwoMSk1yaMBYlYxEQlDIzljk5
         ZQ9Vcf+hbOrrnF0CrodzG9f2RWisa5afqChmXHh8ppYv4Vy4FBiUoNBjebzhjOiD/pZO
         Qm983ZnShaV2B8060spbw9Yax+UOGlnBZqk/6WleHeywgE/ibZsan1nDclne/mqTWiHW
         9FiSjKq/nDTBmkW3VUgsV4eDAAapltEupWPJlVSIdT0g71tsX7gszX6ikr4yCOAbvyqh
         8awws85lijgG7aUjoxCYPrNW9D2DU/rkM9jO5OTmgPUpoW2ZVh+HVi5Ba1Yz9oD2xhG9
         Piag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711017260; x=1711622060;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHG19S00nW0KrNYH2WSzHwN8S/SHdrN0ELw9d3lEmaU=;
        b=p814uV7CrTvNc2FPepjipWgQSyABeY2hWnwQF8f8kfD/iWGKN22Ry6+8+xk2kUsQ9y
         oxwR+P3QDLyqZd5dNEhTsMbvkD71Sz4O19fQX7qHRP8xr0ZZRWMn84YtthSu+LLV1p8R
         ly67tYkkKK+QG2JQrSmUGfQUXQuHuAqFOsnrng5Kgx9crEDAeuUT5Cvzi4VW0vt9LPD5
         NOEhJoJyYTAsENk3skEJR0vXqAWyF6gWP0nvlFX7O6rV4J/MzizQN7YeKAyCvNfM91Wr
         o0hmE0ZEtYSSZzXBPtw+faZ8QQGbNoy7RxhgIIm2Jh56+xMc3E/H32wKJMGQHanl7dbx
         RXbg==
X-Forwarded-Encrypted: i=1; AJvYcCVp9/+YAxf0amusY4qCul/HuF1FcL9iaXIjsuuS9Luvlt6ZFsUjDPqNzUPMJR6vEJZKWXAXSVeFv7W8C0vEFlJ37vvB3uGkadQSqlQWTRm27ITkm6Eiew4ZaIOGssategELbEAF
X-Gm-Message-State: AOJu0Yz+f4zihsrsjYHrbI4a5G5salWcVCMPQMhqX9cKZeLulj1l7mJt
	RhgNIW3AkbnbxhosyaFdQLPkvzRBCzoSX+rHwNmsTNHx3QookbdN
X-Google-Smtp-Source: AGHT+IHZsmHDVKcW8S4Muplgc0gm08EDd7GKFo3DN0TZd0vtgrg7sUO9gJqCCt6ZDD/IbDH6dh92eQ==
X-Received: by 2002:a2e:a4cf:0:b0:2d2:c83c:ffd7 with SMTP id p15-20020a2ea4cf000000b002d2c83cffd7mr2823962ljm.42.1711017259315;
        Thu, 21 Mar 2024 03:34:19 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c468500b004132ae838absm5174369wmo.43.2024.03.21.03.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 03:34:19 -0700 (PDT)
Message-ID: <65fc0d2b.050a0220.102ac.24f6@mx.google.com>
X-Google-Original-Message-ID: <ZfwNKKJD5Yy6UjxN@Ansuel-XPS.>
Date: Thu, 21 Mar 2024 11:34:16 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: limit OTP NVMEM Cell parse to non Nand devices
References: <20240321095522.12755-1-ansuelsmth@gmail.com>
 <20240321113256.7e66ac0f@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321113256.7e66ac0f@xps-13>

On Thu, Mar 21, 2024 at 11:32:56AM +0100, Miquel Raynal wrote:
> Hi Christian,
> 
> ansuelsmth@gmail.com wrote on Thu, 21 Mar 2024 10:55:13 +0100:
> 
> > MTD OTP logic is very fragile and can be problematic with some specific
> > kind of devices.
> > 
> > NVMEM across the years had various iteration on how Cells could be
> > declared in DT and MTD OTP probably was left behind and
> > add_legacy_fixed_of_cells was enabled without thinking of the consequences.
> > 
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
> > 
> > Alternative and more robust way to declare OTP Cells are already
> > prossible by using the fixed-layout node or by declaring a child node
> > with the compatible set to "otp-user" or "otp-factory".
> > 
> > To fix this and limit any regression with other MTD that makes use of
> > declaring OTP as direct child of the dev node, disable
> > add_legacy_fixed_of_cells if we have a node called nand since it's the
> > standard property name to identify Nand devices attached to a Nand
> > Controller.
> 
> You forgot to update the commit log :-)
>

Ugh... sorry. Ok to resend or I need to wait 24h similar to the rules on
net-next?

-- 
	Ansuel

