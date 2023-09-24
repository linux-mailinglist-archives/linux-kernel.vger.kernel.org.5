Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06217AC89D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjIXNSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjIXNSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:18:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5097A1BFB;
        Sun, 24 Sep 2023 06:17:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64386C433C8;
        Sun, 24 Sep 2023 13:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561434;
        bh=vuLQUyedGq0x4DONjqzds8NBXv337ROtROrvDAx3/00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ky9W8XDsRcTESn7+oC0UPO87QWi6mV2nESEBfQcGVSQMzWZoYZEfdU6XmGH+Djmz/
         ez3Y2XpQtOX2Nng0tpB+4+5kl1Nj6ySvleWuCT3jf0A7FPzPhqcM/AgU3YOODERY/q
         AxKoKmFCp/IGDccqZU4lGLWECxhQ6131ZqkUt7NpdmBAqEpxTHo6Q3VmdAAHAClqV+
         xE01auskTFOiyEheunFyARMzGNMcxRIwM0KcRekK9h76fk16Rk1X0y/F3vFgqKToCN
         n+zzqn5cRt53W8qp7oQvfor4khrc6aJkeSc+L+9IH4PCooMj7Bh+FmGAL3GRdwPqKB
         ofswwaeH8Nizg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Timmy Tsai <timmtsai@amd.com>, Sasha Levin <sashal@kernel.org>,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, Likun.Gao@amd.com, yifan1.zhang@amd.com,
        kenneth.feng@amd.com, saleemkhan.jamadar@amd.com,
        Jane.Jian@amd.com, shane.xiao@amd.com, sunran001@208suo.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 29/41] drm/amdgpu/soc21: don't remap HDP registers for SR-IOV
Date:   Sun, 24 Sep 2023 09:15:17 -0400
Message-Id: <20230924131529.1275335-29-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 1832403cd41ca6b19b24e9d64f79cb08d920ca44 ]

This matches the behavior for soc15 and nv.

Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Timmy Tsai <timmtsai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index e5e5d68a4d702..1a5ffbf884891 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -786,7 +786,7 @@ static int soc21_common_hw_init(void *handle)
 	 * for the purpose of expose those registers
 	 * to process space
 	 */
-	if (adev->nbio.funcs->remap_hdp_registers)
+	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
-- 
2.40.1

