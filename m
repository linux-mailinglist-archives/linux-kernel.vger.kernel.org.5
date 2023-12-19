Return-Path: <linux-kernel+bounces-5803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA669818FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588521F22675
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE69637D2F;
	Tue, 19 Dec 2023 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YvGSRlqR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780539840
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbd04e7d183so3118279276.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703010043; x=1703614843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgph0xx62tfEVrK2mU0HsXwH2WGhvP+EnxtPD5Kw9NY=;
        b=YvGSRlqRT+hX3yAzJBHLxMgvxXGvh9/BAUMl5S53xiEIl02NzQUpA4XuPOcJnSzbGN
         /2GORRUSlTT5ZAEL3alqwIkhhMjuJFwnbDwiA708ZZH4Cmaww/VnoyRTiUcW80d+cjJo
         sgpBJW4LJmF4fACuqjpNzlblIqxbcPmbHj/GsP9qNkYZr+viBf8uxv/Sj5LH+0CDJMzL
         XrmYdJUCw55ok9+4wjWNUNW2pgHxYZ2Xkef3wPry5Gdzvgtmpqktbo37HGtQG01CFF8P
         ovjP7PWH1o0qQyK/FhcXzGtHvBcOr94V/yn1Jz1d9ifyXOLdQ2Kv102t52s2NmqWlwlP
         OvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703010043; x=1703614843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgph0xx62tfEVrK2mU0HsXwH2WGhvP+EnxtPD5Kw9NY=;
        b=wiMkf/7KO6WV5A+XyUaqMFX7a5r0gKzvohcNaKMRxA9N8LrFzJyjOryODUfUAUW4Ti
         D/SgZBZ087Uio2BIJwXDoIrZly/vDLjLoOr6fQ4giT/SPDn+NJVwwTJjVPLXTdfgK7Ib
         DZswOy8eGrYb8d14G8YZOQyfsqU7h5Voj6boHNgULx0TnKYh0XV+R+k0gbjPPGsvxdjC
         ZqjiSfNpDcC8TzJZiHUo1R5jGKua9v+4TAWcAG8u//OuOKDtJDv8Xr/Rn75hmjKIekgI
         RU/uBQZYRRCTyqhvgx75IV+TdM2Q8V2yXJHahwPhLF0SlroKTXgtjHCkvFh0z0wQ9zyO
         OkYw==
X-Gm-Message-State: AOJu0YxKb2VpXdZ6aXyDkNaXDoDQ1mC4kiKyZd5f8XDE7dix+Yp0k4ao
	7XzJMM+H7pdrmudhyVbPxOm9cZGlRfbS3Y7hMNrF
X-Google-Smtp-Source: AGHT+IG2ONgtcoT47Z9l781a7bW2xcjjJeRGvkYkQbojW55k5C8WrZ/0wZW5Ybv1u01qKlii34AZLXUE8IlWaWZfrbo=
X-Received: by 2002:a25:ac01:0:b0:dbc:efce:f34c with SMTP id
 w1-20020a25ac01000000b00dbcefcef34cmr4115248ybi.0.1703010042731; Tue, 19 Dec
 2023 10:20:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
 <20231212131712.1816324-5-maxime.coquelin@redhat.com> <CAEjxPJ6zMbM5jPkLC_wDHsXWXofWcDntHRDWQTS6hojECVJPTw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6zMbM5jPkLC_wDHsXWXofWcDntHRDWQTS6hojECVJPTw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Dec 2023 13:20:31 -0500
Message-ID: <CAHC9VhSkGwzWV8T06LdoGXyvrnP7tiYMPYmbmVxWoQg6wzEDiQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] vduse: Add LSM hook to check Virtio device type
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, jmorris@namei.org, serge@hallyn.com, 
	eparis@parisplace.org, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:21=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Dec 12, 2023 at 8:17=E2=80=AFAM Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
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

I asked something similar back in the v4 patchset to see if there was
some special labeling concerns that required the use of a dedicated
hook and from what I can see there are none.

> Other items to consider:
> - If vduse devices are created using anonymous inodes, then SELinux
> grew a general facility for labeling and controlling the creation of
> those via selinux_inode_init_security_anon().

For the vduse folks, the associated LSM API function is
security_inode_init_security_anon(); please don't call into SELinux
directly.

> - You can encode information about the device into its SELinux type
> that then allows you to distinguish things like net vs block based on
> the device's SELinux security context rather than encoding that in the
> permission bits.
> - If you truly need new LSM hooks (which you need to prove first),
> then you should pass some usable information about the object in
> question to allow SELinux to find a security context for it. Like an
> inode associated with the device, for example.

I agree with Stephen and I still remain skeptical that these hooks are
needed.  Until I see a compelling case as to why the existing LSM
hooks are not sufficient I can't ACK these hooks.

--=20
paul-moore.com

