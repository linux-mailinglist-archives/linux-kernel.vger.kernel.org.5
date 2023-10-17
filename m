Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6A7CC792
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbjJQPgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344415AbjJQPge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:36:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE889E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:36:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32d8c2c6dfdso5533937f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697556990; x=1698161790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMFse6qVP0SKpr/9/PirQcPWYPKukXqLgPReMEjtkyg=;
        b=vMWF7WsxKmrNoeM/6d/Zv3fnVITYgT0f1TU0W06gfEuGewsKCAiphEko1vFlMX38Wn
         WDy9BdE+eW5A70lN26/1+9+efXQC2yxHHeNYd00DLMTDATv47ElopwuoA1PndsM2WXX1
         oNSTiQFVQGRRLTcGO0lIazvnRmZ7QIt7AXf0SdLf8ovu0cMgMc30MNS41u1nclFkcLTu
         GbhWZhbEuG8TLl9mGgkRuHghI+UYvT/VukqR1yLd5vIWZzFa0IX/3KJSgAILNFaMSIDL
         vjhxIdh1xeejI7bLCk6BFPqG8jA3rr5XB9HLwCu/56JFMMdIxdEATm1LVpCr9L7kmDJo
         CsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556990; x=1698161790;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qMFse6qVP0SKpr/9/PirQcPWYPKukXqLgPReMEjtkyg=;
        b=Ht/VOCHwg0xozTgOPjrnSKqidhe0Wtc2Uil38ZqDZpwJpb0PfnYxV3dhYoEbSAwdre
         3iAVbiXdHIoeIqGjbRGBRyraHaWXVo6frdsB3N9QC/OwsYKmWIK/r6rnNGtCuipBmn31
         agDE1039ItsI8eiGmGBq7EhWLpFGOvQTUJEQrC6VyXTDNuBuP6UPIv68wB5YbMEQnOKw
         7RGRzk+izzle1OdXjle3iEzG4mHcEPqvoMwQ/zOIENbaxzxvh6b69/dFL7ObR1TMpJLs
         vO68PofKKZfFcXxAmfd7uwDDELIzjpvFh3wgdov7ytK/Hhj0K/znerntTZvLLt0d6mlC
         Pz/g==
X-Gm-Message-State: AOJu0YwpfTV1q6G0URBGohktVAD0/+gTfjRrAbBVB454oAV8LxU5wAoj
        y87RtAK3wAkgl+IF3h2XWp/QeQ==
X-Google-Smtp-Source: AGHT+IG6qN9wBjL2Wth0TPezlyQFv7dXwIHqnQPMkZ8jhf7CGi38w5msaJWBtTzjglxTf+LTJqzB5Q==
X-Received: by 2002:adf:e5c6:0:b0:319:72f8:7249 with SMTP id a6-20020adfe5c6000000b0031972f87249mr2399021wrn.66.1697556990016;
        Tue, 17 Oct 2023 08:36:30 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:93d3:2aab:95bb:3a09])
        by smtp.gmail.com with ESMTPSA id a15-20020a056000100f00b0032d9337e7d1sm40889wrx.11.2023.10.17.08.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 08:36:29 -0700 (PDT)
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
 <20231010062917.3624223-5-xianwei.zhao@amlogic.com>
 <1jedhyx51m.fsf@starbuckisacylon.baylibre.com>
 <376968a3-a0f0-3045-96fe-881c2e36be7e@amlogic.com>
 <1jbkcxv02x.fsf@starbuckisacylon.baylibre.com>
 <ce3b4fa4-5823-4784-b41f-397ad07df3c6@amlogic.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Chuan Liu <chuan.liu@amlogic.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V2 4/4] clk: meson: c3: add c3 clock peripherals
 controller driver
Date:   Tue, 17 Oct 2023 17:21:36 +0200
In-reply-to: <ce3b4fa4-5823-4784-b41f-397ad07df3c6@amlogic.com>
Message-ID: <1jy1g1tg5e.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 17 Oct 2023 at 22:59, Chuan Liu <chuan.liu@amlogic.com> wrote:

>>>>> +
>>>>> +static struct clk_regmap saradc =3D {
>>>>> +     .data =3D &(struct clk_regmap_gate_data){
>>>>> +             .offset =3D SAR_CLK_CTRL0,
>>>>> +             .bit_idx =3D 8,
>>>>> +     },
>>>>> +     .hw.init =3D &(struct clk_init_data) {
>>>>> +             .name =3D "saradc",
>>>>> +             .ops =3D &clk_regmap_gate_ops,
>>>>> +             .parent_hws =3D (const struct clk_hw *[]) {
>>>>> +                     &saradc_div.hw
>>>>> +             },
>>>>> +             .num_parents =3D 1,
>>>>> +             .flags =3D CLK_SET_RATE_PARENT,
>>>>> +     },
>>>>> +};
>>>>> +
>>>>> +static u32 pwm_parent_table[] =3D { 0, 2, 3 };
>>>> What's pwm parent 1, why can't it be used ?
>>> This 1 corresponds to gp1 pll, which is currently dedicated to emmc.
>> Given that gp1 does not exist in your PLL controller, it is going to be
>> hard to dedicate it to eMMC ;)
> Because the register corresponding to gp1_pll has permission restrictions,
> the corresponding register is read-only in the kernel (can read and write
> in the bl31 environment), here first mask the source to solve the
> permission problem before opening

The PWM sel clock does not have CLK_SET_RATE_PARENT so it is not going to
request rate change for any parent clock, it will just what is available.

Your reason does not apply here.

Also, if gp1 registers are read-only from the kernel, you can still
expose it with RO ops, possibly with CLK_GET_RATE_NOCACHE if the bl31
may change at runtime.

>>
>>>>> +
>>>>> +static const struct clk_parent_data pwm_parent_data[] =3D {
>>>>> +     { .fw_name =3D "xtal" },
>>>>> +     { .fw_name =3D "fclk_div4" },
>>>>> +     { .fw_name =3D "fclk_div3" }
>>>>> +};
>>>>> +
>>>>> +static struct clk_regmap pwm_a_sel =3D {
>>>>> +     .data =3D &(struct clk_regmap_mux_data){
>>>>> +             .offset =3D PWM_CLK_AB_CTRL,
>>>>> +             .mask =3D 0x3,
>>>>> +             .shift =3D 9,
>>>>> +             .table =3D pwm_parent_table,
>>>>> +     },
>>>>> +     .hw.init =3D &(struct clk_init_data){
>>>>> +             .name =3D "pwm_a_sel",
>>>>> +             .ops =3D &clk_regmap_mux_ops,
>>>>> +             .parent_data =3D pwm_parent_data,
>>>>> +             .num_parents =3D ARRAY_SIZE(pwm_parent_data),
>>>>> +     },
>>>>> +};
>>>>> +
>>>>> +static struct clk_regmap pwm_a_div =3D {
>>>>> +     .data =3D &(struct clk_regmap_div_data){
>>>>> +             .offset =3D PWM_CLK_AB_CTRL,
>>>>> +             .shift =3D 0,
>>>>> +             .width =3D 8,
>>>>> +     },
>>>>> +     .hw.init =3D &(struct clk_init_data){
>>>>> +             .name =3D "pwm_a_div",
>>>>> +             .ops =3D &clk_regmap_divider_ops,
>>>>> +             .parent_hws =3D (const struct clk_hw *[]) {
>>>>> +                     &pwm_a_sel.hw
>>>>> +             },
>>>>> +             .num_parents =3D 1,
>>>>> +             .flags =3D CLK_SET_RATE_PARENT,
>>>>> +     },
>>>>> +};

[...]

>>>>> +
>>>>> +static struct clk_regmap spifc =3D {
>>>>> +     .data =3D &(struct clk_regmap_gate_data){
>>>>> +             .offset =3D SPIFC_CLK_CTRL,
>>>>> +             .bit_idx =3D 8,
>>>>> +     },
>>>>> +     .hw.init =3D &(struct clk_init_data) {
>>>>> +             .name =3D "spifc",
>>>>> +             .ops =3D &clk_regmap_gate_ops,
>>>>> +             .parent_hws =3D (const struct clk_hw *[]) {
>>>>> +                     &spifc_div.hw
>>>>> +             },
>>>>> +             .num_parents =3D 1,
>>>>> +             .flags =3D CLK_SET_RATE_PARENT,
>>>>> +     },
>>>>> +};
>>>>> +
>>>>> +static u32 emmc_parent_table[] =3D { 0, 1, 2, 3, 4, 5, 7 };
>>>> What's 6 ? why can't it be used ?
>>>>
>> No answer ?
> 6 - gp1_pll,The permission reason is that the patch is submitted to open
> after the solution is resolved
>>
>>>>> +
>>>>> +static const struct clk_parent_data emmc_parent_data[] =3D {
>>>>> +     { .fw_name =3D "xtal" },
>>>>> +     { .fw_name =3D "fclk_div2" },
>>>>> +     { .fw_name =3D "fclk_div3" },
>>>>> +     { .fw_name =3D "hifi_pll" },
>>>>> +     { .fw_name =3D "fclk_div2p5" },
>>>>> +     { .fw_name =3D "fclk_div4" },
>>>>> +     { .fw_name =3D "gp0_pll" }
>>>>> +};
>> Not seeing gp1 there ? why would you need to dedicate an GP pll for MMC
>> ? Maybe I missing something but it seems to me the usual MMC rate are
>> acheivable with the fclks, especially 2p5.
> Permission reason

use RO ops.

>>
>>>>> +
>>>>> +static struct clk_regmap sd_emmc_a_sel =3D {
>>>>> +     .data =3D &(struct clk_regmap_mux_data){
>>>>> +             .offset =3D SD_EMMC_CLK_CTRL,
>>>>> +             .mask =3D 0x7,
>>>>> +             .shift =3D 9,
>>>>> +             .table =3D emmc_parent_table,
>>>>> +     },
>>>>> +     .hw.init =3D &(struct clk_init_data){
>>>>> +             .name =3D "sd_emmc_a_sel",
>>>>> +             .ops =3D &clk_regmap_mux_ops,
>>>>> +             .parent_data =3D emmc_parent_data,
>>>>> +             .num_parents =3D ARRAY_SIZE(emmc_parent_data),
>>>>> +     },
>>>>> +};
>>>>> +
>>>>> +static struct clk_regmap sd_emmc_a_div =3D {
>>>>> +     .data =3D &(struct clk_regmap_div_data){
>>>>> +             .offset =3D SD_EMMC_CLK_CTRL,
>>>>> +             .shift =3D 0,
>>>>> +             .width =3D 7,
>>>>> +     },
>>>>> +     .hw.init =3D &(struct clk_init_data){
>>>>> +             .name =3D "sd_emmc_a_div",
>>>>> +             .ops =3D &clk_regmap_divider_ops,
>>>>> +             .parent_hws =3D (const struct clk_hw *[]) {
>>>>> +                     &sd_emmc_a_sel.hw
>>>>> +             },
>>>>> +             .num_parents =3D 1,
>>>>> +             .flags =3D CLK_SET_RATE_PARENT,
>>>>> +     },
>>>>> +};
>>>>> +
>>>>> +static struct clk_regmap sd_emmc_a =3D {
>>>>> +     .data =3D &(struct clk_regmap_gate_data){
>>>>> +             .offset =3D SD_EMMC_CLK_CTRL,
>>>>> +             .bit_idx =3D 7,
>>>>> +     },
>>>>> +     .hw.init =3D &(struct clk_init_data) {
>>>>> +             .name =3D "sd_emmc_a",
>>>>> +             .ops =3D &clk_regmap_gate_ops,
>>>>> +             .parent_hws =3D (const struct clk_hw *[]) {
>>>>> +                     &sd_emmc_a_div.hw
>>>>> +             },
>>>>> +             .num_parents =3D 1,
>>>>> +             .flags =3D CLK_SET_RATE_PARENT,
>>>>> +     },
>>>>> +};

[...]

>>>>> +static u32 csi_phy_parent_table[] =3D { 0, 1, 2, 3, 4, 5, 7 };
>>>> Same here and all following instance
>>>>
>>> This 1 corresponds to gp1 pll, which is currently dedicated to emmc.
>> No it is not. Again mainline drivers are slightly different from AML
>> fork you might be used to. No PLL is dedicated to the mmc driver.
>> Unless you can make a strong case for it, I don't think it will happen
>> in the near future.
> For performance considerations, emmc needs to use a higher frequency clock
> source (currently our emmc driver has been adapted to 1152M), so we
> internally allocate gp1_pll to emmc.As mentioned above, the gp1_pll
> register permission problem is masked here first=F0=9F=99=82

Your GP1 is controlled by the SCP FW and RO for the kernel. That's all from
the clock controller POV.

No reason to remove it here and elsewhere AFAICT

>>>>> +
>>>>> +static const struct clk_parent_data csi_phy_parent_data[] =3D {
>>>>> +     { .fw_name =3D "fclk_div2p5" },
>>>>> +     { .fw_name =3D "fclk_div3" },
>>>>> +     { .fw_name =3D "fclk_div4" },
>>>>> +     { .fw_name =3D "fclk_div5" },
>>>>> +     { .fw_name =3D "gp0_pll" },
>>>>> +     { .fw_name =3D "hifi_pll" },
>>>>> +     { .fw_name =3D "xtal" }
>>>>> +};
>>>>> +
>>>>> +static struct clk_regmap csi_phy0_sel =3D {
>>>>> +     .data =3D &(struct clk_regmap_mux_data){
>>>>> +             .offset =3D ISP0_CLK_CTRL,
>>>>> +             .mask =3D 0x7,
>>>>> +             .shift =3D 25,
>>>>> +             .table =3D csi_phy_parent_table,
>>>>> +     },
>>>>> +     .hw.init =3D &(struct clk_init_data){
>>>>> +             .name =3D "csi_phy0_sel",
>>>>> +             .ops =3D &clk_regmap_mux_ops,
>>>>> +             .parent_data =3D csi_phy_parent_data,
>>>>> +             .num_parents =3D ARRAY_SIZE(csi_phy_parent_data),
>>>>> +     },
>>>>> +};
>>>>> +
>>>>> +static struct clk_regmap csi_phy0_div =3D {
>>>>> +     .data =3D &(struct clk_regmap_div_data){
>>>>> +             .offset =3D ISP0_CLK_CTRL,
>>>>> +             .shift =3D 16,
>>>>> +             .width =3D 7,
>>>>> +     },
>>>>> +     .hw.init =3D &(struct clk_init_data){
>>>>> +             .name =3D "csi_phy0_div",
>>>>> +             .ops =3D &clk_regmap_divider_ops,
>>>>> +             .parent_hws =3D (const struct clk_hw *[]) {
>>>>> +                     &csi_phy0_sel.hw
>>>>> +             },
>>>>> +             .num_parents =3D 1,
>>>>> +             .flags =3D CLK_SET_RATE_PARENT,
>>>>> +     },
>>>>> +};
>>>>> +
>>>>> +static struct clk_regmap csi_phy0 =3D {
>>>>> +     .data =3D &(struct clk_regmap_gate_data){
>>>>> +             .offset =3D ISP0_CLK_CTRL,
>>>>> +             .bit_idx =3D 24,
>>>>> +     },
>>>>> +     .hw.init =3D &(struct clk_init_data) {
>>>>> +             .name =3D "csi_phy0",
>>>>> +             .ops =3D &clk_regmap_gate_ops,
>>>>> +             .parent_hws =3D (const struct clk_hw *[]) {
>>>>> +                     &csi_phy0_div.hw
>>>>> +             },
>>>>> +             .num_parents =3D 1,
>>>>> +             .flags =3D CLK_SET_RATE_PARENT,
>>>>> +     },
>>>>> +};
