Return-Path: <linux-kernel+bounces-18960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADFC8265B9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28036B21269
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F4310A3F;
	Sun,  7 Jan 2024 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgtxXvlW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFA10A37
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-555f95cc2e4so1219646a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 11:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704654418; x=1705259218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aTPNXQpJ4O39KyDd2HkvT42hjkwINb/udJz5Nmlw+kU=;
        b=lgtxXvlWKY4V834+2hfPsycD2de3OL8aVPH5XIDNiCpuZzJwSsykSmfTl0Z+YOW1Nn
         N24ds1JvYRfCQ6UkdcakRoemNu1W2yiYtaTV0GGJK0h86rB2bLEnx38TIb1Z3YC5YxKk
         c5AeMLHjksfyGvqX0aVz7e9U3sxmwjrFwELV1tek0+Y0RF/EQSwxcxF+ZDhhCIdiC0Vv
         6Usd1goO2hA37B9ZdQic4eHlUcNaeXRGRI4MDmhBSR1siS6QEX6I0MG31Uh4ozmMCIih
         ZHCt6HzYxxc5M+sFR3aMow9vwZia92bgihiWVU/UnjNxwgJAs3oWHAFHTe4HR420pZok
         vQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704654418; x=1705259218;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTPNXQpJ4O39KyDd2HkvT42hjkwINb/udJz5Nmlw+kU=;
        b=he5s/VKsodjuw1mhx6mr8LGvkmzlCrhL8tlPDQpKKW1sCW59xA6EXiskdQqgoPdlQv
         uFm8JLKp0XzqLhGjAank+OYIdfZaLnnoP/4O7Kh86oeXnK+vQ4hStTUC5Kb3jLk5+ULL
         fBQYXeQkCqAkfC9wOkxuKUg2+57/6xwaloWsPIqQA2Ci8Qq+RJaaxtSivTT58IEleYM+
         eU49ZIDw1ohvgkrnhZjEkYTZ+WWUKvcB3bUL6gku4sJykI7iDbTGOB27apFpcUeT3yHU
         kPRxeGop2iVRg1Ix6KLlOrb21FrHJwNyZ5bw2NZ/v5fzbB+QqNPpdmdcxg7dP/uxEeYH
         so4Q==
X-Gm-Message-State: AOJu0YwCTE+//ebgg9UOECT4mlBHZ2pLGz2PYcLBChC/fgN7VpEA4XiC
	u4PXzvG/6EJQpcDj/2GY+o5Zr34va3Zo4A==
X-Google-Smtp-Source: AGHT+IGzR3xBempsgmL7SBQzTLQOMPSwd8z280Em9EHOPwEk56cCkXDNtwAQ4KsVxxWVDU42CK7ysw==
X-Received: by 2002:a50:950d:0:b0:555:6be0:2f58 with SMTP id u13-20020a50950d000000b005556be02f58mr1723870eda.1.1704654418197;
        Sun, 07 Jan 2024 11:06:58 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id fg12-20020a056402548c00b005579d0f146dsm803483edb.38.2024.01.07.11.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 11:06:57 -0800 (PST)
Message-ID: <2df9fe3e-7971-4aa2-89a9-0e085b3b00d7@linaro.org>
Date: Sun, 7 Jan 2024 20:06:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/4] net: stmmac: Enable Per DMA Channel
 interrupt
To: patchwork-bot+netdevbpf@kernel.org,
 Leong Ching Swee <leong.ching.swee@intel.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 peppe.cavallaro@st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
 <170464562363.18664.8264531122295136817.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <170464562363.18664.8264531122295136817.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/01/2024 17:40, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
> 
> On Fri,  5 Jan 2024 15:09:21 +0800 you wrote:
>> From: Swee Leong Ching <leong.ching.swee@intel.com>
>>
>> Hi,
>> Add Per DMA Channel interrupt feature for DWXGMAC IP.
>>
>> Patchset (link below) contains per DMA channel interrupt, But it was
>> achieved.
>> https://lore.kernel.org/lkml/20230821203328.GA2197059-
>> robh@kernel.org/t/#m849b529a642e1bff89c05a07efc25d6a94c8bfb4
>>
>> [...]
> 
> Here is the summary with links:
>   - [net-next,v2,1/4] dt-bindings: net: snps,dwmac: per channel irq
>     https://git.kernel.org/netdev/net-next/c/67d47c8ada0f

Please wait for DT bindings review a bit more than one working day (I
don't count Saturday and Sunday, because we all have some life...).

Best regards,
Krzysztof


