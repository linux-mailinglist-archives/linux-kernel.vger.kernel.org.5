Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01C27CA63E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjJPLFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjJPLFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:05:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A7AB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:05:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so1015257f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697454340; x=1698059140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Syi+h4/GlkdC/FXeBhfgw8IzyShvR4nN+L5IxDsfCY=;
        b=UivXsDRDu+ORh5PR8x39RRQ+rItPpN9AwqnGdHJUz33bT0RQ0T4ZCSWDWnpDlyIKwb
         CslmEkTkMNwq8HxQoyZNzY4m7xj02VH9r7Szi0L3uiKMZdE86t/2+wfG1G/lDWqgzUfh
         iAYdVrAqRRvbtUwQFnRt5xJKD64c7GVZRvNIuJ1oA6tiMMf+oKnplNWQryEi21Yw6TBG
         okFw2raOJTeA1lHDWK0lG+GqUEqqhhuTp6XJTA0l5G034RehAIhL4jm4nb+IgWSl+QKz
         NHTd73Dt5hkgV8lBTwEdK5evSlpESJbZ6WsQCzF407ix4KwCAQMwVSe5zfmarR2LTj3E
         1sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697454340; x=1698059140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Syi+h4/GlkdC/FXeBhfgw8IzyShvR4nN+L5IxDsfCY=;
        b=JJogYGlPwjxeqZsmivVvSJxdaUIIG2+/XJ1JLeizJLqTAbXHcrfg3xv0PwmWjG/W9D
         57cHvZ4Cui1ZUidEXHpSs058WHX3EY4ZEWd/Izuyh1kWs4I7ubvcSF6ESciIPrU+HC9M
         G5nnSc05TxSxvk+KY6CkQxzwOM4MQsG4U4CYMDmLHRxS6ZZQcglwOJt110ewP1S7Wy+m
         BDiJx47uLGzTV1lwIdJcL9iVuOLzNF4ANy2kwA25FFdeqJjJ5pG+ZLyAO1LdPshNX66i
         DnxBjvYdbMNG4gjTPRLRBAvxki1qJZEoDBofAY+vqyPTDUlA39jDKiUv3KBOAOuh2G+M
         BJ8Q==
X-Gm-Message-State: AOJu0Yy2Iw3Kk4om7H8I68RkrcN5tPepGfvJ4B3Z9ogn5whz5hCrTYLg
        /ZvH8uNj+V6S8gvlRs/SKjg=
X-Google-Smtp-Source: AGHT+IHcWQxGKBWB6Ru+kU1QqtsJt1pKDdeOgjo/JB9S2wBXG17gJDZ7JSgMTrjK4LS91xjoJXU6Uw==
X-Received: by 2002:a05:6000:24c:b0:32d:be70:3779 with SMTP id m12-20020a056000024c00b0032dbe703779mr205799wrz.9.1697454339449;
        Mon, 16 Oct 2023 04:05:39 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c431200b0040642a1df1csm6801770wme.25.2023.10.16.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:05:38 -0700 (PDT)
Date:   Mon, 16 Oct 2023 12:05:37 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        "Reviewed-by: Jan Kara" <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>, willy@infradead.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: mm: Unable to handle kernel NULL pointer dereference at virtual
 address - mmap_region (include/linux/fs.h:580 mm/mmap.c:2946)
Message-ID: <48534660-d5f7-45b2-8f99-19c8fb3e51c8@lucifer.local>
References: <CA+G9fYtL7wK-dE-Tnz4t-GWmQb50EPYa=TWGjpgYU2Z=oeAO_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtL7wK-dE-Tnz4t-GWmQb50EPYa=TWGjpgYU2Z=oeAO_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 03:52:07PM +0530, Naresh Kamboju wrote:
> Following kernel crash noticed while running LTP hugetlb and selftests on
> qemu-x86_64 and qemu-arm64 running with Linux next 6.6.0-rc6-next-20231016.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> Test Logs:
> -----

[snip]

> <4>[   97.499871] Call trace:
> <4>[ 97.500288] mmap_region (include/linux/fs.h:580 mm/mmap.c:2946)

OK this is from a patch of mine, and an easy fix (incorrect assumption about
vm->vm_file == file).

I will put a fix forward tonight.

> <4>[ 97.500814] do_mmap (mm/mmap.c:1379)
> <4>[ 97.501243] vm_mmap_pgoff (mm/util.c:546)
> <4>[ 97.501711] ksys_mmap_pgoff (mm/mmap.c:1425)
> <4>[ 97.502166] __arm64_sys_mmap (arch/arm64/kernel/sys.c:21)
> <4>[ 97.502634] invoke_syscall (arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/syscall.c:56)
> <4>[ 97.503175] el0_svc_common.constprop.0
> (include/linux/thread_info.h:127 (discriminator 2)
> arch/arm64/kernel/syscall.c:144 (discriminator 2))
> <4>[ 97.503763] do_el0_svc (arch/arm64/kernel/syscall.c:156)
> <4>[ 97.504191] el0_svc (arch/arm64/include/asm/daifflags.h:28
> arch/arm64/kernel/entry-common.c:133
> arch/arm64/kernel/entry-common.c:144
> arch/arm64/kernel/entry-common.c:679)

[snip]
