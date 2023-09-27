Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88B77B080B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjI0PVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjI0PVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:21:19 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6DE192;
        Wed, 27 Sep 2023 08:21:17 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RFL7Ig121242;
        Wed, 27 Sep 2023 10:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695828067;
        bh=yZDf+G265tlcCz/+xbyevaHnVFHSn7if37D6SE5CeO0=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=eBH1Vxiqxjsj8pkOIKbuUkCEUuZXPU4N/mN6gLdgbzqZkD8TTwrGJTRUcQzfP6D0c
         e74cAQ1QKklHwOldoQnlGRQvpmf3oxASIUzXloQqlefJVPKeS0EivLMgscD+EaXq90
         0/Fg5358/t0jowMNWgtci9beFYXOTPVtKJ3fiKm0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RFL74d031015
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Sep 2023 10:21:07 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 10:21:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 10:21:07 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RFL3s4010422;
        Wed, 27 Sep 2023 10:21:04 -0500
Message-ID: <1ec11ea0-30f7-83b5-5b7c-2f54f6036519@ti.com>
Date:   Wed, 27 Sep 2023 20:51:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 6/9] arm64: dts : ti: k3-am68-sk-som: Add DDR carveout
 memory nodes for R5F
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>
References: <20230906112422.2846151-1-a-nandan@ti.com>
 <20230906112422.2846151-7-a-nandan@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230906112422.2846151-7-a-nandan@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/2023 4:54 PM, Apurva Nandan wrote:
> Two carveout reserved memory nodes each have been added for each of the
> R5F remote processor device within both the MCU and MAIN domains for the
> TI K3 AM68 SK boards. These nodes are assigned to the respective rproc
> device nodes as well. The first region will be used as the DMA pool for
> the rproc device, and the second region will furnish the static carveout
> regions for the firmware memory.
>
> The current carveout addresses and sizes are defined statically for each
> device. The R5F processors do not have an MMU, and as such require the
> exact memory used by the firmwares to be set-aside. The firmware images
> do not require any RSC_CARVEOUT entries in their resource tables either
> to allocate the memory for firmware memory segments.
>
> Note that the R5F1 carveouts are needed only if the R5F cluster is
> running in Split (non-LockStep) mode. The reserved memory nodes can be
> disabled later on if there is no use-case defined to use the
> corresponding
> remote processor.
>
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 156 +++++++++++++++++++++
>   1 file changed, 156 insertions(+)

Reviewed by: Udit Kumar<u-kumar1@ti.com>

> [...]
