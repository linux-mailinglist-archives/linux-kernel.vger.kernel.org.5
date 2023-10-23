Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AAA7D3AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjJWPav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjJWPa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1CDBC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49DD3C433A9;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075025;
        bh=iCTBRr0dsiu33PXdRb3tJpIwc6vYGqE99DbJgnFKsiA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VIbm6w5oJQX5F0hlXID2dAkdV5UTAtYPxJdIjCJr1dXzn5BxNHV/Hi1nU4Iidhxgh
         XSIn5fSBRE9FkEAWfR98DUU4NRxz61V9odzGTMPtumPIG28XJhod7KXsYJhdW+Gvl9
         e1jAO2AoXB0GGBfkixq/S7m0q5IV+gc2vU9NQVOHVxer/xbsSGqS524wllIbYtwzi9
         zys+tkOPEhGeVULNMLfmtY6VmKgEh8/OAN6kZoO3T9fBYC49u9FpiB3VNJ1xfK7mJH
         3k/hi2lKl0/fyFqMazkt2J8ghsK3XePnvSIBHtlVyHJ6IpSalVvYdcA6934bk2dPm9
         Y5Nahwr7ZIzAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26312C595CE;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: finish previous checkpoints before
 returning from remount
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169807502515.26537.16625521816473138159.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 15:30:25 +0000
References: <20231020163645.2852056-1-daeho43@gmail.com>
In-Reply-To: <20231020163645.2852056-1-daeho43@gmail.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        daehojeong@google.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 20 Oct 2023 09:36:45 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Flush remaining checkpoint requests at the end of remount, since a new
> checkpoint would be triggered while remount and we need to take care of
> it before returning from remount, in order to avoid the below race
> condition.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: finish previous checkpoints before returning from remount
    https://git.kernel.org/jaegeuk/f2fs/c/1e7bef5f90ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


