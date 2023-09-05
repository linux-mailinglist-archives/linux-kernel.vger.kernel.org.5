Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713327931C0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244753AbjIEWBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242220AbjIEWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:01:15 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E591EE9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 15:01:11 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1c0fa9dd74fso2455841fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 15:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693951271; x=1694556071; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbMLM6SesxsqKpQmRY/j/CiawnY/XhoFjQDyErU0tlY=;
        b=SAfuPJ5bP4f7qJuT2PREPGkVjz3Lj2hGlH7tO3L2Rvs42M9oDFS4SqbkMkybcUBHcG
         l9qteo2LE7hy9qbTzYgOaHPnR1eVTtkVK0idH8eIQp7aMhYWTFnN4ekMW4y5nlI+7c7h
         FO7SZdjMfyvBfyqrpeQc/VmKZ15bxZKTs99G9xlXsslOxWoE/C2Kei1gvvpXrCfB0z8g
         2A/1uIslJKUf1ynTD4usWGWniJFf6N7alC9wDJnq+C1kZeVOEI6WmYghzhcfA08Gv7Qn
         r7/iw/f+16NeDs2tfEcJl8joRipc+EP8WLjpQ8kAhpqsYDmy0Nn/cqCimO5W/A1yayZy
         3SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693951271; x=1694556071;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbMLM6SesxsqKpQmRY/j/CiawnY/XhoFjQDyErU0tlY=;
        b=atofGc4TZVSvAaMOkvkcQJ2YBGZ5JHyAHb9MRAo93AmxTdFuavyq8RxXw7grE8KtNg
         Gg2hfa5VhgfJEichop00iVBjIkEM1Vl6RPz9SLvuyhCWCSfoiVjaCCDCHQrFnSeQT64Z
         PlwaZP0CyvRCvviiRJtlMW/CDtmL+lcKed9B6IXvcrevuIpSbK4dhE/dVfEoOgzmpyQs
         iVPS2PB6h0sx2/jmAZSN0qZNSvgjKoH/Wbj6FRJBm/CgFHZH6+HTT02Asd/JKxSstozx
         r5oA/1TghdNm62xurvAcjAHAOhVEZE2KVZ1Q2w/jBGsF5He67j6GYFRuCPnDheHGRFeR
         ezNw==
X-Gm-Message-State: AOJu0YyBIwxUx2Icfo/cKL+M5Huag7N56ee12BKHL2my6d9qvAa5ucRI
        hx+8SiuqIpIIVk502VJ/MkUvKUXLQ1TbgwLKR1en2VDw
X-Google-Smtp-Source: AGHT+IHq1/UHHL8bZpJ0hQQNbUzXP2BiRZwArlZppLKIMlMxnJIwdr66Q+CbAaQGbhN5wj+DzRF1UA==
X-Received: by 2002:a05:6870:3329:b0:1c0:2e8f:17fd with SMTP id x41-20020a056870332900b001c02e8f17fdmr18178268oae.40.1693951271042;
        Tue, 05 Sep 2023 15:01:11 -0700 (PDT)
Received: from winterfell.papolivre.org (winterfell.papolivre.org. [2600:3c00:e000:341::1])
        by smtp.gmail.com with ESMTPSA id v49-20020a056870957100b001c03d1a519fsm7033244oal.39.2023.09.05.15.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 15:01:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14d:7224:8468:34c9:cf8b:3384:7414])
        by winterfell.papolivre.org (Postfix) with ESMTPSA id E8AC21C3AB0;
        Tue,  5 Sep 2023 19:01:07 -0300 (-03)
Date:   Tue, 5 Sep 2023 19:01:01 -0300
From:   Antonio Terceiro <antonio.terceiro@linaro.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: snd-cmipci oops during probe on arm64 (current mainline, pre-6.6-rc1)
Message-ID: <ZPelHaX/Lt++kkOm@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="odZTbvddu9YXMVg9"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--odZTbvddu9YXMVg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm using an arm64 workstation, and wanted to add a sound card to it. I bou=
ght
one who was pretty popular around where I live, and it is supported by the
snd-cmipci driver.

It's this one:

0005:02:00.0 Multimedia audio controller: C-Media Electronics Inc CMI8738/C=
MI8768 PCI Audio (rev 10)

After building a mailine kernel (post-v6.5, pre-rc1) on Debian testing arm64
with localmodconfig + CONFIG_SND_CMIPCI=3Dm, it crashes with "Unable to han=
dle
kernel paging request at virtual address fffffbfffe80000c", and the system
never finishes to boot. The login manager never shows up and the serial con=
sole
never gets to a login prompt. I observed the same issue on a 6.3 Debian ker=
nel,
after rebuilding with CONFIG_SND_CMIPCI=3Dm.

If I stop the module from being automatically loaded by adding
`blacklist snd-cmipci` to /etc/modprobe.d/snd-cmipci.conf (or if I
remove the card from the PCIe slot), I get the system to boot. But tring
to load the module manually causes the same crash (I only tested this
with the card on):

[  +4,501093] snd_cmipci 0005:02:00.0: stream 512 already in tree
[  +0,000155] Unable to handle kernel paging request at virtual address fff=
ffbfffe80000c
[  +0,007927] Mem abort info:
[  +0,002793]   ESR =3D 0x0000000096000006
[  +0,003743]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  +0,005307]   SET =3D 0, FnV =3D 0
[  +0,003049]   EA =3D 0, S1PTW =3D 0
[  +0,003134]   FSC =3D 0x06: level 2 translation fault
[  +0,004872] Data abort info:
[  +0,002873]   ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
[  +0,005479]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[  +0,005047]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  +0,000003] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000080519fe9000
[  +0,000004] [fffffbfffe80000c] pgd=3D000008051a979003, p4d=3D000008051a97=
9003, pud=3D000008051a97a003, pmd=3D0000000000000000
[  +0,000009] Internal error: Oops: 0000000096000006 [#1] SMP
[  +0,028142] Modules linked in: snd_cmipci(+) snd_mpu401_uart snd_opl3_lib=
 xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo xt_add=
rtype nft_compat br_netfilter nft_masq nft_chain_nat nf_nat nf_conntrack nf=
_defrag_ipv6 nf_defrag_ipv4 bridge stp llc nf_tables nfnetlink uvcvideo vid=
eobuf2_vmalloc videobuf2_memops uvc videobuf2_v4l2 videodev videobuf2_commo=
n snd_seq_dummy snd_hrtimer snd_seq qrtr rfkill overlay ftdi_sio usbserial =
snd_usb_audio snd_usbmidi_lib snd_pcm aes_ce_blk aes_ce_cipher snd_hwdep po=
lyval_ce snd_rawmidi polyval_generic snd_seq_device joydev snd_timer ghash_=
ce hid_generic gf128mul snd usbhid sha2_ce ipmi_ssif soundcore hid mc sha25=
6_arm64 ipmi_devintf arm_spe_pmu ipmi_msghandler sha1_ce sbsa_gwdt binfmt_m=
isc nls_ascii nls_cp437 vfat fat xgene_hwmon cppc_cpufreq arm_cmn arm_dsu_p=
mu evdev nfsd auth_rpcgss nfs_acl lockd grace dm_mod fuse loop efi_pstore d=
ax sunrpc configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 btrfs=
 efivarfs raid10 raid456 async_raid6_recov async_memcpy
[  +0,000142]  async_pq async_xor async_tx libcrc32c crc32c_generic xor xor=
_neon raid6_pq raid1 raid0 multipath linear md_mod nvme nvme_core ast t10_p=
i drm_shmem_helper xhci_pci drm_kms_helper xhci_hcd crc64_rocksoft crc64 dr=
m crc_t10dif usbcore crct10dif_generic igb crct10dif_ce crct10dif_common us=
b_common i2c_algo_bit i2c_designware_platform i2c_designware_core
[  +0,121670] CPU: 0 PID: 442 Comm: kworker/0:4 Not tainted 6.5.0+ #2
[  +0,006259] Hardware name: ADLINK AVA Developer Platform/AVA Developer Pl=
atform, BIOS TianoCore 2.04.100.07 (SYS: 2.06.20220308) 09/08/2022
[  +0,012506] Workqueue: events work_for_cpu_fn
[  +0,004353] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  +0,006953] pc : logic_inl+0xa0/0xd8
[  +0,003570] lr : snd_cmipci_probe+0x7a4/0x1140 [snd_cmipci]
[  +0,005578] sp : ffff80008287bc70
[  +0,003303] x29: ffff80008287bc70 x28: ffff08008af9d6a0 x27: 000000000000=
0000
[  +0,007128] x26: ffffc4818263c228 x25: 0000000000000000 x24: 000000000000=
0001
[  +0,007127] x23: ffff07ff81a9e000 x22: ffff07ff81a9e0c0 x21: ffff08008af9=
d080
[  +0,007127] x20: ffffc4818263c000 x19: 0000000000000000 x18: ffffffffffff=
ffff
[  +0,007127] x17: 0000000000000000 x16: ffffc4819ac3cd38 x15: ffff80008287=
ba80
[  +0,007127] x14: 0000000000000001 x13: ffff80008287bbc4 x12: 000000000000=
0000
[  +0,007126] x11: ffff07ff834616d0 x10: ffffffffffffffc0 x9 : ffffc4819a61=
dd18
[  +0,007127] x8 : 0000000000000228 x7 : 0000000000000001 x6 : 000000000000=
00ff
[  +0,007127] x5 : ffffc4819adb7998 x4 : 0000000000000000 x3 : 000000000000=
00ff
[  +0,007127] x2 : 0000000000ffbffe x1 : 000000000000000c x0 : fffffbfffe80=
000c
[  +0,007126] Call trace:
[  +0,002436]  logic_inl+0xa0/0xd8
[  +0,003221]  local_pci_probe+0x48/0xb8
[  +0,003744]  work_for_cpu_fn+0x24/0x40
[  +0,003741]  process_one_work+0x170/0x3a8
[  +0,004002]  worker_thread+0x23c/0x460
[  +0,003742]  kthread+0xe8/0xf8
[  +0,003047]  ret_from_fork+0x10/0x20
[  +0,003569] Code: d2bfd000 f2df7fe0 f2ffffe0 8b000020 (b9400000)=20
[  +0,006083] ---[ end trace 0000000000000000 ]---

Because this sound card chipset seems to be popular (pretty much all PCI ca=
rds
I can find to buy locally use that), I'm thinking this might be specific to
arm64, otherwise someone would have seen this before.

--odZTbvddu9YXMVg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEst7mYDbECCn80PEM/A2xu81GC94FAmT3pRkACgkQ/A2xu81G
C96OqRAA3PS1YXRHBd/MjigSfoZAYXai7apBSwpzVbgPmWgTN+5RB7XDkEefGIbM
0+g9B4096yKrGQPdc8qkvLmtxPtOVznycTpjrcKK5ZBPC8FcAX4HNeKIQPptI+HM
w39G+CGYQd1kwc/hYL+7qPHE0qLr34Yb3zk1mMKw2Q2HBGQaNnQ5mBhSMJxnY8xw
WXvD+6lO9lQA3RO+HubtrRNcaFRfEmKKLpVuPFSksm6gb7wiESqilWOHXIC2e9kk
r8ijn8xOp9YDt+gbp2+bSNUhUW3Db3E4/o+7wXKzPWDqWifTd4iz3oA2VClO8Ik1
cqZLcoo+Gqa/0Q3YWEYpZEa8KlONr4bNjveiC+8BR74eJb74yI/o5mzWHJYTwbvD
w8X7ETgfglXdckgweKTZ4GMNWpdTh6vspkcVL0RWE8Dov/EmiaJOQnTEC8W/ZfYD
DJI6818+iZ5fzteUJM73cRm9/aM0Pg6LRiLL5XvQ15siKhv99HFmbgZhgnB5dxkn
MSaGsMjdq7YZXcoyaQi2HOpDIiPrpUlJOqGqpQkRmt5PNCvnG382g41JSvt/gjGU
0zUWNX/J3p5VRD2ycWppH0GE/bTtgPcWBavhfx9u9toS+Sv13o3XptZvMH9Nnqby
wjZAm6SR7MHYGpFG0kLzYQWGFzOVSwBQ1JqB/WwhkicQEA819Ew=
=GsHt
-----END PGP SIGNATURE-----

--odZTbvddu9YXMVg9--
