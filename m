Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA879B29C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbjIKVTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbjIKNyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:54:31 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD412CD7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NOZn0iX5NJmucoEApAcnEmag3C9oOJw3BJHX9r9tqr4=; b=kqniQH+QmYHSts0IHynDVr1D0j
        xoeDhzp06kyLdTcDlqc2IZu37/BipalVYyNlfdASJjdmyFHohAxO8WiNOD5w2aRISoodotAgVM9h4
        Z6M1lgGWthJIC9TRdoJD7SbG5mls/oE6uAIzchXfVJsm1kErbI49X25kMhm9IuYnNHtabuxWxnup4
        Wj4P74CGrwypsQZzn02/N9gjPqKGlb2l4Q5R7FhWtfN002HFH+m8OywIk9QivkImbz7189p+KV7go
        +R++l5sdEm6RJGDm9mqPFVf6dXfKQpbjF026MUhdBOBs9fzq3KohP2HKn5gNJhhl/q1BdIGmuD+WN
        UdLHGm4g==;
Received: from [187.10.203.89] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qfhMo-002LXI-Ic; Mon, 11 Sep 2023 15:54:18 +0200
Message-ID: <63b44028-8f80-4de6-9f17-25c9f713caba@igalia.com>
Date:   Mon, 11 Sep 2023 10:54:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Merge all debug module parameters
To:     christian.koenig@amd.com, alexander.deucher@amd.com
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
        pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>
References: <20230831152903.521404-1-andrealmeid@igalia.com>
Content-Language: en-US
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20230831152903.521404-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian, Alex, I think this series is ready to be picked as well.

Em 31/08/2023 12:29, André Almeida escreveu:
> As suggested by Christian at [0], this patchset merges all debug modules
> parameters and creates a new one for disabling soft recovery:
> 
>> Maybe we can overload the amdgpu_gpu_recovery module option with this.
>> Or even better merge all the developer module parameter into a
>> amdgpu_debug option. This way it should be pretty obvious that this
>> isn't meant to be used by someone who doesn't know how to use it.
> 
> [0] https://lore.kernel.org/dri-devel/55f69184-1aa2-55d6-4a10-1560d75c7324@amd.com/
> 
> Changelog:
> - move enum from include/amd_shared.h to amdgpu/amdgpu_drv.c
> v2: https://lore.kernel.org/lkml/20230830220808.421935-1-andrealmeid@igalia.com/
> 
> - drop old module params
> - use BIT() macros
> - replace global var with adev-> vars
> v1: https://lore.kernel.org/lkml/20230824162505.173399-1-andrealmeid@igalia.com/
> 
> André Almeida (2):
>    drm/amdgpu: Merge debug module parameters
>    drm/amdgpu: Create an option to disable soft recovery
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  5 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 63 ++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  6 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c    |  2 +-
>   8 files changed, 58 insertions(+), 26 deletions(-)
> 
