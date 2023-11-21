Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EBA7F37F2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjKUVRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKUVRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:17:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5FADD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:17:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E2AC433C7;
        Tue, 21 Nov 2023 21:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700601447;
        bh=Y56AO+jdgKKv2wjrPycIECDNz6SB1qKX+7if35pK/Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQ4e5epJyW3aR5whtW4leKfPnGJnYCPiNISJ0YfMzDZYILtpkdWM/bUxRq3v0smjr
         En0oDQo97bauZH0FKctmxBrd5mccn+S6CzWteM6PJL45PMJmBwJz65T9VfttVRyKaA
         qqEwIwysk3C1eSJbDEpt8Q+x+K7DwT8Z5Y1Tm62CspgOe9CJ0CiCdEdrEdpEpdqbrV
         V/DoDaX6zxqxxeta1p4d13NtHWoqEx5QnivPxsjmD1TvEVx+kGVXn+ZpPafm4quoJN
         w9lDAeWofVjEtpAPo6x7gIrSuXIoBHA//a/MULYRxX4uPOWjIP2nbLHW3GW01YSUpS
         QAue6S8eB3OHA==
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
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Julien Gomes <julien@arista.com>
Subject: [PATCH v4 1/8] tpm: Remove unused tpm_buf_tag()
Date:   Tue, 21 Nov 2023 23:17:10 +0200
Message-ID: <20231121211717.31681-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121211717.31681-1-jarkko@kernel.org>
References: <20231121211717.31681-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.42.1

