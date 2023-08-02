Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F45F76D07C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjHBOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjHBOsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:48:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA157196
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:47:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bbdc05a93bso43764115ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690987678; x=1691592478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=34jvrY9iaBvcRp6RfXdi/NZwehC55dKloV135LCo6Q4=;
        b=ApOIy6Oof+Qo/7c+FEtdZW+BbrbkSOoTTUlpREhL52s9a/El38htUsBtKsr3weJLV2
         +dXMUNVFK2+BE/xrnKRHAvNi9FIBpWXkaWXaTtXCl42zHmAoBHaN6lSMr9nZMOEIOlD5
         3y/xyRf8LbatSRznjLxKSft9jkvkndOkzb/hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690987678; x=1691592478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34jvrY9iaBvcRp6RfXdi/NZwehC55dKloV135LCo6Q4=;
        b=O1SfcsoVIfHUzaUtXYDoKl7fQEhXvyfmmBbD+6AyaCXUMBLAuNiPhwxod9n5EpIz1H
         xOYcQdk4YyWcQShReNWhHuVOXkEGjy8ptWTYlwJW6RGnC/dJ65hpy0ksRh0Rhg6/6G/2
         8VS2i8NOV6evXITrOMzhIPG56W+TTH+BhRnGxxq4alOxlo0PHB+BlUgi/ueRP46IaXlp
         uFNp5IPEnSzwP3cdAJbaKOJLXRfUcYWYVrvySjHFTjlPEVuJREKwIdSBFOWUAv3D1TLs
         cFeSOhgZS06ypib/r4KgnWmLBQ/fNml21fzYqjG9CUAlxWtoOQOwwGdPH3zvm8NlUTUn
         3cLw==
X-Gm-Message-State: ABy/qLYtHdSJQqicPrR8FNDjAkUXrFge2H+28yiLSw67666HZso4V++z
        a1GxCIVmHh0PA7BfrOCNQ6c73g==
X-Google-Smtp-Source: APBJJlFPjUDZubqVQL75MLrA9AfOwS26wqtyyCObOSfWkCHMjUe1pBsewbKiHvHWQOXGvHbT0dlkoQ==
X-Received: by 2002:a17:902:ed8c:b0:1b8:28f6:20e6 with SMTP id e12-20020a170902ed8c00b001b828f620e6mr13850468plj.34.1690987678407;
        Wed, 02 Aug 2023 07:47:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:6fae:ec4e:7f84:d593])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001b89891bfc4sm12524139plc.199.2023.08.02.07.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 07:47:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/panel: Fix kernel-doc typo for `follower_lock`
Date:   Wed,  2 Aug 2023 07:47:27 -0700
Message-ID: <20230802074727.1.I4036706ad5e7f45e80d41b777164258e52079cd8@changeid>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the kernel doc for the `follower_lock` member of `struct drm_panel`
there was a typo where it was called `followers_lock`. This resulted
in a warning when making "htmldocs":

  ./include/drm/drm_panel.h:270: warning:
  Function parameter or member 'follower_lock' not described in 'drm_panel'

Fix the typo.

Fixes: de0874165b83 ("drm/panel: Add a way for other devices to follow panel state")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/r/20230802142136.0f67b762@canb.auug.org.au
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/drm/drm_panel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index d6c73f79c131..10015891b056 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -238,7 +238,7 @@ struct drm_panel {
 	struct list_head followers;
 
 	/**
-	 * @followers_lock:
+	 * @follower_lock:
 	 *
 	 * Lock for followers list.
 	 */
-- 
2.41.0.585.gd2178a4bd4-goog

