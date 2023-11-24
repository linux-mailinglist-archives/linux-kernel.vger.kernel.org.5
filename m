Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6427F71B8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjKXKkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345599AbjKXKkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:40:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EDC1AE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:40:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0480C433C7;
        Fri, 24 Nov 2023 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700822428;
        bh=y+1TDiBAnMt4VxdCKGR5QS2biqH47tvAiQJ9i4yez2Y=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=p/qa+RJdm7WokbrVvywi9obaB050hb9y0zng38ZwWloP45PRz9232CjxOYzodFL8L
         gRibElH+QG/dcvyBOrWEQED3vZjkhgtvRO5jbcTTOzHXl8kJR/SHt51HgicJgDeK6t
         FnC5SWQYnR15tJhpZFgGipbCieJveCjAfpWuZzbnyF8RPh5dDt99LCC65nIFbYNSp6
         FiGYFMdrKwQ+xpUTiO5gbQVwNBlfKEcl39Y3h01GRO/KwBKd71tFV3ohenFQK4m8d0
         RyxAnwN1W8Rv+7n6JjcXMwcWRNcuP1XBOes1rA1hxsvmlCZYCapgbcKHVP/vT17+SO
         ojiNCUBS7DoLg==
Message-ID: <74226af80ecee1c3544c1bcf66565514.mripard@kernel.org>
Date:   Fri, 24 Nov 2023 10:40:25 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 05/26] drm/shmem-helper: Remove obsoleted is_iomem
 test
In-Reply-To: <20231029230205.93277-6-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-6-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:01:44 +0300, Dmitry Osipenko wrote:
> Everything that uses the mapped buffer should be agnostic to is_iomem.
> The only reason for the is_iomem test is that we're setting shmem->vaddr
> to the returned map->vaddr. Now that the shmem->vaddr code is gone, remove
> the obsoleted is_iomem test to clean up the code.
>=20
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
