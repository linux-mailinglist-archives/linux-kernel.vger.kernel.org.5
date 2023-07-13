Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6838475297A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjGMRGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGMRGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ABD2D49
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689267903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJWbnZRk37PbyOPLbQx6TkJaNwAsU77I+1I9gnkS+kQ=;
        b=PSxhhvv1HPvBzyOYMiPfgZJt9q/wpccBjwx3E/J85VSC/5wimT5R1zKcrtdZim8grumcTS
        VBDON6+xiK3TaIVkBzBI+swVe6C52yziVFNOE5S76bC0Em0s5i2DJfBbuv0VHxDKMG/dk/
        +cvEysJdim26rfBoOlZEtGRxZ36UAeQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-me74jPv5Neqza6bBpm_waw-1; Thu, 13 Jul 2023 13:05:00 -0400
X-MC-Unique: me74jPv5Neqza6bBpm_waw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-992e68297bcso57065566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267900; x=1691859900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJWbnZRk37PbyOPLbQx6TkJaNwAsU77I+1I9gnkS+kQ=;
        b=jN10Avrp9YW5A2uzT4fYEX0XyOqOXqBmmup8tCMCmPJd5LxkjjCgYtq8bRDSAEsVW/
         Kbkk0N6RtcrUSoA4K3m4yQRCCFIAar5wC7fYA9vrhTnpjXs163byrRxrfsopjWZ/f4gu
         g9rnMX0+pOJSVfmIXKnuN+LY+6TWGnSaelFDUmemaPj3wbFJfr456g7/mywFHOQ8MsCa
         FoKBn+hnG55HYGmM028CJseB4kpr3HFUYiGYDATJFHNExpudGsVEq1eZ00oPKZlwGTDb
         02/LXAZbFBrBucgn0BzAgSmcYKpi1s5JopDNBxAcRFNOmNINpwcf9aDboeQM1AOFQUuP
         qB9w==
X-Gm-Message-State: ABy/qLbrBPqbSygq5LFoKK9uafXx1aydsxzRxKv1qjI5U0cQEhW1MMAf
        6nm4EUSpeeLl39at7rnPqK/RwoD4YFFfxvU3wOMO7usnHyeXH0cjHwocn8DGAoX8InD2iJP+ENp
        my7+P0iQd8pCP0c/F9WySHq6k
X-Received: by 2002:a17:906:113:b0:987:fe18:1c56 with SMTP id 19-20020a170906011300b00987fe181c56mr2115232eje.47.1689267899909;
        Thu, 13 Jul 2023 10:04:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEGCyQeuogsjgxDVJKFBZEg08N1OVXBkYa73JHbS/zCbYQKSeo62Zql1FBRS0FoBHej2bCLIA==
X-Received: by 2002:a17:906:113:b0:987:fe18:1c56 with SMTP id 19-20020a170906011300b00987fe181c56mr2115221eje.47.1689267899743;
        Thu, 13 Jul 2023 10:04:59 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id t9-20020a1709064f0900b00992a8a54f32sm4244576eju.139.2023.07.13.10.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:04:59 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net, donald.robson@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next v7 06/13] drm/nouveau: bo: initialize GEM GPU VA interface
Date:   Thu, 13 Jul 2023 19:04:01 +0200
Message-ID: <20230713170429.2964-7-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713170429.2964-1-dakr@redhat.com>
References: <20230713170429.2964-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the GEM's DRM GPU VA manager interface in preparation for the
(u)vmm implementation, provided by subsequent commits, to make use of it.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 7724fe63067d..057bc995f19b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -215,11 +215,14 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 domain,
 	nvbo = kzalloc(sizeof(struct nouveau_bo), GFP_KERNEL);
 	if (!nvbo)
 		return ERR_PTR(-ENOMEM);
+
 	INIT_LIST_HEAD(&nvbo->head);
 	INIT_LIST_HEAD(&nvbo->entry);
 	INIT_LIST_HEAD(&nvbo->vma_list);
 	nvbo->bo.bdev = &drm->ttm.bdev;
 
+	drm_gem_gpuva_init(&nvbo->bo.base);
+
 	/* This is confusing, and doesn't actually mean we want an uncached
 	 * mapping, but is what NOUVEAU_GEM_DOMAIN_COHERENT gets translated
 	 * into in nouveau_gem_new().
-- 
2.41.0

