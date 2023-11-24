Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A537F71BF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbjKXKlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345395AbjKXKlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:41:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236BE91
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:41:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DADEC433C8;
        Fri, 24 Nov 2023 10:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700822468;
        bh=B9wGFKlvp/YZEopRaAvdU1A2HubEm3DJLIXAlfjLLZA=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=L69sDpmu9gMgz1zrB8/1oyyUf/W8N4ry1cjMHW049czR5sJm4eG5fugpYRBBKZuv4
         W88Pn8p+EOJyPbq8U3moFuVR220+C6w/WiP+epLu7J+0iNf7PDI0lwF2DcW3NIw39D
         oSuL+Rnu1jyCxKR9e8SbLyIpSdpje4k2huqZftU98Q51+pi9Y4JzU/DSGgcPO+RS0J
         oV+SH4b3cmrABZlj9GcxMMSueE17XDXq0dpYHnUQdXAXR3l2CjBuGCwc5DUEm2Arh1
         jc8FmE9NPKOLuuCHWVN5ectENAGY+uVpxn2/AWtRT/wbYAGkOC1qb4Wny7CPDFF+TH
         lHPyI9A+eZ8wA==
Message-ID: <5b594d30e08b4acaf7aaf9b7a4419d2a.mripard@kernel.org>
Date:   Fri, 24 Nov 2023 10:41:05 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 06/26] drm/shmem-helper: Add and use pages_pin_count
In-Reply-To: <20231029230205.93277-7-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-7-dmitry.osipenko@collabora.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 02:01:45 +0300, Dmitry Osipenko wrote:
> Add separate pages_pin_count for tracking of whether drm-shmem pages are
> moveable or not. With the addition of memory shrinker support to drm-shme=
m,
> the pages_use_count will no longer determine whether pages are hard-pinned
> in memory, but whether pages exist and are soft-pinned (and could be swap=
ped
> out). The pages_pin_count > 1 will hard-pin pages in memory.
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
