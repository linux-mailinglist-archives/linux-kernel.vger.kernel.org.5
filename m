Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7844D7F15A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjKTO1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjKTO1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:27:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2C61BB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:26:57 -0800 (PST)
Date:   Mon, 20 Nov 2023 15:26:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700490416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TXI49i6To3Vr/VehUOnq2ADvpNswt7q+vcDH6uWA0Os=;
        b=bOUzPHq3dXKV07IyY8kEBWBRG3uztDE39NH3YeDBKWesjxLbsmUwXN7NOIousYn9pH0YOz
        bxrLLjFcccU2epTqxaER9HvGXXOXVySdvUi4+aNQhGQcmm7PMSeSvBptqHpvyvb1fRWYRZ
        uGyHimIdUgS8lmRbfzQIzV/TBfGT32juSxUdlf5k/hWrAYXdE57rQAgzBt7YUKb7WRnPOb
        wYXZflNxruA2kANkeMlLHgLqubDg4QA/2orIkLFgN2tz6hvh7nMLe9Xn7e2YqdY8i+o4Ij
        6LaV5rSXgT9z5oZz8zs+ggPmbmVGAbS9+s8WJUSwykea2XY4Scx2iSE26I4Y7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700490416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TXI49i6To3Vr/VehUOnq2ADvpNswt7q+vcDH6uWA0Os=;
        b=7RXDpFmlN2rww9TEqmTIyP5uJPcanZ21KKKmoFqCOSGVwyKLvsMEHqa4KahobBQ9te0KkT
        8sghnsXqWwNY0UCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, oe-lkp@lists.linux.dev,
        lkp@intel.com, John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [rt-devel:linux-6.6.y-rt-rebase] [panic]  768c33033e:
 BUG:workqueue_lockup-pool
Message-ID: <20231120142654.9IyB0q_P@linutronix.de>
References: <202311171611.78d41dbe-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202311171611.78d41dbe-oliver.sang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-17 16:53:57 [+0800], kernel test robot wrote:
> Hello,
Hi,

> kernel test robot noticed "BUG:workqueue_lockup-pool" on:
>=20
> commit: 768c33033e41ad195a9304ebb183afb730d5ae98 ("panic: Mark emergency =
section in warn")
> https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git linux-=
6.6.y-rt-rebase
=E2=80=A6
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202311171611.78d41dbe-oliver.san=
g@intel.com

It should be the printk issue on 32bit. It matches the statck trace
provided in the dmesg.xz file. I will add the tag in the updated
version.
Thank you.

Sebastian
