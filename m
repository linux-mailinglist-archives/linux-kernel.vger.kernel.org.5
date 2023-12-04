Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ED08040D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjLDVMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjLDVMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:12:53 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92993B6;
        Mon,  4 Dec 2023 13:12:58 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B4LCr4F100462;
        Mon, 4 Dec 2023 15:12:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701724373;
        bh=GCAlqRs92aifqS39Ep3zKENTJ3ftc7FHnWc5xULdwow=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WVpWhvDAfLTjSEZMSodQ50gR7NyC1RJrsb3uCz2dEsc++iE+Rb+EIHLBoWwDl5hXq
         SypNSZoTcBVZL7B8ObiBwGI6nivNVFz491tkHHTxDOdGiM2nXIQ8foZor4PGJyuLVv
         0gLVSa/B+MXGtxCMIXYcwAKccCBUSB14BNHFwNpo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B4LCriQ061258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Dec 2023 15:12:53 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 15:12:53 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 15:12:52 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B4LCqvE063147;
        Mon, 4 Dec 2023 15:12:52 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] arm64: dts: ti: k3-j7200: Add chipid node to wkup_conf bus
Date:   Mon, 4 Dec 2023 15:12:51 -0600
Message-ID: <170172436341.2630814.4304040849762838946.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231117140910.8747-1-afd@ti.com>
References: <20231117140910.8747-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew Davis,

On Fri, 17 Nov 2023 08:09:06 -0600, Andrew Davis wrote:
> Like in other K3 SoCs the chipid register is inside the wakeup
> configuration space. Move the chipid node under a new bus to
> better represent this topology and match other similar SoCs.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-j7200: Add chipid node to wkup_conf bus
      commit: 82277ed7db29296a2907eab91934c26c405db604
[2/5] arm64: dts: ti: k3-j784s4: Add chipid node to wkup_conf bus
      commit: 3dc5bd24181af7eb90ad764c3b303f697ebf5e87
[3/5] arm64: dts: ti: k3-j721s2: Add chipid node to wkup_conf bus
      commit: 1026355c21ebe9f7af3bb0a9422bc572c9f4ac91
[4/5] arm64: dts: ti: k3-am65: Add chipid node to wkup_conf bus
      commit: 8121e93102b0e09ff1d9589659a823b2271acf62
[5/5] arm64: dts: ti: k3-j721e: Add chipid node to wkup_conf bus
      commit: 27e5b7330fe31d0aae196f26cf251254f2b923bb

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

