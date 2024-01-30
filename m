Return-Path: <linux-kernel+bounces-44144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDCE841DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02171C25319
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339945789A;
	Tue, 30 Jan 2024 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Elw8/dTC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FAC56B71;
	Tue, 30 Jan 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603711; cv=none; b=nRcmiiKsmQ5LxgFAa3A73Dzwg+I/hdYw/KiBZv+yjS5G0YFz1Ss7Twzho6boMFhdZlMrvTd2n07H9YBJR2PDi3IVnUTueV9QRdU5aCiEVSQywv1kDZiHGhUe3+50COfCUwrCrLTHJRysEsB9LogaJ8n8r8SPjjoQ7IB2g4zHKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603711; c=relaxed/simple;
	bh=ipSQZFRis56pggEB+mlu51XG4bdnhA2PgLn++wV8MzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzNiTHasvKYKXLIWKGXBy4N8BpX+NnfO9584tupO14Lk97pmoo4FPD12q4eSNoaJZARuM7zlm4Tc9ZgvJ0HY0nSCNPRL+QqSrw65AV6H/KSHZj4Qq0ZJYyPK9GVPIgSwSpLURg1H1uO/TF5x/Y8PFntR/CEsbK74fV/vApoO1nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Elw8/dTC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706603701;
	bh=ipSQZFRis56pggEB+mlu51XG4bdnhA2PgLn++wV8MzI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Elw8/dTCiBK6tty1acjgrWaZ2rIZZW7BW8zKxbcM1J91nyz7izwXaKaFacPdD1KdH
	 Vu5D1uxLKbB4pjtPJcxy5XcoMgtxFIPm0fwy/Az6SjbD1swppW4J6DzK1+43e5M2yK
	 a9Hkg3K4r2EWmEgNet2ha6Ma1nlA5KQTSsYmFwM6cYES9AMCx39Ef7u+4cAFaCKdd8
	 fS/uAZZ94Oxy1cyppzAerYSUW++15B8fURFxS6kXUPlHRRyt0Hdva0OcK8S2gVWS0Y
	 Y12Gy62x8cKWywo9z3fupNx313PfLhwiwW6LVrMRsuxszJ8lN6i8sghhX7Rgl6dM94
	 Q+ArkV8ouIVKQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D33A23782076;
	Tue, 30 Jan 2024 08:35:00 +0000 (UTC)
Message-ID: <2a918b33-eb95-40d2-9a96-8799e86c66bc@collabora.com>
Date: Tue, 30 Jan 2024 09:35:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: media: mediatek-jpeg-encoder: change
 max iommus count
Content-Language: en-US
To: Matthias Brugger <matthias.bgg@gmail.com>, tiffany.lin@mediatek.com,
 andrew-ct.chen@mediatek.com, linux-mediatek@lists.infradead.org,
 Eugen Hristev <eugen.hristev@collabora.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, bin.liu@mediatek.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org, kernel@collabora.com
References: <20240127084258.68302-1-eugen.hristev@collabora.com>
 <170652472373.127352.5854831299483160743.b4-ty@collabora.com>
 <bf79f44f-5fa7-4341-8deb-605503d33c7c@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <bf79f44f-5fa7-4341-8deb-605503d33c7c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 29/01/24 16:46, Matthias Brugger ha scritto:
> 
> 
> On 29/01/2024 11:41, AngeloGioacchino Del Regno wrote:
>>
>> On Sat, 27 Jan 2024 10:42:57 +0200, Eugen Hristev wrote:
>>> MT8186 has 4 iommus in the list, to cope with this situation, adjust
>>> the maxItems to 4 (instead of previous 2).
>>> Add also minItems as 2 to keep compatibility with current devices.
>>>
>>>
>>
>> Applied to v6.4-next/dts64, thanks!
>>
>> [1/2] dt-bindings: media: mediatek-jpeg-encoder: change max iommus count
>>        commit: b824b32dd5e98221cbe2e8bcccc6fb4134e35fc1
> 
> Hm, not sure why you took this one, as DT-Bindings normally go through the 
> subsystem maintainer trees. Otherwise merge conflicts can occur. Just saying.
> 

That was done so that we don't get devicetree validation issues on our branch;
eventually, there were no driver changes to support that binding change, and
it's there just to validate commit 2/2.

Of course the media maintainers do know about this so there will be no merge
conflict - but yes next time I'll let them pick these instead, it's probably
easier for everyone, besides simply being the proper thing to do.

Angelo

> Matthias
> 
> 
>> [2/2] arm64: dts: mediatek: mt8186: Add jpgenc node
>>        commit: 4c5b46fbf52d52b0f392f0fc3913560bad438e49
>>
>> Best regards,


