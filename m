Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A74D772BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjHGQ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjHGQ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:57:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF441FD8;
        Mon,  7 Aug 2023 09:57:29 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377GvIxx076498;
        Mon, 7 Aug 2023 11:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691427438;
        bh=PF6aaZzeYeb6LziCrXgpvOBeW9cpHEe9HYKTB9xKaAY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WzhGnAR8aFFRIS554Z2ApjqthoD4poJKY+eZAmZoRaD0Bht78Hj8oDG12gh260WPG
         ueHT+FuhKQz7zAGSfkfJjI9YQlQPLbYnsFxw9JUb4gYKT3Nrd+t8GWKna9JGzE1d/U
         awULCkveHKw7Gasx1HQeZxNAHq7qZPLWqmyDglqM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377GvIpi020089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 11:57:18 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 11:57:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 11:57:17 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377GvHZL004565;
        Mon, 7 Aug 2023 11:57:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <t-konduru@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, Udit Kumar <u-kumar1@ti.com>
CC:     Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset for ospi
Date:   Mon, 7 Aug 2023 11:57:17 -0500
Message-ID: <169142733459.1014407.4083667899240359740.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230802114126.162445-1-u-kumar1@ti.com>
References: <20230802114126.162445-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Udit Kumar,

On Wed, 02 Aug 2023 17:11:26 +0530, Udit Kumar wrote:
> After splitting wkup_pmx pin mux for J784S4 into four regions.
> Pin mux offset for OSPI nodes were not updated to align with new
> regions, due to this while setting ospi pin muxes out of range
> error was seen.
> 
> Pin mux offsets for OSPI nodes are corrected in this patch.
> 
> [...]

As discussed in the chain, please send adc and any other fixes (including
those for sk-am69 as follow on patch series). In the future, I'd prefer
all the fixes to be put in a single series to avoid this kind of cherry-pick
fixing.

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset for ospi
      commit: f10f836ccfea21ae3ad3066eb9576625f1acdea2

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

