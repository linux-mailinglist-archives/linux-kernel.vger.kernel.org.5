Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A97785F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbjHWSDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbjHWSDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:03:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0890AE59;
        Wed, 23 Aug 2023 11:03:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9376465113;
        Wed, 23 Aug 2023 18:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C5FC433C9;
        Wed, 23 Aug 2023 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692813810;
        bh=cLsrdluLa3UfuSk6odVJcvVGoDHlOfLYgy6k8Inaock=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pR6SyvVWfeSZvt4t3tidZtFCY5Hddij8mUCsXhVyVkVrrdzlh4RzEO6iLGs6ba2fq
         +OaYOx4a0wl1FDBByC8VK0kLuqydjUp5bE4jvUUEN9QYl4b4OW2I50sFgidaw0AWNE
         jZHDNVc06rdj1Ydo5ypA8xKOBtO9Wj+Jqn5tl5sXeRlYeaJyu/ydaybjMblmUb/U9C
         lJTbFvrcvCJhfGLLM74z/kS0w+YzMxIvvFUP95wsVG6NJnKyrinQ1HHR4io1b/5k/o
         Sy80REl/zqSP2gjFVnKO68B2TEmt3aXoQBeVANHmWk1ZkNSdFVEkoiL88pHBI1OtT9
         YT23EIt8+FJ1w==
Date:   Wed, 23 Aug 2023 14:03:28 -0400
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
Subject: Re: [PATCH AUTOSEL 6.4 09/11] drm/amdkfd: ignore crat by default
Message-ID: <ZOZJ8LmPgd5PqQgf@sashalap>
References: <20230822113553.3551206-1-sashal@kernel.org>
 <20230822113553.3551206-9-sashal@kernel.org>
 <BN9PR12MB5146FBE3E3940F3AB59EA79DF71FA@BN9PR12MB5146.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <BN9PR12MB5146FBE3E3940F3AB59EA79DF71FA@BN9PR12MB5146.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 03:41:17PM +0000, Deucher, Alexander wrote:
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
>> Subject: [PATCH AUTOSEL 6.4 09/11] drm/amdkfd: ignore crat by default
>>
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> [ Upstream commit a6dea2d64ff92851e68cd4e20a35f6534286e016 ]
>>
>> We are dropping the IOMMUv2 path, so no need to enable this.
>> It's often buggy on consumer platforms anyway.
>>
>
>This is not needed for stable.

I'll drop all the patches you've pointed out, thanks!

-- 
Thanks,
Sasha
