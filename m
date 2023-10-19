Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FA37CFD7E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346204AbjJSPBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346206AbjJSPBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:01:11 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069D121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:01:08 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d865854ef96so9109299276.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697727667; x=1698332467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eOey+2KsoRv3Cbtz6P0LcLeSwTcUQ7Xt1JsnXF1/Vww=;
        b=b0lUURBy1R1NLbpGIN648o+bAw61P5nnewD3IRqK5KZ3/rEvYww4w6+VVUbkfF7N/u
         2FMlPgKs1DAcg15rWfQEPBV+OU5jtozMIrwInP/lZgB77fbyeOZkAHkRns7og+9Mc5Fo
         t4zfpdMEUjKykSU7T2lDuqUkQENEihfuWNRr3wsxz8uyaQT7wpxlh1qlJkXss/ocoX9x
         nCU+jTe4/4dZRPVojug7V4/MlhzJzVBI+tO6MKI8cnlwEoROFkTd1bUq4nXFZNmyUT+P
         q5ZtX9OnWAfK6VF9eHjin15sZ4OiQnb7X80NpRXh/N4tcBT6udZkfnko4OcPT35Sr5zx
         B5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697727667; x=1698332467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOey+2KsoRv3Cbtz6P0LcLeSwTcUQ7Xt1JsnXF1/Vww=;
        b=IR34tXt96iORDzUzWPrdUGBN8X0E+5AbEvu+UhVBMaYVckaEiJbZDOgyj59tRBRHnG
         zgOzzp/OrHBKfdZxaTzyyx/DqV514ZuNtZFUCrpHFjJiyvkvP7UrjzDebxjd3zAO1VHg
         1FU68XlQ4ZretjJ7tyJTYIQa+x0QKythjYXca91ZL9V4ek61z+r/BGYGS5M5anBFGUbB
         F8vTZBvUWyLR7Y32EeWCBomjdf2nFXwZEN5jMox1p54W6lcbqPS4rl8OWxx7wJBuww3g
         A1eBBa/67/izVuOFVHiuyJkE49YVozZRj/YUFG2F2EWcwJimZAm9w+u3XEvgU6gmAIlS
         Majw==
X-Gm-Message-State: AOJu0Yzj/BRuwM0PHqZGmOtY2LgtjpcW30QIk3AUqVYxS3PIai4PKICU
        xdG+8fnPUnLotELDc1oIhfEjBJy0bRqxuV/ioWBoew==
X-Google-Smtp-Source: AGHT+IFGteHEULRWiaWhQ4PBV50uPj7JRswpRnHQDgYtfg5pASIlIapoWS1+ZzlDMQo5JjykvQzLfebBPd3xDVancfI=
X-Received: by 2002:a25:238a:0:b0:d9a:be79:c902 with SMTP id
 j132-20020a25238a000000b00d9abe79c902mr2759395ybj.53.1697727667120; Thu, 19
 Oct 2023 08:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231019054612.9192-1-quic_sartgarg@quicinc.com> <20231019054612.9192-2-quic_sartgarg@quicinc.com>
In-Reply-To: <20231019054612.9192-2-quic_sartgarg@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Oct 2023 17:00:30 +0200
Message-ID: <CAPDyKFofS16AsQeTVNiDi_PHUatGoQ3no-1+Azo+yqG0SPTe4Q@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] mmc: core: Add partial initialization support
To:     Sarthak Garg <quic_sartgarg@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com,
        kernel@quicinc.com,
        Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 07:46, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>
> Add the ability to partially initialize the MMC device by
> using device sleep/awake sequence (CMD5).
> Device will be sent to sleep state during mmc runtime/system suspend
> and will be woken up during mmc runtime/system resume.
> By using this sequence the device doesn't need full initialization
> which gives 25% time reduction in system/runtime resume path.
>
> 1) Micron eMMC (ManfID 0x13)
>
> Partial init                            Full Init
>
> a) _mmc_resume:                         _mmc_resume :
>
> Total time : 62ms                       Total time : 84ms
> (Improvement % from full init = ~26%)
>
> 2) Kingston eMMC (ManfID 0x70)
>
> Partial init                            Full Init
>
> a) _mmc_resume:                 _mmc_resume :
> Total time : 46ms                       Total time : 62ms
> (Improvement % from full init = ~25%).
>
> Co-developed-by: Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>
> Signed-off-by: Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> ---
>  drivers/mmc/core/mmc.c   | 163 ++++++++++++++++++++++++++++++++++++---
>  include/linux/mmc/card.h |   4 +
>  include/linux/mmc/host.h |   2 +
>  3 files changed, 160 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 8180983bd402..fb33bcf6d360 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1956,7 +1956,28 @@ static int mmc_sleep_busy_cb(void *cb_data, bool *busy)
>         return 0;
>  }
>
> -static int mmc_sleep(struct mmc_host *host)
> +/*
> + * Returns true if card supports sleep/awake command and host can simply do
> + * sleep/awake instead of full card initialization as part of resume.
> + */
> +static inline int mmc_can_sleepawake(struct mmc_host *host)

Nitpick: Please rename to mmc_can_sleep_awake() to make the name more clear.

> +{
> +       return mmc_can_sleep(host->card) && (host->caps2 & MMC_CAP2_SLEEP_AWAKE);
> +}
> +
> +/**
> + * mmc_sleepawake - function to sleep or awake the device
> + * @host: MMC host
> + * @sleep: if true then sleep command is sent else awake
> + *
> + * This function first deselects the card and then sends the sleep command
> + * in case of sleep whereas in case of awake first awake command is send
> + * and then the card is selected.
> + *
> + * Returns 0 on success, non-zero value on failure
> + */
> +
> +static int mmc_sleepawake(struct mmc_host *host, bool sleep)

Nitpick: Please rename into mmc_sleep_awake()

>  {
>         struct mmc_command cmd = {};
>         struct mmc_card *card = host->card;
> @@ -1967,14 +1988,17 @@ static int mmc_sleep(struct mmc_host *host)
>         /* Re-tuning can't be done once the card is deselected */
>         mmc_retune_hold(host);
>
> -       err = mmc_deselect_cards(host);
> -       if (err)
> -               goto out_release;
> +       if (sleep) {
> +               err = mmc_deselect_cards(host);
> +               if (err)
> +                       goto out_release;
> +       }
>
>         cmd.opcode = MMC_SLEEP_AWAKE;
>         cmd.arg = card->rca << 16;
> -       cmd.arg |= 1 << 15;
>         use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
> +       if (sleep)
> +               cmd.arg |= BIT(15);

Please move this above the call to mmc_prepare_busy_cmd(). For consistency.

>
>         err = mmc_wait_for_cmd(host, &cmd, 0);
>         if (err)
> @@ -1997,6 +2021,9 @@ static int mmc_sleep(struct mmc_host *host)
>         err = __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_sleep_busy_cb, host);
>
>  out_release:
> +       if (!sleep)
> +               err = mmc_select_card(card);
> +
>         mmc_retune_release(host);
>         return err;
>  }
> @@ -2094,6 +2121,73 @@ static int _mmc_flush_cache(struct mmc_host *host)
>                         pr_err("%s: cache flush error %d\n",
>                                mmc_hostname(host), err);
>         }
> +       return err;
> +}
> +
> +/*
> + * Save read/write fields of ext_csd register that the sw changes
> + * as part of suspend.
> + */
> +static int mmc_save_card_ext_csd(struct mmc_host *host)
> +{
> +       int err;
> +       u8 *ext_csd;
> +       struct mmc_card *card = host->card;
> +
> +       err = mmc_get_ext_csd(card, &ext_csd);
> +       if (err || !ext_csd) {
> +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
> +                       mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       card->ext_csd.raw_ext_csd_cmdq = ext_csd[EXT_CSD_CMDQ_MODE_EN];
> +       card->ext_csd.raw_ext_csd_cache_ctrl = ext_csd[EXT_CSD_CACHE_CTRL];
> +       card->ext_csd.raw_ext_csd_bus_width = ext_csd[EXT_CSD_BUS_WIDTH];
> +       card->ext_csd.raw_ext_csd_hs_timing = ext_csd[EXT_CSD_HS_TIMING];
> +
> +       kfree(ext_csd);
> +
> +       return 0;
> +}
> +
> +/*
> + * Get the ext_csd register from the card post resume and compare with
> + * read/write fields of ext_csd register that the sw changes.
> + */
> +static int mmc_test_awake_ext_csd(struct mmc_host *host)
> +{
> +       struct mmc_card *card = host->card;
> +       u8 *ext_csd;
> +       int err;
> +
> +       err = mmc_get_ext_csd(card, &ext_csd);
> +       if (err) {
> +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
> +                       mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       pr_debug("%s: %s: type(cached:current) cmdq(%d:%d) cache_ctrl(%d:%d) bus_width (%d:%d) timing(%d:%d)\n",
> +               mmc_hostname(host), __func__,
> +               card->ext_csd.raw_ext_csd_cmdq,
> +               ext_csd[EXT_CSD_CMDQ_MODE_EN],
> +               card->ext_csd.raw_ext_csd_cache_ctrl,
> +               ext_csd[EXT_CSD_CACHE_CTRL],
> +               card->ext_csd.raw_ext_csd_bus_width,
> +               ext_csd[EXT_CSD_BUS_WIDTH],
> +               card->ext_csd.raw_ext_csd_hs_timing,
> +               ext_csd[EXT_CSD_HS_TIMING]);
> +       err = !((card->ext_csd.raw_ext_csd_cmdq ==
> +                       ext_csd[EXT_CSD_CMDQ_MODE_EN]) &&
> +               (card->ext_csd.raw_ext_csd_cache_ctrl ==
> +                       ext_csd[EXT_CSD_CACHE_CTRL]) &&
> +               (card->ext_csd.raw_ext_csd_bus_width ==
> +                       ext_csd[EXT_CSD_BUS_WIDTH]) &&
> +               (card->ext_csd.raw_ext_csd_hs_timing ==
> +                       ext_csd[EXT_CSD_HS_TIMING]));
> +
> +       kfree(ext_csd);
>
>         return err;
>  }
> @@ -2117,9 +2211,15 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>             ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
>              (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
>                 err = mmc_poweroff_notify(host->card, notify_type);
> -       else if (mmc_can_sleep(host->card))
> -               err = mmc_sleep(host);
> -       else if (!mmc_host_is_spi(host))
> +       else if (mmc_can_sleep(host->card)) {
> +               if (mmc_can_sleepawake(host)) {
> +                       memcpy(&host->cached_ios, &host->ios, sizeof(host->cached_ios));
> +                       err = mmc_save_card_ext_csd(host);

I understand that you want to read/save the ext_csd at suspend to
read/compare it at resume.

Although, I don't understand *why* this is needed, can you please clarify?

> +                       if (err)
> +                               goto out;
> +               }
> +               err = mmc_sleepawake(host, true);
> +       } else if (!mmc_host_is_spi(host))
>                 err = mmc_deselect_cards(host);
>
>         if (!err) {
> @@ -2131,6 +2231,39 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>         return err;
>  }
>
> +static int mmc_partial_init(struct mmc_host *host)

Nitpick: Please rename this into mmc_restore_ios().

> +{
> +       int err = 0;
> +       struct mmc_card *card = host->card;
> +
> +       mmc_set_bus_width(host, host->cached_ios.bus_width);
> +       mmc_set_timing(host, host->cached_ios.timing);
> +       if (host->cached_ios.enhanced_strobe) {
> +               host->ios.enhanced_strobe = true;
> +               if (host->ops->hs400_enhanced_strobe)
> +                       host->ops->hs400_enhanced_strobe(host, &host->ios);
> +       }
> +       mmc_set_clock(host, host->cached_ios.clock);
> +       mmc_set_bus_mode(host, host->cached_ios.bus_mode);
> +

Rather than re-using the above APIs and the ->set_ios() callback in
the host, I believe it would be better to add a new host ops to manage
all of the above at once instead. Something along the lines of the
below, would then replace all of the above.

host->ops->restore_ios(host, &host->cached_ios)
memcpy(&host->ios, &host->cached_ios, sizeof(host->ios));

Would that make sense to you too?

> +       if (!mmc_card_hs400es(card) &&
> +                       (mmc_card_hs200(card) || mmc_card_hs400(card))) {
> +               err = mmc_execute_tuning(card);
> +               if (err) {
> +                       pr_err("%s: %s: Tuning failed (%d)\n",
> +                               mmc_hostname(host), __func__, err);

There is already a print being done in mmc_execute_tuning() at
failure. So, let's drop the above print.

> +                       goto out;
> +               }
> +       }
> +
> +       err = mmc_test_awake_ext_csd(host);

Again, I don't get why this is needed, so let's discuss this more.

> +       if (err)
> +               pr_debug("%s: %s: fail on ext_csd read (%d)\n",
> +                       mmc_hostname(host), __func__, err);
> +out:
> +       return err;
> +}
> +
>  /*
>   * Suspend callback
>   */
> @@ -2161,7 +2294,19 @@ static int _mmc_resume(struct mmc_host *host)
>                 goto out;
>
>         mmc_power_up(host, host->card->ocr);
> -       err = mmc_init_card(host, host->card->ocr, host->card);
> +
> +       if (mmc_can_sleepawake(host)) {
> +               err = mmc_sleepawake(host, false);
> +               if (!err)
> +                       err = mmc_partial_init(host);
> +               else
> +                       pr_err("%s: %s: awake failed (%d), fallback to full init\n",
> +                               mmc_hostname(host), __func__, err);

We don't print other errors during resume - and I don't think there is
any special reason to do it for this case only. Please drop it.

> +       }
> +
> +       if (!mmc_can_sleepawake(host) || err)
> +               err = mmc_init_card(host, host->card->ocr, host->card);
> +
>         mmc_card_clr_suspended(host->card);
>
>  out:
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index daa2f40d9ce6..fbc832ec6d57 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -86,6 +86,8 @@ struct mmc_ext_csd {
>         unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>         unsigned int            boot_ro_lock;           /* ro lock support */
>         bool                    boot_ro_lockable;
> +       u8                      raw_ext_csd_cmdq;       /* 15 */
> +       u8                      raw_ext_csd_cache_ctrl; /* 33 */
>         bool                    ffu_capable;    /* Firmware upgrade support */
>         bool                    cmdq_en;        /* Command Queue enabled */
>         bool                    cmdq_support;   /* Command Queue supported */
> @@ -96,7 +98,9 @@ struct mmc_ext_csd {
>         u8                      raw_partition_support;  /* 160 */
>         u8                      raw_rpmb_size_mult;     /* 168 */
>         u8                      raw_erased_mem_count;   /* 181 */
> +       u8                      raw_ext_csd_bus_width;  /* 183 */
>         u8                      strobe_support;         /* 184 */
> +       u8                      raw_ext_csd_hs_timing;  /* 185 */
>         u8                      raw_ext_csd_structure;  /* 194 */
>         u8                      raw_card_type;          /* 196 */
>         u8                      raw_driver_strength;    /* 197 */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 2f445c651742..836382a0b2e9 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -427,6 +427,7 @@ struct mmc_host {
>  #define MMC_CAP2_CRYPTO                0
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that has GPT entry at a non-standard location */
> +#define MMC_CAP2_SLEEP_AWAKE   (1 << 29)       /* Use Sleep/Awake (CMD5) */
>
>         int                     fixed_drv_type; /* fixed driver type for non-removable media */
>
> @@ -445,6 +446,7 @@ struct mmc_host {
>         spinlock_t              lock;           /* lock for claim and bus ops */
>
>         struct mmc_ios          ios;            /* current io bus settings */
> +       struct mmc_ios          cached_ios;
>
>         /* group bitfields together to minimize padding */
>         unsigned int            use_spi_crc:1;

Kind regards
Uffe
