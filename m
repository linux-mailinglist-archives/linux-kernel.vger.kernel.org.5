Return-Path: <linux-kernel+bounces-64327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A63B0853D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98231C2702D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5EC62A17;
	Tue, 13 Feb 2024 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItoZzt0U"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76362A02;
	Tue, 13 Feb 2024 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859297; cv=none; b=S2RdPVTj0rHyCPPOCkYwSUvhym6QFNEAnLfgV8IUJFGM+4RzrFHtalgqf9a0N24z9C+22BNyDWgVebovZr+u63Dwbapa+SIYvSClCiQFwK39h25AB1sXpgWM7BQGfjCmwgr6Kr9APz/9zB5qJ8KTEkxLCEozLWow1ARnUCRBdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859297; c=relaxed/simple;
	bh=EgadWgVM7l3Yx0UTg9aDJrNq0U9PSlb6sOu5Wiu2Jlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOVp9Y1TW1pP6yZIbpTcLL6bdvZ6H1ovGjRCqh7GZdoKg5tCKfkUvvhi4GL4PQDzitNnw9A4Otty2Faf12hMunshe5Dt7kE8qqTMj+H03bIOaf1kQN6aVLvZIIEY2kcq3LdspEni919AwEmmX9Axowm6hRVsa9gqKcnTV++QRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItoZzt0U; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5114c05806eso7830126e87.1;
        Tue, 13 Feb 2024 13:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707859293; x=1708464093; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uunHV2kuzJlVZf98Idg9yHivF9Hc4C9Du40eWv37yD8=;
        b=ItoZzt0URO0JwfezS69v6xObWINKMEcFiUosChdhPzEpKMN7LI99Po42hI/VaBzQPp
         0PeiFG7fGKcvzGgvqhi9YLebw1uH1tuMYtU/Yi38SNFfDoGeHlTOqM43TwlvdKAzSr2B
         vpJ0Kc8S2OitvatgsLggeGHftB//E+Z1Z/0MOzf5ITmrbnqb1urgckYcfc12ifxW64k8
         f77q4U8l2fpWbE/6NQ7Sci5yLAT/eq4TOdv50zfTzqCpl2561/MUlwEVSqvB5rSpM1BD
         3SsuHWU/mLKV1e8VCZczOLUjxQO+MLYg4B1qESlhrMqXR2J+CRkhUDl29CI0+8ih4kD2
         6dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707859293; x=1708464093;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uunHV2kuzJlVZf98Idg9yHivF9Hc4C9Du40eWv37yD8=;
        b=ONRxlYY/Nn6S09zwbLAp0yP90mpIl1jeSSvI25UNC0t7WizW2HSbNhhl5tch4zmRRB
         4W/1x13t7zwaSgGrWJ4y2rA5kvdkK4z6Bzbh9nipd0EVaj2l91b+yda5XEM3jqUx5zMq
         t1Nu5g5xkO0ufQdDzDGCRqJoxJ/IT8Pz1eY/EP3WQjz9Of0MD4z2yICeGWxaFYGQhBQj
         t4u8vrd9NxaGqdQ9GE4TZsToA6zST/LAMAMIiu6O0RGpknVwLVDMUZuMiFAi/v3dyQlx
         euzye9buAAfx2SJNViavI76KPfV3sqxRSNl1NoDtvfoeMsWvmODzmL7bggkj5YWhfxhH
         /HJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeaqtWlyIqKcSvWiMndsHFNmoI16dUAWefnQD78eeIaAWFBITbud3/xNnhziZavNwj+Y9S4kAKwNXB0EBuem94M7HQgLL+2zcMjPDpcr8Vlsr4aBS3cmB3RpSy3sI8bNMhtIRVBcW7BwgJStD2BHNmWpHUnRTR1/MaswRy6e8IHMeBmw==
X-Gm-Message-State: AOJu0Yw0V9V9OHsI/xOtJrQnd1nERSMCTqMtchkPBui0GxbTL7APsM2q
	D+n6soK8TVqiAPxIMX+zonOWIO6wifle8FnNCfQKmDWjBnp5I5nw
X-Google-Smtp-Source: AGHT+IHJfwf2LvJ0GHILLonTQ9VnmO/eDPOFrKz+HE4cvtW24vVZRyW15A2iSbA+lVB/lNTt50XgrA==
X-Received: by 2002:a05:6512:480c:b0:511:6ec8:9b30 with SMTP id eo12-20020a056512480c00b005116ec89b30mr460285lfb.50.1707859293182;
        Tue, 13 Feb 2024 13:21:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVg6HUzOvBTkF/Sfmc8dtfzLhMmrYqG9BawULxz5QZc1jlF3NQvoDR/nLjqY0eXaMMy0xxZQH4WT4sX55Ck7YeUaNX6c2vNq8fu45TUr95L8xy+OI+I59ephH/pUCG6jSiJdGmB4JAWuCMwOg1CS/LMpSozyXMQUF8igzLQQ7Qf+1aCvB9X0eaaG2kEeYXfAZ3B5Phx5M812q9RDLxBbu9TV3TT0aeqPXv+TQ9yufkasliBl1ZYhh6A//0RIlHcnTNhzJZeRrH5kDE71uWE8RCavmHyQbYDXeGNRcrPhqGSCrbyeriMd770T4na6gh0LLBT7pxv9MPw/uY17nCErcJP01evngAHyQallWBM7L81jblyJTrvbuyb
Received: from localhost ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
        by smtp.gmail.com with ESMTPSA id g25-20020ac25399000000b0051186594564sm1181615lfh.174.2024.02.13.13.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:21:32 -0800 (PST)
Date: Wed, 14 Feb 2024 00:21:31 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
	Dalton Durst <dalton@ubports.com>, Shoji Keita <awaittrot@shjk.jp>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <ZcvdW3SvgIuhJtKX@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
	Dalton Durst <dalton@ubports.com>, Shoji Keita <awaittrot@shjk.jp>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240212175410.3101973-1-megi@xff.cz>
 <20240212175410.3101973-4-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212175410.3101973-4-megi@xff.cz>

Hi Ondřej,

thank you for submitting the driver.

On 24-02-12 18:53, Ondřej Jirman wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> AF8133J is a simple I2C-connected magnetometer, without interrupts.
> 
> Add a simple IIO driver for it.
> 
> Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Dalton Durst <dalton@ubports.com>
> Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>  drivers/iio/magnetometer/Kconfig   |  12 +
>  drivers/iio/magnetometer/Makefile  |   1 +
>  drivers/iio/magnetometer/af8133j.c | 528 +++++++++++++++++++++++++++++
>  3 files changed, 541 insertions(+)
>  create mode 100644 drivers/iio/magnetometer/af8133j.c
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 38532d840f2a..cd2917d71904 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -6,6 +6,18 @@
>  

Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

I've successfully tested driver from v2 on 6.8-rc3.

-- 
Best regards,
Andrey Skvortsov

