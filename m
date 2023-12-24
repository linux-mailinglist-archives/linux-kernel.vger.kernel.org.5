Return-Path: <linux-kernel+bounces-10817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B9581DC43
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 20:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD261F216E4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BFDE56B;
	Sun, 24 Dec 2023 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SRl0W3cY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CFBDDA6
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5d2d0661a8dso30872287b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703447916; x=1704052716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmcVQPwGjjUY9XTbKfzg3lbGQPvGiD0vLAjWo8rnhBQ=;
        b=SRl0W3cYZDpisUjwm9Cdsa5lL22PatpdQ1lwN4L8rsdgijB8cm/dJRZMmfCaBe+N9P
         oJIkvul5DqxNyOHh9ak3C12NnVpe7xqUrtAWeWN1G4GVCcW8uraoy9vcSpfH8HcLycGO
         gLqltSTLnvE3R/U8J4VpmmOXa3x15YDr/Y9XQn4q2ykOv7K/tZjbkM0dqLe2MzPYquq2
         bBhrArobc+R0uTCOry+7ysLAccGJy0lwsjX4/TxqepAwvBGNbViV2a3kamrLsIcJR1B2
         IoiMRK3DY3reIO+GfvglV0armuw8uFdrfvOL4H4sM9kS5PQ7kvp9Q6FBjlQPubHhF/Aa
         vTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703447916; x=1704052716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmcVQPwGjjUY9XTbKfzg3lbGQPvGiD0vLAjWo8rnhBQ=;
        b=WIpYUaL34jlZg9leKdLCbn6/TM4fhg+fmdsBGZNOtf/RV24Uc7N0BzHwj8GwBAAJ7l
         rSIK0pl1vogyf6xZxftJsxGx5ilZvYRZ9+Ysn2uJVNfuBwZonmZJBwRuOpcLvslEq89Z
         eGhcvhOeniwY/6qECGZ2ZUIWnNTaXUT7jyH4uW8N1aNH2lYaDbwzBCAwzTOxo8rISpLT
         LW4QzH7dH1Q+o09EBIPx69+6sLB4MkKIkF64m2BAjtyE57COOlSwCvOZzxzBJBy6Hjj+
         OeCNqh6OwMQ2P26Ut/lZmv0sjq9R4XTnt/VlVd2Feh/0jBCLoTKdt9YnPW4nsbFmZv3p
         vGIQ==
X-Gm-Message-State: AOJu0YwhGrij5JadML8r2eb4URrjtcn/QEgs/MEEpF56HO8A9bJ7kd0R
	L3MVrGz6uHT8XbVZgycSPpM3XHMxXasI53sWntEFbiJTuZze
X-Google-Smtp-Source: AGHT+IGy44q+tnMyqe0jXQ+RNpAK+IeAmGOXK3azlBtSANBmgv2b8x5gogyq35v8wuusXib7Qm+Qw0By+70l3jFZxQ8=
X-Received: by 2002:a0d:df91:0:b0:5e5:7254:2c2d with SMTP id
 i139-20020a0ddf91000000b005e572542c2dmr3160011ywe.53.1703447916657; Sun, 24
 Dec 2023 11:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
 <CAHC9VhTpc7SD0t-5AJ49+b-FMTx1svDBQcR7j6c1rmREUNW7gg@mail.gmail.com> <57ce7089-37c7-44c5-a9da-5a6f02794c42@I-love.SAKURA.ne.jp>
In-Reply-To: <57ce7089-37c7-44c5-a9da-5a6f02794c42@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 24 Dec 2023 14:58:25 -0500
Message-ID: <CAHC9VhQoEVvGXzH6HjnTsQVa1=ZJ0cOpk6pEgPeYdLKJpmsUbA@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Alfred Piccioni <alpic@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 5:49=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/12/23 10:23, Paul Moore wrote:
> >> -       /* RED-PEN how should LSM module know it's handling 32bit? */
> >> -       error =3D security_file_ioctl(f.file, cmd, arg);
> >> +       error =3D security_file_ioctl_compat(f.file, cmd, arg);
> >>         if (error)
> >>                 goto out;
> >
> > This is interesting ... if you look at the normal ioctl() syscall
> > definition in the kernel you see 'ioctl(unsigned int fd, unsigned int
> > cmd, unsigned long arg)' and if you look at the compat definition you
> > see 'ioctl(unsigned int fd, unsigned int cmd, compat_ulong_t arg)'.  I
> > was expecting the second parameter, @cmd, to be a long type in the
> > normal definition, but it is an int type in both cases.  It looks like
> > it has been that way long enough that it is correct, but I'm a little
> > lost ...
>
> Since @arg might be a pointer to some struct, @arg needs to use a long ty=
pe.
> But @cmd can remain 32bits for both 32bits/64bits kernels because @cmd is=
 not
> a pointer, can't it?

I'm not worried about @arg, I'm worried about @cmd, the second
parameter to the syscall.  I was looking at the manpage and it is
specified as an unsigned long, which would be a size mismatch on a
64-bit system, although now that I'm reading further into the manpage
I see that the command is specified as a 32-bit value so an int
shouldn't be a problem.  I'm guessing the unsigned long type persists
from the days before 64-bit systems.

> > I agree that it looks like Smack and TOMOYO should be fine, but I
> > would like to hear from Casey and Tetsuo to confirm.
>
> Fine for TOMOYO part, for TOMOYO treats @cmd as an integer.

Great, thank you.

--=20
paul-moore.com

