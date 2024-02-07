Return-Path: <linux-kernel+bounces-56694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033E184CDB4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32FB51C225BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB197F7DF;
	Wed,  7 Feb 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PY+GQVkB"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9216B7F488
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318580; cv=none; b=prZHTbLPGPnhJJHcrSaXXlFXGd6JXuOORK9HAnUgqFYkv2bU+FzbGbG0PF1PXT1gsOayO5r0HBfL9W6y/w0anzo1p9dmuTiaKkYYhvvjD1ziI7MVt2QwQ3S5aIFTEpRixAAq8V+p9vJJkfn03xoRRJpHaSKPEcC2TbM9T44kJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318580; c=relaxed/simple;
	bh=289HaGYyUFlSBzdgaJPiX1tdAh3koUayV8L35fXtBMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTTgN8S3t8YM1Lz/i0hHb9dfWZTLmcXf1RwHAsXrj9YOzQyaFqt45po6LPKr/m44kPstJmcJh6Zc0QhfVkABsA9Z1W+lUNVgvEzD7llzuzkrtRqJ26/RCKh0GpirbBvFN/CW2Wn3ybT41S4k8WSJvGHb5Rc+B8WqBgrE3sIl5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PY+GQVkB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a389a3b9601so34924266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707318577; x=1707923377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fOJyiQhDEQVM/OwkrnT+6+TKgKM76JkW083fWVVDBk=;
        b=PY+GQVkBbwxWwZNCfwCthRubJa9T++UD1BCfRZdMnhgRuWB0As4VvOuMekPlhPwVHH
         s+NMskSpxvlXsKzp0sCv+9SsErwtFOpIDfrmEhLRbLvsH7SEkG13VYhVUgQW+AbXsop0
         mQjQttud987Oh5DIrHXZXoAQzSSnEGV7n6apJLh13NJX22EkfFrXsUv54ORBs1yfM7YJ
         /vHcYbEJMKI9RsSlUvwOGPH4W7f76HYKeqX2UC/+0nzbCqozTFTHtxaBPdzlh2DpXazM
         +9azSiI7vdi2Kmj/P5vtqO0kPJCGN/LIgTwmTL9bkq2QBmpoHij1hb9MnFrrOrs8o5Cs
         gPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318577; x=1707923377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fOJyiQhDEQVM/OwkrnT+6+TKgKM76JkW083fWVVDBk=;
        b=mbUewWYmSkK9P3YuoTYZZhtOUJ7JqUitTpibylWfWOgUfM6PWM7y1YPQlElAPx/iTK
         8lai5Y5rmPj71semtQaqcG9jpZ5QYpoZhqAT0JR0FwaAFRAbebp/PrTvw7djixhlcsWG
         CpbU8XZVdGYeAvrbdyZWdxms6umjYcrE5pVBuamraFmkPbPQEvyI69mWCewEU7r1tOJy
         M3yr1YjqBaM9S/1OJQ+9nC33IjXRKoQlhxWA4epdxyU9H4evaSyDEeFITc7z2nq49D3A
         1uYxBZMFDBb7PO6fKtT2dmlzk2vyppCIxurBKlZY22CJIvYE3Y9UPXIjUMsHrIPeDJvQ
         phpA==
X-Gm-Message-State: AOJu0YxWR/P7eAe1Z1sM/xhZUfbGoatGQsuIVDCRtM0lJaubzpZp9A2a
	AFvestrFenq2JOyb/AGwfhSYPIqHl26IsH9v3PbghZz+4jRdhl3aiByBjmdZ6rk=
X-Google-Smtp-Source: AGHT+IEll9oUuMXPJPEKfzna/H4NBKn3iyg+La3JeQgNI7lqzBIfxefGwoDNHHhuwYO4qQW6EQqgRQ==
X-Received: by 2002:a17:907:7803:b0:a34:96e9:f46c with SMTP id la3-20020a170907780300b00a3496e9f46cmr4162025ejc.31.1707318576821;
        Wed, 07 Feb 2024 07:09:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvxcgxBYzEwqY+Jl6A6mhH/kPpsJosFYLwZCqbchnZsHhP6c7ZxGSU2Pz3grVJ8cfjhumSW1VdAs+UJ7Ul6fU9s+A8UAlJhMYDdt5sCHZXd9AkWmm89A7S103tkhQ0bM9wY75FZeNX0J3e9OmLVhp5lX7s3NXsfoeD0jbChoB4GHnMC7EFZ09KXxuUag+NW2zXpd7bqdGZAQO0c5Ez/YDspt5lkcAoDjZdJJXG4Gan82yImyk3HveUAmh+IVRwaM9UxblyfwczOHmc4CSEqPIAGLoupgSWYtWvzbjXCRaR9AQXdG5d4IQIHvuwlzDnJIYTkZuZkXwsg5WUxAyMXlCDn/idLyxAzGsobpp+2fJXPKVCYSvRiibxgisv/q2wgrJ/QKOAwY0cS1PDQ+hccitcgvV2it8taIHfieBe/MRrQ54D4GGb0RkYECSF9EGJ3bo3LOJ1jC6QxXWNXbe8zCqFEYO22V2DwySm
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id cw9-20020a170907160900b00a388e24bd2fsm428980ejd.162.2024.02.07.07.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:09:36 -0800 (PST)
Date: Wed, 7 Feb 2024 16:09:34 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
	senozhatsky@chromium.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
	anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v4 2/2] tty/sysrq: Dump printk ring buffer messages via
 sysrq
Message-ID: <ZcOdLrOPiPJmCec5@alley>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
 <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>

On Thu 2024-02-01 13:12:41, Sreenath Vijayan wrote:
> When terminal is unresponsive, one cannot use dmesg to view printk
> ring buffer messages. Also, syslog services may be disabled,
> to check the messages after a reboot, especially on embedded systems.
> In this scenario, dump the printk ring buffer messages via sysrq
> by pressing sysrq+D.

I would use sysrq-R and say that it replays the kernel log on
consoles.

The word "dump" is ambiguous. People might thing that it calls
dmesg dumpers.

Also the messages would be shown on the terminal only when
console_loglevel is set to show all messages. This is done
in __handle_sysrq(). But it is not done in the workqueue
context.

Finally, the commit message should explain why workqueues are used
and what are the limitations. Something like:

<add>
The log is replayed using workqueues. The reason is that it has to
be done a safe way (in compare with panic context).

This also means that the sysrq won't have the desired effect
when the system is in so bad state that workqueues do not
make any progress.
</add>

Another reason might be that we do not want to do it in
an interrupt context. But this reason is questionable.
Many other sysrq commands do a complicate work and
print many messages as well.

Another reason is that the function need to use console_lock()
which can't be called in IRQ context. Maybe, we should use
console_trylock() instead.

The function would replay the messages only when console_trylock()
succeeds. Users could repeat the sysrq when it fails.

Idea:

Using console_trylock() actually might be more reliable than
workqueues. console_trylock() might fail repeatably when:

    + the console_lock() owner is stuck. But workqueues would fail
      in this case as well.

    + there is a flood of messages. In this case, replaying
      the log would not help much.

Another advantage is that the consoles would be flushed
in sysrq context with the manipulated console_loglevel.

Best Regards,
Petr

