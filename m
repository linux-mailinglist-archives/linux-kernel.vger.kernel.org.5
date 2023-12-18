Return-Path: <linux-kernel+bounces-4176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2675B8178D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8F4B216AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408D85BF9D;
	Mon, 18 Dec 2023 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxAf7ckF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1A1E4BF;
	Mon, 18 Dec 2023 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ceb2501f1bso3124281b3a.0;
        Mon, 18 Dec 2023 09:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702920824; x=1703525624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrrdb72hryOiQh+u7nxbNRimC+6/pwn0HNgKp0aqgVU=;
        b=BxAf7ckFxtZ4xRObZAMnxTiRjsgMwwG38vCQk/ecdSs+Gz7X4R57uJVbF1YQB1kVsX
         Ovh1XKTdVpmioOuWQ6GZK89/uB4BvUAZjkdCJ+cwQiiSzlo23kw+MVBGzG76QYMwKLMy
         1qak+/arYLezUH3lTLEVS9j0a7yURLS47xkWL2CadmQ4zkpv6VjwctX/UWsCE08qF4+l
         R3Vs84iVniY9QzUz+cPy1wNdOfA31xI073rAxQ4ysBQt8I3EIkcSV9/LHpZClt7TH1x1
         uPdsCC0i/fc1EvmZJjOPmLoCorwSmrbLpE6Va73E3tP6AaUfP7+68J00+eCvOYpI8lCa
         VXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920825; x=1703525625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrrdb72hryOiQh+u7nxbNRimC+6/pwn0HNgKp0aqgVU=;
        b=sldS7+ZM8Ic83AYzHo6Bj+/Nk2TLvr9+zOhO1ZoxPU7UZsrF+QQKgjn9WbbmLebgrX
         89hYXkZ/CraRr3XAOokMjvp841f7mL5goTR4l6YTfNyYFgw0rBF7Hor3lZMiorHltKyp
         bz9+6P77cokWAl1ZtHoOiT12XDTgrory9HDkPh16130/jtSyBMGJFpdmb3/qWt39pAZK
         +SmETHzxsC3nf6xhxRokCjjIS5lJgQuh4KeX3kSY0+JCwLHcoCsGJSAzU+uAF9B4MnWz
         FJl+2RdHOHgJzrnuR/ZG6osQNCLQN9Cc1juTfn916eL5Ll+3NQ1hgW4qb7TaFDC90zcM
         UmdQ==
X-Gm-Message-State: AOJu0Yzu6dTk5Bdkz4GslQnxKDCn75vJrwqzx4tIqFK7i0z+dWfz/F6X
	VimdZE2rQhFMwb68Gab1tm03VJEnrAMqn+32vnA=
X-Google-Smtp-Source: AGHT+IEl/3podabf9JW3rwvs37X8Z3eFup1Qa1APK02q/QJjpYM5BqxkB+oCv9Hiphu4seWH9LCso07CPCn6vw8c/J4=
X-Received: by 2002:a05:6a00:c81:b0:6cb:a2f4:8579 with SMTP id
 a1-20020a056a000c8100b006cba2f48579mr19678291pfv.15.1702920824664; Mon, 18
 Dec 2023 09:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
 <20231212131712.1816324-5-maxime.coquelin@redhat.com> <CAEjxPJ6zMbM5jPkLC_wDHsXWXofWcDntHRDWQTS6hojECVJPTw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6zMbM5jPkLC_wDHsXWXofWcDntHRDWQTS6hojECVJPTw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 Dec 2023 12:33:33 -0500
Message-ID: <CAEjxPJ77cdHUvxWqLzmYwjLqFiSJH4kwByx7vAvR7dLfqcLy0g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] vduse: Add LSM hook to check Virtio device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	eparis@parisplace.org, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:21=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Dec 12, 2023 at 8:17=E2=80=AFAM Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
> >
> > This patch introduces a LSM hook for devices creation,
> > destruction (ioctl()) and opening (open()) operations,
> > checking the application is allowed to perform these
> > operations for the Virtio device type.
>
> Can you explain why the existing LSM hooks and SELinux implementation
> are not sufficient? We already control the ability to open device
> nodes via selinux_inode_permission() and selinux_file_open(), and can
> support fine-grained per-cmd ioctl checking via selinux_file_ioctl().
> And it should already be possible to label these nodes distinctly
> through existing mechanisms (file_contexts if udev-created/labeled,
> genfs_contexts if kernel-created). What exactly can't you do today
> that this hook enables?

(added Ondrej to the distribution; IMHO we should swap him into
MAINTAINERS in place of Eric Paris since Eric has long-since moved on
from SELinux and Ondrej serves in that capacity these days)

Other items to consider:
- If vduse devices are created using anonymous inodes, then SELinux
grew a general facility for labeling and controlling the creation of
those via selinux_inode_init_security_anon().
- You can encode information about the device into its SELinux type
that then allows you to distinguish things like net vs block based on
the device's SELinux security context rather than encoding that in the
permission bits.
- If you truly need new LSM hooks (which you need to prove first),
then you should pass some usable information about the object in
question to allow SELinux to find a security context for it. Like an
inode associated with the device, for example.

