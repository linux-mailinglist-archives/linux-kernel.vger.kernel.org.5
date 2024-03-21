Return-Path: <linux-kernel+bounces-109727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE07883824
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF9A1C211ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B16451C44;
	Thu, 21 Mar 2024 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJ3wWVD/"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD424E1D6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005624; cv=none; b=Q3Nrtv6E/Bj1OGeoVprsesBr7tF4JOs2jI408MjspqetGD/EBfHnsA62W3nvNd5OqXiwB8zz7x85ufrvIbV5hkHPcgoIJNdcbgypx2QW+H045Tzauug76dUrCS8dtiV0vQa9j4ddvOUgYfU9J4L+t90yJ9Rh86zurrnYqfal9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005624; c=relaxed/simple;
	bh=M/pE1qtuba0xAb4ithnVVZnIuFnsFrNwP1v7PJ5rEqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLj3Tj77d+IuCdHsCgAU+ABHiW8L89t8BwlAFr5eS/5xLeyqexbt5lxQvPWeMJfcbPt2KkN9i+T1cVAUDVgKugO2fmWcHLD7snR3gd/bVDXiTfBREMJLu/lvrqf8L54zVNLPNGgy4jY/PHabf1XTRS//PQQIY8M/ImcOIFoZBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJ3wWVD/; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d6a1af9c07so4491181fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711005621; x=1711610421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhN50euko1HcLlbzreWy4UyMhBRrqu5b6P2NFYTbhuE=;
        b=LJ3wWVD/WYeHDkalIXeELXgogbQXoSuG8GOqZKM2HUYOmYcnPreqfS+0LZuzBa0ic4
         MiXfXQjNphC3MehZKnJLO1YIOr8op3cAwJYXGUL/y9IDpbkBJj/Y0fBaQghaGAHjROhV
         cnYds5kahOvuziY7URmx4c/xeM5FMgqxWSr7ussSdv2WWpOahptXE7QPTROXUEqQIFRD
         bFvL+DlsX1OSa6ZJA0aHPwvD4E0YUDKPLni0/odOLuTP71nFYzehI5953xlPwNTaHEtz
         ODO4XzUQFvOd30al+C83EFkvpSUR0Ii6fYhZc8PGqBYxZet9L80HyGuX4AuR9eWAOBtT
         lbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711005621; x=1711610421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhN50euko1HcLlbzreWy4UyMhBRrqu5b6P2NFYTbhuE=;
        b=dRtwhxT0zkOUatonaFiLMvlpDJiId6Lhak8Yf3t8qBIGaeiGCydomHgTiTjRK6g3bX
         lJrYf25aNMU3rucq0uxKcsZs4jfc/WkXoxaVZTfkrkKMShmIa081mpIu95TD03k90dgS
         lVcZ4W9qQ/3nMUdeiiEysOUF4E7i1rdhHs+ITgs6oDiG6mG/sb1tLx9cQgionJ+0GCO5
         dURvrDwEfPY2U2H/PlX0aJWOcwiCo2PfZz+PJXIm26Xlm/EafL5vPa1y97vj5N6Ql9BK
         BR4ttz7s5AENT9RZxQuWCZegNMTqVxoL8Gm/lBRhVOL1F3yRDrWSsr5KBdukmTL1V/vE
         yKfA==
X-Forwarded-Encrypted: i=1; AJvYcCUKyuhDimIopxv8S5Yy9fZlv0mjOfmY52MEUTFybIBQ192M7viyRU6q5BCbP6CCMFcbnRuFaGJG6LbJAPuuQpH3JPqTv2z4h2qd3Xuf
X-Gm-Message-State: AOJu0Yw2W6mvFYjfgKJVY1GeDxCOgK40htrj639Oaz1Lm1w9N1wk38uH
	JHFUt8Ge8E5cnUYVAz5n5m7xUn6KUa+qucC9aoGFp2vWsO54gVarLUbDw8vMi20=
X-Google-Smtp-Source: AGHT+IHTGPQhf3H6O7uDwt2LrjWYhTXQdcE9UvrgcJNxEE8My4b+onTtxcBz4scNfQjOEmaFcuPkPg==
X-Received: by 2002:a19:ee14:0:b0:513:39a0:1fec with SMTP id g20-20020a19ee14000000b0051339a01fecmr12178552lfb.66.1711005620894;
        Thu, 21 Mar 2024 00:20:20 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bg38-20020a05600c3ca600b004146e631a81sm3616918wmb.5.2024.03.21.00.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:20:20 -0700 (PDT)
Date: Thu, 21 Mar 2024 10:20:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v3] staging: rtl8712: Fix line length exceeding 100
 columns
Message-ID: <1f355628-87d0-4d54-a1ed-64da9da784c9@moroto.mountain>
References: <ZfvaZd92bnoZ9M1m@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfvaZd92bnoZ9M1m@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Thu, Mar 21, 2024 at 12:27:41PM +0530, Ayush Tiwari wrote:
> Split the argument list of the kthread_run function call across two
> lines to address the checkpatch warning "line length exceeds 100
> columns".
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> 
> ---
> 
> Changes in v3: fixed the issue in v2, created the patch against
> a clean staging tree.
> 
> Changes in v2: Fixed the alignment to address checkpatch.pl
> warning.

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


