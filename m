Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F14754A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGORyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGORyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:54:00 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3164430DC;
        Sat, 15 Jul 2023 10:53:58 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id AE9E0100005;
        Sat, 15 Jul 2023 20:53:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AE9E0100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689443636;
        bh=5ttxEKcHawm3oRMYZ4Ouli2azKIL2gurED8PaIq7bWA=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=R2R/SIo3MEqcWoNlvoAXJv2SJgfTyQ9c3kYcrQW2CbowGylAD5qmxiIeujrGS4Uhv
         mfLQct59SUVaJc3L4lTUW9gizgm3j0jd0us1Y1CaPJaYSI7vpI+mY5/sjYe/nQEKcG
         b0WB+lKWPH6Qo3guhnb+JuWC7F9uTrfPSDZPaF2lzADbtPjvpYpu50u76ENwKDbEaR
         4AbMgeo91OsiM3J9jskPKHk/cJZ+E/r05A2vkKzzBxouRdUtDAAGR86e+pI2R126vx
         gCaDs0IopaJaOq+fIA+dWTIFEMeKdf/DWcq8kpCKbMpJewwT8TyLFfVEnsaflywiSU
         r8/7UgUpiqWcw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Sat, 15 Jul 2023 20:53:56 +0300 (MSK)
Received: from [192.168.0.12] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 15 Jul 2023 20:53:13 +0300
Message-ID: <672e6a2f-21b3-77cd-fe83-04d4aa79f68e@sberdevices.ru>
Date:   Sat, 15 Jul 2023 20:48:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v3 0/3] support 512B ECC step size for Meson NAND
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230711122129.2635558-1-AVKrasnov@sberdevices.ru>
 <20230715181553.1d2b5637@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230715181553.1d2b5637@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178635 [Jul 15 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 523 523 523027ce26ed1d9067f7a52a4756a876e54db27c, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/15 16:31:00 #21619439
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miquel!

On 15.07.2023 19:15, Miquel Raynal wrote:
> Hi Arseniy,
> 
> AVKrasnov@sberdevices.ru wrote on Tue, 11 Jul 2023 15:21:26 +0300:
> 
>> Hello,
>>
>> this patchset adds support for 512B ECC step size for Meson NAND. Current
>> implementation only supports 1024B. There are three patches:
>>
>> 1) Update for device tree bindings to replace 'const' type of field
>>    'nand-ecc-step-size' with 'enum' which contains 512 and 1024.
>>
>> 2) Update for device tree bindings to add dependency between properties
>>    'nand-ecc-strength' and 'nand-ecc-step-size'.
>>
>> 3) Update for Meson driver - new enum value for 512B ECC and reworked
>>    ECC capabilities structure to support both 512B and 1024B ECC. By
>>    default this driver uses 1024B ECC, 512B could be enabled in device
>>    tree.
> 
> This series does not apply correctly on nand/next, would you mind
> rebasing (nand/next on linux-mtd) and sending it again?

Sure, as I see 0001 was applied to nand/next, so I can resend only 0002 and 0003,
as 0002 is the first patch which fails to apply?

> 
> BTW the "rfc" prefix is only needed for the "first" submission, when
> you try something "new", otherwise it is no longer required.

Ok, got it

> 
> Thanks,
> Miquèl

Thanks, Arseniy
