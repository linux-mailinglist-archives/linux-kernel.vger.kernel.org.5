Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC1B761E32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGYQPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjGYQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:14:34 -0400
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CF72118
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:14:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1690301659; x=1690308859; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=p4FrMSJtYb7PqmV/oxmGnwwCR88Iaj/wEfwZO+g0Tv8=;
 b=tAye7lvjA5fCoa5W9xLhhIagxzRNgvmeQTQlddraL217Dk08HpboEoku3ubrAHNomDjyBIBSOy+tm5hcTKkYYr+I0Dn3c6JRbsrA/R9y2RocREnYHheAp5UayToFhKuvrpvYdjz8oEJrlDoVHApfj3R6noMpw4keW2jyJXiGIHPSnROFkyko+52TMkoRz9C3Og39PDhxy+/gOCF7FM9T9VdKFbhmGIrFW8EVf5bHV3FoJZYSnkjhgZyVHibBLnwYIZuNgn1dDA/9SVGvzFaZDxnnhp9P5RUfvR3s6l1JINJWWqKGjz2S+ojCUOQcshY0IXca3i5jPlR4SlTF1PIzww==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by d53bb90da10c with SMTP id
 64bff4db13929ab6cbff5789 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 Jul 2023 16:14:19 GMT
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
Subject: [PATCH 4/6] scsi: mpt3sas: Fix an outdated comment
Date:   Tue, 25 Jul 2023 09:13:29 -0700
Message-Id: <20230725161331.27481-5-james@equiv.tech>
In-Reply-To: <20230725161331.27481-1-james@equiv.tech>
References: <20230725161331.27481-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May reduce confusion for users of MPI2_CONFIG_PAGE_IO_UNIT_3::GPIOVal[].

Fixes: a1c4d7741323 ("scsi: mpt3sas: Replace unnecessary dynamic allocation with a static one")
Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
index f07215fbc140..62bde43f64a8 100644
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

