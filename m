Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA1C767FF7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjG2OJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjG2OJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:09:17 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BB0198C;
        Sat, 29 Jul 2023 07:09:15 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5672A1C0004;
        Sat, 29 Jul 2023 14:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1690639754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJHI+2B39D3Or8mTHomyEAuJmjF+7v9ZD1s100wtrNs=;
        b=mu1xBkyaTSueDQVaSjy1rYEeqE37mKfdczlOLICOFcLo0tQesrxldCAQqqbIMb2pmY9i6E
        zOeQVJv6/3nXuHRuTiQWnr66Ru2+EBL4gQVJURj0OkIem35WOQYi24/SGCRahCFsJvGcP6
        Q2iFTFRN0OIRgb7Um0Wa2SoSyV9kuAS02KdtCGpCk/s1sao3+8RLibve2Z2cy98EIiR+Ez
        juFoKYeR96euKoVIYDHyoaa8JM9z+NsTSFICki24p+8Lv+JhjbL850hPSVSNPMXYy6/v+u
        NHqNaxIRUg8w9JFBtWfld+gjyZMoSjBSXv8GJwXnoEvgI3TKTbhlCOxk9vOxkA==
Message-ID: <96bdb44d-3c59-b6e7-7baa-0ab80efeb720@arinc9.com>
Date:   Sat, 29 Jul 2023 17:08:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: dts: ralink: reorder MT7621 clocks in Ethernet
 block
Content-Language: en-US
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
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230729110449.1357-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.07.2023 14:04, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Use order as specified in the binding (first "ethif" then "fe").
> 
> This fixes:
> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: clock-names:0: 'ethif' was expected
>          From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: clock-names:1: 'fe' was expected
>          From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
> 
> Fixes: 7a6ee0bbab25 ("mips: dts: ralink: add MT7621 SoC")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

I'm not sure if I should agree with this patch. The relevant parts of 
the schema for mediatek,mt7621-eth were added way later than the 
existing bindings on mt7621.dtsi. Why don't we address this on the 
schema along with a bunch of other issues the patch for 
mediatek,mt7621-eth brought?

Arınç
