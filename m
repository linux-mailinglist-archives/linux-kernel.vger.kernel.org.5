Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8643A7F7207
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345375AbjKXKs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345711AbjKXKsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:48:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DBE1B2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:48:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4192C433C7;
        Fri, 24 Nov 2023 10:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700822934;
        bh=kFNGBEV5KZVkGa0eNZHwyRy+Zdp7kSVSo5j7XiYUfFA=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=Nv8zz3+x3ChUMdQEo3BExPH42WyXDDU6UihftL7511gbsoQpDDgl3vzQh+KWKHlm2
         S7hjuLEwuJbJF4gGiqaG4GhOqbjp2PAqD7fsaxMgmI01a4QKxU6hgofrKRd8W7lnPa
         E/yqeH13d5lTUkgbY5CLmip6hd1RTrGMFb0BmNvtvUqaFO3Rbeqq5d2yLF0ElKJgEL
         d67ACiflF+1nsBPhYzSeKwVHYLcNa9LH7rYykM9BfSyMwEyw9A1yXHMIN7BTzRgzvE
         xbZnarKTGcGU2vi/hjq8vwsqj40so7FqkX20R5Vv5JacvtPJYiJr8SrBTmU8HBW2yM
         jHlO7V0FALPfw==
Message-ID: <812abc1247327534cb3e044006a54513.mripard@kernel.org>
Date:   Fri, 24 Nov 2023 10:48:51 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 10/26] drm/shmem-helper: Use refcount_t for
 vmap_use_count
In-Reply-To: <20231029230205.93277-11-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-11-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:01:49 +0300, Dmitry Osipenko wrote:
> Use refcount_t helper for vmap_use_count to make refcounting consistent
> with pages_use_count and pages_pin_count that use refcount_t. This also
> makes vmapping to benefit from the refcount_t's overflow checks.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
