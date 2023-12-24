Return-Path: <linux-kernel+bounces-10823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5255181DC65
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 21:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E33B21364
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 20:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B3BEED2;
	Sun, 24 Dec 2023 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YOtIarov"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1164EE574
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2048e63dbd9so107748fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 12:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703451208; x=1704056008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eJ5kELvKhedX9EnpknPh9Uzs8+yLEfkilDmWrRStKw=;
        b=YOtIarov/J6s9xsM6LiDPNK781OXlfgxMeMGXf2gy+ubMCSSqe8JmweU4DRCxIID72
         iAFaKfGmgTyPnB0SHaKIyp5BbHF36gC6fyv37TjbgrxKWhQmC3vWwNiyD7DNfShd7oDw
         PfIqwSMqF8iSyMQW/pFlidLHJYmNyzwjOS1MetE/oU1sk+O6v7xhmX8Qb/HowVAumivC
         hB/whMgie+6f03Rp3wtvN/x6l8/SY3sRhna2Tlo6QkJbEPmX2dubuc5HnmRLOTtSntqm
         FbF4L4A4UsZpMQ1S68abZOLVPDrLo3Bj1Q+VPyLRoCUk8LZ/tjVAtEtLVsQhKUrrr/fW
         N3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703451208; x=1704056008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eJ5kELvKhedX9EnpknPh9Uzs8+yLEfkilDmWrRStKw=;
        b=b/ogmvo9EL/o8GPS7sQDBl05G2ZRK6siru3ElD5ZXrX7E6Q1Fj75uB5BHk0MDAS5Uu
         l+em5p+FSgUQvNNqX2J+ZYSlL55BcSit4HOs1LgCPG6bz93JEyAMRUFmwkPJYy+pHyEU
         AwAZbQ0clzWblBeIelgtPsDEtmu1NB4lRuR8miyuxLMyYOtUZgCutg2vUeYcctbGx3Vc
         Jxtl06EHHGv2k9xM9qmfNmxvCLLF4fWxYeYDIpSc1ZocjBnMZKC8l+mmicMjLxUQiCOK
         At3Eyhyl2yI6LD4nhdPaK49GWBDsOl56BreL9+vl8noGGw0ONK722Ujs96qE2C+5ivah
         +LEA==
X-Gm-Message-State: AOJu0Yy0BfjlTO/YuzxLh1Uz6+wVv7POVCaveDshnl9T13cQE+RDz7bX
	Up0bIe9xmJjV7kCB1z/azz1WhumI8sDgPNAwqRNNc25xMvH1
X-Google-Smtp-Source: AGHT+IHJn2RMPINVg7kRyhtjoEo7CrInLSg++LDl2IOK5pQWVQokOc8gh9qoWmJejDIY2LhqBpVSFISgcHzHDX7bp84=
X-Received: by 2002:a05:6358:7e56:b0:174:c61a:4dd4 with SMTP id
 p22-20020a0563587e5600b00174c61a4dd4mr3742363rwm.41.1703451208018; Sun, 24
 Dec 2023 12:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
In-Reply-To: <20231219090909.2827497-1-alpic@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 24 Dec 2023 15:53:16 -0500
Message-ID: <CAHC9VhRDPv4-gNNiFMNtP_vL8UM66RQX0vxB0WkNw3Rn_Lcfmg@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Alfred Piccioni <alpic@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:09=E2=80=AFAM Alfred Piccioni <alpic@google.com> =
wrote:
>
> Some ioctl commands do not require ioctl permission, but are routed to
> other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
>
> However, if a 32-bit process is running on a 64-bit kernel, it emits
> 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> being checked erroneously, which leads to these ioctl operations being
> routed to the ioctl permission, rather than the correct file
> permissions.
>
> This was also noted in a RED-PEN finding from a while back -
> "/* RED-PEN how should LSM module know it's handling 32bit? */".
>
> This patch introduces a new hook, security_file_ioctl_compat, that is
> called from the compat ioctl syscall. All current LSMs have been changed
> to support this hook.
>
> Reviewing the three places where we are currently using
> security_file_ioctl, it appears that only SELinux needs a dedicated
> compat change; TOMOYO and SMACK appear to be functional without any
> change.
>
> Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> Signed-off-by: Alfred Piccioni <alpic@google.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/ioctl.c                    |  3 +--
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 17 +++++++++++++++++
>  security/selinux/hooks.c      | 28 ++++++++++++++++++++++++++++
>  security/smack/smack_lsm.c    |  1 +
>  security/tomoyo/tomoyo.c      |  1 +
>  7 files changed, 57 insertions(+), 2 deletions(-)

I made some minor style tweaks around line length and alignment, but
otherwise this looked good to me.  Thanks all!

While I agree this is definitely stable kernel material, given where
we are at in the current kernel cycle, and with the end-of-year
holidays in full swing, I'm going to merge this into lsm/dev and send
it up to Linus during the next merge window.  The stable tag will
remain intact, so it will end up trickling down into the stable
kernels, it will just take an extra week or so (which I think will be
good from a testing perspective).

--=20
paul-moore.com

