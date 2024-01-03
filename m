Return-Path: <linux-kernel+bounces-15752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E374C82314F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D99E283D07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F01BDE4;
	Wed,  3 Jan 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWTTMVk+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F61BDD7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4b77c843fbeso928097e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704299532; x=1704904332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MV54hHlBrsG5HCcLwNQkbjmunnaquuRgTwpjGakV+68=;
        b=lWTTMVk+lpKlOLTZTB01iHVCmFNCtAqXPF66TWrn5iDQyAiZmD6Qm3extQl8gocxlJ
         bM64suuPzSzqgxeIYtxW5bD6hqg9ie6NxWDeAKnIBclRAsA1c24uDs8z3boAvf72NwWf
         yQ2UMNCbZWiIlh1oxhdhdzOQYQoCfckMZBQ6FvphSdVRb9nbtMTG7CUpGsonK17sQHcK
         k90UPMojEWsSRXcFHxBtPzJsuWZeWjO1vL/F4Xa8ArpwljIqIVebdSHQp8KfuHFgbhcm
         7akZ5NB8riFssb9Xqerj+a7v/fmdSQ3avsFRdrznA/vdqBbLw9Q3ZIturwQp8Max0LG2
         OBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704299532; x=1704904332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MV54hHlBrsG5HCcLwNQkbjmunnaquuRgTwpjGakV+68=;
        b=cP2WtMeVPS3yrkl360iN4FSbXvlwQt//dFOUmUruuHNpV3aVU66iJLgQ0n3ip+jnhz
         ow8x5I/oXgEbOAgSCL3Vy+y7yc2RYrdt+4ZyFbxdgy3rA1a5pQPz1eujEik7POFHDFFV
         JsZwztltVVcsboV4EsXT2deCsNW0lniqUrKGqAjlleL5cU+8FNcitNiDhfcVfgiODiSk
         +j5Q7F+qqclJuhbKmiOfli4YsO8Fij+JDBPlfD2en8yp0xMq2tI/TTr92O4hKB22AwNE
         rVziHv9UGsr1m6CwKuT2zFYRzcB7OkbJhXVx+fBW24NKxhIPiIk0EaDeq02MiL5rXu3S
         WjBA==
X-Gm-Message-State: AOJu0YyLSt48qbPQZlzpC63Nsv/gCZyx/24Nh2fVF8IbmcZxI2/CIESz
	bGyqypk1okRB1+r9vJs+zapONL+bZ78TWo7d7MTHN9G7+a9z+OTb67J3kVnQ8uU=
X-Google-Smtp-Source: AGHT+IEmN4ihULX6lel2L0ttNUy2SanszwT+ntOj0zaoV75aDf+dIWhdqifANtd8WlrpqBUjTPRMlXSywNsMU7Ss1JY=
X-Received: by 2002:a1f:1388:0:b0:4b6:b867:c83f with SMTP id
 130-20020a1f1388000000b004b6b867c83fmr5726801vkt.22.1704299531712; Wed, 03
 Jan 2024 08:32:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid>
In-Reply-To: <20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Wed, 3 Jan 2024 22:01:35 +0530
Message-ID: <CAMi1Hd2V8PV6j-5GYB7KnCUecBmES+xOkEwRUePORZP+GDKnBw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Don't touch the CE interrupt registers after
 power up
To: Douglas Anderson <dianders@chromium.org>
Cc: ath10k@lists.infradead.org, Abhishek Kumar <kuabhs@chromium.org>, 
	Youghandhar Chintala <quic_youghand@quicinc.com>, Kalle Valo <kvalo@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Jul 2023 at 03:49, Douglas Anderson <dianders@chromium.org> wrote:
>
> As talked about in commit d66d24ac300c ("ath10k: Keep track of which
> interrupts fired, don't poll them"),

Hi Douglas, does this fix has a dependency on the above upstream
commit d66d24ac300c, that you refer to?

Asking because this patch landed on stable v5.4.y branch recently and
now I see RCU stalls and lockups around "ath10k_snoc 18800000.wifi:
failed to receive control response completion, polling.." message
during ath10k_snoc initialization/bringup on DB845c. Here is the
relevant log https://www.irccloud.com/pastebin/raw/NjKm3mLc, with
DB845c rebooting into USB crash dump mode eventually.

I wonder if commit d66d24ac300c need to be backported to v5.4.y as
well? I tried cherry-picking it but ran into non-trivial conflicts, so
didn't spend much time on it.

Regards,
Amit Pundir

> if we access the copy engine
> register at a bad time then ath10k can go boom. However, it's not
> necessarily easy to know when it's safe to access them.
>
> The ChromeOS test labs saw a crash that looked like this at
> shutdown/reboot time (on a chromeos-5.15 kernel, but likely the
> problem could also reproduce upstream):
>
> Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
> ...
> CPU: 4 PID: 6168 Comm: reboot Not tainted 5.15.111-lockdep-19350-g1d624fe6758f #1 010b9b233ab055c27c6dc88efb0be2f4e9e86f51
> Hardware name: Google Kingoftown (DT)
> ...
> pc : ath10k_snoc_read32+0x50/0x74 [ath10k_snoc]
> lr : ath10k_snoc_read32+0x24/0x74 [ath10k_snoc]
> ...
> Call trace:
> ath10k_snoc_read32+0x50/0x74 [ath10k_snoc ...]
> ath10k_ce_disable_interrupt+0x190/0x65c [ath10k_core ...]
> ath10k_ce_disable_interrupts+0x8c/0x120 [ath10k_core ...]
> ath10k_snoc_hif_stop+0x78/0x660 [ath10k_snoc ...]
> ath10k_core_stop+0x13c/0x1ec [ath10k_core ...]
> ath10k_halt+0x398/0x5b0 [ath10k_core ...]
> ath10k_stop+0xfc/0x1a8 [ath10k_core ...]
> drv_stop+0x148/0x6b4 [mac80211 ...]
> ieee80211_stop_device+0x70/0x80 [mac80211 ...]
> ieee80211_do_stop+0x10d8/0x15b0 [mac80211 ...]
> ieee80211_stop+0x144/0x1a0 [mac80211 ...]
> __dev_close_many+0x1e8/0x2c0
> dev_close_many+0x198/0x33c
> dev_close+0x140/0x210
> cfg80211_shutdown_all_interfaces+0xc8/0x1e0 [cfg80211 ...]
> ieee80211_remove_interfaces+0x118/0x5c4 [mac80211 ...]
> ieee80211_unregister_hw+0x64/0x1f4 [mac80211 ...]
> ath10k_mac_unregister+0x4c/0xf0 [ath10k_core ...]
> ath10k_core_unregister+0x80/0xb0 [ath10k_core ...]
> ath10k_snoc_free_resources+0xb8/0x1ec [ath10k_snoc ...]
> ath10k_snoc_shutdown+0x98/0xd0 [ath10k_snoc ...]
> platform_shutdown+0x7c/0xa0
> device_shutdown+0x3e0/0x58c
> kernel_restart_prepare+0x68/0xa0
> kernel_restart+0x28/0x7c
>
> Though there's no known way to reproduce the problem, it makes sense
> that it would be the same issue where we're trying to access copy
> engine registers when it's not allowed.
>
> Let's fix this by changing how we "disable" the interrupts. Instead of
> tweaking the copy engine registers we'll just use disable_irq() and
> enable_irq(). Then we'll configure the interrupts once at power up
> time.
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/net/wireless/ath/ath10k/snoc.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 26214c00cd0d..2c39bad7ebfb 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -828,12 +828,20 @@ static void ath10k_snoc_hif_get_default_pipe(struct ath10k *ar,
>
>  static inline void ath10k_snoc_irq_disable(struct ath10k *ar)
>  {
> -       ath10k_ce_disable_interrupts(ar);
> +       struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
> +       int id;
> +
> +       for (id = 0; id < CE_COUNT_MAX; id++)
> +               disable_irq(ar_snoc->ce_irqs[id].irq_line);
>  }
>
>  static inline void ath10k_snoc_irq_enable(struct ath10k *ar)
>  {
> -       ath10k_ce_enable_interrupts(ar);
> +       struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
> +       int id;
> +
> +       for (id = 0; id < CE_COUNT_MAX; id++)
> +               enable_irq(ar_snoc->ce_irqs[id].irq_line);
>  }
>
>  static void ath10k_snoc_rx_pipe_cleanup(struct ath10k_snoc_pipe *snoc_pipe)
> @@ -1090,6 +1098,8 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
>                 goto err_free_rri;
>         }
>
> +       ath10k_ce_enable_interrupts(ar);
> +
>         return 0;
>
>  err_free_rri:
> @@ -1253,8 +1263,8 @@ static int ath10k_snoc_request_irq(struct ath10k *ar)
>
>         for (id = 0; id < CE_COUNT_MAX; id++) {
>                 ret = request_irq(ar_snoc->ce_irqs[id].irq_line,
> -                                 ath10k_snoc_per_engine_handler, 0,
> -                                 ce_name[id], ar);
> +                                 ath10k_snoc_per_engine_handler,
> +                                 IRQF_NO_AUTOEN, ce_name[id], ar);
>                 if (ret) {
>                         ath10k_err(ar,
>                                    "failed to register IRQ handler for CE %d: %d\n",
> --
> 2.41.0.255.g8b1d071c50-goog
>

