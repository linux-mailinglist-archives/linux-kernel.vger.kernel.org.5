Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D27662C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjG1EHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjG1EHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:07:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017763A9C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 21:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690517194; x=1691121994; i=efault@gmx.de;
 bh=f+mnNl0myTqve1iBYdO9P3iLpsbmD7Lio/xNCSjQqzE=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
 b=FwRcnTWQt1mrTbLLIboOBgfRHko7eLxG3ezq44286EE7U7+7xQyEvw5XV+LoCmv3IrpDq48
 ZkXonwG176tIfscSbrVn64exMcEB3u+14J03ct7bMxHMP3FHodPiAvqBg4nZxx/+kKw5c6Lhe
 dtJJf+ftHLwcgrkKfZeWEaIIWFXPXKiIrTHx39swWxtV9Lk7pXXMzPjWdUUaCMsgPmTL8k3Rf
 9Qik+c+JsKHp57wHU8XMjXty5pwDWAvzyShed106sWEMJkdmUVz9UhT7amWXKMUxGkm6an6/Q
 ChsPJRM3pdHnHqaPYUoBXioDsmK8uTspF8aJFbGkSuhehPJdDRJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.217.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1pbvsc2CNQ-00uJX4; Fri, 28
 Jul 2023 06:06:34 +0200
Message-ID: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
Subject: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Date:   Fri, 28 Jul 2023 06:06:33 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ibqLOecex4c3SJyAb3wxLXXmh39jx9buf9NikLAJ6eKR6H/UYb
 Mk0C8JmUa4KIzwcYIo44efbdKwX/Dg7B3z9/1xVPKrawd0OJxZfruFbpCtgqjUAwqsgnUxv
 Iop96gajQgoyajdeeanaK4hIZ8UngVuIPH5J17Tko9odZEe+6qW5rBn2d3L9X+TMq25eLsc
 9FmY0Q3EsiuifLg4Dm9wQ==
UI-OutboundReport: notjunk:1;M01:P0:mDdJvvw4dt8=;yXlTFu1HIXVAfV+wUfBBJomXDkA
 uYU8Fa7k354FFLN1X59yQ6aA8S7uoQMBiCMElTr/uX7S+2vjT49/Zopmw8s1z4JqZZTMpRVNo
 NY9m4ZM0F5A1cU0Cu75OwLT0ew9Ov8aBlPjrQGUF+xEAz7scQgtdAqf1ZTiazJfLEyIf7yXL+
 B4gml6aHFKWyiqwYhsD/fDmfkT/MiWIti1zixn1RcRBjv/c3CbtudFtFtL94yCfdVAREbdZTf
 n7+hUZCf0CZxY5sY26+LplLuEIGx74CFH1P8kzYbK4ftRY2B7Y4MI4cADfSYIGc6l1pJI85F0
 Xmy+rSV4KRa/51pXiCJDQpnYh09nmZC3lbp5eC2GoLRL8Q59vRlpITksKpgB14lRFP93RpkQU
 qtM/xBuV4voNlPlTDyuUF87aNesL6/gdeeZO/53OW0LhsofaERfOTBhvNtSNTgQZuTbsT9bhX
 OyGLIIU+nDRYifETrlZW0ocTkkEquIOVKfP0hUS+i4cmBxsUPmQ4RCr6iCBzlghwaZSVI9XEq
 rePezJScpPJE3jY7v+INU6XOQeQJ8D4mTpa5g+u7Hel9IW9tWaqcFO+PCJXE0GttOfMGhgSVJ
 kF9WJ5qGFC0SqKDAb8x46J36Kqhj2SxiXTK5+cOgpHTnEdJM5PMotyD1gWGKx6/cOdjSLWlyj
 lz+UpRcu/96swNPzq9x6F/FD6EfDFvzKwoG3QKintNNkLzfEG4TuQeuhCnflZV6nhUJ3xo0+5
 IPKY/MPqDPAG7Ie8KmY4or+/evjFlKTM0sFGlRG2ClGAPFmJTJjlHhcE3m8I9Hbq577qW53ve
 tZpTMtIpriH+WAOLTwS5V9vySFXAE9MZVMNVPWBt1twXNwZ2ARUccklVZiPmtVgtrdxAx5rr7
 5/KqQzS9WUHZoq3Of/jTU2AUcDvuGE5fypClQ4ksA6VKofj/ywYGXDTwySNnoN8locp8Gv8ji
 Uq/0+jtoEuaFLAfraZCwS6F7Fa4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf test 26 in virgin master inspired the below.

The oops is not brand new, apparently arriving sometime after 6.1, as
the stock 6.1.21 Raspian/PiOS kernel does not reproduce but the rpi-
6.4.y pi kernel (https://github.com/raspberrypi/linux.git) branch does.

[   65.416656] Unable to handle kernel paging request at virtual address f=
fffffd080a00000
[   65.416680] Mem abort info:
[   65.416685]   ESR =3D 0x0000000096000007
[   65.416690]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   65.416696]   SET =3D 0, FnV =3D 0
[   65.416701]   EA =3D 0, S1PTW =3D 0
[   65.416705]   FSC =3D 0x07: level 3 translation fault
[   65.416710] Data abort info:
[   65.416715]   ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
[   65.416720]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[   65.416725]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[   65.416731] swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000000f51=
000
[   65.416737] [ffffffd080a00000] pgd=3D10000001fffff003, p4d=3D10000001ff=
fff003, pud=3D10000001fffff003, pmd=3D10000001ffffe003, pte=3D000000000000=
0000
[   65.416758] Internal error: Oops: 0000000096000007 [#1] SMP
[   65.416764] Modules linked in: rfcomm nft_fib_inet nft_fib_ipv4 nft_fib=
_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft=
_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set=
 nf_tables nfnetlink cmac algif_hash aes_arm64 aes_generic algif_skcipher =
af_alg bnep vc4 brcmfmac_wcc 8021q brcmfmac garp stp llc snd_soc_hdmi_code=
c drm_display_helper hci_uart drm_dma_helper drm_kms_helper btbcm bluetoot=
h cfg80211 bcm2835_v4l2(C) cec videobuf2_vmalloc snd_soc_core videobuf2_me=
mops bcm2835_mmal_vchiq(C) videobuf2_v4l2 videodev snd_pcm_dmaengine snd_b=
cm2835(C) v3d snd_pcm videobuf2_common snd_timer sg ecdh_generic ecc drm_s=
hmem_helper mc rfkill snd gpu_sched brcmutil i2c_brcmstb raspberrypi_hwmon=
 pwm_bcm2835 i2c_bcm2835 libaes uio_pdrv_genirq uio nvmem_rmem drm nfsd fu=
se i2c_dev drm_panel_orientation_quirks backlight ip_tables x_tables ipv6
[   65.416903] CPU: 0 PID: 1769 Comm: objdump Tainted: G         C        =
 6.5.0.g0a8db05-master #1
[   65.416909] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
[   65.416913] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   65.416919] pc : __arch_copy_to_user+0x180/0x240
[   65.416929] lr : _copy_to_iter+0xe8/0x4d0
[   65.416936] sp : ffffffc08219b970
[   65.416939] x29: ffffffc08219b970 x28: ffffffd080a00000 x27: ffffffd081=
d5cd30
[   65.416948] x26: 0000000000000000 x25: ffffffd080a00000 x24: 0000000000=
000000
[   65.416956] x23: ffffffc08219bd40 x22: ffffffd081c00000 x21: ffffffc082=
19bd40
[   65.416964] x20: ffffffd081c005c0 x19: 0000000000000400 x18: 0000000000=
000000
[   65.416972] x17: 0000000000000000 x16: 0000000000000000 x15: ffffffd080=
a00000
[   65.416980] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000=
000000
[   65.416987] x11: 0000008000000000 x10: ffffffd081c005c0 x9 : 0000000000=
000230
[   65.416995] x8 : 0000000004000000 x7 : 0000007e08000000 x6 : 000000559a=
e52840
[   65.417003] x5 : 000000559ae52c40 x4 : 0000000000000000 x3 : 0000000000=
000400
[   65.417010] x2 : 0000000000000380 x1 : ffffffd080a00000 x0 : 000000559a=
e52840
[   65.417018] Call trace:
[   65.417021]  __arch_copy_to_user+0x180/0x240
[   65.417026]  read_kcore_iter+0x5b4/0x830
[   65.417035]  proc_reg_read_iter+0x8c/0xe8
[   65.417042]  vfs_read+0x200/0x2a8
[   65.417049]  ksys_read+0x70/0x108
[   65.417054]  __arm64_sys_read+0x24/0x38
[   65.417060]  invoke_syscall+0x50/0x128
[   65.417067]  el0_svc_common.constprop.0+0x68/0x120
[   65.417073]  do_el0_svc+0x40/0xb8
[   65.417079]  el0_svc+0x30/0x98
[   65.417086]  el0t_64_sync_handler+0xc0/0xc8
[   65.417092]  el0t_64_sync+0x190/0x198
[   65.417098] Code: d503201f d503201f d503201f d503201f (a8c12027)

