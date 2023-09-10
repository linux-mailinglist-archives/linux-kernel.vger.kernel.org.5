Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE57F79A023
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 23:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjIJVia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIJVi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 17:38:29 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF138135;
        Sun, 10 Sep 2023 14:38:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 7E0F16015E;
        Sun, 10 Sep 2023 23:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1694381890; bh=MObt01+7aZfA9W2P7HVKiFQpaZwKZaKiEmCR728AsxI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ie7WUum+9vqlaLz+b4zeY4CqqmnrDEAQpAG63R2rtAf9/cWgaDLjonISzhkuU7aHS
         U+Ay9/nAegHSAPSEUZhUSIb3gWCW0yygknxbkKdx1HulGEFpBefVo+djuv2icH8Nql
         nS5oFw85hAq+cY1+wdoqwAUMEiuKdbG/jn5gi46gRLcDF34wGcVlEF4TzCRUgHZe8A
         eJAeBIgVj6Bo46NGkyqKFy0zR/RzKjAX3iV+b4ohe+1p2fU0i31vUOSndtmJn1HPcr
         iTaSRZ3xzeUAo/yEw5WiNdKKnlwTXjOw2crJr0ov8OqMqZWPBoAZ0tk0OE/dFFUt8V
         JffiZC9xds3QQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rhkT2tBqoYB9; Sun, 10 Sep 2023 23:38:07 +0200 (CEST)
Received: from [192.168.1.6] (78-2-200-212.adsl.net.t-com.hr [78.2.200.212])
        by domac.alu.hr (Postfix) with ESMTPSA id 209DB60157;
        Sun, 10 Sep 2023 23:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1694381887; bh=MObt01+7aZfA9W2P7HVKiFQpaZwKZaKiEmCR728AsxI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WZ2b/hzYYFO9caWVgRBRf++18NH9RHKbkn1/HIp74e8vmFn+iYaBUFif3HQfffcHv
         55CDQKpL84quBEhlJbbNjEHPrlrsexY6FHF+geCejB0BYSV5AaIMXqE5CXwE4Dew+t
         owiES2LgzpZqrZ0VVr+cybyqJiYIRh0CSnJ3/RRWChzmsxfzdyJzQ9wZ4wE2XAqWG8
         tS+ZkEgWzqiwFrGLfX8tqHrxV8XfbTr62hpT3ukeYyi+AgGmiEDZtQUSwL0Nv0N5MA
         tCblY2Y6l4i6oeGOZQ8df2Gt3lzgFZATfABXd9fGyHtfacR+nZZO9BL6Vad/14BoW2
         CEumojshO+1Xg==
Message-ID: <de0c0a43-97bd-de86-6e13-7b92610d5fdd@alu.unizg.hr>
Date:   Sun, 10 Sep 2023 23:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: starfive crypto list_add corruption
Content-Language: en-US
To:     Chris Hofstaedtler <chris@hofstaedtler.name>,
        jiajie.ho@starfivetech.com
Cc:     aurelien@aurel32.net, conor.dooley@microchip.com,
        davidlt@rivosinc.com, herbert@gondor.apana.org.au, kernel@esmil.dk,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <24laigwzjtx6scexj5otiesaolgytduhfp7ahqi7hvyhyc4fnv@vc2gqkxnp7v3>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <24laigwzjtx6scexj5otiesaolgytduhfp7ahqi7hvyhyc4fnv@vc2gqkxnp7v3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/23 22:59, Chris Hofstaedtler wrote:
>>> I got this issue, if I remember correctly, I fixed it by enabling
>>> CONFIG_ARM_AMBA and CONFIG_AMBA_PL08X. It improved things a bit,
> 
> I still see the list_add corruption trace with CONFIG_ARM_AMBA and
> CONFIG_AMBA_PL08X set:
> 
> [    3.528140] ------------[ cut here ]------------
> [    3.528535] dwmmc_starfive 16020000.mmc: IDMAC supports 32-bit address mode.
> [    3.532795] list_add corruption. next->prev should be prev (ffffffff816ec4d0), but was ffffffff80e33f38. (next=ffffffd8c0133c40).
> [    3.539866] dwmmc_starfive 16020000.mmc: Using internal DMA controller.
> [    3.551539] WARNING: CPU: 2 PID: 10 at lib/list_debug.c:27 __list_add_valid+0x8a/0xac
> [    3.551564] Modules linked in:
> [    3.551574] CPU: 2 PID: 10 Comm: kworker/u8:0 Not tainted 6.5.0zeha3-00072-g385eddf4e78f #6
> [    3.551586] Hardware name: StarFive VisionFive 2 v1.2A (DT)
> [    3.551592] Workqueue: events_unbound deferred_probe_work_func
> [    3.551607] epc : __list_add_valid+0x8a/0xac
> [    3.551618]  ra : __list_add_valid+0x8a/0xac
> [    3.551628] epc : ffffffff804d21be ra : ffffffff804d21be sp : ffffffc80006bb50
> [    3.551636]  gp : ffffffff81723980 tp : ffffffd8c0156780 t0 : 2000000000000000
> [    3.551644]  t1 : 000000000000006c t2 : 206464615f747369 s0 : ffffffc80006bb60
> [    3.551652]  s1 : ffffffd8c200ae40 a0 : 0000000000000075 a1 : 0000000000000018
> [    3.551659]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 0000000000000000
> [    3.551665]  a5 : 0000000000000000 a6 : ffffffd8c0242640 a7 : 0000000000000038
> [    3.551672]  s2 : ffffffd8c0133c40 s3 : ffffffff816ec400 s4 : ffffffd8c00f7410
> [    3.551680]  s5 : ffffffd8c200af30 s6 : ffffffff816ec4d0 s7 : ffffffd8c004c038
> [    3.551687]  s8 : 0000000000000402 s9 : ffffffff80024be4 s10: 0000000000001000
> [    3.551694]  s11: ffffffd8c008fc00 t3 : ffffffff81736f17 t4 : ffffffff81736f17
> [    3.551701]  t5 : ffffffff81736f18 t6 : ffffffff81736f17
> [    3.551707] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> [    3.551715] [<ffffffff804d21be>] __list_add_valid+0x8a/0xac
> [    3.551727] [<ffffffff808672a8>] starfive_cryp_probe+0x184/0x3fa
> [    3.551745] [<ffffffff8061fcfa>] platform_probe+0x4e/0x92
> [    3.551759] [<ffffffff8061d96a>] really_probe+0x82/0x210
> [    3.551770] [<ffffffff8061db54>] __driver_probe_device+0x5c/0xd0
> [    3.551782] [<ffffffff8061dbf4>] driver_probe_device+0x2c/0xb0
> [    3.551793] [<ffffffff8061dce6>] __device_attach_driver+0x6e/0x8e
> [    3.551805] [<ffffffff8061bc66>] bus_for_each_drv+0x5c/0xb0
> [    3.551816] [<ffffffff8061dfa4>] __device_attach+0x82/0x144
> [    3.551827] [<ffffffff8061e1dc>] device_initial_probe+0xe/0x16
> [    3.551839] [<ffffffff8061cb76>] bus_probe_device+0x86/0x88
> [    3.551849] [<ffffffff8061d73c>] deferred_probe_work_func+0x86/0xbe
> [    3.551861] [<ffffffff80024a0c>] process_one_work+0x162/0x284
> [    3.551876] [<ffffffff80024cd2>] worker_thread+0x1a4/0x348
> [    3.551889] [<ffffffff8002bde6>] kthread+0xc2/0xd6
> [    3.551900] [<ffffffff8000336a>] ret_from_fork+0xa/0x1c
> [    3.551913] ---[ end trace 0000000000000000 ]---
> 
>>> name: StarFive VisionFive 2 v1.2A (DT) epc : crypto_wait_for_test+0x8e/0x92
> [..]
>> I'll investigate this error.
> 
> I also see this panic:
> 
> [    3.558296] jh7110-crypto 16000000.crypto: will run requests pump with realtime priority
> [    3.565961] dwmmc_starfive 16020000.mmc: Version ID is 290a
> [    3.566016] dwmmc_starfive 16020000.mmc: DW MMC controller at irq 70,32 bit host data width,32 deep fifo
> [    3.574329] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    3.577585] mmc_host mmc1: card is polling.
> [    3.606327] Unable to handle kernel paging request at virtual address ffffffff800fab24
> [    3.820748] Oops [#1]
> [    3.823027] Modules linked in:
> [    3.826090] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0zeha3-00072-g385eddf4e78f #6
> [    3.832229] mmc_host mmc1: Bus speed (slot 0) = 49500000Hz (slot req 400000Hz, actual 399193HZ div = 62)
> [    3.835566] Hardware name: StarFive VisionFive 2 v1.2A (DT)
> [    3.850595] epc : starfive_rsa_enc_core+0x30/0x116
> [    3.855402]  ra : starfive_rsa_enc+0x5e/0xbc
> [    3.859679] epc : ffffffff8086937a ra : ffffffff808694be sp : ffffffc800023910
> [    3.866898]  gp : ffffffff81723980 tp : ffffffd8c0150000 t0 : ffffffd8c22380c8
> [    3.874117]  t1 : 0000000000000000 t2 : 472f9351d07df710 s0 : ffffffc800023960
> [    3.881335]  s1 : ffffffd8c013ea80 a0 : ffffffd8c013ea80 a1 : 0000000000000001
> [    3.888553]  a2 : 0000010000000000 a3 : ffffffd8c0133c40 a4 : 0000000000000002
> [    3.895770]  a5 : ffffffff800fab24 a6 : ffffffd8ff1d6d90 a7 : 0000000000000000
> [    3.902988]  s2 : ffffffd8c013ea40 s3 : ffffffd8c2238180 s4 : 0000000000000001
> [    3.910206]  s5 : ffffffd8c22380b0 s6 : ffffffd8c0133c40 s7 : 00000000000002a8
> [    3.917425]  s8 : ffffffff8114c240 s9 : 000000001f030000 s10: 0000000000000001
> [    3.924642]  s11: ffffffd8c0048300 t3 : 0a1255840a4b7df8 t4 : 28fc2f2b1f3b4e7d
> [    3.931861]  t5 : e2bb8080e13469b3 t6 : ffffffd8c2238440
> [    3.937170] status: 0000000200000120 badaddr: ffffffff800fab24 cause: 000000000000000f
> [    3.945083] [<ffffffff8086937a>] starfive_rsa_enc_core+0x30/0x116
> [    3.951183] [<ffffffff808694be>] starfive_rsa_enc+0x5e/0xbc
> [    3.956762] [<ffffffff8045edc4>] pkcs1pad_verify+0xb2/0xea
> [    3.962256] [<ffffffff8045e21a>] crypto_sig_verify+0xa2/0xd0
> [    3.967919] [<ffffffff8047e8c0>] public_key_verify_signature+0x168/0x1d2
> [    3.974625] [<ffffffff80480018>] x509_check_for_self_signed+0x58/0xa0
> [    3.981071] [<ffffffff8047f486>] x509_cert_parse+0x148/0x19e
> [    3.986735] [<ffffffff8047fd08>] x509_key_preparse+0x20/0x18c
> [    3.992485] [<ffffffff8047d8b4>] asymmetric_key_preparse+0x52/0x86
> [    3.998668] [<ffffffff8044fcb8>] __key_create_or_update+0x16c/0x372
> [    4.004941] [<ffffffff8044fecc>] key_create_or_update+0xe/0x16
> [    4.010780] [<ffffffff8047fc78>] x509_load_certificate_list+0x86/0xf6
> [    4.017226] [<ffffffff80c3a59a>] regulatory_init_db+0x92/0x124
> [    4.023068] [<ffffffff800020f0>] do_one_initcall+0x38/0x17c
> [    4.028646] [<ffffffff80c00f1c>] kernel_init_freeable+0x1a2/0x204
> [    4.034749] [<ffffffff80bb4b56>] kernel_init+0x1e/0x10a
> [    4.039979] [<ffffffff8000336a>] ret_from_fork+0xa/0x1c
> [    4.045218] Code: 0205 84aa 8a2e 000f 0140 3783 030b 4709 8793 4007 (c398) 2783
> [    4.052715] ---[ end trace 0000000000000000 ]---
> [    4.057339] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    4.064990] SMP: stopping secondary CPUs
> [    4.068927] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> Maybe this can also be investigated.
> 
> Thanks,
> Chris

Hi, Chris,

Just a hint: running the kernel log output through decode_stacktrace.sh might make it more
useful for the developers ...

Best regards,
Mirsad Todorovac
