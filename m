Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DAF761201
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjGYK6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjGYK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:57:16 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC4D4495
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:54:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36PArsjR094474;
        Tue, 25 Jul 2023 05:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690282434;
        bh=TaDwBHLNvfwwZjJOj/G6LN7uCappV8eNoEELIULmEfo=;
        h=From:To:CC:Subject:Date;
        b=TZ0kn/swmg3/+LJUy8luQ50siH6ksRuY3VUMPfpJQHfZ611LY66XedSMZTsswzm+H
         Zcx5nMVJql+f6aRimL7yP17VoN+yoYa5lUIMbbNF21TcuprJp/10ml7hSFSToMGz+3
         4ZixwnQPPqJYhzwuNueCi7CspLm+ZBh8foY8W3aA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36PArrEq006840
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 05:53:54 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 05:53:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 05:53:53 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36PArnkT091635;
        Tue, 25 Jul 2023 05:53:49 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <onrad.dybcio@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>, <john.garry@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 0/7] arm64: defconfig: Enable various configs for TI platforms
Date:   Tue, 25 Jul 2023 16:23:39 +0530
Message-ID: <20230725105346.1981285-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This patch series enables various config options needed by TI Platform.

bloat-o-meter reports after this change
add/remove: 4/0 grow/shrink: 2/0 up/down: 1592/0 (1592)
[...]
Total: Before=27997071, After=27998663, chg +0.01%



Aradhya Bhatia (1):
  arm64: defconfig: Enable PWM drivers for TI ECAP

Hari Nagalla (1):
  arm64: defconfig: enable TI OMAP2 mailbox and K3 remote proc drivers

Jayesh Choudhary (1):
  arm64: defconfig: Enable SND_SOC_J721E_EVM for audio support

Judith Mendez (1):
  arm64: defconfig: Enable MCAN driver

MD Danish Anwar (1):
  arm64: defconfig: Enable DP83869 Driver

Udit Kumar (2):
  arm64: defconfig: Enable UFS config
  arm64: defconfig: Enable K3 RTI Watchdog

 arch/arm64/configs/defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.34.1

