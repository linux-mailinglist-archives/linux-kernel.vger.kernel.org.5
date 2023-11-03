Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4AB7DFF1F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjKCGPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjKCGPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:15:48 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710901AD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:15:40 -0700 (PDT)
Received: from localhost.localdomain (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2EEB6201BD;
        Fri,  3 Nov 2023 14:15:38 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1698992138;
        bh=AMOQEb03XmNyI60tnL3U2zDrGzgwc0hBeKG41n8Z2ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jtjV3TZLPzvN1w4uR+fgbdz1AEMsgGnTq4P6RHyjkA4Zt4Y8ax1EROo73dfq2HmCn
         6km6mjpDeLUeQkt4Umlt9SO1SEvc6KeAVIZ55upcRfl+Q2MkNozRkMn9yKVbq0djBi
         wUmkcYb+bxTqNFnlLngWXRB0qVR2Ym0rwoQsPtPvW01ucSshJZdJx3qokNg3XkLSo9
         F6FNbXzsO3dVuBuw+jiJCk6s+Hh+evqDvAF3mVfUT26mYeMyFp/Cu1IcHbsF3ikuYT
         JeVqO5FI3+7FoQlAZuoQZ20pbzv+DS8V0IFwoJXgPY2JP2sLVqbevUSE0u3BTLCsEY
         OrMUwmbzBIE8A==
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net
Cc:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@Huawei.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au
Subject: [PATCH 01/10] ipmi: kcs_bmc: Update module description
Date:   Fri,  3 Nov 2023 16:45:13 +1030
Message-Id: <20231103061522.1268637-2-andrew@codeconstruct.com.au>
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

KCS devices are often used for IPMI, but they're not constrained to it.
Update the subsystem module description to reflect its more general
capabilities.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/char/ipmi/kcs_bmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index 8b1161d5194a..a429d9f8a7bf 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -187,4 +187,4 @@ EXPORT_SYMBOL(kcs_bmc_update_event_mask);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
 MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
-MODULE_DESCRIPTION("KCS BMC to handle the IPMI request from system software");
+MODULE_DESCRIPTION("Subsystem for BMCs to communicate via KCS devices");
-- 
2.39.2

