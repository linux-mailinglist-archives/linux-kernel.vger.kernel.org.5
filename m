Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3FA7D0413
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346583AbjJSVkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjJSVkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:40:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4218A106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:39:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9e072472bso1049135ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697751595; x=1698356395; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bzd/mX+G6RAAmLpCVFwycoQWQ7+3hjDN3n5S0L3+DGw=;
        b=du/UcQXr2bUxjWy79b5VNuCLrA1aC/y/hko+Ca4ssIudWpeHPtVrjd+7YfDRVa6KzT
         kQ2yL6jXCP5U0CpCltpOFOLpWkbNEiiRYGapN7/lQAxt8LoqmTAzZrZiMWjkC1Ee/XuG
         58HHBsqBe+6cU2mULK1G7bW/3K/xRbPieb3xb2E9M2v5KDFrAii86W1w01n7z6kkPHBI
         JAur+4gHCStJ2tAqKz2A1BG06c3T6zDnS6prnzwkdItX8inIW5KgOnMcpnywhkb6TTxN
         MbwHsf0RrdHYK2TICuoEDbTZEvdqdyearODOdjaNK+hoOagG4KYYHmwUADSCHTrzN/UM
         YDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697751595; x=1698356395;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzd/mX+G6RAAmLpCVFwycoQWQ7+3hjDN3n5S0L3+DGw=;
        b=vjtLj396G0Dtcg/q8tbf5TR0W78EI4f7jlfe2ksHd/QfwA69IajJcTUYNJbyR0iVFu
         UFLC7Pxnf2KR+jyLCj1EXamohyg3N9p5ElVTs6YmyhK+h+Nv+pTIViXidUXkrJWPMCqd
         l7l1NS5V6NZ4cqVRbOXSRdaTLwo2FikG8rR5LvuHRZKhDJd2WFND+1+E3Ojy05+A4Dwo
         Wosg05VmwrWcjXlVdudlSPI5ALr6tHAWes2MGpwfe3kKdXEgVP3l4ry4cXt+E7563bNC
         9ROVBXvIYSu+mljd9W+dIsmpO+pKB+N+8P4wjeIQ8NLetVGcW8KavASWXIe6penzVx22
         Y9PQ==
X-Gm-Message-State: AOJu0YymVAKB9iMAjG9LUgkRH5HwNgQU5qJMtmGQYnSw00A6M3jPvDvQ
        JD5HLRb9r2m/w3rsQMtqlsw=
X-Google-Smtp-Source: AGHT+IEew7sjFWHoyX6Y6D3tw3dxh1tKP/k/G09xg9iUhwupWSCDOHHKl3pt+RSE+yOl7VXPtuGVCg==
X-Received: by 2002:a17:902:eb84:b0:1c3:62c4:7f12 with SMTP id q4-20020a170902eb8400b001c362c47f12mr176220plg.5.1697751594598;
        Thu, 19 Oct 2023 14:39:54 -0700 (PDT)
Received: from ubuntu ([122.167.60.51])
        by smtp.gmail.com with ESMTPSA id jh4-20020a170903328400b001bb9bc8d232sm182694plb.61.2023.10.19.14.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 14:39:54 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:39:49 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: Alignment should match open parenthesis
Message-ID: <20231019213949.GA2922@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to linux coding style. Reported by checkpatch.pl:
CHECK: Alignment should match open parenthesis

Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
---
 drivers/staging/greybus/camera.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index cdbb42cd413b..405c8e78aa72 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -220,7 +220,7 @@ static int gb_camera_operation_sync_flags(struct gb_connection *connection,
 }
 
 static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
-		struct gb_camera_configure_streams_response *resp)
+				      struct gb_camera_configure_streams_response *resp)
 {
 	unsigned int max_pkt_size = 0;
 	unsigned int i;
@@ -267,8 +267,7 @@ static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
  * Validate the stream configuration response verifying padding is correctly
  * set and the returned number of streams is supported
  */
-static const int gb_camera_configure_streams_validate_response(
-		struct gb_camera *gcam,
+static const int gb_camera_configure_streams_validate_response(struct gb_camera *gcam,
 		struct gb_camera_configure_streams_response *resp,
 		unsigned int nstreams)
 {
@@ -378,8 +377,8 @@ struct ap_csi_config_request {
 #define GB_CAMERA_CSI_CLK_FREQ_MARGIN		150000000U
 
 static int gb_camera_setup_data_connection(struct gb_camera *gcam,
-		struct gb_camera_configure_streams_response *resp,
-		struct gb_camera_csi_params *csi_params)
+					   struct gb_camera_configure_streams_response *resp,
+					   struct gb_camera_csi_params *csi_params)
 {
 	struct ap_csi_config_request csi_cfg;
 	struct gb_connection *conn;
@@ -783,8 +782,9 @@ static ssize_t gb_camera_op_capabilities(void *priv, char *data, size_t len)
 }
 
 static int gb_camera_op_configure_streams(void *priv, unsigned int *nstreams,
-		unsigned int *flags, struct gb_camera_stream *streams,
-		struct gb_camera_csi_params *csi_params)
+					  unsigned int *flags,
+					  struct gb_camera_stream *streams,
+					  struct gb_camera_csi_params *csi_params)
 {
 	struct gb_camera *gcam = priv;
 	struct gb_camera_stream_config *gb_streams;
-- 
2.25.1

