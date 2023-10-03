Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE06A7B60A5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbjJCGIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjJCGIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:08:10 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520ABB7;
        Mon,  2 Oct 2023 23:08:07 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39367fQY111012;
        Tue, 3 Oct 2023 01:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696313261;
        bh=8nHXIz83JEIbMHbNl4Btub6SQ0/ni/ZIwsC2FHxJX6Q=;
        h=From:To:CC:Subject:In-Reply-To:References:Date;
        b=KPmkj9WCNcya62CDRzjUVxY4xqNJavEtHWYOmAYryzGsYCRtBEcaIsgec20Th59y8
         29iId9xbdoEKqS7a0WxpijUilcfV/NLexAYsizKm+gzspJjKwqcyI66sRpWY9W5W9Z
         QnQtI30rjGiL6z+9O/FAkIJt1Y/Iy+4cr/WlynKI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39367fmU010004
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 01:07:41 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 01:07:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 01:07:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39367epB042204;
        Tue, 3 Oct 2023 01:07:41 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH v2 0/6] Add support for
 Texas Instruments MCRC64 engine
In-Reply-To: <87a5thgwt6.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
 <20230812030116.GF971@sol.localdomain>
 <87h6owen39.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <20230822051710.GC1661@sol.localdomain>
 <87zg28d9z4.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <87a5thgwt6.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Date:   Tue, 3 Oct 2023 11:37:40 +0530
Message-ID: <87wmw4fdcj.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kamlesh Gurudasani <kamlesh@ti.com> writes:

>>
>> Here, if we consider similar numbers for crc64 PMULL implementation as
>> crc32 (case 2) , we save good number of cpu cycles using mcrc64
>> in case of files bigger than 5-10mb as most of the time is being spent in HW offload.
>>
>> Regards,
>> Kamlesh
>
> Hi Eric,
>
> Please let me know if above numbers make sense to you and I should send
> next revision.

Hi Eric,

I understand that there is no in-kernel user for crc64-iso3309 and this
is new algorithm that we are trying to add in linux kernel.

As per your suggestion we did the calculations and it turns out to be we
are saving good number of cpu cycles with HW offload.

Also, there are some automotive customers who have a safety
requirement to offload any parameters that are in Linux to ensure FFI.

Let me know if you are willing to accept this driver, so that I can put
efforts to send next revision.

Regards,
Kamlesh
