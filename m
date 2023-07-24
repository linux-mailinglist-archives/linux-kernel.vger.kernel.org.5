Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744DA75E9F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGXDAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGXDAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:00:09 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA5B109
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:00:08 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8Pz86D14zBRYmV
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:00:04 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690167604; x=1692759605; bh=i+p/J1h3q36a6g/06IhJYB84+UE
        C0xOcZ6JZkjXA3Lo=; b=zyFTQMQq5GOQoYlTCR5I+7oPveMvveOovQtM7Rff+om
        DyXmsLei68gN9hJ2ptbkpEuZf7wAo++qV3ce3so4nWhPmhzR+Vd2w1G5Bs5Gp/p0
        3jQu4rPbGo/yUCwxf8ieknGFSGa84PR6zasPKHytbDDinRxtEodebFZj+sg+czyK
        pG8bLaxgAPixnl8hjXXU/JMVZzya3MKL+WFjx7pnY0rzzgoxhNyITGhWiDPNLcjQ
        QJvNHpBuyz0H0oVgkMky7easjRKEFYdOwdNPLkJpiLz93uyAHqEHstW9HIiTp/Wj
        7fxOyMhcK+3UQC9rTjtxckrYO4p6B/pzeZuR2DYQrHw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FlvlwZ-k_wMB for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 11:00:04 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8Pz83VMpzBRDsQ;
        Mon, 24 Jul 2023 11:00:04 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 11:00:04 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: add missing spaces before ';'
In-Reply-To: <20230724025911.7528-1-xujianghui@cdjrlc.com>
References: <20230724025911.7528-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <6c16a6c089033849af90ad35fe86515a@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: space required after that ';' (ctx:BxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/radeon/radeon_vce.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vce.c 
b/drivers/gpu/drm/radeon/radeon_vce.c
index ca4a36464340..d1871af967d4 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -95,7 +95,7 @@ int radeon_vce_init(struct radeon_device *rdev)

  	size = rdev->vce_fw->size - strlen(fw_version) - 9;
  	c = rdev->vce_fw->data;
-	for (;size > 0; --size, ++c)
+	for (; size > 0; --size, ++c)
  		if (strncmp(c, fw_version, strlen(fw_version)) == 0)
  			break;

@@ -110,7 +110,7 @@ int radeon_vce_init(struct radeon_device *rdev)

  	size = rdev->vce_fw->size - strlen(fb_version) - 3;
  	c = rdev->vce_fw->data;
-	for (;size > 0; --size, ++c)
+	for (; size > 0; --size, ++c)
  		if (strncmp(c, fb_version, strlen(fb_version)) == 0)
  			break;
