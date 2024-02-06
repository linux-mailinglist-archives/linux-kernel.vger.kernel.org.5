Return-Path: <linux-kernel+bounces-55331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC3684BB3B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68EFB29141
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310634A08;
	Tue,  6 Feb 2024 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="nu9Rh70Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fPeHNZdV"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC44523C;
	Tue,  6 Feb 2024 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237806; cv=none; b=VDL49X5OPQYmt3kjCHWfoIIvMSvnnAOZKtS5Ji9SdJ/H2dBMFCFtyleaV3FcYOUmr1Wrjv7GrugQZLKMSYAkMAEY3NmMx4rQsrhaWYxbkeiGyxboKwRxqeBalJBM2SLKbAonKk/A1GMaa5zmk9o9K603AGJCkxHUcemCU9pByZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237806; c=relaxed/simple;
	bh=H3sA3HP6yiXiZD2YbLYrofwBQrLibAkYudoYFsj7hBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KIyGxvjsU9uPLrA9IHf/0K/LSW7OLZikr8aSFjxuC8IobzG0D4Jr4tVbC9GFF1courJWrssYT3YV+WJioZldQwpMvRsZ1g5hBVacyxv3kZO4UAtI1YOdVQ6YNAPazCTvpI8xlJ7UrxC5FTyZoCAb0GlPVFIKR8vSSxlfs+DvrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=nu9Rh70Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fPeHNZdV; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8B6A45C00B1;
	Tue,  6 Feb 2024 11:43:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Feb 2024 11:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1707237802; x=1707324202; bh=P4gQPZry16ZhlVFQebz1H
	5tj4IjCcocpT+0mBjF4AJQ=; b=nu9Rh70Yppyf9WYoGytHNSIIjAypsbQkXswHO
	0qi4/ncq6DXSkhvqWelFxV1Hxd3eUtQp5bGah/epE62g4bDAdBCVwWB88TFVfZKM
	s0mtwm/YgDrzuOeAC7A8MoucFNIf/TfeVaTDIEm2+50ynI6LguR5a8f6kTyd8brs
	ViaopX0LgEQwWPfjY3sI+fR/VQGW9n9kINHy0yA+4OzpDhpakFpmnSNknrF5LwWK
	0k7ra67E4Py2H7JZUlcVY9SWSvDmNciU0oMCX9REkrWNQum/2qGPPZ51jyF2OnwB
	eYAArbmPGN8ughBDCXQ5ZKaGcFMYbYsR9RT0pfE4495wAL0jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707237802; x=1707324202; bh=P4gQPZry16ZhlVFQebz1H5tj4IjC
	cocpT+0mBjF4AJQ=; b=fPeHNZdVzy0/UatbEAy0/AoIwZPpCQOmJZ7Nawyy3jgu
	fuQ9RvsZOaM0WI51JoQxCc050gqWa24LKOtNQUMlcOEYkPxm9WdkMO6RfGJLSVKb
	2zhW462CYVKcNCw/3Fo5ZJ/BuU3S8dPZNIKvhZ3ga7gFqwuflg7CeOR22pKqh0Nc
	SXbeyevpsyvTq68eXbu6CVYviZ6HqcnTkt25GvoGyoYFUasvLv8Oz/SIZ1rFqDoN
	Z9dq78YzOYTWWL6ObR3F9pr0ktyS8AiQWaxs26wa2qOpbvrhNR9ojXkNvpfH7M8k
	5J1L+Uvf32300UvzPI5kTpfMNYX+fHLdYYmxR+6unQ==
X-ME-Sender: <xms:qmHCZczodrSt8kITMBydlvvQvXHcZQjxVxpXaE9r4N_A0IjNqMu_GQ>
    <xme:qmHCZQSDznfm6sRm9d1JBg7AoZJM8-OG0BhTo7WpzejjA4uf2LlvsOWaIfVEhgfRB
    j3zRHPHhrhj7nfWIUA>
X-ME-Received: <xmr:qmHCZeW4s8Ptd7ih9j4Ovo3xHNGsK_KcaJCKIv7_V-UZZc-sdwLqvc7TDe4vxJ7ERL-oRKxt72TUPJk_r7yP2t5xRoNhcHt8sUFKheqd_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhigthhhoucet
    nhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrghtth
    gvrhhnpeehfeefheelfedtgfejgeehleeifedvgffhueduueehheeuhffhhfethfeivdeg
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthi
    gthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:qmHCZajjohnMDCG3XO5QVHOrHbuQiXbBVDR1xnrmCXDBrlPKn6DvSg>
    <xmx:qmHCZeCiBw4PqDCzyTZDVIxhGW5iEOAmgbi2gwB8jpBODiOKoe2d-Q>
    <xmx:qmHCZbI1_LzThlKbK40yV1mcVYqORMimLbuOwKY4LVKXbv0RipDm4w>
    <xmx:qmHCZQ0Z4GfJlD-FUl_pdFtntO1Zzwmfowz0IjOEbG5GfMdWz5bBZA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 11:43:21 -0500 (EST)
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH] pidfd: getfd should always report ESRCH if a task is exiting
Date: Tue,  6 Feb 2024 09:43:08 -0700
Message-Id: <20240206164308.62620-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

We can get EBADF from __pidfd_fget() if a task is currently exiting, which
might be confusing. Let's check PF_EXITING, and just report ESRCH if so.

I chose PF_EXITING, because it is set in exit_signals(), which is called
before exit_files(). Since ->exit_status is mostly set after exit_files()
in exit_notify(), using that still leaves a window open for the race.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 kernel/pid.c                                  |  2 +-
 .../selftests/pidfd/pidfd_getfd_test.c        | 31 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index de0bf2f8d18b..db8731f0ee45 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -688,7 +688,7 @@ static int pidfd_getfd(struct pid *pid, int fd)
 	int ret;
 
 	task = get_pid_task(pid, PIDTYPE_PID);
-	if (!task)
+	if (!task || task->flags & PF_EXITING)
 		return -ESRCH;
 
 	file = __pidfd_fget(task, fd);
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index 0930e2411dfb..cd51d547b751 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -5,6 +5,7 @@
 #include <fcntl.h>
 #include <limits.h>
 #include <linux/types.h>
+#include <poll.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
@@ -129,6 +130,7 @@ FIXTURE(child)
 	 * When it is closed, the child will exit.
 	 */
 	int sk;
+	bool ignore_child_result;
 };
 
 FIXTURE_SETUP(child)
@@ -165,10 +167,14 @@ FIXTURE_SETUP(child)
 
 FIXTURE_TEARDOWN(child)
 {
+	int ret;
+
 	EXPECT_EQ(0, close(self->pidfd));
 	EXPECT_EQ(0, close(self->sk));
 
-	EXPECT_EQ(0, wait_for_pid(self->pid));
+	ret = wait_for_pid(self->pid);
+	if (!self->ignore_child_result)
+		EXPECT_EQ(0, ret);
 }
 
 TEST_F(child, disable_ptrace)
@@ -235,6 +241,29 @@ TEST(flags_set)
 	EXPECT_EQ(errno, EINVAL);
 }
 
+TEST_F(child, no_strange_EBADF)
+{
+	struct pollfd fds;
+
+	self->ignore_child_result = true;
+
+	fds.fd = self->pidfd;
+	fds.events = POLLIN;
+
+	ASSERT_EQ(kill(self->pid, SIGKILL), 0);
+	ASSERT_EQ(poll(&fds, 1, 5000), 1);
+
+	/*
+	 * It used to be that pidfd_getfd() could race with the exiting thread
+	 * between exit_files() and release_task(), and get a non-null task
+	 * with a NULL files struct, and you'd get EBADF, which was slightly
+	 * confusing.
+	 */
+	errno = 0;
+	EXPECT_EQ(sys_pidfd_getfd(self->pidfd, self->remote_fd, 0), -1);
+	EXPECT_EQ(errno, ESRCH);
+}
+
 #if __NR_pidfd_getfd == -1
 int main(void)
 {

base-commit: 082d11c164aef02e51bcd9c7cbf1554a8e42d9b5
-- 
2.34.1


