Return-Path: <linux-kernel+bounces-116697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF99888A2AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901D61F3C029
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE83131BCA;
	Mon, 25 Mar 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MrBm0YvQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904113C82A;
	Mon, 25 Mar 2024 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355404; cv=none; b=aXoDLxNE0iCPGa6EH85FCUS7+foxstPohUPWbKw3XsAr/3wKSECX7q/CoI5mnyFl+ECKt1T2TDBxXws8oIG1TvGMi4wCTarPYSn0K7YFu+ptn5uK7vzTJnE3xsFzzWa91FrysfjAksDmz/TPFGPjmY7YnuZpgKAaRg/824kQyoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355404; c=relaxed/simple;
	bh=h//CRCGD0d2uWLlCN+oZeO5mCD2Cg8zsTxqX7sO+7k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDrwkOApoChcWFl+n3iTzZC/cZMfVAkv1axzkFGojbLIbnoV7zT18FA6rK/kUIrZNBLG/0WU6ct929q+GkZVI/Vxp0guEmH6WZvQCH2Vk1OlfodCyiT9BtMQP1NO2oCdkCdRYQKHjxO85HrZiSDhQf2iMMVqprRbDk7AO9zg+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MrBm0YvQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711355400;
	bh=h//CRCGD0d2uWLlCN+oZeO5mCD2Cg8zsTxqX7sO+7k8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MrBm0YvQ2wj43Xa4m0qGLAj2InrmGYBOv7ocrTWilwNht2ogn6buEk12a49ONDu6c
	 caUY1+gsZTPHaf/NP9z92M9tweUc69i74xaj7+fCXBL4BfVn29bA6UDTdBdFjxSiqm
	 tBmQIffZhuypp6rrE6g22gviTCwtQ8V+3z586l0Sf57So2vgP+RXvK2/Jz+mP1+Vw7
	 QsmlegZxTUpS/t/7ld0VlTbif6i0AeGn5u1xhfsOKXAFQMqNXmeFTJRqT9nt5XuDNg
	 laRQEMDAVQZGIM2IW0FI+j5BiKcU9B/HuOhWM90qtowD1KGldXkTm+XyIX9BFXtLNW
	 4kHR7MiA8PbWQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4E9B637813B7;
	Mon, 25 Mar 2024 08:29:59 +0000 (UTC)
Message-ID: <fc6f60fe-ddf5-4f18-bf04-225b4cc174fb@collabora.com>
Date: Mon, 25 Mar 2024 09:29:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] media: i2c: Add GC08A3 image sensor driver
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
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240323023851.5503-1-zhi.mao@mediatek.com>
 <20240323023851.5503-3-zhi.mao@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240323023851.5503-3-zhi.mao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/03/24 03:38, Zhi Mao ha scritto:
> Add a V4L2 sub-device driver for Galaxycore GC08A3 image sensor.
> 
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



