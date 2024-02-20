Return-Path: <linux-kernel+bounces-73665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602E985C5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EC71F22C24
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6273314AD10;
	Tue, 20 Feb 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4uPCKZw6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48277612D7;
	Tue, 20 Feb 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460492; cv=none; b=FJz8b118a96Y+us94wzPk1ifRvYIZUp2t2+12/Y+OG8XYOJo3808QR3h1jtUhF2Hcj/cNDk+AUe9iTTmjcaR8H5TnYi/saIYl/3hiRB77BZASis9LtbsnGEyxAPSrbqD3nUH2UQiIWLFEjaAUni+GhVwzKMK+yxIuHJ+EiHJNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460492; c=relaxed/simple;
	bh=WjP7rgPcTEm9YYG+Py1uE4S8Ykt3c58pHGIz2kCgKS8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c5wOj9faEiJrC/odmDqqdhDz0qDsOrn0/DtLDA+8XU/OcRvRACULGOU9QkPBgltiXxFdIpZKd7ZQvDsvjg/r8h3V1JVEhSxzk/xQ8w1bKlNjn/sdouVQKpiBfQQZRyA7O39tR6m/pNNZXSozIJfE8pF+luzEyTPSt1omTzvhMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4uPCKZw6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708460488;
	bh=WjP7rgPcTEm9YYG+Py1uE4S8Ykt3c58pHGIz2kCgKS8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=4uPCKZw65NZmOP8v/9ch/1si9Gd4+tnvk2HZy44jFkGEHbAPFQcslFDpzCX9FNahQ
	 lP71bTNZjyurn2nEaCLjpjx0dQLPOFrup7TVh2qBRNazsPbFmXp4aGIiArnSnEopmm
	 3igJWvwieMhp/VC+OAsDWgY/0DQPirGf2H1VXLFFZ8Bq6PiPnAIg0hdhda63BLU72i
	 ciLQYMunjYBm12VbXeK21zw+2A3NNyEHZtDho5WiT7L2/bxMuwJlqID3Z2GYwXFs6D
	 SxkJnM+nI/tV4zWFxgL1BzivuC0e6ABLc+Lvz6/usYOVZFjf3pK1U91Pg6xL0LCDE3
	 JO0etxz5oDosg==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BD0453780016;
	Tue, 20 Feb 2024 20:21:27 +0000 (UTC)
Message-ID: <bc287f7b-2434-4a45-8658-6ac4ccbb860e@collabora.com>
Date: Tue, 20 Feb 2024 22:21:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: amd: Skip IRAM/DRAM size modification for
 Steam Deck OLED
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
References: <20240220200116.438346-1-cristian.ciocaltea@collabora.com>
In-Reply-To: <20240220200116.438346-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/24 22:01, Cristian Ciocaltea wrote:
> The recent introduction of the ACP/PSP communication for IRAM/DRAM fence
> register modification breaks the audio support on Valve's Steam Deck
> OLED device.
> 
> It causes IPC timeout errors when trying to load DSP topology during
> probing:

Please ignore this series and use v3 instead:

https://lore.kernel.org/lkml/20240220201623.438944-1-cristian.ciocaltea@collabora.com/

Sorry for the noise,
Cristian

