Return-Path: <linux-kernel+bounces-24408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C4E82BC29
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E10B250E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CB55D74C;
	Fri, 12 Jan 2024 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehVIOSuO"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6875E5D72A;
	Fri, 12 Jan 2024 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-429bf893300so3071321cf.0;
        Fri, 12 Jan 2024 00:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705046790; x=1705651590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C/F8IHc1mT+FStG0CgBOK7or1zKHGZr7hbvdt/4RrnA=;
        b=ehVIOSuOCeyV027m3qa9AtkX2T70XjtH7GTbGiSvOAYVwtwpI9c7EHy9ca8dtCzknl
         7JLjJUEjs8YN3uvROSox+h5RqVDKK9Q24T04zvif8NY0az/xQajk/F4spLKAIYU2v9aj
         1kxmzY9mAsL/j8p8Q+FiSpGwd53WyswtFAiGhVTMt7570wDs7N8B0yu1gToRaSIvtyqr
         M619XUR5gLWVp9H4vAx3sb7DC+38IFqbzFvRkKX+G8yIzK51+gYgYn1UIVfyzRbPefin
         Q00UfRT6NyhBFwk8rn6hdp6R8oSyWWmkfo92iFmGDK9rsgg3pDPgDuvn/TwIDSzRPIVa
         yk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705046790; x=1705651590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/F8IHc1mT+FStG0CgBOK7or1zKHGZr7hbvdt/4RrnA=;
        b=bUcFIctmdkWCFbBTgEC68fSmc1JTdwtUSFPxOjryg4WGdPvDEF27Go6iZbVR1o3Q9B
         KztNckTNZkZE+DUkFm344fFLEq7ZD/F+i59wwIJSKZkOVif8QUkkFp0l1xyLNMljQUeN
         SMa6RYMiZpW4zTkjr/YeiMXoCgjXEop1eAhTSscfkFNMZvdmHbq0iHWbx3Nzjo3yjNLd
         r0pbkVgCejDBAwMvAZAgJOvMFvbZHNZ/D7C247DZHNw4jPw0BVg1LK1dXUhaQausGxuc
         /pNgyeuDoBRGj/Elfb4EH42SuPXoZb28NurTIFotBm3ENvr7ukBch8bt46t5C9mmWyJW
         F4yg==
X-Gm-Message-State: AOJu0YypoFEe6mMsdxxruWTIqausE2iUn6AEnbw1nbJJOjZLyfVrHgx3
	s4q1se5wmfdRejMlMoAOn7RTI5luYhvJtJZdj8k=
X-Google-Smtp-Source: AGHT+IHmZf+GtwAcdAwf/iqSDihdf/xmTm6IYjhiQfWoo45JniJ2KU4jhB5nlcIHgcM36Q85yRShN2zFGro8vhzY61Y=
X-Received: by 2002:a05:6214:402:b0:681:7ea:7aa2 with SMTP id
 z2-20020a056214040200b0068107ea7aa2mr1808111qvx.1.1705046790061; Fri, 12 Jan
 2024 00:06:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOdvVwdLmSsC8TZ1jF0UOg_F_W3wqLECWX620PUkvNk=A@mail.gmail.com>
 <efcb591e162ff0b04a9878f7250ab6ee6907f4a4.camel@mediatek.com> <CABXGCsPF6MbSOpfUBbT77Hnfc450kutsc8Fzr1O_O9bgtQ5PAw@mail.gmail.com>
In-Reply-To: <CABXGCsPF6MbSOpfUBbT77Hnfc450kutsc8Fzr1O_O9bgtQ5PAw@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 12 Jan 2024 13:06:18 +0500
Message-ID: <CABXGCsPfOd_pqHpOXsZZwmqLY+DBg+EiDfKb_Wf-UrXvyuZkOw@mail.gmail.com>
Subject: Re: [BUG] Unloading mt7921e module cause use-after-free
To: =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "nbd@nbd.name" <nbd@nbd.name>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000003f8a00060ebb2416"

--0000000000003f8a00060ebb2416
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 12:31=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Thanks, this patch looks good to me.
> Demonstration: https://youtu.be/nKnA2ftVoXw
>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>

I noticed DMA-API notice:
------------[ cut here ]------------
DMA-API: pci 0000:0f:00.0: device driver has pending DMA allocations
while released from device [count=3D21]
One of leaked entries details: [device address=3D0x00000000ffbda000]
[size=3D4096 bytes] [mapped with DMA_FROM_DEVICE] [mapped as single]
WARNING: CPU: 13 PID: 11252 at kernel/dma/debug.c:863
dma_debug_device_change+0x276/0x3d0
Modules linked in: mt7921e(-) uinput rfcomm snd_seq_dummy snd_hrtimer
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ip_set nf_tables qrtr bnep sunrpc binfmt_misc
intel_rapl_msr intel_rapl_common mt7921_common mt792x_lib
snd_hda_codec_hdmi mt76 edac_mce_amd snd_hda_intel snd_intel_dspcfg
snd_intel_sdw_acpi mac80211 snd_usb_audio kvm_amd snd_hda_codec
snd_usbmidi_lib btusb snd_hda_core uvcvideo snd_ump btrtl kvm ntel
snd_hwdep btbcm uvc snd_seq vfat btmtk videobuf2_vmalloc
videobuf2_memops libarc4 fat snd_seq_device videobuf2_v4l2 bluetooth
snd_pcm irqbypass videobuf2_common snd_timer cfg80211 rapl of snd
joydev pcspkr mc k10temp i2c_piix4 soundcore rfkill gpio_amdpt
gpio_generic loop nfnetlink zram amdgpu amdxcp i2c_algo_bit
drm_ttm_helper ttm drm_exec crct10dif_pclmul gpu_sched
 crc32_pclmul crc32c_intel drm_suballoc_helper polyval_clmulni
drm_buddy polyval_generic drm_display_helper ghash_clmulni_intel nvme
sha512_ssse3 sha256_ssse3 ccp nvme_core sha1_ssse3 sp5100_tco ek
nvme_auth video wmi ip6_tables ip_tables fuse [last unloaded: mt7921e]
CPU: 13 PID: 11252 Comm: rmmod Tainted: G        W    L     6.7.0-check-fix=
+ #70
Hardware name: Micro-Star International Co., Ltd. MS-7D73/MPG B650I
EDGE WIFI (MS-7D73), BIOS 1.81 01/05/2024
RIP: 0010:dma_debug_device_change+0x276/0x3d0
Code: 54 24 08 e8 5c d7 c8 01 48 8b 54 24 08 48 89 c6 ff 34 24 49 89
e9 49 89 d8 44 89 e1 41 56 48 c7 c7 40 46 52 b3 e8 1a c9 d6 ff <0f> 0b
5a 59 4d 85 ed 74 49 48 c7 c7 80 47 52 b3 e8 15 04 f5 ff
RSP: 0018:ffffc90009c77bf0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 00000000ffbda000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 0000000000001000 R08: 0000000000000001 R09: ffffed11f587fff9
R10: ffff888fac3fffcb R11: 0000000000000000 R12: 0000000000000015
R13: ffff888109b02180 R14: ffffffffb35265e0 R15: ffff88811418e0c0
FS:  00007f5a1e4177c0(0000) GS:ffff888fac200000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8b1d394054 CR3: 0000000134cb8000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0xcd/0x2b0
 ? __pfx_vprintk_emit+0x10/0x10
 ? dma_debug_device_change+0x276/0x3d0
 ? report_bug+0x2ea/0x390
 ? handle_bug+0x79/0xa0
 ? exc_invalid_op+0x17/0x40
 ? asm_exc_invalid_op+0x1a/0x20
 ? dma_debug_device_change+0x276/0x3d0
 notifier_call_chain+0xa0/0x2a0
 blocking_notifier_call_chain+0x64/0x90
 bus_notify+0x51/0x70
 device_release_driver_internal+0x42d/0x540
 driver_detach+0xc5/0x180
 bus_remove_driver+0x11e/0x2a0
 ? __check_object_size+0x5b/0x680
 pci_unregister_driver+0x2a/0x250
 __do_sys_delete_module+0x350/0x580
 ? __pfx___do_sys_delete_module+0x10/0x10
 ? syscall_exit_to_user_mode+0xce/0x2b0
 ? do_syscall_64+0xab/0x190
 ? rcu_is_watching+0x15/0xb0
 ? syscall_exit_to_user_mode+0xb6/0x2b0
 ? trace_hardirqs_on_prepare+0xe3/0x100
 ? do_syscall_64+0x58/0x190
 do_syscall_64+0x9b/0x190
 ? trace_hardirqs_on_prepare+0xe3/0x100
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7f5a1dd2d05b
Code: 73 01 c3 48 8b 0d bd 8d 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 8d 8d 0c 00 f7 d8 64 89 01
RSP: 002b:00007ffc5ae71b68 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 000055e490fee760 RCX: 00007f5a1dd2d05b
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055e490fee7c8
RBP: 00007ffc5ae71b90 R08: 1999999999999999 R09: 0000000000000000
R10: 00007f5a1dda5ac0 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffc5ae71df0 R14: 000055e490fee760 R15: 0000000000000000
 </TASK>
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffffb023b291>] copy_process+0x2111/0x8=
8e0
softirqs last  enabled at (0): [<ffffffffb023b2f3>] copy_process+0x2173/0x8=
8e0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
DMA-API: Mapped at:
 debug_dma_map_page+0x60/0x3c0
 dma_map_page_attrs+0x2fc/0xba0
 page_pool_dma_map+0xaf/0x2d0
 __page_pool_alloc_pages_slow+0x36f/0xab0
 page_pool_alloc_frag+0x4fa/0x9c0

It happens when I unload driver mt7921e and in the background some
applications (in my case it is speedtest) have heavy network activity.

Demonstration: https://youtu.be/XYO4ueVlh90

But I am not sure what it is related to the mt7921e driver.

--=20
Best Regards,
Mike Gavrilov.

--0000000000003f8a00060ebb2416
Content-Type: application/zip; name="dmesg-6.8-with-patch.zip"
Content-Disposition: attachment; filename="dmesg-6.8-with-patch.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_lracrifm0>
X-Attachment-Id: f_lracrifm0

UEsDBBQACAAIADBnLFgAAAAAAAAAAAAAAAAYACAAZG1lc2ctNi44LXdpdGgtcGF0Y2gudHh0VVQN
AAft8KBl7fCgZe3woGV1eAsAAQToAwAABOgDAAADAFBLBwgAAAAAAgAAAAAAAABQSwECFAMUAAgA
CAAwZyxYAAAAAAIAAAAAAAAAGAAgAAAAAAAAAAAApIEAAAAAZG1lc2ctNi44LXdpdGgtcGF0Y2gu
dHh0VVQNAAft8KBl7fCgZe3woGV1eAsAAQToAwAABOgDAABQSwUGAAAAAAEAAQBmAAAAaAAAAAAA
--0000000000003f8a00060ebb2416--

