Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772157D3606
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjJWMCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjJWMCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:02:45 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B622F5;
        Mon, 23 Oct 2023 05:02:41 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1eb7a8e9dd0so288139fac.3;
        Mon, 23 Oct 2023 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698062560; x=1698667360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiFbfs7BErHq09w7bwsMK4yHlj0qVMvyV1tXDfbJ0tE=;
        b=CZJUr1ZZ3PgE6x1krwIwnebRqLJ3StwLuXrWx7lER+iyN16dG97aTxHJUktkmwA6ZV
         SVygE4aQ/0rLIU/6Ce5Y/JaDSoVQHV1WGACT/ODcxASToQxnU5ViOmzRuVZvy+nkvq9L
         EXvdHmHtwjzWiMBN9MWDBICSG3qJsZxy08CKcCQQCtyfnymNKveWYkX5mn99vFJOQBND
         SNrgMcbgM6J0VAh6dQnwLLOH1vRXE27Je28q/yyvW1rfjJ4XoHDaq1kx2n6hofdP7XWi
         nl3WH2M42Z0OtUl4bMPveoyNZMdx2nFCMj7LiIEjbKgsin4JOXwzjF+uyEL1cK2cy7JM
         6qEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698062560; x=1698667360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiFbfs7BErHq09w7bwsMK4yHlj0qVMvyV1tXDfbJ0tE=;
        b=jWiMd1/5QZLLY8MdfnEIssyqV7nkva5Iaby7EojHu+wJjdXEISPjlSO2G0jgB0OpSu
         XOG1tCfLyWWxVygRHTeumppYo7qMXRcPae1gCuRDNUO1nA6ssQu4L3rGTus1ADHL7zRp
         kldIRG18H/cHhUYy2cCWntHVYr0eITeX3MZEulI0K+gPHfhXoiPYIA3sfjTKF51FttTs
         XzNj+0p9KY5+2+VpvV7D3R8PIbEgXiQ3ZL/Gtx5cbZnGYvEQ8FX+HSt50pJP7GVwJfYS
         u0RbtQBJM5XOExCsME1FNm7mYtuQHggy2Y2ez7qMWOoEs3HzXXhyUytIDCOCt0Yik7C5
         M4+w==
X-Gm-Message-State: AOJu0YyMNm/i7y6V7m0rNsazP0K7lTLD//mujHxXk1TCzV3sxqCVCwWf
        w/0+o0D4s+Zsvn7rzLa1Bztb0n2Qdj4tWt6Fh04=
X-Google-Smtp-Source: AGHT+IFDOjlPFNxZH+TNCPyOYk/jnYswfxhuW97975JVJB/tFTnE1b6fAO88ZlsiSm8o9UQpuYj3Gyb4/cbuXv7G1A8=
X-Received: by 2002:a05:6870:3e09:b0:1e9:beae:947d with SMTP id
 lk9-20020a0568703e0900b001e9beae947dmr12410358oab.19.1698062558907; Mon, 23
 Oct 2023 05:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698051454.git.houwenlong.hwl@antgroup.com> <90df6cf5674241a85ac7dfe0a1558f1fd025cc17.1698051454.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <90df6cf5674241a85ac7dfe0a1558f1fd025cc17.1698051454.git.houwenlong.hwl@antgroup.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Oct 2023 15:02:02 +0300
Message-ID: <CAHp75VeXiOprRDNakewo2iSe==EeLUxfxuPYS3R+ZsY2KDmQBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/xen/pvh: Set up percpu for stack canary in 32-bit
 kernel entry
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "moderated list:XEN HYPERVISOR X86" <xen-devel@lists.xenproject.org>,
        "open list:X86 PLATFORM DRIVERS - ARCH" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 12:10=E2=80=AFPM Hou Wenlong
<houwenlong.hwl@antgroup.com> wrote:
>
> In a 32-bit SMP kernel, the stack canary is a percpu variable accessed
> as %fs:__stack_chk_guard. However, the ABI for PVH entry does not
> specify the %fs register state. It currently works because the initial
> %fs register is 0x10 for QEMU, which is the same as $PVH_DS_SEL.

> %However, for added safety, the percpu should be set up explicitly
> %before calling xen_prepare_pvh(), which accesses the stack canary.

Stray leading % in two lines above.

--=20
With Best Regards,
Andy Shevchenko
