Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC337CB03A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjJPQm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbjJPQmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:42:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72FC4685
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:32:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32d834ec222so4492527f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697473922; x=1698078722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNCrnVPjlQ/OAERQDWaDWTtn8p4RIvUa6qZfUdX9yJU=;
        b=LY1855fMMGfMp//uzi/XeTxO9M0ZSs3o60YnAtWn8AYj7wXi6IWGBr1VtfnY4bqH3n
         TXD2ioj89UtQvyp5zfLrdGDegbSy7O5w56Bcexy7eR9/qlPXlKEdwf0nzMbeYG2//Y8e
         Oc2fZ/SInxxfLqKPxc9dS7RIlb9mxF5/k0gz3RD283z8xz/QJ44hU74RqZITN/POzmYj
         ehFhxrGde4+/XFvcb289KEGefpQOHsgHf7z1pkUnDQTDCgThMIMKfkQunh6IwnQ2xrvU
         h0+aX2QdNXOi8LJffj/unuiRuOAiFwsG8FxEdAaGr2ipDaCvp3I+llYW50UsqUHDR6d8
         tUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697473922; x=1698078722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNCrnVPjlQ/OAERQDWaDWTtn8p4RIvUa6qZfUdX9yJU=;
        b=eGD6yRTv2Igkxd82IBJjJ1YPiSnw2DyseDFi0JQSl2XheLvVA4tXonyNuNJM6BwTJF
         S+zhDPYc/1ZgnkdTvzIEA7hguL+i70KKEYsPs6NG11L34trpdC3EgF1C/dG+wWWueMPv
         ytsUd7A5L7t0EVSIznlfs6UBrkeyaxnffd8ZF3aw6bzA5M2T6OWcBJiP8Bg2Zv4iQuGn
         g3PhDyHFGMC8oXJy928/TtywrXBV0OKUScMYkU9oxdkbM+yI6fQ5FgN8eIqW/xCN20q+
         Z9Wm9mhewP1FRoFv4PJMkgakeZpZ24wtA2qnqZD3b96ei297FHVC/OL+PblTyC6WGdU5
         u6OQ==
X-Gm-Message-State: AOJu0YxbMkov0GtymIW/q18asQOEtBiVq1KVXpE6FaiWPiDzVhT2oWDg
        bVk8D6p96fMPfmSFMmuWpik=
X-Google-Smtp-Source: AGHT+IGW5RqgVaaDPN+L91IQW20noQdJbJlMuZeyBkPgOxf0so3sGl9SKJ1iLW5zRyilZYMEV4ZbSw==
X-Received: by 2002:a05:6000:613:b0:329:6d09:61ff with SMTP id bn19-20020a056000061300b003296d0961ffmr30513002wrb.62.1697473922488;
        Mon, 16 Oct 2023 09:32:02 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0031ad2f9269dsm27451978wro.40.2023.10.16.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:32:01 -0700 (PDT)
Date:   Mon, 16 Oct 2023 17:32:00 +0100
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
Message-ID: <49bf8caa-e72e-406f-88d6-6d28aded078a@lucifer.local>
References: <CA+G9fYtL7wK-dE-Tnz4t-GWmQb50EPYa=TWGjpgYU2Z=oeAO_w@mail.gmail.com>
 <48534660-d5f7-45b2-8f99-19c8fb3e51c8@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48534660-d5f7-45b2-8f99-19c8fb3e51c8@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 12:05:37PM +0100, Lorenzo Stoakes wrote:
> On Mon, Oct 16, 2023 at 03:52:07PM +0530, Naresh Kamboju wrote:
> > Following kernel crash noticed while running LTP hugetlb and selftests on
> > qemu-x86_64 and qemu-arm64 running with Linux next 6.6.0-rc6-next-20231016.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >
> > Test Logs:
> > -----
>
> [snip]
>
> > <4>[   97.499871] Call trace:
> > <4>[ 97.500288] mmap_region (include/linux/fs.h:580 mm/mmap.c:2946)
>
> OK this is from a patch of mine, and an easy fix (incorrect assumption about
> vm->vm_file == file).
>
> I will put a fix forward tonight.
>
> > <4>[ 97.500814] do_mmap (mm/mmap.c:1379)
> > <4>[ 97.501243] vm_mmap_pgoff (mm/util.c:546)
> > <4>[ 97.501711] ksys_mmap_pgoff (mm/mmap.c:1425)
> > <4>[ 97.502166] __arm64_sys_mmap (arch/arm64/kernel/sys.c:21)
> > <4>[ 97.502634] invoke_syscall (arch/arm64/include/asm/current.h:19
> > arch/arm64/kernel/syscall.c:56)
> > <4>[ 97.503175] el0_svc_common.constprop.0
> > (include/linux/thread_info.h:127 (discriminator 2)
> > arch/arm64/kernel/syscall.c:144 (discriminator 2))
> > <4>[ 97.503763] do_el0_svc (arch/arm64/kernel/syscall.c:156)
> > <4>[ 97.504191] el0_svc (arch/arm64/include/asm/daifflags.h:28
> > arch/arm64/kernel/entry-common.c:133
> > arch/arm64/kernel/entry-common.c:144
> > arch/arm64/kernel/entry-common.c:679)
>
> [snip]

Have cc-d people in this thread on it, but for the record, -fix patch is at
https://lore.kernel.org/all/c9eb4cc6-7db4-4c2b-838d-43a0b319a4f0@lucifer.local/
