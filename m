Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F007A88EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbjITPuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbjITPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:50:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E9EC6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60420C433CB;
        Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695225025;
        bh=IxzmerP4BfIbNeGXSbfo0n4u8HnDaD9IUMu+iAYXuIg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sz5GrnPfBp0fLWnSNvpMt3socVfsC8nB4k9rJwL762H1B4B6T7j4bky/6JUlYKTJy
         iepj/xhEC634uOf6XxKuIn2ooBuUmdmodAmw0AQJX17jgmm+LRZVojcwn8xsH94CSZ
         Z0mIHmBxlg+8Eb+zMT6J7UMO/QlF3F+1Z4uFk7Qdakj4nh6/it+TtfwiV9DnbtQvkB
         7U5NCPD22pb9yY4GSwwv5SzdNN5NZ+QSBBf45rX+IRtBWD7f7qoTp2NKzzGaNYBoRf
         EkqvIHf/S2AHCDmhDkpVWmxvYuaIZtfnhuNoJwlgkKDQD84ItokRbQLFpqM+XO1ZMP
         /Sws3Peg3ptOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38783C43170;
        Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix to avoid fragment w/ OPU
 during f2fs_ioc_compress_file()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169522502522.22557.4305670746484363117.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Sep 2023 15:50:25 +0000
References: <20230904151242.1786219-1-chao@kernel.org>
In-Reply-To: <20230904151242.1786219-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  4 Sep 2023 23:12:42 +0800 you wrote:
> If file has both cold and compress flag, during f2fs_ioc_compress_file(),
> f2fs will trigger IPU for non-compress cluster and OPU for compress
> cluster, so that, data of the file may be fragmented.
> 
> Fix it by always triggering OPU for IOs from user mode compression.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: compress: fix to avoid fragment w/ OPU during f2fs_ioc_compress_file()
    https://git.kernel.org/jaegeuk/f2fs/c/943f7c6f987f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


