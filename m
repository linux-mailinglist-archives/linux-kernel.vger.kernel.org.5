Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C26F8033B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344136AbjLDNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjLDNAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:00:15 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D04CFD;
        Mon,  4 Dec 2023 05:00:21 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4b2d526a509so170957e0c.2;
        Mon, 04 Dec 2023 05:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701694820; x=1702299620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7aJCeBo2guqu/RUQW0zkVfwd6W/nONHlzvSur6h+mg=;
        b=XHg6aGlB/J9ijd2fKK/DyfM2mGeDHhQpUZzG72ePxj+Wgp4G3YLGq1CZXJzwOahG4t
         7PVbZez7OyCtT1zpWu8au72kzCB6mXMkOjRHhFui2hbmxh14W/K0iPmhepDD22dz4lmo
         C/kebn3y5rJpjHmznSGurtsbEve7rENYF+B6ls3hnPVClpuxzHAAk6MMPz5zzWb1i/OU
         Kbv0Tq+YPnKhWiLTqT+ushTwbgBRrSzx5K3RzkKPQrW/qzSwM85/jQ8jpUPlqwC4Mmms
         TU4zNJawCIroDOG4GtJOzh7J2FZzsFrkowqDpv95ddSM24DjSS+n5CMcEP6wMwDrvY2Y
         r+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694820; x=1702299620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7aJCeBo2guqu/RUQW0zkVfwd6W/nONHlzvSur6h+mg=;
        b=D+eblzng7t+13HunIBFS9XKDRUugITsyHNCaH/cX3PnUpUe8oxRDSpFA+vS+lOiFpd
         Fr2qzLDi7ZecGYOPzkK74jibpTo59MDdKO47DJCfOvcJGKp23ie1w3T0EAtv+GH4eBJf
         Ozq7L45JwxD0SQaZrobZ+xmVddmh5I0eOd9zNLIHQvRA4idLm7+JhB1nuyMDiqTHSNK8
         QKFQcnbdd2TsC8tJrpHTGzdMO9f7hLeTgLOEZ7JZx85BzFSvLcRgJiI99MIjZKTBfJxL
         5dWSXEzfbhodCKLsEbz9q5di1r0pDsP4ZrPE0e/drDmYa0lrxN+GPAIEuHyAxz2Q0WUX
         UwAw==
X-Gm-Message-State: AOJu0YyunZpAcR3xW+nd9MhVFC6H7M4pZ7h42WAOzMjrWRxiPqPvia7V
        WM4PvFn259MwU9FIDP3vwbgWcGKNF9NJ76GRZ5+IIHIiXwo=
X-Google-Smtp-Source: AGHT+IGE2npKlsB5rnj3DkCMZSLRvpJrnSD0wKo8FdTtM/D3jLAOT3B9nLe5s9Y0fW0XOiax8rHgS+gYYv3uTUx/8UY=
X-Received: by 2002:a05:6122:718:b0:4b2:c554:e3fe with SMTP id
 24-20020a056122071800b004b2c554e3femr828907vki.30.1701694820422; Mon, 04 Dec
 2023 05:00:20 -0800 (PST)
MIME-Version: 1.0
References: <205dc4c91b47e31b64392fe2498c7a449e717b4b.1701689330.git.geert+renesas@glider.be>
In-Reply-To: <205dc4c91b47e31b64392fe2498c7a449e717b4b.1701689330.git.geert+renesas@glider.be>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 4 Dec 2023 12:59:54 +0000
Message-ID: <CA+V-a8u6JGtidCd13HBQC9XJFedSetGS-H+tudzJ=azaMnW=Cg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Cancel delayed work before releasing host
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 11:30=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> On RZ/Five SMARC EVK, where probing of SDHI is deferred due to probe
> deferral of the vqmmc-supply regulator:
>
>     ------------[ cut here ]------------
>     WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1738 __run_timers.part.=
0+0x1d0/0x1e8
>     Modules linked in:
>     CPU: 0 PID: 0 Comm: swapper Not tainted 6.7.0-rc4 #101
>     Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
>     epc : __run_timers.part.0+0x1d0/0x1e8
>      ra : __run_timers.part.0+0x134/0x1e8
>     epc : ffffffff800771a4 ra : ffffffff80077108 sp : ffffffc800003e60
>      gp : ffffffff814f5028 tp : ffffffff8140c5c0 t0 : ffffffc800000000
>      t1 : 0000000000000001 t2 : ffffffff81201300 s0 : ffffffc800003f20
>      s1 : ffffffd8023bc4a0 a0 : 00000000fffee6b0 a1 : 0004010000400000
>      a2 : ffffffffc0000016 a3 : ffffffff81488640 a4 : ffffffc800003e60
>      a5 : 0000000000000000 a6 : 0000000004000000 a7 : ffffffc800003e68
>      s2 : 0000000000000122 s3 : 0000000000200000 s4 : 0000000000000000
>      s5 : ffffffffffffffff s6 : ffffffff81488678 s7 : ffffffff814886c0
>      s8 : ffffffff814f49c0 s9 : ffffffff81488640 s10: 0000000000000000
>      s11: ffffffc800003e60 t3 : 0000000000000240 t4 : 0000000000000a52
>      t5 : ffffffd8024ae018 t6 : ffffffd8024ae038
>     status: 0000000200000100 badaddr: 0000000000000000 cause: 00000000000=
00003
>     [<ffffffff800771a4>] __run_timers.part.0+0x1d0/0x1e8
>     [<ffffffff800771e0>] run_timer_softirq+0x24/0x4a
>     [<ffffffff80809092>] __do_softirq+0xc6/0x1fa
>     [<ffffffff80028e4c>] irq_exit_rcu+0x66/0x84
>     [<ffffffff80800f7a>] handle_riscv_irq+0x40/0x4e
>     [<ffffffff80808f48>] call_on_irq_stack+0x1c/0x28
>     ---[ end trace 0000000000000000 ]---
>
> What happens?
>
>     renesas_sdhi_probe()
>     {
>         tmio_mmc_host_alloc()
>             mmc_alloc_host()
>                 INIT_DELAYED_WORK(&host->detect, mmc_rescan);
>
>         devm_request_irq(tmio_mmc_irq);
>
>         /*
>          * After this, the interrupt handler may be invoked at any time
>          *
>          *  tmio_mmc_irq()
>          *  {
>          *      __tmio_mmc_card_detect_irq()
>          *          mmc_detect_change()
>          *              _mmc_detect_change()
>          *                  mmc_schedule_delayed_work(&host->detect, dela=
y);
>          *  }
>          */
>
>         tmio_mmc_host_probe()
>             tmio_mmc_init_ocr()
>                 -EPROBE_DEFER
>
>         tmio_mmc_host_free()
>             mmc_free_host()
>     }
>
> When expire_timers() runs later, it warns because the MMC host structure
> containing the delayed work was freed, and now contains an invalid work
> function pointer.
>
> Fix this by cancelling any pending delayed work before releasing the
> MMC host structure.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is v2 of "[RFC] mmc: tmio: Cancel delayed work before freeing
> host".
>
> v2:
>   - Move cancel_delayed_work_sync() call from tmio_mmc_host_free() to
>     mmc_free_host(),
>   - Correct explanation from missing pin control to vqmmc-supply probe
>     deferral,
>   - Update backtrace.
> ---
>  drivers/mmc/core/host.c | 1 +
>  1 file changed, 1 insertion(+)
>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 096093f7be006353..2f51db4df1a8571b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -692,6 +692,7 @@ EXPORT_SYMBOL(mmc_remove_host);
>   */
>  void mmc_free_host(struct mmc_host *host)
>  {
> +       cancel_delayed_work_sync(&host->detect);
>         mmc_pwrseq_free(host);
>         put_device(&host->class_dev);
>  }
> --
> 2.34.1
>
>
