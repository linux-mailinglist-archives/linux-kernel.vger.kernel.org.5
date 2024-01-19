Return-Path: <linux-kernel+bounces-30770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A41383242A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558E02852B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BA94A11;
	Fri, 19 Jan 2024 05:16:15 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462F4691;
	Fri, 19 Jan 2024 05:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705641375; cv=none; b=PxbGae0OaL9uy7UWAZAALQOeaNTFdW93pNoJg/O6BYAOaDursCmxAE+eVcDOEuSs0laGd0l8JoIN77ZyZrE4jejYQAm3u81W74c+Lel4dupvDjTOnSUlZw/pyOb3v0f7JykNF4CDZXgDnOLp7thn4ItCJd23QZ8q04KJOzePW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705641375; c=relaxed/simple;
	bh=ejefZ9g4beo5ULeSi9akJ+erm9iOsIbAyC+YgW+ABWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ereGNIUOzYfcB5RtBA6c90JrP0Y9s4SXaJUx99nKGNGaVUxcVJmSOcMBSa43tXhKl7LzOLoHbyTBbt78TpyxSqtuGdK6VW6SMz4MYWXcQHTlQfp9DTMLuXg8qxsX9aSiyd6JogzoslmSmG4VG7nUCQaMHMrsTChw6YZpuKts9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5986d902ae6so208518eaf.3;
        Thu, 18 Jan 2024 21:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705641373; x=1706246173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbdcNYh3PJs4LxluryfXeC8R/9613mcJgDoLdh3Fh40=;
        b=tvyvG27DvtoFW4WflAkr76OBCizeC7N7NYtZ9VARMU/6u61HdMvDHmm/ToIqXFCS5u
         j2Ar6I3rp0CKy/iOCge1S+qwguO0StNUxVXRQoE4PNkL8rOBzLw4n16h1cvLjraaHIL1
         OG20YKUVhxr2EUo9AUv4ieCnwypjfnhK8HRtKpMO2dLpvQKX6CFL7WoNip3q5Z4cC00A
         ic6rwPiK3LnvFzqu9D1wapmBUY2ivkv7GXZMcoQopX5kLUBj/c08T7AQcAA4+/H10diU
         zoZ+N2Xp5cJYxGacljVMjK9UurSEWGOKygtMLbld/hF5xadjJlSu7HgMbcef49s+Bfz3
         foIA==
X-Gm-Message-State: AOJu0YxpsqQ+K13zYQEglNBXWXgl2CBPq6A73v7i4P6MDrtSb3gc8/x8
	TCSelfYB3tFgapJWXFaMyyL9uHOmNOjQyp+4mBnopD/+1XAI3gS93KFgtj3g8C0HZkPLJgtqG/E
	tsZcXU2LrPoTlZZxflLXUJ7H/9Dk=
X-Google-Smtp-Source: AGHT+IH9pPDvMoYr3EpnW1lLxlB7xEeCm0t0CH2COx35Jodtyc/77y3xB0/VIGzvbDr3JTOjspQPG4UdsI9f5XoQmFo=
X-Received: by 2002:a05:6358:c61f:b0:172:f968:51f1 with SMTP id
 fd31-20020a056358c61f00b00172f96851f1mr1981562rwb.55.1705641372733; Thu, 18
 Jan 2024 21:16:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e0fc158239e73f22405c78d5b3219c266e3763be.1705506665.git.jan.kundrat@cesnet.cz>
In-Reply-To: <e0fc158239e73f22405c78d5b3219c266e3763be.1705506665.git.jan.kundrat@cesnet.cz>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 18 Jan 2024 21:16:01 -0800
Message-ID: <CAM9d7cikvOQvUXMrRPM9g6W34zHJsbNquhJYiV9AgS40eGC3qw@mail.gmail.com>
Subject: Re: [PATCH] perf build: don't hardcode pkg-config path
To: =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>
Cc: linux-perf-users@vger.kernel.org, 
	"Yann E. MORIN" <yann.morin.1998@free.fr>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jan 17, 2024 at 7:58=E2=80=AFAM Jan Kundr=C3=A1t <jan.kundrat@cesne=
t.cz> wrote:
>
> On Buildroot and when building for Arm using the Bootlin toolchain, the
> actual `pkg-config` is named just `pkg-config`, not
> `arm-linux-pkg-config`. This patch allows the external build system
> (such as Buildroot) to pass a working path.
>
> This is already done correctly in tools/build/feature/Makefile and
> tools/thermal/tmon/Makefile and also fixed in other places many years
> ago (9961aa665b70e47d6c80141c4a2482266010f246), but for some reason it
> was never fixed in this file.
>
> Signed-off-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
> To: linux-perf-users@vger.kernel.org
> Cc: Yann E. MORIN <yann.morin.1998@free.fr>
> Cc: linux-kernel@vger.kernel.org

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 86569f230e60..b69ab2ae77c6 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -188,7 +188,7 @@ HOSTLD  ?=3D ld
>  HOSTAR  ?=3D ar
>  CLANG   ?=3D clang
>
> -PKG_CONFIG =3D $(CROSS_COMPILE)pkg-config
> +PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
>
>  RM      =3D rm -f
>  LN      =3D ln -f
> --
> 2.43.0
>
>
>

