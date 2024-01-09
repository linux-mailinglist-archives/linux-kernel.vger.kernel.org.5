Return-Path: <linux-kernel+bounces-21035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8F88288DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CF91F2508B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF7739FD9;
	Tue,  9 Jan 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFGJKvaa"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB4F39FC1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbc6bcc78so2949784b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 07:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704813602; x=1705418402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS1OshAOm1oMEMtX2tH4VkjRRoX4+AFyxwPgDdf1+GY=;
        b=aFGJKvaavTPi8sUM9EBJgLqnKR2YeQBCJlx8s+nrFCGs9uuCINDxNQEttHFiSrDloI
         OPA9gA3lDinTCj+Ccoz0FZAbMXV0P0mK2Hf95FhdwR676yImD/NVJRx6IaBwIZoKdrTF
         Q+PCy9yEecboAKOGlXVdJ3ixNa70FODb0UY+EA+/Vycb/WcnI5G9EvSnBmbrWG1weV8g
         IkVqSZmYZ+OaPr6pcCyjVS/Dy83l3pdbq6KpC+vHpk32tfjkV0Ocsyf61VuC3m17JW9m
         KRNS9yslwffwiuKvgYnVhhYaExOUDtPUmQdaYfHjAjJhelK6qeCtGJfGDF7rXCwebWHJ
         YFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704813602; x=1705418402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS1OshAOm1oMEMtX2tH4VkjRRoX4+AFyxwPgDdf1+GY=;
        b=g1U5+II6DvT9ltk5rQ3tWytfZsQKE9kOXRpXY/0ZT6UUDIQSsCXic3gsYDvBip9rkY
         qHY2Zc2W/x3F0kLRVf4x591YTIrrfuA0C7coOFymvAXbVFR/fqx2JiDOS3T82XrkB57I
         oRB0eXw9oWwJ3Uo/Cn4opjTrIaJMTkLUn7IxR5b0cep/+ZBUNjtNNDRzeF81PRQvZnrq
         OXIkA3vonFgLllF/vxU4YG0bVh2oMmvIyiaS34SpfU0KXekHG3Mo0mrAc7/C6kb9tDJI
         541Ym0gw+Rpf4y2FOEgJSpRJd62ArHZDjuxiQ+ynTcalaLiX7TOMYT3+froXG7eiKICx
         Mmdg==
X-Gm-Message-State: AOJu0YyXAedY8LJMW6EuS5MI0E+2Pufz9AJ/C40A7ei0nJg/hyhQmajf
	h315gb9cuE6deVCH7utCOU11Ms5yZNQdHm2qlu4=
X-Google-Smtp-Source: AGHT+IFFjPl9Z4mQeLV2vlQDfbiAI7oViMVfhlsw40TJT37ovGzGB9auWTqHpo62zim6QeVUrbLaY3TK0s5oGskNDXA=
X-Received: by 2002:a05:6808:2086:b0:3bc:1fd4:4ba7 with SMTP id
 s6-20020a056808208600b003bc1fd44ba7mr6018082oiw.78.1704813602297; Tue, 09 Jan
 2024 07:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130234048.157509-1-lb@semihalf.com> <20231130234048.157509-11-lb@semihalf.com>
 <69bd53de-0948-469f-ae58-48098af1973c@akamai.com>
In-Reply-To: <69bd53de-0948-469f-ae58-48098af1973c@akamai.com>
From: jim.cromie@gmail.com
Date: Tue, 9 Jan 2024 08:19:35 -0700
Message-ID: <CAJfuBxxh7eF+DwMHvy_e6NsNEJ89R6Bqy8Mo5QF8qZwrMsSpgg@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dyndbg: add open and close commands for trace
To: Jason Baron <jbaron@akamai.com>
Cc: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Douglas Anderson <dianders@chromium.org>, Guenter Roeck <groeck@google.com>, 
	Yaniv Tzoreff <yanivt@google.com>, Benson Leung <bleung@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Pekka Paalanen <ppaalanen@gmail.com>, Sean Paul <seanpaul@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 3:46=E2=80=AFPM Jason Baron <jbaron@akamai.com> wrot=
e:
>
> On 11/30/23 6:40 PM, =C5=81ukasz Bartosik wrote:
> > Add open and close commands for opening and closing trace instances.
> > The open command has to be mandatory followed by a trace instance name.
> > If a trace instance already exists in <debugfs>/tracing/instances
> > directory then the open command will reuse it otherwise a new trace
> > instance with a name provided to the open will be created. Close
> > command closes previously opened trace instance. The close will
> > fail if a user tries to close non-existent trace instances or an
> > instance which was not previously opened.
> >
> > For example the following command will open (create or reuse existing)
> > trace instance located in <debugfs>/tracing/instances/usbcore:
> >
> >      echo "open usbcore" > <debugfs>/dynamic_debug/control
>
> Hi,
>
> I'm wondering why this needs to be part of dynamic debug? Can't we make
> trace instances via 'mkdir' and then use those from the dynamic debug sid=
e?
>

I believe thats what happens now -

open foo on already opened foo is not an error.
so if the instance is already created, it just gets used, without
clearing the buffer.
So it can integrate with externally admin'd tracebufs.

the open foo requirement means that we can validate foo,
and error properly if it is mis-spelled



> Thanks,
>
> -Jason
>
>

