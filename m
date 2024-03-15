Return-Path: <linux-kernel+bounces-104638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A84FF87D159
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A70B22A72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EFF4AED0;
	Fri, 15 Mar 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNTHxGrQ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968CE36102;
	Fri, 15 Mar 2024 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521053; cv=none; b=Fd2mEiyOZY1eAdZ4J1VCRP7+C1j2yfEfGI9TmJM3it1razaOg2aOCCAnG4bDI25Kz6moBL7RW+mvNUczI9aykBucRBmcjmjtFQkRjEbkcVqEcqT86W5P6YINbl+flzRdBEy0CjKgLbh0uNJI8z/19R1KjZ4+PrSurMPhfG4JhP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521053; c=relaxed/simple;
	bh=uzYJp0p7W/KnhEZCybrOQ21iTY+W18Is4IY0juHOSkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1prlxNeOl1SaEMVfKy3QsajdKiGX/laZ5FZpGKDgybhIvV2QNRpB8ywI1b0XF/pqC9zj6eTCihFDqaXAd4iJojOmelaG1rxVbYcnQlLCXicCI9wrmT1quqbP3fNxmB/ku96GzJB0vTpwEQtCLvvig9MmE8TqMoXqFQYhmt6bUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNTHxGrQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6cb0f782bso1903500b3a.1;
        Fri, 15 Mar 2024 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710521051; x=1711125851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwJBRDQaCHTutZqaHKnSum7/I1i3qkduDrBcDoliYfc=;
        b=eNTHxGrQmEp1tIgOhZUA3ovkSZ/+aFbKld9qwqhtdSw8cEg053Q09WBiDc11LgyFLq
         /ufXfmLHFgGzPzpTNgXSSp/J98AAg1C3oBm9Nr5vmN/8ECURb0ngp2zvrBHrC49h/YBY
         sSeFkdFVDwIcpBqjCjVUKz1s3gjfOiPK6QXMCO9NQhvG0oR1P72f4kmoR2zSFdG2jILX
         sLXVtLIvTrnvq/0I1jQe0vVcWxKhjE6Xwexj70Ahu/G7SijarZLhMu6fnfdHVfeW8/oq
         dz1WjFLv5gge14gh/820B8UlkaWar2p6ILTtno7CmxQaS/wrShkpRlej5LoEez8x1ywk
         ayqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710521051; x=1711125851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwJBRDQaCHTutZqaHKnSum7/I1i3qkduDrBcDoliYfc=;
        b=WCo0GM/NETc9yWcGtLsDnjtEpi1TUAnbYSSs9kZ0+5yuYeoArp0VLmSFpBI5b6Uoie
         wtSGTkg67LMC1OjRd0hTOxCeT2oVAOajZVw6QBONumGLROEt7SKOaSJ18qbqrfhlO2TU
         hDx8jHSl60tyYFSDlETy1LS/J8FQZaNH76otoI/R6KO2CS5LISRY5ws7MQIwsvI+fZ3k
         BX4hl2yQTbahZKPe/IjIJ29EJoMlYpSKsy06Dy2lxqragFNt/0d+QtZVuUYstuFGWxiF
         27FfmHbLJ9RvKKOnDY3XChKSd1l2ck+hPDELyQkB9nzHu0qeQ7n9n1WMrCdnnkMuB9R0
         mI+A==
X-Forwarded-Encrypted: i=1; AJvYcCVsaD1ug+5xn49EDRhU3/byBne6dvabhZ9cfonqANTN27Z4wwqvFcZrKoq1a8kORo+PEIe4sWMdXps497LPh87SkWFGhdS58ZbvY1OnZh+v70mDgyq+IhGf73khIVtHmtyH
X-Gm-Message-State: AOJu0Yy/5d1KheylwLEHXkIbvrxIuRykkqbeeBF4dskZTjcl68d7kM98
	S4pl3479rHDbzQuPw813/giZm7Q94VXa1NLXFYMQb+AA3AXLiUw/8ROuO9RapjUlKcfCZ0OpwOr
	O4Ue5dxhw2Ug0mnXdcZPGss65c24=
X-Google-Smtp-Source: AGHT+IHedFw6/rnqxLl3EQNKEdSQVA1QinZCgy8Dszf5K4o1eAXbYCO4NwhZkS4xmW+SFL4MJ0voUf5oFtTMwlTffm4=
X-Received: by 2002:a05:6a00:a0c:b0:6e6:6a80:aced with SMTP id
 p12-20020a056a000a0c00b006e66a80acedmr6809034pfh.32.1710521050796; Fri, 15
 Mar 2024 09:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315113828.258005-1-cgzones@googlemail.com> <20240315113828.258005-9-cgzones@googlemail.com>
In-Reply-To: <20240315113828.258005-9-cgzones@googlemail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Mar 2024 09:43:58 -0700
Message-ID: <CAEf4Bza0cpQM4Vz-JVDanr6b+LmJPxehcvmxX1++WQwBji9-Pg@mail.gmail.com>
Subject: Re: [PATCH 09/10] bpf: use new capable_any functionality
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 4:39=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use the new added capable_any function in bpf_token_capable() and
> bpf_net_capable() implementations.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v5:
>    add patch
> ---
>  include/linux/bpf.h  | 2 +-
>  kernel/bpf/syscall.c | 2 +-
>  kernel/bpf/token.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>

It's actually a nice readability improvement, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4f20f62f9d63..bdadf3291bec 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2701,7 +2701,7 @@ static inline int bpf_obj_get_user(const char __use=
r *pathname, int flags)
>
>  static inline bool bpf_token_capable(const struct bpf_token *token, int =
cap)
>  {
> -       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS=
_ADMIN));
> +       return capable_any(cap, CAP_SYS_ADMIN);
>  }
>
>  static inline void bpf_token_inc(struct bpf_token *token)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ae2ff73bde7e..a10e6f77002c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1175,7 +1175,7 @@ static int map_check_btf(struct bpf_map *map, struc=
t bpf_token *token,
>
>  static bool bpf_net_capable(void)
>  {
> -       return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
> +       return capable_any(CAP_NET_ADMIN, CAP_SYS_ADMIN);
>  }
>
>  #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> index d6ccf8d00eab..53f491046a8d 100644
> --- a/kernel/bpf/token.c
> +++ b/kernel/bpf/token.c
> @@ -11,7 +11,7 @@
>
>  static bool bpf_ns_capable(struct user_namespace *ns, int cap)
>  {
> -       return ns_capable(ns, cap) || (cap !=3D CAP_SYS_ADMIN && ns_capab=
le(ns, CAP_SYS_ADMIN));
> +       return ns_capable_any(ns, cap, CAP_SYS_ADMIN);
>  }
>
>  bool bpf_token_capable(const struct bpf_token *token, int cap)
> --
> 2.43.0
>

