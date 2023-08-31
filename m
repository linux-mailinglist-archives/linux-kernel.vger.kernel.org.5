Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3367778EF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344824AbjHaOCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344764AbjHaOCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:02:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53070CF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:02:35 -0700 (PDT)
Received: from [192.168.68.123] (unknown [177.134.102.128])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 242B066072A3;
        Thu, 31 Aug 2023 15:02:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693490553;
        bh=fdO6arFEzTYnGlM+QX5TsE8ARcapWX+TioKV3VJD1xc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EkGzYmC43KDEqfPYzVZxL8vlKX0CRGieqzzt+wX9fUjG96YXNhsIAww9Jj4zmKOUd
         BO1pfZNeqBoErLAZaBaOKjtZypa2vYjZXhKqbsYPeCT6Co6QMD+fks6yqUt5BvjV2f
         PGg1aQO25i1RuZwbBJrhQf5YtmA21wh6HRqi93doPcMHG44N9WQJEX9zPhU8s3EIk0
         T/e43yBjiE8xuXOyooMtouFNcdeSxhVBb332UL6AJK1FEk9rw3gMTnWbj3W/93LOLI
         Q2SCcMpxAqMi+V08GZzN6WAJPQMYuqEo0ONHx+1Gudhg1vsm+tQo8b9BGISubwXl92
         7xi35t8L/mldg==
Message-ID: <37e21200-f294-2768-ed2e-cdadfc6d17fc@collabora.com>
Date:   Thu, 31 Aug 2023 11:02:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/2] Merge all debug module parameters
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com
References: <20230830220808.421935-1-andrealmeid@igalia.com>
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20230830220808.421935-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi André,

Thanks for your patches.

On 30/08/2023 19:08, André Almeida wrote:
> As suggested by Christian at [0], this patchset merges all debug modules
> parameters and creates a new one for disabling soft recovery:
> 
>> Maybe we can overload the amdgpu_gpu_recovery module option with this.
>> Or even better merge all the developer module parameter into a
>> amdgpu_debug option. This way it should be pretty obvious that this
>> isn't meant to be used by someone who doesn't know how to use it.
> 
> [0] https://lore.kernel.org/dri-devel/55f69184-1aa2-55d6-4a10-1560d75c7324@amd.com/


Would you mind to test your patchset with drm-ci ? There is an amdgpu 
test there and I would love to get your feedback of the ci.

You basically just need to apply the ci patch which is available on
https://cgit.freedesktop.org/drm/drm/commit/?h=topic/drm-ci&id=0119c894ab0dc468bcb03f28063239c0a4cf970f

There are instruction on the docs, but in short: to configure it, you 
push your branch to gitlab.freedesktop.org, go to the settings and 
change the CI/CD configuration file from .gitlab-ci.yml to
drivers/gpu/drm/ci/gitlab-ci.yml, and you can trigger a pipeline on your 
branch to get tests running.


Thank you!
Helen


> 
> Changelog:
> - drop old module params
> - use BIT() macros
> - replace global var with adev-> vars
> v1: https://lore.kernel.org/lkml/20230824162505.173399-1-andrealmeid@igalia.com/
> 
> André Almeida (2):
>    drm/amdgpu: Merge debug module parameters
>    drm/amdgpu: Create an option to disable soft recovery
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  5 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 54 +++++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  6 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c    |  2 +-
>   drivers/gpu/drm/amd/include/amd_shared.h |  9 ++++
>   9 files changed, 58 insertions(+), 26 deletions(-)
> 
