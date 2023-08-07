Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4E772A4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjHGQP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjHGQP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:15:26 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7AA10CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:15:24 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63cfe6e0c32so33174236d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691424924; x=1692029724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBYooyeWK7k6BJIomcF3V8ANL7Caa0RySBNuNDEDGk4=;
        b=11qzlmUGwi0zoRhNVQFSGqPgVXSOIJlZMoVTzN/0j2NyBTwaXma4OX4foNKLkGHP7g
         3B4DH3ZF6ElSFg1Lhf87haPAfS47HG8RcaFqw1hyyjvEDbALyQWCk1rBUJXMy9MQsIWo
         ii5L5aHrwJZzI9Os1QENa5TaKl8xbv2aMuwYs+yZZvYAO+attk7a/hvYeGbFlbbLtmLi
         rGqWeIvJRND85m+PZR0ZfeKPDGb/MSfH804crSTP/Uh7BnaqW13tNQY6r0HOmz0HvDY1
         QHA8nsojx80q7pDbPgWtjVSAm8L1KkBt+r5WtjjKY2y03dR66rfOAHR7fl+51/xRIpYi
         p2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691424924; x=1692029724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBYooyeWK7k6BJIomcF3V8ANL7Caa0RySBNuNDEDGk4=;
        b=TV9XeArIxzZ7ODGNYwh73/4TMCXuBvOpcHfsLYFDPvZZH8WLg+Mi7iKWVaxZLWW2Tc
         jo0Pi6uqttHGoss1zVGTaEMcqp2SLGYRoaX136w4t7pI2PNiDTY+r/66jN7rPBV23mgn
         GVk0T31XCrCEOumyfjTOjDz7hKxlHfKUjpabN8fQgQXWn8+zryOE0cXu65BRZEZjjk/b
         IapxH2N865mcBmHhiwSk+FZXenrHFk3NBbi49bbtPg5FqgnRtGz9DOvKq1mUnOZc4QYP
         NcQ4/Gd/ethhjycrL1Dlzmcr1wFCdzvDVxE7F4BZQcST1OmBTys3lMRwWxZ4+31rAMiK
         6PrA==
X-Gm-Message-State: AOJu0YzNOGdz2hdr3wVCVjwfM3Q5aNN0Jo2OdHD2BNVNhlHj5UNa4ldw
        Zgar29/UmTbhBJVRqD05l/8HWBJ60I4BQZUl9LZExg==
X-Google-Smtp-Source: AGHT+IGJsPnES8PM+XJgKXF3Z501OznIjg6TcJH0IghWcT/mqUa+UKk+1ETVfctEFGNE2xojsO29Lyk8Zq0nbmlOhFA=
X-Received: by 2002:a05:6214:3018:b0:63d:1aed:72ee with SMTP id
 ke24-20020a056214301800b0063d1aed72eemr10531003qvb.64.1691424923690; Mon, 07
 Aug 2023 09:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com>
 <2023080743-amendable-moonlit-15b7@gregkh> <CAFqe=zJ9uRTVG=jny2PzUrrFGW2E_mZrGKF-3YMRkjzMUdu_7A@mail.gmail.com>
In-Reply-To: <CAFqe=zJ9uRTVG=jny2PzUrrFGW2E_mZrGKF-3YMRkjzMUdu_7A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Aug 2023 09:15:12 -0700
Message-ID: <CAKwvOd=gJO93_eqUcR6VD8n+eqxL7-aG5D7AnAgG1ki1N1ms0g@mail.gmail.com>
Subject: Re: Fwd: CFI violation when reading amd_pstate/status
To:     =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Huang Rui <ray.huang@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM Build Support <llvm@lists.linux.dev>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 6, 2023 at 11:21=E2=80=AFPM Jannik Gl=C3=BCckert
<jannik.glueckert@gmail.com> wrote:
>
> Hi Greg,
>
> our kernel uses the Fedora config and has a homeopathic patchset on
> top of upstream - see
> https://gitweb.gentoo.org/proj/linux-patches.git/tree/?h=3D6.4 except
> the 50** patches.
> Namely we don't touch cpufreq or pm.
>
> > Comm: cat Tainted: P
>
> I am not using any out of tree modules, the kernel switches to
> Tainted: P on the first CFI violation.

Thanks for the report.
Let's track this in
https://github.com/ClangBuiltLinux/linux/issues/1901
(You can use the MAINTAINERS file to see issue trackers via the `B:`
symbol used by various parts of the tree).

>
> Regards
> Jannik
>
> Am Mo., 7. Aug. 2023 um 08:03 Uhr schrieb Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>:
> >
> > On Mon, Aug 07, 2023 at 06:55:49AM +0700, Bagas Sanjaya wrote:
> > > Hi,
> > >
> > > I notice a bug report on Bugzilla [1]. Quoting from it:
> > >
> > > > On kernel 6.4.7, with amd_pstate=3Dactive, with a Ryzen 7700X
> > > > I get a Clang CFI violation when reading /sys/devices/system/cpu/am=
d_pstate/status
> > > >
> > > > This is reproduceable with every read, I have only tried with amd_p=
state=3Dactive
> > > >
> > > > With the following CFI and Clang configs, Clang 16.0.6
> > > > CONFIG_CFI_CLANG=3Dy
> > > > CONFIG_CFI_PERMISSIVE=3Dy
> > > > CONFIG_LTO_CLANG=3Dy
> > > > CONFIG_LTO_CLANG_THIN=3Dy
> > > >
> > > > Below is the full call trace, let me know if you need a trace with =
debug info.
> > > >
> > > > [ 4947.849350] CFI failure at dev_attr_show+0x24/0x60 (target: show=
_status+0x0/0x70; expected type: 0x8651b1de)
> > > > [ 4947.849358] WARNING: CPU: 2 PID: 16519 at dev_attr_show+0x24/0x6=
0
> > > > [ 4947.849360] Modules linked in: binfmt_misc nf_conntrack_netbios_=
ns nf_conntrack_broadcast wireguard curve25519_x86_64 libcurve25519_generic=
 ip6_udp_tunnel udp_tunnel snd_seq_dummy snd_hrtimer snd_seq rfcomm joydev =
uhid xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_connt=
rack_tftp nft_fib_inet nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_reject_inet nf=
_reject_ipv6 nf_reject_ipv4 nft_reject nft_ct nft_chain_nat bridge 8021q mr=
p garp stp llc nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_m=
angle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_def=
rag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set =
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter=
 ip_tables bnep vfat fat amdgpu snd_hda_codec_realtek snd_hda_codec_generic=
 snd_hda_codec_hdmi snd_hda_intel mt7921e vfio_pci intel_rapl_msr mt7921_co=
mmon intel_rapl_common mt76_connac_lib edac_mce_amd vfio_pci_core mt76 vfio=
_iommu_type1 vfio kvm_amd iommufd iommu_v2 snd_usb_audio
> > > > [ 4947.849379]  snd_intel_dspcfg gpu_sched snd_intel_sdw_acpi mac80=
211 drm_suballoc_helper snd_usbmidi_lib i2c_algo_bit drm_ttm_helper snd_hda=
_codec btusb ttm btrtl libarc4 btmtk snd_hda_core snd_rawmidi kvm snd_seq_d=
evice drm_display_helper btintel snd_hwdep mc btbcm irqbypass cfg80211 cec =
snd_pcm asus_nb_wmi bluetooth eeepc_wmi snd_timer asus_wmi drm_kms_helper l=
edtrig_audio sparse_keymap snd gpio_amdpt platform_profile gpio_generic drm=
_buddy rfkill soundcore rapl i2c_piix4 wmi_bmof pcspkr k10temp lm92 nct6775=
_core hwmon_vid fuse loop dm_crypt crct10dif_pclmul polyval_clmulni polyval=
_generic ghash_clmulni_intel nvme sp5100_tco ccp r8169 nvme_core nvme_commo=
n video wmi sunrpc
> > > > [ 4947.849398] CPU: 2 PID: 16519 Comm: cat Tainted: P              =
     6.4.7-gentoo-dist-hardened #1
> >
> > Can't do much about this kernel, we don't know what's really in it,
> > sorry.
> >
> > greg k-h



--=20
Thanks,
~Nick Desaulniers
