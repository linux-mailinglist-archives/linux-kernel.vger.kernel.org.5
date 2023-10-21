Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16C27D1FDF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 23:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjJUVsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 17:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJUVsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 17:48:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8530D7A
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 14:48:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c8a1541232so16953925ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697924927; x=1698529727; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUY/6aiz/kuqBCZnsp6ZXSxXydVcwFjt2+x9XvheJnQ=;
        b=NBE+qQN7m7FXJaL/NpiV08vhH+B26EkM8q/Ljw+8wvlJT/6Dp5wntiSxewos+VDwMQ
         IwRbnooMm9ib49tS43sc9EbuuwADKm5SACCQ/XQdFOwhm5FVqQ1OjCwZJSD6gyNfp7SX
         EIvzRMO24Jk00qd+NnNkcRa8yIAfpac3BhtSfD/Qn2+lISEnBwiPISlBg/ub5HSurgut
         VwkBQoKcNx81XhYevhqS4MVgtiJ7eyxPph0mjKelEOjveaGvMC5VKXaFrJ3Uz5f/EtpZ
         M3bpOa9MsYAgkKkWWHRSbulT9aE8tl1zU7KMDCE7lQNYiHFVpCpN3ZXg9ivKZSvttFfF
         RLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697924927; x=1698529727;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUY/6aiz/kuqBCZnsp6ZXSxXydVcwFjt2+x9XvheJnQ=;
        b=hNO8JhGshK8Rk40uEGblXg/GsAfY3rP2f5+oubldzIRmXeBY55CV3sIT3y39Xh6CSk
         +m9EQQjLGOdciHkPDjRhq4hj9PtdcZM2fxpU/SQLvgepJOqYFQ1yoEjXshdf1+8WVXT7
         B/qr02gPVTr010Zqpj1YErwyuhpiFMsG4dXZDwhUf95ReThxlWzXC9R4Az73bxU10Rb2
         06gpwpdTY8PS/aqMoX+VU/AaeGpjLbS5ajm/GDEq2a5tD2mtoYnkgITM5kj3BeEAhACl
         G4KF6gnwh3Hv9ciJuFRfv0OFZc+O5ebTyH5bQldvPTAVtDrnmq/X8ONoKEPOpyCucW7/
         1zTQ==
X-Gm-Message-State: AOJu0Yw2FAUCfAcWRmx9285L8MtKWyX4pmytZ3JsyDirijPoGxpaAkeF
        mOBL/jKtordU96O657P+iic=
X-Google-Smtp-Source: AGHT+IEZd9SN83EFFxrJuxljhGwxuZ4exyWb83Q2VVJHLmEQIDMjLqdOV1BIKqIgpjkUfG9ZCE44sg==
X-Received: by 2002:a17:902:cec4:b0:1ca:2caa:aca6 with SMTP id d4-20020a170902cec400b001ca2caaaca6mr6514621plg.68.1697924927110;
        Sat, 21 Oct 2023 14:48:47 -0700 (PDT)
Received: from ubuntu ([122.167.9.184])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001c5eb2c4d8csm3542882plg.160.2023.10.21.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 14:48:46 -0700 (PDT)
Date:   Sat, 21 Oct 2023 14:48:40 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH] staging: greybus: avoid macro argument precedence issues
Message-ID: <20231021214840.GA6557@ubuntu>
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

Adhere to linux coding style, added parentheses around
macro argument 'gcam'.
CHECK: Macro argument 'gcam' may be better as '(gcam)' to
avoid precedence issues

Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
---
 drivers/staging/greybus/camera.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index cdbb42cd413b..ae49e37a87e9 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -180,9 +180,9 @@ static const struct gb_camera_fmt_info *gb_camera_get_format_info(u16 gb_fmt)
 
 #define GB_CAMERA_MAX_SETTINGS_SIZE	8192
 
-#define gcam_dbg(gcam, format...)	dev_dbg(&gcam->bundle->dev, format)
-#define gcam_info(gcam, format...)	dev_info(&gcam->bundle->dev, format)
-#define gcam_err(gcam, format...)	dev_err(&gcam->bundle->dev, format)
+#define gcam_dbg(gcam, format...)	dev_dbg(&(gcam)->bundle->dev, format)
+#define gcam_info(gcam, format...)	dev_info(&(gcam)->bundle->dev, format)
+#define gcam_err(gcam, format...)	dev_err(&(gcam)->bundle->dev, format)
 
 static int gb_camera_operation_sync_flags(struct gb_connection *connection,
 					  int type, unsigned int flags,
-- 
2.25.1

