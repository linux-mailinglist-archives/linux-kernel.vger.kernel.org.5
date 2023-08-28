Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C262078A651
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjH1HNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjH1HM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:12:58 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ACFA0;
        Mon, 28 Aug 2023 00:12:53 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2397980C5;
        Mon, 28 Aug 2023 15:12:37 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 28 Aug
 2023 15:12:37 +0800
Received: from [192.168.125.72] (113.72.145.245) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 28 Aug
 2023 15:12:35 +0800
Message-ID: <a49737f0-0a09-b558-ea06-b3d47a6e4240@starfivetech.com>
Date:   Mon, 28 Aug 2023 15:12:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC v4 0/4] StarFive's Pulse Width Modulation driver support
To:     Conor Dooley <conor@kernel.org>,
        William Qiu <william.qiu@starfivetech.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20230825081328.204442-1-william.qiu@starfivetech.com>
 <20230825-exclusion-doing-93532be4fa97@spud>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230825-exclusion-doing-93532be4fa97@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.245]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 16:06:12 +0100, Conor Dooley wrote:
> On Fri, Aug 25, 2023 at 04:13:24PM +0800, William Qiu wrote:
>> Hi,
>> 
>> This patchset adds initial rudimentary support for the StarFive
>> Pulse Width Modulation controller driver. And this driver will
>> be used in StarFive's VisionFive 2 board.The first patch add
>> Documentations for the device and Patch 2 adds device probe for
>> the module.
>> 
>> Changes v3->v4:
>> - Rebased to v6.5rc7.
>> - Sorted the header files in alphabetic order.
>> - Changed iowrite32() to writel().
>> - Added a way to turn off.
>> - Moified polarity inversion implementation.
>> - Added 7100 support.
>> - Added dts patches.
>> - Used the various helpers in linux/math.h.
>> - Corrected formatting problems.
>> - Renamed dtbinding  to 'starfive,jh7100-pwm.yaml'.
>> - Dropped the redundant code.
>> 
>> Changes v2->v3:
>> - Fixed some formatting issues.
>> 
>> Changes v1->v2:
>> - Renamed the dt-binding 'pwm-starfive.yaml' to 'starfive,jh7110-pwm.yaml'.
>> - Dropped the compatible's Items.
>> - Dropped the unuse defines.
>> - Modified the code to follow the Linux coding style.
>> - Changed return value to dev_err_probe.
>> - Dropped the unnecessary local variable.
>> 
>> The patch series is based on v6.5rc7.
> 
> Out of curiosity, why is this series still an RFC?

There was no comments received in v4. So William resend it and
request for comments.

Best regards,
Hal
