Return-Path: <linux-kernel+bounces-96665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B291D875FAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DA61C2082D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEC252F6C;
	Fri,  8 Mar 2024 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="v9NtW7Be"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D652F6B;
	Fri,  8 Mar 2024 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887095; cv=none; b=qzWAUae6VQpHD/zL9qNWdn6V1FVgcTbcmDjZNh76gTC97QKig9dIbXj6dgAt4AuTIaorUvDjfdVMUAmHJlEexUz1SAOFJPKYC5602mPuLVcoNVBp5wKOpd+N/iPoSiz/kGU0OcGUFA7SaKivtd9wzR1j5jWoKLkdwECucynACco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887095; c=relaxed/simple;
	bh=x/iJ/njqsFro++xvJFXW2s3sHRF1jcLiv3ix3nVesq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlmiHd8F8iKYMk5Aht+c42/7pJsZoORPFmU5Y3CmGn+1y0bmOmRjfJUEspprHIptttd4ITxJxvYCJ+PbIthCkuVx/5Xgm4ItJKxZ009vcNju7NQ8i5iKnHB8xgeX05dNBHXOWQA2cdNlpMHIsEA9L2M1iIIfJVq8eBFwBDjKpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=v9NtW7Be; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709887092;
	bh=x/iJ/njqsFro++xvJFXW2s3sHRF1jcLiv3ix3nVesq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=v9NtW7BedkJvfuiL7yLJL7SveyiayjRZzA62fg0l/uLog+i05oBxPbaIDGmI9/IoQ
	 2Ti8emiQYx98Q2cY5JQ1zkE6IuklbIpDSQL0rWTNta/a90cBsPHbDX72AC1/KH8zvj
	 /ccP/Q5HX53OdIUBw95nwy60kIBeK5nPLHwOgTMkwbOohkmapQ1FlIcjabl57rhUcF
	 VSDoz8kkZGFLRDLadN2rRWOVCFsas3F3q0VGeFL7ITlr5a7gZHMezCaqs/BbZF1MWZ
	 7RupJ3NQaV7ZFSPnP38iF+niUSlhW1Y4RPqKMqPx6R5nNCeeHTTyYAY6qBFVa3xFzV
	 FXjDwzVhAB+3w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6903337813CA;
	Fri,  8 Mar 2024 08:38:11 +0000 (UTC)
Message-ID: <89d6a820-d510-4549-8097-76670fa36e6a@collabora.com>
Date: Fri, 8 Mar 2024 09:38:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: timer: mediatek: Convert to json-schema
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>
Cc: daniel.lezcano@linaro.org, tglx@linutronix.de,
 krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20220929122901.614315-1-angelogioacchino.delregno@collabora.com>
 <20220929122901.614315-3-angelogioacchino.delregno@collabora.com>
 <CAL_JsqKrad8JndQhxHAYjFXPkj7eaJ0GXqkSJy=xrfa=EHvOwA@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAL_JsqKrad8JndQhxHAYjFXPkj7eaJ0GXqkSJy=xrfa=EHvOwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 07/03/24 19:15, Rob Herring ha scritto:
> On Thu, Sep 29, 2022 at 7:29 AM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Convert the MediaTek SoC timer txt binding to json-schema.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../bindings/timer/mediatek,mtk-timer.txt     | 47 ----------
>>   .../bindings/timer/mediatek,timer.yaml        | 86 +++++++++++++++++++
>>   2 files changed, 86 insertions(+), 47 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>>   create mode 100644 Documentation/devicetree/bindings/timer/mediatek,timer.yaml
> 
> Looks like this never got applied. I've applied it now and added 8365
> which got added to the .txt binding in the mean time. I'm not sure
> it's right though. The txt binding says it was CPUX timer, but the dts
> says otherwise. The 6795 dts looks wrong. It says the timer is CPUX
> and GPT timer. That warning remains.
> 

Thanks. This one got totally forgotten, yes.

By the way, I'll recheck the 6795 DT as soon as possible.

Cheers!
Angelo


