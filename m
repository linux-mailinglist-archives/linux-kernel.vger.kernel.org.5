Return-Path: <linux-kernel+bounces-31865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D800A8335A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174A61C20DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4789B12E6A;
	Sat, 20 Jan 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GKxhmoYn"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D02125D2
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705774646; cv=none; b=To3S+wW+4pLLSkan4MkrCj6GRKeyW5xl55LvF6gsYMyQLfuZhmsnSBIxuIZILDOkLNkygSMQgaODxPpYM7rrooXo7H58+1aOVsNlfo1Y811ctCKZa+JVv5MzGsn9aiKCBwjdKFfMmkEGvk8yNxI7XOl0tISytd/mWw1QpHphiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705774646; c=relaxed/simple;
	bh=fIC8UyA2SJ+rQ9HXjA9+oJdd+ykAcxESDRxWvttEpjE=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=LfwkOoiarrwGWUHAbtz6SQV9uYe7gA+Ya/E2TG4+clFspxFWRUol8cTtMfyFzCEWbafXjfcnYxDmP5MaKY6o2Xzp2HOGk+3zPSlg6JxuLXF+vENXNjxcSQQ544gDdVjWsr5/hhVOJxTJPq3MOF4KjxhPxiaXWxK5ANADOBH7SLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GKxhmoYn; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ddf1e88e51so1362979a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 10:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705774643; x=1706379443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMn1BToJweaOcxOlaPFoVzSkf5fWzkYqaJwxOtEOARU=;
        b=GKxhmoYnq7FDglkVeurUdRhm9S6Tz0q+rl02c9EqAliuG0GnOZWgr0jSbb0firJHHI
         x78NidbTE+R4l+nH0hq6xC6y20yFRzfWFtIB0AvK4epV4ie/NmMHhpP9dsE1KIe+XHxV
         MPXatI4ydf7bI9rmnBlQp1Nw5lfYQwXjt8UAm7Vcqdy+zdxrZAxtHImHwfl+OP4vR7x4
         HQxXac4/YqQtwomGbnaKGmwPG7i799WKrQzwncqX3b6ifbTVRZf+47d0rOHEwp6M5DH8
         rJJd7oZ3SPOjJMedcWirC9bGCOk+7MCx7n7+rXvtcUYZZ6XFGSx8lvTCl5Xord89HzFw
         53xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705774643; x=1706379443;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMn1BToJweaOcxOlaPFoVzSkf5fWzkYqaJwxOtEOARU=;
        b=gQO3KhLJObWhYpNyBMSAMTL+h2ZR7+2m4QAIa2LpveZ/mIwIRfOW83f95yoOEQgFcE
         DCiGC7rAts95iL39KS3l2Hr6ps6XjFBteaFScAgHh41gUWCBsYhotdJQA5WGnXvq+vOn
         H/dmENJEF+7J5SqFYQzf4FnFL2Gts0M5joLYxTIqAFUwios36hO9liycx3LePHb46ro9
         RX9aCjbGxWwrIpO8r1pxjwt8JMU1Gu6vkYiQjnQQ5VxIOxbn8O4L7RCVWy+hhlSH+K3+
         ntO+bHQLiBPjbc7mCDm8V92Q6ydebQ9VDnyVgCuFCceVS8MOlXz/Hczyd8WAQV8W+8LP
         12Rw==
X-Gm-Message-State: AOJu0YzT7/pQ717Thm4Ap5aK3KezUjOgPMNiQqkmTAvRETLUmsSKrK8w
	vCw8V3zZHGUlatf1bZdMpqWt7iUOYLaLYdPw7yn5objt8i0mYyhB2i6V0yYjaWTyuZdM//6BE2l
	k
X-Google-Smtp-Source: AGHT+IEum8xz+FQyjPn5YMF2KgAk6IYGtXt+WEaAbqQ608bG4G6PJg/dlD4Iy3ZTC8KPmWj5nOaw5Q==
X-Received: by 2002:a05:6808:2227:b0:3bd:99d1:e22c with SMTP id bd39-20020a056808222700b003bd99d1e22cmr2077156oib.26.1705774643490;
        Sat, 20 Jan 2024 10:17:23 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id sl7-20020a17090b2e0700b0028bbf4c0264sm6339947pjb.10.2024.01.20.10.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 10:17:22 -0800 (PST)
Date: Sat, 20 Jan 2024 10:17:22 -0800 (PST)
X-Google-Original-Date: Sat, 20 Jan 2024 10:03:11 PST (-0800)
Subject:     Re: [GIT PULL] RISC-V Patches for the 6.8 Merge Window, Part 3
In-Reply-To: <CAHk-=wimDL8m=hETgzazd4W23PtBQ_K=E80mkuqhx0H=8BpWQA@mail.gmail.com>
CC: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-14d0b845-9a7e-49aa-b151-7f123a51e0db@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

[Moving this back to linux-kernel@vger.kernel.org, for some reason I changed my
alias to linux-kernel@subspace.kernel.org which doesn't actually exist.]

On Sat, 20 Jan 2024 09:42:08 PST (-0800), Linus Torvalds wrote:
> On Sat, 20 Jan 2024 at 06:52, Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> The last one is particularly clunky, as I've just squashed the fix into a merge
>> from your tree.
>
> _Please_ don't use back-merges to pre-merge things before sending me a
> pull request.
>
> Just let me know about the semantic conflict, and send your tree as it
> works for you. Then, as I merge your tree, I can take care of the
> actual conflicts.
>
> IOW, I really _really_ want developers to worry about *their* changes.
>
> Yes, linux-next is then there to give a heads-up about how these
> changes end up interacting, and you should be aware of it enough to
> send me a heads-up. But that's literally all - you should *not* then
> merge in other peoples changes into your tree.
>
> IOW, a conflict with other trees that got noticed in linux-next should
> just result in that note to me about the conflict once you send your
> tree to me.
>
> Not a random merge of a random commit that came in through another random tree.
>
> One result of that random merge is then your messy diffstat. Your pull
> request claims this:
>
>  443 files changed, 7415 insertions(+), 4420 deletions(-)
>
> but that's literally because you got that random noise from pulling in
> the state from the tty tree that had *nothing* to do with your RISC-V
> changes. The real diffstat if you don't have that last merge is
>
>  71 files changed, 2678 insertions(+), 215 deletions(-)
>
> and ends up looking much saner (ie it actually lists just arch/riscv/
> and the incidental changes around selftests etc that actually happened
> in your tree).

OK, sorry for that.

> So please send a new pull request where you just have *your* tree
> changes, not a random back-merge.

I think it's actually pretty simple for this one, I'm just backing up to 
the previous commit (as that nasty merge was at the tip of the tree).  
So I've set along 
https://lore.kernel.org/r/mhng-878cc879-7aa0-473f-91e4-8288072cdd4e@palmer-ri-x1c9/ 
, which doesn't have the merge and instead just calls out the diff in 
the comment.

>
>               Linus

