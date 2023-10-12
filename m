Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9EC7C7941
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442991AbjJLWHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443010AbjJLWHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:07:50 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36516D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:07:49 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bc9353be9bso212139a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697148468; x=1697753268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BX2/UVo10WOnZMCSNHexte/JXK8qu4Upt2chvVFA7x8=;
        b=Lvn7N9uv69OZ121AzsqYZ2McrKtiTMN2tMUBLVvOksqkKLDH+drXyGVEVaXdxKGXTx
         Phb21hBcMMvtmC913ArKg86TM83fNUWdt7laSTB8IF6uWHxQDsC81Z5o+GS5GA42AWv8
         mPXjVN/rkqLLJCTzlddx52AtBxdiwEArOLdZWa1CJhdFKijFmJcAjZcqeHeiUhoDGI/x
         qnOlMa53ZqH+u6HjpAlgHTBUhKnKOvVYHFOmkHvFDrsn7TnjTn2+1tz6R3C7C1KOTuui
         KO5Ki88kPktgoJHCceTHiKrtkqZk1F5mT0lg48Jn0EfRFlmvai8eqdVUgHdM2CKRt8VO
         DZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697148468; x=1697753268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX2/UVo10WOnZMCSNHexte/JXK8qu4Upt2chvVFA7x8=;
        b=gnSY95iNXwa/zCa79nkNzspu9V/bhg1viaq/W+gYkiPp1CDS5FE8vDuLjDWGhgqoIP
         SfTfpLG3XGblSU8JMuA9vB8Mwk2ylRyBnxxXlnpjou3pEI1BcSAmXmkdy7ovKetfCDqn
         ADsbtdeFS6GTA2VA7c5acLJF562oxEOsE7L/NimXU6ErGdbKwkZbezJXU7knjLBP0Odk
         hmMfDGU3lZVb48pzdobPCKQq7DwnR+b3QtRGc7jLMclU9F6huBsM/3TCeZ9+fuQWw17r
         xQpQXvqQjvTA896l8ArpXOFVFndYkDSs5un8nc0y738O5nGrMlCzMw7fmijpqlGTg/Zr
         DNZw==
X-Gm-Message-State: AOJu0YwPX9cPrg4JtZTFZeadlu6W16I1zmLZsBKH9Ms3MNd03hht/IQq
        GrHc6EuQgTbivzelvOylWpq+lQbhGetjxQUjdHBNDQ==
X-Google-Smtp-Source: AGHT+IE69wm+LfM1P9hVAjNQFO/fTOBepgHbSEMYy1IVhm+plv/9fJIRwOYYZ4z6oxAD4V9Qyp04lg==
X-Received: by 2002:a9d:51cb:0:b0:6bf:5010:9d35 with SMTP id d11-20020a9d51cb000000b006bf50109d35mr25251752oth.3.1697148468435;
        Thu, 12 Oct 2023 15:07:48 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id o10-20020a056a001bca00b0068c670afe30sm7442663pfw.124.2023.10.12.15.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 15:07:47 -0700 (PDT)
Message-ID: <eb150179-c328-4058-80e3-f517d45310c4@kernel.dk>
Date:   Thu, 12 Oct 2023 16:07:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
Content-Language: en-US
To:     Dan Clash <daclash@linux.microsoft.com>, audit@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        dan.clash@microsoft.com
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 3:55 PM, Dan Clash wrote:
> An io_uring openat operation can update an audit reference count
> from multiple threads resulting in the call trace below.
> 
> A call to io_uring_submit() with a single openat op with a flag of
> IOSQE_ASYNC results in the following reference count updates.
> 
> These first part of the system call performs two increments that do not race.
> 
> do_syscall_64()
>   __do_sys_io_uring_enter()
>     io_submit_sqes()
>       io_openat_prep()
>         __io_openat_prep()
>           getname()
>             getname_flags()       /* update 1 (increment) */
>               __audit_getname()   /* update 2 (increment) */
> 
> The openat op is queued to an io_uring worker thread which starts the
> opportunity for a race.  The system call exit performs one decrement.
> 
> do_syscall_64()
>   syscall_exit_to_user_mode()
>     syscall_exit_to_user_mode_prepare()
>       __audit_syscall_exit()
>         audit_reset_context()
>            putname()              /* update 3 (decrement) */
> 
> The io_uring worker thread performs one increment and two decrements.
> These updates can race with the system call decrement.
> 
> io_wqe_worker()
>   io_worker_handle_work()
>     io_wq_submit_work()
>       io_issue_sqe()
>         io_openat()
>           io_openat2()
>             do_filp_open()
>               path_openat()
>                 __audit_inode()   /* update 4 (increment) */
>             putname()             /* update 5 (decrement) */
>         __audit_uring_exit()
>           audit_reset_context()
>             putname()             /* update 6 (decrement) */
> 
> The fix is to change the refcnt member of struct audit_names
> from int to atomic_t.
> 
> kernel BUG at fs/namei.c:262!
> Call Trace:
> ...
>  ? putname+0x68/0x70
>  audit_reset_context.part.0.constprop.0+0xe1/0x300
>  __audit_uring_exit+0xda/0x1c0
>  io_issue_sqe+0x1f3/0x450
>  ? lock_timer_base+0x3b/0xd0
>  io_wq_submit_work+0x8d/0x2b0
>  ? __try_to_del_timer_sync+0x67/0xa0
>  io_worker_handle_work+0x17c/0x2b0
>  io_wqe_worker+0x10a/0x350
> 
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/lkml/MW2PR2101MB1033FFF044A258F84AEAA584F1C9A@MW2PR2101MB1033.namprd21.prod.outlook.com/
> Fixes: 5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit support to io_uring")
> Signed-off-by: Dan Clash <daclash@linux.microsoft.com>

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


