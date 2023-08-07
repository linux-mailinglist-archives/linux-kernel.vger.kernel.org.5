Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2FD772A4E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjHGQQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHGQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:16:32 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B4B10C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:16:31 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a78a29bca3so1444063b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691424991; x=1692029791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI9lCyYaVLODm6yBF1avYe6Q+YXmnQB4pXM9V+w2GqI=;
        b=bUItKTrEf3PRwie2sR5D13cHP88i5n1/BUWXxLBkxbK3icXEUTXSfe+cKgloaoxDZA
         1IcHvTQPchviNvqMpE3ZWNgbMAWVrHGOBzWZ6cJ/CttRvBZihByyxjmq4kpqL7RBo4lU
         Xkm844y4lwlT7Ssb/f8eM2MaLooBp89VIrCtV3FlkmsHClhzouQzNcFSzw5uf34cxBtq
         zMfvZP7obfp+OKWascCg/oIm3X06XYlG092GWY19LU0QGkdNX4jGPyCrsYpu72djj18y
         tUCY4FkxKILyLLawx+GgTsI6IVMX1yb92LCE0HpQYzuWa0UUKWIsvnBEo33p11N0qZrY
         hVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691424991; x=1692029791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI9lCyYaVLODm6yBF1avYe6Q+YXmnQB4pXM9V+w2GqI=;
        b=CF0cjvEMBNkd7xKDUdqAmqnOnP4+lEF8C4PPa7sRNIIorUn0XpSAmH1NGV7T5hWiPK
         9+AKBA7EP6DzXoBGvJnf9eBSP5lT0Jiu+RKKfKj85GdCzMn0GfNYrurn+W8AqAuG5fJW
         3JYBDGPFgVIjJNZ5AuVS2QGcgRbgaoYVo7dlbc6ylRL2c38gOrvuwNN1oB/zx2LLbCHn
         SLowTcsoGosdaxbLTEFJQyCKaJKRi7Sosvyersvc6iYdn+brw2gbM8MrfxjL6mZ7B3G0
         xQunDzhbANv6Ynr7sCx50TjFgX4Mo40FhKU4sF139qhjbUFd1BwomsDQ6xkkDlURjUR6
         heAQ==
X-Gm-Message-State: AOJu0YzT0yvUfzKk8j9D5vEPY5Xx5SMefFjT5zBST+w361pb+yjDaDSa
        bd1iyPkcfk1Y//PlZrljEkaAZ9K5tc4YRIFJlIu5jw==
X-Google-Smtp-Source: AGHT+IFB0XrJ8CL9e/DkqGjiBbm//FuJBQT/I0BwAypIv2vosUrZp0mjdohNdwcbYwhkCe0A3mGq2Hw60KoAMXRy+Ps=
X-Received: by 2002:a05:6358:590f:b0:130:e0a9:a7b4 with SMTP id
 g15-20020a056358590f00b00130e0a9a7b4mr9097775rwf.13.1691424990475; Mon, 07
 Aug 2023 09:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com>
 <2023080743-amendable-moonlit-15b7@gregkh> <CAFqe=zJ9uRTVG=jny2PzUrrFGW2E_mZrGKF-3YMRkjzMUdu_7A@mail.gmail.com>
 <CAKwvOd=gJO93_eqUcR6VD8n+eqxL7-aG5D7AnAgG1ki1N1ms0g@mail.gmail.com>
In-Reply-To: <CAKwvOd=gJO93_eqUcR6VD8n+eqxL7-aG5D7AnAgG1ki1N1ms0g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Aug 2023 09:16:19 -0700
Message-ID: <CAKwvOdm-0+0PieK4KMwuGeW4Y-3+JydRMN+q9Upn5253A_QfoQ@mail.gmail.com>
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

On Mon, Aug 7, 2023 at 9:15=E2=80=AFAM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On Sun, Aug 6, 2023 at 11:21=E2=80=AFPM Jannik Gl=C3=BCckert
> <jannik.glueckert@gmail.com> wrote:
> >
> > Hi Greg,
> >
> > our kernel uses the Fedora config and has a homeopathic patchset on
> > top of upstream - see
> > https://gitweb.gentoo.org/proj/linux-patches.git/tree/?h=3D6.4 except
> > the 50** patches.
> > Namely we don't touch cpufreq or pm.
> >
> > > Comm: cat Tainted: P
> >
> > I am not using any out of tree modules, the kernel switches to
> > Tainted: P on the first CFI violation.
>
> Thanks for the report.
> Let's track this in
> https://github.com/ClangBuiltLinux/linux/issues/1901
> (You can use the MAINTAINERS file to see issue trackers via the `B:`
> symbol used by various parts of the tree).

Heh, while doing my morning email scrub, it looks like a patch has
already been sent (a few minutes ago):
https://lore.kernel.org/all/20230807-amd-pstate-cfi-v1-1-0263daa13bc3@weiss=
schuh.net/

>
> >
> > Regards
> > Jannik
> >
> > Am Mo., 7. Aug. 2023 um 08:03 Uhr schrieb Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>:
> > >
> > > On Mon, Aug 07, 2023 at 06:55:49AM +0700, Bagas Sanjaya wrote:
> > > > Hi,
> > > >
> > > > I notice a bug report on Bugzilla [1]. Quoting from it:
> > > >
> > > > > On kernel 6.4.7, with amd_pstate=3Dactive, with a Ryzen 7700X
> > > > > I get a Clang CFI violation when reading /sys/devices/system/cpu/=
amd_pstate/status
> > > > >
> > > > > This is reproduceable with every read, I have only tried with amd=
_pstate=3Dactive
> > > > >
> > > > > With the following CFI and Clang configs, Clang 16.0.6
> > > > > CONFIG_CFI_CLANG=3Dy
> > > > > CONFIG_CFI_PERMISSIVE=3Dy
> > > > > CONFIG_LTO_CLANG=3Dy
> > > > > CONFIG_LTO_CLANG_THIN=3Dy
> > > > >
> > > > > Below is the full call trace, let me know if you need a trace wit=
h debug info.
> > > > >
> > > > > [ 4947.849350] CFI failure at dev_attr_show+0x24/0x60 (target: sh=
ow_status+0x0/0x70; expected type: 0x8651b1de)
> > > > > [ 4947.849358] WARNING: CPU: 2 PID: 16519 at dev_attr_show+0x24/0=
x60
> > > > > [ 4947.849360] Modules linked in: binfmt_misc nf_conntrack_netbio=
s_ns nf_conntrack_broadcast wireguard curve25519_x86_64 libcurve25519_gener=
ic ip6_udp_tunnel udp_tunnel snd_seq_dummy snd_hrtimer snd_seq rfcomm joyde=
v uhid xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_con=
ntrack_tftp nft_fib_inet nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_reject_inet =
nf_reject_ipv6 nf_reject_ipv4 nft_reject nft_ct nft_chain_nat bridge 8021q =
mrp garp stp llc nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table=
_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_d=
efrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_se=
t nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filt=
er ip_tables bnep vfat fat amdgpu snd_hda_codec_realtek snd_hda_codec_gener=
ic snd_hda_codec_hdmi snd_hda_intel mt7921e vfio_pci intel_rapl_msr mt7921_=
common intel_rapl_common mt76_connac_lib edac_mce_amd vfio_pci_core mt76 vf=
io_iommu_type1 vfio kvm_amd iommufd iommu_v2 snd_usb_audio
> > > > > [ 4947.849379]  snd_intel_dspcfg gpu_sched snd_intel_sdw_acpi mac=
80211 drm_suballoc_helper snd_usbmidi_lib i2c_algo_bit drm_ttm_helper snd_h=
da_codec btusb ttm btrtl libarc4 btmtk snd_hda_core snd_rawmidi kvm snd_seq=
_device drm_display_helper btintel snd_hwdep mc btbcm irqbypass cfg80211 ce=
c snd_pcm asus_nb_wmi bluetooth eeepc_wmi snd_timer asus_wmi drm_kms_helper=
 ledtrig_audio sparse_keymap snd gpio_amdpt platform_profile gpio_generic d=
rm_buddy rfkill soundcore rapl i2c_piix4 wmi_bmof pcspkr k10temp lm92 nct67=
75_core hwmon_vid fuse loop dm_crypt crct10dif_pclmul polyval_clmulni polyv=
al_generic ghash_clmulni_intel nvme sp5100_tco ccp r8169 nvme_core nvme_com=
mon video wmi sunrpc
> > > > > [ 4947.849398] CPU: 2 PID: 16519 Comm: cat Tainted: P            =
       6.4.7-gentoo-dist-hardened #1
> > >
> > > Can't do much about this kernel, we don't know what's really in it,
> > > sorry.
> > >
> > > greg k-h
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
