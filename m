Return-Path: <linux-kernel+bounces-128140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D076E8956C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898E2287DA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA781292EC;
	Tue,  2 Apr 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fBMTao+x"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4FA8662E;
	Tue,  2 Apr 2024 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068395; cv=none; b=pw0Y5sQArvIDdvtPCGS5OLcDAM++gRCiqO3lioFXTqSvwhdq8XwUQhlvHpe26qOcj+RUPZCxksgbc6Zzejf4ez1NKMCC4B9j5B5sRURXWhyCFaIVzZ8YQpxtQHCn4LhzlYNg5z4IHY3BQrjHabDk444V+S7V0F4A0d+DkfQnv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068395; c=relaxed/simple;
	bh=k9jpeeTQRulLlydfpwC6l14dlccqbsTGqCf2ynVuYi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OX//N74CPMm3NXUcqyaq9eu8hMVhHx2Wm5ZG3ZGSRz+rVbRPahddrcTTypAE/alrJD6yDE/hztYliezKJqh0vEfN2g36j4syKc9yWRCLLlCAOjbS1uzrvJzCuV5WvwosXXB2UF6RJ/NtDZm0QMzLJ6zkCXt1awmJQp7DEPpToGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fBMTao+x; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712068387;
	bh=k9jpeeTQRulLlydfpwC6l14dlccqbsTGqCf2ynVuYi0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fBMTao+x11ZZxsEye6B1rpE+VCfhdJsJEjGqi5K6sYPkJRIsjLpxbcoYZAPt3Lmw3
	 0Dm5fUPMVs19etqTkb2movClXqHhAgw3RPoMOJa5EjRArLD5N17NNs9SvB7sMYarhu
	 +ruwYVRyPK53FXPcoplIBsC3PBr9n3tLjaiYh+25ATNZaB0+epp7/HqSnBzuJW8PRn
	 xOMVwv3At1j+V8GzryFc0utZGQ0Fttgb4sbcRvKN1frouteerZzW1Y+kEDDWubM1vV
	 3dR5SeIgeWjBJtAhvclke5ndjcVQ6BtJNewk8BVtkjsUeiK6OQmSHeEBukIMIjos9e
	 n+3AwmaA6htOg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 181A93780624;
	Tue,  2 Apr 2024 14:33:07 +0000 (UTC)
Message-ID: <1f38ce24-83fa-4370-b036-b6c4bcb39fb3@collabora.com>
Date: Tue, 2 Apr 2024 16:33:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] remoteproc: mediatek: Don't parse extraneous subnodes
 for multi-core
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: andersson@kernel.org, matthias.bgg@gmail.com, tzungbi@kernel.org,
 tinghan.shen@mediatek.com, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, wenst@chromium.org, kernel@collabora.com
References: <20240321084614.45253-1-angelogioacchino.delregno@collabora.com>
 <20240321084614.45253-3-angelogioacchino.delregno@collabora.com>
 <ZfxRyMyUqyqtXy8n@p14s> <9ef4e974-740e-4698-bb38-f236521a425c@collabora.com>
 <ZgWA/E46i/CaoM74@p14s> <b6ed8710-1608-4343-8a58-5f8e0e16d10d@collabora.com>
 <CANLsYkyu69Pwv094XGfVomuu1Oixw3vxr42q6WOE4F3snATygw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CANLsYkyu69Pwv094XGfVomuu1Oixw3vxr42q6WOE4F3snATygw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/04/24 16:23, Mathieu Poirier ha scritto:
> On Tue, 2 Apr 2024 at 03:56, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 28/03/24 15:38, Mathieu Poirier ha scritto:
>>> On Wed, Mar 27, 2024 at 01:49:58PM +0100, AngeloGioacchino Del Regno wrote:
>>>> Il 21/03/24 16:27, Mathieu Poirier ha scritto:
>>>>> On Thu, Mar 21, 2024 at 09:46:14AM +0100, AngeloGioacchino Del Regno wrote:
>>>>>> When probing multi-core SCP, this driver is parsing all sub-nodes of
>>>>>> the scp-cluster node, but one of those could be not an actual SCP core
>>>>>> and that would make the entire SCP cluster to fail probing for no good
>>>>>> reason.
>>>>>>
>>>>>> To fix that, in scp_add_multi_core() treat a subnode as a SCP Core by
>>>>>> parsing only available subnodes having compatible "mediatek,scp-core".
>>>>>>
>>>>>> Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
>>>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>>> ---
>>>>>>     drivers/remoteproc/mtk_scp.c | 3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
>>>>>> index 67518291a8ad..fbe1c232dae7 100644
>>>>>> --- a/drivers/remoteproc/mtk_scp.c
>>>>>> +++ b/drivers/remoteproc/mtk_scp.c
>>>>>> @@ -1096,6 +1096,9 @@ static int scp_add_multi_core(struct platform_device *pdev,
>>>>>>             cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
>>>>>>             for_each_available_child_of_node(np, child) {
>>>>>> +          if (!of_device_is_compatible(child, "mediatek,scp-core"))
>>>>>> +                  continue;
>>>>>> +
>>>>>
>>>>> Interesting - what else gets stashed under the remote processor node?  I don't
>>>>> see anything specified in the bindings.
>>>>>
>>>>
>>>> Sorry for the late reply - well, in this precise moment in time, upstream,
>>>> nothing yet.
>>>>
>>>> I have noticed this while debugging some lockups and wanted to move the scp_adsp
>>>> clock controller node as child of the SCP node (as some of those clocks are located
>>>> *into the SCP's CFG register space*, and it's correct for that to be a child as one
>>>> of those do depend on the SCP being up - and I'll spare you the rest) and noticed
>>>> the unexpected behavior, as the SCP driver was treating those as an SCP core.
>>>>
>>>> There was no kernel panic, but the SCP would fail probing.
>>>>
>>>> This is anyway a missed requirement ... for platforms that want *both* two SCP
>>>> cores *and* the AudioDSP, as that'd at least be two nodes with the same iostart
>>>> (scp@1072000, clock-controller@1072000), other than the reasons I explained some
>>>> lines back.
>>>>
>>>> ...and that's why this commit was sent :-)
>>>>
>>>
>>> Please update the bindings with the extra clock requirement in your next
>>> revision.
>>>
>>
>> Ok.
>>
>> Can you please take only patch 1/2 of this series so that I can delay this one
>> for a bit? I don't have time to work on that exactly right now.
>>
> 
> It was added to rproc-next last week.
> 

Ah, sorry, didn't notice that.

Thanks again!



