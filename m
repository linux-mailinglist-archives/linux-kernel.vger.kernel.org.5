Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA8379D056
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjILLrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjILLrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:47:36 -0400
Received: from dd20004.kasserver.com (dd20004.kasserver.com [85.13.150.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED3410D2;
        Tue, 12 Sep 2023 04:47:31 -0700 (PDT)
Received: from dd20004.kasserver.com (dd0804.kasserver.com [85.13.146.35])
        by dd20004.kasserver.com (Postfix) with ESMTPSA id EFBC26320998;
        Tue, 12 Sep 2023 13:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silentcreek.de;
        s=kas202306171005; t=1694519249;
        bh=Ujehp2CrxYPoXuYDlpiKj4du5N6E27baKTbPSJgLyDs=;
        h=Subject:To:References:Cc:From:In-Reply-To:Date:From;
        b=I50aEkjTO1YDotnc2qFwZ9CM00zhMymhQh3v4UbI4IYSBll47/qoTqM/SeUk6M9kg
         AbwEoHlZdvCtVcGCL2HQ6KynlRlJOYxepjA24K2qDw86hU3EiJEutMf9BijDSBYI7j
         R9PLEc9w1P3ROpifpDr/yIIV42BiRzNTNqm8gfqtXzKkiIFAJdNNyZiEtOetb9/xHc
         SGOJVXn4sN1HuKEk2hGRDjZLOWxHrtnGNCPtFK/m0/deZkrcqdUYcf4TPA5zGQPdmi
         FjIAP1CW+ypnSQ7De1ONtmJHEZEl37x3gmKkeMn4hYhC0/e70G1X6yGg/EVxJngFLT
         g1v5SqsU/WWVw==
Subject: Re: Regression: Commit "netfilter: nf_tables: disallow rule addition
 to bound chain via NFTA_RULE_CHAIN_ID" breaks ruleset loading in linux-stable
To:     regressions@lists.linux.dev, fw@strlen.de
References: <20230911213750.5B4B663206F5@dd20004.kasserver.com>
 <ZP+bUpxJiFcmTWhy@calendula>
 <b30a81fa-6b59-4bac-b109-99a4dca689de@leemhuis.info><20230912102701.GA13516@breakpoint.cc>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        sashal@kernel.org, carnil@debian.org, 1051592@bugs.debian.org
From:   "Timo Sigurdsson" <public_timo.s@silentcreek.de>
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 89.246.188.214
MIME-Version: 1.0
In-Reply-To: <20230912102701.GA13516@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20230912114729.EFBC26320998@dd20004.kasserver.com>
Date:   Tue, 12 Sep 2023 13:47:29 +0200 (CEST)
X-Spamd-Bar: /
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Florian Westphal schrieb am 12.09.2023 12:27 (GMT +02:00):

> Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info>
> wrote:
>> On 12.09.23 00:57, Pablo Neira Ayuso wrote:
>> > Userspace nftables v1.0.6 generates incorrect bytecode that hits a new
>> > kernel check that rejects adding rules to bound chains. The incorrect
>> > bytecode adds the chain binding, attach it to the rule and it adds the
>> > rules to the chain binding. I have cherry-picked these three patches
>> > for nftables v1.0.6 userspace and your ruleset restores fine.
>> > [...]
>> 
>> Hmmmm. Well, this sounds like a kernel regression to me that normally
>> should be dealt with on the kernel level, as users after updating the
>> kernel should never have to update any userspace stuff to continue what
>> they have been doing before the kernel update.
> 
> This is a combo of a userspace bug and this new sanity check that
> rejects the incorrect ordering (adding rules to the already-bound
> anonymous chain).
> 

Out of curiosity, did the incorrect ordering or bytecode from the older userspace components actually lead to a wrong representation of the rules in the kernel or did the rules still work despite all that?

Thanks,

Timo 
