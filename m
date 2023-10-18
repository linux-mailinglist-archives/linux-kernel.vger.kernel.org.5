Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676697CD1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjJRBeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJRBeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:34:15 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA8910A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:34:13 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2C38A40805
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:34:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BB50D40CFF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:34:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697592851; a=rsa-sha256;
        cv=none;
        b=xDOb+llsA0ssEH4eIVD4mqWnmBitCe/A0UeoYobUXeXkfFBaBtbxMn+zpsNvL4D9RFdVXH
        bm5YehJyyILPQQBHOQVHLJuEu9IY4I5ml4PzoMNIYnMGU/wHVXvBe3ho9c/ZZ8c3nj/WH6
        hbguOEAnEU3uhAQeS/6Q+w7ksGPfClnJ3l769PCM2mrBNVg1XKFkSOckrWVNvykiBQiUO/
        QCsMBYZOqxL+5g72dZz0yqRXiLDuLP+uJqI4JCeVRJmZPqc+DEbJT9hTQ/k+TLjcGq7rGg
        F2NvaQxxyxHfPgUdLiZFoGkwiAapGTDGRpF7gnk9b3Vg16MekO1KG1M/I/oeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1697592851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=PWcGcc1N96pVbtjYCrBHSWdBU6sl93dC5YZCNRVRav8=;
        b=1tBIjxld/uzK/UEmwHBvW+HCQ6hIiMGkV9xztO7KmAo2F6b4KDI9KpDdk20AWE17bgq1vB
        GSSWchS2m1xvnU7M7Gqx4hygxhqw4lV3qEEUspY8VM+oPshQB41eGxPFLEKQsIr4bTQMNK
        f++pHKgMt2U5r+COU1RXVlrHDqIQLLmlXv0JY+1dh7HrE5pU++1grK/bWN4DP/8rr5kdf8
        tUiGTfIjRX+TLaBcF/WwL3tdgD6O/F5ddUVx1WuZqJ7sYFtsgcHDSmI4zFzuw1swuPseS7
        0HhnM3QT8HriIiUB89WDMbZtKwkiBibou3haCUA3DYYT0bqdn3at4fOnrYIFpA==
ARC-Authentication-Results: i=1;
        rspamd-555cdc57c9-rf66x;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Print-Snatch: 078434be32667207_1697592852014_719305809
X-MC-Loop-Signature: 1697592852014:391060207
X-MC-Ingress-Time: 1697592852014
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.222.53 (trex/6.9.2);
        Wed, 18 Oct 2023 01:34:12 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4S9D0M39l5zQh
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1697592851;
        bh=PWcGcc1N96pVbtjYCrBHSWdBU6sl93dC5YZCNRVRav8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=MteHerEVcBPfdyHbQ61dmZxob5N3zZu2sLo44dBVPhzLSrwzDrGDRNiEpQCqk/TFK
         mx4VAhQ/lIvUbtjAPVICTWVfep7vNy8UMOtUMGlsSCfe17rl9XEvY9uF20gOmQzNDG
         4XXnL6AABMN62wAz6Wh1aMu49fFadYRHyWY98kpZe9ypD/rHG7E7jaC4LQMJ+rrcBz
         MSkztGCJm+xZZgZ2mR2N5iHaK2JT0q/30b1vO2Qijh4VkRTUPMOTfGoAKJoPI4lk7y
         2vHiNJ5vDOeXCm1UedGaEKsDhgktIYCi5DhjOXoZtUoooYPH6oLcLyvQ6OZ0hXIqyK
         EDRvE5Kgz1iLQ==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0083
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 17 Oct 2023 18:33:59 -0700
Date:   Tue, 17 Oct 2023 18:33:59 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: [PATCH v3] fuse: share lookup state between submount and its parent
Message-ID: <20231018013359.GB3902@templeofstupid.com>
References: <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 fs/fuse/fuse_i.h | 20 +++++++++++
 fs/fuse/inode.c  | 88 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 405252bb51f2..0d1659c5016b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -63,6 +63,24 @@ struct fuse_forget_link {
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
+	/** Number of lookups on this inode */
+	u64 nlookup;
+
+	/** The request used for sending the FORGET message */
+	struct fuse_forget_link *forget;
+
+	struct rcu_head rcu;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -158,6 +176,8 @@ struct fuse_inode {
 	 */
 	struct fuse_inode_dax *dax;
 #endif
+	/** Submount specific lookup tracking */
+	struct fuse_submount_lookup *submount_lookup;
 };
 
 /** FUSE inode state bits */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 444418e240c8..dc1499e2074f 100644
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
@@ -113,9 +131,24 @@ static void fuse_free_inode(struct inode *inode)
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
+static void fuse_cleanup_submount_lookup(struct fuse_conn *fc,
+					 struct fuse_submount_lookup *sl)
+{
+	if (!refcount_dec_and_test(&sl->count))
+		return;
+
+	if (sl->nlookup) {
+		fuse_queue_forget(fc, sl->forget, sl->nodeid, sl->nlookup);
+		sl->forget = NULL;
+	}
+	kfree(sl->forget);
+	kfree_rcu(sl, rcu);
+}
+
 static void fuse_evict_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_submount_lookup *sl = NULL;
 
 	/* Will write inode on close/munmap and in all other dirtiers */
 	WARN_ON(inode->i_state & I_DIRTY_INODE);
@@ -132,6 +165,15 @@ static void fuse_evict_inode(struct inode *inode)
 					  fi->nlookup);
 			fi->forget = NULL;
 		}
+
+		spin_lock(&fi->lock);
+		if (fi->submount_lookup) {
+			sl = fi->submount_lookup;
+			fi->submount_lookup = NULL;
+		}
+		spin_unlock(&fi->lock);
+		if (sl)
+			fuse_cleanup_submount_lookup(fc, sl);
 	}
 	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
 		WARN_ON(!list_empty(&fi->write_files));
@@ -332,6 +374,14 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		fuse_dax_dontcache(inode, attr->flags);
 }
 
+static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
+				      u64 nodeid)
+{
+	sl->nodeid = nodeid;
+	sl->nlookup = 1;
+	refcount_set(&sl->count, 1);
+}
+
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 			    struct fuse_conn *fc)
 {
@@ -395,12 +445,22 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
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
@@ -423,11 +483,11 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
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
@@ -1465,6 +1525,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	struct super_block *parent_sb = parent_fi->inode.i_sb;
 	struct fuse_attr root_attr;
 	struct inode *root;
+	struct fuse_submount_lookup *sl;
+	struct fuse_inode *fi;
 
 	fuse_sb_defaults(sb);
 	fm->sb = sb;
@@ -1487,12 +1549,32 @@ static int fuse_fill_super_submount(struct super_block *sb,
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
+	spin_lock(&parent_fi->lock);
+	sl = parent_fi->submount_lookup;
+	if (sl) {
+		refcount_inc(&sl->count);
+		spin_unlock(&parent_fi->lock);
+		spin_lock(&fi->lock);
+		fi->submount_lookup = sl;
+		spin_unlock(&fi->lock);
+	} else {
+		spin_unlock(&parent_fi->lock);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

