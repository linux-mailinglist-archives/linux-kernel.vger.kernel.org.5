Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6517BB637
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjJFLRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjJFLRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:17:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5A8F9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:17:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E32C433B7;
        Fri,  6 Oct 2023 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696591033;
        bh=cd0i+PIs1RvXzrN3U6j1Ub0kVu8Y50D6gcMqDJ6I48c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUXZ7l2u+mtU9bqIBKm8CNtiky6Snt6UIAaoD3H5/XWYCv+/P2Xea+FU8bBgNyZp1
         2SxnZah8UGAMzVeuVygjnCcl4VOJziltHsP4sWZtgeCQGoeTI5dnea99Q3gQ1cNWz7
         oOYJRQ88VmmEs2ZzeKdAMHL+ytR1vc+98U0eUQCVMU3fjNzS+uTj9RE5N6pEV9O+5X
         /zI7L8Xg90cJaaHBnKNkGSilYIB3Sur48cDT3cke3dTKocYT/4Itx2WHKyGPn71dzJ
         aZ2FZsVr6RjY/TY6K6ZRU8lNdJ+QqwWSdtQfFcvVNeUZuSeg0N+23pxSjboxsxD9mz
         WQi3ls5/vpBfQ==
Date:   Fri, 6 Oct 2023 13:17:10 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v8 07/25] timers: Use already existing function for
 forwarding timer base
Message-ID: <ZR/stg6r79FGnt/q@lothringen>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <20231004123454.15691-8-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004123454.15691-8-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:34:36PM +0200, Anna-Maria Behnsen wrote:
> There is an already existing function for forwarding the timer
> base. Forwarding the timer base is implemented directly in
> get_next_timer_interrupt() as well.
> 
> To avoid code duplication, replace implementation for forwarding timer base
> with the direct call to the already existing function.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Good catch!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
