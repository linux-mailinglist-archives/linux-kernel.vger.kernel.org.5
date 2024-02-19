Return-Path: <linux-kernel+bounces-70636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11035859A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6111C209DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 01:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4189E1865;
	Mon, 19 Feb 2024 01:17:15 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2302163
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708305434; cv=none; b=ZfZvp38wym4p5HZiowRwAK4DkOvdUSuuJRKXv+XknB84y0i9v4epAIo3x49VUPUSKyf+rzUPOaDAI7B/emvKl1NHl8NFOe9dXbJM6I3s8/eWTd9L5M+DlQq3m+Lvgg12o9ixUxGYKaKDmeyyXfik8E+5Ns2pcj2pCJ87BDnyg88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708305434; c=relaxed/simple;
	bh=aadPJat/aV0qssEXBjSbmTEWDUUCnlGLgWiZ9Emr+LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=WsFIAptOP3DMtkjDyJMyBz3J/IPgjIPl64bXNeXMtb2pkXInDDuwwkl7U2vW54SInZPNSs/FXvprMLCVZtyF2PCw5frf66LqjTHUiCI50EpVqqhuE25ial6QOgVPp32bAiWuHdGQmcsdZ8JeFzyXh1I3P6DmdFds6iWN1e7Ce0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512ab55fde6so1172783e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708305431; x=1708910231;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnDIzKAAHqUE99uGMy3LM2/SDBhUgCs7WwrNAcRvmtM=;
        b=MoYN9P5yMiW9YiDQTH4OSJR4rj7goCG02O77BCejFaKnr0uVOmQculwFrMNtkxB+oP
         FOa0mqtf4BBGhLL8I1kk9X38Hmn99/4KnSTVoCkevZDjuzMa02o+DpCmYmxybc94Tlce
         KlF+SOzFhHVd6ksCKW0zhTOx5I958F6kDzdy60W7YvQbEg0nqoAh102/LAzWVbrJzRtq
         7MSIdyRNmiYDv4ZYfLZCG37YSN/SOeLUqfPIWxK8ijQVQmCIgeyuaNBW26gQl8tQBL46
         DDf2O23ClBOhY2cwWnylgpwQO45HzoWk3CnxanxOGgcLFkxn+11jtc5eJYB88uNBXyLT
         YEUg==
X-Forwarded-Encrypted: i=1; AJvYcCUjpMYN4Mghxp7C7L1WU/9shNSTXbIG1fSW+PAxUIrUROw/s3E/BfK50mIQ0OwKrwu3x3dxbLUofkuV1RQHRDnqnwjcFWIRZOGLDHW4
X-Gm-Message-State: AOJu0YzE66J6VXmwllaYs90MC6toVxnaEcBjW8gyWzpHhbmkTND9nXwl
	jOJkOIwdtiIrGWweCir2gGK3jVIYHgbeNDfIDcveEdEz+cFYyJSfqzlFnNiHyPn21w==
X-Google-Smtp-Source: AGHT+IHOqjqLGC+mjn9MfSV1yNeKcqKZySM75GdvTDmJkoSBGazeBIHvviH4orNReemonFvCb3Is2w==
X-Received: by 2002:ac2:5382:0:b0:512:acc8:7c40 with SMTP id g2-20020ac25382000000b00512acc87c40mr1430281lfh.57.1708305430821;
        Sun, 18 Feb 2024 17:17:10 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t3-20020a19ad03000000b00512add30279sm377579lfc.157.2024.02.18.17.17.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 17:17:10 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51299e0cb8fso2777159e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:17:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnIxjAxymJxoU5mubYFiXR0gwRSZVQDAUzQJ4cMeUG6k/0dtKOopwwCY6l3XW0H42Q/cm2U6oGQAo/TZQMMSRWlChWI/hkx35ckjk8
X-Received: by 2002:a05:6512:2820:b0:512:88d9:93e4 with SMTP id
 cf32-20020a056512282000b0051288d993e4mt6920154lfb.15.1708305430452; Sun, 18
 Feb 2024 17:17:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209070443.3617790-1-iam@sung-woo.kim>
In-Reply-To: <20240209070443.3617790-1-iam@sung-woo.kim>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Sun, 18 Feb 2024 20:16:42 -0500
X-Gmail-Original-Message-ID: <CAJNyHpJo4D+JxCJRB30eMisux_thO1eJHf0SDsRFQMubdQSkVg@mail.gmail.com>
Message-ID: <CAJNyHpJo4D+JxCJRB30eMisux_thO1eJHf0SDsRFQMubdQSkVg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: add missing checks in state transitions
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, could I ask for comments on this?

On Fri, Feb 9, 2024 at 2:06=E2=80=AFAM Sungwoo Kim <iam@sung-woo.kim> wrote=
:
>
> When an l2cap channel receives L2CAP_CONN_RSP, it revives from BT_DISCONN
> to BT_CONFIG or BT_CONNECTED.
> It is very weird, violates the specification, and I cannot see any real
> usecase for this.
> Similar to this, the L2cap channel has six illegal state transitions:
>
> 1. BT_CONNECT2 -> BT_CONFIG by L2CAP_CONN_RSP
> 2. BT_CONNECT2 -> BT_CONNECTED by L2CAP_CONF_RSP
> 3. BT_CONNECT2 -> BT_DISCONN by L2CAP_CONF_RSP
> 4. BT_CONNECTED -> BT_CONFIG by L2CAP_CONN_RSP
> 5. BT_DISCONN -> BT_CONFIG by L2CAP_CONN_RSP
> 6. BT_DISCONN -> BT_CONNECTED by L2CAP_CONN_RSP
>
> This patch fixes 2, 3, 5, and 6 by adding checks.
> For 1 and 4, I will make an RFC for as it requires some refactoring.
>
> The detaild logs are described in here:
> https://lore.kernel.org/lkml/CAJNyHpKpDdps4=3DQHZ77zu4jfY-NNBcGUrw6UwjuBK=
fpuSuE__g@mail.gmail.com/
>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
>  net/bluetooth/l2cap_core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 60298975d..c5fa2b683 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4339,6 +4339,14 @@ static int l2cap_connect_create_rsp(struct l2cap_c=
onn *conn,
>
>         l2cap_chan_lock(chan);
>
> +       switch (chan->state) {
> +       case BT_CLOSED:
> +       case BT_DISCONN:
> +               l2cap_chan_unlock(chan);
> +               l2cap_chan_put(chan);
> +               goto unlock;
> +       }
> +
>         switch (result) {
>         case L2CAP_CR_SUCCESS:
>                 if (__l2cap_get_chan_by_dcid(conn, dcid)) {
> @@ -4552,6 +4560,14 @@ static inline int l2cap_config_rsp(struct l2cap_co=
nn *conn,
>         if (!chan)
>                 return 0;
>
> +       switch (chan->state) {
> +       case BT_CLOSED:
> +       case BT_CONNECT:
> +       case BT_CONNECT2:
> +       case BT_DISCONN:
> +               goto done;
> +       }
> +
>         switch (result) {
>         case L2CAP_CONF_SUCCESS:
>                 l2cap_conf_rfc_get(chan, rsp->data, len);
> --
> 2.25.1
>

