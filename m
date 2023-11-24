Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2687F6A66
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjKXCCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjKXCCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:02:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E13D7E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:02:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670D7C433C8;
        Fri, 24 Nov 2023 02:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700791364;
        bh=drr8cXKrF5OD9PCoerAcJq+7HVp0o9GWJzjGqXuSa0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFpJGdWUmKdA9n3xca5vSrGJX8BPR0hs+/8k/qGWeW2sK41n/GORNaCGPg8ZaOUhJ
         OMUYoBeouIM0XEp/J7GnOqjdB9kSa1eJieBxbdlHxEYbc731SYb0b6TpmiQzDqV6sv
         hA11DrVekKz8Ct9Wu+/AM4yRWzooFheBgmWeOu8CLTJNgjN9zWPeeBZZjv+qYkUHVT
         +DT1Wr1qYurobhyFC2TzClkmDPYs/Ay3Roqqf37P7HoGVx1DF59pNfOBWbQbE1ct5K
         sFKFjza0oln0Uh4JOw7dVJuWcT+ROmrEnNkY6zTpuVu3bZowwTld8wfPuzE0+MOVE9
         sflXqRbKCeMnA==
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
Subject: [PATCH v6 1/8] tpm: Remove unused tpm_buf_tag()
Date:   Fri, 24 Nov 2023 04:02:30 +0200
Message-ID: <20231124020237.27116-2-jarkko@kernel.org>
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

The helper function has no call sites. Thus, remove it.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v1 [2023-11-21]: A new patch.
---
 include/linux/tpm.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4ee9d13749ad..6588ca87cf93 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -358,13 +358,6 @@ static inline u32 tpm_buf_length(struct tpm_buf *buf)
 	return be32_to_cpu(head->length);
 }
 
-static inline u16 tpm_buf_tag(struct tpm_buf *buf)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	return be16_to_cpu(head->tag);
-}
-
 static inline void tpm_buf_append(struct tpm_buf *buf,
 				  const unsigned char *new_data,
 				  unsigned int new_len)
-- 
2.43.0

