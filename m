Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BA67F0F81
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjKTJzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjKTJza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:55:30 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C9294
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:55:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so12810a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700474125; x=1701078925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXik9sN9oPjNlP35QH0IkVw44/XuwaU3LqfwT7DUr34=;
        b=fvcayZqgDMrtjvbZojBvPRjYTlimdzYA/+lyywdlW97prQ+E7mgY8mds8FapeY7rvH
         HXJ1kRoUMOAuKlVMIJuKRftPQsTHQvluZK0WSvNXRX119Z45LbLX93uZg8qnslrU0ZNW
         ZrnrWTlkinBk8nEKa/nJHFu6G0jGaq+r9PbIZpEXjQp/zcQxS/aEZvyExjWiLvrPK6D2
         m9fehIQy0AwuCuu4KoCpvCUQal30jsIZuR+3Ij4EuiPn7YRPSniELB+VjNVx9yzV0o9e
         nCS3WiAvPnRPNro8PSjfKaliarEmFaCWJKBlNHU9S+2ytAq2sgtsKf9AX4tiSugL+5kb
         H/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474125; x=1701078925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXik9sN9oPjNlP35QH0IkVw44/XuwaU3LqfwT7DUr34=;
        b=D4zUuolMEgBdM19e6QAk0o4KsZxn73bJP23xGOylfR0pGD4ZgEPEAkbvUS40A3tSHq
         3d0TP3g1OwCn3ibLFt+jUxjPJEgoY0AILPrm82OKX5zm2qdHUPH4phFmpixYqt8jLntO
         it4aKnag8X6vzQ2+IJg+taqwJSHNhF+RIFu2NPOvp8S+YmcXLUTsQ2tLz7F7x5SLRBmf
         IPB5VpWYKKSlhRn1vzsyANRq8uHBX98VSrZ2EfWs+TpNt2CApzoqdqoD8Y7H/xvaWOC7
         KoZL3bw/e83bJVohteU03h6gQTO25mC7pyBZEtzXXjZYH67BjU18rIL63JXzuk5gYdmt
         DbQg==
X-Gm-Message-State: AOJu0Yy3HD5wBITLinuqEMHLsBlGdURGyprk9pE0uVNxj+mqATE+YaTP
        hcBGWKm6VS074SeGx2xeR2N/UWUpFVkGtDV0wCvYtg==
X-Google-Smtp-Source: AGHT+IGLyeTL8N3vqZ8p9XQyWBXZE+2KdHScmeVKG54pz248PW0AjCj5rhv3SFu+vAEP8EtsQHEajXYbYCANVG4nOKA=
X-Received: by 2002:a05:6402:c41:b0:544:e249:be8f with SMTP id
 cs1-20020a0564020c4100b00544e249be8fmr218730edb.1.1700474125026; Mon, 20 Nov
 2023 01:55:25 -0800 (PST)
MIME-Version: 1.0
References: <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
 <20231119092530.13071-2-haifeng.xu@shopee.com>
In-Reply-To: <20231119092530.13071-2-haifeng.xu@shopee.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 20 Nov 2023 10:55:11 +0100
Message-ID: <CANn89iJGZOg3ozTi+HLEd_WqVUiVHVXhD5_w8Dj8=4df2zxymw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] bonding: use a read-write lock in bonding_show_bonds()
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 10:25=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.com>=
 wrote:
>
> Problem description:
>
> Call stack:
> ......
> PID: 210933  TASK: ffff92424e5ec080  CPU: 13  COMMAND: "kworker/u96:2"
> [ffffa7a8e96bbac0] __schedule at ffffffffb0719898
> [ffffa7a8e96bbb48] schedule at ffffffffb0719e9e
> [ffffa7a8e96bbb68] rwsem_down_write_slowpath at ffffffffafb3167a
> [ffffa7a8e96bbc00] down_write at ffffffffb071bfc1
> [ffffa7a8e96bbc18] kernfs_remove_by_name_ns at ffffffffafe3593e
> [ffffa7a8e96bbc48] sysfs_unmerge_group at ffffffffafe38922
> [ffffa7a8e96bbc68] dpm_sysfs_remove at ffffffffb021c96a
> [ffffa7a8e96bbc80] device_del at ffffffffb0209af8
> [ffffa7a8e96bbcd0] netdev_unregister_kobject at ffffffffb04a6b0e
> [ffffa7a8e96bbcf8] unregister_netdevice_many at ffffffffb046d3d9
> [ffffa7a8e96bbd60] default_device_exit_batch at ffffffffb046d8d1
> [ffffa7a8e96bbdd0] ops_exit_list at ffffffffb045e21d
> [ffffa7a8e96bbe00] cleanup_net at ffffffffb045ea46
> [ffffa7a8e96bbe60] process_one_work at ffffffffafad94bb
> [ffffa7a8e96bbeb0] worker_thread at ffffffffafad96ad
> [ffffa7a8e96bbf10] kthread at ffffffffafae132a
> [ffffa7a8e96bbf50] ret_from_fork at ffffffffafa04b92
>
> 290858 PID: 278176  TASK: ffff925deb39a040  CPU: 32  COMMAND: "node-expor=
ter"
> [ffffa7a8d14dbb80] __schedule at ffffffffb0719898
> [ffffa7a8d14dbc08] schedule at ffffffffb0719e9e
> [ffffa7a8d14dbc28] schedule_preempt_disabled at ffffffffb071a24e
> [ffffa7a8d14dbc38] __mutex_lock at ffffffffb071af28
> [ffffa7a8d14dbcb8] __mutex_lock_slowpath at ffffffffb071b1a3
> [ffffa7a8d14dbcc8] mutex_lock at ffffffffb071b1e2
> [ffffa7a8d14dbce0] rtnl_lock at ffffffffb047f4b5
> [ffffa7a8d14dbcf0] bonding_show_bonds at ffffffffc079b1a1 [bonding]
> [ffffa7a8d14dbd20] class_attr_show at ffffffffb02117ce
> [ffffa7a8d14dbd30] sysfs_kf_seq_show at ffffffffafe37ba1
> [ffffa7a8d14dbd50] kernfs_seq_show at ffffffffafe35c07
> [ffffa7a8d14dbd60] seq_read_iter at ffffffffafd9fce0
> [ffffa7a8d14dbdc0] kernfs_fop_read_iter at ffffffffafe36a10
> [ffffa7a8d14dbe00] new_sync_read at ffffffffafd6de23
> [ffffa7a8d14dbe90] vfs_read at ffffffffafd6e64e
> [ffffa7a8d14dbed0] ksys_read at ffffffffafd70977
> [ffffa7a8d14dbf10] __x64_sys_read at ffffffffafd70a0a
> [ffffa7a8d14dbf20] do_syscall_64 at ffffffffb070bf1c
> [ffffa7a8d14dbf50] entry_SYSCALL_64_after_hwframe at ffffffffb080007c
> ......
>
> Thread 210933 holds the rtnl_mutex and tries to acquire the kernfs_rwsem,
> but there are many readers which hold the kernfs_rwsem, so it has to slee=
p
> for a long time to wait the readers release the lock. Thread 278176 and a=
ny
> other threads which call bonding_show_bonds() also need to wait because
> they try to acquire the rtnl_mutex.
>
> bonding_show_bonds() uses rtnl_mutex to protect the bond_list traversal.
> However, the addition and deletion of bond_list are only performed in
> bond_init()/bond_uninit(), so we can introduce a separate read-write lock
> to synchronize bond list mutation. In addition, bonding_show_bonds() coul=
d
> race with dev_change_name(), so we need devnet_rename_sem to protect the
> access to dev->name.
>
> What are the benefits of this change?
>
> 1) All threads which call bonding_show_bonds() only wait when the
> registration or unregistration of bond device happens or the name
> of net device changes.
>
> 2) There are many other users of rtnl_mutex, so bonding_show_bonds()
> won't compete with them.
>
> In a word, this change reduces the lock contention of rtnl_mutex.
>
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
