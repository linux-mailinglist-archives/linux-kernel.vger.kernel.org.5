Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D6978322E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 22:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjHUUCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjHUUCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:02:46 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC2F11C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rkMx3QCdkHsHd4DpWtJVECdQPGcyggajnYUXBpzw15w=; b=EADq7rmE7GqaIGEfqJn7DfTL3f
        iUjUJxP8Z7CSXigjq1oBS+lwDFwrd9pB8nLZ0Zd3NomDntKyrh6JK4n6CQ0H9E2kQ8JWFqqNCIfoi
        eGKuHptuFiQFRX9LF7zoq5Y0RDMqBuYiUPRFqkq1vn5sqRUx2MAYqLAiqKPwEKeJIIp4FBXQ99219
        ZTUvafOEKXg0/qQJrFvCQdQqKTKx0sVsQMtfhGupKHTwzMO9o3SukOrG7Y8rymsrWKdtwIL+vI6dB
        Nf5x9UYvna/0pmr6EpwUPHBhJSJs/51aCCC86e/yVptlesZGhKHfjYnh8HRHdsp+JSNt/4D7OxDdC
        9OsMhXtg==;
Received: from [187.35.42.59] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qYB6X-00DrMF-0V; Mon, 21 Aug 2023 22:02:25 +0200
Message-ID: <d36ba832-3100-4a31-96a4-56e6e459b090@igalia.com>
Date:   Mon, 21 Aug 2023 17:02:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/doc: Define KMS atomic state set
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc:     pierre-eric.pelloux-prayer@amd.com, amd-gfx@lists.freedesktop.org,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Daniel Stone <daniel@fooishbar.org>, hwentlan@amd.com,
        Rob Clark <robdclark@gmail.com>,
        wayland-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com,
        joshua@froggi.es
References: <20230815185710.159779-1-andrealmeid@igalia.com>
 <20230815185710.159779-7-andrealmeid@igalia.com>
 <1b23576d-1649-ff5c-6273-b54729ea46d8@mailbox.org>
Content-Language: en-US
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

Em 17/08/2023 07:37, Michel Dänzer escreveu:
> On 8/15/23 20:57, André Almeida wrote:
>> From: Pekka Paalanen <pekka.paalanen@collabora.com>
>>
>> Specify how the atomic state is maintained between userspace and
>> kernel, plus the special case for async flips.
>>
>> Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> 
> [...]
> 
>> +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed to
>> +effectively change only the FB_ID property on any planes. No-operation changes
>> +are ignored as always. [...]
> 
> During the hackfest in Brno, it was mentioned that a commit which re-sets the same FB_ID could actually have an effect with VRR: It could trigger scanout of the next frame before vertical blank has reached its maximum duration. Some kind of mechanism is required for this in order to allow user space to perform low frame rate compensation.
> 

I believe the documentation already addresses that sending redundant 
information may not lead to the desired behavior during an async flip. 
Do you think adding a note about using the same FB_ID would be helpful?
