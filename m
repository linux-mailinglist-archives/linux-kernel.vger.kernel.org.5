Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A73E7EA34A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjKMTIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMTIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:08:01 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBF410D0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:07:57 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 6B2C51F8F7;
        Mon, 13 Nov 2023 20:07:55 +0100 (CET)
Date:   Mon, 13 Nov 2023 20:07:51 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        francesco.dolcini@toradex.com
Subject: Re: [ANNOUNCE] v6.6-rt13
Message-ID: <ZVJ0B9HYLTsLxxXw@francesco-nb.int.toradex.com>
References: <20231108152329.NDcgOQAF@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108152329.NDcgOQAF@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sebastian, hello John

On Wed, Nov 08, 2023 at 04:23:29PM +0100, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v6.6-rt13 patch set. 
> 
> Changes since v6.6-rt12:
> 
>   - Update to the printk series provided by John Ogness. Some of the
>     patches were merged during the merge window other are under review.
>     Here is a small changelog:
>     - warn and panic console output will interrupt the threaded printing
>       mid-line rather than waiting for the line to finish printing
>     
>     - in panic, printing is now synchronous rather than first storing all
>       panic messages and then dumping to consoles
>     
>     - printing kthreads will sleep, rather than busy-wait, while consoles
>       are in emergency or panic states
>     
>     - atomic console printing will only print to the end of the emergency
>       messages, rather than flushing all remaining records
>     
>     - apply various printk mainline fixes currently in review
>         https://lore.kernel.org/lkml/20231106210730.115192-1-john.ogness@linutronix.de

During our weekly CI tests of rt-devel branch we noticed that commit
78f4b59c6faa ("printk: Update the printk series.") breaks booting on
multiple NXP i.MX platforms (arm and arm64), likely related to
drivers/tty/serial/imx.c.

We are not planning any additional investigation at the moment and
we have no debug outputs to share, just wanted to give you a head-up.

Francesco

