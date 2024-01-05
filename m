Return-Path: <linux-kernel+bounces-18375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB45F825C2E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F771C23832
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EEA1E4B8;
	Fri,  5 Jan 2024 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+Yzq7s5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C455225A6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3373bc6d625so18080f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 13:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704490886; x=1705095686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLuZI+TKLGTR0a4JdgoWBRpnyqeG4oW812/LQUmAhTI=;
        b=c+Yzq7s56oP5TEEozrZs17iMFFZ6xkI9jazPjAFuIBD0KFGBurlqxuVX1Ll025/qbC
         JwEeMpn8Z9L1u4lnGe4Rx9Jcl6hpc8qsp7h3bjPoKQ4Asxhc5wxpQlVJHsl6F2s8wDKS
         sL6wO+11qkxr5AcJ1PXansf8OQ9p7HOqnMoZJsFBh9drr23Sp+/AG3E6bZ9mT+2gxLSp
         TUl3w128rKT0VTUdfgNGH96oTdnTeB5E8zbnPJ2EEojWz0Eg69NXTJJRYMPDo+7oypyq
         AkM/YL+7VjAXFSw/LDHEQBl4KvGMpWftIb+a3Ra0JLJj11b4DDp5m6P2MKNQC09REi6S
         RJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704490886; x=1705095686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLuZI+TKLGTR0a4JdgoWBRpnyqeG4oW812/LQUmAhTI=;
        b=AwwB+Sn2hm5gof3J+VZQNzpNNIvaVB2Wt5M3qQIPxgHD/odM9MQJP+PFdVf8+cBi/P
         jb7eif/iKbf+0VgpqKNXuoPRLhER8zCV88fmsnaACyEIL/+fgr68b/Yi1jZSfZlhPVuO
         UU4D5ksAD7gdgeT9ZhUHxYg5aB5e/gSzGXvkqRyKF2FpMML1j0kC+61LNmeCbpZljxPB
         aSu9ZXwy+E+eMpnDqhbba0LIEFcRdaMt5SPpFk567Tal8NBSiRxaAiij2DlRTYBvJW8Q
         wOso2H+SD9tc8ZfgLaRWwg2SWl715KCsKdR0PqDBEPUIbfuXPE8oP8oLoOMIjCsnzMIo
         Q6uw==
X-Gm-Message-State: AOJu0YxXiBF8tNh2vHYtGiS6vTx4dPAgHbKBpANWzADy1LT1Ljgf6RrH
	jQDLsgMC8A5zsqQZpePoO9a5eDdUcPDcwHpK3de3QSfwRsTb
X-Google-Smtp-Source: AGHT+IFUeMb63/pV9XjWL2krMheUVAHFCwFgRteRGv0JgaZJ9oVfQO7qMTGI6+OpLd3P3DNvttSueqkOEpl8UejbFgg=
X-Received: by 2002:a5d:4489:0:b0:333:39fc:3945 with SMTP id
 j9-20020a5d4489000000b0033339fc3945mr21756wrq.12.1704490885598; Fri, 05 Jan
 2024 13:41:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105-newemail-v1-1-c4e0ba2c7c11@google.com>
 <CAKwvOdnbc0Z8poK400k8dhDNjNcpWC8LsbeOSdZ5XxLm=W6k6Q@mail.gmail.com> <CAE-cH4oTTfxfGvkGCFrpCiSUOSUyL2W=isbkE+jHcRshWKnb+g@mail.gmail.com>
In-Reply-To: <CAE-cH4oTTfxfGvkGCFrpCiSUOSUyL2W=isbkE+jHcRshWKnb+g@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 5 Jan 2024 13:41:14 -0800
Message-ID: <CAKwvOdnYT2HM9XSRtFg6KkMEEDtq6muCpVGoqgPgE4sOe8H9iQ@mail.gmail.com>
Subject: Re: [PATCH] mailmap: Switch email for Tanzir Hasan
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>, Tanzir Hasan <tanzhasanwork@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 1:38=E2=80=AFPM Tanzir Hasan <tanzirh@google.com> wr=
ote:
>
> On Fri, Jan 5, 2024 at 1:35=E2=80=AFPM Nick Desaulniers <ndesaulniers@goo=
gle.com> wrote:
> >
> > On Fri, Jan 5, 2024 at 1:31=E2=80=AFPM Tanzir Hasan <tanzirh@google.com=
> wrote:
> > >
> > > From: Tanzir Hasan <tanzhasanwork@gmail.com>
> >
> > Hang on, ^ has a different From than the email From.  Did you change
> > the authorship to the new email addr?  I don't care which you use but:
> > 1. they should match (author and from)
> > 2. verify your new email with me (mentioned below)
>
> I didn't use git commit --amend, I suspect that b4 might be picking
> this up?

Ah, perhaps.  Either way, I verified that Tanzir is the owner of
tanzhasanwork@gmail.com.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>
--=20
Thanks,
~Nick Desaulniers

