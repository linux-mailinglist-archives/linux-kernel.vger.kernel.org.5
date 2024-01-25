Return-Path: <linux-kernel+bounces-38574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F01C83C26D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6445E1C2423F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E87845BF5;
	Thu, 25 Jan 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEcmHnK8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560336B10;
	Thu, 25 Jan 2024 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185172; cv=none; b=rb/NCgt05+ppoLc0f3dvLGUwNOr4Yk3JhL35P60cbkSIHgzW0nWJdUAW0wvShDUPWFPUW18Iz5Ud7T39l8Jpl+dDLAE24o+619aoClMVZPo/5FIAMJjeJGzjYXrVdJvF7XTltKFHwlAS4B2LxjVaI6Q5qG/6flnw3Q/XrDaDqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185172; c=relaxed/simple;
	bh=zfYp4IY/7X/+LaY5xSNFJhQT56Y8mXFU7V7bnUDoJjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/wCVAsC9jRzD+UgA51YTMaVkYKYTPWj/CdYm/nlFDH2dTGL/l4mBhUwhDKZnswn41NgxZxmhqB2O3+sXnrknrm/27pfB68hFbx+lFdjIbXcHsS/lwj9laZn2etfBYc9fY3PtjbAPRc4+b8aM3Y1ZEN+hmbSkjg08CgHSgtG7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEcmHnK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51006C43390;
	Thu, 25 Jan 2024 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706185172;
	bh=zfYp4IY/7X/+LaY5xSNFJhQT56Y8mXFU7V7bnUDoJjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oEcmHnK818I/Jm5CIXPiXFRUVUEYppaXM9myPO1toFGfuJwKcHJFeNfruu/o4VNH7
	 mG5lnXC/ogO/j3r8AWdOzk1rEjQ6CpXLoTlLn0g4Ghmlg9LxTy7GN7qpl2Rd65wuID
	 vAIoOp5UL9HsZwrZRVwigOzTPHk5tEv6m0XHjEzTHa+U0oomwBAaS3WwLb1+DyEmI3
	 5HGyspNEW+lOfq4NzmbgDy/FlFw2lCnTEper9YWLPwq1bpkV2SJ60dGJ6TT0MhdXeV
	 LD70rg68/nxLe0fH/QlHKshy3vLyCqqPOUWf1UZyUDO94iMSRorQDmDwxCptZySMg8
	 xFgBo8GhurSjQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf354613easo7720421fa.1;
        Thu, 25 Jan 2024 04:19:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yz6ylV7viiRwEYrBzfr2n+XsPXPuakECkNGnIMlqiXZAzDfuYPy
	jN+N9NieEkwzllFDlg6t5KAgVM8kr3HpnpT/XzEXIpGHEAA2eGiBwqxpdU3Gir3Y9jXbarHy6O0
	oMwy7MpaP6W5MfvVJLnCok4h4V5I=
X-Google-Smtp-Source: AGHT+IE8X5NPhlKrP0UhMcQQq+MZ5eT7JN3M8CYIYwk0DIMhpjZasu6rhPJKWZjXj4l33/9dJOZOjkHZn/BkUxXAkqs=
X-Received: by 2002:ac2:5f77:0:b0:50f:15fe:f91a with SMTP id
 c23-20020ac25f77000000b0050f15fef91amr417674lfc.88.1706185170550; Thu, 25 Jan
 2024 04:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123234731.work.358-kees@kernel.org>
In-Reply-To: <20240123234731.work.358-kees@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 25 Jan 2024 13:19:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGcKBPnHOm6PtsrxePdv5a6AokB=qvMrwvGmPh_Uk6vsA@mail.gmail.com>
Message-ID: <CAMj1kXGcKBPnHOm6PtsrxePdv5a6AokB=qvMrwvGmPh_Uk6vsA@mail.gmail.com>
Subject: Re: [PATCH] smb: Work around Clang __bdos() type confusion
To: Kees Cook <keescook@chromium.org>
Cc: Steve French <sfrench@samba.org>, Nathan Chancellor <nathan@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, 
	llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 00:47, Kees Cook <keescook@chromium.org> wrote:
>
> Recent versions of Clang gets confused about the possible size of the
> "user" allocation, and CONFIG_FORTIFY_SOURCE ends up emitting a
> warning[1]:
>
> repro.c:126:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>   126 |                         __write_overflow_field(p_size_field, size);
>       |                         ^
>
> for this memset():
>
>         int len;
>         __le16 *user;
>         ...
>         len = ses->user_name ? strlen(ses->user_name) : 0;
>         user = kmalloc(2 + (len * 2), GFP_KERNEL);
>         ...
>         if (len) {
>                 ...
>         } else {
>                 memset(user, '\0', 2);
>         }
>
> While Clang works on this bug[2], switch to using a direct assignment,
> which avoids memset() entirely which both simplifies the code and silences
> the false positive warning. (Making "len" size_t also silences the
> warning, but the direct assignment seems better.)
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1966 [1]
> Link: https://github.com/llvm/llvm-project/issues/77813 [2]
> Cc: Steve French <sfrench@samba.org>
> Cc: Paulo Alcantara <pc@manguebit.com>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/smb/client/cifsencrypt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
> index ef4c2e3c9fa6..6322f0f68a17 100644
> --- a/fs/smb/client/cifsencrypt.c
> +++ b/fs/smb/client/cifsencrypt.c
> @@ -572,7 +572,7 @@ static int calc_ntlmv2_hash(struct cifs_ses *ses, char *ntlmv2_hash,
>                 len = cifs_strtoUTF16(user, ses->user_name, len, nls_cp);
>                 UniStrupr(user);
>         } else {
> -               memset(user, '\0', 2);
> +               *(u16 *)user = 0;

Is 'user' guaranteed to be 16-bit aligned?

>         }
>
>         rc = crypto_shash_update(ses->server->secmech.hmacmd5,
> --
> 2.34.1
>
>

