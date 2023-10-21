Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3DE7D1C63
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjJUKPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:14:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF448D66
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:14:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a55302e0so2100713e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697883296; x=1698488096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54U+E9W9K0OaBdlR5lzHV/a+8QqdJ6fYDyraEx8zyqE=;
        b=C4MXKvDbFm0xM+3ILpOBEkPhyN0GpARXVviEVEDtD4DtCtFAYb2YaKx6zWzvaey00b
         2FqjTvvYLzHM2QJi4icy7ileIIls7MyhPI11tTJ9gLFY9IDTeFnOaUQ8eGZ4F1JXe4lS
         ydKdwtCucwE9ypAyy4Un2I5WnJrIHAed4eFkYGmvTVVfwzIdGjcMPNi8Q2+QSwgJwQVh
         1ylGt4yYZeXBkk1H3f56ihIhaETFLA8eZT8IUIDiY3YFPB9w1VBwGkPBgzII5EST391O
         GlvAwsyKXEM/L4upapyJGg4VVoiHY1eCHvjZWGOvhgYqdbdJEeY2txZThjXvlinhOc/w
         Lmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697883296; x=1698488096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54U+E9W9K0OaBdlR5lzHV/a+8QqdJ6fYDyraEx8zyqE=;
        b=kMrREUzpOr8UyAxpGkKfYZrKMkub6k1oH2COQnTyPDb7sMu4maRUvjjTn3N3nPZcbW
         zjaLcZD0bTsW5NQ+FffU3TkZEf4MtvmNBU04Zp1hTNobFQufetNCTVG1GN5H1v1lc66n
         JY60Wtw8e5SNXprUCz9GLOL8jqUysYdNiwkCbE5aCqshB4GUgbvalNHhckrsnH7PABn6
         ppX2Xp5bTS8VAwoKXlnkaHosvc+uVv1TqsbVpFETDEGQTGMR3CCJodoIlm841PTo49w2
         /XJt5fYxe1RrOfyMxVUUUA8poWw6AdI1rX5GG0IU/SXzmKtsKR8ZAGnw+Po4VfcrgWkR
         3djA==
X-Gm-Message-State: AOJu0YysjHDTr6BV+MCUX2kW4aZ17yHEXTTJ3aQ2Z+IkjG1aTEH6YRS4
        SLkfAxn3LMV3w6k/yHn10w0=
X-Google-Smtp-Source: AGHT+IF4HwHDY5OOqVDBCMW9b6O+w115b7KFZw6tu7WvakGEpq7rLPnhLcH6W5i3GsnyiXl6mUhQ/w==
X-Received: by 2002:ac2:4284:0:b0:506:899d:1989 with SMTP id m4-20020ac24284000000b00506899d1989mr3113028lfh.44.1697883295672;
        Sat, 21 Oct 2023 03:14:55 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id d18-20020a056512369200b005007e7211f7sm803114lfs.21.2023.10.21.03.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 03:14:55 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH v3 1/7] staging: octeon: Fix introduction of new enum typedef cvmx_spi_mode_t in octeon
Date:   Sat, 21 Oct 2023 12:12:32 +0200
Message-Id: <20231021101238.81466-2-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231021101238.81466-1-bergh.jonathan@gmail.com>
References: <20231021101238.81466-1-bergh.jonathan@gmail.com>
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

This patch removes the introduction of the following new enum typedef
cvmx_spi_mode_t and fixes up where implementations which used it.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
Changelog:
v1 -> v2: Fix breaking change spread across multiple patches             
v2 -> v3: Break changes up into individual patches for each removed     
          typedef

 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 3e7b92cd2e35..9f269626b862 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -213,12 +213,12 @@ enum cvmx_fau_op_size {
 	CVMX_FAU_OP_SIZE_64 = 3
 };
 
-typedef enum {
+enum cvmx_spi_mode {
 	CVMX_SPI_MODE_UNKNOWN = 0,
 	CVMX_SPI_MODE_TX_HALFPLEX = 1,
 	CVMX_SPI_MODE_RX_HALFPLEX = 2,
 	CVMX_SPI_MODE_DUPLEX = 3
-} cvmx_spi_mode_t;
+};
 
 typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
@@ -1362,7 +1362,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
 }
 
 static inline int cvmx_spi_restart_interface(int interface,
-					cvmx_spi_mode_t mode, int timeout)
+					enum cvmx_spi_mode mode, int timeout)
 {
 	return 0;
 }
-- 
2.40.1

