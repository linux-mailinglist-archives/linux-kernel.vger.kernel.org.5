Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D447CCAE0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjJQSin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:38:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0948F90
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:38:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9936b3d0286so975555766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697567918; x=1698172718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=USkbb5/cH3vJp4KF5jTF8rcY5cuD/NJi1SRBLDhJQGQ=;
        b=XeDIyL0v2sQK+8XbKrxDFLSfMGJJnHMJJg1PwK6sskm4FojjZpACM04QPqa2N8myiu
         hxtdA59/DJln9laekdfnOyUXDpM0CKG8V3/DJhPE8e17uYpDHhWfM+e9Ja2dKxW4lphD
         G+psKBha4SxF5GAtN4xhVoTP3xjMApQK44KHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697567918; x=1698172718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USkbb5/cH3vJp4KF5jTF8rcY5cuD/NJi1SRBLDhJQGQ=;
        b=iSbcAMcbMRwvY2yyU/FmTKmyIukeThiIIRX0NL9t7jGVZTNYrJWjk2Ivurt4mlbe5u
         CPKxgsy3Wfod4ZQN7mTvC4CjDC+xwZffZr3VU+pIsen5C2vrCKkE4OTPsn0AyhjnHPIb
         F/HPiaAJsmFxOzeBWHYxSR4yiZIkgFbjTmLXvYbagM+D4KLenuu38yS/zi7XxIT/EJ/5
         KVsuoyzmvMJPuQRxQYLsPtTJrGfjLs1nbeSsRQwxwo57zL6eIVCPmZVDKJrMzuxXPGbx
         M8yLWGm0R7+Mjhwz2tE5OGJ4PvUjqJNCLZjrnIVUw5HTZucpRRdW7oHcK4Q4kenu7VBj
         CDNw==
X-Gm-Message-State: AOJu0YwuW7Bq6vZtKq+a7Ddo1ezZBDLGwL9e6OSMg/gPhfuT/PUiZ9Yz
        Z5WSs8Tr2AY2q/pLNr3pXPnU8jeKf6Ize/J7WjK+bQvy
X-Google-Smtp-Source: AGHT+IE5Wet80iYWFw4UESwfB7wfvm7zaHSoJfgVh68rM4p7cVqP/haClGcz+3OTfHjyyEp3TnOm8g==
X-Received: by 2002:a17:906:fe05:b0:99c:b0c9:4ec0 with SMTP id wy5-20020a170906fe0500b0099cb0c94ec0mr2620483ejb.30.1697567918261;
        Tue, 17 Oct 2023 11:38:38 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id o10-20020a170906600a00b00992b510089asm250429ejj.84.2023.10.17.11.38.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 11:38:37 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99de884ad25so972494666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:38:37 -0700 (PDT)
X-Received: by 2002:a17:906:4fc7:b0:9b2:b149:b81a with SMTP id
 i7-20020a1709064fc700b009b2b149b81amr2302073ejw.64.1697567917353; Tue, 17 Oct
 2023 11:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
 <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
 <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com> <55960.1697566804@cvs.openbsd.org>
In-Reply-To: <55960.1697566804@cvs.openbsd.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Oct 2023 11:38:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjS=xg12RVQdTNxEurjo21eXQBQO0D5My6Aox4LCfsO1A@mail.gmail.com>
Message-ID: <CAHk-=wjS=xg12RVQdTNxEurjo21eXQBQO0D5My6Aox4LCfsO1A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Theo de Raadt <deraadt@openbsd.org>
Cc:     Jeff Xu <jeffxu@google.com>, jeffxu@chromium.org,
        akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, willy@infradead.org,
        mawupeng1@huawei.com, linmiaohe@huawei.com, namit@vmware.com,
        peterx@redhat.com, peterz@infradead.org, ryan.roberts@arm.com,
        shr@devkernel.io, vbabka@suse.cz, xiujianfeng@huawei.com,
        yu.ma@intel.com, zhangpeng362@huawei.com, dave.hansen@intel.com,
        luto@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 at 11:20, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> The only case where the immutable marker is ignored is during address space
> teardown as a result of process termination.

.. and presumably also execve()?

I do like us starting with just "mimmutable()", since it already
exists. Particularly if chrome already knows how to use it.

Maybe add a flag field (require it to be zero initially) just to allow
any future expansion. Maybe the chrome team has *wanted* to have some
finer granularity thing and currently doesn't use mimmutable() in some
case?

                  Linus
