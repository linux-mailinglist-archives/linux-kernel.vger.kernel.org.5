Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7E17638E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjGZORy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjGZORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:17:39 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19052273D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:16:28 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36QEFi71099309;
        Wed, 26 Jul 2023 09:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690380944;
        bh=JlCtKk7hUWN8SZwIjABEFWgmcaQVVJb/5LFzNah2tec=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=cxkyE6+U1Jgb2x+dKykooelWm0rXXQzCU2wurAIcaXiSAFfmceAEO5OJs7kfLk8lM
         k9p7jOARD7ngyklqztH97LL0d/XrJ6fxL7ankD1aqAv5KXYCzsoN51XEhafF2a/T6E
         BhECSwdEPmRAw25FBzDJLZQCO8Yh5uD/DLt3aDJM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36QEFiFY030009
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 09:15:44 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jul 2023 09:15:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jul 2023 09:15:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36QEFia8017875;
        Wed, 26 Jul 2023 09:15:44 -0500
Date:   Wed, 26 Jul 2023 09:15:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     <vigneshr@ti.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <krzysztof.kozlowski@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Aradhya Bhatia <a-bhatia1@ti.com>,
        Hari Nagalla <hnagalla@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable various configs for TI
 platforms
Message-ID: <20230726141544.jqydhtd2ns5r54hy@eaten>
References: <20230726133049.2074105-1-u-kumar1@ti.com>
 <20230726134322.gepflrrdcpx6uxvu@colony>
 <ace112fe-978c-a518-2be5-3f3d1f7fd29c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ace112fe-978c-a518-2be5-3f3d1f7fd29c@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:38-20230726, Kumar, Udit wrote:
> > On 19:00-20230726, Udit Kumar wrote:
> > > Enable TI ECAP, DP83869 driver, TI OMAP2, K3 remote proc
> > I think you mean to state TI mailbox and not omap2 :)
> 
> Not really :)
> 
> This driver TI OMAP2, (CONFIG_OMAP2PLUS_MBOX) is used in

OMAP2 is an SoC Architecture with a bunch of SoCs - OMAP2420,
OMAP2430... OMAP2+ refers to the combination of platforms from OMAP2,
OMAP3, OMAP4, OMAP5. Mailbox is a inter-processor communication
hardware block that has been used since OMAP2 generation of SoCs. The
same hardware block is used in K3 architecture as well.

So, call it OMAP2 Mailbox rather than TI OMAP2.
[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
