Return-Path: <linux-kernel+bounces-19490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659A0826DB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2F32837F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3965A405C2;
	Mon,  8 Jan 2024 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="l4RH7Q3F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659453FE4C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso1966182a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1704716529; x=1705321329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loCTSW/cWAimbJbBfjYbWJOxYcX8K7Dkrp91rEaUo30=;
        b=l4RH7Q3FaNX4QZP6NXoFZ2UF2x1swGUkN+8ICZG8lSTCFpFzR9v3K7P/wZVCi+EPFf
         SDxaL6Y4V36vfBg9WltgHxljyd5o4JhsIrrIEBU0ykzfHB4fKQCyEBHmvr2hMM8PE3jc
         6XqsaPm69rWOgerBc/GhA9H32HrnIgP5PzwsdewDonWZV2hT+O5Y4HRSLjibnAM564UO
         1GQwRU+loqazc5R+YSNfFQaQhA4cBc2qSwwG2ArmKoSo/T2Moyzo8RDv25XYd/D1hwhF
         OiC21m9IqdjKCEhX3t4d9U08JWnlHpcUlLzrl3bma1qUSgVtdRdzdkHB2nLzWFf63rPj
         nSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704716529; x=1705321329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loCTSW/cWAimbJbBfjYbWJOxYcX8K7Dkrp91rEaUo30=;
        b=UU2S74usAxy0jTtObMfRQzEsHYNPLIObQieLpVS4qXLQi1vn5hAuTjWvrvYya6X4Fz
         4zwy7KuOixxkZ+u9uc4RyWKRRPL9fbj2qGCq1Wqp7awdNSyw5MMKTP99zfbpZQGJHnc8
         dQ37NhwI67EqlpPZTSjUn03UxY5j3lf+QZl8YBoTtpKHUGPWRTWMFfLqXX1jwttyZAYu
         qbcpKh1PHlLoM2H74GXx8Oo36/qcewc8o9rMwUzFjozbM2H8iIP1gl8g5E7bOKvG8F3b
         bnb+ELhKouFmyDe7li/04K8SZu0yeRTUv+366Tt9Lo19Fr4bcqOMzk80NLUlj0hcbs/H
         gtKw==
X-Gm-Message-State: AOJu0Yz/+jyXTxQ+0c2GJ5AJaseXvP3wvRCsjkt5ld7hTeI3mMBJtyYZ
	IXqfcTu8hSDI8p51//drC59QaaBxlHSW6ShIIgNg12u2iG34
X-Google-Smtp-Source: AGHT+IE2B3+tm253Uwfn3dg0Mu5ix0nw5vbsuEufSGd1AhhsnUeE0b2UL3X4PHsi7f330GQM6J0+HRrBHrxkySiEKdA=
X-Received: by 2002:a50:d5dc:0:b0:557:60fb:7959 with SMTP id
 g28-20020a50d5dc000000b0055760fb7959mr1306240edj.134.1704716529326; Mon, 08
 Jan 2024 04:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com> <7cb5c8b6c6efba7e437595266638be39f23361fc.1701993656.git.jim.cromie@gmail.com>
 <ZYCBlI56kmDMew6U@alley> <CAK8ByeJHAPijVWbATUxXpXHa7uCn3dwLgi_6ckfWY0ADmBwqcQ@mail.gmail.com>
 <ZZWIhpIBqQzL7PcE@alley>
In-Reply-To: <ZZWIhpIBqQzL7PcE@alley>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date: Mon, 8 Jan 2024 13:21:58 +0100
Message-ID: <CAK8ByeKbYDfrKrmOYjfjfNGd0gR1go7V6998=AjGV6aBRT4k=Q@mail.gmail.com>
Subject: Re: [re: PATCH v2 00/15 - 05/11] dyndbg: change +T:name_terminator to dot
To: Petr Mladek <pmladek@suse.com>
Cc: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, bleung@google.com, contact@emersion.fr, 
	daniel@ffwll.ch, dianders@chromium.org, groeck@google.com, jbaron@akamai.com, 
	john.ogness@linutronix.de, keescook@chromium.org, ppaalanen@gmail.com, 
	rostedt@goodmis.org, seanpaul@chromium.org, sergey.senozhatsky@gmail.com, 
	upstream@semihalf.com, vincent.whitchurch@axis.com, yanivt@google.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

czw., 4 sty 2024 o 08:54 Petr Mladek <pmladek@suse.com> napisa=C5=82(a):
>
> On Thu 2023-12-21 16:21:49, =C5=81ukasz Bartosik wrote:
> > pon., 18 gru 2023 o 18:29 Petr Mladek <pmladek@suse.com> napisa=C5=82(a=
):
> > >
> > > On Thu 2023-12-07 17:15:08, Jim Cromie wrote:
> > > > This replaces ',' with '.' as the char that ends the +T:name.
> > > >
> > > > This allows a later patch to treat ',' as a space, which mostly
> > > > eliminates the need to quote query/rules.  And this in turn avoids
> > > > quoting hassles:
> > > >
> > > >   modprobe test_dynamic_debug dyndbg=3Dclass,D2_CORE,+p
> > > >
> > > > It is particularly good for passing boot-args into test-scripts.
> > > >
> > > >   vng -p 4 -v \
> > > >   -a test_dynamic_debug.dyndbg=3Dclass,D2_CORE,+p
> > >
> > > Could you please add example how it looked before and after?
> >
> > Before a user had to issue a command in the format
> > modprobe test_dynamic_debug dyndbg=3D"class D2_CORE +p"
> >
> > Now a use can use either
> > modprobe test_dynamic_debug dyndbg=3D"class D2_CORE +p"
> > or
> > modprobe test_dynamic_debug dyndbg=3Dclass,D2_CORE,+p
>
> I see. This was not clear to me. Please, mention it in
> the commit message.
>

In the patchset v3 I squashed "dyndbg: change +T:name_terminator to
dot" with "dyndbg: add processing of T(race) flag argument" but I will
clarify this topic in the "dyndbg: treat comma as a token separator"

> That said, I am not sure if it is worth it and if it
> is a good idea. Supporting more formats adds complexity
> and confusion. It is the reason why people hate perl.
>
> I agree that quoting in scripts is complicated. Well,
> a sane approach is to use quotes everywhere where possible.
>
> If a script works correctly only with class,D2_CORE,+p
> and breaks with "class D2_CORE +p" then it is a ticking
> bomb. People might try to use "class D2_CORE +p"
> one day because they would cut&paste the string
> from the internet.
>

Addition of new format of dynamic debug queries does not obsolete the
existing format.

> > > Is this format documented somewhere?
> > > Will the documentation get updated?
> >
> > Documentation will be updated.
> >
> > > Could it break existing scripts? [*]
> >
> > It should not break any scripts as this change does not change the
> > interface but extends it.
> >
> > > The dynamic debug interface is really hard to use for me
> > > as an occasional user. I always have to look into
> > > Documentation/admin-guide/dynamic-debug-howto.rst
> > >
> > > Anyway, there should be a good reason to change the interface.
> > > And the exaplantion:
> > >
> > >    "Let's use '.' instead of ',' so that we could later
> > >     treat ',' as space"
> > >
> > > sounds scarry. It does not explain what is the advantage at all.
> > >
> > I will clarify in the commit message that this change allows to use
> > two formats either
> > modprobe test_dynamic_debug dyndbg=3D"class D2_CORE +p"
> > or
> > modprobe test_dynamic_debug dyndbg=3Dclass,D2_CORE,+p
>
> But the patch replaces ',' with '.'. It looks like it modifies
> some existing syntax.
>
> Note that I am not familiar with this code. And I even do not see
> the patched function in the current Linus' tree.
>

Next patchset will include updated dynamic debug documentation.
Hopefully this will help to resolve doubts.

Regards,
Lukasz

> Best Regards,
> Petr
>

