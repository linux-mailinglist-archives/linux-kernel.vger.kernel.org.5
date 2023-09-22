Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429937ABBF8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjIVWsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjIVWsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:48:54 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A0AB;
        Fri, 22 Sep 2023 15:48:48 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-79a2216a2d1so1284813241.2;
        Fri, 22 Sep 2023 15:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695422927; x=1696027727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRzCTvAX8lq6ewJO7NcrsXgOFKTlOn5VfN4T0R6NmVE=;
        b=F8nu001fh9WgcEMWgmhgT8GwdTfkC+V4+rEHu6URg92Kk1qnpwzJLnIIAvCeAeKZxh
         hMljXNWNZ54LayoY+ufMtdN2hbT2gAySBRN1wBb8Dofqib5vYAvQoAu8BrntRa3yJ2HT
         nwLq+myc9FqcdgINrtwUGyDbHJnkcsjH2seF1j6XRXG3thwvA33tXpgOC8jjCo7MuNw1
         Unt90P+Z54cXt7UjBqDd4qQ/TfPf6W2ZsBteqKUMic48r8EIhiqcEEn8p376k7gYdcDP
         bUTuezPxA5EsgGiAMHA+h1kxkWinApDXlUoDs37i1cMbCkfTx2OxVitrF4gGYbBJl/BK
         NrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695422927; x=1696027727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRzCTvAX8lq6ewJO7NcrsXgOFKTlOn5VfN4T0R6NmVE=;
        b=Bzt6FmyXTqK3lBNsRGFhyu2P40WHnrPgPg8M1OgeGPPGst+LFfGvQRwvaZQ6TzrzGw
         RcBQEopopiIVpUhUJcwxa8hKu3NPtbxmD7nH0H+FONi4UlKauV3Nh3PaMq75X2TGGgYv
         TskAF1La78wiRpokvOiXeR8j3ncrGiHp9nuTWhgkPbJ0yCvvPR8Pqtp8ucMjFqPskVzE
         Aapwne2/JfOxWouHgP60+EEPbVLm64HS1yImwkBGlxrp8y93r9RhTtv3SfmBiXlCCtrH
         nPcfqqkvG+X2/GT05TUKWmFj2UQ2OKxPteJngjKE6Qt5ge41QKPAORhUt6aRSpgtLEiw
         fxZw==
X-Gm-Message-State: AOJu0Yz8+o4gTPhor9I6CP5P/VbRU7eQQJnQx3rJgROZoaaYdusIm7vz
        aSXVnWilnsN9rZQsiI/N+G2lv+E9scfbHwTqy5U=
X-Google-Smtp-Source: AGHT+IF1gUPUngEFORaH938h7YzS+JWWpSVyKmix417AKosTTVqEnfAzpMoyZWQpN/BKfzgbZwWB7ubXlAqBNOi+HEI=
X-Received: by 2002:a67:ef99:0:b0:452:951f:2bb1 with SMTP id
 r25-20020a67ef99000000b00452951f2bb1mr838983vsp.29.1695422927511; Fri, 22 Sep
 2023 15:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com> <CAOCHtYhnx1EpBM+o3xhdsicx5uqLidojK3f0HQ+VfyVv1ZXnVQ@mail.gmail.com>
In-Reply-To: <CAOCHtYhnx1EpBM+o3xhdsicx5uqLidojK3f0HQ+VfyVv1ZXnVQ@mail.gmail.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Fri, 22 Sep 2023 17:48:21 -0500
Message-ID: <CAOCHtYi5Ab5ppCmaQV3QuKQcpmJX+sHdAmtuEXhfq8xf5fFCYQ@mail.gmail.com>
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

On Fri, Sep 22, 2023 at 2:08=E2=80=AFPM Robert Nelson <robertcnelson@gmail.=
com> wrote:
>
> On Thu, Sep 21, 2023 at 8:51=E2=80=AFPM Drew Fustini <dfustini@baylibre.c=
om> wrote:
> >
> > This series adds support for the eMMC on the BeagleV Ahead and the
> > Sipeed LicheePi 4A. This allows the kernel to boot with the rootfs on
> > eMMC.
> >
> > I tested on top of v6.6-rc2 with this config [1]. I was able to boot
> > both the Ahead [2] and LPi4a [3] from eMMC. The following prerequisites
> > are required:
> >
> >   [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus [4]
> >
> > I pushed a branch [5] with this patch series and the above patch for
> > those that find a git branch easier to test.
> >
> > Please note that only the MMC controller connected to the eMMC device
> > is enabled in the device trees for these two boards. I did not yet
> > attempt to configure and use the microSD card slot. My preference is to
> > address that in a future patch series.
> >
> > References:
> > [1] https://gist.github.com/pdp7/5fbdcf2a65eb1abdd3a29d519c19cdd2
> > [2] https://gist.github.com/pdp7/91a801a5f8d1070c53509eda9800ad78
> > [3] https://gist.github.com/pdp7/1445c3c991e88fd69c60165cef65726a
> > [4] https://lore.kernel.org/linux-riscv/20230912072232.2455-1-jszhang@k=
ernel.org/
> > [5] https://github.com/pdp7/linux/tree/b4/th1520-mmc
>
> This patchset came out very nice!
>
> v6.6-rc2 with Last RFC v2:
>
> [    4.066630] mmc0: SDHCI controller on ffe7080000.mmc
> [ffe7080000.mmc] using PIO
>
> debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0
>
> /dev/mmcblk0:
>  Timing cached reads:   1516 MB in  2.00 seconds =3D 758.09 MB/sec
>  Timing buffered disk reads:  84 MB in  3.01 seconds =3D  27.94 MB/sec
>
> vs v6.6-rc2 with this patchset:
>
>  [    4.096837] mmc0: SDHCI controller on ffe7080000.mmc
> [ffe7080000.mmc] using DMA
>
> debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0
>
> /dev/mmcblk0:
>  Timing cached reads:   1580 MB in  2.00 seconds =3D 790.97 MB/sec
>  Timing buffered disk reads: 418 MB in  3.00 seconds =3D 139.11 MB/sec

Drew pointed out on Slack, this was not quite right.. After more
digging by Drew, CONFIG_DMA_GLOBAL_POOL is causing a DMA limitation
with the multiplatform defconfig. so with,

./scripts/config --disable CONFIG_ARCH_R9A07G043

(to remove CONFIG_DMA_GLOBAL_POOL)... another 2x in buffered reads..

[    4.059242] mmc0: SDHCI controller on ffe7080000.mmc
[ffe7080000.mmc] using ADMA 64-bit

debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0

/dev/mmcblk0:
 Timing cached reads:   1600 MB in  2.00 seconds =3D 800.93 MB/sec
 Timing buffered disk reads: 892 MB in  3.00 seconds =3D 297.06 MB/sec

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
