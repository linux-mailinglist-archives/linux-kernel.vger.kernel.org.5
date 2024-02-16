Return-Path: <linux-kernel+bounces-69512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B93858A67
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076121C20981
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3599315350C;
	Fri, 16 Feb 2024 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZy5ChhJ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586214A4F4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127724; cv=none; b=kafgkKGGrVEys1pvrGi4CQ6fqQLlxYu0aOzyHS+4Iom/Y8aicrtn2yjB6k8VEl8O0to/yKn4ozTQ31XRPSFj31llvJK3Xo3517wXO0AkcIvtJT1mhCkpAgINRq9xCDbe6pKwjm7WnT8x6FOTQ7yIAYR0Cj+DYzZnx7midmYHIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127724; c=relaxed/simple;
	bh=nIwADbFncYymlWUg/R60jRadSx8+xe1bkn0KEBii9rU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Z+bOxQUBHrwhKse4m2mI6syExfTfYpqxtP8uqJ+I1a98xRQ9AwnkT3QuoFN602fRtj9sUA+vcyOCwqM/HPoSfk/BJ2/zuLDRly2qgqK6gLHmfCvj0CwgzMPEf6EKO+7ySeqjD6Kj5ttjwK/MthpurveZ2VhnC4sh3CeMYOoTiys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZy5ChhJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so1796733276.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708127722; x=1708732522; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eF36kSIEMlGOGF+Ru4Ee+ArAeIU+1BDlU+YfXMm89FI=;
        b=PZy5ChhJk5JUXUDQLXMQvdXtEOXP11BPV4rBPvaGZpyQL1nyZRMDmOSwSNuxq0/eST
         upNa0E1k8pXZ1Nb7r02K+1hiRIoFDBWNHxZ90UAeLS33odaDXxKmuyFBweLwL7MbG+Yh
         DI95Z4Z/KUh4gmlIXnQINyvCcQAx1G0eSJKObAZ7ktCbNYGSQY2kE+JOlB+waObCy6az
         MO3t+tCD1ghKuN9fSaQ82Y9q+/pZAYUP0uRD3UuJY+PuWN+uT5qqVJVQrBISoG3ja9W+
         h9LKbVLAykFBbsE4hY+V34WEDzWtIFvTMOggP3ux8RhEYtYEnvWhInUYixSrzm6lB6ZR
         tOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708127722; x=1708732522;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eF36kSIEMlGOGF+Ru4Ee+ArAeIU+1BDlU+YfXMm89FI=;
        b=QqYRrlcMgUIMZ64M7vk9w8DfGJRllNFUT6O20IJFkeP/VsWX10tkA6PUhVop+Pi7xb
         Bxo/vvEiNqRgfR1mMLSC1KNlXKDrzlZdtt3So1kPtoJRYaVBtmKO+bUX0eBb2Ym6rDGa
         7/DML17lQSAaCNMg4YveNAPg88faXu2qPljgnih74OmJtX5WGRnxVrIZLIeRmgmMnwRV
         2QKGFlH0ZKygs46DuGx9zCUxdXJxQ127QeW8LY1TjnRf/ds5AUu2bD2a+aqkaXk8+Np9
         RCEf4C+3HmtRaDG5PxXdNvpT/dmrveZjJFgNDk2bRP2HMezSMHnzK7S0X0tyRlXenoCF
         +ELw==
X-Forwarded-Encrypted: i=1; AJvYcCWFHFC8YOM0fJIwtJa2q4O4u3c7VYylEoS6bZBDVruoy2dHVWv8Q56NBEX8q0eSJ9A8flFPIxaLuoyvdU/+aqD6ePdfS9RM8UwHixOY
X-Gm-Message-State: AOJu0YzBzW1eTyF7Mt7V0ThuonkTXXXkh+PUsXhWVxieKiUkX3IMb8de
	jdoe0EmdpxcYBO5m5+JZVE+xKhovqvhMq8MHjmVqSI8BL4GXEMI48QAXfrZ+UsNzkJQz+tbclcU
	WTAw1kg==
X-Google-Smtp-Source: AGHT+IGfOGgYYZ1tg0RR7Mc8R16w3ScRVDaDB1YDHMMyW6IG4/kXRU7kq6iMdjHtzqNv1eu7Is10auuBRJZR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4b5c:352:4272:e34e])
 (user=irogers job=sendgmr) by 2002:a05:6902:704:b0:dc7:6f13:61d9 with SMTP id
 k4-20020a056902070400b00dc76f1361d9mr242453ybt.4.1708127721847; Fri, 16 Feb
 2024 15:55:21 -0800 (PST)
Date: Fri, 16 Feb 2024 15:51:58 -0800
In-Reply-To: <20240216235203.229256-1-irogers@google.com>
Message-Id: <20240216235203.229256-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240216235203.229256-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v5 4/8] tools subcmd: Add a no exec function call option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
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
2.44.0.rc0.258.g7320e95886-goog


