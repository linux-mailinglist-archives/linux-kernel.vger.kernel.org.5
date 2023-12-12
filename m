Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56A580EDC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346486AbjLLNeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjLLNeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:34:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74022AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:34:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84000C433C8;
        Tue, 12 Dec 2023 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702388053;
        bh=CqD7IvbERxZ4/wzm3/NaR3i88J3fRY8NtJmzJVhqbuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sr2z4XKn/aPC45t6yzfw/5ANpdcntjra1JlEe+dVdQALiIXKTxl9CYMik8zyrEeLy
         aOqknl3OCYMDn/6MU8bImm7VxV8Mq2zX6fTIRq3Bs5j7mZIS2ro7ovgI+tevmNDR/j
         I4XWTpOs8r6XFJCi3EawQtyjrsa7DeFGSANw/D+64p6l3dQnvZyVflWmfMVvEk5X4k
         00rmfWhg5BizqbGIWASqEewyT4HeniudXpNj4ZFt5H80uw20cgpfg6ywns8LuBvWJj
         AQbyDXSwdEtbi+xZ8ztk6BOLARaaS2eAtigUb/9ID8hE+PyPvnNB7QdNHtZjI6y09J
         uIRn1xlAWKZhQ==
Date:   Tue, 12 Dec 2023 14:34:09 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/8] rcu: Fix expedited GP deadlock (and cleanup some
 nocb stuff)
Message-ID: <ZXhhUSmHl63Gp6EG@lothringen>
References: <20231208220545.7452-1-frederic@kernel.org>
 <0be847d6-804e-4f9d-9eb4-beee9efb6c78@paulmck-laptop>
 <ZXdrNJFCaXAFMITp@localhost.localdomain>
 <c429620e-53ab-4cd1-b1c2-ca83f4f3cea7@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c429620e-53ab-4cd1-b1c2-ca83f4f3cea7@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 01:39:40PM -0800, Paul E. McKenney wrote:
> This one passes TREE01 and TINY01, but on TREE09 still gets this:
> 
> kernel/rcu/tree_nocb.h:1785:13: error: ‘__call_rcu_nocb_wake’ defined but not used [-Werror=unused-function]
> 
> Huh.  I suppose that there is always __maybe_unused?

Looks like a good fit indeed!

Thanks!

> 							Thanx, Paul
