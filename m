Return-Path: <linux-kernel+bounces-81278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDEC8673F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC08EB292F9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB201CD2B;
	Mon, 26 Feb 2024 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="06Av+1by"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B937200BD;
	Mon, 26 Feb 2024 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947316; cv=none; b=BBf2GpNqqRUm8Nv3vixAsvlKkCQD8jhYHPclXFVIIKwg+rwYWTOpzY8YrIC0seaWM3jc4NcjSeJQlvhHzKXRUTzGua6WPaLumHQw1TUluwvFJF3zo3bcaG9GrFl3MtM8zsdgO/hRUacvUixdau/jsVSyzsXEAodAgQOJz/kJhAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947316; c=relaxed/simple;
	bh=PRmRkpP87fdXdGPmJyV15H5s0bYWIoTINv/TZ8U2PQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEOLa4KWCILtFfqMZN5Vm+0PDoWxVINjog5ABB1I3YDi2iBGEZMrRKuiTSRx/6Fbnmdtpg40aSOUmfluLtg4Exc1n+0NUQ0lLBch6T5OgTy/FzAl5HghKCGJ1Qgf+qSoFkcFcwC+EyhyHmWQDJEqWpkhmsmhFpNYsNmaSsUsAL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=06Av+1by; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708947313;
	bh=PRmRkpP87fdXdGPmJyV15H5s0bYWIoTINv/TZ8U2PQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=06Av+1byeWeu/a9c4RjGq0y+ZA3NMayTQiZwBpfKVYZb79d0czUVUfHmqd+MCssPn
	 cavR8TihvdA8cPiTblZFR6LgjkPtslxjMLIjyub3H9Dpc486cjpvMnQRGhsTpiQpEe
	 EYGdALLBXpwk2eqBtg+YLdOk9vIzQVgZueISZQuy+PmRfd0aw5kY3U8TttgproQtya
	 0FXw3thFb47JBziyQBvxRbbvzRFOMV4LLHJ07SmmnsR02NrhFjKIpEIdO/b3J1lJo0
	 HELKfrNWKSzQlMwc5nExdmhANzf2R5hf5f3H9CNr5IZNVixqjc6UNPhBZQI19+tJsa
	 ijE2LkJFaEBeQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 88E6237814B0;
	Mon, 26 Feb 2024 11:35:12 +0000 (UTC)
Message-ID: <a22b7703-2ee1-47dd-8933-4a72e64e9fe0@collabora.com>
Date: Mon, 26 Feb 2024 12:35:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] clk: mediatek: mt8183: Enable need_runtime_pm on
 mt8183-mfgcfg
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>, Pin-yen Lin <treapking@chromium.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Weiyi Lu <weiyi.lu@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20240108081834.408403-1-treapking@chromium.org>
 <20240108081834.408403-2-treapking@chromium.org>
 <CAGXv+5GoAauw77wVXx6SXsSma9zP_A1vXLRo=GH2ptjvY=kLgA@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5GoAauw77wVXx6SXsSma9zP_A1vXLRo=GH2ptjvY=kLgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/02/24 05:43, Chen-Yu Tsai ha scritto:
> On Mon, Jan 8, 2024 at 4:18 PM Pin-yen Lin <treapking@chromium.org> wrote:
>>
>> mt8183-mfgcfg has a mutual dependency with genpd during the probing
>> stage, so enable need_runtim_pm to prevent a deadlock in the following
>> call stack:
>>
>> CPU0:  genpd_lock --> clk_prepare_lock
>> genpd_power_off_work_fn()
>>   genpd_lock()
>>   generic_pm_domain::power_off()
>>      clk_unprepare()
>>        clk_prepare_lock()
>>
>> CPU1: clk_prepare_lock --> genpd_lock
>> clk_register()
>>    __clk_core_init()
>>      clk_prepare_lock()
>>      clk_pm_runtime_get()
>>        genpd_lock()
>>
>> Do a runtime PM get at the probe function to make sure clk_register()
>> won't acquire the genpd lock.
>>
>> Fixes: acddfc2c261b ("clk: mediatek: Add MT8183 clock support")
>> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> Note that this compliments a patch [1] adding the power domain for the mfgcfg
> clock controller node, which has been floating around for almost 3 years.
> 

..but why does this happen *only* on MT8183 and not on any other MediaTek SoC?

I understand what you're trying to solve here, but if we explore a bit more, we
can maybe come to the conclusion that we don't need to add this flag, and perhaps
just enable PM runtime as regular flow for all clock controllers.

That would also be cleaner, to some extent.

Cheers,
Angelo

> [1] https://lore.kernel.org/linux-mediatek/20210414073108.3899082-1-ikjn@chromium.org/
> 
>> ---
>>
>> (no changes since v1)
>>
>>   drivers/clk/mediatek/clk-mt8183-mfgcfg.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
>> index ba504e19d420..62d876e150e1 100644
>> --- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
>> +++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
>> @@ -29,6 +29,7 @@ static const struct mtk_gate mfg_clks[] = {
>>   static const struct mtk_clk_desc mfg_desc = {
>>          .clks = mfg_clks,
>>          .num_clks = ARRAY_SIZE(mfg_clks),
>> +       .need_runtime_pm = true,
>>   };
>>
>>   static const struct of_device_id of_match_clk_mt8183_mfg[] = {
>> --
>> 2.43.0.472.g3155946c3a-goog
>>



