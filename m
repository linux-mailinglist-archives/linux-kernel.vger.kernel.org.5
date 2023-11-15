Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DBB7E07BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjKCRrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKCRrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:47:10 -0400
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFF718B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:47:04 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B1554502360
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:39:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a277.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6688F5023DE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:39:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1699033186; a=rsa-sha256;
        cv=none;
        b=kHrEKo6dgd+yhnIf5aMMtgN8qZhPg7Y+SbKisW+BRaazAApYh1M9KbM8QAK/Bz40STcmwS
        DRdbRqbC0tamHqAUkMe/2Pdyu9o5erYgytKHVI01VrmMjTE+p07RtNZStSbP+PKECCKgjp
        ydhrhaFeXou0hJAZJQWLUKou0IGYJ1BGcA+Lcq1/DSoQgDSjhxkC5S3u1o3Q1iCH0b2Pdf
        p0MyVQcCG78bx3NVe6JF07SN3PA1LKRW+HbiJiF97vf+lxyhvrEqR1NUGGnBbXsC7d9my0
        /g5GNdFkuhr+HpyeXPOe7Gs+wArx2za3d8XXx9uaKbVlyfqEmY2ZAQSGxMv3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1699033186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=7CfAwxtc1GjVGjPpAu1RZavwIvZcA14MkN7wWbXh4lQ=;
        b=GBMGbwynk7axeze7jT75t027PuB2Z4pTTxdbxAdWcTUog3TKvUR7+hyPEFF5GOl32AmhL4
        ATJaY43ZVvRV+WNcFJq/2wiD7+iEMW2M4Bn34FaIgaonWIGJShMdNk0R3YWHTpYFW3oF6g
        m3skiHPIxnWn6bDCkQnzTpR1QEobzg1H4ZvOiZ4D6oQ4QbauU77UArfPIlDysK1fWAaRmH
        SXfyyAivjajOpCeuO05YJ0zCoYGGcrI7zFGVV/Yc9rmXpfmnL6HXx/zgtPv1TIcsMiVYgr
        dfHhCrQplKXJPIFqoVdE5QEmGWKI/eiNyGQE+gcK/JuqSwegNq7QP5hWDtaAWw==
ARC-Authentication-Results: i=1;
        rspamd-76878f7dcc-vwwx9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Inform: 0c9abc8f64449e4a_1699033186552_2730902570
X-MC-Loop-Signature: 1699033186552:2722986492
X-MC-Ingress-Time: 1699033186552
Received: from pdx1-sub0-mail-a277.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.68.53 (trex/6.9.2);
        Fri, 03 Nov 2023 17:39:46 +0000
Received: from kmjvbox.templeofstupid.com (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a277.dreamhost.com (Postfix) with ESMTPSA id 4SMSg60sC3zxQ
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1699033186;
        bh=7CfAwxtc1GjVGjPpAu1RZavwIvZcA14MkN7wWbXh4lQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=E7DGPSnRfTpJMYKw5mWau4sSlqen++SJbzkyB0xiFEw5vCxIo+aySGIfSI8pk7vJL
         4IDipHBSX93pXeRVFtCWqt65gkmjOPs9mC1xm5xMOAgWZ1/wH3f7h6wDLDG8xUZnpF
         vo/TgUr90YwkD5sgB3TTaGgLmfJOwic6xUmGCnRFeol2y9T2UNDiYjDetugxLdLrY3
         lUVUTphNQYW81i2Wm7hmQQX7aKiniQ/rEJtFG7oe8iGPF3Bx4KuFZVIithgrAtd8ms
         KJ9QkeknrMPPg58cdeV5RBAtDfl19kSDR0OUuKVid7cVXDn/T7Q/VmTJbBPLsb/NTT
         FIqEXX+nf5bZA==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00cd
        by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
        Fri, 03 Nov 2023 10:39:47 -0700
Date:   Fri, 3 Nov 2023 10:39:47 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: [resend PATCH v4] fuse: share lookup state between submount and its
 parent
Message-ID: <20231103173947.GA2059@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fuse submounts do not perform a lookup for the nodeid that they inherit
from their parent.  Instead, the code decrements the nlookup on the
submount's fuse_inode when it is instantiated, and no forget is
performed when a submount root is evicted.

Trouble arises when the submount's parent is evicted despite the
submount itself being in use.  In this author's case, the submount was
in a container and deatched from the initial mount namespace via a
MNT_DEATCH operation.  When memory pressure triggered the shrinker, the
inode from the parent was evicted, which triggered enough forgets to
render the submount's nodeid invalid.

Since submounts should still function, even if their parent goes away,
solve this problem by sharing refcounted state between the parent and
its submount.  When all of the references on this shared state reach
zero, it's safe to forget the final lookup of the fuse nodeid.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: stable@vger.kernel.org
Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts")
---
Changes since v3:

- Remove rcu head from lookup tracking struct along with unnecessary
  kfree_rcu call. (Feedback from Miklos Szeredi)
- Make nlookup one implicitly.  Remove from struct and simplify places
  where it was being used. (Feedback from Miklos Szeredi)
- Remove unnecessary spinlock acquisition. (Feedback from Miklos
  Szeredi)
- Add a WARN_ON if the lookup tracking cookie cannot be found during
  fuse_fill_super_submount.  (Feedback from Miklos Szeredi)

Changes since v2:

- Move to an approach where the lookup is shared between the submount's
  parent and children.  Use a reference counted lookup cookie to decide
  when it is safe to perform the forget of the final reference.
  (Feedback from Miklos Szeredi)

Changes since v1:

- Cleanups to pacify test robot

Changes since RFC:

- Modified fuse_fill_super_submount to always fail if dentry cannot be
  revalidated.  (Feedback from Bernd Schubert)
- Fixed up an edge case where looked up but subsequently declared
  invalid dentries were not correctly tracking nlookup.  (Error was
  introduced in my RFC).
---
 fs/fuse/fuse_i.h | 15 ++++++++++
 fs/fuse/inode.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 405252bb51f2..9377c46f14c4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -63,6 +63,19 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
 
+/* Submount lookup tracking */
+struct fuse_submount_lookup {
+	/** Refcount */
+	refcount_t count;
+
+	/** Unique ID, which identifies the inode between userspace
+	 * and kernel */
+	u64 nodeid;
+
+	/** The request used for sending the FORGET message */
+	struct fuse_forget_link *forget;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -158,6 +171,8 @@ struct fuse_inode {
 	 */
 	struct fuse_inode_dax *dax;
 #endif
+	/** Submount specific lookup tracking */
+	struct fuse_submount_lookup *submount_lookup;
 };
 
 /** FUSE inode state bits */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 444418e240c8..243bda3cfdf6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -68,6 +68,24 @@ struct fuse_forget_link *fuse_alloc_forget(void)
 	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL_ACCOUNT);
 }
 
+static struct fuse_submount_lookup *fuse_alloc_submount_lookup(void)
+{
+	struct fuse_submount_lookup *sl;
+
+	sl = kzalloc(sizeof(struct fuse_submount_lookup), GFP_KERNEL_ACCOUNT);
+	if (!sl)
+		return NULL;
+	sl->forget = fuse_alloc_forget();
+	if (!sl->forget)
+		goto out_free;
+
+	return sl;
+
+out_free:
+	kfree(sl);
+	return NULL;
+}
+
 static struct inode *fuse_alloc_inode(struct super_block *sb)
 {
 	struct fuse_inode *fi;
@@ -113,6 +131,17 @@ static void fuse_free_inode(struct inode *inode)
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
+static void fuse_cleanup_submount_lookup(struct fuse_conn *fc,
+					 struct fuse_submount_lookup *sl)
+{
+	if (!refcount_dec_and_test(&sl->count))
+		return;
+
+	fuse_queue_forget(fc, sl->forget, sl->nodeid, 1);
+	sl->forget = NULL;
+	kfree(sl);
+}
+
 static void fuse_evict_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -132,6 +161,11 @@ static void fuse_evict_inode(struct inode *inode)
 					  fi->nlookup);
 			fi->forget = NULL;
 		}
+
+		if (fi->submount_lookup) {
+			fuse_cleanup_submount_lookup(fc, fi->submount_lookup);
+			fi->submount_lookup = NULL;
+		}
 	}
 	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
 		WARN_ON(!list_empty(&fi->write_files));
@@ -332,6 +366,13 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		fuse_dax_dontcache(inode, attr->flags);
 }
 
+static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
+				      u64 nodeid)
+{
+	sl->nodeid = nodeid;
+	refcount_set(&sl->count, 1);
+}
+
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 			    struct fuse_conn *fc)
 {
@@ -395,12 +436,22 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	 */
 	if (fc->auto_submounts && (attr->flags & FUSE_ATTR_SUBMOUNT) &&
 	    S_ISDIR(attr->mode)) {
+		struct fuse_inode *fi;
+
 		inode = new_inode(sb);
 		if (!inode)
 			return NULL;
 
 		fuse_init_inode(inode, attr, fc);
-		get_fuse_inode(inode)->nodeid = nodeid;
+		fi = get_fuse_inode(inode);
+		fi->nodeid = nodeid;
+		fi->submount_lookup = fuse_alloc_submount_lookup();
+		if (!fi->submount_lookup) {
+			iput(inode);
+			return NULL;
+		}
+		/* Sets nlookup = 1 on fi->submount_lookup->nlookup */
+		fuse_init_submount_lookup(fi->submount_lookup, nodeid);
 		inode->i_flags |= S_AUTOMOUNT;
 		goto done;
 	}
@@ -423,11 +474,11 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		iput(inode);
 		goto retry;
 	}
-done:
 	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
 	fi->nlookup++;
 	spin_unlock(&fi->lock);
+done:
 	fuse_change_attributes(inode, attr, NULL, attr_valid, attr_version);
 
 	return inode;
@@ -1465,6 +1516,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	struct super_block *parent_sb = parent_fi->inode.i_sb;
 	struct fuse_attr root_attr;
 	struct inode *root;
+	struct fuse_submount_lookup *sl;
+	struct fuse_inode *fi;
 
 	fuse_sb_defaults(sb);
 	fm->sb = sb;
@@ -1487,12 +1540,27 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	 * its nlookup should not be incremented.  fuse_iget() does
 	 * that, though, so undo it here.
 	 */
-	get_fuse_inode(root)->nlookup--;
+	fi = get_fuse_inode(root);
+	fi->nlookup--;
+
 	sb->s_d_op = &fuse_dentry_operations;
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root)
 		return -ENOMEM;
 
+	/*
+	 * Grab the parent's submount_lookup pointer and take a
+	 * reference on the shared nlookup from the parent.  This is to
+	 * prevent the last forget for this nodeid from getting
+	 * triggered until all users have finished with it.
+	 */
+	sl = parent_fi->submount_lookup;
+	WARN_ON(!sl);
+	if (sl) {
+		refcount_inc(&sl->count);
+		fi->submount_lookup = sl;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

