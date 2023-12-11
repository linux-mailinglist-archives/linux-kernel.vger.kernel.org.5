Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A5180C6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjLKKp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjLKKpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:45:49 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DD9F1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1702291548;
        bh=nJNJSRAPiHel+faBaicrqJd87X81ec133qYhZnzAXxg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ivbtaq0SZy/g2+D8pO1Byfa/UEjgT+0RGADp20ko/xVskJDfzj9PmP7ZtWOmFl1up
         CLeDOr3ewsmppclL0RJVzuBxwQfFhOvk+6Ucrj0GlvQWezsR3FN2ua8PcblqQHMBaL
         b71gcpcQ3Kj+ea9l4bs45fOMWW7nMmzFJgfht6y9hgn8BYJnxcQ3+RtSeV11S2POv+
         1Cyyfm+hglHWP+pCFhHXAop86485DYbEWsJQ1xhtfY8Wk0fFnr9sngkZFqApCygPp5
         gOOtgxqA80SdsGbcwjMwIpgDvrBrXgfwQWqJGW54qq6kXrkILZ4/8itqPc/2kabdUZ
         Zqjk0Rn4ISprQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Spdgv6mLNz4wdC;
        Mon, 11 Dec 2023 21:45:47 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v4 0/5] powerpc/smp: Topology and shared processor
 optimizations
In-Reply-To: <20231211025656.4lqrhnic5gynkuzq@linux.vnet.ibm.com>
References: <20231109054938.26589-1-srikar@linux.vnet.ibm.com>
 <20231211025656.4lqrhnic5gynkuzq@linux.vnet.ibm.com>
Date:   Mon, 11 Dec 2023 21:45:44 +1100
Message-ID: <87msuhdnl3.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> * Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2023-11-09 11:19:28]:
>
> Hi Michael,
>
>> PowerVM systems configured in shared processors mode have some unique
>> challenges. Some device-tree properties will be missing on a shared
>> processor. Hence some sched domains may not make sense for shared processor
>> systems.
>> 
>> 
>
> Did you get a chance to look at this patchset?
> Do you see this getting pulled into your merge branch?
> I havent seen any comments that requires a change from the current patchset.

I was assuming you'd send another version to at least incorporate the
clarifications you posted.

And I wasn't really sure the discussion about the prink_once() change
was resolved. Anyway I'll check with Aneesh.

cheers
