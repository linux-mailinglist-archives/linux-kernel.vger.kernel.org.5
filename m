Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EDC7B4051
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 14:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjI3MwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 08:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjI3MwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 08:52:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F29F1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 05:52:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FA9C433CB;
        Sat, 30 Sep 2023 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696078320;
        bh=fQTDtT9gnWgXUs+I9buDYmY6imSxTfJ5hIWH/nKngUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgjrlymuo0WltimOMkmuXz4oV1+bt9qfmo/hhNyXcikzu7EaGa4n/wgk3XwktQTCN
         SknjOXRlAENSX/2931edHNrX93SFp8kSZSAgBS2Dfq84VmxdmnkC7iRdLNHn4QGjGr
         OnYippK2hUgXFApgGby73dVAgX1a+T23DLZqgVtaXipteIfRBzCKt3J14h9489ZnoU
         hY/wC7LmF8I4YrvI+8jU4R8I/pZNKq1Da7by1qheFDABExAZ5YRBgwehNtZZMBWYIM
         e4Ds4ctkJIgdnzipElalZr0Dd+g8izrTw3U4STXCsLch6LaF2TbCL0tu50+Yr3dHQE
         +2qkDcwE9i8tg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
Subject: [PATCH 2/5] dt-bindings: timer: Add SOPHGO CV1800B clint
Date:   Sat, 30 Sep 2023 20:39:34 +0800
Message-Id: <20230930123937.1551-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230930123937.1551-1-jszhang@kernel.org>
References: <20230930123937.1551-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for the SOPHGO CV1800B clint.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index a0185e15a42f..98c76d5893ac 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -37,6 +37,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-clint
+              - sophgo,cv1800-clint
               - thead,th1520-clint
           - const: thead,c900-clint
       - items:
-- 
2.40.1

