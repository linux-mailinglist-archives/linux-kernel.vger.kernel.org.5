Return-Path: <linux-kernel+bounces-86341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB6386C423
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F2E28330F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C278153E2E;
	Thu, 29 Feb 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QqUeHf2g"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27A53E2B;
	Thu, 29 Feb 2024 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196489; cv=none; b=DlzG8Pa6UDY1hw29jyWCwuNmSaNDIZhijIPIFoi+ID21ACpNVugdZR7+mb/qdwZ0mN/Jom6Lkv+YV7cMCK6jm9COIbydY8VnJrTooN66MZKHPVb4BVFYVGm7Psx0HxzqxV63BnwawdXg50dcl6xxr3HpGP2yS7heQNXZTsy+Wvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196489; c=relaxed/simple;
	bh=9+dpCXx7x8UpSu3QuELJTExwI0UUO/emZ4rDeXtx924=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJlSRWWx3bZ9sXO1Fkbvt5sgqXNdXQP4HB/VSv6V+9Oy598Pkt9Jq2gTdM+YlISannvr/YfabW7yg48fCtyu0Kv9vnzoLLGJFd6u+0qEEKJAee0QxV/fhgqFNc0QC5jXmZ417maPhEv1ZX/1R83QBnKpq5jqN2CesqyDmBCWuZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QqUeHf2g; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709196486;
	bh=9+dpCXx7x8UpSu3QuELJTExwI0UUO/emZ4rDeXtx924=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QqUeHf2gm7ya25wnu6E/Surks4FtpIdhdpaTZtIqhLZqXWuCUT1rBSm4Fz3y7d51H
	 qiPLYiz55uYSQgit4TpXAEG795vs9TecMRbNmJA6lBvIS6WuFj40bGj3PvTX/ENsH1
	 3LkJ8YBut8oDlQjXc6MymbwST6AFCZbuQoBPhA1Q92Zz7BGQzIp4Cv0IbFW6JoGNNe
	 o9QnxE9hcQ1JoySzCi4ROL5ssEd6l5UC6w+Ni3Kia6CrJWtqSiTMTmmSxkcD0I5+zX
	 lL6i6Y+xIn0Tu+a2V0txcd6imogZVCvUX1jg1UssxaH5faNL9I4HFAj324mBBBjKMc
	 KjzC8ZLfoDOcA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 39C3037810EF;
	Thu, 29 Feb 2024 08:48:04 +0000 (UTC)
Message-ID: <e1f772b3-cbe5-4d6b-b2cd-d6e10bd2121a@collabora.com>
Date: Thu, 29 Feb 2024 09:48:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/mediatek: Add gamma support for MT8195
Content-Language: en-US
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Jason-ch Chen <jason-ch.chen@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Fei Shao <fshao@chromium.org>
References: <20240229023522.15870-1-jason-jh.lin@mediatek.com>
 <20240229023522.15870-4-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240229023522.15870-4-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/02/24 03:35, Jason-JH.Lin ha scritto:
> Since MT8195 compatible is in the single enum group, we have to add its
> compatible into mediatek-drm component binding table to ensure that
> it can be bound as a ddp_comp.
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogiaocchino.delregno@collabora.com>


