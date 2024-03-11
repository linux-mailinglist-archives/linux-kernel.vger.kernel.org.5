Return-Path: <linux-kernel+bounces-98699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84246877E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078F4B217BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E282DF84;
	Mon, 11 Mar 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IbVh30D1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25146FC3;
	Mon, 11 Mar 2024 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152880; cv=none; b=hY9gwZTDiyjbBCIc5E4DXRe43ZGPUL/QzhU1Ddh/n/PqFVCw+ilx12H/T9eOUvj4W/MScIO0soUM7ydgjWVU286C9e1OV8gYT7a+/5MxWdAVLSf+TiupE32TbHb+RcR2HOnDJhYD7//ttLabnS5gC2omj72UjZI9YN4FaIi3Dmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152880; c=relaxed/simple;
	bh=Fgkwb/7yCvzFKvDQtJ1OKLGB5SBm7Cf1d4U3o19ANm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Szj31vQ6BafINMXxL1m547/6Im0h/E37RTYWvYlaEGsdA7E+6aLk9WDg+3EhRjcmfqBbsILEF4ipLuQklA75lRdTlmfIOIuy6JQIPBckoLpdRhoVJm+pVz+8kFyOmypAh4PAbSIbbKYFHCg9u7xzuKAFh2Jkm1D9gn5ubn9Ycdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IbVh30D1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710152877;
	bh=Fgkwb/7yCvzFKvDQtJ1OKLGB5SBm7Cf1d4U3o19ANm0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IbVh30D1g/pEERm13Uj1SwlryBdRwfdYZ/5GpC0yUqsoEfKEk1zgHw72ThIXUnOZJ
	 WYLTmz+JGzVDoVNIyhKyC5H7auJ/aj9iAjmoxdtJl3DvfyCfF5JHMz7/V2ngac0Qb+
	 qy+jEBhJkozyrA+6xG/a/mdGfT1MVXvJfVd4je2YRVSt+5ucJO8Q/xgcD6/QvhLeKz
	 sYi1YnVVGKI2MPZRPYA4/jaSNwLNgQFufAPnAskO1zcsyAnpJhA5+E1AmpHdRD49ZQ
	 fgCFJc0B2gMQSxcKcSBLMvZYNgaznddSun1sV5U/00ThkwlgqkKt3ICyxIjVdF2J8G
	 W6quzf2Z7rFEw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 310133780629;
	Mon, 11 Mar 2024 10:27:56 +0000 (UTC)
Message-ID: <e701d13a-44e9-473a-b0fa-f6cf14efae28@collabora.com>
Date: Mon, 11 Mar 2024 11:27:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] media: mediatek: vcodec: Fix multiple typos
Content-Language: en-US
To: Sebastian Fricke <sebastian.fricke@collabora.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240309-mediatek-typos-v1-0-fa4aeb59306c@collabora.com>
 <20240309-mediatek-typos-v1-1-fa4aeb59306c@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240309-mediatek-typos-v1-1-fa4aeb59306c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/03/24 16:08, Sebastian Fricke ha scritto:
> Correct multiple different typos found in comments or function names.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



