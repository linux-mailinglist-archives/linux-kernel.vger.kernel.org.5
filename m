Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746537FF65E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjK3Qk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345658AbjK3Qkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:40:52 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AE110E2;
        Thu, 30 Nov 2023 08:40:58 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D8C25C007F;
        Thu, 30 Nov 2023 11:40:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 Nov 2023 11:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1701362457; x=
        1701448857; bh=4sDD4mN+pIoyX7m8FGv2uCwfMAv7UW1AZsJ3O0T01T8=; b=b
        fcSzGWgxiasYLEPtKTIOyLWvupsxC9+Bncp3fVIRu3jCqyyUltHLmbYBQDqwAWD8
        wKkJ6ihbiucwniyQbywRdsp0/zyHrCMt6K0oU9Y/qECgFaPcd5ZAxCs4WoHBSKIg
        LbAUH6PV26VlDiHrUM/XsiCXXlnXQkPQH3YVsAVjowoAKEPKYjSPY6LtlScg0uYe
        tf80TuUe0dgekCqV2MFtDanTSy3V9LIriJEaDvClZo+PECOjVHe9yfUy3+iLFk9i
        4v5GQtxpCL4VdG2V69yEiNZkv4Ljg7cXKrrDiEsJmydYacKDCVMOCdDzb3tlesrf
        REOXsb8aZiwiPsi+WDlAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701362457; x=
        1701448857; bh=4sDD4mN+pIoyX7m8FGv2uCwfMAv7UW1AZsJ3O0T01T8=; b=a
        ANGV5K1XzH9CPL28GtdWbUILbVM8yIuEp0TA0y0lHtx0q0Gz38FvjgG9wAPCAyBb
        CSPxlP+VoIQMA9FNzH240SeYuN8zz9r3T+FTN+0XJA39XaFYyiwu8DeZhpvEZ2O4
        SWBf70fveyFAe9+nCF8BU1rerdd9AAdZcmBcMcuMhRor5jM9cL9Few/D0WAfe5Xm
        nZzNcDHfShuEdtq6qoNT2Y/6149jNxuAg5m6X8l6Rt4e8AKyrELSznf5cEo7qreA
        88iONaDp7R4vru3HwI5TCvSa1C8RPfE1bvQOCaPBhbp4ggnTl4rs/2DFtM0I585L
        RcUisRmQ+cNOlcp99hM0w==
X-ME-Sender: <xms:GbtoZQRpqkbCTw_0mWhJO2Ivs6-hrrgWALCwE-cEvremXeqOOjWsng>
    <xme:GbtoZdxqjsBSGbWx9fRuGJwt6ZQYpNARK47gZzxtjmjYjq_VhLjZDQ00nTG28b6Ps
    bUVUCyiDG93n2qI9RU>
X-ME-Received: <xmr:GbtoZd1_1TJOl405YzZmIq9AB-iOZq9x5YHR4e0aSIN33cKjjOwjic-FH7RfoJYtJGBNjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepvdegffehledvleejvdethffgieefveevhfeigefffffgheeguedtieek
    tdeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:GbtoZUBrZ0CarmP0il6Tmait1Jwe5hyG_mvqkg_itSz2xxqPmjRkoA>
    <xmx:GbtoZZjup_GZrD6WBufcls8o_2V2nlI0uZviKGRU9rosFUemwbLuIg>
    <xmx:GbtoZQrD4wl0oD9FWaoLH4vClKY4fFIhOHnrpChE-XBtOu9ZsQxp9Q>
    <xmx:GbtoZXb4hsrIMZLT7PUkwRdn8CwadJzJK81sOK4-diZ6a3Q8md6WzQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 11:40:56 -0500 (EST)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        Tycho Andersen <tandersen@netflix.com>
Subject: [RFC 3/3] clone: allow CLONE_THREAD | CLONE_PIDFD together
Date:   Thu, 30 Nov 2023 09:39:46 -0700
Message-Id: <20231130163946.277502-3-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130163946.277502-1-tycho@tycho.pizza>
References: <20231130163946.277502-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tycho Andersen <tandersen@netflix.com>

This removes the restriction of CLONE_THREAD | CLONE_PIDFD being specified
together. Assuming the previous patch sorts out all the thorny issues this
should be safe. I've left it as a separate patch since it is not strictly
necessary as a usecase for us, but might be nice? Perhaps we want to wait
until someone actually needs it though.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 kernel/fork.c                                   |  3 +--
 .../selftests/pidfd/pidfd_non_tgl_test.c        | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index eef15c93f6cf..ada476f38b56 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2302,9 +2302,8 @@ __latent_entropy struct task_struct *copy_process(
 		/*
 		 * - CLONE_DETACHED is blocked so that we can potentially
 		 *   reuse it later for CLONE_PIDFD.
-		 * - CLONE_THREAD is blocked until someone really needs it.
 		 */
-		if (clone_flags & (CLONE_DETACHED | CLONE_THREAD))
+		if (clone_flags & CLONE_DETACHED)
 			return ERR_PTR(-EINVAL);
 	}
 
diff --git a/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c b/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c
index e3992f2d88cf..dfd6a2cd85a3 100644
--- a/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c
@@ -305,6 +305,22 @@ static int test_non_tgl_exit(void)
 	return ret;
 }
 
+static int test_clone_thread_pidfd(void)
+{
+	pid_t pid;
+	int flags = CLONE_THREAD | CLONE_VM | CLONE_SIGHAND | CLONE_PIDFD;
+	int pidfd;
+
+	pid = clone(thread_sleep, stack + STACK_SIZE, flags, NULL, &pidfd);
+	if (pid < 0) {
+		perror("clone");
+		return KSFT_FAIL;
+	}
+
+	close(pidfd);
+	return KSFT_PASS;
+}
+
 #define T(x) { x, #x }
 struct pidfd_non_tgl_test {
 	int (*fn)();
@@ -313,6 +329,7 @@ struct pidfd_non_tgl_test {
 	T(test_non_tgl_basic),
 	T(test_non_tgl_exec),
 	T(test_non_tgl_exit),
+	T(test_clone_thread_pidfd),
 };
 #undef T
 
-- 
2.34.1

