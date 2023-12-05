Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAE1805DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346199AbjLEScA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLESb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:31:58 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3CD1A3;
        Tue,  5 Dec 2023 10:32:04 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5IVtsK069716;
        Tue, 5 Dec 2023 12:31:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701801115;
        bh=s7vJc403VmnZq30rm2kHIIpCMIF7DVzrRxssjHMAj7Q=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=apAc6UiPbD0hMDeuHsaBTxdr/dcxXDEFon4DRGEtHrDHA1mVAgkKbol11EHscCfWX
         r4RjDKZwNqxzOWlLD/lyRvSyoS7yWS85ZFRIZzVa6bxJnEiHUqnbXzzEUZMAmSwcZO
         LV5Z1eWW6CtkoO4WMCzymtmUvFEcI0NOvjt5jU3g=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5IVtJ1068194
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Dec 2023 12:31:55 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 12:31:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 12:31:55 -0600
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5IVo9x066832;
        Tue, 5 Dec 2023 12:31:51 -0600
Message-ID: <30baf959-e486-4804-947b-516e53cce6fa@ti.com>
Date:   Wed, 6 Dec 2023 00:01:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: dts: ti: Add Itap Delay Value For High Speed
 DDR
To:     Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <u-kumar1@ti.com>
References: <20231201082045.790478-1-b-kapoor@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20231201082045.790478-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhavya

On 12/1/2023 1:50 PM, Bhavya Kapoor wrote:
> This Series adds Itap Delay Value for DDR52 speed mode for eMMC in
> J7200 and for DDR50 speed mode for MMCSD in J721s2 and J784s4 SoC.
>
> Rebased to next-20231201
>
> Bhavya Kapoor (3):
>    arm64: dts: ti: k3-j7200-main: Add Itap Delay Value For DDR52 speed
>      mode
>    arm64: dts: ti: k3-j721s2-main: Add Itap Delay Value For DDR50 speed
>      mode
>    arm64: dts: ti: k3-j784s4-main: Add Itap Delay Value For DDR50 speed
>      mode

Could you confirm, after adding itap values, above modes are working 
fine apart from

mode detection.

Thanks

Udit


>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi  | 1 +
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 1 +
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 1 +
>   3 files changed, 3 insertions(+)
>
