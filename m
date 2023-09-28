Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6457B25DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjI1TRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjI1TRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE59419D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695928591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=23hYikUdaRtGRVcpuaZcOKkjmtKH+z+s0tfM+DCpReY=;
        b=BZSGhsvCq3KKncaRzL8YWHHYVDrx4STLy7tjJmJHS0SrkXBKw/HEtIvF4SNVSfjApsU1md
        yoPZNfZCTOzLfDq0ZyLdRXS6XWv8zHnylGh+CTTNpSRAnekQjbnua13QEEGVFWoIzX/tyr
        baPZDbtq/uPW+sHoav9EowWsuiZ/BoI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-kojMsZAGMAyUsMWAiPx88w-1; Thu, 28 Sep 2023 15:16:29 -0400
X-MC-Unique: kojMsZAGMAyUsMWAiPx88w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a621359127so1142562966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695928588; x=1696533388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23hYikUdaRtGRVcpuaZcOKkjmtKH+z+s0tfM+DCpReY=;
        b=KWIejPRt0P9qGzPX/wAqLifluDLOR2XmRFpruIJKuOV4HxPST9wnrXlM4zVy8WvtEL
         n9jNdr+Tz180t8mxloA6Dfvk+oc5WGz+PFL2RUjiX77aSI5AANuNultoUKVWkm3VWTs2
         dmxqMkTptSdqr1NfopJwioNO4TRUNGYLgfNIvFF2qYtbVGhXv/7ade34ziMgiTdcQiHU
         rKMLl+X54JSkIBs7IJHZUitl7PySS5bJzlfBNwjBoizPJunRbVwfNiPzmCgNzS3vE2zY
         fABkjIhDXgyvS+QlGVe2ZQ/2fcWA1q/bhP8AppNzE5zY3rpWSkXd2vtOCWtZtRkWckwJ
         af6A==
X-Gm-Message-State: AOJu0YxOugfOJgIY0Em8xWhElHCCMLjBOXStna5yJvPErG9URhFaNBIY
        e52mDblq8ZEn8ULD1+axy0anzAtBzGfUxCwr8qEzV4S+6Edqc7kn1Rxn4yrG9a9pZey13PbfYsl
        U+0hbw44Br7xjztijL9xM/o8UrKb1OivA
X-Received: by 2002:a17:906:7494:b0:9b2:8323:d916 with SMTP id e20-20020a170906749400b009b28323d916mr1849417ejl.17.1695928588282;
        Thu, 28 Sep 2023 12:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcc7rpRWbFx8dTtTXWIuL3BtbBej/D3KE1229rLnvopnKPsf54bJU+nNKXQeP7SwQjHIpBww==
X-Received: by 2002:a17:906:7494:b0:9b2:8323:d916 with SMTP id e20-20020a170906749400b009b28323d916mr1849392ejl.17.1695928587868;
        Thu, 28 Sep 2023 12:16:27 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709061b1a00b0099bc08862b6sm11446090ejg.171.2023.09.28.12.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 12:16:27 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v5 0/6] [RFC] DRM GPUVM features
Date:   Thu, 28 Sep 2023 21:16:14 +0200
Message-ID: <20230928191624.13703-1-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently GPUVM offers common infrastructure to track GPU VA allocations
and mappings, generically connect GPU VA mappings to their backing
buffers and perform more complex mapping operations on the GPU VA space.

However, there are more design patterns commonly used by drivers, which
can potentially be generalized in order to make GPUVM represent the
basis of a VM implementation. In this context, this patch series aims at
generalizing the following elements.

1) Provide a common dma-resv for GEM objects not being used outside of
   this GPU-VM.

2) Provide tracking of external GEM objects (GEM objects which are
   shared with other GPU-VMs).

3) Provide functions to efficiently lock all GEM objects dma-resv the
   GPU-VM contains mappings of.

4) Provide tracking of evicted GEM objects the GPU-VM contains mappings
   of, such that validation of evicted GEM objects is accelerated.

5) Provide some convinience functions for common patterns.

The implementation introduces struct drm_gpuvm_bo, which serves as abstraction
combining a struct drm_gpuvm and struct drm_gem_object, similar to what
amdgpu does with struct amdgpu_bo_vm. While this adds a bit of complexity it
improves the efficiency of tracking external and evicted GEM objects.

This patch series is also available at [3].

[1] https://gitlab.freedesktop.org/nouvelles/kernel/-/commits/gpuvm-next

Changes in V2:
==============
  - rename 'drm_gpuva_manager' -> 'drm_gpuvm' which generally leads to more
    consistent naming
  - properly separate commits (introduce common dma-resv, drm_gpuvm_bo
    abstraction, etc.)
  - remove maple tree for tracking external objects, use a list drm_gpuvm_bos
    per drm_gpuvm instead
  - rework dma-resv locking helpers (Thomas)
  - add a locking helper for a given range of the VA space (Christian)
  - make the GPUVA manager buildable as module, rather than drm_exec
    builtin (Christian)

Changes in V3:
==============
  - rename missing function and files (Boris)
  - warn if vm_obj->obj != obj in drm_gpuva_link() (Boris)
  - don't expose drm_gpuvm_bo_destroy() (Boris)
  - unlink VM_BO from GEM in drm_gpuvm_bo_destroy() rather than
    drm_gpuva_unlink() and link within drm_gpuvm_bo_obtain() to keep
    drm_gpuvm_bo instances unique
  - add internal locking to external and evicted object lists to support drivers
    updating the VA space from within the fence signalling critical path (Boris)
  - unlink external objects and evicted objects from the GPUVM's list in
    drm_gpuvm_bo_destroy()
  - add more documentation and fix some kernel doc issues

Changes in V4:
==============
  - add a drm_gpuvm_resv() helper (Boris)
  - add a drm_gpuvm::<list_name>::local_list field (Boris)
  - remove drm_gpuvm_bo_get_unless_zero() helper (Boris)
  - fix missing NULL assignment in get_next_vm_bo_from_list() (Boris)
  - keep a drm_gem_object reference on potential vm_bo destroy (alternatively we
    could free the vm_bo and drop the vm_bo's drm_gem_object reference through
    async work)
  - introduce DRM_GPUVM_RESV_PROTECTED flag to indicate external locking through
    the corresponding dma-resv locks to optimize for drivers already holding
    them when needed; add the corresponding lock_assert_held() calls (Thomas)
  - make drm_gpuvm_bo_evict() per vm_bo and add a drm_gpuvm_bo_gem_evict()
    helper (Thomas)
  - pass a drm_gpuvm_bo in drm_gpuvm_ops::vm_bo_validate() (Thomas)
  - documentation fixes

Changes in V5:
==============
  - use a root drm_gem_object provided by the driver as a base for the VM's
    common dma-resv (Christian)
  - provide a helper to allocate a "dummy" root GEM object in case a driver
    specific root GEM object isn't available
  - add a dedicated patch for nouveau to make use of the GPUVM's shared dma-resv
  - improve documentation (Boris)
  - the following patches are removed from the series, since they already landed
    in drm-misc-next
    - f72c2db47080 ("drm/gpuvm: rename struct drm_gpuva_manager to struct drm_gpuvm")
    - fe7acaa727e1 ("drm/gpuvm: allow building as module")
    - 78f54469b871 ("drm/nouveau: uvmm: rename 'umgr' to 'base'")

Danilo Krummrich (6):
  drm/gpuvm: add common dma-resv per struct drm_gpuvm
  drm/gpuvm: add drm_gpuvm_flags to drm_gpuvm
  drm/gpuvm: add an abstraction for a VM / BO combination
  drm/gpuvm: track/lock/validate external/evicted objects
  drm/nouveau: make use of the GPUVM's shared dma-resv
  drm/nouveau: use GPUVM common infrastructure

 drivers/gpu/drm/drm_gpuvm.c             | 1036 +++++++++++++++++++++--
 drivers/gpu/drm/nouveau/nouveau_bo.c    |   15 +-
 drivers/gpu/drm/nouveau/nouveau_bo.h    |    5 +
 drivers/gpu/drm/nouveau/nouveau_exec.c  |   52 +-
 drivers/gpu/drm/nouveau/nouveau_exec.h  |    4 -
 drivers/gpu/drm/nouveau/nouveau_gem.c   |   10 +-
 drivers/gpu/drm/nouveau/nouveau_sched.h |    4 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c  |  183 ++--
 drivers/gpu/drm/nouveau/nouveau_uvmm.h  |    1 -
 include/drm/drm_gem.h                   |   32 +-
 include/drm/drm_gpuvm.h                 |  465 +++++++++-
 11 files changed, 1625 insertions(+), 182 deletions(-)


base-commit: a4ead6e37e3290cff399e2598d75e98777b69b37
-- 
2.41.0

