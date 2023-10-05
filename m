Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4D67BA487
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjJEQG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbjJEQEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A4D98E9B;
        Thu,  5 Oct 2023 08:01:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4887C15;
        Thu,  5 Oct 2023 08:01:42 -0700 (PDT)
Received: from [10.57.2.146] (unknown [10.57.2.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 761603F5A1;
        Thu,  5 Oct 2023 08:01:01 -0700 (PDT)
Message-ID: <17bbd391-e6df-4a01-9bbb-d0583d7621c4@arm.com>
Date:   Thu, 5 Oct 2023 16:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/gpu: fix Panfrost documentation build
 warnings
Content-Language: en-GB
To:     =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     kernel test robot <lkp@intel.com>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231005141239.132783-1-adrian.larumbe@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20231005141239.132783-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2023 15:12, Adrián Larumbe wrote:
> Fix issues revealed by `make htmldocs` after adding Panfrost DRM
> documentation file.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: d124dac2089c ("drm/panfrost: Add fdinfo support GPU load metrics")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310030917.Txzlpoeq-lkp@intel.com
> ---
>  Documentation/gpu/drivers.rst  | 1 +
>  Documentation/gpu/panfrost.rst | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
> index 3a52f48215a3..45a12e552091 100644
> --- a/Documentation/gpu/drivers.rst
> +++ b/Documentation/gpu/drivers.rst
> @@ -18,6 +18,7 @@ GPU Driver Documentation
>     xen-front
>     afbc
>     komeda-kms
> +   panfrost
>  
>  .. only::  subproject and html
>  
> diff --git a/Documentation/gpu/panfrost.rst b/Documentation/gpu/panfrost.rst
> index ecc48ba5ac11..a07f6821e994 100644
> --- a/Documentation/gpu/panfrost.rst
> +++ b/Documentation/gpu/panfrost.rst
> @@ -5,7 +5,7 @@
>  .. _panfrost-usage-stats:
>  
>  Panfrost DRM client usage stats implementation
> -==========================================
> +==============================================

This fix is already present in drm-misc-next - I think Boris must have
fixed it when applying.

With that dropped:

Reviewed-by: Steven Price <steven.price@arm.com>

>  
>  The drm/Panfrost driver implements the DRM client usage stats specification as
>  documented in :ref:`drm-client-usage-stats`.

