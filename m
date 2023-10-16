Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6AD7CB4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjJPUdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJPUdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:33:51 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7815D9B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:33:48 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c4bad60a1aso2978207a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697488428; x=1698093228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRWY+QElkskL8wemRIg4NTsWbtaxxzWjt8U5HujW9kw=;
        b=RRs4RrpqE297HI6zPAO0jNkc0jn2SsqnmG9ToafrxNXDTSEJ3xO8DhA5WCV+EgrSwG
         N7MwY/5V0SrcWm53l3knH/z2IWH0bo4NyQGCrZoIRzOyrx3dKzLO32mdQZyBFV7/7Lfg
         +OSdXtHRuZU/QQAoONsJjeW45yP3/YgrlumQFr5uIxNwicYRnqcl+4tPB53aUxSNp2XJ
         pe9UuynH28GbMSgUDcCV6ExeMN+O/UGHe31c+AhT33paV8FbVR7B4b0bLWKXsByGIqji
         gd0YLyHvS5M5ANeSldp+UU5xScA3puWdKuyJkqUpCBIn1kIjO7znEMAM4CykKyyWt04P
         ufjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697488428; x=1698093228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRWY+QElkskL8wemRIg4NTsWbtaxxzWjt8U5HujW9kw=;
        b=vzcCdOTBd272loSpy3nW0pa1ic1YEOZYqsspMZuILi6UoMxKs7V9hISBJQ0dopHPjw
         57QJoAQaxoblBAo9DizZ2Ia8F1oojlPDMRU38IHbhFEVyBznF1/DbzMApxlDyJOcjbyK
         cNdB0rvlukNSfd89BadhNrqYuikM70J9G8a0w7VTCp6G3ma99ZzqHfqdNpdgnTFSRe/f
         IG3oLTkvFcyuyjYuXZ0IcKzgp6jd+f+ChT7TpCMw/Ipq4uOObEJ+0FhRG72MpdVNcFCT
         Y4yiO8ZlZdywyo8KRrTWGnFSJVC67P9f7Vqq19mEHy1Pwohj9R/rsKxQK7Hz38FyFhuj
         o+TQ==
X-Gm-Message-State: AOJu0YxhSqR0MHBdR7l9saw0tjqPjoLdDk3YnfSt57gidMPHY1EJjeNA
        wBC5KT8Ranzzijc0WqLg9nA=
X-Google-Smtp-Source: AGHT+IG0cGbclFM3Cfjk+8WyKdDCoUvHnAS14MOWRm9NlAwNWKrqzGbW2SpzErRD8nEDumguRXVd2Q==
X-Received: by 2002:a9d:6858:0:b0:6bc:bd1a:26d with SMTP id c24-20020a9d6858000000b006bcbd1a026dmr344562oto.15.1697488427735;
        Mon, 16 Oct 2023 13:33:47 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:f4c2:1fbd:107b:b16c? ([2001:df0:0:200c:f4c2:1fbd:107b:b16c])
        by smtp.gmail.com with ESMTPSA id f123-20020a625181000000b0068c006dd5c1sm334087pfb.115.2023.10.16.13.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 13:33:47 -0700 (PDT)
Message-ID: <7286cd41-4f06-8afc-b8c5-acc617771daf@gmail.com>
Date:   Tue, 17 Oct 2023 09:33:40 +1300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH/RFC] m68k: Add full preempt support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <7858a184cda66e0991fd295c711dfed7e4d1248c.1696603287.git.geert@linux-m68k.org>
 <CAMuHMdUQ72KOPw5vxNfhjoTR-SsaELeKneBmyQPYEWa_o5OZZA@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdUQ72KOPw5vxNfhjoTR-SsaELeKneBmyQPYEWa_o5OZZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 17/10/23 01:23, Geert Uytterhoeven wrote:
> On Fri, Oct 6, 2023 at 4:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> Currently, a Preemptible Kernel is only supported on the Coldfire CPU
>> family.  Extend preempt support to the full Classic M68K CPU family
>> (68020+ with MMU, and 68000-derivatives without MMU).
>>
>> Make sure preemption is disabled in loops involving cache and TLB
>> flushing.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> Tested on ARAnyM, using none/voluntary/full preemption.
>> Compile-tested on 68000.
>>
>> I don't know if all of the preempt_{dis,en}able() pairs are really
>> needed, or if we need more of them.  I just followed what some other
>> architectures are doing.
>>
>> Without the preempt_{dis,en}able() pairs, the kernel panics on ARAnyM while
>> starting early userspace (Debian 4.0), cfr. below.
>> Does full preemption work on Coldfire without?
>> Thanks for your comments!
>>
>>      BUG: Bad rss-counter state mm:93ade98e type:MM_FILEPAGES val:-7
>>      BUG: Bad rss-counter state mm:93ade98e type:MM_ANONPAGES val:-1
>>      Kernel panic - not syncing: table already free!
> Ran into one of these again, once, so probably we need more
> preempt_{dis,en}able() pairs, but where?
>
>      BUG: Bad rss-counter state mm:9bb416c6 type:MM_FILEPAGES val:-20
>      BUG: Bad rss-counter state mm:9bb416c6 type:MM_ANONPAGES val:-6

Is that significant here? In particular, does this condition cause a 
fault signal sent to the associated process?

If I read the mmput() code right, this is just a warning happening 
during process exit. The stack trace suggests that process exit was 
forced by a signal.

Maybe we should disable preemption until signal handling is complete?

Your patch to entry.S does not check for pending signals before 
preempting the kernel on return from exception or interrupt ...

Cheers,

     Michael


>      Kernel panic - not syncing: table already free!
>      CPU: 0 PID: 480 Comm: grep Not tainted
> 6.6.0-rc6-atari-01887-g1ab3ae298649 #1601
>      Stack from 018c9c8c:
>              018c9c8c 0048a940 0048a940 00000000 00000001 003c0caa
> 0048a940 003b9b96
>              00000001 00000001 01a58000 01a62100 01a5b000 000cf316
> 018c9dd2 00006440
>              0047d67f 80039000 c0000000 01a58b00 80039000 80000000
> c0000000 01a62100
>              01a5b000 000cfd0e 01a58b00 00000001 ffffffff 018c9db2
> 00000000 000cfb36
>              80000000 01a60a68 01a60a68 003aa02e 000dbd0a 000d557c
> 80000000 80038fff
>              80038fff bfffffff 000cfd8e 018c9dd2 80000000 80039000
> 00000000 c0000000
>      Call Trace: [<003c0caa>] dump_stack+0xc/0x10
>       [<003b9b96>] panic+0xd8/0x256
>       [<000cf316>] pmd_offset.isra.0+0x0/0x20
>       [<00006440>] free_pointer_table+0x68/0x124
>       [<000cfd0e>] free_pgd_range+0x1d8/0x1ea
>       [<000cfb36>] free_pgd_range+0x0/0x1ea
>       [<003aa02e>] mas_find+0x0/0x4c
>       [<000dbd0a>] unlink_anon_vmas+0x0/0x108
>       [<000d557c>] unlink_file_vma+0x0/0x40
>       [<000cfd8e>] free_pgtables+0x6e/0x80
>       [<00045eec>] up_read+0x0/0x62
>       [<000d63fc>] exit_mmap+0x118/0x1ee
>       [<0000c001>] asinbig+0x25/0x34
>       [<0000ffff>] EXPTBL+0x2eb/0x400
>       [<0000ffff>] EXPTBL+0x2eb/0x400
>       [<00021f10>] __mmput+0x18/0xae
>       [<00025cce>] do_exit+0x2b4/0x7ba
>       [<00026316>] do_group_exit+0x1e/0x96
>       [<0002e354>] get_signal+0x19c/0x694
>       [<000032fc>] test_ti_thread_flag+0x0/0x14
>       [<0002d6b6>] force_sig_info_to_task+0xb0/0xea
>       [<00003caa>] do_notify_resume+0x36/0x4a0
>       [<0002d970>] force_sig_fault_to_task+0x32/0x3e
>       [<0002d990>] force_sig_fault+0x14/0x1a
>       [<0000597c>] send_fault_sig+0x24/0x84
>       [<00002632>] do_signal_return+0x10/0x1a
>       [<00088000>] adjust_reg_min_max_vals+0x106/0x140c
>
>      ---[ end Kernel panic - not syncing: table already free! ]---
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
