Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE3375D7E7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 01:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGUXip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 19:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGUXio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 19:38:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4228D1B6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:38:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c926075a50cso6075567276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689982722; x=1690587522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7oI2k+n70r09++ymnvAIa7Gl6vaz4ByDtPCwimW7Q90=;
        b=7d2WPgTOR161B95SSw69r7f+ijCvihtTNkLyDXwhknhcNvG4wFvEktHMAq7jt4OHEm
         a3e/VqagtHMG34iCPhuDyLhcuLMUwQ+ifw2gjSQjnhogyjHu/FI+nODzi2OoomWJhu2A
         9jsM16yblubZxqV5CF/Eis8Njtr+hy0EjuT8w7svSYzu6q8wePkRu0h9rMQf26EwIin6
         1Te2vN0ulcLxjqFjlngUBmIFjM2PkO9fZTXmDZtnkmCBsgdN2fMEsSy/UGtd5VVDVTAK
         m49iaey4dLHD8rUeVTsLKM4flB0RDLAiEdM9DfKUUReLU7MXwIlMoBmaxf8XkCAebF5P
         xL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689982722; x=1690587522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oI2k+n70r09++ymnvAIa7Gl6vaz4ByDtPCwimW7Q90=;
        b=R/jpg4A/zn+dM15JtrG1uy4+pUooddO6YVBKvVFXm7rQcaMUl6jHDbW4FQvZsKUWvr
         7HgxIq+T269ai5byxHns1pvA9PQkN6AbTAWWu8pBlspf7n42nCCU56m1GUtm+b5rEiSA
         1k92Fz/38LyozAOhtztcLcC0o11OT2aHSaNVlgF5CzeJgYxVINaMXSEkw+jrHHkx3dHU
         I68ssKAA+4UKpcg/xdJVQjbJJrgU/V6LqImka5m0pwULXj047IZXi9rzqlGt2LlRw1WS
         GnPA1q7aeoL7mWy2Y1gttOpwy9a1KIhy15xPAZ+2uMREgulpUJl35qevwW5rnjEYxZBm
         MOng==
X-Gm-Message-State: ABy/qLbLZdkm3/1L9nqj97lU1iQMJjWu02fkmHoimokA1qtvjxf0xDqh
        iDijLfqDDahJXjkaA9Sw1jAlHkL5HsU=
X-Google-Smtp-Source: APBJJlFDs5FHNs5v+9qnY6bXeicf3eDutpz6ueu60Qhp8gCv6VpW/IJ7YNk3G+Pic8BM3apO9vN7wvtGcoA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c9c3:0:b0:d00:f564:509b with SMTP id
 z186-20020a25c9c3000000b00d00f564509bmr36019ybf.1.1689982722574; Fri, 21 Jul
 2023 16:38:42 -0700 (PDT)
Date:   Fri, 21 Jul 2023 16:38:41 -0700
In-Reply-To: <202307211945.TSPcyOhh-lkp@intel.com>
Mime-Version: 1.0
References: <202307211945.TSPcyOhh-lkp@intel.com>
Message-ID: <ZLsXAdjFuKLpd3ig@google.com>
Subject: Re: arch/powerpc/kvm/e500mc.c:95:15: error: invalid instruction
From:   Sean Christopherson <seanjc@google.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023, kernel test robot wrote:
> Hi Sean,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f7e3a1bafdea735050dfde00523cf505dc7fd309
> commit: e83ca8cfa286c9fc78b585b0e66df7f542bcbcf2 KVM: PPC: booke: Mark three local functions "static"
> date:   4 months ago
> config: powerpc-randconfig-r001-20230721 (https://download.01.org/0day-ci/archive/20230721/202307211945.TSPcyOhh-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230721/202307211945.TSPcyOhh-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307211945.TSPcyOhh-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/powerpc/kvm/e500mc.c:95:15: error: invalid instruction
>       95 |         asm volatile("tlbilxlpid");

I assume this is a binutils bug?  I ran into a similar problem on PPC a while
back where I couldn't cross-compile even relatively basic PPC code.
