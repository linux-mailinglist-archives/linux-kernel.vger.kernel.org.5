Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40758771639
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjHFRJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 13:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjHFRJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 13:09:06 -0400
Received: from rs227.mailgun.us (rs227.mailgun.us [209.61.151.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65A21BD1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 10:08:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1691341722; x=1691348922; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=PYLdD6KHPs84hwcZPrlzS2LVaOnFTzTv2n62BLHJ5zA=;
 b=gXq98kSV6f8EAU5y67KjH8b23/VynQzuYOOyN37Uk7qGr6NxvOhSsJEghZQZzOqNBNuglHVCZG0Xwf7t8RsJ3KQ0YYC4wkvjPD3i3tVwxlZSFI7Gv2bGwVMwa/a/WBaO9b733+1gdx9iHVUlqUciCeRSj7zheDJOzB3IZa2oplckX8pDh1337eA4aUyaEYH1fErZKDyzWWOHlDqMOZ8CQlOpfeUzMRzAxywdlkN2smLwY7MG69c/MGCklkHyXJNukSKHaNmu/1VojNTFU9fH1gkvKUpHpDXhH0J+zqRzx99D2iuPMeKEqan3JfZQlZMDpJMSoPSqMzyeLVPOaS05/Q==
X-Mailgun-Sending-Ip: 209.61.151.227
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 1df4b02de713 with SMTP id
 64cfd39a7c3063b7c0fa4d53 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 06 Aug 2023 17:08:42 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     James Seo <james@equiv.tech>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/12] scsi: mpt3sas: Fix an outdated comment
Date:   Sun,  6 Aug 2023 10:06:01 -0700
Message-Id: <20230806170604.16143-10-james@equiv.tech>
In-Reply-To: <20230806170604.16143-1-james@equiv.tech>
References: <20230806170604.16143-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May reduce confusion for users of MPI2_CONFIG_PAGE_IO_UNIT_3::GPIOVal[].

Fixes: a1c4d7741323 ("scsi: mpt3sas: Replace unnecessary dynamic allocation with a static one")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
index 84b167d49e34..587f7d248219 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
@@ -974,7 +974,7 @@ typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_1 {
 
 /*
  *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for GPIOCount at runtime.
+ *36 and check the value returned for GPIOCount at runtime.
  */
 #ifndef MPI2_IO_UNIT_PAGE_3_GPIO_VAL_MAX
 #define MPI2_IO_UNIT_PAGE_3_GPIO_VAL_MAX    (36)
-- 
2.39.2

