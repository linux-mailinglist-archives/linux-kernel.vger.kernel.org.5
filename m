Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5943375430B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbjGNTIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbjGNTIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:08:21 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5162E35A4;
        Fri, 14 Jul 2023 12:08:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 041A27C0;
        Fri, 14 Jul 2023 19:08:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 041A27C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689361700; bh=nUPuQ13veVELwRb8U6SSuEUxzlRyJIkwkNqP+rK/KCY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SSTMZ1Hk9q882shOHPP6sPofIvHcUJdWYDGaeM+wYpSk2ft2kLeV5IsmCL2hVM1EE
         hKJ/l91G1WWmLHv6maerTprAToo4RgxN1VJSIBV9aubhJNq25OwitTmVZ7boVFcbJb
         rC5/2eC+kQQx8WQgYwuSLIlAVPuY2EW9kx9wsNMDs2wFjqyqfTHAfEwTflLQGtvYXA
         6l6CVzefVeMB4aMd+n4lkEYSakjGbItRGxY5KrbCT+LcuuShbKrEoFnOo1054jQ8QY
         UZvKyjKS2VrmnFVVlXbkEWsUhnFuYvzaR6WnkrcDZi4DRB3XUPgP3Cg2hhNQU4u+vy
         w/9gu89P9no7w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        rick.wertenbroek@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: scheduler: completion: Fix minor error in
 pseudo-code
In-Reply-To: <20230706114057.1120335-1-rick.wertenbroek@gmail.com>
References: <20230706114057.1120335-1-rick.wertenbroek@gmail.com>
Date:   Fri, 14 Jul 2023 13:08:19 -0600
Message-ID: <87y1jiz4yk.fsf@meer.lwn.net>
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

Rick Wertenbroek <rick.wertenbroek@gmail.com> writes:

> Add missing address-of (&) operator in pseudo-code.
>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  Documentation/scheduler/completion.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/scheduler/completion.rst b/Documentation/scheduler/completion.rst
> index 9f039b4f4b09..f19aca2062bd 100644
> --- a/Documentation/scheduler/completion.rst
> +++ b/Documentation/scheduler/completion.rst
> @@ -157,7 +157,7 @@ A typical usage scenario is::
>  
>  	/* run non-dependent code */		/* do setup */
>  
> -	wait_for_completion(&setup_done);	complete(setup_done);
> +	wait_for_completion(&setup_done);	complete(&setup_done);
>  

Applied, thanks.

jon
