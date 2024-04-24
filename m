Return-Path: <linux-kernel+bounces-156681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499068B06C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCAC1F2437C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88005159202;
	Wed, 24 Apr 2024 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LrpEhTZj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65E0158DC7;
	Wed, 24 Apr 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952836; cv=none; b=poniKgtPUUqURmFFnnR3m44vi59zSwfwpLnKO+vf/CYI04ZwP3qf4J77mv9BCPPgSONvUIsu+NRuO51zOgkv/+KpzXLMgje67fLIWW3gzGxIeBamVIailS3ISylb+8KvjIUYJJlSbANZRYdt9CwLRdsrD5Q2Z9aLXsZmI/1AFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952836; c=relaxed/simple;
	bh=uQASEV2BynAx1WUK7KoYyrhPrcyeJFPB5nX/BTtJdV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKOemNABNXUsMzSK6bWY2g7sL0U5tg4iZmHaP7iqCkuXk8CZch4miiRKbJTBjNgc/6DcP/RG6QKbrfA4LmVo8XZC00om2tmSB4IKyrjSY/i+Y8DPkgVhy9zR8BXzPf7tvmf+C8TJXqrORcEPpxMFhq8nQJ+vUorjOINFEAtuRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LrpEhTZj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713952832;
	bh=uQASEV2BynAx1WUK7KoYyrhPrcyeJFPB5nX/BTtJdV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LrpEhTZjFLvzi7YmQ253CkCVdNbi5T+p1cA9t6bNrSa2r9+YLJ7y14iIqqQ6Gg1LM
	 PFBGEmg4TJq33Z/hKeSwPeAuIb3BCmZ2xPXDzJEl0zo/dsYcq+PIUDnB4iLxmyVFmO
	 cmkwwdt4Ee/S9a7/uXT7UUnIYWT4diLSzCGin+HykszfQBL8E4d40AHbr/qvEhc7gR
	 Ys7DdyLC3rUe3j162sA33f8j2tf8CLtezZcKKTEAJh4FPJfAlwnxsbeDwkBDz7zM9J
	 V6tBS49DfMDLquCUmdAb1zcaAX0E6lZWyOrx1FVobJz2iNZFD2TL5pT9pjDxNqIdd9
	 SP2RKSQBx2LWw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DDAC8378107C;
	Wed, 24 Apr 2024 10:00:31 +0000 (UTC)
Message-ID: <84acccf1-b356-4e7d-8335-d782adaa6bfa@collabora.com>
Date: Wed, 24 Apr 2024 12:00:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] remoteproc: mediatek: Support MT8188 SCP core 1
To: Olivia Wen <olivia.wen@mediatek.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Tinghan Shen <tinghan.shen@mediatek.com>,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 jason-ch.chen@mediatek.com, yaya.chang@mediatek.com, teddy.chen@mediatek.com
References: <20240424030351.5294-1-olivia.wen@mediatek.com>
 <20240424030351.5294-3-olivia.wen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240424030351.5294-3-olivia.wen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/04/24 05:03, Olivia Wen ha scritto:
> MT8188 SCP has two RISC-V cores which is similar to MT8195 but without
> L1TCM. We've added MT8188-specific functions to configure L1TCM in
> multicore setups.
> 
> Signed-off-by: Olivia Wen <olivia.wen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



