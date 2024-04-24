Return-Path: <linux-kernel+bounces-157116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2420E8B0D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE03E28534B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7C215ECC9;
	Wed, 24 Apr 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZ53top6"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8191DFEB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969999; cv=none; b=B9bs74PkT+IK7jREQPTqIpkjo/pswUFTu9QRFr9PQb0m9xOsdhnJPxa5P3pa6rKBBABY5/2y3Xj3qvNsIPo0Sy4Xm8xg4Y3qh6pT5mei7lgVe83UbmpvbPEFoqaXnuHaTNhjk/mv9P0yirMibPE8al37OMnQcDCjs3IWGIFEHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969999; c=relaxed/simple;
	bh=F+yMiTBe5/hoxx2NJhqcvizqF27UFcCyQ+BG9ETc4IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khilMTXOJ+tTde+x9BXVzG3rtN1PwkpHFhMnUQ5Ul6zW23VV7GwSMsoGYDXlIg/CfZuLG9phAyRCIM0dwrF5G54KEAzPRLOPypQpMStSMnHZdnGZSblcC3OH+kEyXqOWf19Piib/fV6xtccfvzZvhYZyJ+9CD4jvK+5qfDa2k6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kZ53top6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so7114792a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713969996; x=1714574796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rmBHxU+K5+JFdDXXWYzqD2OyvFTC6VOaZA7L4t5ci3I=;
        b=kZ53top66Zq27EgqxWEwQMaDQDRwMN1S3bPquFH+UeSuyh3d8TuKrpV1lxdvNDmAYN
         cEfj+Ew2ZM+VT+Uznx7RadfgvDhnqTGrGVP9wQlmBgiTcsMWDa61cFMR8GIskc4EbnBc
         48yaA9DfC7mpFaCOuZ4A6ZYKVNbO7HYLazC81IhXJ0NsJFC0L9Ra5MiI4llTKKxC6RFF
         zm0EUGVH6J3jeQCi7aA4hEaTioaDNXyWUshW+MT3ImY3YXmddaS/5Aw2ExIWmn/xJujv
         UJlZUsiV5yye4YwZiCby7hX6pU1Wt5rNMoaf1Ux7b3r1dw+UJ8zrY+tgJlToDm/AyMAI
         09VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969996; x=1714574796;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmBHxU+K5+JFdDXXWYzqD2OyvFTC6VOaZA7L4t5ci3I=;
        b=Kx4qdiR/ncdmP7WjZAMf0m49CIjv0mLzMptiWadakM8SqCuxgDGTIr2lxnmrVtGYjx
         oTbyjM+1ylcxJxidvEXygbUmlVl2AHjgP57FvT/Bi1CBVSX9ZtV9g4Wt2DY3rk+Zo0wB
         iv7l6cPIk93tjTHa/vozymU+KKi5fyiUzSaUFJIXfVtVSrs9nJHLOEAuyJrsRfLml3vg
         lx3Cd3YTUtVbJhYGbrHjN8SUzcx+037IBapeG22saR3mzT919MZbElzi0CYjGFY5a+F2
         uZfxGHewJ6uW//ShPxpbgw11wNqv9mx7gFV8YN1QB8SwckwoxXnzeVNAWYKtW13YhPF4
         CNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrcnj5eV5XfEtu4Eb9Huy0XHE4tTglPaYspSV6CbdqtsBL90Q5jGu337JzACG+E2eHk3aJmwzTjoTl2xSY0yr+I4L5AhFvFvoY2v2V
X-Gm-Message-State: AOJu0YwB+R+ztBqOGIUel/uRwX2PUVGAlH9RpgQvwmiu2FxXYxnOUrVh
	uNQPPangJ8PJbSroQ5OtOMHdQ7V3fDH3oAJaZle3ECg4WCpySHI0gLo1y0Ros/Y=
X-Google-Smtp-Source: AGHT+IHn78VhiqSOB7pwnrThAKv9zjattaN+a7GzLm9zrQ+WEJPEsTGOI3m9iM6/iprTZBhXzezPHw==
X-Received: by 2002:a50:9b5b:0:b0:570:8d89:4c3f with SMTP id a27-20020a509b5b000000b005708d894c3fmr2047583edj.0.1713969996460;
        Wed, 24 Apr 2024 07:46:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k13-20020a508acd000000b0056ff510c327sm8224276edk.94.2024.04.24.07.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:46:35 -0700 (PDT)
Message-ID: <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
Date: Wed, 24 Apr 2024 16:46:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Wren Turkal <wt@penguintechs.org>, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240424122932.79120-1-brgl@bgdev.pl>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240424122932.79120-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 14:29, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 

>  		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>  		if (IS_ERR(qcadev->susclk)) {
> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>  					       GPIOD_OUT_LOW);
>  		if (IS_ERR(qcadev->bt_en)) {
> -			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
> -			power_ctrl_enabled = false;
> +			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
> +			return PTR_ERR(qcadev->bt_en);
>  		}
>  
> +		if (!qcadev->bt_en)
> +			power_ctrl_enabled = false;

This looks duplicated - you already have such check earlier.

Best regards,
Krzysztof


