Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFDD78A761
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjH1IQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjH1IQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:16:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE7711B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:16:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc63ef9959so22472075ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693210580; x=1693815380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hD5oyc91zexss8iplnmDih5E3tUKOUqVxVKR2VyNeyI=;
        b=ftU2e2RdnDVfMD3FFMtiZay9w1igiZJvdLHjDzCZh2mDV2QjnqogxSUgA6/k6VGMhq
         EeCSYBef2LnimoHeQ5Lqv4gF/OkvVzBkDiQP1lux4TIzjYdg/cyozutpMmCBOA5zHA8O
         tpjXilUIrGqCYS6rPg1dfCtvezEQ4qRhoS1Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693210580; x=1693815380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hD5oyc91zexss8iplnmDih5E3tUKOUqVxVKR2VyNeyI=;
        b=UNbWoKEO1Wx8veiLkZzLkDi/VKDTpIhfDjR4lFhOgFoblKh2cuwwBKbcl39Gh8SxI8
         lIoLGL8VyzlB5FLUFanOk/TLuloZNVdNPbTbUdH946AvcDf6wSHwUn7AIdCmYe69N457
         HoaHZle0vDzJZx6z40yN5ce5oIXZbVu4wHfSorU+nLxZYiBKNWzYO6uAEDXrsfMSIGtk
         XgEKuXGnmLiR5QMZyy1dqK/kCtxQygUdq0PbVvd7zRSFkDS6n+PofOSWktVEqqaMM6l/
         BovIBcdwRyRPFM+qYEam7BsJx3QcrfasoT3tYU3PK2NAV5YxiKM4niyWs5biIIp8pNnV
         oReA==
X-Gm-Message-State: AOJu0Yxny8JlbnTUxftAtYRUOfF43DV93fPqZOKM5Q7Bn3BQxjTyVtMI
        JgebbZz1A63uw06GyUBTOj/5iQ==
X-Google-Smtp-Source: AGHT+IHBCRkOdvz3bICLpxgNzt2TpU53Ks2o85GsbfP1PoYC+pS6KkoDT91ML3hyAlpG+R91OrKFyw==
X-Received: by 2002:a17:903:4c5:b0:1bd:ec9e:59fe with SMTP id jm5-20020a17090304c500b001bdec9e59femr23569151plb.68.1693210579906;
        Mon, 28 Aug 2023 01:16:19 -0700 (PDT)
Received: from datalore.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id jh12-20020a170903328c00b001bf5c12e9fesm6676568plb.125.2023.08.28.01.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 01:16:19 -0700 (PDT)
From:   Brandon Pollack <brpol@chromium.org>
To:     marius.vlad@collabora.com, jshargo@chromium.org
Cc:     corbet@lwn.net, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mairacanal@riseup.net,
        melissa.srw@gmail.com, mripard@kernel.org,
        rodrigosiqueiramelo@gmail.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mduggan@chromium.org,
        hirono@chromium.org, Brandon Pollack <brpol@chromium.org>
Subject: [v5,0/7] Adds support for ConfigFS to VKMS!
Date:   Mon, 28 Aug 2023 08:14:42 +0000
Message-ID: <20230828081609.3572937-1-brpol@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Jim is busy with other work and I'm working on some things that
rely on this, I've taken up the task of doing the iterations.  I've
addressed the comments as best I can (those replies are to each
individual change) and here is the patch set to go with those.

I added my own signoff to each commit, but I've left jshargo@ as the
author of all the commits he wrote.  I'm sure there is still more to
address and the ICT tests that were writtein parallel to this may also
need some additions, but I'm hoping we're in a good enough state to get
this in and iterate from there soon.

Since V5:
========
Fixed some bad merge conflicts and locking behaviours as well as
clarified some documentation, should be good to go now :)

Since V4:
========
Fixed up some documentation as suggested by Marius
Fixed up some bad locking as suggested by Marius
Small fixes here and there (most have email responses to previous chain
emails)

Since V3:
========
I've added hotplug support in the latest patch.  This has been reviewed some
and the notes from that review are addressed here as well.

Relevant/Utilizing work:
=======================
I've built a while test framework based on this as proof it functions (though
I'm sure there may be lingering bugs!).  You can check that out on
crrev.com if you are interested and need to get started yourself (but be
aware of any licensing that may differ from the kernel itself!  Make
sure you understand the license:

https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/tast-tests/LICENSE

That said, you can see the changes in review on the crrev gerrit:

https://chromium-review.googlesource.com/c/chromiumos/platform/tast-tests/+/4666669

Outro:
=====
I really appreciate everyone's input and tolerance in getting these
changes in.  Jim's first patch series was this, and other than some
small cleanups and documentation, taking over it is also mine.

Thank you everyone :)

Brandon Pollack (1):
  drm/vkms Add hotplug support via configfs to VKMS.

Jim Shargo (6):
  drm/vkms: Back VKMS with DRM memory management instead of static
    objects
  drm/vkms: Support multiple DRM objects (crtcs, etc.) per VKMS device
  drm/vkms: Provide platform data when creating VKMS devices
  drm/vkms: Add ConfigFS scaffolding to VKMS
  drm/vkms: Support enabling ConfigFS devices
  drm/vkms: Add a module param to enable/disable the default device

 Documentation/gpu/vkms.rst            |  20 +-
 drivers/gpu/drm/Kconfig               |   1 +
 drivers/gpu/drm/vkms/Makefile         |   1 +
 drivers/gpu/drm/vkms/vkms_composer.c  |  30 +-
 drivers/gpu/drm/vkms/vkms_configfs.c  | 721 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_crtc.c      | 102 ++--
 drivers/gpu/drm/vkms/vkms_drv.c       | 206 +++++---
 drivers/gpu/drm/vkms/vkms_drv.h       | 182 +++++--
 drivers/gpu/drm/vkms/vkms_output.c    | 405 +++++++++++++--
 drivers/gpu/drm/vkms/vkms_plane.c     |  44 +-
 drivers/gpu/drm/vkms/vkms_writeback.c |  31 +-
 11 files changed, 1508 insertions(+), 235 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c

-- 
2.42.0.rc1.204.g551eb34607-goog

