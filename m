Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8AD76648C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjG1Gyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjG1Gyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:54:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CAEE4F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:54:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so2281825a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1690527274; x=1691132074;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=jbLVZA6GLdYVOmzJTJTIy97G+xSErqL2fwBMteHvG6U=;
        b=ME8bUHPXmCp2WyNtI7fWv/WvfvPz6H8bKBcPDxs24TfyA0qZz3pUF+5UYfdseXt9bJ
         PS5Am3gaf3WY+164knk9n4DiWAoAuJQSdfn9ZdhlrGVuwd5BWxQljCw1qO3qtYwkFhcb
         0qgPfc0BvWgHPwxIFToLSnVNKC7yQYzcyYvh6aC8E4Iha+bCR/kBZi3Gp5UVGhAU4H1R
         SVHsxCZqDE6VblfdrtN4ZgYspiQqYOYYguxYNvuczbskl0sdsf3tQ0VLkin/PqHVL+jW
         MsQsd9ZwdDwgVz8c0MzuoLTx2jJ2cAzUYMATkGHWnrqTqFTjVfSJHGjik4/xmlie+Uov
         YlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690527274; x=1691132074;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbLVZA6GLdYVOmzJTJTIy97G+xSErqL2fwBMteHvG6U=;
        b=JwNuck4KJkv+97MV2k2CZJdPOTYr3DPgUfS3una3DMNEMYbWPlSmzkOSfz6ZPImRz7
         l5RoV4nzILO3OBYCwKLPGhI8NVdwlGshCdqp8hk3QMZeKBHm6KjiW7RUdi+5S4rHJPVi
         kk93Px9Ni54ClSg8ijxUyvGPYtbKwkSiGk7ncdtAWwAvENMb7nxgR69Yws7TAWU/BcHd
         kKXwLm0xT0+UlUZTyKf4L8UPruNKw0ld+JWgw5dhLk4UxvuTp57nhdq5LycfDmTKavZm
         T0fSLFeWGYoIR5ob32urRhrBNzU0H3/WEoxfPnCJRkdSI2erbdhRpmmd6WFmImyWiq0k
         6BOg==
X-Gm-Message-State: ABy/qLZ+7+J1pUilcR/JxQz2EktIsXyBr0YNVk0rRn5UUIEWjL+TFl8T
        /9Ngjy1hJJz1kYMW3L7zErDaUA==
X-Google-Smtp-Source: APBJJlFwFT1CYbfHt9QePH98wDjc7kgS385mF3cKczDnQtT19F22NlsjwvcOxEyT3VqGtVnHNorAAg==
X-Received: by 2002:aa7:d311:0:b0:522:30d5:6065 with SMTP id p17-20020aa7d311000000b0052230d56065mr953242edq.21.1690527274073;
        Thu, 27 Jul 2023 23:54:34 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id d15-20020a056402516f00b00521f4ee396fsm1448246ede.12.2023.07.27.23.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 23:54:33 -0700 (PDT)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <2B3CA5F1CCCFEAB2+20230727034517.GB126117@1182282462>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Yexuan Yang <1182282462@bupt.edu.cn>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
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
Date:   Fri, 28 Jul 2023 08:49:53 +0200
In-reply-to: <2B3CA5F1CCCFEAB2+20230727034517.GB126117@1182282462>
Message-ID: <87bkfwr0ew.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Yexuan Yang <1182282462@bupt.edu.cn> writes:

>> Over the 432 benchmark configurations, the relative performance of the Rust
>> driver to the C driver (in terms of IOPS) is between 6.8 and -11.8 percent with
>> an average of 0.2 percent better for reads. For writes the span is 16.8 to -4.5
>> percent with an average of 0.9 percent better.
>> 
>> For each measurement the drivers are loaded, a drive is configured with memory
>> backing and a size of 4 GiB. C null_blk is configured to match the implemented
>> modes of the Rust driver: `blocksize` is set to 4 KiB, `completion_nsec` to 0,
>> `irqmode` to 0 (IRQ_NONE), `queue_mode` to 2 (MQ), `hw_queue_depth` to 256 and
>> `memory_backed` to 1. For both the drivers, the queue scheduler is set to
>> `none`. These measurements are made using 30 second runs of `fio` with the
>> `PSYNC` IO engine with workers pinned to separate CPU cores. The measurements
>> are done inside a virtual machine (qemu/kvm) on an Intel Alder Lake workstation
>> (i5-12600).
>
> Hi All!
> I have some problems about your benchmark test.
> In Ubuntu 22.02, I compiled an RFL kernel with both C null_blk driver and Rust
> null_blk_driver as modules. For the C null_blk driver, I used the `modprobe`
> command to set relevant parameters, while for the Rust null_blk_driver, I simply
> started it. I used the following two commands to start the drivers:
>
> ```bash
> sudo modprobe null_blk \
>     queue_mode=2 irqmode=0 hw_queue_depth=256 \
>     memory_backed=1 bs=4096 completion_nsec=0 \
>     no_sched=1 gb=4;
> sudo modprobe rnull_mod
> ```
>
> After that, I tested their performance in `randread` with the fio command, specifying the first parameter as 4 and the second parameter as 1:
>
> ```bash
> fio --filename=/dev/nullb0 --iodepth=64 --ioengine=psync --direct=1 --rw=randread --bs=$1k --numjobs=$2 --runtime=30 --group_reporting --name=test-rand-read --output=test_c_randread.log
> fio --filename=/dev/rnullb0 --iodepth=64 --ioengine=psync --direct=1 --rw=randread --bs=$1k --numjobs=$2 --runtime=30 --group_reporting --name=test-rand-read --output=test_rust_randread.log
> ```
>
> The test results showed a significant performance difference between the two
> drivers, which was drastically different from the data you tested in the
> community. Specifically, for `randread`, the C driver had a bandwidth of
> 487MiB/s and IOPS of 124.7k, while the Rust driver had a bandwidth of 264MiB/s
> and IOPS of 67.7k. However, for other I/O types, the performance of the C and
> Rust drivers was more similar. Could you please provide more information about
> the actual bandwidth and IOPS data from your tests, rather than just the
> performance difference between the C and Rust drivers? Additionally, if you
> could offer possible reasons for this abnormality, I would greatly appreciate
> it!

Thanks for trying out the code! I am not sure why you get these numbers.
I am currently out of office, but I will rerun the benchmarks next week
when I get back in. Maybe I can provide you with some scripts and my
kernel configuration. Hopefully we can figure out the difference in our
setups.

Best regards,
Andreas
