Return-Path: <linux-kernel+bounces-79583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B531862477
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398271C21556
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011022511E;
	Sat, 24 Feb 2024 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHn/dHs0"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB5D10A24
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708773523; cv=none; b=MVSGCKboCPzftPuuBvGEj/bZz9euNKWMpIv32Ae4i0Qcq3Te3tWVQ9zUwgOJfc1b+o0tuQ1zV+VNF1TQPlbKku+RgT22rLaywqizGvpRls6ySiM9DfcxegKez2les1su3He/MojSzrn68cc0IbH5QV+5G6wNWnwxfiLvRF1lVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708773523; c=relaxed/simple;
	bh=K/4cGTKKaechsK64Xd1gIN7fPS7yWIdNXevAsxCLHNE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7i4RZzd3tySrFHb+AmDr6KRuoj5oCRrnPckORkcWvjuDRCG3SUxnM/rXY2OaVlx5YU60EsrwqsYJ+sVJZnn5sBSmX1Wz7Vz3MCCaaTWB2fcRyCw77cRuzxAb/h6Q64Miaw1zaTWMkSWJncVmquqsDABfYNz6OGf1jv64pNn9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHn/dHs0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d61e39912so941141f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708773520; x=1709378320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/zHtnHJBkLHaWWffv0wRxWGPw57+ZGOg6K9nRmYxTo4=;
        b=OHn/dHs0xokbWM1GJmnTUign/S2OCdCRvMYuyfFOP+NZicG9lNrrpm9h5Mi0F8ivwA
         CFdRAYwuh7nd0qpLgkuNqy1hVpFGG8QhXkz4KKoXwz5Yd23KB9FdHjqEToah0syjwd/J
         xj45zgjUgpcmJPPRXfJ5Q6EC5OtvxejUMgb0xT5t8h4WCJ1mAQMq3wjI0XrduGBZyhaA
         SIsQfJIsBAsJ1kj3pxvJyEx8XoENB1YDrH5VXvVFlEPsHp0qm38mOOf+fBxnAtO+ylDf
         PAKvjfWAVl8yE6TOnRNvf9Zbt3NOnH9zXJZzAP7hHZ4aAysXN41M7+LelT0uwSdP435Z
         JpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708773520; x=1709378320;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zHtnHJBkLHaWWffv0wRxWGPw57+ZGOg6K9nRmYxTo4=;
        b=MFM60SmTQak48K1O+CoJ4ylkHc8XogszArO2WOrIYxSiPxu69oVoBK7m/C8oqUYtQ4
         VjFkK8steQm7w3WPt0v3k1BnJwEPfs5HlceR6Xuu41fV/NCzSNakN+x6hzqgd0O3tvcD
         yomenO2fXQnB2FcBoyUsIIEkYWtNPt6UHrYq1Dx4HKt1d+3SQDYy5+Rz7zdLjso/LXVs
         C2tSNhJOZkBP8JunaJD+ajy/mfuf/zCVhpaOmQxLAeCr7WUw+BeKqR/EnYLUsLGcLvGv
         hiGBsJ82l1DbKelUa9u9L4aUhpocVLW6uA3IW/rNBZ+fiE99vCmLFJMhBhAHCwWxfaTl
         dXMw==
X-Forwarded-Encrypted: i=1; AJvYcCXvOJBcKjL+wtQ2oZnqhDFTUekjn7aAmWv4Le59OsXypvjkz8ZWukXvztEngeOY6tpcRst7891QCAAPZWHh4N9P+a+KV+noga9Cs0pB
X-Gm-Message-State: AOJu0YxpJk3Xou9Wgl3TGrc9bOGVWXhTJ1hX603RapsCR0JM5zU9xQ+A
	3QN9K4RDzK2oWfUjprSCHj9o83janxgecpxVFZwCr+9C8VzIHBk9
X-Google-Smtp-Source: AGHT+IFjdGtAcyyWaW+dDqzIT3dnsYQx3wZ2z+cpQrxMSC/0EYYTNa7bwc0ddqm4fNskWdx6J0I3+Q==
X-Received: by 2002:adf:ee06:0:b0:33d:746b:f365 with SMTP id y6-20020adfee06000000b0033d746bf365mr1464302wrn.52.1708773519559;
        Sat, 24 Feb 2024 03:18:39 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id k3-20020adff5c3000000b0033d8ce120f2sm1783346wrp.95.2024.02.24.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:18:39 -0800 (PST)
Message-ID: <65d9d08f.df0a0220.988bb.3177@mx.google.com>
X-Google-Original-Message-ID: <ZdnQjOFySK5xzA-N@Ansuel-XPS.>
Date: Sat, 24 Feb 2024 12:18:36 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, David Bauer <mail@david-bauer.net>
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for BoHong bh25q128as
References: <20240220200325.19089-1-ansuelsmth@gmail.com>
 <f7c45e7b-993c-444b-8710-042da7512bbf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7c45e7b-993c-444b-8710-042da7512bbf@linaro.org>

On Thu, Feb 22, 2024 at 09:19:48AM +0000, Tudor Ambarus wrote:
> 
> 
> On 2/20/24 20:03, Christian Marangi wrote:
> > From: David Bauer <mail@david-bauer.net>
> > 
> > Add MTD support for the BoHong bh25q128as SPI NOR chip.
> > The chip has 16MB of total capacity, divided into a total of 256
> > sectors, each 64KB sized. The chip also supports 4KB sectors.
> > Additionally, it supports dual and quad read modes.
> > 
> > Datasheet is public and can be found at the referenced link.
> > 
> > Functionality was verified on an Tenbay WR1800K / MTK MT7621 board.
> > 
> > Link: https://www.e-interlink.com.tw/userUpload/files/BH25Q128AS_v1_0.pdf
> > Signed-off-by: David Bauer <mail@david-bauer.net>
> > [ reworked to new flash_info format ]
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Read/write/erase test are done by flashing and installing an OpenWrt
> > image on the spi and by using overlayfs on it confirming correct
> > read/write.
> > 
> > root@OpenWrt:/tmp/tmp2# cat /sys/bus/spi/devices/spi0.0/spi-nor/partname 
> > bh25q128as
> > root@OpenWrt:/tmp/tmp2# cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id 
> > 684018
> > root@OpenWrt:/tmp/tmp2# cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer 
> > bohong
> > 
> > root@OpenWrt:/# xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> > 53464450000101ff00000109300000ff68000103600000ffffffffffffff
> > ffffffffffffffffffffffffffffffffffffe520f1ffffffff0744eb086b
> > 083b42bbeeffffffffff00ffffff44eb0c200f5210d800ffffffffffffff
> > ffffffffffff003600279ef97764fcebffff
> > 
> 
> Hey, Christian,
> 
> Seems that the flash defines the SFDP tables, thus it's likely you won't
> need a flash entry at all, and instead rely on the generic SFDP driver
> to parse the flash settings from SFDP and initialize the flash based on
> that.
> 
> Have you tried testing the flash without adding a dedicated entry for
> it? Just specifying the jedec,spi-nor compatible in dt will do the
> trick. As you do now, but without this patch :).
>

The user just tested this and It seems there is a problem in JEDEC id?

[    0.726451] spi spi0.0: setup: ignoring unsupported mode bits a00
[    0.732850] spi-nor spi0.0: unrecognized JEDEC id bytes: 68 40 18 68 40 18
[    0.739725] spi-nor: probe of spi0.0 failed with error -2

-- 
	Ansuel

