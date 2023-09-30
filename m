Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E852B7B4052
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjI3MwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 08:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjI3MwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 08:52:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBE51A4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 05:52:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D39C433CD;
        Sat, 30 Sep 2023 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696078324;
        bh=0cXR+wjSxc3y0eRPOSPa5epHEc/W4j4DDvL7tCSFcHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REmv6J/ExFC/eGAjHAiMAIVg67CrBH31GFPnanZkKftD5wWdukAWx+UAjV0OtHQu1
         rXunINX7W15Rzcb5lR+QRcBRZ7pcFbZctii84zTu6GjrTZUu594QrJ2moVSBSnCc37
         my9zZcN2LSVReCLhxC4eMY6hvKC5kqRh1Tg/i36anJCfBggWdN/nAz+JvHgW2DX0w0
         njgOMh7nPiXoXJvHM/nAoEo0LpXBNuwgPLyS9+/9Pt1EiB2zuSkRPLi3urIEGkmO2m
         v+/50sD4iWUUyYGoRhAV6SwO7b3tpI4ZEAwrJmvuzH8KdgEW0rksWCxxxmIg2/0yyf
         r1VWlOi8eXAaQ==
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
Subject: [PATCH 3/5] dt-bindings: riscv: Add Milk-V Duo board compatibles
Date:   Sat, 30 Sep 2023 20:39:35 +0800
Message-Id: <20230930123937.1551-4-jszhang@kernel.org>
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

Document the compatible strings for the Milk-V Duo board[1] which uses
the SOPHGO CV1800B SoC[2].

Link: https://milkv.io/duo [1]
Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/riscv/sophgo.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
index 4e8fd3c6a6ff..6db241c9d00c 100644
--- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
+++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
@@ -18,6 +18,10 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - milkv,duo
+          - const: sophgo,cv1800b
       - items:
           - enum:
               - milkv,pioneer
-- 
2.40.1

