Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE117523A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjGMNYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjGMNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:23:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF472D40
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:22:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b702319893so10474231fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689254563; x=1691846563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXWviMRLD7YocUFq1hAwJTX8QyWW8iQWGTv5QqtyLjk=;
        b=McxC7at3hk1pweV1zh33Jfqa/21F0tDnkTwZMMTwXWTU1ixyOxDbDD2wOcvvyq7q2d
         rX/1t2VLAdaVSy4GzHUcK9YnqgraYwtY+DWa857WOxv8UOC88QZ31m0fuxbUc8/eWE22
         jxez+//fWGwCCLrHHQ6WSHtgZTUFmgmDPtbDWcgmEkJPoE03zrt1CneXzSWMXoux6PIB
         jkdtzhTZaTrqVYYeiqJgbU7SZVq8IzFIH6XNh4GmLyqVTT8WMZ6pOkG9HfVwVwSVOHRS
         0hU6GCD9vtwOymJdp3/PgHZaSeRS9DCP+M+y46dT+/dwxRyVa15fBq7BLTrr3YvlEstf
         Zvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689254563; x=1691846563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXWviMRLD7YocUFq1hAwJTX8QyWW8iQWGTv5QqtyLjk=;
        b=YfB7k07dPXAPKPSQ6dcpt608HU2X18hg8WlAEjXqTgQkJ8s3XV9KtOEip5mqmE4Fva
         dPFeGnwNgwo8otdTHF+EH7d/WKdSXQgpX1DSMWnk+M3O1wv5ZA+qnC29ESEbw+9nsmhb
         uejs88qlcG/aL4MzsT+RzdgUDW4m36bGwKxxkP4b1OxbhY3KNJMrTnCAAb6UnvQP5qGJ
         PALbReAE2GsUK9Ujecv38tEAHqkHHIUVfxm5FOdqMAoBkZ5TZ2R8Yr/yEEE4y9HoE7uE
         UzAPtgliCFCU6bRpUYBZHKeP7ro9jlSfxq/06shYX5+isnHpNlkwnFtZjpAkX+bJrFhm
         mhOQ==
X-Gm-Message-State: ABy/qLYKrAviUAlnCkYacDQXijLlMJPwYh+qBg5jPgY2KDJ8FHmEq4BO
        5WmMvTtbkoSsw3d1dShXKSfShUfWvWDjoepKVUU=
X-Google-Smtp-Source: APBJJlFenJyAGZmX8lEaZL7qfj96wtFrIKUun/k3YYqQR79WUOoM+Tr06gqwq0Dkn2qCu7f7U7uISA==
X-Received: by 2002:a2e:95ca:0:b0:2b6:ed80:15d1 with SMTP id y10-20020a2e95ca000000b002b6ed8015d1mr1287788ljh.24.1689254562815;
        Thu, 13 Jul 2023 06:22:42 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id qo11-20020a170907212b00b00992b0745548sm3943114ejb.152.2023.07.13.06.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 06:22:42 -0700 (PDT)
Message-ID: <9a0817c2-4101-5c21-977d-77ac0d83a067@baylibre.com>
Date:   Thu, 13 Jul 2023 15:22:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] clk: mediatek: mt8195-topckgen: Refactor parents for
 top_dp/edp muxes
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        wenst@chromium.org, msp@baylibre.com, yangyingliang@huawei.com,
        u.kleine-koenig@pengutronix.de, miles.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230713072138.84117-1-angelogioacchino.delregno@collabora.com>
 <20230713072138.84117-3-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230713072138.84117-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/2023 09:21, AngeloGioacchino Del Regno wrote:
> The top_dp and top_edp muxes can be both parented to either TVDPLL1
> or TVDPLL2, two identically specced PLLs for the specific purpose of
> giving out pixel clock: this becomes a problem when the MediaTek
> DisplayPort Interface (DPI) driver tries to set the pixel clock rate.
> 
> In the usecase of two simultaneous outputs (using two controllers),
> it was seen that one of the displays would sometimes display garbled
> output (if any at all) and this was because:
>   - top_edp was set to TVDPLL1, outputting X GHz
>   - top_dp was set to TVDPLL2, outputting Y GHz
>     - mtk_dpi calls clk_set_rate(top_edp, Z GHz)
>       - top_dp is switched to TVDPLL1
>       - TVDPLL1 changes its rate, top_edp outputs the wrong rate.
>       - eDP display is garbled
> 
> To solve this issue, remove all TVDPLL1 parents from `top_dp` and
> all TVDPLL2 parents from `top_edp`, plus, necessarily switch both
> clocks to use the new MUX_GATE_CLR_SET_UPD_INDEXED() macro to be
> able to use the right bit index for the new parents list.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/clk/mediatek/clk-mt8195-topckgen.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> index 81daa24cadde..abb3721f6e1b 100644
> --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> @@ -417,15 +417,21 @@ static const char * const pwrmcu_parents[] = {
>   
>   static const char * const dp_parents[] = {
>   	"clk26m",
> -	"tvdpll1_d2",
>   	"tvdpll2_d2",
> -	"tvdpll1_d4",
>   	"tvdpll2_d4",
> -	"tvdpll1_d8",
>   	"tvdpll2_d8",
> -	"tvdpll1_d16",
>   	"tvdpll2_d16"
>   };
> +static const u8 dp_parents_idx[] = { 0, 2, 4, 6, 8 };
> +
> +static const char * const edp_parents[] = {
> +	"clk26m",
> +	"tvdpll1_d2",
> +	"tvdpll1_d4",
> +	"tvdpll1_d8",
> +	"tvdpll1_d16"
> +};
> +static const u8 edp_parents_idx[] = { 0, 1, 3, 5, 7 };

AFAII your solution is to force a specific TVDPLLX for each display, and 
it isn't dynamic.

Do you think it's possible to do that using the DTS ? I'm asking 
because, IMHO, this kind of setup is more friendly/readable/flexible in 
the DTS than hardcoded into the driver.

>   
>   static const char * const disp_pwm_parents[] = {
>   	"clk26m",
> @@ -957,11 +963,11 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_PWRMCU, "top_pwrmcu",
>   		pwrmcu_parents, 0x08C, 0x090, 0x094, 16, 3, 23, 0x08, 6,
>   		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_DP, "top_dp",
> -		dp_parents, 0x08C, 0x090, 0x094, 24, 4, 31, 0x08, 7),
> +	MUX_GATE_CLR_SET_UPD_INDEXED(CLK_TOP_DP, "top_dp",
> +		dp_parents, dp_parents_idx, 0x08C, 0x090, 0x094, 24, 4, 31, 0x08, 7),
>   	/* CLK_CFG_10 */
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_EDP, "top_edp",
> -		dp_parents, 0x098, 0x09C, 0x0A0, 0, 4, 7, 0x08, 8),
> +	MUX_GATE_CLR_SET_UPD_INDEXED(CLK_TOP_EDP, "top_edp",
> +		edp_parents, edp_parents_idx, 0x098, 0x09C, 0x0A0, 0, 4, 7, 0x08, 8),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_DPI, "top_dpi",
>   		dp_parents, 0x098, 0x09C, 0x0A0, 8, 4, 15, 0x08, 9),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_PWM0, "top_disp_pwm0",

-- 
Regards,
Alexandre
