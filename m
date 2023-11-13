Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680BA7E93E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjKMBJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKMBJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:09:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE08D1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:09:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514F7C433C8;
        Mon, 13 Nov 2023 01:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699837762;
        bh=NWIlzFEgg2A3+SpkYxmsGisYK5SmdcnCfOPvo5IDKK8=;
        h=From:To:Cc:Subject:Date:From;
        b=PMq3rYRZJrQbhLBj0X7qQDeo5yg0CezYYjpfZRMrnxhUFb9ku/AgdcENPQSUJoY40
         A1Fmg2/M2FooliyANBTSfsMsXAcww1LNdwTkno680bvuvDhzfhCTwTfi223qqhN6PQ
         oXMN3GC4sOfSPfLZWocDw0RjZYr1PQ+82yZGeAz+gievaNco5TfNvbGnZHR80lMmBk
         pDwAeS+w+TPD/ILgA1auQ6UbjiW5XuA2nXVC9JGK7sPxt1pHxS+Dq26L/OcnZcWscf
         EgiH+mp/3nO8PPPCaZRwb4vJTD4lK4+4gA1BITRgjEc448aZB488XxJrMF4emnIBvM
         Cla/YDhGteDaA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 0/2] riscv: sophgo: add pinctrl support for cv1800b
Date:   Mon, 13 Nov 2023 08:57:00 +0800
Message-Id: <20231113005702.2467-1-jszhang@kernel.org>
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

This series adds pinctrl support for cv1800b reusing the
pinctrl-single driver.

Jisheng Zhang (2):
  riscv: dts: cv1800b: add pinctrl node for cv1800b
  riscv: dts: sophgo: set pinctrl for uart0

 arch/riscv/boot/dts/sophgo/cv-pinctrl.h       | 19 +++++++++++++++++++
 .../boot/dts/sophgo/cv1800b-milkv-duo.dts     | 11 +++++++++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 10 ++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv-pinctrl.h

-- 
2.42.0

