Return-Path: <linux-kernel+bounces-137063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0689DBD9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AADF1F2442E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B7112FB16;
	Tue,  9 Apr 2024 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBuRzoDW"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5A12F5A0;
	Tue,  9 Apr 2024 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671926; cv=none; b=mN/nbAPjQPckq5qeKxkOS8i4wxaar6mmSC6l6Zv+R/wyVBMq/ANK8wnhml5oFQXJxPQtl7QvpvLFtnVek5XJnH7PgYMUl9DN5bW2QjWYCKRzDvCYiaEj0bOgf+nN8sOwiAom49dfrSPEbxx7qtsF01+L/0jmxt0cv0MTQTMupmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671926; c=relaxed/simple;
	bh=Pb3U8o0znOa+FZrFMgY8KaP+XUwl/EDu8Wcwfm7QUUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtZLSueHVd5UqTYXBW4A75YnnFFAtBbnR+jmfk0fvp6U1x33JJcvGHI1shFC+BnlzN/XDuJNlVtGvjtSRedSIv98fEY6250am/AqEvAd3hzddVGDZLNRuHAfWF/5WvIrA2aqlheeTjzyo/73yLCkDHIqgCssOeqpC7/MJ0UYVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBuRzoDW; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso12861491fa.1;
        Tue, 09 Apr 2024 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712671923; x=1713276723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yq7Ve/MoVtY976kXQjQT0Gp8ZXknYj2h3YGm3jklcHo=;
        b=LBuRzoDWuSO277Om9dbcVaTEPdeuJoUlgB4e7qKErAO0vWtCvEQmM/sowiY0saXUMo
         GVyrRKSBE06/Yd0b03rVmKrtpqm5QhsO8hYz91ix631/nfW+usRz3H6qiyFq+ixhcnJz
         iyFb+D8px5TRzRuJcl4KxS2rb5ZMjS/08oUHgaFvhWhyKLEFliUm9QlEmMxufgGqnHkq
         7rpbMJVlRFgubjSOQF8CD2cGvBm8Y+mCwvzPcQYTS6IUDTd9He3Z6Jhg4QwejQyUHJpu
         ZFDlrCtFwUodPLPBrvi71VL0zwNkRP2E1HTEJWCnD9sWnUgGF4cKYFRbiWiS9H7POsjm
         HHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712671923; x=1713276723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yq7Ve/MoVtY976kXQjQT0Gp8ZXknYj2h3YGm3jklcHo=;
        b=fKc0kuDoEtG/NHXlxoUb9QiQQCU9Z5ViyMK/5GxqSnIIo9p2/RTJhw8SuXcFhBzNDz
         iY6yP17yjmOJYiBaJIbGPmTlEjGVd5g6KbnSlh/OPm17R/F1FX4csLbYh/ubLcKdR5o5
         PGg7czQII8Nr+t9rYe6spMMzYyVaiMajtMBDysDrBPhCTpBZPNAglQ4wGmLgGIhm6AGX
         LEXh7N2a2hstSg7gpM27m+tt0R37l7pHx5cFpLXXoUfc7PuitwMsD8rE9DQfIMX4t3z0
         pIZMCTo+pHbYdglxiqonT1wBEvV0VjltRc17TOIrWQ7oFbBGYR2iWhCrPMoS/esRwzXb
         1sBg==
X-Forwarded-Encrypted: i=1; AJvYcCVeN2pod8QLBs7mqvk8BrndHyYsO1OymGRbKgAn3+xzdTf7Lh+dsCBsq8/Fs3NHbhia0eZMKC5uvIO/9I5sUm5fJKHGZJzfWJm+MjVoKxvSB69uMSycSYFUPsoZm9tY1EprqMYjs/yuelVDZDdyfhxNPrIkLEvlO0cCnIZYYDSac/hJtjX+
X-Gm-Message-State: AOJu0YzPxtpfoPF03aW7e0Kf6vLiqSz734VnpmKMOaXUtLlrJfseVnln
	ZqadjUYic09RVsc2ZIEM7I8p/LpS7fOpWvBdgkisc5uYgN1VKCCqAUo1pBe+1Y5t8P4hrwRqAMX
	5wL+pLsBxVxSuDLsvVy+mR4fs9Ao=
X-Google-Smtp-Source: AGHT+IEbW1mmDB2SJKlZlyubQTwI+ixEezwvqOpNrsOBopPAXAxjksYWvJ7cuiCIlWgNkVvgZu+Z+14EdCJbAfxHdOY=
X-Received: by 2002:a2e:9602:0:b0:2d8:1267:3202 with SMTP id
 v2-20020a2e9602000000b002d812673202mr7627397ljh.10.1712671922638; Tue, 09 Apr
 2024 07:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7cf0848b-f44c-42ad-848a-369a249bff77@gmail.com> <tencent_FE3C6F369E968237444B7E74BD7625670A09@qq.com>
In-Reply-To: <tencent_FE3C6F369E968237444B7E74BD7625670A09@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Apr 2024 10:11:50 -0400
Message-ID: <CABBYNZ+4x2XxgL2eGYU0dd1+83quVajEk-bAqt3FG7wPx+=nFg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix oob in rfcomm_sock_setsockopt
To: Edward Adam Davis <eadavis@qq.com>
Cc: eric.dumazet@gmail.com, edumazet@google.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marcel@holtmann.org, netdev@vger.kernel.org, pmenzel@molgen.mpg.de, 
	syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,

On Tue, Apr 9, 2024 at 9:36=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> If optlen < sizeof(u32) it will trigger oob, so take the min of them.
>
> Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/bluetooth/rfcomm/sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index b54e8a530f55..42c55c756b51 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -629,7 +629,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *=
sock, int optname,
>
>         switch (optname) {
>         case RFCOMM_LM:
> -               if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
> +               if (copy_from_sockptr(&opt, optval, min_t(int, sizeof(u32=
), optlen))) {
>                         err =3D -EFAULT;
>                         break;
>                 }
> --
> 2.43.0

This has been dealt with already:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Dee77912bc0bbd78fceb785a81cc9108fa954982f


--=20
Luiz Augusto von Dentz

