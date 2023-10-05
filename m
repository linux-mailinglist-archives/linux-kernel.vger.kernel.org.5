Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E955C7BA2C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjJEPpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjJEPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:45:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4BC7688
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:32:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2162AC116D2;
        Thu,  5 Oct 2023 09:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696499059;
        bh=n0rJB8fV9mLGmVujUFMI+UNHNOp23wGOwv8hNHIVVmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qswWlWPadLuBBO2nU4EQZ/Ardmmf+MKvlrCHfX46HkFmSZdgk2C3goWZijVVU4GwB
         8QnZNPwnU2huB5Bep7LtFo7nfiVhjClrMupqaYGgMSEazOHEFzMISRUOAT2+1ztCpW
         6P0+/hjXBHtfbxOQyVP2PZfUe0Gtx7TwZ1611aNSiIcz7C8ez0yPao+lyMTUdx9Vno
         Smurun2I4Ftdn+ZrRwJJeVIcehDOPHgWP0IWS0hF8d0pwRR/y1agPg2qCa+fcCaFyP
         lxZKhGOPkbACR0dCASOzcrSfivTxHjl5Ty34ZwZyQFiyYPn2lGruRf2XFvXaxmKi8X
         +qSL959LeprlA==
Date:   Thu, 5 Oct 2023 11:44:16 +0200
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
Subject: Re: [PATCH v8 01/25] tick/sched: Cleanup confusing variables
Message-ID: <ZR6FcOhHZkNGi5To@lothringen>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <20231004123454.15691-2-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004123454.15691-2-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:34:30PM +0200, Anna-Maria Behnsen wrote:
> tick_nohz_stop_tick() contains the expires (u64 variable) and tick
> (ktime_t) variable. In the beginning the value of expires is written to
> tick. Afterwards non of the variables is changed. They are only used for

*none

> checks.
> 
> Drop the not required variable tick and use always expires instead.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
