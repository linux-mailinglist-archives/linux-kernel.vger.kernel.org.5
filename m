Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0D6794484
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbjIFU2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbjIFU2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:28:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318A619B1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 13:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=FLTOwwr5W43vbiGYl2v2rKXXuVv9T2DL3IE1Nf+wFh4=; b=TmD8pgRJhAchnJvuzfhT5jRS7w
        AfJO/UhAW/m4rOUw/qZ7914fzD+kvfDaF06viiN5wAm/qrqfrZgiYhr8gia6w09jmB0lyGWctoRpG
        SaPzgLvKgpqHmGhH3JrakBfc7UOS67ChNDTCfGxqOMwzFy8XnxH3VDFigRiQdpUvmJaZSkBiBsprL
        wCrKAngc1/yhzYfVuK/xAiLROJSlX88apCtXVcDcT9z5OF+xFt//qAvuOhydgGIMjjoJHR0OJpEZx
        407g22zbK1c8kAkUc9MBneL/uwjlh5sRFzjurjcvhBiVAPlZracCBw5kO7hy+BZ6Bh0nWKa9AZrmk
        ZQQO4BPQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdz8i-00AqvX-1z;
        Wed, 06 Sep 2023 20:28:40 +0000
Message-ID: <555ac3b5-93ee-efca-45d7-f34b5e91d891@infradead.org>
Date:   Wed, 6 Sep 2023 13:28:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] drm/connector: document supported_colorspaces and
 DRM_MODE_COLORIMETRY_COUNT
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230906-topic-drm_connector_doc-v1-1-f4ce7ad0150c@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230906-topic-drm_connector_doc-v1-1-f4ce7ad0150c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/6/23 11:19, Javier Carrasco wrote:
> The supported_colorspaces parameter was added to the following
> functions without documenting it:
> 
> drm_mode_create_dp_colorspace_property
> drm_mode_create_hdmi_colorspace_property
> 
> The missing descriptions generate warnings when compiling the
> documentation. Add the descriptions to document the
> supported_colorspaces parameter.
> 
> The drm_colorspace enum member DRM_MODE_COLORIMETRY_COUNT has been
> properly documented by moving the description out of the enum to the
> member description list to get rid of an additional warning and improve
> documentation clarity.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> The supported_colorspaces parameter was added to the following
> functions without documenting it:
> 
> drm_mode_create_dp_colorspace_property
> drm_mode_create_hdmi_colorspace_property
> 
> The missing descriptions generate warnings when compiling the
> documentation. Add the descriptions to document the
> supported_colorspaces parameter.
> 
> The drm_colorspace enum member DRM_MODE_COLORIMETRY_COUNT has been
> properly documented by moving the description out of the enum to the
> member description list to get rid of an additional warning and improve
> documentation clarity.
> ---
>  drivers/gpu/drm/drm_connector.c | 2 ++
>  include/drm/drm_connector.h     | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index bf8371dc2a61..77bfe17dcf98 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c

These (2) are already fixed in linux-next.

> @@ -2203,6 +2203,7 @@ static int drm_mode_create_colorspace_property(struct drm_connector *connector,
>  /**
>   * drm_mode_create_hdmi_colorspace_property - create hdmi colorspace property
>   * @connector: connector to create the Colorspace property on.
> + * @supported_colorspaces: colorspaces supported by the driver.
>   *
>   * Called by a driver the first time it's needed, must be attached to desired
>   * HDMI connectors.
> @@ -2227,6 +2228,7 @@ EXPORT_SYMBOL(drm_mode_create_hdmi_colorspace_property);
>  /**
>   * drm_mode_create_dp_colorspace_property - create dp colorspace property
>   * @connector: connector to create the Colorspace property on.
> + * @supported_colorspaces: colorspaces supported by the driver.
>   *
>   * Called by a driver the first time it's needed, must be attached to desired
>   * DP connectors.
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index d300fde6c1a4..18cf46e3478b 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h

This one still needs to be fixed/applied.
You can add:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> @@ -498,6 +498,8 @@ enum drm_privacy_screen_status {
>   *   ITU-R BT.601 colorimetry format
>   *   The DP spec does not say whether this is the 525 or the 625
>   *   line version.
> + * @DRM_MODE_COLORIMETRY_COUNT:
> + *   Not a valid value; merely used four counting
>   */
>  enum drm_colorspace {
>  	/* For Default case, driver will set the colorspace */
> @@ -522,7 +524,6 @@ enum drm_colorspace {
>  	DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED	= 13,
>  	DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT	= 14,
>  	DRM_MODE_COLORIMETRY_BT601_YCC		= 15,
> -	/* not a valid value; merely used for counting */
>  	DRM_MODE_COLORIMETRY_COUNT
>  };
>  
> 
> ---
> base-commit: 65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4
> change-id: 20230906-topic-drm_connector_doc-42dae3ba43c6
> 
> Best regards,

-- 
~Randy
