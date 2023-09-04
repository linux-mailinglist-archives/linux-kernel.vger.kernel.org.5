Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E08791EE0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbjIDVJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjIDVJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:09:31 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5EB12E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:09:25 -0700 (PDT)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4Rfh8g6lsMzDqDx;
        Mon,  4 Sep 2023 21:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1693861764; bh=rC5mzBz1eIp9iAikOLl0SNEgeyeJvZBofi1hx7Ht8Xg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sJrT65RQs3jM+EFArU4lJH0yUQHBRRXx84PsVsmXgnElb6OlDJgEzAuBSAJHdtse4
         tq7MSPXX4lySBtzmfHR841R//tp3P5YLe5FVDUCKDw5X6aeT5L29O6tuWwJMzN4YWE
         P4Mz3ap6sEkH9CTfIS3XnzQrbDauvp8tJxZyMMjw=
X-Riseup-User-ID: 5248EFA8B71512A4301BE177B580034F60ECB2FA86EB0AB9B790A9018150663D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Rfh8P3Sh7zFrx8;
        Mon,  4 Sep 2023 21:09:09 +0000 (UTC)
Message-ID: <7d17f8bf-7cfe-d11d-1dfc-4032c6437188@riseup.net>
Date:   Mon, 4 Sep 2023 18:09:09 -0300
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 15:05, Arthur Grillo wrote:
> When CONFIG_DEBUG_FS is not set -Wunused-function warnings appear,
> make the static function inline to suppress that.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309012114.T8Vlfaf8-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202309012131.FeakBzEj-lkp@intel.com/
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

Best Regards,
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
