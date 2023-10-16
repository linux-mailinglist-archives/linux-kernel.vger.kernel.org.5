Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B547CA608
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJPKwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJPKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:52:53 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAE495
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EhiJa9EH24JyhTMQDgYLXmR2kDM/RJaPhmujtJdfRWM=; b=kHEUSKMnLFS7Zi/BPAGf45+91e
        w9Xa6Zk1dl3NckTqMNoMtflp+51PMfUj9WFG3UlUZph7XwLcU70mFcCKm7ouvPcFKaFyUXXqH9A/5
        zU3mEKjYBb5wzkrBOIKFqjpQXwZSlZToC0PJqLRmdV/g2pBV0Xo6u8sDq4Itb2i4reGNF0ce/AK6C
        /hvFi57OKTCUIkWZ28pquvLGChkE71p1RRbu36ms1uRaB2JQFCj6ySyKS8QLYSby0I+MYQmvsnkFd
        xj9Bz7NwIAioKhyt03GAgqENty2EsZ8uqjZtE4Gsl0mS/d+Iq8FqT7NsE6x5rw+h638We9KdVivGo
        Wm/eD2nw==;
Received: from [192.168.12.174]
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qsLD7-0011nd-Cj; Mon, 16 Oct 2023 12:52:33 +0200
Message-ID: <b48bd1fc-fcb0-481b-8413-9210d44d709b@igalia.com>
Date:   Mon, 16 Oct 2023 12:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/doc: Define KMS atomic state set
Content-Language: en-US
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        xaver.hugl@gmail.com
Cc:     pierre-eric.pelloux-prayer@amd.com,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, hwentlan@amd.com,
        Rob Clark <robdclark@gmail.com>, ville.syrjala@linux.intel.com,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com,
        joshua@froggi.es, wayland-devel@lists.freedesktop.org
References: <20230815185710.159779-1-andrealmeid@igalia.com>
 <20230815185710.159779-7-andrealmeid@igalia.com>
 <1b23576d-1649-ff5c-6273-b54729ea46d8@mailbox.org>
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <1b23576d-1649-ff5c-6273-b54729ea46d8@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On 8/17/23 12:37, Michel Dänzer wrote:
> On 8/15/23 20:57, André Almeida wrote:
>> From: Pekka Paalanen <pekka.paalanen@collabora.com>
>>
>> Specify how the atomic state is maintained between userspace and
>> kernel, plus the special case for async flips.
>>
>> Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> [...]
>
>> +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed to
>> +effectively change only the FB_ID property on any planes. No-operation changes
>> +are ignored as always. [...]
> During the hackfest in Brno, it was mentioned that a commit which re-sets the same FB_ID could actually have an effect with VRR: It could trigger scanout of the next frame before vertical blank has reached its maximum duration. Some kind of mechanism is required for this in order to allow user space to perform low frame rate compensation.
>
Xaver tested this hypothesis in a flipping the same fb in a VRR monitor 
and it worked as expected, so this shouldn't be a concern.

Thanks,
     André


