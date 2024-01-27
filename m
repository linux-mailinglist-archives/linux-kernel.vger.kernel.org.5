Return-Path: <linux-kernel+bounces-41113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7375483EC09
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B3C286133
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881691DFCD;
	Sat, 27 Jan 2024 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTrmFLq4"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24214A89;
	Sat, 27 Jan 2024 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706344134; cv=none; b=fSloNOp2oSrbdcm/vMeyRvJFnoZfPK6oZGewyyNgHCUkFFn8kRsSdDXXW3/xp5HZzNEKZ7wrEjA/NdGQHGl3hqsyrRbKketNY+BE3o7Uf2qsr70KWn7AQPxEB99FA3W1e/qxISWKQx2ZiS+bEI3L/R/Gtw5x3FKlvIoFfhfDWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706344134; c=relaxed/simple;
	bh=d1V8wThzGsmZMZOQ0rForCRH2YGW3FAj81t3pQLuVi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ghe76Ak6bCKaFSGOQROoI1MrHZzJskUNFrTj4obfQZg1jo5XdQvHn13eWYCdGEeH56bN0NGBB5XyJyH4JuS/2vQojnOOUZttWYNSNG8SQUyo96i/zCS9Ynql7/im3R3leY2/42GJqkeYAk13isU0n0z8vbfQCdBP2+fz9gDQx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTrmFLq4; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42a7aa96669so11173711cf.3;
        Sat, 27 Jan 2024 00:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706344130; x=1706948930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0BfXCv58nbfgA3SCTcAzVjBex9YEwBJLtzAAg7/CVs=;
        b=PTrmFLq4O8HiHzCJaQs23qkoKQbMLY1hIwE9gz7bySTgG3sbMzuNMq2Vn6DOi4oNZB
         SeApx1wOdB2J+jZVAjJVCiI4e3Cp6+3TT6mwGgKNIjGUSPX3GHqQ1dmtUi0DYNtDFSNK
         wIYEhgatEnQKBXenJn8tsvaQMwpGPzsBg9TTF6Scf4jAjTJZDjKxHsre5DTQPXhUt6zr
         D3Z/020ZJr6vC4BD2E/+18ms2V1Gffnrz90+/0Zt7OHaRzIhaPK012DE+/ZuID5z//62
         fjlSWAAuV9GAUOaHpkO0RSbiYQPdosqqQYvWlyvMCotDyOJmudO/Auqo4GK/QnWhgZ+R
         QAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706344130; x=1706948930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0BfXCv58nbfgA3SCTcAzVjBex9YEwBJLtzAAg7/CVs=;
        b=dS5MFpp6KjUoZtm5CWuIhOwaz3L9bPmt6K8igNh3bt5xmJp5mkCUFWxUs+rR4Y5qMh
         jpEucsrgti8iAYDamMhyqENIIAwAKz0FTfQSwyyXD6au9yVgnfgIv0V4VvAP0ccSMC24
         bUsTP3RShzLkAaymJ5a1gYlJmge6O0taTexP1zc2Mt2Rc6sEhu6u27mx+JNrGvn6f0r4
         SLDusM+sG7kXvCDGb6QKVCmQQu8LOZ7L9QDLZV2nXxvQiUlqMM+zkBzdvkqzZUj+P/Rk
         R73MGrljavRWTMAkmGL+HfvPuz+E147q9xvEihur81SEHHyl9Ka310VKxKBZneQ+wVAL
         GK8Q==
X-Gm-Message-State: AOJu0YwxKqHRap/KZrN1gYnRJVZIy9A9TerlvRy9zcJwx5qizKc+mIXx
	IauwNkvdCkc2ul8PeZXoGl2pqwpPZuhPae0GRuHm3tXLLcL7q21vVEw7FjoFVP+jyv341kQh8CN
	EYUh7P8NIBjO0HY1+4PhNsLsUPYw=
X-Google-Smtp-Source: AGHT+IGz9c4eJJFD/0IFcc65sOC3RuOQPreLDtj3R93QK8hdP9hJTZlP+oz53pONWb1Uh/Altr2oz77Xl9lALM8+snU=
X-Received: by 2002:a05:6214:19c4:b0:686:9fb0:7d80 with SMTP id
 j4-20020a05621419c400b006869fb07d80mr1829615qvc.68.1706344129447; Sat, 27 Jan
 2024 00:28:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123062827.8525-1-victorshihgli@gmail.com> <20240123062827.8525-8-victorshihgli@gmail.com>
In-Reply-To: <20240123062827.8525-8-victorshihgli@gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Sat, 27 Jan 2024 16:28:43 +0800
Message-ID: <CAK00qKBf24CMFygfutpfxQwaKEQEo+FKv2XU4X_oxv38un-YEg@mail.gmail.com>
Subject: Re: [PATCH V14 07/21] mmc: core: Support UHS-II card control and access
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Jason Lai <jason.lai@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 2:28=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Embed UHS-II access/control functionality into the MMC request
> processing flow.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>
> Updates in V13:
>  - Separate __mmc_go_idle() into one patch for re-factorring the code.
>  - Move mmc_decode_scr declaration to sd.h.
>  - Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
>  - Drop unnecessary comment.
>
> Updates in V12:
>  - Use mmc_op_multi() to check DCMD which supports multi read/write
>    in mmc_uhs2_prepare_cmd().
>
> Updates in V10:
>  - Move some definitions of PatchV9[02/23] to PatchV10[06/23].
>  - Move some definitions of PatchV9[05/23] to PatchV10[06/23].
>  - Drop do_multi in the mmc_blk_rw_rq_prep().
>  - Use tmode_half_duplex to instead of uhs2_tmode0_flag.
>  - Move entire control of the tmode into mmc_uhs2_prepare_cmd().
>
> Updates in V8:
>  - Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
>  - Modify return value in sd_uhs2_attach().
>
> Updates in V7:
>  - Add mmc_uhs2_card_prepare_cmd helper function in sd_ops.h.
>  - Drop uhs2_state in favor of ios->timing.
>  - Remove unnecessary functions.
>
> ---
>
>  drivers/mmc/core/core.c    |   10 +-
>  drivers/mmc/core/sd.c      |   10 +-
>  drivers/mmc/core/sd.h      |    5 +
>  drivers/mmc/core/sd_ops.c  |    9 +
>  drivers/mmc/core/sd_ops.h  |   17 +
>  drivers/mmc/core/sd_uhs2.c | 1115 ++++++++++++++++++++++++++++++++++--
>  include/linux/mmc/core.h   |   13 +
>  include/linux/mmc/host.h   |   15 +
>  8 files changed, 1155 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 2edf31492a5d..be77cebe1fb8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -334,6 +334,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct=
 mmc_request *mrq)
>
>  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  {
> +       struct uhs2_command uhs2_cmd;
> +       __be32 payload[4]; /* for maximum size */
>         int err;
>
>         init_completion(&mrq->cmd_completion);
> @@ -351,6 +353,8 @@ int mmc_start_request(struct mmc_host *host, struct m=
mc_request *mrq)
>         if (err)
>                 return err;
>
> +       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> +
>         led_trigger_event(host->led, LED_FULL);
>         __mmc_start_request(host, mrq);
>

Hi, Adrian

I referenced your comments of the V9:

Refer:
https://patchwork.kernel.org/project/linux-mmc/patch/20230721101349.12387-7=
-victorshihgli@gmail.com/

My understanding is as follows, please correct me if there are any mistakes=
.
There is already "struct uhs2_command *uhs2_cmd" in struct mmc_command.
If I also put "__be32 payload[4]" in struct mmc_command.
The code will become:
mmc_uhs2_card_prepare_cmd(host, mrq, *mrq->cmd->uhs2_cmd, mrq->cmd->payload=
);
But a null pointer problem occurs when sending commands like COM0(mmc_go_id=
le).
In this case I just can only plan for the time being as follows:

if (mrq->cmd->uhs2_cmd)
     mmc_uhs2_card_prepare_cmd(host, mrq, *mrq->cmd->uhs2_cmd,
mrq->cmd->payload);
else
     mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);

Would you give me any other advice?

Thanks, Victor Shih

> @@ -430,6 +434,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
>   */
>  int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
>  {
> +       struct uhs2_command uhs2_cmd;
> +       __be32 payload[4]; /* for maximum size */
>         int err;
>
>         /*
> @@ -450,6 +456,8 @@ int mmc_cqe_start_req(struct mmc_host *host, struct m=
mc_request *mrq)
>         if (err)
>                 goto out_err;
>
> +       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> +
>         err =3D host->cqe_ops->cqe_request(host, mrq);
>         if (err)
>                 goto out_err;
> @@ -1132,7 +1140,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 o=
cr)
>                 return 0;
>         }
>
> -       if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
> +       if (!mmc_card_uhs2(host) && host->caps2 & MMC_CAP2_FULL_PWR_CYCLE=
) {
>                 bit =3D ffs(ocr) - 1;
>                 ocr &=3D 3 << bit;
>                 mmc_power_cycle(host, ocr);
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index c3e554344c99..67fded1b2be0 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -207,7 +207,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>  /*
>   * Given a 64-bit response, decode to our card SCR structure.
>   */
> -static int mmc_decode_scr(struct mmc_card *card)
> +int mmc_decode_scr(struct mmc_card *card)
>  {
>         struct sd_scr *scr =3D &card->scr;
>         unsigned int scr_struct;
> @@ -904,7 +904,7 @@ int mmc_sd_get_csd(struct mmc_card *card)
>         return 0;
>  }
>
> -static int mmc_sd_get_ro(struct mmc_host *host)
> +int mmc_sd_get_ro(struct mmc_host *host)
>  {
>         int ro;
>
> @@ -1630,7 +1630,7 @@ static void mmc_sd_detect(struct mmc_host *host)
>         }
>  }
>
> -static int sd_can_poweroff_notify(struct mmc_card *card)
> +int sd_can_poweroff_notify(struct mmc_card *card)
>  {
>         return card->ext_power.feature_support & SD_EXT_POWER_OFF_NOTIFY;
>  }
> @@ -1658,7 +1658,7 @@ static int sd_busy_poweroff_notify_cb(void *cb_data=
, bool *busy)
>         return 0;
>  }
>
> -static int sd_poweroff_notify(struct mmc_card *card)
> +int sd_poweroff_notify(struct mmc_card *card)
>  {
>         struct sd_busy_data cb_data;
>         u8 *reg_buf;
> @@ -1706,7 +1706,7 @@ static int _mmc_sd_suspend(struct mmc_host *host)
>         if (mmc_card_suspended(card))
>                 goto out;
>
> -       if (sd_can_poweroff_notify(card))
> +       if (mmc_sd_can_poweroff_notify(card))
>                 err =3D sd_poweroff_notify(card);
>         else if (!mmc_host_is_spi(host))
>                 err =3D mmc_deselect_cards(host);
> diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
> index 1af5a038bae9..fbfaa3b00630 100644
> --- a/drivers/mmc/core/sd.h
> +++ b/drivers/mmc/core/sd.h
> @@ -11,10 +11,15 @@ struct mmc_card;
>
>  int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
>  int mmc_sd_get_csd(struct mmc_card *card);
> +int mmc_decode_scr(struct mmc_card *card);
> +int mmc_sd_get_ro(struct mmc_host *host);
>  void mmc_decode_cid(struct mmc_card *card);
>  int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>         bool reinit);
>  unsigned mmc_sd_get_max_clock(struct mmc_card *card);
>  int mmc_sd_switch_hs(struct mmc_card *card);
>
> +int sd_can_poweroff_notify(struct mmc_card *card);
> +int sd_poweroff_notify(struct mmc_card *card);
> +
>  #endif
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index a59cd592f06e..f22c7041632c 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -27,6 +27,15 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_card=
 *card)
>         if (WARN_ON(card && card->host !=3D host))
>                 return -EINVAL;
>
> +       /*
> +        * UHS2 packet has APP bit so only set APP_CMD flag here.
> +        * Will set the APP bit when assembling UHS2 packet.
> +        */
> +       if (host->uhs2_sd_tran) {
> +               host->uhs2_app_cmd =3D true;
> +               return 0;
> +       }
> +
>         cmd.opcode =3D MMC_APP_CMD;
>
>         if (card) {
> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> index 7667fc223b74..d3a3465c7669 100644
> --- a/drivers/mmc/core/sd_ops.h
> +++ b/drivers/mmc/core/sd_ops.h
> @@ -11,6 +11,7 @@
>  #include <linux/types.h>
>
>  struct mmc_card;
> +struct mmc_command;
>  struct mmc_host;
>
>  int mmc_app_set_bus_width(struct mmc_card *card, int width);
> @@ -21,6 +22,22 @@ int mmc_send_relative_addr(struct mmc_host *host, unsi=
gned int *rca);
>  int mmc_app_send_scr(struct mmc_card *card);
>  int mmc_app_sd_status(struct mmc_card *card, void *ssr);
>  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
> +void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq=
);
> +
> +static inline void mmc_uhs2_card_prepare_cmd(struct mmc_host *host, stru=
ct mmc_request *mrq,
> +                                            struct uhs2_command uhs2_cmd=
, __be32 payload[4])
> +{
> +       if (host->uhs2_sd_tran) {
> +               uhs2_cmd.payload =3D payload;
> +               mrq->cmd->uhs2_cmd =3D &uhs2_cmd;
> +               mmc_uhs2_prepare_cmd(host, mrq);
> +       }
> +}
> +
> +static inline int mmc_sd_can_poweroff_notify(struct mmc_card *card)
> +{
> +       return card->ext_power.feature_support & SD_EXT_POWER_OFF_NOTIFY;
> +}
>
>  #endif
>
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index beb2541338ff..c46729d85644 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -1,23 +1,51 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (C) 2021 Linaro Ltd
> - *
>   * Author: Ulf Hansson <ulf.hansson@linaro.org>
>   *
> + * Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + * Author: Yi Sun <yi.y.sun@intel.com>
> + *
> + * Copyright (C) 2020 Genesys Logic, Inc.
> + * Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> + *
> + * Copyright (C) 2020 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *
> + * Copyright (C) 2022 Genesys Logic, Inc.
> + * Authors: Jason Lai <jason.lai@genesyslogic.com.tw>
> + *
> + * Copyright (C) 2023 Genesys Logic, Inc.
> + * Authors: Victor Shih <victor.shih@genesyslogic.com.tw>
> + *
>   * Support for SD UHS-II cards
>   */
>  #include <linux/err.h>
> +#include <linux/pm_runtime.h>
>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/mmc/sd_uhs2.h>
>
> +#include "card.h"
>  #include "core.h"
>  #include "bus.h"
>  #include "sd.h"
> +#include "sd_ops.h"
>  #include "mmc_ops.h"
>
> +#define UHS2_WAIT_CFG_COMPLETE_PERIOD_US  (1 * 1000)
> +#define UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS 100
> +
>  static const unsigned int sd_uhs2_freqs[] =3D { 52000000, 26000000 };
>
> +struct sd_uhs2_wait_active_state_data {
> +       struct mmc_host *host;
> +       struct mmc_command *cmd;
> +};
> +
>  static int sd_uhs2_power_up(struct mmc_host *host)
>  {
>         int err;
> @@ -42,12 +70,51 @@ static int sd_uhs2_power_off(struct mmc_host *host)
>
>         host->ios.vdd =3D 0;
>         host->ios.clock =3D 0;
> -       host->ios.timing =3D MMC_TIMING_LEGACY;
> +       /* Must set UHS2 timing to identify UHS2 mode */
> +       host->ios.timing =3D MMC_TIMING_UHS2_SPEED_A;
>         host->ios.power_mode =3D MMC_POWER_OFF;
> +       host->uhs2_sd_tran =3D false;
>
>         return host->ops->uhs2_control(host, UHS2_SET_IOS);
>  }
>
> +/*
> + * sd_uhs2_cmd_assemble() - build up UHS-II command packet which is embe=
dded in
> + *                          mmc_command structure
> + * @cmd:       MMC command to executed
> + * @uhs2_cmd:  UHS2 command corresponded to MMC command
> + * @header:    Header field of UHS-II command cxpacket
> + * @arg:       Argument field of UHS-II command packet
> + * @payload:   Payload field of UHS-II command packet
> + * @plen:      Payload length
> + * @resp:      Response buffer is allocated by caller and it is used to =
keep
> + *              the response of CM-TRAN command. For SD-TRAN command, uh=
s2_resp
> + *              should be null and SD-TRAN command response should be st=
ored in
> + *              resp of mmc_command.
> + * @resp_len:  Response buffer length
> + *
> + * The uhs2_command structure contains message packets which are transmi=
ted/
> + * received on UHS-II bus. This function fills in the contents of uhs2_c=
ommand
> + * structure and embededs UHS2 command into mmc_command structure, which=
 is used
> + * in legacy SD operation functions.
> + *
> + */
> +static void sd_uhs2_cmd_assemble(struct mmc_command *cmd,
> +                                struct uhs2_command *uhs2_cmd,
> +                                u16 header, u16 arg, __be32 *payload,
> +                                u8 plen, u8 *resp, u8 resp_len)
> +{
> +       uhs2_cmd->header =3D header;
> +       uhs2_cmd->arg =3D arg;
> +       uhs2_cmd->payload =3D payload;
> +       uhs2_cmd->payload_len =3D plen * sizeof(u32);
> +       uhs2_cmd->packet_len =3D uhs2_cmd->payload_len + 4;
> +
> +       cmd->uhs2_cmd =3D uhs2_cmd;
> +       cmd->uhs2_resp =3D resp;
> +       cmd->uhs2_resp_len =3D resp_len;
> +}
> +
>  /*
>   * Run the phy initialization sequence, which mainly relies on the UHS-I=
I host
>   * to check that we reach the expected electrical state, between the hos=
t and
> @@ -55,7 +122,15 @@ static int sd_uhs2_power_off(struct mmc_host *host)
>   */
>  static int sd_uhs2_phy_init(struct mmc_host *host)
>  {
> -       return 0;
> +       int err;
> +
> +       err =3D host->ops->uhs2_control(host, UHS2_PHY_INIT);
> +       if (err) {
> +               pr_err("%s: failed to initial phy for UHS-II!\n",
> +                      mmc_hostname(host));
> +       }
> +
> +       return err;
>  }
>
>  /*
> @@ -64,6 +139,80 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
>   */
>  static int sd_uhs2_dev_init(struct mmc_host *host)
>  {
> +       struct mmc_command cmd =3D {0};
> +       struct uhs2_command uhs2_cmd =3D {};
> +       u32 cnt;
> +       u32 dap, gap, resp_gap;
> +       u16 header, arg;
> +       __be32 payload[UHS2_DEV_INIT_PAYLOAD_LEN];
> +       u8 gd =3D 0;
> +       u8 resp[UHS2_DEV_ENUM_RESP_LEN] =3D {0};
> +       int err;
> +
> +       dap =3D host->uhs2_caps.dap;
> +       gap =3D host->uhs2_caps.gap;
> +
> +       /*
> +        * Refer to UHS-II Addendum Version 1.02 Figure 6-21 to see DEVIC=
E_INIT CCMD format.
> +        * Head:
> +        *      - Control Write(R/W=3D1) with 4-Byte payload(PLEN=3D01b).
> +        *      - IOADR =3D CMD_BASE + 002h
> +        * Payload:
> +        *      - bit [3:0]  : GAP(Group Allocated Power)
> +        *      - bit [7:4]  : GD(Group Descriptor)
> +        *      - bit [11]   : Complete Flag
> +        *      - bit [15:12]: DAP(Device Allocated Power)
> +        */
> +       header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> +       arg =3D ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
> +              UHS2_NATIVE_CMD_WRITE |
> +              UHS2_NATIVE_CMD_PLEN_4B |
> +              (UHS2_DEV_CMD_DEVICE_INIT >> 8);
> +
> +       /*
> +        * Refer to UHS-II Addendum Version 1.02 section 6.3.1.
> +        * Max. time from DEVICE_INIT CCMD EOP reception on Device
> +        * Rx to its SOP transmission on Device Tx(Tfwd_init_cmd) is
> +        * 1 second.
> +        */
> +       cmd.busy_timeout =3D 1000;
> +
> +       /*
> +        * Refer to UHS-II Addendum Version 1.02 section 6.2.6.3.
> +        * Let's retry the DEVICE_INIT command no more than 30 times.
> +        */
> +       for (cnt =3D 0; cnt < 30; cnt++) {
> +               payload[0] =3D ((dap & 0xF) << 12) |
> +                             UHS2_DEV_INIT_COMPLETE_FLAG |
> +                             ((gd & 0xF) << 4) |
> +                             (gap & 0xF);
> +
> +               sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,
> +                                    payload, UHS2_DEV_INIT_PAYLOAD_LEN,
> +                                    resp, UHS2_DEV_INIT_RESP_LEN);
> +
> +               err =3D mmc_wait_for_cmd(host, &cmd, 0);
> +               if (err) {
> +                       pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\=
n",
> +                              mmc_hostname(host), __func__, err);
> +                       return err;
> +               }
> +
> +               if (resp[3] !=3D (UHS2_DEV_CMD_DEVICE_INIT & 0xFF)) {
> +                       pr_err("%s: DEVICE_INIT response is wrong!\n",
> +                              mmc_hostname(host));
> +                       return -EIO;
> +               }
> +
> +               if (resp[5] & 0x8) {
> +                       host->uhs2_caps.group_desc =3D gd;
> +                       return 0;
> +               }
> +               resp_gap =3D resp[4] & 0x0F;
> +               if (gap =3D=3D resp_gap)
> +                       gd++;
> +       }
> +
>         return 0;
>  }
>
> @@ -74,6 +223,52 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
>   */
>  static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
>  {
> +       struct mmc_command cmd =3D {0};
> +       struct uhs2_command uhs2_cmd =3D {};
> +       u16 header, arg;
> +       __be32 payload[UHS2_DEV_ENUM_PAYLOAD_LEN];
> +       u8 id_f =3D 0xF, id_l =3D 0x0;
> +       u8 resp[UHS2_DEV_ENUM_RESP_LEN] =3D {0};
> +       int err;
> +
> +       /*
> +        * Refer to UHS-II Addendum Version 1.02 Figure 6-28 to see ENUME=
RATE CCMD format.
> +        * Header:
> +        *      - Control Write(R/W=3D1) with 4-Byte payload(PLEN=3D01b).
> +        *      - IOADR =3D CMD_BASE + 003h
> +        * Payload:
> +        *      - bit [3:0]: ID_L(Last Node ID)
> +        *      - bit [7:4]: ID_F(First Node ID)
> +        */
> +       header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> +       arg =3D ((UHS2_DEV_CMD_ENUMERATE & 0xFF) << 8) |
> +              UHS2_NATIVE_CMD_WRITE |
> +              UHS2_NATIVE_CMD_PLEN_4B |
> +              (UHS2_DEV_CMD_ENUMERATE >> 8);
> +
> +       payload[0] =3D (id_f << 4) | id_l;
> +       payload[0] =3D cpu_to_be32(payload[0]);
> +
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_=
DEV_ENUM_PAYLOAD_LEN,
> +                            resp, UHS2_DEV_ENUM_RESP_LEN);
> +
> +       err =3D mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       if (resp[3] !=3D (UHS2_DEV_CMD_ENUMERATE & 0xFF)) {
> +               pr_err("%s: ENUMERATE response is wrong!\n",
> +                      mmc_hostname(host));
> +               return -EIO;
> +       }
> +
> +       id_f =3D (resp[4] >> 4) & 0xF;
> +       id_l =3D resp[4] & 0xF;
> +       *node_id =3D id_f;
> +
>         return 0;
>  }
>
> @@ -84,6 +279,181 @@ static int sd_uhs2_enum(struct mmc_host *host, u32 *=
node_id)
>   */
>  static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *c=
ard)
>  {
> +       struct mmc_command cmd =3D {0};
> +       struct uhs2_command uhs2_cmd =3D {};
> +       u16 header, arg;
> +       u32 cap;
> +       int err;
> +
> +       /*
> +        * Use Control Read CCMD to read Generic Capability from Configur=
ation Register.
> +        * - Control Write(R/W=3D1) with 4-Byte payload(PLEN=3D01b).
> +        * - IOADR =3D Generic Capability Register(CFG_BASE + 000h)
> +        */
> +       header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | card->uhs=
2_config.node_id;
> +       arg =3D ((UHS2_DEV_CONFIG_GEN_CAPS & 0xFF) << 8) |
> +              UHS2_NATIVE_CMD_READ |
> +              UHS2_NATIVE_CMD_PLEN_4B |
> +              (UHS2_DEV_CONFIG_GEN_CAPS >> 8);
> +
> +       /*
> +        * There is no payload because per spec, there should be
> +        * no payload field for read CCMD.
> +        * Plen is set in arg. Per spec, plen for read CCMD
> +        * represents the len of read data which is assigned in payload
> +        * of following RES (p136).
> +        */
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL,=
 0);
> +
> +       err =3D mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /*
> +        * Generic Capability Register:
> +        * bit [7:0]  : Reserved
> +        * bit [13:8] : Device-Specific Number of Lanes and Functionality
> +        *              bit 8: 2L-HD
> +        *              bit 9: 2D-1U FD
> +        *              bit 10: 1D-2U FD
> +        *              bit 11: 2D-2U FD
> +        *              Others: Reserved
> +        * bit [14]   : DADR Length
> +        *              0: 4 bytes
> +        *              1: Reserved
> +        * bit [23:16]: Application Type
> +        *              bit 16: 0=3DNon-SD memory, 1=3DSD memory
> +        *              bit 17: 0=3DNon-SDIO, 1=3DSDIO
> +        *              bit 18: 0=3DCard, 1=3DEmbedded
> +        * bit [63:24]: Reserved
> +        */
> +       cap =3D cmd.resp[0];
> +       card->uhs2_config.n_lanes =3D
> +                               (cap >> UHS2_DEV_CONFIG_N_LANES_POS) &
> +                               UHS2_DEV_CONFIG_N_LANES_MASK;
> +       card->uhs2_config.dadr_len =3D
> +                               (cap >> UHS2_DEV_CONFIG_DADR_POS) &
> +                               UHS2_DEV_CONFIG_DADR_MASK;
> +       card->uhs2_config.app_type =3D
> +                               (cap >> UHS2_DEV_CONFIG_APP_POS) &
> +                               UHS2_DEV_CONFIG_APP_MASK;
> +
> +       /*
> +        * Use Control Read CCMD to read PHY Capability from Configuratio=
n Register.
> +        * - Control Write(R/W=3D1) with 8-Byte payload(PLEN=3D10b).
> +        * - IOADR =3D PHY Capability Register(CFG_BASE + 002h)
> +        */
> +       arg =3D ((UHS2_DEV_CONFIG_PHY_CAPS & 0xFF) << 8) |
> +              UHS2_NATIVE_CMD_READ |
> +              UHS2_NATIVE_CMD_PLEN_8B |
> +             (UHS2_DEV_CONFIG_PHY_CAPS >> 8);
> +
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL,=
 0);
> +
> +       err =3D mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /*
> +        * PHY Capability Register:
> +        * bit [3:0]  : PHY Minor Revision
> +        * bit [5:4]  : PHY Major Revision
> +        * bit [15]   : Support Hibernate Mode
> +        *              0: Not support Hibernate Mode
> +        *              1: Support Hibernate Mode
> +        * bit [31:16]: Reserved
> +        * bit [35:32]: Device-Specific N_LSS_SYN
> +        * bit [39:36]: Device-Specific N_LSS_DIR
> +        * bit [63:40]: Reserved
> +        */
> +       cap =3D cmd.resp[0];
> +       card->uhs2_config.phy_minor_rev =3D
> +                               cap & UHS2_DEV_CONFIG_PHY_MINOR_MASK;
> +       card->uhs2_config.phy_major_rev =3D
> +                               (cap >> UHS2_DEV_CONFIG_PHY_MAJOR_POS) &
> +                                UHS2_DEV_CONFIG_PHY_MAJOR_MASK;
> +       card->uhs2_config.can_hibernate =3D
> +                               (cap >> UHS2_DEV_CONFIG_CAN_HIBER_POS) &
> +                                UHS2_DEV_CONFIG_CAN_HIBER_MASK;
> +
> +       cap =3D cmd.resp[1];
> +       card->uhs2_config.n_lss_sync =3D
> +                               cap & UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
> +       card->uhs2_config.n_lss_dir =3D
> +                               (cap >> UHS2_DEV_CONFIG_N_LSS_DIR_POS) &
> +                               UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
> +       if (card->uhs2_config.n_lss_sync =3D=3D 0)
> +               card->uhs2_config.n_lss_sync =3D 16 << 2;
> +       else
> +               card->uhs2_config.n_lss_sync <<=3D 2;
> +
> +       if (card->uhs2_config.n_lss_dir =3D=3D 0)
> +               card->uhs2_config.n_lss_dir =3D 16 << 3;
> +       else
> +               card->uhs2_config.n_lss_dir <<=3D 3;
> +
> +       /*
> +        * Use Control Read CCMD to read LINK/TRAN Capability from Config=
uration Register.
> +        * - Control Write(R/W=3D1) with 8-Byte payload(PLEN=3D10b).
> +        * - IOADR =3D LINK/TRAN Capability Register(CFG_BASE + 004h)
> +        */
> +       arg =3D ((UHS2_DEV_CONFIG_LINK_TRAN_CAPS & 0xFF) << 8) |
> +               UHS2_NATIVE_CMD_READ |
> +               UHS2_NATIVE_CMD_PLEN_8B |
> +               (UHS2_DEV_CONFIG_LINK_TRAN_CAPS >> 8);
> +
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL,=
 0);
> +
> +       err =3D mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /*
> +        * LINK/TRAN Capability Register:
> +        * bit [3:0]  : LINK_TRAN Minor Revision
> +        * bit [5:4]  : LINK/TRAN Major Revision
> +        * bit [7:6]  : Reserved
> +        * bit [15:8] : Device-Specific N_FCU
> +        * bit [18:16]: Device Type
> +        *              001b=3DHost
> +        *              010b=3DDevice
> +        *              011b=3DReserved for CMD issuable Device
> +        * bit [19]   : Reserved
> +        * bit [31:20]: Device-Specific MAX_BLKLEN
> +        * bit [39:32]: Device-Specific N_DATA_GAP
> +        * bit [63:40]: Reserved
> +        */
> +       cap =3D cmd.resp[0];
> +       card->uhs2_config.link_minor_rev =3D
> +                               cap & UHS2_DEV_CONFIG_LT_MINOR_MASK;
> +       card->uhs2_config.link_major_rev =3D
> +                               (cap >> UHS2_DEV_CONFIG_LT_MAJOR_POS) &
> +                               UHS2_DEV_CONFIG_LT_MAJOR_MASK;
> +       card->uhs2_config.n_fcu =3D
> +                               (cap >> UHS2_DEV_CONFIG_N_FCU_POS) &
> +                               UHS2_DEV_CONFIG_N_FCU_MASK;
> +       card->uhs2_config.dev_type =3D
> +                               (cap >> UHS2_DEV_CONFIG_DEV_TYPE_POS) &
> +                               UHS2_DEV_CONFIG_DEV_TYPE_MASK;
> +       card->uhs2_config.maxblk_len =3D
> +                               (cap >> UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) =
&
> +                               UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK;
> +
> +       cap =3D cmd.resp[1];
> +       card->uhs2_config.n_data_gap =3D
> +                               cap & UHS2_DEV_CONFIG_N_DATA_GAP_MASK;
> +       if (card->uhs2_config.n_fcu =3D=3D 0)
> +               card->uhs2_config.n_fcu =3D 256;
> +
>         return 0;
>  }
>
> @@ -98,26 +468,357 @@ static int sd_uhs2_config_read(struct mmc_host *hos=
t, struct mmc_card *card)
>   */
>  static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *=
card)
>  {
> +       struct mmc_command cmd =3D {0};
> +       struct uhs2_command uhs2_cmd =3D {};
> +       u16 header, arg;
> +       __be32 payload[UHS2_CFG_WRITE_PAYLOAD_LEN];
> +       u8 nMinDataGap;
> +       int err;
> +       u8 resp[5] =3D {0};
> +
> +       /*
> +        * Use Control Write CCMD to set Generic Setting in Configuration=
 Register.
> +        * - Control Write(R/W=3D1) with 8-Byte payload(PLEN=3D10b).
> +        * - IOADR =3D Generic Setting Register(CFG_BASE + 008h)
> +        * - Payload =3D New contents to be written to Generic Setting Re=
gister
> +        */
> +       header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | card->uhs=
2_config.node_id;
> +       arg =3D ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +              UHS2_NATIVE_CMD_WRITE |
> +              UHS2_NATIVE_CMD_PLEN_8B |
> +              (UHS2_DEV_CONFIG_GEN_SET >> 8);
> +
> +       /*
> +        * Most UHS-II cards only support FD and 2L-HD mode. Other lane n=
umbers
> +        * defined in UHS-II addendem Ver1.01 are optional.
> +        */
> +       host->uhs2_caps.n_lanes_set =3D UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> +       card->uhs2_config.n_lanes_set =3D UHS2_DEV_CONFIG_GEN_SET_2L_FD_H=
D;
> +
> +       payload[0] =3D card->uhs2_config.n_lanes_set << UHS2_DEV_CONFIG_N=
_LANES_POS;
> +       payload[1] =3D 0;
> +       payload[0] =3D cpu_to_be32(payload[0]);
> +       payload[1] =3D cpu_to_be32(payload[1]);
> +
> +       /*
> +        * There is no payload because per spec, there should be
> +        * no payload field for read CCMD.
> +        * Plen is set in arg. Per spec, plen for read CCMD
> +        * represents the len of read data which is assigned in payload
> +        * of following RES (p136).
> +        */
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_=
CFG_WRITE_PAYLOAD_LEN,
> +                            NULL, 0);
> +
> +       err =3D mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /*
> +        * Use Control Write CCMD to set PHY Setting in Configuration Reg=
ister.
> +        * - Control Write(R/W=3D1) with 8-Byte payload(PLEN=3D10b).
> +        * - IOADR =3D PHY Setting Register(CFG_BASE + 00Ah)
> +        * - Payload =3D New contents to be written to PHY Setting Regist=
er
> +        */
> +       arg =3D ((UHS2_DEV_CONFIG_PHY_SET & 0xFF) << 8) |
> +              UHS2_NATIVE_CMD_WRITE |
> +              UHS2_NATIVE_CMD_PLEN_8B |
> +              (UHS2_DEV_CONFIG_PHY_SET >> 8);
> +
> +       if (host->uhs2_caps.speed_range =3D=3D UHS2_DEV_CONFIG_PHY_SET_SP=
EED_B) {
> +               if (card->uhs2_config.n_lanes =3D=3D UHS2_DEV_CONFIG_2L_H=
D_FD &&
> +                   host->uhs2_caps.n_lanes =3D=3D UHS2_DEV_CONFIG_2L_HD_=
FD) {
> +                       /* Support HD */
> +                       host->ios.timing =3D MMC_TIMING_UHS2_SPEED_B_HD;
> +                       nMinDataGap =3D 1;
> +               } else {
> +                       /* Only support 2L-FD so far */
> +                       host->ios.timing =3D MMC_TIMING_UHS2_SPEED_B;
> +                       nMinDataGap =3D 3;
> +               }
> +               card->uhs2_config.speed_range_set =3D UHS2_DEV_CONFIG_PHY=
_SET_SPEED_B;
> +       } else {
> +               if (card->uhs2_config.n_lanes =3D=3D UHS2_DEV_CONFIG_2L_H=
D_FD &&
> +                   host->uhs2_caps.n_lanes =3D=3D UHS2_DEV_CONFIG_2L_HD_=
FD) {
> +                       /* Support HD */
> +                       host->ios.timing =3D MMC_TIMING_UHS2_SPEED_A_HD;
> +                       nMinDataGap =3D 1;
> +               } else {
> +                       /* Only support 2L-FD so far */
> +                       host->ios.timing =3D MMC_TIMING_UHS2_SPEED_A;
> +                       nMinDataGap =3D 3;
> +               }
> +               card->uhs2_config.speed_range_set =3D UHS2_DEV_CONFIG_PHY=
_SET_SPEED_A;
> +       }
> +
> +       payload[0] =3D card->uhs2_config.speed_range_set << UHS2_DEV_CONF=
IG_PHY_SET_SPEED_POS;
> +
> +       card->uhs2_config.n_lss_sync_set =3D (max(card->uhs2_config.n_lss=
_sync,
> +                                               host->uhs2_caps.n_lss_syn=
c) >> 2) &
> +                                          UHS2_DEV_CONFIG_N_LSS_SYN_MASK=
;
> +       host->uhs2_caps.n_lss_sync_set =3D card->uhs2_config.n_lss_sync_s=
et;
> +
> +       card->uhs2_config.n_lss_dir_set =3D (max(card->uhs2_config.n_lss_=
dir,
> +                                              host->uhs2_caps.n_lss_dir)=
 >> 3) &
> +                                         UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
> +       host->uhs2_caps.n_lss_dir_set =3D card->uhs2_config.n_lss_dir_set=
;
> +
> +       payload[1] =3D (card->uhs2_config.n_lss_dir_set << UHS2_DEV_CONFI=
G_N_LSS_DIR_POS) |
> +                    card->uhs2_config.n_lss_sync_set;
> +       payload[0] =3D cpu_to_be32(payload[0]);
> +       payload[1] =3D cpu_to_be32(payload[1]);
> +
> +       memset(resp, 0, sizeof(resp));
> +
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_=
CFG_WRITE_PAYLOAD_LEN,
> +                            resp, UHS2_CFG_WRITE_PHY_SET_RESP_LEN);
> +
> +       err =3D mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       if ((resp[2] & 0x80)) {
> +               pr_err("%s: %s: UHS2 CMD not accepted, resp=3D 0x%x!\n",
> +                      mmc_hostname(host), __func__, resp[2]);
> +               return -EIO;
> +       }
> +
> +       /*
> +        * Use Control Write CCMD to set LINK/TRAN Setting in Configurati=
on Register.
> +        * - Control Write(R/W=3D1) with 8-Byte payload(PLEN=3D10b).
> +        * - IOADR =3D LINK/TRAN Setting Register(CFG_BASE + 00Ch)
> +        * - Payload =3D New contents to be written to LINK/TRAN Setting =
Register
> +        */
> +       arg =3D ((UHS2_DEV_CONFIG_LINK_TRAN_SET & 0xFF) << 8) |
> +               UHS2_NATIVE_CMD_WRITE |
> +               UHS2_NATIVE_CMD_PLEN_8B |
> +               (UHS2_DEV_CONFIG_LINK_TRAN_SET >> 8);
> +
> +       if (card->uhs2_config.app_type =3D=3D UHS2_DEV_CONFIG_APP_SD_MEM)
> +               card->uhs2_config.maxblk_len_set =3D UHS2_DEV_CONFIG_LT_S=
ET_MAX_BLK_LEN;
> +       else
> +               card->uhs2_config.maxblk_len_set =3D min(card->uhs2_confi=
g.maxblk_len,
> +                                                      host->uhs2_caps.ma=
xblk_len);
> +       host->uhs2_caps.maxblk_len_set =3D card->uhs2_config.maxblk_len_s=
et;
> +
> +       card->uhs2_config.n_fcu_set =3D min(card->uhs2_config.n_fcu, host=
->uhs2_caps.n_fcu);
> +       host->uhs2_caps.n_fcu_set =3D card->uhs2_config.n_fcu_set;
> +
> +       card->uhs2_config.n_data_gap_set =3D max(nMinDataGap, card->uhs2_=
config.n_data_gap);
> +       host->uhs2_caps.n_data_gap_set =3D card->uhs2_config.n_data_gap_s=
et;
> +
> +       host->uhs2_caps.max_retry_set =3D 3;
> +       card->uhs2_config.max_retry_set =3D host->uhs2_caps.max_retry_set=
;
> +
> +       payload[0] =3D (card->uhs2_config.maxblk_len_set << UHS2_DEV_CONF=
IG_MAX_BLK_LEN_POS) |
> +                    (card->uhs2_config.max_retry_set << UHS2_DEV_CONFIG_=
LT_SET_MAX_RETRY_POS) |
> +                    (card->uhs2_config.n_fcu_set << UHS2_DEV_CONFIG_N_FC=
U_POS);
> +       payload[1] =3D card->uhs2_config.n_data_gap_set;
> +       payload[0] =3D cpu_to_be32(payload[0]);
> +       payload[1] =3D cpu_to_be32(payload[1]);
> +
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_=
CFG_WRITE_PAYLOAD_LEN,
> +                            NULL, 0);
> +
> +       err =3D mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /*
> +        * Use Control Write CCMD to set Config Completion(payload bit 63=
) in Generic Setting
> +        * Register.
> +        * Header:
> +        *      - Control Write(R/W=3D1) with 8-Byte payload(PLEN=3D10b).
> +        *      - IOADR =3D PGeneric Setting Register(CFG_BASE + 008h)
> +        * Payload:
> +        *      - bit [63]: Config Completion
> +        *
> +        * DLSM transits to Active state immediately when Config Completi=
on is set to 1.
> +        */
> +       arg =3D ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +              UHS2_NATIVE_CMD_WRITE |
> +              UHS2_NATIVE_CMD_PLEN_8B |
> +              (UHS2_DEV_CONFIG_GEN_SET >> 8);
> +
> +       payload[0] =3D 0;
> +       payload[1] =3D UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
> +       payload[0] =3D cpu_to_be32(payload[0]);
> +       payload[1] =3D cpu_to_be32(payload[1]);
> +
> +       memset(resp, 0, sizeof(resp));
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_=
CFG_WRITE_PAYLOAD_LEN,
> +                            resp, UHS2_CFG_WRITE_GENERIC_SET_RESP_LEN);
> +
> +       err =3D mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /* Set host Config Setting registers */
> +       err =3D host->ops->uhs2_control(host, UHS2_SET_CONFIG);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 SET_CONFIG fail!\n", mmc_hostname(ho=
st), __func__);
> +               return err;
> +       }
> +
>         return 0;
>  }
>
> -/*
> - * Initialize the UHS-II card through the SD-TRAN transport layer. This =
enables
> - * commands/requests to be backwards compatible through the legacy SD pr=
otocol.
> - * UHS-II cards has a specific power limit specified for VDD1/VDD2, that=
 should
> - * be set through a legacy CMD6. Note that, the power limit that becomes=
 set,
> - * survives a soft reset through the GO_DORMANT_STATE command.
> - */
> -static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *c=
ard)
> +static int sd_uhs2_go_dormant(struct mmc_host *host, u32 node_id)
> +{
> +       struct mmc_command cmd =3D {0};
> +       struct uhs2_command uhs2_cmd =3D {};
> +       u16 header, arg;
> +       __be32 payload[1];
> +       int err;
> +
> +       /* Disable Normal INT */
> +       err =3D host->ops->uhs2_control(host, UHS2_DISABLE_INT);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 DISABLE_INT fail!\n",
> +                      mmc_hostname(host), __func__);
> +               return err;
> +       }
> +
> +       /*
> +        * Refer to UHS-II Addendum Version 1.02 Figure 6-17 to see GO_DO=
RMANT_STATE CCMD format.
> +        * Header:
> +        *      - Control Write(R/W=3D1) with 4-Byte payload(PLEN=3D01b).
> +        *      - IOADR =3D CMD_BASE + 001h
> +        * Payload:
> +        *      - bit [7]: HBR(Entry to Hibernate Mode)
> +        *                 1: Host intends to enter Hibernate mode during=
 Dormant state.
> +        *                 The default setting is 0 because hibernate is =
currently not supported.
> +        */
> +       header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
> +       arg =3D ((UHS2_DEV_CMD_GO_DORMANT_STATE & 0xFF) << 8) |
> +               UHS2_NATIVE_CMD_WRITE |
> +               UHS2_NATIVE_CMD_PLEN_4B |
> +               (UHS2_DEV_CMD_GO_DORMANT_STATE >> 8);
> +
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_=
GO_DORMANT_PAYLOAD_LEN,
> +                            NULL, 0);
> +
> +       err =3D mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /* Check Dormant State in Present */
> +       err =3D host->ops->uhs2_control(host, UHS2_CHECK_DORMANT);
> +       if (err)
> +               return err;
> +
> +       /* Disable UHS2 card clock */
> +       err =3D host->ops->uhs2_control(host, UHS2_DISABLE_CLK);
> +       if (err)
> +               return err;
> +
> +       /* Restore sd clock */
> +       mmc_delay(5);
> +       err =3D host->ops->uhs2_control(host, UHS2_ENABLE_CLK);
> +       if (err)
> +               return err;
> +
> +       /* Enable Normal INT */
> +       err =3D host->ops->uhs2_control(host, UHS2_ENABLE_INT);
> +       if (err)
> +               return err;
> +
> +       /* Detect UHS2 */
> +       err =3D host->ops->uhs2_control(host, UHS2_PHY_INIT);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
> +static int sd_uhs2_wait_active_state_cb(void *cb_data, bool *busy)
>  {
> +       struct sd_uhs2_wait_active_state_data *data =3D cb_data;
> +       struct mmc_host *host =3D data->host;
> +       struct mmc_command *cmd =3D data->cmd;
> +       int err;
> +
> +       err =3D mmc_wait_for_cmd(host, cmd, 0);
> +       if (err)
> +               return err;
> +
> +       if (cmd->resp[1] & UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE)
> +               *busy =3D false;
> +       else
> +               *busy =3D true;
> +
>         return 0;
>  }
>
> +static int sd_uhs2_go_dormant_state(struct mmc_host *host, u32 node_id)
> +{
> +       struct mmc_command cmd =3D {0};
> +       struct uhs2_command uhs2_cmd =3D {};
> +       u16 header, arg;
> +       int err;
> +       struct sd_uhs2_wait_active_state_data cb_data =3D {
> +               .host =3D host,
> +               .cmd =3D &cmd
> +       };
> +
> +       err =3D sd_uhs2_go_dormant(host, node_id);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail, err=3D 0x%x!\=
n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /*
> +        * Use Control Read CCMD to check Config Completion(bit 63) in Ge=
neric Setting Register.
> +        * - Control Read(R/W=3D0) with 8-Byte payload(PLEN=3D10b).
> +        * - IOADR =3D Generic Setting Register(CFG_BASE + 008h)
> +        *
> +        * When UHS-II card been switched to new speed mode, it will set =
Config Completion to 1.
> +        */
> +       header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
> +       arg =3D ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +               UHS2_NATIVE_CMD_READ |
> +               UHS2_NATIVE_CMD_PLEN_8B |
> +               (UHS2_DEV_CONFIG_GEN_SET >> 8);
> +
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL,=
 0);
> +       err =3D __mmc_poll_for_busy(host, UHS2_WAIT_CFG_COMPLETE_PERIOD_U=
S,
> +                                 UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS,
> +                                 &sd_uhs2_wait_active_state_cb, &cb_data=
);
> +       if (err) {
> +               pr_err("%s: %s: Not switch to Active in 100 ms\n", mmc_ho=
stname(host), __func__);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static void sd_uhs2_remove(struct mmc_host *host)
> +{
> +       mmc_remove_card(host->card);
> +       host->card =3D NULL;
> +}
> +
>  /*
>   * Allocate the data structure for the mmc_card and run the UHS-II speci=
fic
>   * initialization sequence.
>   */
> -static int sd_uhs2_init_card(struct mmc_host *host)
> +static int sd_uhs2_init_card(struct mmc_host *host, struct mmc_card *old=
card)
>  {
>         struct mmc_card *card;
>         u32 node_id;
> @@ -131,9 +832,14 @@ static int sd_uhs2_init_card(struct mmc_host *host)
>         if (err)
>                 return err;
>
> -       card =3D mmc_alloc_card(host, &sd_type);
> -       if (IS_ERR(card))
> -               return PTR_ERR(card);
> +       if (oldcard) {
> +               card =3D oldcard;
> +       } else {
> +               card =3D mmc_alloc_card(host, &sd_type);
> +               if (IS_ERR(card))
> +                       return PTR_ERR(card);
> +       }
> +       host->card =3D card;
>
>         card->uhs2_config.node_id =3D node_id;
>         card->type =3D MMC_TYPE_SD;
> @@ -146,18 +852,189 @@ static int sd_uhs2_init_card(struct mmc_host *host=
)
>         if (err)
>                 goto err;
>
> -       host->card =3D card;
> +       /* If change speed to Range B, need to GO_DORMANT_STATE */
> +       if (host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> +           host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD) {
> +               err =3D sd_uhs2_go_dormant_state(host, node_id);
> +               if (err)
> +                       goto err;
> +       }
> +
> +       host->uhs2_sd_tran =3D true;
> +
>         return 0;
>
>  err:
> -       mmc_remove_card(card);
> +       if (!oldcard)
> +               mmc_remove_card(card);
> +       else
> +               sd_uhs2_remove(host);
>         return err;
>  }
>
> -static void sd_uhs2_remove(struct mmc_host *host)
> +/*
> + * Initialize the UHS-II card through the SD-TRAN transport layer. This =
enables
> + * commands/requests to be backwards compatible through the legacy SD pr=
otocol.
> + * UHS-II cards has a specific power limit specified for VDD1/VDD2, that=
 should
> + * be set through a legacy CMD6. Note that, the power limit that becomes=
 set,
> + * survives a soft reset through the GO_DORMANT_STATE command.
> + */
> +static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *c=
ard)
>  {
> -       mmc_remove_card(host->card);
> -       host->card =3D NULL;
> +       int err;
> +       u32 cid[4];
> +       u32 ocr;
> +       u32 rocr;
> +       u8  *status;
> +       int ro;
> +
> +       /* Send CMD0 to reset SD card */
> +       err =3D __mmc_go_idle(host);
> +       if (err)
> +               return err;
> +
> +       mmc_delay(1);
> +
> +       /* Send CMD8 to communicate SD interface operation condition */
> +       err =3D mmc_send_if_cond(host, host->ocr_avail);
> +       if (err) {
> +               dev_warn(mmc_dev(host), "CMD8 error\n");
> +               goto err;
> +       }
> +
> +       /*
> +        * Probe SD card working voltage.
> +        */
> +       err =3D mmc_send_app_op_cond(host, 0, &ocr);
> +       if (err)
> +               goto err;
> +
> +       card->ocr =3D ocr;
> +
> +       /*
> +        * Some SD cards claims an out of spec VDD voltage range. Let's t=
reat
> +        * these bits as being in-valid and especially also bit7.
> +        */
> +       ocr &=3D ~0x7FFF;
> +       rocr =3D mmc_select_voltage(host, ocr);
> +       /*
> +        * Some cards have zero value of rocr in UHS-II mode. Assign host=
's
> +        * ocr value to rocr.
> +        */
> +       if (!rocr)
> +               rocr =3D host->ocr_avail;
> +
> +       rocr |=3D (SD_OCR_CCS | SD_OCR_XPC);
> +
> +       /* Wait SD power on ready */
> +       ocr =3D rocr;
> +
> +       err =3D mmc_send_app_op_cond(host, ocr, &rocr);
> +       if (err)
> +               goto err;
> +
> +       err =3D mmc_send_cid(host, cid);
> +       if (err)
> +               goto err;
> +
> +       memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
> +       mmc_decode_cid(card);
> +
> +       /*
> +        * For native busses:  get card RCA and quit open drain mode.
> +        */
> +       err =3D mmc_send_relative_addr(host, &card->rca);
> +       if (err)
> +               goto err;
> +
> +       err =3D mmc_sd_get_csd(card);
> +       if (err)
> +               goto err;
> +
> +       /*
> +        * Select card, as all following commands rely on that.
> +        */
> +       err =3D mmc_select_card(card);
> +       if (err)
> +               goto err;
> +
> +       /*
> +        * Fetch SCR from card.
> +        */
> +       err =3D mmc_app_send_scr(card);
> +       if (err)
> +               goto err;
> +
> +       err =3D mmc_decode_scr(card);
> +       if (err)
> +               goto err;
> +
> +       /*
> +        * Switch to high power consumption mode.
> +        * Even switch failed, sd card can still work at lower power cons=
umption mode, but
> +        * performance will be lower than high power consumption mode.
> +        */
> +       status =3D kmalloc(64, GFP_KERNEL);
> +       if (!status)
> +               return -ENOMEM;
> +
> +       if (!(card->csd.cmdclass & CCC_SWITCH)) {
> +               pr_warn("%s: card lacks mandatory switch function, perfor=
mance might suffer\n",
> +                       mmc_hostname(card->host));
> +       } else {
> +               /* send CMD6 to set Maximum Power Consumption to get bett=
er performance */
> +               err =3D mmc_sd_switch(card, 0, 3, SD4_SET_POWER_LIMIT_1_8=
0W, status);
> +               if (!err)
> +                       err =3D mmc_sd_switch(card, 1, 3, SD4_SET_POWER_L=
IMIT_1_80W, status);
> +
> +               err =3D 0;
> +       }
> +
> +       /*
> +        * Check if read-only switch is active.
> +        */
> +       ro =3D mmc_sd_get_ro(host);
> +       if (ro < 0) {
> +               pr_warn("%s: host does not support read-only switch, assu=
ming write-enable\n",
> +                       mmc_hostname(host));
> +       } else if (ro > 0) {
> +               mmc_card_set_readonly(card);
> +       }
> +
> +       /*
> +        * NOTE:
> +        * Should we read Externsion Register to check power notification=
 feature here?
> +        */
> +
> +       kfree(status);
> +
> +       return 0;
> +
> +err:
> +       sd_uhs2_remove(host);
> +       return err;
> +}
> +
> +int sd_uhs2_reinit(struct mmc_host *host)
> +{
> +       struct mmc_card *card =3D host->card;
> +       int err;
> +
> +       sd_uhs2_power_up(host);
> +       err =3D sd_uhs2_phy_init(host);
> +       if (err)
> +               return err;
> +
> +       err =3D sd_uhs2_init_card(host, card);
> +       if (err)
> +               return err;
> +
> +       err =3D sd_uhs2_legacy_init(host, card);
> +       if (err)
> +               return err;
> +
> +       mmc_card_set_present(card);
> +       return err;
>  }
>
>  static int sd_uhs2_alive(struct mmc_host *host)
> @@ -179,38 +1056,195 @@ static void sd_uhs2_detect(struct mmc_host *host)
>                 mmc_claim_host(host);
>                 mmc_detach_bus(host);
>                 sd_uhs2_power_off(host);
> +               /* Remove UHS2 timing to indicate the end of UHS2 mode */
> +               host->ios.timing =3D MMC_TIMING_LEGACY;
>                 mmc_release_host(host);
>         }
>  }
>
> +static int _sd_uhs2_suspend(struct mmc_host *host)
> +{
> +       struct mmc_card *card =3D host->card;
> +       int err =3D 0;
> +
> +       mmc_claim_host(host);
> +
> +       if (mmc_card_suspended(card))
> +               goto out;
> +
> +       if (mmc_sd_can_poweroff_notify(card))
> +               err =3D sd_poweroff_notify(card);
> +
> +       if (!err) {
> +               sd_uhs2_power_off(host);
> +               mmc_card_set_suspended(card);
> +       }
> +
> +out:
> +       mmc_release_host(host);
> +       return err;
> +}
> +
> +/*
> + * Callback for suspend
> + */
>  static int sd_uhs2_suspend(struct mmc_host *host)
>  {
> -       return 0;
> +       int err;
> +
> +       err =3D _sd_uhs2_suspend(host);
> +       if (!err) {
> +               pm_runtime_disable(&host->card->dev);
> +               pm_runtime_set_suspended(&host->card->dev);
> +       }
> +
> +       return err;
> +}
> +
> +/*
> + * This function tries to determine if the same card is still present
> + * and, if so, restore all state to it.
> + */
> +static int _mmc_sd_uhs2_resume(struct mmc_host *host)
> +{
> +       int err =3D 0;
> +
> +       mmc_claim_host(host);
> +
> +       if (!mmc_card_suspended(host->card))
> +               goto out;
> +
> +       /* Power up UHS2 SD card and re-initialize it. */
> +       err =3D sd_uhs2_reinit(host);
> +       mmc_card_clr_suspended(host->card);
> +
> +out:
> +       mmc_release_host(host);
> +       return err;
>  }
>
> +/*
> + * Callback for resume
> + */
>  static int sd_uhs2_resume(struct mmc_host *host)
>  {
> +       pm_runtime_enable(&host->card->dev);
>         return 0;
>  }
>
> +/*
> + * Callback for runtime_suspend.
> + */
>  static int sd_uhs2_runtime_suspend(struct mmc_host *host)
>  {
> -       return 0;
> +       int err;
> +
> +       if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
> +               return 0;
> +
> +       err =3D _sd_uhs2_suspend(host);
> +       if (err)
> +               pr_err("%s: error %d doing aggressive suspend\n", mmc_hos=
tname(host), err);
> +
> +       return err;
>  }
>
>  static int sd_uhs2_runtime_resume(struct mmc_host *host)
>  {
> -       return 0;
> +       int err;
> +
> +       err =3D _mmc_sd_uhs2_resume(host);
> +       if (err && err !=3D -ENOMEDIUM)
> +               pr_err("%s: error %d doing runtime resume\n", mmc_hostnam=
e(host), err);
> +
> +       return err;
>  }
>
> -static int sd_uhs2_shutdown(struct mmc_host *host)
> +static int sd_uhs2_hw_reset(struct mmc_host *host)
>  {
> -       return 0;
> +       int err;
> +
> +       sd_uhs2_power_off(host);
> +       /* Wait at least 1 ms according to SD spec */
> +       mmc_delay(1);
> +       sd_uhs2_power_up(host);
> +
> +       err =3D sd_uhs2_reinit(host);
> +
> +       return err;
>  }
>
> -static int sd_uhs2_hw_reset(struct mmc_host *host)
> +/*
> + * mmc_uhs2_prepare_cmd - prepare for SD command packet
> + * @host:      MMC host
> + * @mrq:       MMC request
> + *
> + * Initialize and fill in a header and a payload of SD command packet.
> + * The caller should allocate uhs2_command in host->cmd->uhs2_cmd in
> + * advance.
> + *
> + * Return:     0 on success, non-zero error on failure
> + */
> +void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq=
)
>  {
> -       return 0;
> +       struct mmc_command *cmd;
> +       struct uhs2_command *uhs2_cmd;
> +       u16 header, arg;
> +       __be32 *payload;
> +       u8 plen;
> +
> +       cmd =3D mrq->cmd;
> +       header =3D host->card->uhs2_config.node_id;
> +       if ((cmd->flags & MMC_CMD_MASK) =3D=3D MMC_CMD_ADTC)
> +               header |=3D UHS2_PACKET_TYPE_DCMD;
> +       else
> +               header |=3D UHS2_PACKET_TYPE_CCMD;
> +
> +       arg =3D cmd->opcode << UHS2_SD_CMD_INDEX_POS;
> +       if (host->uhs2_app_cmd) {
> +               arg |=3D UHS2_SD_CMD_APP;
> +               host->uhs2_app_cmd =3D false;
> +       }
> +
> +       /*
> +        * UHS-II Addendum 7.2.1.2
> +        * Host may set DM to 1 for DCMD which supports multi-block read/=
write regardless of
> +        * data transfer length (e.g., CMD18, CMD25). Otherwise, it shall=
 not set DM to 1.
> +        * (e.g., CMD6, CMD17, CMD24). These rules are also applied to ot=
her multi-block read/write
> +        * commands defined in other Part of SD specifications (for examp=
le, Host may set DM to 1
> +        * for ACMD18 or ACMD25).
> +        */
> +       if (mmc_op_multi(cmd->opcode))
> +               cmd->uhs2_cmd->tmode_half_duplex =3D mmc_card_uhs2_hd_mod=
e(host);
> +       else
> +               cmd->uhs2_cmd->tmode_half_duplex =3D 0;
> +
> +       uhs2_cmd =3D cmd->uhs2_cmd;
> +       payload =3D uhs2_cmd->payload;
> +       plen =3D 2; /* at the maximum */
> +
> +       if ((cmd->flags & MMC_CMD_MASK) =3D=3D MMC_CMD_ADTC &&
> +           cmd->uhs2_cmd->tmode_half_duplex) {
> +               if (mmc_card_uhs2_hd_mode(host))
> +                       arg |=3D UHS2_DCMD_2L_HD_MODE;
> +
> +               arg |=3D UHS2_DCMD_LM_TLEN_EXIST;
> +
> +               if (cmd->data->blocks =3D=3D 1 &&
> +                   cmd->data->blksz !=3D 512 &&
> +                   cmd->opcode !=3D MMC_READ_SINGLE_BLOCK &&
> +                   cmd->opcode !=3D MMC_WRITE_BLOCK) {
> +                       arg |=3D UHS2_DCMD_TLUM_BYTE_MODE;
> +                       payload[1] =3D cpu_to_be32(cmd->data->blksz);
> +               } else {
> +                       payload[1] =3D cpu_to_be32(cmd->data->blocks);
> +               }
> +       } else {
> +               plen =3D 1;
> +       }
> +
> +       payload[0] =3D cpu_to_be32(cmd->arg);
> +       sd_uhs2_cmd_assemble(cmd, uhs2_cmd, header, arg, payload, plen, N=
ULL, 0);
>  }
>
>  static const struct mmc_bus_ops sd_uhs2_ops =3D {
> @@ -221,7 +1255,7 @@ static const struct mmc_bus_ops sd_uhs2_ops =3D {
>         .resume =3D sd_uhs2_resume,
>         .runtime_suspend =3D sd_uhs2_runtime_suspend,
>         .runtime_resume =3D sd_uhs2_runtime_resume,
> -       .shutdown =3D sd_uhs2_shutdown,
> +       .shutdown =3D sd_uhs2_suspend,
>         .hw_reset =3D sd_uhs2_hw_reset,
>  };
>
> @@ -237,7 +1271,7 @@ static int sd_uhs2_attach(struct mmc_host *host)
>         if (err)
>                 goto err;
>
> -       err =3D sd_uhs2_init_card(host);
> +       err =3D sd_uhs2_init_card(host, NULL);
>         if (err)
>                 goto err;
>
> @@ -254,21 +1288,33 @@ static int sd_uhs2_attach(struct mmc_host *host)
>                 goto remove_card;
>
>         mmc_claim_host(host);
> +
>         return 0;
>
>  remove_card:
> -       mmc_remove_card(host->card);
> -       host->card =3D NULL;
> +       sd_uhs2_remove(host);
>         mmc_claim_host(host);
> -       mmc_detach_bus(host);
> +
>  err:
> +       mmc_detach_bus(host);
>         sd_uhs2_power_off(host);
> +       /* Remove UHS2 timing to indicate the end of UHS2 mode */
> +       host->ios.timing =3D MMC_TIMING_LEGACY;
>         return err;
>  }
>
> +/**
> + * mmc_attach_sd_uhs2 - select UHS2 interface
> + * @host: MMC host
> + *
> + * Try to select UHS2 interface and initialize the bus for a given
> + * frequency, @freq.
> + *
> + * Return:     0 on success, non-zero error on failure
> + */
>  int mmc_attach_sd_uhs2(struct mmc_host *host)
>  {
> -       int i, err =3D 0;
> +       int i, err;
>
>         if (!(host->caps2 & MMC_CAP2_SD_UHS2))
>                 return -EOPNOTSUPP;
> @@ -283,6 +1329,9 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
>          */
>         for (i =3D 0; i < ARRAY_SIZE(sd_uhs2_freqs); i++) {
>                 host->f_init =3D sd_uhs2_freqs[i];
> +               pr_debug("%s: %s: trying to init UHS-II card at %u Hz\n",
> +                        mmc_hostname(host), __func__, host->f_init);
> +
>                 err =3D sd_uhs2_attach(host);
>                 if (!err)
>                         break;
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 2c7928a50907..f30f6be86f66 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -23,6 +23,15 @@ enum mmc_blk_status {
>         MMC_BLK_NEW_REQUEST,
>  };
>
> +struct uhs2_command {
> +       u16     header;
> +       u16     arg;
> +       __be32  *payload;
> +       u32     payload_len;
> +       u32     packet_len;
> +       u8      tmode_half_duplex;
> +};
> +
>  struct mmc_command {
>         u32                     opcode;
>         u32                     arg;
> @@ -108,6 +117,10 @@ struct mmc_command {
>         unsigned int            busy_timeout;   /* busy detect timeout in=
 ms */
>         struct mmc_data         *data;          /* data segment associate=
d with cmd */
>         struct mmc_request      *mrq;           /* associated request */
> +
> +       struct uhs2_command     *uhs2_cmd;      /* UHS2 command */
> +       u8                      *uhs2_resp;     /* UHS2 native cmd resp *=
/
> +       u8                      uhs2_resp_len;  /* UHS2 native cmd resp l=
en */
>  };
>
>  struct mmc_data {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 68e78c65cf1c..899bb5d247d3 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -126,6 +126,13 @@ struct sd_uhs2_caps {
>  };
>
>  enum sd_uhs2_operation {
> +       UHS2_PHY_INIT =3D 0,
> +       UHS2_SET_CONFIG,
> +       UHS2_ENABLE_INT,
> +       UHS2_DISABLE_INT,
> +       UHS2_ENABLE_CLK,
> +       UHS2_DISABLE_CLK,
> +       UHS2_CHECK_DORMANT,
>         UHS2_SET_IOS,
>  };
>
> @@ -476,6 +483,8 @@ struct mmc_host {
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that ha=
s GPT entry at a non-standard location */
>
> +       bool                    uhs2_sd_tran;
> +       bool                    uhs2_app_cmd;   /* Host UHS-II APP Comman=
d */
>         struct sd_uhs2_caps     uhs2_caps;      /* Host UHS-II capabiliti=
es */
>
>         int                     fixed_drv_type; /* fixed driver type for =
non-removable media */
> @@ -737,6 +746,12 @@ static inline void mmc_debugfs_err_stats_inc(struct =
mmc_host *host,
>         host->err_stats[stat] +=3D 1;
>  }
>
> +static inline int mmc_card_uhs2_hd_mode(struct mmc_host *host)
> +{
> +       return host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A_HD ||
> +              host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD;
> +}
> +
>  int mmc_sd_switch(struct mmc_card *card, int mode, int group, u8 value, =
u8 *resp);
>  int mmc_send_status(struct mmc_card *card, u32 *status);
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
> --
> 2.25.1
>

