Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF76377A05D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjHLOOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLOOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:14:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B85171F;
        Sat, 12 Aug 2023 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691849677; x=1692454477; i=deller@gmx.de;
 bh=Z0Q1Bsd2MUeU0/1NwsOdMI2auHzcEVELykRiZEs2ghE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TXeqFUxb2NV9CADKQgvtRz6zqv1cbv/CjTmFHY7QVyWwOL8rVvf1yiYunpdG1klVtCQXhn8
 DM24APzpsa3ELIMVbH3Vo6uTtwMy2u+3wxxlesFS5sR6+GZtNlyPtuhyzLFQkr00fP0RdWSpn
 kq0W5TftKaFq9W1JrkzakLqCYmJ9fdo1SuQKXdIJd7wGpge9soeqmWTter3II5LvfIvuMqcdR
 X4tK2TBDS1lIkYVCRjrcD+8SRtlOGp8CWzL/2oJMvII3Q3W9iZKH39u95PLApxSuu3OO/k98U
 W6NaII5EJg6eqLcKT5WK8CuGYXkNJqLF9XJ/zaBpxWhrAeoi/8RA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.153.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1pphg83AMn-00f6vI; Sat, 12
 Aug 2023 16:14:37 +0200
Date:   Sat, 12 Aug 2023 16:14:36 +0200
From:   Helge Deller <deller@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH] devtmpfs: Add missing lockdep annotation
Message-ID: <ZNeTzE+C0souldl9@p100>
References: <ZNZblen+NXOrW9wE@p100>
 <2023081210-deputy-emboss-f348@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081210-deputy-emboss-f348@gregkh>
X-Provags-ID: V03:K1:zwYCU+JNc90/kSZhs7ntPMdfpTOa5+zvTMl+UHYkp2vOkLpbVy4
 lGzkdg7mR1vZrbukZJitHCVgfteFpj2ALoRACw6m/eEEJiIXozJfUhfGO28kXWsztZWQAjc
 QLEJvTYMAazqaTH19YA4o4EQAmwWeIyNd7uWIRK1GBqO54jxNS91pg7mQ9HesOyJijJrP8P
 lyCPXmsN1tc9gq9melqRw==
UI-OutboundReport: notjunk:1;M01:P0:pn0rDcEqfLQ=;pkoyj47klR4fai0zMD9KLrEULnf
 rkTLZhZ6xBBVZRMaHQaBZYYYHc+lOzwKCQow9BTtnR4uP6K1apG6v8MWzwgJrmS8Cv2kVZoYF
 1AXAgflubtlcg7wfOHLgEg8mO1sHNQGGqiUD7acb7JDIpILffp6A2lWomZvlSoeWGBcWYNGWV
 VQ4wXm1j7j28Mqk6UdC6urIKY7S4076jrpeHI7NHlKH+X5khly6+/5OwmXP7OOLkAaqZmIYhk
 GYZAyg/nfb0Nf62f8T7/phH7yMmxL6P7VM82BhcUtoCV6oS+QFfRO+9HBVNRsIAGZOv9oW20m
 rlrz/xb85bNCFTQzdSG5gso6iMdb5XMTWmcvxs8Gg4+ywvweqg7OPHe5RjHJVtIKlYXnntcIP
 pvoLv43hKuAZRLy7A5FDJSBQf3MO3Eb8QXZA8JPcMPJf2eOhf8VGF2pg9tOuuc/wXDN0p7kaR
 7igb5dGV+eqlfvxUaZ/cyQWmuNN0CG7dVd7wF20AO1dPsFNaQVgg4oqpHjOhIHB52C1NtmMW6
 CxX8qeYVVV9T6r2ieNDRpu4iOcE3SEAyj9tVQydoLyL2PB5+YEYvBLX4tNVtO1B1iNV9ewBel
 rc7DYi2y+y3mr7MBDd2skohJzUaiq1j2SR8JNU4DHq6yaaZKjUxchcfneuQrlISA23fAKOWyU
 5MkKi2GH9THytlmGwJsmBlf7udjkjcRT45/jFGgDeGBRXVo/VsEUprVKMYh64YQzBbEds2gfN
 9fWhQruJ2wJBwyZJEZCFNgIO+kohbgEIxHk4nP/JHrMwWU+86DZKtc20VYoJSZDgQkPTOuu2G
 07qQEqVV3YYHNr9Opz+6oMp0YNwx+ZIIIon67r80MstfuTXEMj9ZxNT4NdB3vIoiRSiV4q65U
 vZ7C7hTurm8b3rD8nLUMecBFAeCnZ7zzA2qzY3b8HZGhUVC6fBf3yXaNtjVWiPknR6ujhlq86
 K6yFoQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Fri, Aug 11, 2023 at 06:02:29PM +0200, Helge Deller wrote:
> > Add the lockdep annotation to the setup_done completer to avoid this
> > kernel warning:
> >
> >  Backtrace:
> >   [<000000004030bcd0>] show_stack+0x74/0xb0
> >   [<000000004146c63c>] dump_stack_lvl+0x104/0x180
> >   [<000000004146c6ec>] dump_stack+0x34/0x48
> >   [<000000004040e5b4>] register_lock_class+0xd24/0xd30
> >   [<000000004040c21c>] __lock_acquire.isra.0+0xb4/0xac8
> >   [<000000004040cd60>] lock_acquire+0x130/0x298
> >   [<000000004147095c>] _raw_spin_lock_irq+0x60/0xb8
> >   [<0000000041474a4c>] wait_for_completion+0xa0/0x2d0
> >   [<000000004015d9f4>] devtmpfs_init+0x1e0/0x2b8
> >   [<000000004015d0e4>] driver_init+0x68/0x1b8
> >   [<0000000040102b68>] kernel_init_freeable+0x4ac/0x7f0
> >   [<000000004146df68>] kernel_init+0x64/0x3a8
> >   [<0000000040302020>] ret_from_kernel_thread+0x20/0x28
> >
> > Signed-off-by: Helge Deller <deller@gmx.de>
> >
> > diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> > index b848764ef018..f98d58b0225c 100644
> > --- a/drivers/base/devtmpfs.c
> > +++ b/drivers/base/devtmpfs.c
> > @@ -462,6 +462,7 @@ int __init devtmpfs_init(void)
> >  		return err;
> >  	}
> >
> > +	init_completion(&setup_done);
> >  	thread =3D kthread_run(devtmpfsd, &err, "kdevtmpfs");
> >  	if (!IS_ERR(thread)) {
> >  		wait_for_completion(&setup_done);
>
> What changed to required this now?  What commit id does this fix?  Why
> doesn't the declaration of DECLARE_COMPLETION() initialize this properly
> for us already?

You're right!

The problem is not the missing init_completion() call.

That part of the kernel warning indicates the real problem:
 INFO: trying to register non-static key.

Lockdep uses static_obj() to check if the given lock is in "static" memory=
,
aka inside a valid memory region: from &_stext to &_end.

The "setup_done" completer is used at bootup only, and thus located in
the __initdata section. And on parisc the __initdata section is outside of
the &_stext to &_end range, so the static_obj() check fails.

The patch below fixes it.
I'll send a proper patch to the mailing list in a moment.

Thanks!
Helge


diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 111607d91489..aa99245d8e12 100644
=2D-- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -855,6 +855,15 @@ static int static_obj(const void *obj)
 	if (is_kernel_percpu_address(addr))
 		return 1;

+	/*
+	 * in initdata section and used during bootup only?
+	 * NOTE: On some platforms the initdata section is
+	 * outside of the _stext ... _end range.
+	 */
+	if (system_state < SYSTEM_FREEING_INITMEM &&
+		init_section_contains((void*)addr, 1))
+		return 1;
+
 	/*
 	 * module static or percpu var?
 	 */
