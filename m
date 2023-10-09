Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B37B7BEA39
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378293AbjJITA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378172AbjJITAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:00:54 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FC99C;
        Mon,  9 Oct 2023 12:00:51 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 513D460A9E;
        Mon,  9 Oct 2023 22:00:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Z0imEe6DeSw0-tb5Kw72p;
        Mon, 09 Oct 2023 22:00:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
        t=1696878048; bh=Q0kzR1Hkqz2cOVD+5iFO30kiqBo+q8tCC8dS7GzQR8s=;
        h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
        b=JLtChTSwho6cSk5GB+t52/2PP2CUNKzRSTrNKHb+N57FkOR2uUdsrbIYNfZlz8kdc
         vBL6blQzTg9Pzjdd5BBkGTM+cWB+SYJ+S4Cy3h8rHOz8B2QzTOXmt2PARTJoUcnyjl
         f6I8oD/FvT/m4sRE/bwTkJthJi0cYmSIX9T7NbeM=
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
Date:   Mon,  9 Oct 2023 22:00:26 +0300
Message-ID: <20231009190027.10304-1-efectn@6tel.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009054034.am2e4hcmwoworeml@dhruva>
References: <20231009054034.am2e4hcmwoworeml@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9.10.2023 08:40, Dhruva Gole wrote:
> Hello,
> 
> On Oct 05, 2023 at 16:54:04 +0300, Muhammed Efe Cetin wrote:
>> Hello,
>>
>> On 28.09.2023 13:51, Dhruva Gole wrote:
>>> Hi,
>>>
>>> On Aug 21, 2023 at 18:47:59 +0300, Muhammed Efe Cetin wrote:
>>>> Add initial support for OPi5 that includes support for USB2, PCIe2, Sata,
>>>> Sdmmc, SPI Flash, PMIC.
>>>>
>>>> Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
>>>> Reviewed-by: Ondřej Jirman <megi@xff.cz>
>>>> ---
>>>>    arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>>>    .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 673 ++++++++++++++++++
>>>>    2 files changed, 674 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
>>>>
>>> ...
>>>
>>> Can you provide some sort of documentation on how I can build and boot
>>> the kernel on this board? I was unable to use the upstream arm64
>>> defconfig with this exact series applied to boot the board.
>>
>> What was wrong when you tried to compile & boot the board? Can you provide some logs?
> 
> Umm don't have logs at hand, but I remember it didn't really reach the
> linux first line either, it went into sort of a bootloop just after
> the uboot stage.

Hmm there might be issue with your uboot compilation. It'd be better if you provide useful logs.

> 
>>
>>>
>>>> +
>>>> +&i2c6 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&i2c6m3_xfer>;
>>>> +	status = "okay";
>>>> +
>>>> +	hym8563: rtc@51 {
>>>> +		compatible = "haoyu,hym8563";
>>>> +		reg = <0x51>;
>>>> +		#clock-cells = <0>;
>>>> +		clock-output-names = "hym8563";
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&hym8563_int>;
>>>> +		interrupt-parent = <&gpio0>;
>>>> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
>>>> +		wakeup-source;
>>>
>>> Are you able to actually use rtc as a wakeup source? I tried this
>>> on a downstream kernel that I mention below..
>>>
>>> rtcwake -s 10 -m mem
>>>
>>> didn't actually seem to wake the device from deepsleep after 10 seconds.
>>> Do you know what other pins I can use as wakeup sources?
>>
>> No, i've not tried it before.
> 
> ah okay
> 
>>
>>>
>>>> +	};
>>>> +};
>>>> +
>>>> +&mdio1 {
>>>> +	rgmii_phy1: ethernet-phy@1 {
>>>> +		compatible = "ethernet-phy-ieee802.3-c22";
>>>
>>> Just wondering, can you please give some logs of the board with eth
>>> working? The image that I have from opi seems to fail eth? As in I am
>>> not able to see any ip address. here are the logs:
>>>
>>> https://gist.github.com/DhruvaG2000/eda2762e35013c8d5ac9f37e818103a3
>>
>> Unfortunately the board is not near me currently. However, i was able to use GMAC ethernet in both the upstreram and downstream kernels. Did you try any images other than Orange Pi ones?
> 
> Nope, are there any other images that maybe more suitable? Please can you point me to them?

You can check the images below the Third Party Images section in OPi's download page. GMAC should work properly with most of them.

> 
>>
>>>
>>> ...
>>>
>>
> 
