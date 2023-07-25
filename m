Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8590A761AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGYN53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjGYN5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:57:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01541FCB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Jgl0XieBOEgol9v6No4S+VHtHcuhVMNvxRzF4jEjSk=; b=msqKwlyW7XEzHTuuzxfBe4hZv7
        6TQLa9t3BOrFQ7BdzCsqCpytboZspI4sUEpar039h8hFZvWtXSlPr7Jz1SWZU20iaD5Wbv2Q16vN0
        Mn4O6RbEUbwDE+8PmmYB6/NyarS1QaF3AIpTWR7PSvFIMK/e/Ib7HErwLJJylqLdAh90e2qLGHg+u
        1239my/bRT8gRQ3uQEEQ4mKLOJDiwNh8UiNYhO7puHewooMD3Op3DHYh1qF+nKNqwq4WH89xrXnin
        ewRSPJvA6yspFJuhpqn9wt+DwayhA3lAJPYRA/uW9mWHbtDuhLUq88v9KJMnwrUGLExf5ZcKGWH0z
        ynyzIwnw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOIXA-005WWO-5t; Tue, 25 Jul 2023 13:57:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFE1230036B;
        Tue, 25 Jul 2023 15:57:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FF6027D9B9A7; Tue, 25 Jul 2023 15:57:03 +0200 (CEST)
Date:   Tue, 25 Jul 2023 15:57:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: vmlinux.o: warning: objtool: cpuidle_enter_state+0x1d3: return
 with instrumentation enabled
Message-ID: <20230725135703.GN3765278@hirez.programming.kicks-ass.net>
References: <202307252003.0OM6CkWI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307252003.0OM6CkWI-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:57:50PM +0800, kernel test robot wrote:
> Hi Peter,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0b5547c51827e053cc754db47d3ec3e6c2c451d2
> commit: 17cc2b5525856d7374f09b28ba1faf1fa61b2352 cpuidle: Ensure ct_cpuidle_enter() is always called from noinstr/__cpuidle
> date:   6 months ago
> config: x86_64-randconfig-r012-20230725 (https://download.01.org/0day-ci/archive/20230725/202307252003.0OM6CkWI-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230725/202307252003.0OM6CkWI-lkp@intel.com/reproduce)

When I grab that .config and try and build v6.5-rc3 (using
olddefconfig), I get:

$ make O=tmp-build -j64 vmlinux
...
In file included from <command-line>:
./../drivers/gpu/drm/i915/intel_dsi_cmd.h:33:10: fatal error: intel_drv.h: No such file or directory
33 | #include "intel_drv.h"
|          ^~~~~~~~~~~~~
compilation terminated.
