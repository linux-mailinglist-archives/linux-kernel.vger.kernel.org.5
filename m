Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38D7667A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjG1Ir5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjG1IrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:47:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BBB3C30;
        Fri, 28 Jul 2023 01:47:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36S8l5cP017291;
        Fri, 28 Jul 2023 03:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690534025;
        bh=ospLJOiRLA8qDpt2SMFfsnLKB32y9OULjpCRa2jD87k=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=YTXCK0Fftm3PoA8be2LeRyP47nLVi2TQz/nPtdgpu8ADu7fYZvHGHBFmwmc4cK4Ko
         KWQpR9B5f5ajOAT63x5i90tf1loofytl0LhbfKxRchMhKswqudj514DJbtGIq6aqxc
         r8+zaaRitBCeaEn7WzAlTALQGO9xTFcv8yBeEH1A=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36S8l5u1004205
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 03:47:05 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 03:47:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 03:47:05 -0500
Received: from [172.24.227.94] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36S8l2k3061575;
        Fri, 28 Jul 2023 03:47:02 -0500
Message-ID: <72f0010b-fa38-56c2-8b7f-fe1af89e5e36@ti.com>
Date:   Fri, 28 Jul 2023 14:17:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-j784s4: Add UFS support
Content-Language: en-US
To:     Udit Kumar <u-kumar1@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230725133607.2021379-1-u-kumar1@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230725133607.2021379-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/07/23 19:06, Udit Kumar wrote:
> This patch series adds UFS support for J784S4 SOC,
> UFS is kept disabled at SOC level, and enabled in EVM where
> UFS flash is present.
> 
> This patch is tested by enabling below configs on top of defconfig
> CONFIG_SCSI_UFS_BSG=y
> CONFIG_SCSI_UFS_CDNS_PLATFORM=y
> CONFIG_SCSI_UFS_TI_J721E=y
> 
> Change log:
> 
> Changes in v2
> v1: https://lore.kernel.org/all/20230725053843.1721028-1-u-kumar1@ti.com/
> Add DT node for UFS:
>   Corrected typo
>   Added 0x00 instead of 0x0 to align with test of file
>   Added Tested by
> 
> Add Support for UFS peripheral
>   Added Tested by
> 
> Test logs of v1 patch
> https://gist.github.com/uditkumarti/ab188e4b433058ae86734cd46eff7d94
> 
> 
> Udit Kumar (2):
>   arm64: dts: ti: k3-j784s4-main: Add DT node for UFS
>   arm64: dts: ti: k3-j784s4-evm: Add Support for UFS peripheral
> 
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   |  4 ++++
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 24 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

-- 
Regards
Vignesh
