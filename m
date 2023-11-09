Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BEA7E6254
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjKICnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjKICnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:43:22 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA0E25A3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 18:43:20 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b497c8575aso352335b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 18:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1699497800; x=1700102600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2BPILWUudgjxtMiGaYlnaXfmp61Yn6LnZ4RtnwFCHg=;
        b=lvufzeQ8UMlQoLcCZDtJKVEu3PwBRubxFrx+ATUivHBCB4tC7Al2Tq4dsSv2jUK84J
         dGvZLSOCelz6ryfQZRAdlZLqFkBRP3DFxWfqLMzikZ+wHqx5S37WKLQT4KcIBVEf7wyU
         GYdZs2GkYgDncewocH7TxNbOpaUxwjZUQMobiAk37Q9YdXA4x0asYis1AP4xlr5RR6Nt
         cFl/qZv9Pgmf6zJ9SR/b7730ONauqOEqzZZ+fe5dg7u2KeZf2ouF+VElyK9gAdqx71l8
         /O9IesSBcpcJ8FU1Z/CzHAHF6rvm/pt/+LQyW+7MmnO9osHFqO40L8Bu0UrQpiRKIucV
         2+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699497800; x=1700102600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a2BPILWUudgjxtMiGaYlnaXfmp61Yn6LnZ4RtnwFCHg=;
        b=VF9qbtQzlbJDaqxRnocC9hQK2SJvmzCpT1sTIWrm1dgN9lYjQ4fQWGxu+33tCG8+jL
         aqaI9svPHFJzExrcmHYs8xhJTIyMXqRcqYCRm7it6iI1OKbLNyEQwQvIeR8QRfGWu9sm
         8a3xJfwUVfUerWP76Wt4N54M0+BuJZSV5UmPPrFHhqtJpwXAa2zC+c4dXHNKnXMKoQnE
         zXHsajiB8iCBy1EYLl89pkpsqscOqvkIFysvoQC+dCs3lBflfqRKdjqd4Linv8bJylqT
         1DsAOWlbRY/X6YDrhY6AKlH0l2DdVjFmXMreSdsoKu0T+jgENyiW+4IRWTMVIB8YtziD
         ptVg==
X-Gm-Message-State: AOJu0Yw5DQ7QP3WrTQTbJx57/BgcH+ticU1ApaGUSvutM1WDNgDSMvM6
        psX7LcJnCflt+5oKr95otFUONQ==
X-Google-Smtp-Source: AGHT+IHnTyAFNmPUlZLOrNFdfKFSUdzX5rWlA4LKsRP2dEqyYMGoq4uiEYOj8AOUPkJHMW8WiIcc9g==
X-Received: by 2002:a05:6a20:9385:b0:160:97a3:cae9 with SMTP id x5-20020a056a20938500b0016097a3cae9mr4620550pzh.54.1699497799829;
        Wed, 08 Nov 2023 18:43:19 -0800 (PST)
Received: from [10.54.24.52] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b0027722832498sm193666pjb.52.2023.11.08.18.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 18:43:19 -0800 (PST)
Message-ID: <04f0842e-abbf-4e8f-a458-d49ff1d26e71@shopee.com>
Date:   Thu, 9 Nov 2023 10:43:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boning: use a read-write lock in bonding_show_bonds()
To:     Eric Dumazet <edumazet@google.com>
Cc:     j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231108064641.65209-1-haifeng.xu@shopee.com>
 <CANn89iJnjp8YYYLqtfAGg6PU9iiSrKbMU43wgDkuEVqX8kSCmA@mail.gmail.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <CANn89iJnjp8YYYLqtfAGg6PU9iiSrKbMU43wgDkuEVqX8kSCmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/8 22:19, Eric Dumazet wrote:
> On Wed, Nov 8, 2023 at 7:47 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>> call stack:
> 
> These stacks should either be removed from the changelog, or moved
> _after_ the description
> of the problem. These are normal looking call stacks, you are not
> fixing a crash or deadlock.
> 
>> ......
>> PID: 210933  TASK: ffff92424e5ec080  CPU: 13  COMMAND: "kworker/u96:2"
>> [ffffa7a8e96bbac0] __schedule at ffffffffb0719898
>> [ffffa7a8e96bbb48] schedule at ffffffffb0719e9e
>> [ffffa7a8e96bbb68] rwsem_down_write_slowpath at ffffffffafb3167a
>> [ffffa7a8e96bbc00] down_write at ffffffffb071bfc1
>> [ffffa7a8e96bbc18] kernfs_remove_by_name_ns at ffffffffafe3593e
>> [ffffa7a8e96bbc48] sysfs_unmerge_group at ffffffffafe38922
>> [ffffa7a8e96bbc68] dpm_sysfs_remove at ffffffffb021c96a
>> [ffffa7a8e96bbc80] device_del at ffffffffb0209af8
>> [ffffa7a8e96bbcd0] netdev_unregister_kobject at ffffffffb04a6b0e
>> [ffffa7a8e96bbcf8] unregister_netdevice_many at ffffffffb046d3d9
>> [ffffa7a8e96bbd60] default_device_exit_batch at ffffffffb046d8d1
>> [ffffa7a8e96bbdd0] ops_exit_list at ffffffffb045e21d
>> [ffffa7a8e96bbe00] cleanup_net at ffffffffb045ea46
>> [ffffa7a8e96bbe60] process_one_work at ffffffffafad94bb
>> [ffffa7a8e96bbeb0] worker_thread at ffffffffafad96ad
>> [ffffa7a8e96bbf10] kthread at ffffffffafae132a
>> [ffffa7a8e96bbf50] ret_from_fork at ffffffffafa04b92
>>
>> 290858 PID: 278176  TASK: ffff925deb39a040  CPU: 32  COMMAND: "node-exporter"
>> [ffffa7a8d14dbb80] __schedule at ffffffffb0719898
>> [ffffa7a8d14dbc08] schedule at ffffffffb0719e9e
>> [ffffa7a8d14dbc28] schedule_preempt_disabled at ffffffffb071a24e
>> [ffffa7a8d14dbc38] __mutex_lock at ffffffffb071af28
>> [ffffa7a8d14dbcb8] __mutex_lock_slowpath at ffffffffb071b1a3
>> [ffffa7a8d14dbcc8] mutex_lock at ffffffffb071b1e2
>> [ffffa7a8d14dbce0] rtnl_lock at ffffffffb047f4b5
>> [ffffa7a8d14dbcf0] bonding_show_bonds at ffffffffc079b1a1 [bonding]
>> [ffffa7a8d14dbd20] class_attr_show at ffffffffb02117ce
>> [ffffa7a8d14dbd30] sysfs_kf_seq_show at ffffffffafe37ba1
>> [ffffa7a8d14dbd50] kernfs_seq_show at ffffffffafe35c07
>> [ffffa7a8d14dbd60] seq_read_iter at ffffffffafd9fce0
>> [ffffa7a8d14dbdc0] kernfs_fop_read_iter at ffffffffafe36a10
>> [ffffa7a8d14dbe00] new_sync_read at ffffffffafd6de23
>> [ffffa7a8d14dbe90] vfs_read at ffffffffafd6e64e
>> [ffffa7a8d14dbed0] ksys_read at ffffffffafd70977
>> [ffffa7a8d14dbf10] __x64_sys_read at ffffffffafd70a0a
>> [ffffa7a8d14dbf20] do_syscall_64 at ffffffffb070bf1c
>> [ffffa7a8d14dbf50] entry_SYSCALL_64_after_hwframe at ffffffffb080007c
>> ......
>>
>> Problem description:
>>
>> Thread 210933 holds the rtnl_mutex and tries to acquire the kernfs_rwsem,
>> but there are many readers which hold the kernfs_rwsem, so it has to sleep
>> for a long time to wait the readers release the lock. Thread 278176 and any
>> other threads which call bonding_show_bonds() also need to wait because
>> they try to accuire the rtnl_mutex.
> 
> acquire
> 
>>
>> bonding_show_bonds() uses rtnl_mutex to protect the bond_list traversal.
>> However, the addition and deletion of bond_list are only performed in
>> bond_init()/bond_uninit(), so we can intoduce a separate read-write lock
> 
> introduce
> 
>> to synchronize bond list mutation.
>>
>> What's the benefits of this change?
>>
>> 1) All threads which call bonding_show_bonds() only wait when the
>> registration or unregistration of bond device happens.
>>
>> 2) There are many other users of rtnl_mutex, so bonding_show_bonds()
>> won't compete with them.
>>
>> In a word, this change reduces the lock contention of rtnl_mutex.
>>
> 
> This looks good to me, but please note:
> 
> 1) This is net-next material, please resend next week, because
> net-next is currently closed during the merge window.
> 
> 2) Using a spell checker would point few typos (including in the title
> "boning" -> "bonding")
> 
> Thanks.

Thanks for your review, I 'll send a new patch next week.
