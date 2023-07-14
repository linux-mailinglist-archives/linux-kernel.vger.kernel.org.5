Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0375429B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjGNSeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbjGNSeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:34:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2D4C6;
        Fri, 14 Jul 2023 11:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EB0961DC2;
        Fri, 14 Jul 2023 18:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3688CC433C7;
        Fri, 14 Jul 2023 18:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689359659;
        bh=WCHZqBac1jgCHUwyQJ8QVnJ2MMfqq+0zZRukAUThmGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V7+5HVNbJ+kVtknpGS3EVELMYaJkXEDkYUDOz/24CouQom4qQTS9GLJHRCSuUhv8Q
         A88iqTZdapvFE6Px0Qoe8iUwkyXx2OI8vDikvNtQfsmBXdg0RQWDsLTmYzVziHgGP/
         sTWBmPzxpMJc9RK6a8fIGsNJeflF8UJELz1lzh3usMe6fWIX5dcDIiPKzwne0s8k/A
         c8DTZN4KzG2u+ck6g/I/lXX+4kc7+gwtFTy16lP2FCBCIgwh5XQscj28lOQE13Dtvb
         i3EDdo+MO36q5ebAup9NVKZuZSCfaY4ELOWhg+AT6noUngBXfQQD6HB5NaiPBW05a3
         xA1SVc9sKB+pQ==
Date:   Fri, 14 Jul 2023 11:34:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, corbet@lwn.net,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <20230714113418.49dfac7e@kernel.org>
In-Reply-To: <a7d0381c-c99e-4dba-9156-cc07a86bdc39@sirena.org.uk>
References: <20230713223432.1501133-1-kuba@kernel.org>
        <f61a12c6-9587-9cb4-122e-dc3a74e58bd1@leemhuis.info>
        <20230714102218.687ee2ea@kernel.org>
        <a7d0381c-c99e-4dba-9156-cc07a86bdc39@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 18:59:08 +0100 Mark Brown wrote:
> > If we try to fend off anyone who doesn't understand common meaning 
> > of words the document will be very long and painful to read.  
> 
> That's true, but "bug" is one of those things where there is a frequent
> disconnect on definitions, and when coupled with the must respond bit I
> can see things going wrong.

Right, I agree the "what's a bug" arguments often happen but they
happen primarily when people are trying to get Greg to pull patches
into stable. Or when people try to fast path their "oh, so important
feature" into Linus's tree skipping -next.

The simple way to put it would be if the resulting code goes to stable
or linux/master then it was a bug.

But we can't expect from the user to know if the problem is stable
material, or even whether their problem is a bug in the first place.
Simple example - WiFi cards which don't support AP mode. User may try
to run an AP, and report it doesn't work. They may not know whether
it's HW limitation or a bug. The maintainer responding with "it's not
supported, sorry" does not seem to me to be a high bar.

Also, in my defense, I do give a rough ballpark of what we consider to
be a problem we expect to be addressed:

  ... bug reports of reasonable quality. The bug reports range from
  users reporting real life crashes, thru errors discovered in fuzzing
  to reports of issues with the code found by static analysis tools 
  and new compiler warnings.

Just in case someone thought that maintainers are their tech support.
Then again, I don't want to completely exclude technical questions which
aren't straight up crashes because some of those are reasonable, should
be answered or even result in improving docs or error reporting.

It's a balancing act :(
