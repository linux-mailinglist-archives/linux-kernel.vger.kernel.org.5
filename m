Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8227E93DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjKMBHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKMBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:07:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130B5D1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:07:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E3EC433C7;
        Mon, 13 Nov 2023 01:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699837653;
        bh=sOrImuVHq65cb4dbzAFQe06ipFaS43Ps0KtMNSiSL3k=;
        h=From:To:Cc:Subject:Date:From;
        b=K/EOtILU4kBTOHK7+AdCwY8JyGDr76XunsubN2vOGquSeXlCGQMjrQFf3+VkM8M4o
         PiK2sko+N34cPWapww8zBMNkefZtbnf0MHniQyP8eOPt19uwn+c2juEPbgySOSVStC
         Uh6M/jErqlDoFracJmQMdY6r3ZvVz1vpNG0HPNb61dMC6mkWS4w5WRMvh/alwf/ZwP
         JuMlUetTxVetL2WcWgtOfIHfH0JjZ0tbYRSgQosojcg0PQeAL6V0AwK3Kfg20bzozx
         SpS6HBQhKUVuv9XrQMFvonY4j41+AdpS+wXjmBICDpkTHCf6oyBSbKk4eEU0dV78Br
         5kai7HYXRn3mw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 0/4] riscv: sophgo: add reset support for cv1800b
Date:   Mon, 13 Nov 2023 08:54:59 +0800
Message-Id: <20231113005503.2423-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds reset controller support for sophgo cv1800b using
reset-simple driver.

Jisheng Zhang (4):
  dt-bindings: reset: Add binding for Sophgo CV1800B reset controller
  reset: Add reset controller support for Sophgo CV1800B SoC
  riscv: dts: sophgo: add reset dt node for cv1800b
  riscv: dts: sophgo: add reset phandle to all uart nodes

 .../bindings/reset/sophgo,cv1800b-reset.yaml  | 38 ++++++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 12 +++
 drivers/reset/Kconfig                         |  3 +-
 drivers/reset/reset-simple.c                  |  2 +
 .../dt-bindings/reset/sophgo,cv1800b-reset.h  | 96 +++++++++++++++++++
 5 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/reset/sophgo,cv1800b-reset.yaml
 create mode 100644 include/dt-bindings/reset/sophgo,cv1800b-reset.h

-- 
2.42.0

