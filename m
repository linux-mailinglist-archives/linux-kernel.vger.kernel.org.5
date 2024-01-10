Return-Path: <linux-kernel+bounces-22176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461CB829A82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5651C256D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3654878D;
	Wed, 10 Jan 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="Gc9d3wuR"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8C48788
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so7249115a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 04:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1704890450; x=1705495250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9jsUN/BVeIkcbXy/z5zJSURXSeGDLSMnvhduytMxik=;
        b=Gc9d3wuRjWi9XYno5/3tru0I7+ClNwDGNQ5S6mMV7xykhEZOZ3smWYtvlu1comOsda
         R7w6U7xEYoO9DiaE05xTBVC+XmrR9kU/kuREAIFzvF5LTw9eldpuRk/ngCMqngnwueOa
         qo6x+vs9MPAPLesIUZYRlKsO9Ho+JyuiLVh1Z51OQFIC8BENlR+P6iL6mGCE8vfmlQNg
         h2CBPqZULH82r5+mnSpiO1fEPVo0wO6nJYOrS06i+Z3NLCkrb+93n+ZhcQHVhnNKS6jQ
         fY1vaA83jGnlQ75lVEOpmOwY5Dy9SHikDNBddeobVcgLIj6z//H4n4c1FQF7HhRQFIfP
         w6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704890450; x=1705495250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9jsUN/BVeIkcbXy/z5zJSURXSeGDLSMnvhduytMxik=;
        b=wlS3e6RtRdTDbyMSoZL36P36dUl7+QruTeiJM2eD52lOhaxu2GIDHoSVVrxNxe7Kz4
         qGkATvYs5XOGApoM+iILcF+nU7VbVSDTqCZ16vT4pJ3WXsclDhQaVUqoWm364JzLPRYE
         WSRl6t+CNh2GRFAhzi8/nLmvg2abgZRpi546IKP4U/bTum+D5e9xZA6tVW6hH7axy8Jt
         BmMC6m65eZDRv0FWYfWEhKukyrQHoTf9TcHCD9P8UFO0xVYXvSho7QQInmen4swSTC1c
         DDEjrkbB2/GCShcj6TAz29WESh1fkUVQ6B68qIE/IjHx4/8r2dl7LiKadeAFd5zy1/5d
         duqA==
X-Gm-Message-State: AOJu0YxjvqmGPeD8z7qDlg0jtuHELX1YqCmremQ+1oG079v8B3F2WCn8
	1QWwnFGhBZ5+YyrpsJLjmIeg7DK3IIrBH3oWbGnIr0zUm0dQ
X-Google-Smtp-Source: AGHT+IGZl2Sg5PGdainwSgKoXbgdF1nB4xAMFfxjxsr0NvnHJSVrfiNKwVxzQhmh+1vSzlNWne2yIBrEmGSKqpKgT5Q=
X-Received: by 2002:aa7:c1d8:0:b0:557:e391:ec65 with SMTP id
 d24-20020aa7c1d8000000b00557e391ec65mr655363edp.20.1704890450415; Wed, 10 Jan
 2024 04:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130234048.157509-1-lb@semihalf.com> <20231130234048.157509-11-lb@semihalf.com>
 <69bd53de-0948-469f-ae58-48098af1973c@akamai.com> <CAJfuBxxh7eF+DwMHvy_e6NsNEJ89R6Bqy8Mo5QF8qZwrMsSpgg@mail.gmail.com>
In-Reply-To: <CAJfuBxxh7eF+DwMHvy_e6NsNEJ89R6Bqy8Mo5QF8qZwrMsSpgg@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date: Wed, 10 Jan 2024 13:40:38 +0100
Message-ID: <CAK8ByeLg7UYA3=bMYyVHQks6RP8FbkuCJ6+q94hk0ZgdQknB7g@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dyndbg: add open and close commands for trace
To: jim.cromie@gmail.com, Jason Baron <jbaron@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Douglas Anderson <dianders@chromium.org>, Guenter Roeck <groeck@google.com>, 
	Yaniv Tzoreff <yanivt@google.com>, Benson Leung <bleung@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Pekka Paalanen <ppaalanen@gmail.com>, Sean Paul <seanpaul@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 9 sty 2024 o 16:20 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Fri, Jan 5, 2024 at 3:46=E2=80=AFPM Jason Baron <jbaron@akamai.com> wr=
ote:
> >
> > On 11/30/23 6:40 PM, =C5=81ukasz Bartosik wrote:
> > > Add open and close commands for opening and closing trace instances.
> > > The open command has to be mandatory followed by a trace instance nam=
e.
> > > If a trace instance already exists in <debugfs>/tracing/instances
> > > directory then the open command will reuse it otherwise a new trace
> > > instance with a name provided to the open will be created. Close
> > > command closes previously opened trace instance. The close will
> > > fail if a user tries to close non-existent trace instances or an
> > > instance which was not previously opened.
> > >
> > > For example the following command will open (create or reuse existing=
)
> > > trace instance located in <debugfs>/tracing/instances/usbcore:
> > >
> > >      echo "open usbcore" > <debugfs>/dynamic_debug/control
> >
> > Hi,
> >
> > I'm wondering why this needs to be part of dynamic debug? Can't we make
> > trace instances via 'mkdir' and then use those from the dynamic debug s=
ide?
> >
>
> I believe thats what happens now -
>
> open foo on already opened foo is not an error.
> so if the instance is already created, it just gets used, without
> clearing the buffer.

Yes, I confirm this behavior.

> So it can integrate with externally admin'd tracebufs.
>
> the open foo requirement means that we can validate foo,
> and error properly if it is mis-spelled
>
>
>
> > Thanks,
> >
> > -Jason
> >
> >

