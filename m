Return-Path: <linux-kernel+bounces-136449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B0D89D429
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BAB1C222CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346D37E771;
	Tue,  9 Apr 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZvttuI9e"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122C57D413;
	Tue,  9 Apr 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651136; cv=none; b=YTMlMAjW4UXbY0WlX025kd+8htUMNu7aE76oKfGEW/BOf4cJaYjYPpzq+gzI1+phUDso0+MPnsVjEkEBTANjRpCBvYUJu9Pu9fXCb7sRlWbA4sOV7rUvf/PVTChpfr6pKDGsATqo/nAI5YI+2ZB4CSZjujjibetnvSSmp0uYdSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651136; c=relaxed/simple;
	bh=9gq00SjHcig7A04o9+fxsqSU+z6odSuDVPgoQObKNmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBeQiB5pZjYHfs+vdomLkL12ckwV9+TqEH3NhkhlTzWQvtAwoW90er9lMUIMZqfBNk1cncZzr1pv2DzTE1bcB/hpWlKUjEiM1zaoEaMCgsfzwxDITzb2hYJGSD1woa/diax402iIKFIEp1+KvJanxO4mmeZ71MWP528TgbcNIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZvttuI9e; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712651133;
	bh=9gq00SjHcig7A04o9+fxsqSU+z6odSuDVPgoQObKNmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZvttuI9eCIg0F4HYNf/0bbzuDRX52cuOZ2SeKTl5VCUPJzORaiLGin1rvmHBUNgsE
	 yu5Fyhok5xNZ5rNO/rLpAsf4QBYgsmtN3gJqZ0kX5NB1nQtY9GUCPuKraU1hShO9SC
	 oTfk75+AC2UDqfiXPV0S7keBS7IMVbP7b+MxRyS340r0KIut3Q6jjx21tuZbT992EM
	 MYeG6w1x/z8zoMrNkf/QZIkiIkK8l5okw0aT/Tuob4lE1R0WuZbe8o/TuyHyWvBcAI
	 61044vkCiyGHYmkigpzJtiMEqELyu0tADcQ8d7EX1vYXLgiNGUfc9G+TTgcdxgYNZ+
	 1Dl6/r33CG88Q==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1619C37809D1;
	Tue,  9 Apr 2024 08:25:32 +0000 (UTC)
Message-ID: <bf713024-a96b-457a-9281-0406e6eb0828@collabora.com>
Date: Tue, 9 Apr 2024 11:25:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Steam Deck OLED 6.8.2 nau8821-max fails
To: Daniel Martin <dmanlfc@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Sound System <linux-sound@vger.kernel.org>
References: <ZhFJZoful6nEFskW@archie.me>
 <4d231dc4-0183-47e1-8bfa-3dd225bf8ea3@leemhuis.info>
 <904ffa11-592a-4336-aed2-d6370bb01896@collabora.com>
 <b99e51de-3622-4360-b69d-0fd911ea2a7d@leemhuis.info>
 <9012f8d5-302a-4840-815a-22b1e85fda5c@collabora.com>
 <CAOyTmd3bpmb7t1fCMKPBXqhVtpdpKRvVq5EA7VXrnb-5Fs9ngQ@mail.gmail.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <CAOyTmd3bpmb7t1fCMKPBXqhVtpdpKRvVq5EA7VXrnb-5Fs9ngQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/9/24 10:54 AM, Daniel Martin wrote:
> Why this was changed in the first place could do with some explaining,
> as Valve had this implemented first in the SteamDeck (probably collabora
> dev).
> There were no other implementations out in the wild AFAIK & now with the
> 6.8.x kernel, this issue has manifested because of an enum change.

The OLED model was launched with a 6.1-based kernel which relied on a
downstream implementation of the Vangogh SOF drivers.  Those were
mainlined by AMD way later, in v6.6, but during the upstreaming process
we ended up with this unfortunate ID assignments incompatibility.

> I cannot for the life of me find an alternative topology file. Where are
> the other implementations? Therefore it makes sense aligning to what was
> done before on the Steam Deck OLED.

I'm not aware of an alternative topology file available so far.
> Alternatively, if Valve could provide an updated topology file for 6.8+
> kernels, that would be great too.
> Just my two cents from a humble OS dev, trying to make stuff work.

I think that would be the long-term goal, so until that is figured out,
the easiest workaround to get this working with mainline is to apply the
enum change patch.

Regards,
Cristian

