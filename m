Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558DD781372
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379660AbjHRTkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379661AbjHRTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F25E3C3F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE52262F6F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 19:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B28C433C7;
        Fri, 18 Aug 2023 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692387606;
        bh=ieteLVsMIxcVRNFh/sMw6Ea6C+wGGEv0a1ea4Trb7PQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CYQ23CHDBXJC5EeJMBSm7MiNIsS/n5m5yNh2T8se0kb5bFpGoyfGoBgJLkOrvO+CM
         t+UYY/PLl3El4LdJE4f2BXb8Gx6YTz0nZW8V9ARjqMAsuMlBrMDwcswUJCK/f2lBLQ
         FS0w+c0nu3DKhWbSo/3SMQC5WuAMyiDE75OQIZEzEwZsZfrFpaJ2HPSb/yGqg294Fj
         ERbphVDYQkOL8pTH2gR9yux12mWKHf/HBRp03XDkKp3e4zXEQV2eaDg+LQHTZnk9o7
         PSUNJ40XRf6h4LJ5thSTl2zmHkh4iLGX8C4d96XtcNkKtZCSGw0G6ZUfu2KX9mZnQ+
         5YQxjRNusraug==
Date:   Fri, 18 Aug 2023 12:40:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v6.5-rc7
Message-ID: <20230818124005.20d90a33@kernel.org>
In-Reply-To: <CAHk-=wi-DdiZu-zMfE3X5nx4i5farupHmJawz-My_Z2nk9Qkow@mail.gmail.com>
References: <20230817221129.1014945-1-kuba@kernel.org>
        <CAHk-=wi-DdiZu-zMfE3X5nx4i5farupHmJawz-My_Z2nk9Qkow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 06:58:49 +0200 Linus Torvalds wrote:
> > Fixes to fixes:  
> 
> Heh. New header for an old problem ...

Yeah.. Almost all the "current" fixes are just follow ups to the fixes
we sent after -rc1, I wanted to highlight that somehow. Highlight that
it doesn't feel like we're fixing problems which came in via -next any
more.
