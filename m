Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D979B769509
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGaLhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGaLha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:37:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACFCC3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690803424; x=1691408224; i=efault@gmx.de;
 bh=dyXJz749kJv3ruX20121R33BFCwNLgjk2KT6tCDfzlQ=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=EnpUksuEs7z7ljhCp9ZHRC5yrRe/20JFQwae7BP0lz9wJYDpoO/kXdyiCDewgcL+Q0TagN5
 PQJ/HhrNbiQcQ2XqYgvsvoYuuF11qQGviHniPLQB8nGFxSPCPOneWzlK7ioRfmKC35JNdV2T4
 mChiucEJVJW4kVmCYxq4RAfpYLfE0UtJzk9YCFwPYRRGiAb1RnfpIntyWWEoqUo4lGr08jrHw
 L4lu/cvjzxWEfYvcK7ZyX10rMPCZas3yeeMY+1/HXvBovNdzkj7x4rpfVHelmNGvwEmqmGxzY
 3uOHplu5/9kaQSHt4CJGb+McecZK7bvjFJGQYWLbL3m3BdTHap9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer-2.fritz.box ([185.191.216.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wPb-1qWBqN2uDb-007SdW; Mon, 31
 Jul 2023 13:37:04 +0200
Message-ID: <b26b34cf503ad570a3b40c72f312482921d7104f.camel@gmx.de>
Subject: Re: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     Will Deacon <will@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, lstoakes@gmail.com,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org
Date:   Mon, 31 Jul 2023 13:37:04 +0200
In-Reply-To: <20230731104340.GA24767@willie-the-truck>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
         <20230728141852.GA21718@willie-the-truck>
         <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
         <20230731104340.GA24767@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MMUQKeREATw9F48Hkh5KH8jwtgPTb3jIthu8Yo1s+5qczF1kWvH
 DPQbppPrtUnbLcR3+vfuVBDJ5sYK4DgM3QR9K5HQG3oBbhjZdzWiUfNPDudy51neSMlCoUk
 70PSe0GgUQnuGNUVLarDzlv3PPpTUqnj1yoA2DS3wpxduD4S0pD5VwOePSkaFdiT7/UjOjY
 EStnf2ernCIchvFeSNcqQ==
UI-OutboundReport: notjunk:1;M01:P0:TfNCXJ/gIdY=;phXCSzdzX7cm/HpUk6EdpkbQ87g
 cmj19wnOY9mukxOlrYJn24Cai7yXdgFsYtuq+P22TwfyoIsPiUVhJDvQ2Tc8fh5u59kEfBWb3
 63gV/nttnQA+ATShbnLY99G2V8S3cpXqvEqduIiBsDNrxSQrKv0pGC+UPgI9IxZoYmuhddAgu
 jB2XCjqb9nLbo0umK04X8rIzLx77MPcdTRCwnqm0qcUHrf/teU3dFwDpToBlaqfLB1tHQQg/+
 TZp7RHqg9d73x6eY9GqeIFKJf+/9swOMADDgjCLgUwM0UtamwWIxRNVulwL8PcElFcc1gqo+Y
 gsvBPxAxO9icSlh6zBEvE4eczc8SWBJ8/3jx3dtCVbOUslGfExepDGF2P7YlWW4vFVj37bDbO
 n9AWDo6n1N5eXQg3f8mxaXbp1tS2HeX1sSiRKWFMUcB0bLUHLRp7Gy0b7to9qUNjpOrTGGKw6
 78PtSH+ymVPbSYAQvoAuyXJcLgLS24Yv6pSemDdrGMzM4Wy4Pxo3qX4CssOtGHnMpqkNwFSvy
 a2N5T1mtExUZF5alY+OCfb4OaNvhqNGOW5p+tLfxGk/Ny6cTlz6NTvbfoZ70LtEqymGuKrqiE
 9PEG4Ay01rl+FOdIZVsHkw5ZwZZYy4bQEQv/Z0IcQ86clcEtXPCL2sIPSMuaDP4MflxjV4t62
 2UnQZVTXLESC9+ILqUfLv1InrmA1MXcIr/3rJKfad9b2uONCktFBJ54FoVM01ztsKXGkB/MIc
 6vj17RNErJy4mZPcpHGPqLAv8o8yWZrlat2e47Bqp8+G/Ov7JbqxS+xxkh1/q4BYwlsJuuY0V
 Cl5h6cEqVeZedcVEoJTSXSEXc2639Hda8m7ZZ/tWIM2Lstk5p2LSFn0qRaWDR+gZHO7Oiwd2+
 BeBoycG2WMx0kRq8fNo7c0/EABvNnE9Oy2aBlYt7SQZMHS7R5ynlXB0LXPXblex9GinD/vBQ5
 CJKEPtEEeMxjCl2yB6hNEDYREZc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-31 at 11:43 +0100, Will Deacon wrote:


> The easiest way to trigger the problem is simply:
>
> # objdump -d /proc/kcore
>
> Looking at the history, I wonder whether this is because of a combinatio=
n
> of:
>
> e025ab842ec3 ("mm: remove kern_addr_valid() completely")
>
> which removed the kern_addr_valid() check on the basis that kcore used
> copy_from_kernel_nofault() anyway, and:
>
> 2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")
>
> which replaced the copy_from_kernel_nofault() with _copy_to_user().
>
> So with both of those applied, we're missing the address check on arm64.

Hm, I see trace_printk() in the future of self and x86_64 desktop box.

While my attempt to bisect the two arm64 allocation failures was doomed
by an apparent inability to reliably type sudo perf test 26, I still
suspect they might be a part of this fossilized bug.. see last two with
funny looking addr/len.

dmesg|tail -2
[ 1506.732999] __vm_enough_memory: pid: 3824, comm: objdump, not enough me=
mory for the allocation of 64913409 pages
[ 1506.733050] __vm_enough_memory: pid: 3824, comm: objdump, not enough me=
mory for the allocation of 64913441 pages
cat trace|grep 3824
...
objdump-3824    [000] .......  1506.708497: vm_unmapped_area: addr=3D0x7fa=
9ac8000 err=3D0 total_vm=3D0x52f flags=3D0x1 len=3D0x2e7000 lo=3D0x1000 hi=
=3D0x7faa24e000 mask=3D0x0 ofs=3D0x0
objdump-3824    [000] .......  1506.708657: vm_unmapped_area: addr=3D0x7fa=
a213000 err=3D0 total_vm=3D0x816 flags=3D0x1 len=3D0x7000 lo=3D0x1000 hi=
=3D0x7faa24e000 mask=3D0x0 ofs=3D0x0
objdump-3824    [000] .......  1506.709740: vm_unmapped_area: addr=3D0x7fa=
86f7000 err=3D0 total_vm=3D0x81d flags=3D0x1 len=3D0x13d1000 lo=3D0x1000 h=
i=3D0x7faa24e000 mask=3D0x0 ofs=3D0x0
objdump-3824    [000] .......  1506.732991: vm_unmapped_area: addr=3D0x179=
95df000 err=3D0 total_vm=3D0x831 flags=3D0x1 len=3D0x3de8001000 lo=3D0x100=
0 hi=3D0x7faa24e000 mask=3D0x0 ofs=3D0x0
objdump-3824    [000] .......  1506.733049: vm_unmapped_area: addr=3D0x179=
95bf000 err=3D0 total_vm=3D0x831 flags=3D0x1 len=3D0x3de8021000 lo=3D0x100=
0 hi=3D0x7faa24e000 mask=3D0x0 ofs=3D0x0
objdump-3824    [000] .......  1506.733846: exit_mmap: mt_mod ffffff814999=
1980, DESTROY


