Return-Path: <linux-kernel+bounces-38349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B73B483BE23
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520081F2DEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0F01C6BD;
	Thu, 25 Jan 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ayPiKa1V"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F101C69C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176744; cv=none; b=YhJ0eOH7Tu8Qw8wZJG6SQbVa5ABiNPOvrT4XsxVpZMznz7YWHqN6gf0pVmzKCewGzrErQcelhmp6OC4P51fz1GjnU4h61Xy+vHuur9ufsleH89LTmtsPfmCUGqfM8QpDVlPvoUDwL63rOt8RNd3jBvfIw24p0QQK7Xn5BAnjR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176744; c=relaxed/simple;
	bh=WKpvg0X+iL12WtuMds4/SdTYP/Rq0wCzwew5aiXY4jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUwYLlyFDJK/YMF3ytDPDy40SDmFxEVsHQtAOMBUuXI9DNpIZE1DWIKT+wlTWkfb5jsLtCNkdGZPiVdL9JN5zC+Wgnc/YHgHQyMqGXMpZ5hN9XP6OGtPDXYA/eUJbU/3OXshP7nk6zBggGz76O8Ts81KrCcHvxRre84Q6irF5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ayPiKa1V; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6868f31a555so20557156d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706176740; x=1706781540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79PYbjK8bosV8v03uRxryBv/M1N0jqOVv+qRTvu/Lno=;
        b=ayPiKa1V9dKP6lRTLAZxRV4ljG22qpiUX3TjTSajZFcvf/0skpB5IAxbxFvBt0oWoA
         gW7bEcl682Xm4FXztOLFtpJGo1HfbBx52YT0cvYFJPyzZaZfZaIjkaJ/DGudMPeuF0ee
         BNrqR+xng1TlqL+cfAS81OvSs1KsaMJtvFKXYJUHRHoh5fkn7epeL1G/PH3sFtqfcC+s
         7Q9w9H89EMxLGlbml27qX21Dfc00yHu+j5/JLQthrui8itozHSCxpmJQaRj+4wLgtIWH
         hmVQL+1GAr/E+zq/RLIje03Qnw+VvivPB5T3KAMDtjqTEOOFNeyO15QZy/EAjAgX4tbL
         UsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176740; x=1706781540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79PYbjK8bosV8v03uRxryBv/M1N0jqOVv+qRTvu/Lno=;
        b=xJljS2+U1h+xQRbOiSjY/XUVbP/beoLeM1SUUTi3LBY51PX91sVWn6TGX0xsiaBzGB
         Iza/ZgQPI5Z3agiqJ6PSnC4z0VsNPnZJDPgyTqZFJjbYrjJ89/lZZ3AeRvZ8oRg9Q/mQ
         87ibpEcIvIw7MmEshRnOw8hevXcJzYq+yfhu+2sel5Uq9sNQ82v77rQw51USgmEp9iKy
         45gHhx2c4aCHyLdAvk9DuWsBexuv3vTQMmWoBAsz3H70x5b9UYfcllPkF5CWIDhXKGrZ
         RnXp5sowmov5DnsancCstrkSgy9fFvoTaxErWA4TgTMR2WE2LDjCHpaLsYBUR3Etv+7D
         ZtbQ==
X-Gm-Message-State: AOJu0Yx8WW4CP3zQRs++6/wIy4JzLkyvACHhWY4TWOT+W9SvetxHIFdH
	TIOE3eFP/XIF22ME+5pBwllhpsoReQCvMyJ1aH/zwJZ5lS5vaJVAubgVVwoXgqM=
X-Google-Smtp-Source: AGHT+IFX+WJUjKVyMoF7VIqz7lwHkgo+xeYgCH/keHCQa06QjpPB++UCo/heJp7KdhTg47KNUQpu+A==
X-Received: by 2002:a05:6214:d65:b0:683:6621:c006 with SMTP id 5-20020a0562140d6500b006836621c006mr828558qvs.81.1706176740540;
        Thu, 25 Jan 2024 01:59:00 -0800 (PST)
Received: from [172.30.205.155] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id qm17-20020a056214569100b006879b82e6f0sm375625qvb.38.2024.01.25.01.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:59:00 -0800 (PST)
Message-ID: <91c047da-aff7-4e31-9fd8-ef4c3ffef27f@linaro.org>
Date: Thu, 25 Jan 2024 10:58:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sm8550-qrd: correct WCD9385 TX port
 mapping
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240124164505.293202-1-krzysztof.kozlowski@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240124164505.293202-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/24/24 17:45, Krzysztof Kozlowski wrote:
> WCD9385 audio codec TX port mapping was copied form HDK8450, but in fact
> it is offset by one.  Correct it to fix recording via analogue
> microphones.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 83fae950c992 ("arm64: dts: qcom: sm8550-qrd: add WCD9385 audio-codec")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

That matches what I believe to be the corresponding part in the DT!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

