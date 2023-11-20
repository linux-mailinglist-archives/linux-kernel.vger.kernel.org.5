Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1357F171D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjKTPR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjKTPRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:17:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C63E10F1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:17:17 -0800 (PST)
Date:   Mon, 20 Nov 2023 16:17:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700493435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K3luYjW4+b8eiOVyq/MgJ1GTBk4q8MbuB+R3JUqmQTI=;
        b=YvUji9dwKUG9gmCseE4F82oupuwKlYYjIKYGLEftJp9sjT/kXCv7CKvIsQ4PphrwOMU1ZM
        rLKb29ojeupexh2H7QrN84SVK+mL+11SX2jm14WwGwy1Kpc5+o6CZG67G35KubDz1RN178
        Mjyv8VZtzZFPIuobNu0wlVJt6AILWSFjnZgJLfo/59hcf6GlKL73dVBNcxQ2A96HZcq9tu
        m8GLRqlI8NcEXMhbt62TQdygsuunk4iBJl38GdgJWgbIXOnZ+vapxkSW0QHI4dcmSXH7Xg
        49Byu9fYwjEc13v8i+Q0cQ3dbeqOt0A0Pi/gTLjKw4whqRWs9GxO+I1U5bfFVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700493435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K3luYjW4+b8eiOVyq/MgJ1GTBk4q8MbuB+R3JUqmQTI=;
        b=5O6szdcEW60mmbNfoS+J72fQnONmREIyw4rrpy/Atj6GOjDJ5aSWHt35Kc1sh9BH6b/oPO
        RvJ1pgWJentKVWDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kernel/time/hrtimer.c:1483:14: warning: variable
 'expires_in_hardirq' set but not used
Message-ID: <20231120151714.ttaFVMK0@linutronix.de>
References: <202311120815.33YfGjzD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202311120815.33YfGjzD-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-12 08:52:44 [+0800], kernel test robot wrote:
> Hi Sebastian,
Hi,

> FYI, the error/warning still remains.
> 
>    kernel/time/hrtimer.c:120:35: warning: initialized field overwritten [-Woverride-init]
>      120 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
>          |                                   ^~~~~~~~~~~~~~~~~~~~~
>    kernel/time/hrtimer.c:120:35: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
>    kernel/time/hrtimer.c:121:35: warning: initialized field overwritten [-Woverride-init]
>      121 |         [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
>          |                                   ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/hrtimer.c:121:35: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
>    kernel/time/hrtimer.c:122:35: warning: initialized field overwritten [-Woverride-init]
>      122 |         [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
>          |                                   ^~~~~~~~~~~~~~~~~~~~~
>    kernel/time/hrtimer.c:122:35: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
>    kernel/time/hrtimer.c:123:35: warning: initialized field overwritten [-Woverride-init]
>      123 |         [CLOCK_TAI]             = HRTIMER_BASE_TAI,
>          |                                   ^~~~~~~~~~~~~~~~
>    kernel/time/hrtimer.c:123:35: note: (near initialization for 'hrtimer_clock_to_base_table[11]')

This is "okay". The array is first initialized completely to a safe
value and then a few of the individual values are overwritten.
So this "initialized field overwritten", that the compiler complains
about, is intended here. 

>    kernel/time/hrtimer.c: In function '__run_hrtimer':
> >> kernel/time/hrtimer.c:1483:14: warning: variable 'expires_in_hardirq' set but not used [-Wunused-but-set-variable]
>     1483 |         bool expires_in_hardirq;
>          |              ^~~~~~~~~~~~~~~~~~

This is because the code using it is disabled at build time. I could
tweak the code to make look it used in the off case so the warning goes
away.

Sebastian
