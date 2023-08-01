Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7549A76A968
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjHAGn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjHAGnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:43:15 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A661FD8;
        Mon, 31 Jul 2023 23:43:02 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EA981BF206;
        Tue,  1 Aug 2023 06:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1690872181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3VvrVTmS3ewdRk3DK8RHjaOEKGb5fZ7apaK+oODe/I=;
        b=cL3g/ZWzj9cEh8UwFFtxipC92h6O4N8ufQP+0KOvB+BShgr6DIg43HYaqOqktLbPaE5INr
        qkgSuCUF7u+UeSpaRsdNzEB+kihPeYZQUO1ncSOCWpM/BJf+fo+7s7otcdlh9QENEx5kEP
        feEkJ0qb3xv2bqK32vqyNBPTYBQHXdU+bjVIe8hIYbcTUqQ0Ylwphb/9lHfJaPXuVR4TN4
        V1cZDtNRXECwB88xN/RbjSXXhKVu5J3Vo+Wj7SGZWANQ9XLXryHsOeU1pXFY6cFwgPKUI6
        5TQjZiTZUPC/sZlfxpJ6yq3YMqflR/pQvwAlS3fXzf6kcMih0vgipaJlek4Pdg==
Message-ID: <0b605849-0976-f58b-d449-56031b1d0282@arinc9.com>
Date:   Tue, 1 Aug 2023 09:42:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: dts: ralink: reorder MT7621 clocks in Ethernet
 block
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230729110449.1357-1-zajec5@gmail.com>
 <96bdb44d-3c59-b6e7-7baa-0ab80efeb720@arinc9.com>
In-Reply-To: <96bdb44d-3c59-b6e7-7baa-0ab80efeb720@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't received anything arguing with this so my answer is still no.

Also, this patch changes the lines introduced with b2f471a26721 
("staging: mt7621-dts: make use of new 'mt7621-clk'").

Arınç

On 29.07.2023 17:08, Arınç ÜNAL wrote:
> On 29.07.2023 14:04, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Use order as specified in the binding (first "ethif" then "fe").
>>
>> This fixes:
>> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: 
>> ethernet@1e100000: clock-names:0: 'ethif' was expected
>>          From schema: 
>> Documentation/devicetree/bindings/net/mediatek,net.yaml
>> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: 
>> ethernet@1e100000: clock-names:1: 'fe' was expected
>>          From schema: 
>> Documentation/devicetree/bindings/net/mediatek,net.yaml
>>
>> Fixes: 7a6ee0bbab25 ("mips: dts: ralink: add MT7621 SoC")
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> I'm not sure if I should agree with this patch. The relevant parts of 
> the schema for mediatek,mt7621-eth were added way later than the 
> existing bindings on mt7621.dtsi. Why don't we address this on the 
> schema along with a bunch of other issues the patch for 
> mediatek,mt7621-eth brought?
> 
> Arınç
