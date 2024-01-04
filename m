Return-Path: <linux-kernel+bounces-17172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 852F2824929
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BB4287218
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B262E2C855;
	Thu,  4 Jan 2024 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fmOjjJ9f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E002C859
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d894764e7so8416375e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704396955; x=1705001755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TLfuV7xsXyW+hLKhxRy2JmANDmog6uIMlY97oe3vpGA=;
        b=fmOjjJ9fZ+iJn4YSNSK/eJgX9cZ3H3w62EDHYon7+YnT2lIEQFQXj/GBYZb90oAcyq
         Rzd9/CsODZ5mz/sNjJeIpk1m7ajzHI+yVSeD5RMvpH+B15IyU7SaR+WN0ofc1NK1wZfs
         0fTiHiF+RAHO64CccNJcSVTeaToCfSSAPLXG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396955; x=1705001755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLfuV7xsXyW+hLKhxRy2JmANDmog6uIMlY97oe3vpGA=;
        b=v60dKJStmMl1d3T69S+Q1l0CAccGvp6qa3y5RbwszHTDfq/T8XtCRZG2csBu/XF9H5
         9V19Yu9N/ovUG5F08zSm5fxhPly6GUjjvffnk43WIRwM4ezzi03Z8nVJRRLwfg7k+4LN
         3QZvRH0mSlnYjqjqPn5kx+TnLOAF1SepGL5bn/Seg6u+FkdAdSZ5H2cfGxzfrhi5ebtW
         4DaJd1BPcuKLw6z0XU24ELBKlNzEd8zcJGcIkY2dZZ3Ac2t+eZC0WdvxksCTD/owCFZT
         9kAR+EHAXbfvwSjOrLboiP84nhruYkIAtlVHzrI4dE/KYwQkzB/wwSwGcIW0izbD3CQ5
         kynQ==
X-Gm-Message-State: AOJu0YzIcGC7cCq/TdnOT1sHH5BjpBj5C7mpqCWpoGHc5YzRwnQSXBmh
	OB+QB71AZT+DwTm4P8FRV97VThd4WO+1paagmZUL+KJWl8RZx9pI
X-Google-Smtp-Source: AGHT+IEaIkzrIUBpXAOJfcHbAzUMndcTbdg02Fjxg2SWFljy/v5BqBgf7bXf24pjBnufZkxbW4TyEA==
X-Received: by 2002:a05:600c:c0b:b0:40e:351d:53fd with SMTP id fm11-20020a05600c0c0b00b0040e351d53fdmr377601wmb.239.1704396955335;
        Thu, 04 Jan 2024 11:35:55 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id bg10-20020a170906a04a00b00a26a443e98esm13930367ejb.169.2024.01.04.11.35.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:35:54 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so105256566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:35:54 -0800 (PST)
X-Received: by 2002:a17:906:1194:b0:a28:b79a:37a0 with SMTP id
 n20-20020a170906119400b00a28b79a37a0mr367224eja.222.1704396954150; Thu, 04
 Jan 2024 11:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103203246.115732ec@gandalf.local.home> <20240104014837.GO1674809@ZenIV>
 <20240103212506.41432d12@gandalf.local.home> <20240104043945.GQ1674809@ZenIV>
 <20240104100544.593030e0@gandalf.local.home> <20240104182502.GR1674809@ZenIV> <20240104141517.0657b9d1@gandalf.local.home>
In-Reply-To: <20240104141517.0657b9d1@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 11:35:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgxhmMcVGvyxTxvjeBaenOmG8t_Erahj16-68whbvh-Ug@mail.gmail.com>
Message-ID: <CAHk-=wgxhmMcVGvyxTxvjeBaenOmG8t_Erahj16-68whbvh-Ug@mail.gmail.com>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default ownership
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 11:14, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> "file descriptor" - is just what maps to a specific inode.

Nope. Technically and traditionally, file descriptor is just the
integer index that is used to look up a 'struct file *'.

Except in the kernel, we really just tend to use that term (well, I
do) for the 'struct file *' itself, since the integer 'fd' is usually
not really relevant except at the system call interface.

Which is *NOT* the inode, because the 'struct file' has other things
in it (the file position, the permissions that were used at open time
etc, close-on-exec state etc etc).

> "file description" - is how the file is accessed (position in the file and
>                         flags associated to how it was opened)

That's a horrible term that shouldn't be used at all. Apparently some
people use it for what is our 'struct file *", also known as a "file
table entry".  Avoid it.

If anything, just use "fd" for the integer representation, and "file"
for the pointer to a 'struct file".

But most of the time the two are conceptually interchangeable, in that
an 'fd' just translates directly to a 'struct file *'.

Note that while there's that conceptual direct translation, there's
also very much a "time of use" issue, in that a "fd -> file"
translation happens at one particular time and in one particular user
context, and then it's *done* (so closing and possibly re-using the fd
after it's been looked up does not actually affect an existing 'struct
file *').

And while 'fd -> file' lookup is quick and common, the other way
doesn't exist, because multiple 'fd's can map to one 'struct file *'
thanks to dup() (and 'fork()', since a 'fd -> file' translation always
happens within the context of a particular user space, an 'fd' in one
process is obviously not the same as an 'fd' in another one).

               Linus

