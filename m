Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CCC76A9AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjHAHDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjHAHCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:02:49 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D31BF;
        Tue,  1 Aug 2023 00:02:35 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37172Aoh030373;
        Tue, 1 Aug 2023 02:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690873330;
        bh=sBXAjbfHeRj7hzkUpoVdh1Ao5fWm61KOvhJ132iXmrs=;
        h=From:To:CC:Subject:In-Reply-To:References:Date;
        b=oWRxSfWKi+PcuXRSeN74eoEOEGrcrMI2R2mxZ6clpRkPs/32nt+T1snbp1Up75cxK
         eewKwYRGD5D/xrMmznufpAyuRb1LZM+J51fQd+5+GME79L7n/UgM0pTb9+eAHyOlXA
         dhj1LeZyknkbyPqMgvwoGqB3+6G2+GZKW35KCSyw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37172Aw4029151
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 02:02:10 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 02:02:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 02:02:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 371729Z7120125;
        Tue, 1 Aug 2023 02:02:09 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Menon, Nishanth" <nm@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH 0/5] Add support for Texas
 Instruments MCRC64 engine
In-Reply-To: <CAMj1kXFvA=xfEUsquchpcCvE-mVaFbSmPzt30Fyp7ifO-AX9eA@mail.gmail.com>
References: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
 <CAMj1kXGXNbkxdDRNojtZD3NhMGK97LOchqGoM-4-tVLgH5JEiA@mail.gmail.com>
 <87y1ive0yk.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <CAMj1kXFvA=xfEUsquchpcCvE-mVaFbSmPzt30Fyp7ifO-AX9eA@mail.gmail.com>
Date:   Tue, 1 Aug 2023 12:32:09 +0530
Message-ID: <87v8dzdz4e.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ard Biesheuvel <ardb@kernel.org> writes:

> On Tue, 1 Aug 2023 at 08:22, Kamlesh Gurudasani <kamlesh@ti.com> wrote:
>>
>> Ard Biesheuvel <ardb@kernel.org> writes:
>>
>> > On Sun, 30 Jul 2023 at 20:56, Kamlesh Gurudasani <kamlesh@ti.com> wrote:
>> >>
>> >> Add support for MCRC64 engine to calculate 64-bit CRC in Full-CPU mode
>> >>
>> >> MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
>> >> according to the ISO 3309 standard.
>> >>
>> >> Generator polynomial: x^64 + x^4 + x^3 + x + 1
>> >> Polynomial value: 0x000000000000001b
>> >>
>> >
>> > How will this code be used? WIthout a user of the crc64-iso crypto API
>> > algorithm, there is no point in having a driver that implements it.
>>
>> Thanks for the review.
>>
>> MCRC64 will be used to check the integrity of memory blocks.
>> On TI K3 SOCs, users can use MCRC64 to accelerate the integrity check.
>>
>
> Where is the implementation of this logic? Does it use the shash/ahash API?
>
> If so, it should be part of this series.

We have implemented user-space application to utilize crc64-iso using below kernel module

algif_hash: User-space interface for hash algorithms 

https://gist.github.com/ti-kamlesh/73abfcc1a33318bb3b199d36b6209e59

>
>
>> >
>> > Also, *if* such a user exists, we'd need to have a generic C
>> > implementation as well - we don't add new algorithms unless they can
>> > be enabled on all platforms and architectures.
>>
>> If it is must, will implement generic C code.
>>
>> >
>> >
>> >> Tested with
>> >>
>> >> and tcrypt,
>> >> sudo modprobe tcrypt mode=329 sec=1
>> >>
>> >> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>> >> ---
>> >> Kamlesh Gurudasani (5):
>> >>       crypto: crc64 - add crc64-iso test vectors
>> >>       dt-bindings: crypto: Add binding for TI MCRC64 driver
>> >>       crypto: ti - add driver for MCRC64 engine
>> >>       arm64: dts: ti: k3-am62: Add dt node, cbass_main ranges for MCRC64
>> >>       arm64: defconfig: enable MCRC module
>> >>
>> >>  Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml |  42 +++++++
>> >>  MAINTAINERS                                             |   7 ++
>> >>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi                |   7 ++
>> >>  arch/arm64/boot/dts/ti/k3-am62.dtsi                     |   1 +
>> >>  arch/arm64/configs/defconfig                            |   2 +
>> >>  crypto/tcrypt.c                                         |   5 +
>> >>  crypto/testmgr.c                                        |   7 ++
>> >>  crypto/testmgr.h                                        | 401 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >>  drivers/crypto/Kconfig                                  |   1 +
>> >>  drivers/crypto/Makefile                                 |   1 +
>> >>  drivers/crypto/ti/Kconfig                               |  10 ++
>> >>  drivers/crypto/ti/Makefile                              |   2 +
>> >>  drivers/crypto/ti/mcrc64.c                              | 360 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >>  13 files changed, 846 insertions(+)
>> >> ---
>> >> base-commit: d7b3af5a77e8d8da28f435f313e069aea5bcf172
>> >> change-id: 20230719-mcrc-upstream-7ae9a75cab37
>> >>
>> >> Best regards,
>> >> --
>> >> Kamlesh Gurudasani <kamlesh@ti.com>
>> >>
