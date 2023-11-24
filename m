Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADECF7F71C5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345617AbjKXKlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345395AbjKXKlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:41:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB771A8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:41:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80675C433C8;
        Fri, 24 Nov 2023 10:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700822486;
        bh=mx8zbhH9XuRFKow8SMM4vIllq541PDHZLX4FbTHewh0=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=qqxW+0tALhs6DPa50m/V0TDQBDRvKe6AVAWJNKYhn3V8Pyho0tFULZ7QAjdBeRiZs
         z4IodWvCbcDaqeIplw2I2Xc2q8vxPJthU8sMsFBRxH84qNOAAcVKkvX+7I+Jf8Ayhk
         xQgh62ZjZ6Pu++q35Yb86wsxRDAHjNS/zPkcvoe64CKbbrntFpNE8JAD2Dyi5zt8zc
         7p6INUCsxodERYJmS0t19p1m4z+XuNfeLutyVZAdO6sd+LhZ149p0PauBQOORB2tNT
         B+99y/nbY4HyeN/CCRge+Hye2knoWDH8DTYY/DzC9J6G3gMVGVWo54JR8EPhmC80tf
         YnE554xIeHfCA==
Message-ID: <5ebb290e629a83f12525c2ddf0ca2082.mripard@kernel.org>
Date:   Fri, 24 Nov 2023 10:41:24 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 07/26] drm/shmem-helper: Use refcount_t for
 pages_use_count
In-Reply-To: <20231029230205.93277-8-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-8-dmitry.osipenko@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Boris Brezillon" <boris.brezillon@collabora.com>,
        "Chia-I Wu" <olvaffe@gmail.com>,
        =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@gmail.com>,
        "Emma Anholt" <emma@anholt.net>,
        "Gerd Hoffmann" <kraxel@redhat.com>,
        "Gurchetan Singh" <gurchetansingh@chromium.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Melissa Wen" <mwen@igalia.com>, "Qiang Yu" <yuq825@gmail.com>,
        "Steven Price" <steven.price@arm.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 02:01:46 +0300, Dmitry Osipenko wrote:
> Use atomic refcount_t helper for pages_use_count to optimize pin/unpin
> functions by skipping reservation locking while GEM's pin refcount > 1.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
