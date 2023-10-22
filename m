Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B137D22A8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjJVKji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVKjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:39:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A91F7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:39:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9d3a21f7aso18970055ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697971175; x=1698575975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gO2PwCgF6TrXzVHmmodaWvzoIahOuJS1U51meYcBm48=;
        b=dMWIZuzjrQy2gD9L/R6g07F2VW5AGeEsOLy4MKWYCsAODljRhHzsjMOWG8r5esuuSj
         Db1zj2ujj3+PaWCaAgoHPIpGyMe27GZJJFq88srMn0AgnuT07NeUs0Yqx2tOhrzxAdwJ
         34w7BBVckSr10SxzNdNgjV3Stc+T1NhskiODFlDt6wBmyBV0s8Oy18JsedfNQCcmTl6/
         hvvYg6D0QRABp/BDXvoTuTNx/CtCds18kaD4y/N38m+LLP2AxJYpEqpJ9d1kMHglexWg
         HFOZPWlRvBCB26QfAM5XoRvqijG9shmBOMmUgw4FHgiqxmDGcl2YhULX6iOvBnCObt32
         kwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697971175; x=1698575975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gO2PwCgF6TrXzVHmmodaWvzoIahOuJS1U51meYcBm48=;
        b=mc/PYQ6P5IdlQiWu1ZAq2vxFQhDQB8XTXolt5z4wdU9qWSrOT6XikLByJno7FAPgmH
         okDt4Q9V+LLkOeDxLX5mbjOth6ysJxREm8MmQp4yYcDxcW4CLTTlLqTyT7tATWmQlsxo
         2H6pgufV16IdtYjoHTI8G4KhMweee+kcUdSmSp+HYrDHxg7q4bn/kAyAgxx2ejd+bT9X
         RBXSQBffKdSHMpYg8JtNppFqxtWH/FKO9Bm3uEue8JgfBVM3S2AXhRXhRbylqWM881Tz
         UpUzZMse0DCO5JP240Z+pCo8d2qW63g3vmMSVPk9BbzCZ9tvew8QSrh+fUum8NCAwc10
         avbA==
X-Gm-Message-State: AOJu0YzHKIMFuT8MofXH1VM2oyJF7o5fyAaVBf2hQfUkWdkTYwKw388Y
        8vNItk7YJv6yMNA/aUAY56Q=
X-Google-Smtp-Source: AGHT+IHupRxsxOf8XzGoXWmB8r0Ah50M32C5qqbdbbyGsvgkbv7FasfOKxiUO+T3TZZkMU49GZ1eTg==
X-Received: by 2002:a17:902:d34b:b0:1ca:7ec3:f4f9 with SMTP id l11-20020a170902d34b00b001ca7ec3f4f9mr8001564plk.32.1697971174684;
        Sun, 22 Oct 2023 03:39:34 -0700 (PDT)
Received: from ubuntu ([122.171.143.200])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001c5076ae6absm4269087plg.126.2023.10.22.03.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 03:39:34 -0700 (PDT)
Date:   Sun, 22 Oct 2023 03:39:28 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH 1/3] staging: greybus: Modify lines end with a '('
Message-ID: <827f8417afa3943e8b71910a7ba88ea35614dd2c.1697969950.git.nandhakumar.singaram@gmail.com>
References: <cover.1697969950.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697969950.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to linux coding style. Reported by checkpatch.pl:
CHECK: Lines should not end with a '('

Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
---
 drivers/staging/greybus/camera.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index ae49e37a87e9..feddceddffbb 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
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
-- 
2.25.1

