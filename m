Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E943783C97
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjHVJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjHVJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA67113;
        Tue, 22 Aug 2023 02:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AE88618D8;
        Tue, 22 Aug 2023 09:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268EDC433C7;
        Tue, 22 Aug 2023 09:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692695551;
        bh=lwqgw8d2qxsRjyzo3Hd13D6Y7rRh6LRCeLZGT0Dm7aI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4R4U3YC9vNQgXKQgQj+B7aDTK3UoEy0pKUfRYXuB1IwiVyy95ooB7OKpk7Tadd5E
         4diZiDroWYxomx49l11D00Mradk6d3FwX1PPa6aVU1sPKgbL36FNo041AhMHxt+jj3
         qPQpp8hBdgdSiym9tWEbgAbtTD3Co1OnorlFpwAyA4OigfQiDRkFXSQhSv5VYN4Vxv
         a1jcX5f1QuJEgswJsoNT/ZZjXnSJeXzk/l6jZhYKpPIdU2FJswJ6LJWmJ6x+MdCVGo
         Z1urGBIf9iDCZ9YQDlqOJEk+bSkVYK+IGfZO4dl4ffao/EN47Jrwmuc46rdiqehU0q
         9o0delAv/ZqyA==
Date:   Tue, 22 Aug 2023 11:12:28 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     syzbot <syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com>
Cc:     davidgow@google.com, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com, benjamin.tissoires@redhat.com
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in
 input_dev_uevent
Message-ID: <ijh2qmdtj452nq3idu2tohkrmfwr2qhbhrnyqzxjkkw2lrby53@v2dffcqdohsx>
References: <00000000000035beba060371a468@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="irvpjy7sl5yod4kf"
Content-Disposition: inline
In-Reply-To: <00000000000035beba060371a468@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--irvpjy7sl5yod4kf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 21, 2023 at 09:48:01AM -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    7271b2a53042 Add linux-next specific files for 20230818
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D11edc0d3a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1936af09cdef7=
dd6
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3a0ebe8a52b89c6=
3739d
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17998f03a80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17b81223a80000
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d81109bc02c1/dis=
k-7271b2a5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4b3bf8e2a4f7/vmlinu=
x-7271b2a5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6404cd473c1e/b=
zImage-7271b2a5.xz
>=20
> The issue was bisected to:
>=20
> commit 699fb50d99039a50e7494de644f96c889279aca3
> Author: David Gow <davidgow@google.com>
> Date:   Thu Jul 20 12:45:09 2023 +0000
>=20
>     drivers: base: Free devm resources when unregistering a device
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13140083a8=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D10940083a8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17140083a80000
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com
> Fixes: 699fb50d9903 ("drivers: base: Free devm resources when unregisteri=
ng a device")
>=20
> usb 1-1: USB disconnect, device number 2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:645 [inl=
ine]
> BUG: KASAN: slab-use-after-free in string+0x394/0x3d0 lib/vsprintf.c:727
> Read of size 1 at addr ffff88801c8c6ca8 by task kworker/1:3/4508
>=20
> CPU: 1 PID: 4508 Comm: kworker/1:3 Not tainted 6.5.0-rc6-next-20230818-sy=
zkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/26/2023
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0xc4/0x620 mm/kasan/report.c:475
>  kasan_report+0xda/0x110 mm/kasan/report.c:588
>  string_nocheck lib/vsprintf.c:645 [inline]
>  string+0x394/0x3d0 lib/vsprintf.c:727
>  vsnprintf+0xc5f/0x1870 lib/vsprintf.c:2818
>  add_uevent_var+0x17c/0x390 lib/kobject_uevent.c:665
>  input_dev_uevent+0x162/0x8f0 drivers/input/input.c:1691
>  dev_uevent+0x305/0x760 drivers/base/core.c:2599
>  kobject_uevent_env+0x623/0x1800 lib/kobject_uevent.c:557
>  device_del+0x642/0xa50 drivers/base/core.c:3830
>  input_unregister_device+0xb9/0x100 drivers/input/input.c:2440
>  hidinput_disconnect+0x160/0x3e0 drivers/hid/hid-input.c:2386
>  hid_disconnect+0x143/0x1b0 drivers/hid/hid-core.c:2273
>  hid_hw_stop+0x16/0x70 drivers/hid/hid-core.c:2322
>  uclogic_remove+0x47/0x90 drivers/hid/hid-uclogic-core.c:485
>  hid_device_remove+0xce/0x250 drivers/hid/hid-core.c:2682
>  device_remove+0xc8/0x170 drivers/base/dd.c:567
>  __device_release_driver drivers/base/dd.c:1272 [inline]
>  device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
>  bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
>  device_del+0x39a/0xa50 drivers/base/core.c:3812
>  hid_remove_device drivers/hid/hid-core.c:2859 [inline]
>  hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2879
>  usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1456
>  usb_unbind_interface+0x1dd/0x8d0 drivers/usb/core/driver.c:458
>  device_remove drivers/base/dd.c:569 [inline]
>  device_remove+0x11f/0x170 drivers/base/dd.c:561
>  __device_release_driver drivers/base/dd.c:1272 [inline]
>  device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
>  bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
>  device_del+0x39a/0xa50 drivers/base/core.c:3812
>  usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
>  usb_disconnect+0x2e1/0x890 drivers/usb/core/hub.c:2252
>  hub_port_connect drivers/usb/core/hub.c:5280 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
>  port_event drivers/usb/core/hub.c:5740 [inline]
>  hub_event+0x1db7/0x4e00 drivers/usb/core/hub.c:5822
>  process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
>  process_scheduled_works kernel/workqueue.c:2703 [inline]
>  worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
>  kthread+0x33a/0x430 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>  </TASK>
>=20
> Allocated by task 782:
>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>  __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
>  kasan_kmalloc include/linux/kasan.h:198 [inline]
>  __do_kmalloc_node mm/slab_common.c:1004 [inline]
>  __kmalloc_node_track_caller+0x61/0x100 mm/slab_common.c:1024
>  alloc_dr drivers/base/devres.c:119 [inline]
>  devm_kmalloc+0xa5/0x230 drivers/base/devres.c:829
>  devm_kzalloc include/linux/device.h:314 [inline]
>  uclogic_input_configured+0x251/0x610 drivers/hid/hid-uclogic-core.c:151
>  hidinput_connect+0x1bf4/0x2b60 drivers/hid/hid-input.c:2344
>  hid_connect+0x139e/0x18a0 drivers/hid/hid-core.c:2187
>  hid_hw_start drivers/hid/hid-core.c:2302 [inline]
>  hid_hw_start+0xa0/0x130 drivers/hid/hid-core.c:2293
>  uclogic_probe+0x235/0x380 drivers/hid/hid-uclogic-core.c:221
>  __hid_device_probe drivers/hid/hid-core.c:2626 [inline]
>  hid_device_probe+0x2e4/0x480 drivers/hid/hid-core.c:2663
>  call_driver_probe drivers/base/dd.c:579 [inline]
>  really_probe+0x234/0xc90 drivers/base/dd.c:658
>  __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
>  __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
>  bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
>  __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
>  bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
>  device_add+0x11f1/0x1b40 drivers/base/core.c:3623
>  hid_add_device+0x371/0xa60 drivers/hid/hid-core.c:2809
>  usbhid_probe+0xd0a/0x1360 drivers/hid/usbhid/hid-core.c:1429
>  usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
>  call_driver_probe drivers/base/dd.c:579 [inline]
>  really_probe+0x234/0xc90 drivers/base/dd.c:658
>  __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
>  __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
>  bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
>  __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
>  bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
>  device_add+0x11f1/0x1b40 drivers/base/core.c:3623
>  usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
>  usb_generic_driver_probe+0xca/0x130 drivers/usb/core/generic.c:238
>  usb_probe_device+0xda/0x2c0 drivers/usb/core/driver.c:293
>  call_driver_probe drivers/base/dd.c:579 [inline]
>  really_probe+0x234/0xc90 drivers/base/dd.c:658
>  __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
>  __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
>  bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
>  __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
>  bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
>  device_add+0x11f1/0x1b40 drivers/base/core.c:3623
>  usb_new_device+0xd80/0x1960 drivers/usb/core/hub.c:2589
>  hub_port_connect drivers/usb/core/hub.c:5440 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
>  port_event drivers/usb/core/hub.c:5740 [inline]
>  hub_event+0x2daf/0x4e00 drivers/usb/core/hub.c:5822
>  process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
>  process_scheduled_works kernel/workqueue.c:2703 [inline]
>  worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
>  kthread+0x33a/0x430 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>=20
> Freed by task 4508:
>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
>  ____kasan_slab_free mm/kasan/common.c:236 [inline]
>  ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
>  kasan_slab_free include/linux/kasan.h:164 [inline]
>  slab_free_hook mm/slub.c:1800 [inline]
>  slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
>  slab_free mm/slub.c:3809 [inline]
>  __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
>  release_nodes drivers/base/devres.c:506 [inline]
>  devres_release_all+0x192/0x240 drivers/base/devres.c:535
>  device_del+0x628/0xa50 drivers/base/core.c:3827
>  input_unregister_device+0xb9/0x100 drivers/input/input.c:2440
>  hidinput_disconnect+0x160/0x3e0 drivers/hid/hid-input.c:2386
>  hid_disconnect+0x143/0x1b0 drivers/hid/hid-core.c:2273
>  hid_hw_stop+0x16/0x70 drivers/hid/hid-core.c:2322
>  uclogic_remove+0x47/0x90 drivers/hid/hid-uclogic-core.c:485
>  hid_device_remove+0xce/0x250 drivers/hid/hid-core.c:2682
>  device_remove+0xc8/0x170 drivers/base/dd.c:567
>  __device_release_driver drivers/base/dd.c:1272 [inline]
>  device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
>  bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
>  device_del+0x39a/0xa50 drivers/base/core.c:3812
>  hid_remove_device drivers/hid/hid-core.c:2859 [inline]
>  hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2879
>  usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1456
>  usb_unbind_interface+0x1dd/0x8d0 drivers/usb/core/driver.c:458
>  device_remove drivers/base/dd.c:569 [inline]
>  device_remove+0x11f/0x170 drivers/base/dd.c:561
>  __device_release_driver drivers/base/dd.c:1272 [inline]
>  device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
>  bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
>  device_del+0x39a/0xa50 drivers/base/core.c:3812
>  usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
>  usb_disconnect+0x2e1/0x890 drivers/usb/core/hub.c:2252
>  hub_port_connect drivers/usb/core/hub.c:5280 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
>  port_event drivers/usb/core/hub.c:5740 [inline]
>  hub_event+0x1db7/0x4e00 drivers/usb/core/hub.c:5822
>  process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
>  process_scheduled_works kernel/workqueue.c:2703 [inline]
>  worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
>  kthread+0x33a/0x430 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

So, we discussed it this morning with Benjamin, and I think the culprit
is that the uclogic driver will allocate a char array with devm_kzalloc
in uclogic_input_configured()
(https://elixir.bootlin.com/linux/latest/source/drivers/hid/hid-uclogic-cor=
e.c#L149),
and will assign input_dev->name to that pointer.

When the device is removed, the devm-allocated array is freed, and the
input framework will send a uevent in input_dev_uevent() using the
input_dev->name field:

https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1688

So it's a classic dangling pointer situation.

And even though it was revealed by that patch, I think the issue is
unrelated. The fundamental issue seems to be that the usage of devm in
that situation is wrong.

input_dev->name is accessed by input_dev_uevent, which for KOBJ_UNBIND
and KOBJ_REMOVE will be called after remove.

For example, in __device_release_driver() (with the driver remove hook
being called in device_remove() and devres_release_all() being called in
device_unbind_cleanup()):
https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L1278

So, it looks to me that, with or without the patch we merged recently,
the core has always sent uevent after device-managed resources were
freed. Thus, the uclogic (and any other input driver) was wrong in
allocating its input_dev name with devm_kzalloc (or the phys and uniq
fields in that struct).

Note that freeing input_dev->name in remove would have been just as bad.

Looking at the code quickly, at least hid-playstation,
hid-nvidia-shield, hid-logitech-hidpp, mms114 and tsc200x seem to be
affected by the same issue.

We discussed a couple of solutions with Benjamin, such as creating a
helper devm action to free and clear the input_dev->name field, droping
the name, phys and uniq fields from the uevent, or converting name, phys
and uniq to char arrays so drivers don't have to allocate them.

We couldn't find a perfect one though, so... yeah.

Maxime

--irvpjy7sl5yod4kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZOR7/AAKCRDj7w1vZxhR
xf1HAP4lreV9C9Lj1DwQ9w5eWXT3fdWDaco/QN1m62Qiol5eDQD7BS8aSsD6MuiP
065L2HAfC7ZUSzqoB75xeh37D8+AOwU=
=sTF/
-----END PGP SIGNATURE-----

--irvpjy7sl5yod4kf--
