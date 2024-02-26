Return-Path: <linux-kernel+bounces-81256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD368672C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BDA284702
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBFF1D531;
	Mon, 26 Feb 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XnSjorZx"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3861CFA9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708946109; cv=none; b=jp3vgb/eqlojaaxFVUw5rAKgiKONz+sew+UMXqOSTnzipLCkW/3qBonZkG+D19JtJua+VzMgs7Ew2iLA2rrdKc9SeUgGuQO3WGgbolLSIlpVOlBHGKEFqDL+y7+PuxwgqpLJw1YEudgN+/ilKTu4Oe17yBvMoFG7FsbDl0WLrlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708946109; c=relaxed/simple;
	bh=e7sUo5PM0icbMQjDNxn1MNfOtLT/dzaKORRyoAnKynU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvrYjq4KDvnBYZBQxAUBUVCWVOTylgQMdBh37THHcRstLU5LFxoHzNY4Ky45hkhipnut3eH8sGpowToD9cFVxNBFlJaq3ZofXn0xRId05SQNXC9ferVs3mE6qY1EDTQK0AAX3dQKmWjSncz1Yb6HAfHl8+CGaPSaG6cz8OcrV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XnSjorZx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412a8d9402eso1167325e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708946106; x=1709550906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Px1KTQ85Y2nPIxC9kHHbSuRe1ilouCzdaJwzdUj/bOQ=;
        b=XnSjorZx+W82YZ7d6+uRbPPlKLzVfHnxxGh3wuq8kYIcufBU6cfSJpEM8FY8JRyuGi
         BRy0grr4YeQrUANRWg198Otn7gdxhozyUUvJ9+YnGVdn1FDei2oQXpgpBvKxW4V6cakF
         pZJABd5k3TkMjA/Q+RNvHll2pLXlRBSm5IiMO40PuvPYVVjfgQUIEcgEHr5QASYT6pXx
         gBhggy0NmecMQPWbIUkBE7eOQu0uONQzSjPZQ+WrbDy/LBIGAcSj9zYLT1i7P5uDqtYt
         whu/K3bo1DQ4Kci7TtKzRevbJbyZ0cCpDkJfN+o+USwpPNsbLlRCce9uZ2AwNb2SQUiD
         k3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708946106; x=1709550906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Px1KTQ85Y2nPIxC9kHHbSuRe1ilouCzdaJwzdUj/bOQ=;
        b=SI67s4finrmnNz6TWsKX3HMenAeJZF5J/wssn5FEwf7A/oSaVMXAg3WCKPZmYrj1iv
         okqQfpdEDJxsqDAeEqu8+0rVKutFBuLQxXY/DKnyJOIw8ziDvSFazrXuZfj4jvFfKHKm
         TUDc66r+FXjqRWz0kGM1FBGvqxsRXmx1LHI+olg+wC+O7vYKx1HgMnEh672RpWVSZ8zU
         jNVjV3spfr52UYUc6RsTXMgGBFh1xu45Ed9cjR2hpyHKHapxLCkbn7U06m/hdiEQ3/2c
         dn0kC9hwjjtMLpJ5YdwVrMuVUsLEhc3Jo6F+O8XOQ3cEdTRFesbpWiLAeFyK1hGb4CJU
         KJfg==
X-Forwarded-Encrypted: i=1; AJvYcCWxbxuka6u5SqTA98o/wMfZYLqE0IujYs8J2Z2ifiCQfEqp9GHMSoLOgV6bVNFC7prsvYfunNvU/RfOlBpAczMndIIBUuRyh7ynjluT
X-Gm-Message-State: AOJu0Yw4Qr1n3irvkc+nGMeuHUBucExsFFuWJFrIiwBU+2dwA9/Qh0b5
	/eFbCoLStSL5F+/ls2TBVYzXjneLXxpXRAuYDNGzOOwbBvrnuF3o187xeesCKgc=
X-Google-Smtp-Source: AGHT+IELMecq+M8n1n9kPpnybwIle6Z82w3bd1zGd7ECsJKlyzFs5xPocXIeBDpdG7puQ4OQmrWflw==
X-Received: by 2002:adf:f303:0:b0:33d:c0c3:fe0a with SMTP id i3-20020adff303000000b0033dc0c3fe0amr5170178wro.0.1708946105822;
        Mon, 26 Feb 2024 03:15:05 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c029a00b004128e903b2csm11584411wmk.39.2024.02.26.03.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 03:15:05 -0800 (PST)
Message-ID: <cc6db3bb-c5c7-45ca-bd75-819887791e16@baylibre.com>
Date: Mon, 26 Feb 2024 12:15:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] mfd: tps6594: use volatile_table instead of
 volatile_reg
Content-Language: en-US
To: Bhargav Raviprakash <bhargav.r@ltts.com>, linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 lgirdwood@gmail.com, broonie@kernel.org, linus.walleij@linaro.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com,
 vigneshr@ti.com, kristo@kernel.org
References: <20240223093701.66034-1-bhargav.r@ltts.com>
 <20240223093701.66034-3-bhargav.r@ltts.com>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240223093701.66034-3-bhargav.r@ltts.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 10:36, Bhargav Raviprakash wrote:
> In regmap_config use volatile_table instead of volatile_reg.
> This change makes it easier to add support for TPS65224 PMIC.
>
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> ---
>   drivers/mfd/tps6594-core.c  | 16 ++++++++++------
>   drivers/mfd/tps6594-i2c.c   |  2 +-
>   drivers/mfd/tps6594-spi.c   |  2 +-
>   include/linux/mfd/tps6594.h |  4 +++-
>   4 files changed, 15 insertions(+), 9 deletions(-)

Acked-by: Julien Panis <jpanis@baylibre.com>


