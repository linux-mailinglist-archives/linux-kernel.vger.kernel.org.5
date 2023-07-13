Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7A37516E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjGMDq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjGMDqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:46:23 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE011FEE;
        Wed, 12 Jul 2023 20:46:22 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 49AC680BE;
        Thu, 13 Jul 2023 11:46:15 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Jul
 2023 11:46:15 +0800
Received: from [192.168.125.128] (183.27.98.46) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Jul
 2023 11:46:14 +0800
Message-ID: <a6bdf17f-dd05-0237-92f4-7fc5115e4bef@starfivetech.com>
Date:   Thu, 13 Jul 2023 11:43:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 0/9] Add STG/ISP/VOUT clock and reset drivers for
 StarFive JH7110
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <kernel@esmil.dk>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230712092007.31013-1-xingyu.wu@starfivetech.com>
 <mhng-d3795910-5414-4555-bf3d-75ebe769ed2b@palmer-ri-x1c9a>
 <20230712-unsold-impound-02608d701dfb@spud>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <20230712-unsold-impound-02608d701dfb@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.46]
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/13 1:01, Conor Dooley wrote:
> On Wed, Jul 12, 2023 at 09:50:37AM -0700, Palmer Dabbelt wrote:
>> On Wed, 12 Jul 2023 02:19:58 PDT (-0700), xingyu.wu@starfivetech.com wrote:
>> > This patch serises are base on the basic JH7110 SYSCRG/AONCRG
>> > drivers and add new partial clock drivers and reset supports
>> > about System-Top-Group(STG), Image-Signal-Process(ISP)
>> > and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC. These
>> > clocks and resets could be used by DMA, VIN and Display modules.
> 
>> Happy to take it through the RISC-V tree if folks want, but IMO it's
>> probably better aimed at the clock/reset folks.  Either way I'd want to give
>> them a chance to ack/review it, so I'm going to drop it from my list.
>> 
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> I had a look through it & I am generally happy with it - everything has
> either an R-b from DT folk or Hal on the drivers.
> I was going to propose the same thing as the PLL patchset - if Emil is
> happy with it, then I intend sending Stephen a PR for the drivers &
> bindings.
> 

Thanks, I will send a new version soon with some modification from Emil's comments.

Best regards,
Xingyu Wu

