Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6843C78DC62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbjH3Spd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244703AbjH3NrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E765AC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693403184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PzqfQ88022ZJBnlN9XJGH4Rch2pPLUTbjECBn8E9VEk=;
        b=Ztml5sFOOPQeYDksDDIoM+No/re9m3mOrxv3ddiUB4Z3lBKHwHghwl3qeUh82qhXM+40Iz
        T90dfwSKyHSkWQIiJxWVzktT07WtLYPFFRrR9i0QKkUCcW26wLyifDS/bT35xnJ9x0NjiU
        7sf7R6/X/gtEJil8j1RmzFRqnpVaQd8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-5qmow3ZUNlKsJGgiqqG8rQ-1; Wed, 30 Aug 2023 09:46:23 -0400
X-MC-Unique: 5qmow3ZUNlKsJGgiqqG8rQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9cca3c395so19428221fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403181; x=1694007981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzqfQ88022ZJBnlN9XJGH4Rch2pPLUTbjECBn8E9VEk=;
        b=FTNsXQ5c51Kkd2cyOxIpgKt5Kp18imwHLd43dKTlsLXHaacz2O/ly28KgH99vr3ER7
         hcH/5OL+6JPf3iYKyrN7EZCrb2vt6A7H6AaeyCpKd4+9w6VUNdvvAYA426cZ8ccF4NE+
         dX05Y7NkZkXi3XDdBkobKg5ASPUXts+PjB6n3DfNuZyto+DTsBa++LbaJgKkNWsQT3jy
         o21LqeENLEq6tR4SrB6Rfi0qzPP44+Tu78eGQE+6Jvjr6v5EDvkheM/d46ZsACrEcGQl
         dpPLkBVrhbwTL4pU4Zdsr4slBL/V3KPhIVMXiqc1RtwNu688Y3ROTOgURk/rO62qVS05
         /Sbg==
X-Gm-Message-State: AOJu0YwBZoUzvI50DNmFsc72FjF8Pheg/cFh6QKhGhVVkwEc/JjSSm+W
        5RAF/k97Y8ibF09G16gu7NKPcKSruqAgIip6eqNDayfu2vALJA37zhSKzGuwnUZWoBfDtyHvk5M
        eTut1eIASUjsFlN6hpiz1Nu7i
X-Received: by 2002:a05:651c:201b:b0:2bb:8d47:9d95 with SMTP id s27-20020a05651c201b00b002bb8d479d95mr1564052ljo.2.1693403181697;
        Wed, 30 Aug 2023 06:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj7gH1IKBMS0NWbE4Xd4vUNDX4WI+F2xE2mn0UylTciMqkBXPKro8KLHlIW5rak33HRcstNQ==
X-Received: by 2002:a05:651c:201b:b0:2bb:8d47:9d95 with SMTP id s27-20020a05651c201b00b002bb8d479d95mr1564026ljo.2.1693403181300;
        Wed, 30 Aug 2023 06:46:21 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709063e5a00b009829dc0f2a0sm7174346eji.111.2023.08.30.06.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:20 -0700 (PDT)
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
Subject: [PATCH 0/5] Introduce new wrappers to copy user-arrays
Date:   Wed, 30 Aug 2023 15:45:51 +0200
Message-ID: <cover.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

P.

Philipp Stanner (5):
  string.h: add array-wrappers for (v)memdup_user()
  kernel: kexec: copy user-array safely
  kernel: watch_queue: copy user-array safely
  drm_lease.c: copy user-array safely
  drm: vmgfx_surface.c: copy user-array safely

 drivers/gpu/drm/drm_lease.c             |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +--
 include/linux/string.h                  | 42 +++++++++++++++++++++++++
 kernel/kexec.c                          |  2 +-
 kernel/watch_queue.c                    |  2 +-
 5 files changed, 48 insertions(+), 6 deletions(-)

-- 
2.41.0

