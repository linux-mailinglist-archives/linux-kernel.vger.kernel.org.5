Return-Path: <linux-kernel+bounces-118413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D765888BA70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073291C2DF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F813340A;
	Tue, 26 Mar 2024 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvJiQP3Y"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C47513280F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434570; cv=none; b=DIz/HO/7678oJo094SwMphnepZ6+kJFgwgORSUBfio/Hr9kJFF5N1O5ssNsyw97zka1ti2b3mmuV9N1nH6b3BGCa4he8h8x1a+IDD6HvAqKETq42pM1PlK10DyDeS7Ar98jobWrziAFjGczH5OHf3jaJLqjw6aouZi7vjtenXJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434570; c=relaxed/simple;
	bh=SR9YNar3/X3F4Y7T5Iev7JOeoTFsIajhJNRqCU0l+tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9449zKLgCg24YrmO7/RB3Mrpkxym2XP/MvvkVAu8PImIShJShcfpQCdzWzsb3TyWs6i5ksW9nh8Tm/ciOJnofohL2c4FMtCYeVjxvd0FAr5ikCaXGix2oFmAPoC6DcrhsauAc3bzOgqh5P/APgdvM4L+4Ew2tuwxvxiOUH+11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvJiQP3Y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso5300435a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711434560; x=1712039360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5QDBHaSC5fntPQdx5nI9UDxMCD9F3a8euvISqTDLhTk=;
        b=PvJiQP3YbGwbuoAej92Vu/nUGx2B7zPW3Pjuid3x9lOyeLvWuK9dxA9N9dfUUrEnL6
         286cgmGkNNGNmsg76xa/iGbZ+iDMymmZ5xPb8alIhhlrtApYktwXf6iKgT4Mog9oFIov
         qr+htwfi4X+9Iqi0GYb25eP1i5T6giUK1OltbGxaCZVZGw/FvPBGDfD0ZFy0fg75OAb5
         uxmPxnXWGvRsgCqB2b6HN0EJjnrOCtwmo/dwJDp/XYk9eoTew7lE0NPyAow1MEauCgeN
         c41EfBQQDi4d9yeDw9/J0WltaG4/aSuNHSegfS/3OgjDNhmhAJd3EU6Bbv14abe+A0Ee
         rHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711434560; x=1712039360;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QDBHaSC5fntPQdx5nI9UDxMCD9F3a8euvISqTDLhTk=;
        b=KAiceTEORiis5rkiFptuiJ0gExHTkK18QytV5oXudp7gjCrq/JwYl9wDqxzeY2oT1f
         vyIh3V3Li/VNeVu+DUPOsGRKHQVZNvrH0HTwdmnVnPe0gsKLIpPLWRUKcOUxUVf0biMb
         w64aKUvfUf254vo0zwXZcpdey8F6WyB6s8+ZtVSBSvaJYp+cgv+TN7xnL0l6z48absQQ
         3ns/+YRiYK/OD/pxubNsbAPhKSKiM+9ELbh3ZOVQLE1J+HtOtJKUvuK+MhAo0c+xUxP0
         iEAlvjtMjR74hoguFO8sEHsWcKoaS7xLC1O7Acp3PEzjtGL4jpwFQOXSF5VscBmQoEka
         Uc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvA1RGrKeMyxKZCrcbggcL85HGR+7PyGLQmQ+QQBOQiV6CXqukuxeby9HB/z8vS6hUXWQA6fJ8saK4AsGATTmfbZIbV6dTnl5y9EP4
X-Gm-Message-State: AOJu0YwSMbZF10ndz6QR6basN7FnxWisgOP9conK7TyBhPpcJHX+cQTX
	Pl8oty5u8i2/zDOT+8fqnivY0N2+1e0DVgIbcPuFl4LkCS7UvziS4FhYTNW/ujY=
X-Google-Smtp-Source: AGHT+IHS+Py7F4eCiITse8lcGWhLrhntEwe1W757/7QYsqErqTxDqZZZwsaVh7yrPgaOIa8FUDlqxg==
X-Received: by 2002:a50:9b58:0:b0:566:2aff:2d38 with SMTP id a24-20020a509b58000000b005662aff2d38mr5980629edj.26.1711434559971;
        Mon, 25 Mar 2024 23:29:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id fk26-20020a056402399a00b0056c2bd89354sm219887edb.14.2024.03.25.23.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 23:29:19 -0700 (PDT)
Message-ID: <68dbebe0-acaa-40f0-9a5c-fd49d265ae08@linaro.org>
Date: Tue, 26 Mar 2024 07:29:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] QCM2290 LMH
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org,
 Loic Poulain <loic.poulain@linaro.org>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
 <d8ed4e6c-549f-4c04-b38a-2d788df8b707@notapiano>
 <dbe90a1c-bac2-4176-8eba-7ad96a182313@linaro.org>
 <8e0cc005-0b3a-4475-bfe4-82ec46d918a5@notapiano>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8e0cc005-0b3a-4475-bfe4-82ec46d918a5@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 00:01, Nícolas F. R. A. Prado wrote:
> On Mon, Mar 25, 2024 at 08:59:55PM +0100, Krzysztof Kozlowski wrote:
>> On 20/03/2024 20:08, Nícolas F. R. A. Prado wrote:
>>>> Loic Poulain (1):
>>>>       arm64: dts: qcom: qcm2290: Add LMH node
>>>>
>>>>  Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 12 ++++++++----
>>>>  arch/arm64/boot/dts/qcom/qcm2290.dtsi                   | 14 +++++++++++++-
>>>>  drivers/thermal/qcom/lmh.c                              |  3 +++
>>>>  3 files changed, 24 insertions(+), 5 deletions(-)
>>>
>>> Hi,
>>>
>>> I've started tracking the results of 'make dtbs_check' on linux-next, and I've
>>> noticed that on today's next, next-20240320, there's a new warning coming from
>>> this. The reason is that the DT change has landed, but the binding has not,
>>> since it goes through a separate tree. I thought the binding was supposed to
>>> always land before the driver and DT that make use of it, but looking through
>>
>> There is no such rule. Of course new binding should be documented in
>> earlier or the same kernel release cycle as users get in, but it's not a
>> requirement.
> 
> So, after giving the documentation a second look, I found this:
> 
> "For new platforms, or additions to existing ones, make dtbs_check should not
> add any new warnings."
> 
> Source: https://www.kernel.org/doc/html/latest/process/maintainer-soc.html#validating-devicetree-files

It's just "should"...

> 
> What is not clear there is what the reference point is: is it on linux-next?
> Mainline release?

Does it matter? There was never a new warning introduced by this
patchset. The patchset itself is correct. No new warnings.

> 
> As Konrad pointed out it's tricky (and maybe not worth it) to guarantee this for
> linux-next. But for mainline release it seems feasible (and IMO the target, as
> after that stability guarantees should apply).

I don't believe in such guarantees. Different maintainers apply patches
differently, especially bindings, so this is beyond our control. Often
also beyond SoC maintainer control.

> 
>>
>>
>>> the dt-binding documentation pages I couldn't find anything confirming or
>>> denying that.
>>>
>>> I expect this to happen again in the future, which is why I'm reaching out to
>>> understand better how to deal with this kind of situation.
>>
>> Deal as what to do? Are you asking in terms of maintenance of some
>> subsystem or sending some patches? In this particular case here, I don't
>> think there is anything on your side to deal with.
> 
> I'm asking what's the most helpful way to you the maintainers for me to report
> these failures in the future.

The most effective way is LKP-like or Rob's-bot-like automated replies
to original email threads, by testing the original patchset on
linux-next. But Rob's bot is actually doing it, just on different base.

Other reports, like for cases when only parts of patch is applied, could
be also useful but I am afraid you will generate way too much of them.
Binding is supposed to go via subsystem, DTS via SoC, so basically 90%
of patchsets might have some sort of delays resulting in dtbs_check
false positive warnings.

For my SoC I check my trees, mainline and next, and keep adding list of
exceptions for expected issues. What's useful for Qualcomm? Konrad,
Bjorn, any thoughts?

Have in mind that expected warnings can be for entire cycle when dealing
with technical debt, because DTS goes N+1.

> 
> Rob has already automated running dtbs_check for patches coming into the mailing
> list. And I have set up KernelCI to run dtbs_check on linux-next in order to
> catch any issues that might slip through, or happen during integration of the
> trees, etc.
> 
> Now, if we agree that dtbs_check regressions on linux-next are acceptable, at
> least ones like this, where the issue is just synchronization between

Yes and no. True regressions are not acceptable. Expected intermediate
regressions as a result of patchset being applying, but not yet fully
applied, are OK. Expected regressions for intra-cycle-work are also OK.

> maintainers, then I can simply not report them in the future. But we should
> have some point where dtbs_check should not regress, and mainline release seems
> the reasonable choice, because if we don't then dtbs_check warnings would just
> keep growing forever.

I invite therefore to my session:
https://eoss24.sched.com/event/1aBEf?iframe=no
We'll see if they keep growing :)

Best regards,
Krzysztof


