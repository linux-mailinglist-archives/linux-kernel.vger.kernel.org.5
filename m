Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC02771A24
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjHGGVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjHGGVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:21:51 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD958F9;
        Sun,  6 Aug 2023 23:21:49 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76ce66110edso223232685a.0;
        Sun, 06 Aug 2023 23:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691389309; x=1691994109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/xzphQt9ZA3tfB0IgnozXtrvZ3dycV/F1nyKSxUP+c=;
        b=DsdrjiWjRoBJcOjvZX7s9f3+IufHjSXXdeWbqR53fRwfhu6P2Y1+KMo6z6l9Qxa79S
         +m8o0/aKKU9pqFCMcGGvVU7sClSugF3T1f2habfV5+TLvFWoFsXh3ncBp/nsO3mE8/rT
         1rOiMU/yQZYAdCYFAblq8v9rzNuj44TzkoV0NDogHksF4FqZ2nYBoeaqS7foY5w2JXjm
         4Jl3Wb9v+Id5nT0fMDbl1vfVgJG8XB2TnmixC7PEQFcNdVspusuqwpeBRnsMU0IuAG6i
         sTGngQslnjMy0kQNb5lXzDkh3KMYNfEH8+A5LSf5LUZrWX+b00tQOSFejaOEAcKiW/d5
         JKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691389309; x=1691994109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/xzphQt9ZA3tfB0IgnozXtrvZ3dycV/F1nyKSxUP+c=;
        b=aJeahy1nWKIezZ8e11esNeaEjauO+5iOPhHr/ejPIhfYdo3dSYcuZgAyoAg5IFtJMZ
         4xP0DNrwDeWMHc0g0pQdWPiX77jepo9/Of78ViIhI7fOnCnGpr+X3jhSsVftNjX8xwwO
         da1YiZFMKpHeVLZ8wCWvqJqqwVhvRcWZ7zBUTzs8KXspJrLvTWlVyX8V3qUgrltiNjf1
         adUYbJQeND+eDWkQxGFp9mhpGU2VrVk7HS7EcB+26vxK94feFV3EI0wahrHnIxttEfOm
         JJgRwfoXFJnJ1glhUrjDZyJ6tDst1TX6ykwPMC3EOOeyoTb4uBgQp6ncSTBRKjjoVT34
         TzFw==
X-Gm-Message-State: AOJu0YzrOGooKFPxDGRoBV9oxlok4I1T/rTno9qI41UjneKGeKwY3lQL
        4RyAxC7IXBrrai/2F0+Rf43VybbmvX23e4aLhtw=
X-Google-Smtp-Source: AGHT+IGEY9lcuMnrZyJyz9T4XlH1X5goYL+6ea0KD1no/zh1MLsPLn6h60M8gDc0fetXmoKpswVgqBAW2btJQDfijd8=
X-Received: by 2002:a05:620a:171f:b0:76c:b7f0:2b94 with SMTP id
 az31-20020a05620a171f00b0076cb7f02b94mr9382662qkb.7.1691389308674; Sun, 06
 Aug 2023 23:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com> <2023080743-amendable-moonlit-15b7@gregkh>
In-Reply-To: <2023080743-amendable-moonlit-15b7@gregkh>
From:   =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>
Date:   Mon, 7 Aug 2023 08:21:37 +0200
Message-ID: <CAFqe=zJ9uRTVG=jny2PzUrrFGW2E_mZrGKF-3YMRkjzMUdu_7A@mail.gmail.com>
Subject: Re: Fwd: CFI violation when reading amd_pstate/status
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Huang Rui <ray.huang@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux LLVM Build Support <llvm@lists.linux.dev>
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

Hi Greg,

our kernel uses the Fedora config and has a homeopathic patchset on
top of upstream - see
https://gitweb.gentoo.org/proj/linux-patches.git/tree/?h=3D6.4 except
the 50** patches.
Namely we don't touch cpufreq or pm.

> Comm: cat Tainted: P

I am not using any out of tree modules, the kernel switches to
Tainted: P on the first CFI violation.

Regards
Jannik

Am Mo., 7. Aug. 2023 um 08:03 Uhr schrieb Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> On Mon, Aug 07, 2023 at 06:55:49AM +0700, Bagas Sanjaya wrote:
> > Hi,
> >
> > I notice a bug report on Bugzilla [1]. Quoting from it:
> >
> > > On kernel 6.4.7, with amd_pstate=3Dactive, with a Ryzen 7700X
> > > I get a Clang CFI violation when reading /sys/devices/system/cpu/amd_=
pstate/status
> > >
> > > This is reproduceable with every read, I have only tried with amd_pst=
ate=3Dactive
> > >
> > > With the following CFI and Clang configs, Clang 16.0.6
> > > CONFIG_CFI_CLANG=3Dy
> > > CONFIG_CFI_PERMISSIVE=3Dy
> > > CONFIG_LTO_CLANG=3Dy
> > > CONFIG_LTO_CLANG_THIN=3Dy
> > >
> > > Below is the full call trace, let me know if you need a trace with de=
bug info.
> > >
> > > [ 4947.849350] CFI failure at dev_attr_show+0x24/0x60 (target: show_s=
tatus+0x0/0x70; expected type: 0x8651b1de)
> > > [ 4947.849358] WARNING: CPU: 2 PID: 16519 at dev_attr_show+0x24/0x60
> > > [ 4947.849360] Modules linked in: binfmt_misc nf_conntrack_netbios_ns=
 nf_conntrack_broadcast wireguard curve25519_x86_64 libcurve25519_generic i=
p6_udp_tunnel udp_tunnel snd_seq_dummy snd_hrtimer snd_seq rfcomm joydev uh=
id xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntra=
ck_tftp nft_fib_inet nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_reject_inet nf_r=
eject_ipv6 nf_reject_ipv4 nft_reject nft_ct nft_chain_nat bridge 8021q mrp =
garp stp llc nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_man=
gle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defra=
g_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set nf=
netlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter i=
p_tables bnep vfat fat amdgpu snd_hda_codec_realtek snd_hda_codec_generic s=
nd_hda_codec_hdmi snd_hda_intel mt7921e vfio_pci intel_rapl_msr mt7921_comm=
on intel_rapl_common mt76_connac_lib edac_mce_amd vfio_pci_core mt76 vfio_i=
ommu_type1 vfio kvm_amd iommufd iommu_v2 snd_usb_audio
> > > [ 4947.849379]  snd_intel_dspcfg gpu_sched snd_intel_sdw_acpi mac8021=
1 drm_suballoc_helper snd_usbmidi_lib i2c_algo_bit drm_ttm_helper snd_hda_c=
odec btusb ttm btrtl libarc4 btmtk snd_hda_core snd_rawmidi kvm snd_seq_dev=
ice drm_display_helper btintel snd_hwdep mc btbcm irqbypass cfg80211 cec sn=
d_pcm asus_nb_wmi bluetooth eeepc_wmi snd_timer asus_wmi drm_kms_helper led=
trig_audio sparse_keymap snd gpio_amdpt platform_profile gpio_generic drm_b=
uddy rfkill soundcore rapl i2c_piix4 wmi_bmof pcspkr k10temp lm92 nct6775_c=
ore hwmon_vid fuse loop dm_crypt crct10dif_pclmul polyval_clmulni polyval_g=
eneric ghash_clmulni_intel nvme sp5100_tco ccp r8169 nvme_core nvme_common =
video wmi sunrpc
> > > [ 4947.849398] CPU: 2 PID: 16519 Comm: cat Tainted: P                =
   6.4.7-gentoo-dist-hardened #1
>
> Can't do much about this kernel, we don't know what's really in it,
> sorry.
>
> greg k-h
