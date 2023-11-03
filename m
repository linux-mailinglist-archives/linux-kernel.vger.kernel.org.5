Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768E67DFF16
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjKCGPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKCGPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:15:48 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D51B2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:15:41 -0700 (PDT)
Received: from localhost.localdomain (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E281B201BF;
        Fri,  3 Nov 2023 14:15:38 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1698992139;
        bh=UrTbHIBuDGRrYkDPZsK7lRpnYMK3E56TRQ6kVp/EyZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JMtdd0T0P2ikWmfihcJb7TZYWjGjos/oKFYsVKErP6oYr9ryUwZBj1FmAHMZvOg5K
         /lLCvJwADNnbA6Qvi7Ml4lSiHyJqIHKVL8GjPW6qBdkmSyz7ws6OODms3Bugi9c9bd
         EvUjv8nvKmBnxP8z6Jg7vqcdPkVsSUTF2di+420m3rCNJX4ycft1f7Yy0xqwDRfrII
         EY//3q5nRw+uu3Hi36DTDKhmGKQ9gdwsA2jef7pJy159m02X8/tE+4W4C7cDcdrvb7
         gcrVKBHGx4HYZULDZfTGT1BzFc3h5NKGyyvPwUm8v2o3ykpdtz2fehzJ1sKQ7Ri9rb
         a/G36x83DzgPA==
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net
Cc:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@Huawei.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au
Subject: [PATCH 02/10] ipmi: kcs_bmc: Include spinlock.h
Date:   Fri,  3 Nov 2023 16:45:14 +1030
Message-Id: <20231103061522.1268637-3-andrew@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct kcs_bmc_device defines a spinlock member but the header in which
it is defined failed to include the spinlock header. In the spirit of
include-what-you-use, do what's necessary.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/char/ipmi/kcs_bmc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/kcs_bmc.h b/drivers/char/ipmi/kcs_bmc.h
index fa408b802c79..880d835fb90c 100644
--- a/drivers/char/ipmi/kcs_bmc.h
+++ b/drivers/char/ipmi/kcs_bmc.h
@@ -7,6 +7,7 @@
 #define __KCS_BMC_H__
 
 #include <linux/list.h>
+#include <linux/spinlock.h>
 
 #define KCS_BMC_EVENT_TYPE_OBE	BIT(0)
 #define KCS_BMC_EVENT_TYPE_IBF	BIT(1)
-- 
2.39.2

