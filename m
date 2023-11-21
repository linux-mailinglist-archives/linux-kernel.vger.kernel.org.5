Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203DC7F270B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjKUIQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKUIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:16:35 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C126AC3;
        Tue, 21 Nov 2023 00:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/RxgG
        ssmueIYxvcnniPKhkRyiQduoQOk4uIl6MFF1y8=; b=fvGsGHgdIWES8p59y9MW+
        Pxn5R8UQlPpqT+kLweZ4eXyyKhhfMUv2G5wOjU32bYkRpjHxW6NvI5Hjsh7KKz6z
        WmEmdy4Mq0D3kSGs6WcaRgT8ImJokCI9zPusPKBl432dIAdujGiGwMNQL5veP71P
        IWbr3ruIN5VkQxfYcuWsM0=
Received: from localhost.localdomain (unknown [39.144.137.247])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wAn9ctEZ1xlUJ6BDg--.31532S2;
        Tue, 21 Nov 2023 16:16:05 +0800 (CST)
From:   Xing Tong Wu <xingtong_wu@163.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xingtong.wu@siemens.com, tobias.schaffner@siemens.com,
        gerd.haeussler.ext@siemens.com
Subject: [PATCH v3 0/2] hwmon: (nct6775) Fix pwm bugs for NCT chips
Date:   Tue, 21 Nov 2023 16:16:02 +0800
Message-Id: <20231121081604.2499-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAn9ctEZ1xlUJ6BDg--.31532S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWrZrW3CFy7KFW8Zw47Jwb_yoWxCFb_Wr
        4IqrWxWw4qqasIka4a9Fn2v342kFWUur4UAr95trZxAw1fZrZ8uF4vvry2gr17Za10kFyf
        ur1kJFyfA342kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0tUUUUUUUU==
X-Originating-IP: [39.144.137.247]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiFgUv0F44X7XFXQAAs4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xing Tong Wu <xingtong.wu@siemens.com>

These patches address bugs in the pwm features that do not meet the
specification definition.

changes since v2:
 - Update commit message for 1/2 patch
 - Extend 6106 arrays and remove 6116 arrays for PWM.

changes since v1:
 - Add PWM mode and mask register arrays for NCT6116
 - Delete 2nd patch for pwm_enable change
 - Delete log print and add comment for pwm failure set

Xing Tong Wu (2):
  hwmon: (nct6775) Add support for 2 additional fan controls
  hwmon: (nct6775) Fix fan speed set failure in automatic mode

 drivers/hwmon/nct6775-core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.25.1

