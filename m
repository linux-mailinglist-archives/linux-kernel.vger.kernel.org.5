Return-Path: <linux-kernel+bounces-64900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A2A854471
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E23E1F29205
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B22BE6D;
	Wed, 14 Feb 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9jmjc71"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06C7499
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900968; cv=none; b=ZjJmy1QIsZDqhQ2H2Q6c7iRP/3+s11rWMyg1s8LKVlgTJxNRWfsAw/ooCRhpwkLIJ//kyDsPGrNWGxq4wyQUknNP/1OpFidvTIrj7pcLNQfcwxsvuiv0uuwnEpZxvp0RncgPenrdVZ058Dwlin7bFh1GiRfQiLOaA4woT7fO8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900968; c=relaxed/simple;
	bh=seU+VubZDxRKHlz/IYUta4RkwMrn8jtaSqsjf1TwkaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6GFkJr1TDfdmVJr3z7GuUt0dYbzTfQY5j+ecLdevq2bkgXbe3fyBr8xALGu5sSoS3ZAZXcd/2N/poEQlcj/uofuRJAFZF/oEzSAr8tAlLFbYIXMQRl2QccAN5k+hyzJJ/MLdyI2GUGQ4tJVqX/OjluU+6wgDMRzuJ9N7/YSjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q9jmjc71; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a271a28aeb4so666059766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707900963; x=1708505763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t6CpUTvlMcNqRo8XepyQNVrnC/CoT51gZejZ28v0Jlc=;
        b=Q9jmjc71ycTlDgpNu3/BH7te7vk11pvPUjb74w4SwZB70/zVqhC/E61z+xojw2wJ4u
         ZWN8Engh6bhcziiFJtphzxv/xwMvsoGCyaPzB46BFOul7zhSrLlF5gMbxI5QUAyjtdaU
         EQw9fKJlivzcdA+HddiAMfPRnwnGLbknBbcBC3JUh2zPmcu0EzD75NlpvdZ6FMwc6B0O
         +xUFBtnw8JXm+9UuwLhTBlrhxBB/daJb+wG/pzyWQEguYf4vg8OnInrum8Vj183RhLaw
         hLrGUIG10llbm/PyKI0akQ4kLDrBiqjo+sFyiT9efIB0kppo4tg5WmhDK52wzg/yaSGq
         MSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900963; x=1708505763;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6CpUTvlMcNqRo8XepyQNVrnC/CoT51gZejZ28v0Jlc=;
        b=Pn87WnEEv7hlSTZFiDAXpRT8ThWYLPdsuvwzthwWYsQzNUzN88zk8iY/ZkJf4qNjxY
         6E0VjGvH7IWfDaqWghYMkJRRF9RqSDY2Cq0X8rIH55vdQCgWkBImZy94FZodMtI4xD2+
         N5oPOyWFFzBnt9oAqzyJrJq4W/CR1xnmKHkujQSLsRrilxDAx9bDEc5w1+OjhhxVs0w0
         +PWDNlyDQ7EvKpeAOTjOE1a6ooCeKSFn0GoKrmBkJPrp89HeXBMh4Z1yVegnoKZ8TkXV
         yhdUUCn3faGrubbU+/JNDMyydu/a2L3HEBr6v12kO9QWHTLnS/o5ZXkysa0prtvsyjJx
         yJFA==
X-Forwarded-Encrypted: i=1; AJvYcCVa0WQ0iKI5+WQsqlXtHwrBUMw9k9yS1jkCv5f2s4oi2Cj8P7dWMZhYw7n2PHIirfKPQhSkdA+Jsr9pMLn+NqO4DJn+jSzzhKC5PhAP
X-Gm-Message-State: AOJu0YwBBQUc+911+/q+DMRo3pmedv8/DeR+R2Aa1jppUn0TKLP3rIuY
	h7JHvfXc0d9G9/6sfeDFPo44BWJdz9ZlCLFtD3GEKDq1rc1SHDPNVOUVZm8dWks=
X-Google-Smtp-Source: AGHT+IFv53OqyKfCS2AyE5QoKSqZ4vvx8TNNN5nJHOC0yja0St3b4kFIh57OSkH4RJa89iWyy8q47g==
X-Received: by 2002:a17:906:fa06:b0:a3d:1214:90d with SMTP id lo6-20020a170906fa0600b00a3d1214090dmr1221446ejb.16.1707900963109;
        Wed, 14 Feb 2024 00:56:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMtxAmcF6e+TOX5s+TM0JUdrisWtAAxtai7TwdZG2HspeeM/DulbdXVS9f0+kOgJyo4ulwvQXBB4oH5GVSVVCj2Ht//HpnWPK2LHMnIyvw/lfnjpRWK5foPTEn4f8T36yGXqlwarpGJj5cVSOQ1jOAwCNt9zUnMBD1i9GD/2Jn8E6niScnhqkoAStzZzUl+3TGC6u5Vjdk0CdW/Cybs0UedQlDXHX46z6sN1IO1zrI0OYbBk5Q8TP0Y7Q59r8YmImIhsH97GcJPtbVWY+E5xg0ht4ZSv7yLrvay51PXgqrg895ohgCxL/rb8mg9hoN2ZD33+PmOtqBrrOgh7MaNGa8ZiFLLMGK6hKmLn2DsNSjioXaZrK64g78Ddv0wgAspXkdT7GqV4NYiS0dLwb2UA4oLqUzfhl6/7E/2LeXGlyHyjlGRR3oJm9/d1Z1aiID8nJFAj9eUcErrq3CQABv/ZCpBKUDUE8V3x3ZGrkxV9jqsIJs7PaJw5lz/Wg4PPPzvDvG6a5A4n7SLgDQfcmKX4a7HeOfMAKkyCCRuwXgUGXIjLs+kpaVPktRwY0OShkLQPunsn/h8BQO4kdcBu1O1+RseRUWH834PAIzJb1cXZ8bgK6s8trKclaUVHopvedBDzi/MA78kFQO+GChKW6Z3+2pM2lU/JA0ViBck/IgUV0EhxrFJu7zsC1okufliwDq7Cs0Eqwt10vqnnuNpOdjkH4GbDW0k2+cloaCtPf35E9NYis+P1FX8aC+ezCYuy95go4VARuiNvvMNqLPgU+sVrYT6d7GClZFbfr+qD1Ls8tp3ZE44M1MbL+8/ZUqAmxCx8f+rQWlTBew8mckyG8U5cs=
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id vu6-20020a170907a64600b00a3d19aed4cesm1082935ejc.21.2024.02.14.00.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 00:56:02 -0800 (PST)
Message-ID: <9dcca70b-2c34-4b5b-8b8a-18bd9b4e6e5b@linaro.org>
Date: Wed, 14 Feb 2024 09:56:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] dt-bindings: ufs: qcom: Add SC7180 compatible
 string
To: Rob Herring <robh@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: David Wronek <davidwronek@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-phy@lists.infradead.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
 <20240121-sm7125-upstream-v4-2-f7d1212c8ebb@gmail.com>
 <20240212222232.GB2655166-robh@kernel.org>
 <CAA8EJpoymmOBc3CfNHJKBT8BNje_s2a5uGPde3QHYv3vQ97=-Q@mail.gmail.com>
 <CAL_JsqLGVBjiYt5tG0GFxxeHmNDD1PgJx3ab-n2x0nHPEaX9iQ@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAL_JsqLGVBjiYt5tG0GFxxeHmNDD1PgJx3ab-n2x0nHPEaX9iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2024 19:11, Rob Herring wrote:
> On Tue, Feb 13, 2024 at 4:30 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Tue, 13 Feb 2024 at 00:22, Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Sun, Jan 21, 2024 at 05:57:42PM +0100, David Wronek wrote:
>>>> Document the compatible for the UFS found on SC7180.
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Signed-off-by: David Wronek <davidwronek@gmail.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>
>>> Should have been picked up by SCSI/UFS maintainers, but it
>>> hasn't, so I applied it.
>>
>> And it now triggers schema warnings, because sc7180-ufshc has 7 clocks
>> and 1 reg entries.
> 
> And now dropped... Perhaps the dts changes should be too.
> 
> Maybe QCom maintainers should require a report of dtbs_check on new
> boards. My comparisons of Linus vs. next warnings often show an
> increase in QCom warnings. Like right now:
> 
> linus: arch/arm64/boot/dts/qcom:1990:265
> next: arch/arm64/boot/dts/qcom:1610:298

I was tracking new dtbs_check warnings on Qualcomm for selected
subsystems and for selected boards, but that grew faster than I was able
to fix it so I gave up...

After all these months and all these review feedbacks many people still
do not test their DTS with dtbs_check, so maybe the solution is to start
dropping people's patches? Detect new warnings and drop the patch from
Qualcomm tree?

> 
> First number is total warnings. Second number is unique warnings
> (stripping dtb name). Some of this is just mismatch between schemas
> and dts changes showing up in next, but it doesn't tend to go to 0 as
> the merge window approaches. I've seen this several cycles. All the
> data is available from my CI jobs, and I regularly look at the diff
> with this:
> 
> $ less ~/bin/gl-diff-dtb-warnings
> #!/bin/sh
> 
> [ -z "$1" ] && { echo "Missing arch!"; exit 1; }
> 
> arch="$1"
> 
> job="job-dtbs-check"
> logfile="platform-warnings.log"
> 
> # url <branch> <arch>
> url() {
>         local branch="$1"
>         local arch="$2"
>         echo "https://gitlab.com/robherring/linux-dt/-/jobs/artifacts/${branch}/raw/${logfile}?job=${job}%3A+%5B${arch}%5D"
> 
> }
> 
> curl -Ls -o orig.log $(url linus ${arch})
> curl -Ls -o next.log $(url next ${arch})
> meld orig.log next.log

That's useful, thanks!

Best regards,
Krzysztof


