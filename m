Return-Path: <linux-kernel+bounces-72554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F45B85B51C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1082827A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD15C8E3;
	Tue, 20 Feb 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwhZ+sOm"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057575D485;
	Tue, 20 Feb 2024 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417639; cv=none; b=N7zOE0wDMvPTR4DN1pqSCdpIWc7DPXfUSS+9zESDCd7+DeW8hP53Cf1NlNNfsOA/bd1GieW/o4Dehj03vwLOVjHHYn0EO8wlErlE100QzNaZR8MvOR4IaFpUPfXJsZ2Qmd3SfK21z5lTp/gc9FawnRfgOzMm6MBNgsCpB3oE8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417639; c=relaxed/simple;
	bh=xGkHwHgsNKCUyaW3yxpI0yGm3mNFmMcYeiiqH8O+1eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li39PjG/NCc2qTI3DlE18qApv95gN6gZlLkfQcO5/p+nJRVWLJaEtSSubsayed3AvU8GGWbEY87UGNcb1WtHNrCjlSNTupKKuin1ZzV8Q/bB9e+OhYDjqS0D8AZYGxC+57Pk/qQGfqdvxw0FUPuVLv2SbxkgXG0bd07Jg6hZD0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwhZ+sOm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso3705730a12.0;
        Tue, 20 Feb 2024 00:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708417637; x=1709022437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h3mNF6ymvZU2rJqeUcClsvb+93q2IKPLnONC3Oy06ug=;
        b=lwhZ+sOmXiY9sfYcJEOgESgb7e4R0JYXBO1quTnOp1FaBuCNhOGDzrMbYgpYcxBezy
         gRmhXC9ZsASdHJJZxBey9YZxHvGN4RN2O2DACz7UKn/sImT+CxOE1qWDZI6eiTxVPxz8
         fH1kVsFOTjfpWvjr6wgnflhk4UUdJJZFP6z9ls7YgYr2MRCOTgzY7lCda0+bUL7O2d9f
         RD936q+wQVPVSVAZO1saXfPo1mqYuj6ybOFZZxC1lzjJ4gX4aXfr7G33F83nB+kvq66Q
         VQ2LnVFYpRnlv/OcAUXV+lu+3kfUrcoSYHGI7Wkp+vTS1JxiGTQ04uYYuhAV4KQ+6gvk
         HJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708417637; x=1709022437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3mNF6ymvZU2rJqeUcClsvb+93q2IKPLnONC3Oy06ug=;
        b=WEKEgpLMEieW/DKkPMFUNcn52LqOHnaB5HgfPVd6Gz934VLR+kUFOvFPRrHneiILut
         i14HsXJFQ+aY3peyd3FESYK5o3F/JY99TQ8ZbXzIXzyPOwVBt6SQH4AJBP50mOBxGTP9
         oqPmlO+Qc1x0XaJtbRoNCuuXoJBaO3Ye/nXo8pA1xBh5ND9IXeIH5I7vIeP+DmEGPZBw
         luXwC68HzcD9STek0SJ3KyNjb4GTHQEjHgEe5P20SXPP/8mScZRJioSjSNfEHV8C3FiV
         ul714MNcoIsMNufS7ahZwFdbWQWu/eVaSkhmJfiyKmGHyzHANwK/GgV7JblKW+7eN2Hl
         Fp0w==
X-Forwarded-Encrypted: i=1; AJvYcCWTfrS52+9MtWKPagTIVXu7sp4/bb4eRCNKAHuZzcZDKuKl64lLs7qMEghAyNxyOaByJmH/hXkGZ++TrSFAYpU5btWNvDVhD/1VabY8IVaciTPn3ytu4/YOhoHVLDWpikILsMkqEOTVTQRkd/Us4qnZrcn456TNnEjYyBilc1PK
X-Gm-Message-State: AOJu0Yyb+ldMS65d5L58jn4kCfRhOqhbPH2Y+IHT34fEYZHSXOmM30Gx
	n9Dx3/7n1oYy07E5S298ssvPnWVVqkc4cucoJglQxOCw5eECZJBExh8iEHKDYYysaWgFS1R/DEh
	H06ZdTwXSuTViEtNiHmUwWAljdj8=
X-Google-Smtp-Source: AGHT+IHEBObqHGdbcKe/0UUtdFdBYryuEqZdpxlQpp8rPZQgtgbdMaGQqBxDALoz+PiSbK1FlD2LuL7d66Nado/BRDA=
X-Received: by 2002:a17:90a:de13:b0:299:4392:33e2 with SMTP id
 m19-20020a17090ade1300b00299439233e2mr6802188pjv.39.1708417636648; Tue, 20
 Feb 2024 00:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220-raw-setsockopt-v1-1-7d34cb1377fc@pengutronix.de>
In-Reply-To: <20240220-raw-setsockopt-v1-1-7d34cb1377fc@pengutronix.de>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Tue, 20 Feb 2024 17:27:05 +0900
Message-ID: <CAMZ6RqKPUUrgfVpdu4y=mGUFjNTbfH7q46ZwcMwOn6zEwfHnZg@mail.gmail.com>
Subject: Re: [PATCH] can: raw: raw_getsockopt(): reduce scope of err
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue. 20 Feb. 2024 at 17:16, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Reduce the scope of the variable "err" to the individual cases. This
> is to avoid the mistake of setting "err" in the mistaken belief that
> it will be evaluated later.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

One nitpick to remove a newline, but aside from that:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

(as usual, I do not mind if the nitpick gets resolved while applying).

> ---
>  net/can/raw.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 897ffc17d850..2bb3eab98af0 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -756,7 +756,6 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>         struct raw_sock *ro = raw_sk(sk);
>         int len;
>         void *val;
> -       int err = 0;
>
>         if (level != SOL_CAN_RAW)
>                 return -EINVAL;
> @@ -766,7 +765,9 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>                 return -EINVAL;
>
>         switch (optname) {
> -       case CAN_RAW_FILTER:
> +       case CAN_RAW_FILTER: {

Aesthetically speaking, I do not like turning the cases into compound
statement, but this removes a pitfall, so let go for it!

> +               int err = 0;
> +
>                 lock_sock(sk);
>                 if (ro->count > 0) {
>                         int fsize = ro->count * sizeof(struct can_filter);
> @@ -791,7 +792,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>                 if (!err)
>                         err = put_user(len, optlen);
>                 return err;
> -
> +       }
>         case CAN_RAW_ERR_FILTER:
>                 if (len > sizeof(can_err_mask_t))
>                         len = sizeof(can_err_mask_t);
> @@ -822,7 +823,9 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>                 val = &ro->xl_frames;
>                 break;
>
> -       case CAN_RAW_XL_VCID_OPTS:
> +       case CAN_RAW_XL_VCID_OPTS: {
> +               int err = 0;
> +
>                 /* user space buffer to small for VCID opts? */
>                 if (len < sizeof(ro->raw_vcid_opts)) {
>                         /* return -ERANGE and needed space in optlen */
> @@ -839,6 +842,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>                         err = put_user(len, optlen);
>                 return err;
>
> +       }

Nitpick: to be aligned with the above, also remove the newline here
(same as above):

-
+       }

>         case CAN_RAW_JOIN_FILTERS:
>                 if (len > sizeof(int))
>                         len = sizeof(int);

