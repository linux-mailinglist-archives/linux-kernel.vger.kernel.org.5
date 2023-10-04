Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089617B8480
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbjJDQHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjJDQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:07:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ECABF;
        Wed,  4 Oct 2023 09:06:58 -0700 (PDT)
Date:   Wed, 4 Oct 2023 18:06:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696435617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/mvQ3LQWM+yhOAQ4tE2ke6BtCBZK3qVmsmkWeNUxwjU=;
        b=D834bHwVbxR9ipp3ib+2LAiFv+XvppnnkH5+kDBspJWd5betvqnDysg3oT17dsy7V4LjJ0
        9XcBdqcDcjJYxsO6EgSbdKd/B2LT02lACYA/zebQhFE+yRk+fcAvvpNEhxhkVbPjjsBxPV
        awPuMIMnOhA3p0dGW3PvxDUT9a4y4bAGExhqqOT3eFQuuZS5R8lX2ISW357PxNE2fU10eI
        RwLpFrksxyVlKhTXLkfgsDQkotZEK3+YASP+XL2xrVW9HDU4QxhhuYts1ziH6Se7qKI13Q
        KF3ptUGZr9rs82jnyzhzcf7/WytnrisZJwP6ihTOCqQ5nAijyNRB3fEJF8l/uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696435617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/mvQ3LQWM+yhOAQ4tE2ke6BtCBZK3qVmsmkWeNUxwjU=;
        b=gY3oPh0wfRPWSdir5KxH2LBvmzM4d7LbHt98ze07+k9pT6yQZc5kaD8E7s0Cuy9f6j3Oa5
        S72kTuAgvRp+u5AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.6-rc4-rt7
Message-ID: <20231004160655.0D-7XFo_@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.6-rc4-rt7 patch set. 

Changes since v6.6-rc4-rt6:

  - Lockdep complained about SRCU locking if printk was used from NMI.

  - The i915 driver could create a locking related splat during suspend/
    resume. Reported by John B. Wyatt IV.

  - A new version of printk. This is an update to the current
    development version. Large patch series provided by John Ogness.

Known issues
     None

The delta patch against v6.6-rc4-rt6 is not appended below due to its
size. It and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/incr/patch-6.6-rc4-rt6-rt7.patch.xz

and as web based diff:
     
     https://git.kernel.org/rt/linux-rt-devel/d/v6.6-rc4-rt7/v6.6-rc4-rt6

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.6-rc4-rt7

The RT patch against v6.6-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6-rc4-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patches-6.6-rc4-rt7.tar.xz

Sebastian
