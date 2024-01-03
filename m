Return-Path: <linux-kernel+bounces-16062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5586A82379A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91792840A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA541DA4E;
	Wed,  3 Jan 2024 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CfoMUGTw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62B1DA38
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28b1095064so82114566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704320261; x=1704925061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ggectDD1sVFfFuxF/ttgx0s4Ggo2HATlFxfh+QjmL3o=;
        b=CfoMUGTw2GdwxyRQnnMtqmN+XUJ6zHHXhmB4U80Ncv+sTDlJQk+QKtDL1TRwjstHye
         yGKE+JpjSZ+cUFpg4kVzScq6H37aspIuLV6u5kly4X5M/ZjmKiqXaxf2tVt4V0pSoCaK
         X7CGIsEFxKs0MFeRF6j6rvB5kzRFuCPalIgTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704320261; x=1704925061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggectDD1sVFfFuxF/ttgx0s4Ggo2HATlFxfh+QjmL3o=;
        b=qBl6Aj03w1dFagS0erpl7vBL3aKeBau12/dOOXGschNr9DzfrR6tvLx9hhgt4i0E2N
         xjPIhkxZyh0BAv847N6YoqnJmDbLcVw2x8MNi5rR8qzGsu/jb3B0s3g4FOPRwtnuJNAG
         ZvuYO4kNedpgXA8SCveKX1JR6Ipzl5GI+iexM13nsZNIJX0LwjcsutbYK6leAopTV7fP
         +NXiFqWbyNCkdpBj4RDn+Kp5o9CXxq75l/ooBMcgU4uoqSzFGvxR9LnpOZEujZT6YiwM
         6ZuZW8YYBkCWCpH/Yvjmob0L1Sald8tr5rEA1MR59QoEqfT/4m6bNYWL5yrWNwLaEAI3
         Rf7A==
X-Gm-Message-State: AOJu0Yy6sZ6CliJXbkZLUeM3weK5uzTu4pPRyOtvZJOO0OA0WR1wWwNg
	LUQHHlnPPuOLKbdrdkxKugFBKnxUIgh+qKn/cM09uRfp+DkFVMA6
X-Google-Smtp-Source: AGHT+IFNl507ZSLGfCFTJB3Ggc7lrPipDF5egg9gFL79GMJWDGQv5Rf4C028EzzLUlmfxt6VpplZCg==
X-Received: by 2002:a17:906:7154:b0:a28:1c2e:7bee with SMTP id z20-20020a170906715400b00a281c2e7beemr1161689ejj.282.1704320260963;
        Wed, 03 Jan 2024 14:17:40 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id fg8-20020a1709069c4800b00a1fa7e39957sm13206990ejc.136.2024.01.03.14.17.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 14:17:40 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso7929199a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:17:40 -0800 (PST)
X-Received: by 2002:a17:906:73c9:b0:a27:db5c:8a4a with SMTP id
 n9-20020a17090673c900b00a27db5c8a4amr1618752ejl.213.1704320259797; Wed, 03
 Jan 2024 14:17:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
 <20240103145306.51f8a4cd@gandalf.local.home> <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
 <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com> <20240103221444.GM1674809@ZenIV>
In-Reply-To: <20240103221444.GM1674809@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 14:17:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgHEyd2z-KvaV6ndKSqGjkisE0MBEXsFkkxeicHTUy-Xg@mail.gmail.com>
Message-ID: <CAHk-=wgHEyd2z-KvaV6ndKSqGjkisE0MBEXsFkkxeicHTUy-Xg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 14:14, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Jan 03, 2024 at 01:54:36PM -0800, Linus Torvalds wrote:
>
> > Again: UNTESTED, and meant as a "this is another way to avoid messing
> > with the dentry tree manually, and just using the VFS interfaces we
> > already have"
>
> That would break chown(), though.

Right,. That's why I had that note about

   So take this as a "this might work", but it probably needs a bit more
   work - eventfs_set_attr() should set some bit in the inode to say
   "these have been set manually", and then revalidate would say "I'll
   not touch inodes that have that bit set".

and how my example patch overrides things a bit *too* aggressively.

That said, I think the patch that Steven just sent out is the right
direction to go regardless. The d_revalidate() thing was literally
just a "we can do this many different ways".

                     Linus

