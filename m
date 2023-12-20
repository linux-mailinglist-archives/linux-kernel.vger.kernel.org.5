Return-Path: <linux-kernel+bounces-6567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB7C819A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6D2B25BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014D81D543;
	Wed, 20 Dec 2023 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7fluobq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A91CF91
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d3748f345so2476795e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703060776; x=1703665576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkrbtLJIHxwrubyyHIdPB7BAusH4Ki6x0JXajVz1Khc=;
        b=M7fluobqfAyQrP+MyoKKpsFtFBJjsUTq7y/CdNharBPIWYZahVMqCc0TkFlfLri5r7
         PG7ozJqYkX1Apihjd5/7Pue/KwtsTO+nhFTiYueZ5nkPzUaQdFRUBP8sZzJ8/CS2JHtA
         uw5TAO/Fm3T1YI4QqGRxFcCaabbNu8SvRoII9/BYKXsvJxzwnUHI4DstnYAcLajTNmws
         rxP2sEzohRXJg0bg0kY39jY6qGFoCOLF/jGSS5fr5tUjTUw3T/atnYa9AKAe3ABImqED
         6+wXeoSMU8YMIIfVCC6CcBotY8yr+f2N4wWHWONw+vVdq5aGNHPoJMyDIou8hUxrmXL0
         hQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703060776; x=1703665576;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkrbtLJIHxwrubyyHIdPB7BAusH4Ki6x0JXajVz1Khc=;
        b=aYb+3EkR2gdUMfVFhL8bgiJDNJjc0jfprOp+OJZ2T28185PMadSnaVkJxd1NHSR9OU
         r96gyRxDyKmwpSWkRRAgCCaO1R4hyF/gzlcUctJKv+JoNFb9kkM2TKQbCR3+V7B1f2Gj
         ZAQMSTJSnOQXr6viFnDmTeExlLwJrMJxtjaGk8YwyFckCBMP7y4OFwUcdF/MpL38KBJX
         yoODjpasaLwwladIeAhIB6e79Ae7FITQfHn19dgFKioZtfLIO5KyoegKUFVMQnFbxGlY
         4rCns66t3cpn5jviGTJAlW/P3rIuB9XVauTmiF/EOg1seSx7t1ka+e/FOJ5LwjHL3bKk
         pWmA==
X-Gm-Message-State: AOJu0YzQx8NKGu+FlA+mU2TJN6JR7wFTzT1TBXN+oHhtYyXd1Y4H+u5Y
	bJJ1TOpbCcAi3+LFXis5CS5mfQ==
X-Google-Smtp-Source: AGHT+IHImClgIuXANa8nvI1xzuVponsoYGx0l0Jz+ArANYlvWkbUlBxindmotLQPWnT51t4yhlIlpw==
X-Received: by 2002:a05:600c:3093:b0:40c:3272:1fe2 with SMTP id g19-20020a05600c309300b0040c32721fe2mr11077574wmn.49.1703060775809;
        Wed, 20 Dec 2023 00:26:15 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b0040b2b38a1fasm6284450wms.4.2023.12.20.00.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:26:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: marc.ferland@gmail.com
Cc: gregkh@linuxfoundation.org, marc.ferland@sonatest.com, 
 jeff.dagenais@gmail.com, rdunlap@infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231218150230.1992448-1-marc.ferland@sonatest.com>
References: <20231218150230.1992448-1-marc.ferland@sonatest.com>
Subject: Re: [PATCH v4 0/5] Add support for the ds28ec20 one-wire eeprom
Message-Id: <170306077424.20321.13888791815997352512.b4-ty@linaro.org>
Date: Wed, 20 Dec 2023 09:26:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 18 Dec 2023 10:02:25 -0500, marc.ferland@gmail.com wrote:
> From: Marc Ferland <marc.ferland@sonatest.com>
> 
> Hi,
> 
> Here is v4 of my ds2433 driver patch series, see [1] for v3.
> 
> Changes:
> v4: Drop last paragraph from the ds2490 patch commit message
>     (suggested by Krzysztof).
>     Rename the __ds_read_block function to read_block_chunk.
>     Statically allocate the validcrc bitmap, suggested by David
>     Laight.
>     Remove both W1_PAGE_COUNT and W1_F23_TIME defines from the same
>     patch (was previously in separate patches, suggested by
>     Krzysztof).
>     Nullify pointer earlier in w1_f23_remove_slave to better match
>     w1_f23_add_slave (suggested by Krzysztof).
> v3: Do not use in-reply-to when sending a new patch series.
> v2: Incorporate suggestions from Krzysztof Kozlowski: drop the 'w1:
>     ds2433: rename W1_EEPROM_DS2433' and 'w1: ds2433: rename
>     w1_f23_data to w1_data' patches.
>     Create a separate patch for the validcrc bitmap change (also suggested
>     by Krzysztof).
>     Fix build error: initializer element is not a compile-time constant.
>     Rework the ds2490 patch and remove the ds_write_block changes: I
>     have no way of reliably test this change with my current setup,
>     and I did not experience any write failures. Let's not try to fix
>     what already works.
>     Rearrange commit order for a more logical order.
>     Tested with the ds2433 eeprom.
>     Rebased on v6.7-rc2.
> 
> [...]

Applied, thanks!

[1/5] w1: ds2490: support block sizes larger than 128 bytes in ds_read_block
      https://git.kernel.org/krzk/linux-w1/c/d605ba72e9c04efc35fcf225df59d4ccb1d4061f
[2/5] w1: ds2433: remove unused definitions
      https://git.kernel.org/krzk/linux-w1/c/86626c06d651c72bc10c25f263e98fa90655b5ae
[3/5] w1: ds2433: introduce a configuration structure
      https://git.kernel.org/krzk/linux-w1/c/75f0c1c78d709f258004562a540c83bc05bfb962
[4/5] w1: ds2433: use the kernel bitmap implementation
      https://git.kernel.org/krzk/linux-w1/c/3fe3a1bfef75efcdfbcca955fe1d47ec07215110
[5/5] w1: ds2433: add support for ds28ec20 eeprom
      https://git.kernel.org/krzk/linux-w1/c/93c4bb3666a3d463c73a66ab3cc78a4c4b83631a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


