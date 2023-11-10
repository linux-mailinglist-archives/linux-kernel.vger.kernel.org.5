Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78597E81B7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjKJSc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344887AbjKJSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:31:48 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53292AD26
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:58:22 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so1727444b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699613902; x=1700218702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5IUeWekHfreeoT4d6rzGP0QBd9dD1NqeQcWvgmcT6s=;
        b=nbCcLv5XOsNUco79Obe/BF0oLZM0NFeZF05xbHzPtN9WXY8IASZXedjtdRebEOU7OX
         eWqq2iw5OCclCzFWOo0+EgyTHTFEI/FJTK8CTTb03SbIkWXT6mtH6+VOSVJ/oboNUsUY
         1//NpzVU7YLmxjeWcg61MPwJ4F7t4T8GgQoAhTGYyQeldndOOMUWk+3lnyoruAxaPmVL
         z2WoCS8nEY/h/y06mruX+FHqhykizwG0Iq0LPmUrmIOGToNDC3jRDS1n569V8SaMzcnx
         XXdFGkFNLIF2B2VgyxVSg2Jgs9351wNSaP6fjUXN8WsrjHmB1/ffm6CQNeOSNj1q7DFp
         DYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699613902; x=1700218702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5IUeWekHfreeoT4d6rzGP0QBd9dD1NqeQcWvgmcT6s=;
        b=T0covWzehxLFD8/j/j9jHS8KnipXoYTTV2FsfbSBaWek8l/0B3PZY/sqjfhdiHoRZp
         KAJd7LaUH9EJ50K9dl6K2Lsu2eD9UoS/qXgQZk1sXwucHIZNIIUioTjtaMToV+4aOFpl
         1AMKOG45LG9/6nFt6CqxelcUlgEvPLSYMyleF4oLViWpqb0O8AM1+mfpCKjiBzSXH4sf
         p4yD6KDSjl9jkbEn8GnvqPbi9andypL4QeeHuhfVK5t1Ni8woMaGwvzeD3uxU2yFdoRu
         0pnio58EgY/+4QYrwI0AKaqJ0wMkHlJTcMrfVV/vYwREgXhSa89uYQS1eOfC+aEtZFVH
         2i/g==
X-Gm-Message-State: AOJu0YwTaGai//gbknfSVbCLCqEBEw7ilNYwm4dMfoAp0+GK5185E74z
        eieD7yvEQwd4LHkyB/StSauH8YHWxuanr5Eb
X-Google-Smtp-Source: AGHT+IG6aZsLMX7XHC7FMoJY28qDjYKmoVJwl7FdMYZxT4Mf1xNfM2KWIQDP6hlhCCL74Xm3jdldtw==
X-Received: by 2002:a05:6a20:a4a5:b0:17f:d42e:202c with SMTP id y37-20020a056a20a4a500b0017fd42e202cmr5312588pzk.49.1699613902213;
        Fri, 10 Nov 2023 02:58:22 -0800 (PST)
Received: from anfanite396-Predator-PH315-51.gateway.iitmandi.ac.in ([14.139.34.101])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a178700b00277337818afsm1469131pja.0.2023.11.10.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:58:21 -0800 (PST)
From:   Dipam Turkar <dipamt1729@gmail.com>
To:     jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, airlied@gmail.com,
        Dipam Turkar <dipamt1729@gmail.com>
Subject: [PATCH] Remove custom dumb_map_offset implementations in i915 driver
Date:   Fri, 10 Nov 2023 16:28:11 +0530
Message-Id: <20231110105811.380646-1-dipamt1729@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making i915 use drm_gem_create_mmap_offset() instead of its custom
implementations for associating GEM object with a fake offset.

Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_mman.c | 192 -----------------------
 drivers/gpu/drm/i915/gem/i915_gem_mman.h |   4 -
 drivers/gpu/drm/i915/i915_driver.c       |   3 +-
 3 files changed, 2 insertions(+), 197 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index aa4d842d4c5a..6b73fe509270 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -600,198 +600,6 @@ void i915_gem_object_release_mmap_offset(struct drm_i915_gem_object *obj)
 	spin_unlock(&obj->mmo.lock);
 }
 
-static struct i915_mmap_offset *
-lookup_mmo(struct drm_i915_gem_object *obj,
-	   enum i915_mmap_type mmap_type)
-{
-	struct rb_node *rb;
-
-	spin_lock(&obj->mmo.lock);
-	rb = obj->mmo.offsets.rb_node;
-	while (rb) {
-		struct i915_mmap_offset *mmo =
-			rb_entry(rb, typeof(*mmo), offset);
-
-		if (mmo->mmap_type == mmap_type) {
-			spin_unlock(&obj->mmo.lock);
-			return mmo;
-		}
-
-		if (mmo->mmap_type < mmap_type)
-			rb = rb->rb_right;
-		else
-			rb = rb->rb_left;
-	}
-	spin_unlock(&obj->mmo.lock);
-
-	return NULL;
-}
-
-static struct i915_mmap_offset *
-insert_mmo(struct drm_i915_gem_object *obj, struct i915_mmap_offset *mmo)
-{
-	struct rb_node *rb, **p;
-
-	spin_lock(&obj->mmo.lock);
-	rb = NULL;
-	p = &obj->mmo.offsets.rb_node;
-	while (*p) {
-		struct i915_mmap_offset *pos;
-
-		rb = *p;
-		pos = rb_entry(rb, typeof(*pos), offset);
-
-		if (pos->mmap_type == mmo->mmap_type) {
-			spin_unlock(&obj->mmo.lock);
-			drm_vma_offset_remove(obj->base.dev->vma_offset_manager,
-					      &mmo->vma_node);
-			kfree(mmo);
-			return pos;
-		}
-
-		if (pos->mmap_type < mmo->mmap_type)
-			p = &rb->rb_right;
-		else
-			p = &rb->rb_left;
-	}
-	rb_link_node(&mmo->offset, rb, p);
-	rb_insert_color(&mmo->offset, &obj->mmo.offsets);
-	spin_unlock(&obj->mmo.lock);
-
-	return mmo;
-}
-
-static struct i915_mmap_offset *
-mmap_offset_attach(struct drm_i915_gem_object *obj,
-		   enum i915_mmap_type mmap_type,
-		   struct drm_file *file)
-{
-	struct drm_i915_private *i915 = to_i915(obj->base.dev);
-	struct i915_mmap_offset *mmo;
-	int err;
-
-	GEM_BUG_ON(obj->ops->mmap_offset || obj->ops->mmap_ops);
-
-	mmo = lookup_mmo(obj, mmap_type);
-	if (mmo)
-		goto out;
-
-	mmo = kmalloc(sizeof(*mmo), GFP_KERNEL);
-	if (!mmo)
-		return ERR_PTR(-ENOMEM);
-
-	mmo->obj = obj;
-	mmo->mmap_type = mmap_type;
-	drm_vma_node_reset(&mmo->vma_node);
-
-	err = drm_vma_offset_add(obj->base.dev->vma_offset_manager,
-				 &mmo->vma_node, obj->base.size / PAGE_SIZE);
-	if (likely(!err))
-		goto insert;
-
-	/* Attempt to reap some mmap space from dead objects */
-	err = intel_gt_retire_requests_timeout(to_gt(i915), MAX_SCHEDULE_TIMEOUT,
-					       NULL);
-	if (err)
-		goto err;
-
-	i915_gem_drain_freed_objects(i915);
-	err = drm_vma_offset_add(obj->base.dev->vma_offset_manager,
-				 &mmo->vma_node, obj->base.size / PAGE_SIZE);
-	if (err)
-		goto err;
-
-insert:
-	mmo = insert_mmo(obj, mmo);
-	GEM_BUG_ON(lookup_mmo(obj, mmap_type) != mmo);
-out:
-	if (file)
-		drm_vma_node_allow_once(&mmo->vma_node, file);
-	return mmo;
-
-err:
-	kfree(mmo);
-	return ERR_PTR(err);
-}
-
-static int
-__assign_mmap_offset(struct drm_i915_gem_object *obj,
-		     enum i915_mmap_type mmap_type,
-		     u64 *offset, struct drm_file *file)
-{
-	struct i915_mmap_offset *mmo;
-
-	if (i915_gem_object_never_mmap(obj))
-		return -ENODEV;
-
-	if (obj->ops->mmap_offset)  {
-		if (mmap_type != I915_MMAP_TYPE_FIXED)
-			return -ENODEV;
-
-		*offset = obj->ops->mmap_offset(obj);
-		return 0;
-	}
-
-	if (mmap_type == I915_MMAP_TYPE_FIXED)
-		return -ENODEV;
-
-	if (mmap_type != I915_MMAP_TYPE_GTT &&
-	    !i915_gem_object_has_struct_page(obj) &&
-	    !i915_gem_object_has_iomem(obj))
-		return -ENODEV;
-
-	mmo = mmap_offset_attach(obj, mmap_type, file);
-	if (IS_ERR(mmo))
-		return PTR_ERR(mmo);
-
-	*offset = drm_vma_node_offset_addr(&mmo->vma_node);
-	return 0;
-}
-
-static int
-__assign_mmap_offset_handle(struct drm_file *file,
-			    u32 handle,
-			    enum i915_mmap_type mmap_type,
-			    u64 *offset)
-{
-	struct drm_i915_gem_object *obj;
-	int err;
-
-	obj = i915_gem_object_lookup(file, handle);
-	if (!obj)
-		return -ENOENT;
-
-	err = i915_gem_object_lock_interruptible(obj, NULL);
-	if (err)
-		goto out_put;
-	err = __assign_mmap_offset(obj, mmap_type, offset, file);
-	i915_gem_object_unlock(obj);
-out_put:
-	i915_gem_object_put(obj);
-	return err;
-}
-
-int
-i915_gem_dumb_mmap_offset(struct drm_file *file,
-			  struct drm_device *dev,
-			  u32 handle,
-			  u64 *offset)
-{
-	struct drm_i915_private *i915 = to_i915(dev);
-	enum i915_mmap_type mmap_type;
-
-	if (HAS_LMEM(to_i915(dev)))
-		mmap_type = I915_MMAP_TYPE_FIXED;
-	else if (pat_enabled())
-		mmap_type = I915_MMAP_TYPE_WC;
-	else if (!i915_ggtt_has_aperture(to_gt(i915)->ggtt))
-		return -ENODEV;
-	else
-		mmap_type = I915_MMAP_TYPE_GTT;
-
-	return __assign_mmap_offset_handle(file, handle, mmap_type, offset);
-}
-
 /**
  * i915_gem_mmap_offset_ioctl - prepare an object for GTT mmap'ing
  * @dev: DRM device
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.h b/drivers/gpu/drm/i915/gem/i915_gem_mman.h
index 196417fd0f5c..253435795caf 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.h
@@ -20,10 +20,6 @@ struct mutex;
 int i915_gem_mmap_gtt_version(void);
 int i915_gem_mmap(struct file *filp, struct vm_area_struct *vma);
 
-int i915_gem_dumb_mmap_offset(struct drm_file *file_priv,
-			      struct drm_device *dev,
-			      u32 handle, u64 *offset);
-
 void __i915_gem_object_release_mmap_gtt(struct drm_i915_gem_object *obj);
 void i915_gem_object_release_mmap_gtt(struct drm_i915_gem_object *obj);
 
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index d50347e5773a..a18a33896ba4 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -42,6 +42,7 @@
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_ioctl.h>
+#include <drm/drm_gem.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 
@@ -1826,7 +1827,7 @@ static const struct drm_driver i915_drm_driver = {
 	.gem_prime_import = i915_gem_prime_import,
 
 	.dumb_create = i915_gem_dumb_create,
-	.dumb_map_offset = i915_gem_dumb_mmap_offset,
+	.dumb_map_offset = drm_gem_dumb_mmap_offset,
 
 	.ioctls = i915_ioctls,
 	.num_ioctls = ARRAY_SIZE(i915_ioctls),
-- 
2.34.1

