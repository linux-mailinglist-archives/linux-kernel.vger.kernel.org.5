Return-Path: <linux-kernel+bounces-166428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA0F8B9A86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CAC1C21BC8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3F077F2D;
	Thu,  2 May 2024 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INJmBKwm"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDE4604B3;
	Thu,  2 May 2024 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651985; cv=none; b=An72DeOdrWIYbsucaG8OXcmwOa3X84q0XHZl74cI+Js+gbF1Wkc0LnQywgV5yf4/V8eT6vfUJLKUi7RrqlxH6bw+MGy7RnisjqvScKO3xsVknPXT05aMmmzV3LhD8qtD0YcZDm1sDsYBfBAG6ADaUTHpX7GUsg2BpQ5NcCckCvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651985; c=relaxed/simple;
	bh=Mqkrhza3t8I1NNmuInmaoNH7fQpysGQRs0CN3Xq6QZk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6kXAUEm0onkBzxryCGOjr7hsEqr0pR+YJwtSFdRK9rOmDUzzMepVZ5MAVk0TbTcjlnc3Me6m72DwCVRlkgpbeErsS0v//W87dnJgJG7+tiIqmIQuvf8pCfktUnf6m4SdF4MBjmpVr/FR+KRfSypdY/Xcs22MIPtuWUesbO5BL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INJmBKwm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41bab13ca4eso40701675e9.1;
        Thu, 02 May 2024 05:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714651982; x=1715256782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uNtgswtzTBIO+kOiOB63IQ6L3ruI+H9mtsGm2wznV5E=;
        b=INJmBKwmMduZL5JOWMqNHuHGYVT5z3E+4xo8436KgaK5aWBsk5vVwIbLF4Sj1B+n/N
         Rc6NgUdhF4X71VQdp0YgIvgui/YDA7rwz2+rTjY/07F9VwBQsLKFLZxSfqTFxk7VToKI
         gajeEgWeMJBcP2/Im/TCP4sAFrz0Ecq7w2u3lfGcfEh7kYjBgSYcpSoajONqNw6N9soo
         Kou3ThcdbgVs2KmSNxhBrU4wPJ8NB/vy6+6OHTSE3saC1ra08V/9dN/c02h846Qyeglj
         qciMRSmvP94T4kZ3a3ZvPA3qQIrdf10Nz05cPNC0N9/NrEazgJjXi+TT2qVneU8CjtYZ
         hIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714651982; x=1715256782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNtgswtzTBIO+kOiOB63IQ6L3ruI+H9mtsGm2wznV5E=;
        b=TIbiFFmB0XtrsFpvIxna7Z6yWI2FDT1Qm/3HNgos/wxqI2VcutFEjjnfFdq5WO2hb9
         m9K5bwp6RntqfALScbwUQUqf5+PRQhKli6nNCpCQKjwLWT489VF/4RSLEsiRRs4bG4Um
         lbvBY90PgJWDgX677ez13zp3jN/vNvUNks4WTi2jLVGpMxmmP/v0H5o137uzBq6o59ew
         /Cix8T1kWVA8ms8nY34gSPpYfdxtuder13+YMbgS6M4c6I/F6gHmqFG9P4KtUo/n/Ueg
         4wknC0ZQ95Iy8G0TVYyBDue6fbKVAsiWLa2cZQSyqatz5H4Gebn7gYJQ1yYEgkiyVwbd
         DnXA==
X-Forwarded-Encrypted: i=1; AJvYcCWQbtyp5kPB9SwYGWPmsSuje6LRRp1O3IjPAKMWTW6oUVL+2Ut1ScdBLNLKeu1D2QUcWWOelfaCUM6FxLKEOkusJBbgOI63IHaTCEDEvuS9m3gsJ0t3/LhehuDJYay0QQ/T3z51Y6qjmy1fuDrzMUneJK42NwfVq7ZcfHtjk89+srwI7yVG
X-Gm-Message-State: AOJu0YwAGxIppurV4XC5c2kSQxblyQgJSMp2c3jiapq+2I34SyD1dy0y
	LgqE+CS9rnDcB5LJb3R+tDPbpRPXku+o3kL0x+Aim0as7y4eHAlm
X-Google-Smtp-Source: AGHT+IEu1hDh6wrO8MNZ87VL1UC1AHkRHlnMqdwwjboZKadDjNQWMLRJH4xNE7l8YroPc/XByFaI/A==
X-Received: by 2002:a05:600c:1392:b0:41b:f116:87e0 with SMTP id u18-20020a05600c139200b0041bf11687e0mr3932012wmf.29.1714651981731;
        Thu, 02 May 2024 05:13:01 -0700 (PDT)
Received: from localhost ([217.151.144.138])
        by smtp.gmail.com with ESMTPSA id s20-20020adfa294000000b0034e285d818dsm1136638wra.32.2024.05.02.05.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 05:13:01 -0700 (PDT)
From: Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver.graute@kococonnector.com>
Date: Thu, 2 May 2024 10:42:17 +0200
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, o.rempel@pengutronix.de,
	u.kleine-koenig@pengutronix.de, hdegoede@redhat.com,
	ye.xingchen@zte.com.cn, p.puschmann@pironex.com,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
	felix@kaechele.ca
Subject: Re: [PATCH v3 2/2] Input: edt-ft5x06 - add ft5426
Message-ID: <ZjNR6eny4lt4tLIJ@graute-think>
References: <20240501204758.758537-1-andreas@kemnade.info>
 <20240501204758.758537-3-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501204758.758537-3-andreas@kemnade.info>

On 01/05/24, Andreas Kemnade wrote:
> As ft5426 seems to be compatible with this driver, add it.
> Debug output during identification: Model "generic ft5x06 (79)", Rev. "
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 2a1db11344766..028ec66faa193 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1486,6 +1486,7 @@ static const struct of_device_id edt_ft5x06_of_match[] = {
>  	{ .compatible = "edt,edt-ft5406", .data = &edt_ft5x06_data },
>  	{ .compatible = "edt,edt-ft5506", .data = &edt_ft5506_data },
>  	{ .compatible = "evervision,ev-ft5726", .data = &edt_ft5506_data },
> +	{ .compatible = "focaltech,ft5426", .data = &edt_ft5506_data },
>  	/* Note focaltech vendor prefix for compatibility with ft6236.c */
>  	{ .compatible = "focaltech,ft6236", .data = &edt_ft6236_data },
>  	{ /* sentinel */ }
> -- 
> 2.39.2

Reviewed-by: Oliver Graute <oliver.graute@kococonnector.com>

