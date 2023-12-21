Return-Path: <linux-kernel+bounces-9017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E7981BF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A2C288744
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD374E21;
	Thu, 21 Dec 2023 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="btJLFqeh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593CE745C9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40b5155e154so14456525e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703188923; x=1703793723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QIRteLYRFk8XTtG6H0ylz2RcK42VRX4JCV0tvN7ueI=;
        b=btJLFqeh6UJ9s2TlncpT/sujsfAd9t9kjn19vH7ZOnmWHiyvoKmQWNedg5AUOtjdz5
         xIftggRU4doYIs/yiMaGxG1r6DVv6YAphp/WwageZFQlve0UW9x+nHgK25zC3eb5RUu1
         KV36j6pBaTrc8/h9TJsUuzc9cDITrkYLqapCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703188923; x=1703793723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QIRteLYRFk8XTtG6H0ylz2RcK42VRX4JCV0tvN7ueI=;
        b=A0zSvlcYFc6vibLJ9ZMnKAPScRXae7gP5YW+aJgHMoH5aQUkp9mYrHDIAnjg1707OG
         3Z3OJRchIx30doDH3FXbFXfS69LR+9vJBQgI6qXGARQShLB643Sy7bS5eucu2nqTi7r/
         OfJz8FRzpLeiJvVsnM4jcVO+9s+6AjV+yPmOOvdFef+n8+Z7bPPuEI1WeajQpEkfJFHX
         IKot7MMnJezZnJ1jzCv2B2TCIhhgK50itB/vSHJ+hrJSGA9qb7qoGGpw9ScTe7gfnmYo
         otpTdfY25IWbtH+9bkILBV3Z37HliafIFWDKHTEN0Iq36aNYOJeoI0OBgLJ1/a9+QnTP
         0akw==
X-Gm-Message-State: AOJu0Yzc4lootCfZHXCdvXPyCkjmM6887tpt9ocLP2TZ5MMmuwsLqa8V
	d3JSl2OxK5HGAByNVjQ5C3/mPuD2GmHMm8CoNRPlW+n9QEJZXoHe
X-Google-Smtp-Source: AGHT+IEEDNchIjUpmzfBx6wDyzmnJq+dPu8th6+HKfsE+dH7kumnXXJZRKL1L4hoTjA9o4omYal9ng==
X-Received: by 2002:a05:600c:602a:b0:40c:32f2:2c18 with SMTP id az42-20020a05600c602a00b0040c32f22c18mr133432wmb.143.1703188923343;
        Thu, 21 Dec 2023 12:02:03 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id wi22-20020a170906fd5600b00a2693ce340csm1291207ejb.59.2023.12.21.12.02.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 12:02:02 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a233a60f8feso135344966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:02:02 -0800 (PST)
X-Received: by 2002:a17:906:2208:b0:a23:2e46:84cc with SMTP id
 s8-20020a170906220800b00a232e4684ccmr136613ejs.153.1703188922296; Thu, 21 Dec
 2023 12:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221102703.08dc1273@gandalf.local.home> <CAHk-=wiwQtUHvzwyZucDq8=Gtw+AnwScyLhpFswrQ84PjhoGsg@mail.gmail.com>
 <20231221142841.48b13ba4@gandalf.local.home>
In-Reply-To: <20231221142841.48b13ba4@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Dec 2023 12:01:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjmUr93TFgpZ6ew3t5XFO2Cyxb8wnRENCkWvrH8m9XEOA@mail.gmail.com>
Message-ID: <CAHk-=wjmUr93TFgpZ6ew3t5XFO2Cyxb8wnRENCkWvrH8m9XEOA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: A few more fixes for 6.7
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 11:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Luckily, that's easy to get to. All I need to do is:
>
> static void update_inode_attr(struct dentry *dentry, struct inode *inode,
>                               struct eventfs_attr *attr, umode_t mode)
> {
>         struct tracefs_fs_info *fsi = dentry->d_sb->s_fs_info;
>         struct tracefs_mount_opts *opts = &fsi->mount_opts;
>
>         /* Default the ownership to what it was mounted as */
>         inode->i_uid = opts->uid;
>         inode->i_gid = opts->gid;

I think you should add

>         inode->i_mode = mode;

to that "default setup", which not only makes things more consistent,
it also means that you can then remove it from here:

>         if (!attr) {
>                 inode->i_mode = mode;
>                 return;
>         }

.. and the 'else' side from here:

>         if (attr->mode & EVENTFS_SAVE_MODE)
>                 inode->i_mode = attr->mode & EVENTFS_MODE_MASK;
>         else
>                 inode->i_mode = mode;

and it all looks a lot more clear and obvious.

"Set things to default values, then if we have attr and the specific
fields are set in those attrs, update them".

Instead of having this odd "do one thing for git/uid, another for mode".

> > I still claim that the whole dynamic ftrace stuff was a huge mistake,
> > and that the real solution should always have been to just use one
> > single inode for every file (and use that 'attr' that you track and
> > the '->getattr()' callback to make them all *look* different to
> > users).
>
> Files now do not even have meta-data, and that saved 2 megs per trace
> instance. I only keep meta data for the directories. The files themselves
> are created via callback functions.

I bet that was basically *all* just the inodes.

The dentries take up very little space, and the fact that you didn't
keep the dentries around meant that you instead replaced them with
that 'struct eventfs_file' which probably takes up as much room as the
dentries ever did - and now when you use them, you obviously use
*more* memory since it duplicates the data in the dentries, including
the name etc.

So I bet you use *more* memory than if you just kept the dentry tree
around, and this dynamic creation has then caused a number of bugs and
a lot of extra complexity - things like having to re-implement your
own readdir() etc, much of which has been buggy.

And when you fix the resulting bugs, the end result is often
disgusting. I'm talking about things like commit ef36b4f92868
("eventfs: Remember what dentries were created on dir open"), which
does things like re-use file->private_data for two entirely different
things (is it a 'cursor' or a 'dlist'? Who can know? That thing makes
me gag).

Honestly, that was just one example of "that code does some truly ugly
things because the whole notion is mis-designed".

            Linus

