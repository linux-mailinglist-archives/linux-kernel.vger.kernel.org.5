Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81595775EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjHIMTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjHIMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:19:31 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE922108;
        Wed,  9 Aug 2023 05:19:29 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 02D7082827;
        Wed,  9 Aug 2023 14:19:17 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH 0/4] clk: marvell: Move number of clocks into driver source
Date:   Wed, 09 Aug 2023 14:18:18 +0200
Message-Id: <20230809-mmp-nr-clks-v1-0-5f3cdbbb89b8@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAqE02QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNL3dzcAt28It3knOxiXfNkC4NUE0OzVLOkNCWgjoKi1LTMCrBp0bG
 1tQDFf6WaXQAAAA==
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=L3KKPBYjCYq83GGRGZysh9jgh6zofLjtE79BkG62VaY=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk04QN9z1ef4YX3+Gt8rOsKgNgzLUpl+KqLOWv3
 H4hiJDRmWSJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNOEDQAKCRCaEZ6wQi2W
 4W4qD/9rfquFcCOqU9h47Drec9rkZzDlYlewgusX3dS3sWVKectBSdaLG3JuXZ44Nb3uYxhOUm5
 fulplq5+o0Of6/zGXEYjIHkvIpD7QNyQZOnBTsDy46GhlvNDpcxe5iwBnGjWVX/SN8sK4OKnPgN
 2Q7ZzseU0JckSIdU5m5C+0+qr+2FRzuENSkHbgKcLorZbsL1dpgHmzkd+DDyRUHQsWtXIeJqz06
 Ydu0t2HMB0CgNJwtSBHhVRjjJ0XHJ2ca+p/pg8pfOKpX+M1EGaqJBxbs61re6FtIlWu54fa/2bF
 +vr8eBqApMoXZ4GtuD47nMLOijyuWinLiOx1SBSCeVRCBMLOowBD+DPn2cM8r18F5XXeBsnji6k
 lgnaCmznADwVaoCDVD10S+0UQLFjTxor05ozygqJMTDewajy6a9X45rMK7qWiBIH6PEmW/F6ni8
 xXCKETAac3McjQOG2A4JEMVJXDFWOCc8Xur3tb39MyME+6hfPHG5SwoFL+IU7utMdxPofju+l6b
 TzbLr5ahqC7YXjJc0Iwd3iRNbJdL4sLJsHdGUA1d4fBwkvO77Bmc035xbpoQCM5OL1yUypaadqJ
 x8jKbN51N+GbGTz8nZbGgWyW/L+ggmceoLLd2CoURjSyjoWx22UT6G+9k4wkvNsqPD/Hz9rSeA4
 rpGPzzAOb57z6mw==
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
Duje Mihanović (4):
      clk: mmp2: Move number of clocks into driver source
      clk: pxa168: Move number of clocks to driver source
      clk: pxa1928: Move number of clocks to driver source
      clk: pxa910: Move number of clocks to driver source

 drivers/clk/mmp/clk-audio.c                    | 4 +++-
 drivers/clk/mmp/clk-of-mmp2.c                  | 4 +++-
 drivers/clk/mmp/clk-of-pxa168.c                | 4 +++-
 drivers/clk/mmp/clk-of-pxa1928.c               | 7 +++++--
 drivers/clk/mmp/clk-of-pxa910.c                | 4 +++-
 include/dt-bindings/clock/marvell,mmp2-audio.h | 1 -
 include/dt-bindings/clock/marvell,mmp2.h       | 1 -
 include/dt-bindings/clock/marvell,pxa168.h     | 1 -
 include/dt-bindings/clock/marvell,pxa1928.h    | 3 ---
 include/dt-bindings/clock/marvell,pxa910.h     | 1 -
 10 files changed, 17 insertions(+), 13 deletions(-)
---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230809-mmp-nr-clks-7c80e416e6bf

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


