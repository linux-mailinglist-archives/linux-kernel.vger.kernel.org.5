Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F1778E56A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbjHaEaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344749AbjHaEaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:30:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ED2A1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6BD662025
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B35AC433C9;
        Thu, 31 Aug 2023 04:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693456209;
        bh=Uezw268IlI2ncqkg6nwncMxImF/dZgC6hLzyvH2pNgA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BB+J+/Hq67oYbtMsbGxKsD4bbdYhsLeA0lKdFV6KMvW+2WZReP7O5+eGxvyS7ZnVK
         wvzUMbzPym4/lkiNZpjT3GirLGTcWv3XG28ZXfkAKF/+Ptg/sFSX5zp9PVN5jGXNg4
         z+n0X8xux3RF496aeOz6hetVZxvATnoNKcjIqon4sKL7jferaGZUTEUpT3qS9Iwfe8
         Yw4OzF6X4tq1fox0C1RCuvSv+S+i4h/wO7sW8/kILRBbeXSARv9+qRl7k4OcGtOAW6
         WfvG5Xluw8UK86SPnRVdwzBSPjLOYkvf2UrTBlPsu37ZDA5j++9yzW1rhkal0OIKDJ
         lwyC5JgAC+j6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47399E270FB;
        Thu, 31 Aug 2023 04:30:09 +0000 (UTC)
Subject: Re: [GIT PULL] NVDIMM and DAX for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <12c76f8e-aae8-2cab-4ab0-571a8c806423@intel.com>
References: <12c76f8e-aae8-2cab-4ab0-571a8c806423@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <12c76f8e-aae8-2cab-4ab0-571a8c806423@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.6
X-PR-Tracked-Commit-Id: 08ca6906a4b7e48f8e93b7c1f49a742a415be6d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47d154eb2ac4e508555937207031ba062119e371
Message-Id: <169345620926.29893.16589404508854183628.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 04:30:09 +0000
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     torvalds@linux-foundation.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, Ira Weiny <ira.weiny@intel.com>,
        nvdimm@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 10:07:56 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47d154eb2ac4e508555937207031ba062119e371

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
