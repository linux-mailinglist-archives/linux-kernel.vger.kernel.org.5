Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D17780BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376936AbjHRMlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376913AbjHRMkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:40:49 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D4E3A8D;
        Fri, 18 Aug 2023 05:40:47 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 459737FD3;
        Fri, 18 Aug 2023 20:40:44 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Aug
 2023 20:40:44 +0800
Received: from [192.168.125.62] (183.27.97.249) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Aug
 2023 20:40:43 +0800
Message-ID: <e47c92c9-c57b-83b1-c444-0fce41164fe1@starfivetech.com>
Date:   Fri, 18 Aug 2023 20:40:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 0/2] Add dma and tdm nodes for StarFive JH7110 SOC
To:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230724065158.925-1-walker.chen@starfivetech.com>
 <20230726-upriver-net-8490aa69df8a@spud>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230726-upriver-net-8490aa69df8a@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 17:21:39 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> On Mon, 24 Jul 2023 14:51:56 +0800, Walker Chen wrote:
>> These patches add dma and tdm nodes for the StarFive JH7110 SoC, they
>> are based on linux-next. I have tested them on the VisionFive2 board.
>> Thanks.
>> 
>> Best regards,
>> Walker
>> 
>> [...]
> 
> Applied to riscv-dt-for-next, thanks!
> 
> [1/2] riscv: dts: starfive: jh7110: add dma controller node
>       https://git.kernel.org/conor/c/ac73c09716c3
> [2/2] riscv: dts: starfive: jh7110: add the node and pins configuration for tdm
>       https://git.kernel.org/conor/c/e7c304c0346d

Hi, Conor,

You had deleted the `status = "okay";` of usb0 by mistake in this commit.

 &usb0 {
 	dr_mode = "peripheral";
-	status = "okay";
 };

Could you please help fix it?

Best regards,
Hal
