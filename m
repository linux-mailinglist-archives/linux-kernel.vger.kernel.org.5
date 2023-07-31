Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D6D7689C2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjGaCBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGaCBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:01:15 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE2FD7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=moHci8shG8kLdpyJfiqGNs2yvu+A/oWWcGTVvGHpmA4=; b=nQIpReVUxiINcewGH84N2iwpId
        r46e73TugbymzBRbIHjbc9MqR5HIlvzTnhTx0PH/sbA/5lHnTer0SCRRwvziEJbxLWIRA1umtak3S
        XYq5KRKWy3shNO6WTjhX1HlUUI4uFiFm1y5XskQDSQ/sqr9tpafvQ/PN7/YjZEDGg60Red+TuYDeU
        vjQHqgZcOwtc6rgdXcGmdNCawpyfknlu7SEhHfAV22oRgVSVv3cI7RwjJSjttq3T5S5co4tBJU/vV
        V2l9blN27TZ69ONHgKyU2H+tRMj9IfptbcVrjqqOymyALNSOrYUlAz+j+O17Hd1YQK4DpqCEsQEdE
        A6LyywVw==;
Received: from [191.193.131.122] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qQIDW-0072kP-Cy; Mon, 31 Jul 2023 04:01:02 +0200
Message-ID: <35a8e502-c36c-e67e-29ba-a20ae6134c6d@igalia.com>
Date:   Sun, 30 Jul 2023 23:00:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: Re: [PATCH v5 6/6] drm/doc: Define KMS atomic state set
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wayland-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com
References: <20230707224059.305474-1-andrealmeid@igalia.com>
 <20230707224059.305474-7-andrealmeid@igalia.com>
 <ZK0ZlciR66oTO+Td@phenom.ffwll.local> <20230713105142.122a0cc1@eldfell>
Content-Language: en-US
In-Reply-To: <20230713105142.122a0cc1@eldfell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em 13/07/2023 04:51, Pekka Paalanen escreveu:
> On Tue, 11 Jul 2023 10:57:57 +0200
> Daniel Vetter <daniel@ffwll.ch> wrote:
> 
>> On Fri, Jul 07, 2023 at 07:40:59PM -0300, André Almeida wrote:
>>> From: Pekka Paalanen <pekka.paalanen@collabora.com>
>>>
>>> Specify how the atomic state is maintained between userspace and
>>> kernel, plus the special case for async flips.
>>>
>>> Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>> ---
>>> v4: total rework by Pekka
>>> ---
>>>   Documentation/gpu/drm-uapi.rst | 41 ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 41 insertions(+)
>>>
>>> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
>>> index 65fb3036a580..6a1662c08901 100644
>>> --- a/Documentation/gpu/drm-uapi.rst
>>> +++ b/Documentation/gpu/drm-uapi.rst
>>> @@ -486,3 +486,44 @@ and the CRTC index is its position in this array.
>>>   
>>>   .. kernel-doc:: include/uapi/drm/drm_mode.h
>>>      :internal:
>>> +
>>> +KMS atomic state
>>> +================
>>> +
>>> +An atomic commit can change multiple KMS properties in an atomic fashion,
>>> +without ever applying intermediate or partial state changes.  Either the whole
>>> +commit succeeds or fails, and it will never be applied partially. This is the
>>> +fundamental improvement of the atomic API over the older non-atomic API which is
>>> +referred to as the "legacy API".  Applying intermediate state could unexpectedly
>>> +fail, cause visible glitches, or delay reaching the final state.
>>> +
>>> +An atomic commit can be flagged with DRM_MODE_ATOMIC_TEST_ONLY, which means the
>>> +complete state change is validated but not applied.  Userspace should use this
>>> +flag to validate any state change before asking to apply it. If validation fails
>>> +for any reason, userspace should attempt to fall back to another, perhaps
>>> +simpler, final state.  This allows userspace to probe for various configurations
>>> +without causing visible glitches on screen and without the need to undo a
>>> +probing change.
>>> +
>>> +The changes recorded in an atomic commit apply on top the current KMS state in
>>> +the kernel. Hence, the complete new KMS state is the complete old KMS state with
>>> +the committed property settings done on top. The kernel will automatically avoid
>>> +no-operation changes, so it is safe and even expected for userspace to send
>>> +redundant property settings.  No-operation changes do not count towards actually
>>> +needed changes, e.g.  setting MODE_ID to a different blob with identical
>>> +contents as the current KMS state shall not be a modeset on its own.
>>
>> Small clarification: The kernel indeed tries very hard to make redundant
>> changes a no-op, and I think we should consider any issues here bugs. But
>> it still has to check, which means it needs to acquire the right locks and
>> put in the right (cross-crtc) synchronization points, and due to
>> implmentation challenges it's very hard to try to avoid that in all cases.
>> So adding redundant changes especially across crtc (and their connected
>> planes/connectors) might result in some oversynchronization issues, and
>> userspace should therefore avoid them if feasible.
>>
>> With some sentences added to clarify this:
>>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> After talking on IRC yesterday, we realized that the no-op rule is
> nowhere near as generic as I have believed. Roughly:
> https://oftc.irclog.whitequark.org/dri-devel/2023-07-12#1689152446-1689157291;
> 
> 

How about:

The changes recorded in an atomic commit apply on top the current KMS 
state in the kernel. Hence, the complete new KMS state is the complete 
old KMS state with the committed property settings done on top. The 
kernel will try to avoid no-operation changes, so it is safe for 
userspace to send redundant property settings. However, the kernel can 
not assure that every redundant information will always result in a 
no-op, giving the need to take locks to check par of the state. Giving 
that, some redundant information can lead to a full damage path. This is 
not something bad by itself, but userspace need to be aware of that side 
effect.

> Thanks,
> pq
> 
>>> +
>>> +A "modeset" is a change in KMS state that might enable, disable, or temporarily
>>> +disrupt the emitted video signal, possibly causing visible glitches on screen. A
>>> +modeset may also take considerably more time to complete than other kinds of
>>> +changes, and the video sink might also need time to adapt to the new signal
>>> +properties. Therefore a modeset must be explicitly allowed with the flag
>>> +DRM_MODE_ATOMIC_ALLOW_MODESET.  This in combination with
>>> +DRM_MODE_ATOMIC_TEST_ONLY allows userspace to determine if a state change is
>>> +likely to cause visible disruption on screen and avoid such changes when end
>>> +users do not expect them.
>>> +
>>> +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed to
>>> +effectively change only the FB_ID property on any planes. No-operation changes
>>> +are ignored as always. Changing any other property will cause the commit to be
>>> +rejected.
>>> -- 
>>> 2.41.0
>>>    
>>
> 
