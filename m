Return-Path: <linux-kernel+bounces-35131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D22838C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D09289AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AF65C91C;
	Tue, 23 Jan 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkBLj+kB"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55A5C911;
	Tue, 23 Jan 2024 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007121; cv=none; b=iOWcRu1O/dsingUTBetMUL2lgLkaRtBr4rlAOju50Uv9HHG87jZdkYKxjtyW0bHV/Z4MiFPSsNH/UFSkUNxqg9VWbHL1xDSr7fhMpd63psAxJ5PYNe5VVeh8yR0p6g58o8353+RtRd3vqPVFgatydcR9hng1ttbWVgFRjmPOMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007121; c=relaxed/simple;
	bh=neKUPJ34JPy3WiBec0A1u178rccXG3QqsJ1piL0qHZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dn864nWI78OF8OECUnHZHGOkVpzmSdAx22Pcv6k1VCg20th6KavSVPPdwMxnKiGU1fRtUsrILAhznW2FiKJeVvkuuVfCq3KD9K9h+yMGZ690Ci9bKYH41vUHe7V3qhX/GhWlRtxonaLRCGDZrTaa/pAY+5HfDOJbm32pDTS39CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkBLj+kB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e7b273352so4201334e87.1;
        Tue, 23 Jan 2024 02:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706007118; x=1706611918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFZafMtSv0/elpLnpQZUohigcJRvEy0uJqyVJh/DR7w=;
        b=MkBLj+kBXvhb2nHxBbeDz5U7NiJygFdeAIhTf9UpCGPu7yY1Pav1PtB3kYMwtYHT4E
         9Gu2AJdmPgO+d/ciVvSGdzbJgjb+GwvYuk+MIEg/NJ417PrZRfq1vcI/4qjeiNyaCYYj
         MaXHvKsjj+cZO1vEQjzQJTfpFfu+aQq3JETS0Ucx8Q3UAn6S4srrHlFfW3xez81PmM52
         HNIeL6fT0BREXcOnXwwUiTjjFARKs+4MGog2vhjOSvXzHWJPuiDYBClMRyuCRT0fNsdu
         MBDsqzUexItL9YmytTNha6VXJ77j7N5lOk6+6ZoiwQlvS640mrm94F+agES1out6qQej
         ziuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706007118; x=1706611918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFZafMtSv0/elpLnpQZUohigcJRvEy0uJqyVJh/DR7w=;
        b=VUawf0pSnw2LBbGvPLbOz1d48S1X4lC+GjuH+8KPUQSLTCGhMtzYQxMsvue4mqwaHL
         MfN5wQF+Poqo/DIZNkNmsJEvBWGwpFBp7d8nG6473AcAer4lbz6p/zu/Lf6PoTLiAViQ
         BoMMTN2cHmj8V+ulFBXQY7MaSHc161HMMMurkgLa5zLSsUOI9H6wPfJrSpYO9k3iGA/2
         ePmjPwBq5cT+syXhWmT7DQtWaZEiha5qUJyyWJRmM7LdVYepxTz3ILSOlQhSU1VE+Unt
         IkqiWMK2nz3MX18foyl3DqxxAqZNKvFXFRSTxgR9Qqtv+CKlLjUowJ5JrU6o3CVPj8AW
         vCeQ==
X-Gm-Message-State: AOJu0YzHX8gXoZevnFNs38cwC9fCkxLtecZvvp8EKXNl+gs6r7l2A43y
	WLQFD78T/lZzs37o9g2kByUJpqH+5Geo/p0iYMVY6sR9wBYzlSZk
X-Google-Smtp-Source: AGHT+IGYivB1VmQP/KfsanGEc49Hzh3FOSa/vEFybMaVlw3HPoL8B48MAJ0ilgDENLijEJ7bwy/NiA==
X-Received: by 2002:ac2:485b:0:b0:510:6cc:18bf with SMTP id 27-20020ac2485b000000b0051006cc18bfmr406683lfy.7.1706007117783;
        Tue, 23 Jan 2024 02:51:57 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:b1db:193d:1c75:4008? (2a02-8389-41cf-e200-b1db-193d-1c75-4008.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b1db:193d:1c75:4008])
        by smtp.gmail.com with ESMTPSA id cn7-20020a0564020ca700b0055c349e04f8sm2385567edb.36.2024.01.23.02.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 02:51:57 -0800 (PST)
Message-ID: <0bd3319f-7d63-485b-9b44-d6858c045b37@gmail.com>
Date: Tue, 23 Jan 2024 11:51:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "iio: add modifiers for A and B ultraviolet light"
To: Paul Cercueil <paul@crapouillou.net>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123104305.10881-1-paul@crapouillou.net>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240123104305.10881-1-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.01.24 11:43, Paul Cercueil wrote:
> This reverts
> b89710bd215e ("iio: add modifiers for A and B ultraviolet light")
> 
> Enum iio_modifer is *ABI*, you can't just decide to change all the
> values from one version to another, otherwise you break userspace.
> The new entries should have been added to the end of the enum.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 ++-----
>  drivers/iio/industrialio-core.c         | 2 --
>  include/uapi/linux/iio/types.h          | 2 --
>  tools/iio/iio_event_monitor.c           | 2 --
>  4 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2e6d5ebfd3c7..7937bb4a4a68 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1587,8 +1587,6 @@ What:		/sys/.../iio:deviceX/in_intensityY_raw
>  What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
>  What:		/sys/.../iio:deviceX/in_intensityY_both_raw
>  What:		/sys/.../iio:deviceX/in_intensityY_uv_raw
> -What:		/sys/.../iio:deviceX/in_intensityY_uva_raw
> -What:		/sys/.../iio:deviceX/in_intensityY_uvb_raw
>  What:		/sys/.../iio:deviceX/in_intensityY_duv_raw
>  KernelVersion:	3.4
>  Contact:	linux-iio@vger.kernel.org
> @@ -1597,9 +1595,8 @@ Description:
>  		that measurements contain visible and infrared light
>  		components or just infrared light, respectively. Modifier
>  		uv indicates that measurements contain ultraviolet light
> -		components. Modifiers uva, uvb and duv indicate that
> -		measurements contain A, B or deep (C) ultraviolet light
> -		components respectively.
> +		components. Modifier duv indicates that measurements
> +		contain deep ultraviolet light components.
>  
>  What:		/sys/.../iio:deviceX/in_uvindex_input
>  KernelVersion:	4.6
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 9a85752124dd..bce09d325142 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -117,8 +117,6 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_LIGHT_GREEN] = "green",
>  	[IIO_MOD_LIGHT_BLUE] = "blue",
>  	[IIO_MOD_LIGHT_UV] = "uv",
> -	[IIO_MOD_LIGHT_UVA] = "uva",
> -	[IIO_MOD_LIGHT_UVB] = "uvb",
>  	[IIO_MOD_LIGHT_DUV] = "duv",
>  	[IIO_MOD_QUATERNION] = "quaternion",
>  	[IIO_MOD_TEMP_AMBIENT] = "ambient",
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 5060963707b1..9c2ffdcd6623 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -91,8 +91,6 @@ enum iio_modifier {
>  	IIO_MOD_CO2,
>  	IIO_MOD_VOC,
>  	IIO_MOD_LIGHT_UV,
> -	IIO_MOD_LIGHT_UVA,
> -	IIO_MOD_LIGHT_UVB,
>  	IIO_MOD_LIGHT_DUV,
>  	IIO_MOD_PM1,
>  	IIO_MOD_PM2P5,
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 8073c9e4fe46..2eaaa7123b04 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -105,8 +105,6 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_LIGHT_GREEN] = "green",
>  	[IIO_MOD_LIGHT_BLUE] = "blue",
>  	[IIO_MOD_LIGHT_UV] = "uv",
> -	[IIO_MOD_LIGHT_UVA] = "uva",
> -	[IIO_MOD_LIGHT_UVB] = "uvb",
>  	[IIO_MOD_LIGHT_DUV] = "duv",
>  	[IIO_MOD_QUATERNION] = "quaternion",
>  	[IIO_MOD_TEMP_AMBIENT] = "ambient",
Oops, sorry about that. You are right, I will send a new patch with the
new elements at the end of the enum. This patch should be applied to get
things right again, though.

Thanks and best regards,
Javier Carrasco

