Return-Path: <linux-kernel+bounces-42562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F460840326
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915871C22421
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBA057883;
	Mon, 29 Jan 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PWiNFEaj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB357867;
	Mon, 29 Jan 2024 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525283; cv=none; b=efsw6u4sIiaPv3DW2/7XsxRjtueDXg2xW/cwWD5QuOg8oxdXujr7CWYWYqPXc7PRqt7Huc02m3p9yTSW7wrb5jN6leNDiwkMgZc9zKqiLU2GoElp6FQrIL2akjwH4B9AAehYDkc+R2tk/DM3ckJGXFGYyZ0j4nVqkrBesWV8Rx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525283; c=relaxed/simple;
	bh=xEqQM1fzy9szP+fpqrJ11n+/1aP8eVpnc7QXFhpkMec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6FHBorJMbjQplNqYtG375CigufAl0RD/s8DaG6wX1Pu8gin1v167Bkac5x4Xo1cYVFvHAXi0dAOuOPIUiPsUxkEF/PRK7Tngj3goVvOuYGuNAZZOfV1f0tbgNXN5r0W6avVIAqAxbvXcimffz8v9ULjWw1aZK9c/i2vbAYDTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PWiNFEaj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706525280;
	bh=xEqQM1fzy9szP+fpqrJ11n+/1aP8eVpnc7QXFhpkMec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PWiNFEaj6ZhhaWudOxKUE7+4KkASnAySS/YDm22TwFah+JKIH57MNUdRqrygzZ/l2
	 ckivlCZ3tgV5vCHKVsH5R77QdNxSXe2oyVN1o/QRgoejKWLhQOdfre6r/iOm0rIlkL
	 FRxe8kTulECeWbfVgT0INS2b2AjVAMXbdjv37H0Lu8BPTzN74DdbeXJxiWEtsIK9NC
	 8NUwmWg2ZAkMQI53FRmnFDwtUyqmGmjQ7H6p2rQ2vjm480F8B7bdHqUIWkjXCuaktg
	 ja0DYn+xufl6U6IsybIe9YdMVaxs84Y14f2v3kPU7v9rF/L8hjSEfo0MS2iSqdpz8i
	 gDo1A7ri6M0lg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 907F13780C1F;
	Mon, 29 Jan 2024 10:47:59 +0000 (UTC)
Message-ID: <282822ba-0e96-4078-a807-4b0b08e42014@collabora.com>
Date: Mon, 29 Jan 2024 11:47:59 +0100
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
To: tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
 Eugen Hristev <eugen.hristev@collabora.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, bin.liu@mediatek.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org, kernel@collabora.com
References: <20240127084258.68302-1-eugen.hristev@collabora.com>
 <170652472373.127352.5854831299483160743.b4-ty@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <170652472373.127352.5854831299483160743.b4-ty@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/01/24 11:41, AngeloGioacchino Del Regno ha scritto:
> 
> On Sat, 27 Jan 2024 10:42:57 +0200, Eugen Hristev wrote:
>> MT8186 has 4 iommus in the list, to cope with this situation, adjust
>> the maxItems to 4 (instead of previous 2).
>> Add also minItems as 2 to keep compatibility with current devices.
>>
>>
> 
> Applied to v6.4-next/dts64, thanks!
> 

Sorry, typo: v6.8-next/dts64

> [1/2] dt-bindings: media: mediatek-jpeg-encoder: change max iommus count
>        commit: b824b32dd5e98221cbe2e8bcccc6fb4134e35fc1
> [2/2] arm64: dts: mediatek: mt8186: Add jpgenc node
>        commit: 4c5b46fbf52d52b0f392f0fc3913560bad438e49
> 
> Best regards,


