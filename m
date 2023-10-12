Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC09E7C6729
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377775AbjJLH0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjJLH03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:26:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284ECB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:26:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50348c54439so2199e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697095585; x=1697700385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iXDbEM0tnlYCwwxypnUP6o9vn/vxZxK+NHpfGQwV3N0=;
        b=dOGI8/BkzLwuAelqJaoceeQr2ugjCU2HtJ27Bt18Sh7k3wN9R/SBCLSiFReA96f4ux
         F1INI3Ft12RjX+qLE9xUl/t6XBUzyI9uQcNDi60vbn3AVVwYmhjLy0tn99RDDeoB2ZVC
         hDWTiIEhzTw9sWZiukQsC3CIbBbKLxvkKVJ1F3/UU3zOmHXdOf+hGRdnfQvnLmkj6sXz
         929jKJTAK19TJB23OR1uxCUHcCwMjiM0NaqbJOY666MWsKEQQBmFQ6Hbuk2G9apFcNjQ
         icI/8ksqaL7JOmtCve3bshhwPs+QTiEgRPjW+X6PtUfKgZegbIT67RU8Vqfo2nVgE6pu
         6wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697095585; x=1697700385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXDbEM0tnlYCwwxypnUP6o9vn/vxZxK+NHpfGQwV3N0=;
        b=MlnM06lHAITVavWbDC/q4bExasQoFluIY+qGt5HqHEVZikW074CSk12sLeEcE/OT49
         oPhYYeF0+vfACrK/91lBZUE4PhZa8dF6MO0roYfO6LVQxLqTmJ3wzsaSLm09ZmJ2rzaa
         JJKZZc5Fucqu/3Xzqg24BScp31Bd9Dflao+MsJoXRtE+hvbDwEPUkKiHuhQOW0nfu2fw
         3uFQVb3YtWy373pfQsXf3k1E+LZQFEmamD5D6oJbreLY+hWbdfbJluRuRAfCbznVmLPP
         p6YjFZvcrifurdlfT9qItPmTYVvALc0u5f+zpP58uvNEgiz3zbqwcUTEJg7scz4eGNaa
         mDKg==
X-Gm-Message-State: AOJu0Yw4W56h8fVssTPCXhH5Rzewv+6DaysdK1ShAx5dqDG4pzq1MhQx
        9NzrzCg6EKmV7v2jfJH1VkZMK2+DN59Ja3K+F071ag==
X-Google-Smtp-Source: AGHT+IHeCkssxKHsyTMo2wZSeJFL0UijlpR2d2mdeO1q0hG5qpGCYfClgxKR6H7mMryKBlDVXLC6EQ9eJbNipeKNYOo=
X-Received: by 2002:ac2:4f8e:0:b0:505:6e12:9e70 with SMTP id
 z14-20020ac24f8e000000b005056e129e70mr179405lfs.6.1697095585144; Thu, 12 Oct
 2023 00:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230831115730.4806-1-hdanton@sina.com> <20231011211846.1345-1-hdanton@sina.com>
In-Reply-To: <20231011211846.1345-1-hdanton@sina.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 Oct 2023 09:26:12 +0200
Message-ID: <CACT4Y+b1UZGxj=pp4m4g=9P0DoQ4Rs6H3eVMZvGc=CYMj_rZ-w@mail.gmail.com>
Subject: Re: some works in 2023
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 23:19, Hillf Danton <hdanton@sina.com> wrote:
>
> In 2023 alone (continued 2)
>
> 101 Subject: Re: [syzbot] [kernel?] general protection fault in netdev_register_kobject
> https://yhbt.net/lore/lkml/000000000000bc839e060436421f@google.com/
> 102 Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in pwq_release_workfn
> https://yhbt.net/lore/lkml/000000000000a178f50604369403@google.com/
> 103 Subject: Re: [syzbot] [net?] [wireless?] INFO: rcu detected stall in request_firmware_work_func
> https://lore.kernel.org/lkml/0000000000001d0fac060436e0b4@google.com/

Hi Hillf,

I've tried to open first 3 and for all of them lore says:

     [not found] <20230831110322.4608-1-hdanton@sina.com>

So it is not possible to see your emails. Somehow it happens only with
your emails b/c on the second one there are emails from other people
that are shown normally.
Perhaps there is something wrong with your email setup?


> 104 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __sco_sock_close
> https://lore.kernel.org/lkml/0000000000002e6fcd0604566075@google.com/
> 105 Subject: Re: [syzbot] [kernel?] general protection fault in tty_register_device_attr
> https://lore.kernel.org/lkml/000000000000a1ef37060459de79@google.com/
> 106 Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in dev_uevent
> https://lore.kernel.org/lkml/000000000000be767106045cc22d@google.com/
> 107 Subject: Re: [syzbot] [afs?] KASAN: slab-use-after-free Read in afs_dynroot_test_super
> https://lore.kernel.org/lkml/00000000000079a09a0604692e94@google.com/
> 108 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_conn_del
> https://lore.kernel.org/lkml/0000000000000598e50604b668a1@google.com/
> 109 Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
> https://lore.kernel.org/lkml/0000000000004554cd0604e5bcc5@google.com/
> 110 Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in team_device_event
> https://lore.kernel.org/lkml/0000000000000c7f5d0604f924b5@google.com/
>
>
> 111 Subject: Re: [syzbot] [bluetooth?] general protection fault in lock_sock_nested
> https://lore.kernel.org/lkml/0000000000004af49b06051546ab@google.com/
> 112 Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
> https://lore.kernel.org/lkml/000000000000e6665c0605ff20f6@google.com/
> 113 Subject: Re: [syzbot] [netfilter?] INFO: rcu detected stall in gc_worker (3)
> https://lore.kernel.org/lkml/00000000000076fc0706062e0619@google.com/
> 114 Subject: Re: [syzbot] [bluetooth?] possible deadlock in hci_dev_do_close
> https://lore.kernel.org/lkml/000000000000a559aa06062dc990@google.com/
> 115 Subject: Re: [syzbot] [serial?] KASAN: use-after-free Read in gsm_cleanup_mux
> https://lore.kernel.org/lkml/0000000000005c26700606418357@google.com/
> 116 Subject: Re: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in pvr2_context_set_notify
> https://lore.kernel.org/lkml/0000000000001bacdb060669b7d8@google.com/
> 117 Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in tls_encrypt_done
> https://lore.kernel.org/lkml/00000000000015a94a06068f132c@google.com/
> 118 Subject: Re: [syzbot] [mm?] WARNING in copy_hugetlb_page_range
> https://lore.kernel.org/lkml/0000000000003ee4a70606d9d0c1@google.com/
> 119 Subject: Re: [syzbot] [net?] [usb?] INFO: rcu detected stall in worker_thread (9)
> https://lore.kernel.org/lkml/0000000000006cdc4c060732e606@google.com/
> 120 Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in clock_adjtime (2)
> https://lore.kernel.org/lkml/000000000000a8ec770607334a74@google.com/
>
>
> 121 Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
> https://lore.kernel.org/lkml/000000000000e45bec06075b4cc8@google.com/
> 122 Subject: Re: [syzbot] [reiserfs?] possible deadlock in filename_create
> https://lore.kernel.org/lkml/00000000000090cd01060770a5e2@google.com/
