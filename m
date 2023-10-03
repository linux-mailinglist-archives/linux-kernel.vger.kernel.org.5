Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485B97B6711
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbjJCLCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239979AbjJCLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:02:52 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94802AF;
        Tue,  3 Oct 2023 04:02:49 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393B2iVA060457;
        Tue, 3 Oct 2023 06:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696330964;
        bh=RhFn1NX600E1HUFjRN5fhMG8ct64/Y2PP8y3PLMoDfs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HOvmL0dhKGEQixVUGPad/sTqmpUNklf7U4RFC1EyfJMPlJhI+TmRj+0LDxpehx0gF
         qw2qxKauID6knHFqpfp0XxWBrMAAD0nZ7UqF1G9PpHLY0sdALFzOVhPC3uU/DAGGQi
         ZhDQQz3HpI7RbOrp39guD0be9xoUsrXZi2+nRhbk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393B2iFn097365
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 06:02:44 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 06:02:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 06:02:43 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393B1Dvj129223;
        Tue, 3 Oct 2023 06:02:39 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Tom Rini <trini@konsulko.com>,
        Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-am42: Add boot phase tags marking
Date:   Tue, 3 Oct 2023 16:30:46 +0530
Message-ID: <169633065052.2221719.11298211613404230030.b4-ty@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911172902.1057417-1-nm@ti.com>
References: <20230911172902.1057417-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,

On Mon, 11 Sep 2023 12:28:59 -0500, Nishanth Menon wrote:
> bootph-all as phase tag was added to dt-schema
> (dtschema/schemas/bootph.yaml) to describe various node usage during
> boot phases with DT.
> 
> Based on next-20230911
> 
> Nishanth Menon (3):
>   arm64: dts: ti: k3-am64: Add phase tags marking
>   arm64: dts: ti: k3-am642-evm: Add boot phase tags marking
>   arm64: dts: ti: k3-am642-sk: Add boot phase tags marking
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am64: Add phase tags marking
      commit: 8d5bfa637f0f04a71166b9bde0ef022b08986296
[2/3] arm64: dts: ti: k3-am642-evm: Add boot phase tags marking
      commit: 33830e077797ce4d7317b83a145f03bfde06ad4c
[3/3] arm64: dts: ti: k3-am642-sk: Add boot phase tags marking
      commit: 4669288219a7f77c6ff992d10ce6a20660863979

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

