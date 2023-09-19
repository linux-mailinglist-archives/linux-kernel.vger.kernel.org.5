Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995B27A6844
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjISPmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjISPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:42:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F0BE;
        Tue, 19 Sep 2023 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=IACdfNuUYr66Z311YYT0yhMAduB6qAWlbgcROB4ta1g=; b=zHRoIVAIs5n8pYuYR0KDW0wscP
        lFyIVlmkCumQloWCHty5+XxdLEgCgbkhQN/ueAHlDnXdFZoJgsO+lOPUggdToQ2LDGFtT7nnSyxoX
        sAiBk3oRiTwQX+7nJBR3e+9DCRx+mRzhFEvhH/bX5h3/ALbO/piXeG1rkcH5P9TrvblmzBiLomgBG
        FY5Bs6f4b2aoWul8id8utAzUFJ3WoG3O3fliC/qkyWu0MWcW+LZ9P+4n/EzdEduVQq4ABgIzxgUIx
        YiKbiJY6V92cS2//bT/LyjGuqUyYStAk/bw6Q5f/pFibR1c4/CYbYqV+SPVD6VKG6BtwI1ZnLaKRm
        ubM5G1ug==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qicrX-000mij-35;
        Tue, 19 Sep 2023 15:42:08 +0000
Message-ID: <04b8a6de-2b20-4488-b20f-c8a8f6001fd2@infradead.org>
Date:   Tue, 19 Sep 2023 08:42:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Sep 19 (UML)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
References: <20230919163728.78432283@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230919163728.78432283@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/23 23:37, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230918:
> 
> New tree: kvm-ppc
> 
> The mm tree gained a boot warning for which I reverted 5 commits.
> 
> Non-merge commits (relative to Linus' tree): 5750
>  3717 files changed, 446028 insertions(+), 107378 deletions(-)
> 
> ----------------------------------------------------------------------------
> 

on i386 or x86_64:

../arch/x86/um/../kernel/module.c: In function 'execmem_arch_params':
../arch/x86/um/../kernel/module.c:54:50: error: implicit declaration of function 'kaslr_enabled'; did you mean 'kasan_enabled'? [-Werror=implicit-function-declaration]
   54 |         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled())
      |                                                  ^~~~~~~~~~~~~
      |                                                  kasan_enabled



git blames this on:

commit 12633d679796
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Sep 19 15:14:03 2023 +1000

    Revert "arch: make execmem setup available regardless of CONFIG_MODULES"
    
    This reverts commit 3300c3af20090ff5e03e5c4bf2ef2cfaa03d4e9b.


-- 
~Randy
