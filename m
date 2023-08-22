Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A99783D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjHVKDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjHVKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:03:35 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD03A1B0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:03:32 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RVQ0J1v80z9t1h;
        Tue, 22 Aug 2023 12:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1692698608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjYJ8bmRgsu9whLXejnFW9sP9exyEiWtQpPu89Cp2vE=;
        b=PE2dLjlVed0Ct3qKsbPam7mDvu94iDnt7GJ5uhVJ2MhUeqdKNOw2GAy4/CyiE4kBNn4GGt
        SwiJoULl7oeIF3OZQHOki+pn6ZWIyNa/mDZsehWzTkPOVaHpV4x9vRVUMJKLqIUml/9tYg
        0TPkhJx1zpzx2ysSlwD23NrNq57Qw3L/bQ+aV6dipwMUUL4HAE2crrEQW7XB3HQ10lc2CU
        r0PRe8bXnNtsHdzUefeoARdtb4lsK4eAhn6eQL8Zti72+LMsN9LAOs/UTo1RpCjLb7WjUB
        3kCBnGBOxuDcMrW4z4cfASSslglYm5GoJRJMRX2nFSp9VAEkGXn3UGOubEaoPA==
Message-ID: <2a9e9d0b-3285-d9f7-be3e-37540c72df04@mailbox.org>
Date:   Tue, 22 Aug 2023 12:03:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v6 6/6] drm/doc: Define KMS atomic state set
Content-Language: de-CH-frami, en-CA
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
Cc:     pierre-eric.pelloux-prayer@amd.com,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        kernel-dev@igalia.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        joshua@froggi.es, hwentlan@amd.com, christian.koenig@amd.com
References: <20230815185710.159779-1-andrealmeid@igalia.com>
 <20230815185710.159779-7-andrealmeid@igalia.com>
 <1b23576d-1649-ff5c-6273-b54729ea46d8@mailbox.org>
 <d36ba832-3100-4a31-96a4-56e6e459b090@igalia.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <d36ba832-3100-4a31-96a4-56e6e459b090@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d4c5790f17af99201a3
X-MBO-RS-META: um1mtj8ugou78wcfbp7gir8q1cirdpif
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 22:02, André Almeida wrote:
> Em 17/08/2023 07:37, Michel Dänzer escreveu:
>> On 8/15/23 20:57, André Almeida wrote:
>>> From: Pekka Paalanen <pekka.paalanen@collabora.com>
>>>
>>> Specify how the atomic state is maintained between userspace and
>>> kernel, plus the special case for async flips.
>>>
>>> Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>
>> [...]
>>
>>> +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed to
>>> +effectively change only the FB_ID property on any planes. No-operation changes
>>> +are ignored as always. [...]
>>
>> During the hackfest in Brno, it was mentioned that a commit which re-sets the same FB_ID could actually have an effect with VRR: It could trigger scanout of the next frame before vertical blank has reached its maximum duration. Some kind of mechanism is required for this in order to allow user space to perform low frame rate compensation.
>>
> 
> I believe the documentation already addresses that sending redundant information may not lead to the desired behavior during an async flip. Do you think adding a note about using the same FB_ID would be helpful?

Maybe not.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

