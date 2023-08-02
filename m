Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C6376CBE1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjHBLiX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Aug 2023 07:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjHBLiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:38:22 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA572137;
        Wed,  2 Aug 2023 04:38:20 -0700 (PDT)
Received: from [127.0.0.1] (unknown [176.201.65.65])
        by mail11.truemail.it (Postfix) with ESMTPA id 6D8F9213FE;
        Wed,  2 Aug 2023 13:38:18 +0200 (CEST)
Date:   Wed, 02 Aug 2023 13:37:47 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Jai Luthra <j-luthra@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/4] arm64: dts: ti: k3-am62x: Enable AUDIO_REFCLKx
User-Agent: K-9 Mail for Android
In-Reply-To: <itvg2zmmapbfmgbwos6c4y5zsc2rb3sffv2znhwz6i2vahe4y6@uu2547kcz5sd>
References: <20230731142135.108477-1-francesco@dolcini.it> <20230731142135.108477-2-francesco@dolcini.it> <itvg2zmmapbfmgbwos6c4y5zsc2rb3sffv2znhwz6i2vahe4y6@uu2547kcz5sd>
Message-ID: <23C6E13C-3F10-490B-A18E-C67B91CBAF35@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Il 2 agosto 2023 13:23:50 CEST, Jai Luthra <j-luthra@ti.com> ha scritto:
>Hi Francesco,
>
>Thank you for posting this patch.
>
>On Jul 31, 2023 at 16:21:32 +0200, Francesco Dolcini wrote:
>> From: Jai Luthra <j-luthra@ti.com>
>> 
>> On AM62-based SoCs the AUDIO_REFCLKx clocks can be used as an input to
>> external peripherals when configured through CTRL_MMR, so add the
>> clock nodes.
>> 
>> Signed-off-by: Jai Luthra <j-luthra@ti.com>
>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 18 ++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++++
>
>Given currently none of the AM62A boards are using the refclks, can you 
>drop those or just mark the nodes as disabled. Whoever is the first user 
>can enable them.

I can drop the 2 clocks from AM62A, however, should we really do it? These clocks exist and they are just defined in the DTS, they are not going to be enabled if not used, "ti,am62-epwm-tbclk" is also not disabled for example.

Francesco

