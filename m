Return-Path: <linux-kernel+bounces-103642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEF787C25D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EAF1F21B90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA02B74C01;
	Thu, 14 Mar 2024 18:01:51 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FCD70CCB;
	Thu, 14 Mar 2024 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710439311; cv=none; b=itLMM+8ZAyCmdAMezdSwJnK9DDuNxg/VWQL1RZ96PXssG+kOk9LjJVuFtTrJOlPT4CfRpNOnKKzr6B4gd4GwaVx5z77+Au2Ye96ULNgGruX9ygd/6yAarQl7/XSxbvlB53g47szARlTYSlrADAlw3aNFMNgcb1noXWLnO6IY0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710439311; c=relaxed/simple;
	bh=+XSMUuSZTYPv/X36ZrMXS/2Gc+s7h2uYU5OB12gYChA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUfrdVVANz2jIfePQmcpZEQd0z0si+XOQSU7qwts8LvE6NkFNix8hWBVNGcs9C/qISLvfkyq0zTY5Qek30vAeOyTOQZOvlpwp/1orj2u8FNqmQrePc9htfj79LQVT+c6hoPkd5D4IOwNnNHVoVUEn4SEiK9XShE0AdBKXiTDcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id E50DA72C8FB;
	Thu, 14 Mar 2024 21:01:44 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id C92F07CCB3A; Thu, 14 Mar 2024 20:01:44 +0200 (IST)
Date: Thu, 14 Mar 2024 20:01:44 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	LSM List <linux-security-module@vger.kernel.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-api@vger.kernel.org,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
	John Johansen <john.johansen@canonical.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3] LSM: use 32 bit compatible data types in LSM syscalls.
Message-ID: <20240314180143.GA26431@altlinux.org>
References: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com>
 <ef972e0088964722adffc596d38b0463@paul-moore.com>
 <CAHC9VhQc-DEf=kSxbG-Mvz8jq-gxkaCe2jHb2a9LsJLQydj1zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQc-DEf=kSxbG-Mvz8jq-gxkaCe2jHb2a9LsJLQydj1zQ@mail.gmail.com>

On Thu, Mar 14, 2024 at 11:30:53AM -0400, Paul Moore wrote:
> On Wed, Mar 13, 2024 at 4:07 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mar 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >
> > > LSM: use 32 bit compatible data types in LSM syscalls.
> > >
> > > Change the size parameters in lsm_list_modules(), lsm_set_self_attr()
> > > and lsm_get_self_attr() from size_t to u32. This avoids the need to
> > > have different interfaces for 32 and 64 bit systems.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: a04a1198088a: ("LSM: syscalls for current process attributes")
> > > Fixes: ad4aff9ec25f: ("LSM: Create lsm_list_modules system call")
> > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Reported-and-reviewed-by: Dmitry V. Levin <ldv@strace.io>
> > > ---
> > >  include/linux/lsm_hook_defs.h                        |  4 ++--
> > >  include/linux/security.h                             |  8 ++++----
> > >  security/apparmor/lsm.c                              |  4 ++--
> > >  security/lsm_syscalls.c                              | 10 +++++-----
> > >  security/security.c                                  | 12 ++++++------
> > >  security/selinux/hooks.c                             |  4 ++--
> > >  security/smack/smack_lsm.c                           |  4 ++--
> > >  tools/testing/selftests/lsm/common.h                 |  6 +++---
> > >  tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 10 +++++-----
> > >  tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
> > >  tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
> > >  11 files changed, 38 insertions(+), 38 deletions(-)
> >
> > Okay, this looks better, I'm going to merge this into lsm/stable-6.9
> > and put it through the usual automated testing as well as a kselftest
> > run to make sure everything there is still okay.  Assuming all goes
> > well and no one raises any objections, I'll likely send this up to
> > Linus tomorrow.
> 
> I had to squash the code snippet below into the patch to address a
> build problem identified by the kernel build robot.  I'm going to keep
> Casey's sign-off and Dmitry's reported-reviewed tag as I feel this
> change is minor, but if anyone has any objections please let me know
> soon.
> 
> [NOTE: cut-n-paste'd into email, likely whitespace damage, but you get the idea]
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 77eb9b0e7685..e619ac10cd23 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -960,10 +960,10 @@ asmlinkage long sys_cachestat(unsigned int fd,
>                struct cachestat __user *cstat, unsigned int flags);
> asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, un
> signed int flags);
> asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> -                                     size_t *size, __u32 flags);
> +                                     u32 *size, u32 flags);
> asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> -                                     size_t size, __u32 flags);
> -asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
> +                                     u32 size, u32 flags);
> +asmlinkage long sys_lsm_list_modules(u64 *ids, u32 *size, u32 flags);

Fine with me, thanks.

btw, with the change above, u32 will become about twice more popular
in include/linux/syscalls.h than __u32.


-- 
ldv

