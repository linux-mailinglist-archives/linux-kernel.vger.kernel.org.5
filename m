Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D85F768A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjGaDyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaDyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:54:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10184A1;
        Sun, 30 Jul 2023 20:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D1CA60E83;
        Mon, 31 Jul 2023 03:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3BCC433C8;
        Mon, 31 Jul 2023 03:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690775687;
        bh=E4ohKTWtdIMZQzjQBicmrpz83AnFnnvK8A7iqUWlIJE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JYEwrawbpmc6qWyZLM9/r5PJRb/88uZ4yEOJz8RK7kQ4aIA1jkVasCiXKWafil721
         d/MaYnS1O9VvGEwf01QMp0hLSwRTyETbORoLfsQHi9xF8LwRaZXLgQDWgbrtUY74cy
         meKBiHmKuefbEb0xoWZUtNGGYkzhhJTgBBHl9f4wRujmlAW6hIzaC7kxZkIstZ3WJA
         fcamJPQJ8EN/+SMeU5ZFbMSLK/BN0CmsXytUubJ+fJwetHFeyFJDX9csup877QV9YX
         zpwPu2c7cmlkEFA5cCskmHE2JvhyTSvKBsF4imx70ZKlwY2xReO/cpMTidOe3KhkVN
         3dkSO8bfTAzdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7145CCE1067; Sun, 30 Jul 2023 20:54:46 -0700 (PDT)
Date:   Sun, 30 Jul 2023 20:54:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
Message-ID: <bfa768e7-fc4f-4511-ad3a-67772f41d50c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZMJWet00+9yIl/9c@duo.ucw.cz>
 <78722041-D1F7-45FA-BA1C-41B92209BA6C@joelfernandes.org>
 <0751f5a8-2727-4a08-8bb8-50bbd4244c9c@paulmck-laptop>
 <67eba84a-ae24-2983-a756-463f39f3ca71@roeck-us.net>
 <ebe4a969-8a24-4bb8-8dbe-f77db89f65c9@paulmck-laptop>
 <2f4b012e-1f95-30aa-3f43-c31e84cb2c42@roeck-us.net>
 <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
 <6d45f1d0-25e5-8603-0fbb-73374be00503@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d45f1d0-25e5-8603-0fbb-73374be00503@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:22:52PM -0700, Guenter Roeck wrote:
> On 7/27/23 13:33, Paul E. McKenney wrote:
> [ ... ]
> 
> > So which of the following Kconfig options is defined in your .config?
> > CONFIG_TASKS_RCU, CONFIG_TASKS_RUDE_RCU, and CONFIG_TASKS_TRACE_RCU.
> > 
> 
> Only CONFIG_TASKS_RCU. I added another log message after call_rcu_tasks().
> It never returns from that function.
> 
> [    1.168993] Running RCU synchronous self tests
> [    1.169219] Running RCU synchronous self tests
> [    1.285795] smpboot: CPU0: Intel Xeon Processor (Cascadelake) (family: 0x6, model: 0x55, stepping: 0x6)
> [    1.302827] RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
> [    1.304526] Running RCU Tasks wait API self tests
> 
> ... and then nothing for at least 10 minutes (then I gave up and stopped the test).
> 
> Qemu command line:
> 
> qemu-system-x86_64 -kernel \
>      arch/x86/boot/bzImage -M q35 -cpu Cascadelake-Server -no-reboot \
>      -snapshot -device e1000e,netdev=net0 -netdev user,id=net0 -m 256 \
>      -drive file=rootfs.iso,format=raw,if=ide,media=cdrom \
>      --append "earlycon=uart8250,io,0x3f8,9600n8 panic=-1 slub_debug=FZPUA root=/dev/sr0 rootwait console=ttyS0 noreboot" \
>      -d unimp,guest_errors -nographic -monitor none
> 
> Again, this doesn't happen all the time. With Cascadelake-Server
> I see it maybe once every 5 boot attempts. I tried with qemu v8.0
> and v8.1. Note that it does seem to happen with various CPU types,
> only for some it seems to me more likely to happen (so maybe the
> CPU type was a red herring). It does seem to depend on the system
> load, and happen more often if the system is under heavy load.

Hmmm...  What kernel are you using as your qemu/KVM hypervisor?

And I echo Joel's requests for your .config file.

							Thanx, Paul
