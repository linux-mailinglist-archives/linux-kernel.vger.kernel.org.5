Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CEC7CCA30
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjJQRyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJQRya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:54:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D62B90
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:54:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40572aeb673so56687555e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697565266; x=1698170066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUUCkiu5vUAHLKvjzzzRJs8u1+C022EMiTeERsZUBSE=;
        b=zYPdVUDaC2JicSkU4IMs9d9NBqFPCry6g4Ba4t6ARWvAGQoOVBygefGGeBhfDzH/Cn
         1xHfyPbeQtmpAM0aj8eipbnl692o2eLCi/o1Nvrv6ENCr2u4MR7BsoKdDy8PfRTQZFMn
         YVXd/Ni9hrdNlVwk+q/5ciZprB2KmKfZgi0q8rEuB7H3oMTCqo6Rt3Grm1W4+2nWm0Oy
         ZuKva5akUaHLAkgQHNiZQVGhEv0U5iPdNsVxagXXNzqEIQp52FAhEjBmaC9fDpms5QJL
         9UrNHxpHAc7cJuAZOjgKO6I63XU6M26RuOZOGuSb6gLd2MaXbuoI0wNBOqEDYO0IRG2G
         RUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697565266; x=1698170066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUUCkiu5vUAHLKvjzzzRJs8u1+C022EMiTeERsZUBSE=;
        b=Sbuuseu9UJ9DizLsrKndUyG5dPn0P4GJ5WM18BpFIH82Esa8KeS2SXT8cBvxJ102kb
         7DvkV9OuLwHxfx0ezQhGQom2oqJId79HnYUGug4Xe5deWZwTCLYeNoXJ2cYDfg9LlBDu
         TLLx/VasdE9TAQzF7VTRQPYClE8di3llY5ndecNESTsLNKDTmtul0EXHAxIxRmcOrqqf
         3J2Uhi6Ec1Nfv5i5UJcufFd5ol2gyxgkQj2/hlykL+7/csRRbF47e2Da6zqKAh90kvMF
         cIBZ/UP6Z6y2SNdn4Vy801EP1xvQ0Pqzvp6MYGmfEGqk/qoOgxNaxJfyJ7e8h2vIiPkY
         L4Cg==
X-Gm-Message-State: AOJu0YxbLenJhajMWR45qmhg2f3ADn9Ij0XPonPbU3muA5IbxdZObqhZ
        2vjAhJc4jnpx0gB7tC6kAi7mVw==
X-Google-Smtp-Source: AGHT+IG505kDYsm+03qRLM/qO/s22ze8aCQIk76ph//q3WRXO4DCwOktsuci2V9jr+fr4BJ+ziIiuw==
X-Received: by 2002:a05:600c:3114:b0:407:7e5f:ffb9 with SMTP id g20-20020a05600c311400b004077e5fffb9mr2450207wmo.9.1697565266528;
        Tue, 17 Oct 2023 10:54:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id v18-20020a05600c15d200b00406447b798bsm2221328wmf.37.2023.10.17.10.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:54:26 -0700 (PDT)
Message-ID: <2d5190ed-5c95-4278-8e70-211a71de821b@linaro.org>
Date:   Tue, 17 Oct 2023 19:54:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] thermal: lvts: make some read-only arrays static
 const
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231017171655.177096-1-colin.i.king@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231017171655.177096-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Colin,

On 17/10/2023 19:16, Colin Ian King wrote:
> Don't populate the read-only arrays on the stack, instead make them
> static const. 

Why ?

> Make lvts_write_config parameters cmds and nr_cmds
> const too.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 877a0e5ac3fd..b20e69cb466f 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -308,7 +308,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>   
>   static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
>   {
> -	u32 masks[] = {
> +	static const u32 masks[] = {
>   		LVTS_MONINT_OFFSET_SENSOR0,
>   		LVTS_MONINT_OFFSET_SENSOR1,
>   		LVTS_MONINT_OFFSET_SENSOR2,
> @@ -400,7 +400,7 @@ static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
>   {
>   	irqreturn_t iret = IRQ_NONE;
>   	u32 value;
> -	u32 masks[] = {
> +	static const u32 masks[] = {
>   		LVTS_INT_SENSOR0,
>   		LVTS_INT_SENSOR1,
>   		LVTS_INT_SENSOR2,
> @@ -781,7 +781,7 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
>    * each write in the configuration register must be separated by a
>    * delay of 2 us.
>    */
> -static void lvts_write_config(struct lvts_ctrl *lvts_ctrl, u32 *cmds, int nr_cmds)
> +static void lvts_write_config(struct lvts_ctrl *lvts_ctrl, const u32 *cmds, const int nr_cmds)
>   {
>   	int i;
>   
> @@ -865,7 +865,8 @@ static int lvts_ctrl_set_enable(struct lvts_ctrl *lvts_ctrl, int enable)
>   
>   static int lvts_ctrl_connect(struct device *dev, struct lvts_ctrl *lvts_ctrl)
>   {
> -	u32 id, cmds[] = { 0xC103FFFF, 0xC502FF55 };
> +	u32 id;
> +	static const u32 cmds[] = { 0xC103FFFF, 0xC502FF55 };
>   
>   	lvts_write_config(lvts_ctrl, cmds, ARRAY_SIZE(cmds));
>   
> @@ -889,7 +890,7 @@ static int lvts_ctrl_initialize(struct device *dev, struct lvts_ctrl *lvts_ctrl)
>   	/*
>   	 * Write device mask: 0xC1030000
>   	 */
> -	u32 cmds[] = {
> +	static const u32 cmds[] = {
>   		0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098D, 0xC10308F1,
>   		0xC10307A6, 0xC10306B8, 0xC1030500, 0xC1030420, 0xC1030300,
>   		0xC1030030, 0xC10300F6, 0xC1030050, 0xC1030060, 0xC10300AC,

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

