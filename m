Return-Path: <linux-kernel+bounces-127696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB87894F9C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5B71F256B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F75A4CF;
	Tue,  2 Apr 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yALmyE4v"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714B58AAB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052622; cv=none; b=kSZJBhmOinzRa2NVMlhTF2VhH1lP4+EYilYOv/yU7CjJGB63v5/HJURjt/nmlRuDdYD6kpKS8jaUP8G+Db4CDiYS/eJrHCCRrgASz+crgYiehqTcjXReckMGz/YhRQJq0YAnQedrDwMEvV2YzcstO2le4iPgJugK83zfx4sPE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052622; c=relaxed/simple;
	bh=0kebiPk3tKa7/IHwyWmTQTorTf80HcI+vNk71eLMMfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFnkhQrM+TUk09wU+jm3RHan7kkRvArD2ZmAoMBZAGgJcJ9k45WaW4v4bHd0/zRctr1LRAjkMJEuCxfmc1by9wIbqEHyAuY/Do62cCcURdRsBLT8GU5OYdKrheBOXc0QXJzgMjLHtrWRy+8L5CuEutp9wutcBtl8XYDWiFEf0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yALmyE4v; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712052619;
	bh=0kebiPk3tKa7/IHwyWmTQTorTf80HcI+vNk71eLMMfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yALmyE4v5Uk7/0unVC+y/UOxPUvStllE+5MALfnESMk/JZnZY2xEGUMFxLXHXmOYZ
	 DDR8xv67oMX6e0PabhS+CU7bsYYMORlBGN7WK1LmSzwmeJZNMOQfgt1JOlEK3WiwXs
	 rs+LOrM/FPBTNRUOhGsyWvIctp0xDzdsQ4oHpxZT7oOtpP62tYvIieFRkVeQOf0cOq
	 0MoBi1S/8C/5pvOP0WlDF1qP1x3wAaG3mgesYR7vJStVdLUOfMp92hRqqNPoxN/iBo
	 haLCdCu03AxewvFtNfVtgznCxrf2O2rG7Uu/qxNhEhqZ7UTx9TIW8M7NIa/E4GunlL
	 n6tL3q1UjIGbA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A4FA237820EE;
	Tue,  2 Apr 2024 10:10:18 +0000 (UTC)
Message-ID: <e3746b1b-fe23-4205-a5f4-2fb8ff6a9fe7@collabora.com>
Date: Tue, 2 Apr 2024 12:10:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: Init `ddp_comp` with devm_kcalloc()
To: Douglas Anderson <dianders@chromium.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: CK Hu <ck.hu@mediatek.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, "Jason-JH.Lin"
 <jason-jh.lin@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Nathan Lu <nathan.lu@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240328092248.1.I2e73c38c0f264ee2fa4a09cdd83994e37ba9f541@changeid>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240328092248.1.I2e73c38c0f264ee2fa4a09cdd83994e37ba9f541@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/03/24 17:22, Douglas Anderson ha scritto:
> In the case where `conn_routes` is true we allocate an extra slot in
> the `ddp_comp` array but mtk_drm_crtc_create() never seemed to
> initialize it in the test case I ran. For me, this caused a later
> crash when we looped through the array in mtk_drm_crtc_mode_valid().
> This showed up for me when I booted with `slub_debug=FZPUA` which
> poisons the memory initially. Without `slub_debug` I couldn't
> reproduce, presumably because the later code handles the value being
> NULL and in most cases (not guaranteed in all cases) the memory the
> allocator returned started out as 0.
> 
> It really doesn't hurt to initialize the array with devm_kcalloc()
> since the array is small and the overhead of initting a handful of
> elements to 0 is small. In general initting memory to zero is a safer
> practice and usually it's suggested to only use the non-initting alloc
> functions if you really need to.
> 
> Let's switch the function to use an allocation function that zeros the
> memory. For me, this avoids the crash.
> 
> Fixes: 01389b324c97 ("drm/mediatek: Add connector dynamic selection capability")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

P.S.: I really dislike the dynamic selection stuff, as that's only a partial
solution for something that should've been in DT from day 1 instead.
P.P.S.: I took care of that already - a series is about to come in a few days.

Cheers,
Angelo


