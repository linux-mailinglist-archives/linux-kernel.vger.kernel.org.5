Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F768761654
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjGYLiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjGYLiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:38:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4111BCF;
        Tue, 25 Jul 2023 04:38:12 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36PBc4md129919;
        Tue, 25 Jul 2023 06:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690285084;
        bh=U0wNK9usvynmIcSy2bNot6lVmF92EKBTxhWZKbiDj80=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EwH7cmEkOEKfnIGcUjqAnSNlcfEr5tpntNP8LM2rA0aG47oUoRz8vJ5RTLdAh6rc8
         95Tbq6//dm5OimwY+ZZISNG7Jv1biHl7KoLZ0EEo4BzSeWoZ38YWg+5wIQaZu+jGba
         88X0DViGUNf8WjaiSRJ03pcuATIDEdtLC0xcJJr4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36PBc4pS002263
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 06:38:04 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 06:38:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 06:38:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36PBc4Lo129550;
        Tue, 25 Jul 2023 06:38:04 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <peda@axentia.se>, <rogerq@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Deprecate ti-serdes header file
Date:   Tue, 25 Jul 2023 06:38:03 -0500
Message-ID: <169028506508.1718716.4077417084454860962.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230721125732.122421-1-j-choudhary@ti.com>
References: <20230721125732.122421-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Hi Jayesh Choudhary,

On Fri, 21 Jul 2023 18:27:30 +0530, Jayesh Choudhary wrote:
> This series moves the ti-serdes.h header to arch/arm64/boot/dts/ti/
> as these constants do not have driver usage and are not suitable for
> bindings as discussed in [1].
> 
> Deprecating the bindings header for now instead of dropping them based
> on the discussion in [2].
> We expect to remove this bindings header in the next cycle.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: Use local header for SERDES MUX idle-state values
      commit: 8d08d7aac7f620b5d298fad0ba0e6e431ea132a9
[2/2] dt-bindings: ti-serdes-mux: Deprecate header with constants
      commit: 5438d75fb9d7bb863ddc5ef28b242ca50c9879ff

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

