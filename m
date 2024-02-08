Return-Path: <linux-kernel+bounces-58314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8C84E48A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C38281B74
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD6A7CF3A;
	Thu,  8 Feb 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9973PBU"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E17CF15
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407909; cv=none; b=ejjzTqk054jqY9Oppj2ry7JolEmZGnN/lr1ajuzYmzM3UoYbOl7b5ynIUGe4i6cF5SlI6geWTt69jgzLxhiGT2mfndKa/xOta1igyD6WPYdwbmIYBbuWfIWAlzT+PJlSE/0xMAG9GR5LK1CxZTCwQLpDQGnMkJ6v7fV67Djf/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407909; c=relaxed/simple;
	bh=TDzIbgNZS3QQJ06NuDSb7ivY5hSpwIiPFF8WCAG4ms4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzzkfN/mLa1y7ipIN9wqaowPIAi0KaoV29NwRP7siqRPDkWg/IwVYWAkmKl8zaKq6dJXTcInW1WsdDibktAGcK1jKG4P66dIupKzQA33ofBFf9MjgH/UcmDht1jsffGv3GPysKQhhpyZpd7+I0oTGtNQM4Wv5iL5qNtI5wkEurY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L9973PBU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4101565d20bso40135e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707407905; x=1708012705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lIhQWOTtlIkqEaUJ1btl8Cu6sS2lOJLYFYGhIk6UT1E=;
        b=L9973PBU+D6tNYoCxWXglN87EDqBCIXgrqrrumKYKtboaWCnHNcMM2aWnnyNR6OUV2
         DPzMmLMry93rAY8o3mujO1veKdn0q2CP3QDfS5o9QyYHEZ8Aa8JRt+7kOqK8EWwjEEmL
         nCuNZEaI3IM45PI+/IygV3O9ayD1wg0k3+lZnH1sd8ggh069F4Ga/Ez4TKmh+hWstfmD
         ePbDgzAGxs1zFx6w+gZ1mOQS1S3ngn5wqSn/q7n/22mKRPdXVC+kbAPNpakAESHK+pYj
         w8gcPrn5EEaPKIsRHJMCDm9jd2WHBX4NnqZp4kS+Z8hS+7Lqd6zS/aPcTvnXDLLFZ+NT
         5uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707407905; x=1708012705;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIhQWOTtlIkqEaUJ1btl8Cu6sS2lOJLYFYGhIk6UT1E=;
        b=vdqM/CO97BoLVk3ptcZvTY4P1tbMSaRFfw1BpVcTss4itIlxdVRDlV0Y64+Km/ptVF
         Ag0Ax84JOR3hb7D7avYK7jKX1iwdg4fs8TCgKbZk2AgnhVZ4M4iKWyuCWWY45dsPtQX3
         483D7nNjktNQmKWEPHUOdJ29eog/XmsVFHh/BYAHdbQqEy2kjF+TOoIkm38TZPz+9ixl
         6L+6Mlzlw5u3KvfvsdHBIWRs9rFjgnhfziYghm4SDACju8POpm6QcVIGNUkCHP0ry03+
         XfSSmA2VvFMyhYiE4XPMq7MO7FvDTrYwjyEX6U4r2J1HEn1gUyS/5K3Ukk8tEd83r2Ar
         bW7Q==
X-Gm-Message-State: AOJu0YwPasEGy2gzUY2hy5Oerftc16KTxgx2mcvDQY7zVnQGgLWXBNNn
	zZD2lDleaLjxpFMIIY1EPui5ft/iE/1sbNfJA6vFWeaUTc0qfwRSVja7B28/0P0=
X-Google-Smtp-Source: AGHT+IGNPybB0TZOxSOUTbCKcXB4naATIZwEppynxO7ce0EBtrDo1p9PbZxytwBFufmWwadt0gGctA==
X-Received: by 2002:a05:600c:4e90:b0:40e:f681:b7b6 with SMTP id f16-20020a05600c4e9000b0040ef681b7b6mr7133621wmq.37.1707407905497;
        Thu, 08 Feb 2024 07:58:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2/RbxsHzs+NwWDAM1SaX60oCC8/o6mD82oZRbD51iuXjr9ljwOR9b+sLHQfhMNvOHT1W/IvbfWx/pMk05QAwNTOvmfuhhbqBeKsb56adhGkqQ1tOLuq4aaggEHyhHjlRp/rxq1Nr4hVCLaq/i6HQ8ZaOOYEV4CfPMD2KxoH50Dy1LOIRDXaECtOr3efcjBR2a9vrrF+foHRCYvQ/SnMLbc6ieBskpk0T1FYVKPI1HQC5tT/ozM+LNDGpI/hAaGFwrw2+R+wEFDkd9soypT+ADSNwQb1zN96BChiEA3KSkDzFu5ihittuH+WUPRJnMhIgIRlDMqQxWaqiMgU6Irl9nimTdThnSL/3QfKgVLwC90WGdNYJU1r+0xCBQkmsw54zie6GPLiN4ycfuAytQnA/nqjIHYSGEPXgoq9Wh9zyLYdTh06M0qyamLxhV8GyfrD73ifMv5CKQwrWk1iQn4+sBTxbnNZ60U8Ou3A==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id az6-20020a05600c600600b0040fdc645beesm2048938wmb.20.2024.02.08.07.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 07:58:25 -0800 (PST)
Message-ID: <57018287-3686-4575-8bd4-a1efd1248fe8@linaro.org>
Date: Thu, 8 Feb 2024 16:58:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/7] dt-bindings: mailbox: qcom: Add CPUCP mailbox
 controller bindings
To: Sibi Sankar <quic_sibis@quicinc.com>, Rob Herring <robh@kernel.org>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, andersson@kernel.org,
 konrad.dybcio@linaro.org, jassisinghbrar@gmail.com,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-2-quic_sibis@quicinc.com>
 <20240130171240.GA1929440-robh@kernel.org>
 <8865b33b-8dd6-73bf-1d34-919c6bcff65c@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8865b33b-8dd6-73bf-1d34-919c6bcff65c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2024 11:28, Sibi Sankar wrote:
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - qcom,x1e80100-cpucp-mbox
>>> +      - const: qcom,cpucp-mbox
>>
>> A generic fallback implies multiple devices use the same unchanged
>> block. That seems doubtful given you have not defined any others and
>> given Konrad's comments.
> 
> This mbox is expected to be used as is on a number of future SoCs,
> that's the only reason I added the generic fallback. I can drop it
> in the next re-spin if you want.

Given that, if you ever have compatible devices, just use
device-specific compatible as fallback.


Best regards,
Krzysztof


