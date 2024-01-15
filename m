Return-Path: <linux-kernel+bounces-26391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3580282DFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB461C21F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CE21865C;
	Mon, 15 Jan 2024 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chCOOdzV"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E0B3D8C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5542a7f1f3cso10981534a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705343553; x=1705948353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ujyliyBd0fe+skX+g0KgLHIMvEykTGuHPaZvGn7oKI4=;
        b=chCOOdzVZtcPXjLbL+RnvYnUHTOYGhl+mxZ0A3PR+37AGOHXX7W4xLY7W0v/OaQw3s
         XHD13F2UI4wkRPJy87NNKArshJcRoQIrBZ+F5jZ6TV62ftv0YuTVM9z5wmYNa4RNeoNp
         sFJSafV8iqVTaHTx1QE92N5WKWJfnJljpSMAahTXqL2vfyOs65C2Y6SsN6NTF7e7rj3i
         ssMEA2opxM1LlwC51hgZJ0cIzUltLBtBIR3QTEeKtpVSkdE+ae52WonG3mkNm9JMBICg
         iLVgSNz6EKa4NcGAiGVqa5Sw5+e7xwoNhIkZq8wrLeutAzYisC96GmPoPxMAm6NGdldH
         O8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705343553; x=1705948353;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujyliyBd0fe+skX+g0KgLHIMvEykTGuHPaZvGn7oKI4=;
        b=Oxc/eWvgOVZukRQNBPr5nuqaES2AsCkDU/f1hiskrl6B8ywCSwNljb37A54TNrdOJn
         tCkTohXVD/SUA9D4LXfXkctCTDwv7fyVueEDuv1SViB10Z+kwOwY1ypUMXoXvLg6qPYX
         JD3HLpzcAbmXtRKphEZCLjndQz4QZlAPHa88SYXtQy3rYdhqKCe+AVlG5SfRd9fUtr9e
         BJmB/BopMqrx7nxCb6pT8TukB1aoMuBNNgvQhib3xmYh9P1r8Pr852r4H7PqNCUULuHE
         UeZvIaMjfZ1C8fHZ3WPauxNs3yFN1hk0UVn2UuBhCMi0JAWL4RADl9fzcKxxgyl/dqno
         EWWQ==
X-Gm-Message-State: AOJu0Yyx2VfMIbQ92+2uR6MKkMMOeD2nXijdEoCiCdavwqj/qkM0bi8t
	fi6I41nZx5SWVYtFAOBRL6q5lqJq3yY2MQ==
X-Google-Smtp-Source: AGHT+IHgWvQypTjR9uR1ShFmw7Ge1zhaArJ83oGmz2jMKWl3qKBv7hQXzzocAy5/7/Rl9kQ6kc5/yg==
X-Received: by 2002:a17:906:38d3:b0:a2c:43d:3f1 with SMTP id r19-20020a17090638d300b00a2c043d03f1mr2673705ejd.85.1705343552865;
        Mon, 15 Jan 2024 10:32:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id gu18-20020a170906f29200b00a28aba1f56fsm5561182ejb.210.2024.01.15.10.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 10:32:32 -0800 (PST)
Message-ID: <3bb632e4-67ad-43d8-9b7f-6e55880b0bd7@linaro.org>
Date: Mon, 15 Jan 2024 19:32:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: sm8450: Revert "interconnect: qcom:
 sm8450: Enable sync_state"
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240115153420.1525037-1-krzysztof.kozlowski@linaro.org>
 <201733c1-dc24-4d77-9967-f52c8e81d35b@kernel.org>
 <96928df4-75ca-4a55-829b-b8ab0583e3b5@linaro.org>
 <93bc06a3-8af9-4d50-bfee-d54e04bade51@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <93bc06a3-8af9-4d50-bfee-d54e04bade51@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2024 19:17, Konrad Dybcio wrote:
> On 15.01.2024 18:59, Krzysztof Kozlowski wrote:
>> On 15/01/2024 17:44, Georgi Djakov wrote:
>>> On 15.01.24 17:34, Krzysztof Kozlowski wrote:
>>>> Revert commit 16862f1b2110 ("interconnect: qcom: sm8450: Enable
>>>> sync_state"), because it causes serial console to corrupt, later freeze
>>>> and become either entirely corrupted or only print without accepting any
>>>> input.
>>>
>>> Sounds like some driver is not requesting bandwidth and is relying on
>>> bandwidth requests made by other drivers. Maybe we are missing some
>>> "interconnects" property in DT?
>>
>> Yes, the debug UART (console) misses the interconnects. They could be
>> added but it does not change the fact that console is broken since v6.6
>> and this was probably never tested on actual hardware :/
> 
> This patch? I definitely tested it out on a headless remote board..

OK, then maybe something changed between your tests and when it was
applied? Anyway issue is reproducible 100%. Even older kernel (v6.5)
with your commit cherry-picked fails.

Best regards,
Krzysztof


