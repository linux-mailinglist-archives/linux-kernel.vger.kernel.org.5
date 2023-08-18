Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C9780417
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357407AbjHRC7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357450AbjHRC70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:59:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C5421C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:59:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-564af0ac494so374189a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lcfc-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1692327550; x=1692932350;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s8FIv/P5NEOWnZZHJHr7vxcf/Z4Pvhy6SYUyZNMnQpA=;
        b=np8c+6P8A2igANUhXRe9dt4JXTBssimZIv9HT1sECP80iXMqBr0bvlGqn3HhbOwpTb
         JBqCI2NmPKYz5DF+ux+6Le7hJlaPBMniGGB5mJfVe7v0GzEwik8nUb+tt9KQi8tnYy3r
         1cvjR0YxGo57StPB8D4j++IWfxVIQiw70j8JAlt42Fe2QNWLIqxGNSfNy+BIrN+3X27h
         JLpWx6lmbJAX6MMWrLDa9+zy+OkvoJkBep+ao95t3/0lkW6StHGUphfgmsG9nVj4WGLb
         anOpPMOHhBKM/VDOsNRk0XVlUG7ofCO6DH7WGnfYrHlXlOExSn8pZpfKoJb1OvBZo5Vz
         uQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692327550; x=1692932350;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8FIv/P5NEOWnZZHJHr7vxcf/Z4Pvhy6SYUyZNMnQpA=;
        b=FMkVyBrvCl2eoe3KdlpjE55DRg/FujSrg8Ju+KXQUelJNnHABlxJqG547meB/wE5SO
         V/XKPxaZZXkYTvf0WUnxaLpNbg16u+81G9nh/0HEw1vuCgRi+T6yoLsxOWwbv27jMSzE
         sJM4FrzIrnORJ9D+foYLmQDsGatseVLbCaZRpufjOEXutq5JCu3tNCD4n7LdF1g2bw5S
         K5I+C1CkexZpjxZUE/FugFm15aKqfYjlTnaZHUFJHQOJVNjjCqAwUqx7RUI+sRfqrWe6
         2FIEijxcOgGDTMIo97776r2V2AAjzyY+FfU6T+4YeIA2enE2EfumL5cybMx60vf5jyGO
         vVNw==
X-Gm-Message-State: AOJu0YwAnay+VorWP64/hIx1JzZ89WxDg30QFIE7S1xwRXEDMBdYwVy4
        f36pnOrB5YSSSJ1dr9Cr8l5NMg==
X-Google-Smtp-Source: AGHT+IEzrPpGM2b8EIV+iUlY+GtpLWxa2TTjWo4hsAE6UI5o5V+TlhzS4Ic1mKWz8vRt5/tspEXM5g==
X-Received: by 2002:a17:902:bc49:b0:1bd:d14a:7e14 with SMTP id t9-20020a170902bc4900b001bdd14a7e14mr1244165plz.65.1692327549961;
        Thu, 17 Aug 2023 19:59:09 -0700 (PDT)
Received: from rasheed-i7-P52.LCFutureCenter.com (211-23-25-187.hinet-ip.hinet.net. [211.23.25.187])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001bdc7d88ee3sm497514plg.37.2023.08.17.19.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 19:59:09 -0700 (PDT)
From:   "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
To:     hverkuil-cisco@xs4all.nl, mchehab@kernel.org, bleung@chromium.org
Cc:     groeck@chromium.org, linux-media@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        derekhuang@google.com, rekanorman@chromium.org,
        Rasheed.Hsueh@lcfuturecenter.com, rasheed.yh@gmail.com,
        "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
Subject: [PATCH v1 1/1] media: platform: cros-ec: Add Boxy to the match table
Date:   Fri, 18 Aug 2023 10:58:48 +0800
Message-Id: <20230818025848.9531-2-rasheed.hsueh@lcfc.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818025848.9531-1-rasheed.hsueh@lcfc.corp-partner.google.com>
References: <20230818025848.9531-1-rasheed.hsueh@lcfc.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Boxy device uses the same approach as the Google Brask
which enables the HDMI CEC via the cros-ec-cec driver.

Signed-off-by: rasheed.hsueh <rasheed.hsueh@lcfc.corp-partner.google.com>
---
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index c17faf002877..0b7fe074bc15 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -231,6 +231,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Gladios", "0000:00:02.0", "Port B" },
 	/* Google Lisbon */
 	{ "Google", "Lisbon", "0000:00:02.0", "Port B" },
+	/* Google Boxy */
+	{ "Google", "Boxy", "0000:00:02.0", "Port D" },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.17.1

