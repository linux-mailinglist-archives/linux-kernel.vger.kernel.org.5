Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216E275AAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGTJbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGTJbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:31:24 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56627359E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:22:12 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R66dr2ClKzBRDsL
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:22:08 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689844928; x=1692436929; bh=OFKE5E9c4rF6D5IgSGAwbuC0/Ms
        M5ASBbtPBPoN95a8=; b=vHzayJ+Wm8ij9fhl7eRhD2fmd9As1ben7A/JIdyjzEO
        AbEtC8hO54KGu9QG/yjknyhxS+lQvPamFUIvi7apXVKsJXeNZ8hn1ZJDea0WnNxD
        qbjVfoRVDexaQMYXkE7IjJdMsasWYPuGIYByH0F0zZWki03UQCY1xH4H6JTp5A6J
        pswVtL6lMWOyG+JsOLdV57A5t63I9Jp2gB0fZQUR+Kg/eAFUHyeCAodwQhQlKgww
        1paEZ5enRRfxb2CglJlDlQpcaRNjrxNClfjymUs16g6Zq3i8+4FWPad8qJPucbpO
        oigLSehWmY5BKqa0iF2DuKuMzABK0wD0gIOlsKTtliw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5iZDg_YgSRJd for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 17:22:08 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R66dr0DYnzBHXhQ;
        Thu, 20 Jul 2023 17:22:08 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 17:22:07 +0800
From:   sunran001@208suo.com
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic79xx: fix some errors related to spaces
In-Reply-To: <20230720092058.3618-1-xujianghui@cdjrlc.com>
References: <20230720092058.3618-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <3029a40608f9337530b3cb767d936f36@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: space prohibited before that close parenthesis ')'
ERROR: open brace '{' following struct go on the same line
ERROR: space prohibited before open square bracket '['

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/scsi/aic7xxx/aic79xx.h | 7 +++----
  1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx.h 
b/drivers/scsi/aic7xxx/aic79xx.h
index 59e9321815c8..a1fdefdfddd8 100644
--- a/drivers/scsi/aic7xxx/aic79xx.h
+++ b/drivers/scsi/aic7xxx/aic79xx.h
@@ -66,7 +66,7 @@ struct scb_platform_data;
  #define	SCB_LIST_NULL		0xFF00
  #define	SCB_LIST_NULL_LE	(ahd_htole16(SCB_LIST_NULL))
  #define QOUTFIFO_ENTRY_VALID 0x80
-#define SCBID_IS_NULL(scbid) (((scbid) & 0xFF00 ) == SCB_LIST_NULL)
+#define SCBID_IS_NULL(scbid) (((scbid) & 0xFF00) == SCB_LIST_NULL)

  #define SCSIID_TARGET(ahd, scsiid)	\
  	(((scsiid) & TID) >> TID_SHIFT)
@@ -1043,8 +1043,7 @@ typedef enum {

  typedef uint8_t ahd_mode_state;

-struct ahd_completion
-{
+struct ahd_completion {
  	uint16_t	tag;
  	uint8_t		sg_status;
  	uint8_t		valid_tag;
@@ -1316,7 +1315,7 @@ struct aic7770_identity {
  	const char		*name;
  	ahd_device_setup_t	*setup;
  };
-extern struct aic7770_identity aic7770_ident_table [];
+extern struct aic7770_identity aic7770_ident_table[];
  extern const int ahd_num_aic7770_devs;

  #define AHD_EISA_SLOT_OFFSET	0xc00
