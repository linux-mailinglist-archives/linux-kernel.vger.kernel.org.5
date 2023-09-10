Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16D479A0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 01:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjIJXo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 19:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjIJXo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 19:44:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C5118C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 16:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=psFHv5kVZjBZeSjSwTGpttOqkbU4kOzBlHIhUIId7P8=; b=caYFO9eaBmvQfAm7wMM/auiAzw
        0HYDndat46HAViXPi597CkWvxYkycwL8jH55f1Jn9XHJu8YdD854xHCvwC8dTFSoO7hk2I9SxENKm
        qWh9cbfHlrsi+LbGTegt1yumvwHVwuVaMyvs6Vj2wcGV4VUNkw39ZviVBTnNn/zvKdhjqKbtoC3dR
        W9RSiQFEYApN0LiRJYUtr6XQqjjNBrBm+t0lZVHVcEYnmFULtzu1NKcm48eT4Uq5P2uCu9nFFrOcF
        w6tkepsKUReqftkY9T8oBcPC7eInm+zpyLVEunM8Q2K+Cy3nbGQ8h2wzOEA12JgrCXSD28v2bSZ37
        HKnxgUmw==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfU6l-00GzAn-0h;
        Sun, 10 Sep 2023 23:44:51 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: fix replay_mode kernel-doc warning
Date:   Sun, 10 Sep 2023 16:44:50 -0700
Message-ID: <20230910234450.15962-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the typo in the kernel-doc for @replay_mode to prevent
kernel-doc warnings:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:623: warning: Incorrect use of kernel-doc format:          * @replay mode: Replay supported
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:626: warning: Function parameter or member 'replay_mode' not described in 'amdgpu_hdmi_vsdb_info'

Fixes: ec8e59cb4e0c ("drm/amd/display: Get replay info from VSDB")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -620,7 +620,7 @@ struct amdgpu_hdmi_vsdb_info {
 	unsigned int max_refresh_rate_hz;
 
 	/**
-	 * @replay mode: Replay supported
+	 * @replay_mode: Replay supported
 	 */
 	bool replay_mode;
 };
