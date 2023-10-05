Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819897BA342
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjJEPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbjJEPvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:05 -0400
X-Greylist: delayed 878 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 07:09:27 PDT
Received: from forward203c.mail.yandex.net (forward203c.mail.yandex.net [178.154.239.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C568B47B5;
        Thu,  5 Oct 2023 07:09:27 -0700 (PDT)
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by forward203c.mail.yandex.net (Yandex) with ESMTP id DCDB465257;
        Thu,  5 Oct 2023 16:54:49 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 4C57E60118;
        Thu,  5 Oct 2023 16:54:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5sYS4WpDR8c0-c59Uhkbc;
        Thu, 05 Oct 2023 16:54:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
        t=1696514056; bh=djv/zTCmEEO0N9ZJ0kPB68viw9nxhWIGHqi+5kw6/nk=;
        h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
        b=mxjIvrbWDeQZsZfQoZxIAayHgrDIZBpf/35k7buCmGNqzgA1wms/0ZYX33Ym9XHmP
         TYWEQzWj9cfX6nPeiV05eP2L6h263aubX3vkAPPjLbCCyb5l5GR4fMWGml3EujhLZm
         iMN34tW9If/TvZtdJMXz4R80jSIM4Rq43htSKp0w=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From:   Muhammed Efe Cetin <efectn@6tel.net>
To:     d-gole@ti.com
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org, efectn@6tel.net,
        heiko@sntech.de, jonas@kwiboo.se,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, megi@xff.cz,
        robh+dt@kernel.org, sebastian.reichel@collabora.com
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: Add Orange Pi 5
Date:   Thu,  5 Oct 2023 16:54:04 +0300
Message-ID: <20231005135405.257495-1-efectn@6tel.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230928105137.5ljhuoxjc7et5thw@dhruva>
References: <20230928105137.5ljhuoxjc7et5thw@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 28.09.2023 13:51, Dhruva Gole wrote:
> Hi,
> 
> On Aug 21, 2023 at 18:47:59 +0300, Muhammed Efe Cetin wrote:
>> Add initial support for OPi5 that includes support for USB2, PCIe2, Sata,
>> Sdmmc, SPI Flash, PMIC.
>>
>> Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
>> Reviewed-by: Ondřej Jirman <megi@xff.cz>
>> ---
>>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>   .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 673 ++++++++++++++++++
>>   2 files changed, 674 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
>>
> ...
> 
> Can you provide some sort of documentation on how I can build and boot
> the kernel on this board? I was unable to use the upstream arm64
> defconfig with this exact series applied to boot the board.

What was wrong when you tried to compile & boot the board? Can you provide some logs?

> 
>> +
>> +&i2c6 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c6m3_xfer>;
>> +	status = "okay";
>> +
>> +	hym8563: rtc@51 {
>> +		compatible = "haoyu,hym8563";
>> +		reg = <0x51>;
>> +		#clock-cells = <0>;
>> +		clock-output-names = "hym8563";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&hym8563_int>;
>> +		interrupt-parent = <&gpio0>;
>> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
>> +		wakeup-source;
> 
> Are you able to actually use rtc as a wakeup source? I tried this
> on a downstream kernel that I mention below..
> 
> rtcwake -s 10 -m mem
> 
> didn't actually seem to wake the device from deepsleep after 10 seconds.
> Do you know what other pins I can use as wakeup sources?

No, i've not tried it before.

> 
>> +	};
>> +};
>> +
>> +&mdio1 {
>> +	rgmii_phy1: ethernet-phy@1 {
>> +		compatible = "ethernet-phy-ieee802.3-c22";
> 
> Just wondering, can you please give some logs of the board with eth
> working? The image that I have from opi seems to fail eth? As in I am
> not able to see any ip address. here are the logs:
> 
> https://gist.github.com/DhruvaG2000/eda2762e35013c8d5ac9f37e818103a3

Unfortunately the board is not near me currently. However, i was able to use GMAC ethernet in both the upstreram and downstream kernels. Did you try any images other than Orange Pi ones?

> 
> ...
> 
