Return-Path: <linux-kernel+bounces-56496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0D384CAD5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92328B23101
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BF67604D;
	Wed,  7 Feb 2024 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VQGTaYAO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1781A76044;
	Wed,  7 Feb 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707310003; cv=none; b=QPgLHmVh/rLzbYGK77v7P4O8cI+w1TBOrT4av2wd97p5Zqd/TdHtVgf5PxiZ3J2QEvgGSnSFVQRLilSyULCVsMohFlX145z6OTAS2FAODOsFeo8Ac501mCVO09NbeA06Qc81O+4IcYzwYu1p8edQGuqAOIaTittzdCKlrFkhtYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707310003; c=relaxed/simple;
	bh=iTpYch75tcd9ZP7LW6ilopgE85q/9ga/hzmsirOsblg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVijszrHqIc39gG20lMMlM4JbaAxUJsC0rV4IwpFGQa1O8QcS15okrL2zj0cYQ94S8mS2F+uW2ZeDIiJn4D4UjV5lpz81VIJSNjPAfdshwGCO8PaSVrO8lMbToZ6348QQrI0OWdkHCVG4SZ8K7nG4jqVqJgUu4hWDALS4Bu3d9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VQGTaYAO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707310000;
	bh=iTpYch75tcd9ZP7LW6ilopgE85q/9ga/hzmsirOsblg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VQGTaYAO4UXkiE0SOdaExAt58ciEwIUI3p9ZgpZEu+eCNSJxgbpxPs2NOIfFTeiR7
	 Ejg7EiYSdzzI7FECNLfqmcv/vDBRoa6nYNtgdrqgiAiurXxYo16CKpsK30eiU5OGIE
	 1azFEDU2fWDxFLpi35B9jYhbGZjIQ+navGvU6rIG+6e6KL13IVN3C/BNIJtEP22Ydh
	 PmVnuxsbLojV6DqTRizND8lKy+tTq4Y6EXiLCkIwy3HBsAINd3sb8TRnv+apYRwDG/
	 Nntuj2uPQfgUbo/DRbXnW43pjmZUE8B+61OjrxN9RGSPsIw3GPMKYmrxuTEBiqbLrZ
	 JxSBt4tZRxDQw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 933E337809D0;
	Wed,  7 Feb 2024 12:46:39 +0000 (UTC)
Message-ID: <b4018932-2fcb-4a15-9ec4-e29e5761d3e0@collabora.com>
Date: Wed, 7 Feb 2024 13:46:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] spmi: Add support for multi-master
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240207-spmi-multi-master-support-v1-0-ce57f301c7fd@linaro.org>
 <20240207-spmi-multi-master-support-v1-1-ce57f301c7fd@linaro.org>
 <CAA8EJpqsJmv36=o1aTjVH6eMHXMg8BHNpiDvs+Q8YB23ezVGtQ@mail.gmail.com>
 <ZcMvFtAwQQjAZhk6@linaro.org>
 <CAA8EJprqWLX7_yWZzKp3FAKFGkSkk041f9hj1uXuRBrbH5APyQ@mail.gmail.com>
 <ZcNIddeG6VHxBEOQ@linaro.org>
 <CAA8EJpo-16u34Yc6MLmHSqFrQ0VrZAq6TwGeVc5WFwMmhruqoA@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAA8EJpo-16u34Yc6MLmHSqFrQ0VrZAq6TwGeVc5WFwMmhruqoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/02/24 12:45, Dmitry Baryshkov ha scritto:
> On Wed, 7 Feb 2024 at 11:08, Abel Vesa <abel.vesa@linaro.org> wrote:
>>
>> On 24-02-07 09:23:09, Dmitry Baryshkov wrote:
>>> On Wed, 7 Feb 2024 at 09:19, Abel Vesa <abel.vesa@linaro.org> wrote:
>>>>
>>>> On 24-02-07 01:55:39, Dmitry Baryshkov wrote:
>>>>> On Wed, 7 Feb 2024 at 01:34, Abel Vesa <abel.vesa@linaro.org> wrote:
>>>>>>
>>>>>> Some newer SPMI controllers support multiple bus masters.
>>>>>> Such a master can control multiple slave devices. The generic
>>>>>> framework needs to be able to pass on the master id to the
>>>>>> controller-specific driver. So do that. The framework will
>>>>>> check if the devicetree child nodes are actually bus masters
>>>>>> and will register the devices for each master. The legacy
>>>>>> approach will still be supported for backwards compatibility.
>>>>>
>>>>> Please remind me, are those two actual bus musters driving a single
>>>>> bus in parallel or two SPMI buses being handled by a single device? In
>>>>> the latter case this implementation is incorrect. There should be
>>>>> multiple spmi_controller instances, one for each bus. Allocate them in
>>>>> a loop and set ctrl->dev.of_node after allocating.
>>>>
>>>> It's two SPMI buses (two sets of wires) handled by the same controller,
>>>> HW-wise.
>>>>
>>>> If we register two spmi controllers with the kernel framework, it will
>>>> be HW inaccurate, because there is just one controller which has
>>>> multiple masters.
>>>
>>> struct spmi_controller is a controller for a single bus. Inside your
>>> device you have two SPMI buses, each can be controlled by its own
>>> struct spmi_controller. Just like devices that control multiple I2C,
>>> SPI or USB busses register a separate instance of the bus controller.
>>
>> Well, this is what this patchset is trying to do in the generic part.
>> The SPMI controller supports multiple buses (HW-wise) and therefore SW
>> implementation shouldn't be tied to single bus requirement.
> 
> So, after the off-line discussion:
> - add new compatible string for sm8450+
> - register two spmi controller instances

Well, I don't know about the actual hardware that you're trying to implement
but, in my opinion, the "idea" of this series does actually make sense.

The SPMI specification says that SPMI supports up to 4 masters, and up to
16 slaves.

Just my two cents.

Cheers,
Angelo

> - drop the master-id from the SPMI interface
> - optionally: think about having a new separate driver for v7 SPMI.
> 
>>
>>>
>>>>
>>>> I'm not saying it might not work. But, to me, it looks more like a hack.
>>>>
>>>> Basically, we would be mapping HW bus masters to kernel controllers.
>>>
>>> Buses, not just masters.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>>> ---
>>>>>>   drivers/spmi/spmi-mtk-pmif.c |  6 ++--
>>>>>>   drivers/spmi/spmi-pmic-arb.c | 10 +++---
>>>>>>   drivers/spmi/spmi.c          | 76 ++++++++++++++++++++++++++++++--------------
>>>>>>   include/linux/spmi.h         | 10 +++---
>>>>>>   4 files changed, 67 insertions(+), 35 deletions(-)
>>>>>
>>>>> --
>>>>> With best wishes
>>>>> Dmitry
>>>
>>>
>>>
>>> --
>>> With best wishes
>>> Dmitry
> 
> 
> 



