Return-Path: <linux-kernel+bounces-148305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE13F8A80B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9311C2140B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFDE13C8FB;
	Wed, 17 Apr 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G1QBEvdS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015E13C3F9;
	Wed, 17 Apr 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349173; cv=none; b=hH0eTdgwezy5672SxYAWa9LnUpuy23sWcZ8CXXzt2UBqpHXCQHqJeNuZtcJ9EfvY3Bxd/My1fBISTl3PF1N3XgNCmlF7Jr0voZZ0qU1PNoWIKhkkPOmksS8IYEqYfyC6qU80XayoQ4S63bQdKVNPooqtPAYfhyQ4qD8mNS7TibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349173; c=relaxed/simple;
	bh=rtVJ5+PB9noO22V5MS255NdCXXQMOWIvUIKCZ3a6zTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdqhe6y3rfmLHzCjHSSt14LXwqRqAtLQQnZN/XcpFNLHZOXP6KsGEH6xFH+Xpy953ufdz1qLIGYDWq+eLpa/A+1yg8skg71h5k5L5wnkWwCcPHipVCVC3BsBX1nBwEkOs006Of0cXIgWMZmkjy9biHf4/AgGnUSbQg8d3KFDSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G1QBEvdS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713349170;
	bh=rtVJ5+PB9noO22V5MS255NdCXXQMOWIvUIKCZ3a6zTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G1QBEvdSaWBNUUxlG3VAR8oD0+OQDUKG+Use8eHDA1zFOkMkVfLPur/ZSwqKm2Osa
	 /dLgBd0DqVUzCE4PZzEo/jxMo3j2gwH+oKWIe8SrrMJA/YJJLFYuKGyUjpUwKrR44i
	 DoneY7PugSC5RppjrgWaVSvoLRVXe4YQVh5Z2PywR9BQfEZseUAlwaTdBQ0Sovx8bf
	 eOdYp7DFbeMD/4mnc6iHgY6He/IJaEcmnJWgXFk86D11tdO3O2Lo2CNybCpfKXi894
	 oFdSq1EutIFc5k9ILvc5R2FA0PmE2p06z/E86qfLcCO2iQ9ibT+ksWwfwn5YiTrdu5
	 aBOqbhCLqfjcg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D01B137820F1;
	Wed, 17 Apr 2024 10:19:28 +0000 (UTC)
Message-ID: <a1e7bdcc-5d1a-4866-81d0-9d34273632e8@collabora.com>
Date: Wed, 17 Apr 2024 12:19:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/18] dt-bindings: display: mediatek: aal: add
 compatible for MT8365 SoC
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Jitao Shi <jitao.shi@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-1-33ce8864b227@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v2-1-33ce8864b227@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/04/24 17:53, Alexandre Mergnat ha scritto:
> Document the display Adaptive Ambient Light on MT8365, which is compatible
> with that of the MT8183.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



