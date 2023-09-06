Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B299794335
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbjIFSiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244041AbjIFShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:37:47 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC45D1BE4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:36:48 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a9b41ffe11so92364b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694025408; x=1694630208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R41xuxNyeQCab4RBKOEKbIOBQAQArqGWfJ+WVPjIFUs=;
        b=JLYPQpNO2EQk4MTLIuqgZRe04IQ+AFDokvNDJcDFZZM6H7EZ7pX6rGOSk7LzD78gaj
         eDCJYVyOId1tLb0zyknH1kZwhsgWbQ2ul/4pbhZtEMxk9sfwqWuHU24zoIxJi72s1A8n
         nwfccWdKCzttIPzfPMaRn/hYB3G6aZNC3TzwMOR1SmMznfo5cwANOLEUfpGrp/KCScui
         VK/5KH5AbYbmEj6XGRdkYPSH883N8QxteTkRXVPLYJpgH0Bst7WIJmIKn2CeXRvgvDsf
         i6MnnZjPsQapmuuLlPjdU1oduiTbHAVEvIm97Pw0fWSaBbgS0KPEklYR1N7Vap8ACzKd
         KnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694025408; x=1694630208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R41xuxNyeQCab4RBKOEKbIOBQAQArqGWfJ+WVPjIFUs=;
        b=FkG6SKeTTnUNgzTqHz76eMqjArKXLjtjz8gxXLOCST9TmDTrh0BQ5cV4ZeIP7a7EUB
         3xxL0DZQbA2AX0WaOm3Yw8tcgw5sjTglXbGvzzQiJ6Yvc0AVBR7VbJUu5iQ/04CowZA2
         b5BLo6igAJE3DNvjppfVBgUoQsup6MzelYAWcxLq86rwkOFozenVgHDT/jOXKH7k8kDp
         g0jj+rxGPUi/f27zghzdbuyOl7yismIkNpElptXsvhcnLyPsWYJZy8F6tuQFjwXeDyj0
         usB1kFBnqRY7lBRQNU8ZkRDWaA+7FBqrSkfyzDxbPDbr68dlg5yTl06HxqCmBS9PSH66
         5XwA==
X-Gm-Message-State: AOJu0YxB4ti9x0EnIl43gajhWKUgfEYINS3LNElCpDkLsOYyE4X93xDM
        X4l5S9P767md2gGt0iiL1vJnj64Yx25uCg1gguMeiS0k
X-Google-Smtp-Source: AGHT+IG9BploV0dwCcQBy3Ie/w4dFRaPVVu7bV3WtqyHoujw3JT0PQHSDxMiMRcpSSeN64E4ac/5zw==
X-Received: by 2002:a05:6808:2a47:b0:3a9:cfb5:4637 with SMTP id fa7-20020a0568082a4700b003a9cfb54637mr16328313oib.38.1694025408158;
        Wed, 06 Sep 2023 11:36:48 -0700 (PDT)
Received: from winterfell.papolivre.org (winterfell.papolivre.org. [2600:3c00:e000:341::1])
        by smtp.gmail.com with ESMTPSA id t8-20020a056808158800b003a76d7f596esm4918939oiw.54.2023.09.06.11.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:36:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14d:7224:8468:34c9:cf8b:3384:7414])
        by winterfell.papolivre.org (Postfix) with ESMTPSA id 7ADFA1C3AB0;
        Wed,  6 Sep 2023 15:36:46 -0300 (-03)
Date:   Wed, 6 Sep 2023 15:36:40 -0300
From:   Antonio Terceiro <antonio.terceiro@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: snd-cmipci oops during probe on arm64 (current mainline,
 pre-6.6-rc1)
Message-ID: <ZPjGuCdmPgqznc5t@linaro.org>
References: <ZPelHaX/Lt++kkOm@linaro.org>
 <877cp3esse.wl-tiwai@suse.de>
 <4f335dd2-8043-c60e-cf84-c2b01c4fee12@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SpMcbUejsrGYVbOX"
Content-Disposition: inline
In-Reply-To: <4f335dd2-8043-c60e-cf84-c2b01c4fee12@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SpMcbUejsrGYVbOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 01:49:16PM +0100, Robin Murphy wrote:
> On 2023-09-06 07:10, Takashi Iwai wrote:
> > On Wed, 06 Sep 2023 00:01:01 +0200,
> > Antonio Terceiro wrote:
> > >=20
> > > Hi,
> > >=20
> > > I'm using an arm64 workstation, and wanted to add a sound card to it.=
 I bought
> > > one who was pretty popular around where I live, and it is supported b=
y the
> > > snd-cmipci driver.
> > >=20
> > > It's this one:
> > >=20
> > > 0005:02:00.0 Multimedia audio controller: C-Media Electronics Inc CMI=
8738/CMI8768 PCI Audio (rev 10)
> > >=20
> > > After building a mailine kernel (post-v6.5, pre-rc1) on Debian testin=
g arm64
> > > with localmodconfig + CONFIG_SND_CMIPCI=3Dm, it crashes with "Unable =
to handle
> > > kernel paging request at virtual address fffffbfffe80000c", and the s=
ystem
> > > never finishes to boot. The login manager never shows up and the seri=
al console
> > > never gets to a login prompt. I observed the same issue on a 6.3 Debi=
an kernel,
> > > after rebuilding with CONFIG_SND_CMIPCI=3Dm.
> > >=20
> > > If I stop the module from being automatically loaded by adding
> > > `blacklist snd-cmipci` to /etc/modprobe.d/snd-cmipci.conf (or if I
> > > remove the card from the PCIe slot), I get the system to boot. But tr=
ing
> > > to load the module manually causes the same crash (I only tested this
> > > with the card on):
> > >=20
> > > [  +4,501093] snd_cmipci 0005:02:00.0: stream 512 already in tree
> > > [  +0,000155] Unable to handle kernel paging request at virtual addre=
ss fffffbfffe80000c
> > > [  +0,007927] Mem abort info:
> > > [  +0,002793]   ESR =3D 0x0000000096000006
> > > [  +0,003743]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > [  +0,005307]   SET =3D 0, FnV =3D 0
> > > [  +0,003049]   EA =3D 0, S1PTW =3D 0
> > > [  +0,003134]   FSC =3D 0x06: level 2 translation fault
> > > [  +0,004872] Data abort info:
> > > [  +0,002873]   ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
> > > [  +0,005479]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > > [  +0,005047]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > > [  +0,000003] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D000008051=
9fe9000
> > > [  +0,000004] [fffffbfffe80000c] pgd=3D000008051a979003, p4d=3D000008=
051a979003, pud=3D000008051a97a003, pmd=3D0000000000000000
> > > [  +0,000009] Internal error: Oops: 0000000096000006 [#1] SMP
> > > [  +0,028142] Modules linked in: snd_cmipci(+) snd_mpu401_uart snd_op=
l3_lib xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo =
xt_addrtype nft_compat br_netfilter nft_masq nft_chain_nat nf_nat nf_conntr=
ack nf_defrag_ipv6 nf_defrag_ipv4 bridge stp llc nf_tables nfnetlink uvcvid=
eo videobuf2_vmalloc videobuf2_memops uvc videobuf2_v4l2 videodev videobuf2=
_common snd_seq_dummy snd_hrtimer snd_seq qrtr rfkill overlay ftdi_sio usbs=
erial snd_usb_audio snd_usbmidi_lib snd_pcm aes_ce_blk aes_ce_cipher snd_hw=
dep polyval_ce snd_rawmidi polyval_generic snd_seq_device joydev snd_timer =
ghash_ce hid_generic gf128mul snd usbhid sha2_ce ipmi_ssif soundcore hid mc=
 sha256_arm64 ipmi_devintf arm_spe_pmu ipmi_msghandler sha1_ce sbsa_gwdt bi=
nfmt_misc nls_ascii nls_cp437 vfat fat xgene_hwmon cppc_cpufreq arm_cmn arm=
_dsu_pmu evdev nfsd auth_rpcgss nfs_acl lockd grace dm_mod fuse loop efi_ps=
tore dax sunrpc configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2=
 btrfs efivarfs raid10 raid
> >   456 async_raid6_recov async_memcpy
> > > [  +0,000142]  async_pq async_xor async_tx libcrc32c crc32c_generic x=
or xor_neon raid6_pq raid1 raid0 multipath linear md_mod nvme nvme_core ast=
 t10_pi drm_shmem_helper xhci_pci drm_kms_helper xhci_hcd crc64_rocksoft cr=
c64 drm crc_t10dif usbcore crct10dif_generic igb crct10dif_ce crct10dif_com=
mon usb_common i2c_algo_bit i2c_designware_platform i2c_designware_core
> > > [  +0,121670] CPU: 0 PID: 442 Comm: kworker/0:4 Not tainted 6.5.0+ #2
> > > [  +0,006259] Hardware name: ADLINK AVA Developer Platform/AVA Develo=
per Platform, BIOS TianoCore 2.04.100.07 (SYS: 2.06.20220308) 09/08/2022
> > > [  +0,012506] Workqueue: events work_for_cpu_fn
> > > [  +0,004353] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS B=
TYPE=3D--)
> > > [  +0,006953] pc : logic_inl+0xa0/0xd8
> > > [  +0,003570] lr : snd_cmipci_probe+0x7a4/0x1140 [snd_cmipci]
> > > [  +0,005578] sp : ffff80008287bc70
> > > [  +0,003303] x29: ffff80008287bc70 x28: ffff08008af9d6a0 x27: 000000=
0000000000
> > > [  +0,007128] x26: ffffc4818263c228 x25: 0000000000000000 x24: 000000=
0000000001
> > > [  +0,007127] x23: ffff07ff81a9e000 x22: ffff07ff81a9e0c0 x21: ffff08=
008af9d080
> > > [  +0,007127] x20: ffffc4818263c000 x19: 0000000000000000 x18: ffffff=
ffffffffff
> > > [  +0,007127] x17: 0000000000000000 x16: ffffc4819ac3cd38 x15: ffff80=
008287ba80
> > > [  +0,007127] x14: 0000000000000001 x13: ffff80008287bbc4 x12: 000000=
0000000000
> > > [  +0,007126] x11: ffff07ff834616d0 x10: ffffffffffffffc0 x9 : ffffc4=
819a61dd18
> > > [  +0,007127] x8 : 0000000000000228 x7 : 0000000000000001 x6 : 000000=
00000000ff
> > > [  +0,007127] x5 : ffffc4819adb7998 x4 : 0000000000000000 x3 : 000000=
00000000ff
> > > [  +0,007127] x2 : 0000000000ffbffe x1 : 000000000000000c x0 : fffffb=
fffe80000c
> > > [  +0,007126] Call trace:
> > > [  +0,002436]  logic_inl+0xa0/0xd8
> > > [  +0,003221]  local_pci_probe+0x48/0xb8
> > > [  +0,003744]  work_for_cpu_fn+0x24/0x40
> > > [  +0,003741]  process_one_work+0x170/0x3a8
> > > [  +0,004002]  worker_thread+0x23c/0x460
> > > [  +0,003742]  kthread+0xe8/0xf8
> > > [  +0,003047]  ret_from_fork+0x10/0x20
> > > [  +0,003569] Code: d2bfd000 f2df7fe0 f2ffffe0 8b000020 (b9400000)
> > > [  +0,006083] ---[ end trace 0000000000000000 ]---
> > >=20
> > > Because this sound card chipset seems to be popular (pretty much all =
PCI cards
> > > I can find to buy locally use that), I'm thinking this might be speci=
fic to
> > > arm64, otherwise someone would have seen this before.
> >=20
> > There is only one change in this driver code itself since 6.5 (commit
> > b6ba0aa46138), and judging from the stack trace, it's unrelated with
> > your problem.   It's more likely a regression in the lower level code,
> > e.g. PCI layer or arch/arm64 stuff.
> >=20
> > Could you try git bisect?
>=20
> Hmm, but has this combination of card and machine *ever* actually worked?

That could be it. In trying to find a starting point for the bisection,
I tried 6.1.0, 5.15.130, and 5.10.19, and they all fail in exactly the
same way. I didn't go further back.

> It's blowing up trying to access PCI I/O space, which has apparently ended
> up in the indirect access mechanism without that being configured correct=
ly.
> That is definitely an issue down somewhere between the PCI layer and the
> system firmware. Does the system even have an I/O space window? Some arm64
> machines don't. I guess we might not have got as far as probing a driver =
if
> the I/O BAR couldn't be assigned at all, but either way something's not g=
one
> right.

I'm pretty sure I saw reports of people using PCI GPUs on this machine,
but I would need to confirm.

What info would I need to gather from the machine in order to figure
this out?

--SpMcbUejsrGYVbOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEst7mYDbECCn80PEM/A2xu81GC94FAmT4xrUACgkQ/A2xu81G
C952DBAAipiZmtHVhrMt7eXTx3M7MGPFcBYZb8+n8NJ7+V01hJSuf3mNIIWJVfBr
Y9du3v0p35+E+B1dya+I62tq2dv2qY5zM05E8hQLrLNjpJGgoDMGQTyzbR0pMW0x
FqBhF9D/Lq6xaTeHiQoLJp0t3wsYl3NgDFkD/fBtqpQ47P4YjdRUi07lVpcwWE8y
PSE3icJ9s/pmP63epakd7U+D0a4teMBMPH8SnWTFuU1PG1awRv4uevHZ3IkOrMFt
r2V55ACGGHXe1LQ4Awl+dgdqKTJUMmKdjoaetm9/vqo7VnlAgWyzQ0xxyXJejQOC
vJWjTml9P9TZtpZw9+r9rS+/sW8DHLev6DnhC/PZ5pYjoSaNIsL17BN3QRU6YlvB
C5hld6ImoUa4NwmVRNNbRmOJXvEFPu35dmouPBfzL4h0LZQPneAdeDmVREnovJ5o
vfLA5VSlJpB1A1WZcxWWpi6JGQIST2NN9+y8/CVJRTpoh93aInSVpaBv7I8uon7N
B6WuzqP5SokLnnXDrVcjLwwB2cvRuXtYTz4hWbgz7eXzfDraBJjkyaqKsCF5iJWZ
IR9aphEiJmWLYUJ7k0sJwWg8jP2vCdMYfCIs/lr5JeuhYvNkK/cRFcaTbrsCvJ51
0ebMlBHn8cPuwP7spbq0p9X012MPZ31X90PUAUBLgFhKunE9308=
=TQAU
-----END PGP SIGNATURE-----

--SpMcbUejsrGYVbOX--
