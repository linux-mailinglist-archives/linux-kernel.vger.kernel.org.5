Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6196C769A76
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjGaPKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjGaPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:09:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47D61FDE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:09:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-317716a4622so4285278f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1690816175; x=1691420975;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=I4vO2/48289ncfyl74yVzbi9SJ+8aO99Q+q42Y/o7iA=;
        b=KMLLwvWuQB0v34U5jA7W9JWyQty3m1XLZgxxm6zAAlpRBSuBq+TxbhJrjsRfyJ9FBA
         A3kld0jeBNojm9Q2LUrMBnzh5VhG8/8GAA0kdl9YzxoDI4Cwot0BF57j4TDBZe4DPE7/
         QOUiAf+l21FB6iFaXvE7FvG0GoZU+f4EopdppzBmqQo4CwO/XDUqqTQQ68xI77Ss9f/t
         /GF/U0+S1pEa2ll1G8muN9uiChw0x14+HwD3++CdFj+n6WPzhNx3VxiCmvqmX1BJIpJa
         bMl0b5aY+q9VFP/iTaDDBQPukddst1nHdV3dvKn9ynL4uUSAgdq1JpMVs4w2mjiNFPZn
         1kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690816175; x=1691420975;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4vO2/48289ncfyl74yVzbi9SJ+8aO99Q+q42Y/o7iA=;
        b=YjzakKxdI3462yEOftCtIUQ8UxJkbKyH5kCtytXjGK+skntSRKbBeNYw0dRrXlloZT
         ER+xTSihftV9JLvR1nYRGywrYFTQ1N02YGtFaV3hm4Qy/blqM3s3Qq73g0Z4k7v6Qbix
         40NsupkW3hPU43Q3YCHkytfMcHLWyIvb4CneCVINHHkc5ned/cPCV11g2V+IyTsV//Cd
         GKMmujlWZ0lOcFzxPTxcaMEu01bczw20zWG/hQmr04G8oeQ+OKTg1hMapDHv+tNGUP99
         kqXElBobXBEDYcnyTE9gW6p7cMx13zBX0DgCgJRxfXgT4MB+yLXOOMsa3ADVC8qq819I
         F7Eg==
X-Gm-Message-State: ABy/qLbjrxALVEuyGXSk6Ih5RQoifdxrJrHf/KS7D9wuboAP8Bw8dN6v
        bDhJTdHn4kYXBU5QcZ9HAd9rwQ==
X-Google-Smtp-Source: APBJJlFA0nobe7wROd+ljsHGw7HOxtq4QXUAvZeba2N7YHxBdfwAOGihboymyObrWDI04pCCbRXzdQ==
X-Received: by 2002:a05:6000:108b:b0:314:1560:cc68 with SMTP id y11-20020a056000108b00b003141560cc68mr71125wrw.56.1690816174663;
        Mon, 31 Jul 2023 08:09:34 -0700 (PDT)
Received: from localhost ([165.225.194.195])
        by smtp.gmail.com with ESMTPSA id r8-20020adfe688000000b0031434c08bb7sm13289600wrm.105.2023.07.31.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 08:09:34 -0700 (PDT)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <2B3CA5F1CCCFEAB2+20230727034517.GB126117@1182282462>
 <87bkfwr0ew.fsf@metaspace.dk>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Yexuan Yang <1182282462@bupt.edu.cn>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Date:   Mon, 31 Jul 2023 16:14:38 +0200
In-reply-to: <87bkfwr0ew.fsf@metaspace.dk>
Message-ID: <87r0oop176.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

"Andreas Hindborg (Samsung)" <nmi@metaspace.dk> writes:

> Hi,
>
> Yexuan Yang <1182282462@bupt.edu.cn> writes:
>
>>> Over the 432 benchmark configurations, the relative performance of the Rust
>>> driver to the C driver (in terms of IOPS) is between 6.8 and -11.8 percent with
>>> an average of 0.2 percent better for reads. For writes the span is 16.8 to -4.5
>>> percent with an average of 0.9 percent better.
>>> 
>>> For each measurement the drivers are loaded, a drive is configured with memory
>>> backing and a size of 4 GiB. C null_blk is configured to match the implemented
>>> modes of the Rust driver: `blocksize` is set to 4 KiB, `completion_nsec` to 0,
>>> `irqmode` to 0 (IRQ_NONE), `queue_mode` to 2 (MQ), `hw_queue_depth` to 256 and
>>> `memory_backed` to 1. For both the drivers, the queue scheduler is set to
>>> `none`. These measurements are made using 30 second runs of `fio` with the
>>> `PSYNC` IO engine with workers pinned to separate CPU cores. The measurements
>>> are done inside a virtual machine (qemu/kvm) on an Intel Alder Lake workstation
>>> (i5-12600).
>>
>> Hi All!
>> I have some problems about your benchmark test.
>> In Ubuntu 22.02, I compiled an RFL kernel with both C null_blk driver and Rust
>> null_blk_driver as modules. For the C null_blk driver, I used the `modprobe`
>> command to set relevant parameters, while for the Rust null_blk_driver, I simply
>> started it. I used the following two commands to start the drivers:
>>
>> ```bash
>> sudo modprobe null_blk \
>>     queue_mode=2 irqmode=0 hw_queue_depth=256 \
>>     memory_backed=1 bs=4096 completion_nsec=0 \
>>     no_sched=1 gb=4;
>> sudo modprobe rnull_mod
>> ```
>>
>> After that, I tested their performance in `randread` with the fio command, specifying the first parameter as 4 and the second parameter as 1:
>>
>> ```bash
>> fio --filename=/dev/nullb0 --iodepth=64 --ioengine=psync --direct=1 --rw=randread --bs=$1k --numjobs=$2 --runtime=30 --group_reporting --name=test-rand-read --output=test_c_randread.log
>> fio --filename=/dev/rnullb0 --iodepth=64 --ioengine=psync --direct=1 --rw=randread --bs=$1k --numjobs=$2 --runtime=30 --group_reporting --name=test-rand-read --output=test_rust_randread.log
>> ```
>>
>> The test results showed a significant performance difference between the two
>> drivers, which was drastically different from the data you tested in the
>> community. Specifically, for `randread`, the C driver had a bandwidth of
>> 487MiB/s and IOPS of 124.7k, while the Rust driver had a bandwidth of 264MiB/s
>> and IOPS of 67.7k. However, for other I/O types, the performance of the C and
>> Rust drivers was more similar. Could you please provide more information about
>> the actual bandwidth and IOPS data from your tests, rather than just the
>> performance difference between the C and Rust drivers? Additionally, if you
>> could offer possible reasons for this abnormality, I would greatly appreciate
>> it!
>
> Thanks for trying out the code! I am not sure why you get these numbers.
> I am currently out of office, but I will rerun the benchmarks next week
> when I get back in. Maybe I can provide you with some scripts and my
> kernel configuration. Hopefully we can figure out the difference in our
> setups.
>

I just ran the benchmarks for that configuration again. My setup is an
Intel Alder Lake CPU (i5-12600) with Debian Bullseye user space running
a 6.2.12 host kernel with a kernel config based on the stock Debian
Bullseye (debian config + make olddefconfig). 32 GB of DDR5 4800MHz
memory. The benchmarks (and patched kernel) run inside QEMU KVM (from
Debian repos Debian 1:5.2+dfsg-11+deb11u2). I use the following qemu
command to boot (edited a bit for clarity):

"qemu-system-x86_64" "-nographic" "-enable-kvm" "-m" "16G" "-cpu" "host"
"-M" "q35" "-smp" "6" "-kernel" "vmlinux" "-append" "console=ttyS0
nokaslr rdinit=/sbin/init root=/dev/vda1 null_blk.nr_devices=0"

I use a Debian Bullseye user space inside the virtual machine.

I think I used the stock Bullseye kernel for the host when I did the
numbers for the cover letter, so that is different for this run.

Here are the results:

+---------+----------+------+---------------------+
| jobs/bs | workload | prep |          4          |
+---------+----------+------+---------------------+
|    4    | randread |  1   | 0.28 0.00 (1.7,0.0) |
|    4    | randread |  0   | 5.75 0.00 (6.8,0.0) |
+---------+----------+------+---------------------+

I used the following parameters for both tests:

Block size: 4k
Run time: 120s
Workload: randread
Jobs: 4

This is the `fio` command I used:

['fio', '--group_reporting', '--name=default', '--filename=/dev/<snip>', '--time_based=1', '--runtime=120', '--rw=randread', '--output=<snip>', '--output-format=json', '--numjobs=4', '--cpus_allowed=0-3', '--cpus_allowed_policy=split', '--ioengine=psync', '--bs=4k', '--direct=1', '--norandommap', '--random_generator=lfsr']

For the line in the table where `prep` is 1 I filled up the target
device with data before running the benchmark. I use the following `fio`
job to do that:

['fio', '--name=prep', '--rw=write', '--filename=/dev/None', '--bs=4k', '--direct=1']

Did you prepare the volumes with data in your experiment?

How to read the data in the table: For the benchmark where the drive is
prepared, Rust null_blk perform 0.28 percent better than C null_block.
For the case where the drive is empty Rust null_block performs 5.75
percent better than C null_block. I calculated the relative performance
as "(r_iops - c_iops) / c_iops * 100".

The IOPS info you request is present in the tables from the cover
letter. As mentioned in the cover letter, the numbers in parenthesis in
each cell is throughput in 1,000,000 IOPS for read and
write for the C null_blk driver. For the table above, C null_blk did
1,700,000 read IOPS in the case when the drive is prepared and 5,750,000
IOPS in the case where the drive is not prepared.

You can obtain bandwidth by multiplying IOPS by block size. I can also
provide the raw json output of `fio` if you want to have a look.

One last note is that I unload the module between each run and I do not
have both modules loaded at the same time. If you are exhausting you
memory pool this could maybe impact performance?

So things to check:
 - Do you prepare the drive?
 - Do you release drive memory after test (you can unload the module)
 - Use the lfsr random number generator
 - Do not use the randommap

I am not sure what hardware you are running on, but the throughput
numbers you obtain seem _really_ low.

Best regards
Andreas Hindborg
