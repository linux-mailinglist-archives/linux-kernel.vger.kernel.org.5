Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA47476713C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjG1Pz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjG1Pza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:55:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AB444B5;
        Fri, 28 Jul 2023 08:55:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so7332524a12.1;
        Fri, 28 Jul 2023 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690559717; x=1691164517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpdC41+Bf2kU2Tf09u02Pdp+KuYiOkl5+Sf1RWH1VHM=;
        b=NKiQ0jkjkVDzHrPPfVGjhRPKwcRldGhM6uAhpkqxvwOGhCgzSsbZoZhu5PLrvK+4Uy
         QQbRpCIMvlSqIH0J3FhPj3wLansioW2hoxGalrXM3e03tuu3zx46gqI7cAImLGQxIMeS
         aparSlLN7xRmAeJtm76amSjRM3lefEbYnpVPpHN5i3GwxIBGoADLs77Pc5afBJh6XwcY
         MUb7bsc+w+tE65Y25FwWqD30PXC/LQYdMo6ZomSxCqBlLDlHBAvwFS5Cz2B37b0gt4Wq
         HnRlP5fLueetmeBn6FfIpoemu+XqGJ85WOJQhp/CaozpasrUPyChlFvWEx31SyCHOVIr
         0KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559717; x=1691164517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpdC41+Bf2kU2Tf09u02Pdp+KuYiOkl5+Sf1RWH1VHM=;
        b=aNOHr/7Cqf1q6eGQ/L8U6uSL0PMvg866VINX+SaxNO/ouswJliUSW6PSstTfy3wHnx
         B/AWCOcr3DImQl5T09jUB3StN6iitbUBgKXqIZGqWtuxTZ4acmatm1PvOfvAuQ+Ivjq5
         C9nTujhW6sxTzGM9VjdDe1mu/ln9d4HYY+OLQaYAGkGvNQPXw1E2cygMlAzJaPz2WRXb
         WxtBmwyu/4Rtf9b0KVX+t9Q1HXaj1J7V21khvAfv9b6AeBunINsHFyMMiOc5bleC+A+z
         ZqGtDTXbSVZul/zlljBt2d+Eav0idyRiVJKhF5aw1+XmCj8yMu8taZzQctxR8Dfp6CMO
         HL1Q==
X-Gm-Message-State: ABy/qLYyx+6w3N9aOxxtaEpNgebDH87fyudaFzFCq7+f4EyazIzvLLqd
        EwfcBcqqsKpVDcFG6N6hMrL0kEdi2v163+GB
X-Google-Smtp-Source: APBJJlEwirtYX2paxLrqjb1Vl3X7IY3qqxJrdGPWFwmZTaZkZ1KekvCci5Xme1v3jfl9+jGcMEl9LQ==
X-Received: by 2002:a17:906:5a4f:b0:997:e7d0:e26d with SMTP id my15-20020a1709065a4f00b00997e7d0e26dmr3540076ejc.4.1690559717409;
        Fri, 28 Jul 2023 08:55:17 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-157-016.77.0.pool.telefonica.de. [77.0.157.16])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098669cc16b2sm2198345ejw.83.2023.07.28.08.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:55:17 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] selinux: avoid implicit conversions in selinuxfs code
Date:   Fri, 28 Jul 2023 17:54:57 +0200
Message-Id: <20230728155501.39632-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728155501.39632-1-cgzones@googlemail.com>
References: <20230728155501.39632-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use umode_t as parameter type for sel_make_inode(), which assigns the
value to the member i_mode of struct inode.

Use identical type for loop iterator.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: avoid declarations in init-clauses of for loops
---
 security/selinux/selinuxfs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index b969e87fd870..7d7931d1758e 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -97,7 +97,7 @@ static int selinux_fs_info_create(struct super_block *sb)
 static void selinux_fs_info_free(struct super_block *sb)
 {
 	struct selinux_fs_info *fsi = sb->s_fs_info;
-	int i;
+	unsigned int i;
 
 	if (fsi) {
 		for (i = 0; i < fsi->bool_num; i++)
@@ -1075,8 +1075,8 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	u32 sid, *sids = NULL;
 	ssize_t length;
 	char *newcon;
-	int i, rc;
-	u32 len, nsids;
+	int rc;
+	u32 i, len, nsids;
 
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
@@ -1192,7 +1192,7 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	return length;
 }
 
-static struct inode *sel_make_inode(struct super_block *sb, int mode)
+static struct inode *sel_make_inode(struct super_block *sb, umode_t mode)
 {
 	struct inode *ret = new_inode(sb);
 
@@ -1613,7 +1613,6 @@ static int sel_make_avc_files(struct dentry *dir)
 {
 	struct super_block *sb = dir->d_sb;
 	struct selinux_fs_info *fsi = sb->s_fs_info;
-	int i;
 	static const struct tree_descr files[] = {
 		{ "cache_threshold",
 		  &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
@@ -1623,7 +1622,7 @@ static int sel_make_avc_files(struct dentry *dir)
 #endif
 	};
 
-	for (i = 0; i < ARRAY_SIZE(files); i++) {
+	for (u32 i = 0; i < ARRAY_SIZE(files); i++) {
 		struct inode *inode;
 		struct dentry *dentry;
 
@@ -1649,7 +1648,7 @@ static int sel_make_ss_files(struct dentry *dir)
 {
 	struct super_block *sb = dir->d_sb;
 	struct selinux_fs_info *fsi = sb->s_fs_info;
-	int i;
+	u32 i;
 	static const struct tree_descr files[] = {
 		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
 	};
@@ -1700,7 +1699,7 @@ static const struct file_operations sel_initcon_ops = {
 
 static int sel_make_initcon_files(struct dentry *dir)
 {
-	int i;
+	u32 i;
 
 	for (i = 1; i <= SECINITSID_NUM; i++) {
 		struct inode *inode;
-- 
2.40.1

