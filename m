Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841A87C6182
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjJLAJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjJLAJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:09:27 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD469E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:09:23 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4527d436ddfso186875137.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697069362; x=1697674162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E6Rb76QtykLEtpxRTYbPOUD3PEgLNbGFAb6+VKc0g0=;
        b=ldTJZADeta0UhUlotByppu58yUaQfL4ob0rR9p0XYk17+JPZjuNVRpWlIegSuDVttZ
         6d8bL4JCAlZ0bFT4z29Y4iCTY55mmKxFQa3qwDxAd4FiMHSiM9Akk7E92WU3/H5Y9KSm
         fKvUS1MkSG83JrBHUQ13sQS2r0nMV8ytX5d422Z1k5oT5+RvXoRAIRCiEQBYuUy9cP71
         h4d7eOJhSb6IEK3eUSlkIqT1VartMBx6K7sjN+h8+8PQUQ8WsGbneQBQ6ySb5dfrBjV1
         jtmeW5luwI/2fQhI120ufdWitKtL3TmGAp71euKzrM0nPaWrE3L5wXOABHZR7eDpcSOr
         KujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697069362; x=1697674162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8E6Rb76QtykLEtpxRTYbPOUD3PEgLNbGFAb6+VKc0g0=;
        b=s3jmh3ctpqkqgitv076gDiTyiSdjLDkGXj735tTWBsjjx9LXIRA0ZcM45iY8xFtuMj
         NAkoyOHK9Nu15jOWtbQoFdWXFDGSsDAAUgdJBy8D6oMu8E6xbtov/OT8jJ9hOoHN/lWE
         wrdqSYbb86C9RWo/7yUW7zsCAzf/Hd8JDCyaYAxDqaRBsu8X++kWbEwnyz2w6kwvcFjq
         T0+ZX6bj/tBiq03EiUPhN0voVBrTv43QaC6xS2bqIupWuwu/hV3sDOVUW9N2pabaCIB1
         ucEkq0oB+hfAKuKu3sqZmq+ZxqvywmDuSp9gCiDQLf6THZhQ7ikjk2X1Z/SXYAfDF7LJ
         PvGA==
X-Gm-Message-State: AOJu0YxGl+rYh8o9FmM1+GSZvZP0RFyovQuK20JqwdDF9ZDARZBpBL0S
        auUZm5PcxSMsujTlCc5XFMzRAGAAc5E3fT5BZ/8=
X-Google-Smtp-Source: AGHT+IE+jtGj0bpjr4ph2nFS2WUEiMP1Bl7FyBQFitIVf0PO5COhrul84X3ZhwP6TxoKBxvnZ7R7AtyFrDQXdrhBJCI=
X-Received: by 2002:a67:e40d:0:b0:452:8953:729e with SMTP id
 d13-20020a67e40d000000b004528953729emr22925899vsf.13.1697069361033; Wed, 11
 Oct 2023 17:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231011114721.193732-1-bjorn@kernel.org>
In-Reply-To: <20231011114721.193732-1-bjorn@kernel.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 12 Oct 2023 10:08:54 +1000
Message-ID: <CAKmqyKMtD7cvNjvs=_=frbaUVpPunj4sX0Q+jgLqDSYKNAwWxg@mail.gmail.com>
Subject: Re: [PATCH] riscv, qemu_fw_cfg: Add support for RISC-V architecture
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:34=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Qemu fw_cfg support was missing for RISC-V, which made it hard to do
> proper vmcore dumps from qemu.
>
> Add the missing RISC-V arch-defines.
>
> You can now do vmcore dumps from qemu. Add "-device vmcoreinfo" to the
> qemu command-line. From the qemu montior:
>   (qemu) dump-guest-memory vmcore
>
> The vmcore can now be used, e.g., with the "crash" utility.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  drivers/firmware/Kconfig       | 2 +-
>  drivers/firmware/qemu_fw_cfg.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e3041fd62..f05ff56629b3 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -155,7 +155,7 @@ config RASPBERRYPI_FIRMWARE
>
>  config FW_CFG_SYSFS
>         tristate "QEMU fw_cfg device support in sysfs"
> -       depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || SPARC =
|| X86)
> +       depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV =
|| SPARC || X86)
>         depends on HAS_IOPORT_MAP
>         default n
>         help
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
> index a69399a6b7c0..1448f61173b3 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -211,7 +211,7 @@ static void fw_cfg_io_cleanup(void)
>
>  /* arch-specific ctrl & data register offsets are not available in ACPI,=
 DT */
>  #if !(defined(FW_CFG_CTRL_OFF) && defined(FW_CFG_DATA_OFF))
> -# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64))
> +# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RIS=
CV))
>  #  define FW_CFG_CTRL_OFF 0x08
>  #  define FW_CFG_DATA_OFF 0x00
>  #  define FW_CFG_DMA_OFF 0x10
>
> base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
> --
> 2.39.2
>
>
