Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD547BF9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjJJL1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjJJL1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:27:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD739E;
        Tue, 10 Oct 2023 04:27:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B7BC433CB;
        Tue, 10 Oct 2023 11:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696937272;
        bh=dtIQTDwVuag5MMahnmM7/RPqc9HUv7RP2UIAvmElWJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PlLsRHRMYGdugdo8mpcaqXpbhLp8hmL86LfnEzRbynQFv2E0hhbfg+54a0iQsWAKj
         0sJKpgcOvDhhIZGa0uLNoKHEL9TdGbsGdWIKNiXafi3zsTAtIS6bV0EuF0Y8ZeCF9w
         NRZGmWomjJE0rP9w8p49Uog6mlDDNjPOKIq09/uTXw0qr8AzIzZmUg+zPg+MIuTyZ0
         XkAJ1KaVWHypTOLmKkuS/sXmDSnCBs487QxvDonQMbdp48mBQOnXb2H6pLL2XDlVjL
         n2yXEZTBvIGSkJP+3Y7U0iwDpBbPeniih1HKLeHVKxnzi7iMTWKzGWRPoINTwzU472
         Kyi0vwmWTsRmw==
Date:   Tue, 10 Oct 2023 13:27:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     zhuangel570 <zhuangel570@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/5] srcu fixes
Message-ID: <ZSU1NeV/Z65ph/RC@lothringen>
References: <20231003232903.7109-1-frederic@kernel.org>
 <f214737a-6856-455f-ac86-9f7ec605b902@paulmck-laptop>
 <ZR0vjdp+BNiFm46+@lothringen>
 <CANZk6aQG4Lqyk8JkT_my3dwub4jGpn31wYRoCwW4oSH1x=sJ1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANZk6aQG4Lqyk8JkT_my3dwub4jGpn31wYRoCwW4oSH1x=sJ1A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 06:24:53PM +0800, zhuangel570 wrote:
> On Wed, Oct 4, 2023 at 5:25 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> There is currently no way to reproduce this problem in our environment.
> The problem has appeared on 2 machines, and each time it occurred, the
> test had been running for more than a month.
> 
> BTW, I will run tests with these patches in our environment.

Ok, let us know if it ever triggers after this series.

Since I added you in the Co-developed-by: tags, I will need to
also add your Signed-off-by: tag.

Is that ok for you?

Thanks.
