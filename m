Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810E47F058E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 11:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjKSK5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 05:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjKSK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 05:57:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1610D11D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700391448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paKcR4aagnq4OR4cFFNyGyCczT8YfM2615gwz6U/Ifs=;
        b=TtQbMRN+jI0GVPqUIBw+chII97xHmIfAeOCqMCvjL43aFp6sKGjm/26wDwMdSgDjU7Pfv3
        r6Z63G+RlIp8gJfimIUizZp0qX4y7JmBpjpxKMzGvBUBbUAUKMYGIXNr11roHHu6DAYO7W
        RyvYtDqsPCrJmcWrSBd3Jb4E3R8KNAI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-kJXZqyjQNBiMontU1rG26Q-1; Sun, 19 Nov 2023 05:57:26 -0500
X-MC-Unique: kJXZqyjQNBiMontU1rG26Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32db6a28e24so1696934f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700391444; x=1700996244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paKcR4aagnq4OR4cFFNyGyCczT8YfM2615gwz6U/Ifs=;
        b=JXFsJDqxIRa/mrc4ij2sHikWWczq5+BbmBcocdReexkz3hgjoxFDzfyDDYJcHD7BF+
         ircILGnf1A4TpqUObaMAOpEcLso7B0DbVFXMg6n5kkn+INlA60KRYr3+lCkV1LvHN9Lq
         cBOGMGwh9DAN6Uk9EenogGKT1pT+s5aWd9OIz372ebuuDvBfFFD1Mqjk2LirM5nEHuGh
         xsxm36YA7S7pjMbDkM2qHbKuXfUZ+Kyjh1CpXUZtwngSpI/g/hCIcaCty5wYsuy9PJNz
         X7jsPsDgKS1rz/aG60st+vQCrXai5buHYmMjTmAw23I1gCmehkXSJNXEYu0b2oyhs/ma
         cQeA==
X-Gm-Message-State: AOJu0YzrtNNv3OIvd274/Wf3G4LmH0WCTgh0QPPGErZDG4d1lwQEw/U3
        pTKLkAh6w736V/6OaSerXbv7CyS2hFzlS846iMEahPZkadB38jHyai4XfHUJRcsm7W4h9SCDUib
        WXKmgkZ/SHa/VcapHhZhzQwTswyrF+2SmsOlQ7my9FTmkZUgQcAXtYHvi0bnt4BGeOsDEIo9bu6
        AkAu335OA=
X-Received: by 2002:adf:e58b:0:b0:32d:b051:9a27 with SMTP id l11-20020adfe58b000000b0032db0519a27mr2879808wrm.20.1700391444542;
        Sun, 19 Nov 2023 02:57:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi7SRJ7y81uoAdnNo/STFG3TuDFoHARhcCF0tpowHTWIp4MigNAbZkJfZ0hoizOoIOzIYjFQ==
X-Received: by 2002:adf:e58b:0:b0:32d:b051:9a27 with SMTP id l11-20020adfe58b000000b0032db0519a27mr2879785wrm.20.1700391444248;
        Sun, 19 Nov 2023 02:57:24 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id dm15-20020a0560000bcf00b0032d81837433sm7796649wrb.30.2023.11.19.02.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 02:57:23 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Erico Nunes <nunes.erico@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 5/5] drm/todo: Add entry about implementing buffer age for damage tracking
Date:   Sun, 19 Nov 2023 11:57:01 +0100
Message-ID: <20231119105709.3143489-6-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231119105709.3143489-1-javierm@redhat.com>
References: <20231119105709.3143489-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only damage tracking for frame damage is supported. If a driver
needs to do buffer damage (e.g: the framebuffer attached to plane's state
has changed since the last page-flip), the damage helpers just fallback to
a full plane update.

Add en entry in the TODO about implementing buffer age or any other damage
accumulation algorithm for buffer damage handling.

Suggested-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Simon Ser <contact@emersion.fr>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

 Documentation/gpu/todo.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index b62c7fa0c2bc..5c43a958814b 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -782,6 +782,26 @@ Contact: Hans de Goede
 
 Level: Advanced
 
+Buffer age or other damage accumulation algorithm for buffer damage handling
+============================================================================
+
+Drivers that do per-buffer uploads, need a buffer damage handling (rather than
+frame damage like drivers that do per-plane or per-CRTC uploads), but there is
+no support to get the buffer age or any other damage accumulation algorithm.
+
+For this reason, the damage helpers just fallback to a full plane update if the
+framebuffer attached to a plane has changed since the last page-flip.
+
+This should be improved to get damage tracking properly working on drivers that
+do per-buffer uploads.
+
+More information about damage tracking and references to learning materials in
+`Damage Tracking Properties <https://docs.kernel.org/gpu/drm-kms.html#damage-tracking-properties>`_
+
+Contact: Javier Martinez Canillas <javierm@redhat.com>
+
+Level: Advanced
+
 Outside DRM
 ===========
 
-- 
2.41.0

