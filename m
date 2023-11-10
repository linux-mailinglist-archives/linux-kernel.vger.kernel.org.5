Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0260E7E804E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344715AbjKJSJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344062AbjKJSFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415A3B30D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:42:11 -0800 (PST)
Date:   Fri, 10 Nov 2023 16:42:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699630929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dDteLn6emsaeJRd9Z2EqXHXZ9pLR50Kqg15NjGltrl4=;
        b=MHtGO6IkNTFpDICaecsk5wGI21WyzVKZLJd6oLXrxG5ims/DLQHc7SQZS+nNwii1lTGOgg
        Tbc0f2qBcabmO5o1OBeFDGcvYEcdYTLNwH7X4k5L/y/T3mxs51mzoEmGTcHJgYGQCw2U+K
        +Jo8SIjtwoqernqen3aQ0+Wsgq9PHsr4TDUjRjPTKf3yaY0RJdvYtK44QFE1IiDKwi9dq+
        nL2LOfx7qXy5Aw5q/zy0QQkIyHPFBcacXSt9NbNgL/cKWLTiqy2vypt6ITRIAhKrd5mno0
        O/OtKBHmrRWOjiLqk4WjHpdwxLaDDhCg5NTpOgevgUjO3x68BTVZm/BBuNitPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699630929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dDteLn6emsaeJRd9Z2EqXHXZ9pLR50Kqg15NjGltrl4=;
        b=0GyOxRvkh5+t36CreeAX+gbAQp9YWnYvQhV9SgzvWMoPYn1TdbuvkRg95HBz2EbEW2lyv8
        dlxpNILdIYtCQwCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <20231110154208.5UoC_qsI@linutronix.de>
References: <202311080840.Vc2kXhfp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202311080840.Vc2kXhfp-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-08 09:04:40 [+0800], kernel test robot wrote:
=E2=80=A6
Could you please explain what is wrong here? The code in line 73 has no
percpu reference at all. Or expects an argument.

> sparse warnings: (new ones prefixed by >>)
> >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argumen=
t 1 (different address spaces) @@     expected void *ptr @@     got unsigne=
d int [noderef] __percpu * @@
>    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
>    lib/flex_proportions.c:73:9: sparse:     got unsigned int [noderef] __=
percpu *
> >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argumen=
t 1 (different address spaces) @@     expected void *ptr @@     got unsigne=
d int [noderef] __percpu * @@
>    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
>    lib/flex_proportions.c:73:9: sparse:     got unsigned int [noderef] __=
percpu *
> >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argumen=
t 1 (different address spaces) @@     expected void *ptr @@     got unsigne=
d int [noderef] __percpu * @@
>    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
>    lib/flex_proportions.c:73:9: sparse:     got unsigned int [noderef] __=
percpu *
> >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argumen=
t 1 (different address spaces) @@     expected void *ptr @@     got unsigne=
d int [noderef] __percpu * @@
>    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
>    lib/flex_proportions.c:73:9: sparse:     got unsigned int [noderef] __=
percpu *
> >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argumen=
t 1 (different address spaces) @@     expected void *ptr @@     got int [no=
deref] __percpu * @@
>    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
>    lib/flex_proportions.c:73:9: sparse:     got int [noderef] __percpu *
> >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argumen=
t 1 (different address spaces) @@     expected void *ptr @@     got int [no=
deref] __percpu * @@
>    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
>    lib/flex_proportions.c:73:9: sparse:     got int [noderef] __percpu *
> >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argumen=
t 1 (different address spaces) @@     expected void *ptr @@     got int [no=
deref] __percpu * @@
>    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
>    lib/flex_proportions.c:73:9: sparse:     got int [noderef] __percpu *
> >> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argumen=
t 1 (different address spaces) @@     expected void *ptr @@     got int [no=
deref] __percpu * @@
>    lib/flex_proportions.c:73:9: sparse:     expected void *ptr
>    lib/flex_proportions.c:73:9: sparse:     got int [noderef] __percpu *
>    lib/flex_proportions.c: note: in included file (through include/linux/=
mmzone.h, include/linux/gfp.h, include/linux/percpu_counter.h, ...):
>=20
> vim +73 lib/flex_proportions.c
>=20
>     55=09
>     56	/*
>     57	 * Declare @periods new periods. It is upto the caller to make sur=
e period
>     58	 * transitions cannot happen in parallel.
>     59	 *
>     60	 * The function returns true if the proportions are still defined =
and false
>     61	 * if aging zeroed out all events. This can be used to detect whet=
her declaring
>     62	 * further periods has any effect.
>     63	 */
>     64	bool fprop_new_period(struct fprop_global *p, int periods)
>     65	{
>     66		s64 events =3D percpu_counter_sum(&p->events);
>     67=09
>     68		/*
>     69		 * Don't do anything if there are no events.
>     70		 */
>     71		if (events <=3D 1)
>     72			return false;
>   > 73		preempt_disable_nested();
>     74		write_seqcount_begin(&p->sequence);
>     75		if (periods < 64)
>     76			events -=3D events >> periods;
>     77		/* Use addition to avoid losing events happening between sum and =
set */
>     78		percpu_counter_add(&p->events, -events);
>     79		p->period +=3D periods;
>     80		write_seqcount_end(&p->sequence);
>     81		preempt_enable_nested();
>     82=09
>     83		return true;
>     84	}
>     85=09
>=20
Sebastian
