Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E138979B60E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378129AbjIKWab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242652AbjIKQCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:02:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9C81AE;
        Mon, 11 Sep 2023 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694448116; x=1725984116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lKHyicF0p9BaS5ys6PVn7lp6R/aWgLwg26A6LMOSZlE=;
  b=z7WIJKdGfvou2O0P9SAvdWfqMAdFxe4E4Avq/aFNSQMRt/c37zWfrEc5
   JbCaUAskMJgBZirlLPO24IH3QIzg2xAEsrUSl4LZqaZD0aCjiRvAyuz2M
   TuWShe1ebQyYQEd1q/jwoLwweSyLVHgH0I2I2HB6R1m9W/eGQCwFI9BLA
   jjmOrkoB883hLE8oMEC2jRVp+1/Fuw/5NxNgAx6rPUX6ae6Q3IF7xLSnS
   mCLfuaiO537+QKmWmnlfVYpw2jiymm5cCGOEc9wiAxJn/Q5JJAwMgpJ/H
   l61bNH0reyqaju82Nxcjr5Ejo7ZrD8/8t5A1Rw0IfXP+ofZVISPnTylaF
   Q==;
X-CSE-ConnectionGUID: +foy2RZLSUOIYXipKZdYxg==
X-CSE-MsgGUID: ZKrN9PlRR+q/ZjuwzBu+Kw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="4164260"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 09:01:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 11 Sep 2023 09:01:55 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 11 Sep 2023 09:01:53 -0700
Message-ID: <18943157-a1fb-0fda-e3d4-e0478d18a849@microchip.com>
Date:   Mon, 11 Sep 2023 18:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d29_curiosity: Add device tree
 for sama5d29_curiosity board
Content-Language: en-US, fr-FR
To:     claudiu beznea <claudiu.beznea@tuxon.dev>,
        <Mihai.Sain@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <andre.przywara@arm.com>,
        <Andrei.Simion@microchip.com>, <Jerry.Ray@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Cristian.Birsan@microchip.com>
References: <20230801111151.6546-1-mihai.sain@microchip.com>
 <20230801111151.6546-2-mihai.sain@microchip.com>
 <14d628cf-a40c-11e6-7743-e3ba3bd8aa2d@tuxon.dev>
 <PH8PR11MB68049899CFD7947B0B3A03EF820BA@PH8PR11MB6804.namprd11.prod.outlook.com>
 <9ce18601-02d8-686e-ebe0-04c5dc29f6c9@tuxon.dev>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <9ce18601-02d8-686e-ebe0-04c5dc29f6c9@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihai, Claudiu,

First of all, thanks a lot for your help on this board DT, that's great!

On 03/08/2023 at 11:09, claudiu beznea wrote:
> Hi, Mihai,
> 
> On 02.08.2023 15:19,Mihai.Sain@microchip.com  wrote:
>>> +&macb0 {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&pinctrl_macb0_default &pinctrl_macb0_phy_irq>;
>>> +     #address-cells = <1>;
>>> +     #size-cells = <0>;
>>> +     phy-mode = "rmii";
>>> +     status = "disabled";
>> Should any phy/mdio container be placed here? Also, any reason this node is disabled?
>> The board has no phy.
>> We will add external phy boards to macb interface and they will be present in dt-overlay.
>>
> Then remove the macb0 node from here and keep it in overlay.

What about choosing a phy and making it enabled by default. Because I 
doubt people will use this board without a phy under Linux, honestly.
Overlays would remove this "by default" node and add the replacing phy 
if hardware plugged-in is different.

By doing this we avoid having difficult situations where the most used 
phy with this board is disabled or non existant and that we absolutely 
need an overlay for such a basic thing as having Ethernet working 
out-of-the-box...

Just my $0.02, but it might simplify our life in the long run...

Best regards,
   Nicolas
