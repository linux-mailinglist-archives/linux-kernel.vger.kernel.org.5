Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4A792B56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjIEQvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343542AbjIECdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:33:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E553FCC6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 19:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1693881184;
        bh=oYSw+lAsn5fW0NHyAGD8kP2eBNm2Gv1EzsjNXsi3X+s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NRL+iJQg/CfAtSnxyA8TTmE9AUVAPSA8q1cUdDkN831C3mzeHdT9Hx5NWdY8FsNWo
         gc1QqwhQvGunaf6ME/zpw09X8axTZsVQ5v1UbVnaE0IfMHTktKcULCqIKQZIQGrgp8
         wjJfMJURXHNDefyVdOlxOBL8IlYlpKJoJD5m9mM4+ZD7h5+7IVQUXX03UIS35SQtIk
         E4Rem0Pmj92oyGBGZ3vbgETg/A/AvE5iEEV8GW11gDxsEeDSuGvn6HVPXUDdelSIUb
         9S+gJzZ6c/P9Ajawrkv/p5M1aZmDkREWttR+s6ig1DM9p10BWILWZrWRq/NEfKPpX8
         fhh/4dzrLm1RA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfqL83pLzz4wZn;
        Tue,  5 Sep 2023 12:33:04 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] smp/core for v6.6-rc1
In-Reply-To: <169322654880.420889.9261217338657613439.tglx@xen13.tec.linutronix.de>
References: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de>
 <169322654880.420889.9261217338657613439.tglx@xen13.tec.linutronix.de>
Date:   Tue, 05 Sep 2023 12:33:03 +1000
Message-ID: <87cyyxic2o.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Linus,
>
> please pull the latest smp/core branch from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2023-08-28
>
> up to:  e0a99a839f04: Documentation: core-api/cpuhotplug: Fix state names
>
>
> Updates for the CPU hotplug core:
>
>   - Support partial SMT enablement.
>
>     So far the sysfs SMT control only allows to toggle between SMT on and
>     off. That's sufficient for x86 which usually has at max two threads
>     except for the Xeon PHI platform which has four threads per core.
>
>     Though PowerPC has up to 16 threads per core and so far it's only

The threads per core value comes from firmware, so in theory it can be
anything.

But in practice the max on any existing system is 8 threads per core.

cheers
