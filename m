Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B55F7B09BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjI0QO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjI0QOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:14:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BDD91
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:14:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5032a508e74so5003e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695831292; x=1696436092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deEAg0wdOMk2/iimIJp0P2VjFaxr/4oc1ty6m2sB+Ss=;
        b=YukGGVT2DOzkMbSOwp4IcesuKxTgo16BZVPRsD5cijtqJuDNwgr0K0t26fce+zFXSa
         gWU/MAXwOCBy9fBD2NGAv8ZMBU2qxX8Epr4C0P/q1sTqzQ5G3ZaGFZ43/QP586l0CXD2
         5H7pSpmjM/M6K+kwBcjFviB8saH5me/gCs2HlqZWhAGo7DxsjQTPPn8RoG9Qq8j2nEJs
         PcWelpUXA8DIh4x0HxtQzqxZcu3oPFDXI1lxGy3HkWSTeFlHKHP2JXxy2QRatsE517kL
         0oYlpwgdZ8pObuwuTJJtFi7EASpZdpSHo8JQEE6p+Bkb5saFShQF5l8LAe4f12XTzn0f
         dipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695831292; x=1696436092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deEAg0wdOMk2/iimIJp0P2VjFaxr/4oc1ty6m2sB+Ss=;
        b=HSPtOWEIppcvc97aJDo4kxV+Iq5EvH1+eQmWciKyQnxcvBFA61bqwF/hTBu/rvgjnu
         iJtHNOm3mLv7r29Hpp8cFhtrmoHTE0b03PJanKF6W5pywnHbVb/rSpeMMX9gXNr41Q2C
         KdeCC1Sewh1RwFUdJCa9/Sg+uT6VChBUayyA3lLrbt47z65gL2Qdqpguv+Sp4BjXOGyM
         ZX1Xu7XXojxo3rR9zH3w+qYKotmJxf9tXijDso1emOX7oPFqN1bTPuxi3GlImeXqGMi3
         PqjIR919N/agk2KZI/i3NNRwXvuU/Uh+pJJSkZKcPM0loapJcfKO+azMRYki8ffDcy+G
         IcJQ==
X-Gm-Message-State: AOJu0YxGWe4CwvFYscnNM/xqhvy0RiO1dfNlTc9ivPpuj9LBvmub/NbD
        AIJXhZ4ShM8FaOAD2q21K/wg/O4ZicTEPQaljQ/OvA==
X-Google-Smtp-Source: AGHT+IFUPtHbMGvooamvOFA6dCoa++W2n3L1mKUug8p/9C0xyUutQrkSl75OtHXX0UOmlL4Y7//sFYmAkVjhycB/T90=
X-Received: by 2002:ac2:44d2:0:b0:502:dc15:7fb with SMTP id
 d18-20020ac244d2000000b00502dc1507fbmr147845lfm.5.1695831291761; Wed, 27 Sep
 2023 09:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570185411.596431.3153227201984845022.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169570185411.596431.3153227201984845022.stgit@dwillia2-xfh.jf.intel.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 27 Sep 2023 10:14:39 -0600
Message-ID: <CAMkAt6r2VPPMZ__SQfJse8qWsUyYW3AgYbOUVM0S_Vtk=KvkxQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] virt: tdx-guest: Add Quote generation support
 using TSM_REPORTS
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Erdem Aktas <erdemaktas@google.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:17=E2=80=AFPM Dan Williams <dan.j.williams@intel=
.com> wrote:
>
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.=
com>
>
> In TDX guest, the attestation process is used to verify the TDX guest
> trustworthiness to other entities before provisioning secrets to the
> guest. The first step in the attestation process is TDREPORT
> generation, which involves getting the guest measurement data in the
> format of TDREPORT, which is further used to validate the authenticity
> of the TDX guest. TDREPORT by design is integrity-protected and can
> only be verified on the local machine.
>
> To support remote verification of the TDREPORT in a SGX-based
> attestation, the TDREPORT needs to be sent to the SGX Quoting Enclave
> (QE) to convert it to a remotely verifiable Quote. SGX QE by design can
> only run outside of the TDX guest (i.e. in a host process or in a
> normal VM) and guest can use communication channels like vsock or
> TCP/IP to send the TDREPORT to the QE. But for security concerns, the
> TDX guest may not support these communication channels. To handle such
> cases, TDX defines a GetQuote hypercall which can be used by the guest
> to request the host VMM to communicate with the SGX QE. More details
> about GetQuote hypercall can be found in TDX Guest-Host Communication
> Interface (GHCI) for Intel TDX 1.0, section titled
> "TDG.VP.VMCALL<GetQuote>".
>
> Trusted Security Module (TSM) [1] exposes a common ABI for Confidential
> Computing Guest platforms to get the measurement data via ConfigFS.
> Extend the TSM framework and add support to allow an attestation agent
> to get the TDX Quote data (included usage example below).
>
>   report=3D/sys/kernel/config/tsm/report/report0
>   mkdir $report
>   dd if=3D/dev/urandom bs=3D64 count=3D1 > $report/inblob
>   hexdump -C $report/outblob
>   rmdir $report
>
> GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
> with TDREPORT data as input, which is further used by the VMM to copy
> the TD Quote result after successful Quote generation. To create the
> shared buffer, allocate a large enough memory and mark it shared using
> set_memory_decrypted() in tdx_guest_init(). This buffer will be re-used
> for GetQuote requests in the TDX TSM handler.
>
> Although this method reserves a fixed chunk of memory for GetQuote
> requests, such one time allocation can help avoid memory fragmentation
> related allocation failures later in the uptime of the guest.
>
> Since the Quote generation process is not time-critical or frequently
> used, the current version uses a polling model for Quote requests and
> it also does not support parallel GetQuote requests.
>
> Link: https://lore.kernel.org/lkml/169342399185.3934343.30358453483269445=
19.stgit@dwillia2-xfh.jf.intel.com/ [1]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> Reviewed-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hey Dan,

I tried running your test commands on an SNP enabled guest. To build
the kernel I just checked out linus/master and applied your series. I
haven't done any debugging yet, so I will update with what I find.

root@Ubuntu2004:~#   hexdump -C $report/outblob
[  219.871875] ------------[ cut here ]------------
[  219.876642] kernel BUG at include/linux/scatterlist.h:187!
[  219.882280] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  219.887628] CPU: 0 PID: 1317 Comm: hexdump Not tainted 6.6.0-rc3-xfstest=
s-000
44-gf636850ddfc7 #1
[  219.896530] Hardware name: Google Google Compute Engine/Google Compute E=
ngine
, BIOS Google 09/26/2023
[  219.905859] RIP: 0010:enc_dec_message+0x4ed/0x570
[  219.910673] Code: c7 c0 00 00 00 80 48 2b 05 b8 4f 99 00 e9 dc fd ff ff =
0f 0b
 bb f4 ff ff ff eb b5 0f 0b 0f 0b 0f 0b e8 e7 47 ce ff 89 c3 eb 94 <0f> 0b =
0f 0b
 0f 0b 0f 0b 48 8d 7c 24 38 e8 11 6b 23 00 8b 5c 24 58
[  219.929547] RSP: 0018:ffffc90000e27a18 EFLAGS: 00010246
[  219.934893] RAX: 0000000000000000 RBX: ffffc90000e27bf8 RCX: 00000000000=
81000
[  219.942134] RDX: 0000000000000000 RSI: 0000000000080000 RDI: ffffc90080e=
27bf8
[  219.949378] RBP: ffff8881018980a0 R08: 0000000000000000 R09: ffffc90000e=
27a78
[  219.956621] R10: 0000000000026680 R11: 0000000000000008 R12: ffff888111a=
3c400
[  219.963864] R13: ffff8881018980d0 R14: ffff8881003e7000 R15: 00000000000=
00060
[  219.971106] FS:  00007fd7e75f5740(0000) GS:ffff888237c00000(0000) knlGS:=
00000
00000000000
[  219.979303] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  219.985160] CR2: 00005563500e8808 CR3: 0008000111986001 CR4: 00000000003=
70ef0
[  219.992401] Call Trace:
[  219.994955]  <TASK>
[  219.997160]  ? die+0x36/0x80
[  220.000149]  ? do_trap+0xf4/0x100
[  220.003574]  ? enc_dec_message+0x4ed/0x570
[  220.007777]  ? do_error_trap+0x65/0x80
[  220.011632]  ? enc_dec_message+0x4ed/0x570
[  220.015842]  ? exc_invalid_op+0x50/0x70
[  220.019788]  ? enc_dec_message+0x4ed/0x570
[  220.023994]  ? asm_exc_invalid_op+0x1a/0x20
[  220.028288]  ? enc_dec_message+0x4ed/0x570
[  220.032505]  ? enc_dec_message+0x16f/0x570
[  220.036711]  ? srso_alias_return_thunk+0x5/0x7f
[  220.041352]  ? srso_alias_return_thunk+0x5/0x7f
[  220.045994]  handle_guest_request+0xc6/0x330
[  220.050375]  get_ext_report+0x1e0/0x3d0
[  220.054323]  sev_report_new+0x159/0x460
[  220.058267]  tsm_report_read.part.0+0x96/0x120
[  220.062818]  configfs_bin_read_iter+0xe1/0x1e0
[  220.067377]  vfs_read+0x1db/0x310
[  220.070813]  ksys_read+0x6f/0xf0
[  220.074152]  do_syscall_64+0x3f/0x90
[  220.077843]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  220.083007] RIP: 0033:0x7fd7e7705fd2
[  220.086695] Code: c0 e9 c2 fe ff ff 50 48 8d 3d aa cb 0a 00 e8 d5 1a 02 =
00 0f
 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d =
00 f0
 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[  220.105572] RSP: 002b:00007fff9bc8fc18 EFLAGS: 00000246 ORIG_RAX: 000000=
00000
00000
[  220.113252] RAX: ffffffffffffffda RBX: 00007fd7e77e4980 RCX: 00007fd7e77=
05fd2
[  220.120496] RDX: 0000000000001000 RSI: 00005563500e7800 RDI: 00000000000=
00000
[  220.127742] RBP: 00007fd7e77e14a0 R08: 0000000000000000 R09: 00000000000=
0007c
[  220.134988] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00010
[  220.142232] R13: 00007fd7e77e08a0 R14: 0000000000000d68 R15: 00000000000=
00d68
[  220.149479]  </TASK>
[  220.151865] ---[ end trace 0000000000000000 ]---
[  220.156629] RIP: 0010:enc_dec_message+0x4ed/0x570
[  220.161479] Code: c7 c0 00 00 00 80 48 2b 05 b8 4f 99 00 e9 dc fd ff ff =
0f 0b
 bb f4 ff ff ff eb b5 0f 0b 0f 0b 0f 0b e8 e7 47 ce ff 89 c3 eb 94 <0f> 0b =
0f 0b
 0f 0b 0f 0b 48 8d 7c 24 38 e8 11 6b 23 00 8b 5c 24 58
[  220.180379] RSP: 0018:ffffc90000e27a18 EFLAGS: 00010246
[  220.185743] RAX: 0000000000000000 RBX: ffffc90000e27bf8 RCX: 00000000000=
81000
[  220.193012] RDX: 0000000000000000 RSI: 0000000000080000 RDI: ffffc90080e=
27bf8
[  220.200280] RBP: ffff8881018980a0 R08: 0000000000000000 R09: ffffc90000e=
27a78
[  220.207551] R10: 0000000000026680 R11: 0000000000000008 R12: ffff888111a=
3c400
[  220.214822] R13: ffff8881018980d0 R14: ffff8881003e7000 R15: 00000000000=
00060
[  220.222094] FS:  00007fd7e75f5740(0000) GS:ffff888237c00000(0000) knlGS:=
00000
00000000000
[  220.230329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  220.236210] CR2: 00005563500e8808 CR3: 0008000111986001 CR4: 00000000003=
70ef0
