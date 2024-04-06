Return-Path: <linux-kernel+bounces-133932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C0F89AB09
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD520282563
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DB3376E9;
	Sat,  6 Apr 2024 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOM9kjRm"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844AB374EB;
	Sat,  6 Apr 2024 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712409430; cv=none; b=iDY94o5Q3DHSS3SmBjMTn/aMFYmJM/tSeHF7TMno4GxhBK++DKKdd/PbyFkiixWoq/jDIz3TGyYkSR9siS09qlrcVzDgkWpcfzMmeYEa0g8T8OOWqZYGWbqQgjayqVNJLED5m7D8FJDsFQzZZ195c0Dnz7I0irArw29mHMV5Pxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712409430; c=relaxed/simple;
	bh=VJJCSOf/JvpxykJNws5kwPDmUfdpbC4X42YTE2K1AUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMcGPeJ5w8nm178ZKa2GylL3KNj5G1j4ZeBtK1Scrz4exuJC8Mw49HQNtfsuUAOSwHZBiHKq7l+IGHOyaMZUHWxTo/beSXAmRAgO1c0Vd+Zj4ilZfE6RoqE5CKAc0jRSjE8Rbcios3cmbAxBFf63upc4w9YPfxWv5z1BZ37MFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOM9kjRm; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a3095907ffso1186996a91.0;
        Sat, 06 Apr 2024 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712409428; x=1713014228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzKx5rEfU8Mn0ywULn1KY41VZeJws0/wMPTNdGwCnF4=;
        b=TOM9kjRm/lmt1lD5AucveB5G83IOwHByyD8XszdjuUg0WWOnffoSc1Qj16bTZLvRQQ
         bfQfphXoVa6FuoPY9fhoUFSF9DqXXA9J2RJ89oRuUylx/uXV7WKOg1bCKvszDtf08DFY
         jIusal6h2lQWtsMnjSb/GGU405nZmWNlfMs3rmhaS4je0E+0CltQoiycBHjJObf5qlfk
         LBV3R4E2G6PbA4CN4FLUq+T+BxZWbggWNpcPgvKe48H78n2nUqYULKQYAiT1KGRVjqvl
         FHCRLoBUrYPb99+KyANUsLTik9+jFEcyc3ml/mxJik3VDL1ZSUWUeIH5QTQo8fBypB/T
         0ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712409428; x=1713014228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzKx5rEfU8Mn0ywULn1KY41VZeJws0/wMPTNdGwCnF4=;
        b=v2hQFUyL1VlGO6tU5tSGs6xzO8G1wzK4UA15H5hQNtzgGkNmMOnCuV55a9+UjgeuOl
         GEVSbVLir/Ysp44J3aAwyIqUlWTuK3dUGuDK4+MvYv2ULuhUhzMsehPXoPSotBmtj/3E
         7H+0kJ5uAFIUhJfy1bikE/C+jS+BbX/ezKJCxqA4SYkvqp5+uTwwpH2auLUxZmsG+WJI
         9DCx44Vg/7KFKZwyByX3yo3PviepNVdS7Gf6T8kfScQT/dYIVDjH6ZR5x8Yx/ECd7xT2
         z/ulzX99tIrdA2inDzGSfU/Rz34EgOEDbnVEsmnpT1qBBanCFgqan4pna8V9z5KnJdUg
         i4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWvoBImOI1MG1IEkwm6YO+IduGGHiURhI8GhvgV0z+z0O/MKUH4RE2kjwzgkNZMiy/ZL0Vze8j7B1ZgOhg4xNzVrG3wEnNDjNkXH4Z32/r80Fn5BFhl1cdeWRFlNj+plC8wCk5H7FDGAhHxcDSO9f8M+pe49ZN6NCIccqq0lHXyYu7vLg==
X-Gm-Message-State: AOJu0Yw4zOgebtiOyN31mkvFgpSprwB0GRujmOCaKGxtl/rpCdE+Obbu
	wVVXJBWqg1QGPpCtFRfMkVShiUVN4pIymkZFE5I12biKby/SJM4q
X-Google-Smtp-Source: AGHT+IGtrbyINl2CLwezwEj0RKyyXObl5s3LgTlCnH0C8D9V33PuxQi7dGzGBDmI/RYzBthjjTgsTg==
X-Received: by 2002:a17:90a:72c4:b0:2a0:3a16:7489 with SMTP id l4-20020a17090a72c400b002a03a167489mr3200611pjk.44.1712409427904;
        Sat, 06 Apr 2024 06:17:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090a588100b002a29e717991sm4911802pji.22.2024.04.06.06.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 06:17:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 6 Apr 2024 06:17:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Jean Delvare <jdelvare@suse.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH 3/3] hwmon: (coretemp) Use a model-specific bitmask to
 read registers
Message-ID: <f4d18a63-c348-4882-897b-dc636feb149b@roeck-us.net>
References: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
 <20240406010416.4821-4-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406010416.4821-4-ricardo.neri-calderon@linux.intel.com>

On Fri, Apr 05, 2024 at 06:04:16PM -0700, Ricardo Neri wrote:
> The Intel Software Development manual defines states the temperature
> digital readout as the bits [22:16] of the IA32_[PACKAGE]_THERM_STATUS
> registers. In recent processor, however, the range is [23:16]. Use a
> model-specific bitmask to extract the temperature readout correctly.
> 
> Instead of re-implementing model checks, extract the correct bitmask
> using the intel_tcc library. Add an 'imply' weak reverse dependency on
> CONFIG_INTEL_TCC. This captures the dependency and lets user to unselect
> them if they are so inclined. In such case, the bitmask used for the
> digital readout is [22:16] as specified in the Intel Software Developer's
> manual.
> 
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org # v6.7+
> ---
>  drivers/hwmon/Kconfig    | 1 +
>  drivers/hwmon/coretemp.c | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 83945397b6eb..11d72b3009bf 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -847,6 +847,7 @@ config SENSORS_I5500
>  config SENSORS_CORETEMP
>  	tristate "Intel Core/Core2/Atom temperature sensor"
>  	depends on X86
> +	imply INTEL_TCC

I do not think it is appropriate to make a hardware monitoring driver
depend on the thermal subsystem.

NAK in the current form.

Guenter

