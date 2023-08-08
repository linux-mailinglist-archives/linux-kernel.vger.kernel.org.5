Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2947740A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHHRHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHHRGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:06:34 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597105F861
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:02:44 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-79aa01cc971so2176662241.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510523; x=1692115323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0It1tkSwsEURQ4T/DiymDBeWiMUa1upzyDAUi/yKAc8=;
        b=o6vKbpTh/ILkqQ7BDqAyY1T0wV9+vx61JIvWFmatltAmeQDehHM63PaTBIpfWyMs7i
         my0JcneI+yCuJUuDBkInUHI6cTVxIwACVTmJ3o5hX7zWiRI/fWlkXEt2i7HVo5g2q4Oc
         G1WjbbgBBuiKnheDGEoKWxX8JcswlofKdFTMx+kZlW7QHY5duQk4d3ARkjtsmSp+BMMC
         OUC1ZyzksqtuItbwiL9e5D2nKf+0GiEEcbKrNl2buMlwyQc6rybFw/2Wln6DmcpIVfgI
         z0EkfgVxHjtV/en0o+QSeVN89EFZ0BPK5CGNvj1ef7tga/H/BMIOWCfSaSMDJjXGqwD8
         sOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510523; x=1692115323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0It1tkSwsEURQ4T/DiymDBeWiMUa1upzyDAUi/yKAc8=;
        b=QZ0yBDNpQDRTx9KkZNQX9GFaQ9Ya/dbiq+Dvl8XZWsRdXcn/CMuXl2N6jP0Ag8+fWV
         MAMQWa5tfFcVAAg1u+6y/l7ApL0aIC4VgcaOZkGA9/qTTHHXNbCwvqgmjoo2JU9DSJc5
         xp899GzRnSsX53ULnPb4KpAPYCXhyRiIKR13diEHjHjrEEkUsvG7fRP3CLNAyqeKFOL/
         7gyPsdGhd++Z778jMi28nRi9r85tfo8HmDbtD5hwqVgalHECK/NJbGy30lvGtMRswSUr
         PSAuw1t/zfhscwCS6SYJatmk8A1uVRwx14Nkyn9XzDoVei0CHaXCaixCVL2asYy8o68C
         rx8w==
X-Gm-Message-State: AOJu0Yzv2XJx0HiSFdxd4ueVp7XQh401JdquE2lwstm2awH8EpQFJSU3
        F2ptqDA5IcTFZnqGsEzA0z7O+H7+OcPob6xu8exXnQBi4cxAs5Ff
X-Google-Smtp-Source: AGHT+IEV1blOow0o15QXlg2tqzXmWeY3ywys2EgBR31ZeMxeskv6bdOHnlu9HfuF0B38SAzxSLfktx2eCgxabacOXMU=
X-Received: by 2002:a25:ad1c:0:b0:d10:d237:b03d with SMTP id
 y28-20020a25ad1c000000b00d10d237b03dmr11562146ybi.53.1691490163885; Tue, 08
 Aug 2023 03:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com> <20230721101349.12387-3-victorshihgli@gmail.com>
In-Reply-To: <20230721101349.12387-3-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:22:07 +0200
Message-ID: <CAPDyKFq_bxP=SVLEWnGAjKVUp8G5xfkLEVt14V9odXXfj0M0Aw@mail.gmail.com>
Subject: Re: [PATCH V9 02/23] mmc: core: Prepare to support SD UHS-II cards
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 at 12:14, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>

As I have said earlier, please don't claim authorship of patches that
you haven't autherd.

Of course, if you have made major modifications to a patch, then you
may do so, but that is certainly not the case here.

>
> Update in previous version:

Please drop the above from the commit message.

> The SD UHS-II interface was introduced to the SD spec v4.00 several years
> ago. The interface is fundamentally different from an electrical and a
> protocol point of view, comparing to the legacy SD interface.
>
> However, the legacy SD protocol is supported through a specific transport
> layer (SD-TRAN) defined in the UHS-II addendum of the spec. This allows the
> SD card to be managed in a very similar way as a legacy SD card, hence a
> lot of code can be re-used to support these new types of cards through the
> mmc subsystem.
>
> Moreover, an SD card that supports the UHS-II interface shall also be
> backwards compatible with the legacy SD interface, which allows a UHS-II
> card to be inserted into a legacy slot. As a matter of fact, this is
> already supported by mmc subsystem as of today.
>
> To prepare to add support for UHS-II, this change puts the basic foundation
> in the mmc core in place, allowing it to be more easily reviewed before
> subsequent changes implements the actual support.
>
> Basically, the approach here adds a new UHS-II bus_ops type and adds a
> separate initialization path for the UHS-II card. The intent is to avoid us
> from sprinkling the legacy initialization path, but also to simplify
> implementation of the UHS-II specific bits.
>
> At this point, there is only one new host ops added to manage the various
> ios settings needed for UHS-II. Additional host ops that are needed, are
> being added from subsequent changes.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>
> Updates in V9:
>  - move sd_uhs2_operation definition of PatchV8[05/23] to
>    PatchV9[02/23] for avoid compilation errors.
>  - move uhs2_control definition of PatchV8[05/23] to
>    PatchV9[02/23] for avoid compilation errors.
>  - move mmc_host flags definition of PatchV8[05/23] to
>    PatchV9[02/23] for avoid compilation errors.
>  - move mmc_host flags MMC_UHS2_SUPPORT definition of PatchV8[05/23] to
>    PatchV9[02/23] for avoid compilation errors.
>  - move mmc_host flags MMC_UHS2_SD_TRAN definition of PatchV8[05/23] to
>    PatchV9[02/23] for avoid compilation errors.
>
> Updates in V7:
>  - Drop sd_uhs2_set_ios function.
>  - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_up().
>  - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_off().
>  - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A.
>  - Modify sd_uhs2_legacy_init to avoid sd_uhs2_reinit cycle issue.
>
> Updates in V4:
>  - Re-based, updated a comment and removed white-space.
>  - Moved MMC_VQMMC2_VOLTAGE_180 into a later patch in the series.
>
> ---
>
>  drivers/mmc/core/Makefile  |   2 +-
>  drivers/mmc/core/core.c    |  17 ++-
>  drivers/mmc/core/core.h    |   1 +
>  drivers/mmc/core/sd_uhs2.c | 294 +++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/card.h   |   7 +
>  include/linux/mmc/host.h   |  45 ++++++
>  6 files changed, 364 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mmc/core/sd_uhs2.c
>
> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
> index 6a907736cd7a..15b067e8b0d1 100644
> --- a/drivers/mmc/core/Makefile
> +++ b/drivers/mmc/core/Makefile
> @@ -7,7 +7,7 @@ obj-$(CONFIG_MMC)               += mmc_core.o
>  mmc_core-y                     := core.o bus.o host.o \
>                                    mmc.o mmc_ops.o sd.o sd_ops.o \
>                                    sdio.o sdio_ops.o sdio_bus.o \
> -                                  sdio_cis.o sdio_io.o sdio_irq.o \
> +                                  sdio_cis.o sdio_io.o sdio_irq.o sd_uhs2.o\
>                                    slot-gpio.o regulator.o
>  mmc_core-$(CONFIG_OF)          += pwrseq.o
>  obj-$(CONFIG_PWRSEQ_SIMPLE)    += pwrseq_simple.o
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 3d3e0ca52614..ba8808cd9318 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2244,6 +2244,18 @@ void mmc_rescan(struct work_struct *work)
>                 goto out;
>         }
>
> +       /*
> +        * Ideally we should favor initialization of legacy SD cards and defer
> +        * UHS-II enumeration. However, it seems like cards doesn't reliably
> +        * announce their support for UHS-II in the response to the ACMD41,
> +        * while initializing the legacy SD interface. Therefore, let's start
> +        * with UHS-II for now.
> +        */
> +       if (!mmc_attach_sd_uhs2(host)) {
> +               mmc_release_host(host);
> +               goto out;
> +       }
> +
>         for (i = 0; i < ARRAY_SIZE(freqs); i++) {
>                 unsigned int freq = freqs[i];
>                 if (freq > host->f_max) {
> @@ -2276,10 +2288,13 @@ void mmc_rescan(struct work_struct *work)
>
>  void mmc_start_host(struct mmc_host *host)
>  {
> +       bool power_up = !(host->caps2 &
> +                        (MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_SD_UHS2));
> +
>         host->f_init = max(min(freqs[0], host->f_max), host->f_min);
>         host->rescan_disable = 0;
>
> -       if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
> +       if (power_up) {
>                 mmc_claim_host(host);
>                 mmc_power_up(host, host->ocr_avail);
>                 mmc_release_host(host);
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 37091a6589ed..920323faa834 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -81,6 +81,7 @@ int mmc_detect_card_removed(struct mmc_host *host);
>  int mmc_attach_mmc(struct mmc_host *host);
>  int mmc_attach_sd(struct mmc_host *host);
>  int mmc_attach_sdio(struct mmc_host *host);
> +int mmc_attach_sd_uhs2(struct mmc_host *host);
>
>  /* Module parameters */
>  extern bool use_spi_crc;
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> new file mode 100644
> index 000000000000..06b2aab52b93
> --- /dev/null
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 Linaro Ltd
> + *
> + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> + *
> + * Support for SD UHS-II cards
> + */
> +#include <linux/err.h>
> +
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
> +
> +#include "core.h"
> +#include "bus.h"
> +#include "sd.h"
> +#include "mmc_ops.h"
> +
> +static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
> +
> +static int sd_uhs2_power_up(struct mmc_host *host)
> +{
> +       int err;
> +
> +       if (host->ios.power_mode == MMC_POWER_ON)
> +               return 0;
> +
> +       host->ios.vdd = fls(host->ocr_avail) - 1;
> +       host->ios.clock = host->f_init;
> +       host->ios.timing = MMC_TIMING_UHS2_SPEED_A;
> +       host->ios.power_mode = MMC_POWER_ON;
> +
> +       err = host->ops->uhs2_control(host, UHS2_SET_IOS);
> +
> +       return err;
> +}
> +
> +static int sd_uhs2_power_off(struct mmc_host *host)
> +{
> +       if (host->ios.power_mode == MMC_POWER_OFF)
> +               return 0;
> +
> +       host->ios.vdd = 0;
> +       host->ios.clock = 0;
> +       host->ios.timing = MMC_TIMING_LEGACY;
> +       host->ios.power_mode = MMC_POWER_OFF;
> +       if (host->flags & MMC_UHS2_SD_TRAN)
> +               host->flags &= ~MMC_UHS2_SD_TRAN;

Let's not add this as part of $subject patch, but rather from the
patch that implements the support for SD tran.

Moreover, I am not so fond of the name "host->flags" as it is simply
too generic, but let's discuss this in the next version.

> +
> +       return host->ops->uhs2_control(host, UHS2_SET_IOS);
> +}
> +
> +/*
> + * Run the phy initialization sequence, which mainly relies on the UHS-II host
> + * to check that we reach the expected electrical state, between the host and
> + * the card.
> + */
> +static int sd_uhs2_phy_init(struct mmc_host *host)
> +{
> +       return 0;
> +}
> +
> +/*
> + * Do the early initialization of the card, by sending the device init broadcast
> + * command and wait for the process to be completed.
> + */
> +static int sd_uhs2_dev_init(struct mmc_host *host)
> +{
> +       return 0;
> +}
> +
> +/*
> + * Run the enumeration process by sending the enumerate command to the card.
> + * Note that, we currently support only the point to point connection, which
> + * means only one card can be attached per host/slot.
> + */
> +static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
> +{
> +       return 0;
> +}
> +
> +/*
> + * Read the UHS-II configuration registers (CFG_REG) of the card, by sending it
> + * commands and by parsing the responses. Store a copy of the relevant data in
> + * card->uhs2_config.
> + */
> +static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
> +{
> +       return 0;
> +}
> +
> +/*
> + * Based on the card's and host's UHS-II capabilities, let's update the
> + * configuration of the card and the host. This may also include to move to a
> + * greater speed range/mode. Depending on the updated configuration, we may need
> + * to do a soft reset of the card via sending it a GO_DORMANT_STATE command.
> + *
> + * In the final step, let's check if the card signals "config completion", which
> + * indicates that the card has moved from config state into active state.
> + */
> +static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
> +{
> +       return 0;
> +}
> +
> +/*
> + * Initialize the UHS-II card through the SD-TRAN transport layer. This enables
> + * commands/requests to be backwards compatible through the legacy SD protocol.
> + * UHS-II cards has a specific power limit specified for VDD1/VDD2, that should
> + * be set through a legacy CMD6. Note that, the power limit that becomes set,
> + * survives a soft reset through the GO_DORMANT_STATE command.
> + */
> +static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)
> +{
> +       return 0;
> +}
> +
> +/*
> + * Allocate the data structure for the mmc_card and run the UHS-II specific
> + * initialization sequence.
> + */
> +static int sd_uhs2_init_card(struct mmc_host *host)
> +{
> +       struct mmc_card *card;
> +       u32 node_id;
> +       int err;
> +
> +       err = sd_uhs2_dev_init(host);
> +       if (err)
> +               return err;
> +
> +       err = sd_uhs2_enum(host, &node_id);
> +       if (err)
> +               return err;
> +
> +       card = mmc_alloc_card(host, &sd_type);
> +       if (IS_ERR(card))
> +               return PTR_ERR(card);
> +
> +       card->uhs2_config.node_id = node_id;
> +       card->type = MMC_TYPE_SD;
> +
> +       err = sd_uhs2_config_read(host, card);
> +       if (err)
> +               goto err;
> +
> +       err = sd_uhs2_config_write(host, card);
> +       if (err)
> +               goto err;
> +
> +       host->card = card;
> +       return 0;
> +
> +err:
> +       mmc_remove_card(card);
> +       return err;
> +}
> +
> +static void sd_uhs2_remove(struct mmc_host *host)
> +{
> +       mmc_remove_card(host->card);
> +       host->card = NULL;
> +}
> +
> +static int sd_uhs2_alive(struct mmc_host *host)
> +{
> +       return mmc_send_status(host->card, NULL);
> +}
> +
> +static void sd_uhs2_detect(struct mmc_host *host)
> +{
> +       int err;
> +
> +       mmc_get_card(host->card, NULL);
> +       err = _mmc_detect_card_removed(host);
> +       mmc_put_card(host->card, NULL);
> +
> +       if (err) {
> +               sd_uhs2_remove(host);
> +
> +               mmc_claim_host(host);
> +               mmc_detach_bus(host);
> +               sd_uhs2_power_off(host);
> +               mmc_release_host(host);
> +       }
> +}
> +
> +static int sd_uhs2_suspend(struct mmc_host *host)
> +{
> +       return 0;
> +}
> +
> +static int sd_uhs2_resume(struct mmc_host *host)
> +{
> +       return 0;
> +}
> +
> +static int sd_uhs2_runtime_suspend(struct mmc_host *host)
> +{
> +       return 0;
> +}
> +
> +static int sd_uhs2_runtime_resume(struct mmc_host *host)
> +{
> +       return 0;
> +}
> +
> +static int sd_uhs2_shutdown(struct mmc_host *host)
> +{
> +       return 0;
> +}
> +
> +static int sd_uhs2_hw_reset(struct mmc_host *host)
> +{
> +       return 0;
> +}
> +
> +static const struct mmc_bus_ops sd_uhs2_ops = {
> +       .remove = sd_uhs2_remove,
> +       .alive = sd_uhs2_alive,
> +       .detect = sd_uhs2_detect,
> +       .suspend = sd_uhs2_suspend,
> +       .resume = sd_uhs2_resume,
> +       .runtime_suspend = sd_uhs2_runtime_suspend,
> +       .runtime_resume = sd_uhs2_runtime_resume,
> +       .shutdown = sd_uhs2_shutdown,
> +       .hw_reset = sd_uhs2_hw_reset,
> +};
> +
> +static int sd_uhs2_attach(struct mmc_host *host)
> +{
> +       int err;
> +
> +       err = sd_uhs2_power_up(host);
> +       if (err)
> +               goto err;
> +
> +       err = sd_uhs2_phy_init(host);
> +       if (err)
> +               goto err;
> +
> +       err = sd_uhs2_init_card(host);
> +       if (err)
> +               goto err;
> +
> +       err = sd_uhs2_legacy_init(host, host->card);
> +       if (err)
> +               goto err;
> +
> +       mmc_attach_bus(host, &sd_uhs2_ops);
> +
> +       mmc_release_host(host);
> +
> +       err = mmc_add_card(host->card);
> +       if (err)
> +               goto remove_card;
> +
> +       mmc_claim_host(host);
> +       return 0;
> +
> +remove_card:
> +       mmc_remove_card(host->card);
> +       host->card = NULL;
> +       mmc_claim_host(host);
> +       mmc_detach_bus(host);
> +err:
> +       sd_uhs2_power_off(host);
> +       return err;
> +}
> +
> +int mmc_attach_sd_uhs2(struct mmc_host *host)
> +{
> +       int i, err = 0;
> +
> +       if (!(host->caps2 & MMC_CAP2_SD_UHS2))
> +               return -EOPNOTSUPP;
> +
> +       /* Turn off the legacy SD interface before trying with UHS-II. */
> +       mmc_power_off(host);
> +
> +       /*
> +        * Start UHS-II initialization at 52MHz and possibly make a retry at
> +        * 26MHz according to the spec. It's required that the host driver
> +        * validates ios->clock, to set a rate within the correct range.
> +        */
> +       for (i = 0; i < ARRAY_SIZE(sd_uhs2_freqs); i++) {
> +               host->f_init = sd_uhs2_freqs[i];
> +               err = sd_uhs2_attach(host);
> +               if (!err)
> +                       break;
> +       }
> +
> +       return err;
> +}
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index daa2f40d9ce6..469fd68f854f 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -211,6 +211,11 @@ struct sd_ext_reg {
>  #define SD_EXT_PERF_CMD_QUEUE  (1<<4)
>  };
>
> +struct sd_uhs2_config {
> +       u32                     node_id;
> +       /* TODO: Extend with more register configs. */
> +};
> +
>  struct sdio_cccr {
>         unsigned int            sdio_vsn;
>         unsigned int            sd_vsn;
> @@ -318,6 +323,8 @@ struct mmc_card {
>         struct sd_ext_reg       ext_power;      /* SD extension reg for PM */
>         struct sd_ext_reg       ext_perf;       /* SD extension reg for PERF */
>
> +       struct sd_uhs2_config   uhs2_config;    /* SD UHS-II config */
> +
>         unsigned int            sdio_funcs;     /* number of SDIO functions */
>         atomic_t                sdio_funcs_probed; /* number of probed SDIO funcs */
>         struct sdio_cccr        cccr;           /* common card info */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 461d1543893b..2e3748e4f14d 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -63,6 +63,10 @@ struct mmc_ios {
>  #define MMC_TIMING_MMC_HS400   10
>  #define MMC_TIMING_SD_EXP      11
>  #define MMC_TIMING_SD_EXP_1_2V 12
> +#define MMC_TIMING_UHS2_SPEED_A    13
> +#define MMC_TIMING_UHS2_SPEED_A_HD 14
> +#define MMC_TIMING_UHS2_SPEED_B    15
> +#define MMC_TIMING_UHS2_SPEED_B_HD 16
>
>         unsigned char   signal_voltage;         /* signalling voltage (1.8V or 3.3V) */
>
> @@ -91,6 +95,21 @@ struct mmc_clk_phase_map {
>         struct mmc_clk_phase phase[MMC_NUM_CLK_PHASES];
>  };
>
> +struct sd_uhs2_caps {
> +       /* TODO: Add UHS-II capabilities for the host. */
> +};
> +
> +enum sd_uhs2_operation {
> +       UHS2_PHY_INIT = 0,
> +       UHS2_SET_CONFIG,
> +       UHS2_ENABLE_INT,
> +       UHS2_DISABLE_INT,
> +       UHS2_ENABLE_CLK,
> +       UHS2_DISABLE_CLK,
> +       UHS2_CHECK_DORMANT,

Looks like the above is better added in the next couple of patches,
where these actually become used.

> +       UHS2_SET_IOS,
> +};
> +
>  struct mmc_host;
>
>  enum mmc_err_stat {
> @@ -145,6 +164,17 @@ struct mmc_host_ops {
>          */
>         void    (*set_ios)(struct mmc_host *host, struct mmc_ios *ios);
>
> +       /*
> +        * The uhs2_set_ios callback is mandatory to implement for hosts that
> +        * supports the SD UHS-II interface (MMC_CAP2_SD_UHS2), while the
> +        * callback is unused for the other cases. Note that, the struct
> +        * mmc_ios is being re-used for this as well.
> +        *
> +        * Expected return values for the uhs2_set_ios callback are a negative
> +        * errno in case of a failure or zero for success.
> +        */
> +       int     (*uhs2_set_ios)(struct mmc_host *host, struct mmc_ios *ios);
> +

This isn't used, please drop it.

>         /*
>          * Return values for the get_ro callback should be:
>          *   0 for a read/write card
> @@ -212,6 +242,14 @@ struct mmc_host_ops {
>
>         /* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
>         int     (*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
> +
> +       /*
> +        * The uhs2_control callback is used to execute SD UHS-II specific
> +        * operations. It's mandatory to implement for hosts that supports the
> +        * SD UHS-II interface (MMC_CAP2_SD_UHS2). Expected return values are a
> +        * negative errno in case of a failure or zero for success.
> +        */
> +       int     (*uhs2_control)(struct mmc_host *host, enum sd_uhs2_operation op);
>  };
>
>  struct mmc_cqe_ops {
> @@ -396,6 +434,7 @@ struct mmc_host {
>                                  MMC_CAP2_HS200_1_2V_SDR)
>  #define MMC_CAP2_SD_EXP                (1 << 7)        /* SD express via PCIe */
>  #define MMC_CAP2_SD_EXP_1_2V   (1 << 8)        /* SD express 1.2V */
> +#define MMC_CAP2_SD_UHS2       (1 << 9)        /* SD UHS-II support */
>  #define MMC_CAP2_CD_ACTIVE_HIGH        (1 << 10)       /* Card-detect signal active high */
>  #define MMC_CAP2_RO_ACTIVE_HIGH        (1 << 11)       /* Write-protect signal active high */
>  #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)  /* Don't power up before scan */
> @@ -422,6 +461,12 @@ struct mmc_host {
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that has GPT entry at a non-standard location */
>
> +       struct sd_uhs2_caps     uhs2_caps;      /* Host UHS-II capabilities */
> +
> +       int flags;
> +#define MMC_UHS2_SUPPORT (1 << 0)
> +#define MMC_UHS2_SD_TRAN (1 << 1)

As I said above, please drop this from the $subject patch and move it
to the patch that implements SD tran.

> +
>         int                     fixed_drv_type; /* fixed driver type for non-removable media */
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm features */

Kind regards
Uffe
