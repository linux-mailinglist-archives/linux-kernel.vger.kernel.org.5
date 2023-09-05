Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A017792AC5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjIEQmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354447AbjIELoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:44:55 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC441AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693914285;
        bh=gJzNLpQ6Up0eFCMZC22QBRZeBn/joseX3LEw2biCIDk=;
        h=From:To:Cc:Subject:Date;
        b=MmBA5gvdO0wXfnIojwt2IXd8wkxMbBkl0wP3BZAHsPWrT+oOCjjv8i+5/IR5+tUNL
         fG2/S9rjMEXV0CjXPxQi6Y+JG5uuuxOq3vkLZvKn3mP+ZFonV4B+EKdmZ7B2RBUUiX
         OxZ7Wmx5bUWzsJFcos03rvgFdv0fGt7thHBMemyk=
Received: from localhost ([101.224.150.13])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id A4C38235; Tue, 05 Sep 2023 19:41:12 +0800
X-QQ-mid: xmsmtpt1693914072tejdfe73l
Message-ID: <tencent_E54C7156F583E15FFE320E576E3389C39A08@qq.com>
X-QQ-XMAILINFO: MBjwNRQMz5zUp8kpJGiDTwbPE48m8as6nqWjNMjhV/lnfBk6Wc92PQxtfAVFLu
         9wb88I75s4YndDuQCD1Oeb9zLyAMD4cofOle46lEQ+sjTZT5nNK4rFQnGFMw6XKZ2dBd/mSQxcWK
         Y1okX2Ls48MqMODOn4ZpZsPbN2cVwAZfwtV4lb/JLumeP0Y0UCy0gWObesV+ofAd6fwIoYdc4gk2
         vVbY0/iFWVjS1iXiFkRiG660t1EE3OPZEdTUvCtw3oMWc+MnOtqdJTLVt5eVaZuYJVF+yrtiG2ZP
         c7r8zRKSfkxr7M3EGZvCY80huThYs8912UlApYSSOWcPSoHz+IkG7mjUMZ3FdaCykVBHDPhKzG9+
         882Oagtf9C16Bn/Jod0fvdO6Z4BgIwiK8eA0kILgONdDsm5cDPlpf8VjMbc5OVqKTQwYcEsTbYPv
         RZG5G2di5jaZoNmg9f6pqy6n2L2ICignYksoRyvcm1EMygR+y2whvpPzHZkbQbcIy8Vb42VZDVn5
         w4FhfHxG787tuHRyLX9OJKUQlLDH+1CCIb50s2HfVOS5OZ49/tKgugD5V1Pq/zARN5PUaCRVTrdt
         8DmV5P9D29kfyperIhI7FszzPd5N/H4K9OMj+PCaAWu7MdnsfN0AljN/gbiSBi82BZ2TE2HLL2yg
         +J7nsXiFtJGjEsdQcRaKfqz+d/VaXqrrD9IQDp0meMwu8pBza1b3DgqqulI82aqGoGqANTfmkrFn
         sG07zUbWaILggoyPnfhjjj9a/qppIl4eCl9KVSyITWPkDA5O9ARhzi/7/sFV+StaSBqJS1U1TB04
         fg1wH3bRtelzc7+UP4L6dFY64z2aoa+HiMDxBtXT0MNpk92smpfqcq08h8kPRzQE1lzLvJ4qjaDy
         M6yJAo2NGxnDG8Z1r05mIxDrjFJmWaI4TIKIJkxCf8ag6FymZjr5n+Sq1VgX72bEQu41pix7o+PQ
         XaAYPeI+bxXWmMH3TsQgbehHJ+NPU4gr/ftoRugd4=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From:   Woody Zhang <woodylab@foxmail.com>
To:     Lee Jones <lee@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, Woody Zhang <woodylab@foxmail.com>
Subject: [PATCH] mfd: cs42l43: Fix Kconfig dependency
Date:   Tue,  5 Sep 2023 19:41:00 +0800
X-OQ-MSGID: <20230905114100.1889986-1-woodylab@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD_CS42L43 depends on REGMAP_IRQ as it uses devm_regmap_add_irq_chip.
Otherwise the build may fail with following log.

  AR      drivers/built-in.a
  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  MODPOST Module.symvers
ERROR: modpost: "devm_regmap_add_irq_chip" [drivers/mfd/cs42l43.ko] undefined!

Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
Signed-off-by: Woody Zhang <woodylab@foxmail.com>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index aea95745c73f..90ce58fd629e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -241,6 +241,7 @@ config MFD_CS42L43
 	tristate
 	select MFD_CORE
 	select REGMAP
+	select REGMAP_IRQ
 
 config MFD_CS42L43_I2C
 	tristate "Cirrus Logic CS42L43 (I2C)"
-- 
2.39.2

