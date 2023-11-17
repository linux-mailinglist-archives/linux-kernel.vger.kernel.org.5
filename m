Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424097EF8C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjKQUiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjKQUiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:38:06 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6612A7;
        Fri, 17 Nov 2023 12:38:03 -0800 (PST)
Received: from localhost (unknown [98.53.138.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 806372F3;
        Fri, 17 Nov 2023 20:38:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 806372F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1700253483; bh=q6+O3Z4W8hngyfTtdcFQ2nq/97As5//xLdkJImOc1vk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZmEhFO6ZE6ao4whuNt0YrEx2H6O09JfyTSPa4KoV8a/TlXELtBT2Hom8njwtwaRLN
         MUE67PxGJ6Vo93jsiPhE2QNw1WWBUBliubzmtywl8G6qfX+WqEp089obgjkA+Puttb
         iWY9vnX+6I1pbOS93M1t4GlVV+2JEpxor+FCR7rRWqzfF8shpLrPLkrndSGZR0LjUN
         OgnJhi03JviL8NMRSFxErcDvm/9gRYLM3F3wFINFE5Xo3avMuFN5UUHwcWP8z/BnbQ
         qsIOCdINIQfJtQCot3Rdyl5XQfGa24DWhzsFgqGTsdcBbw6bUodjKNw6weJFHmJiqR
         FMP3yuSrVL3FQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH RFC] docs: automarkup: linkify git revs
In-Reply-To: <20231027115420.205279-1-vegard.nossum@oracle.com>
References: <20231027115420.205279-1-vegard.nossum@oracle.com>
Date:   Fri, 17 Nov 2023 13:37:53 -0700
Message-ID: <87h6lk86am.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> There aren't a ton of references to commits in the documentation, but
> they do exist, and we can use automarkup to linkify them to make them
> easier to follow.
>
> Use something like this to find references to commits:
>
>   git grep -P 'commit.*[0-9a-f]{8,}' Documentation/
>
> Also fix a few of these to standardize on the exact format that is
> already used in changelogs.
>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/arch/x86/boot.rst           |  2 +-
>  Documentation/bpf/btf.rst                 |  6 ++----
>  Documentation/doc-guide/sphinx.rst        |  9 +++++++++
>  Documentation/livepatch/callbacks.rst     |  4 ++--
>  Documentation/networking/snmp_counter.rst | 16 ++++++----------
>  Documentation/sphinx/automarkup.py        | 20 +++++++++++++++++++-
>  6 files changed, 39 insertions(+), 18 deletions(-)

That seems to work nicely.  Applied, thanks.

jon
