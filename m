Return-Path: <linux-kernel+bounces-38790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DFE83C606
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76567B252CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48C66EB60;
	Thu, 25 Jan 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSjrt/Hn"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D24605C8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194946; cv=none; b=aG7BAF4z6fgo3lEyww2kfOu/fZZtmg2cyr6qsSvo4hfM8+M+S9j7YBtPISd3uSS3Fp71dyfznhDpGnn0ISx6LQTjgYEsIvoNN3wp6xdlcO5OPbx1WT8OaH4U3Lxlh5O3mvRu3iCioaC7il1sz8hyxwBdCYw9s5ILpqQolwjHjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194946; c=relaxed/simple;
	bh=cAHbuBrAmhIHJA/sqaHUG4MiTnpiJIAwjM4exYUKT84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCjuVGkzlXLY0ZIZziDzW77h+sqHC5rWgM89JQcLZTuGFSY8ZtGpX9rlA8QG5Wr8o4TvRLlxyWuO9zN7363m9SdoLqpvkpKkJoCkWVKYbbJPlJ6rwdHk2bSAHlOGqwHK1BMCgQIoxcyaQEgrkNAozemrfE5JCzMD3e6T+jIUvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eSjrt/Hn; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-214410e969cso415731fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194942; x=1706799742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTHYIZzUxtAT+UZGnWW/PMLr3D1IxYvIdKjSA4oFUS4=;
        b=eSjrt/HnV378FQfVZlwXIZaEUQ0PnKtvh4N/BIlI2BwU84iugMl+R2nIcbaQpGgIWp
         kQFolbj8FzXh5LzszULCogrd4JLcPLB+tCrb02hzdjCXE9aFRlYEXuluSEO31eb2Pk68
         sLX2f5zskwT1Mw0C2JbdNiqKQOjB/rG4mOzihAVUnDcTDGyY65ywzxp0dnZ1REcI0+iG
         VTmw6UiN/PX/dnIaB2Xb7AFZW8x4OGoYxZdGNPg3PAqWkBOliHfjiV+rg6SIo3eSivnM
         q4GIjpXmaCCFLloKSZBrO0WISMLc89ZAw2kXT2PcMNFgPBuxG5CS3Fi4804OgqT9S9Ye
         IIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194942; x=1706799742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTHYIZzUxtAT+UZGnWW/PMLr3D1IxYvIdKjSA4oFUS4=;
        b=pZlcMtfDUULxMvWAvTnVGZNtT48PWTCCcxQ2vG0HhyVWMbuPCDhSBtbU+3tcTglTmq
         HgtHcPffUepyNyRRtM71md7BI5i6lNihVjQ2wIjGMHrKf9JA8alCIm9/mNkoH13Ft65H
         XVK1rcQkLikop5s6gcokDKpELr5/pmKDmKtHzxCkNH6WmZBvtL4P6PYaIczcDBCHN7dp
         sRRKVaj/jdspH6deXFuNsdjxKaIzG43t3Bf2Kp+41yLsJ9bRuvoQPIp6P7qrrmpccL7L
         w2ioFxh+TecDa/wp1ERV8gI8M5JBn/lCiOICDmm6/RsXsQFzqP+E+e7Yxq4nwaGcNqFd
         b/mg==
X-Gm-Message-State: AOJu0YzbHyYvLhJJHzXRp/eTZCGtK7R7owdxMDa9P+wrvoB2lRbJoGR5
	ZKnYEuKTH32g8EX/7c7OvaFt4qynTvmiYSzBMovfbp/A/kb8wMQMKvzUOr3Clro2/mdG8+23Dir
	0k1S+cAR79NROsdYDuaHQZax+g/CroNr9qOPGGA==
X-Google-Smtp-Source: AGHT+IH18fERkDlyVopUGZsEyzj2rkiDR7TmWSqJRbHrxYPyuZZATjZVn5OWkncC1o6/boI68kzvD+uz9/xOct5JPB4=
X-Received: by 2002:a05:6870:9e9c:b0:214:d0c9:b8d9 with SMTP id
 pu28-20020a0568709e9c00b00214d0c9b8d9mr433312oab.1.1706194940332; Thu, 25 Jan
 2024 07:02:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125052744.18866-1-gavin.liu@mediatek.com>
In-Reply-To: <20240125052744.18866-1-gavin.liu@mediatek.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 25 Jan 2024 16:02:08 +0100
Message-ID: <CAHUa44EcGnOno8TQ-wPE8Q_ghG8t5J5uRLqnYduAnQXx6oRATg@mail.gmail.com>
Subject: Re: [PATCH] optee: support wq_sleep_timeout
To: "gavin.liu" <gavin.liu@mediatek.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, 
	Jerome Forissier <jerome.forissier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 6:28=E2=80=AFAM gavin.liu <gavin.liu@mediatek.com> =
wrote:
>
> From: Gavin Liu <gavin.liu@mediatek.com>
>
> Add wq_sleep_timeout to support self waking when timeout for secure
> driver usage.
>
> Signed-off-by: Gavin Liu <gavin.liu@mediatek.com>
> ---
>  drivers/tee/optee/notif.c         |  9 +++++++--
>  drivers/tee/optee/optee_private.h |  2 +-
>  drivers/tee/optee/rpc.c           | 10 ++++++++--
>  3 files changed, 16 insertions(+), 5 deletions(-)

I'd like to see the corresponding secure world changes taking
advantage of this ABI change before we take this any further.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
> index 05212842b0a5..d5e5c0645609 100644
> --- a/drivers/tee/optee/notif.c
> +++ b/drivers/tee/optee/notif.c
> @@ -29,7 +29,7 @@ static bool have_key(struct optee *optee, u_int key)
>         return false;
>  }
>
> -int optee_notif_wait(struct optee *optee, u_int key)
> +int optee_notif_wait(struct optee *optee, u_int key, u32 timeout)
>  {
>         unsigned long flags;
>         struct notif_entry *entry;
> @@ -70,7 +70,12 @@ int optee_notif_wait(struct optee *optee, u_int key)
>          * Unlock temporarily and wait for completion.
>          */
>         spin_unlock_irqrestore(&optee->notif.lock, flags);
> -       wait_for_completion(&entry->c);
> +       if (timeout !=3D 0) {
> +               if (!wait_for_completion_timeout(&entry->c, timeout))
> +                       rc =3D -ETIMEDOUT;
> +       } else {
> +               wait_for_completion(&entry->c);
> +       }
>         spin_lock_irqsave(&optee->notif.lock, flags);
>
>         list_del(&entry->link);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> index 7a5243c78b55..da990c4016ec 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -252,7 +252,7 @@ struct optee_call_ctx {
>
>  int optee_notif_init(struct optee *optee, u_int max_key);
>  void optee_notif_uninit(struct optee *optee);
> -int optee_notif_wait(struct optee *optee, u_int key);
> +int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
>  int optee_notif_send(struct optee *optee, u_int key);
>
>  u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_pa=
rams,
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index e69bc6380683..14e6246aaf05 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -130,6 +130,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct t=
ee_context *ctx,
>  static void handle_rpc_func_cmd_wq(struct optee *optee,
>                                    struct optee_msg_arg *arg)
>  {
> +       int rc =3D 0;
> +
>         if (arg->num_params !=3D 1)
>                 goto bad;
>
> @@ -139,7 +141,8 @@ static void handle_rpc_func_cmd_wq(struct optee *opte=
e,
>
>         switch (arg->params[0].u.value.a) {
>         case OPTEE_RPC_NOTIFICATION_WAIT:
> -               if (optee_notif_wait(optee, arg->params[0].u.value.b))
> +               rc =3D optee_notif_wait(optee, arg->params[0].u.value.b, =
arg->params[0].u.value.c);
> +               if (rc)
>                         goto bad;
>                 break;
>         case OPTEE_RPC_NOTIFICATION_SEND:
> @@ -153,7 +156,10 @@ static void handle_rpc_func_cmd_wq(struct optee *opt=
ee,
>         arg->ret =3D TEEC_SUCCESS;
>         return;
>  bad:
> -       arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> +       if (rc =3D=3D -ETIMEDOUT)
> +               arg->ret =3D TEEC_ERROR_BUSY;
> +       else
> +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
>  }
>
>  static void handle_rpc_func_cmd_wait(struct optee_msg_arg *arg)
> --
> 2.18.0
>

