Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9FB790F60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 02:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349864AbjIDAgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 20:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjIDAgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 20:36:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9438FD;
        Sun,  3 Sep 2023 17:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 713F3B80D3C;
        Mon,  4 Sep 2023 00:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A3EC433CA;
        Mon,  4 Sep 2023 00:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693787764;
        bh=l/ZbviUAxVSkzWPyEeIQ9Fs+OkgtA7pgZqstVlvtbQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=evXDeLHRwiT4KgwYnIN2i5lcQIUcFDaUGlfkVPVf+PtZYoGITJ2Volm+tErbbpK10
         WweMowunRx81+JswUwcqQPA2jAYr7jslTPKkKcB2FY2S1LoKBKPXt37SUJlJKqmav7
         Qy+lNtKGClbdkFVJY+9yTY37Tkcuz0OXraOVJPZgPNnve6ho6odmEnZpcwfzC6NTmT
         TG0DJwCDaAxg+wdhgo2Lw16ebN2y8yLvX8LX96X9Tv9efh/aETy2PHWjexn3bxf/qW
         y3Xm82oFazw2fFIyrY50SeGEYi28Z0JvwQHN3n4SMpTDS6fPHZJEmYGtsGmsazWoqN
         6NSxAcr9wl+rg==
Date:   Sun, 3 Sep 2023 20:36:02 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH AUTOSEL 6.1 08/10] drm/amdkfd: ignore crat by default
Message-ID: <ZPUmcjPuyUj2qqN+@sashalap>
References: <20230822113628.3551393-1-sashal@kernel.org>
 <20230822113628.3551393-8-sashal@kernel.org>
 <BN9PR12MB5146E3C94A2A6CB87138B2BCF71FA@BN9PR12MB5146.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <BN9PR12MB5146E3C94A2A6CB87138B2BCF71FA@BN9PR12MB5146.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 03:41:18PM +0000, Deucher, Alexander wrote:
>[Public]
>
>> -----Original Message-----
>> From: Sasha Levin <sashal@kernel.org>
>> Sent: Tuesday, August 22, 2023 7:36 AM
>> To: linux-kernel@vger.kernel.org; stable@vger.kernel.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
>> Mike Lothian <mike@fireburn.co.uk>; Sasha Levin <sashal@kernel.org>; Pan,
>> Xinhui <Xinhui.Pan@amd.com>; airlied@gmail.com; daniel@ffwll.ch; amd-
>> gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
>> Subject: [PATCH AUTOSEL 6.1 08/10] drm/amdkfd: ignore crat by default
>>
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> [ Upstream commit a6dea2d64ff92851e68cd4e20a35f6534286e016 ]
>>
>> We are dropping the IOMMUv2 path, so no need to enable this.
>> It's often buggy on consumer platforms anyway.
>
>
>This is not needed for stable.

Dropped this and the other ones you've pointed out, thanks!

-- 
Thanks,
Sasha
