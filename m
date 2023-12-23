Return-Path: <linux-kernel+bounces-10472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A4B81D4C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D5D1C20C54
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E747125C6;
	Sat, 23 Dec 2023 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbbPgjTH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BA711C8A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso22179445e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 07:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703344414; x=1703949214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7RZjFb+nij+zY4Pr94c1OS3SH59BuL/+qyNrJdQ5ag=;
        b=gbbPgjTHKdPviU/9QrInoxgU2C/7/bIlEygJoC8fJjBOSpHTppoPUEhCRMyZ6l7xD6
         nmMOY2YOlQ+3UGr3YWdCE9+b3ugGS9lCKxwshcvczzpfGDLkp3juliriSx/lLmUdM+UL
         cq5tI9NHWGj50FnAl8gd1NRR2GCemnWkbACiCQ7c+t9D1QXtsUSTW2jYgRW9FB8ZKEIo
         dpIk7gYx7u0P9otlrfprI1q97atW5RLJzdAv4eBOeLbOBAIcn1lO56pc5PiWQThfXlvA
         WsayVzq6AEnUbtQoAxIreupTknvQRCYyYuNSkjLmpvqTsfg3wz4fYAgWf0KFzg/qFp1X
         z5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703344414; x=1703949214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7RZjFb+nij+zY4Pr94c1OS3SH59BuL/+qyNrJdQ5ag=;
        b=R3xwl1UwZj5nOEB3uTfqX5XPr5bXV0EMoJttMixieV5WuIk+PJxGKhEV5OtIPpX0J1
         t3aM2tOpCUdoTkGROyqaHhdY/1LTu3DeG+jIU9DMJb9dXsQZqa5VWkMQUINnrziTSbup
         A3Skt7HULj4TOd6l5UdxX8qWQJWkf9+cj8E28Mac1vXRXT2tV3GixVGa+FGZDp5SkyEm
         7veXkRy1xepVxEeEr38/cXwmvujkScZ/QHv96am7i1ig84IMcRN0RPiiQqLAl3iRbhBm
         Brtm3jnBJhEVNTYwjPsM6LBPS96nmzDVlERI7Npue2Vqronq6CK5JCxmucB9KzzPzzb0
         qRJQ==
X-Gm-Message-State: AOJu0YyOd1N8TGkupfyZum/8UH5ifmDeDaVtqI2WDq2ZegmUAHwLiX7A
	NfT+hMTkI8/6j3EYaTcsx3o2bYRX1oalk48ZpYI=
X-Google-Smtp-Source: AGHT+IEFK/Y1UR42XOxBItq4BK6z+twGv8PfA7HsXO8dlqD2hfT5pSad5X0+YLw+5gEHRgHpU0GJOlkE8+oxSUcZdMk=
X-Received: by 2002:a05:600c:a47:b0:40d:1257:36fd with SMTP id
 c7-20020a05600c0a4700b0040d125736fdmr1711349wmq.93.1703344413892; Sat, 23 Dec
 2023 07:13:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221130930.32634-1-ruipengqi7@gmail.com> <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
 <CADHLONGLZaZT4Ot56AnxOf=ROrTWvge5=NUx5uqKqJhpJibfOQ@mail.gmail.com> <6fe05804-da74-45cd-a6f1-df4644671d99@linaro.org>
In-Reply-To: <6fe05804-da74-45cd-a6f1-df4644671d99@linaro.org>
From: ruipeng qi <ruipengqi7@gmail.com>
Date: Sat, 23 Dec 2023 23:13:22 +0800
Message-ID: <CADHLONE2YnBJGJUp2-vn_XEpc7+quTMWF7y1zpV0ygeL2VpQxA@mail.gmail.com>
Subject: Re: [PATCH 1/7] [RFC PATCH 1/7] osdump: Add one new os minidump module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, zalbassam@google.com, dianders@chromium.org, 
	mark.rutland@arm.com, lecopzer.chen@mediatek.com, maz@kernel.org, 
	arnd@arndb.de, yury.norov@gmail.com, brauner@kernel.org, mcgrof@kernel.org, 
	maninder1.s@samsung.com, michael.christie@oracle.com, samitolvanen@google.com, 
	linux-arm-kernel@lists.infradead.org, qiruipeng@lixiang.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 10:23=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> > Qcom minidump can dump some logs like dmsg, some status like IRQ or
> > Run queue. This can help to learn some information when the issue occur=
s,
> > which will help to find out the root cause. But what it dumps are limit=
ed, it
> > doesn't dump w and lock if they are not local data.
>
> So add missing features to it. I don't think you got my comment and keep
> arguing on the same thing repeated for upstream submissions many times.
> We do not want multiple vendor solutions. Every vendor wants his work
> and does not care about integrating or reusing other pieces.
>
> >
> > For osdump, it dumps objects stored in slab, datas in bss, data segment=
s,
> > some data alloced with memblock, data stored in local stack, and so on.
> > In a word, it dumps almost all of the key data in the kernel. Besides, =
you
> > can use the crash tool to analyze the dump file.
>
> I don't see a problem why minidump cannot do it.
Qcom minidump allows one kernel client to register its region to dump, and =
then
driver will create and maintain one elf head for it.
But osdump will dump thousands of non-continuous regions. If you register o=
ne
by one, and add an elf head for each, it will cause heavy overhead. So it s=
tore
data in binary, and reassemble a standard elf format file offline for debug=
.

Sir, I am not really familiar with Qcom minidump, and some options may be w=
rong.
But do you think it is ok to integrate osdump to Qcom? Looking forward to y=
our
suggestions!

Best Regards
Ruipeng

