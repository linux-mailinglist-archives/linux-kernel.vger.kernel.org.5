Return-Path: <linux-kernel+bounces-121319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F99C88E5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485A72978D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F6B136E34;
	Wed, 27 Mar 2024 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BiKre3Op"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11B12DD8B;
	Wed, 27 Mar 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543802; cv=none; b=cq9BUF4yfhyN5kwFTWTpFgWL3+llVpTQaf1vf/p5DqzPpZ0JlROu/IcplP5H1gRWiBSpShbcYoXFUpbuesj4uNoZjLWup/Vwm2zgoOfuWJyFR0uh9+eXq80nrbhJbYZgIBV8O9HErbvQ4ktfdkx+2K9allbQd/aAYrr6xoc8aag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543802; c=relaxed/simple;
	bh=ABclRLb/R2quz1tOh/euCSegn/zdsYmPz6ReeOO+m9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1iP/67h73J5MJtihzqoDYlNkGt/9tutZwBmls04XZQd2DAy8vvdKlrtkztCwfd9BhUAi38g7Rv6/CPGv8Qmi5yqWW+4ykd1ZQZCfxpKHTcYBFevWFUbshgd4hlas9jTj/s0Xhxq9imi6KAfJbsxKd+zKBacPvsTENoTf4k3mMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BiKre3Op; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711543799;
	bh=ABclRLb/R2quz1tOh/euCSegn/zdsYmPz6ReeOO+m9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BiKre3OppgksMn0qvlTpqn8PN0VPd9qAcm+ZlikA9ppXxvpgRiGG2jIaEq3ZXdZyJ
	 LchSpMT/XOSWQj/OuZb07xVg0mdSi1CpU4HIXgbPIpUMG7ZjJG7vXlWEVwBvhQcR/k
	 pPZ7g04SXUECZgRkNqMRRKkJ3bcWuQ+bMomk6kgyVcfJFBsJg0fmm9tbqrmSnrb5Pw
	 zWlVrLfq+IikZG1mwpDiVAP0tWrihYvHlk4My5pvGEYHbI3xDvk+Hnls9VfdEiz2Bd
	 /ZiLlRTNWNKhxlIKhOjnwZKRyPzcpCLm07y0MEklL605qdgVw+IMGDhZPyNEIPE/+W
	 FA/Crc/1Czv4g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B2BF237811CD;
	Wed, 27 Mar 2024 12:49:58 +0000 (UTC)
Message-ID: <9ef4e974-740e-4698-bb38-f236521a425c@collabora.com>
Date: Wed, 27 Mar 2024 13:49:58 +0100
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
 <ZfxRyMyUqyqtXy8n@p14s>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <ZfxRyMyUqyqtXy8n@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/03/24 16:27, Mathieu Poirier ha scritto:
> On Thu, Mar 21, 2024 at 09:46:14AM +0100, AngeloGioacchino Del Regno wrote:
>> When probing multi-core SCP, this driver is parsing all sub-nodes of
>> the scp-cluster node, but one of those could be not an actual SCP core
>> and that would make the entire SCP cluster to fail probing for no good
>> reason.
>>
>> To fix that, in scp_add_multi_core() treat a subnode as a SCP Core by
>> parsing only available subnodes having compatible "mediatek,scp-core".
>>
>> Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/remoteproc/mtk_scp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
>> index 67518291a8ad..fbe1c232dae7 100644
>> --- a/drivers/remoteproc/mtk_scp.c
>> +++ b/drivers/remoteproc/mtk_scp.c
>> @@ -1096,6 +1096,9 @@ static int scp_add_multi_core(struct platform_device *pdev,
>>   	cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
>>   
>>   	for_each_available_child_of_node(np, child) {
>> +		if (!of_device_is_compatible(child, "mediatek,scp-core"))
>> +			continue;
>> +
> 
> Interesting - what else gets stashed under the remote processor node?  I don't
> see anything specified in the bindings.
> 

Sorry for the late reply - well, in this precise moment in time, upstream,
nothing yet.

I have noticed this while debugging some lockups and wanted to move the scp_adsp
clock controller node as child of the SCP node (as some of those clocks are located
*into the SCP's CFG register space*, and it's correct for that to be a child as one
of those do depend on the SCP being up - and I'll spare you the rest) and noticed
the unexpected behavior, as the SCP driver was treating those as an SCP core.

There was no kernel panic, but the SCP would fail probing.

This is anyway a missed requirement ... for platforms that want *both* two SCP
cores *and* the AudioDSP, as that'd at least be two nodes with the same iostart
(scp@1072000, clock-controller@1072000), other than the reasons I explained some
lines back.

..and that's why this commit was sent :-)

P.S.: The reason why platforms don't crash without the scp_adsp clock controller
       as a child of SCP is that the bootloader is actually doing basic init for
       the SCP, hence the block is powered on when booting ;-)

Cheers,
Angelo

> Thanks,
> Mathieu
> 
>>   		if (!cluster_of_data[core_id]) {
>>   			ret = -EINVAL;
>>   			dev_err(dev, "Not support core %d\n", core_id);
>> -- 
>> 2.44.0
>>



