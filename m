Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2107E2E90
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjKFVDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjKFVDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:03:43 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB64A3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:03:41 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28010522882so4104372a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699304621; x=1699909421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0IQyvMq1nhgyAfkUJUt91oFnqOK0wtJnc9t4EbDGpw=;
        b=fJlKY0p1CzKJuOzzrDVo4ELugd74FbVikqY6T9G3xFVX3Wc/J+fWz2/jBXIwFUj+Zg
         aD1Kjq2op0djjhZi7mmI4RnpZbhC5xdeI/9PVI74GHxqB+FhDJkACFqMt/jWnBdWN/tL
         AAq2qoV/j6p9C2xsWNqu9/U8EbftuY1HMS9+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699304621; x=1699909421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0IQyvMq1nhgyAfkUJUt91oFnqOK0wtJnc9t4EbDGpw=;
        b=L8JtS1VX7sYEIeh195lbLAwvn4sTL6MWekqPapEY9WZU1kHxRoX4WoTWvZg9LIGZll
         f6eNJqrv8MmFEUHyAZFwqJJ6fI5viblXcHQrEBDDWJUsUHJVm58yzeiC3friebDzeIwV
         OMU739s3NWcUH4zIl9VAvtozbBrPDxBAYUNELBf0oi3QxfMCZ5Dz2/lx3W89JxQVYd99
         ZvTg6SB5Xfbd0e96qqSMI2WKrhr/SmSuXTYw5IHQYzdBCMSPBXgjBbcADjo7tDw+thgC
         5N9R7earYd75QaeVtd+paNUSAqnotvfAqJ24/yMG25/AgvBNQj+ol//TJqz0q6krUOpU
         RZGg==
X-Gm-Message-State: AOJu0YxLn4QtnRRJrh5GGy/UuQEneHegTiYqYBJ0e7uO/dh5Qs2p+JrA
        VJG55W6+6IHV+2uzWGOUucrbGg==
X-Google-Smtp-Source: AGHT+IFltuGcFYnuLj+qwXqqKSiyLd6vdgDwuo1FCXHKemqumq0pTt+FlW/esVerE7+MOVMCbtvuSw==
X-Received: by 2002:a17:90a:ca11:b0:27c:f8bd:9a98 with SMTP id x17-20020a17090aca1100b0027cf8bd9a98mr21793104pjt.40.1699304620658;
        Mon, 06 Nov 2023 13:03:40 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:3374:ff6c:474e:a78])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c14b00b001c75a07f62esm6291220plj.34.2023.11.06.13.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 13:03:40 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Add a few panels and use correct modes
Date:   Mon,  6 Nov 2023 13:00:49 -0800
Message-ID: <20231106210337.2900034-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

This series contains 3 patches:
1. Add a few new generic edp panels.
2. Support a new quirk to override the mode read from edid
3. Only add hard-coded mode if both edid and hard-coded modes presents.

v1: https://patchwork.kernel.org/project/dri-devel/cover/20231101212604.1636517-1-hsinyi@chromium.org/
v2: https://patchwork.kernel.org/project/dri-devel/cover/20231102221309.1971910-1-hsinyi@chromium.org/
v3: https://patchwork.kernel.org/project/dri-devel/cover/20231106202718.2770821-1-hsinyi@chromium.org/

Hsin-Yi Wang (3):
  drm/panel-edp: drm/panel-edp: Add several generic edp panels
  drm/panel-edp: Add override_edid_mode quirk for generic edp
  drm/panel-edp: Avoid adding multiple preferred modes

 drivers/gpu/drm/panel/panel-edp.c | 130 ++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 7 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

