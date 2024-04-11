Return-Path: <linux-kernel+bounces-139610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BA38A0550
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60471C210D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C545657D3;
	Thu, 11 Apr 2024 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jyg+0vMn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7712F657A3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797585; cv=none; b=kbv29vueukAXLuhAiMF643Kwr+SuNpn2nL5pnZnaHgqaL9cLCcKUJJftflAWiu8PvsMciriu+xd3VxAp4Kb+/rSiNN0ZWsxKKj/pL5bvYDaK1eehnX+fQ84/TtVojvwv+I30KVaf3CIQtR9p/AQpZPfjZuKksAkfhIMKbbUqcOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797585; c=relaxed/simple;
	bh=zhLDADHOwmHHPH8g5hxQ5LSBrm2Fmoz5QVlMxcXmoXc=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=dCDXRbTlvprwJyba09lYMPKMzM0TzJO73W/qkgHKqDiMMGa+q9ZG+0xdIX1XmGIVdHIqRiKhZf6yovNmBJ9oG43mxveuLO7T2WZ2t3XQnPEFLQb3D0UgBnHNiHqhRPSsmZ0vNfhzVa2QGIpSeKhejMf8Eme4kUy+JowcP4Gf2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jyg+0vMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6D3C433F1;
	Thu, 11 Apr 2024 01:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797585;
	bh=zhLDADHOwmHHPH8g5hxQ5LSBrm2Fmoz5QVlMxcXmoXc=;
	h=Date:From:To:Cc:Subject:From;
	b=Jyg+0vMnyURozpnMc2Xc4q3nFO2f5qbLlsZ9hwgkKxwYNaRo3CFfxkCT6bSPiRtR4
	 BWTW6cZqOLQMb7FKK4uQ3Cd9nQl9o8Y5EKxpIQ/AezQ4O6X0aAhhud431ka0H68fsr
	 mk1+X7g5+q85XIwUA80CJ2ebTpin/eh5sVmCWs0aNl/mR4IXxgM3FzcwXw9PqE3rnE
	 Ug44ykKSf8fYA21TSgdsDk6mSVxgAchwRs+rxfJgq3Z1EgmFTpNG7ZLu7j9nOTHRTV
	 oP+vcC8uUQorXvSs3OH6JzZSNv4t7wuOXGBnxeWM8GRZKUfhwnWW3udr/IKOLe8S2U
	 /pi5AtO+GulHA==
Date: Thu, 11 Apr 2024 10:06:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Zhenhua Huang
 <quic_zhenhuah@quicinc.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] bootconfig: Fixes for v6.9-rc3
Message-Id: <20240411100621.d3fd98310487cef580456853@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Bootconfig fixes for v6.9-rc3:

- fs/proc: Fix to not show original kernel cmdline more than twice on
  /proc/bootconfig.
- fs/proc: Fix to show the original cmdline only if the bootconfig
  modifies it.


Please pull the latest bootconfig-fixes-v6.9-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
bootconfig-fixes-v6.9-rc3

Tag SHA1: b0066d569a0eed92657edc836868122a6761da49
Head SHA1: c722cea208789d9e2660992bcd05fb9fac3adb56


Masami Hiramatsu (1):
      fs/proc: Skip bootloader comment if no embedded kernel parameters

Zhenhua Huang (1):
      fs/proc: remove redundant comments from /proc/bootconfig

----
 fs/proc/bootconfig.c       | 12 ++++++------
 include/linux/bootconfig.h |  1 +
 init/main.c                |  5 +++++
 3 files changed, 12 insertions(+), 6 deletions(-)
---------------------------
diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index 902b326e1e56..87dcaae32ff8 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -62,12 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 				break;
 			dst += ret;
 		}
-		if (ret >= 0 && boot_command_line[0]) {
-			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
-				       boot_command_line);
-			if (ret > 0)
-				dst += ret;
-		}
+	}
+	if (cmdline_has_extra_options() && ret >= 0 && boot_command_line[0]) {
+		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
+			       boot_command_line);
+		if (ret > 0)
+			dst += ret;
 	}
 out:
 	kfree(key);
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index ca73940e26df..e5ee2c694401 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -10,6 +10,7 @@
 #ifdef __KERNEL__
 #include <linux/kernel.h>
 #include <linux/types.h>
+bool __init cmdline_has_extra_options(void);
 #else /* !__KERNEL__ */
 /*
  * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
diff --git a/init/main.c b/init/main.c
index 2ca52474d0c3..881f6230ee59 100644
--- a/init/main.c
+++ b/init/main.c
@@ -487,6 +487,11 @@ static int __init warn_bootconfig(char *str)
 
 early_param("bootconfig", warn_bootconfig);
 
+bool __init cmdline_has_extra_options(void)
+{
+	return extra_command_line || extra_init_args;
+}
+
 /* Change NUL term back to "=", to make "param" the whole string. */
 static void __init repair_env_string(char *param, char *val)
 {

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

