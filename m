Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D6A774E30
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjHHWWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHHWWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:22:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EA1E64
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:22:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C236766071E0;
        Tue,  8 Aug 2023 23:22:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691533368;
        bh=5SDjhQMDm26ufFacwMtrPXYKPBi6NVFzvYKGHSHP5T8=;
        h=From:To:Cc:Subject:Date:From;
        b=JI2dpb94v0ahhW3yz2OoaSdcrGzIRriXFBJNEFEum+6b5q4mir5WfbaG+iS48/PaE
         IMEV8ada+23MguCmu2amYAEonW8Oh0tZ0WN3pKePxbJzFUwBlwXdP6D+gMQO1icuK0
         ZizBcqO9DBnrPoXRD1nrmJP2NQi0CpwZhRjG0NrkdcjqeWElJRLeZQvyVgxgMZ5yQY
         0seqzIiq1DdkHw1PcIw/VRoNvqd55jUEj5cx7R69uA7hW1d5mfn2jSgHrEeVKUYMR5
         Ph78g5jCY8bLrZ6eG+VU0rroyik9dtK6p4d7VtarlhFAvYDZDT0nqrhCfMz97Iclf5
         qmkDGKGI2fgZA==
From:   =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To:     robh@kernel.org, steven.price@arm.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, adrian.larumbe@collabora.com
Subject: [PATCH 0/2] Add fdinfo support to Panfrost
Date:   Tue,  8 Aug 2023 23:22:37 +0100
Message-ID: <20230808222240.1016623-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds basic fdinfo support to the Panfrost DRM driver.
It will display a series of key:value pairs under /proc/pid/fdinfo/fd
for render processes that open the Panfrost DRM file.

The pairs contain basic drm gpu engine and memory region information that
can either be cat by a privileged user or accessed with IGT's gputop
utility.

Adrián Larumbe (2):
  drm/panfrost: Add fdinfo support to Panfrost
  drm/panfrost: Add drm memory stats display through fdinfo

 drivers/gpu/drm/panfrost/panfrost_device.c | 12 +++++++
 drivers/gpu/drm/panfrost/panfrost_device.h | 10 ++++++
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 40 ++++++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_gem.c    | 16 +++++++++
 drivers/gpu/drm/panfrost/panfrost_gem.h    |  1 +
 drivers/gpu/drm/panfrost/panfrost_job.c    |  6 ++++
 drivers/gpu/drm/panfrost/panfrost_job.h    |  3 ++
 7 files changed, 85 insertions(+), 3 deletions(-)

-- 
2.41.0

