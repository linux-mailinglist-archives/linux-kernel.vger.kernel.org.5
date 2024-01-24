Return-Path: <linux-kernel+bounces-37515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B2183B12D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6119C28400A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE3B131725;
	Wed, 24 Jan 2024 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FfowQ89Q"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703512F59E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121065; cv=none; b=iNaUISZCLm7OQKKT5fbTxJxnvD0Ta5biO0md4fS6nPw+bE3Y5dyi+ZVIKcwIsz6sRqMhLorGfsRcoDaQV3mewlXkdsgZnr/z3oe8Q2X6qi4CLh1lmOXn3RxoQzL6QsSyvmmVxGDV5efeclEvSMKljguZl2fqEAchLKsDj2rC+lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121065; c=relaxed/simple;
	bh=5C65bOMspCRwrUd4nqyifHQ9iilJrLYr6DwEmT4uC4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgxoSXYS66BAtd0VSfWOYhMkCFIC0WjG+CS4jPIVFHgYQrA+QvLBjmP7w1zH6kDgVYKf2uLQV1FrnZK43MOSGKZW7EwZRjam+Vf3ctWweTflvfMwOTuJYnkNGnv+ecR7enTbvuv7gzmGR2TXGI3xMnXfUAEpzj1grJ843UOasQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FfowQ89Q; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ddc0c02665so481121b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706121047; x=1706725847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2i8Xd8HMGoPtstPdvP9nqcXZNT+QofCfEBJAvkYMuk=;
        b=FfowQ89Qj3OCFEP42VqisgbJ8Afo45vKvx11GbVmgw+wDJaXJ5ZfVNPan8GjfkAu9y
         1JT0gQya6NLmypoiKdydBtICIIi9ueL6Mvlj2laVodvkPAxkYGKCmdG/Areu6mXSTTyH
         LbF+t5HaQkpjDaRYXqHTtarKFMEPf/STWaTMgCreE5EpMftmOjOIqwBPSA98YXLOLwsy
         d6GtxR4kiCWh6pX7nW4IPxrnrKYOiWG51Zc5mHPI9Hi6I4Z9VjM5MwEokrZH7LMeWRbg
         Wj3TgIkgQ6DjP4qKNchVoj+Eeso3NxhUfWDzbqAtxHDxkmoE+tzXJPmnidq39evHJkit
         CkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121047; x=1706725847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2i8Xd8HMGoPtstPdvP9nqcXZNT+QofCfEBJAvkYMuk=;
        b=ncQjLz7Wq3O5TV28WvMlb4sT3Zr93LBW7ddK4io1hC+vOWg9sk38lPbh0iiiBjhCFA
         ca3i+kssqUC/LSDIfldrMxjN7+am2tu79IHoxaxnIASTUWHMp17rGLwqNfM9Qt5CP8yV
         vRbQEbGHub6xEcCItJgNZJHe23HU0QxJsQ0NOEAurIbTfbi/RGz9qrf2J5nTWvWxklNn
         PfvJdluvZUoyRJkpaiyucAw6PPJE+ZnmCJ1WvkjCH6OwkAaFds/Jj9+GffY+8uu0Zmt1
         BSyN+CVtNfuXBs04i7EsbAE2Z3KwdzW4PK1Ck+Y+EM4Dv8zTp7zZEI/m1j7FgXlFsBRH
         qiEw==
X-Gm-Message-State: AOJu0YxT+VHIOaCQSTo2LKVvZBszo2xVSKk9IJ2Z8Cwci3KP7zWbB8jR
	n5dRi6orZAl4tIVEXn0toshQWwxLCbfpgCtfmquYFNgMeV3GifgXllf0MIaA2qlezFf/HSNEfZm
	3X70=
X-Google-Smtp-Source: AGHT+IGhFlCoHvfTo0vDq6Jert274wAOP6jL3oUoJ7+t2cu89hvGIYcsj6qyELcEVpcCVgWYfRktjw==
X-Received: by 2002:a05:6a20:e121:b0:199:96a4:b6b9 with SMTP id kr33-20020a056a20e12100b0019996a4b6b9mr1382220pzb.38.1706121047168;
        Wed, 24 Jan 2024 10:30:47 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id t6-20020a625f06000000b006dd87826805sm2309454pfb.75.2024.01.24.10.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:30:46 -0800 (PST)
Date: Wed, 24 Jan 2024 10:30:43 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: David Laight <David.Laight@aculab.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <ZbFXU4x4p1qw4GHD@ghost>
References: <20240123-fix_sparse_errors_checksum_tests-v3-0-efecc7f94297@rivosinc.com>
 <20240123-fix_sparse_errors_checksum_tests-v3-2-efecc7f94297@rivosinc.com>
 <2235fa55381e481b9252e11463b34720@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2235fa55381e481b9252e11463b34720@AcuMS.aculab.com>

On Wed, Jan 24, 2024 at 09:04:55AM +0000, David Laight wrote:
> From: Charlie Jenkins
> > Sent: 24 January 2024 00:39
> > 
> > The test cases for ip_fast_csum and csum_ipv6_magic were using arbitrary
> > alignment of data to iterate through random inputs. ip_fast_csum should
> > have the data aligned along (14 + NET_IP_ALIGN) bytes and
> > csum_ipv6_magic should have data aligned along 32-bit boundaries.
> > 
> ...
> > +	0x9359, 0x5630, 0xd659, 0x5b4d, 0x511e, 0x627c, 0x4e30, 0x73f1, 0x63c,
> > +	0xf2da, 0x7b,	0xa98b, 0x4fb7, 0x87a6, 0x2500, 0x34e4, 0xf0cd, 0xdc69,
> > +	0x7bde, 0x73f0, 0xd85d, 0x722d, 0x9776, 0x3c8,	0x7e07, 0xdca9, 0x9ecc,
> > +	0xc6c0, 0xbec1, 0x8de5, 0x6f7f, 0x1a09, 0xdbe6, 0x7c4b, 0x3787, 0xdb38,
> > +	0xfac,	0xbed9, 0x3039, 0x6501, 0xae1a, 0xed89, 0xd982, 0xc530, 0xccf6,
> > +	0xd888, 0xf369, 0x2c4e, 0x38c0, 0xcff5, 0xdc9d, 0x5998, 0xe0d1, 0x7e23,
> 
> I'm seeing some odd alignment in that table.
> I think there are 'random' tabs following short constants.
> (Not helped by outuck deciding that tabs are 6 spaces!)
> Probably better to add leading spaces (or zeros after the 0x).

Sure, I will add zeros.

- Charlie

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

