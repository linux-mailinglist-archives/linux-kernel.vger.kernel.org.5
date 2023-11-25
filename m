Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623537F8F48
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 21:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjKYUzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 15:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjKYUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 15:55:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7530C5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 12:55:41 -0800 (PST)
Received: from sobremesa.fritz.box (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 54CB86602F2E;
        Sat, 25 Nov 2023 20:55:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700945740;
        bh=d0hv3YyRAgqiF4M37fzP8Ro2Ds0NYvFuhF+NO43K8yo=;
        h=From:To:Cc:Subject:Date:From;
        b=PYFXWcqlaFIhqfWxjCWnAqrGxvf9qhGqJWkGGEQX4Td2rhjSPojxrreqGZZFi0tLI
         RbctpvuWVUwxujJ9HgRCI3NXBZ0qyJ69ESSr2SDrIZ/iQ2qhwRZ4x9mT+2q6PtIpV2
         rdIWgNIs0HqP58e25YPkRPssTz+Qw6isU7+3unEj10slEORnM+CZKg4vv4u34/fNJo
         E+1ZRaGoldtufBXk7aajVMx97naRox+rocY9BHcfpX4nj0Lk5mt3B0N3/dSHhx/bF1
         3IDz8TI3LR7PH2YvOAr6BVJQAXkQP74AsZyxERyreRQIh9dYzLs7YrBTezVAYPrFgj
         6YzksXs6X56EQ==
From:   =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 0/2] Panfrost devfreq and GEM status fixes
Date:   Sat, 25 Nov 2023 20:52:01 +0000
Message-ID: <20231125205438.375407-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During recent development of the Mali CSF GPU Panthor driver, a user
noticed that GPU frequency values as reported by fdinfo were
incorrect. This was traced back to incorrect handling of frequency value
updates. The same problem was seen in Panfrost.

Also one should consider GEM objects from a dma-buf import as being
resident in system memory, so that this can be reflected on fdinfo.

Adrián Larumbe (2):
  drm/panfrost: Consider dma-buf imported objects as resident
  drm/panfrost: Fix incorrect updating of current device frequency

 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 17 +++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_gem.c     |  2 +-
 2 files changed, 16 insertions(+), 3 deletions(-)


base-commit: 38f922a563aac3148ac73e73689805917f034cb5
-- 
2.42.0

