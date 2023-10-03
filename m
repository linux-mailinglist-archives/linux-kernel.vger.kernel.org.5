Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B0B7B671F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239983AbjJCLDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjJCLDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:03:44 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB6CB4;
        Tue,  3 Oct 2023 04:03:41 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393B3WLB048005;
        Tue, 3 Oct 2023 06:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696331012;
        bh=FE/aQgQdKgOY0EfmAJOD6c3hwO0kJhRHCGRU5eMOVFg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rVLdsSyi3LJxLbD63M8Wsf8aHphJl7rss3tn6egy84VvtAuwJcZohHcvNSHgPjSIm
         iXHoUuOraUkBri8zl+dS+VpcU9FadumS6gIWG80wfB6U0JNdzRY92gIwMidBbJl9D1
         eExuNYKc8Qzch/H6anYbZ+oE/1M0ycOf1wU4qLiA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393B3W4T002792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 06:03:32 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 06:03:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 06:03:31 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393B1Dvm129223;
        Tue, 3 Oct 2023 06:03:28 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am654-base-board: Add I2C I/O expander
Date:   Tue, 3 Oct 2023 16:30:49 +0530
Message-ID: <169633065054.2221719.4109033665984711830.b4-ty@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920053834.21399-1-r-gunasekaran@ti.com>
References: <20230920053834.21399-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi Gunasekaran,

On Wed, 20 Sep 2023 11:08:34 +0530, Ravi Gunasekaran wrote:
> AM654 baseboard has two TCA9554 I/O expander on the WKUP_I2C0 bus.
> The expander at address 0x38 is used to detect daughter cards.
> Add a node for this I/O expander.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am654-base-board: Add I2C I/O expander
      commit: 2f40c6df3dcc1341afd99cd1a4de035f807c8a03

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
Vignesh

