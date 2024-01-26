Return-Path: <linux-kernel+bounces-40668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC3A83E3DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65E92874F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2A624A07;
	Fri, 26 Jan 2024 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tzsgxdhU"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976411DFF9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304227; cv=none; b=PqjkLzwHzyXCoWT/MxWKjxCiDJLLjnDCWIUFFJb0fNG/Rabu4amY5n4frBtvf4jAVUxYO/+rzFyvnxNV1n6STIDNyEOjWOa9pLSOk2qNeWP9o8UEjP+z7cFfAI9a2qmyB8adZnNAd4hHe1wjq3LGVgz161DbIdW/kZWGNCejubI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304227; c=relaxed/simple;
	bh=mngwzQ1tW4ra+TgOhuZhs7sUcDu+H/klAorbuEgjoBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMWpey7qRJYdfXTmixQ63sJYDdTBQrg3Vxqild4uWiY952RESFaOx8eWJnFY9nhbE3HAStb9WrZeWBOka/lWL6+ruaVi6qYikuYCqEy/Xj/Mi8a2Ag4aLxQCLUrvuZhHgHSCGZP8hUHFlzUjayxLhvUbCEatfyhkOAyGxjHScEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tzsgxdhU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf2adac1ccso8911461fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706304223; x=1706909023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nb6lh03t2Y/P5wpyJLZs3j8XPaxvw2LYek8NlAlQ38A=;
        b=tzsgxdhUhDxcUjZimCLtlJodtzfOf09iSvVwif/+29kyNMvY0GVI51cgioc+K69riV
         cOgCUzcUIGK9IAmIqCofsynzXkSmsh6zgmyUT0L+SoGdAtL6zLfEebpWtSXXUPeLeJz8
         wnDjRs1AlBXd5qBSPQk+rQvU1ajlLFDuYlUsd2R+UAGV5AVdY5JeBDc96HvZoV/Wis+8
         EcsY2QPJugr1MmvOT72rXQ9KScrc8Q3j3+52onQW2DXLFRMhlmG+NB+LPj1LXBzFCRBQ
         5/8091tJgSKpkY089We9R8W6adjd5wcfk8gVE7rSXNccnz0xEDhduoEQFCENPl/iZBoQ
         4w+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706304223; x=1706909023;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nb6lh03t2Y/P5wpyJLZs3j8XPaxvw2LYek8NlAlQ38A=;
        b=AzWtnhAzCAmNh5omajcKLd544d51+3lTmSOOI341SydV4eoI1TJN8v8YbZmyKUVD2f
         t+HgwSgRiLoObrGQinmY1VvG3gs8G4AWCsf9Y9CtuQEydNLNFq41EkNwZr+xSEtTgK2d
         bzi92zSa47AXaI/Duuh2k/otb4aT7zwmPKHYC5Lj9x33J2YTEgxvPhSaFn9auaNENrtG
         sHmBazsqJ502iRG8Bv0QQtKFftag3/nnhD2ARq2GY3qX3QQKiV7UGClzgksJbZcmfBGr
         8x0YTNfx5od/PAh1mSawyJZ6ZBltlOwB6s5CQMX3/4KLI1JODwLyCiRAcZ602M5JrFLy
         SXxw==
X-Gm-Message-State: AOJu0YzrKjY3IAaSC9138dNLAVrb/NX5PuFAc7KEEBzyl1ljaLdmKmEL
	1fg7y1l/Na82ADOY2oRS0xjQXqqU5fSDOkremo1bn7/hab69toW1yGjrl0pLsOI=
X-Google-Smtp-Source: AGHT+IHgPyi0JRFd4/vgCp62QKGLsOfwgqtNUV8jYGIesmhciNt34fa6WdWZ+P+cC+dVYi3kqi9uhw==
X-Received: by 2002:a2e:5c84:0:b0:2cd:3663:979d with SMTP id q126-20020a2e5c84000000b002cd3663979dmr284037ljb.0.1706304223477;
        Fri, 26 Jan 2024 13:23:43 -0800 (PST)
Received: from [192.168.231.132] (178235179146.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.146])
        by smtp.gmail.com with ESMTPSA id ba30-20020a0564021ade00b0055d07073cc6sm999494edb.80.2024.01.26.13.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:23:43 -0800 (PST)
Message-ID: <f28604d2-20a8-4662-9412-f09c6bf4a67b@linaro.org>
Date: Fri, 26 Jan 2024 22:23:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: Introduce additional tsens
 instances
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240126-sc8280xp-tsens2_3-v2-1-8504d18828de@quicinc.com>
 <ZbPfeq6ElA3vMf_O@hovoldconsulting.com>
 <20240126165113.GS2936378@hu-bjorande-lv.qualcomm.com>
 <ZbPlRsx3czAHRBew@hovoldconsulting.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZbPlRsx3czAHRBew@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.01.2024 18:00, Johan Hovold wrote:
> On Fri, Jan 26, 2024 at 08:51:13AM -0800, Bjorn Andersson wrote:
>> On Fri, Jan 26, 2024 at 05:36:10PM +0100, Johan Hovold wrote:
> 
>>> Shall you submit a follow-on patch to set the polling delays to zero
>>> for the other thermal zones (cpu, cluster, mem) so that we don't poll
>>> for those?
>>
>> I optimistically interpreted Konrad's response as a promise by him to do
>> so ;)
>>
>> I do like his patch which remove the poll-properties for non-polling
>> mode. Would be nice to not first change the values to 0 and then remove
>> the properties...

That was my intention as well..

> 
> No, that should not be an issue as it allows us to get rid of the
> polling without waiting for a binding update which may or may not
> materialise in 6.9-rc1.

If you really insist, I may do that, but if the thermal guys act on it
quickly and we negotiate an immutable branch, we can simply but atop it,
saving the submitter timeof(patchset), the reviewers timeof(verify), the
build bots timeof(builds) and the applier timeof(pick-build-push)..

> 
> But whoever updates those properties need to do some proper testing to
> make sure that those interrupts really work.

They seem to, check /proc/interrupts before and after adding an e.g. 45degC
trip point on one of the CPU thermal zones, they fire aplenty.

Konrad

