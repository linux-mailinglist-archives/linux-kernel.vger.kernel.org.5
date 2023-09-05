Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE087932C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 01:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243325AbjIEX7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 19:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjIEX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:59:11 -0400
Received: from cmx-mtlrgo001.bell.net (mta-mtl-003.bell.net [209.71.208.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0C1AB;
        Tue,  5 Sep 2023 16:59:07 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [142.198.135.111]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 64C35282037E9D70
X-CM-Envelope: MS4xfMZOeoLC1ZyliLnrYcNL8rcSX1FQsv+QSr6yamJep8J7IwEiRAkfqllSJj3Ix6RpB1xKWd2XrR9/bCNq7Aeleqvp5UIlNwIgtVf0/AkBYTYb2o7PdI+f
 RPZICdLhonibeHz/wwBMuYmMz9e/WQKef6q4uzZspV6P0juaFtiIaPTmxnZRa8TO62joNFQUCm1PTMrlZ65XSvKhbIYsylQmM2JyVCymqohqTUCWTtTmnEBR
 dw/Kob9iWsFlnP0iFd1iI8Yz6WYwlnOB4mTLVA5VSsspRQop+RMOpXv4gN2NU3kh3NuNnc9QUICJolQ5eE34/DA+cYx7ba/X+m0oUd6XjFCBgaKmC2A3OAKD
 W0OT18Uxw9nEXZz4N4P+HDCUNQKhOeeD2yQzxCZTyaLj1Pgu+/KiDgkUU14ocOkKN1yf91qKEuzwI/7pj6kkhJHEysK/sA==
X-CM-Analysis: v=2.4 cv=W7Nb6Tak c=1 sm=1 tr=0 ts=64f7c0c5
 a=m0hBPjpnfWKpZW+YOe+Hqw==:117 a=m0hBPjpnfWKpZW+YOe+Hqw==:17
 a=IkcTkHD0fZMA:10 a=FBHGMhGWAAAA:8 a=sxHeeXqbiIlOdLNL7AwA:9 a=QEXdDO2ut3YA:10
 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (142.198.135.111) by cmx-mtlrgo001.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 64C35282037E9D70; Tue, 5 Sep 2023 19:59:01 -0400
Message-ID: <c6568683-86b4-c48d-ed37-f1f87677eb44@bell.net>
Date:   Tue, 5 Sep 2023 19:59:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] linux/export: fix reference to exported functions for
 parisc64
Content-Language: en-US
From:   John David Anglin <dave.anglin@bell.net>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230905190828.790400-1-masahiroy@kernel.org>
 <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
In-Reply-To: <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
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

On 2023-09-05 5:57 p.m., John David Anglin wrote:
> I'll check ddb5cdbafaaa.
Similar fault with ddb5cdbafaaa:

sata_sil24 0000:00:01.0: Applying completion IRQ loss on PCI-X errata fix
Backtrace:
scsi host2: sata_sil24
  [<0000000040bf2c00>] mutex_lock+0x48/0xc8
  [<000000004023d370>] cpu_hotplug_disable+0x80/0x98
scsi host3: sata_sil24
  [<0000000040792314>] pci_device_probe+0x144/0x2a8
  [<00000000408af87c>] really_probe+0x12c/0x5a8
scsi host4: sata_sil24
  [<00000000408afd7c>] __driver_probe_device+0x84/0x1a0
  [<00000000408aff44>] driver_probe_device+0xac/0x260
scsi host5: sata_sil24
  [<00000000408b0684>] __driver_attach_async_helper+0x8c/0x160
  [<000000004028043c>] async_run_entry_fn+0x64/0x1d0
ata3: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80080000 ir6
  [<0000000040269c88>] process_one_work+0x238/0x520
  [<000000004026a184>] worker_thread+0x214/0x770
ata4: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80082000 ir6
  [<00000000402788d4>] kthread+0x274/0x280
ata5: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80084000 ir6
  [<0000000040202020>] ret_from_kernel_thread+0x20/0x28
ata6: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80086000 ir6


Page fault: no context: Code=6 (Instruction TLB miss fault) at addr 0b3a029a8348
CPU: 0 PID: 10 Comm: kworker/u64:0 Not tainted 6.4.0-rc2+ #1
Hardware name: 9000/785/C8000
Workqueue: events_unbound async_run_entry_fn

      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
PSW: 00001000000001001111111100001111 Not tainted
r00-03  000000ff0804ff0f 0b3a029a83406038 0000000000010770 0000000050d94c50
r04-07  0000000000010000 0000000053a97000 00000000515398b0 0000000000000000
r08-11  0000000051539800 0000000053a97800 0000000053a97120 00000000515398b0
r12-15  0000000050c10000 0000000000000002 0000000040d54d60 0000000000000001
r16-19  0000000040ca1d20 0000000050ce46c0 0000000050d56150 0000000000020000
r20-23  000000007f41c000 000000000000000f 0002000000000002 0000000000044b38
r24-27  0000000000000000 0000000000000003 0000000000000002 0000000000010000
r28-31  0000000000002395 0000000050d94d60 0000000050d94d00 0000000000001033
sr00-03  00000000000c7000 0000000000000000 0000000000000000 00000000000c5c00
sr04-07  0000000000000000 0000000000000000 0000000000000000 0000000000000000

IASQ: 000000000b3a029a 000000000b3a029a IAOQ: 0b3a029a83406038 0b3a029a8340603c
  IIR: 43ffff80    ISR: 0000000000000dc0  IOR: 00000000402849ac
  CPU:        0   CR30: 0000000050d56150 CR31: ffffffffffffffff
  ORIG_R28: 0000000000000080
  IAOQ[0]: 0xb3a029a83406038
  IAOQ[1]: 0xb3a029a8340603c
  RP(r2): ehci_pci_setup+0x100/0x780 [ehci_pci]
Backtrace:
  [<0000000040bf2c00>] mutex_lock+0x48/0xc8
  [<000000004023d370>] cpu_hotplug_disable+0x80/0x98
  [<0000000040792314>] pci_device_probe+0x144/0x2a8
  [<00000000408af87c>] really_probe+0x12c/0x5a8
  [<00000000408afd7c>] __driver_probe_device+0x84/0x1a0
  [<00000000408aff44>] driver_probe_device+0xac/0x260
  [<00000000408b0684>] __driver_attach_async_helper+0x8c/0x160
  [<000000004028043c>] async_run_entry_fn+0x64/0x1d0
  [<0000000040269c88>] process_one_work+0x238/0x520
  [<000000004026a184>] worker_thread+0x214/0x770
  [<00000000402788d4>] kthread+0x274/0x280
  [<0000000040202020>] ret_from_kernel_thread+0x20/0x28

Kernel panic - not syncing: Page fault: no context

Dave

-- 
John David Anglin  dave.anglin@bell.net

