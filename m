Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB9C76E350
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjHCIjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjHCIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:39:28 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B52F4221;
        Thu,  3 Aug 2023 01:38:00 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id AC5BE8067;
        Thu,  3 Aug 2023 16:37:52 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 3 Aug
 2023 16:37:52 +0800
Received: from [192.168.125.84] (183.27.98.54) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 3 Aug
 2023 16:37:51 +0800
Message-ID: <34c8c9d5-fad0-52ce-d1e6-798546005bfd@starfivetech.com>
Date:   Thu, 3 Aug 2023 16:37:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 2/3] ASoC: starfive: Add JH7110 PWM-DAC driver
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230731032829.127864-1-hal.feng@starfivetech.com>
 <20230731032829.127864-3-hal.feng@starfivetech.com>
 <9b03c7ed-845c-494b-8c40-10d1fe923b15@sirena.org.uk>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <9b03c7ed-845c-494b-8c40-10d1fe923b15@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.54]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 20:14:38 +0100, Mark Brown wrote:
> On Mon, Jul 31, 2023 at 11:28:28AM +0800, Hal Feng wrote:
> 
>> +static const struct jh7110_ct_pwmdac pwmdac_ct_data_shift[] = {
>> +	{ .name = "left 0 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_0 },
>> +	{ .name = "left 1 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_1 },
>> +	{ .name = "left 2 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_2 },
>> +	{ .name = "left 3 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_3 },
>> +	{ .name = "left 4 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_4 },
>> +	{ .name = "left 5 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_5 },
>> +	{ .name = "left 6 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_6 },
>> +	{ .name = "left 7 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_7 }
>> +};
> 
> It's not clear to me why this is user selectable - what does the control
> do?

It's convenient to change the register values in user space with the
control. But actually using fixed register configuration is enough.
I will drop all these control in the next version.

> 
>> +static int jh7110_pwmdac_put(struct snd_kcontrol *kcontrol,
>> +			     struct snd_ctl_elem_value *ucontrol,
>> +			     int pwmdac_ct)
>> +{
>> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
>> +	struct jh7110_pwmdac_dev *dev = snd_soc_component_get_drvdata(component);
>> +	int sel = ucontrol->value.enumerated.item[0];
>> +	unsigned int items;
> 
>> +	if (pwmdac_ct == PWMDAC_CT_SHIFT)
>> +		dev->shift = pwmdac_ct_shift[sel].vals;
>> +	else if (pwmdac_ct == PWMDAC_CT_DUTY_CYCLE)
>> +		dev->duty_cycle = pwmdac_ct_duty_cycle[sel].vals;
>> +	else if (pwmdac_ct == PWMDAC_CT_DATA_CHANGE)
>> +		dev->data_change = pwmdac_ct_data_change[sel].vals;
>> +	else if (pwmdac_ct == PWMDAC_CT_DATA_MODE)
>> +		dev->data_mode = pwmdac_ct_data_mode[sel].vals;
>> +	else if (pwmdac_ct == PWMDAC_CT_DATA_SHIFT)
>> +		dev->data_shift = pwmdac_ct_data_shift[sel].vals;
>> +
>> +	return 0;
>> +}
> 
> _put() operations should return 1 if the control value changes so event
> generation works - please test a card using this driver with the
> mixer-test selftest, it'll identify this and a bunch of other potential
> issues.

Thanks for the correct, but it doesn't matter as I will drop these control
later.

> 
>> +static int jh7110_pwmdac_component_probe(struct snd_soc_component *component)
>> +{
>> +	snd_soc_add_component_controls(component, jh7110_pwmdac_snd_controls,
>> +				       ARRAY_SIZE(jh7110_pwmdac_snd_controls));
>> +	return 0;
>> +}
> 
> The driver can just point to the controls from the _driver struct and
> skip having a probe() function.

Thanks for your advice, but I would like to drop these control later.

Thanks again for your review.

Best regards,
Hal
