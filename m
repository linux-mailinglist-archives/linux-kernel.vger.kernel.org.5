Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3BA7A809D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbjITMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbjITMiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AACDD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695213446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/re3vPWoYJ/6xHLpunyVTZgfJ3oWhQoot3M15Xf93m8=;
        b=fun9RKCVYIFO2NpscfgqRbewk7rWIr4IcMr0+xs1le64fQaaoai57DN0QqxYOjR07SuBy8
        4Gi0Z3qSX7cF4BEqgTSbTXauwOc/zwltUc7VE2Ij+9JUu8HfOSZJbnYdbIMsAKsuicGX3A
        CNDyu86JF11RjZ76wAFybIhjKgXFhcg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-ZPzisAiJNOi39mfhGckCng-1; Wed, 20 Sep 2023 08:37:25 -0400
X-MC-Unique: ZPzisAiJNOi39mfhGckCng-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a9cd336c9cso154954366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213444; x=1695818244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/re3vPWoYJ/6xHLpunyVTZgfJ3oWhQoot3M15Xf93m8=;
        b=lxqmH0dmAsRYOWZ0uzYC0hZPVehCe0w6tfWGfRHZSaF1QpLcnyx4Giku3NoFhNo5gR
         6Ys3qe8JuPLTLYfqOzl8RdRNHkq/IOWDQ+9tKyX6JGS2nWMixjc2H0rucHleSwpbUX67
         9Fi1exFeM2aCSNbifjKP4XONQLvPYhPT0Euh6ua/GaePXFZRpO6uG3/JPNMS1vwr9rRM
         ctmk4uFrhmP5WkoF8CHvArzKky8XnrjIKrOCqp5MJUSKGVEebQjMHeDApY1OidqTvRDV
         CStik6QwVdIOYkZIcvhnJ4hlRJ35a9wD1CbuOPiZNUcDivy8Jft8YTAW2UsyzxaBbdHW
         ErMA==
X-Gm-Message-State: AOJu0YxAJswF1tek89Yuj6woZbSzo7TXY6yOnP5x5i9yexG08KQ03nrq
        IJ16jIvvBY7twiq/R4liixEdQtqhsYrmDCeBCI/szRU6WbK5rjosypSHhaLJp7Srkni9OqsS9BE
        ODj3TWdDzchHp6D4JiXLsn3MQ
X-Received: by 2002:a17:906:1d4:b0:9ad:f4d9:f6f2 with SMTP id 20-20020a17090601d400b009adf4d9f6f2mr1978098ejj.5.1695213444578;
        Wed, 20 Sep 2023 05:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhjndQs4UNSwfullLxNR+tIZdKn1iy3aRr+eKNx4dO54tFLsdtNfZQxNfsH7DoGs3jy6KzlA==
X-Received: by 2002:a17:906:1d4:b0:9ad:f4d9:f6f2 with SMTP id 20-20020a17090601d400b009adf4d9f6f2mr1978090ejj.5.1695213444350;
        Wed, 20 Sep 2023 05:37:24 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906854b00b0099ccee57ac2sm9233184ejy.194.2023.09.20.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:37:19 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>
Subject: [PATCH v3 5/5] drm: vmgfx_surface.c: copy user-array safely
Date:   Wed, 20 Sep 2023 14:36:13 +0200
Message-ID: <20230920123612.16914-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920123612.16914-2-pstanner@redhat.com>
References: <20230920123612.16914-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 5db403ee8261..9be185b094cb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -777,9 +777,9 @@ int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
 	       sizeof(metadata->mip_levels));
 	metadata->num_sizes = num_sizes;
 	metadata->sizes =
-		memdup_user((struct drm_vmw_size __user *)(unsigned long)
+		memdup_array_user((struct drm_vmw_size __user *)(unsigned long)
 			    req->size_addr,
-			    sizeof(*metadata->sizes) * metadata->num_sizes);
+			    metadata->num_sizes, sizeof(*metadata->sizes));
 	if (IS_ERR(metadata->sizes)) {
 		ret = PTR_ERR(metadata->sizes);
 		goto out_no_sizes;
-- 
2.41.0

