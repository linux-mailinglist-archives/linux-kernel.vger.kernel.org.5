Return-Path: <linux-kernel+bounces-155573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3708AF418
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572CC28EC72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A0813D514;
	Tue, 23 Apr 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPqn29Gw"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6AB13CF84
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889719; cv=none; b=MhZoE/hOp/dJB+D8nmQ7UTFnBPiZCXfv0gJHwc87GtMscVYkbbf+cew5edXZEMLTmRDioAKe4qe0cjZqCrmR1aBqfFvh2KCOMCfomK+o1wgOA1YIIGvrfHo1xdoEgHFNHgiUk4cpsTnlRjBZMvVyAiG71IDFMvgU2hZ+Lc/enCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889719; c=relaxed/simple;
	bh=u10jUnV5IDjrF3qigV0Kcg5bqQzScV7FiuhI8S8dp5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phxoapo1k74One92DQYUHGebEI2PDsUjTJkK1sXkvoDA/VaVSZK/Bt6w4CnWHcfN6rG6zwcPymCcE2EY0tqqWgfguLtyCozjwjCdyo5ZzgQlHiZQyDi7i+Jn69zP+COe1TZNPbqQpFc3InYzChHR1CaCO75LtqHCZAKDWQBoR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zPqn29Gw; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51b526f0fc4so2860241e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713889716; x=1714494516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zO+T8/DOzCQtrJbOxhztGwyZx8qyfjvyqs0TKvYcbI=;
        b=zPqn29GwyY8ZvUg5m2MlYy7Dia+QuJoCLxJ4OGLzx9ppexTCYMEKXd7Bwbo81JwUW2
         spHQfLVX63Z/JHAfMYTA10goZdWVoX6U7FeQfx589/orOyontm0a2J/tJqdEUcHM+yWD
         4vdtow+xiVWWbF2l3pj/vEcPxE8SC4/VKwaMPL2wDqsTth806RWTva9G1ieQ1whec7Yt
         6ojoOvBdo5qa7vps485RhYWuuVFLu5SqtFPBKhf/g01R69hgt+3rCM5amYWAIK09ZPh6
         HplvxplFjofMReab1l/44gRSazncjMnviql37UmLRwce7UinKi0y1zVMG+WnrQTtx6Cf
         ab/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713889716; x=1714494516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zO+T8/DOzCQtrJbOxhztGwyZx8qyfjvyqs0TKvYcbI=;
        b=TCi4zRyDhM2yAm7r31GNEXw7461ivmaK+hYj05ZviIFQCgLUW4S8zO8KrNGQA7GtA2
         NL0NNTzxRnsaNbXAK3+xiBf0D5VhQWbAPp3SAUDBicqWsyv4Uve0g5eHZoAHwJxHhI1v
         xsmbHp1bxe3m5peVJFlkDZmtxzTFgRzLw9tnsSzc0o5Ud1OMzkx5wKLxWrWfMpLkose+
         p6vTXeyB6mwpMa+9R46+tlpHDKH8/dZqj3YARqSfyzXdiAYEvDM8D0LLlyfuD0xy5ytc
         ENzu5EJySSMRQesOgY0wi3jPlQNp8+Qb8Mb3qaotry0m6yep21Kuy2GElIMGTw3irivN
         7JJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXtxPpTPjk/wMaZDSL+OtaV+njKyKuxXhUPmlZ5ZKlsTHF+o7Pf0q2uAh0CCTIGHNOzK6X1f9+A6Dg2QNoM6c+E02YJqW252/hfeGn
X-Gm-Message-State: AOJu0YzlTx+rZqF6LuBh8sV9+m120EKo4FLrWzXNlxmcm8VIWWP+n7RM
	WQVsOrde8KWMsIkKbgicwpL5pfTPpvYdibkTFLFuDUt6Ts0k/jJilEhRMgHzs08=
X-Google-Smtp-Source: AGHT+IEOuAlhaaJQxnP2a++uUiRdJnjYuA5FRyqcqTId66NsqOBEEuVva004iyFbkf+AmumSQrPhwA==
X-Received: by 2002:ac2:4895:0:b0:517:87ba:aff3 with SMTP id x21-20020ac24895000000b0051787baaff3mr33591lfc.43.1713889716504;
        Tue, 23 Apr 2024 09:28:36 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d14-20020a05651233ce00b00516ceeae6a9sm2060603lfg.9.2024.04.23.09.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:28:35 -0700 (PDT)
Message-ID: <7f111799-a647-4b9c-8915-5a7be0c66d5e@linaro.org>
Date: Tue, 23 Apr 2024 18:28:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: msm8976: Add Adreno GPU
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240413170317.34553-1-a39.skl@gmail.com>
 <20240413170317.34553-4-a39.skl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240413170317.34553-4-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/13/24 19:03, Adam Skladowski wrote:
> Add Adreno GPU node.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---

[...]

> +				opp-200000000 {
> +					opp-hz = /bits/ 64 <200000000>;
> +					required-opps = <&rpmpd_opp_low_svs>;
> +					opp-supported-hw = <0xff>;

Doesn't look like this platform had any speed binning going on, can drop?

Konrad

