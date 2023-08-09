Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19FE7763FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjHIPge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjHIPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:36:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3CE30E5;
        Wed,  9 Aug 2023 08:35:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379FYxAK087176;
        Wed, 9 Aug 2023 10:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691595299;
        bh=JiQZC2FZs9C/E86dwYL/boTsnw7Kx4vcl3knrFhrQ8w=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=sVIo2GrBGCOXUdFI0EEtry+iH5TVwpK+Y/ZM25FLB0JisdygtGrZ+8xK3OMfTm4LG
         qCAD3t1heu7pRusvxBk2mpqNasP5Y4cYaKMkXkELyv9MxetbeUjfb9g6Zaks5yiWHc
         wABja+p9E73a9OF1UVBeidG3tJGi4hpO60+T8Kss=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379FYxlu006583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 10:34:59 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 10:34:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 10:34:58 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379FYwMI091148;
        Wed, 9 Aug 2023 10:34:58 -0500
Date:   Wed, 9 Aug 2023 10:34:58 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jai Luthra <j-luthra@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v5 0/6] Add TPS6594 PMIC support on several boards
Message-ID: <20230809153458.lbenzo74u5zuzwet@showgirl>
References: <20230809-tps6594-v5-0-485fd3d63670@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809-tps6594-v5-0-485fd3d63670@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:17-20230809, Jai Luthra wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
> communicate through the I2C or SPI interfaces.
> TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
> 
> This serie adds device tree nodes for TI TPS6594 PMICs found in the
> following boards:
> - J721EXSOMXEVM:
>   Link: https://www.ti.com/tool/J721EXSOMXEVM
> - J721S2XSOMXEVM:
>   Link: https://www.ti.com/tool/J721S2XSOMXEVM
> - J7200XSOMXEVM:
>   Link: https://www.ti.com/tool/J7200XSOMXEVM
> - AM62A-SKEVM:
>   Link: https://www.ti.com/tool/SK-AM62A-LP
> - J784S4XEVM
>   Link: https://www.ti.com/tool/J784S4XEVM


In the refresh, could you roll in
https://lore.kernel.org/linux-arm-kernel/22e92c94-b3ee-3505-57d3-a3243e8671d8@ti.com/
into this series rather than with Audio series?

Please also see if any other PMIC defconfig needs to be enabled while at
it.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
