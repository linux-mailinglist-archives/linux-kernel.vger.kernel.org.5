Return-Path: <linux-kernel+bounces-7642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC12181AB24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FC528232F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB44AF64;
	Wed, 20 Dec 2023 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hakddRLq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57145C09
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d9f4eed60eso124261a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703115618; x=1703720418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT9ddCwESgsBoC0klthrCGoZVKiU2GhW3IYmRpWSVN4=;
        b=hakddRLqIxBqscujWUaIheFFI1t5+YhWYJr9fd2/1GNQEpsHdHPQjqkgYHYLy25pIQ
         U6x3mDdOdvwSLBgFVTnREr8yUNL8j254i+Cv0B8UmIAVRJb/Qeel3DfMr0zUVc+aqjhy
         llq6gjyQzvtbr8uxhl8oMcCcUQSQPB4e4thuLZIhh9ftRw3BCOSIZsGmTbruQkgOUk+n
         Mhk9z+9En4uxzyy2NCplegfJuGvMlEc4F0YVjq9y+/krTTEeLGJOl7yxhU7QgcGP5ogr
         Lpqz/TzAPvsN/IzDQhHxr/wgxfBRC8dzFUr8p73ggEaBrgLy0grcKSW6Jnj6GNmDlGX6
         qtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703115618; x=1703720418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT9ddCwESgsBoC0klthrCGoZVKiU2GhW3IYmRpWSVN4=;
        b=Q7H0oZkM+WRXKB88nTSZWC2smXIOeiltBXlQBnhdEE7O8QG2GL3QGnF7Ub+/oiOMQL
         CkeMB/mgek0Rs0NeqrXr8Mbc/rwxJPM7YyOhfanKfCTzrqlxFoIUoAOaJVkjzh7fAHPh
         U9qn6CWbClIQYfObQ+USwzr2s1Te4fylKhzqdixHNUXykeBWw7Y8RlqAgo8rJhAMXUh0
         X6qXuLD9ahJrNfrohyQpI8XTkgZJ5H7kMmyH9xhvowho3QuzvS9A2jR/V9AqDN0kSQS8
         K8r3Iv6a0irbFv84CflIHtCkoWv3NAAHK2C4FfUM8MuvUGCQxdzU39pcFkyXDkCk3iru
         cARw==
X-Gm-Message-State: AOJu0YxnBmoAdYeMJnwk5UKFl7oRqUZH1teW5FeN/l4qumgDHuAZ1+JL
	czzu21jT+FMGCu5TKv4NGuHhswT4fHmXd3kkdvFtPOecJb/U6hrUvc4=
X-Google-Smtp-Source: AGHT+IFl1yH9HmEtW/GRt/3W2yqcGB7F1oFfk9bZiSKJ12kXycsrXzJ5TDlaI7WhVRoyr+AHA0ljXKlr1IzXq/x2Slk=
X-Received: by 2002:a05:6830:18c2:b0:6d9:f031:4e76 with SMTP id
 v2-20020a05683018c200b006d9f0314e76mr20116594ote.69.1703115618088; Wed, 20
 Dec 2023 15:40:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312191507.348721d2-oliver.sang@intel.com> <20231219095821.GAZYFpPUSKexZAcl05@fat_crate.local>
 <CAHk-=wimbX8UF6ECo53Hm4Vz0tCC7jjN9e3tEhZfoEtsxyfU-A@mail.gmail.com>
 <87013f74-5828-4bef-848b-ffedde8e86f5@citrix.com> <CAHk-=wh=z-aXw6o8Hi9SiC5-vwP403-ZpDHUOXdXmLbaG93dvQ@mail.gmail.com>
 <CAHk-=whfpRxuucUL1oguRivq0e7JSxNWC2p_6gvKriNTHmr0UQ@mail.gmail.com>
In-Reply-To: <CAHk-=whfpRxuucUL1oguRivq0e7JSxNWC2p_6gvKriNTHmr0UQ@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 20 Dec 2023 15:39:40 -0800
Message-ID: <CABCJKud8PG_ho79it34JxHG07n_Kbe9SLeBkEJwMYP_kS80D_g@mail.gmail.com>
Subject: Re: [linus:master] [x86/entry] be5341eb0d: WARNING:CPU:#PID:#at_int80_emulation
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Borislav Petkov <bp@alien8.de>, 
	kernel test robot <oliver.sang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 3:15=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Tue, 19 Dec 2023 at 12:17, Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
> >
> > That said, I still think that just getting rid of this horrid special
> > case for posix timers is the right thing, and we should just remove
> > that SYS_NI() alias thing entirely.
>
> IOW, something like the attached patch.
>
> It's not extensively tested, but hey, the diffstat looks nice:
>
>   arch/arm64/include/asm/syscall_wrapper.h |  4 ---
>   arch/riscv/include/asm/syscall_wrapper.h |  5 ----
>   arch/s390/include/asm/syscall_wrapper.h  | 13 +--------
>   arch/x86/include/asm/syscall_wrapper.h   | 34 +++---------------------
>   kernel/sys_ni.c                          | 14 ++++++++++
>   kernel/time/posix-stubs.c                | 45 -------------------------=
-------
>   6 files changed, 19 insertions(+), 96 deletions(-)
>
> and it builds in at least a *couple* of configurations, including with
> CONFIG_POSIX_TIMERS disabled.
>
> I did *not* check whether it might fix the warning, since I doubt my
> user space would even boot without that posix timer support (actually,
> honestly, because I'm just lazy and "it _looks_ fine to me" was the
> main real thing).

I tested the patch with the 0-day bot reproducer and it does fix the
warning. My usual arm64 and riscv configs also seem to build and boot
just fine.

> But that SYS_NI() thing really does deserve to die, as it was purely
> used as a hack for some random timer system calls.
>
> Comments?

Removing the SYS_NI bits is definitely a cleaner solution. Looks good to me=
.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Sami Tolvanen <samitolvanen@google.com>

Sami

