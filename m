Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4691D792B19
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbjIEQrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354437AbjIELhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:37:18 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F38F1AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=s1; bh=8Oon+UZVxMzjsZmhyhxxf4Iok+yFxg7JUkPTPozzk2Y=;
        b=UVXSHcpHRkuysgyXTlsLgYFD5G8Zf+7iKD2zhOY93EMero2+yHxox8SQCGOt52IQsbmu
        LFG86tfIhEG9SBKzMcjTS87Wr08UHxaVaQogNfYs7JVvDqPhoreHTP9FFGnawws9df7mj6
        gF8V2GOKOo4yTnmrUATsP1JSxx5YAuNK+YXHfODzvk9sOiMcr94AY+F+QBGTAdgWxhcRNT
        AsyHlKVqRDA5sFQe5qbAYVDFozpAz+F0Lt2Dwgh1XdEHxPfb7SKwakXtZjVNg56Ge/gCgt
        50ipMMb5phMrP8fQlWDiy+ziLLN0+hi5IxX27I4crpuV+ih+2LPFRUZYCHYmya9g==
Received: by filterdrecv-7765c6879f-mrb57 with SMTP id filterdrecv-7765c6879f-mrb57-1-64F71232-5
        2023-09-05 11:34:10.187704852 +0000 UTC m=+2232639.625816428
Received: from [192.168.1.50] (unknown)
        by geopod-ismtpd-8 (SG) with ESMTP
        id jd1KlkDuTLa2t2toI-Tyqw
        Tue, 05 Sep 2023 11:34:09.834 +0000 (UTC)
Message-ID: <ca8d3730-dc32-0192-d812-82cc58700260@kwiboo.se>
Date:   Tue, 05 Sep 2023 11:34:10 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/3] Make Rockchip IO domains dependency from other
 devices explicit
Content-Language: en-US
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230904115816.1237684-1-s.hauer@pengutronix.de>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h8rKZkhjZNKspq1qu?=
 =?us-ascii?Q?L4Ur5DSU6M7CKd5T0Kq7NrTwxkY0tJnRNwRv890?=
 =?us-ascii?Q?ix6HcaePIYyKW9zxu6ZLyGrpetznd+uB5S1Dlgl?=
 =?us-ascii?Q?plZTeXSWqP9NfqnFo7J=2FZab5+FSbBkH8lju7GTo?=
 =?us-ascii?Q?pVDtsmY87Fwltw+ZpyRuwb65ai5cWJcyIpndsM?=
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

On 2023-09-04 13:58, Sascha Hauer wrote:
> This is a continuation of the patch posted by Quentin Schulz here [1]
> 
> This series aims to solve a problem with Rockchip IO domains. On many
> Rockchip SoCs the pins are driven by external supplies normally
> controlled by regulators of a PMIC. There are multiple voltages allowed
> for the regulators; additionally the chosen voltage has to be programmed
> into SoC registers. There already is a driver [2] handling setting these
> registers. The driver works by registering a notifier on the regulators.
> Whenever a regulator is about to change its voltage then the notifier will
> program the IO domain registers suitably for the new voltage.
> 
> The problem is that there is no dependency between pins and the IO
> domain driver which means that it can happen that a pin is used before
> the IO domain driver has been probed. In that case the pin can end up
> being non functional as neither the regulator has been configured
> correctly nor the SoC registers have been adjusted to the regulators
> voltage.
> 
> One way to ensure correct probing order is to defer probing of devices
> in the pinctrl driver until the IO domain driver has been probed. We
> can't do this for all devices though, as that would introduce a cyclic
> dependency when for example the I2C port needed to access the PMIC for
> the regulators is part of a IO domain itself.
> 
> This series solves these problems similarly to Quentins patch. With
> Quentins patch we would have to add rockchip,io-domain properties for
> all pin group nodes we wish to honor the IO domain dependency for. We
> could put these properties into the board dts files which would mean
> that we either only add the properties to nodes which actually byte us,
> or that we would have to add the properties to all possible pin groups
> except the ones needed to access the PMIC. We could also put these
> properties into the dtsi files, but that would mean a board has to add a
> /delete-property/ rockchip,io-domain to the pin groups needed to access
> the PMIC to avoid circular dependencies.
> 
> The approach chosen here is slightly different. First of all this series
> doesn't change the current behaviour without board specific dts changes.
> To activate the IO domain dependency handling, a board has to add a
> rockchip,io-domains property to the pinctrl node. When this property is
> present all pins are assumed to need the IO domain driver. Pin groups
> needed to access the PMIC can then be given a rockchip,io-domain-boot-on
> property. When this property is given then the IO domain is assumed to
> be correctly configured by the boot loader. It should be added to all
> pin groups needed to access the PMIC to avoid cyclic dependencies. Patch
> 3/3 contains a usage example for the Radxa Rock-3a.

FYI, I have sent out a series that ports the IO domain driver to U-Boot.
This was needed to have working Ethernet on RK356x devices that use a
1.8V PHY. Initially only RK356x support have been ported but support for
other SoCs should follow in the future. Vendor U-Boot also initialize
the IO domain configuration based on the voltage reported by the
supplying regulator.

So at least for the example board IO domains should be configured when
entering linux while booting using a future version of mainline U-Boot.

https://lore.kernel.org/u-boot/20230821223020.3918620-1-jonas@kwiboo.se/

Regards,
Jonas

> 
> Sascha
> 
> [1] https://lore.kernel.org/lkml/20220802095252.2486591-1-foss+kernel@0leil.net/
> [2] drivers/soc/rockchip/io-domain.c
> 
> Sascha Hauer (3):
>   pinctrl: rockchip: add support for io-domain dependency
>   dt-bindings: pinctrl: rockchip: Add io domain properties
>   arm64: dts: rockchip: rock-3a: add io domain properties
> 
>  .../bindings/pinctrl/rockchip,pinctrl.yaml    | 13 +++-
>  .../boot/dts/rockchip/rk3568-rock-3a.dts      | 11 ++++
>  drivers/pinctrl/pinctrl-rockchip.c            | 64 +++++++++++++++++++
>  drivers/pinctrl/pinctrl-rockchip.h            |  3 +
>  4 files changed, 90 insertions(+), 1 deletion(-)
> 

