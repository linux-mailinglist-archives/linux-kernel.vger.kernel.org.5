Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35297637DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjGZNn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjGZNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:43:54 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B62610FA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:43:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36QDhNhm059372;
        Wed, 26 Jul 2023 08:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690379003;
        bh=fnT5LE7FtoBV0RsZMcMQxdiF/qPZYvwty/dj8hNsqDc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=M/d/FEJbQRTbUqA3SCmx9wdncbW7JG8Gg/c+5vtwN7wh6pffylyqQEU7tgVLVlar7
         a0Jp13S0jitlF1nuFSn3xU+ZbNzZRYcSRa43MlVhBh2ONR/Jg3oFACRtCC7o2sWA0t
         bSZtbvfUL0YeC1kXp5kYA6p7FpwZQzVlEdHRnyYw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36QDhNS6027148
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 08:43:23 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jul 2023 08:43:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jul 2023 08:43:22 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36QDhMe7126175;
        Wed, 26 Jul 2023 08:43:22 -0500
Date:   Wed, 26 Jul 2023 08:43:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Udit Kumar <u-kumar1@ti.com>
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
Message-ID: <20230726134322.gepflrrdcpx6uxvu@colony>
References: <20230726133049.2074105-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230726133049.2074105-1-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on $subject: I think mentioning K3 will help narrow things down a bit.

On 19:00-20230726, Udit Kumar wrote:
> Enable TI ECAP, DP83869 driver, TI OMAP2, K3 remote proc

I think you mean to state TI mailbox and not omap2 :)

> SND_SOC_J721E_EVM, MCAN, UFS and RTI driver to be built
> as module.
> These are needed on different TI platforms.

Please elaborate the list of boards this benefits TI platforms are a
big variant list. TI Platforms is too generic a term that scales
architectures.. that is not the point you are trying to make.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Judith Mendez <jm@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

If the various contributers are ok, just my 2 cents:
Could you drop all other sign-offs other than yours? I understand the
contributions from various members on the TI SDK tree, but I'vent seen
them attempt to upstream and you took the effort in ensuring the new
squashed patch contains all the relevant components.

[..]
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
