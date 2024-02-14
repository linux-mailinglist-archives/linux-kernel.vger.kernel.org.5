Return-Path: <linux-kernel+bounces-65504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78DB854DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A332C28DBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A71B60247;
	Wed, 14 Feb 2024 16:18:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA67C5FDD5;
	Wed, 14 Feb 2024 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927520; cv=none; b=pJ7u5l/6ySdAheg4dv4DavsNHXwZrt0JAixd8buKgd6z/IfzM+S81e9qDxYMevmVbXGNiPVDQIIXClb6OSjzjQO7p5DLNhQl2sfLegqH772KPGd7B5ssVG3kvnozC3GKWXAX+Lc4aMr4JCevrEa9Nd3iy9KTPvfpowpE8eApiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927520; c=relaxed/simple;
	bh=iqVM3Nbl0mt1+TLQBiJZGR5wCnWn4U71gfKB9sZvOfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAXWUqtj4vm0GFbeidIbyheuTtuB4aBg5k9Su6nC4hAfMJKYsNy0upDmwEmUcwCD4zJHsNULJFgoBM0ao5GmRWJI9361+JWJRgql0Mv4rOrsuHc6m7vG6/3jbLxZU58rf83aJmrvGRSFwasOfrWLOPaeh19SWq2Tj5v4zxTnq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA7A11FB;
	Wed, 14 Feb 2024 08:19:17 -0800 (PST)
Received: from [10.57.49.250] (unknown [10.57.49.250])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCDDB3F762;
	Wed, 14 Feb 2024 08:18:34 -0800 (PST)
Message-ID: <729a4c17-9e86-467f-85cf-652c503fa14e@arm.com>
Date: Wed, 14 Feb 2024 16:18:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename
 qcom,dsb-element-size
Content-Language: en-GB
To: Rob Herring <robh@kernel.org>
Cc: Mao Jinlong <quic_jinlmao@quicinc.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Tao Zhang <quic_taozha@quicinc.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
 <20240213160521.15925-2-quic_jinlmao@quicinc.com>
 <20240213222957.GA2502642-robh@kernel.org>
 <c70df5a6-20af-4cee-b147-5847751fa36b@arm.com>
 <CAL_JsqKdAzPEGh941S05kraTjOcEpsPCnDRkppNkb8pBCpZu6g@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAL_JsqKdAzPEGh941S05kraTjOcEpsPCnDRkppNkb8pBCpZu6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 16:03, Rob Herring wrote:
> On Wed, Feb 14, 2024 at 9:56 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> On 13/02/2024 22:29, Rob Herring wrote:
>>> On Tue, Feb 13, 2024 at 08:05:17AM -0800, Mao Jinlong wrote:
>>>> Change qcom,dsb-element-size to qcom,dsb-element-bits as the unit is
>>>> bit.
>>>
>>> That may be, but this is an ABI and you are stuck with it. Unless, you
>>> can justify why that doesn't matter. (IIRC, this is new, so maybe no
>>> users yet?)
>>
>> This was added and support queued in v6.8. This change won't make it to
>> v6.8 (given it has to go via two levels and is technically not a fix).
> 
> I'd argue it is a fix. But given no users yet, delaying is fine.

I agree it is a fix, but not something that maintainers would like to
pull it during an rc cycle. As you said, since there are no real users
for this yet (and given it is all under a single vendor), it may be fine
to queue this if the DT maintainers are OK with this.


> 
>> As James also pointed out, it doesn't matter what the name is (now that
>> it has been published).
> 
> v6.8 final is what we consider published.

I can't send this to Greg as a fix. For v6.8. We can fix it for v6.9 cycle.

Suzuki
> 
> Rob


