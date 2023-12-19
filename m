Return-Path: <linux-kernel+bounces-5108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A617B8186A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAD21F235AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F318179AD;
	Tue, 19 Dec 2023 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VY0QB7A7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D66171D8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d2d5ab5aaso2332145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702986636; x=1703591436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4a4teJHwZUJyBTzwWesDJ9PWyu4xpIdJ7qFNO5rTNc=;
        b=VY0QB7A7ldBEXgRKTH2YnRmkwlnr1RV0QOPvwR+7uZgiHUFu1fQdUR3Gs+nKaOlWbt
         m0mJISDrqWk8COkBz9lMlS94WbFz+M3H5M/21kJ9ivflJb2zKM6lhM4ky96xNhpMlpLZ
         rRkYUsegofGXWaY+Xjv1oQEokxTR8T2Wo3hQS1kdib12l7SIbi48f+mSp1GjTkXarExA
         lfqXwQZLx43HP64KxbdULBBUQhpR1ClWUY2+6+lYvbn7bXmC3QeZBZ5fwMGrKBUT/RHx
         twY/ffeex0q0elDESRsNUhqkfDWBD7tJ14nUjrkmjcJjg5SCflgQGbECVZr1k0FTgA6K
         Cl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702986636; x=1703591436;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4a4teJHwZUJyBTzwWesDJ9PWyu4xpIdJ7qFNO5rTNc=;
        b=DkfeY3tkK+Ot2X8fea90oIKbANAFicrH1UazuX4c5nuIKPba7psxas8coLc7gzCW4P
         RFYBe7/Aji1GehVnXCrzHQYULHBDz9vo1wEy0FMN5hOqQJCcnoKepWxkbTSzxzjR9lAY
         xOrCTNkaXi+mHn23kfrasGw3Y4P32/QeSELBpF8iY9kQ1yUJqXnUa7rtm7070nB2FRcv
         /faOUAFvDssZrd2y0sOTnlfwWBR5f2pokaccXKB4FHKgE2tsXh68u2ebYCvj62w/low9
         plcrBWuFzGWVScrkYMPwy+Gk4a6yN5C+maEs0P9LvnPEpzXt0spoHd8XCxoPCP6dbQwK
         tEvw==
X-Gm-Message-State: AOJu0YwCHtLNhD13DxzWMCoGMmqt9OhoqcZXzAkCup0S96GGrExxSzOy
	JRBGQrSLsQFvrNyBr57kV2DbCw==
X-Google-Smtp-Source: AGHT+IF4RYZBU0bIpMbIEP0f2+iigHpU5ygsAxD5kB8kDDyDkIYRkoy3zMNnLp5dntiiCPGDCpM4+A==
X-Received: by 2002:a05:600c:4d0f:b0:40c:3e43:417f with SMTP id u15-20020a05600c4d0f00b0040c3e43417fmr8925830wmp.58.1702986636513;
        Tue, 19 Dec 2023 03:50:36 -0800 (PST)
Received: from [192.168.199.59] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id ah2-20020a1709069ac200b00a23577b265csm2507243ejc.173.2023.12.19.03.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 03:50:35 -0800 (PST)
Message-ID: <05796d3a-3046-427b-8a0f-0895026e7da3@linaro.org>
Date: Tue, 19 Dec 2023 12:50:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/34] media: iris: implement iris v4l2_ctrl_ops and
 prepare capabilities
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-17-git-send-email-quic_dikshita@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1702899149-21321-17-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.12.2023 12:32, Dikshita Agarwal wrote:
> Implement iris v4l2_ctrl_ops - s_ctrl and g_volatile_ctrl.
> 
> Core capability structure has all the supported capabilities
> for all supported codecs. Initializes instance capability
> from core capability based on the codec type.
> 
> Add following to each capability:
> Children: define dependencies for a specific capability.
> Adjust: define function to adjust the value of capability
>         based on client configuration or dependency with
> 	other capability.
> Set: define function to set the adjusted value to firmware.
> 
> Prepare dependency graph for all inter-dependent capabilities.
> This is used to adjust the value of capabilities and set the
> same to firmware.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
[...]

> +static inline bool are_all_childrens_visited(struct plat_inst_cap *cap,
> +					     bool lookup[INST_CAP_MAX])
he's making a list, he's checking it twice..

I still think moving to a predefined config struct instead would
be a good idea

Konrad

