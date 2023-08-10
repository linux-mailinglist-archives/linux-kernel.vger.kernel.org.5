Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFD0776D64
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjHJBMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHJBMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:12:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDCC1982;
        Wed,  9 Aug 2023 18:12:13 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A1C8cV022013;
        Wed, 9 Aug 2023 20:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691629928;
        bh=uxxGT65fRGlsGnQ0NdE7ItHanqicRg4wNo8X6hdp2RA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WFB+sBhyiF/Nti1kBzIGIkOSAglcjm9ae2u2XeyaReDTPr7EIqhNr/NEvVooZRuYz
         jXP6GfbQ237FGM6vRuTmtxblZ7vS9Pb7L7F9aqcnuR6+TGaqq1FPOeVbgWmjcwb1aC
         sXzEze3ymf1VDYd6C4Ew+owqsofTtQv8Tp7U5udE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A1C75T086386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 20:12:07 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 20:12:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 20:12:07 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A1C7dP068901;
        Wed, 9 Aug 2023 20:12:07 -0500
Date:   Wed, 9 Aug 2023 20:12:07 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Add R5F and C7x DSP nodes for AM62a SoC
Message-ID: <20230810011207.ltlzresx5hwiwlgo@shawl>
References: <20230810005850.21998-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810005850.21998-1-hnagalla@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:58-20230809, Hari Nagalla wrote:
> This patch series adds R5F and C7x dsp processor nodes for AM62A SoC.
> The first patch amends the dsp node binding doc file and the remaining
> patches configure the remote processor device nodes.
> 
> v1: https://lore.kernel.org/all/20230502141416.9924-1-hnagalla@ti.com/ 
> 
> Devarsh Thakkar (2):
>   arm64: dts: k3-am62a-wakeup: Add R5F device node
>   arm64: dts: ti: k3-am62a7-sk: Enable ipc with remote proc nodes
> 
> Hari Nagalla (2):
>   dt-bindings: remoteproc: k3-dsp: correct optional sram properties for
>     AM62A SoCs
>   arm64: dts: k3-am62a-mcu: Add R5F remote proc node
> 
> Jai Luthra (1):
>   arm64: dts: k3-am62a-main: Add C7xv device node

	please send the binding fix to the remoteproc maintainer, SoC TI
	can pick the dts fixes in the next kernel rc1 rev.
> 
>  .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 16 ++++-
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 11 +++
>  arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi      | 35 ++++++++++
>  arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   | 23 +++++++
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       | 68 +++++++++++++++++++
>  5 files changed, 151 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
