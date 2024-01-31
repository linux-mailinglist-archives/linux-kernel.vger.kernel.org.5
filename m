Return-Path: <linux-kernel+bounces-46376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C497F843EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8C7285E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E6A74E33;
	Wed, 31 Jan 2024 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ABzV98aI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A27A69D34
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701376; cv=none; b=J2ef7Y1kzJugWDmkrJa15sEQ8jpqBu+tuUEVzY71mMKGehT2V4IzRtmJGXcHmuf1OMlN+gPPwO1BpaLsFODqptqaz0dBbvQquvrpCukn1iu9n/a4VU9MNVEoTq6jhyklEgBXkzEQY481j1LkGcG03x4HD2yhH5NRPrKRaeUtprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701376; c=relaxed/simple;
	bh=1LrKOT6zOkvOtdG1q90dBaEd32pdBD9e7IHCq6opG3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUfDt1nL7jEG9ENJzy/i9jMHUAU9JlblWsBQ52W78myoXGKykrwdrq0PpNCUmKp37yQzxLAXpBdK95iPD8F4l2VhB8E6b2/5jjpknwzkS1XiYQo1WfOLxJyG1CXjhd+dOPGG+G+ynQW/yVihgozqARDYNOr68XF52JfC4N54eSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ABzV98aI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706701373;
	bh=1LrKOT6zOkvOtdG1q90dBaEd32pdBD9e7IHCq6opG3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ABzV98aIWDp/moh2/6kSB/75RQPaCX1CmoupAYsmYelEfLo0KtRw9iQs4R8ItoJ4R
	 r1mCT5mRcu9gnjvrMDcPN44gMPE4P3xt98NCrMUKooo1NS+eDLDrptHunAYN+Vl4m2
	 XJTlC4JKQakK4DZ0iOxlCy+AzQ+730fZWFI5MXlQojMjH2Ix9fps5FJIk0Lv7jD/6s
	 NQXi7vZDeFeKQKaLNGl7TygDovkqpVTeAufE/87T5HPAbA/lvOi0zpHp5IredGZXB8
	 R9BcWPxsOb5Sr7sJ7hV1ZrBXeRlpPNh/9iYFGj5xvIwGQnLzIO9ZHgtLCMINIcF/lA
	 ZpIrfScC/5ikQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 58C1B3781FE1;
	Wed, 31 Jan 2024 11:42:52 +0000 (UTC)
Message-ID: <11f4cfd2-f6a2-45cb-923a-95760a1b9883@collabora.com>
Date: Wed, 31 Jan 2024 12:42:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 2/3] ASoC: mediatek: mt8186: correct the HDMI widgets
Content-Language: en-US
To: =?UTF-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "ajye_huang@compal.corp-partner.google.com"
 <ajye_huang@compal.corp-partner.google.com>,
 =?UTF-8?B?Q2h1bnh1IExpICjmnY7mmKXml60p?= <Chunxu.Li@mediatek.com>,
 =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?=
 <Allen-KH.Cheng@mediatek.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
 "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "robert.foss@linaro.org" <robert.foss@linaro.org>,
 "Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "nfraprado@collabora.com" <nfraprado@collabora.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
References: <20230730180803.22570-1-jiaxin.yu@mediatek.com>
 <20230730180803.22570-3-jiaxin.yu@mediatek.com>
 <25e6ab45-ecad-4bc3-bf4d-983243c939ad@sirena.org.uk>
 <c6ae8630d06138b6d0156c19323afebf0718f522.camel@mediatek.com>
 <089fe457-1c61-4b7b-ad37-a67e7f46cb56@sirena.org.uk>
 <6aa6947865795fc534b61f5b8a80b3c42fd5a0cd.camel@mediatek.com>
 <9c90185c-9cd4-4a08-9925-be5d460af54d@sirena.org.uk>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <9c90185c-9cd4-4a08-9925-be5d460af54d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 03/08/23 21:33, Mark Brown ha scritto:
> On Thu, Aug 03, 2023 at 07:20:15AM +0000, Jiaxin Yu (俞家鑫) wrote:
> 
>> I agree with you, in fact the speaker is indeed doing this way. But
>> about the hdmi that on the board, I did not find a defination link
>> snd_soc_dapm_hdmi, so I use snd_soc_dapm_line to replace. The purpose
>> is to control it link speaker. Or what do you suggest I should do?
> 
> I think the sensible thing here is to define a DIGITAL_OUTPUT() which
> can be used for HDMI, S/PDIF and anything else that comes up and isn't
> clearly wrong like reusing one of the analog descriptions is.

Hello Jiaxin,

the MT8186 Corsola Chromebooks are broken upstream without this series.

Are you still interested in upstreaming this one?

Thanks,
Angelo

