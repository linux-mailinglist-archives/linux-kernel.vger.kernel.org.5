Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C2D801D04
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjLBNRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBNRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:17:33 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3C2A9;
        Sat,  2 Dec 2023 05:17:33 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id AFCB27F98;
        Sat,  2 Dec 2023 21:17:25 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 2 Dec
 2023 21:17:25 +0800
Received: from [192.168.125.85] (113.72.145.176) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 2 Dec
 2023 21:17:24 +0800
Message-ID: <c4154501-5b93-4eaf-8d2d-690809d26c57@starfivetech.com>
Date:   Sat, 2 Dec 2023 21:17:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/20] Refactoring Microchip PCIe driver and add
 StarFive PCIe
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Daire McNamara" <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20231115114912.71448-1-minda.chen@starfivetech.com>
 <ZWbcjKiSfvp-74CL@fedora.fritz.box> <ZWchVSO6iQbCFwkp@fedora.fritz.box>
 <1168e373-b049-4c17-9cbd-c588bf913bbb@starfivetech.com>
 <ZWn8ebtIDrGF9P5i@fedora.fritz.box>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <ZWn8ebtIDrGF9P5i@fedora.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/1 23:32, Damian Tometzki wrote:
> On Fri, 01. Dec 15:15, Minda Chen wrote:
>> 
>> 
>> On 2023/11/29 19:32, Damian Tometzki wrote:
>> > On Wed, 29. Nov 07:39, Damian Tometzki wrote:
>> >> Hello Minda,
>> >> 
>> >> i tried this Patchset on Linux-6.6.3 but boot with nvme doesnt work. Linux doesnt find
>> >> /root partition /dev/nvme0n1p4. 
>> >> I dont know if it has anything to do with this patchset ?
>> >> Best regards
>> >> Damian
>> > Hi,
>> > some additional information: 
>> > Begin: Running /scripts/local-block ... done.
>> > Begin: Running /scripts/local-block ... done.
>> > [   11.097653] /soc/pcie@940000000: Failed to get clk index: 1 ret: -517
>> > [   11.104147] pcie-starfive 940000000.pcie: error -ENODEV: failed to get pcie clocks
>> > [   11.111981] /soc/pcie@9c0000000: Failed to get clk index: 1 ret: -517
>> > [   11.118451] pcie-starfive 9c0000000.pcie: error -ENODEV: failed to get pcie clocks
>> > [   11.126371] platform 17020000.pinctrl: deferred probe pending
>> > [   11.132145] platform 16010000.mmc: deferred probe pending
>> > Begin: Running /scripts/local-block ... done.
>> > Begin: Running /scripts/local-block ... done.
>> > 
>> > Damian
>> > 
>> It is get stg clk failed. Did you enable CONFIG_CLK_STARFIVE_JH7110_STG=y?
> Hi,
> 
> it is now a little bit better now i get: 
> Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
> Begin: Running /scripts/local-premount ... done.
> Begin: Waiting for root file system ... Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> [   13.916056] platform 940000000.pcie: deferred probe pending
> [   13.921668] platform 9c0000000.pcie: deferred probe pending
> [   13.927259] platform 16010000.mmc: deferred probe pending
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> 
> 
Hi 
Please check this configuation.
CONFIG_PHY_STARFIVE_JH7110_PCIE=y
CONFIG_PINCTRL_STARFIVE_JH7110=y
CONFIG_PINCTRL_STARFIVE_JH7110_SYS=y
CONFIG_PINCTRL_STARFIVE_JH7110_AON=y

BTW, Maybe you can reply e-mail to me only.
