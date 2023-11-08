Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E667E4FD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjKHFKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHFKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:10:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AC4198;
        Tue,  7 Nov 2023 21:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CcH0xTRreCC1JdfQLSTKsazctMgrxZEpUTaQpd5V+l8=; b=HVqFImqG062WRZeK41Ixy5+5Kk
        +DNNktpRc94BTFyEPU4p1twnYWIOzhu1IwfapPP3vVrWsJSw/gdYYZhBq6QlKlYpO0GnJK3LnxAI/
        QfkeJJpH3M7ke8jntTUCYS5n8i8ZHfBUhtIx8mqX+xb1d3E363YKQpFyAvsOeFVniHWhsKKPsDthL
        yGXNI+CMtG6akbb1TBY2F2YpDx6RSZctIV7vcN4QF+S3t7XKPwctckG7PcZwXCGcjD2QPKG/pAYWu
        7y2BrDLFjbmIBDVDPppn5fH4w45/jbFBANM3roSHAntehGJM/bk6qjXT0LmZLpdSxvqdX3F6X+cfp
        d3xvakXw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0apf-002yQz-2x;
        Wed, 08 Nov 2023 05:10:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        "Tobin C . Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nik Bune <n2h9z4@gmail.com>,
        Anup K Parikh <parikhanupk.foss@gmail.com>
Subject: [PATCH] fs: dcache: fix dget()/dget_dlock() kernel-doc
Date:   Tue,  7 Nov 2023 21:10:27 -0800
Message-ID: <20231108051027.12363-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the kernel-doc notation for dget() and dget_dlock() to
prevent a kernel-doc warning:

include/linux/dcache.h:312: warning: expecting prototype for dget, dget_dlock(). Prototype was for dget_dlock() instead

There have been several previous attempts to clean up these
kernel-doc warnings:

a. https://lore.kernel.org/lkml/20190327051717.23225-14-tobin@kernel.org/
b. https://lore.kernel.org/all/eec6afad98dddc2eef10a5c98a074a07aba50787.1657360984.git.mchehab@kernel.org/
c. https://lore.kernel.org/all/9d2676a83ebee327b97b82f3c2ab76a2e53756d1.1660829433.git.mchehab@kernel.org/
d. https://lore.kernel.org/all/Yvde4NryqBnZesTI@autolfshost/
e. https://lore.kernel.org/all/20230926163631.116405-1-n2h9z4@gmail.com/

Parts of this patch are from Anup's v3 patch [d].

Fixes: dc0474be3e27 ("fs: dcache rationalise dget variants")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Tobin C. Harding <tobin@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Nik Bune <n2h9z4@gmail.com>
Suggested-by: Anup K Parikh <parikhanupk.foss@gmail.com>
---
 include/linux/dcache.h |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff -- a/include/linux/dcache.h b/include/linux/dcache.h
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -301,12 +301,15 @@ extern char *dentry_path(const struct de
 /* Allocation counts.. */
 
 /**
- *	dget, dget_dlock -	get a reference to a dentry
+ *	dget_dlock - get a reference to a dentry
  *	@dentry: dentry to get a reference to
  *
  *	Given a dentry or %NULL pointer increment the reference count
- *	if appropriate and return the dentry. A dentry will not be 
+ *	if appropriate and return the dentry. A dentry will not be
  *	destroyed when it has references.
+ *
+ *	The reference count increment in this function is not atomic.
+ *	Consider dget() if atomicity is required.
  */
 static inline struct dentry *dget_dlock(struct dentry *dentry)
 {
@@ -315,6 +318,17 @@ static inline struct dentry *dget_dlock(
 	return dentry;
 }
 
+/**
+ *	dget - get a reference to a dentry
+ *	@dentry: dentry to get a reference to
+ *
+ *	Given a dentry or %NULL pointer increment the reference count
+ *	if appropriate and return the dentry. A dentry will not be
+ *	destroyed when it has references.
+ *
+ *	This function atomically increments the reference count.
+ *	Consider dget_dlock() if atomicity is not required or manually managed.
+ */
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry)
