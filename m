Return-Path: <linux-kernel+bounces-66689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E72E856040
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F6289B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4FE131E30;
	Thu, 15 Feb 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lLDSyuor"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221DC131754;
	Thu, 15 Feb 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993642; cv=none; b=Khp8ykPcSbFkTFKWUyS8C/ZByZ+uTDBKI1/qH5vClJ1Y2d0O/cVhgM/kffcxAP3W1SQZvpUaSmwFqOKaVy/sNZwsJ1ANDGCGg9Hh/sxvu585FAQUXbFM5yw1FI2bZEBnuptgmn5rdfBsFjrVSP4LDEH1zYTrVM56CHpPuSWudKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993642; c=relaxed/simple;
	bh=Z2I/2iS1wg6hKZc0HSZWdzEp3y5P2j0JmOn+KktqECE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uKPALx7D7dvAqnptU2Z/B72rIOK28CV3tQED1aPLbo3h9p7IN+Oc+UsX+IXkw6HEGBIC2JhcVQ9+0Dd3ovsn8bTv7LmiEj73ylr85aDP0mEQDQ6dMi3GnVxHu/hDwmVgFUyiCawtds9hJV2jCYyO43vGHazLldlBdj7XOcNCzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lLDSyuor; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707993639;
	bh=Z2I/2iS1wg6hKZc0HSZWdzEp3y5P2j0JmOn+KktqECE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lLDSyuorzfgMILXk5YCfu2LUE2BOOMbM38F+LNMj0yCjj0cV3mtSUg9aKseaNlpA9
	 VFf5wAynXJKAD5JXp4NvZQyI3dOozcIdTskAgixzriXkcB9hikPUPhGZMjnh4ct1bB
	 c08IPM2vCJILsmzrfWzWaHkbJU0OQVScC0CoCt1zSM85IWtpvoxk5PyQ41LUiRVhpA
	 n6sra+3LWtPdiJWL2d1SwsZEWv7A7yzQrsBflzpCbjVVN0znHwqQeomvFITsaRWj9j
	 PEAUVv0LdiMDeDBBYEzb7yvh3+WDQNnGIVe35XYKE+N/ZtsPWBYGkQPn2rxWHmD5Zd
	 3+OzjmgGwSGig==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BA51C37820B1;
	Thu, 15 Feb 2024 10:40:38 +0000 (UTC)
Message-ID: <8f34e44c-48d7-43b4-ae6a-827d4e3fa122@collabora.com>
Date: Thu, 15 Feb 2024 11:40:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] drm/mediatek: Drop calling cmdq_pkt_finalize()
Content-Language: en-US
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
 <20240215004931.3808-6-chunkuang.hu@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240215004931.3808-6-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/24 01:49, Chun-Kuang Hu ha scritto:
> For some client driver, it want to reduce latency between excuting
> previous packet command and next packet command, so append jump
> command to the end of previous packet and the jump destination
> address is the start address of next packet command buffer. Before
> next packet exist, the previous packet has no information of where
> to jump to, so append nop command first. When next packet exist,
> change nop command to jump command. For mediatek drm driver, it
> never has next packet, so appending nop command is redundant.
> Because cmdq_pkt_finalize() would append nop command, so change
> calling cmdq_pkt_finalize() to cmdq_pkt_eoc() to prevent append
> redundant nop command.
> 
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Makes sense.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



