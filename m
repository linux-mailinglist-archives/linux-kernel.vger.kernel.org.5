Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D258D7FAE36
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjK0XKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0XKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:10:21 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AE019D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:10:26 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50aab3bf71fso6594479e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701126625; x=1701731425; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aArr4Zo3fOK6qHGsqiAv8zLE+MevB0/MPL6lNLgo6oI=;
        b=LjOEXu3mcmBAMtZiVjbWFT7Dsp819n8ueh6V/PY9YCtntyLybQQBa9u7IY0CyvGWR8
         Dj760iG/QtAnV+oxFsQPHQnJhA8YarwO38Z0xpqGn7LLvpzehTogR2mJhNcWGyH9/h+7
         ImrbTuGJuF264IDJ+Cqar0Br/OSSxIY+1BBYnXzoLw0xeptqjBjgzFlSrJom55/Sbizr
         osxskChL/emAZY6mxV5d7e8MPto2EEA7lOVt94I0V3pNUmz9wuPNQOkHiJRd2w6/EAqn
         yCRyoEYcOyHWl8P4HifJmrRkynS8PHYkJFZF2Jjz11hB+48iqRSfyMJJRCJKKNkeQ7Yb
         X7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701126625; x=1701731425;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aArr4Zo3fOK6qHGsqiAv8zLE+MevB0/MPL6lNLgo6oI=;
        b=f8XCO44ca3OEwiZzea02JZFFQbjLpAo7wgYMUekFIL7gyQkMATq/HU0OcBvMSDyGO+
         UYJREJ0NL+pCeuNeJMLNih+D4VTm7rA3ZTe1NN2f/+5HXx/QcGE6rREj2nVPQlnoeJ/g
         J4hsaJ0NxZxxak07Ni1XLvefNpj1ovUIjfHx+4YJT3ERgeLmRbsDfxOqQJUDHvEe4Zck
         pt+86QmVyzcezunqoGs55l5nggyG7plbqHfO/oJ2ooPX+HVwglNYiVgfg8BONHWLiLXP
         3HAd9eGdtbfP2fJWhiKYerCEE/9X+ZvxZRvWO3hbrTLyJOvsvayuoEhmXiUP425pKk0V
         3atQ==
X-Gm-Message-State: AOJu0YxHY8dr43VnFlrpJnt7P9Zaxt4z3yZ7X24Z26851isL0tuRxbFH
        eaVyB5AyYKoet+rQ7rYmS1AWBQ==
X-Google-Smtp-Source: AGHT+IFqxRcjotsq5abR+BpqaRX3hSy8XtvlvzV0lyt0zCqUjqDI89ngohYQ1hokiAeePaglzUK7CQ==
X-Received: by 2002:a05:6512:3d9e:b0:50b:aa9a:903b with SMTP id k30-20020a0565123d9e00b0050baa9a903bmr6515322lfv.30.1701126624836;
        Mon, 27 Nov 2023 15:10:24 -0800 (PST)
Received: from [192.168.1.2] (c-21d3225c.014-348-6c756e10.bbcust.telenor.se. [92.34.211.33])
        by smtp.gmail.com with ESMTPSA id cf17-20020a056512281100b0050aa94e6d15sm1636877lfb.9.2023.11.27.15.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 15:10:24 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/3] Revert panel fixes and original buggy patch
Date:   Tue, 28 Nov 2023 00:10:18 +0100
Message-Id: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANohZWUC/x2MQQqAMAwEv1JyNmCqIPgV8VB01YBUaUUE6d8NH
 meZnZcykiJT715KuDXrEQ2kcjRtIa5gnY3J174R8R2bhHTxGSJ2XvRhtHNoIIIutGS3M8HmPzm
 MpXy4o/4IYgAAAA==
To:     Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series reverts the attempts to fix the bug that went
into v6.7-rc1 in commit 199cf07ebd2b
"drm/bridge: panel: Add a device link between drm device and panel device"
and then it reverts that patch as well.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (3):
      Revert "driver core: Export device_is_dependent() to modules"
      Revert "drm/bridge: panel: Check device dependency before managing device link"
      Revert "drm/bridge: panel: Add a device link between drm device and panel device"

 drivers/base/core.c            |  1 -
 drivers/gpu/drm/bridge/panel.c | 26 --------------------------
 2 files changed, 27 deletions(-)
---
base-commit: 95ba893c9f4feb836ddce627efd0bb6af6667031
change-id: 20231127-revert-panel-fix-e4da3e11e7a4

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

