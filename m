Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542EE7B6C12
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbjJCOtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjJCOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:49:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566D8AB;
        Tue,  3 Oct 2023 07:49:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FFFC433C9;
        Tue,  3 Oct 2023 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696344548;
        bh=+Ho8OQ8KZ6j0Fkyejtlca4SZ/HaEVS5nu63V95Lo0rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UMzh7wm26I2LcyNKyLn7E8AH/ScySYJlF/+3NbK5vxyPNFU95Rc2ft3ztJx4TfCi3
         JTITHfZlsgaWWp+E7ofLc22kb5lqz46HY/zVgcHQJhXgAc5A3UQn6FkIGX7k45fStM
         0CeIj8c6YGqSd+nGTc+a6RnRjVJyzXBviZaLj/sHWKx90qbK5mijPPXj3DMIxE1jTP
         fkJQ6FBOqDuyrahb5K42N+1nbSEn801FFA2ZeyfJrXv6Z+801QVpo5VIk2HbmBLQrc
         DCLV+QfJO9SiGC1weVHeeQWfQ3N12ofo2sxJgJjZOE2GxWuwcl+pdY7h5TvYfYmKY9
         SrYxhPhTjjphw==
Date:   Tue, 3 Oct 2023 10:49:06 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 6.5] ASoC: cs35l56: Call pm_runtime_dont_use_autosuspend()
Message-ID: <ZRwp4q2zEPojTgWB@sashalap>
References: <20231002125059.4091982-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231002125059.4091982-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:50:59PM +0100, Richard Fitzgerald wrote:
>commit ec03804552e9a723569e14d2512f36a8e70dc640 upstream
>
>Driver remove() must call pm_runtime_dont_use_autosuspend().
>
>Drivers that call pm_runtime_use_autosuspend() must disable
>it in driver remove(). Unfortunately until recently this was
>only mentioned in 1 line in a 900+ line document so most
>people hadn't noticed this. It has only recently been added
>to the kerneldoc of pm_runtime_use_autosuspend().
>
>Backport note: This is the same change as the upstream
>commit but the cs35l56->base.dev argument in the upstream
>code is cs35l56->dev in older releases.

Queued up, thanks!

-- 
Thanks,
Sasha
