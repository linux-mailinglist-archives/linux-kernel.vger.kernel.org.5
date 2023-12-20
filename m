Return-Path: <linux-kernel+bounces-6482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC78819976
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D1D1C25860
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D237156E2;
	Wed, 20 Dec 2023 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbrdC7KB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8E2208D;
	Wed, 20 Dec 2023 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5e82f502a4cso7380157b3.0;
        Tue, 19 Dec 2023 23:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057172; x=1703661972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzYCqCFyrXN3Jx7OKv87DouNgO5Lu5lZTs1h6WtByWQ=;
        b=ZbrdC7KBiuEgKotAdrwJWbBrcqX9M/UO0TRNZretfuKJ8aOQpPLap3/OtzuJlIuZ7P
         9UNt3X5UqR/tuzT03vm92cjZM1dy6l+/mrUXxDliStIEgZ5LSs7COC/UkyuV2y/xRMyX
         xeeK2LuKyNiLJUQQAFMwpmmcCyOhFl/tsvZwonLL17ezrWGrVmIm4F5VBG6xjPDaTEg+
         PIJjwQSJgarbvqkdydckoTvu46uua/jbjQIKyC8Bt4xxiBtRXeapA0Vno6YB6GmmZcnF
         W4/VaQDa1Oc9I3xBkrUQ9Q6F19R3l6oK6tbDcdlAi7FMyTtXxL9uzUrkshuqEf4vaEG2
         hLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057172; x=1703661972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzYCqCFyrXN3Jx7OKv87DouNgO5Lu5lZTs1h6WtByWQ=;
        b=LNz6SQ7Y7qMblsoeVJ/K/RwLQmkIgOBee+PZ9RRPMYMBwVwjyJWLZSod+JzJHIO3aS
         2XxnYqNTME+KIkwPudzKUcZIFjIuugg9BjCnO7pbedR/1REhpYQPPz3jpLb+dZhFMkpd
         IqIbKIHiTjZdLccOXOMFSeQA3zHXRIlKQkHOgu4syKmMs9cb85D+q98qcMuT732OkonQ
         KXEjReptdzPplew8JNuRtcVrXirxVu4+ERwiWc+XN1cXqO3RtMBCkL8tzjAQDmufu2Cn
         FPB2K0qookXG/OCEcrIdDOZ3iIpqq3USnEJ2nIAPay1D3A6X8yoR/FnesK0Z8m/d+Ip8
         8Kgw==
X-Gm-Message-State: AOJu0YxEclf1RxmOACBso8Kn78+Jy4VwxrQw4G4Vu2tbptyfXfBVXB4H
	73PvI1LOZBhbI41GpwqTUmDEEkng+7RmfrbaOQy8p0ILHmY=
X-Google-Smtp-Source: AGHT+IEDFxtA+AcXoB2h28NfTj80mMvvNZc3QvUU6Z3rUjXvQZYaTxtpAqS2Js5oydyOJgJ5msWrRl54zHerX5T6trA=
X-Received: by 2002:a0d:d952:0:b0:5e7:5da7:a850 with SMTP id
 b79-20020a0dd952000000b005e75da7a850mr2211967ywe.37.1703057172306; Tue, 19
 Dec 2023 23:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220065931.2372-1-rdunlap@infradead.org>
In-Reply-To: <20231220065931.2372-1-rdunlap@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 20 Dec 2023 16:25:55 +0900
Message-ID: <CAKFNMonArSVESPSrCn5ovsggFQAeywg+JfHmBKx9MUGbSmfwTg@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: cpfile: fix some kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 3:59=E2=80=AFPM Randy Dunlap wrote:
>
> Correct the function parameter names for nilfs_cpfile_get_info():
>
> cpfile.c:564: warning: Function parameter or member 'cnop' not described =
in 'nilfs_cpfile_get_cpinfo'
> cpfile.c:564: warning: Function parameter or member 'mode' not described =
in 'nilfs_cpfile_get_cpinfo'
> cpfile.c:564: warning: Function parameter or member 'buf' not described i=
n 'nilfs_cpfile_get_cpinfo'
> cpfile.c:564: warning: Function parameter or member 'cisz' not described =
in 'nilfs_cpfile_get_cpinfo'
> cpfile.c:564: warning: Excess function parameter 'cno' description in 'ni=
lfs_cpfile_get_cpinfo'
> cpfile.c:564: warning: Excess function parameter 'ci' description in 'nil=
fs_cpfile_get_cpinfo'
>
> This still leaves a few kernel-doc warnings.
> Also, the function parameters should have descriptions after them.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: linux-nilfs@vger.kernel.org
> ---
>  fs/nilfs2/cpfile.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff -- a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
> --- a/fs/nilfs2/cpfile.c
> +++ b/fs/nilfs2/cpfile.c
> @@ -554,8 +554,10 @@ static ssize_t nilfs_cpfile_do_get_ssinf
>  /**
>   * nilfs_cpfile_get_cpinfo -
>   * @cpfile:
> - * @cno:
> - * @ci:
> + * @cnop:
> + * @mode:
> + * @buf:
> + * @cisz:
>   * @nci:
>   */
>

Ah, thank you for pointing it out.

I would like to fill in the missing descriptions and send it upstream.

Thanks,
Ryusuke Konishi

