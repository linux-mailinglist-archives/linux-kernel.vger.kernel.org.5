Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4FD7B4B0F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 06:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjJBEmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 00:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJBEmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 00:42:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37246B4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 21:42:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c60778a3bfso113818255ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 21:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696221734; x=1696826534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Apgh5I/AZlw1bZUGVlRw0FcB6BXkBGvFxHpXJVnA298=;
        b=iTO4Q2uu4fGWnmes6ZuhnepLkW8klHD+JytR1m2EPXAR2hJPC2pe4Oj/IZae/N1+qM
         RlhmW8u5V0U4MbP4InytmpZ2LlRqhZKsbIvwRO1fDBql7WNI1+539WD+UCgHFDxv0GdD
         4DXOoVyw6NBMhMgpG8nnPXhuHTShw6x3fRiCnTLthm/cGNon8X6KeCd5J/6y5i4yrgb4
         /IHtszLbNikBB+Ubb7RM1Y5WAb6fj+bQjpeuo8KfKG2mFVttxqy4GATZs/zyU62jttg6
         vZRzilt7r+OFc0fMlkyVRCU7x0GtEfmF35HjIqnb6XsSZRbS+/DXfz755L5/QK5Fzj2C
         yrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696221734; x=1696826534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Apgh5I/AZlw1bZUGVlRw0FcB6BXkBGvFxHpXJVnA298=;
        b=UdwZTHyi+Ky/F0ZOYvxjmKOi/EWgGXxp4K1Ye7xnQX1aMUeh0vwmLBWDe/gtloiJlT
         ypEUstIjcTak8p+0IROPo4TUafSt9n1kNwtaAf5QHuX32p0k+Gjpv5Au7w4VDk13mxDT
         ZX7+toBzdXG5J0vRMct3q0tIuw1B3/xtAnAESyCZELXj1Ixg5rJEewvE8BMlqP7Gh0m/
         J852T8GPdXu4oyCBulV7G0Flrpoa7JMI2ZXv88vc053xFipwgvWoIlXP2xNctMoxucZB
         0N3zbtCVPoFRK0i2J0nZf4gw/TAj5Gy8+13v9YYhHkcIsTafRZ95espamLKeLet+mvmC
         CrUw==
X-Gm-Message-State: AOJu0YybImCNuQ25jqaJI69woZlhZHVBXHwfwT9Abs9W2gjmt3uBqrOJ
        I2vbKiKLdcf1+G/GLoHUxvE=
X-Google-Smtp-Source: AGHT+IFFfibQl2jUVEX5S5XbCIBmeSoheGM2nkffMvC6cL/VFt9IIncdmDz+joXJ2xn+KBlnCBFneQ==
X-Received: by 2002:a17:903:428b:b0:1b8:2c6f:3248 with SMTP id ju11-20020a170903428b00b001b82c6f3248mr10461230plb.39.1696221734619;
        Sun, 01 Oct 2023 21:42:14 -0700 (PDT)
Received: from sagar-virtual-machine.localdomain ([103.157.161.86])
        by smtp.gmail.com with ESMTPSA id jj7-20020a170903048700b001c73701bd17sm7397429plb.4.2023.10.01.21.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 21:42:14 -0700 (PDT)
From:   Sagar Vashnav <sagarvashnav72427@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sagar Vashnav <sagarvashnav72427@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: add kernel docs for dc_dmub_caps
Date:   Mon,  2 Oct 2023 00:41:19 -0400
Message-Id: <20231002044126.70197-1-sagarvashnav72427@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9270c1f3-c8f3-4b3c-91ec-ed17d97ecafd@infradead.org>
References: <9270c1f3-c8f3-4b3c-91ec-ed17d97ecafd@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel documentation for the dc_dmub_caps structure.

Signed-off-by: Sagar Vashnav <sagarvashnav72427@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 81258392d..14b4c503d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -208,6 +208,16 @@ struct dc_color_caps {
 	struct mpc_color_caps mpc;
 };
 
+/**
+ * struct dc_dmub_caps - DMUB (Display Microcontroller Unit) capabilities
+ * @psr: support for PSR (Power Saving State Residency)
+ * @mclk_sw: support for MCLK_SW (Memory Clock Switch)
+ * @subvp_psr: support for SUBVP PSR (Sub-Viewport Power Saving State Residency)
+ * @gecc_enable: GECC (Global Error Correcting Code) enablement.
+ *
+ * This structure describes the capabilities of the Display Microcontroller Unit (DMUB).
+ * It specifies whether certain features like PSR and MCLK_SW are supported.
+ */
 struct dc_dmub_caps {
 	bool psr;
 	bool mclk_sw;
-- 
2.34.1

