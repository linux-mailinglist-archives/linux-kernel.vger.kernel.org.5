Return-Path: <linux-kernel+bounces-91160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4006870A35
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015DA1C20E92
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C4D79934;
	Mon,  4 Mar 2024 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QMqei85U"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12E7CF17;
	Mon,  4 Mar 2024 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579472; cv=none; b=p/4C4ZWF9gxFWCAE4T27Pn0QDBAiGi/7oadFbicGPzGFZjumTWDHPvruWV4KzSs8iR5Quztv09rLtAOALB4wEdWqZ9CZQXBc3QGlhOpA1chnmbuGlVHl+YHpKMnkkVRcDulgU0rtWpeHBuH0+RqnVH1ztBcxYBeGHntHKlPzJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579472; c=relaxed/simple;
	bh=K3yrAUxiGdxT7G8PGb78Jnh5WW5YiKan5RDHOUdHxAQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZVimDZc73F6C1HDjpaYE9dWzWA1hvCuOIeskq42WeasuZ3vERpPetmrdRtPpX4ZwShMNtZqhdJenZDiW98/iVfxDR1CVgJGQz5zQ/mMuSsdu0h66QeMawNcMaCW54ExK2St7OQnt+a3tr3dK4j29cV/a9IT8xI3sMSC2GFRfBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QMqei85U; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709579468;
	bh=K3yrAUxiGdxT7G8PGb78Jnh5WW5YiKan5RDHOUdHxAQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=QMqei85Ub5fJFt0Uw9DIkhVOxC8Cjbc5f/XONZH8HXy9F0yQ2I+KxVxp8evAKgyuW
	 RXsCvF14+INkMQqGREGKq/P0JGAwpxPy+QV+oDXQD/pDqX5VXVVQmYkBz3DoHr5G46
	 CjrZMa6v3kp6HyYPfxJNzRJXAFWN/O3Rt+eu3qUnuyrJylruhL8DF0FKDQHnJoACZl
	 EYPBVZgsZU46hzraNRVd6h1HVH69mRlDAskUcI43/yfUS+7XjtE7HP4Ikcg9y274ox
	 ewPozdep0uZADlomZXnMjLXRz61U1z9IKpJg0cBPzeOT/wQAd6lbIiz8A5Jezw35Or
	 xeXP7kWWJkKGw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 24DA23780480;
	Mon,  4 Mar 2024 19:11:07 +0000 (UTC)
Message-ID: <db53a405-362f-4c8d-82e2-49c001b29dd1@collabora.com>
Date: Mon, 4 Mar 2024 21:11:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] ASoC: SOF: amd: Skip IRAM/DRAM size modification
 for Steam Deck OLED
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240220201623.438944-1-cristian.ciocaltea@collabora.com>
In-Reply-To: <20240220201623.438944-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/24 22:16, Cristian Ciocaltea wrote:
> This patch series restores audio support on Valve's Steam Deck OLED model, which
> broke after the recent introduction of ACP/PSP communication for IRAM/DRAM fence
> register programming.

Hi Mark,

Could we get this queued for merging as v6.9 material?

Thanks,
Cristian

