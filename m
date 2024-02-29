Return-Path: <linux-kernel+bounces-86874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFDF86CC13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15FC1F2539C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A1B137772;
	Thu, 29 Feb 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="plEqwVnx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD4137750;
	Thu, 29 Feb 2024 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218318; cv=none; b=i0/cX2Mbw56+rtced9TgW2N1POUkv5j5rVnSlL6VQ/EKrikky0JqlbQOMp81FPGuqE0rC/g2RNOvItI18j13aQqPROrRUtV4dBcfdx9c2wT0qLasiA2yU6FYxghu9eiQd9QrOjAuOgAle4yXxJqNH1NTF9s4HykvPwGcc+QAm50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218318; c=relaxed/simple;
	bh=wrjX1gCWYg6nSC7PmaC6lhYpHs6jGe36eMWuYBSxilk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUcz69dvWZ193Kgjwn1XyLEB0WVKM1bm2ZusYIpAJQ2qIosEEYW2G02b9IMDE3C+olzHAnQyVqut5tm8/23HS6Zc2STa7e+Mh2Dj2qwgr24EBPmPXDx/zy5ZLZ/Yem++eMg6BP3Qli3cKMeUQSCp0VWPfHuz4l8Z550UBcpGp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=plEqwVnx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709218311;
	bh=wrjX1gCWYg6nSC7PmaC6lhYpHs6jGe36eMWuYBSxilk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=plEqwVnxYxepv2JEG/f9Bg/Gb93C9CmKhxp5jfucjO/sbNALZYICMpViFrBJ4r7xd
	 gnFN14JTKU2IOG3sbHdI0Az0Ckzapl0TEFAGw0oWyTtn8QdGUGmCMFvBdn8tvbPGQR
	 7JH4fOCOY4CkTB+0plwtFdBKVIVPMeKTa38Z6C8zBmXYXzK5BqBbTPAzDn+WXy0Caw
	 d4G5IXOdhVR/6XJy9Vie+p60BEEB02y7OTFGcWZugI0+83J3IHMPU7nzaG084tda0e
	 rLkJ7My88caQ6FW27ofQF45v6mM3g3wHuSj5EnOx+V5hkW/pWhRjmNSnPboOUzLOKp
	 ZZnJgmSZ8gb8Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1EDE33782079;
	Thu, 29 Feb 2024 14:51:50 +0000 (UTC)
Message-ID: <9e7e840d-59bf-42fb-8e7b-224afb9f27d8@collabora.com>
Date: Thu, 29 Feb 2024 15:51:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: display: mediatek: gamma: Change
 MT8195 to single enum group
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
References: <20240229144844.1688-1-jason-jh.lin@mediatek.com>
 <20240229144844.1688-2-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240229144844.1688-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/02/24 15:48, Jason-JH.Lin ha scritto:
> Since MT8195 gamma has multiple bank for 12 bits LUT and it is
> different from any other SoC LUT setting.
> 
> So we add MT8195 compatible to the single enum group to make its
> driver data settings can be reused by other SoC.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



