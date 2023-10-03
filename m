Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805557B6714
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbjJCLDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239979AbjJCLDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:03:02 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27832D9;
        Tue,  3 Oct 2023 04:02:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393B2o4X090298;
        Tue, 3 Oct 2023 06:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696330970;
        bh=oKguRQsLG/WkRSzVJ52xZM14EtO1D/qUEJDWKbdWsTg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PY8nXZnSmZHB8zLQbRqGMk3U6yj17J3ZHMAx0J+8NZjLPearaIO1yYhy8WSGLIf97
         AbKEYWHlviF5B+m2qHtQUkC4/lGyrs5SOAs4lV0ISguya9gPxYhxisCh4c6GqSABQw
         7prb6zOIrHn7cdf6PT6LsBOB7hufsw9/RoxqK/Ow=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393B2nXf002494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 06:02:50 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 06:02:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 06:02:49 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393B1Dvk129223;
        Tue, 3 Oct 2023 06:02:46 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Tom Rini <trini@konsulko.com>,
        Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-am625: Add boot phase marking
Date:   Tue, 3 Oct 2023 16:30:47 +0530
Message-ID: <169633065052.2221719.18006511616618309362.b4-ty@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911162535.1044560-1-nm@ti.com>
References: <20230911162535.1044560-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,

On Mon, 11 Sep 2023 11:25:32 -0500, Nishanth Menon wrote:
> bootph-all as phase tag was added to dt-schema
> (dtschema/schemas/bootph.yaml) to describe various node usage during
> boot phases with DT.
> 
> Based on next-20230911
> 
> Nishanth Menon (3):
>   arm64: dts: ti: k3-am625: Add boot phase tags marking
>   arm64: dts: ti: k3-am625-beagleplay: Add boot phase tags marking
>   arm64: dts: ti: k3-am625-sk: Add boot phase tags marking
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am625: Add boot phase tags marking
      commit: 87e437a0fb6cbecbabff293061793b32e3bcd3b1
[2/3] arm64: dts: ti: k3-am625-beagleplay: Add boot phase tags marking
      commit: 944adefc7f88aec1adf5f76f593d483938bc5e4e
[3/3] arm64: dts: ti: k3-am625-sk: Add boot phase tags marking
      commit: c412c2f26eed08b1836ccf79f5547b67c1b55d5d

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

