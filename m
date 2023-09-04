Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A589791AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbjIDP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347580AbjIDP5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:57:14 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC8ECE2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:57:09 -0700 (PDT)
Received: from v0.lan (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id AAA411F8A1;
        Mon,  4 Sep 2023 17:57:04 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Subject: [PATCH 0/6] cpufreq for H616
Date:   Mon, 04 Sep 2023 17:57:00 +0200
Message-Id: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEz+9WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyMT3eSC0rSi1ELdDDNDM10DY3ODlDTTxNREYxMloJaCotS0zAqwcdG
 xtbUAEKOQaV4AAAA=
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin@biqu3d.com>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693843024; l=1631;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=U/3GSrY/Da5OP4VIOMN9GgEPvGCUXEMC8rHSLoKA2Rw=;
 b=MtvEf/mtaOylRcOzTcUjowCffBGTFqT6Srlp77NJ9QYCFml/mSDTBkShMH7IpjvA6TZsxu7K+
 RVNodzZtuxfBZ3LhwAyAp68ANZQnuFvystXI1eMcjZPUvCL16DzlGJw
X-Developer-Key: i=martin.botka@somainline.org; a=ed25519;
 pk=aTCd3jmwU8GrJidWg3DSKLpdVMcpFzXzCSLXLR6NtWU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds support for cpufreq on H616 SoC.

H616 is bit interesting. It has SoC versions that have different
frequencies and uV but some versions have the same version ID and
we have to check the SoC revision to differentiate between them.

This is done via SMCCC. Thus the exporting of the symbol.

Please note that this series depends on my THS series which
depends on my SID series.

I also have not enabled the cpufreq on any devices to minimize
the series dependencies and I did test it only on CB1 where
it works.

Cheers,
Martin

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
Martin Botka (6):
      firmware: smccc: Export revision soc_id function
      cpufreq: dt-platdev: Blocklist allwinner,h616 SoC
      dt-bindings: opp: Add compatible for H616
      cpufreq: sun50i: Add H616 support
      arm64: dts: allwinner: h616: Add CPU Operating Performance Points table
      arm64: dts: allwinner: h616: Add cooling cells

 .../opp/allwinner,sun50i-h6-operating-points.yaml  |   6 +-
 .../boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 129 ++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     |   8 ++
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             | 149 +++++++++++++++++----
 drivers/firmware/smccc/smccc.c                     |   1 +
 6 files changed, 270 insertions(+), 24 deletions(-)
---
base-commit: a384547b9656aa2c98f643037b0e940476c41f51
change-id: 20230824-cpufreq-h616-0370df5aea34

Best regards,
-- 
Martin Botka <martin.botka@somainline.org>

