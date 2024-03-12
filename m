Return-Path: <linux-kernel+bounces-100060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7B987914B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD15F1F23101
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA479DC3;
	Tue, 12 Mar 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Wv/bI80X"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0978281;
	Tue, 12 Mar 2024 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236721; cv=none; b=uNhuaHSryL/W1k566/zrTDVEZehj0/Cx+IAW3efOEzPmPGfAbeE/tF6E0/L9rZGxIwnEkZ8/TLGqyfqF+2E7qdxlFjqVGOjoxOyE/DPotkgrBTlMIOT1tg/sV5KcBVKBE39XoIGngijtWwKg7gyA+oqT1IqQdWKcBmy6SIuA1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236721; c=relaxed/simple;
	bh=Mk2uhfXl37VOJISZwLi7o99cz/qukl3YgrOVI1UeofY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DL2hCDL1c6/iqk9gMpBRdJlGNTU1uk+A1c6Ru0T5CZOOZTkgFe5291oWi+pZ+ADLwAIkrouzTXtDU7lhzUNF/X0RHll8iJog/h7zvlz8HopHYvN/p0+ISRlDNmHlWHtjVHzyvePPQFhwcpUkTqX77x8Tmn797n7L/47nx5AavO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Wv/bI80X; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710236717;
	bh=Mk2uhfXl37VOJISZwLi7o99cz/qukl3YgrOVI1UeofY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wv/bI80XvDTtZEuMgQE+FmNMRaOsJJXXWy3bWktedpp5XUs17nHeVVa/XmUnC6NXK
	 pSojzoHSONji14fanSMaYeh0oDxeyuzYCZ5EpQQ2+tqTS91iqGW/q0ROoQfVrx6lX8
	 5Bmt7Bi1zbpFhjWHY0pioIp5kusWbL8a0kV1+v2+y/6tUL7smvlXO43Q3Jz3bAI1Bz
	 oYTSRjWnkbd4BQdiIoMnxfvvGCg3zoYnIEviLibebPbAATSChAb5qe4w5UnUwl2Nxv
	 9+bfeg5F7nTcBJa9Lyh/ukUdPp61022ysnuQh8gwCXiUX3etDXgWmKsh+rWMg89/q9
	 UgJpMiEQD/O2A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3F6CA37813E5;
	Tue, 12 Mar 2024 09:45:17 +0000 (UTC)
Message-ID: <ae89f215-c97d-496e-9640-c87ccac1c991@collabora.com>
Date: Tue, 12 Mar 2024 10:45:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] clk: mediatek: Introduce need_pm_runtime to
 mtk_clk_desc
Content-Language: en-US
To: Pin-yen Lin <treapking@chromium.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Weiyi Lu <weiyi.lu@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20240108081834.408403-1-treapking@chromium.org>
 <CAGXv+5EnBt+7WrNb-QyziEaCihvjhFVf2tpzk=XyAoeELqucaw@mail.gmail.com>
 <e0e6febf-1045-49f8-a200-8bc095b0fa50@collabora.com>
 <CAGXv+5F5YFRKjaXu_XbXrUhqKL0NSRyt6tniQYfhRh+fsaxqmg@mail.gmail.com>
 <cc74422d-962f-4da5-867b-158a71db1a7b@collabora.com>
 <CAGXv+5EyRROsh_=J1Fg4K+ZgfkERF4dh4R6WoGw9MnTBMNUCgQ@mail.gmail.com>
 <dfdc6a65-3ccf-463c-95df-093f3c2fefd3@collabora.com>
 <CAEXTbpcPfWQr4iuD2U0zgJUi+BF-rLfyF4iDDiQYBrrv9U=6Xg@mail.gmail.com>
 <90f3f4e2-ced5-4fae-b765-5b802f4895c8@collabora.com>
 <CAEXTbpeSyh1YfKsM8cqRjOFA7Ww4ooRxgCxMwXw2F4uCyX=OBg@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAEXTbpeSyh1YfKsM8cqRjOFA7Ww4ooRxgCxMwXw2F4uCyX=OBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 12/03/24 10:35, Pin-yen Lin ha scritto:
> Hi Angelo
> 
> On Thu, Mar 7, 2024 at 7:22 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 07/03/24 12:10, Pin-yen Lin ha scritto:
>>> Hi Angelo and Chen-yu,
>>>
>>> I tried enabling the runtime PM regardless of the .need_pm_runtime
>>> flag, and my MT8183 device works well with that with no obvious boot
>>> regression.
>>>
>>> Should I send out another patch that always enables runtime PM in
>>> __mtk_clk_simple_probe()? Or is there anything I should test?
>>>
>>
>> Hello Pin-yen,
>>
>> as I discussed with Chen-Yu - yes, we must make sure that this does not
>> create any regression on machines running on other SoC models.
>>
>> I think it's unlikely that it does, but since the HW is available, being
>> extremely careful with validating this change is a good idea :-)
>>
>> If you can/want to test before we do, sure, please send the new patch and,
>> when you do, please say that you tested it and on which SoCs; as long as
>> it's not just one SoC, that'll be good enough for me.
>>
>> P.S.: Please don't top-post!
>>
>> Cheers,
>> Angelo
> 
> I just tried this on MT8192 and the system looks healthy as well. I'll
> send out a patch to enable the runtime PM for all mediatek clock
> controllers.
> 
> Thanks for your time on reviewing this, and sorry for the top-posting.
> 

You're welcome. Looking forward to see the new patch!

Cheers,
Angelo

> Regards,
> Pin-yen
> 
>>
>>> Regards,
>>> Pin-yen
>>>
>>> On Thu, Feb 29, 2024 at 6:36 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 29/02/24 11:34, Chen-Yu Tsai ha scritto:
>>>>> On Thu, Feb 29, 2024 at 5:45 PM AngeloGioacchino Del Regno
>>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>>
>>>>>> Il 29/02/24 08:17, Chen-Yu Tsai ha scritto:
>>>>>>> On Mon, Feb 26, 2024 at 7:16 PM AngeloGioacchino Del Regno
>>>>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>>>>
>>>>>>>> Il 23/02/24 05:27, Chen-Yu Tsai ha scritto:
>>>>>>>>> On Mon, Jan 8, 2024 at 4:18 PM Pin-yen Lin <treapking@chromium.org> wrote:
>>>>>>>>>>
>>>>>>>>>> Introduce a new need_pm_runtime variable to mtk_clk_desc to indicate
>>>>>>>>>> this clock controller needs runtime PM for its operations.
>>>>>>>>>> Also do a runtime PM get on the clock controller during the
>>>>>>>>>> probing stage to workaround a possible deadlock.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>>>>>>>>>
>>>>>>>>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>>>>>>>>>
>>>>>>>>> The patch itself looks fine.
>>>>>>>>>
>>>>>>>>> Besides the MT8183 MFG clock issues, we do actually need this for the
>>>>>>>>> MT8192 ADSP clock. Its power domain is not enabled by default.
>>>>>>>>>
>>>>>>>>
>>>>>>>> ...but on MT8195 the ADSP clock works - because the ADSP node exists.
>>>>>>>
>>>>>>> That's an indirect dependency that should not be relied on. Say the clock
>>>>>>> driver probed but the ADSP hasn't, and you try to read out the current
>>>>>>> status. What would happen?
>>>>>>>
>>>>>>> - Read out works fine, because the power domain is default on, and hasn't
>>>>>>>       been turned off by late cleanup
>>>>>>> - Read out is bogus (but you can't tell)
>>>>>>> - Read out hangs.
>>>>>>>
>>>>>>> The third is what happens on MT8192. There's still some issues on that
>>>>>>> front, as even after I applied the ADSP power domain patches from MediaTek,
>>>>>>> the readout was still hanging.
>>>>>>>
>>>>>>
>>>>>> That MT8192 lockup story is getting crazy in my head... anyway, besides that,
>>>>>> I get the point - I was somehow ignoring the fact that kernel modules do exist.
>>>>>>
>>>>>> Eh, sorry about that :-)
>>>>>>
>>>>>>>> This poses a question: should we make clock controllers depend on power domains,
>>>>>>>> or should we keep everything powered off (hence clocks down - no power consumption)
>>>>>>>> *unless* the user exists?
>>>>>>>
>>>>>>> That's a policy discussion separate from actual hardware dependencies.
>>>>>>> *If* the clock controller needs the power domain to be active for the
>>>>>>> registers to be accessed, the clock controller *must* have a direct
>>>>>>> dependency on the power domain.
>>>>>>>
>>>>>>
>>>>>> I admit I should've worded that better.
>>>>>>
>>>>>> "should we make clock controllers depend on power domains" was actually implying
>>>>>> "IF those need one" :-)
>>>>>>
>>>>>> I really wonder if - at this point - it's simply a better idea to not restrict
>>>>>> the call to devm_pm_runtime_enable/resume_and_get to `need_runtime_pm == true`.
>>>>>>
>>>>>> Do we really need to exclude that on other clock controllers that don't have
>>>>>> any power domain dependency? Any side effect?
>>>>>>
>>>>>> Saying this because if we can avoid yet another per-SoC flag I'm really happy,
>>>>>> as readability is also impacted and besides - if we ever find out that one of
>>>>>> those need a power domain in the future, we'll need just one commit and just
>>>>>> only in the devicetree, instead of enabling a flag in driver X as well as that,
>>>>>> avoiding some (potentially unnecessary) noise... I guess.
>>>>>>
>>>>>> P.S.: I just noticed that the return value for the devm_pm_runtime_enable() call
>>>>>>           is not being checked!
>>>>>>
>>>>>> .......
>>>>>>
>>>>>> In short....
>>>>>>
>>>>>> Chen-Yu, at this point, do you have any reason why we wouldn't be able and/or it
>>>>>> wouldn't be a good idea to just avoid adding the `need_runtime_pm` flag (meaning
>>>>>> that we perform pm_runtime calls for all clock drivers unconditionally)?
>>>>>>
>>>>>> If this is about longer boot time, I don't think that it's going to be more than
>>>>>> a millisecond or two, so that should be completely ignorable.
>>>>>
>>>>> I think it's just more of a "don't enable features you don't need" thing.
>>>>> We already ran into a weird deadlock, which is why the devm_pm_runtime_enable()
>>>>> call has that comment.
>>>>>
>>>>> I don't think anyone has actually looked at it. As you said it shouldn't be
>>>>> much, at least during boot time. It's one call per clock controller.
>>>>>
>>>>>> Can you please do a test for that, or should I?
>>>>>
>>>>> The earliest I can work on it would be some time next week. Does that work
>>>>> for you?
>>>>>
>>>>
>>>> The earliest I'd be able to work on this myself would be at the end of next
>>>> week if not later.. so yes, please take your time, no worries.
>>>>
>>>> Thank you!
>>>>
>>>>> ChenYu
>>>>>
>>>>>> Cheers
>>>>>> Angelo
>>>>>>
>>>>>>>> For the second one, this means that the *device* gets the power domain (adsp), and
>>>>>>>> not the clock controller (which clocks are effectively useless if there's no user).
>>>>>>>
>>>>>>> No. See my previous paragraph.
>>>>>>>
>>>>>>> ChenYu
>>>>>>>
>>>>>>>> Angelo
>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> Changes in v3:
>>>>>>>>>> - Update the commit message and the comments before runtime PM call
>>>>>>>>>>
>>>>>>>>>> Changes in v2:
>>>>>>>>>> - Fix the order of error handling
>>>>>>>>>> - Update the commit message and add a comment before the runtime PM call
>>>>>>>>>>
>>>>>>>>>>       drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++++
>>>>>>>>>>       drivers/clk/mediatek/clk-mtk.h |  2 ++
>>>>>>>>>>       2 files changed, 21 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
>>>>>>>>>> index 2e55368dc4d8..ba1d1c495bc2 100644
>>>>>>>>>> --- a/drivers/clk/mediatek/clk-mtk.c
>>>>>>>>>> +++ b/drivers/clk/mediatek/clk-mtk.c
>>>>>>>>>> @@ -13,6 +13,7 @@
>>>>>>>>>>       #include <linux/of.h>
>>>>>>>>>>       #include <linux/of_address.h>
>>>>>>>>>>       #include <linux/platform_device.h>
>>>>>>>>>> +#include <linux/pm_runtime.h>
>>>>>>>>>>       #include <linux/slab.h>
>>>>>>>>>>
>>>>>>>>>>       #include "clk-mtk.h"
>>>>>>>>>> @@ -494,6 +495,18 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
>>>>>>>>>>                              return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
>>>>>>>>>>              }
>>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +       if (mcd->need_runtime_pm) {
>>>>>>>>>> +               devm_pm_runtime_enable(&pdev->dev);
>>>>>>>>>> +               /*
>>>>>>>>>> +                * Do a pm_runtime_resume_and_get() to workaround a possible
>>>>>>>>>> +                * deadlock between clk_register() and the genpd framework.
>>>>>>>>>> +                */
>>>>>>>>>> +               r = pm_runtime_resume_and_get(&pdev->dev);
>>>>>>>>>> +               if (r)
>>>>>>>>>> +                       return r;
>>>>>>>>>> +       }
>>>>>>>>>> +
>>>>>>>>>>              /* Calculate how many clk_hw_onecell_data entries to allocate */
>>>>>>>>>>              num_clks = mcd->num_clks + mcd->num_composite_clks;
>>>>>>>>>>              num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
>>>>>>>>>> @@ -574,6 +587,9 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
>>>>>>>>>>                              goto unregister_clks;
>>>>>>>>>>              }
>>>>>>>>>>
>>>>>>>>>> +       if (mcd->need_runtime_pm)
>>>>>>>>>> +               pm_runtime_put(&pdev->dev);
>>>>>>>>>> +
>>>>>>>>>>              return r;
>>>>>>>>>>
>>>>>>>>>>       unregister_clks:
>>>>>>>>>> @@ -604,6 +620,9 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
>>>>>>>>>>       free_base:
>>>>>>>>>>              if (mcd->shared_io && base)
>>>>>>>>>>                      iounmap(base);
>>>>>>>>>> +
>>>>>>>>>> +       if (mcd->need_runtime_pm)
>>>>>>>>>> +               pm_runtime_put(&pdev->dev);
>>>>>>>>>>              return r;
>>>>>>>>>>       }
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
>>>>>>>>>> index 22096501a60a..c17fe1c2d732 100644
>>>>>>>>>> --- a/drivers/clk/mediatek/clk-mtk.h
>>>>>>>>>> +++ b/drivers/clk/mediatek/clk-mtk.h
>>>>>>>>>> @@ -237,6 +237,8 @@ struct mtk_clk_desc {
>>>>>>>>>>
>>>>>>>>>>              int (*clk_notifier_func)(struct device *dev, struct clk *clk);
>>>>>>>>>>              unsigned int mfg_clk_idx;
>>>>>>>>>> +
>>>>>>>>>> +       bool need_runtime_pm;
>>>>>>>>>>       };
>>>>>>>>>>
>>>>>>>>>>       int mtk_clk_pdev_probe(struct platform_device *pdev);
>>>>>>>>>> --
>>>>>>>>>> 2.43.0.472.g3155946c3a-goog
>>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>
>>
>>
>>


