Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2610379041F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351256AbjIAXlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351237AbjIAXlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:41:40 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191751706
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:41:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5657add1073so326189a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611660; x=1694216460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT1iKlrITuZofU1kQPrtkxFP604YngjW6FFJAYPzuCU=;
        b=MajupvmWpK2Z2Cq+gnnWnDEerUV1DTNU+6pJA0u8/gTPIWRp7+0175rn6aVCGKGUYg
         Csrtc9CUA7AyhRzYJzjUunF8RY0mIHVtT3/7vnPawABu18Kn/YLetlM6auBxo/6mT9f/
         4rZgnwgm8Kf7B57gUaWzSH7XT7zeaUCbaKBkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611660; x=1694216460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pT1iKlrITuZofU1kQPrtkxFP604YngjW6FFJAYPzuCU=;
        b=SDe+zPFWed7uR5dQdXcff34gsErW9GnG8cSsGdQWU0RbMaEwCa7kGOedf3pBmEvrtY
         xtvdhgSSiZCcta4eewTZL9ZPsAv/H6DLlZSUjWSFdkF2QGc9N12U5HM08LauA/8AX++l
         iPHeviPaejNHhaFHtRiGUw9OpwgwSD6c88bLvu51oMPpOTT5Ov0jfqJJ/t7tNPPYkJGK
         CjlZmcJBtlDg8xhqU2AETKZXVfdtR8mCv8HCtfxFKeH9lk6iDa/+VUNL/809pLeuw6BI
         yQZQhKxnRVsdW9AmZ6vqjgowyJIWqLJ3H5ExAPq0qBExLIq9ssQQKGGWwDkqvLLwA1bb
         sxNA==
X-Gm-Message-State: AOJu0YzJFYUqk0zUheyKUmRTuEuO6aUL6dspw7qreUGETN+Pv8siVj1M
        y+j2wk55oRUIckrpq3MrHhxSnkqgiGqYwdVFqzvyLKta
X-Google-Smtp-Source: AGHT+IGqVAUGomc3SlwvihPd+jy1s+2/sdtPRZxfYwC1170/gmtaQyqQmY66o6+Nz6XRTaKspuptHQ==
X-Received: by 2002:a17:90b:23c8:b0:25c:18ad:6b82 with SMTP id md8-20020a17090b23c800b0025c18ad6b82mr5046871pjb.21.1693611660378;
        Fri, 01 Sep 2023 16:41:00 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a1a4500b0026b4ca7f62csm3773488pjl.39.2023.09.01.16.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:40:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        daniel@ffwll.ch, javierm@redhat.com, jstultz@google.com,
        kong.kongxinwei@hisilicon.com, linux-kernel@vger.kernel.org,
        robh@kernel.org, steven.price@arm.com, sumit.semwal@linaro.org,
        tiantao6@hisilicon.com, tzimmermann@suse.de,
        u.kleine-koenig@pengutronix.de, xinliang.liu@linaro.org,
        yongqin.liu@linaro.org
Subject: [RFT PATCH 6/6] drm/hisilicon/kirin: Call drm_atomic_helper_shutdown() at shutdown/unbind time
Date:   Fri,  1 Sep 2023 16:39:57 -0700
Message-ID: <20230901163944.RFT.6.I21e0916bbd276033f7d31979c0da171458dedd4d@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901234015.566018-1-dianders@chromium.org>
References: <20230901234015.566018-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() at system shutdown time
and at driver unbind time. Among other things, this means that if a
panel is in use that it won't be cleanly powered off at system
shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart and at driver remove (or unbind) time comes
straight out of the kernel doc "driver instance overview" in
drm_drv.c.

I have attempted to put this in the right place at unbind time. In
most other DRM drivers the call is made right after the call to
drm_kms_helper_poll_fini(), so I've put it there. That means that this
call will also be made in the case that we hit errors in bind, since
kirin_drm_kms_cleanup() is called both in the bind error path and in
unbind. I believe this is harmless even though it's not needed in the
bind error path.

For handling shutdown, we rely on the common technique of seeing if
the drvdata is NULL to know whether we need to call
drm_atomic_helper_shutdown(). This makes it important to make sure
that the drvdata is NULL if bind failed or if unbind was called. We
don't need the actual check for NULL and we'll rely on the patch
("drm/atomic-helper: drm_atomic_helper_shutdown(NULL) should be a
noop").

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index e8c77bcc6dae..75292a2f4644 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -206,6 +206,7 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 static int kirin_drm_kms_cleanup(struct drm_device *dev)
 {
 	drm_kms_helper_poll_fini(dev);
+	drm_atomic_helper_shutdown(dev);
 	kirin_drm_private_cleanup(dev);
 	drm_mode_config_cleanup(dev);
 
@@ -244,6 +245,7 @@ static int kirin_drm_bind(struct device *dev)
 	kirin_drm_kms_cleanup(drm_dev);
 err_drm_dev_put:
 	drm_dev_put(drm_dev);
+	dev_set_drvdata(dev, NULL);
 
 	return ret;
 }
@@ -255,6 +257,7 @@ static void kirin_drm_unbind(struct device *dev)
 	drm_dev_unregister(drm_dev);
 	kirin_drm_kms_cleanup(drm_dev);
 	drm_dev_put(drm_dev);
+	dev_set_drvdata(dev, NULL);
 }
 
 static const struct component_master_ops kirin_drm_ops = {
@@ -284,6 +287,11 @@ static void kirin_drm_platform_remove(struct platform_device *pdev)
 	component_master_del(&pdev->dev, &kirin_drm_ops);
 }
 
+static void kirin_drm_platform_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static const struct of_device_id kirin_drm_dt_ids[] = {
 	{ .compatible = "hisilicon,hi6220-ade",
 	  .data = &ade_driver_data,
@@ -295,6 +303,7 @@ MODULE_DEVICE_TABLE(of, kirin_drm_dt_ids);
 static struct platform_driver kirin_drm_platform_driver = {
 	.probe = kirin_drm_platform_probe,
 	.remove_new = kirin_drm_platform_remove,
+	.shutdown = kirin_drm_platform_shutdown,
 	.driver = {
 		.name = "kirin-drm",
 		.of_match_table = kirin_drm_dt_ids,
-- 
2.42.0.283.g2d96d420d3-goog

