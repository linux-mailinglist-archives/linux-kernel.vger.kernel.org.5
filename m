Return-Path: <linux-kernel+bounces-110319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE99B885D22
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35BB1C215AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997F412C529;
	Thu, 21 Mar 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL4BCWK3"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5BE76052;
	Thu, 21 Mar 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037629; cv=none; b=NJu87nIjYaFbo1qWbZEhfO9wLQ3dmXnTmgUsm/3V3ZSNG32qs7vSj9t52u/KB3GxTrdRdkdddJep8d51NOn8q4xbXzL9Gvq33cX84cHs7rxo0RDPvQQQSiEC56G2WsUGhLS6Q7KmLUfEbepZYaC99dBdL8I2s89wkU8WnmFXqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037629; c=relaxed/simple;
	bh=qaWndn4RxrwHldNq1Aw523yyTmQ6HNnctipJ6kybmZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBB9xT2mVvDnfQ0vJ6Uy4PtnnmG7IdhGKX9bHWkkjpNkAX+66DXKAF52zLHgBJBXF2+IgjsZO+n+r0KLSfD8wj9gMv+Q0FMeGsKkh5lsgmcpq13sujuGFZh/1qMg3fisAs2TsI9QvS+WZD9xEMsvXfyQAQ1CQCANt1+r/4LwWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL4BCWK3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso568104b3a.2;
        Thu, 21 Mar 2024 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711037627; x=1711642427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CZMRCTzeJUSHAVCzPUbUrnO160LGVQctRdEtMVA/Kg=;
        b=bL4BCWK3bFBibyTbkkOTeGQ5o1VUwSDcaQwoplh0pM0B2hmNHqecs2X5Zm2j7MnzOZ
         QtpM00abvMTPd7FJ57zeIXHMugBJeUVyRqff4zMetEwS18+ycB38hy6xdSLzzM7ibOO4
         DmCy5vU/UksZe81CBL1+Mp5uPEu8U9wcl40dNlwaXD+gopyTlcypYgpH8oQPZDIhhEUJ
         LYasjUCct4j0zr57a+Okcz06JOumUQgAXxzh4Sc6FaPUFVj+WAGRPciIw51f3S8WlyS1
         WMaj/3mY18QosoaCetegPohgDUPEwDPF39pmQ5/8db31/n8dH6qRUXQA4IWsQ6m1AALo
         eJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037627; x=1711642427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CZMRCTzeJUSHAVCzPUbUrnO160LGVQctRdEtMVA/Kg=;
        b=Hv1s0xd+nGFxSr6MrcYCFjCEtxWsJI9vbATDLpgJpwJejq5d1MlHMLaX1fsvtcyzwZ
         6diapRucg35FoegLpd8K9XRny6TOH+XkRsNLX4mKJzdLVQlCbl2FvYYPTFn6Kx4hKt2x
         iF/YhmsDvdwvFosavP82Qj2au06J6dKE6OEkirlpni+lKFc6GbTjWVHR4JXAyVDxZHUK
         Fi4nLE7x4u/DlPDavTAyyF96kEu5Mxqntl+vK2nvwy1GxJQ49ytN9ing4ctPU29t7Xe4
         FG6ZWjNKcOnTrzgy+hqbWbXK3oZWXsskdcuQZr1PFXVsbHlWWlZy13Zkmf9C77qSG7Zu
         neWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ggHOGQ4vuWvFKxyqQmtbHaVMnJjIwj5Pz3REEsXMZVAPoiubvAD4BGmlQG1HlC6o7TK+QxtCp/1QcBBwn153TANXxrEV0V6boUS86YmHKwyrRXsGF+Z4rip0pd4LBb42whTSSL1/SJmibLeIlPBRhQx19hVE5/2QrbkAJXYA7pp3RA==
X-Gm-Message-State: AOJu0YxaQZkJiymS56T3aSICiybBZNcbVcB2Zzd4U8Xvwop1P1gmpoUF
	QYA8MnK2Ryj5ZKvEszcNUqgbfz5Gu86YOmq/N4LAutaGhThx8TZEqfsE8aisMJM++qlSkiEO2R7
	r7zCX0lvsdtw44cNL/18r8hd2lzE=
X-Google-Smtp-Source: AGHT+IGUS/sSqPwQgQO7KCyKe6qoGdepLQrwiQNGMRHxqPVy9fVN0LoIus0DdIvMA0gbC2cqm0EMn09Aqj3PGs5ekt4=
X-Received: by 2002:a17:90a:d241:b0:29f:eeae:e6bf with SMTP id
 o1-20020a17090ad24100b0029feeaee6bfmr6590769pjw.38.1711037626665; Thu, 21 Mar
 2024 09:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfxZ9nCyKvwmpKkE@x1>
In-Reply-To: <ZfxZ9nCyKvwmpKkE@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Mar 2024 09:13:35 -0700
Message-ID: <CAEf4Bzb+tctGAzSfNunJT259-toJ3nL7p0X4CemuUa=6iH82NQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] libbpf: Define MFD_CLOEXEC if not available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 9:02=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Since its going directly to the syscall to avoid not having
> memfd_create() available in some systems, do the same for its
> MFD_CLOEXEC flags, defining it if not available.
>
> This fixes the build in those systems, noticed while building perf on a
> set of build containers.
>
> Fixes: 9fa5e1a180aa639f ("libbpf: Call memfd_create() syscall directly")
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/lib/bpf/libbpf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index efab29b8935bd9f7..635a38c6f947a34d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1650,6 +1650,10 @@ static int sys_memfd_create(const char *name, unsi=
gned flags)
>         return syscall(__NR_memfd_create, name, flags);
>  }
>
> +#ifndef MFD_CLOEXEC
> +#define MFD_CLOEXEC 0x0001U
> +#endif
> +

makes sense, and lgtm. Do you need it in the bpf or bpf-next tree the
most? your patch header doesn't specify this


>  static int create_placeholder_fd(void)
>  {
>         int fd;
> --
> 2.44.0
>

