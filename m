Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5887F5924
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbjKWHYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjKWHYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:24:06 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113231AE;
        Wed, 22 Nov 2023 23:24:12 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AN7O36p054116;
        Thu, 23 Nov 2023 01:24:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700724243;
        bh=TGc5OPH6YSShQOIo05fyi7b2rYKPVzZvGdOwoeCul7I=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SSDymrpkNgU6WWHPO5/5pppAIry/GU5g76xvX5Gs/kKJglN7+IpzgLGNwJMKe95ex
         Ng/vvdcTLycPHh+B6LduIZ6mHn3qGVQis3K5mMOfqB/JHwVu3m2SEWW3gr841tUv4Y
         tziOZU5tTB3vlrl4O3saP+ieDxmbVAvcwC3xblvM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AN7O3X0084161
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Nov 2023 01:24:03 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 01:24:03 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 01:24:03 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AN7O2i6011049;
        Thu, 23 Nov 2023 01:24:02 -0600
Date:   Thu, 23 Nov 2023 01:24:02 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Neha Malcom Francis <n-francis@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-nandan@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>, <vaishnav.a@ti.com>, <hnagalla@ti.com>,
        <devarsht@ti.com>
Subject: Re: [PATCH v7 0/4] Add TPS6594 PMIC support on several boards
Message-ID: <20231123072402.2pscgotxhc6mffe2@carnivore>
References: <20231122104513.2335757-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231122104513.2335757-1-n-francis@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:15-20231122, Neha Malcom Francis wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
> communicate through the I2C or SPI interfaces.
> TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
> 
> This series adds device tree nodes for TI TPS6594 PMICs found in the
> following boards:
> - J721EXSOMXEVM:
>   Link: https://www.ti.com/tool/J721EXSOMXEVM
> - J721S2XSOMXEVM:
>   Link: https://www.ti.com/tool/J721S2XSOMXEVM
> - J7200XSOMXEVM:
>   Link: https://www.ti.com/tool/J7200XSOMXEVM
> - J784S4XEVM
>   Link: https://www.ti.com/tool/J784S4XEVM
> 
> Boot Logs:
> https://gist.github.com/nehamalcom/384cf594e37739a34f8a08664830e37a
> 
> ---
> Changes from v6:
> https://lore.kernel.org/all/20230810-tps6594-v6-0-2b2e2399e2ef@ti.com/
> - Modify patch series to include only patches not merged (J7)
> - Add boot logs for all affected boards

So what changed for j721s2?
https://lore.kernel.org/all/20230810024700.4qhgygd6mma4sw2u@kobold/

And, there is no defconfig patch? Then how did the test work? if you
have done local .config changes, that should have been defconfig patch.

Also did you audit the SKs to make sure they don't need this?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
