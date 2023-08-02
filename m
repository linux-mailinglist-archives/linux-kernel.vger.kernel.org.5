Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B48576DA67
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjHBWFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjHBWFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:05:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2770B211F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691013876;
        bh=IyuQtdrcOrT2L9y8aZe6ItaRI/HFLInO7ui6Yh133S8=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=eUYgvGX9RXPlq85xDyWE5LbcIGZgRhrB40RsQPqL3eFgUmL2yux94n5vox0FCpZJ4
         +ZGxs2P+QcMbTj0ifU75P5f8HRExy1SmDZJbhfBVA3j2QM2bC2Dkqv94fEvaMpUuWr
         C5wCQf3+p2icJgkxxtmV6k0x75WOtgT8l/lDZ0b0=
X-QQ-mid: bizesmtp89t1691013827t3lhs1iz
Received: from TimeMachine.lan ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 06:03:33 +0800 (CST)
X-QQ-SSF: 01400000008000301000B00A0000000
X-QQ-FEAT: q+yjhizk/eI0E/AJXypCJ5+jUHPz2Jl9cX52hkDc0l5X4XJW9Z87Q2DngIJm5
        f1gpuwqdC7BpShAsFhFhv3sZm/mWCq8s712FcfUvwAGKwGRrK6XTkvNK56e9dCkNZgk/iHH
        Bts88aNx9hH3Op12Gq+PBX5e+YtVopjsXSlTdqXFV5ncVp1WNDZ2QBKPFco/1sGd1zjQ2Pw
        JCYMrYEmdBJm3UaL3ZV5gLM0jYHUhvMqe13Fcadz+fIsPAZPy8pAp02e90jJ6dV7c8XTCHJ
        et7nSOTSYYmAubxJUaGBP7JW1ucvxYqXCx384zNj0BoNGsfvFImz7vVTk89uRQCZ54lvUvw
        xAYdSo/Pfwjk9mucXCGxtGyTI1zf/NKewW4JxakzGnsvt4y1Qc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2213657009978695455
From:   Martin Botka <martin@biqu3d.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] dt-bindings: vendor-prefixes: Add BigTreeTech
Date:   Thu,  3 Aug 2023 00:02:34 +0200
Message-ID: <32C9B4A9A60647F1+20230802220309.163804-2-martin@biqu3d.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802220309.163804-1-martin@biqu3d.com>
References: <20230802220309.163804-1-martin@biqu3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Botka <martin.botka@somainline.org>

BigTreeTech is a company based in Shenzhen that makes
3D printers and accessories.

Add prefix for it.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index af60bf1a6664..1d5f86e3f099 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -194,6 +194,8 @@ patternProperties:
     description: Beckhoff Automation GmbH & Co. KG
   "^bitmain,.*":
     description: Bitmain Technologies
+  "^bigtreetech,.*":
+    description: Shenzhen BigTree Tech CO., LTD
   "^blutek,.*":
     description: BluTek Power
   "^boe,.*":
-- 
2.41.0

