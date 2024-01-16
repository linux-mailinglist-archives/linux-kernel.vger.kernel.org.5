Return-Path: <linux-kernel+bounces-28268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7D82FC4E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C101E1F28D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CEA5A0E5;
	Tue, 16 Jan 2024 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QX2dfPNZ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366450A8D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437925; cv=none; b=ND/NI85drhN+0q6KXKaW+xRc7kAoT0L7zzqO9KFSaRBg0OzwefKQaBQOotHsMH2TwO/Qesjd0oIdFf7EXwVwzHe4PdNdXYp7JknCGgQpGkFPErPshQN6XEjLrYJsiKKtL404PM/quUfPGl5+I3IJZoBJIOxKShH9n+cGCqiF8lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437925; c=relaxed/simple;
	bh=VwD2o42GKCMVoFWM4BCeW2ZBYFCQzyp04aI4NBC1I88=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=qnBDrdTomWpRBHRkcKAJw1SpA2QWi64hNTiEXAaPQWlQS+J81m8P+N4CGC5Ds1CV1b7davHp+Seq//IxKuVwCS5uMLIxZNe09izCwVVL9jemEHLvWudvkqgW5urXKRaX9G3OGnns4HHsMkc+4+Pu+otzokP9Gct7/6wK97C61pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QX2dfPNZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e67e37661so14244884e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705437922; x=1706042722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txkFZci/pgsXaxnR/38VBVYwmC/OcvuhAyTTbLIrlLk=;
        b=QX2dfPNZ7iTk1JUsVkg255Q8C2IPQs0aohtn0aDYIvUSI0xq2jAAuTQZohRwav8kyR
         gb4rCz1Eu40HieJyHQXEruCM7QbEjk8lec0SASFN0pntZ+zEL1tEf+x4ObqG5yUb51eP
         01lDP0joyi84bQqEEeG5LDEvN/lRe97HFzfAuTo0C4ENNwUfK/4aqGO03+LkuRBFU06r
         ZHkLuB0U8iKnNS4RQ/HQrxVnsj+97TJZTLb7p6Yr2kfE7OK+dlmghdak51yi5cPV/uTT
         roIfYMrtG2gDmS6ZZoeM8+wza9cohtKRXWMnncCVV2soioFsPa3zfk+KeRBUxToMfdLR
         FkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437922; x=1706042722;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txkFZci/pgsXaxnR/38VBVYwmC/OcvuhAyTTbLIrlLk=;
        b=im09ADCOLYN7iU7Brz4XgtdZICSJUkKp7IH+UR0oKRKv4UL1rwXQgJXQS5odUmqLdj
         t7G26utyBhhBuCy7XNeM15AcEuUs2uH/mJMmGia3jV1bC55HasuKzYhd/Tpe5Jk68/1K
         wx5tDdpjyYGgEliTBiulzReih+ZoIi8K9U6JJZGArpLW5+/pv7c7scvJUCm+ft8F4u+q
         3G7Z4CvPDk0celNXASRvCNClKjG+b7FhibY3Vl35faR98HeC5+HzDLl1Dgn1X0TZxkrb
         fhyrCQ+Fgq5dlh4ggT/FAneLkhqUYY2FEH15sBhuLQB0Ec2t7eOxd3KSFQcNrDb0qZhK
         zk1Q==
X-Gm-Message-State: AOJu0YwIk/S0u3YBiFsO6PYlW5EGRtPfi2M2DMdlkCsOQiXOpCKpzNyc
	hh7DEDdIfmyp37ei00m7VNTQ9zF9sg3hwQ==
X-Google-Smtp-Source: AGHT+IGGcXxw/R0mm39DaU/LVmJ6coh0dFZ6uHogacHYaydxCmMOz/aPNXG/4aLNp003Lf0G81ZpGA==
X-Received: by 2002:a05:6512:39d5:b0:50e:2f43:8b7f with SMTP id k21-20020a05651239d500b0050e2f438b7fmr4218175lfu.13.1705437922134;
        Tue, 16 Jan 2024 12:45:22 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id st6-20020a170907c08600b00a2ce3230351sm5448862ejc.37.2024.01.16.12.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 12:45:21 -0800 (PST)
Message-ID: <d90d035b-c63b-4bb2-a84b-9627fca10eee@linaro.org>
Date: Tue, 16 Jan 2024 21:45:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: display: convert Atmel's HLCDC to DT
 schema
Content-Language: en-US
To: Dharma Balasubiramani <dharma.b@microchip.com>,
 conor.dooley@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lee@kernel.org, thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc: linux4microchip@microchip.com
References: <20240116113800.82529-1-dharma.b@microchip.com>
 <20240116113800.82529-2-dharma.b@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240116113800.82529-2-dharma.b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 12:37, Dharma Balasubiramani wrote:
> Convert the existing DT binding to DT schema of the Atmel's HLCDC display
> controller.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> changelog
> v1 -> v2
> - Remove the explicit copyrights.
> - Modify filename like compatible.
> - Modify title (drop words like binding/driver).
> - Modify description actually describing the hardware and not the driver.
> - Remove pinctrl properties which aren't required.
> - Ref endpoint and not endpoint-base.
> - Drop redundant info about bus-width description and add ref to video-interfaces.
> - Move 'additionalProperties' after 'Required'.
> - Drop parent node and it's other sub-device node which are not related here.
> - Add compatible to example 2 and add comments that bus-width is the diff between two examples.
> ---

Please respond to review comments and acknowledge you implement each of
them. I don't think you did here everything I pointed out. The next
patch for sure misses things.

Best regards,
Krzysztof


