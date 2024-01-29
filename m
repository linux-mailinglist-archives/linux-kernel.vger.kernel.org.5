Return-Path: <linux-kernel+bounces-42541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F328402D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82109285670
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2FC5787F;
	Mon, 29 Jan 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BInki8l7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275456B96;
	Mon, 29 Jan 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524331; cv=none; b=u2ZJjZ990WHPblLB6iwID8s8szlYrvpvVu1mKcq7Lul2YEmGFyVRKI8oEsKfQa+jyPN5hvY902mHu3wD2DdYeJbMCWu9XtUQQrasK40UsEVHDU6HECtRc1OXpWtaBV6SoE3ZfA4itVi432wPimkYDQIbEwA16hYtNGcC+jqSCaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524331; c=relaxed/simple;
	bh=Kw1lj15Qbi2VspPbsVRk7AoiW6W+CJ78QBpDv6oRZ5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvtC1+/Hv73lQ+9Ffn+KLzWsp39+mPa6KzhiRyP7//3PfLk2d5/t6oIvNpPRKuDXvhZTvQqB5/eHWGH6EKLc1yVjiAI+0BoYTkyRB4ftCV8bYwcOuCHq+j4m2oGGVDcVB7QZM9vyu7O+AWzNJXBuV3pBk8SxxWNAKJlMVp7g4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BInki8l7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706524328;
	bh=Kw1lj15Qbi2VspPbsVRk7AoiW6W+CJ78QBpDv6oRZ5M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BInki8l7s8YGSvbUkuui9ovLkxveKFX3sa1/BLZvHt9I1vbNH4VSZ7ssDoxlTuVnp
	 khFmezlVJH5zIAI/QAKlVp24B9GSGhAG8J/tdMMyF5A2ChVi6RqdQQNhXwXwAlLacD
	 4tF9b00MTFmkloorpEqzQYhlMQ/tHqX6K6TYQV49hn0T8EowcMx4AFZhFow02U6Lxq
	 BldG8He3rANbHJXOwAzdrmdPf227q3R1jM1xGb0UeeZhEwSVybuAwdqecu3mql3jKu
	 9b9+kCWVwW+xMoHn4uzsf7gcKChQ3NKUoC3zoqAJfJ+6fWkoMVfbCJ1ez+WQi+F/DD
	 Yn4GduU4XfVCw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E83A33780C1F;
	Mon, 29 Jan 2024 10:32:07 +0000 (UTC)
Message-ID: <54553c4f-bdf9-4f26-9d32-2f12d62de0ec@collabora.com>
Date: Mon, 29 Jan 2024 11:32:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: mediatek: mt8186: Add jpgenc node
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 bin.liu@mediatek.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, matthias.bgg@gmail.com,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Max Staudt <mstaudt@chromium.org>,
 Ricardo Ribalda <ribalda@chromium.org>
References: <20240127084258.68302-1-eugen.hristev@collabora.com>
 <20240127084258.68302-2-eugen.hristev@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240127084258.68302-2-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/01/24 09:42, Eugen Hristev ha scritto:
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



