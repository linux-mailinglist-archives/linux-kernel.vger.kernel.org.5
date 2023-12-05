Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4916805450
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345254AbjLEMgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345237AbjLEMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:36:35 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC9FA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:36:42 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cdea2f5918so3753062b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701779802; x=1702384602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KIsb92r91QpPekGXu//XTsZOOlRQ2+GzhKmsBQNjlBs=;
        b=K8bZAcJ5xOnAw3kvTSwU/K6Dp5GmYjNp6pHoDY38jHmxlvwRQK2ElyyekvTk4ayYP6
         6N2XsCsCfxz3GaZYOgCAQuoRR0UqFxNBAWDVBTglartIm1lgIuUj1oFIdwt5ArLCsruB
         OaiEnKfygMvo5+pA6P8AEL0k3EhnOR2U78wDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701779802; x=1702384602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIsb92r91QpPekGXu//XTsZOOlRQ2+GzhKmsBQNjlBs=;
        b=dBFjJ1bJERnGkSImAmEITETD/CDyTT6PCs7V6jdiYDVSGg1HMp1y1uPLAT2g4i5It0
         W5JDf5fJTHz+uyBjj1Rrh4XrwtziNes57ecH0lTbF3sLyNjJOX6QQUA7BRwZoh1+Ard5
         eHfIDQP1/kfM4DXthod9ZnVjLAfY2T7ncWPgw2LRVfNhh5ttrN7gUujz0CtAnMcyvrO1
         FkPRlgkAUM0aeKdZaJ7rEbs9WxXqwiVtEfcWpxmfiSE5XvaevhqJBsAi/hs1IPwitH55
         oMgzyk0ow2ACwN0s3LVSmWpgXIcff9Sc3e/RIfdSPIvLfsPHzbfNgw8EnRjdRFAV08rC
         VbCg==
X-Gm-Message-State: AOJu0YzDyf5NCjlL6JHoDbZjaoy0U3Lo7HQwKWTmQV3qGudo1Z3cQI5K
        YenZzFLBdFSLe1O0VJ8tLR0u7g==
X-Google-Smtp-Source: AGHT+IF6AYuS2w8vqW1PS7HCIG9VdZITdv4Vw0j4ZEYFjRIjxdtKSKpGWhyEF6S9kd1UPykcAM7zJg==
X-Received: by 2002:a05:6a20:7490:b0:18f:97c:5b82 with SMTP id p16-20020a056a20749000b0018f097c5b82mr2572927pzd.80.1701779801795;
        Tue, 05 Dec 2023 04:36:41 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:433d:45a7:8d2c:be0e])
        by smtp.gmail.com with ESMTPSA id p26-20020aa7861a000000b006ce7abe91dasm285115pfn.195.2023.12.05.04.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 04:36:41 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH 0/4] Support panels used by MT8173 Chromebooks in edp-panel
Date:   Tue,  5 Dec 2023 20:35:33 +0800
Message-ID: <20231205123630.988663-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains 4 patches:
1. Add a new panel delay to support some BOE panels
2. Sort the panel entries as a clean up. This one does not depend on other
   patches in this series and can be merged separately.
3. Add panel entries used by Mediatek MT8173 Chromebooks.
4. Add panels missing data sheets but used to work in older kernel version
   without any specified delays.


Pin-yen Lin (4):
  drm/panel-edp: Add powered_on_to_enable delay
  drm/edp-panel: Sort the panel entries
  drm/edp-panel: Add panels delay entries
  drm/panel-edp: Add some panels with conservative timings

 drivers/gpu/drm/panel/panel-edp.c | 92 ++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

-- 
2.43.0.rc2.451.g8631bc7472-goog

