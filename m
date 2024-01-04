Return-Path: <linux-kernel+bounces-17222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C148249FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D1A1F22F1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B2C2C1BA;
	Thu,  4 Jan 2024 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbiBNzwJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B3225CC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eab4bf47aso855270e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 13:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704402363; x=1705007163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/veKMHUdNJ5SX/e4HlrsaFpg5vnXvc9Zdcy7jOW3gE=;
        b=RbiBNzwJ/JWk/Ik/5A12EZfkprQBllYqBvzH/yebrXDLBepiCNC9CkG3EqehqJmxZm
         p3efYq5/EkGJtNAmD2NbzQ5iXm0qN3Wkpw7n7iTHTcYU7PF809zrVx5eXg1OrHVbdse3
         HD7X1+p8q1hDePLO3Qn+8i0UZSnbKXgzhXTlZVyn5pPS5NgHihfZKcF33UxXmpp3HuI+
         G0IfsYLvQmRAoDFhnB3mai9XDKzesmctoBbQvHvnQA2lzVIKhqocp+giImZk3Q8s5iZX
         NxR7gyqtOcGN5ET1Vr8MDt1Bny8n+5645iXznORymASvz4aeFXiQ5nKXEqbaJ+Nydatq
         hPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704402363; x=1705007163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/veKMHUdNJ5SX/e4HlrsaFpg5vnXvc9Zdcy7jOW3gE=;
        b=UaqyJieI3WA6aFK6RYDzQo2iXT91omcqYyY427izlMWxEi7kz2infl7J5RaTTqZTzm
         9wS0D28sMHP3NnJrA5hKkKmnkLzY/ku/P7Y5yoeKmmg2xfkfHXUt4FMpNp6syK07oppA
         B+wXEJ/DpLpmdcjZ43eL39n29wltOLhivTb7f6n/xH90crUtxqGrALlKUYBv12qn8f80
         3cYOeMpcaVm2fTHDLL4sO9ctjtdFyA2LMEtKARoUZt8xSHNEcOlIUv7yKXb8dOFR3Hia
         sjLJQQuoHOIVnkEJ5D2TnHDYbJFysqrxeBai10MRy6aWZQ0VIvjhUyRvmCiWBi6yaOOY
         QHOg==
X-Gm-Message-State: AOJu0Yw6ra84qg7efvweVKK2t+s4tAf9ZnLFpZNs7kDfgSdFmYku8Egs
	pzKeiuc01XsafTUzGKL3upg+/u+WZ1JV5TGFAqs=
X-Google-Smtp-Source: AGHT+IGmditBjxbHlfhLEurFcCQuX7DE//CxVN1uI+y5wR1YnHpg/cnI2Ro+FI+M2ClOMEKW4sFwMMrogmX9GUc8bfc=
X-Received: by 2002:a19:2d5c:0:b0:50e:b219:44f with SMTP id
 t28-20020a192d5c000000b0050eb219044fmr82025lft.1.1704402362938; Thu, 04 Jan
 2024 13:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006122717.3984017-1-make_ruc2021@163.com>
In-Reply-To: <20231006122717.3984017-1-make_ruc2021@163.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 4 Jan 2024 22:05:50 +0100
Message-ID: <CAFLxGvytpwjXM0bdLrxt0itfEBPqJSmuM6otB7dTBmsTaAAPgw@mail.gmail.com>
Subject: Re: [PATCH] um: vector: fix return value check in vector_legacy_rx
To: Ma Ke <make_ruc2021@163.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	xiangyang3@huawei.com, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 6, 2023 at 2:28=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote:
>
> In vector_legacy_rx, to avoid an unexpected result returned by
> pskb_trim, we should check the return value of pskb_trim().
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  arch/um/drivers/vector_kern.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.=
c
> index 131b7cb29576..822a8c0cdcc1 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -890,7 +890,8 @@ static int vector_legacy_rx(struct vector_private *vp=
)
>                                         skb->ip_summed =3D CHECKSUM_UNNEC=
ESSARY;
>                                 }
>                         }
> -                       pskb_trim(skb, pkt_len - vp->rx_header_size);
> +                       if (pskb_trim(skb, pkt_len - vp->rx_header_size))
> +                               return 0;

I think this adds a memory leak. Also, can pskb_trim() really fail in
this scenario?
The function controls skb creation and knows all lengths.

