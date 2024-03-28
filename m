Return-Path: <linux-kernel+bounces-123343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5B08906E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDF81C31B32
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7052137934;
	Thu, 28 Mar 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rltSqJS0"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8813793D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645624; cv=none; b=krFw6eUsLxFt6x70yXX5sFT5x+iiLnn3UduUWPtoKBJl7y4OVIpaXDr0QrbU2e52vrBHIhVzPz+Od7zoneOvJkHOGMr8Gujo3u6GRjFNWmg3sEDfS32GkDHknSeg+7yzpdnIyxnS/LTxVJLicB9s0ZKxmh5UZ4DAgPzbCCUSNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645624; c=relaxed/simple;
	bh=S/rMmcnmpsGVrWPMgaxxFuJITwvJsDmZfZRoYbd7kJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYU2nRWn1q1dDRd9TAbOab86xtBNE+7dptKhO5qzSib1WxKaPOuQyCMgCOgDONPdxQixPImLuzFikIwZm9rPgP/cUZJBZRNifP/mQYGq3P7j3Bd299Kt8LT+EwvQMvdWislpi3L8YVmPVHnkKj9GEkbGLyN2q8sBh1TrSdR+ais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rltSqJS0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-341cf28dff6so854899f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711645621; x=1712250421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fXQkktLwKnjh/iLjR9yQ58intWukOcyLPotu7tuR3uI=;
        b=rltSqJS0CKu8H2rM1zPuh1vHdXXiJges6ozOVG3/OJecOsgXQR2TDX+jGFPiyLOUYG
         ohtMIDgaIkRSnvlv2G0Q8y7IAYjfe46XAlRkYz6hKZ4YcyqWaCoJHk61HIrzJOesp9Lj
         6CRttNElmYSr0aNsgANCt1nvNSVJP3iRb/mZuRLJEdvXHSr52JX52Tlkpjft4lugRR0x
         0LVBtqNN8OdIuHOzu1gUEqOvBtxYLdfXY3Akr65RRH+KPZMzTEP1YVXl/C/u/n80HmA1
         44kgGkhKYPYiPq8L6vJq1UOPMl9piHaFW6IufMaEFRdRQBwIqUC6iEfLKQvAJJI2Vbae
         XL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645621; x=1712250421;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXQkktLwKnjh/iLjR9yQ58intWukOcyLPotu7tuR3uI=;
        b=i0/EIBOrQVXa9VnH7vaSIqqlEyvKOW6x0Qgox4Py11pijAjesrXWVtnN5O24V6TM7q
         1R4U0O/IlZ4IyGc2dpNhH+o6SyKOxLxj26lIZRME9RaGWxUDs73DO1zaMA1H/6SSAyYB
         3fMqWpb9ZCrxnEvo0gxaneIsei9HqLl67bpo6x2L1U2tKxfnKPkSMmuEYIdFPzMjtMDu
         n+VKTWkK1tTybx9OOIHX9iosSOMg6gj3/o+rV9fmLeHSdkTXCmuYo06lVrs45W/th7Ix
         bLHsT+lxlWJ1Mzz3cvBjG/axRWYP76Iaih+PKKh4EHINcvA0ESXRjBaHSU5s31Jjx3WM
         K3vA==
X-Forwarded-Encrypted: i=1; AJvYcCU7RZAvakgCkp3tXrj3+Cy8z1uAKNl3NHHMBYPc+sbPIHdvhldFkTjW/cuxwU0ZINLzNiUqOZVfNTWHaxzqxj6729TMWYJ6Do3Vhuhb
X-Gm-Message-State: AOJu0Yw1nu2q3k+vQGloE5L6vJ7j+Ce12d5AydI4cn7624xEVcisid/i
	Aw5BjTiZa9Fz56xr5pYF32/DvAcfPjoWAblT4KJ8zhADMXxNP4oVigjKY+R7zho=
X-Google-Smtp-Source: AGHT+IFSWtJLxRRZrsyDz22Q8s/vm/VgEryUJzgbTw3fttmGr+830itvEDGfu5ORaeXEt5+psUXb2A==
X-Received: by 2002:a05:6000:50e:b0:33e:bfb8:732c with SMTP id a14-20020a056000050e00b0033ebfb8732cmr2225093wrf.64.1711645620763;
        Thu, 28 Mar 2024 10:07:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6212000000b0034181bea3b0sm2229735wru.3.2024.03.28.10.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 10:07:00 -0700 (PDT)
Message-ID: <c61e2120-1a74-4e64-a3e7-e712d33e97df@linaro.org>
Date: Thu, 28 Mar 2024 18:06:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] dt-bindings: media: imx258: Add alternate
 compatible strings
To: Luigi311 <personal@luigi311.com>, git@luigi311.com,
 linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com,
 mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, sakari.ailus@linux.intel.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-19-git@luigi311.com>
 <586bdcc9-793d-4cbe-9544-9012a665288e@linaro.org>
 <30d886be-cac8-400a-9b2f-dd2ce64b34d8@luigi311.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <30d886be-cac8-400a-9b2f-dd2ce64b34d8@luigi311.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 18:05, Luigi311 wrote:
> 
> Looks like it no longer complains when i run
> make dt_binding_check DT_SCHEMA_FILES=media/i2c/sony,imx258
> 
> with the following
> 
> properties:
>   compatible:
>     enum:
>       - sony,imx258
>       - sony,imx258-pdaf
> 
> If that looks good I can go ahead and include that in the v3
> 

Looks good, thanks.

Best regards,
Krzysztof


