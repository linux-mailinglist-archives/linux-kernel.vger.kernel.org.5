Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA76D799127
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjIHUpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjIHUpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:45:54 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B84F8E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:45:49 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx0.riseup.net (Postfix) with ESMTPS id 4Rj7Rc3Ch0z9t74;
        Fri,  8 Sep 2023 20:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1694205948; bh=h1TWJdGJ9ASx08PyZZIFjCeXM50aEyi5tVxjQAo3lGI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ELCqhZrkXLfDwUcMLzlzeWlU0aaN2zvpp9Ac7LBWk7STYDWMmAcByZ5PqQ4v7RSA8
         im1/5hLJdn5iVfN6xcVO73KQUN7vHIVD6lzuSOYGbbuoMopoX+n6u1kSB3dI20RfIA
         5LGH9OOUSsRvz8761ndiNd4U2Jwm9IJTN2yd19DU=
X-Riseup-User-ID: 76C808A5AD22C7481D8113EBDB2523E94D0004C5ADD5B03B1E1896DD3A06C1C7
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Rj7RX4zYMzJnCB;
        Fri,  8 Sep 2023 20:45:44 +0000 (UTC)
Message-ID: <95380f26-a772-3723-5715-e5c4f2d6d1cc@riseup.net>
Date:   Fri, 8 Sep 2023 17:45:46 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] drm/debugfs: Add inline to drm_debugfs_dev_init() to
 suppres -Wunused-function
Content-Language: en-US
To:     Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     tales.aparecida@gmail.com, andrealmeid@riseup.net,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        kernel test robot <lkp@intel.com>
References: <20230901-debugfs-fix-unused-function-warning-v1-1-161dd0902975@riseup.net>
From:   Maira Canal <mairacanal@riseup.net>
In-Reply-To: <20230901-debugfs-fix-unused-function-warning-v1-1-161dd0902975@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arthur,

On 9/1/23 15:05, Arthur Grillo wrote:
> When CONFIG_DEBUG_FS is not set -Wunused-function warnings appear,
> make the static function inline to suppress that.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309012114.T8Vlfaf8-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202309012131.FeakBzEj-lkp@intel.com/
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>

Applied to drm-misc/drm-misc-next!

Thanks!
- Maíra

> ---
>   include/drm/drm_drv.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 9850fe73b739..e2640dc64e08 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -584,7 +584,7 @@ static inline bool drm_firmware_drivers_only(void)
>   #if defined(CONFIG_DEBUG_FS)
>   void drm_debugfs_dev_init(struct drm_device *dev, struct dentry *root);
>   #else
> -static void drm_debugfs_dev_init(struct drm_device *dev, struct dentry *root)
> +static inline void drm_debugfs_dev_init(struct drm_device *dev, struct dentry *root)
>   {
>   }
>   #endif
> 
> ---
> base-commit: 8e455145d8f163aefa6b9cc29478e0a9f82276e6
> change-id: 20230901-debugfs-fix-unused-function-warning-9ebbecbd6a5a
> 
> Best regards,
