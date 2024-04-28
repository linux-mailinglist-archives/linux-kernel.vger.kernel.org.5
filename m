Return-Path: <linux-kernel+bounces-161369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B7E8B4B3B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68AD1C20A6B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D756B81;
	Sun, 28 Apr 2024 10:20:39 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727865675F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714299639; cv=none; b=tsCieu6IiATmhvyomb1UmIMT0uNA3XnN3v+AQG5y994em0FXYyScjOhHttD0P2E7XOqMsu2xYT8W41FN/i9B10qX9i2jisRK+GoH/S/QUMI351EkVWTrt8dD1+AZxSbF9eow5T8fuFtTFNJFQQWnC3hqKezxVrnLiUTXRbGqlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714299639; c=relaxed/simple;
	bh=0KCSf97xhCyy4fk36LXoT6qkCb4jI9/Um5OMJ+dSoko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLAsHP+oqX/Wjuz7H+rKy/WxXwMx3x0w/utGfpLDkwWYy6pqDFT8cRvZiI5CbteSZPS5AlPgTU+K57jWmn/p81cZSdc5YwR1x2HyjE+bmx86tRBqMIeQpaEgfwV2xaw2JAKqYsuzRPdPgQnMDdKZArT0itiv0FlGAtGXZwMbq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43SAJqfW099414;
	Sun, 28 Apr 2024 19:19:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sun, 28 Apr 2024 19:19:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43SAJq3e099411
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 28 Apr 2024 19:19:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
Date: Sun, 28 Apr 2024 19:19:52 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jirislaby@kernel.org>
References: <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV>
 <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <c95c62ba-4f47-b499-623b-05627a81c601@I-love.SAKURA.ne.jp>
 <2023053005-alongside-unvisited-d9af@gregkh>
 <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh>
 <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/28 4:02, Linus Torvalds wrote:
> On Fri, 26 Apr 2024 at 23:21, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> syzbot is reporting data race between __tty_hangup() and __fput(), for
>> filp->f_op readers are not holding tty->files_lock.
> 
> Hmm. I looked round, and we actually have another case of this:
> snd_card_disconnect() also does
> 
>                         mfile->file->f_op = &snd_shutdown_f_ops;

OK. That one needs to be fixed as well.

> 
> and I don't think tty->files_lock (or, in the sound case,
> &card->files_lock) is at all relevant, since the users of f_ops don't
> use it or care.

More precisely, the users of f_op can't access it. For example,
do_splice_read() cannot understand that "in" argument refers to a tty
device and therefore will not know about tty->files_lock.

> 
> That said, I really think we'd be better off just keeping the current
> model, and have the "you get one or the other". For the two cases that
> do this, do that f_op replacement with a WRITE_ONCE(), and just make
> the rule be that you have to have all the same ops in both the
> original and the shutdown version.

If we keep the current model, WRITE_ONCE() is not sufficient.

My understanding is that KCSAN's report like
https://elixir.bootlin.com/linux/v6.9-rc5/source/Documentation/dev-tools/kcsan.rst#L56
will remain unless we wrap all f_op readers using data_race() macro. That is,
we will need to define a wrapper like

static inline struct file_operations *f_op(struct file *file)
{
	/*
	 * Ignore race in order to silence KCSAN, for __tty_hangup() or
	 * snd_card_disconnect() might update f_op while file is in use.
	 */
	return data_race(file->f_op);
}

and do for example

-	if (unlikely(!in->f_op->splice_read))
+	if (unlikely(!f_op(in)->splice_read))

for https://elixir.bootlin.com/linux/v6.9-rc5/source/fs/splice.c#L977 and

-	return in->f_op->splice_read(in, ppos, pipe, len, flags);
+	return f_op(in)->splice_read(in, ppos, pipe, len, flags);

for https://elixir.bootlin.com/linux/v6.9-rc5/source/fs/splice.c#L985 .

Are VFS people happy with such change? I guess that VFS people assume that
file->f_op does not get updated while file is in use. Also, such data_race()
usage does not match one of situations listed in
https://elixir.bootlin.com/linux/v6.9-rc5/source/tools/memory-model/Documentation/access-marking.txt#L58 .

> 
> I do *not* think it's at all better to replace (in two different
> places) the racy f_op thing with another racy 'hungup' flag.

This approach allows VFS people to assume that file->f_op does not
get updated while file is in use.

> 
> The sound case is actually a bit more involved, since it tries to deal
> with module counts. That looks potentially bogus. It does
> 
>                         fops_get(mfile->file->f_op);
> 
> after it has installed the snd_shutdown_f_ops, but in snd_open() it
> has done the proper
> 
>         replace_fops(file, new_fops);

replace_fops() is intended to be used *ONLY* from ->open() instances.

> 
> which actually drops the module count for the old one. So the sound
> case seems to possibly leak a module ref on disconnect. That's a
> separate issue, though.
> 
>                       Linus
> 
>                     Linus


