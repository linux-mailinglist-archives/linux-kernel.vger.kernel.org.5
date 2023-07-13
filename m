Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400D47528F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbjGMQlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbjGMQkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:40:55 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EA935AB;
        Thu, 13 Jul 2023 09:40:26 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DFVPcn055385;
        Thu, 13 Jul 2023 10:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689262285;
        bh=Fx8/FCdawKoQ2I1f7bvdlggCVVdqP5rMHBO9wGphMp4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mbOqi6mAwqKM425nlaW57i2ypI3PGooyK06goWjJ7TzBfy0eIKwEg3/zdstTELG/G
         bXMoQknf8snDGYW7wB4vJAxfv0r6YuEiYnbqdBbq8L+F7OWiOeRBF8GwbiYbGVSo4M
         MLsA2mt13Xn+u5IX+SOp54smfd1UzZINMhMeT47c=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DFVP2H122561
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 10:31:25 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 10:31:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 10:31:25 -0500
Received: from [10.249.136.52] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DFVLAM035657;
        Thu, 13 Jul 2023 10:31:22 -0500
Message-ID: <18310450-05f3-172c-e4bc-fda114f333a4@ti.com>
Date:   Thu, 13 Jul 2023 21:01:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 3/5] arm64: dts: ti: k3-j784s4: Add WIZ and SERDES PHY
 nodes
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <afd@ti.com>, <s-vadapalli@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230710101705.154119-1-j-choudhary@ti.com>
 <20230710101705.154119-4-j-choudhary@ti.com>
 <20230712141828.lnpo4mhd5dv34rlz@census>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230712141828.lnpo4mhd5dv34rlz@census>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/23 19:48, Nishanth Menon wrote:
> On 15:47-20230710, Jayesh Choudhary wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> J784S4 SoC has 4 Serdes instances along with their respective WIZ
>> instances. Add device-tree nodes for them and disable them by default.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> [j-choudhary@ti.com: fix serdes_wiz clock order]
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
> NAK. This patch introduces the following dtbs_check warning.
> arch/arm64/boot/dts/ti/k3-am69-sk.dtb: serdes-refclk: 'clock-frequency' is a required property
> 

Sorry for this. This property was added in the final board file.
I will fix it in the next revision.
I will add '0' as clock-property in the main file similar to j721e[1]
which will be overridden in the board file with required value to get
rid of this warning.

Warm Regards,
-Jayesh

[1]: 
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi#n16>


