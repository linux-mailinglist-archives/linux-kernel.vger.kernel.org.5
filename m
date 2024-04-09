Return-Path: <linux-kernel+bounces-137464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E03CA89E27B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9751F23611
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F48E156C60;
	Tue,  9 Apr 2024 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdz3kUsk"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A913E3E8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687154; cv=none; b=IKVKRcyMg/sBg7VzHOJ/VSXole5myuiGRPcW7z+3aUE0N2is1PGvk5SZeS4TtTg4BQNsILhnIA58/oz7SMpt4ewUDK6xAyrSiQ83LnIfbFI0tr0/WmGSeD/JghwqdPFZ98XqUFl7cyOb0XmntO/Oj60vWxj7TfX/76lCJ14GQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687154; c=relaxed/simple;
	bh=QMgUojTl/i/srSNF5GIKUc3oeUgKB1hhbEyskGreugQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3ify5mx7jAoUBlj0X6g5RmohdGy/hrelc17UO/Vwx3IND97Gapwc8sjAT3ekTVa8c0xkEXzJG8/bvO0nyqo6v4sG5Fg/JrdrUZjVg/VUL7CAXKNkhS2xcvbetuzab1xKWXUGaqy5TOkwEmwe7hofpB8OjjLiq2Nkd7p+JHG8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdz3kUsk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-416c4767ae6so544905e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712687151; x=1713291951; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMVnTlKzzIBXlOvhWSp8lJbGWUU4Q1quhbk/89hlgNY=;
        b=jdz3kUskaRhIyLfry1ywef46UKT25IrEf1ZDRfeGYTIPgXlVkVOvvq23fBvp/5h+fS
         NoC5hfpyQHfXr2A30pUXZbyOqk6dQE7ciEXINpE9VgkrEBQUol/YK68vkhD6M2QWhOpA
         zYNeTAcrmgrO2cALypsljVhLvNaHWoVcwzbODE8wLEJhHeZJdWFxFDfCNCrNr9cP0cbs
         x4aS36S0xGBvhgfDCq73vPrzN04RzosRfe4HeSnhQ/2PEOZPgV9McCHHAKZLUATwr7l7
         swY4Fyy8+2XktNScsU5ynklI25D2x5KxjtXLivhj34QnFyCl93C2nlHe2BqyEOo6xv0w
         O69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712687151; x=1713291951;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMVnTlKzzIBXlOvhWSp8lJbGWUU4Q1quhbk/89hlgNY=;
        b=vdTGuuavQCeFfxXl6xVFmJELdKaM4jOjSFUrVjs3YxOiKfva9U+TtNBtMse9Aqo90F
         O8pwgg68f7yQckDhUUiZCfBFNSq3EbxOnt6cGNiKoa59Rhg3+goxIfltXxeTfu8V6507
         CujsMzuaPoQVyFALdj7FfvcWyRSqJoynpJP7WuVlooh1jzWXqVDBuofkIxLPISqw/z9Z
         lgKDt1bfhPtMDrP438HpwMRpjQBv/dBGEf3TaKKXjWzGyZXmS1NMAjpQu7NGsFLpkbZ3
         FRKoOOKqOabNth/lEN8GbGgW9RCP1bA24XGBDeoMG4nb2nY9OKl7qMrZxSZ6znuOUhrr
         qPVA==
X-Forwarded-Encrypted: i=1; AJvYcCU5rGYD/rtMaOZjwnzi2JFkLtMtR+lOjJXNIX9JyVyf++Ak+S+cNWXNCi9KbnnQuS4CybLexGeTqB6q1I5k3tXXusv8moWF82tPNK8M
X-Gm-Message-State: AOJu0YzXWhxwr3MmeRCJKfuUaZ/MGPDqlZIfsmOU1DRRGRh3Y345kaf7
	SbjeYIKap01K6DHjDNlIukMYHMGxPAqP2a9FBa3KDynwytPc5HgDcjv0Nq6oEA==
X-Google-Smtp-Source: AGHT+IFHEnlsqznP4KTV21mQuVExIU4Ie6hLZRtrEQN+FAIK8t6xpdewmL+c6BcHdbPggT+DVYeCMw==
X-Received: by 2002:a05:600c:4707:b0:414:e0af:9b9f with SMTP id v7-20020a05600c470700b00414e0af9b9fmr337610wmo.30.1712687151262;
        Tue, 09 Apr 2024 11:25:51 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:ae75:6122:b198:210f])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c470b00b00416b5f63822sm2048888wmo.0.2024.04.09.11.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 11:25:50 -0700 (PDT)
Date: Tue, 9 Apr 2024 20:25:45 +0200
From: Marco Elver <elver@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] tracing: Add new_exec tracepoint
Message-ID: <ZhWIKeZuWfPOU91D@elver.google.com>
References: <20240408090205.3714934-1-elver@google.com>
 <202404090840.E09789B66@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404090840.E09789B66@keescook>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Tue, Apr 09, 2024 at 08:46AM -0700, Kees Cook wrote:
[...]
> > +	trace_new_exec(current, bprm);
> > +
> 
> All other steps in this function have explicit comments about
> what/why/etc. Please add some kind of comment describing why the
> tracepoint is where it is, etc.

I beefed up the tracepoint documentation, and wrote a little paragraph
above where it's called to reinforce what we want.

[...]
> What about binfmt_misc, and binfmt_script? You may want bprm->interp
> too?

Good points. I'll make the below changes for v2:

diff --git a/fs/exec.c b/fs/exec.c
index ab778ae1fc06..472b9f7b40e8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1268,6 +1268,12 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		return retval;
 
+	/*
+	 * This tracepoint marks the point before flushing the old exec where
+	 * the current task is still unchanged, but errors are fatal (point of
+	 * no return). The later "sched_process_exec" tracepoint is called after
+	 * the current task has successfully switched to the new exec.
+	 */
 	trace_new_exec(current, bprm);
 
 	/*
diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 8853dc44783d..623d9af777c1 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -61,8 +61,11 @@ TRACE_EVENT(task_rename,
  * @task:	pointer to the current task
  * @bprm:	pointer to linux_binprm used for new exec
  *
- * Called before flushing the old exec, but at the point of no return during
- * switching to the new exec.
+ * Called before flushing the old exec, where @task is still unchanged, but at
+ * the point of no return during switching to the new exec. At the point it is
+ * called the exec will either succeed, or on failure terminate the task. Also
+ * see the "sched_process_exec" tracepoint, which is called right after @task
+ * has successfully switched to the new exec.
  */
 TRACE_EVENT(new_exec,
 
@@ -71,19 +74,22 @@ TRACE_EVENT(new_exec,
 	TP_ARGS(task, bprm),
 
 	TP_STRUCT__entry(
+		__string(	interp,		bprm->interp	)
 		__string(	filename,	bprm->filename	)
 		__field(	pid_t,		pid		)
 		__string(	comm,		task->comm	)
 	),
 
 	TP_fast_assign(
+		__assign_str(interp, bprm->interp);
 		__assign_str(filename, bprm->filename);
 		__entry->pid = task->pid;
 		__assign_str(comm, task->comm);
 	),
 
-	TP_printk("filename=%s pid=%d comm=%s",
-		  __get_str(filename), __entry->pid, __get_str(comm))
+	TP_printk("interp=%s filename=%s pid=%d comm=%s",
+		  __get_str(interp), __get_str(filename),
+		  __entry->pid, __get_str(comm))
 );
 
 #endif

