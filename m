Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4CB75C00A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjGUHnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGUHm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:42:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9746C273D;
        Fri, 21 Jul 2023 00:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2395610A6;
        Fri, 21 Jul 2023 07:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281CAC433C7;
        Fri, 21 Jul 2023 07:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689925369;
        bh=T4FJvDy9MkTw/qZktOip/VIoJ8vZ68JXARk3IFi5TeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5eRPMsF18CLkDAvMwcz44y0+muivNABdQoDv57UA1bvb4WEQJH+VW5EyRPL3LTAG
         giC81RLaygveRtb50U43+Twj/5CbJF4cOOXp9D6myAib8Fl61savpy+spaSOEDZCsR
         Z1OBe/9o5gPn8tWTvc8fgMULT+mGZZ/m3ll054/z4Wwm3KSxW7j5Xlw0VeOkikH3Z5
         EhqsqQ3jRA4k5eIqvgoJiB43U4UynuX07sxfP4WBkOQiP6fI32TZB0MUUT75LHMsis
         61WEGpIkt7RmNDfmCwFFJUAY4CQsraC9OHnT8Ni7MW4fBC4nLhXIw8r25AzGjvikuy
         2zzA0qWBW67bw==
Date:   Fri, 21 Jul 2023 15:42:46 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Rob Barnes <robbarnes@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the chrome-platform tree
Message-ID: <ZLo29pYwDhKBLM2S@google.com>
References: <20230720124611.45b25256@canb.auug.org.au>
 <ZLi/gg2HLgwt5JR3@google.com>
 <CA+Dqm31A6GNOpXB00X0aRd5TOpDgRAuTNh0Ce5YKm5EN+15gyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Dqm31A6GNOpXB00X0aRd5TOpDgRAuTNh0Ce5YKm5EN+15gyg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 09:32:11AM -0600, Rob Barnes wrote:
> The patch to fix this issue was submitted here:
> https://lore.kernel.org/lkml/221b9a4a-275f-80a4-bba6-fb13a3beec0a@roeck-us.net/T/
> 
> However, it's looking unlikely that it will be accepted. So I think we
> should revert a6edd5f5d9cc for now. Let me know if I need to submit a
> revert patch?

No, you don't need to send a revert patch.  I'll remove it from the queue
if the symbol can't get exported for now.
