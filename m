Return-Path: <linux-kernel+bounces-149729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C98A9518
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7551F21FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F67715821A;
	Thu, 18 Apr 2024 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXqoqV5W"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D1156894
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429292; cv=none; b=JsSgP3Y3i7p0+AKNjB6kfZzXNngqXvbRU7NZI4vPjfsSoQCxc8fafjQbG0z7cHnoZuvbDPMdvnF7DeXS9MTtnjwqbaj1PvfN/B4BiD8yAwlD7mYGEx8ATumYQpU4pAk/zF7lCTb+zHG3YlzJLfAinGFl1g2MRUGthGlKuLeWrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429292; c=relaxed/simple;
	bh=PvjJiHc07d7HQVna/M26Qt71tFK0cH80Q61Wk8UFVYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s2P5HEVhwietf8nwIFM72Ujw7nVUDIiU/YI/Z2NWdRyPkzFjOzF39uXGXCvIXi035/0Fa8nEJOG429nnNQaltfsHeKs17tutRizQtaOs325k1D98G3cWjrU+tG3JsnqFjB1MuzpRh2WZ350tv16YgPtzuSqJ2CpKI2/ATGdKB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXqoqV5W; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-617bd0cf61fso11792017b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713429290; x=1714034090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGxK485HKa2SBRU+YdaSArNpkCJ1zh3F1ofT1bma4bA=;
        b=VXqoqV5WNcggFkUPm/7OZnpMFz24DjETyAF2re+jO1ufoUns1iL1QY3KdXHx+CAYo0
         3i8Z4btfGCmHB2urDB7HiSJZmMyHck2/l30ooMGy3c8tldJPoOHaYQUUukIXvbBUaiT5
         /MUgajYFSNpr5EtOub4pLRu9tbQ4JjdbwXuRwVyM8pwqrIZAxRreDnl+GXea7mIo9067
         ts3siRlveCllImueH9DnZfQAgPZCem1uscnYZwQaL8ZKz02B+PAXTVJPzGeRyRrwXmP8
         XbyfRG9YrEgbEceqfTdmbrPUniwKfjE5D4iIuhKwWHxXe1ax4ElpPKlN4N+GLYDsNGZG
         Id1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713429290; x=1714034090;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qGxK485HKa2SBRU+YdaSArNpkCJ1zh3F1ofT1bma4bA=;
        b=rt+JJo3J+jSRwVGNp+WtigFxpvTeUmxzKw++y/HjGTGNNxDRkVDr9LocNVgZiX4hxI
         DWHzoNyMqYL5rz7NeTS/xYn2IUyzU076GABWE8MuI/7D3PVFoK0N65JG5xOS9kjk/HIJ
         TbttphWPKnTh36cKMZugZCWGUCkN/l9gT3B8fwMH874eejWtWxDWkzl6C0lWWQJ2klWY
         v/FkOgu4sPIiiqxPvS1GkRnIrRDpTY9WDJPKJE4nfmlMweRFC8uA3DpSkxfuBIxrrS8l
         MnWFpMpHl5vcShctp6y0WZqt5FB05ZnYJAcmLXs4Klfpt6I55pXKgoh8iuVbkzfx9em7
         9s4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoal038ZU9a7DnnxajJf/5CFsUADmGLzRs9ntYStVK+1JedET/xR8QoJfEPKefWsm4tdvZ0uW5UlehJn8JchJKZDAmhTxDd7Z3ECuc
X-Gm-Message-State: AOJu0YztY1ix1EC3+qU7TxNrMpZqwVaNKzl2TkfV8oSNaTDMoYM13Jb9
	3e/yLkL6XvM3BCXZzC8CfWUl/3JJ/C8V70tLN17kmJ4Qc3dzJc6QGgkPs+rUL4oqfiqhtFIk3h7
	Crz4IF3IR5+zecw==
X-Google-Smtp-Source: AGHT+IFD+eAxYV0eCvOm4jSkX0p3P9g8OdrClcvMgVWRXbAZcQdEeITKo0qYrQq6BLdFSDulKyQJqQdLowqyTPc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:498f:0:b0:61b:2122:84b2 with SMTP id
 w137-20020a81498f000000b0061b212284b2mr254427ywa.10.1713429289875; Thu, 18
 Apr 2024 01:34:49 -0700 (PDT)
Date: Thu, 18 Apr 2024 08:34:47 +0000
In-Reply-To: <20240417191418.1341988-2-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417191418.1341988-2-cmllamas@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418083447.3877366-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/4] binder: introduce BINDER_SET_PROC_FLAGS ioctl
From: Alice Ryhl <aliceryhl@google.com>
To: cmllamas@google.com
Cc: aliceryhl@google.com, arve@android.com, brauner@kernel.org, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com, 
	tkjos@android.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Carlos Llamas <cmllamas@google.com> writes:
> This new ioctl enables userspace to control the individual behavior of
> the 'struct binder_proc' instance via flags. The driver validates and
> returns the supported subset. Some existing ioctls are migrated to use
> these flags in subsequent commits.
>=20
> Suggested-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder.c            | 25 +++++++++++++++++++++++++
>  drivers/android/binder_internal.h   |  4 +++-
>  include/uapi/linux/android/binder.h |  6 ++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index bad28cf42010..e0d193bfb237 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5334,6 +5334,26 @@ static int binder_ioctl_get_extended_error(struct =
binder_thread *thread,
>  	return 0;
>  }
> =20
> +static int binder_ioctl_set_proc_flags(struct binder_proc *proc,
> +				       u32 __user *user)
> +{
> +	u32 flags;
> +
> +	if (get_user(flags, user))
> +		return -EFAULT;
> +
> +	binder_inner_proc_lock(proc);
> +	flags &=3D PF_SUPPORTED_FLAGS_MASK;
> +	proc->flags =3D flags;
> +	binder_inner_proc_unlock(proc);
> +
> +	/* confirm supported flags with user */
> +	if (put_user(flags, user))
> +		return -EFAULT;
> +
> +	return 0;
> +}

I'm just thinking out loud here, but is this the best API for this
ioctl? Using this API, if I want to toggle the oneway-spam-detection
flag, then I can't do so without knowing the value of all other flags,
and I also need to synchronize all calls to this ioctl.

That's fine for the current use-case where these flags are only set
during startup, but are we confident that no future flag will be toggled
while a process is active?

How about these alternatives?

1. Userspace passes two masks, one containing bits to set, and another
   containing bits to unset. Userspace returns new value of flags. (If
   the same bit is set in both masks, we can fail with EINVAL.)

2. Compare and swap. Userspace passes the expected previous value and
   the desired new value. The kernel returns the actual previous value
   and updates it only if userspace gave the right previous value.

3. Set or unset only. Userspace passes a boolean and a mask. Boolean
   determines whether userspace wants to set or unset the bits set in
   the mask.

I don't know what the usual kernel convention is for this kind of
ioctl, so I'm happy with whatever you all think is best.

Alice

