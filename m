Return-Path: <linux-kernel+bounces-148298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809168A8087
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20571C212AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0FF13B7AF;
	Wed, 17 Apr 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NNnQV93m"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BDA137C26;
	Wed, 17 Apr 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348938; cv=none; b=SzBkxAAYpd30MVCMHYJtYYEfSjhX0mKV82thlLpEh4F7fouBrxHNyj/7P+CHq31wPPvq8eSXevcEP78aMgUDsoVKOSTpAw0VhQvJhdDaW+509Nw83LoUCIaD5y5rdI206G1dhuScEG0gjqSLnulE6RcsYBdbMNQ0wYwQd41pKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348938; c=relaxed/simple;
	bh=wDUM4X4Ysi+qIstEq+ysY7Ux3HsREZBqamdrLrY/+eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTkga+nKz+kyfNdKECQWUzry8VHm+HWezxVXVHSv0yG9j0YSJf2hVbFniGU4iuSt8nZ8F25kigPpgT4Z/UMW2J5ltaGMs/5zlr/DJCbbx7P8OsMoYP1zDfPeZ+VylfLrK06+9TkHn85S8ymClIiVYckBwWxSivKWqgi54JnGVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NNnQV93m; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713348934;
	bh=wDUM4X4Ysi+qIstEq+ysY7Ux3HsREZBqamdrLrY/+eI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NNnQV93mnxJuX7B3GIil2Zq6b1V01fdXRGrLRe7UT9FyhNdPKNhyp6JT0FkODDY/y
	 qBBAgKnzT3M+zXXbqKm9s7BZHxW1sOx2d83aeUw6o/5BZKdy4pjgWq2ggG/P+myF0u
	 nibHeRLGD3V5Y2s6KPSZKcHIeDG0Tdd6Yer+Ay/KSb04VnnSuc15P1hUboYcSPO646
	 4OPhEFiolH7t1BraY4UztSSkKjHtfbULcihCCmT+lLD4VALPEbq7noDaGvENl/pXKW
	 XbH2s/qQK6XRR7ZeEH+yj6VPN/JSdWdGxqNXLi8dBOLY5TmDLePqXaPTpnU/wcngug
	 26KlK2rcNGuKA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5D662378020A;
	Wed, 17 Apr 2024 10:15:33 +0000 (UTC)
Message-ID: <c603af5f-fe37-4bd6-aa27-7a797d11f1ae@collabora.com>
Date: Wed, 17 Apr 2024 12:15:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/18] dt-bindings: display: mediatek: dpi: add
 power-domains property
To: amergnat@baylibre.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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
 linux-clk@vger.kernel.org, Fabien Parent <fparent@baylibre.com>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-6-33ce8864b227@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v2-6-33ce8864b227@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/04/24 17:53, amergnat@baylibre.com ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> DPI is part of the display / multimedia block in MediaTek SoCs, and
> always have a power-domain (at least in the upstream device-trees).
> Add the power-domains property to the binding documentation.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Please add the relevant Fixes tag and resubmit.

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



