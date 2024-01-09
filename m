Return-Path: <linux-kernel+bounces-20668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856A9828343
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1B71C24F94
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C3B33CF8;
	Tue,  9 Jan 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/qX1q0f"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F1F33CCF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso2684157e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 01:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704792821; x=1705397621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVeS9dNi5F3UQMp7NbVYNXBADspqfRiuuFMETtP0Ze8=;
        b=P/qX1q0fsI2rQxko6x9iJdIGwJHoukE6zBOvFw0owVsAPEo0xtTzCawrIkAz2wJiQz
         kp559S3IS8bnyd7YZ0CJoo39x0wpgPKf/FZat1xDW6kwaAD4ot8Q8YJkvHzSMIWq/NMj
         QPVsbgNvteUIgd791gYFi8ra+1rVcwZ/ymeZFeF0+Lp1CkGGe6CYa2SSNsyN6S0ndNvy
         p0Oj/K6DMcddezeHTpF6+wV9CciyNwVTckpaL0/DGnhQ3UlULtn+2IqrSOlOQn9Qh1o0
         SZVt8GgL9yzp/oK+3liA4mp3bdgN5UJRJ6rF/Qk88azGkbvIJLAwk7dym7sAekbYHQm8
         0OwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704792821; x=1705397621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVeS9dNi5F3UQMp7NbVYNXBADspqfRiuuFMETtP0Ze8=;
        b=YWK0+QemI9Rkr4ZMmvIkhT3vXf8ZdpZvsdmVqkWsF/be7CxaKLhsXNbUJfBH9yvcVd
         qZ7136jAmOepMesPwCs+LAm+AB4EcOj6jrtSGesGFO8DARIuiQkWPIN4bz1LBbwbmCWy
         DRn4Nd5Kic7+YZaOnudSbEeCrPnkJc6zwkPvu/4N8kkNt22635iSKPNUypxkwvK60NGo
         lEYPd9Mmhjya7m5g68XQuJBZCTNC8xt3A2Jzp3aYe6qygSMiCalEp8oSWlwuoy/oMoh7
         Fs/gyjxIOHzjLIfDFZ3m9pivzLxOLf7hbHEj5OVmhSkzYlZgYbMJaJbs5jmyuf0COJyf
         P38w==
X-Gm-Message-State: AOJu0YyjrSE6NAtC5PfzcK6gq8NnyjeSoSy+HYP2m8YHU1JXvLcbGkNj
	iPbP5bNVAtS/jNIVD+GjdM/BtGMxo9vVNw==
X-Google-Smtp-Source: AGHT+IGfNHPtDigajGJRU+dhzRgIlsaLULmucB1e2N68M1etdiT5SBgJNUKqBwAEMNxEMDISWXGtXA==
X-Received: by 2002:ac2:4e12:0:b0:50e:9c17:24c8 with SMTP id e18-20020ac24e12000000b0050e9c1724c8mr2414289lfr.7.1704792821587;
        Tue, 09 Jan 2024 01:33:41 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512218b00b0050e7bee0787sm248909lft.234.2024.01.09.01.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 01:33:41 -0800 (PST)
Message-ID: <19eceba8-dfc3-40d0-a681-8c47a0248cfd@linaro.org>
Date: Tue, 9 Jan 2024 10:33:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] clk: qcom: gcc-sm8250: Set delay for Venus CLK
 resets
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Manivannan Sadhasivam <mani@kernel.org>
References: <20240105-topic-venus_reset-v1-0-981c7a624855@linaro.org>
 <20240105-topic-venus_reset-v1-9-981c7a624855@linaro.org>
 <0cbedc75-cacf-43f8-a1f9-284546ad548a@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <0cbedc75-cacf-43f8-a1f9-284546ad548a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/24 01:34, Bryan O'Donoghue wrote:
> On 08/01/2024 12:32, Konrad Dybcio wrote:
>> Some Venus resets may require more time when toggling. Describe that.
> 
> May or does ?
> 
> I'd prefer a strong declaration of where this value came from and why its being added.
> 
> May is ambiguous.
> 
> "Downstream has a 150 us delay for this. My own testing shows this to be necessary in upstream"

Alright

> 
> Later commits want to add a 1000 us delay. Have all of these delays been tested ?

No, we don't support Venus on many of the newer SoCs..


> 
> If not please describe where the values come.

They come from the downstream Venus driver as you mentioned.
I checked a couple different downstream SoC kernel trees and
tried to assign the values based on what I found in a kernel
for that platform. Some are fairly educated guesses.

Konrad

