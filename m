Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8352D7718DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjHGDwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjHGDwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:52:21 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B488310FD;
        Sun,  6 Aug 2023 20:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TA8ZO
        F4Cd3S6yJAnesaFglbxk/2g0jy6+FsK1Jy8oAU=; b=DN0WdONdJKeH/0PWvSYTf
        7t9nyLlxYR5eLbYhSWu7b8ddlT8X+/VTA19PgBRdetXZamJeGh9FQ1tBEkl8O3sc
        THYvNU5g98DvFnSVuP8iaQP7FO+lJn4LAq1RuzhJZArQooDabWV3gkaq6JHmkv0y
        oTYW75w8CLYtvkUovE5eSo=
Received: from localhost.localdomain (unknown [39.144.137.13])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wAnC8nLZtBkztfiCQ--.36380S2;
        Mon, 07 Aug 2023 11:36:45 +0800 (CST)
From:   xingtong_wu@163.com
To:     ilpo.jarvinen@linux.intel.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, xingtong.wu@siemens.com,
        lee@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, gerd.haeussler.ext@siemens.com,
        tobias.schaffner@siemens.com, lkp@intel.com
Subject: [PATCH v2 0/2] fix logic errors in BX-59A
Date:   Sat,  1 Aug 2043 01:30:25 +0800
Message-Id: <20430731173026.2631-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7196d4b9-34fe-4a18-863b-65d07c4a348c@linux.intel.com>
References: <7196d4b9-34fe-4a18-863b-65d07c4a348c@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnC8nLZtBkztfiCQ--.36380S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU6Ma0UUUUU
X-Originating-IP: [39.144.137.13]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbBEA-E0GNfugXwNQAAsN
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS,T_DATE_IN_FUTURE_Q_PLUS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xingtong.wu" <xingtong.wu@siemens.com>

change since v1:
 - Improve the changelog to make things clear

These are rather simple patches fixing logic errors in Siemens
IPC drivers.

xingtong.wu (2):
  platform/x86/siemens: simatic-ipc: fix logic error in BX-59A
  platform/x86/siemens: simatic-ipc-batt: fix logic error for BX-59A

 drivers/platform/x86/siemens/simatic-ipc-batt.c | 3 ++-
 drivers/platform/x86/siemens/simatic-ipc.c      | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.25.1

