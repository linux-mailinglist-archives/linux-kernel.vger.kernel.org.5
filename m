Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5BF7B4557
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 07:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjJAFeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 01:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAFd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 01:33:59 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A165BD3;
        Sat, 30 Sep 2023 22:33:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-578a62c088cso1428685a12.1;
        Sat, 30 Sep 2023 22:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696138436; x=1696743236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e25S8FidnBp2b/TjTMPt6cwLn4APnkp8TLzb3MlL7vM=;
        b=ZDqNbMPfq6zl4wpGBmptaD/Fky2U+7YRlJpuK+8T1cRTqccKptrOFeEBzB6yA4vk7G
         2uykftU1CnHJ2f1M0Vh/MPVpfdbOQYDaqZXpKs664b0xaKZixTxOo3yXX/yrNVjUdu3Y
         FvkVYMl1lnM4th3FHPOLfAir9qhtq1VhUQRYcigul2XdklOTVZGwiWslB5A9b3ypkO0V
         tFrqHahv6U0dTZRF5X0rDie0rZwj+MU6AaLwdIOeWau0s5CgyrWh0mwl/gTzReiQWzZN
         IDrdNlisPUVhqfIEmG/IuAPhZsw4GJAByum8uRx7+9WLPBl1YPd07TP/uKTI/+ml0Adl
         27xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696138436; x=1696743236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e25S8FidnBp2b/TjTMPt6cwLn4APnkp8TLzb3MlL7vM=;
        b=BcGZ5chnoTM/zUAvNzX9zDdtLc6piKqEi0Wxy3Y1BJJ7eEa8GsLUB5/tJ/KaE2W1SL
         CteC10+vvN4sPiomyeelamH0CoD8qFwzS5euvTCkE5Md8DObsJhyuwAUHFCwJkCCTX/b
         zaUXKqJt4WVQKLx8PGM8iROsIEw7WJtSQw8NRyPBOjU91t5EVUNuCaFIUkRbtxEbibXK
         sAQ8U3mr0ijEmDCqPAIkXYLjXS44tkfwRoB2rf48cdb+EQdWgA2+voI6Qct6X/3/68jl
         gvwN0f6E07L8i+GmK8j3T4zxL1jDzEVdrJP+H5bzH41oyTbHd6A+zYvdp1nHcSkDcc/Q
         45uQ==
X-Gm-Message-State: AOJu0Yw3/1jggvhvQGxRzpK0q+OMBdI+XK3dxQwl0yMq1Q/gUErn2gD8
        UteE32A01tfKLqib+L7TolPxK2dqspbBICFdeU4=
X-Google-Smtp-Source: AGHT+IFeGGgSK33NxbYGbCWnvIBTGMeC+Cau3GyoLf9CWZDdd859xZWx67uaU61Jha0qPNsoAVSeGCceOyEomHUAg3Q=
X-Received: by 2002:a17:90b:23d6:b0:278:fcac:7e0 with SMTP id
 md22-20020a17090b23d600b00278fcac07e0mr13939303pjb.16.1696138435988; Sat, 30
 Sep 2023 22:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXpi5Rd6Y4umKOWRsCjX0kit=W5ZrVhn=MuRkyvJPwmjjDVnA@mail.gmail.com>
 <ZRj_ovMi-Xbb8i-D@debian.me>
In-Reply-To: <ZRj_ovMi-Xbb8i-D@debian.me>
From:   enc0der <enc0der@gmail.com>
Date:   Sun, 1 Oct 2023 01:33:44 -0400
Message-ID: <CAEXpi5RiLbma5cb-ctEvvb7LGRn78VTOh5HDmreC2hYgtBEQog@mail.gmail.com>
Subject: Re: rt8000usb driver issue (maybe interaction with other drivers)
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux RCU <rcu@vger.kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Gaul <gaul@gaul.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bagas,

The distro I am using is:
Jetson Linux 35.4.1 which is is part of JetPack 5.1.2

Supported Linux Kernel version: 5.10 LTS
aarch64
sample root fs built from: Ubuntu 20.04

When I asked Nvidia directly, their response was "Most likely it could
be wifi driver issue because it gives."

These are the drivers being loaded:

rt2800usb              36864  0
rt2x00usb              24576  1 rt2800usb
rt2800lib             122880  1 rt2800usb
rt2x00lib              77824  3 rt2800usb,rt2x00usb,rt2800lib
mac80211              811008  3 rt2x00lib,rt2x00usb,rt2800lib
cfg80211              724992  2 rt2x00lib,mac80211

I've not worked with driver code before, so I am out of my element
here.  I saw in the git history for rt2800usb some changes went in
since I was using the USB wifi adapter on an older system that has a
linux version older than 2019 (when the OS was compiled and flashed on
the machine).

And maybe something else is broken somewhere.  Just not sure how to
help figure out where this is all broken.

Rick










On Sun, Oct 1, 2023 at 1:12=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> On Sat, Sep 30, 2023 at 06:04:22PM -0400, enc0der wrote:
> > Hello all!
> >
> > This is the first time I have ever reported anything linux related, so
> > if this is not the proper way, please let me know what the correct way
> > is.
> >
> > I am using an NVIDIA Jetson Orin Nano developer platform.  They
> > release what they call a jetpack that comes with linux and their
> > additions on top.  We are using the latest version they release (just
> > released about a month ago)
>
> Something like a distro? What version?
>
> >
> > When I plug in a USB WiFi adapter that uses the rt8000usb driver, if I
> > connect to a network it sees, I get a kernel panic.  If I have
> > "automatically connect" it kernel panics when I plug the USB in.
> >
> > The version of the kernel they ship is:
> >
> > 5.10.120-tegra. (tegra is their additions)
> >
> > I talked with NVIDIA first on what I was seeing and after looking at
> > my log, they said it is likely a driver problem.
> >
> > Right after I plug in the device, this is the sequence of messages I se=
e:
> >
> > [  264.400281] BUG: scheduling while atomic: NetworkManager/622/0x00000=
203
> > [  264.408778] BUG: scheduling while atomic: NetworkManager/622/0xfffff=
dff
> > [  264.417178] BUG: scheduling while atomic: swapper/2/0/0x00000504
> > [  264.423685] bad: scheduling from the idle thread!
> >
> > Then it panics
> >
> > Sometimes it prints more, like:
> >
> > [   21.657382] BUG: scheduling while atomic: NetworkManager/630/0x00000=
203
> > [   21.664818] WARNING: CPU: 4 PID: 630 at
> > kernel/rcu/tree_plugin.h:297 rcu_note_context_switch+0x50/0x540
> > [   21.675028] ---[ end trace 62dc42c98ec427c8 ]---
> > [   21.679873] BUG: scheduling while atomic: NetworkManager/630/0x00000=
505
> > [   21.687591] WARNING: CPU: 4 PID: 0 at kernel/rcu/tree.c:624
> > rcu_eqs_enter.isra.0+0x128/0x130
> > [   21.696512] ---[ end trace 62dc42c98ec427c9 ]---
> >
> > I've also seen this:
> >
> > [   27.885487] Unable to handle kernel paging request at virtual
> > address 0000000000001000
> > [   27.893656] Mem abort info:
> > [   27.896524]   ESR =3D 0x86000004
> > [   27.899664]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
> > [   27.905124]   SET =3D 0, FnV =3D 0
> > [   27.908257]   EA =3D 0, S1PTW =3D 0
> > [   27.911480] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000001110cb=
000
> > [   27.918090] [0000000000001000] pgd=3D0000000000000000, p4d=3D0000000=
000000000
> > [   27.925066] Internal error: Oops: 86000004 [#1] PREEMPT SMP
> > [   27.930794] Modules linked in: mtd_blkdevs(E) mtd(E) lzo_rle(E)
> > lzo_compress(E) zram(E) ramoops(E) reed_solomon(E) bnep(E) loop(E)
> > rt2800usb(E) rt2x00usb(E) rt2800lib(E) rt2x00lib(E) aes_ce_blk(E)
> > rtl8822ce(E) mac80211(E) crypto_simd(E) cryptd(E) rtk_btusb(E)
> > snd_soc_tegra186_asrc(E) input_leds(E) snd_soc_tegra186_dspk(E)
> > snd_soc_tegra210_ope(E) aes_ce_cipher(E) snd_soc_tegra186_arad(E)
> > snd_soc_tegra210_iqc(E) ghash_ce(E) btusb(E) snd_soc_tegra210_mvc(E)
> > snd_soc_tegra210_afc(E) sha2_ce(E) btrtl(E) snd_soc_tegra210_amx(E)
> > snd_soc_tegra210_dmic(E) snd_soc_tegra210_adx(E) r8168(E)
> > snd_soc_tegra210_adsp(E) snd_soc_tegra210_admaif(E) sha256_arm64(E)
> > btbcm(E) snd_soc_tegra210_mixer(E) snd_soc_tegra210_sfc(E)
> > snd_soc_tegra210_i2s(E) cfg80211(E) snd_soc_tegra_machine_driver(E)
> > snd_soc_tegra_pcm(E) sha1_ce(E) btintel(E) snd_hda_codec_hdmi(E)
> > snd_soc_tegra_utils(E) snd_hda_tegra(E) snd_soc_simple_card_utils(E)
> > snd_soc_spdif_tx(E) nvadsp(E) snd_soc_tegra210_ahub(E)
> > snd_hda_codec(E) userspace_alert(E)
> > [   27.930905]  snd_hda_core(E) tegra_bpmp_thermal(E) nv_imx219(E)
> > spi_tegra114(E) tegra210_adma(E) nvidia(OE) binfmt_misc(E) ina3221(E)
> > pwm_fan(E) nvgpu(E) nvmap(E) ip_tables(E) x_tables(E) [last unloaded:
> > mtdblock]
> > [   28.042400] CPU: 4 PID: 630 Comm: NetworkManager Tainted: G
> > W  OE     5.10.120-tegra #1
>
> Out-of-tree modules, right?
>
> > [   28.051233] Hardware name: Unknown NVIDIA Orin Nano Developer
> > Kit/NVIDIA Orin Nano Developer Kit, BIOS 4.1-33958178 08/01/2023
> > [   28.062910] pstate: 60400089 (nZCv daIf +PAN -UAO -TCO BTYPE=3D--)
> > [   28.069071] pc : 0x1000
> > [   28.071586] lr : arm_smmu_dma_sync+0x40/0x70
> > [   28.075965] sp : ffff8000100231a0
> > [   28.079365] x29: 0000000000001000 x28: ffff4655c01d0ec0
> > [   28.084817] x27: ffffaced1f227000 x26: ffff4655c6ee32c0
> > [   28.090270] x25: 0000000000000000 x24: ffffaced1e405858
> > [   28.095718] x23: ffff46572e84ae00 x22: ffff4655c6ee2c40
> > [   28.101165] x21: ffff4655c82c3480 x20: ffffaced1db49e08
> > [   28.106618] x19: ffff8000100231c0 x18: 0000000000010101
> > [   28.112073] x17: 0000000000cccccc x16: ffffaced1d23382c
> > [   28.117520] x15: 0000000000000000 x14: 0000000000000000
> > [   28.122970] x13: 0000000000000001 x12: 0000000000000000
> > [   28.128421] x11: 0000000000000008 x10: 0000000000000ab0
> > [   28.133863] x9 : ffff800010023180 x8 : ffff4655c6ee3750
> > [   28.139309] x7 : 000000067eb29c20 x6 : 0000000000000238
> > [   28.144763] x5 : 00000000410fd420 x4 : 0000000000f0000f
> > [   28.150214] x3 : 0000000000001000 x2 : ffff4655c82c3480
> > [   28.155658] x1 : ffffaced1db49e08 x0 : ffff465704c37558
> > [   28.161107] Call trace:
> > [   28.163620]  0x1000
> > [   28.165777] Code: bad PC value
> > [   28.168911] ---[ end trace 62dc42c98ec427ca ]---
> > [   28.183964] Kernel panic - not syncing: Oops: Fatal exception
> > [   28.189864] SMP: stopping secondary CPUs
> > [   29.275883] SMP: failed to stop secondary CPUs 0-5
> > [   29.280811] Kernel Offset: 0x2ced0d200000 from 0xffff800010000000
> > [   29.287066] PHYS_OFFSET: 0xffffb9ab40000000
> > [   29.291360] CPU features: 0x08040006,4a80aa38
> > [   29.295832] Memory Limit: none
> > [   29.309234] ---[ end Kernel panic - not syncing: Oops: Fatal excepti=
on ]---
> >
> > (This one I believe when I started with the wifi adapter connected to
> > USB3 and networking was set to automatically connect.
> >
> > I see in the git repo that these drivers have been changed over the
> > last few years.  Given the age of the kernel that NVIDIA is using, I
> > am not sure how to correlate changes listed in the history of the
> > files with the release.  I guess I could download and diff them until
> > I figure out where.
>
> Where?
>
> >
> > I'm just not sure where to go from here.  I do know without question,
> > older versions of these drivers work on the Jetson Nano and Raspberry
> > Pi 3 which are MUCH older kernels.
>
> What version?
>
> Confused...
>
> --
> An old man doll... just what I always wanted! - Clara
