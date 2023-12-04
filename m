Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AA98032A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbjLDM3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjLDM32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:29:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA45114
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:29:34 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c0a11a914so10466625e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701692972; x=1702297772; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jtRzLSN1qiD5ViHrLDUVaEvxomgxXY/Nh4KNz8w1+w=;
        b=iK8gKI8qJwQOgB/m2v6pIIxBm7uTScfF6I/99ACl6aw6x4BWPm3D1EWnRWZcEZZ+42
         sRu0NKGbe+nIxsni0/dWewg1HJ1uEFq3nCaaoHY3G508XNzd0I1Ct3mOspnVlATGgQPq
         yR0vk96s6R4A2jDWbXdBMEutkGkW5O2Je4hhWcJseTcPVPtudTVKwoo8bPbt3iqyt/OL
         XbjFRKwZhejRtl9BF/7EF54buFlzuDUeGxadq/NYvb8w9t+NxKvGwgHlZc766EGRn7Wi
         a1ebOM8O4dhwwp40Cemd5CPGCgVmnno3j2t4djArIAdFh1zEO7JHtS1hOAyqeykEXrYN
         PX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701692972; x=1702297772;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jtRzLSN1qiD5ViHrLDUVaEvxomgxXY/Nh4KNz8w1+w=;
        b=SJB/xIbK6n94DmEs1Wu1thzBvB/xirCwinsM3iRH2TzMdF/LJQhlUBiy0y/hvE8c5g
         IeMfkjO1QKz+DMU8BUVbFh8es4iC/t/T2K2C1+d1g9UoKdB3AKEfExz/0tHiJzjjI8Xe
         Cx9gn5lcJgurNtNxgpfsx4vKMEQPUTZ2A2TbxL3fLvSTFwX/lLVtSqBcJdUcENl9aq6H
         KUgAUFJ+BK+/UQ5EkAzFV+AB/0waFCV0FZyltDvqWBSVrLWvxZuMZYlc9esadbmdj/yJ
         50PthJiI4AeOWbvP0IeJtqoXH1oQFXIjYCID26HE1i2my8s13pXqvK6kG/w73lZWK9TU
         Ye+g==
X-Gm-Message-State: AOJu0YwRVb1w4VR0/Ho3fjlob8ua/YtFWRUMGQIGDjWQhDRz/U8lXUk6
        qIXv8mt09hTSE8CqiP/rCw8RdDStG2uxUdrJKfY=
X-Google-Smtp-Source: AGHT+IHeQU6ukVh6qvTvC91E/9AZ9tQzE96+lLjiDnPYJUypYWxHlpietrEODuWPZuVKx1JlmTZr4g==
X-Received: by 2002:a1c:7508:0:b0:40b:3566:e54e with SMTP id o8-20020a1c7508000000b0040b3566e54emr2517759wmc.39.1701692972469;
        Mon, 04 Dec 2023 04:29:32 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id cp6-20020a056000400600b003334520e49bsm3763015wrb.53.2023.12.04.04.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:29:32 -0800 (PST)
Date:   Mon, 4 Dec 2023 15:29:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/x86: x86-android-tablets: Fix an IS_ERR() vs NULL
 check in probe
Message-ID: <4b1b2395-c7c5-44a4-b0b0-6d091c7f46a2@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi_new_device() function returns NULL on error, it doesn't return
error pointers.

Fixes: 70505ea6de24 ("platform/x86: x86-android-tablets: Add support for SPI device instantiation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/platform/x86/x86-android-tablets/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 6a5975ac3286..f8221a15575b 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -220,8 +220,8 @@ static __init int x86_instantiate_spi_dev(const struct x86_dev_info *dev_info, i
 
 	spi_devs[idx] = spi_new_device(controller, &board_info);
 	put_device(&controller->dev);
-	if (IS_ERR(spi_devs[idx]))
-		return dev_err_probe(&controller->dev, PTR_ERR(spi_devs[idx]),
+	if (!spi_devs[idx])
+		return dev_err_probe(&controller->dev, -ENOMEM,
 				     "creating SPI-device %d\n", idx);
 
 	return 0;
-- 
2.42.0

