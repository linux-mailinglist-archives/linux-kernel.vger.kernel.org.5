Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441967D19CA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjJUAEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjJUAEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:04:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD419E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:03:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507cd62472dso2804714e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697846638; x=1698451438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3QOt+Zgd2/WO0G0wH+oMWkyPIIiY/39bwhMnXAR6G4=;
        b=atJthkE9VDa8SyXB6LZEh6/DrUziyjwT/6FEcELU4TnxFcSqqSbRU3gpRoeEi01JY+
         9NsTcE158gZ7r3GYsUoSNtyiiDYNfBsJ8WXNj7QhWyyUhu25fg8lqwmtp9m4rXsH1jsz
         D7EYjGmXWsexnWop4knY9yb/nw4uWm1Mp1C9nkGcAy3nbiLMwXh37kqxEIzPXty4ftfl
         ua8L5Hod60+gHrq6Qi34clkb9iNgqCrBNwAq1bWXO96t0uJ0kUTvLqDU3ZTffdtFpyZO
         aFvTQHaqpZ9cGssfEYr7nrKwu0UIap2eKCUp697dl3vchzdwz6G61o+EvpabjH8u+WXQ
         asKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697846638; x=1698451438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3QOt+Zgd2/WO0G0wH+oMWkyPIIiY/39bwhMnXAR6G4=;
        b=v11gld8WBlBduqr5BBr93p3BPK/cmQpay7fTtZ8mkaBz0oqyOXhiZFj4piKU/EpsO8
         T61yWnChrY6MyFgwEcCjruT7ntL39TE5C977Qw59yoSlM69NTYQipJORekljRHhf4Jd3
         fVVn/8LxZqKwLRjdRof69Jej1fnHXV+PO3eb/WzC98klx+Tf0qmntK0s4+QoLq8/zxPe
         9zqCdHUWyRgKgOtEyxYY1zvrR8gTcSfvrU1/yOaEB8WrTZK3RrUOunKuWCNxl4a8Libe
         58FR162D/qYUbQh360AmmHcOcNyjiJKs9FwjvcHFVQoywYI4CDQ7WG+PD+yUMp6bbWSE
         oXWg==
X-Gm-Message-State: AOJu0Yx/f+30MugMmSGCMzgRB474SZH3ViWTOaVt7tb84OkIkl6OH+ZO
        fevT72B4HXBdjKqj767ut92KC9mebr3YRA==
X-Google-Smtp-Source: AGHT+IHmQfVR+6oJ35CKxqhWsV1GQHCSuiO/Aj3kUxDOOOv5UnkYEtXpDFc6iKuLqKMVppxjWqdJhA==
X-Received: by 2002:a05:6512:10c8:b0:504:567a:19a7 with SMTP id k8-20020a05651210c800b00504567a19a7mr2085249lfg.2.1697846637526;
        Fri, 20 Oct 2023 17:03:57 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id n13-20020ac242cd000000b00507ce48e283sm595463lfl.206.2023.10.20.17.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 17:03:57 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 2/2] staging: octeon: Fix remaining instances affected by removal of typedefs
Date:   Sat, 21 Oct 2023 02:03:40 +0200
Message-Id: <20231021000340.56889-3-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231021000340.56889-1-bergh.jonathan@gmail.com>
References: <20231021000340.56889-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the remaining instances in ethernet.c file affected by removal 
of the typedefs from octeon-stubs.h

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/octeon/ethernet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9eee28f2940c..8e1f4b987a25 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -201,8 +201,8 @@ EXPORT_SYMBOL(cvm_oct_free_work);
  */
 static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
 {
-	cvmx_pip_port_status_t rx_status;
-	cvmx_pko_port_status_t tx_status;
+	struct cvmx_pip_port_status rx_status;
+	struct cvmx_pko_port_status tx_status;
 	struct octeon_ethernet *priv = netdev_priv(dev);
 
 	if (priv->port < CVMX_PIP_NUM_INPUT_PORTS) {
@@ -798,7 +798,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 
 	num_interfaces = cvmx_helper_get_number_of_interfaces();
 	for (interface = 0; interface < num_interfaces; interface++) {
-		cvmx_helper_interface_mode_t imode =
+		enum cvmx_helper_interface_mode imode =
 		    cvmx_helper_interface_get_mode(interface);
 		int num_ports = cvmx_helper_ports_on_interface(interface);
 		int port;
-- 
2.40.1

