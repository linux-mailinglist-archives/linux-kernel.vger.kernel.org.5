Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F387AB9DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjIVTIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjIVTIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:08:49 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FD1C1;
        Fri, 22 Sep 2023 12:08:43 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7ab9488f2f0so154971241.3;
        Fri, 22 Sep 2023 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695409722; x=1696014522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7L9HvqDP5WJky24lmHONuk63n7kfCDpjCwpcpj0vxMA=;
        b=Mi/5vk+W/rYXHqn8ZjMSE9WEFZH0UK7eboKSAemx5t8p+j3rx10R6ryXBV2eNPVYUH
         ZjIZtkGDXkNAX0oRqMElAMSG4aqM3FFF8bnYRw3b0lAqz6WhggA9Twffra4v2YVh762M
         HLOwXm6xq5QAc9WEqrIj9TuH0Y7FEDSaM+wJ1S4s1/+9/RpuUQR07ZWXdfhhVf3B8fsw
         gQKPjXVrC02FzTfeDs2IhfL+cDP3FYPvvc758rU6FKUjbd+RtCYxbOv7oLaszwFQyVDT
         R6M9QUggKVTVVpyztzqE2Cbsxn+QqcZMItykOsZzB+M8JE5BzPNquVt3Fs7YIgacy3S/
         dnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695409722; x=1696014522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7L9HvqDP5WJky24lmHONuk63n7kfCDpjCwpcpj0vxMA=;
        b=mzqaorlbKx7AILa+GmrMOYFm0SX1NB+WAGOLbK9MCFoDLMwn8RODJob1F6H/WJb9ju
         yalJxAzber2cDQhGWE0uK295JYTg4HH9Yc9NmQxtFZvE00PrfHPnfqzpXLpf1/czWwGn
         100F/f7FoDSJES1mBlAjQbegHPe3HVAiuQfXbM8mobiR4pC5PktaG9IH24Zipa5yxeRE
         ar74V+zN03eIMKPsAkqrNLzLwCsYw6K+PV4ioEJxIgtK/B4NwZulEqFAKtbfFnnCg/3j
         s3jFGXAGidVLS17LCu7+ue1EBDKPqthrDXBeGXiwWDwg7KdPnr6eZsiT5cfCMm/lFCZO
         7IoA==
X-Gm-Message-State: AOJu0YyepZU/X4ZmhCabvyz6AYIPGnlciE3roy9w0dPznuyddDFLRflH
        edZAz19Th+Vo5oZhzbXklQ9MT/Vvixu3TX84djQ=
X-Google-Smtp-Source: AGHT+IEIuHwatFh1RJWylUlf8xGj74/AAV7K6EqAqxS9YaAsvTvQZCNSlpedgXwBetK5NHqFPcDAKpBDiR2hEQSg3vk=
X-Received: by 2002:a1f:ed45:0:b0:490:29bb:670b with SMTP id
 l66-20020a1fed45000000b0049029bb670bmr114533vkh.12.1695409722407; Fri, 22 Sep
 2023 12:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
In-Reply-To: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Fri, 22 Sep 2023 14:08:16 -0500
Message-ID: <CAOCHtYhnx1EpBM+o3xhdsicx5uqLidojK3f0HQ+VfyVv1ZXnVQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] RISC-V: Add eMMC support for TH1520 boards
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 8:51=E2=80=AFPM Drew Fustini <dfustini@baylibre.com=
> wrote:
>
> This series adds support for the eMMC on the BeagleV Ahead and the
> Sipeed LicheePi 4A. This allows the kernel to boot with the rootfs on
> eMMC.
>
> I tested on top of v6.6-rc2 with this config [1]. I was able to boot
> both the Ahead [2] and LPi4a [3] from eMMC. The following prerequisites
> are required:
>
>   [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus [4]
>
> I pushed a branch [5] with this patch series and the above patch for
> those that find a git branch easier to test.
>
> Please note that only the MMC controller connected to the eMMC device
> is enabled in the device trees for these two boards. I did not yet
> attempt to configure and use the microSD card slot. My preference is to
> address that in a future patch series.
>
> References:
> [1] https://gist.github.com/pdp7/5fbdcf2a65eb1abdd3a29d519c19cdd2
> [2] https://gist.github.com/pdp7/91a801a5f8d1070c53509eda9800ad78
> [3] https://gist.github.com/pdp7/1445c3c991e88fd69c60165cef65726a
> [4] https://lore.kernel.org/linux-riscv/20230912072232.2455-1-jszhang@ker=
nel.org/
> [5] https://github.com/pdp7/linux/tree/b4/th1520-mmc

This patchset came out very nice!

v6.6-rc2 with Last RFC v2:

[    4.066630] mmc0: SDHCI controller on ffe7080000.mmc
[ffe7080000.mmc] using PIO

debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0

/dev/mmcblk0:
 Timing cached reads:   1516 MB in  2.00 seconds =3D 758.09 MB/sec
 Timing buffered disk reads:  84 MB in  3.01 seconds =3D  27.94 MB/sec

vs v6.6-rc2 with this patchset:

 [    4.096837] mmc0: SDHCI controller on ffe7080000.mmc
[ffe7080000.mmc] using DMA

debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0

/dev/mmcblk0:
 Timing cached reads:   1580 MB in  2.00 seconds =3D 790.97 MB/sec
 Timing buffered disk reads: 418 MB in  3.00 seconds =3D 139.11 MB/sec

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
