Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462F279088B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 17:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjIBPiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjIBPiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:38:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88DFE4B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:37:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so1574a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693669078; x=1694273878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LqKOi6XeDft6JHIA0q1WMDUlAe87S892KnJGjksHzw4=;
        b=T2+qniJbJMdT6g+lEZ/gRb7HIjv3cAzfQ+3qGNh/H4lQ3Y7KUWDA7vJfRaNPlzd91p
         2YKWnAGlE2wooiWbMc+PKV8irlyqz1eIULvk0d7COUpt+y73oMLRQCwajEm7eEolqH7n
         0TmqXgR67mJPTsK/DscRzhjRcyAJn691d25C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693669078; x=1694273878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqKOi6XeDft6JHIA0q1WMDUlAe87S892KnJGjksHzw4=;
        b=NJ6AoE0Eo0nq61VcpKTviv9JocF2ABcKvhc1n6eJAIcZJNrnIYVLS2lwcBrClfeONz
         hIUOBix9dfGguEWuMb2H95qNHjWDtC+LI2H3jgGAB4LFDKMXubKvVev6HYC1p2SNi7/h
         mhK6sECEveqD1P3Dto+AsMfqzTpzTLRGXqXb44jR2fSeVczZpbdlmIqaDQgnNmT3iDAv
         Yuq8IW4L3133O6DFyJUm8ubPDbkRg8ZDuNKIJu22mC7KEwFcBvqMMHWv/aV5FkPy5aV4
         ARX/AIgV3l7IrqYEKAugEfxe2hv/101wAyMP6m+oFxJe88o+cD+5XklRRNUOUzdhfmg+
         V5pA==
X-Gm-Message-State: AOJu0Yye0pXUWsFhYggAQJdObaEioGljxKY44rJIvkj338H1vNA38yqd
        0QCWhFWV9B1V7AkiPggQPBdIpFLioGKJg8QwnahU4g==
X-Google-Smtp-Source: AGHT+IHd5Vu/6IalXJap9hy+JS6mI1VDQ8PzkFTwlVBgAre4/xk+ftssjeqVHK2hJmKzkDwOGBijSA==
X-Received: by 2002:a17:906:cc0f:b0:9a5:c79f:bed5 with SMTP id ml15-20020a170906cc0f00b009a5c79fbed5mr3695161ejb.16.1693669078110;
        Sat, 02 Sep 2023 08:37:58 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a1-20020a170906684100b0099bd046170fsm3495490ejs.104.2023.09.02.08.37.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 08:37:56 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so4021050a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 08:37:56 -0700 (PDT)
X-Received: by 2002:a05:6402:12d7:b0:51d:d390:143f with SMTP id
 k23-20020a05640212d700b0051dd390143fmr4373503edx.5.1693669076297; Sat, 02 Sep
 2023 08:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZPMdTJ7zwrCkdMTu@debian>
In-Reply-To: <ZPMdTJ7zwrCkdMTu@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Sep 2023 08:37:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmvf9OjxeiO7ZzN2hsmDZ7-HViP9AjQkRN84fuDXNATQ@mail.gmail.com>
Message-ID: <CAHk-=wgmvf9OjxeiO7ZzN2hsmDZ7-HViP9AjQkRN84fuDXNATQ@mail.gmail.com>
Subject: Re: mainline build failure due to d1d4ff5d11a5 ("cgroup: put
 cgroup_tryget_css() inside CONFIG_CGROUP_SCHED")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sept 2023 at 04:32, Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> git bisect pointed to d1d4ff5d11a5 ("cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED").

I pushed out a commit that should fix it (76be05d4fd6c: "cgroup: fix
build when CGROUP_SCHED is not enabled")

            Linus
