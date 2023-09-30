Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4890E7B43A8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjI3UnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 16:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjI3UnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:43:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BB3C4;
        Sat, 30 Sep 2023 13:43:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-503397ee920so23344028e87.1;
        Sat, 30 Sep 2023 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696106598; x=1696711398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WeRUrKM8X8BCdOcvYDMsa1x5SktvdTvF8z8SbqpYVFQ=;
        b=DmyfOi5Uz9N9KOa8JgvQX6tNAoUXqB0xlskYmWhzyDFYhz0PV/ZV0fb5BVWR8aW0sc
         av3gn86pkkgjCWgFrV9WKdJ0EB9nqkW3rzWvBQcSDYqC3ElS2y2ogdME/iLlP5IOxIXx
         h4A5nvPqma7Q3/ahoc3a1jyJhdTeUVhyEuYz8oB/BEPV4L6OImBLlgggxIaSCJNz33Uz
         uTxmz54E95Zf/AOQNm4aIVyEmzKZGgXXAxLWEFa/mG53YtLbLdY32Ir++QH2oEmxnCk4
         A2QxvidwtOWGo/40XQBaXDVG4WDnOJ0WfpGc6MHQSO344Mg1LrfmZ7OvAKwr/rVeipTI
         dqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696106598; x=1696711398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeRUrKM8X8BCdOcvYDMsa1x5SktvdTvF8z8SbqpYVFQ=;
        b=VQBVcZNTapZH+u0/R6ayyisrEMyrL2c6Scz1zk+dNz4o2gF7ZlDSA7F9aGXaZTil0U
         7gdsJBDDTN2p5DWE8RJgcaD1i1I/n8yN2qB9nTBomVR5LjG/V+3Q4r8ORh0qy2fvqxUO
         J/WqL41SJT+Alg2gPG7MaWFgkMDfl5fNhL6W2uMGgvRdTvAkJOu0hH3op2YFuUJHe/ZJ
         9tNTxshyHq3iK4BfbW3Gz69rVN4eo1hATR06kTlknJ57pGXtOSU1hC67VUKXtp+GB0fB
         vqjdz41uQvgFM4R8IM387isU4WKCN9PL9/53Tc+SfuNiHY8M9Hk6IOJRtWlA5F71SPNd
         0NVA==
X-Gm-Message-State: AOJu0Yx2Tu7NEgIk7XMwc1LSo6KeUolRlLNfTYjgGxufdX0GQLrjZkqG
        xnCs8jfkxTr4QSR8V6EOnI38qR4G5h/MBA==
X-Google-Smtp-Source: AGHT+IEftZ0o0Q3a8WvaH2SE+dB/j+J+v11iIIee/ONjdaJ1Qnh6lD6boFJsEoARm+TDRSErbBEAUA==
X-Received: by 2002:a05:6512:32d4:b0:505:7360:6010 with SMTP id f20-20020a05651232d400b0050573606010mr3474894lfg.28.1696106598517;
        Sat, 30 Sep 2023 13:43:18 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id b1-20020ac24101000000b005042a4cca48sm4043893lfi.12.2023.09.30.13.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 13:43:18 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH] drivers: usb: Remove unnecessary whitespace in function pointer declaration
Date:   Sat, 30 Sep 2023 22:41:36 +0200
Message-Id: <20230930204136.62015-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a formatting issue flagged by checkpatch where unnecessary
whitespace was included before the parameter list in the function
pointer declaration.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/usb/c67x00/c67x00.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/c67x00/c67x00.h b/drivers/usb/c67x00/c67x00.h
index a4456d0fffa9..3673357818b4 100644
--- a/drivers/usb/c67x00/c67x00.h
+++ b/drivers/usb/c67x00/c67x00.h
@@ -193,7 +193,7 @@ struct c67x00_sie {
 	/* Entries to be used by the subdrivers */
 	spinlock_t lock;	/* protect this structure */
 	void *private_data;
-	void (*irq) (struct c67x00_sie *sie, u16 int_status, u16 msg);
+	void (*irq)(struct c67x00_sie *sie, u16 int_status, u16 msg);
 
 	/* Read only: */
 	struct c67x00_device *dev;
-- 
2.34.1

