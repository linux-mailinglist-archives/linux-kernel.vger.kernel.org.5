Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC25A771C9A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjHGIwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjHGIwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:52:31 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F6392
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:52:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9529F5C0071;
        Mon,  7 Aug 2023 04:52:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Aug 2023 04:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1691398349; x=1691484749; bh=pK+JY1UZHR
        KX40EFsSZc3Ch/k+Ium31qkjrWu7lTaJ4=; b=d51qVqoD/EYic19iCczvJVjmCM
        T6Bg8JJDKX2UCRbq8qpGubBCy8ZgZaJXCrseisgm8IGV7etXE0ZNI6SC14+P7n1u
        Ry7eXwxiZMtt7sb+lNtoZDvS9W+X0X4weE2Am/goB9rHR7i638840T/gWxMeDCQ7
        43clmkOTrfJ7lg3dFfbpzFJU2mOmSd9buWzR9VC1/tG92GhX401K0h+h5CJHmwIP
        UOvMbyHrGi1bS0ryXeyaxmXrZrTtByc6lm4USolHGvcz4BmjUN7QfEHG88g4Fr3Q
        FZjMrExl1UzQxFuBY5Krd9w/kTAxBz2ExWWmjE3ctF0ndsqbZ+mbfstl7SAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691398349; x=1691484749; bh=pK+JY1UZHRKX4
        0EFsSZc3Ch/k+Ium31qkjrWu7lTaJ4=; b=BPK1TApja4rq2rGxfw0Rt3SkhwB94
        3Q+L99PGQpjOUW6GonMq2NJSt2XkefX2qkQ+wHj+JkbVZJqhuoocs/ut0zIw8awK
        mk/VOkfSbJG4TLAPxHzegWBP8aGWPktDyI7PYFy5LnSn/j2TQu064EIr929Xj3ZE
        vOwU+y7TSweXlQpLdukbPni7Cg9lFMUTJZ7JLPO4tU3zxAyH7I3FaiUilBszAgbk
        32Jcpj1Umb4QrQ9TsOraUkvtjjiiP1ujIXS6/iGPJeJk8rmMwLaWvJBvSNmP4ukW
        DKVlYz9MxQKNN18D5fvCwgHITZ5rR9SppqKwkS9p1BZ1UmkRVmvTPeu5A==
X-ME-Sender: <xms:zLDQZMJAt1fjDHneBc1QUsQWe1RfBxuGVSP0A-834Bc-DBuJpzaW_Q>
    <xme:zLDQZML6AjSBYHI5UNV4f6nytkyds911G3YUfRLUgA3Mur1eZImD2ziLNTBGixnCK
    vnZhT0mTDpngs_U2Qg>
X-ME-Received: <xmr:zLDQZMtoxzChWaHt5Veha3eTOsAOr931WHv6w92jNiLj4o0ugjCED0tvXiG2rirfwZz8mFsOu3AXIgCwctcnjn2IFwT1_bq3toSVJ7s2fwV1sieMi-FcsSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghvihguucft
    hhgvihhnshgsvghrghcuoegurghvihgusehrvggruggrhhgvrggurdgvuheqnecuggftrf
    grthhtvghrnhepkeeivdeggeehleeltedujeejhedvfedvieeiiedvteevvdejhefgkeet
    gffggeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epuggrvhhiugesrhgvrggurghhvggrugdrvghu
X-ME-Proxy: <xmx:zLDQZJZsFdfL3Kgquja4BHUJvPgtU1AV2copwAgw-65CG-Y3Xkvjzw>
    <xmx:zLDQZDbEOT5izRR8str_uAVst2-ecK49NoWBN-RePHV46zkS-WYIgQ>
    <xmx:zLDQZFCrj5vY2YJwr1qc4-i3L5yIMOQqKHRX-r238FGj9TGVwMxYSQ>
    <xmx:zbDQZOwZux1xziwONXfdPSul7mGGknTVTQNWZUlkCfRDdWIWQDKzPA>
Feedback-ID: id2994666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Aug 2023 04:52:27 -0400 (EDT)
From:   David Rheinsberg <david@readahead.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Luca Boccassi <bluca@debian.org>,
        David Rheinsberg <david@readahead.eu>
Subject: [PATCH] pid: allow pidfds for reaped tasks
Date:   Mon,  7 Aug 2023 10:52:03 +0200
Message-ID: <20230807085203.819772-1-david@readahead.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pidfd can currently only be created for tasks that are thread-group
leaders and not reaped. This patch changes the pidfd-core to allow for
pidfds on reapead thread-group leaders as well.

A pidfd can outlive the task it refers to, and thus user-space must
already be prepared that the task underlying a pidfd is gone at the time
they get their hands on the pidfd. For instance, resolving the pidfd to
a PID via the fdinfo must be prepared to read `-1`.

Despite user-space knowing that a pidfd might be stale, several kernel
APIs currently add another layer that checks for this. In particular,
SO_PEERPIDFD returns `EINVAL` if the peer-task was already reaped,
but returns a stale pidfd if the task is reaped immediately after the
respective alive-check.

This has the unfortunate effect that user-space now has two ways to
check for the exact same scenario: A syscall might return
EINVAL/ESRCH/... *or* the pidfd might be stale, even though there is no
particular reason to distinguish both cases. This also propagates
through user-space APIs, which pass on pidfds. They must be prepared to
pass on `-1` *or* the pidfd, because there is no guaranteed way to get a
stale pidfd from the kernel.

This patch changes the core pidfd helpers to allow creation of pidfds
even if the PID is no longer linked to any task. This only affects one
of the three pidfd users that currently exist:

 1) fanotify already tests for a linked TGID-task manually before
    creating the PIDFD, thus it is not directly affected by this change.
    However, note that the current fanotify code fails with an error if
    the target process is reaped exactly between the TGID-check in
    fanotify and the test in pidfd_prepare(). With this patch, this
    will no longer be the case.

 2) pidfd_open(2) calls find_get_pid() before creating the pidfd, thus
    it is also not directly affected by this change.
    Again, similar to fanotify, there is a race between the
    find_get_pid() call and pidfd_prepare(), which currently causes
    pidfd_open(2) to return EINVAL rather than ESRCH if the process is
    reaped just between those two checks. With this patch, this will no
    longer be the case.

 3) SO_PEERPIDFD will be affected by this change and from now on return
    stale pidfds rather than EINVAL if the respective peer task is
    reaped already.

Given that users of SO_PEERPIDFD must already deal with stale pidfds,
this change hopefully simplifies the API of SO_PEERPIDFD, and all
dependent user-space APIs (e.g., GetConnectionCredentials() on D-Bus
driver APIs). Also note that SO_PEERPIDFD is still pending to be
released with linux-6.5.

Signed-off-by: David Rheinsberg <david@readahead.eu>
---
 kernel/fork.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d2e12b6d2b18..4dde19a8c264 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2161,7 +2161,7 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  * Allocate a new file that stashes @pid and reserve a new pidfd number in the
  * caller's file descriptor table. The pidfd is reserved but not installed yet.
  *
- * The helper verifies that @pid is used as a thread group leader.
+ * The helper verifies that @pid is/was used as a thread group leader.
  *
  * If this function returns successfully the caller is responsible to either
  * call fd_install() passing the returned pidfd and pidfd file as arguments in
@@ -2180,7 +2180,14 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  */
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
+	if (!pid)
+		return -EINVAL;
+
+	/*
+	 * Non thread-group leaders cannot have pidfds, but we allow them for
+	 * reaped thread-group leaders.
+	 */
+	if (pid_has_task(pid, PIDTYPE_PID) && !pid_has_task(pid, PIDTYPE_TGID))
 		return -EINVAL;
 
 	return __pidfd_prepare(pid, flags, ret);
-- 
2.41.0

