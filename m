Return-Path: <linux-kernel+bounces-42519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8812684027C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB2CB21874
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC84759160;
	Mon, 29 Jan 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RLObF3y7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBEF55E68;
	Mon, 29 Jan 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522942; cv=none; b=bAqjLSsDYd6w3WbLUEMocC6APP8yVXRIGhFA2UfC3wsRVMC8BM846IGm5ewAWIre4aWSlCG8huu0MYMo3vT79EBxmAgy2UbvmEVPpWyPhHluYtj1wK658aid/xyPao3K/aYV1j551f/MKNfSl4mmJdDEU5ZixXE5Y6DsQQU+b58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522942; c=relaxed/simple;
	bh=p/Ph/5wfUOLH0/jsr9kMb9nbnht9W04o8BGEYL0ZXlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQLbycrCvjUPLSaGEiGzJUHIEauu3TL5uuBquEVyeB9hrWLV+R2KBhKkCzCaEX/uoLSARuZk41Iz4BUfu2jrSv4CQRDZTxbzwWphEn1iadrpbXUp7A4jkrlHRlp2Po9M8Q4T5AuSuanmEQzw2jZTezus8uxrTQn8MeOC+6yRtPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RLObF3y7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706522938;
	bh=p/Ph/5wfUOLH0/jsr9kMb9nbnht9W04o8BGEYL0ZXlk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RLObF3y7C+wTgpdgBNWYzSDZKeVB06dTonfrmUrlGixusmcNKY3kyp001vblJ1RSd
	 SxfLuCPynrmJdVLXSBbYgbNm/9FOLaSZBSOhITtr5rAdYT/+7tH6fhYOX1EV2PRCac
	 XrmfFLH11oSksB7eUBlxoIQPRcdkLNdClwbk4lGlqO4IsCOY2aXlZljsV4LkOl2G2p
	 0RhaSWd5TRtLB2PrmaT9hwwM61nEtg+2FszFDeeLU5TT0Lfnssdmy7oCNQ14BRxsnd
	 l8oFLAozz3u1jHvC6TNJEvSdHWWQjOBijojD9xcXnirf9m4YLT8kuecXF1nhCcuoo4
	 L/AL3JSGZJnWw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 45B503781FCF;
	Mon, 29 Jan 2024 10:08:56 +0000 (UTC)
Message-ID: <fe6904ca-c897-4705-a885-3c529f33323b@collabora.com>
Date: Mon, 29 Jan 2024 11:08:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] media: mediatek: vcodec: Fix kerneldoc warnings
To: Ricardo Ribalda <ribalda@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans Verkuil <hverkuil@xs4all.nl>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Bin Liu <bin.liu@mediatek.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
 Tianshu Qiu <tian.shu.qiu@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-amlogic@lists.infradead.org
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
 <20240126-gix-mtk-warnings-v1-1-eed7865fce18@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240126-gix-mtk-warnings-v1-1-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/01/24 00:16, Ricardo Ribalda ha scritto:
> These fields seems to be gone:
> drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c:57: warning: Excess struct member 'wait_key_frame' description in 'vdec_vp8_slice_info'
> drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c:166: warning: Excess struct member 'mv_joint' description in 'vdec_vp9_slice_counts_map'
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


