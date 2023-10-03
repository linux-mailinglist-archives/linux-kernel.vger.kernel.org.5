Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F327B6742
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjJCLKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjJCLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:10:06 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96DEAC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:10:01 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d8198ca891fso805499276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 04:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696331401; x=1696936201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRXEVtIUE4isQB5cvonaSP2CaI96haOCCWdAmU5l+u8=;
        b=MCR7yWt3rYoPbdMn6uK7VSCi6/CzDMYVVy5k9EgMkDMPevT7egMEy++teUHmznhsqJ
         JJALA9idJ0unt5fCaHPOK2Yk3JArR1qIYVu5vJNwdRw3wzHosMEok6RQHzFCgLXa0M3X
         hV/aHrk7KJa3XxCCRXG/qZhuFBI++0iZeydU2bUjYJgxv3iclL/Rb9+YYQvmurIATx2t
         JxPXY7MIpP31Am84ucnN7xIG/O2jlRNw7wOxoW11vmEoCLYZGytjOUZSRFBCYK+lbbks
         QrZRp7VLULOXKprRB3N3ASm78LR/dGhHhJ37f/NVs5kSF7jn1M8j1Div9hjI+JMmfWX3
         7Nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331401; x=1696936201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRXEVtIUE4isQB5cvonaSP2CaI96haOCCWdAmU5l+u8=;
        b=VPu9oNA+QhpyLp/gr6xrrQK0uxlPAozLFMy8WBeJAxvpbpzkJBPamLzVya2OsSWHfY
         0mAA1cbfJjATiw7JkajkwTZ1Qx6mJcd8t6lg29Fn7v88pOq28m4UHCWVrFFoNcNgpUPZ
         0S301Et6uYjTGNcrb/9wp93k5BIKs6sS0ddgguFV9MPv7prjUAS/StAAwmygr9yTsYT9
         OnK4jIsIklbOirDhIz8Q+mjg7fR9QqJrO29WvgKi2ctU2oLxpfmqZEs9fQc5ZJ/7nRH2
         5ZUAoJwg7oTT+vfnlZ+g6v9oyya7xbg1HrqtxLSMgUwdK4DEdrnmQPhJi1edTjBICnCX
         ZfhA==
X-Gm-Message-State: AOJu0YzUijdtWu6MI9mOLddMJCR+/mzTYw2hmW9BZRW6q1A1qVaF0psi
        brZBUVVd9MNUcdo/dBm8QzGXhs5i6G0iLqrpLgIuQA==
X-Google-Smtp-Source: AGHT+IGyRJcrM9EocC9Rz3KcHzMpOUoe2b2b6yT5fyBE+Dyk1kfIA8oVXrkqP/7YrnlxiGFmsDqTrcyBjmAaWnTzKHo=
X-Received: by 2002:a25:14d5:0:b0:d7a:8e37:6d4d with SMTP id
 204-20020a2514d5000000b00d7a8e376d4dmr12341241ybu.43.1696331400762; Tue, 03
 Oct 2023 04:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com> <20230915094351.11120-16-victorshihgli@gmail.com>
In-Reply-To: <20230915094351.11120-16-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Oct 2023 13:09:25 +0200
Message-ID: <CAPDyKFpt-ZmSGUWBukLvYvY6DexOr6g23FMWdY14d3gBKxzAmA@mail.gmail.com>
Subject: Re: [PATCH V12 15/23] mmc: sdhci-uhs2: add detect_init() to detect
 the interface
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Sdhci_uhs2_do_detect_init() is a sdhci version of mmc's uhs2_detect_init
> operation. After detected, the host's UHS-II capabilities will be set up
> here and interrupts will also be enabled.

$subject patch is adding a bunch of static functions, which isn't
really being used until later. If you compile this patch it will
trigger warnings about unused function, we don't want that. Each patch
in the series should build nicely without warning and errors.

To deal with these problems, I suggest that you move the introduction
of the sdhci_uhs2_control() from patch17 to $subject patch - or
possibly make that as a standalone patch, preceeding $subject patch.
Step by step you can then add support for each of the "enum
sd_uhs2_operation" to sdhci_uhs2_control().

Moreover, please work at the commit message a bit, it's not entirely
easy to understand by reading what goes on here.

>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
> Updates in V8:
>  - usleep_range() to instead of udelay() in sdhci_uhs2_interface_detect().
>  - read_poll_timeout() to instead of read_poll_timeout_atomic()
>    in sdhci_uhs2_interface_detect().
>  - Modify return value in sdhci_uhs2_do_detect_init().
>
> Updates in V7:
>  - Drop using uhs2_reset ops and use sdhci_uhs2_reset()
>    in sdhci_uhs2_do_detect_init().
>
> Updates in V6:
>  - Remove unnecessary functions.
>  - Wrap at 100 columns in some functions.
>
> ---
>
>  drivers/mmc/host/sdhci-uhs2.c | 112 ++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index ad791c48f681..4c2a56629ab3 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -335,6 +335,118 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>   *                                                                           *
>  \*****************************************************************************/
>
> +static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
> +{
> +       int timeout = 100000; /* 100ms */

Please use define instead.

> +       u32 val;
> +
> +       usleep_range(50, 200); /* wait for 50us - 200us before check */

Why? Comment?

And use defines.

> +
> +       if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IF_DETECT),
> +                             100, timeout, true, host, SDHCI_PRESENT_STATE)) {
> +               pr_warn("%s: not detect UHS2 interface in 100ms.\n", mmc_hostname(host->mmc));
> +               sdhci_dumpregs(host);
> +               return -EIO;
> +       }
> +
> +       /* Enable UHS2 error interrupts */
> +       sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
> +
> +       /* 150ms */
> +       timeout = 150000;

Ditto.

> +       if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_LANE_SYNC),
> +                             100, timeout, true, host, SDHCI_PRESENT_STATE)) {
> +               pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
> +               sdhci_dumpregs(host);
> +               return -EIO;
> +       }
> +
> +       DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initialized.\n",
> +           mmc_hostname(host->mmc));
> +       return 0;
> +}
> +
> +static int sdhci_uhs2_init(struct sdhci_host *host)
> +{
> +       u16 caps_ptr = 0;
> +       u32 caps_gen = 0;
> +       u32 caps_phy = 0;
> +       u32 caps_tran[2] = {0, 0};
> +       struct mmc_host *mmc = host->mmc;
> +
> +       caps_ptr = sdhci_readw(host, SDHCI_UHS2_CAPS_PTR);
> +       if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
> +               pr_err("%s: SDHCI_UHS2_CAPS_PTR(%d) is wrong.\n",
> +                      mmc_hostname(mmc), caps_ptr);
> +               return -ENODEV;
> +       }
> +       caps_gen = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_OFFSET);
> +       caps_phy = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_PHY_OFFSET);
> +       caps_tran[0] = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_TRAN_OFFSET);
> +       caps_tran[1] = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_TRAN_1_OFFSET);
> +
> +       /* General Caps */
> +       mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_CAPS_DAP_MASK;
> +       mmc->uhs2_caps.gap = FIELD_GET(SDHCI_UHS2_CAPS_GAP_MASK, caps_gen);
> +       mmc->uhs2_caps.n_lanes = FIELD_GET(SDHCI_UHS2_CAPS_LANE_MASK, caps_gen);
> +       mmc->uhs2_caps.addr64 = (caps_gen & SDHCI_UHS2_CAPS_ADDR_64) ? 1 : 0;
> +       mmc->uhs2_caps.card_type = FIELD_GET(SDHCI_UHS2_CAPS_DEV_TYPE_MASK, caps_gen);
> +
> +       /* PHY Caps */
> +       mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_CAPS_PHY_REV_MASK;
> +       mmc->uhs2_caps.speed_range = FIELD_GET(SDHCI_UHS2_CAPS_PHY_RANGE_MASK, caps_phy);
> +       mmc->uhs2_caps.n_lss_sync = FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LSS_SYN_MASK, caps_phy);
> +       mmc->uhs2_caps.n_lss_dir = FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LSS_DIR_MASK, caps_phy);
> +       if (mmc->uhs2_caps.n_lss_sync == 0)
> +               mmc->uhs2_caps.n_lss_sync = 16 << 2;
> +       else
> +               mmc->uhs2_caps.n_lss_sync <<= 2;
> +       if (mmc->uhs2_caps.n_lss_dir == 0)
> +               mmc->uhs2_caps.n_lss_dir = 16 << 3;
> +       else
> +               mmc->uhs2_caps.n_lss_dir <<= 3;
> +
> +       /* LINK/TRAN Caps */
> +       mmc->uhs2_caps.link_rev = caps_tran[0] & SDHCI_UHS2_CAPS_TRAN_LINK_REV_MASK;
> +       mmc->uhs2_caps.n_fcu = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_N_FCU_MASK, caps_tran[0]);
> +       if (mmc->uhs2_caps.n_fcu == 0)
> +               mmc->uhs2_caps.n_fcu = 256;
> +       mmc->uhs2_caps.host_type = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_HOST_TYPE_MASK, caps_tran[0]);
> +       mmc->uhs2_caps.maxblk_len = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_BLK_LEN_MASK, caps_tran[0]);
> +       mmc->uhs2_caps.n_data_gap = caps_tran[1] & SDHCI_UHS2_CAPS_TRAN_1_N_DATA_GAP_MASK;
> +
> +       return 0;
> +}
> +
> +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       DBG("Begin do uhs2 detect init.\n");
> +
> +       if (sdhci_uhs2_interface_detect(host)) {
> +               pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));

Does this really deserve a warning to be printed to the log?

> +               return -EIO;
> +       }
> +
> +       if (sdhci_uhs2_init(host)) {
> +               pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
> +               return -EIO;
> +       }
> +
> +       /* Init complete, do soft reset and enable UHS2 error irqs. */
> +       sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> +       sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
> +       /*
> +        * N.B SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
> +        * by SDHCI_UHS2_SW_RESET_SD
> +        */
> +       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +
> +       return 0;
> +}
> +
>  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  {
>         host->mmc_host_ops.start_signal_voltage_switch =

Kind regards
Uffe
