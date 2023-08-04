Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4188D77089E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjHDTHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjHDTHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3944C02
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593616210F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 19:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B278AC433C7;
        Fri,  4 Aug 2023 19:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691176019;
        bh=0zirEVVzRvgLiu5ZMZaMlqvvUJyoQ/fRdJMPJ/KCU1E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G002A/txUg4hTe7rGhgR5SQs9YjGWs1vrOuVPZlS+CvCys1soSdOuAuJTMX2bSOeK
         lUVfIAsKjVH4Cwm+BML/1rsq7w+sNqbv0dsTAaiAR6aEzRTKg4OgbtVOJjTdoSjKMN
         6ocIYhzyChJQH7EFCJ/qnT/Ltn63ggmIwzYgP0oiiR1N82AMI4YDxhoRrck1GxCXvh
         WhOg0NG0z8wlFlQXhG69WSKJ9FaUoXa1Ae+TblzjezUr9aMwWwKoQXAtPvNe8Uin0u
         /HG3d5LR6g5B78SxF8F3qmY5KtaKMWUDovRDhfsXSOGz3mTghgFIzHngQgIOjOaEXw
         OxwY/YtQV6O3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BA43C395F3;
        Fri,  4 Aug 2023 19:06:59 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty0b5R=rfu21PD=V1dh91XMit2wzAuAcrJA0E8h2EuUng@mail.gmail.com>
References: <CAPM=9ty0b5R=rfu21PD=V1dh91XMit2wzAuAcrJA0E8h2EuUng@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty0b5R=rfu21PD=V1dh91XMit2wzAuAcrJA0E8h2EuUng@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-08-04
X-PR-Tracked-Commit-Id: 1958b0f95a35e4443573c4c3ec2efd89d2d00d82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4142fc6743d39271e712936d9fb284cd84cb6010
Message-Id: <169117601962.19359.10923133631430492175.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Aug 2023 19:06:59 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Aug 2023 15:07:56 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4142fc6743d39271e712936d9fb284cd84cb6010

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
