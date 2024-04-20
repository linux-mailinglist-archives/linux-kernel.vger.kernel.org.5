Return-Path: <linux-kernel+bounces-152393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110C98ABDC7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BB81F214F1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 23:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134064CDE0;
	Sat, 20 Apr 2024 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rI9KCbdR"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D698F101C5
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713656389; cv=none; b=Eds30lJyLHCL5w0IEga1ySpygl+cjabZJwmTB8lznxLg1yidDVnIQA2AvB1aUqgcSppEZH/AsBD6tS7IudPMo5Yg9NFnMRzrXuBgUCwrEkhY82sGgW1EBwqTSH+KK/xOhmnCl7d1MHZMUMypDR7F+1NyjZBBOEzMgrTec7wnKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713656389; c=relaxed/simple;
	bh=vg7G/c4GVxNEW9BkK8tbkjLCsox9iImaFckeYxGhJYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZyNKTwjabrPcUeFPd/TDC4QVxsN8BF48mWKsGuxt0hgUr317Ebukbzfp/7R1Kohm2fyoN2Mvw9FBUckpuDs6Zhtr9O2sTuPZfizpgEpg7mJ5VoZJglcj9qO0UvaGf8nfsoFggmlc1wE327wMACd653ZKtYKJYQx6h24cKHMkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rI9KCbdR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed112c64beso2843704b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 16:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713656387; x=1714261187; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RjGoWeWh4DAGJMx32fKXE91blPy/3pj8mu5su3kP+w=;
        b=rI9KCbdRVcog1EzIzEHjzguDyCQPZJnGQR5oJKQaTVTx+CE/pTCiuLkMeAvfdNCXtf
         COqydzOB2DvLdfy4LfJTiN2L24qdx6URO6cRVReIUSaTi4v7EYdbywaI26cUMZYdEBQc
         ULaGTuVZPCQ1L1B4wxWV605iQoThmjdGCgKTZ5TaprG6HBLyeviFSJOZ5VeDtl5ZyYhu
         2c+XCsA5h2VM1RcdwRnOZ093gyLfuUSKBC09S9ofv897/tgcl4J221QspqzBhMfgSePG
         O9pwDpRdJncRuwfYGGDr5GWt3WU4LLr1ZKj+vZNibajLL/9nCLKUR5nxl68/wFNHIsK/
         FFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713656387; x=1714261187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RjGoWeWh4DAGJMx32fKXE91blPy/3pj8mu5su3kP+w=;
        b=wWy61IZ2idHgbTIReiVJIPCxMKYltOBPrRCe1fyFQhj2bQSw1FTR22Bd4X/tOMIS0u
         djr1RJtmO6Ax22YSQkTadXFnWOcVBgvfuOdtDNwXx9EUkv/Hr2HUeeTiOm8xtr3sy/UK
         YDfs74l7Ey0bSmRzI3TEjj9AZYWG+q0JPgZyEnaPPG5KR3n9aqVC3I2lklPoi8758Y+9
         EWjw86iRRHTKebS0R/vIwqkCwqbJGK+YtvtiTxvGj+e2Mye44a8WVYr2L+hovMYSbtnN
         H6PEYGU/UwdR0uFUOZVqmW8bfnWiXEoGrwsVIujDmjoT8Gf7xXq59uQVAvCclBrCZuJE
         VmOA==
X-Forwarded-Encrypted: i=1; AJvYcCX5CTLAxbqgpW0dP5OR5iD0pAF8TSQ1Ne1LwpQHdwFNcunduJWLmIe8aMD3SYCskb9N6rG7zzuRNOvg4HKwU3h1+lvks35zV17ovu5X
X-Gm-Message-State: AOJu0YxevOgeXseZOnufRaso2Yx8qn7DfQLJoLL0+YnhxzcRaoXOqrNS
	tgw/iLVq0HE34WPP12K+D1bCMIxqYzm9zCpzGB0iBf3umcdfETGMrNw01bfOTA==
X-Google-Smtp-Source: AGHT+IHHi21jEXTjZlY8+zVKjP905H3+F4CdwBB+kI/I+ZhP+E5GZamZW4mVvrEth3JoHyggPIcVKA==
X-Received: by 2002:a05:6a20:914a:b0:1a7:60fa:b324 with SMTP id x10-20020a056a20914a00b001a760fab324mr6827650pzc.18.1713656386883;
        Sat, 20 Apr 2024 16:39:46 -0700 (PDT)
Received: from google.com (139.69.82.34.bc.googleusercontent.com. [34.82.69.139])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b001e28f7c4233sm5631139pln.236.2024.04.20.16.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 16:39:45 -0700 (PDT)
Date: Sat, 20 Apr 2024 23:39:41 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
	tkjos@android.com
Subject: Re: [PATCH 1/4] binder: introduce BINDER_SET_PROC_FLAGS ioctl
Message-ID: <ZiRSPXSuSMyUO0Cw@google.com>
References: <20240417191418.1341988-2-cmllamas@google.com>
 <20240418083447.3877366-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418083447.3877366-1-aliceryhl@google.com>

On Thu, Apr 18, 2024 at 08:34:47AM +0000, Alice Ryhl wrote:
> Carlos Llamas <cmllamas@google.com> writes:
> > This new ioctl enables userspace to control the individual behavior of
> > the 'struct binder_proc' instance via flags. The driver validates and
> > returns the supported subset. Some existing ioctls are migrated to use
> > these flags in subsequent commits.
> > 
> > Suggested-by: Arve Hjønnevåg <arve@android.com>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binder.c            | 25 +++++++++++++++++++++++++
> >  drivers/android/binder_internal.h   |  4 +++-
> >  include/uapi/linux/android/binder.h |  6 ++++++
> >  3 files changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index bad28cf42010..e0d193bfb237 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -5334,6 +5334,26 @@ static int binder_ioctl_get_extended_error(struct binder_thread *thread,
> >  	return 0;
> >  }
> >  
> > +static int binder_ioctl_set_proc_flags(struct binder_proc *proc,
> > +				       u32 __user *user)
> > +{
> > +	u32 flags;
> > +
> > +	if (get_user(flags, user))
> > +		return -EFAULT;
> > +
> > +	binder_inner_proc_lock(proc);
> > +	flags &= PF_SUPPORTED_FLAGS_MASK;
> > +	proc->flags = flags;
> > +	binder_inner_proc_unlock(proc);
> > +
> > +	/* confirm supported flags with user */
> > +	if (put_user(flags, user))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> 
> I'm just thinking out loud here, but is this the best API for this
> ioctl? Using this API, if I want to toggle the oneway-spam-detection
> flag, then I can't do so without knowing the value of all other flags,
> and I also need to synchronize all calls to this ioctl.
> 
> That's fine for the current use-case where these flags are only set
> during startup, but are we confident that no future flag will be toggled
> while a process is active?

hmmm, this is a very good point. It would probably lead to userspace
having to cache its flags for every binder instance. This is not a good
solution at all.

> 
> How about these alternatives?
> 
> 1. Userspace passes two masks, one containing bits to set, and another
>    containing bits to unset. Userspace returns new value of flags. (If
>    the same bit is set in both masks, we can fail with EINVAL.)
> 
> 2. Compare and swap. Userspace passes the expected previous value and
>    the desired new value. The kernel returns the actual previous value
>    and updates it only if userspace gave the right previous value.
> 
> 3. Set or unset only. Userspace passes a boolean and a mask. Boolean
>    determines whether userspace wants to set or unset the bits set in
>    the mask.
> 
> I don't know what the usual kernel convention is for this kind of
> ioctl, so I'm happy with whatever you all think is best.

I've never come across these types of alternatives personally. What I've
seen however, is the typical SET/GET ioctl pairs. This is a "simpler"
interface I guess but it has the downside of an extra roundtrip. e.g.

	ioctl(fd, BINDER_GET_PROC_FLAGS, &flags);
	flags |= BF_LARGE_HANDLES;
	ioctl(fd, BINDER_SET_PROC_FLAGS, &flags);

What seems tempting about the SET/GET pair is that we could replace the
BINDER_ENABLE_ONEWAY_SPAM_DETECTION with the SET. Instead of maintaining
legacy code for the "deprecated" ioctl.

wdyt?

I'll have a second look at the alternatives you mentioned. Perhaps I can
reference some other existing ioctl that does something similar.

--
Carlos Llamas

