Return-Path: <linux-kernel+bounces-15839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FD8823422
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E0F1C23CA1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BC31C68D;
	Wed,  3 Jan 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NjhhFPYs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC91C683
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5559bb6b29dso5575425a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 10:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704305547; x=1704910347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/OAdStb2L8zryYFpyn7IXiVtaAM2rtXpmPffWXoWPII=;
        b=NjhhFPYsOyNDFiBDl9i5ycZ7r71PtHSavuqTK6u2LrR1roqKWAB3Hcqzcx8KsL/I52
         aO8pMdJNiMaT6rk2QJ8Ut4vEVr+Gw+CtnwWG63CiEtb65kvyPqbE9ZKDO/u2c2trI3iS
         bTtfclLw/vFca6cZeUUq0gSUMwVtgVY2SYHlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704305547; x=1704910347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OAdStb2L8zryYFpyn7IXiVtaAM2rtXpmPffWXoWPII=;
        b=nYBRNfHmBTCVd0cJlqUKfzPi+FCKcVgL0anGCVrWlzBiW2x9FWeyM2G0L20jdqi97b
         5Ned0+Wlvvj1RfW/5o+zitR4Uz3w/4oXJJKkZy9aGW5v4mPB9P6dyymADViMWQc9mm5w
         G0MMRxipl5+K4xAV5+CUdWR0dloJLOeCksQ1S96werUNlB0aNJnGVhH6z3DQbpCDn0Ec
         36Sn21tGG914nlsvyweyZqDUPG5TK+ETKbLXPqAMrNFRpVjetETOFF3j4p8Hx9RKnU/S
         LU6JzOFax3H0EMTDLVB9MRMIS79hqfsaorSmtjjl85O2ZzinGKNQpMoXFgxzMr9taYse
         ghJg==
X-Gm-Message-State: AOJu0YwR1PqdDcCIjwuVYUAkfeydeIYELvvzUaxqeI7lbdfQyb5Ic7eb
	9wRv7mQ3WDRDYpB+pkpynxDkqBB+eAhQsftm80OZZhM9tIPIC9ye
X-Google-Smtp-Source: AGHT+IHY7KNgOEOg3ufLPvtroPrKKiJOo4A5zhi9c/8u2nGJUeaegodZjfXVSSjD6wTGknqhDjj62Q==
X-Received: by 2002:a17:907:26cd:b0:a27:7da8:aaee with SMTP id bp13-20020a17090726cd00b00a277da8aaeemr5009775ejc.12.1704305546872;
        Wed, 03 Jan 2024 10:12:26 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id lo2-20020a170906fa0200b00a26ae4fb50asm12271688ejb.89.2024.01.03.10.12.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 10:12:26 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2864eb81c9so184280566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 10:12:26 -0800 (PST)
X-Received: by 2002:a17:906:5a5c:b0:a23:6708:cdd0 with SMTP id
 my28-20020a1709065a5c00b00a236708cdd0mr6801033ejc.88.1704305545696; Wed, 03
 Jan 2024 10:12:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home>
In-Reply-To: <20240103102553.17a19cea@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 10:12:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
Message-ID: <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 07:24, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Instead, just have eventfs have its own iterate_shared callback function
> that will fill in the dent entries. This simplifies the code quite a bit.

Much better. Now eventfs looks more like a real filesystem, and less
like an eldritch horror monster that is parts of dcache tackled onto a
pseudo-filesystem.

However, one request, and one nit:

> Also, remove the "lookup" parameter to the create_file/dir_dentry() and
> always have it return a dentry that has its ref count incremented, and
> have the caller call the dput. This simplifies that code as well.

Can you please do that as a separate patch, where the first patch just
cleans up the directory iteration, and the second patch then goes "now
there are no more callers that have the 'lookup' argument set to
false".

Because as-is, the patch is kind of two things mixed up.

The small nit is this:

> +static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  {
> +       /*
> +        * Need to create the dentries and inodes to have a consistent
> +        * inode number.
> +        */
>         list_for_each_entry_srcu(ei_child, &ei->children, list,
>                                  srcu_read_lock_held(&eventfs_srcu)) {
> -               d = create_dir_dentry(ei, ei_child, parent, false);
> -               if (d) {
> -                       ret = add_dentries(&dentries, d, cnt);
> -                       if (ret < 0)
> -                               break;
> -                       cnt++;
> +
> +               if (ei_child->is_freed)
> +                       continue;
> +
> +               name = ei_child->name;
> +
> +               dentry = create_dir_dentry(ei, ei_child, ei_dentry);
> +               if (!dentry)
> +                       goto out;
> +               ino = dentry->d_inode->i_ino;
> +               dput(dentry);
> +
> +               if (c > 0) {
> +                       c--;
> +                       continue;
>                 }

Just move this "is the position before this name" up to the top of the
loop. Even above the "is_freed" part.

Let's just always count all the entries in the child list.

And same for the ei->nr_entries loop:

>         for (i = 0; i < ei->nr_entries; i++) {

where there's no point in creating that dentry just to look up the
inode number, only to then decide "Oh, we already iterated past this
part, so let's not do anything with it".

This wouldn't seem to matter much with a big enough getdents buffer
(which is the normal user level behavior), but it actually does,
because we don't keep track of "we have read to the end of the
directory".

So every readdir ends up effectively doing getdents at least twice:
once to read the directory entries, and then once to just be told
"that was all".

End result: you should strive very hard to *not* waste time on the
directory entries that have already been read, and are less than
'ctx->pos'.

             Linus

