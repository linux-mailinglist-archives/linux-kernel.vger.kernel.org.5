Return-Path: <linux-kernel+bounces-14469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6518D821D72
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE718285484
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C137210A0C;
	Tue,  2 Jan 2024 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cBYrHOUt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D631078D;
	Tue,  2 Jan 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704204832;
	bh=TNz2bBbjdA8ttdYkWZtPUW/GO/y4iF7ensfXnYtQXew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cBYrHOUtswoP4Jqju05wwfV4ZlcVuMtYSMafpUEfTvPis0o9a3XR64npMCLCQ/Zz+
	 NwrOPQ3bsW+l08qfZj3Hb/0Js697WCWxJoJNaok25S7VddTatB4MXU7F6In81wkesY
	 eSMXKsC06dZ3gxX18KbaE8aQZ+CcsM+uezBsX7Iw7KPhuArNL18iMq7p7FH3x1r4dw
	 fRK2VIDxhVrImFZZL9j/3TkgjbxkSoCc0o2JNAXEQbJSgkZjGE/TEX3uPA4XHp9kAj
	 KDV0OVWHcu9SupmQ73mQ03uEAogjQS60N0LinimJIgkT+XAYAFpU8LVaFA4E4DKmcn
	 Gol2qlV9XAyJQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AD3E13781FDF;
	Tue,  2 Jan 2024 14:13:51 +0000 (UTC)
Message-ID: <2c90633c-8d28-41e6-8c47-c58e1f1c3276@collabora.com>
Date: Tue, 2 Jan 2024 15:13:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8186: Add jpgenc node
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 bin.liu@mediatek.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, matthias.bgg@gmail.com,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Max Staudt <mstaudt@chromium.org>,
 Ricardo Ribalda <ribalda@chromium.org>
References: <20240102103801.268647-1-eugen.hristev@collabora.com>
 <20240102103801.268647-2-eugen.hristev@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240102103801.268647-2-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/01/24 11:38, Eugen Hristev ha scritto:
> From: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> 
> Add JPEG encoder node.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Max Staudt <mstaudt@chromium.org>
> Tested-by: Max Staudt <mstaudt@chromium.org>
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> [eugen.hristev@collabora.com: minor cleanup]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



