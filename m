Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26757F6A79
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjKXCDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjKXCCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:02:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E2A171E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:02:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA6FC433C8;
        Fri, 24 Nov 2023 02:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700791374;
        bh=gORzZnTnBE2H3oHce9S3/9lGlc/hZRFZ0MDxFGFZxTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1rX6Y/qnWHG7DB8DhMf+Oo6R83MLcYs5VO8KN29H1f0Uno04N+VG8nWMYbLrOrM9
         54L5a/kFUw3OX1GkLd+pYmXX8puiHLJP3k5e1+LA2x35G7Qukcc9SYCnagVaR17CYu
         pHrfN2Mw+MrG78Iozu7C4tYfBxgmz11+rI3iB7aHPk3lCHVv1AQ0F7XdEH2ObXbhkd
         /ASdym8QobCwuqXiUaeSQfh/5K2HJBn5ttlE4Puh9X1TtTQG2d3spuGB7OfIOBv3pH
         U3MJ0AFdGXS0fCNTi+7S34YRf7QxWXD/n2emLIaB0OolgbahX2jOzPBFQhZMkQh09r
         Y3jC5GHTQH3nw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v6 4/8] tpm: Update struct tpm_buf documentation comments
Date:   Fri, 24 Nov 2023 04:02:33 +0200
Message-ID: <20231124020237.27116-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124020237.27116-1-jarkko@kernel.org>
References: <20231124020237.27116-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove deprecated portions and document enum values.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v1 [2023-11-21]: A new patch.
v2 [2023-11-24]: Refined the commit message a bit.
---
 include/linux/tpm.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index bb0e8718a432..0a8c1351adc2 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -297,15 +297,14 @@ struct tpm_header {
 	};
 } __packed;
 
-/* A string buffer type for constructing TPM commands. This is based on the
- * ideas of string buffer code in security/keys/trusted.h but is heap based
- * in order to keep the stack usage minimal.
- */
-
 enum tpm_buf_flags {
+	/* the capacity exceeded: */
 	TPM_BUF_OVERFLOW	= BIT(0),
 };
 
+/*
+ * A string buffer type for constructing TPM commands.
+ */
 struct tpm_buf {
 	unsigned int flags;
 	u8 *data;
-- 
2.43.0

