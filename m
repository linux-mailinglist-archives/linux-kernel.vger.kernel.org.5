Return-Path: <linux-kernel+bounces-11829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC8A81EC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA6C1C21633
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3082F9C1;
	Wed, 27 Dec 2023 04:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUdD8mR7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF136F4FA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 04:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bb9b28acb4so2319052b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 20:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703652286; x=1704257086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v/upiCvFRkNwsr8xkvtQN18zxqhN8Dcopz1Ls8r2LVQ=;
        b=cUdD8mR7F1+8eGzYf4zxGrz7AV/7PvtB6KBfez9t9cw+xurRrjaR4L5U//dV793A0E
         mGOkSpAas27utrtuZlYObvKB6zp5UebI2fEGAx73cSRgSZk6XJ5+LW4VGJqpvif0Ri1G
         /9W/+nU7XIiBVIIgt9sddy4S1ynILPe3xkKOBNLhRJvZ0JaVcADIOQPeXqsmY6Txx3IJ
         68onWfi5XMVJxr+2F7ooP9g6KavP7/A1Dz1ep+BHcbfH57c0O9cSpNUfenhKoLa4BM6/
         XBGS/P4v3JIXl66EfVesgMpfjoq+2xiY4yCCpOEkTIj5axEO1svKgHRL0PZDk/aH4wjl
         NGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703652286; x=1704257086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/upiCvFRkNwsr8xkvtQN18zxqhN8Dcopz1Ls8r2LVQ=;
        b=B7s8YRp0VSO8LrqApSMFI1VVRgyHy5qSoh8cz2OSMtLAHVpBmCfCC2ZdGko5in9ELE
         cZPs9eOtER6U6HDpdKP4Q6vL6tYiXlvbAiMrVdS2iMZSH8pCrtLXaOQYf9veNL4uf/GD
         P8siztJoiYxi/QoR7hTYAU4iqw1E8Y0vldMAM++O9ZebVLFxQEMK+GAiOxN/CbZLFgX1
         LHhFchXk78uhMXRFzoU9TBHpeGEvErDAadorlRmotitNrdvRTCW4Gn9hgn2TAJSLrS/x
         UDSZd+X9gTmaQtlyEp1f7yKknUHB9SdOdKVlYDpfddrrIVhrerbHZEu+BG84fJalXdc2
         FR5g==
X-Gm-Message-State: AOJu0Yw7pu92TkyoFn9EpreXsMAzytwk/5HLKxkMb3bU7XFuHJ+ZejXx
	VzAhuocwAr6OGinif9I50Me6CiHKpQfU7I31ZUQ=
X-Google-Smtp-Source: AGHT+IHNrOIG8QznrufRqzz4syaeac4phWwmMgMvXtJXT9jfjfzh1lRnAPDJMSgYo0NuKEb8fgEzYbvk9M0FiNmptFc=
X-Received: by 2002:a05:6808:4444:b0:3bb:c6c4:6a0d with SMTP id
 ep4-20020a056808444400b003bbc6c46a0dmr318036oib.107.1703652285868; Tue, 26
 Dec 2023 20:44:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223015131.2836090-1-lb@semihalf.com> <CAJfuBxyN+t6OgzzX3ZT6MxdMT6Awr29orJAucVMDz2zmEFCDDQ@mail.gmail.com>
In-Reply-To: <CAJfuBxyN+t6OgzzX3ZT6MxdMT6Awr29orJAucVMDz2zmEFCDDQ@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Tue, 26 Dec 2023 21:44:19 -0700
Message-ID: <CAJfuBxz24vu5d1v=mKfRTD5OwrC_bvWZeD-PubaCFOZbmihjiA@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] dyndbg: add support for writing debug logs to trace
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
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

> >
> > Jim, I made a few changes to the test script dd-selftest.rc you created
> > and I also added new test scenarios. You can find the entire patchset
> > with the test script changes on top here
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+log/refs/sandbox/ukaszb/dyndbg_trace_v3
> > I wonder where would be the proper place to store the test script
> > (upstream, your github.com:jimc/linux.git)
> > Do you have a suggestion for that ?
> >
>
> I got it (your HEAD), renamed and put it in:
> tools/testing/selftests/dynamic_debug/
> and copied & modified Makefile and config from ../users/
> I added your SOB, that seems proper.
>

meh.
my select-paste of your HEAD dropped all the whitespace.
how annoying.


> nice additions.  and I like the colors.  maybe they belong in lib.mk,
> but thats 4 later.
>
> and tweaked the modules / DUTs to *hopefully* get stable callsite counts
> from the tests on them, in virtually any usable config.
> DUTs: file init/main, module mm_init, and module test_dynamic_debug (a
> config constraint)
> The ref-counts are taken from a default virtme-ng -k config on my x86-64 box
>
> I now pass tests up to:
>
> [root@v6 wk-proof]# ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> ...
> # TEST_PRIVATE_TRACE_6
> [ 1009.296557] dyndbg: read 3 bytes from userspace
> [ 1009.296876] dyndbg: query 0: <=_> on module: <*>
> [ 1009.297171] dyndbg: processed 1 queries, with 1559 matches, 0 errs
> [ 1009.311621] dyndbg: read 39 bytes from userspace
> [ 1009.312032] dyndbg: query 0: <open
> A_bit_lengthy_trace_instance_name> on module: <*>
> [ 1009.312569] dyndbg: instance is already opened
> name:A_bit_lengthy_trace_instance_name
> [ 1009.313063] dyndbg: processed 1 queries, with 0 matches, 1 errs
> : ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh:454
> ddcmd() expected to exit with code 0
> Error: 'File exists'
>

_7 has some obsolete counts, after previous $modname changes

