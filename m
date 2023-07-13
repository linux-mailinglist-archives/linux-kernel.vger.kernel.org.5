Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECDE752C50
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjGMVlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjGMVlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:41:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1C62691;
        Thu, 13 Jul 2023 14:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 712C761B7C;
        Thu, 13 Jul 2023 21:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D577BC433CA;
        Thu, 13 Jul 2023 21:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689284489;
        bh=jpkwRfIuO/p7CmmiIptnPZpuPwnt1xMdErD42scVioE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PnHV7FfGf0Q7aK6dC/VdAQbmGh446IrCj0LlIA6f5iqR0ArZiDKxMpW4W07F1TSL1
         /5uqwLqWzCr7i+F7S6OlQEDNCZq2SrQliofa9Yh5AbYQyPhEME/l+5hQtqY7EXvMMH
         shGEPki2RW04M4S4e22AyzWpSo105IPIVQ7DL2IzJNEtHOjkivDtFWUQ2jVLLG7fF+
         BX1O2s6TzUsB++dWQAPpNdgO5uw6erQbCe7Rxbe4YCcHTIGBT5L4AB0jAPskhVk3o5
         lNGE98F9rKlieHtYh+lWOZd1vyZFI3Jlos3k/2+83eIq0KK/7/8CjmpllQkyBzRZ0/
         ela6nozmqMB3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C309CE29F46;
        Thu, 13 Jul 2023 21:41:29 +0000 (UTC)
Subject: Re: [GIT PULL] sh fixes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <90e6042f3a82d5e9b4cf475603dcb73ca5e821d8.camel@physik.fu-berlin.de>
References: <90e6042f3a82d5e9b4cf475603dcb73ca5e821d8.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <90e6042f3a82d5e9b4cf475603dcb73ca5e821d8.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.5-tag2
X-PR-Tracked-Commit-Id: 7c28a35e19fafa1d3b367bcd3ec4021427a9397b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9350cd0190c0d60915ec704112c864d858a0d31c
Message-Id: <168928448979.12038.351367698931546359.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jul 2023 21:41:29 +0000
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Jul 2023 09:25:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.5-tag2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9350cd0190c0d60915ec704112c864d858a0d31c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
