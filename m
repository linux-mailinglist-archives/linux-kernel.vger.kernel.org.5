Return-Path: <linux-kernel+bounces-66706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26A4856071
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AFC1C201EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56F412DDA9;
	Thu, 15 Feb 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3xpIKCTi"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A212DDA8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993986; cv=none; b=QZrStholV5EqlCDjzhBdA9FGqEwxwvvoPDxw7HRdFqGi8xkH3Wojo4CmYE3G4W22EWrmFR1v95oC2tRi3iU0rtEpIUqc99u+XYHl0IeKKc+TeVEiJYZL5xPc4WXRet8BEIx3U2P/B/rbYvZHH0PHKa8gCmXytyoaCcZrnDu7lHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993986; c=relaxed/simple;
	bh=YbT37hERPMotSbqysWVXhccVGhmIL5NWBAzDOuVxwJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijlxUzo+5qBiFpu6GMAC4c+BtqU1qCD3+sVuzFcP3yG2g11HluIyXoLwJmO05DQdTwdFqKdcMIcaUl5FuXbn+h8qaKEaz4L5mVthGCsFd4iPhbfAfS74sr9ug5lvSN1Sj3Z4Pey5yoF/hXo4KXUGlYR/4ExERfTRacyOasbnAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3xpIKCTi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707993983;
	bh=YbT37hERPMotSbqysWVXhccVGhmIL5NWBAzDOuVxwJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3xpIKCTiI4T2EIGKteQ1V5vk5Ykel3u0GclVdzPNz2BVTzI+JuiTpjFJ9OO8VrMQn
	 Q7Z12jsjx/DJGyab5s9d0jv5M1DhUkaHD9hyLV4yn+5mnONLSWcXJ8ysyRtBQJXJEZ
	 3TzWRL2OpuvR3gZxxAZ1xkgqbwJoNEhlG5cmPL4b8uWp+/RZpR41s5Ys24593D9hUX
	 SBiPR2kqz7O06TpoKA+buky6hJincltVxPygzHSYS8cjkSY/FxJgwkYJEGGafwqNWA
	 4xlA9DWhjyFSIV6DVNOgifAVu72GEMWw4gMQZzy+kQ+W28gal2MX2ddqJuVh2taRHY
	 qXnHq6ptKefnw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D0DF83780FC7;
	Thu, 15 Feb 2024 10:46:21 +0000 (UTC)
Message-ID: <96cbca68-052f-42dd-a410-da9061d54c06@collabora.com>
Date: Thu, 15 Feb 2024 11:46:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/13] drm/mediatek: Support alpha blending in display
 driver
Content-Language: en-US
To: Hsiao Chien Sung <shawn.sung@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
 Sean Paul <seanpaul@chromium.org>, Fei Shao <fshao@chromium.org>,
 Jason Chen <jason-ch.chen@mediatek.corp-partner.google.com>,
 "Nancy . Lin" <nancy.lin@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240215101119.12629-1-shawn.sung@mediatek.com>
 <20240215101119.12629-8-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240215101119.12629-8-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/24 11:11, Hsiao Chien Sung ha scritto:
> Support "Pre-multiplied" and "None" blend mode on MediaTek's chips by
> adding correct blend mode property when the planes init.
> Before this patch, only the "Coverage" mode (default) is supported.
> 
> For more information, there are three pixel blend modes in DRM driver:
> "None", "Pre-multiplied", and "Coverage".
> 
> To understand the difference between these modes, let's take a look at
> the following two approaches to do alpha blending:
> 
> 1. Straight:
> dst.RGB = src.RGB * src.A + dst.RGB * (1 - src.A)
> This is straightforward and easy to understand, when the source layer is
> compositing with the destination layer, it's alpha will affect the
> result. This is also known as "post-multiplied", or "Coverage" mode.
> 
> 2. Pre-multiplied:
> dst.RGB = src.RGB + dst.RGB * (1 - src.A)
> Since the source RGB have already multiplied its alpha, only destination
> RGB need to multiply it. This is the "Pre-multiplied" mode in DRM.
> 
> For the "None" blend mode in DRM, it means the pixel alpha is ignored
> when compositing the layers, only the constant alpha for the composited
> layer will take effects.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



