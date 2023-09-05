Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B27931BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbjIEWAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjIEWAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:00:47 -0400
X-Greylist: delayed 114 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 15:00:43 PDT
Received: from cmx-torrgo001.bell.net (mta-tor-001.bell.net [209.71.212.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C9AE6;
        Tue,  5 Sep 2023 15:00:43 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [142.198.135.111]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 64E88507011C958C
X-CM-Envelope: MS4xfJGFMW4MzwbFw+0yIIUe+IrGADD6e9Fil/ptQxS9gD2aohR/UEBPHQXHzIFL6dD6Sqgip8nEoagKLml6zOp90g9VFOhCctR44VUhyJsNWyRhytsA0YwG
 6pfiuwSnC8sQ1qbDOYwWXBVhVXf5V8uVpsbKl28tgeZovjTeto842iSuwwnlNZyEW5v2uvjwpUkA+Rdyjq7LOjIefNRjY62lyVsyjbEUo2LQgiBGrFd/VZgI
 fiI96BJoHueWaYCpqWkcxv/KIW3Hdl3Q5yMrUwZx3C2OqxjLybYUZNNTWOTuP4jtM0a5I1Aon0/CBXclR+FLHYawgqqR1mqnMf53Nvw8m9G6SFmiU/1pBiAG
 7CnuO75CNk8wfel0qms1NGMDQWKhL1IAevG/qUNdjgCIYZDE+6470ZvYrlyqHjlz7ygzUJDbDtuBI5ymtZqAzA8ZDa1sCg==
X-CM-Analysis: v=2.4 cv=UM++oATy c=1 sm=1 tr=0 ts=64f7a443
 a=m0hBPjpnfWKpZW+YOe+Hqw==:117 a=m0hBPjpnfWKpZW+YOe+Hqw==:17
 a=IkcTkHD0fZMA:10 a=FBHGMhGWAAAA:8 a=VwQbUJbxAAAA:8 a=wkG6FOpsRsjeTc6AjSQA:9
 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22 a=AjGcO6oz07-iQ99wixmX:22
Received: from [192.168.2.49] (142.198.135.111) by cmx-torrgo001.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 64E88507011C958C; Tue, 5 Sep 2023 17:57:23 -0400
Message-ID: <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
Date:   Tue, 5 Sep 2023 17:57:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] linux/export: fix reference to exported functions for
 parisc64
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230905190828.790400-1-masahiroy@kernel.org>
From:   John David Anglin <dave.anglin@bell.net>
In-Reply-To: <20230905190828.790400-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch get us slightly further but boot still fails in a similar way:

[...]
Run /init as init process
process '/usr/bin/sh' started with executable stack
Loading, please wait...
Starting systemd-udevd version 254.1-3
e1000 alternatives: applied 0 out of 569 patches
usbcore alternatives: applied 0 out of 17 patches
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
scsi_mod alternatives: applied 0 out of 7 patches
usbcore: registered new device driver usb
SCSI subsystem initialized
ehci_hcd alternatives: applied 0 out of 114 patches
mptbase alternatives: applied 0 out of 73 patches
libata alternatives: applied 0 out of 3 patches
ehci_pci alternatives: applied 0 out of 2 patches
Fusion MPT base driver 3.04.20
Copyright (c) 1999-2008 LSI Corporation
ohci_hcd alternatives: applied 0 out of 144 patches
ehci-pci 0000:60:01.2: EHCI Host Controller
ehci-pci 0000:60:01.2: new USB bus registered, assigned bus number 1
Backtrace:
  [<000000001071d5d8>] usb_hcd_pci_probe+0x330/0x4a0 [usbcore]
  [<000000001025e620>] ehci_pci_probe+0x50/0x70 [ehci_pci]
  [<00000000407d4004>] pci_device_probe+0x144/0x2a8
  [<000000004091df6c>] really_probe+0x12c/0x5a8
  [<000000004091e46c>] __driver_probe_device+0x84/0x1a0
  [<000000004091e66c>] driver_probe_device+0xe4/0x2c8
  [<000000004091eddc>] __driver_attach_async_helper+0x8c/0x160
  [<0000000040284ecc>] async_run_entry_fn+0x64/0x210
  [<000000004026b5e0>] process_one_work+0x268/0x478
  [<000000004026ba88>] worker_thread+0x298/0x740
  [<000000004027c3f4>] kthread+0x274/0x280
  [<0000000040202020>] ret_from_kernel_thread+0x20/0x28


Page fault: no context: Code=6 (Instruction TLB miss fault) at addr 0b3a029a8348
CPU: 3 PID: 57 Comm: kworker/u64:4 Not tainted 6.5.0+ #1
Hardware name: 9000/785/C8000
Workqueue: events_unbound async_run_entry_fn

      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
PSW: 00001000000001001111111100001111 Not tainted
r00-03  000000ff0804ff0f 0b3a029a83406038 000000001025e770 0000000052008c30
r04-07  000000001025e000 0000000053501000 000000005156a0a0 0000000000000000
r08-11  000000005156a000 0000000053501800 0000000053501120 000000005156a0a0
r12-15  0000000000000002 0000000040d63640 00000000516b7328 0000000000000001
r16-19  0000000050d54580 0000000000000008 0000000050d54540 0000000000010000
r20-23  0000000000001a46 000000000000000f 0002000000000002 0000000000045b38
r24-27  0000000000000000 0000000000000003 0000000000000002 000000001025e000
r28-31  0000000000002395 0000000052008d40 0000000052008ce0 0000000000001033
sr00-03  00000000000cbc00 0000000000000000 0000000000000000 00000000000cbc00
sr04-07  0000000000000000 0000000000000000 0000000000000000 0000000000000000

IASQ: 000000000b3a029a 000000000b3a029a IAOQ: 0b3a029a83406038 0b3a029a8340603c
  IIR: 43ffff80    ISR: 0000000000000002  IOR: 0000000052008ea0
  CPU:        3   CR30: 0000000051794c20 CR31: ffffffffffffffff
  ORIG_R28: 0000000000000000
  IAOQ[0]: 0xb3a029a83406038
  IAOQ[1]: 0xb3a029a8340603c
  RP(r2): ehci_pci_setup+0x100/0x780 [ehci_pci]
Backtrace:
  [<000000001071d5d8>] usb_hcd_pci_probe+0x330/0x4a0 [usbcore]
  [<000000001025e620>] ehci_pci_probe+0x50/0x70 [ehci_pci]
  [<00000000407d4004>] pci_device_probe+0x144/0x2a8
  [<000000004091df6c>] really_probe+0x12c/0x5a8
  [<000000004091e46c>] __driver_probe_device+0x84/0x1a0
  [<000000004091e66c>] driver_probe_device+0xe4/0x2c8
  [<000000004091eddc>] __driver_attach_async_helper+0x8c/0x160
  [<0000000040284ecc>] async_run_entry_fn+0x64/0x210
  [<000000004026b5e0>] process_one_work+0x268/0x478
  [<000000004026ba88>] worker_thread+0x298/0x740
  [<000000004027c3f4>] kthread+0x274/0x280
  [<0000000040202020>] ret_from_kernel_thread+0x20/0x28

Kernel panic - not syncing: Page fault: no context

This was with master.  I'll check ddb5cdbafaaa.

Dave

On 2023-09-05 3:08 p.m., Masahiro Yamada wrote:
> John David Anglin reported parisc has been broken since commit
> ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost").
>
> I checked the assembler output, and noticed function references are
> prefixed with P%, so the situation in parisc64 is similar to ia64.
>
> Fixes: ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> Reported-by: John David Anglin <dave.anglin@bell.net>
> Closes: https://lore.kernel.org/linux-parisc/1901598a-e11d-f7dd-a5d9-9a69d06e6b6e@bell.net/T/#u
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> I just checked the assembler output, and I created this patch
> based on my best guess. Only compile-tested.
> I hope somebody will run-test this patch.
>
>
>   include/linux/export-internal.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
> index 1c849db953a5..45fca09b2319 100644
> --- a/include/linux/export-internal.h
> +++ b/include/linux/export-internal.h
> @@ -52,6 +52,8 @@
>   
>   #ifdef CONFIG_IA64
>   #define KSYM_FUNC(name)		@fptr(name)
> +#elif defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
> +#define KSYM_FUNC(name)		P%name
>   #else
>   #define KSYM_FUNC(name)		name
>   #endif


-- 
John David Anglin  dave.anglin@bell.net

