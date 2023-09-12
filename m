Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F55C79D8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbjILSej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbjILSei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:34:38 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E6F189
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:34:34 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 49729940D59
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:34:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a271.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DCB45940D21
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:34:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694543672; a=rsa-sha256;
        cv=none;
        b=XeSftaUoxuIyOTgm37ZAYC/OE4qZlAQ5YOvhQ/5REyMgIgEzOQtyU4DDISEuzkTRYdSvJ/
        dS46eWW1nFbxNZRM4G6+WGlgzkf7aAeEqxZ+oJ4WcZsO2iWs3E+hmlo8BgDJZPQgkkAd7O
        V4RxVyc3nlC9PSHR+hfWpMP8mvDryE21M7G5xgJMd5/uEOycm7dXSTgyCjzraXOBRRdzid
        DfKiU8RmlZMPM7W9KRzjeU6sPgCWw+xTd9jx37EWD8J+2ChSqaUbPXKJ6Ku3JBvsiD8R5+
        z/UDJbBsoy7P0PGXqXPV2TO7xOV2tLT8d+/JGaAgrcx9XG0G9DJGq7WQO2XnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694543672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=qxi+CJvQQtvK74E3Vo3p+KVNJms56lu0ly94jseqZbM=;
        b=sxDfnGsNA3H8uPf94JPhBTfLXT4SQ/2oOSMxRiKoyLaqc+luKzGAv5tLUEDiApxysqqyrb
        yv8visFx5LjCamN4MUJzLweeXsRmxJ9W7WUTlcX1MaxihPte7NWKBU5uRYPWZO1cF+Z5TQ
        jVsB6vSuKFHDlC1AouQaBD6+EDSN/RNO3GfWPcraTPIJbXT/Si3KA0sb4yt9w2gdOULgIE
        OxCOfcXHRNwIapWvSUQT1EbuMRS50qaJhWVLXgKDAKmsEshNFawSYtwbny6w+ni9a+qrro
        s/E5cr5KFoP9f5aTgS7IyGpf1jeRbsTg6qcVhOvivhGgGe10naj/LukT/rWHPg==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-msbjh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Duck-Grain: 05c9392504ead2cf_1694543673128_1672885809
X-MC-Loop-Signature: 1694543673128:915971295
X-MC-Ingress-Time: 1694543673128
Received: from pdx1-sub0-mail-a271.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.184.206 (trex/6.9.1);
        Tue, 12 Sep 2023 18:34:33 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a271.dreamhost.com (Postfix) with ESMTPSA id 4RlXLJ4lN6zM7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1694543672;
        bh=qxi+CJvQQtvK74E3Vo3p+KVNJms56lu0ly94jseqZbM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=F8TQlKovqhZCWwYNfFxDpg7MW8mDZRj1lGqGGsqiua+9l1M2dDs7ojaUrHp1DHrrj
         xi2LYitdfZqYagwU1wMdg8X6pVipOXvZUUIL5Gci7JSgN8kT19J+FSXAEuGnf3nISz
         171CAB9ch26K9240za/C1cWiSapVlavPPHmv/L01r3LqKhElDnr0vWXy1Tpb7ZjWDR
         A0I386QmTsoTWQgfQNxa9NT/2N40zEDULeocdB3xg2t2VLgE3RBlumbxq1Uq/3BLB7
         2X4mpVP5bEeQbBnpsn5PCzXpIIqqN+RBSTbrhUrjZ73hGpYSQergIMosr7oiV4CSib
         k1phPXAqjHbGw==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0111
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 12 Sep 2023 11:34:22 -0700
Date:   Tue, 12 Sep 2023 11:34:22 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: [PATCH v2 1/2] fuse: revalidate: move lookup into a separate function
Message-ID: <e21fe75ba435ddc4d0b2e056c950dd421af794bf.1694541252.git.kjlx@templeofstupid.com>
References: <cover.1694541252.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694541252.git.kjlx@templeofstupid.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If this refactoring seems cumbersome, it's because the goal is to move
the lookup parts of fuse_dentry_revalidate into a common function.  This
function will be used elsewhere in a separate commit.  In the meantime,
the new function fuse_dentry_revalidate_lookup is responsible for just
the lookup and validation portions of the revalidate dance.  The
fuse_dentry_revalidate function retains the responsibility for
invalidating and mutating any state associated with the origial
fuse_inode and dentry.

Cc: stable@vger.kernel.org
Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/fuse/dir.c | 85 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 04a1c62342dc..da5b6079d88c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -183,6 +183,57 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	args->out_args[0].value = outarg;
 }
 
+static int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
+					 struct dentry *entry,
+					 struct inode *inode,
+					 struct fuse_entry_out *outarg,
+					 bool *lookedup)
+{
+	struct dentry *parent;
+	struct fuse_forget_link *forget;
+	FUSE_ARGS(args);
+	int ret;
+
+	forget = fuse_alloc_forget();
+	ret = -ENOMEM;
+	if (!forget)
+		goto out;
+
+	parent = dget_parent(entry);
+	fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
+			 &entry->d_name, outarg);
+	ret = fuse_simple_request(fm, &args);
+	dput(parent);
+
+	/* Zero nodeid is same as -ENOENT */
+	if (!ret && !outarg->nodeid)
+		ret = -ENOENT;
+	if (!ret) {
+		if (outarg->nodeid != get_node_id(inode) ||
+		    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg->attr.flags & FUSE_ATTR_SUBMOUNT)) {
+			fuse_queue_forget(fm->fc, forget,
+					  outarg->nodeid, 1);
+			goto invalid;
+		}
+		*lookedup = true;
+	}
+	kfree(forget);
+	if (ret == -ENOMEM || ret == -EINTR)
+		goto out;
+	if (ret || fuse_invalid_attr(&outarg->attr) ||
+	    fuse_stale_inode(inode, outarg->generation, &outarg->attr)) {
+		goto invalid;
+	}
+
+	ret = 1;
+out:
+	return ret;
+
+invalid:
+	ret = 0;
+	goto out;
+}
+
 /*
  * Check whether the dentry is still valid
  *
@@ -206,9 +257,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
 		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
 		struct fuse_entry_out outarg;
-		FUSE_ARGS(args);
-		struct fuse_forget_link *forget;
 		u64 attr_version;
+		bool lookedup = false;
 
 		/* For negative dentries, always do a fresh lookup */
 		if (!inode)
@@ -220,38 +270,19 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
 		fm = get_fuse_mount(inode);
 
-		forget = fuse_alloc_forget();
-		ret = -ENOMEM;
-		if (!forget)
-			goto out;
-
 		attr_version = fuse_get_attr_version(fm->fc);
 
-		parent = dget_parent(entry);
-		fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
-				 &entry->d_name, &outarg);
-		ret = fuse_simple_request(fm, &args);
-		dput(parent);
-		/* Zero nodeid is same as -ENOENT */
-		if (!ret && !outarg.nodeid)
-			ret = -ENOENT;
-		if (!ret) {
+		ret = fuse_dentry_revalidate_lookup(fm, entry, inode, &outarg,
+						    &lookedup);
+		if (ret == -ENOMEM || ret == -EINTR)
+			goto out;
+		if (lookedup) {
 			fi = get_fuse_inode(inode);
-			if (outarg.nodeid != get_node_id(inode) ||
-			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
-				fuse_queue_forget(fm->fc, forget,
-						  outarg.nodeid, 1);
-				goto invalid;
-			}
 			spin_lock(&fi->lock);
 			fi->nlookup++;
 			spin_unlock(&fi->lock);
 		}
-		kfree(forget);
-		if (ret == -ENOMEM || ret == -EINTR)
-			goto out;
-		if (ret || fuse_invalid_attr(&outarg.attr) ||
-		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))
+		if (ret <= 0)
 			goto invalid;
 
 		forget_all_cached_acls(inode);
-- 
2.25.1

