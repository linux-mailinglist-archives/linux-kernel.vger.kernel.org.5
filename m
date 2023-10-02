Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081557B5685
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbjJBPYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbjJBPYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:24:50 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55EDB8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:24:46 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9F9CB800BC2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:24:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2ACC3801C06
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:24:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696260283; a=rsa-sha256;
        cv=none;
        b=ZPypHAlP6Jjjo6MElegIyivurm/bZW6rWOWxDEmrMKQYcfq9aM4bxSv6Nmz85EM9EGUIqw
        rVr69k6Z99oRSDJatKnMYsGn/F4tC8fIbbVW2di9m5bcjsGsF5LDcXDjW773sxeNwltJxS
        9/k0KO/QZ9VPqYscdXW3kord5122BQwNoUDOM76GyFB7N61J/sz63227nVviAalriAcoTs
        e0IzxnEB1xX4a9VMb/07iuqjKcakaR+gbufDbgiDJuaL0RV+7AbTyc5Gi2SAY6aTsbbaZ7
        Q7PQng6GVsyhvBdjfHuuZ07jaJe00u/0g/zhh1Ns/x+ZrwiexT/6dtmW/rCuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696260283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=TVjVZZCVY56Vmj7QpyQH3UJ5VWeUuqsU7/tY0Ipy4co=;
        b=W4+CZEqQpB/vVFuICfVqf4VkMkrHelrSs/wH1rm0j+vX51BNV6babfKHFIzq9McDH+XokH
        cAMjRZzYU9EhYvroawnC2SC4qoFc2SFFWaJ1/EasR0tteG9fqOqdt+GroF8kl7d1imT+NC
        RLjux/m3ytyPPpJkXMju0FYHHmA/lZTKwAayC97Wa65KwPSeLrmzShjH/21gqNkXNl9+sT
        uTb5XZ51sEJB8mfWt7reDjEOnOeQKdpP0TTYKjBuaVWBecnJiqmth3ryHf5jGDSXZzCvFv
        J5LoVSBM1/f6SxbeqS9LdC6NxDG3PqF+mfBUF8Th24mN1HEgz5J9RUGHjXZXsA==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-p25dv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Eight-Abortive: 3bab207e103c039a_1696260283434_2964901075
X-MC-Loop-Signature: 1696260283434:4163934859
X-MC-Ingress-Time: 1696260283434
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.162.150 (trex/6.9.1);
        Mon, 02 Oct 2023 15:24:43 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4RzlB23fmQz1TG
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1696260282;
        bh=TVjVZZCVY56Vmj7QpyQH3UJ5VWeUuqsU7/tY0Ipy4co=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=RVADlwDi63AV3zzotDLLj5vXk6zEWrjFRHZnmfcpOnLAmCw2Yd0wGuSV+tOAHRpBk
         ma45QvOv3sGdnHg0u0QRltGTzLRmFkYvLRgYkZ0opMsAovJXSQwI8Xw+/plBVB2DTk
         LkYWqhUfw+JSykiLkBaGgLfwlgbvgsBUMGbsPsX0dCsukVSl09YfR1dFRYHfaWUB4m
         3yygStcInkJM13JZvfZprEBMQUE+40fjycZxBRutU85+uYartlauJDdX+CZKdqCzSZ
         Pz1AxCpxLP1w2yybrKHxlEryq8tPQsUT4QOFKc5+UcLwHFYG/J9DynTiH06jnyNbmN
         QefBFIHkll+rg==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0110
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 02 Oct 2023 08:24:38 -0700
Date:   Mon, 2 Oct 2023 08:24:38 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: [resend PATCH v2 1/2] fuse: revalidate: move lookup into a separate
 function
Message-ID: <82abdcba1e56dd3bc524bc3f2f44ae9c71f40fb7.1696043833.git.kjlx@templeofstupid.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696043833.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the lookup parts of fuse_dentry_revalidate into a common function.
This function will be used elsewhere in a separate commit.  In the
meantime, the new function fuse_dentry_revalidate_lookup is responsible
for just the lookup and validation portions of the revalidate dance.
The fuse_dentry_revalidate function retains the responsibility for
invalidating and mutating any state associated with the origial
fuse_inode and dentry.

The rationale for this refactoring is to allow a lookup to be triggered
as part of creating a submount.  The submount code lives in another
module.  A subsequent commit will utilize the common function that is
created by this commit.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/fuse/dir.c | 85 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d707e6987da9..5e01946d7531 100644
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

