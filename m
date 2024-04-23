Return-Path: <linux-kernel+bounces-155590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006068AF486
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B6D1C23CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7013D51C;
	Tue, 23 Apr 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="QPbiyC5c"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80113B78A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890706; cv=none; b=Mpfe0ykkL5R5uze7awZXRNPslNl396IOB9VcOnwGMekoz6Cx3/Pj0l8Sd2ENdICDftw0j2z1bj2TufxIH/zuZFC1u6n0u387H1MfwTo54vV51V1Q620wfhaJa+G6Ogm+fI2olZ2F3uV2KA71BGLzfg8Nao/bwdbzo+99Mcfo3Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890706; c=relaxed/simple;
	bh=i+NB4eOEdWNDg9BzHPTFWjZ8Vmz5Dk3Bt6ZggFv1VGk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=l2OqGVwslXJhM/GLOMgzwENFKV9vpr/nxD5KxkuZYXdhzvH0Iy9UgIB9LWU/eVYlpDYP8C3K6nnqWoN5DznMUyp8eyZXe/MNRQQdm8YJcJhBI+yB/jm877wTAXo2/z9yVH6Ql6JN6EHlWeRQeANyVM3jEyLpKYzNtnMl0lWb+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=QPbiyC5c; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so55664905ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1713890704; x=1714495504; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPjAjYNLyOr/W5Uow8fuoPqi9jTuVqit1qFTrYBLQC0=;
        b=QPbiyC5cz+b9R23nh3aSaXzciCOecrd8AwqECtmTO0Ia48IPwMSBLwCif4F5FMA/Ii
         3FnTWJ+HGG20V2u29YQ12u3IdFtk5k4iCuZ9siFp6G3ucvHemUvTJ/GeP2fX1aYS540P
         IFvpjUyl7JzecJ4o57D/Apluk1JXCFeCIDbPyEmODW90PJWizR5wZQf+PBZMkf5P9x0s
         AQD5fup82gjTbcq3V7opocsOHqChKOUp6Gh6qgIfmh43liTHks8p9VB3jRkdZhf+DloY
         kU6T6ml+e7xhZDjGRLpNk/T5m/U5jslQN2nqb1AzlGrsQeXCe0LKHCagSzF3l9YAjDXB
         q/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713890704; x=1714495504;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPjAjYNLyOr/W5Uow8fuoPqi9jTuVqit1qFTrYBLQC0=;
        b=ezk3iyiQkGndGR8p9NuGaN7LJ1odshXU83la2cRuir/8uI6i4VVqMMDTh2JCM0eq+I
         94MhJ8tErspPq8NOEbztPF0Xj/Cp6vUq2jTDoTiDuUS8th3ank5eU7f8bsZTyzhhr7FR
         93KkPPy2qcYzI1ymGFJUCKX4DNg4ZlOyySHE0Lwv5/sxAXSXFrmE28+/Pl4+E18KsFtZ
         PNNHpIuVeO/69NSwgbWD5x/EQzvL+4+N1ZFeTMlHNg/zFk4VYlsfD50bpx67EDdSiD6u
         dRArE+BMCC3iBwohcsWOa9lmrgSUZEwn4oBqmJvez3LrcoWNgY5fb1TVo9B9GnWfeV+s
         4Odw==
X-Gm-Message-State: AOJu0YxvPVWAgce40h6UdeF6a1EYNYfBRSfhE/WdkMiJLFmjU3TK22p7
	h2h9O8FF/5haqXgqTagPeHuQ6gocFUPAu40udt6x9qYZq3MOE0KIeu1jA5peFA==
X-Google-Smtp-Source: AGHT+IHnfLVV05vFXn7wb2ygCmRJcEa2gV2WCAU/7zFz67fopheRhLDhLyxMtjE32lIMnUHvzVyGRA==
X-Received: by 2002:a17:902:e843:b0:1e4:c75e:aae2 with SMTP id t3-20020a170902e84300b001e4c75eaae2mr19481727plg.59.1713890704016;
        Tue, 23 Apr 2024 09:45:04 -0700 (PDT)
Received: from smtpclient.apple ([76.14.15.177])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b001e49428f313sm10223458plt.261.2024.04.23.09.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:45:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/2] implement OA2_INHERIT_CRED flag for openat2()
Date: Tue, 23 Apr 2024 09:44:50 -0700
Message-Id: <4D2A1543-273F-417F-921B-E9F994FBF2E8@amacapital.net>
References: <20240423110148.13114-1-stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
In-Reply-To: <20240423110148.13114-1-stsp2@yandex.ru>
To: Stas Sergeev <stsp2@yandex.ru>
X-Mailer: iPhone Mail (21E236)


> On Apr 23, 2024, at 4:02=E2=80=AFAM, Stas Sergeev <stsp2@yandex.ru> wrote:=

>=20
> =EF=BB=BFThis patch-set implements the OA2_INHERIT_CRED flag for openat2()=
 syscall.
> It is needed to perform an open operation with the creds that were in
> effect when the dir_fd was opened. This allows the process to pre-open
> some dirs and switch eUID (and other UIDs/GIDs) to the less-privileged
> user, while still retaining the possibility to open/create files within
> the pre-opened directory set.

I like the concept, as it=E2=80=99s a sort of move toward a capability syste=
m. But I think that making a dirfd into this sort of capability would need t=
o be much more explicit. Right now, any program could do this entirely by ac=
cident, and applying OA2_INHERIT_CRED to an fd fished out of /proc seems haz=
ardous.

So perhaps if an open file description for a directory could have something l=
ike FMODE_CRED, and if OA2_INHERIT_CRED also blocked .., magic links, symlin=
ks to anywhere above the dirfd (or maybe all symlinks) and absolute path loo=
kups, then this would be okay.

Also, there are lots of ways that f_cred could be relevant: fsuid/fsgid, eff=
ective capabilities and security labels. And it gets more complex if this ev=
er gets extended to support connecting or sending to a socket or if someone o=
pens a device node.  Does CAP_SYS_ADMIN carry over?

>=20
> Changes in v2:
> - capture full struct cred instead of just fsuid/fsgid.
>  Suggested by Stefan Metzmacher <metze@samba.org>
>=20
> CC: Stefan Metzmacher <metze@samba.org>
> CC: Eric Biederman <ebiederm@xmission.com>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Christian Brauner <brauner@kernel.org>
> CC: Jan Kara <jack@suse.cz>
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Chuck Lever <chuck.lever@oracle.com>
> CC: Alexander Aring <alex.aring@gmail.com>
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-api@vger.kernel.org
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> Stas Sergeev (2):
>  fs: reorganize path_openat()
>  openat2: add OA2_INHERIT_CRED flag
>=20
> fs/internal.h                |  2 +-
> fs/namei.c                   | 52 +++++++++++++++++++++++++++++-------
> fs/open.c                    |  2 +-
> include/linux/fcntl.h        |  2 ++
> include/uapi/linux/openat2.h |  3 +++
> 5 files changed, 50 insertions(+), 11 deletions(-)
>=20
> --
> 2.44.0
>=20
>=20

