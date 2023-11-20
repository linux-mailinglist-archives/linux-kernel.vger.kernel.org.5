Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E287F0D47
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjKTIQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTIQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:16:23 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CFCCE5;
        Mon, 20 Nov 2023 00:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZgGtt
        8Vwx6KY+WLiRd8mNkVCUwdJFjtTfHpwI5Ps2aI=; b=CjQY12NBqUnQVagIuGS1W
        y4GFRYUuBfZaCMhUpcVkhG/8P+vVi8ykOH1WGrP3bbSnsJOdPIuRH1CDlyJV7bO1
        rJDUykT485qPLbc09PW85S+AWAY2X5fbfigwTslg5LE8ra9Wak88U2m5K3t1pvBM
        3F5lccLjmcD1mmy69/bglw=
Received: from localhost.localdomain (unknown [39.144.137.207])
        by zwqz-smtp-mta-g3-2 (Coremail) with SMTP id _____wDH52myFVtlTcE1Dg--.30221S2;
        Mon, 20 Nov 2023 16:15:47 +0800 (CST)
From:   Xing Tong Wu <xingtong_wu@163.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xingtong.wu@siemens.com, tobias.schaffner@siemens.com,
        gerd.haeussler.ext@siemens.com
Subject: [PATCH v2 0/2] hwmon: (nct6775) Fix pwm bugs for NCT chips
Date:   Mon, 20 Nov 2023 16:15:40 +0800
Message-Id: <20231120081542.3174-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDH52myFVtlTcE1Dg--.30221S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVsXoUUUUU
X-Originating-IP: [39.144.137.207]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiFhUu0F44X5n24gABsI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xing Tong Wu <xingtong.wu@siemens.com>

These patches address bugs in the pwm features that do not meet the
specification definition.

changes since v1:
 - Add PWM mode and mask register arrays for NCT6116
 - Delete 2nd patch for pwm_enable change
 - Delete log print and add comment for pwm failure set

Xing Tong Wu (2):
  hwmon: (nct6775) Fix incomplete register array
  hwmon: (nct6775) Fix fan speed set failure in automatic mode

 drivers/hwmon/nct6775-core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.25.1

