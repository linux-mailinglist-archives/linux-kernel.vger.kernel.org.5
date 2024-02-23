Return-Path: <linux-kernel+bounces-78130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CD4860F51
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57664B279DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4C5D91B;
	Fri, 23 Feb 2024 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AITRzPou"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819555D906;
	Fri, 23 Feb 2024 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684214; cv=none; b=PKukYik8NR7S4lpuXlZglu5plwRyCSWJL0lvjHgSkFO3o31xjuZ9/wfSOfQ1HMR5zKaF5LWS/ovW6ef0AVCVs9HwF8iELRP2nb6eX892d3KH8gkjiKoMKMf/1umcX/ke7RcrI9vI1naM4yDz0kHRgqxBxxmbvvGLJFCNMmXQN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684214; c=relaxed/simple;
	bh=a5wsB2yzzq4HgC/3HlvIPTX8LqprZF/u+NXqYmbqYW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oveXDV0eWlzoOvh52kNogaWPsBrcyBjEi2lhM0hP1oL4lvGXo6NXWdfEYqwJFq3uO4HrCqa+wykEMA+5qUWbusKdhK5iQxV/+Jow1hpO/33bDi81qSPSGOkceKewsVluQMImjc2k4mgbeRlqQJreVaJuy9NZl3M17hDRGH9i5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AITRzPou; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708684210;
	bh=a5wsB2yzzq4HgC/3HlvIPTX8LqprZF/u+NXqYmbqYW8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=AITRzPoueMRYeP57son9yL6hAeAgXHSh8sWxepR3jEGc2Mp36bHj3vHMYYi+J7aEx
	 tFcIxI397gK1+nh3flb50/8ug7TbRyAyDAKtTc4o3yOzg3wdF1pRBPZ2/OfekKUju1
	 ib3ph1KHl+R3jvap1mX0iSkEOpiech1UU5Us0C8emgMpSqp23Pk19Mwm1epvnxJLST
	 GmWULOC0PkTfYbbYBfgWC6aKawmvgh0wS9L4yjWUNTrzcbFvi90WHpE8nnT5bXg0uS
	 1EumBITbZZDinPGrDEzkCaNX87LUD4sUdF/qvawmv+5EhkewYtAlW8QFmdr3MEu3aD
	 1rsOgo4/wQfkg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E127E37820CF;
	Fri, 23 Feb 2024 10:30:09 +0000 (UTC)
Message-ID: <c365c2c8-8211-4e36-8ba1-8b4638e81039@collabora.com>
Date: Fri, 23 Feb 2024 11:30:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] soc: mediatek: cmdq: Rename cmdq_pkt_jump() to
 cmdq_pkt_jump_abs()
Content-Language: en-US
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Moudy Ho
 <moudy.ho@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20240222154120.16959-1-chunkuang.hu@kernel.org>
 <20240222154120.16959-4-chunkuang.hu@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240222154120.16959-4-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/02/24 16:41, Chun-Kuang Hu ha scritto:
> In order to distinguish absolute jump and relative jump,
> cmdq_pkt_jump() append absolute jump command, so rename it to
> cmdq_pkt_jump_abs().
> 
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



