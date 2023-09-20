Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C169A7A8097
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbjITMiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbjITMiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7CD8F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695213432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KRPqkETTBVBC/zv1aXEUiiiXJ1Cft936yka0iGNazc=;
        b=NsQNVBVvn8cHPjczHEd+ce2WPl1ngK2pnhiyVc5PtQmWoQ8d+Py5Z8jmz44+yOYavYNmvm
        GWyQO5jYZh4eydeAyxzk8JDq0QT5L4jsUe495Rdh4Q4RvcX9PvlHJTQMnRNrKQOs76hVvA
        3NXHExGLPza5WyCqKStB0fDDqnXyRbM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-4e45YJ1yNf2nIe3wTP_STg-1; Wed, 20 Sep 2023 08:37:10 -0400
X-MC-Unique: 4e45YJ1yNf2nIe3wTP_STg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-404fc59b8acso13443825e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213429; x=1695818229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KRPqkETTBVBC/zv1aXEUiiiXJ1Cft936yka0iGNazc=;
        b=lVMTfTHCdqXVUxa/8BdisZ3vrnHMjeJe31bjz85LUpA6zZPXvzYVpay6b9EWKf1bCP
         aAlgT6FQUmkeJxKvQd/td/c8KK9EALcy/7Xjr5nvf78DfevPQWljROmiz9PEtWbMJ+JQ
         aRGXUoD5KTQpBFxFkE6foRv5w4UmVLsBT4Ww8ZgkxrF58AqMthqC4egIw4DhmFHGd67y
         8jz933qFEwccVk2M+gZmgFZIgla+KU4uVKPO+hGHHHxXp6lWd1XJr8OotPSLLg87JdB2
         rW1akAabgynh+AT0mJg8mxLPqJxo3RUyRUGF3482MhHAegpZl4sarfVSVgLlDCGjWq3z
         Nawg==
X-Gm-Message-State: AOJu0YxIf/THX7695kz5EcI/pHzK6QXppN5rprGiotD8b1U6ITKS7Ozs
        wNeDX2DkAGkIAo0a7Os6leL95bxo3WOWobGWqxvf3XBmmIjOLokxrAxwWoKtTlIk/g3XrL6uYW3
        uJrhRHjHo4gRQhc/q3oa7+lsf
X-Received: by 2002:adf:ec48:0:b0:317:630d:1e8e with SMTP id w8-20020adfec48000000b00317630d1e8emr2031480wrn.2.1695213429376;
        Wed, 20 Sep 2023 05:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGorWXFxi2CZ+i0Bq4z7I+sy7K13wS44rMjIuskory3+gtAyjUda2GeiUfH2k5vq773C10/rA==
X-Received: by 2002:adf:ec48:0:b0:317:630d:1e8e with SMTP id w8-20020adfec48000000b00317630d1e8emr2031462wrn.2.1695213429120;
        Wed, 20 Sep 2023 05:37:09 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id lg13-20020a170906f88d00b009ad88839665sm9297787ejb.70.2023.09.20.05.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:37:03 -0700 (PDT)
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
Subject: [PATCH v3 4/5] drm_lease.c: copy user-array safely
Date:   Wed, 20 Sep 2023 14:36:12 +0200
Message-ID: <20230920123612.16914-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920123612.16914-2-pstanner@redhat.com>
References: <20230920123612.16914-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
 drivers/gpu/drm/drm_lease.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 150fe1555068..94375c6a5425 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -510,8 +510,8 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	/* Handle leased objects, if any */
 	idr_init(&leases);
 	if (object_count != 0) {
-		object_ids = memdup_user(u64_to_user_ptr(cl->object_ids),
-					 array_size(object_count, sizeof(__u32)));
+		object_ids = memdup_array_user(u64_to_user_ptr(cl->object_ids),
+					       object_count, sizeof(__u32));
 		if (IS_ERR(object_ids)) {
 			ret = PTR_ERR(object_ids);
 			idr_destroy(&leases);
-- 
2.41.0

