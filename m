Return-Path: <linux-kernel+bounces-26084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37F382DB42
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5CF1F22651
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7846C1759F;
	Mon, 15 Jan 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="0Do1yxTR"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806917590
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a27eddc1c27so456015166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 06:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705328789; x=1705933589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ozom/lCh7bTZ+/UKfLuCBm+OREt52FaBrJgWzLh8wC8=;
        b=0Do1yxTRwgC7h280pJ8zhLj/yfD/6WH13dQWYRj2ztXHCfl0K2c7xAzZvEoJ6DoVqv
         mw6QNl8KldnuTDm1bTankOz7PZSmz9nW7Xb4Nvd1xSb8WKWW+M4JZR1xKTICA++qaKmb
         Qs8hFLuAnwnSinSay6UDX6ktpZhU/VUyToi6gZsM1XsUrWAbiM9Lrqua7HgmdqDAXF+i
         LaBWsQ/SJqMFtd0gSlX/8SQx7WrgWiJhx0uSzcoMefcd98yDhH5/yRHZvmtPHrVVYS3L
         DQlX85B9BJzJj18vXOYMUVzaKjEKb5PzLD8gJKaYGMmG78jIeUUPhXwhcnF8Mj4z4rI0
         xvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705328789; x=1705933589;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ozom/lCh7bTZ+/UKfLuCBm+OREt52FaBrJgWzLh8wC8=;
        b=XpCeD27U/EMF/AZTjhwcOR2AS+0ivJA3Ig/tQ3WFVD2RDeSqdjEp7S7hIh75pIVefG
         z+Fdzcc5PyoIHGviMFhIWzQ7mvUFIOksCrCnT2WwpVyBXenLt4DNQnQ+FgTvii8LC4BF
         nCnd+7ETGHETUkfTLBkn4PME9q3qfwpHBdCSzH8olLB4hv4nPIW5R246O4hm5kzctlMP
         GSyj3NV+wtHX34wlR2la3ot4IQWL8orvsJqZwLqaH7F1O3mLJbaOIkb7X6UiYRn6s+ML
         WopmpV1ocsSI3hpghe3tkvvOTo0EEe13SHRAaLWjlRJsekWX9jISPhmf8AJUDpO77xEa
         8otw==
X-Gm-Message-State: AOJu0YzQsPHrE6QsLfFehk4hnTKO1kjQWEVLBqvlDzKw6WcG5jhejJjn
	OA/Eb4Xl6fcSkJApJ6QXPPdP0dI2RrUSR1ywHw==
X-Google-Smtp-Source: AGHT+IFPE1nx6Rr58qzIM5ZCiUHok3Ak5Gi1PZAX+14/hxuK9boaY1dYPKdC8HnlSs8HFgwRD9CSdDRExPU=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3a10:62fd:72bf:27db])
 (user=gnoack job=sendgmr) by 2002:a17:906:39cf:b0:a23:5780:6300 with SMTP id
 i15-20020a17090639cf00b00a2357806300mr19031eje.10.1705328789306; Mon, 15 Jan
 2024 06:26:29 -0800 (PST)
Date: Mon, 15 Jan 2024 15:26:21 +0100
In-Reply-To: <20240112074059.29673-1-hu.yadi@h3c.com>
Message-Id: <ZaVAjQmio26WloSk@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240112074059.29673-1-hu.yadi@h3c.com>
Subject: Re: [PATCH] selftests/filesystems:fix build error in overlayfs
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, mic@digikod.net, amir73il@gmail.com, 
	brauner@kernel.org, avagin@google.com, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 514118380@qq.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Fri, Jan 12, 2024 at 03:40:59PM +0800, Hu Yadi wrote:
> One build issue comes up due to both mount.h included dev_in_maps.c
>=20
> In file included from dev_in_maps.c:10:
> /usr/include/sys/mount.h:35:3: error: expected identifier before numeric =
constant
>    35 |   MS_RDONLY =3D 1,  /* Mount read-only.  */
>       |   ^~~~~~~~~
> In file included from dev_in_maps.c:13:
>=20
> Remove one of them to solve conflict, another error comes up:
>=20
> dev_in_maps.c:170:6: error: implicit declaration of function =E2=80=98mou=
nt=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>   170 |  if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) =3D=3D -1) {
>       |      ^~~~~
> cc1: all warnings being treated as errors
>=20
> and then , add sys_mount definition to solve it
> After both above, dev_in_maps.c can be built correctly on my mache(gcc 10=
2,glibc-2.32,kernel-5.10)

This is apparently the same error as in
https://lore.kernel.org/all/11cdac1e-e96c-405f-63e8-35b0e2926337@arm.com/

I'm getting the impression that we are fixing the issue at the wrong layer =
here?
After all, the mount() syscall is supposed to be used with <sys/mount.h>
according to the mount(2) man page?  It feels a bit like cheating to resort=
 to
sys_mount() instead...?

Do you have any deeper thoughts on what could be the underlying issue here?
With my newer GCC toolchains, I have been unable to reproduce this.

Thanks,
=E2=80=94G=C3=BCnther


