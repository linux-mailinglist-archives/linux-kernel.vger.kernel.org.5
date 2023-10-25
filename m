Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01E17D6F17
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344682AbjJYOFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjJYOFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:05:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE7513A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:05:09 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-694ed847889so4958520b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698242708; x=1698847508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QodZ+zOhRS9ysFD14TPJp+ufF/L2P9im5K7i5cATYBY=;
        b=hudgD1emcNiA16lRY//vaOqa56L+tLa2ZeqGpSeCkzV/oLU+VvgTJrE7YlFJ4bYue0
         b7Tt5mjnTLmrpjuHQ21roYCWfq9Le0+RvD25UJZx0JPnZLvJfX/yHszeEAZ9T/QxHtDn
         TuO+NNdKfcjzK9Z+nAOoCRjqvUw+dsenXiRTzVPB7NOJIzkvMyj0IgF29ZILiAVg8RJE
         OTFh13CoYNCoshjWOek7ks7Nyhv2AAZgvotWJDyLUe8ulwy42ASJP+2Pqv9witBOxfdp
         rVr8eXUCkOnf3VnZndkF51JJ/WyTsYuY8MH+zvs8noKwY39UnDnZ+8WmYECTm51ZjE0x
         soDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242708; x=1698847508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QodZ+zOhRS9ysFD14TPJp+ufF/L2P9im5K7i5cATYBY=;
        b=HQBHO9dLKN8hI/lsZ4Clk1oMVHLsxMgmAW1+J4Bf6FTzY7P5YxQucmQ3JTD6+L3pZS
         iTQwrUZpqsJjUAJPQFv5kBgUxUqOgydwOt76bxV4fgxE9gt/635G48+kk6QMKMFKdNcI
         ha8SWae42BUVlh4zdN0W6CoGD3A+oNarXZbSk5DHkhlB+rAQkmcVhDBVJlh7EsBDVYVA
         LqUWeu3iVYrhPbsa4zk1sb4MS+cmFqHCSUAbkzepLM3ti4Tz63CLkrp1CuOwtTnI0Mz6
         gzG1UEzR7aRvCND8X4dDnW2EyHGrJURhqj5fWo7bEQaBCBbNUoh2JnZmz2xogSIJKWiL
         rooA==
X-Gm-Message-State: AOJu0YxGiriIFibqY+//+cfSC0drqqk5zbqaAWNgPM159sBXge2EoAGW
        4I2X+J+x47PbKACwt/cgiWI=
X-Google-Smtp-Source: AGHT+IHGIX91kg9M698jtU9/okbgfeX+hEAvgOPmIzyzhvaiddrf/3vGC6KhyzP5/E1RDET9W87TAQ==
X-Received: by 2002:a05:6a00:14ce:b0:691:2d4:23a2 with SMTP id w14-20020a056a0014ce00b0069102d423a2mr15058971pfu.31.1698242708473;
        Wed, 25 Oct 2023 07:05:08 -0700 (PDT)
Received: from sagar-virtual-machine.localdomain ([103.70.144.216])
        by smtp.gmail.com with ESMTPSA id v124-20020a626182000000b0064fd4a6b306sm9838330pfb.76.2023.10.25.07.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:05:08 -0700 (PDT)
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
Subject: [PATCH] drm/amd/display: add kernel docs for dc_stream_forward_crc_window
Date:   Wed, 25 Oct 2023 10:04:16 -0400
Message-Id: <20231025140419.21180-1-sagarvashnav72427@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel documentation for the dc_stream_forward_crc_window

Signed-off-by: Sagar Vashnav <sagarvashnav72427@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1729fb727..5ab35e482 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -528,6 +528,19 @@ dc_stream_forward_dmcu_crc_window(struct dmcu *dmcu,
 		dmcu->funcs->forward_crc_window(dmcu, rect, mux_mapping);
 }
 
+/**
+ * dc_stream_forward_crc_window() - Forward CRC window configuration to DMUB or DMCU.
+ * @stream: The stream state to forward CRC window configuration for.
+ * @rect: Pointer to the rectangle defining the CRC window coordinates.
+ * @is_stop: Flag indicating whether the CRC capture should be stopped.
+
+ * This function is responsible for forwarding the CRC window configuration
+ * for a given stream to either the DMUB or DMCU, depending on their availability.
+
+ * Return:
+ * %true if the CRC window configuration was successfully forwarded;
+ * %false if the stream was not found or CRC forwarding is not supported.
+ */
 bool
 dc_stream_forward_crc_window(struct dc_stream_state *stream,
 		struct rect *rect, bool is_stop)
-- 
2.34.1

