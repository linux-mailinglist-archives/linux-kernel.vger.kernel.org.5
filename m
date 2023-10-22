Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E847D2313
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 14:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjJVMQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 08:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVMQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 08:16:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C5DDC
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 05:16:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c77449a6daso19496705ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 05:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697976972; x=1698581772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+S2mdckSSp2Nfs5ye+ND5i2vKp9m6YBgPQvt8jtLlY=;
        b=BaUTLMmznHyHgVukBZFAUf1ja8ajqHytYv+pWdgSJx0GSVjgiAEQ8OcVUJyJHSevhJ
         vWsdymZhmg8eTyJy8sNSds6t7EliPRz/jEPfcQSRtaaguVoGK95WvnvhxpTV6x/LBBuE
         4Be+FtRaK4RKPaJRS3acJwlQxHWJjuJn/34PVfoGOlPEMGwH6gIH6Dk8gk9tVD2+g1w+
         p7p57y6WPeDWRpzErsoUj69IkGnWWfln+YrGI98ZHTPK/ByfP2sfHPHC65QERAIccIqL
         3RyIBMzxt3+1zWJfTdJgVoozxSLnUPNFnKBxiBHgCog2WUEDGG2+Ft+GtYfSkF8Udy4N
         Q1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697976972; x=1698581772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+S2mdckSSp2Nfs5ye+ND5i2vKp9m6YBgPQvt8jtLlY=;
        b=Y20PBJZl18NnVJk//mRsXVqMTogBHc3flhVYYaTj0UQpJmmzuo5rXYuXRnpcob50xf
         Xnrn5KQk5ZZOl7a9R9YBMxMK/OHyFns5HHn50WzkCIqo8YrmYnSLZXQXM1FeH/lhqfuw
         mTZDgGgnZR2MOGP66OC4BXnoO8TcxmgLkZwWRRKwClQII+vsyoYkE3HHyTmlxZ+6fKth
         x+YE/eFJWQkSCKJMGlL57NuqciJIs6bLvBhBaFDBdBqV+iZ1esmMNs6gn9stN9CFgNlO
         UjjP/VesTxqzTkYyyrbhVNaqgKLNaTZz9Nd7i7bWZb9qCVME98H8PATA/QBfpT/N9fMO
         ZcyQ==
X-Gm-Message-State: AOJu0YzDqqhgB3FC8DRFfviJ+Gdl6M9clsPgVaSjOERz9YZ9IKTHQXN0
        L3JzzpzRlOCEZz1IRGcCvgO3cfMIzTU=
X-Google-Smtp-Source: AGHT+IGjoR0YMcAj2F7zAWRDZOhI9k2JNW4ERSe30aG0pfFa024ofCeya2M+RkiNweOChf+FSqQW2w==
X-Received: by 2002:a17:902:e88f:b0:1c7:23c9:a7db with SMTP id w15-20020a170902e88f00b001c723c9a7dbmr6767428plg.26.1697976971794;
        Sun, 22 Oct 2023 05:16:11 -0700 (PDT)
Received: from ubuntu ([122.171.143.200])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001c9c879ee4asm4366495plf.17.2023.10.22.05.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 05:16:11 -0700 (PDT)
Date:   Sun, 22 Oct 2023 05:15:57 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH v2 1/3] staging: greybus: camera: Alignment should match open
 parenthesis
Message-ID: <d2630a16ff9eca40b03dcade63c197fdd5e5b78f.1697976302.git.nandhakumar.singaram@gmail.com>
References: <cover.1697976302.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697976302.git.nandhakumar.singaram@gmail.com>
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
 drivers/staging/greybus/camera.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index ae49e37a87e9..6516e7efaab9 100644
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
@@ -378,8 +378,8 @@ struct ap_csi_config_request {
 #define GB_CAMERA_CSI_CLK_FREQ_MARGIN		150000000U
 
 static int gb_camera_setup_data_connection(struct gb_camera *gcam,
-		struct gb_camera_configure_streams_response *resp,
-		struct gb_camera_csi_params *csi_params)
+					   struct gb_camera_configure_streams_response *resp,
+					   struct gb_camera_csi_params *csi_params)
 {
 	struct ap_csi_config_request csi_cfg;
 	struct gb_connection *conn;
@@ -783,8 +783,8 @@ static ssize_t gb_camera_op_capabilities(void *priv, char *data, size_t len)
 }
 
 static int gb_camera_op_configure_streams(void *priv, unsigned int *nstreams,
-		unsigned int *flags, struct gb_camera_stream *streams,
-		struct gb_camera_csi_params *csi_params)
+					  unsigned int *flags, struct gb_camera_stream *streams,
+					  struct gb_camera_csi_params *csi_params)
 {
 	struct gb_camera *gcam = priv;
 	struct gb_camera_stream_config *gb_streams;
-- 
2.25.1

