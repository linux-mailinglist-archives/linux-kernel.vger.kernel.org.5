Return-Path: <linux-kernel+bounces-116698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC3088A2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACDE1C36035
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882B213C81E;
	Mon, 25 Mar 2024 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0BBCJUwJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669213C837;
	Mon, 25 Mar 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355406; cv=none; b=e+DKnm42NfCSD1cnAlZfYc+9RRSr/Cjesud8LPAJtmsevfYlEVqw6dXnEHB3FwY/+06CaDjMVN56UZO4R/83qb0lgWxcATr3t53PSzOu8mUxhsKq8VSzo0rs6bjyPU5uT0vjyU1FpVUGLJswdNTeuYiB+CXHI6BnbPDTt7Dpt20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355406; c=relaxed/simple;
	bh=WcjRvdfQ2EbQum9xWCjkiEU3kMs3JIEIAvUpABV232Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0TaETEwEWNWbH6IesDIyQ20cIcavnrjDpgRJTAmVkm3bzTzJOnccQIpKC1g/bRMOS8FXmRapIB2xO6ycCPmJ3kRFL8X9nEX8Ke4+/vv9Mg81Bh321O85UH83sln9hYQdgJ8Q1hNcepngpFPAKcsFYH8EMqIsQlentOs5Pa6ooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0BBCJUwJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711355403;
	bh=WcjRvdfQ2EbQum9xWCjkiEU3kMs3JIEIAvUpABV232Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0BBCJUwJ7vWjw3HrU5xaFXwV+xSULegmhfamw+lIn+trZZQiFHhl9jk1mZ2Q2cjYo
	 AiIAWSTeFlM9byqnX0Z2lMbZ/EAnx95k6Ojb3pEmJgkj2mAvV4BPVyWRK9XTCTBX5x
	 brzFmnzKmSQvTEca4b8Q7/u+cQocbgIGCUfap8KdtQDcWJJxMphuDCVUSYd09SroRa
	 g2uDARjYNHVfL089PTtXe2DXFayNNbKeOB30fEpDeT4EP6Qc61+wOuFLg+71+PZlLD
	 z10N5ghqVJsOkm6U9iOtTkG64KpuBSbWqIDaIZZmgzBuXEBx23ht9I6I64fnmD07Ul
	 pbvLZPF0sk5Lw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 883D7378209C;
	Mon, 25 Mar 2024 08:30:01 +0000 (UTC)
Message-ID: <26c3e4e6-89b2-4411-b55b-8fad80d38c75@collabora.com>
Date: Mon, 25 Mar 2024 09:30:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] media: dt-bindings: i2c: add GalaxyCore GC05A2
 image sensor
To: Zhi Mao <zhi.mao@mediatek.com>, mchehab@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, sakari.ailus@linux.intel.com
Cc: laurent.pinchart@ideasonboard.com, shengnan.wang@mediatek.com,
 yaya.chang@mediatek.com, Project_Global_Chrome_Upstream_Group@mediatek.com,
 yunkec@chromium.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 jacopo.mondi@ideasonboard.com, 10572168@qq.com, hverkuil-cisco@xs4all.nl,
 heiko@sntech.de, jernej.skrabec@gmail.com, macromorgan@hotmail.com,
 linus.walleij@linaro.org, hdegoede@redhat.com,
 tomi.valkeinen@ideasonboard.com, gerald.loacker@wolfvision.net,
 andy.shevchenko@gmail.com, bingbu.cao@intel.com,
 dan.scally@ideasonboard.com, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240323014751.4989-1-zhi.mao@mediatek.com>
 <20240323014751.4989-2-zhi.mao@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240323014751.4989-2-zhi.mao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/03/24 02:47, Zhi Mao ha scritto:
> Add YAML device tree binding for GC05A2 CMOS image sensor,
> and the relevant MAINTAINERS entries.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



