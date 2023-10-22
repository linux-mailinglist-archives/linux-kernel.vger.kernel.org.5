Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101727D2315
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 14:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjJVMSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 08:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVMSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 08:18:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF84DD
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 05:18:10 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b709048d8eso1736226b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697977090; x=1698581890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PE4+6mfVrbVPnjzZCicIAFyglp4nXFWxs8H1/H4u0+Y=;
        b=kB7gmBDseVKiH680twAJtsMXFccOgb3xGjsphL4JCF9j9ZnDL+kZ1HcXX+FljdIO//
         uBdzp+KS3zhqo8Kgrc3Q1Sm0wqmLbqNmsgDsijOt++xWzjBB3J4wGGZxnLC9BDmH5QWB
         Fw/ht2CzMpDIHtnYbU7OjBZYP7PHjPBMZ13rfYhBIr2gC7MAhUXPx1GOZu3FlMTxW4Ld
         4W5AM/SwiK5xDd9xBiMnm19cc5RmT4gzX4X/oPSwn/fKN9+ku6FrGlNfCNPL5Q9diCDJ
         cO0BNGUeWTbnkMlGvN1YEUfxfiUTdPiX12JV6Uz2jjApVgIwNSQhOCbov+irJ73N7Th9
         51Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697977090; x=1698581890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE4+6mfVrbVPnjzZCicIAFyglp4nXFWxs8H1/H4u0+Y=;
        b=Vb6sWCWiEki93Sp+TnWdQz37B+4anBqTiZd654S7wlWl9yvHdTeAYcct9xuyMTY+Ye
         Dz6rK165KphCfEKFJD1ZvoP2rLyoK++ElsbGZMAw2lM1tQC8AvqmYnTwvBFlOFRNBsNl
         SZpL/uiKlqdUON/Mu33oezTuQmLsYHtUL71vGjfynrueYReMu3pOJUA6+rhlGm6flWcF
         tzBaq3bDhnzmzJ/1QIMyjmhTkfCEBIT0KbMZx9oo8filIOBYkAD0zjqD5EetpgcW8ahi
         fOkHacDVYcGQfnsfuxs+gJrPLQvd80m2dXpszGO7Ua+B+3fxlhsSagmjkMRVUjTiik0k
         qmnA==
X-Gm-Message-State: AOJu0YwWChWQU4Rau0a+fCBseAYD/FjWeJnTl1WFNBQeK2tHLXdMk0UN
        QCzn6K5S8uquseTHozQoF7Y=
X-Google-Smtp-Source: AGHT+IE8H30sWK+Ba1pN9DY8WJX2lDbNtDqXWBEsdV+UbFfQ0u9AgPoZsSFH8lJmSevKs6+8uTVHPQ==
X-Received: by 2002:a05:6a00:9398:b0:68b:a137:3739 with SMTP id ka24-20020a056a00939800b0068ba1373739mr5872707pfb.4.1697977090042;
        Sun, 22 Oct 2023 05:18:10 -0700 (PDT)
Received: from ubuntu ([122.171.143.200])
        by smtp.gmail.com with ESMTPSA id t3-20020a6564c3000000b005ac384b71cbsm3599506pgv.60.2023.10.22.05.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 05:18:09 -0700 (PDT)
Date:   Sun, 22 Oct 2023 05:18:01 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH v2 2/3] staging: greybus: camera: Modify lines end with a '('
Message-ID: <5f63b332c83f5f0e95f59e673b0292c27fecb411.1697976302.git.nandhakumar.singaram@gmail.com>
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
CHECK: Lines should not end with a '('

Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
---
 drivers/staging/greybus/camera.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index 6516e7efaab9..40d3b8aca8f0 100644
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

