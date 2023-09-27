Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FB27B0813
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjI0PW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjI0PWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:22:55 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC89199;
        Wed, 27 Sep 2023 08:22:53 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RFMk4b094035;
        Wed, 27 Sep 2023 10:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695828166;
        bh=4Ta4IAomgLuh+Ghvv0s9NcJ0pVcIltH33sQCw8+cYag=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=bXBUu5je9xhsKfTwT46/yHL38Za6dgT9Gx4Yf/mpeUSiOSin/QEzJuP6FYvAPqpIB
         zp1o3IRE9DmJchuGP1ERV8/ZicEMLP69NAqRgeVLdxCA1EfCSUOuCRtnpTANShU3fq
         SgNXbi+4mjdWESPtqm9eye+pXBBQlYXv2m2nqwz0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RFMkVZ002985
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Sep 2023 10:22:46 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 10:22:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 10:22:46 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RFMg6e099870;
        Wed, 27 Sep 2023 10:22:43 -0500
Message-ID: <d96b0ac6-b216-3025-23f7-28c93b84b98f@ti.com>
Date:   Wed, 27 Sep 2023 20:52:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 8/9] arm64: dts : ti: k3-am69-sk: Add DDR carveout
 memory nodes for R5F
Content-Language: en-US
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
 <20230906112422.2846151-9-a-nandan@ti.com>
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230906112422.2846151-9-a-nandan@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/2023 4:54 PM, Apurva Nandan wrote:
> Two carveout reserved memory nodes each have been added for each of the
> R5F remote processor device within both the MCU and MAIN domains for the
> TI K3 AM69 SK boards. These nodes are assigned to the respective rproc
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
> disabled later on if there is no use-case defined to use the corresponding
> remote processor.
>
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 200 ++++++++++++++++++++++++++
>   1 file changed, 200 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> index d282c2c633c1..d5a39caf15af 100644
> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> @@ -47,6 +47,102 @@ secure_ddr: optee@9e800000 {
>   			reg = <0x00 0x9e800000 0x00 0x01800000>;
>   			no-map;
>   		};


Reviewed by: Udit Kumar<u-kumar1@ti.com>

> [...]
