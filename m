Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C2779ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjHLKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbjHLKEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:04:01 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4162E26A0;
        Sat, 12 Aug 2023 03:04:01 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id C60F48406F;
        Sat, 12 Aug 2023 12:03:58 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH v2 0/4] clk: marvell: Move number of clocks to driver
 source
Date:   Sat, 12 Aug 2023 12:02:55 +0200
Message-Id: <20230812-mmp-nr-clks-v2-0-f9271bd7eaa5@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM9Y12QC/23MQQ7CIBCF4as0s3YMUK3UlfcwXQgdhLSFBgzRN
 Nxd7Nrl/5L3bZAoOkpwbTaIlF1ywdcQhwa0ffgnoRtrg2CiZZL1uCwr+oh6nhJetGR04h11ykB
 9rJGMe+/afahtXXqF+NnxzH/rfydzZHg2rR6VUrJX8pamMNPRRhhKKV/5NMhkpQAAAA==
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=cJRDswR60Gmq60WcoCzCVYt6uob84DCT479ZE1hE9II=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk11jVKQCc8SXUGxEtD639y/2mgmr2NmNH7gm/7
 DXjCTZA3a+JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNdY1QAKCRCaEZ6wQi2W
 4SseD/4hfBVKlj4oGiG+fcE8YDmZFgCsUxEoyrQGraYmb7D5hEUbxeRctcpOtfaKjjLM3nG2UxF
 RwVsuTueEmuo+4tEeIq/axikUxUhkQvBntxGmgZ5FbZ3jklhA+19qt1ufOPSDeNdOfykczMJ2zt
 ++xtk7M+vuUjmW20pHfilFIyx0owQhU8lopvzHSGPcJRYpvITxJUHgbbKlTBwKLUdjM5nNjtQic
 iSPuKDOIKOZnDQcqYFjP7VDDcwIcS8mdqD0MS/sVNZcieIvgV2Jj9XsQxz7zxbKDcTlETscqlpo
 0nNE6YbDaw1J/ztF9qRCL/fLNIknO0tHZqEZZlzS2SPqpJHBtg8Hr7LvBiKvtB/pzL6o8bb6Bhl
 gjBx5dayhq0pPX4T8K4wJP0IzmGS81SBKN26Y41MSfsDyjJ27A9lc9aEs/sx8KZWLycR5MUc0Rl
 sgCxDprhI1pOuGq3bfa2JQdEtY8u1dSaqGcxLAXLKUuWgZuV6encAENQtQHdkyaJupHGeRznEzY
 cVv3m8ao0mt9ieHu5rmUBbAgeDSWQG4DnfhOdJQ/QX8igk2ISXx2Oo25IImQWe8OGhG4Rej/OzD
 Ip2Ryd0vdU3owS0VIRQBI6nucQGghl6uK+ihZyo3VTI1uYu04etvlg+D6+3CUErJ91vGqZjhdti
 0yYKrL0LALPf8Qg==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In v4 of my PXA1908 series, Conor suggested that the NR_CLKS variables
in dt bindings should be moved to the respective driver source files
because these are not used by the device trees and so are needlessly
added to the ABI. This series does that for the rest of the Marvell
PXA/MMP SoCs.

Link: https://lore.kernel.org/r/20230808-produce-thievish-3ce1b86a114b@spud/
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v2:
- Fix clk-audio.c compile error
- Reword mmp2 commit to match other commits
- Link to v1: https://lore.kernel.org/r/20230809-mmp-nr-clks-v1-0-5f3cdbbb89b8@skole.hr

---
Duje Mihanović (4):
      clk: mmp2: Move number of clocks to driver source
      clk: pxa168: Move number of clocks to driver source
      clk: pxa1928: Move number of clocks to driver source
      clk: pxa910: Move number of clocks to driver source

 drivers/clk/mmp/clk-audio.c                    | 6 ++++--
 drivers/clk/mmp/clk-of-mmp2.c                  | 4 +++-
 drivers/clk/mmp/clk-of-pxa168.c                | 4 +++-
 drivers/clk/mmp/clk-of-pxa1928.c               | 7 +++++--
 drivers/clk/mmp/clk-of-pxa910.c                | 4 +++-
 include/dt-bindings/clock/marvell,mmp2-audio.h | 1 -
 include/dt-bindings/clock/marvell,mmp2.h       | 1 -
 include/dt-bindings/clock/marvell,pxa168.h     | 1 -
 include/dt-bindings/clock/marvell,pxa1928.h    | 3 ---
 include/dt-bindings/clock/marvell,pxa910.h     | 1 -
 10 files changed, 18 insertions(+), 14 deletions(-)
---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230809-mmp-nr-clks-7c80e416e6bf

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


