Return-Path: <linux-kernel+bounces-17346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA2824C01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A671C22078
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DF8810;
	Fri,  5 Jan 2024 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjbcmRYT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88024373
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc02727c62so574680a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 16:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704413213; x=1705018013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EYi3ShOTCWSVgfC3FFX6YL88YfXo3L5cnVrx8NMJ+V4=;
        b=EjbcmRYTatQ+HKC7/dT3uv7ZrdcS2yvcpGUVTtMk/E/8tJW0pVMmq90WFSD/qeqwBs
         B7xR0lWtCPf0alvsYKYwERr/UInhzUf5tkftK6EUFpjYiv4P+pSXN+/G7eh/e2e3uXHs
         bOOjyCtD9epShLYSFF/qGfWitoceq+oNv8PD1uNphAVQTitfke1k4Cxsz8muIzYF0QgY
         VB9rbm5wEtQiq7GaGllEJhHBw6Tdjcqr8XMwCEL7CsEDyO4i1p6O2PFoabcnVmBxnVc/
         XAGww1cYn4ihOUjsMe0qLpuHKG60UZoEA3cc0HQvDHVu6mORSAiOS3x0Bqsiebwi3Cb7
         jnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704413213; x=1705018013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYi3ShOTCWSVgfC3FFX6YL88YfXo3L5cnVrx8NMJ+V4=;
        b=lmqe1QfDcKuu6OYFOnVKkI6PpmCNdKCI1Iadrdbt1Oyu/v3/S2aOwquJ5M684VZTV7
         313EA+YH6rtaqEycGyWKdxm87Z64aAFBHrVpBID3SRKKf6zyvjYBcqWp2twMdv2W1T4O
         uKOOkLfNGtPOkQ/QHS5mh66x3sCr1dKxZhdNN6sGS1s6u2YkAteRIz+aUrB7FdUYf3sP
         dKRVIu4yO3xD35XFbaRnwnIZ8/TWDbIwg5koUT0J/B/o8G7HLpdItoJMmYiagBvfe1ne
         TG6zdtQE1ruqZVE50/K0XIQfsSPm8zTE6C4NUCn78QCqG/g8K7worETwCFow8UQVcRGQ
         wtIw==
X-Gm-Message-State: AOJu0YziYol8WuGjAWfP4hK53L/+0oRjKEkynKxmLZRR8Q7XN4OACP3A
	A6PmuMbBpYuuNLykbSi3Ev955ko25vgAhIzrgnU=
X-Google-Smtp-Source: AGHT+IEmpiVRzbREW2nwmhrrIY7UhYkVxHRB8TLtD0FiWLyUBplV9SWSptffT4rBFcRR7tqo3PnbFC+Jy+HD84pmHx4=
X-Received: by 2002:a05:6830:10d9:b0:6dc:25a:99fd with SMTP id
 z25-20020a05683010d900b006dc025a99fdmr1509701oto.24.1704413213609; Thu, 04
 Jan 2024 16:06:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com> <674f65e71c5c3e874b6b72b6f9d8cdd7a091b6d0.1701993656.git.jim.cromie@gmail.com>
 <ZYB0gyz-2M3k2kbD@alley> <CAJfuBxyOpPfks69LKOfiz7TPeSmqhCvHzv2qrCwn2CXfZLHJFA@mail.gmail.com>
 <ZZV_2hTP1VQB3VZm@alley>
In-Reply-To: <ZZV_2hTP1VQB3VZm@alley>
From: jim.cromie@gmail.com
Date: Thu, 4 Jan 2024 17:06:27 -0700
Message-ID: <CAJfuBxyaEWrKvbGmXf1xPXMBLpx444AJwxLcG7w9p1Jsza+toQ@mail.gmail.com>
Subject: Re: [re: PATCH v2 00/15 - 03/11] dyndbg: disambiguate quoting in a
 debug msg
To: Petr Mladek <pmladek@suse.com>
Cc: lb@semihalf.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	bleung@google.com, contact@emersion.fr, daniel@ffwll.ch, 
	dianders@chromium.org, groeck@google.com, jbaron@akamai.com, 
	john.ogness@linutronix.de, keescook@chromium.org, ppaalanen@gmail.com, 
	rostedt@goodmis.org, seanpaul@chromium.org, sergey.senozhatsky@gmail.com, 
	upstream@semihalf.com, vincent.whitchurch@axis.com, yanivt@google.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

> I still thing that using "echo" in the form of
>
>      $> echo param param param
>
> is uncommon and even misleading.
>
> Best Regards,
> Petr

we can differ on this.

as to the patch itself,
you dont like it,
I dont need it,
we'll drop it and I'll fix the following commit msg

