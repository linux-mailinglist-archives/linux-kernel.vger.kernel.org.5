Return-Path: <linux-kernel+bounces-60910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F8E850AE4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8816B21772
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152345A4FF;
	Sun, 11 Feb 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dka6fa6d"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7B43AA0
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707677670; cv=none; b=Bm5pl4u2zMfSHJXIOW/1jzBLC5ySpK686fjz/bhlBNQEoim7oXUcFGWRdnsH89f1HZu3SqXn3yTY7a2WTuROweicoXmBxobbKhYMh51dh7TvFj13Uww5Z/Dv5d00Hx83kiRWz7TkU5uY7Dw7Xuvwu6rnWEtkokkoaed2XCIxvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707677670; c=relaxed/simple;
	bh=n5of2Qo8ttrUmqC2zHB+ErZs5AOiNXviNw8Hh7Y+SfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFz1FoiX4mMWKxqnQgDB1fU6n9RwhpmJE0UKwBwHJYmemL8KzwAL0HTeh7vv0tA6Mtqy0Pf8phT/pD4VUthhR1lCMMlII7v2USZS7kwAosazlcrkMMCAkN34yyZHiUg/odkGlbb6HYrLoFjwm5XpRWVqZxzQEiPi8PYvK1pLUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dka6fa6d; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso2156648a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 10:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707677668; x=1708282468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENCnaf1G7GCn1EGMDIKPk2diBnyUlqfm8U6hO3agBiM=;
        b=dka6fa6dcBYq9jhqhWWlLRVZ44PxRRNHsnUzxpPSP0tdIgnci64wK7BeztUc9DfM5C
         xgnuoAYCRo/qsLil36UfWJNu6DbP02Ksgr5uRFg7NQEwnCBnViJqz/V07j1aNdz1zPEs
         0opNGRfspAHcj2ZUQs1PhWcxcnnHzxlPfiHuNZ9uVNyuBF3fYTbn0YjRT0nh889bD4M0
         Rc9su9fKkr3VfPHeV/kzuwSGXo5vohjM94WL1iu9sfdVeugK1PQNCww4UBA7eFzGrPK1
         X+3zoMMgI7vZ3a8sxQi2hTvprJPr2zUlAHbPXKd/sRF63wHGC007Ig5JEoFA5ikmACY9
         5xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707677668; x=1708282468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENCnaf1G7GCn1EGMDIKPk2diBnyUlqfm8U6hO3agBiM=;
        b=S+M9oM6OS2jlPMITWE/ien4+1/fv94Sa2YAg6Dp3+4nThqC7U+l6ww8eB0H4UwjRXu
         jpjt1EJJpAQHzGynUQl0/n+nrrmn5JT2h6vV+25/wjufwB4vliEvQhR6viQhePj0veGc
         59iXtRMt7RwBEY0dNN/hPXt3B1E22Leyj1Zimh3oUMMTNTYtXL5neeLMeUR4IJlbrUJf
         L6hhn0NaF/rQbl2EWehMVJrrAlrLNoJCb/c02RzYKSnTWeFR9PvzGo5AMt/SmI8ND/98
         MxKLXUj1MDtxrH6i1neoJxHsM8zcCpJ0LkYrjqJ1Sueqp79gxqQKC3+cXWQUOxbjcrvY
         zI6Q==
X-Gm-Message-State: AOJu0YzkG5jT9iZXB9lBZ+xhV6OQKnk/CMP1bIz82zpBUKZ18WhNXo+1
	fNwDYQo8FamWhxloNTfSlaX3oc7YRwbXvTFlAvFaBODxQmVTVYYe3/ybWAxA
X-Google-Smtp-Source: AGHT+IGVkYKS/2nXrvZ90mYdqPEEEvMRGfWK+qCrzx40/p3E5eyZwAdT10/hmL9Ns63hp2t/Hs5DAA==
X-Received: by 2002:a05:6a00:1d1c:b0:6e0:520d:2ff4 with SMTP id a28-20020a056a001d1c00b006e0520d2ff4mr4659229pfx.30.1707677667802;
        Sun, 11 Feb 2024 10:54:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a21-20020a056a000c9500b006e03927d123sm4055939pfv.202.2024.02.11.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 10:54:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 11 Feb 2024 10:54:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] regmap: kunit: Ensure that changed bytes are actually
 different
Message-ID: <d1136c07-191e-443f-b462-c18ee2c217e3@roeck-us.net>
References: <20240211-regmap-kunit-random-change-v3-1-e387a9ea4468@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211-regmap-kunit-random-change-v3-1-e387a9ea4468@kernel.org>

On Sun, Feb 11, 2024 at 04:58:17PM +0000, Mark Brown wrote:
> During the cache sync test we verify that values we expect to have been
> written only to the cache do not appear in the hardware. This works most
> of the time but since we randomly generate both the original and new values
> there is a low probability that these values may actually be the same.
> Wrap get_random_bytes() to ensure that the values are different, there
> are other tests which should have similar verification that we actually
> changed something.
> 
> While we're at it refactor the test to use three changed values rather
> than attempting to use one of them twice, that just complicates checking
> that our new values are actually new.
> 
> We use random generation to try to avoid data dependencies in the tests.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

Minor comment below.

> +
> +	/*
> +	 * The value written via _write() was translated by the core,
> +	 * translate the original copy for comparison purposes.
> +	 */
> +	if (config.val_format_endian == REGMAP_ENDIAN_BIG)
> +		val[2] = cpu_to_be16(val[2]);
> +	else
> +		val[2] = cpu_to_le16(val[2]);
>  	
>  	/* The values should not appear in the "hardware" */
> -	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[2], val, sizeof(val));
> -	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[6], val, sizeof(u16));
> +	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[2], &val[0], sizeof(val));

I kept those two checks separate on purpose because a non-equal check
will "succeed" if a single byte is different. That means the above check
will "pass" if one of regmap_raw_write() or regmap_write() works but
the other is broken.

Thanks,
Guenter

