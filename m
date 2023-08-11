Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D64D779899
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjHKUbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjHKUbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:31:45 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F861AA;
        Fri, 11 Aug 2023 13:31:44 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BKVZ96012376;
        Fri, 11 Aug 2023 15:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691785895;
        bh=Hw6THVNdTS2IzS4mI52C7J40avF8EqNjo2uhaWNQgxU=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=xPz7mFdlHHNj1s0CvP0FSgTuxz3gmfSwDbre3N4+lKuLWE+UFj3fj6Mscpx75OfAO
         TNq1Ca4vK9WlZSetHzQZwvbZVJnxrGQOkHI/8Ro5GQFmST273u56PrvmjyBljmbqlE
         RA4+7tk8iJKyEOHULd/qr4G5yiQZ0MA2stVu2GNk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BKVZlT129771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 15:31:35 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 15:31:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 15:31:35 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BKVYT6009410;
        Fri, 11 Aug 2023 15:31:34 -0500
Message-ID: <a5731a6b-f97b-a1c7-4322-a50c538ad11b@ti.com>
Date:   Fri, 11 Aug 2023 15:31:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/5] Add R5F and C7x DSP nodes for J721S2 SoC.
Content-Language: en-US
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
References: <20230811202252.3586926-1-a-nandan@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230811202252.3586926-1-a-nandan@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 3:22 PM, Apurva Nandan wrote:
> This series adds the R5F processor nodes and C7x DSP nodes for
> J721S2 SoC.
> 
> The first three patches adds the remote proc nodes to the SoC device
> tree and the last two patches reserves the memory for remote proc IPCs
> on J721S2 EVM board.
> 
> Test log: https://gist.githubusercontent.com/apurvanandan1997/556b4148651ae74b50dda993ad07f1e5/raw/
> 
> v3: Changelog:
> 1) Disabled c7x in k3-j721s2-main.dtsi and enabled in k3-j721s2-som-p0.dtsi
>     which fixes the following dtbs_check for k3-am69-sk.dts
>     - dsp@64800000: 'mboxes' is a required property
>     - dsp@64800000: 'memory-region' is a required property
> 2) Split into separate patches for C7x and R5F

Thanks for taking care of these details, series LGTM,

Reviewed-by: Andrew Davis <afd@ti.com>

> 
> Link to v2:
> https://lore.kernel.org/lkml/20230808201842.292911-1-a-nandan@ti.com/
> 
> v2:Changelog:
> 1) Added status = "disabled"; in soc dtsi files, and removed it from som dts
> 2) Fixed mboxes property in for all cores in som dts
> 
> Link to v1:
> https://lore.kernel.org/all/20230529220941.10801-1-hnagalla@ti.com/
> 
> Apurva Nandan (4):
>    arm64: dts: ti: k3-j721s2-main: Add MAIN R5F remote processsor nodes
>    arm64: dts: ti: k3-j721s2-main: Add C7x remote processsor nodes
>    arm64: dts : ti: k3-j721s2-som-p0: Add DDR carveout memory nodes for
>      R5F
>    arm64: dts : ti: k3-j721s2-som-p0: Add DDR carveout memory nodes for
>      C71x DSPs
> 
> Hari Nagalla (1):
>    arm64: dts: ti: k3-j721s2-mcu: Add MCU R5F cluster nodes
> 
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 106 +++++++++
>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  40 ++++
>   arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 208 ++++++++++++++++++
>   3 files changed, 354 insertions(+)
> 
