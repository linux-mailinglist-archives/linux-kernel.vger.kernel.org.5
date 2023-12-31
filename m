Return-Path: <linux-kernel+bounces-13776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C71820C65
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 19:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245CCB21440
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0D89468;
	Sun, 31 Dec 2023 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJkbnM8A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434948F57;
	Sun, 31 Dec 2023 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso6477195a12.0;
        Sun, 31 Dec 2023 10:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704046625; x=1704651425; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BaDyQEIBzm0p+xKB0eysC12lFkzM+QQKnF8lz2Wv2jY=;
        b=NJkbnM8ASMW4SBBqJunNsq6Vmf0JplOAnS+668ppzwJMTIg3oNTVtTJ0f37teXSRbE
         oOGcUvjDI1yF56W9h/3J+kzUAxnImtgMtG5A34z/7sLpyaefarQ9ijtbXt9Quiu+ULi3
         Pv93hT5rcUq2CEb1Op5I949zzueSuKtmWoeP5pE8xksUdB3uDGhKkk2xAqO33AwiTLfI
         Lc9duHIZrnA0pIyYk1yd+sMPnOpVH9bL2kOS2AdEc9itwXxEN+2SRXmuo5h6I7par3jf
         MU4a1zxl8On2omhDUWUdiPsbSyqAedau0iOAExXd7/zuY0ayzRoFhvM8ws2q2AXPlKeO
         hfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704046625; x=1704651425;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BaDyQEIBzm0p+xKB0eysC12lFkzM+QQKnF8lz2Wv2jY=;
        b=FjuMdNE1derYkloNXGnBH6cOZ0fiGkjyloLIwKgKenG2wwqfO5ZcuC3p+0kWMM4EtX
         k4oDEc0aMj/hRdsieNeI6oAy3UIdBGF41D3DT4pIn0a6xfNsqeLFwTglNgK6AkpnYR7e
         uZSFaOV8vCCWZ+vvCRqwkU9lu3yCkDCKsejMa6273iWGzX6B4E9JlS94rWmLTQhhVxhT
         Z7xow1BI3Z9Avp78+IwX5ARe3SJrUN4aJtKRSCdRTrI6aa2+roRoQx5lMcGdCWAoVCva
         fAKPnS7c09jC43cDXPur6GlcilOG0UKJr7KUsTXIbojZdpaEjqvOMAOVAghkNlcl2TZk
         4YDQ==
X-Gm-Message-State: AOJu0YwV1Ax1hybn1BWB/rO8Cy8nFO+TLv/Dy3iSO8d+TlPJmpAKDehl
	ZWx8VkyJAoMJS1B/rlK4VB0=
X-Google-Smtp-Source: AGHT+IGlfkh8oALkfVhlt2WQE2M82WH6H65rtax5D8VBR4d5wReLnkC0jW1XbY3HaHOnd9vOe1EfAw==
X-Received: by 2002:a05:6a20:13cd:b0:190:5b7f:a1d with SMTP id ho13-20020a056a2013cd00b001905b7f0a1dmr15093370pzc.43.1704046625405;
        Sun, 31 Dec 2023 10:17:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j22-20020a62e916000000b006d97cc5cc13sm17326604pfh.8.2023.12.31.10.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 10:17:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Dec 2023 10:17:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: (lm75) Add AMS AS6200 temperature sensor
Message-ID: <ca786cac-aa83-4795-8b91-ee85b07bdcfa@roeck-us.net>
References: <17ba2dfdb3d25bf1b5b4ed9f858b6e28902bedbe.1703127334.git.alkuor@gmail.com>
 <d1686678991bf8ee0d00cb08ca046798f37ca4b3.1703127334.git.alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1686678991bf8ee0d00cb08ca046798f37ca4b3.1703127334.git.alkuor@gmail.com>

On Sat, Dec 23, 2023 at 11:21:59AM -0500, Abdel Alkuor wrote:
> as6200 is a temperature sensor with 0.0625°C resolution and a
> range between -40°C to 125°C.
> 
> By default, the driver configures as6200 as following:
> - Converstion rate: 8 Hz
> - Conversion mode: continuous
> - Consecutive fault counts: 4 samples
> - Alert state: high polarity
> - Alert mode: comparator mode
> 
> Interrupt is supported for the alert pin.
> 
> Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>

Applied. Side note below.

> +    Datasheet: Publicly available at the AMS website
> +
> +               https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf

Apparently checkpatch doesn't like this way of pointing to a datasheet anymore
and reacts with a warning, demanding the use of Link: or similar.
I don't think this is appropriate, so I guess we see the first instance of
to-be-ignored checkpatch warnings ins the hwmon subsystem.

Guenter

