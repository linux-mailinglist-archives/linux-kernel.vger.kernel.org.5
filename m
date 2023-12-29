Return-Path: <linux-kernel+bounces-12888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E459081FC20
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6B21C213C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 00:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84437FF;
	Fri, 29 Dec 2023 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="fm3VigLf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E15633
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cb21afa6c1so80967521fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 16:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703808341; x=1704413141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1uQHxJ/UMslgvxsnPESIEbCfyITt0swCrvdM6gTclE=;
        b=fm3VigLfXIMLb5a2aJ6xQFxbUjw1+8MFeZ8zqqYGdNOLAj/ThNfTtJOK3Fi6njzK9Z
         ROftyw6WyziHmiG9BakLV0TDniiyEB848GlUG77fCBCic5e0R/ufvNWP3JzFFTYR2ePA
         7y3w21sizzxZqsU6ffnk4Qz9rZE6EcSyu9wbQsyUtEwqxRo5u/6snosoeF2OB8rXEjVy
         vuOGDoKY01n617OrKdphQGCaa1a7zsSdAKzgueo9ozl6WPvwuVzsNrj1s5xZJmA5Iy7d
         n+eZ34qjvI2TChxKPzZ8KJcr92n3zJXwjmu7o9UYPR2sU3lWcw6YQoho4fXSSYjucmFR
         8phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703808341; x=1704413141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1uQHxJ/UMslgvxsnPESIEbCfyITt0swCrvdM6gTclE=;
        b=TLdZM4JDrKfU2HBXHOT7dBWNCe3mEr/hMM5oXXMpnHmKgxgJKTrbOUHB7eQuZ8pNUJ
         ECDxTP7Mwa+tmpfWb86CKqAsxkBCknngdnOBbxFSL3PkS84SbrlX0XODmlzAWQ1MP36S
         H+KAH4LqjLaMmNPEJPchpYPQcNpAqJrtfMhRRm1jrrtboNfysBrmU2kL+dHKgkP71Mak
         EZlvEXg8irdkWKyzv2P75SuK4o0i27zWinI+quAqO1QT53BwMRODJoRNDcqgO908qFut
         S+ccAw0e7vQg7aN30vldDs8ZidkYJJhZxMOtGZEk0LRiPNYiGxbuVd6s/+K0G8gqDLnD
         kKcg==
X-Gm-Message-State: AOJu0YxUvoidtNeRS8U4Jrkpg5dtuCniH538E8IJnbwJew6pwpwvUEd1
	rweI7MUh2q40qhEyrRqASATA41Sed4KsX4Iw+L5kXAJj/KaT
X-Google-Smtp-Source: AGHT+IGpVDyeZg9aMabF8Z3XI5HktLMS+tNvGABnw2Oy3gSYcyrZzM8/jYKyw7bcom9loi2vGCbWiT74whi5ve6DZBY=
X-Received: by 2002:a2e:2413:0:b0:2cc:9493:8117 with SMTP id
 k19-20020a2e2413000000b002cc94938117mr4838058ljk.65.1703808341202; Thu, 28
 Dec 2023 16:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223015131.2836090-1-lb@semihalf.com> <CAJfuBxyN+t6OgzzX3ZT6MxdMT6Awr29orJAucVMDz2zmEFCDDQ@mail.gmail.com>
 <CAJfuBxz24vu5d1v=mKfRTD5OwrC_bvWZeD-PubaCFOZbmihjiA@mail.gmail.com>
In-Reply-To: <CAJfuBxz24vu5d1v=mKfRTD5OwrC_bvWZeD-PubaCFOZbmihjiA@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date: Fri, 29 Dec 2023 01:05:30 +0100
Message-ID: <CAK8Bye+K9cWG_AJ-2rTzRn4eZn-9fDreP8zsRfrPdV4wcRD7pw@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] dyndbg: add support for writing debug logs to trace
To: jim.cromie@gmail.com
Cc: Jason Baron <jbaron@akamai.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Douglas Anderson <dianders@chromium.org>, 
	Guenter Roeck <groeck@google.com>, Yaniv Tzoreff <yanivt@google.com>, Benson Leung <bleung@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Pekka Paalanen <ppaalanen@gmail.com>, Sean Paul <seanpaul@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, Simon Ser <contact@emersion.fr>, 
	John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-kernel@vger.kernel.org, 
	upstream@semihalf.com, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=9Br., 27 gru 2023 o 05:44 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> > >
> > > Jim, I made a few changes to the test script dd-selftest.rc you creat=
ed
> > > and I also added new test scenarios. You can find the entire patchset
> > > with the test script changes on top here
> > > https://chromium.googlesource.com/chromiumos/third_party/kernel/+log/=
refs/sandbox/ukaszb/dyndbg_trace_v3
> > > I wonder where would be the proper place to store the test script
> > > (upstream, your github.com:jimc/linux.git)
> > > Do you have a suggestion for that ?
> > >
> >
> > I got it (your HEAD), renamed and put it in:
> > tools/testing/selftests/dynamic_debug/
> > and copied & modified Makefile and config from ../users/
> > I added your SOB, that seems proper.
> >
>
> meh.
> my select-paste of your HEAD dropped all the whitespace.
> how annoying.
>
>
> > nice additions.  and I like the colors.  maybe they belong in lib.mk,
> > but thats 4 later.
> >
> > and tweaked the modules / DUTs to *hopefully* get stable callsite count=
s
> > from the tests on them, in virtually any usable config.
> > DUTs: file init/main, module mm_init, and module test_dynamic_debug (a
> > config constraint)
> > The ref-counts are taken from a default virtme-ng -k config on my x86-6=
4 box
> >
> > I now pass tests up to:
> >
> > [root@v6 wk-proof]# ./tools/testing/selftests/dynamic_debug/dyndbg_self=
test.sh
> > ...
> > # TEST_PRIVATE_TRACE_6
> > [ 1009.296557] dyndbg: read 3 bytes from userspace
> > [ 1009.296876] dyndbg: query 0: <=3D_> on module: <*>
> > [ 1009.297171] dyndbg: processed 1 queries, with 1559 matches, 0 errs
> > [ 1009.311621] dyndbg: read 39 bytes from userspace
> > [ 1009.312032] dyndbg: query 0: <open
> > A_bit_lengthy_trace_instance_name> on module: <*>
> > [ 1009.312569] dyndbg: instance is already opened
> > name:A_bit_lengthy_trace_instance_name
> > [ 1009.313063] dyndbg: processed 1 queries, with 0 matches, 1 errs
> > : ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh:454
> > ddcmd() expected to exit with code 0
> > Error: 'File exists'
> >
>
> _7 has some obsolete counts, after previous $modname changes

Which obsolete counts are you referring to ?

Thanks,
Lukasz

