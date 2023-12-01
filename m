Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB61800597
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377815AbjLAIbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:31:52 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC759170C;
        Fri,  1 Dec 2023 00:31:54 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1CB8E4001A;
        Fri,  1 Dec 2023 08:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701419513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G662Lum/IwLyA/HpHCfZJ9Kv+HVUlnLAq1Z9xdL98DQ=;
        b=m1oT+hG0KBDSwDxlAXifY4jG4ysNPmM87KlLqlwvyByfMCvhiRYoIZqHvlJ0jTtFWSF4gX
        CVY00it3MURoks5XL6YmesQOlkRxpwfLR06pAoJ1h0oGJnYjryyhp594EJCwELHifG1l9R
        E787PKki84Qz2oOSgpzk39nJdNU5CwvldVo2YGY2RbOGq73XLp4GknIOYNOfjPaahneZh3
        4ApgZpnw2ezQzozlFsEICd/YaTHeWF57xWXcAoidjngi2u0uGJjC2LNZcNGOl8/JdI+IID
        xDbxJW6vV75gHYyjUo1Cxy5tZWdIvAPFsdtyfp5dO1DmtUFD2ok0iZ8XM5vWgw==
Message-ID: <b9f5e141-c6d4-40a6-b467-a490f1464704@bootlin.com>
Date:   Fri, 1 Dec 2023 09:31:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
To:     Nishanth Menon <nm@ti.com>
Cc:     vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
        thomas.petazzoni@bootlin.com, u-kumar1@ti.com,
        Esteban Blanc <eblanc@baylibre.com>,
        Jai Luthra <j-luthra@ti.com>
References: <20231027082852.2922552-1-thomas.richard@bootlin.com>
 <20231201051449.sijqtozzup4z6exd@ladder>
Content-Language: en-US
From:   Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20231201051449.sijqtozzup4z6exd@ladder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/23 06:14, Nishanth Menon wrote:
> On 10:28-20231027, Thomas Richard wrote:
>> From: Esteban Blanc <eblanc@baylibre.com>
>>
>> This patch adds support for TPS6594 PMIC family on wakup I2C0 bus.
>> Theses devices provides regulators (bucks and LDOs), but also
>> GPIOs, a RTC, a watchdog, an ESM (Error Signal Monitor)
>> which monitors the SoC error output signal, and a PFSM
>> (Pre-configurable Finite State Machine) which manages the
>> operational modes of the PMIC.
>>
>> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
>> Signed-off-by: Jai Luthra <j-luthra@ti.com>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
>>
>> Notes:
>>     This patch was picked from:
>>     https://lore.kernel.org/all/20230810-tps6594-v6-0-2b2e2399e2ef@ti.com/
>>     
>>     I reviewed it, and checked that there is no issue during the boot.
> 
> Thank you, but I am considering a more comprehensive series from Neha[1]
> instead, if you don't mind.

It's ok for me.
Neha told me he sent a new version of the series.
I sent only this patch, as I was able to test only j7200.

Regards,

Thomas

