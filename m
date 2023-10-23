Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031857D40A1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjJWUHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjJWUH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:07:29 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4E4D68;
        Mon, 23 Oct 2023 13:07:27 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id D5EB6120014;
        Mon, 23 Oct 2023 23:07:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D5EB6120014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1698091644;
        bh=6nprZO3dzKZSeMwqmtQlXFQ3CBnQLenNbiuNbUHf8kU=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=tkrlIrhp/4WgQfs8TbMCH/7ZNqvAq47LWAm85Ym2H5td7RCq64AH2Ige5Kxl7Cuv2
         f0PYoVvzkryj2McKPii14GPp8+tTnax5CX8gmvmkZ2Hu7XX+GXi+kT2Oql403afsyh
         BwxrtPMierl8ZjlHyp4ypiJGV5oOTyCEmFfMqYBSOCpoJao3IRo+y7fLwTvlc5ISzS
         zXAITWdhebzq2rMbZBQIxf/m9cCrFyzjyBOUlYaah4KZ/YJ8OLl/PXEiIzA0YpLLqY
         KnicpAlJD8tsrGSoU0Ns0af5+Ozj+53KkJlsHYAeLxnbbDMBSKrKyrjGYF6cOrxcQE
         tmLoSPVyT5dhA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 23 Oct 2023 23:07:24 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 23 Oct 2023 23:07:24 +0300
Message-ID: <10dcc778-f165-407e-b765-760d277d5e35@salutedevices.com>
Date:   Mon, 23 Oct 2023 23:07:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 RESEND] pwm: meson: add pwm support for S4
Content-Language: en-US
To:     JunYi Zhao <junyi.zhao@amlogic.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20231016052457.1191838-1-junyi.zhao@amlogic.com>
From:   George Stark <gnstark@salutedevices.com>
In-Reply-To: <20231016052457.1191838-1-junyi.zhao@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180818 [Oct 23 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 542 542 3d23828e213bab96daa5e52f9cef518f74e40214, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/23 18:09:00 #22267281
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello JunYi Zhao

On 10/16/23 08:24, JunYi Zhao wrote:
> From: "junyi.zhao" <junyi.zhao@amlogic.com>
> 
> Support PWM for S4 soc.
> Now the PWM clock input is done in independent CLKCTRL registers.
> And no more in the PWM registers.
> PWM needs to obtain an external clock source.
> 
> Signed-off-by: junyi.zhao <junyi.zhao@amlogic.com>
> ---
> V2 -> V3:
> Rebase and Review the latest upstream code again.
> After reconstruction, stick to the previous code as much as possible.
>   drivers/pwm/pwm-meson.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 25519cddc2a9..fe9fd75747c4 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -99,6 +99,7 @@ struct meson_pwm_channel {
>   struct meson_pwm_data {
>   	const char * const *parent_names;
>   	unsigned int num_parents;
> +	unsigned int extern_clk;
may be bool extern_clk;
>   };
>   
>   struct meson_pwm {
> @@ -396,6 +397,10 @@ static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
>   	.num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
>   };
>   
> +static const struct meson_pwm_data pwm_s4_data = {
> +	.extern_clk = true,
> +};
> +
>   static const struct of_device_id meson_pwm_matches[] = {
>   	{
>   		.compatible = "amlogic,meson8b-pwm",
> @@ -429,6 +434,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>   		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>   		.data = &pwm_g12a_ao_cd_data
>   	},
> +	{
> +		.compatible = "amlogic,s4-pwm",
> +		.data = &pwm_s4_data,
> +	},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
> @@ -451,6 +460,16 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>   		struct clk_parent_data div_parent = {}, gate_parent = {};
>   		struct clk_init_data init = {};
>   
> +		if (meson->data->extern_clk) {
> +			snprintf(name, sizeof(name), "clkin%u", i);
> +			channel->clk = devm_clk_get(dev, name);
> +			if (IS_ERR(channel->clk)) {
> +				dev_err(meson->chip.dev, "can't get device clock\n");
> +				return PTR_ERR(channel->clk);
> +			}
> +			continue;
> +		}
> +
>   		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>   
>   		init.name = name;
> 
> base-commit: 4d2c646ac07cf4a35ef1c4a935a1a4fd6c6b1a36

-- 
Best regards
George
