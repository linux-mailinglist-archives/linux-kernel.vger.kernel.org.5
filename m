Return-Path: <linux-kernel+bounces-135321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E4C89BEFC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1CD1F22C84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6D86BFC8;
	Mon,  8 Apr 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5CmKq+P"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E3347C2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579470; cv=none; b=q/GiQkK9kkUqtwJSm7aLmfMWq3x7rmUNYJDLFb0ODooalrUt9+qTLQDe/KQ5TpCMYgI6lQRCRL/aW1oK0vAR0W7hl3rvcRH/6jVLThi0USwHj7mdO0ZzBRq4zF9M+DKo4uvOgVTfq4v0h+tYdTNerXvh/FMB2LIA0e1glaQ7j8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579470; c=relaxed/simple;
	bh=b+Ek3x+dl309D7rDml0vt1qBMPhwIeHmGaGIl/mbWfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rf68ezUFsyP+NkxKFmy8wJHSlWZzoPvbNbiFHLPzbz0RwEj5PkviqbxFGL1g7QmEsGxOPZNdLyRHIYv5oOBU0NIblEaSXZGQyKpfoErOh0sI3OWMjs5DkB+ts8wcJx/HkEPTiGqMSlkqE7E5huJAw2AGIV1WkxwGZ4XGkJuGdo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O5CmKq+P; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d0c004b1so4879788e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712579466; x=1713184266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kzSIy4IUQFVGAHOdr/Ay+CcKI2R39RlezDr1DWC0dBc=;
        b=O5CmKq+PE31zVeXLvHkIXBh/k7jcj1yQs/JZa6GXMPWhIMvaUvYy+9XJx82le8RPRf
         Y9zPwd3JensKVLvc8lY05HtC2uFR8EEFF+TEIFnw0MLmEktKyVkMGVlnUfDY66xZdqYN
         3avjY/5j3+Mawpq0Og/Eo5xDJaXj9yJYBZXdmZEdho+dvtsFjCyGpFgf5C6adf8lM748
         tToDaMlZB1sqPXOblw8OBpF9ST6XksCcDJEDQCk1YAcXScwL9xvhWJw42sNkwPQvU3Mb
         +csIbqFhyOJCuxWU6UBrSXvm8DbBIMHYE1V+/phNGg0lY+ufiYgU4ddP43S8cOB5FrnQ
         lP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712579466; x=1713184266;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzSIy4IUQFVGAHOdr/Ay+CcKI2R39RlezDr1DWC0dBc=;
        b=UqrROzIBfIIjo79UOtkX94U5rde84fh+R+5tmq7JMeyMdYZWjPiKOhbFIBpZDkAUnU
         PvY9OY5cL6pJ49/OXIPx8TQ6Ml7j3lOn9st/Y/w7MK6Z1ar6hEHQdb5N9cMx2HMRP0Sp
         8ALnrK76DsC0AZ49ph3rslTp+eklnsDKOw9TCdYxREMCNDkF66zP4h77I+mizL5p9bTZ
         CmCSQDL7jSg8Egw3pSKkT97+LWAIWn6d9Gq4+xlZMabUUEEFZz6m/QJKidfykAD8otZv
         GjG3jk6+VqildVGcN2tXMFSXffHeYh/eMoNsSGsZLiD7RVALVZUxwNvlBtV48OhW0fl8
         u/+w==
X-Forwarded-Encrypted: i=1; AJvYcCXCkVVvzoHYheo01NF/pPCiT2Lxl1PTzs2fH12hdS9+wvFjNoLU/ihSQ8JwE1CYqlQdUmg9rp6JJSzdXnnUNRyiDq67xT9buIKqKW/3
X-Gm-Message-State: AOJu0YxDFRr69U0Z/LlCgaPkV/kj2e1s2GlmQxi4DvutiFZXu0QJkPGD
	o1oTYf9quW1OoHl3Hio2poA092pNi5/RRP2Kn07WMKHLsJKyIy1YbbyAECgILM0=
X-Google-Smtp-Source: AGHT+IEImUZC1L3qfzkl/1/Q5Bme4/VywRnw6ZCt+yP13TPusBFTdR7s5x4BctBnwDCwXHlq9BABGQ==
X-Received: by 2002:a19:4319:0:b0:513:c757:33d9 with SMTP id q25-20020a194319000000b00513c75733d9mr5668252lfa.53.1712579465738;
        Mon, 08 Apr 2024 05:31:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c3b0600b0041668162b45sm4337813wms.26.2024.04.08.05.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 05:31:05 -0700 (PDT)
Message-ID: <92665046-2e0f-4c51-84c6-3281a08e6804@linaro.org>
Date: Mon, 8 Apr 2024 14:31:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] media: dt-bindings: nxp,imx8-jpeg: Add clocks
 entries
To: Mirela Rabulea <mirela.rabulea@nxp.com>, shawnguo@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, festevam@denx.de,
 festevam@gmail.com, alexander.stein@ew.tq-group.com, Frank.li@nxp.com,
 ming.qian@nxp.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, mchehab@kernel.org, hverkuil@xs4all.nl,
 linux-media@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240408120654.1196880-1-mirela.rabulea@nxp.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240408120654.1196880-1-mirela.rabulea@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 14:06, Mirela Rabulea wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The JPEG decoder/encoder present in iMX8QXP and iMX8QM SoCs need
> the PER and IPG clocks to be functional, so add the clock entries.
> 
> This also fixes the following schema warning:
> 
> imx8qm-apalis-eval.dtb: jpegdec@58400000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
> ---

This is like third version today? Give people chance to review your code
and wait 24h before postings.

Best regards,
Krzysztof


