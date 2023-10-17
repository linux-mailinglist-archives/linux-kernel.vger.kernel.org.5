Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46957CC5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbjJQOPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344037AbjJQOPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:15:30 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4FCF5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:15:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso71901181fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697552127; x=1698156927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lj+rrdViRJjUfQuPmcCus9x1Xjw7sD9CZl2Q7GMS/eI=;
        b=xuUpzZ/Ob0jr9v6Zt/uC96iRMfllqQHP/OFZtZmQLObkOEpF3NO8JRIfA6lmjOxWOa
         an8rGewcAtilUBHOdMF7J+VIW2ZpVSFjD22yq2h9HaOY1H/kdvMAfanQSP6wr4Yse674
         cIdRvFJTCTCNgrFcmzvhIzDH//3mucV9H6Mf6RejS0Mg0b5orCCZIF+YgwjpRn/DDwny
         Ji/LnQQeBdHUoZfLA4cRbaOvCqkN2GJlmdVJ16/b+94bzXy2kT04BykQnozR7XSAZHEx
         IHzFigL+ic/TMlBYfsJZFG2IgotTIJDf9ADckHyECriT+T5qepdlZypTStDfQYS7s3LF
         3TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697552127; x=1698156927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj+rrdViRJjUfQuPmcCus9x1Xjw7sD9CZl2Q7GMS/eI=;
        b=b18/mAvMt8k7DwrdEf/aUY/KwZQMMLWhRmXmkzCVtYYgdN3qcGLs3TlkYVAJmr6Jjs
         zX+38miG53R3nXfJ30Qn8xa6QUVNBdZLiIRhHZ9o0HhOS/hYFGAUXreAreofIM7GGgz2
         7MjXzIBfsx15IoJuiKz2kIFKZMcEjgV5W9g4CPzD3lv3BbbC7bj92bE+5DfaORp5+OCQ
         Xk2sSKh3PfXnCGJYeG+BAdO3UrQBcYIWtC3Mf5hAaPfHmlrNb6ePvGnSdEnTJVfWRUKd
         S0LYmoFaxeVm16cyXytDa8iRv2THrHw95xdqG998smJqK30RyTFxgp2a6y5ekicQ7Hrc
         fWSw==
X-Gm-Message-State: AOJu0Yw94ooatDMbLVuSRjRkbLDCeer3bzNKAcHQJWbBFi2gVhOLP12W
        nA1c1JHSNTd63/R7j+N7kK4D3A==
X-Google-Smtp-Source: AGHT+IG/Qb1WyUSRcFMsKcYP3r/QECH5ek8lUiosc3//YaTTJ96KN/DrbAJfDnOLJb/QQW2gvAMJhQ==
X-Received: by 2002:a05:651c:145:b0:2c5:2191:3f35 with SMTP id c5-20020a05651c014500b002c521913f35mr1879222ljd.2.1697552127096;
        Tue, 17 Oct 2023 07:15:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b004060f0a0fd5sm1663409wmq.13.2023.10.17.07.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:15:26 -0700 (PDT)
Date:   Tue, 17 Oct 2023 17:15:23 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        "Reviewed-by: Jan Kara" <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>, willy@infradead.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: mm: Unable to handle kernel NULL pointer dereference at virtual
 address - mmap_region (include/linux/fs.h:580 mm/mmap.c:2946)
Message-ID: <3d007161-f0d8-43cf-a0c4-5d62cd38da07@kadam.mountain>
References: <CA+G9fYtL7wK-dE-Tnz4t-GWmQb50EPYa=TWGjpgYU2Z=oeAO_w@mail.gmail.com>
 <48534660-d5f7-45b2-8f99-19c8fb3e51c8@lucifer.local>
 <49bf8caa-e72e-406f-88d6-6d28aded078a@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bf8caa-e72e-406f-88d6-6d28aded078a@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 05:32:00PM +0100, Lorenzo Stoakes wrote:
> On Mon, Oct 16, 2023 at 12:05:37PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Oct 16, 2023 at 03:52:07PM +0530, Naresh Kamboju wrote:
> > > Following kernel crash noticed while running LTP hugetlb and selftests on
> > > qemu-x86_64 and qemu-arm64 running with Linux next 6.6.0-rc6-next-20231016.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > >
> > > Test Logs:
> > > -----
> >
> > [snip]
> >
> > > <4>[   97.499871] Call trace:
> > > <4>[ 97.500288] mmap_region (include/linux/fs.h:580 mm/mmap.c:2946)
> >
> > OK this is from a patch of mine, and an easy fix (incorrect assumption about
> > vm->vm_file == file).
> >
> > I will put a fix forward tonight.
> >
> > > <4>[ 97.500814] do_mmap (mm/mmap.c:1379)
> > > <4>[ 97.501243] vm_mmap_pgoff (mm/util.c:546)
> > > <4>[ 97.501711] ksys_mmap_pgoff (mm/mmap.c:1425)
> > > <4>[ 97.502166] __arm64_sys_mmap (arch/arm64/kernel/sys.c:21)
> > > <4>[ 97.502634] invoke_syscall (arch/arm64/include/asm/current.h:19
> > > arch/arm64/kernel/syscall.c:56)
> > > <4>[ 97.503175] el0_svc_common.constprop.0
> > > (include/linux/thread_info.h:127 (discriminator 2)
> > > arch/arm64/kernel/syscall.c:144 (discriminator 2))
> > > <4>[ 97.503763] do_el0_svc (arch/arm64/kernel/syscall.c:156)
> > > <4>[ 97.504191] el0_svc (arch/arm64/include/asm/daifflags.h:28
> > > arch/arm64/kernel/entry-common.c:133
> > > arch/arm64/kernel/entry-common.c:144
> > > arch/arm64/kernel/entry-common.c:679)
> >
> > [snip]
> 
> Have cc-d people in this thread on it, but for the record, -fix patch is at
> https://lore.kernel.org/all/c9eb4cc6-7db4-4c2b-838d-43a0b319a4f0@lucifer.local/

Smatch also caught this bug.  Your patch silences the warning.

mm/mmap.c:2946 mmap_region() error: we previously assumed 'file' could be null (see line 2849)

It's amazing that Naresh was able to hit this after it had only been in
linux-next for less than a day.

regards,
dan carpenter
