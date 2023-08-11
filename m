Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99565778504
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjHKBio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjHKBim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:38:42 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4CB10D;
        Thu, 10 Aug 2023 18:38:40 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 99D5880C7;
        Fri, 11 Aug 2023 09:38:26 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 11 Aug
 2023 09:38:27 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 11 Aug
 2023 09:38:25 +0800
Message-ID: <fe0b5497-93f1-74c6-7e53-e15a62f4692f@starfivetech.com>
Date:   Fri, 11 Aug 2023 09:38:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [-next v1 1/1] riscv: dts: starfive: jh7110: Fix GMAC
 configuration
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Conor Dooley" <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>
References: <20230810074646.19076-1-samin.guo@starfivetech.com>
 <20230810074646.19076-2-samin.guo@starfivetech.com>
 <CAJM55Z_AKXa-cKy8kS4-8XPcqgFb4ts2ywhcWwL7Nf3wMBCWJA@mail.gmail.com>
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <CAJM55Z_AKXa-cKy8kS4-8XPcqgFb4ts2ywhcWwL7Nf3wMBCWJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/10 19:28:23, Emil Renner Berthing wrote:
> On Thu, 10 Aug 2023 at 09:46, Samin Guo <samin.guo@starfivetech.com> wrote:
>>
>> Fixed configuration to improve the speed of TCP RX.
>>
>> Before:
>>   # iperf3 -s
>>   -----------------------------------------------------------
>>   Server listening on 5201 (test #1)
>>   -----------------------------------------------------------
>>   Accepted connection from 192.168.1.4, port 47604
>>   [  5] local 192.168.1.3 port 5201 connected to 192.168.1.4 port 47612
>>   [ ID] Interval           Transfer     Bitrate
>>   [  5]   0.00-1.00   sec  36.3 MBytes   305 Mbits/sec
>>   [  5]   1.00-2.00   sec  35.6 MBytes   299 Mbits/sec
>>   [  5]   2.00-3.00   sec  36.5 MBytes   306 Mbits/sec
>>   [  5]   3.00-4.00   sec  36.5 MBytes   306 Mbits/sec
>>   [  5]   4.00-5.00   sec  35.7 MBytes   300 Mbits/sec
>>   [  5]   5.00-6.00   sec  35.4 MBytes   297 Mbits/sec
>>   [  5]   6.00-7.00   sec  37.1 MBytes   311 Mbits/sec
>>   [  5]   7.00-8.00   sec  35.6 MBytes   298 Mbits/sec
>>   [  5]   8.00-9.00   sec  36.4 MBytes   305 Mbits/sec
>>   [  5]   9.00-10.00  sec  36.3 MBytes   304 Mbits/sec
>>   - - - - - - - - - - - - - - - - - - - - - - - - -
>>   [ ID] Interval           Transfer     Bitrate
>>   [  5]   0.00-10.00  sec   361 MBytes   303 Mbits/sec        receiver
>>
>> After:
>>   # iperf3 -s
>>   -----------------------------------------------------------
>>   Server listening on 5201 (test #1)
>>   -----------------------------------------------------------
>>   Accepted connection from 192.168.1.4, port 47710
>>   [  5] local 192.168.1.3 port 5201 connected to 192.168.1.4 port 47720
>>   [ ID] Interval           Transfer     Bitrate
>>   [  5]   0.00-1.00   sec   111 MBytes   932 Mbits/sec
>>   [  5]   1.00-2.00   sec   111 MBytes   934 Mbits/sec
>>   [  5]   2.00-3.00   sec   111 MBytes   934 Mbits/sec
>>   [  5]   3.00-4.00   sec   111 MBytes   934 Mbits/sec
>>   [  5]   4.00-5.00   sec   111 MBytes   934 Mbits/sec
>>   [  5]   5.00-6.00   sec   111 MBytes   935 Mbits/sec
>>   [  5]   6.00-7.00   sec   111 MBytes   934 Mbits/sec
>>   [  5]   7.00-8.00   sec   111 MBytes   935 Mbits/sec
>>   [  5]   8.00-9.00   sec   111 MBytes   934 Mbits/sec
>>   [  5]   9.00-10.00  sec   111 MBytes   934 Mbits/sec
>>   [  5]  10.00-10.00  sec   167 KBytes   933 Mbits/sec
>>   - - - - - - - - - - - - - - - - - - - - - - - - -
>>   [ ID] Interval           Transfer     Bitrate
>>   [  5]   0.00-10.00  sec  1.09 GBytes   934 Mbits/sec        receiver
>>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
>> ---
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index a608433200e8..76884cf373bf 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -318,8 +318,8 @@
>>
>>         stmmac_axi_setup: stmmac-axi-config {
>>                 snps,lpi_en;
>> -               snps,wr_osr_lmt = <4>;
>> -               snps,rd_osr_lmt = <4>;
>> +               snps,wr_osr_lmt = <0xf>;
>> +               snps,rd_osr_lmt = <0xf>;
> 
> nit: this is a limit, so presumably counting things and not an address
> or bitmask, so I'd prefer decimal numbers here, eg <15>.
> 
> It works fine either way, so
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Thanks Esmil, that's right.
I refer to examples of snps,dwmac.yaml, so I use 0xf...

Best regards,
Samin
> 
>>                 snps,blen = <256 128 64 32 0 0 0>;
>>         };
>>
>> @@ -839,7 +839,7 @@
>>                         rx-fifo-depth = <2048>;
>>                         tx-fifo-depth = <2048>;
>>                         snps,multicast-filter-bins = <64>;
>> -                       snps,perfect-filter-entries = <8>;
>> +                       snps,perfect-filter-entries = <256>;
>>                         snps,fixed-burst;
>>                         snps,no-pbl-x8;
>>                         snps,force_thresh_dma_mode;
>> @@ -870,7 +870,7 @@
>>                         rx-fifo-depth = <2048>;
>>                         tx-fifo-depth = <2048>;
>>                         snps,multicast-filter-bins = <64>;
>> -                       snps,perfect-filter-entries = <8>;
>> +                       snps,perfect-filter-entries = <256>;
>>                         snps,fixed-burst;
>>                         snps,no-pbl-x8;
>>                         snps,force_thresh_dma_mode;
>> --
>> 2.17.1
>>

