Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBED80C228
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjLKHls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKHlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:41:46 -0500
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8F7EB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:41:50 -0800 (PST)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3BB7fSEN057284;
        Mon, 11 Dec 2023 15:41:28 +0800 (+08)
        (envelope-from xinhu.wu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx07.spreadtrum.com [10.0.1.12])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SpYSL3PS5z2Pb2Zw;
        Mon, 11 Dec 2023 15:35:30 +0800 (CST)
Received: from zebjkernups01.spreadtrum.com (10.0.93.153) by
 shmbx07.spreadtrum.com (10.0.1.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 11 Dec 2023 15:41:26 +0800
From:   Xinhu Wu <xinhu.wu@unisoc.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <zhang.lyra@gmail.com>, <heikki.krogerus@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <xinhuwu.unisoc@gmail.com>, <zhiyong.liu@unisoc.com>,
        <peak.yang@unisoc.com>, <teng.zhang1@unisoc.com>,
        <bruce.chen@unisoc.com>, <surong.pang@unisoc.com>,
        <xingxing.luo@unisoc.com>, <xinhu.wu@unisoc.com>
Subject: [PATCH V2 0/2] usb: typec: sprd: Add Unisoc PMIC typec driver
Date:   Mon, 11 Dec 2023 15:41:18 +0800
Message-ID: <20231211074120.27958-1-xinhu.wu@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.153]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx07.spreadtrum.com (10.0.1.12)
X-MAIL: SHSQR01.spreadtrum.com 3BB7fSEN057284
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support typec driver on unisoc related pmic, using extcon mechanism framework
to notify client driver

change in V2
-Modify the commit message

Xinhu Wu (2):
  usb: typec: Support sprd_pmic_typec driver
  dt-bindings: usb: Add an Spreadtrum pmic typec yaml

 .../bindings/usb/sprd,pmic_typec.yaml         |  65 ++
 drivers/usb/typec/Kconfig                     |  11 +
 drivers/usb/typec/Makefile                    |   1 +
 drivers/usb/typec/sprd_pmic_typec.c           | 587 ++++++++++++++++++
 4 files changed, 664 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sprd,pmic_typec.yaml
 create mode 100644 drivers/usb/typec/sprd_pmic_typec.c

-- 
2.17.1

