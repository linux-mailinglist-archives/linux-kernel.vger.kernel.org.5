Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D8279C987
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjILIOa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 04:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjILIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:14:16 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F67E78;
        Tue, 12 Sep 2023 01:14:12 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 01B8080BE;
        Tue, 12 Sep 2023 16:14:06 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Sep
 2023 16:14:06 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 12 Sep 2023 16:14:04 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-mmc@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v2 0/3] Change tuning implementation
Date:   Tue, 12 Sep 2023 16:13:59 +0800
Message-ID: <20230912081402.51477-4-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912081402.51477-1-william.qiu@starfivetech.com>
References: <20230912081402.51477-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series of patches changes the tuning implementation, from the
previous way of reading and writing system controller registers to
reading and writing UHS_REG_EXT register, thus optimizing the tuning
of obtaining delay-chain.

Changes v1->v2:
- Rebased to v6.6rc1.
- Keeped "starfive,sysreg" in dt-bindings but removed from required.
- Changed the function interface name.
- Maked the code implementation more concise.

The patch series is based on v6.6rc1.

William Qiu (3):
  dt-bindings: mmc: Remove properties from required
  mmc: starfive: Change tuning implementation
  riscv: dts: starfive: Drop unused properties and limit frquency

 .../bindings/mmc/starfive,jh7110-mmc.yaml     |   2 -
 .../jh7110-starfive-visionfive-2.dtsi         |   4 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |   2 -
 drivers/mmc/host/dw_mmc-starfive.c            | 137 +++++-------------
 4 files changed, 44 insertions(+), 101 deletions(-)

--
2.34.1

