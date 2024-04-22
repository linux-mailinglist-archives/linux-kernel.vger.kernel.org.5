Return-Path: <linux-kernel+bounces-153195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9818ACAD0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E590B1C2130F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6BC1448E5;
	Mon, 22 Apr 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tBAQuJb2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2761448C6;
	Mon, 22 Apr 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782176; cv=none; b=EgUFByg72WNMKTHSivWC+gCfYJrh1RAT1v2Zp6YkEHwRkDYVK/pFjmoJWAy7dU1Hkm3iGsdUCUUd7rAOVWIonmkzuyfIMwJWRPZEJO1I2uO4jB+BnCl4MH0eEnmnHU5QSO/+TZQWHMAVBHr0Hgq+Q0ilJLSZydqlmYsFGEX9gX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782176; c=relaxed/simple;
	bh=qB9ESYnlpbBc8BQ5YozfKxN503oTQZjT1vyLxzz2ACA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJM0FgnC0WCotCI/9W7xPUZ+ysi5bdFM9jp+zyA0AQYmmRJREDPIYtNtEN3CM2CutbkA/4M2LPwVVMwBjp/rzH/we+lHsSC1AdnHbmR49RPr7icXjAXD2Zw1raHwAaWEVY8FUaknr70b5EGF0RHQPStJ+r4MtQQUk8hCmlUqtec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tBAQuJb2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713782173;
	bh=qB9ESYnlpbBc8BQ5YozfKxN503oTQZjT1vyLxzz2ACA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tBAQuJb2cAfsbp/fccSgu0p6Iv5kqUcLHBPBRZZUYpjxvp5ltUnL4Z5H2QOOnkbbD
	 CkBW3YMOe3NyAKYXoEOKB4/GpP7tZ+XxP5G7eYJ8d4fS0wlI12zQmezlNvaevjhQ8t
	 WwhViHbhgcVUK2SViflBgIT4b7DCmhVcWPkE2ZqQdR3wChS8/iKLle6r6o0xqywAsM
	 oB+6rX4OueyVW1SpD3VYSbghLnoebXABmhz1av7c+0PwkUz2q3M8ueJkfPBHTZY9E8
	 ScsNtOxemBBXsq0oUcf2g7B0Tvv+sa4Eg5S1TQB65J3jZevtiVC0vfTHwL6f73qIdq
	 8oMsgFqFCV4jQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B6E9A3780C22;
	Mon, 22 Apr 2024 10:36:12 +0000 (UTC)
Message-ID: <1b066d9b-866c-40d9-a65e-71a7ae85475d@collabora.com>
Date: Mon, 22 Apr 2024 12:36:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8390-genio-700-evk: remove
 spi2
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Yow-shin Liou <yow-shin.liou@mediatek.com>,
 Jason-ch Chen <Jason-ch.Chen@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240422093926.15392-1-macpaul.lin@mediatek.com>
 <20240422093926.15392-3-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240422093926.15392-3-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/04/24 11:39, Macpaul Lin ha scritto:
> Remove spi2 node since this is usually be overridden by
> dtbo overlay.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

There's no *.dtso for this board yet, so it's not getting overridden by any dtbo
overlay.

If you add one, you can remove this - otherwise, no.

Thanks,
Angelo


