Return-Path: <linux-kernel+bounces-21677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B118292AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01DD1C25496
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B844C6B;
	Wed, 10 Jan 2024 03:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fle9INwo"
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5A23D5;
	Wed, 10 Jan 2024 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-dbdc7ff087fso2876794276.2;
        Tue, 09 Jan 2024 19:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704856115; x=1705460915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFF4djnEjNRjNb/Z2lhzWjzj1NHxohVp1JZl91La+1g=;
        b=fle9INwotfwTOsSaBtUyxkLmiV2ebl2+6PlZxiKohlwCBmwFC7L7PqKvvJoLRbb4+I
         sF0uXNvFAH/vOLVDi+spw0toppvLIpxDHPNF8lXMOkIJ3fobDn0wffBfJP45UYMjaE1B
         rGpOP/Ev33RiP49E6nDfcqSRyctMy1FmXfi7uxsORDWjl8Z9W2BlsWSKR76zSu6EfuJk
         OOBW5ebvE++lZ9d32msUKsCTktgj7IhJH+RyLBSRhIpDmuMKuNeZFi03+7RvyDP7A9pa
         ly79JZjpuVZBSeampL7vIPP+ndhN/ltGNi3DO1A6TYWeVQcUNRmYYHU7rESF2GGC7eJW
         Pd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704856115; x=1705460915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFF4djnEjNRjNb/Z2lhzWjzj1NHxohVp1JZl91La+1g=;
        b=EAzr4NMNAEfrtWKtFmwMqmPn7nYPKh9m6j1GQW5oS6vvp8d4YgXeDZ8ahFdb36eVnS
         gsjITWFt2tBmCUwvoU7Byj9Iln7P0pFhqguYe7jgNFLlebr2Wehf2teroEn8cGjiz9yu
         ZaXzjFKWvJt7faq44P+Yt9vfQ5V8vmHUC2UEh6+XhSmrudqlkNlkPseiKWbl8ejc2m9S
         WMQhC1WSy2BtiuZ4GCCRHnJaXFlmFVOmZUEIMXL/X8Ks3sdOA5hpfgSj28sHLkmayXfj
         dTQ0UAn8ZLA93eulmHu8C6xpCAgBiWC0+hNugmtfQTYZ9dbvqqQWTsOJgSjJhKdjwjdH
         mYtA==
X-Gm-Message-State: AOJu0Yx5XlHob6Iv/iLnuHdlStahvqVfu917mm2lfyxsS/cTf11wTy6u
	cx5Vkp9TSQ8Jk6bZxlcmBQc4zNsXmVTBKdkXIQ6DW5fxHiqp66wM
X-Google-Smtp-Source: AGHT+IGrzlkbOChlJ1fL+Av9xopiJJoeeo9wO6yazpGlFCCuK5Me2frpoYSokfDFh0bDQxSzqciQ7NNZAP3FJV+pTvs=
X-Received: by 2002:a5b:808:0:b0:dbd:b176:5796 with SMTP id
 x8-20020a5b0808000000b00dbdb1765796mr253001ybp.86.1704856114764; Tue, 09 Jan
 2024 19:08:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109031204.15552-1-menglong8.dong@gmail.com>
In-Reply-To: <20240109031204.15552-1-menglong8.dong@gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 10 Jan 2024 11:08:23 +0800
Message-ID: <CADxym3azdds6dRDdvofHj1cxZ1QxcN1S8EkrLtYtKy4opoPrFw@mail.gmail.com>
Subject: Re: [PATCH] net: tcp: accept old ack during closing
To: edumazet@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 11:12=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
com> wrote:
>
> For now, the packet with an old ack is not accepted if we are in
> FIN_WAIT1 state, which can cause retransmission. Taking the following
> case as an example:
>
>     Client                               Server
>       |                                    |
>   FIN_WAIT1(Send FIN, seq=3D10)          FIN_WAIT1(Send FIN, seq=3D20, ac=
k=3D10)
>       |                                    |
>       |                                Send ACK(seq=3D21, ack=3D11)
>    Recv ACK(seq=3D21, ack=3D11)
>       |
>    Recv FIN(seq=3D20, ack=3D10)
>
> In the case above, simultaneous close is happening, and the FIN and ACK
> packet that send from the server is out of order. Then, the FIN will be
> dropped by the client, as it has an old ack. Then, the server has to
> retransmit the FIN, which can cause delay if the server has set the
> SO_LINGER on the socket.
>
> Old ack is accepted in the ESTABLISHED and TIME_WAIT state, and I think
> it should be better to keep the same logic.
>
> In this commit, we accept old ack in FIN_WAIT1/FIN_WAIT2/CLOSING/LAST_ACK
> states. Maybe we should limit it to FIN_WAIT1 for now?
>
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index df7b13f0e5e0..b2b19421de8b 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6699,17 +6699,21 @@ int tcp_rcv_state_process(struct sock *sk, struct=
 sk_buff *skb)
>                 return 0;
>
>         /* step 5: check the ACK field */
> -       acceptable =3D tcp_ack(sk, skb, FLAG_SLOWPATH |
> -                                     FLAG_UPDATE_TS_RECENT |
> -                                     FLAG_NO_CHALLENGE_ACK) > 0;
> +       reason =3D tcp_ack(sk, skb, FLAG_SLOWPATH |
> +                                 FLAG_UPDATE_TS_RECENT |
> +                                 FLAG_NO_CHALLENGE_ACK);
>
> -       if (!acceptable) {
> +       if (reason <=3D 0) {
>                 if (sk->sk_state =3D=3D TCP_SYN_RECV)
>                         return 1;       /* send one RST */
> -               tcp_send_challenge_ack(sk);
> -               SKB_DR_SET(reason, TCP_OLD_ACK);
> -               goto discard;
> +               /* accept old ack during closing */
> +               if (reason < 0) {
> +                       tcp_send_challenge_ack(sk);
> +                       reason =3D -reason;
> +                       goto discard;
> +               }
>         }
> +       SKB_DR_SET(NOT_SPECIFIED);

Oops, It should be "SKB_DR_SET(reason, NOT_SPECIFIED);" here.
Sorry that I shouldn't be too confident to compile it.

>         switch (sk->sk_state) {
>         case TCP_SYN_RECV:
>                 tp->delivered++; /* SYN-ACK delivery isn't tracked in tcp=
_ack */
> --
> 2.39.2
>

