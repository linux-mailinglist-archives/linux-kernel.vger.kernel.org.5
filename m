Return-Path: <linux-kernel+bounces-62243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD31851D79
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028FC1F2495D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CFE47A48;
	Mon, 12 Feb 2024 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGs80CWM"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379D47F6C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764359; cv=none; b=drwzasdiLwS6DcHCzlQMP8FU6N9XIHT9OldJqYiS0o8TchfmMveGVV4NSRYxPeXfhkfTPS0xQpXqs9bvEtb8YYpYUcgsKv8rdcbIEiw4froMI9RbNcc+8XvjupwIsGzE0nqguPBaQW+HQ6jx8UkoDULyS+sj14S9N7vuV23vlZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764359; c=relaxed/simple;
	bh=LBou+XLQ8QDVF7i9zNrb0c+TC2HDLKGD9kRdzvqDd8M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=D7ggRGq35O5TkQPn/MYXibxMAKB21+uofn8+FVOs223XUC/uyR/DqlKbovZoXqUW5lLzHuhKJlFgR4JoNss0ed4VFAivclmu19Qavo6jKe1N2XwT7cOkUapaQUT+l3/L/kw2qBJ3b6majYKte1dOrpGU7471Cm7bqEdtLmtAxYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGs80CWM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbc447ddfeso725685276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707764356; x=1708369156; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FAs57lgcOMUxLgf079L8itwe0kfFXp2CsT7fDYu4PDI=;
        b=HGs80CWMzD8pcAUY1jRbxc/aYbownwLRYBYA83vBUAtJYVtFpKvup9XaGpO0muRX6S
         dtKmOKiTT2Mon+xo0DqCzxqKnyBx0luCM/Xuig3+tVnlA2laEzAfIJNyOar7iTrQ/vcV
         Bdc06BggdZddTwXW6xjZSVlXdU1VRLoSb8jOY541/2W8c3GV0SdOthe3si8zT1IvkxLw
         k4u5C8CcsVG/3oS62NCzBMXW1pizYRfKPV6nTk4PmjyOauAthQ7oaUfiCDrZPKR9Y0tk
         FAXHVuUaOz8ik1VrvH5YENVMP5MHwLqoBMz7HhbN/uk1YF+qLZ5fExsY6bEs0ERXPK8k
         FWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764356; x=1708369156;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAs57lgcOMUxLgf079L8itwe0kfFXp2CsT7fDYu4PDI=;
        b=IZn0wMEfiimvtrZhW1oPQvcLpLKIbSjLd5rcviMeCcCQhCfw20a52srx0NoA8uv/Jp
         IGxptU9BymOgzOCiBMg7sd64FOoTf4K9bzxCeXoQaaW4fIHxtBj4VCldidll021MbL2x
         daQ9tv45ZlSnzA6G/I+hwZVBQrp4EeJdz5NCtpN529D+UBf5Rox0defhMfIUmACIxS4P
         DouXOwXDlyRtzhCZbit6JrvbE5pGQnBsVXv1cPDNgxcbtCui2DiANQcI5UWk87y6i4RW
         UUN9rb+IZX9Z0AieWoV9STatdqqPKd0Rtl8VFz3EQtjdubLqGiLC7svn1ml4AsliOuEE
         vBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp4Zp4qMMR6HS9Oy012d6TZCxZpZhAHwOe4f+bh2dGIRiziIHcquq2Nrq82/cTsYrZTiiQKc8iNnq9rxiKJQX73O+e7rjqDXs1Fxw0
X-Gm-Message-State: AOJu0YwH+ep+VRjoWrAD0l/oC9j666BSjsPQodXAuGbI+Q00MaDM3mnT
	7ZBEAoKalNSDxXASRwKDOKB7C7X7D0/gvOcmfw5rDhIuCUr7RRc/6NPMzBlkjNeAaDBW5gkNs8v
	J4fYi9g==
X-Google-Smtp-Source: AGHT+IFKUUMT3n7DkY6OIeWV+e7Wky9FtU2Gzr+NBHztBUsnln24BvN1I4nBHu3pAe9rRC8RqMKIOJHyh6k+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:125c:bcda:4fe2:b6e6])
 (user=irogers job=sendgmr) by 2002:a05:6902:1007:b0:dc6:e20f:80cb with SMTP
 id w7-20020a056902100700b00dc6e20f80cbmr348338ybt.3.1707764356106; Mon, 12
 Feb 2024 10:59:16 -0800 (PST)
Date: Mon, 12 Feb 2024 10:58:54 -0800
In-Reply-To: <20240212185858.68189-1-irogers@google.com>
Message-Id: <20240212185858.68189-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212185858.68189-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 4/8] tools subcmd: Add a no exec function call option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Tools like perf fork tests in case they crash, but they don't want to
exec a full binary. Add an option to call a function rather than do an
exec. The child process exits with the result of the function call and
is passed the struct of the run_command, things like container_of can
then allow the child process function to determine additional
arguments.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 2 ++
 tools/lib/subcmd/run-command.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 5cdac2162532..d435eb42354b 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -122,6 +122,8 @@ int start_command(struct child_process *cmd)
 		}
 		if (cmd->preexec_cb)
 			cmd->preexec_cb();
+		if (cmd->no_exec_cmd)
+			exit(cmd->no_exec_cmd(cmd));
 		if (cmd->exec_cmd) {
 			execv_cmd(cmd->argv);
 		} else {
diff --git a/tools/lib/subcmd/run-command.h b/tools/lib/subcmd/run-command.h
index 17d969c6add3..d794138a797f 100644
--- a/tools/lib/subcmd/run-command.h
+++ b/tools/lib/subcmd/run-command.h
@@ -47,6 +47,8 @@ struct child_process {
 	unsigned exec_cmd:1; /* if this is to be external sub-command */
 	unsigned stdout_to_stderr:1;
 	void (*preexec_cb)(void);
+	 /* If set, call function in child rather than doing an exec. */
+	int (*no_exec_cmd)(struct child_process *process);
 };
 
 int start_command(struct child_process *);
-- 
2.43.0.687.g38aa6559b0-goog


