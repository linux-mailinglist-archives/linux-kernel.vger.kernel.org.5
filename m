Return-Path: <linux-kernel+bounces-37643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317BF83B2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41BA1F22F90
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCE7133981;
	Wed, 24 Jan 2024 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhtQrtTL"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786913341A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127712; cv=none; b=lLixK/raNGTVBhFZljXfwNOVcK4bELQ7qPN6Z9Hf4LraFNZIF2oxh58/nMGIA1yFIqPJbv1+vHCBhFYkrtXPu/c6PeNetErF8vVv8jvPGHyw6poO8judlHRTaqHPM+cm4LgM3qCH3TGSeXaIp4rVuxOBgTRG2GWMUWLkWasJMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127712; c=relaxed/simple;
	bh=LNSKSzvs2ljLvTMYKnjzvlKWDygso/Wh3QR4cqKrHPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKsZllZMVp4FSMNsUwxnXPEWU1FgEEfYc8nxvLGKQ3wotl5husG7AxhsJrbApa20aN145DQfCQXopshPHJ0okqBtPRbkRjxSXEACw0KyXUJIPxxr/xKHu7L9vqDPyiqAUSA9ZhNd9PjgLaWxxDJGxHLHeyVEbBojrDtk81p8Ybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhtQrtTL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ddc0c02665so589047b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706127710; x=1706732510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMwNi5kNbBjiibbpUwYiOJds2nMSzlktlZQe4MVPO8Q=;
        b=YhtQrtTLJuKXM1gD+Qcfwgjwv9BCldfANNHJO54u2o3rmYKofw2fLhaiwtSLOyYkV2
         2QUD46MNighRiNKgyd8RAA7LcJzveeMUe4hkMW7CSWFzbkVG2yxxRhjoVQ29C1o8afcv
         +FBPTYGdTGW1dVTZ3MHbpwZ/Uq9pdysRh2U290F0c03xnFV/out9Jy54Gg+EroWvf7sQ
         X3tdClq8YaJ1KvcmuPyl1a+RaFzYJPqVRk3zGiQc79tZjGXGjKEykGx5cXnA2FrF0T5S
         v+ZWfpX/Sacmz0T14xKG4wWCaQKCpDsIDzTLT5xKzzXb9GfCcA43xZgxBiBVxZnLMEmR
         WxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706127710; x=1706732510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMwNi5kNbBjiibbpUwYiOJds2nMSzlktlZQe4MVPO8Q=;
        b=FbPwLjpikp9zwUK+IUL8A09zyn8DwWzlzCc+X5YIrRYbEd3Tr6lyKxAgaTQ7ArqzyJ
         NAepqNAM78Gtzr2zCbbhqsieKH4TZ6homeYYlkFoNa9JSt/Df9y9qIm1oopa4kJc+kkK
         dIuUC5mC164F41y18SnefWzbVSJUKn6L3fxmchmct7+Pc95kOZ/ob+tKcZLU8xu0fK9k
         JPuDNsxsMTQ03uqtFSixNrR1L2raAyeib/JAl/r4FNYh68gz7RCwLL1MRfb0U+m3w2+h
         8XuobhPEhaZUQpJDQnOTynRQnKIdDcn1R4rq6riEmqtYZHRxYYDJ8ofZs3QisIrthKwq
         8fyA==
X-Gm-Message-State: AOJu0YzwWNNxnpltxyZnnnrpqP5bZ07+vFyQGwZs2qKbsuH4BRQT07YA
	4DX394KXtlAjJtlVlI0q1Yy7w4oOC+fSWZ3/FtI4IC5A91ODsIKVR1gyyfrclm+Bbq7je+Ejk5r
	mU83St/FgKmWkh+tV9N85f7F32xU=
X-Google-Smtp-Source: AGHT+IGDX6D0oFWtuFmABbjGrfo2fIBX+9sdMbFAJJSPrhHlAu3U99NIGliSiXlr+T1LZUpUf+2FYFbJk2PC6b5dWag=
X-Received: by 2002:aa7:9a11:0:b0:6db:e5d6:68c5 with SMTP id
 w17-20020aa79a11000000b006dbe5d668c5mr126236pfj.7.1706127710103; Wed, 24 Jan
 2024 12:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADBGO79JycAycKXm9A46pLrGZHTsySV4NH+yvV7VFU-8reMF=Q@mail.gmail.com>
In-Reply-To: <CADBGO79JycAycKXm9A46pLrGZHTsySV4NH+yvV7VFU-8reMF=Q@mail.gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Wed, 24 Jan 2024 13:21:23 -0700
Message-ID: <CADBGO78cNfZZFA_iDbjatiyvSwF3G7DjbddqTpQyw4zMoyC5ZQ@mail.gmail.com>
Subject: Re: [REGRESSION BISECTED] 6.8-rc1 - Wayland hangs when connecting via
 VNC or RDP
To: Luben Tuikov <ltuikov89@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I forgot to say what graphics driver I'm using. It is amdgpu.

p.s. Sorry for the bad formatting in my previous email, it has been a while
since I posted to LKML.

Thanks,
Paul

On Wed, Jan 24, 2024 at 12:47=E2=80=AFPM Paul Zimmerman <pauldzim@gmail.com=
> wrote:
>
> When I attempt to connect via VNC or RDP to my Ubuntu desktop, the Waylan=
d
> server seems to hang. The desktop GUI no longer works either locally or
> remotely. I can still log in via ssh, so the system is still alive,
> but the GUI is
> frozen. If I boot into Xorg instead, everything works fine. Kernel 6.7
> works fine
> also.
>
> I bisected this to commit f7fe64ad0f22 "drm/sched: Split free_job into
> own work item".
> That commit does not revert cleanly however.
>
> I don't see anything in dmesg when this happens. Here is a snippet from
> journalctl when it happens:
> Jan 23 16:14:30 paulz-Precision-5820-Tower systemd[2826]: Started
> Tracker metadata extractor.
> Jan 23 16:14:55 paulz-Precision-5820-Tower systemd[2826]: Started
> Application launched by gnome-session-binary.
> Jan 23 16:16:47 paulz-Precision-5820-Tower
> gnome-remote-desktop-daemon[4158]: [16:16:47:810] [4158:4896]
> [ERROR][com.freerdp.core.peer] - Incorrect RDP header.
> Jan 23 16:16:47 paulz-Precision-5820-Tower
> gnome-remote-desktop-daemon[4158]: [16:16:47:810] [4158:4896]
> [ERROR][com.freerdp.core.peer] - peer_recv_callback:
> CONNECTION_STATE_ACTIVE - peer_recv_pdu() fail
> Jan 23 16:16:47 paulz-Precision-5820-Tower
> gnome-remote-desktop-daemon[4158]: [16:16:47:810] [4158:4896]
> [ERROR][com.freerdp.core.transport] - transport_check_fds:
> transport->ReceiveCallback() - -1
> Jan 23 16:16:47 paulz-Precision-5820-Tower gnome-remote-de[4158]:
> Unable to check file descriptor, closing connection
> Jan 23 16:16:47 paulz-Precision-5820-Tower systemd[1]:
> run-user-1001-gnome\x2dremote\x2ddesktop-cliprdr\x2d9Tp4LD.mount:
> Deactivated successfully.
>
> This is on an x86_64 Xeon system running Ubuntu 22.04.3.  Any hints on ho=
w to
> debug this further? Is there a way to turn on additional debug prints for=
 this?
>
> Thanks,
> Paul

