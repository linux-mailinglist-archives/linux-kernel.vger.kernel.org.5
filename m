Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DAD79DEDB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 06:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjIMEE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 00:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIMEEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 00:04:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8A2E4B;
        Tue, 12 Sep 2023 21:04:18 -0700 (PDT)
X-UUID: 98ca723051ea11ee8051498923ad61e6-20230913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=Uv9SfrdM9gAKy8Qa0F4yVH9o4de4qwEitUTuqWTnByA=;
        b=nCAuJJ5qUsyZpGcLE1XtalOly4pXTO0swZ8p2ZgYEvnl8YV9lESmIi2DEP4uOpPnkQuCRGwrlvzoXn46ymKXRSsv5NqZWTpUQO4daLS+SmPcp4XgqFgW3VyBoGRgLBwhiWB2K2Il4yXzD3ISpiAckClqrUvV0KadFujZqiEXfcQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:2432b400-c321-4d48-bb1e-3cf4ef7046a0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:e038e013-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 98ca723051ea11ee8051498923ad61e6-20230913
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 341470103; Wed, 13 Sep 2023 12:04:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Sep 2023 12:04:09 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 13 Sep 2023 12:04:09 +0800
Message-ID: <0035b43a-1172-c8f0-7033-85f149149ad9@mediatek.com>
Date:   Wed, 13 Sep 2023 12:04:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: add device-tree for Genio 700
 EVK board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Chris-QJ Chen <chris-qj.chen@mediatek.com>
References: <20230912140613.6528-1-macpaul.lin@mediatek.com>
 <20230912140613.6528-2-macpaul.lin@mediatek.com>
 <7a036d2b-ed59-f581-d018-479cc634617e@linaro.org>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <7a036d2b-ed59-f581-d018-479cc634617e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.550600-8.000000
X-TMASE-MatchedRID: oTBA/+sdKaYOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
        qIY+/skQkABPgKBt/0qbqzDH9G7eTK6EIEWX9vrei/vfAS7Q3Hv54F/2i/DwjWYC5Atx1DUQLoj
        IF2zyxe5OJB5wP1oqhJIsozNWXuFtHVyRZCioB7+zI1v7J4hECn5Vr62Os+xivDa284z78yfePd
        M6BjX2XqdS0I0ZMbxhVjTaBrCCDAoAwWnlblYdAp4CIKY/Hg3AtOt1ofVlaoLUHQeTVDUrItRnE
        QCUU+jzjoczmuoPCq0PESG/w4M2US/Q1SaB3NTAol5Q+nDJxYSjmxuCJ/adALxNxWONISiR
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.550600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: FA1045D0AC6BC6EA46E0FF9DD615CAEA5E7049021EEE9C4B6C7E207889DF05352000:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 22:32, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On 12/09/2023 16:06, Macpaul Lin wrote:
>> Add basic device-tree for the Genio 700 EVK board. The
>> Genio 700 EVK is based on MediaTek MT8390 SoC.
>> MT8390 hardware register maps are identical to MT8188.
>> 
>> The Genio 700 EVK has following features:
>> 
> 
> 
> ...
> 
>> +
>> +sdio_fixed_1v8: regulator-3 {
>> +compatible = "regulator-fixed";
>> +regulator-name = "sdio_io";
>> +regulator-min-microvolt = <1800000>;
>> +regulator-max-microvolt = <1800000>;
>> +enable-active-high;
>> +regulator-always-on;
>> +};
>> +
>> +sdio_fixed_3v3: regulator-4 {
>> +compatible = "regulator-fixed";
>> +regulator-name = "sdio_card";
>> +regulator-min-microvolt = <3300000>;
>> +regulator-max-microvolt = <3300000>;
>> +gpio = <&pio 74 0>;
> 
> Use proper defines.

Fixed remaining 3 defines of gpio value, will send v2.

>> +enable-active-high;
>> +regulator-always-on;
>> +};
>> +
>> +touch0_fixed_3v3: regulator-5 {
>> +compatible = "regulator-fixed";
>> +regulator-name = "touch_3v3";
>> +regulator-min-microvolt = <3300000>;
>> +regulator-max-microvolt = <3300000>;
>> +gpio = <&pio 119 GPIO_ACTIVE_HIGH>;
>> +enable-active-high;
>> +};
>> +
>> +usb_hub_fixed_3v3: regulator-6 {
>> +compatible = "regulator-fixed";
>> +regulator-name = "usb_hub_3v3";
>> +regulator-min-microvolt = <3300000>;
>> +regulator-max-microvolt = <3300000>;
>> +gpio = <&pio 112 0>; /* HUB_3V3_EN */
>> +startup-delay-us = <10000>;
>> +enable-active-high;
>> +};
>> +
>> +usb_hub_reset_1v8: regulator-7 {
>> +compatible = "regulator-fixed";
>> +regulator-name = "usb_hub_reset";
>> +regulator-min-microvolt = <1800000>;
>> +regulator-max-microvolt = <1800000>;
>> +gpio = <&pio 7 0>; /* HUB_RESET */
>> +vin-supply = <&usb_hub_fixed_3v3>;
>> +};
>> +
>> +usb_p0_vbus: regulator-8 {
>> +compatible = "regulator-fixed";
>> +regulator-name = "usb_p0_vbus";
>> +regulator-min-microvolt = <5000000>;
>> +regulator-max-microvolt = <5000000>;
>> +gpio = <&pio 84 GPIO_ACTIVE_HIGH>;
>> +enable-active-high;
>> +};
>> +
>> +usb_p1_vbus: regulator-9 {
>> +compatible = "regulator-fixed";
>> +regulator-name = "usb_p1_vbus";
>> +regulator-min-microvolt = <5000000>;
>> +regulator-max-microvolt = <5000000>;
>> +gpio = <&pio 87 GPIO_ACTIVE_HIGH>;
>> +enable-active-high;
>> +};
>> +
>> +usb_p2_vbus: regulator-10 {
>> +compatible = "regulator-fixed";
>> +regulator-name = "usb_p2_vbus";
>> +regulator-min-microvolt = <5000000>;
>> +regulator-max-microvolt = <5000000>;
>> +enable-active-high;
>> +};
>> +};
>> +
>> +&i2c0 {
>> +pinctrl-names = "default";
>> +pinctrl-0 = <&i2c0_pins>;
>> +clock-frequency = <400000>;
>> +status = "okay";
>> +
>> +touchscreen@5d {
>> +compatible = "goodix,gt9271";
>> +reg = <0x5d>;
>> +interrupt-parent = <&pio>;
>> +interrupts = <6 IRQ_TYPE_EDGE_RISING>;
>> +irq-gpios = <&pio 6 GPIO_ACTIVE_HIGH>;
>> +reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
>> +AVDD28-supply = <&touch0_fixed_3v3>;
>> +VDDIO-supply = <&mt6359_vio18_ldo_reg>;
>> +pinctrl-names = "default";
>> +pinctrl-0 = <&touch_pins>;
>> +};
>> +};
>> +
>> +&i2c1 {
>> +pinctrl-names = "default";
>> +pinctrl-0 = <&i2c1_pins>;
>> +clock-frequency = <400000>;
>> +status = "okay";
>> +};
>> +
>> +&i2c2 {
>> +pinctrl-names = "default";
>> +pinctrl-0 = <&i2c2_pins>;
>> +clock-frequency = <400000>;
>> +status = "okay";
>> +};
>> +
>> +&i2c3 {
>> +pinctrl-names = "default";
>> +pinctrl-0 = <&i2c3_pins>;
>> +clock-frequency = <400000>;
>> +status = "okay";
>> +};
>> +
>> +&i2c4 {
>> +pinctrl-names = "default", "default";
> 
> Why do you need two default entries? This should be just one, shouldn't it?


Fixed.

> Best regards,
> Krzysztof
> 

Thanks for the review.

Best regards,
Macpaul Lin
