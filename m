Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBED7990C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjIHUD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjIHUDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1CB170E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694203364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CVUWiNi0XyDqlB1JxyjZ0R/Ir5gIUCrvEGnFOU6/cQM=;
        b=fp0PpOJsLp1iRy9m7EjVpqrkGG/hoSvW/43Vo1Bg+As/g5rhJPU/tVPoNuv4165ctt9iAi
        Hk463BJN+RyUMVgIyONsFZdzAFDZjrjWu6+LqZF009Couvv4sEupbO1KeY36tuwjBcT/mp
        hbrMqaWGcuWcw0iJ+uFWcgyextIXPEc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-1aNggRKnM2Sp07IByhg2tg-1; Fri, 08 Sep 2023 16:02:43 -0400
X-MC-Unique: 1aNggRKnM2Sp07IByhg2tg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4122119722eso4980241cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 13:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203362; x=1694808162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVUWiNi0XyDqlB1JxyjZ0R/Ir5gIUCrvEGnFOU6/cQM=;
        b=woze+hC4DpRE6YMOHRUuH1EMeOs3Y9+ZPYXJ4GhxjUhJ2lLI5IB2Q+7PKvmfGWFoJp
         siDGxhUGVwMqhSsnZA0vk124v6+yt5Wetp4LVFrJ9y17BVt7kBQ3e+FNAKvmL9xNI/Ld
         Ob/68wd/yiALLkLsWz1Ltv/9eXHV1TFDxb3+27u9LNkOhQy37uzH1IYLGgcxirmxkn3Q
         K/vkYdNLjbnBqWLLu2HgtCQAi/af8lstThW329y8QWktfUXDqLzdpoJ16Xh7JsDSpHuO
         hRbGGzTLhwtEFXNj0pxnW20OLS/B7317qoDa2LZSKzBdCEYC7XQkRrJn/WyIhHR9pHUe
         Oecg==
X-Gm-Message-State: AOJu0YzvniRhgJTf0JmSnn41vYMLVYKItSSAvPpXbebMoEwnoMJF3rqA
        SxgYJxi/q/UuBFHPUdcZ2hSqPbO3jvrYWURZgdfcJvYEYeLsimaet/1yTaypfv1c6PECrJ8xmId
        6bmhD5OEhx5Z4jGzOalo6B8Ca
X-Received: by 2002:a05:622a:1915:b0:412:1c5f:4781 with SMTP id w21-20020a05622a191500b004121c5f4781mr4701183qtc.4.1694203362639;
        Fri, 08 Sep 2023 13:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuiGnmMFWAKLSh30zPQGkgvOkX4VTvQk/17jsSVc5WjoNTNjt80rBc5lL7G+qjPScKuI3czQ==
X-Received: by 2002:a05:622a:1915:b0:412:1c5f:4781 with SMTP id w21-20020a05622a191500b004121c5f4781mr4701161qtc.4.1694203362351;
        Fri, 08 Sep 2023 13:02:42 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id jm8-20020a05622a750800b003f9c6a311e1sm840078qtb.47.2023.09.08.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:02:42 -0700 (PDT)
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
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2 0/5] Introduce new wrappers to copy user-arrays
Date:   Fri,  8 Sep 2023 21:59:39 +0200
Message-ID: <cover.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
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

Hi!

David Airlie suggested that we could implement new wrappers around
(v)memdup_user() for duplicating user arrays.

This small patch series first implements the two new wrapper functions
memdup_array_user() and vmemdup_array_user(). They calculate the
array-sizes safely, i.e., they return an error in case of an overflow.

It then implements the new wrappers in two components in kernel/ and two
in the drm-subsystem.

In total, there are 18 files in the kernel that use (v)memdup_user() to
duplicate arrays. My plan is to provide patches for the other 14
successively once this series has been merged.


Changes since v1:
- Insert new headers alphabetically ordered
- Remove empty lines in functions' docstrings
- Return -EOVERFLOW instead of -EINVAL from wrapper functions


@Andy:
I test-build it for UM on my x86_64. Builds successfully.
A kernel build (localmodconfig) for my Fedora38 @ x86_64 does also boot
fine.

If there is more I can do to verify the early boot stages are fine,
please let me know!

P.

Philipp Stanner (5):
  string.h: add array-wrappers for (v)memdup_user()
  kernel: kexec: copy user-array safely
  kernel: watch_queue: copy user-array safely
  drm_lease.c: copy user-array safely
  drm: vmgfx_surface.c: copy user-array safely

 drivers/gpu/drm/drm_lease.c             |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +--
 include/linux/string.h                  | 40 +++++++++++++++++++++++++
 kernel/kexec.c                          |  2 +-
 kernel/watch_queue.c                    |  2 +-
 5 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.41.0

