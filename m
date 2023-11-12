Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F18D7E9225
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjKLSvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKLSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:51:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57341FE5;
        Sun, 12 Nov 2023 10:51:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35018C433C8;
        Sun, 12 Nov 2023 18:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699815106;
        bh=7V7AfIKqaTCD6m2lsmbg52UA7J/T4Eb6G/9aTJ+EDlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnN+Anc7K9m4jgChYzwebKq17e4JzFGV7xmKvAH4blQEQ3Y61Yc1e0iP7MoJHqdhm
         IuG9hXhtSC/wSHts98yNgLT7fSQyNJjujIQyVGUKKYXVS96XIDweNeSqAf9M20iJe/
         zxRSOmmoGznY0Tn3rBQCwVTeJklGF7NEwSP3k2/SapxQDbHX2dW4UEUpWwCFi18ghx
         WaitH1pGjKyfLdbYRtycne5fQCp6df3bh9xoZC/4xINF1NW94GbsGFdHJA13f9ZJ0n
         5zXTPqxRakp3zZoVQ24ZMF3kOrD+4s/Ix8diS4XFVScdjAYrWtWHVFo2/UyI9ocAeZ
         rfsRJ+xjZA2DA==
Date:   Sun, 12 Nov 2023 13:51:44 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH AUTOSEL 6.6 09/11] drm/amd: Fix UBSAN
 array-index-out-of-bounds for Powerplay headers
Message-ID: <ZVEewK-GAnRsrPA3@sashalap>
References: <20231112132736.175494-1-sashal@kernel.org>
 <20231112132736.175494-9-sashal@kernel.org>
 <CADnq5_OyK=rDH38Q8Kiyq9BhWuihgd8wX7XKAffxwkO4w+ksog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_OyK=rDH38Q8Kiyq9BhWuihgd8wX7XKAffxwkO4w+ksog@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 01:00:37PM -0500, Alex Deucher wrote:
>On Sun, Nov 12, 2023 at 8:27 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> [ Upstream commit 49afe91370b86566857a3c2c39612cf098110885 ]
>>
>> For pptable structs that use flexible array sizes, use flexible arrays.
>>
>> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2039926
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Acked-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>I don't think any of these UBSAN flexible array changes are stable material.

I'll drop it, but in general we've been taking kasan/ubsan/kcsan/...
annotation fixes since it enables (easier) testing on the LTS trees, and
for example finding issues specific to those LTS trees.
-- 
Thanks,
Sasha
