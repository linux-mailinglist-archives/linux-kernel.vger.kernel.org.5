Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7159375E432
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 20:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjGWSov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 14:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGWSos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 14:44:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4732EE40;
        Sun, 23 Jul 2023 11:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E9E60E00;
        Sun, 23 Jul 2023 18:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41AE5C433C8;
        Sun, 23 Jul 2023 18:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690137887;
        bh=dExd8VX+UcH8v9pAQXjfs/OHsaj6FriVpVkrXkBM0XA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T3ertNvOFUFC743xYziYzBV0KQFymLOL1O6y3IO0Q+rGA8fQIsjV7LeBFbbBWQLx9
         3hxRXQn8ePSQgLcDLXzxOlq37NMIzXew94zvg6S2XCcr1e4bl7jRQLNLmaRsZzxgnH
         x5xTxrZanzmKXDpjCSRxfTAJ+NWGukZBwL2LzUsnqzsOPamecNdXTyahoxTEONso0Q
         tHnTxTIImYtAAZO1EUprZ/4t8zWzBbXa3e2f3d8Y6aFfWNJWkL3Bg6J3AseQkVUeoK
         T4yXjKReK7mDRCaSSjrKa85iC7yWT/VU2oPOnqf1yRVZdEhz2SBjf57ZAeN19HEaVN
         MJ+X4U1UysTJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31230C595C1;
        Sun, 23 Jul 2023 18:44:47 +0000 (UTC)
Subject: Re: Re: [GIT PULL] smb3 client minor debugging fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mv2V8SDi=qDDwsnoeXSLxqLXHH7FESEz736scrfU+w=MQ@mail.gmail.com>
References: <CAH2r5msCqEDv1mUMMVTg8t7K+CO82Ha_xQoYJ-FkQ9h83By5wA@mail.gmail.com>
 <CAHk-=whTnOWaYxG2sU8ikFZsowUPApWgHxf0jM77ELUb39SuAw@mail.gmail.com> <CAH2r5mv2V8SDi=qDDwsnoeXSLxqLXHH7FESEz736scrfU+w=MQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mv2V8SDi=qDDwsnoeXSLxqLXHH7FESEz736scrfU+w=MQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc2-smb3-client-fixes-ver2
X-PR-Tracked-Commit-Id: ba61a03af29a5f305cb301eb83b42578474508f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8266f53b39087c195f0d011dc5696cb2e6155242
Message-Id: <169013788719.27296.3358286910928653186.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Jul 2023 18:44:47 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Jul 2023 14:56:46 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc2-smb3-client-fixes-ver2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8266f53b39087c195f0d011dc5696cb2e6155242

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
