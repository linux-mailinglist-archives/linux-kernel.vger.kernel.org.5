Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2B9772A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjHGQRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjHGQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:17:46 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCE210EC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:17:45 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-56cca35d8c3so2420955eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691425065; x=1692029865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOMQKdmZShAbrMOCi8V+xGenD6h4CfjCRpwadFereic=;
        b=3PEqRyFS+a1U3orlxEi+YML6SOG137afBBLPEYzEiHPo2p/DTaGfS4Hx5jNRreMRrO
         q+JneVHBLoLRmu7hFmRt8nRLkHybDNwZKj+pqqAZhCG7W+a9ki256RwbrK/ETg3Wj6VM
         zf+JR/4N7NFsZE8wEiQ9vD6ClFeLB0VwjJFGafE1JdlCDtGVRG6LjQLfEE9fV/DF1LKs
         ob0LOcliVh7f8vWqKeqE/M0UcrEsLxlTLR1fJP3q3NEcveL//bAn8/tUvOGV02RaulQ0
         7oOdXMcLBuTclIv7SJ1lqrbIbA0XLHmJvbpCRc2LydVYgoOgPnt8GO+63Bv1njeOHgSW
         8X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425065; x=1692029865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOMQKdmZShAbrMOCi8V+xGenD6h4CfjCRpwadFereic=;
        b=ErCaClmObD9OX0i4JTcmnBUoSvtrY97U7SxFST6qmuRTN5PrXl98jlCGGfRO7Z8aJp
         rZmZc2/JB7hVoHXMDd+TuiapubVoUPs6G/QfkcibQoo9QK5LMZbN254TLB9FULxYBLt3
         ISK8vA76vWbgdsUglp72SKAxT4adkLwy821K+1yc1WwlfehvSI+zBG/WRgNyNznpiS3s
         lc/+04hgzA1s+c81joNO+dEgcn8oAuOgjP4f9yDF0mla7nLBcpHGxxo9hhjSXQY1dcbh
         SUex/H6nPA8ENrLhYO91s6zT6NHtuPGsQcwfGTq8J4i3thqSwfciYZQ786KysE3TfnTX
         GFPQ==
X-Gm-Message-State: AOJu0Yxl1SgwrABA/tw1h3fV7mvF5Ng9ufFr+No9akSQ4LfJJSaH97m2
        zMGfN6WHG3X9z3K60gQk7EakF4UYqD7O5TopUuwCAA==
X-Google-Smtp-Source: AGHT+IGTvk7ouK4vslL42TMdt+8hzcgzNzCUejYDraANLVWCBcGejWMNacBOOb+oEn7QTC7i9fbWey9ZgBxigSCUZ7k=
X-Received: by 2002:a05:6358:f57:b0:139:c7cb:77d7 with SMTP id
 c23-20020a0563580f5700b00139c7cb77d7mr2159770rwj.13.1691425064908; Mon, 07
 Aug 2023 09:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com>
 <2023080743-amendable-moonlit-15b7@gregkh> <CAFqe=zJ9uRTVG=jny2PzUrrFGW2E_mZrGKF-3YMRkjzMUdu_7A@mail.gmail.com>
In-Reply-To: <CAFqe=zJ9uRTVG=jny2PzUrrFGW2E_mZrGKF-3YMRkjzMUdu_7A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Aug 2023 09:17:34 -0700
Message-ID: <CAKwvOdm0Tv0=KGdhVwuJX+8N-Dgx+kzuPy6zCBsV1kOc+6b+qQ@mail.gmail.com>
Subject: Re: Fwd: CFI violation when reading amd_pstate/status
To:     =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM Build Support <llvm@lists.linux.dev>
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

Can you tell us more about your distro? Is it public? Is it built with clan=
g?

>
> > Comm: cat Tainted: P
>
> I am not using any out of tree modules, the kernel switches to
> Tainted: P on the first CFI violation.
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
