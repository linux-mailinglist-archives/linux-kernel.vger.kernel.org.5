Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA5A8113F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjLMOAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjLMN7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:59:49 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5629B10CE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:58:59 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDDwsgj027897;
        Wed, 13 Dec 2023 07:58:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702475934;
        bh=89t8sp8RvwbRW5tg6/I1blYTP7PaFABvFF+QNtHqL60=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=emFA6BU2KimBoMWh/rUHfyORUyiTum0N+nUsaD++XstqmJpEZpwPnFegilVZ1FU09
         dSHI3RNLsyLVwk7gMiQ+g7a5bzlUR59eIefqe+33TBH8rlgn2j9O5L98WxsvRthw3s
         lbN7LNqwjjl00OpZdTkmAbd7MJ4srL+GkYkCYmxg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDDwsYY126018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 07:58:54 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 07:58:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 07:58:53 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDDwrPV109893;
        Wed, 13 Dec 2023 07:58:53 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vaishnav Achath <vaishnav.a@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
        <j-choudhary@ti.com>
Subject: Re: [PATCH] soc: ti: k3-socinfo: Add JTAG ID for J722S
Date:   Wed, 13 Dec 2023 07:58:52 -0600
Message-ID: <170247592434.2577664.9645918157736470871.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211132600.25289-1-vaishnav.a@ti.com>
References: <20231211132600.25289-1-vaishnav.a@ti.com>
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

Hi Vaishnav Achath,

On Mon, 11 Dec 2023 18:56:00 +0530, Vaishnav Achath wrote:
> Add JTAG ID info for the J722S SoC family to enable SoC detection.
> 
> More details about this SoC can be found in the TRM:
> 	https://www.ti.com/lit/zip/sprujb3
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: k3-socinfo: Add JTAG ID for J722S
      commit: 2c2235292b33d788a1436f1d2a6108184a657f51

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

