Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D81A7B764F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbjJDBev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbjJDBet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:34:49 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7295AB;
        Tue,  3 Oct 2023 18:34:44 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57bab4e9e1aso992202eaf.3;
        Tue, 03 Oct 2023 18:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696383284; x=1696988084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT0S+khWSlvnY5isNKAiko/BfaauXTs+jj9q/zIn3RQ=;
        b=EJj+CR1Lme/oHMXBno3G+muiu0X7g2lwC5W2ovxfECSf4iYtfKHs+5Lstl3q81GmcN
         turDIO0dUTOEtRW2KaEyfDIZ0e5Y+sTlZatHptmNYR8ioK5VJ3w1uejIBy9YtqlF0LJU
         va7zoxUYA75//qQRMbVqojbLOcb74xvi3ktRxz+JUhPgcu5XZrhwXvHE103/F4Egv+xN
         zkYYKb2fhAFFWupQYnhEVuDNZY9sdervoEug8n8auIqq2Z1DOuD9Na+PeTeSGCsrv9EJ
         wZVOb5NONSZwYQUYQayHrri+VyL7862d8MT9PjIf8NtjM81ws/Qniy3bRfLgdHyZLkgA
         rxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696383284; x=1696988084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qT0S+khWSlvnY5isNKAiko/BfaauXTs+jj9q/zIn3RQ=;
        b=acu8ndQrBerZab78krNlASEg1bux8BWRoyL39YBr3CAqkFN1vFwgEPRPo5Um+CRWGP
         t6n2c0cjdcv2o4aHF1xdadWp6Uq4ROwS0BT4IBo/Ri9xf4G1kGr4Ut/fPnMswfTs83OS
         OjwG+ZxGO3jHSZIkirYqslS08mrpQ0q1IIgsNVfg6yDK410CrHlGwdhEqLBG5ZYnnyVH
         sveYclRIFueBF2KW9YcQL67NHXAKlpqqIcY1XqkZg1DCHULhWRpr6ePJSjsDUgL1Y+XT
         44Q87OETB2tEseys2sFu5nr+OaNgSZSEAVzR1c34HYa8IXLBDB1st7l+ntwC6VweJAxa
         0niA==
X-Gm-Message-State: AOJu0Yxpeaty9scmPk0wCm49em2zNZa0SBFfYzc/D3xp1XyySbFOhLoZ
        kQfqKIj+BUq5/vLDbU6aXH4sO0UoPsq11elZNCY=
X-Google-Smtp-Source: AGHT+IEkrgyYEzK9QBJPhu2lj5taS6EzV8bOMkl1OFUqAwj5eNvHttH59Ko/L7vMqfMDI5olJdanbXFCYRBW2ak1q9Y=
X-Received: by 2002:a05:6358:2496:b0:13a:cb52:4837 with SMTP id
 m22-20020a056358249600b0013acb524837mr1070657rwc.31.1696383283735; Tue, 03
 Oct 2023 18:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXpi5Rd6Y4umKOWRsCjX0kit=W5ZrVhn=MuRkyvJPwmjjDVnA@mail.gmail.com>
 <ZRj_ovMi-Xbb8i-D@debian.me> <20231002185053.GB402943@wp.pl>
In-Reply-To: <20231002185053.GB402943@wp.pl>
From:   enc0der <enc0der@gmail.com>
Date:   Tue, 3 Oct 2023 21:34:32 -0400
Message-ID: <CAEXpi5StYwujiTaH2_5PE9Hg_cgzAEtBuFxfgVxEJvbqRNv_4A@mail.gmail.com>
Subject: Re: rt8000usb driver issue (maybe interaction with other drivers)
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
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

Hello Stanislaw!

On Mon, Oct 2, 2023 at 2:50=E2=80=AFPM Stanislaw Gruszka <stf_xl@wp.pl> wro=
te:
>
> Is possible that this is rt2800usb or usb host driver issue. But without
> full logs we can not be sure.

Okay, I was able to use dmesg -w before it kernel panic'd to grab some
additional details, first this is when I plug in th USB WiFi adapter
but I have it not automatically connect.  In this state, it will not
kernel panic:

[ 1496.115251] usb 1-3.4: new high-speed USB device number 7 using tegra-xu=
sb
[ 1496.333698] usb 1-3.4: New USB device found, idVendor=3D148f,
idProduct=3D5370, bcdDevice=3D 1.01
[ 1496.333707] usb 1-3.4: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[ 1496.333712] usb 1-3.4: Product: 802.11 n WLAN
[ 1496.333716] usb 1-3.4: Manufacturer: Ralink
[ 1496.333719] usb 1-3.4: SerialNumber: 1.0
[ 1497.187704] usb 1-3.4: reset high-speed USB device number 7 using tegra-=
xusb
[ 1497.399765] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 5390,
rev 0502 detected
[ 1497.574025] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 5370 detect=
ed
[ 1497.575366] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht=
'
[ 1497.577940] usbcore: registered new interface driver rt2800usb
[ 1497.744748] ieee80211 phy0: rt2x00lib_request_firmware: Info -
Loading firmware file 'rt2870.bin'
[ 1497.747318] ieee80211 phy0: rt2x00lib_request_firmware: Info -
Firmware detected - version: 0.36

Then, I tell it to connect to a local network, and I see a loop of
errors over and over before it eventually panics:

(I just copied in a few of them since many of these repeated over and over:

[ 1541.821783] wlan0: authenticate with 6c:4b:b4:30:9b:04
[ 1542.000817] wlan0: send auth to 6c:4b:b4:30:9b:04 (try 1/3)
[ 1542.002490] wlan0: authenticated
[ 1542.006241] wlan0: associate with 6c:4b:b4:30:9b:04 (try 1/3)
[ 1542.010192] wlan0: RX AssocResp from 6c:4b:b4:30:9b:04 (capab=3D0x411
status=3D0 aid=3D14)
[ 1542.050657] wlan0: associated
[ 1542.075032] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[ 1542.091614] wlan0: Limiting TX power to 30 (30 - 0) dBm as
advertised by 6c:4b:b4:30:9b:04
[ 1542.242112] BUG: scheduling while atomic: ksoftirqd/3/29/0x00000103
[ 1542.248587] Modules linked in: rt2800usb(E) rt2x00usb(E)
rt2800lib(E) rt2x00lib(E) mac80211(E) cfg80211(E) nvidia_modeset(OE)
fuse(E) lzo_rle(E) lzo_compress(E) zram(E) ramoops(E) reed_solomon(E)
loop(E) snd_soc_tegra186_asrc(E) snd_soc_tegra210_ope(E)
snd_soc_tegra186_arad(E) snd_soc_tegra186_dspk(E)
snd_soc_tegra210_iqc(E) aes_ce_blk(E) crypto_simd(E) cryptd(E)
snd_soc_tegra210_mvc(E) snd_soc_tegra210_afc(E) aes_ce_cipher(E)
snd_soc_tegra210_dmic(E) snd_soc_tegra210_adx(E) ghash_ce(E)
snd_soc_tegra210_amx(E) sha2_ce(E) snd_soc_tegra210_i2s(E)
snd_soc_tegra210_mixer(E) snd_soc_tegra210_admaif(E) sha256_arm64(E)
snd_soc_tegra210_sfc(E) snd_soc_tegra_pcm(E) hid_ite(E) sha1_ce(E)
input_leds(E) spidev(E) snd_soc_tegra210_adsp(E)
snd_soc_tegra_machine_driver(E) snd_soc_spdif_tx(E)
snd_soc_tegra_utils(E) snd_soc_simple_card_utils(E)
snd_hda_codec_hdmi(E) snd_soc_tegra210_ahub(E) nvadsp(E)
userspace_alert(E) snd_hda_tegra(E) tegra_bpmp_thermal(E)
tegra210_adma(E) nv_imx219(E) snd_hda_codec(E)
[ 1542.248665]  snd_hda_core(E) spi_tegra114(E) nvidia(OE)
binfmt_misc(E) ina3221(E) pwm_fan(E) nvgpu(E) nvmap(E) ip_tables(E)
x_tables(E) [last unloaded: mtd]
[ 1542.248686] CPU: 3 PID: 29 Comm: ksoftirqd/3 Tainted: G        W
OE     5.10.120-tegra #1
[ 1542.248687] Hardware name: Unknown NVIDIA Orin Nano Developer
Kit/NVIDIA Orin Nano Developer Kit, BIOS 4.1-33958178 08/01/2023
[ 1542.248690] Call trace:
[ 1542.248702]  dump_backtrace+0x0/0x1d0
[ 1542.248705]  show_stack+0x30/0x40
[ 1542.248712]  dump_stack+0xd8/0x138
[ 1542.248717]  __schedule_bug+0x78/0x90
[ 1542.248722]  __schedule+0x844/0x910
[ 1542.248724]  schedule+0x78/0x110
[ 1542.248727]  schedule_timeout+0x184/0x340
[ 1542.248731]  nvhost_syncpt_wait_timeout+0x450/0x720
[ 1542.248733]  nvhost_syncpt_wait_timeout_ext+0xf4/0x120
[ 1542.248738]  tegra_se_channel_submit_gather.isra.0+0x160/0x440
[ 1542.248740]  tegra_se_ccm_compute_auth+0x2d8/0x650
[ 1542.248743]  tegra_se_aes_ccm_encrypt+0x6c/0x150
[ 1542.248746]  crypto_aead_encrypt+0x38/0x50
[ 1542.248768]  aead_encrypt+0x130/0x180 [mac80211]
[ 1542.248782]  ieee80211_crypto_ccmp_encrypt+0x1f8/0x270 [mac80211]
[ 1542.248793]  ieee80211_txq_schedule_start+0xae4/0xc10 [mac80211]
[ 1542.248803]  ieee80211_proberesp_get+0x3ec/0x830 [mac80211]
[ 1542.248814]  ieee80211_tx_prepare_skb+0x27c/0x2d0 [mac80211]
[ 1542.248824]  ieee80211_xmit+0xa0/0xd0 [mac80211]
[ 1542.248835]  __ieee80211_subif_start_xmit+0x780/0xb10 [mac80211]
[ 1542.248845]  ieee80211_subif_start_xmit+0x5c/0x2f0 [mac80211]
[ 1542.248850]  dev_hard_start_xmit+0x10c/0x330
[ 1542.248855]  sch_direct_xmit+0xf4/0x360
[ 1542.248857]  __qdisc_run+0x140/0x730
[ 1542.248859]  net_tx_action+0x14c/0x380
[ 1542.248862]  __do_softirq+0x140/0x3e8
[ 1542.248865]  run_ksoftirqd+0x50/0x60
[ 1542.248868]  smpboot_thread_fn+0x1c4/0x280
[ 1542.248870]  kthread+0x148/0x170
[ 1542.248872]  ret_from_fork+0x10/0x24
[ 1542.248882] ------------[ cut here ]------------
[ 1542.248887] WARNING: CPU: 3 PID: 29 at kernel/rcu/tree_plugin.h:297
rcu_note_context_switch+0x50/0x540
[ 1542.258457] Modules linked in: rt2800usb(E) rt2x00usb(E)
rt2800lib(E) rt2x00lib(E) mac80211(E) cfg80211(E) nvidia_modeset(OE)
fuse(E) lzo_rle(E) lzo_compress(E) zram(E) ramoops(E) reed_solomon(E)
loop(E) snd_soc_tegra186_asrc(E) snd_soc_tegra210_ope(E)
snd_soc_tegra186_arad(E) snd_soc_tegra186_dspk(E)
snd_soc_tegra210_iqc(E) aes_ce_blk(E) crypto_simd(E) cryptd(E)
snd_soc_tegra210_mvc(E) snd_soc_tegra210_afc(E) aes_ce_cipher(E)
snd_soc_tegra210_dmic(E) snd_soc_tegra210_adx(E) ghash_ce(E)
snd_soc_tegra210_amx(E) sha2_ce(E) snd_soc_tegra210_i2s(E)
snd_soc_tegra210_mixer(E) snd_soc_tegra210_admaif(E) sha256_arm64(E)
snd_soc_tegra210_sfc(E) snd_soc_tegra_pcm(E) hid_ite(E) sha1_ce(E)
input_leds(E) spidev(E) snd_soc_tegra210_adsp(E)
snd_soc_tegra_machine_driver(E) snd_soc_spdif_tx(E)
snd_soc_tegra_utils(E) snd_soc_simple_card_utils(E)
snd_hda_codec_hdmi(E) snd_soc_tegra210_ahub(E) nvadsp(E)
userspace_alert(E) snd_hda_tegra(E) tegra_bpmp_thermal(E)
tegra210_adma(E) nv_imx219(E) snd_hda_codec(E)
[ 1542.258510]  snd_hda_core(E) spi_tegra114(E) nvidia(OE)
binfmt_misc(E) ina3221(E) pwm_fan(E) nvgpu(E) nvmap(E) ip_tables(E)
x_tables(E) [last unloaded: mtd]
[ 1542.258524] CPU: 3 PID: 29 Comm: ksoftirqd/3 Tainted: G        W
OE     5.10.120-tegra #1
[ 1542.258525] Hardware name: Unknown NVIDIA Orin Nano Developer
Kit/NVIDIA Orin Nano Developer Kit, BIOS 4.1-33958178 08/01/2023
[ 1542.258529] pstate: 20c00089 (nzCv daIf +PAN +UAO -TCO BTYPE=3D--)
[ 1542.258532] pc : rcu_note_context_switch+0x50/0x540
[ 1542.258535] lr : rcu_note_context_switch+0x28/0x540
[ 1542.258536] sp : ffff8000101e3270
[ 1542.258538] x29: ffff8000101e3270 x28: 0000000000000000
[ 1542.258541] x27: ffffb2b1e4fe7000 x26: ffffb2b1e49fbe00
[ 1542.258544] x25: 0000000000000000 x24: ffffb2b1e41c5858
[ 1542.258548] x23: ffff293a2e827e00 x22: ffff2938c0228ec0
[ 1542.258551] x21: 0000000000000000 x20: ffff2938c0228ec0
[ 1542.258554] x19: ffff293a2e828b00 x18: 0000000000000060
[ 1542.258557] x17: 0000000000018021 x16: ffffb2b1e2fe5220
[ 1542.258560] x15: ffff2938c0229430 x14: ffffffffffffffff
[ 1542.258564] x13: ffff8000901e2d75 x12: ffff8000101e2d7e
[ 1542.258567] x11: 0101010101010101 x10: ffffffffff7f7f7f
[ 1542.258570] x9 : 00000000fffffffe x8 : 343278302f303178
[ 1542.258573] x7 : 302b6b726f665f6d x6 : 0000000000000002
[ 1542.258576] x5 : ffff80001001c000 x4 : ffffb2b1e4ff2000
[ 1542.258579] x3 : ffffb2b1e4ff2dc0 x2 : ffffb2b1e3180d70
[ 1542.258582] x1 : ffff8000101e3270 x0 : 0000000000000002
[ 1542.258585] Call trace:
[ 1542.258589]  rcu_note_context_switch+0x50/0x540
[ 1542.258592]  __schedule+0xc0/0x910
[ 1542.258594]  schedule+0x78/0x110
[ 1542.258597]  schedule_timeout+0x184/0x340
[ 1542.258600]  nvhost_syncpt_wait_timeout+0x450/0x720
[ 1542.258602]  nvhost_syncpt_wait_timeout_ext+0xf4/0x120
[ 1542.258605]  tegra_se_channel_submit_gather.isra.0+0x160/0x440
[ 1542.258607]  tegra_se_ccm_compute_auth+0x2d8/0x650
[ 1542.258610]  tegra_se_aes_ccm_encrypt+0x6c/0x150
[ 1542.258612]  crypto_aead_encrypt+0x38/0x50
[ 1542.258625]  aead_encrypt+0x130/0x180 [mac80211]
[ 1542.258636]  ieee80211_crypto_ccmp_encrypt+0x1f8/0x270 [mac80211]
[ 1542.258648]  ieee80211_txq_schedule_start+0xae4/0xc10 [mac80211]
[ 1542.258660]  ieee80211_proberesp_get+0x3ec/0x830 [mac80211]
[ 1542.258672]  ieee80211_tx_prepare_skb+0x27c/0x2d0 [mac80211]
[ 1542.258684]  ieee80211_xmit+0xa0/0xd0 [mac80211]
[ 1542.258695]  __ieee80211_subif_start_xmit+0x780/0xb10 [mac80211]
[ 1542.258707]  ieee80211_subif_start_xmit+0x5c/0x2f0 [mac80211]
[ 1542.258710]  dev_hard_start_xmit+0x10c/0x330
[ 1542.258713]  sch_direct_xmit+0xf4/0x360
[ 1542.258715]  __qdisc_run+0x140/0x730
[ 1542.258718]  net_tx_action+0x14c/0x380
[ 1542.258720]  __do_softirq+0x140/0x3e8
[ 1542.258723]  run_ksoftirqd+0x50/0x60
[ 1542.258726]  smpboot_thread_fn+0x1c4/0x280
[ 1542.258728]  kthread+0x148/0x170
[ 1542.258730]  ret_from_fork+0x10/0x24
[ 1542.258732] ---[ end trace c64fbdc5cc928ac7 ]---
[ 1542.263555] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #280!!!
[ 1542.271921] softirq: huh, entered softirq 2 NET_TX 00000000548727ea
with preempt_count 00000100, exited with fffffffe?
[ 1542.275488] BUG: scheduling while atomic: ksoftirqd/5/39/0x00000103
[ 1542.289407] Modules linked in: rt2800usb(E) rt2x00usb(E)
rt2800lib(E) rt2x00lib(E) mac80211(E) cfg80211(E) nvidia_modeset(OE)
fuse(E) lzo_rle(E) lzo_compress(E) zram(E) ramoops(E) reed_solomon(E)
loop(E) snd_soc_tegra186_asrc(E) snd_soc_tegra210_ope(E)
snd_soc_tegra186_arad(E) snd_soc_tegra186_dspk(E)
snd_soc_tegra210_iqc(E) aes_ce_blk(E) crypto_simd(E) cryptd(E)
snd_soc_tegra210_mvc(E) snd_soc_tegra210_afc(E) aes_ce_cipher(E)
snd_soc_tegra210_dmic(E) snd_soc_tegra210_adx(E) ghash_ce(E)
snd_soc_tegra210_amx(E) sha2_ce(E) snd_soc_tegra210_i2s(E)
snd_soc_tegra210_mixer(E) snd_soc_tegra210_admaif(E) sha256_arm64(E)
snd_soc_tegra210_sfc(E) snd_soc_tegra_pcm(E) hid_ite(E) sha1_ce(E)
input_leds(E) spidev(E) snd_soc_tegra210_adsp(E)
snd_soc_tegra_machine_driver(E) snd_soc_spdif_tx(E)
snd_soc_tegra_utils(E) snd_soc_simple_card_utils(E)
snd_hda_codec_hdmi(E) snd_soc_tegra210_ahub(E) nvadsp(E)
userspace_alert(E) snd_hda_tegra(E) tegra_bpmp_thermal(E)
tegra210_adma(E) nv_imx219(E) snd_hda_codec(E)
[ 1542.289527]  snd_hda_core(E) spi_tegra114(E) nvidia(OE)
binfmt_misc(E) ina3221(E) pwm_fan(E) nvgpu(E) nvmap(E) ip_tables(E)
x_tables(E) [last unloaded: mtd]
[ 1542.289559] CPU: 5 PID: 39 Comm: ksoftirqd/5 Tainted: G        W
OE     5.10.120-tegra #1
[ 1542.289563] Hardware name: Unknown NVIDIA Orin Nano Developer
Kit/NVIDIA Orin Nano Developer Kit, BIOS 4.1-33958178 08/01/2023
[ 1542.289566] Call trace:
[ 1542.289578]  dump_backtrace+0x0/0x1d0
[ 1542.289585]  show_stack+0x30/0x40
[ 1542.289594]  dump_stack+0xd8/0x138
[ 1542.289602]  __schedule_bug+0x78/0x90
[ 1542.289609]  __schedule+0x844/0x910
[ 1542.289613]  schedule+0x78/0x110
[ 1542.289619]  schedule_timeout+0x184/0x340
[ 1542.289625]  nvhost_syncpt_wait_timeout+0x450/0x720
[ 1542.289629]  nvhost_syncpt_wait_timeout_ext+0xf4/0x120
[ 1542.289636]  tegra_se_channel_submit_gather.isra.0+0x160/0x440
[ 1542.289641]  tegra_se_ccm_compute_auth+0x2d8/0x650
[ 1542.289646]  tegra_se_aes_ccm_encrypt+0x6c/0x150
[ 1542.289651]  crypto_aead_encrypt+0x38/0x50
[ 1542.289685]  aead_encrypt+0x130/0x180 [mac80211]
[ 1542.289711]  ieee80211_crypto_ccmp_encrypt+0x1f8/0x270 [mac80211]
[ 1542.289735]  ieee80211_txq_schedule_start+0xae4/0xc10 [mac80211]
[ 1542.289757]  ieee80211_proberesp_get+0x3ec/0x830 [mac80211]
[ 1542.289779]  ieee80211_tx_prepare_skb+0x27c/0x2d0 [mac80211]
[ 1542.289801]  ieee80211_xmit+0xa0/0xd0 [mac80211]
[ 1542.289823]  __ieee80211_subif_start_xmit+0x780/0xb10 [mac80211]
[ 1542.289845]  ieee80211_subif_start_xmit+0x5c/0x2f0 [mac80211]
[ 1542.289852]  dev_hard_start_xmit+0x10c/0x330
[ 1542.289858]  sch_direct_xmit+0xf4/0x360
[ 1542.289862]  __qdisc_run+0x140/0x730
[ 1542.289867]  net_tx_action+0x14c/0x380
[ 1542.289871]  __do_softirq+0x140/0x3e8
[ 1542.289876]  run_ksoftirqd+0x50/0x60
[ 1542.289882]  smpboot_thread_fn+0x1c4/0x280
[ 1542.289885]  kthread+0x148/0x170
[ 1542.289890]  ret_from_fork+0x10/0x24
[ 1542.290056] softirq: huh, entered softirq 2 NET_TX 00000000548727ea
with preempt_count 00000100, exited with fffffffe?
[ 1542.310049] BUG: scheduling while atomic: kworker/u12:0/3307/0x00000201
[ 1542.316883] Modules linked in: rt2800usb(E) rt2x00usb(E)
rt2800lib(E) rt2x00lib(E) mac80211(E) cfg80211(E) nvidia_modeset(OE)
fuse(E) lzo_rle(E) lzo_compress(E) zram(E) ramoops(E) reed_solomon(E)
loop(E) snd_soc_tegra186_asrc(E) snd_soc_tegra210_ope(E)
snd_soc_tegra186_arad(E) snd_soc_tegra186_dspk(E)
snd_soc_tegra210_iqc(E) aes_ce_blk(E) crypto_simd(E) cryptd(E)
snd_soc_tegra210_mvc(E) snd_soc_tegra210_afc(E) aes_ce_cipher(E)
snd_soc_tegra210_dmic(E) snd_soc_tegra210_adx(E) ghash_ce(E)
snd_soc_tegra210_amx(E) sha2_ce(E) snd_soc_tegra210_i2s(E)
snd_soc_tegra210_mixer(E) snd_soc_tegra210_admaif(E) sha256_arm64(E)
snd_soc_tegra210_sfc(E) snd_soc_tegra_pcm(E) hid_ite(E) sha1_ce(E)
input_leds(E) spidev(E) snd_soc_tegra210_adsp(E)
snd_soc_tegra_machine_driver(E) snd_soc_spdif_tx(E)
snd_soc_tegra_utils(E) snd_soc_simple_card_utils(E)
snd_hda_codec_hdmi(E) snd_soc_tegra210_ahub(E) nvadsp(E)
userspace_alert(E) snd_hda_tegra(E) tegra_bpmp_thermal(E)
tegra210_adma(E) nv_imx219(E) snd_hda_codec(E)
[ 1542.316959]  snd_hda_core(E) spi_tegra114(E) nvidia(OE)
binfmt_misc(E) ina3221(E) pwm_fan(E) nvgpu(E) nvmap(E) ip_tables(E)
x_tables(E) [last unloaded: mtd]
[ 1542.316981] CPU: 0 PID: 3307 Comm: kworker/u12:0 Tainted: G
W  OE     5.10.120-tegra #1
[ 1542.316983] Hardware name: Unknown NVIDIA Orin Nano Developer
Kit/NVIDIA Orin Nano Developer Kit, BIOS 4.1-33958178 08/01/2023
[ 1542.317008] Workqueue: phy0 ieee80211_ba_session_work [mac80211]
[ 1542.317011] Call trace:
[ 1542.317018]  dump_backtrace+0x0/0x1d0
[ 1542.317022]  show_stack+0x30/0x40
[ 1542.317029]  dump_stack+0xd8/0x138
[ 1542.317033]  __schedule_bug+0x78/0x90
[ 1542.317038]  __schedule+0x844/0x910
[ 1542.317040]  schedule+0x78/0x110
[ 1542.317044]  schedule_timeout+0x184/0x340
[ 1542.317047]  nvhost_syncpt_wait_timeout+0x450/0x720
[ 1542.317050]  nvhost_syncpt_wait_timeout_ext+0xf4/0x120
[ 1542.317054]  tegra_se_channel_submit_gather.isra.0+0x160/0x440
[ 1542.317057]  tegra_se_ccm_compute_auth+0x2d8/0x650
[ 1542.317060]  tegra_se_aes_ccm_encrypt+0x6c/0x150
[ 1542.317063]  crypto_aead_encrypt+0x38/0x50
[ 1542.317080]  aead_encrypt+0x130/0x180 [mac80211]
[ 1542.317094]  ieee80211_crypto_ccmp_encrypt+0x1f8/0x270 [mac80211]
[ 1542.317108]  ieee80211_txq_schedule_start+0xae4/0xc10 [mac80211]
[ 1542.317121]  ieee80211_proberesp_get+0x3ec/0x830 [mac80211]
[ 1542.317135]  ieee80211_tx_prepare_skb+0x27c/0x2d0 [mac80211]
[ 1542.317148]  ieee80211_xmit+0xa0/0xd0 [mac80211]
[ 1542.317161]  __ieee80211_tx_skb_tid_band+0x84/0xb0 [mac80211]
[ 1542.317174]  ieee80211_start_tx_ba_cb_irqsafe+0x300/0x3c0 [mac80211]
[ 1542.317187]  ieee80211_tx_ba_session_handle_start+0xec/0x1b0 [mac80211]
[ 1542.317200]  ieee80211_ba_session_work+0x2a0/0x350 [mac80211]
[ 1542.317204]  process_one_work+0x1c4/0x4a0
[ 1542.317206]  worker_thread+0x54/0x430
[ 1542.317208]  kthread+0x148/0x170
[ 1542.317211]  ret_from_fork+0x10/0x24
[ 1542.317383] BUG: workqueue leaked lock or atomic:
kworker/u12:0/0xfffffe00/3307
                    last function: ieee80211_ba_session_work [mac80211]


The last set of messages:

[ 1575.970833] BUG: scheduling while atomic: NetworkManager/593/0xfffffdff
[ 1575.977680] Modules linked in: rt2800usb(E) rt2x00usb(E)
rt2800lib(E) rt2x00lib(E) mac80211(E) cfg80211(E) nvidia_modeset(OE)
fuse(E) lzo_rle(E) lzo_compress(E) zram(E) ramoops(E) reed_solomon(E)
loop(E) snd_soc_tegra186_asrc(E) snd_soc_tegra210_ope(E)
snd_soc_tegra186_arad(E) snd_soc_tegra186_dspk(E)
snd_soc_tegra210_iqc(E) aes_ce_blk(E) crypto_simd(E) cryptd(E)
snd_soc_tegra210_mvc(E) snd_soc_tegra210_afc(E) aes_ce_cipher(E)
snd_soc_tegra210_dmic(E) snd_soc_tegra210_adx(E) ghash_ce(E)
snd_soc_tegra210_amx(E) sha2_ce(E) snd_soc_tegra210_i2s(E)
snd_soc_tegra210_mixer(E) snd_soc_tegra210_admaif(E) sha256_arm64(E)
snd_soc_tegra210_sfc(E) snd_soc_tegra_pcm(E) hid_ite(E) sha1_ce(E)
input_leds(E) spidev(E) snd_soc_tegra210_adsp(E)
snd_soc_tegra_machine_driver(E) snd_soc_spdif_tx(E)
snd_soc_tegra_utils(E) snd_soc_simple_card_utils(E)
snd_hda_codec_hdmi(E) snd_soc_tegra210_ahub(E) nvadsp(E)
userspace_alert(E) snd_hda_tegra(E) tegra_bpmp_thermal(E)
tegra210_adma(E) nv_imx219(E) snd_hda_codec(E)
[ 1575.977790]  snd_hda_core(E) spi_tegra114(E) nvidia(OE)
binfmt_misc(E) ina3221(E) pwm_fan(E) nvgpu(E) nvmap(E) ip_tables(E)
x_tables(E) [last unloaded: mtd]
[ 1575.977819] CPU: 4 PID: 593 Comm: NetworkManager Tainted: G
W  OE     5.10.120-tegra #1
[ 1575.977822] Hardware name: Unknown NVIDIA Orin Nano Developer
Kit/NVIDIA Orin Nano Developer Kit, BIOS 4.1-33958178 08/01/2023
[ 1575.977825] Call trace:
[ 1575.977834]  dump_backtrace+0x0/0x1d0
[ 1575.977840]  show_stack+0x30/0x40
[ 1575.977846]  dump_stack+0xd8/0x138
[ 1575.977852]  __schedule_bug+0x78/0x90
[ 1575.977857]  __schedule+0x844/0x910
[ 1575.977861]  schedule+0x78/0x110
[ 1575.977867]  schedule_hrtimeout_range_clock+0xa0/0x120
[ 1575.977872]  schedule_hrtimeout_range+0x3c/0x50
[ 1575.977880]  do_sys_poll+0x3d4/0x770
[ 1575.977885]  __arm64_sys_ppoll+0xc0/0x100
[ 1575.977891]  el0_svc_common.constprop.0+0x80/0x1d0
[ 1575.977896]  do_el0_svc+0x38/0xb0
[ 1575.977900]  el0_svc+0x1c/0x30
[ 1575.977904]  el0_sync_handler+0xa8/0xb0
[ 1575.977908]  el0_sync+0x16c/0x180
[ 1587.493670] wlan0: deauthenticating from 6c:4b:b4:30:9b:04 by local
choice (Reason: 3=3DDEAUTH_LEAVING)

Then at this point the communications were cut (I was using a wired
interface to capture)

From the serial port, once I tell it to connect to the local network,
this is all that is output before serial stops

[  533.875985] BUG: scheduling while atomic: ksoftirqd/0/12/0x00000103
[  533.882790] WARNING: CPU: 0 PID: 12 at kernel/rcu/tree_plugin.h:297
rcu_note_context_switch+0x50/0x540
[  533.892621] ---[ end trace a78168b0d15c7046 ]---
[  533.897590] softirq: huh, entered softirq 2 NET_TX 00000000cca7c5d3
with preempt_count 00000100, exited with fffffffe?
[  533.941129] BUG: scheduling while atomic: ksoftirqd/2/24/0x00000103
[  533.947928] softirq: huh, entered softirq 2 NET_TX 00000000cca7c5d3
with preempt_count 00000100, exited with fffffffe?
[  533.963887] BUG: scheduling while atomic: kworker/u12:3/722/0x00000201
[  533.971012] BUG: workqueue leaked lock or atomic:
kworker/u12:3/0xfffffe00/722
[  533.971012]      last function: ieee80211_ba_session_work [mac80211]
[  533.985079] BUG: workqueue leaked lock or atomic:
kworker/u12:3/0xfffffe00/722
[  533.985079]      last function: ieee80211_ibss_leave [mac80211]
[  533.998657] BUG: scheduling while atomic: kworker/u12:3/722/0xfffffe01
[  534.983931] BUG: scheduling while atomic: kworker/u12:0/7/0x00000102
[  534.991172] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #02!!!
[  535.007609] softirq: huh, entered softirq 6 TASKLET
0000000048396bde with preempt_count 00000101, exited with 00000000?
[  535.018825] BUG: scheduling while atomic: kworker/u12:0/7/0x00000201
[  535.026005] BUG: workqueue leaked lock or atomic: kworker/u12:0/0xfffffe=
00/7
[  535.026005]      last function: ieee80211_ba_session_work [mac80211]
[  535.040029] BUG: scheduling while atomic: kworker/u12:0/7/0xfffffe01
[  535.056041] BUG: scheduling while atomic: kworker/u12:0/7/0x00000201
[  535.063242] BUG: workqueue leaked lock or atomic: kworker/u12:0/0xfffffe=
00/7
[  535.063242]      last function: ieee80211_ba_session_work [mac80211]
[  535.077144] BUG: scheduling while atomic: kworker/u12:0/7/0xfffffe01
[  535.084030] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #280!!!
[  535.854930] BUG: scheduling while atomic: NetworkManager/625/0x00000203
[  535.862489] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #2c0!!!
[  535.870814] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #2c0!!!
[  535.887341] WARNING: CPU: 0 PID: 625 at kernel/softirq.c:174
__local_bh_enable_ip+0xac/0xc0
[  535.896074] ---[ end trace a78168b0d15c7047 ]---
[  535.900889] BUG: scheduling while atomic: NetworkManager/625/0xfffffdff
[  535.907957] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #2c2!!!
[  535.916279] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #2c2!!!
[  536.103830] BUG: scheduling while atomic: kworker/u12:0/7/0x00000102
[  536.110787] softirq: huh, entered softirq 6 TASKLET
0000000048396bde with preempt_count 00000101, exited with 00000000?
[  536.121976] BUG: scheduling while atomic: kworker/u12:0/7/0x00000201
[  536.128931] BUG: workqueue leaked lock or atomic: kworker/u12:0/0xfffffe=
00/7
[  536.128931]      last function: ieee80211_ba_session_work [mac80211]
[  536.142827] BUG: scheduling while atomic: kworker/u12:0/7/0xfffffe01
[  536.149562] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #80!!!
[  536.157772] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #80!!!
[  536.187788] BUG: scheduling while atomic: kworker/u12:0/7/0x00000201
[  536.194783] BUG: workqueue leaked lock or atomic: kworker/u12:0/0xfffffe=
00/7
[  536.194783]      last function: ieee80211_ba_session_work [mac80211]
[  536.208655] BUG: scheduling while atomic: kworker/u12:0/7/0xfffffe01
[  536.215394] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #280!!!
[  537.227755] BUG: scheduling while atomic: kworker/u12:3/722/0x00000102
[  537.234965] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #282!!!
[  537.251488] softirq: huh, entered softirq 6 TASKLET
0000000048396bde with preempt_count 00000101, exited with 00000000?
[  537.262678] BUG: scheduling while atomic: kworker/u12:3/722/0x00000201
[  537.269960] BUG: workqueue leaked lock or atomic:
kworker/u12:3/0xfffffe00/722
[  537.269960]      last function: ieee80211_ba_session_work [mac80211]
[  537.284025] BUG: workqueue leaked lock or atomic:
kworker/u12:3/0xfffffe00/722
[  537.284025]      last function: ieee80211_ibss_leave [mac80211]
[  537.297583] BUG: scheduling while atomic: kworker/u12:3/722/0xfffffe01
[  537.343746] BUG: scheduling while atomic: kworker/u12:3/722/0x00000201
[  537.351032] BUG: workqueue leaked lock or atomic:
kworker/u12:3/0xfffffe00/722
[  537.351032]      last function: ieee80211_ba_session_work [mac80211]
[  537.365115] BUG: scheduling while atomic: kworker/u12:3/722/0xfffffe01
[  538.375733] BUG: scheduling while atomic: kworker/u12:0/7/0x00000102
[  538.392605] softirq: huh, entered softirq 6 TASKLET
0000000048396bde with preempt_count 00000101, exited with 00000000?
[  538.403822] BUG: scheduling while atomic: kworker/u12:0/7/0x00000201
[  538.410984] BUG: workqueue leaked lock or atomic: kworker/u12:0/0xfffffe=
00/7
[  538.410984]      last function: ieee80211_ba_session_work [mac80211]
[  538.424985] BUG: workqueue leaked lock or atomic: kworker/u12:0/0xfffffe=
00/7
[  538.424985]      last function: ieee80211_ba_session_work [mac80211]
[  538.438865] BUG: scheduling while atomic: kworker/u12:0/7/0xfffffe01
[  538.460354] BUG: scheduling while atomic: ksoftirqd/0/12/0x00000101
[  538.467953] softirq: huh, entered softirq 6 TASKLET
0000000048396bde with preempt_count 00000100, exited with 00000000?
[  538.631875] BUG: scheduling while atomic: ksoftirqd/5/39/0x00000103
[  538.639025] softirq: huh, entered softirq 2 NET_TX 00000000cca7c5d3
with preempt_count 00000100, exited with fffffffe?
[  539.508955] BUG: scheduling while atomic: NetworkManager/625/0x00000403
[  539.525507] BUG: scheduling while atomic: NetworkManager/625/0xfffffbff
[  542.849869] BUG: scheduling while atomic: NetworkManager/625/0x00000203
[  542.866840] BUG: scheduling while atomic: NetworkManager/625/0xfffffdff
[  543.508184] BUG: scheduling while atomic: NetworkManager/625/0x00000403
[  543.523724] BUG: scheduling while atomic: NetworkManager/625/0xfffffbff
[  543.582356] BUG: scheduling while atomic: NetworkManager/625/0x00000403
[  543.590206] WARNING: CPU: 2 PID: 625 at net/core/skbuff.c:665
skb_release_head_state+0x10c/0x120
[  543.599396] ---[ end trace a78168b0d15c7048 ]---
[  543.604213] WARNING: CPU: 2 PID: 625 at net/core/skbuff.c:665
skb_release_head_state+0x10c/0x120
[  543.613516] ---[ end trace a78168b0d15c7049 ]---
[  543.618313] WARNING: CPU: 2 PID: 625 at net/core/skbuff.c:665
skb_release_head_state+0x10c/0x120
[  543.627533] ---[ end trace a78168b0d15c704a ]---
[  543.632440] WARNING: CPU: 2 PID: 625 at net/core/skbuff.c:665
skb_release_head_state+0x10c/0x120
[  543.641624] ---[ end trace a78168b0d15c704b ]---
[  543.646395] BUG: scheduling while atomic: NetworkManager/625/0xfffffbff
[  543.653378] BUG: scheduling while atomic: kworker/2:1/44/0x00000505
[  543.660273] ------------[ cut here ]------------
[  543.665037] WARNING: CPU: 2 PID: 44 at kernel/time/timer.c:1420
call_timer_fn+0x1f8/0x200
[  543.673596] ---[ end trace a78168b0d15c704c ]---
[  543.687399] BUG: scheduling while atomic: swapper/2/0/0x00000504
[  543.693876] bad: scheduling from the idle thread!

Then unit reboots.

If I turn on auto-connect, and boot with the device already attached,
I can see the panic, from serial output:

[   23.278662] BUG: scheduling while atomic: NetworkManager/722/0x00000203
[   23.286079] WARNING: CPU: 1 PID: 722 at
kernel/rcu/tree_plugin.h:297 rcu_note_context_switch+0x50/0x540
[   23.296285] ---[ end trace 60819f07c492dc1c ]---
[   23.382446] BUG: scheduling while atomic: NetworkManager/722/0x00000505
[   23.389654] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #202!!!
[   23.397965] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #202!!!
[   23.406289] WARNING: CPU: 1 PID: 0 at kernel/rcu/tree.c:624
rcu_eqs_enter.isra.0+0x128/0x130
[   23.415092] ---[ end trace 60819f07c492dc1d ]---
[   29.410485] Kernel panic - not syncing: stack-protector: Kernel
stack is corrupted in: __schedule+0x910/0x910
[   29.420717] CPU: 1 PID: 722 Comm: NetworkManager Tainted: G
W  OE     5.10.120-tegra #1
[   29.429584] Hardware name: Unknown NVIDIA Orin Nano Developer
Kit/NVIDIA Orin Nano Developer Kit, BIOS 4.1-33958178 08/01/2023
[   29.441313] Call trace:
[   29.443843]  dump_backtrace+0x0/0x1d0
[   29.447614]  show_stack+0x30/0x40
[   29.451025]  dump_stack+0xd8/0x138
[   29.454519]  panic+0x17c/0x384
[   29.457661]  __stack_chk_fail+0x30/0x40
[   29.461608]  schedule+0x0/0x110
[   29.464837]  schedule+0x78/0x110
[   29.468158]  __arm_lpae_dma_sync+0x1e0/0x200
[   29.472550]  __arm_lpae_dma_sync+0x14c/0x200
[   29.476951]  __arm_lpae_dma_sync+0x14c/0x200
[   29.481342]  __arm_lpae_dma_sync+0x14c/0x200
[   29.485735]  arm_lpae_dma_sync+0x54/0x80
[   29.489771]  arm_smmu_dma_sync+0x40/0x70
[   29.493805]  __iommu_map+0x138/0x250
[   29.497479]  _iommu_map+0x70/0xd0
[   29.500892]  0x80
[   29.502879] SMP: stopping secondary CPUs
[   29.506918] Kernel Offset: 0x2ff010360000 from 0xffff800010000000
[   29.513177] PHYS_OFFSET: 0xffffb7a9c0000000
[   29.517465] CPU features: 0x08040006,4a80aa38
[   29.521933] Memory Limit: none
[   29.536986] ---[ end Kernel panic - not syncing: stack-protector:
Kernel stack is corrupted in: __schedule+0x910/0x910 ]---


> The rt2800 driver wasn't modified for ages. It's rater stable, but
> perhaps there are issues in other involved modules i.e. mac80211.
>
> Regards
> Stanislaw


Thanks!
Rick
