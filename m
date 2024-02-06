Return-Path: <linux-kernel+bounces-55553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA1584BE0D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390EAB216BD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906491426F;
	Tue,  6 Feb 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="O5WuoKc9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GTcAcPhB"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390FA14266;
	Tue,  6 Feb 2024 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247482; cv=none; b=sVNegaHmOVGPRUZqzMtp08GIdA0l6YE6pmXOmyxkQmNlXwexW1U95RvRv0u3XfCzMF5OXjUnphK3QKlYE7nOl4OBXLxfcgwAR3fmSRiDdpTDL9L8Mh5E1/cC9c/0YvyYwb17k2WlDZwMKauGBXJSOoAzBnwcvftYdML4AQP2mz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247482; c=relaxed/simple;
	bh=M4fAkBlp0hjdilUomg63kXcVDzF13rsTVmWNtJq0Q7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ICzHGPCc3rTPiEL88VmrmX+VXTfynR2K0+Pi9c0G8gTjuPg8v9tEAcrc+EQcP9fm9lpC1v+FFeb4v5Vg/ccCA1qy7eJ5P1C/BB1v7Y3Zf/fvLBIBzIFVf7b7iWvLDEKJ54iIUVF0bgZ8TjSTdtVPrLiYVmT6onIWd9vwkSdyDBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=O5WuoKc9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GTcAcPhB; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 25D3C5C00E3;
	Tue,  6 Feb 2024 14:24:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Feb 2024 14:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1707247479; x=1707333879; bh=y8GyuwLWAhh7c8OATUhVe
	iRBYCHx0aeUuHH+DE1GXN4=; b=O5WuoKc9V99yeRlIx55bptAuuOCazO9h6ocfA
	u9kuP14uwpPaiTfvBh1N/2JdgNACu97fe9yMW4VFpJ2WU1QlvvRFc7VOuW3d5nvX
	fG9WELXT6HuOPfDuGMapcjBz/IHm4uaTR9CTGVbG7ncX+EAHD2Ay/iuaLnhykFHj
	Sj0ayjBEtpz/DNAl3zs+LH6gcg7gS5CXm2qPc1QId4OsWJL0pK0TqaVT4vhFKIsE
	QIlC3lvanE+La5roPn4jTgd4ffnllZJDNHsqFDF2RCnWu57ulpJdKxqMI0RggKgH
	vXFLPbuDY9Yw/Jjw9IQX1ujbWlaOQdbwH75fG8TWdj618wKtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707247479; x=1707333879; bh=y8GyuwLWAhh7c8OATUhVeiRBYCHx
	0aeUuHH+DE1GXN4=; b=GTcAcPhBZv+wG8/2b/GgauapVAxz13km7GlUpXkh6Ppa
	iKXy31ylxSM/l0jYi5S8qp31DveyIdtsjx234I2IZtbM2HyYWetR9zS2LMzw16uV
	0o9ErPn8x+HrtkVvGpaxFnP/gc5S17fP0rQ7aw7d4U3qBYJWDvM9F04450uULk2c
	pvrmiKzIx3ezlPjqfXcqqLyJKhu3tUNXWln18p1hgAabpDXPHCMi09aocJ/lQQhq
	HbT604dsI9Gpwo158kdWGolnPitakhGcZ0FCgHPQswlMtvooSsg7wtC3yRND3SrI
	T5mnNbz8adW40XDc/xexPbDkiTbNRg4ZxrGLPtMgJA==
X-ME-Sender: <xms:dofCZVRKbB6yPNcprcFtWYVpgafgrnnJK9_Jb2c2acjTlC3K-1CFFA>
    <xme:dofCZew5SeQSyvnVRzwZA1ebqxhPNaAZ3octS2rDucCQdcHS-owbGljeECyj6qG8r
    iM7QwCS9EhZ_SaPm-k>
X-ME-Received: <xmr:dofCZa0JKALGoK6MPCQh0pPQdJx5Y73YOwmEfAbO6DFeqX3Q6nglTzELQH1LsZX5oHuVCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhigthhhoucet
    nhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrghtth
    gvrhhnpeehfeefheelfedtgfejgeehleeifedvgffhueduueehheeuhffhhfethfeivdeg
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthi
    gthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:dofCZdD4HBp9fvuuTQ7sNUH_3I0dzgJyQPcQZgXGjP01KlfwLHB5Ug>
    <xmx:dofCZeiU5CGVypB3ajKbiLhMvsc-QZBQvpEnieWEp5GAN_U9KHoZDw>
    <xmx:dofCZRpz4sKh4T8pNioJ86f9XejGOFG2Y4cTO1JD72VJT1sFO9eOug>
    <xmx:d4fCZZXskGt6sbPKPeLI302CdNotr5XRn3b2f_4prBBeWOIRDcEzlA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 14:24:37 -0500 (EST)
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH v2] pidfd: getfd should always report ESRCH if a task is exiting
Date: Tue,  6 Feb 2024 12:23:57 -0700
Message-Id: <20240206192357.81942-1-tycho@tycho.pizza>
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
v2: fix a race in the check by putting the check after __pidfd_fget()
    (thanks Oleg)
---
 kernel/pid.c                                  | 17 +++++++++-
 .../selftests/pidfd/pidfd_getfd_test.c        | 31 ++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index de0bf2f8d18b..a8cd6296ed6d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -693,8 +693,23 @@ static int pidfd_getfd(struct pid *pid, int fd)
 
 	file = __pidfd_fget(task, fd);
 	put_task_struct(task);
-	if (IS_ERR(file))
+	if (IS_ERR(file)) {
+		/*
+		 * It is possible that the target thread is exiting; it can be
+		 * either:
+		 * 1. before exit_signals(), which gives a real fd
+		 * 2. before exit_files() takes the task_lock() gives a real fd
+		 * 3. after exit_files() releases task_lock(), ->files is NULL;
+		 *    this has PF_EXITING, since it was set in exit_signals(),
+		 *    __pidfd_fget() returns EBADF.
+		 * In case 3 we get EBADF, but that really means ESRCH, since
+		 * the task is currently exiting and has freed its files
+		 * struct, so we fix it up.
+		 */
+		if (task->flags & PF_EXITING && PTR_ERR(file) == -EBADF)
+			return -ESRCH;
 		return PTR_ERR(file);
+	}
 
 	ret = receive_fd(file, NULL, O_CLOEXEC);
 	fput(file);
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


