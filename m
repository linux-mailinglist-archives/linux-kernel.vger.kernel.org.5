Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D74E78D2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 07:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjH3FGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 01:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjH3FGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 01:06:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A06D1BE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 22:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=zW7btOlt2K11qPsWxiHaKJSAiy+S4wAiIVnsHPn6fd0=; b=cUmOXIY0aE/IlImLNPprIrDQE1
        GOiZtwCWlf5W9BZ3hDZT9ISC5B5ikbRE1+1XpE2G0JuIrZYUoqEJxX9F5PC+AuFcooXMqdgoq9k6Q
        ABliNVk7NWBFvInDGIFAxmxIr/Sfpts6BZxACrqcbadL2oLYs1tV7cYrlDDn3MrBLgLdsfI5bYh3D
        5Tl5sVvGJoFqHaxdPZ8LdQnBMO424tTkG5eQABt9q9S2yH1scb5OhvJolRiG1DeazcXRdTaiQ7CEB
        d3G44W0nPla9H+SNm0zZmwQY+n6BcUESMJVic0D7zl4kjOFPDXZ81O2ZXbs+LrnCMeY5GDVtWTO6F
        6fpZhDJQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qbDPH-00Cq5a-1f;
        Wed, 30 Aug 2023 05:06:19 +0000
Message-ID: <2b26d9e6-262c-0cd5-d390-e3b52f55e760@infradead.org>
Date:   Tue, 29 Aug 2023 22:06:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] drm/connector: mark enum counter value as private
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org
References: <20230716004616.21838-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230716004616.21838-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/15/23 17:46, Randy Dunlap wrote:
> Mark the DRM_MODE_COLORIMETRY_COUNT enum value as private in
> kernel-doc to prevent a build warning:
> 
> include/drm/drm_connector.h:527: warning: Enum value 'DRM_MODE_COLORIMETRY_COUNT' not described in enum 'drm_colorspace'
> 
> Fixes: c627087cb164 ("drm/connector: Use common colorspace_names array")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> ---
>  include/drm/drm_connector.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20230714.orig/include/drm/drm_connector.h
> +++ linux-next-20230714/include/drm/drm_connector.h
> @@ -522,7 +522,7 @@ enum drm_colorspace {
>  	DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED	= 13,
>  	DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT	= 14,
>  	DRM_MODE_COLORIMETRY_BT601_YCC		= 15,
> -	/* not a valid value; merely used for counting */
> +	/* private: not a valid value; merely used for counting */
>  	DRM_MODE_COLORIMETRY_COUNT
>  };
>  

Any comments on this patch?
The warning is still present in mainline.
The "private:" marker tells kernel-doc not to expect documentation for it.

thanks.
-- 
~Randy
