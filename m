Return-Path: <linux-kernel+bounces-131125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A9589835E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549121F28737
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A5371B25;
	Thu,  4 Apr 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ek1Sbvg/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193A57172C;
	Thu,  4 Apr 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220339; cv=none; b=pCvwiHf5KyS0ievam4Emz3DpT2ZEUnedq/q0cs3t8CwAMhHMjXTdxy1flC2vkXVfEWbtg9j8MeuXu4HeC9ycspV11O84payfibeOvMUThibHKsfe35UgkUY348Bhv50XousK1EL0fIfDL+uJhGnWyQsyg4/U/WLWsKkvFWufOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220339; c=relaxed/simple;
	bh=f3ZHkHvCpCweFVRDS+9nWl67EHYJRCdqnlO132i1YnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZr5jUgLNgIAOyHUCTLDfg9XkV9uviFQ4XSO9y4TtOokKV17tjrgnWMlECw7laHTvMW3W8QAeLhSiPzT2ANiM3qC6Wua9r0IH2XibG9Ff5aaSpgZ14wVNY/3JZrSvy8Ge0TCgHoNZmxz18mLxfSu1BTl4b78rwB006lAX1OKmVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ek1Sbvg/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712220336;
	bh=f3ZHkHvCpCweFVRDS+9nWl67EHYJRCdqnlO132i1YnM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ek1Sbvg/59Y+GNAxAeM5gP3RduwmfKbBbHJnk6mNbhplJoPLulTR4aNwxzm1kiasU
	 YgrayKHq3IxJq4sSguxXkwXDtofmww4VvRe1GhggK754mTR/qXkmlrHr84fXbuEQyV
	 ZUmi4h55358SEK1UKIjoLIAAU8sP/gThIAJgx1l6ZRlB1o3W5D+/tr/vlHltbMdKb/
	 fUL/mDY0Jgr1DmIoiiRnpGqHldzv6LRtekiApFRhrV6YCFs1I8Csv8MZ+hdlpQfClV
	 Hx22YPyijzSo6s7KukpUwXgKgnAIHvGzWRxZM607wV7aq4mELbiyPnAmIAjokHBKEJ
	 0sLuYQ1F3OK7w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D26823780029;
	Thu,  4 Apr 2024 08:45:35 +0000 (UTC)
Message-ID: <ae872ee7-3709-45ce-b240-c35a59427041@collabora.com>
Date: Thu, 4 Apr 2024 10:45:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] pinctrl: mediatek: paris: More pin config cleanups
To: Linus Walleij <linus.walleij@linaro.org>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327091336.3434141-1-wenst@chromium.org>
 <CACRpkdYi=3ZYVQGAAwJ5iYNX-WY1OPTX_xuP3H-xJj9Q+b+RRw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CACRpkdYi=3ZYVQGAAwJ5iYNX-WY1OPTX_xuP3H-xJj9Q+b+RRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/04/24 10:23, Linus Walleij ha scritto:
> On Wed, Mar 27, 2024 at 10:13 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
> 
>> Here are a couple more pin config cleanups for the MediaTek paris
>> pinctrl driver library.
>>
>> Patch 1 fixes readback of PIN_CONFIG_INPUT_SCHMITT_ENABLE. The function
>> was passing back the disabled state incorrectly.
>>
>> Patch 2 reworks support for PIN_CONFIG_{INPUT,OUTPUT}_ENABLE, following
>> discussions on the bcm2835/bcm2711 pinctrl drivers [1]. The driver is
>> made to follow the definitions of each option as described in the DT
>> bindings and pinctrl core.
>>
>> Please have a look and merge if possible.
> 
> Patches applied for fixes, it looks like pretty urgent stuff, yet no feedback
> from maintainers for a week so I applied it.
> 
> Yours,
> Linus Walleij

Yeah - sorry about that, but this one went out of my radar for whatever
reason....
Just had a look at it and - even if it's too late - I can give my approval.

Please feel free to ping me if this happens again: when done for a good reason,
pings are helpful and appreciated on my side, no worries!

Btw, Linus, thanks for swiftly applying this as - yes - those are good and
high priority fixes.


*Anyway* - whole series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

