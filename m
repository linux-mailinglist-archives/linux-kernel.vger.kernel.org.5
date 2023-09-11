Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1461779BDFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357206AbjIKWFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbjIKI1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:27:11 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A65B110;
        Mon, 11 Sep 2023 01:27:06 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38B8Qs2C080008;
        Mon, 11 Sep 2023 03:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694420814;
        bh=nou6XV5HrZutUro+1SS2+mIlpVh2z5I+ijBXzWViANc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=dNifVKpUiCdzMKhvUZGkw/F2KMBpcyA8jOOBuANQ8jYaBhk6xfA72fFudDdtdpJRo
         vPtx24qiYDbPOpS3RwlMrOBxIJjpORaRzy3kCF3cpd88G6pq8JKHRfDHKGnvqJDV8U
         JPIVMKbr/eoYfZK4PEDr4ZK1EgZvqIeFbYLtit8Y=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38B8Qsic062818
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 03:26:54 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 03:26:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 03:26:54 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38B8Qoun005857;
        Mon, 11 Sep 2023 03:26:50 -0500
Message-ID: <a5c650c9-3bb5-44d7-8191-8e122f1077df@ti.com>
Date:   Mon, 11 Sep 2023 13:56:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 0/7] arm64: ti: k3-j7: Add the ESM & main domain
 watchdog nodes
To:     Keerthy <j-keerthy@ti.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20230911040942.31031-1-j-keerthy@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230911040942.31031-1-j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keerthy

On 9/11/2023 9:39 AM, Keerthy wrote:
> The series add the ESM & main domain watchdog nodes for j721s2,
> j784s4 SOCs.
>
> Changes in v3:
>
> 	* Added all the RTI events for MAIN_ESM for j784s4 as 8 instances
> 	  are enabled.
> 	* Rebased on top of 6.6-rc1
> 	* Tested for the watchdog reset
>
> RESEND series - corrected krzysztof.kozlowski+dt@linaro.org ID
>
> Changes in v2:
>
>          * Added all the instances of watchdog on j784s4/j721s2
>          * Fixed all 0x0 in dts to 0x00
>          * Fixed couple of ESM event numbers for j721s2
>          * Rebased to linux-next branch
>
> Keerthy (7):
>    arm64: dts: ti: k3-j721s2: Add ESM instances
>    arm64: dts: ti: k3-j784s4: Add ESM instances
>    arm64: dts: ti: k3-j7200: Add MCU domain ESM instance
>    arm64: dts: ti: k3-j784s4-main: Add the main domain watchdog instances
>    arm64: dts: ti: k3-j784s4-mcu: Add the main domain watchdog instances
>    arm64: dts: ti: k3-j721s2-main: Add the main domain watchdog instances
>    arm64: dts: ti: k3-j721s2-mcu: Add the main domain watchdog instances

Thanks for series,

Two minor suggestions.

1) Order of patches , since J721S2 esm is added first , it will be 
better to have  watchdog for J721S2 first

2) I understand, to add watchdog entries, for J784S4 and J721S2, you 
followed ascending device id order

due to that there is mix of entries like watchdog16 coming before 
watchdog15.


Let maintainers to take call on these minor one.


For me, with or without above suggestions fix.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   6 +
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |  94 +++++++++
>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  32 +++
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 189 ++++++++++++++++++
>   .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  32 +++
>   5 files changed, 353 insertions(+)
>
