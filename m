Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813C7770F3F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 12:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjHEKTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 06:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjHEKTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 06:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA151113
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691230700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EDl8FKi4TmGBJc8DUiagN0W08gSz4Sjm38M3DkmH1A8=;
        b=W/6+h5VlS2KrbqJbHp7guznDGUmDM2MTcMcZtqp0f3kxy+pjy/gVEFG0NK1UCfAgIgS7/X
        TmORnCLDzqtvEUBecFIijBx2+08/fkJM66wfQI4hET3w1hmLunOdxItGY//H1TJkMMedtJ
        YjgB2H5HmR2pfPoTSeJIN+BaI9k2CsE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-S4sKxeXuNri1SAYRE-lUJw-1; Sat, 05 Aug 2023 06:18:19 -0400
X-MC-Unique: S4sKxeXuNri1SAYRE-lUJw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63cebe9238bso7597326d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 03:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691230698; x=1691835498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDl8FKi4TmGBJc8DUiagN0W08gSz4Sjm38M3DkmH1A8=;
        b=Qc5TCLbREjSIoLMrQHSd6ilVnP/7pitHAIosOv26DPHo+bVGaXn3jTG3NYmPqNGihg
         hDeIvS4Yk5n1d7H3MOzbvk3RbxPr5EV456SZkAM8hYfo3agXP/DObPwiQgdZ3kgyjPrp
         J9F2ZSIDl0ZthLkRX/qbbfjCYMsUGzTKjhU1PO/EcNk7pGuEbByQbGLm7kioTFr1xlmk
         2rKdhPuoUQerwkFDgbN4/1yP9dEv23gP/wUJnICAXo+lU7arrG2w9IkS+MDYRBM7FPY/
         9CDM1fj0Ua+aCsOaeg85rGMUPzu6iOEHqytVD8oYFXlwK1PszE9NdNKQGPwnYjtJ5owO
         wvOA==
X-Gm-Message-State: ABy/qLbVap8bsmw7mm86VLWkfnpOMy8a2hf9dtfbLLAqGkfDb2Y5gJw/
        PzqgwuimyfkDI2VG/tgpxvVG8R6CnNumF+fBA0DQnZqJURs9chIkz2Xa/kJABRTiswiffgj3/6h
        FQNvAU9X2qtVNvwfT8dGAwmLu4Dr8FtyOTdQb7qFaBJjISIvMaUapjJ9CgyRlZntCSd7dcOSUbI
        Nt+68R14U=
X-Received: by 2002:ac8:5c05:0:b0:40f:a5bb:5276 with SMTP id i5-20020ac85c05000000b0040fa5bb5276mr21244873qti.1.1691230698039;
        Sat, 05 Aug 2023 03:18:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGxbKkXSoa09vwMpsK5fJJErUueAZzn6Eyh8re2STw/wxSsOI0uRnQzLEtQYQPJQ+wGIPPrkA==
X-Received: by 2002:ac8:5c05:0:b0:40f:a5bb:5276 with SMTP id i5-20020ac85c05000000b0040fa5bb5276mr21244843qti.1.1691230697692;
        Sat, 05 Aug 2023 03:18:17 -0700 (PDT)
Received: from kherbst.pingu.com ([31.17.16.107])
        by smtp.gmail.com with ESMTPSA id dq15-20020a05622a520f00b0040c72cae9f9sm1247325qtb.93.2023.08.05.03.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 03:18:16 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        Olaf Skibbe <news@kravcenko.com>
Subject: [PATCH] drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes
Date:   Sat,  5 Aug 2023 12:18:13 +0200
Message-ID: <20230805101813.2603989-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original commit adding that check tried to protect the kenrel against
a potential invalid NULL pointer access.

However we call nouveau_connector_detect_depth once without a native_mode
set on purpose for non LVDS connectors and this broke DP support in a few
cases.

Cc: Olaf Skibbe <news@kravcenko.com>
Cc: Lyude Paul <lyude@redhat.com>
Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/238
Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/245
Fixes: 20a2ce87fbaf8 ("drm/nouveau/dp: check for NULL nv_connector->native_mode")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index f75c6f09dd2af..a2e0033e8a260 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -967,7 +967,7 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 	/* Determine display colour depth for everything except LVDS now,
 	 * DP requires this before mode_valid() is called.
 	 */
-	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS && nv_connector->native_mode)
+	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS)
 		nouveau_connector_detect_depth(connector);
 
 	/* Find the native mode if this is a digital panel, if we didn't
-- 
2.41.0

