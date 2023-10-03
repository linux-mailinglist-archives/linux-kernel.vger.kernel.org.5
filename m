Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63F7B5E47
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbjJCAeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjJCAek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:34:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E057C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:34:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-692779f583fso279364b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 17:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696293276; x=1696898076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULFaUXbFksMdiOTX7EFeIrZO1zGruO/Y5COdeG+mbmw=;
        b=aCkqFxpoJ1W/FvxslnLgbXWH7lmfgtEJ/BY9wVHdupH/enLEg1qCiifjUePo5vCvbs
         iC2AFdU4y1ufFuKo0J2z1ud5g7HhhA7Y7UodaHOUqI3m8I5osY2FZIL0PVEXkwNByqRH
         XMhGrOxFxTTZ4ZKwFvkztkQ+QOOIChQwOUTbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293276; x=1696898076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULFaUXbFksMdiOTX7EFeIrZO1zGruO/Y5COdeG+mbmw=;
        b=MRuF+dGONLbGbaaBS204u4ygVeiwglw7iemLpy5wx74utg2NSDKyWVyve9dziX32Wh
         HEIa9n3bAmfWEPbcn3KLxdvjPKPT+1m4f83Ba9TfA/d3T7FHxSOGqvhecK5pfTxN3bvp
         0JTc+goQ97r7TCs9zqDBgiJSX8jEM+stzO8dsijwivvQeOi9Lyv7fB/GKtzoUeANGA5f
         t2BYykbPXcMHW4BtU+smt5A4c6NFwYyYa5Xf9YnOIFsupt88PP5AESJMVZbWiz43Q3Ux
         14daJCr/MqRBCz1JwTIS7espiUzTb9BKT2UNEPf/m91r9xxjn0RgsoHeFdobfnqHrW9X
         KMzw==
X-Gm-Message-State: AOJu0Yyq6wGIEuLJIFMWJzWZnbi/vKsNGgOC+gCegY4VqWG68mKK0NJM
        U++QKes40usJAuOJNkNQjpXEUAvNUlr8iHJ/IIs=
X-Google-Smtp-Source: AGHT+IFEG97ZEYV1LjW9w3tPX6P9RnwrvT9boD1/FLSuHTy5NIliBpsfZfToads/4dmEdvczCCLX0Q==
X-Received: by 2002:a05:6a00:1787:b0:68e:2478:d6c9 with SMTP id s7-20020a056a00178700b0068e2478d6c9mr13123617pfg.2.1696293275992;
        Mon, 02 Oct 2023 17:34:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:f676:8db:8677:aefe])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b0068a13b0b300sm101368pfb.11.2023.10.02.17.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:34:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 4/4] platform/chrome: cros_ec_proto: Mark outdata as const
Date:   Mon,  2 Oct 2023 17:34:28 -0700
Message-ID: <20231003003429.1378109-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231003003429.1378109-1-swboyd@chromium.org>
References: <20231003003429.1378109-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'outdata' is copied to the data buffer in cros_ec_cmd() before being
sent over to the EC. Mark the argument as const so that callers can pass
const pointers to this function and so that callers know the data won't
be modified.

Cc: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c     | 2 +-
 include/linux/platform_data/cros_ec_proto.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 475a6dd72db6..945b1b15a04c 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -1004,7 +1004,7 @@ EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
 int cros_ec_cmd(struct cros_ec_device *ec_dev,
 		unsigned int version,
 		int command,
-		void *outdata,
+		const void *outdata,
 		size_t outsize,
 		void *indata,
 		size_t insize)
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 4f9f756bc17c..8865e350c12a 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -258,7 +258,7 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
 
 int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
 
-int cros_ec_cmd(struct cros_ec_device *ec_dev, unsigned int version, int command, void *outdata,
+int cros_ec_cmd(struct cros_ec_device *ec_dev, unsigned int version, int command, const void *outdata,
 		    size_t outsize, void *indata, size_t insize);
 
 /**
-- 
https://chromeos.dev

