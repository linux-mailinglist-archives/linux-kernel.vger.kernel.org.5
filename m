Return-Path: <linux-kernel+bounces-123056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C9989018A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1A11C28820
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337D912DD90;
	Thu, 28 Mar 2024 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUAG8QBE"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11D12D1FC;
	Thu, 28 Mar 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635574; cv=none; b=FkxojQ1cB2SQcGJM8jq1JG2Di0ih/8QY2EmC/akPRwxubxnp6rqq3pBY1aO24yBAOMy9IOITgl8sdw2dvK1OqZzKJbyPa90oAWlC/ATkz+duTcACfyy/ZJVDdb520fJJDzYwelb6sf5be07wmxZbA66tb1uSQKWpuPgldRRKqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635574; c=relaxed/simple;
	bh=2xwyGLOOj3aMO5bTl8Wvb2iK0ag8hGdp7A/E/1Ppr/k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oI3yeYbxpfh65OF47m0QhVjy8+GCM1Q0WE8LaJRA84/HW/VTDcTzWpQgmemAP1EFnsZCVcjD624e4BcqfKKADL0Kws+YkRDkxbuLp3vNLf+6IKgBYQriSfjc6HtgArsadoB1uGV5CPsP4pIp8x/g6ujJZYgLhLgatkU8klY+84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUAG8QBE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41488f9708fso6912195e9.3;
        Thu, 28 Mar 2024 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711635570; x=1712240370; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WrB39jskNAQxk3poTjDI2WVUKziiXPl2M1zSpgJNL0Y=;
        b=RUAG8QBEPB9MYq1SyIYGvwzTjpbJ5a21Ed5+gKkJFnko9mfAkPFXXxOlD2Cz9RsAlJ
         pRupcoF5ArLyLbaCt3eVoI4gSj1ifuL8LFcsCGDt5rlhzOlJH/itzleyXKelUWwM1UJs
         Thbyavp1IEWN8TMKdnK98unh6jPs1WQZUi+YcsEch8pKB85s4OQa1n5780NiTObO9s5v
         Pf7ccN6cGT8rd9s2vGDvsgQDvMkXAi/W+swuYmLMXwRbniC0wp3BS2S0jj7nAmSe3/Gx
         YLWSO4SUsCR8pskmjK/+LVyY5kNqVtHvn9kFzhy5ciCW7oJjPBqsYjn85dWEXpvwQFAA
         yQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635570; x=1712240370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WrB39jskNAQxk3poTjDI2WVUKziiXPl2M1zSpgJNL0Y=;
        b=nsCvPWCgPGptI8CLMMBIvBbrlp6LywiBxcNPThjrnbJboAuTXM5qQt1+HbsqtX1VD2
         C33y5KEJEaQY10wzP+4SsHnDTSOUveJ65pOSDs7bGIj3+HD2IdC8z5aH8E8saVrvMbVO
         z9+a/s1hTbzWeDhDHOCr4S4FfjWmKdnPIcJMqUObHtzzw+zNDCIqtMn/fKdCP13JulUr
         LHTlKO36IGk6aJC1ea97e+E3ITkR3/h9+CMFuF5RjEMM/rJX0ekHVz3c13RayJJFdyrD
         4ATscOeGXnMt/XLyq4hQXbzqO4CB4eu90yZN4k5MkgLsrVl2HX90H1bTqlyNDBPsDQ/r
         Jq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaWiRIY0s26ox6IhgSGCag6xGC8w2T58u9wltYlRGI9+KfX2eybclN1HdbkkaE/kBTvxc6PNfdI+rVygPXECVBl5vv4/wG5Ee2sdjcB3JTDE1a0E/n8d3uu0byFBWE3lKfWAvk
X-Gm-Message-State: AOJu0YzzeNTfKp13Q3YwmSU3d2v+XrKvr7s62QhsNW0TB/+n7YalAMmq
	ra8UiNQj4fS+RRL2QbUnweKgg0iX6rS9BFRiwXgsmuWldMocnGf1
X-Google-Smtp-Source: AGHT+IHWrLZeKk2CojUjAsEcno3P9RlE2RJMQ3G0SD3pycUW+URPzK2IyGZs4uxY7GtMdfxhVmrWqg==
X-Received: by 2002:a05:600c:45ca:b0:414:8948:621c with SMTP id s10-20020a05600c45ca00b004148948621cmr2718071wmo.8.1711635569770;
        Thu, 28 Mar 2024 07:19:29 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-1-248-55.retail.telecomitalia.it. [87.1.248.55])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c1d0e00b0041477f95cf6sm2457876wms.13.2024.03.28.07.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:19:29 -0700 (PDT)
Message-ID: <66057c71.050a0220.e4ba.97dc@mx.google.com>
X-Google-Original-Message-ID: <ZgV8bS19nCFV8iQm@Ansuel-XPS.>
Date: Thu, 28 Mar 2024 15:19:25 +0100
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
 <30bc0d38-b610-4397-ba42-46819d5507fc@milecki.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30bc0d38-b610-4397-ba42-46819d5507fc@milecki.pl>

On Wed, Mar 27, 2024 at 11:15:02PM +0100, Rafał Miłecki wrote:
> On 22.03.2024 05:09, Christian Marangi wrote:
> > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > index 5887feb347a4..0de87bc63840 100644
> > --- a/drivers/mtd/mtdcore.c
> > +++ b/drivers/mtd/mtdcore.c
> > @@ -900,7 +900,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
> >   	config.name = compatible;
> >   	config.id = NVMEM_DEVID_AUTO;
> >   	config.owner = THIS_MODULE;
> > -	config.add_legacy_fixed_of_cells = true;
> > +	config.add_legacy_fixed_of_cells = !mtd_type_is_nand(mtd);
> >   	config.type = NVMEM_TYPE_OTP;
> >   	config.root_only = true;
> >   	config.ignore_wp = true;
> 
> I think there may be even more unwanted behaviour here. If
> mtd_otp_nvmem_register() fails to find node with "user-otp" /
> "factory-otp" compatible then it sets "config.of_node" to NULL but that
> means NVMEM core still looks for NVMEM cells in device's "of_node".
> 
> I believe we should not look for OTP NVMEM cells out of the "user-otp" /
> "factory-otp" compatible nodes.
> 
> So maybe what we need in the first place is just:
> config.add_legacy_fixed_of_cells = !!np;
> ?
> 
> Any extra limitation of .add_legacy_fixed_of_cells should probably be
> used only if we want to prevent new users of the legacy syntax. The
> problem is that mtd.yaml binding allowed "user-otp" and "factory-otp"
> with old syntax cells. It means every MTD device was allowed to have
> them.
> 
> No in-kernel DTS even used "user-otp" or "factory-otp" with NVMEM legacy
> cells but I'm not sure about downstream DTS files. Ideally we would do
> config.add_legacy_fixed_of_cells = false;
> but that could break compatibility with some downstream DTS files.

Yes the main problem is prevent regression in downstream. I feel for the
nand usage, this is 100% of the times broken. For SPI and other corner
case MTD devices it's not?

Anyway did you by chance have a suggestion for a better fixes tag?

-- 
	Ansuel

