Return-Path: <linux-kernel+bounces-61221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051CF850F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394F4B220E8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B56310A10;
	Mon, 12 Feb 2024 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WPdiy/GT"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1A2F51F;
	Mon, 12 Feb 2024 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727867; cv=none; b=RfJ6D9qT920KEXOc+pY852BQJsWhegyFj07oiWJ4OYbWj8ZPKINn8t5Zs1+zSd7WkT3XWZEmOklcZVQH8BiRyE0xncX69WdMUqZi5iY1hUchiS+glAoXSTio7+cjtWmj9R1mfCIq5qZjpAMeahC2HaAudwkoBOya8QXyIC+mOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727867; c=relaxed/simple;
	bh=JfOQqLAkSvqpY8InqNZrSpNTGBxtk7MPqEk2psMnHnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHqF/0zFiUS6WCnqh384qbQCf13DFw6ZwHrULjuR3/OJ78w/SxrcBIfUGyq5KSdC+cbU0bTQyBwtZg37tkTCuG9j3JeNsZZ337Dfjh/aP+oZMf2/FiB8aul6DYWZj+w8KImcHrgh8jjIR4s+6mOSFGEFns8Hj5SRvrIymTQ4Xg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WPdiy/GT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707727863;
	bh=JfOQqLAkSvqpY8InqNZrSpNTGBxtk7MPqEk2psMnHnc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WPdiy/GTbV7ftpYhOdATDPnX8DbMbe/fcmli9lcD5SUC/9/X5ps2bEDi7ntRQOcEJ
	 vpJog6qEVW+f1DJD6kbZW3QVlMRy3dCuXna3zz6ftF83Xo52aC4zXIQvEyDJ0I1wP2
	 +bg6BPMGtsVjk+6RzbzHJzCNcKVLtRNR6kWvibqSc2r4AFi5AUENsUewN6cS0P5zYa
	 0fm6zC/K7Vafiwwh8s6TM+6MfYpgPHjuxag8wxusSUj/ZnoH8/L0moGr/LVChadZMv
	 1Qbr7VzYaMNW6FTpnz3b8Qj0cg5aWMVCu7DVT4dXY6qCaveGJWAJclphF3uaUvQTDq
	 RCBj14PPxdEDA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 211D1378203F;
	Mon, 12 Feb 2024 08:51:02 +0000 (UTC)
Message-ID: <c3488bc9-f55f-478a-b8fc-274f40fb0818@collabora.com>
Date: Mon, 12 Feb 2024 09:51:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: net: wireless: mt76: add interrupts
 description for MT7986
Content-Language: en-US
To: Peter Chiu <chui-hao.chiu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231221032648.641-1-chui-hao.chiu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231221032648.641-1-chui-hao.chiu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/12/23 04:26, Peter Chiu ha scritto:
> The mt7986 can support four interrupts to distribute the interrupts
> to different CPUs.
> 
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



