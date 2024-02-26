Return-Path: <linux-kernel+bounces-81257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7B68672D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC031C22943
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721E1D52D;
	Mon, 26 Feb 2024 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fYY39ux/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0BD1CF8F;
	Mon, 26 Feb 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708946175; cv=none; b=kdA8dfrxjVm82KPAouxJreHZtEA7vrFn8m08i4Fy6IMMtz1Cpq+etT9DbulNfV9QFj5WiOun5d7Eax2pZ+qNsbRNgPp2JSGl+m/4Ds0gC7b50RKQo4Y7I1zpGXp4jDPIkT+AZdH+uprtzTl5g4XoHKCGmeHPEYQYp+/JsS1ccb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708946175; c=relaxed/simple;
	bh=rbz5V7dAp9UKMWAJ4NGuXVlKWd6zmgzIZmH1IQn+dU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Au+BkK8TXI3NDyCx+I5xCEYniG82MEA9NYQWwrFAUVApRiTgxeWsawtSVylcS9E82MtTl9xwB6hkc/XE3yR+ddS66pf/Z2Pa+uTQ+nLQ8akIS88VXZrnPzaSL4Y9OCQhcMl8q9I5Z4lWEk5hLHnWsK8pxBWUoY+bkGmm9peLW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fYY39ux/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708946172;
	bh=rbz5V7dAp9UKMWAJ4NGuXVlKWd6zmgzIZmH1IQn+dU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fYY39ux/ltUowjNs1wv42h9v43ezzKaVupXe98joJu0hgeKUs2czrOscxzdORgCdZ
	 IFV2243rdAeXgBtotTPscvVH86qVHBtgVOyrdb7VUtkxPwT1q5ziFR0+NIb+IDcfU1
	 4pZI6L8JJXikYDsbh1UwI/xr5S8wKKkQNq8/+z/g6o5pN1IBjBqOidmvvFv5Ropu96
	 U+NEySA/0sP1Yid5WGkDCObo/XSg/lgrppi5LNCPTtP3vOJ7HGmBN2wbzVsf+PKOOQ
	 km5Xvo3XaTW5FeD6o5AIdhFZnVi4mfNrI4pDL4A/iPLCEewonNNCtzpsFFr4vZfNk5
	 8ZqdJ9Nktpmrg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 53D663780022;
	Mon, 26 Feb 2024 11:16:11 +0000 (UTC)
Message-ID: <e0e6febf-1045-49f8-a200-8bc095b0fa50@collabora.com>
Date: Mon, 26 Feb 2024 12:16:10 +0100
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
To: Chen-Yu Tsai <wenst@chromium.org>, Pin-yen Lin <treapking@chromium.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Weiyi Lu <weiyi.lu@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20240108081834.408403-1-treapking@chromium.org>
 <CAGXv+5EnBt+7WrNb-QyziEaCihvjhFVf2tpzk=XyAoeELqucaw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5EnBt+7WrNb-QyziEaCihvjhFVf2tpzk=XyAoeELqucaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/02/24 05:27, Chen-Yu Tsai ha scritto:
> On Mon, Jan 8, 2024 at 4:18 PM Pin-yen Lin <treapking@chromium.org> wrote:
>>
>> Introduce a new need_pm_runtime variable to mtk_clk_desc to indicate
>> this clock controller needs runtime PM for its operations.
>> Also do a runtime PM get on the clock controller during the
>> probing stage to workaround a possible deadlock.
>>
>> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> The patch itself looks fine.
> 
> Besides the MT8183 MFG clock issues, we do actually need this for the
> MT8192 ADSP clock. Its power domain is not enabled by default.
> 

..but on MT8195 the ADSP clock works - because the ADSP node exists.

This poses a question: should we make clock controllers depend on power domains,
or should we keep everything powered off (hence clocks down - no power consumption)
*unless* the user exists?

For the second one, this means that the *device* gets the power domain (adsp), and
not the clock controller (which clocks are effectively useless if there's no user).

Angelo

>> ---
>>
>> Changes in v3:
>> - Update the commit message and the comments before runtime PM call
>>
>> Changes in v2:
>> - Fix the order of error handling
>> - Update the commit message and add a comment before the runtime PM call
>>
>>   drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++++
>>   drivers/clk/mediatek/clk-mtk.h |  2 ++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
>> index 2e55368dc4d8..ba1d1c495bc2 100644
>> --- a/drivers/clk/mediatek/clk-mtk.c
>> +++ b/drivers/clk/mediatek/clk-mtk.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>   #include <linux/slab.h>
>>
>>   #include "clk-mtk.h"
>> @@ -494,6 +495,18 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
>>                          return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
>>          }
>>
>> +
>> +       if (mcd->need_runtime_pm) {
>> +               devm_pm_runtime_enable(&pdev->dev);
>> +               /*
>> +                * Do a pm_runtime_resume_and_get() to workaround a possible
>> +                * deadlock between clk_register() and the genpd framework.
>> +                */
>> +               r = pm_runtime_resume_and_get(&pdev->dev);
>> +               if (r)
>> +                       return r;
>> +       }
>> +
>>          /* Calculate how many clk_hw_onecell_data entries to allocate */
>>          num_clks = mcd->num_clks + mcd->num_composite_clks;
>>          num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
>> @@ -574,6 +587,9 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
>>                          goto unregister_clks;
>>          }
>>
>> +       if (mcd->need_runtime_pm)
>> +               pm_runtime_put(&pdev->dev);
>> +
>>          return r;
>>
>>   unregister_clks:
>> @@ -604,6 +620,9 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
>>   free_base:
>>          if (mcd->shared_io && base)
>>                  iounmap(base);
>> +
>> +       if (mcd->need_runtime_pm)
>> +               pm_runtime_put(&pdev->dev);
>>          return r;
>>   }
>>
>> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
>> index 22096501a60a..c17fe1c2d732 100644
>> --- a/drivers/clk/mediatek/clk-mtk.h
>> +++ b/drivers/clk/mediatek/clk-mtk.h
>> @@ -237,6 +237,8 @@ struct mtk_clk_desc {
>>
>>          int (*clk_notifier_func)(struct device *dev, struct clk *clk);
>>          unsigned int mfg_clk_idx;
>> +
>> +       bool need_runtime_pm;
>>   };
>>
>>   int mtk_clk_pdev_probe(struct platform_device *pdev);
>> --
>> 2.43.0.472.g3155946c3a-goog
>>




