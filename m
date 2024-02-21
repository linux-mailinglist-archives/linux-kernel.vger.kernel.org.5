Return-Path: <linux-kernel+bounces-74761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F292885D92C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AD01F2426D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9455E6F099;
	Wed, 21 Feb 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kp9CToK0"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418269DEE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521321; cv=none; b=r0ZKUpj6fVI3RuGcOSLVKokwzLLaO2LPK/iUD9gnYsQpcTZD4cfASukBGcLQYhvDuMPcDU4mb6dp82iTidarFu+HK6QNj0soYDEsBNi9aKb8tW/EmUZKtiDfUmwuytt1RFMtkB3+lHBdEsuq7B6t+5BSk3Swgn/NSkboluh0Cl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521321; c=relaxed/simple;
	bh=0oiU4XaRWDS6j4LBNifbui5q7io0SNO+FMU6eW1wzu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnMlE1UAQuZP3TG6Pa/1bq7OcoZdAkjxGxbgE9Pk1ecHiCybFKxqRCPiL1Njlzt0FoKnYqdw51dx/XciEqHoj+lwPtkMCBHUGbd9utMXkHQoKati04FRdYw7/uqynoo/JKLEOL/R9QbDhVH3mo1gTidFv6Rsh4jtGz/3oN17ZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kp9CToK0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3f4464c48dso68574866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708521317; x=1709126117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0sGkUIkt/bMIosWsZDLIe9J8o3jcEjfocOjlnpUT44=;
        b=kp9CToK09MUdy8shVSgbdvZketrpl6H5z+yXxzNlF4fU+npo/6FXidY6+uxQBYI56j
         zB3zLJdu52u/wfs5HETsF7EgQb6UdwVwFDcHU0JPAu7+f2vnQu8KvOlUbcMVr1kD1dBI
         /8zc0c8wXMAJxfr26JNG8WyshsMJfK/lWlYXE+Z26udP5OA5q/Z9IL5KHCPgNfqIs9wm
         YIBfTIjT8O2/VD6v9LeU5y3o1Eaq4m6uNCgx3FOJG2HRkaPswhf9kq4Sp/traXt/XadS
         roFk2TZPUpIo2YgBXwNnmy349TfTmy2WkCJxmZQyCYoRdkCQYKFxGwpZdykLRYwSI6UU
         kLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521317; x=1709126117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0sGkUIkt/bMIosWsZDLIe9J8o3jcEjfocOjlnpUT44=;
        b=uR+djqz3cLSQUhv+rE3GIrN7E3CVppZpPMLl5XT8aZwH8ndeL3RG/N7mQpo1U8q4mM
         gWxCkA4dzLG25ixK64+xgbrJIKOiXRQI+MA2PeFeoPcQqfT6M1icQ4VhTENI4uLLBf0p
         FEvHw3s8h7wpOq3aHI48ncknIQgCAEdTo+8vw286DOr8SIeohB+O27kpGXnjEBgJBSiw
         +cpq6JMMa9x/7MvBzCRtUmPInfwV7qvxt9iAN9FETOY7SIhxn60pXXb0iYDeacDYA8fC
         O5YymfpH/AUBN4LlRT1SC2kHoTOihav18GIQKpLbIsHS22b+ziPmvjwAayEFi373wQ+M
         q4RA==
X-Forwarded-Encrypted: i=1; AJvYcCWYnyPyqWThviS8ULuNKASZTqtdMHltYg4PDn5kvZHiqm9YWx1/mcmhApgvO0/yXRI6keksiy/hLtZr510P9IdlAA87qjx0WwLLrVT4
X-Gm-Message-State: AOJu0YyaemJuvnHLhBITlRC5QCLGB2+WA6v0+fHvatwbjyNip57bL15p
	R9JyTw4dYgso2W2ZoNb+y24sPgkh9rb2CuexYdOC+1oGFQdSp/8Mn0dg/sQgIpM=
X-Google-Smtp-Source: AGHT+IHGJ1FuMr+A7FNLQlz+4RrCrl8EAK9R3DgIA8ynv5GJFPGlAtMQsiBG++juajVubHNOCOssKA==
X-Received: by 2002:a17:906:185a:b0:a3d:994a:791d with SMTP id w26-20020a170906185a00b00a3d994a791dmr13864861eje.59.1708521317114;
        Wed, 21 Feb 2024 05:15:17 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id y2-20020a170906470200b00a3d0dd84276sm4941502ejq.184.2024.02.21.05.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:15:15 -0800 (PST)
Date: Wed, 21 Feb 2024 16:15:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ACPI: thermal_lib: Add missing checks for errors
 in return code ret
Message-ID: <4b78456b-071f-46c0-bb47-919b493cab79@moroto.mountain>
References: <20240221123936.3421462-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221123936.3421462-1-colin.i.king@gmail.com>

On Wed, Feb 21, 2024 at 12:39:36PM +0000, Colin Ian King wrote:
> Static analysis with clang scan build detected various return codes
> being assigned and not checked. The calls to the trip point functions
> probably should be error return checked as these can fail because
> of unlikely issues such as invalid ACPI object names or ACPI value
> evaluation failures.
> 
> Cleans up clang scan warnings, such as:
> drivers/acpi/thermal_lib.c:106:9: warning: 2nd function call argument
> is an uninitialized value [core.CallAndMessage]
>         return thermal_temp(ret, temp_decik, ret_temp);
> 
> 
> Fixes: 6908097aa5a7 ("ACPI: thermal_lib: Add functions returning temperature in deci-Kelvin")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> 
> Note: Not tested.
> 
> ---
>  drivers/acpi/thermal_lib.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/thermal_lib.c b/drivers/acpi/thermal_lib.c
> index 4e0519ca9739..4d27048ef075 100644
> --- a/drivers/acpi/thermal_lib.c
> +++ b/drivers/acpi/thermal_lib.c
> @@ -103,6 +103,9 @@ int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_tem
>  	int temp_decik;
>  	int ret = acpi_active_trip_temp(adev, id, &temp_decik);
>  
> +	if (ret)
> +		return ret;
> +
>  	return thermal_temp(ret, temp_decik, ret_temp);
                            ^^^
The "ret" variable is checked at the start of the thermal_temp()
function which means the code works the same before and after your
patch.

However, the static checker is correct that we are passing uninitialized
data to this function, it's just never used if "ret" is non-zero.

In this case, the rule is that if the function is parsed inline then
it's not a bug, but if it's not inline then it is a bug.  Technically,
passing uninitialized data to a function is undefined behavior in C but
Linus said that didn't really match with real life and that everyone
should recognize that inlines are different and update the tools
accordingly.  (Something like that, I don't have the email in front of
me).

The other thing to consider is that tools like MEMSan (?) will see
non-inline function calls and we're reading from uninitialized memory
and trigger a warning for that.

In this code, I suspect that thermal_temp() will be inlined so it's
probably a false positive in Clang.

regards,
dan carpenter


