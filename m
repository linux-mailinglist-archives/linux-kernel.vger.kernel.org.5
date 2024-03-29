Return-Path: <linux-kernel+bounces-124020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 399CC891148
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7705B221EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A581739AEC;
	Fri, 29 Mar 2024 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQMxnnXd"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0BF21115;
	Fri, 29 Mar 2024 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677594; cv=none; b=YmA6eI7zHcsLhjDqsSJqiI7cYAVaf3lwJcpAxjJJyVjawteBzy+xTvdR6AYqJnHMReT1p559w9LNvTyYyud3uxsAW/4YRhficpw6Owx1TEpHnu8xMLyUprYr/0aG+NyHu/mwa0en6+j6EwU2h8jJfwrlBsgq4617oB524F5Pr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677594; c=relaxed/simple;
	bh=zcEaf0OYkqRJ13FMmtURjzPtvhhTZX2HN/2HDcv5HqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZ6OBrtDSiEJm+x2FXE2EHUW7MJBWCxqQLUljT25/8tRVpjNZyqCR/T3lVoApOjyC0eCGacZGfr514Y7pY/3BLJahK5cy76ngJAmuVB1MBsOb2k79wTb3ykTBl2IaHG+uts0laxdzGwF1A4vNlldl9O1UCBNvLDoL/oIyAz/M4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQMxnnXd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ec7e38b84so1078965f8f.1;
        Thu, 28 Mar 2024 18:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711677591; x=1712282391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcEaf0OYkqRJ13FMmtURjzPtvhhTZX2HN/2HDcv5HqU=;
        b=WQMxnnXdAFXvFXDVTHxIBEJKUYcpsg3K3EKabPF6SOwikNgHn+6YcGmzoZDZLl3idF
         eK/CDPafp53ZbASzfhlO4NCeTf6D11b2dSuFBhHGd1SXpJguCnXi5LXAooJZBROlDj2n
         ejrxrMpJvf13uIsBq6VaX5cCCaVL75U2GVoL86s0vijAAoLIfGVft1RFqOCPCh3G2iJ4
         TKZbek0fzKNKQNwHJ7vrapHWjT9DzuUayiN/83saMa0/3o3mpYWk+NpGnNJ6grrmdKTH
         ZHmMaeSc2HA2XXRdRUC9OR5XFnxLa1mCelibR/pfiXamvRtL9eeQVkSDO909W1prLu5x
         DtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677591; x=1712282391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcEaf0OYkqRJ13FMmtURjzPtvhhTZX2HN/2HDcv5HqU=;
        b=VNM1Mvp44hLMtjvNA7d2BHWQ8/WGGUpE+Q+4jPx2c1YCUe3uvlbLgbaWggqfAl27gT
         46TQxj6sYHV80S85q09EWHPnn3ZiiBWJXIEHqfxzvCjZhq1nBCanrxkCeqJWvrO6cduh
         Amu0dDUZKuHRWHTlR0fIIGJ4DNsYu9WKgv752cXroXw8aU7Vq/bzpyS4c/ispIY3ywTd
         9pnTUvN8+xYgQyFJfZkGQgridRJKhmfsaC8XXeERLNxHSI6T9nfsdRaEcOq5p+cBjbnb
         cGO636cXriajk7Mq8dKdc9SWWSNqFKKFF6AuZ/qrGowY491tpPgN4P/PwzIPMW41ZWGp
         3wxA==
X-Forwarded-Encrypted: i=1; AJvYcCUmcjdqJBvkkHwIcd/7MYt39PWPIMrWrqpPZKUeHzammDiFaxsiti0rNS7vmtNwZJEkx/lDl8zgoNeGzRYHtPA3UlkZHD3snU4k6NQr0ucej8SZjHDrJzzVix0MW3bpwWNOtCfXEivP6eg/ixS+fB+Gl+4morqZnPpD
X-Gm-Message-State: AOJu0YweVRo2UmBslH0+swqN4quBiJfSgv3fvWcE7pDY8H22Hb1DlWMF
	Ft2yQsLGUAApZ5C2+1aMysFxMLQJOfVULOYluHWJs1t5t8uRYshSWwQjY3QUcL7B5CzRZ14SROl
	YpeMAFtVc0U+1y9dQ4kn3ELLDfbWIBd/D
X-Google-Smtp-Source: AGHT+IFOk1kmtrnbkGl3mAksWauulb5Av4q6f7hQ4Ig7SY8Cjy7EMAsdcDs73bfEGNr7UXZV1vVF72fmYynergxd3X8=
X-Received: by 2002:a05:6000:a88:b0:341:bff9:2e4f with SMTP id
 dh8-20020a0560000a8800b00341bff92e4fmr499776wrb.44.1711677590502; Thu, 28 Mar
 2024 18:59:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328110103.28734-1-ncopa@alpinelinux.org> <xr93zfuifhxv.fsf@gthelen-cloudtop.c.googlers.com>
In-Reply-To: <xr93zfuifhxv.fsf@gthelen-cloudtop.c.googlers.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 Mar 2024 18:59:38 -0700
Message-ID: <CAADnVQK+KRG47q8vuyXDVjBrE7oZWsb3XB5eLbJ95MSw3qhg1w@mail.gmail.com>
Subject: Re: [PATCH] tools/resolve_btfids: fix build with musl libc
To: Greg Thelen <gthelen@google.com>
Cc: Natanael Copa <ncopa@alpinelinux.org>, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Viktor Malik <vmalik@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-kernel@vger.kernel.org, Khazhy Kumykov <khazhy@chromium.org>, 
	Dmitrii Bundin <dmitrii.bundin.a@gmail.com>, Gaosheng Cui <cuigaosheng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 9:18=E2=80=AFAM Greg Thelen <gthelen@google.com> wr=
ote:
>
> Natanael Copa <ncopa@alpinelinux.org> wrote:
>
> > Include the header that defines u32.
>
> > Fixes: 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with
> > types from btf_ids.h")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218647
>
> Tested-by: Greg Thelen <gthelen@google.com>
>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
> > ---
> > This fixes build of 6.6.23 and 6.1.83 kernels for Alpine Linux, which
> > uses musl libc. I assume that GNU libc indirecly pulls in linux/types.h=
.

Ok. Applied to bpf tree and added the above explanation to commit log.

