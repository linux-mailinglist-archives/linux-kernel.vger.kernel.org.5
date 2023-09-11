Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE679A2D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjIKF0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjIKF0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:26:45 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D923CCB;
        Sun, 10 Sep 2023 22:26:35 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38B5QTb6018067;
        Mon, 11 Sep 2023 00:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694409989;
        bh=HvhxSOFRQX0iMubBivgYbIGT+oXRDG8Cl5SMk+EbhME=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=WpPc5pMM/t698uXIzp01p1w3mr0yWyKatTFFOHVDvTeupnZSK9OeSsxNZYnDMAdf6
         tOG3ipOd7+UEUtDimQfRmn9H27CpzI0pXKJ+2YvecxTD+J550Zzqx8gtUoUoYSejy5
         zT0FsFsHCGSOe+oHiBjeZV13FUP3U44OFMQbHICM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38B5QTeu116861
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 00:26:29 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 00:26:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 00:26:29 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38B5QP7x018037;
        Mon, 11 Sep 2023 00:26:25 -0500
Message-ID: <25ba2e12-00a2-61bd-022e-7258c0ffb89b@ti.com>
Date:   Mon, 11 Sep 2023 10:56:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <afd@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: k3-j721s2: Add overlay to enable
 main CPSW2G with GESI
To:     Rob Herring <robh+dt@kernel.org>
References: <20230726065407.378455-1-s-vadapalli@ti.com>
 <20230726065407.378455-3-s-vadapalli@ti.com>
 <CAL_JsqJ7zHHMiZiSfM+Du3d-rG9VetkEvbBXHYN5=JUcg2irAA@mail.gmail.com>
Content-Language: en-US
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <CAL_JsqJ7zHHMiZiSfM+Du3d-rG9VetkEvbBXHYN5=JUcg2irAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hello Rob,

On 09/09/23 03:47, Rob Herring wrote:
> On Wed, Jul 26, 2023 at 1:54 AM Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
>>
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> The MAIN CPSW2G instance of CPSW on J721S2 SoC can be enabled with the GESI
>> Expansion Board connected to the J7 Common-Proc-Board. Use the overlay
>> to enable this.
>>
>> Add alias for the MAIN CPSW2G port to enable kernel to fetch MAC address
>> directly from U-Boot.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>>  .../dts/ti/k3-j721s2-evm-gesi-exp-board.dtso  | 85 +++++++++++++++++++
>>  2 files changed, 87 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index 6dd7b6f1d6ab..019a8be19b93 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
>>  # Boards with J721s2 SoC
>>  dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>> +dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-gesi-exp-board.dtbo
> 
> Overlays need to be applied to something. That's done like this:
> 
> foo-dtbs := base.dtb k3-am62x-sk-hdmi-audio.dtbo
> dtb-y += foo.dtb
> 
> Please send a fix for this.

I have posted the fix at:
https://lore.kernel.org/r/20230911052158.89185-1-s-vadapalli@ti.com/

> 
> Rob

-- 
Regards,
Siddharth.
