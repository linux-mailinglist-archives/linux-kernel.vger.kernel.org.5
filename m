Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8D276970A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGaNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGaNEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:04:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE590E78
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:04:23 -0700 (PDT)
Received: from [192.168.2.174] (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C40366003AC;
        Mon, 31 Jul 2023 14:04:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690808662;
        bh=zs4EmxmW2VcAgYRV4nogwdLhJIIVn/eyYKG/cygxAko=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZM3AVClBVajzg2zQqSLSCqOzAtBRRQfcz2+gYspXO0jaxYXJ7V1LJ/AwyTI8puPFl
         juUTV+FHfdrd7EBK6ptEm/eQni5TX1f/27Mi/MRtwMKMOANg5hFcseRJ1P4fNuDCgM
         IUVLhEp6HusCegRQmkU2hTmXRggSkekgxg8uBQ+oPjEHISaNILraLFMw+Ux+680vBv
         +8JpADdPcsPV9AS8KIPq2U5uJwbMwUsOtjn/GhEx4i7STJXjN4VhZ1qTyq5Xd9A+SW
         7DcizxFQvPlzAH+eR+JBELDGL3nQP6zgKTshOW+udPaSBOgTJiEVa8IAAW+vHqk+/P
         dZcVFp2OJ/6hw==
Message-ID: <0713eab4-1cb0-dbb1-fc8d-f9cbaf566a0f@collabora.com>
Date:   Mon, 31 Jul 2023 16:04:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v14 12/12] drm/gem: Add _unlocked postfix to
 drm_gem_pin/unpin()
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
 <20230722234746.205949-13-dmitry.osipenko@collabora.com>
 <20230725095303.07611834@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230725095303.07611834@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 10:53, Boris Brezillon wrote:
> On Sun, 23 Jul 2023 02:47:46 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> Make clear that drm_gem_pin/unpin() functions take reservation lock by
>> adding _unlocked postfix to the function names.
>>
>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> I'm still a bit confused by the fact we sometimes use the
> xxx[_locked]() pattern (version without the _locked suffix takes the
> lock) and other times the xxx[_unlocked]() pattern (version with the
> _unlocked suffix takes the lock). It'd be good to chose one pattern and
> stick to it, at least for all core functions...

After a more close look, agree that the _locked variant is much more
common in DRM. Alright, I'll rename the drm-gem funcs.

-- 
Best regards,
Dmitry

