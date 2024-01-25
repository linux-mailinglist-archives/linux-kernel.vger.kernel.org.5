Return-Path: <linux-kernel+bounces-39121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD83183CB18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 988AEB256C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AE81386BB;
	Thu, 25 Jan 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZkHsCxq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D306D134757;
	Thu, 25 Jan 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207296; cv=none; b=IuU8QUgJyM0MnDvLspwCRMf4q470ZaeC6jD/uQ7lF5aueYWiWhvkRld8FxkW5A50oi02oIwCKuCcIzVHxNVIQuRtR3B1IXWXV5ZIhY6Q9h/iax6IZzA4Gzvepe9B9RlggwvZPNNfMABNVMXqWDWQPS9bArkszM/CVFaCavBEIMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207296; c=relaxed/simple;
	bh=N6ZEDuiUthyrFTNfqDI04qaw+c0qqDUfP3nYRGcwyjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMTOyYfwPUVlG+YSYDuF6XZ7fqW2Eu6Fu+VA8PSJYI6A6sODFFCq69/rivgruoYa8Hv6MxCPKE9+1+EaJErev2EjAfK/HSMLH4wYFi1wTE0Dk/biUVwSR8MdbFYaO7qjjxyTZvuSyASZ+7xAJikx5lGii4cd0+XmJVmoh2XxzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZkHsCxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F4BC43390;
	Thu, 25 Jan 2024 18:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706207296;
	bh=N6ZEDuiUthyrFTNfqDI04qaw+c0qqDUfP3nYRGcwyjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BZkHsCxqRg4uKfWIIAzrh35ZHF7uOs8Fold3RkOXJ8QpcxrOvoVP6RdBSCMFwzcHf
	 YFkyhLj8woDGjGb6oHqlimvo0hi5+1LR00Cq0FhMCEoxELdwkjRDf+3Cloebwsmv3Z
	 7OdYixQINOjG146LOn12MJj1UdZ1v4mRvgzuzHoYt8IfnL0ex0yuWemnlDrw+YJ7C3
	 ou1rLvom/37mMFfjPK8ziz+IdFlxdbbWXUe43KyhIYT8nIy5OF3magR6ZIwTOjZwEw
	 wkAfL3cLYULfY9V2bvsJckv0ea0Um/ptsrs7iNBglrnw3UM+hxOyJdEmbgyMZPMe9+
	 ZhMuAFfPJPhFA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf33b909e8so9713321fa.0;
        Thu, 25 Jan 2024 10:28:16 -0800 (PST)
X-Gm-Message-State: AOJu0YyvLkpEuGWVi6YX3OzM14VlBpoPP3M7dxkOB1CDPTEmQcufMQ3y
	nsgPd8ylp9Knl6w1+DZjb0lqTc9R4C64bK7dDGO5UKYnPISaD7wbXXOxBji67SqTGfYFPHiZo9A
	r+NHw7IIID64+lOARE3E2BRerWVw=
X-Google-Smtp-Source: AGHT+IF4A+Ju+VLoXBiDORGvr3AIpO6hZuYmyrpVf8uXLhHDJf4q1S9Z2/98OeaA5FJkEYmlY6Xk9DZVHViKbc6Mtb0=
X-Received: by 2002:a2e:be20:0:b0:2cf:15be:462e with SMTP id
 z32-20020a2ebe20000000b002cf15be462emr185537ljq.11.1706207294732; Thu, 25 Jan
 2024 10:28:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123234731.work.358-kees@kernel.org> <CAMj1kXGcKBPnHOm6PtsrxePdv5a6AokB=qvMrwvGmPh_Uk6vsA@mail.gmail.com>
 <202401250958.11B29BE48@keescook>
In-Reply-To: <202401250958.11B29BE48@keescook>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 25 Jan 2024 19:28:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHKTWy7kyHNYD0+JbbDqEreL7efatDZ9VLKPbXhVVVdqw@mail.gmail.com>
Message-ID: <CAMj1kXHKTWy7kyHNYD0+JbbDqEreL7efatDZ9VLKPbXhVVVdqw@mail.gmail.com>
Subject: Re: [PATCH] smb: Work around Clang __bdos() type confusion
To: Kees Cook <keescook@chromium.org>
Cc: Steve French <sfrench@samba.org>, Nathan Chancellor <nathan@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, 
	llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 19:00, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jan 25, 2024 at 01:19:19PM +0100, Ard Biesheuvel wrote:
> > On Wed, 24 Jan 2024 at 00:47, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Recent versions of Clang gets confused about the possible size of the
> > > "user" allocation, and CONFIG_FORTIFY_SOURCE ends up emitting a
> > > warning[1]:
> > >
> > > repro.c:126:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
> > >   126 |                         __write_overflow_field(p_size_field, size);
> > >       |                         ^
> > >
> > > for this memset():
> > >
> > >         int len;
> > >         __le16 *user;
> > >         ...
> > >         len = ses->user_name ? strlen(ses->user_name) : 0;
> > >         user = kmalloc(2 + (len * 2), GFP_KERNEL);
> > >         ...
> > >         if (len) {
> > >                 ...
> > >         } else {
> > >                 memset(user, '\0', 2);
> > >         }
> > >
> > > While Clang works on this bug[2], switch to using a direct assignment,
> > > which avoids memset() entirely which both simplifies the code and silences
> > > the false positive warning. (Making "len" size_t also silences the
> > > warning, but the direct assignment seems better.)
> > >
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > Closes: https://github.com/ClangBuiltLinux/linux/issues/1966 [1]
> > > Link: https://github.com/llvm/llvm-project/issues/77813 [2]
> > > Cc: Steve French <sfrench@samba.org>
> > > Cc: Paulo Alcantara <pc@manguebit.com>
> > > Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> > > Cc: Shyam Prasad N <sprasad@microsoft.com>
> > > Cc: Tom Talpey <tom@talpey.com>
> > > Cc: linux-cifs@vger.kernel.org
> > > Cc: llvm@lists.linux.dev
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  fs/smb/client/cifsencrypt.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
> > > index ef4c2e3c9fa6..6322f0f68a17 100644
> > > --- a/fs/smb/client/cifsencrypt.c
> > > +++ b/fs/smb/client/cifsencrypt.c
> > > @@ -572,7 +572,7 @@ static int calc_ntlmv2_hash(struct cifs_ses *ses, char *ntlmv2_hash,
> > >                 len = cifs_strtoUTF16(user, ses->user_name, len, nls_cp);
> > >                 UniStrupr(user);
> > >         } else {
> > > -               memset(user, '\0', 2);
> > > +               *(u16 *)user = 0;
> >
> > Is 'user' guaranteed to be 16-bit aligned?
>
> It's the first two bytes of a kmalloced address range, which I'm nearly
> certain will be sanely aligned, as those allocs are commonly used for
> holding structs, etc.
>

Ah yes, this kmalloc() was carefully hidden in the commit log :-)

