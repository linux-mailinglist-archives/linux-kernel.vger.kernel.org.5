Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B51D7CBF70
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjJQJat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjJQJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:29:38 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4F119AE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Zoyx6acph8T/D4cDNkRj+Bxu58arAqE6Znc8aS28M0U=; b=pG1JKIecF2BtvDA1vVl9uxnEb0
        tsGe52hITAfAs+Sn4Hm7ycaFLwRLFA9I805pa/f2ozAqSfs1xZDYk8zW6uRcZbeR3XXCyHXizeeU5
        u9Vo6KxtT9B1UORnieFMmwT/XL4M3Ss5L9Iht5UdQcYHYE2um1anYmPrGpXEC8Ag9WPcIPSpFNDc/
        4WxivlCutLspGIGkN9/S9GLzSZoXz4mNIPYN06AZLIVWB420p6pznXNck3+rRuj7K2eqo5lHpGXAB
        nWkJpZQUAXH5wYCTDuDICorsD3kHQ1TyoMCJUl/94FCf7nKUhAd2Msm51pRpYvjIzDAumK0gtpQTI
        SAlOAGxQ==;
Received: from 167.red-81-39-185.dynamicip.rima-tde.net ([81.39.185.167] helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qsgNf-001ODF-7B; Tue, 17 Oct 2023 11:28:51 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Pekka Paalanen" <ppaalanen@gmail.com>, hwentlan@amd.com,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, joshua@froggi.es,
        Simon Ser <contact@emersion.fr>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v7 6/6] amd/display: indicate support for atomic async page-flips on DC
Date:   Tue, 17 Oct 2023 11:28:37 +0200
Message-ID: <20231017092837.32428-7-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017092837.32428-1-andrealmeid@igalia.com>
References: <20231017092837.32428-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Ser <contact@emersion.fr>

amdgpu_dm_commit_planes() already sets the flip_immediate flag for
async page-flips. This flag is used to set the UNP_FLIP_CONTROL
register. Thus, no additional change is required to handle async
page-flips with the atomic uAPI.

Signed-off-by: Simon Ser <contact@emersion.fr>
Reviewed-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9d5742923aed..c6fd34bab358 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3997,7 +3997,6 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 		adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 	/* indicates support for immediate flip */
 	adev_to_drm(adev)->mode_config.async_page_flip = true;
-	adev_to_drm(adev)->mode_config.atomic_async_page_flip_not_supported = true;
 
 	state = kzalloc(sizeof(*state), GFP_KERNEL);
 	if (!state)
-- 
2.42.0

