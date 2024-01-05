Return-Path: <linux-kernel+bounces-18373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FC0825C29
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7165F1C23822
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E577225D3;
	Fri,  5 Jan 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNgeOTuF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E822096
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33723ad790cso19093f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 13:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704490527; x=1705095327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF7MzogxYhcmQAGby29V5YEgq6eI9SROtb4tZUHpo0o=;
        b=kNgeOTuFX73eNwr4W0MnzNKrx6LaWNqisLOsyY2BjBxxV7CEJgwOyuU8Mr/sKqR0R/
         GW+NB1MvbOIjJHy/U6LHPrm6mhern4lNprbtm+e5lH5lcub/4kGflYksxriAtxWV3vHf
         y81Lzq9V1RQ8i7TBBwYdPBYhASSlOoOZOaLcILcOat4vJoiNkCgx1jt+4XmmCbi1dmVB
         iiMVjPp+vKdcUp3SmrbCi3jFtdrmWQs5gJM7hShRNkoocogKEBaI35VrdL/o38PIa4/0
         jlBSswoXhGKHMAY7VRf0UAXy/XCuXzsVy/2Lv0+bbyiDYiB+2AEqukyJHJKpCLtRO5Ov
         K/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704490527; x=1705095327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF7MzogxYhcmQAGby29V5YEgq6eI9SROtb4tZUHpo0o=;
        b=c5+XL7j5jW8VfcQUuQFGtvdnyuwLHiOxC7VQt2YVrP06tMTDLXl3NW2+e8EIK1iBNR
         P2dnOZDXxdnpOTHiLxE7FgDiWYAU3DDRt3soSR7S5RDblogjl4l5NnQ6OgwK0VfU2/Hm
         d4LlaRR15jY0SBvRBLKa2UIdCyc/z+0FvKjjXeq51LBJbvhtIdmXhhiBV4qsbDyrNH9V
         JYVkJ34C5Tto/2BAV1L4UYRkAPbI5+SuhLswmnFDxAZ8OcJE4EWmOOZtOlFiJBjbQQ1r
         7IphwCy0RABK0rOE+Kl5sAuGek0xq9zo0ORnkHqX9AKYs98x2PbOc2N9GoIaTI6OoOLr
         oZig==
X-Gm-Message-State: AOJu0Yw6MLbJvdP3gFVjyjSZDwo4Uj/9WvRmW89+byrrWTQ8j8t/aGP7
	+4Mp3N4A0+u2ziyJMedr/2cO/YYEmJRgRLT9NjKhnqIQvS6J4uv+LRpneQDBcA==
X-Google-Smtp-Source: AGHT+IF1McAC6Gh+doA/d9syP3gV+Z/zkDPakkTNtzWUyDLwzbVbw3QbaUP0mVBVmIE19S5s4k1XuJ8Tp6ssb1gqhFc=
X-Received: by 2002:adf:f3cf:0:b0:336:ded0:a21e with SMTP id
 g15-20020adff3cf000000b00336ded0a21emr18089wrp.21.1704490526589; Fri, 05 Jan
 2024 13:35:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105-newemail-v1-1-c4e0ba2c7c11@google.com>
In-Reply-To: <20240105-newemail-v1-1-c4e0ba2c7c11@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 5 Jan 2024 13:35:12 -0800
Message-ID: <CAKwvOdnbc0Z8poK400k8dhDNjNcpWC8LsbeOSdZ5XxLm=W6k6Q@mail.gmail.com>
Subject: Re: [PATCH] mailmap: Switch email for Tanzir Hasan
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>, Tanzir Hasan <tanzhasanwork@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 1:31=E2=80=AFPM Tanzir Hasan <tanzirh@google.com> wr=
ote:
>
> From: Tanzir Hasan <tanzhasanwork@gmail.com>

Hang on, ^ has a different From than the email From.  Did you change
the authorship to the new email addr?  I don't care which you use but:
1. they should match (author and from)
2. verify your new email with me (mentioned below)

>
> Access to the tanzirh@google.com email will be revoked upon the end of
> the internship.
>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 9a9069235f0d..109c0eca1da5 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -639,3 +639,4 @@ Wolfram Sang <wsa@kernel.org> <wsa@the-dreams.de>
>  Yakir Yang <kuankuan.y@gmail.com> <ykk@rock-chips.com>
>  Yusuke Goda <goda.yusuke@renesas.com>
>  Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.com>
> +Tanzir Hasan <tanzhasanwork@gmail.com> <tanzirh@google.com>

Thanks for your work on the kernel during your internship Tanzir! Mind
emailing me from your replacement email? I'll RB the patch once
verified.

>
> ---
> base-commit: ac865f00af293d081356bec56eea90815094a60e
> change-id: 20240105-newemail-ccd4a5db700d
>
> Best regards,
> --
> Tanzir Hasan <tanzirh@google.com>
>


--=20
Thanks,
~Nick Desaulniers

