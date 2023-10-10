Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B777BF1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441896AbjJJEcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 00:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376523AbjJJEcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:32:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D521593;
        Mon,  9 Oct 2023 21:32:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so6593866e87.1;
        Mon, 09 Oct 2023 21:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696912325; x=1697517125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9nKNkeB60RcbKm6PBPumuMk8T7ADkJrETtJNbo1qqOk=;
        b=QkYtLvqgeZBo+muGmPfmDHF+W4IO0Z8kcszfW7pSpMUgWlt0ZIKA8zYaaa1dcp2DkP
         4Qb+Of1dtcCAz2BaO5Ssqy+41nYCqeEphBWsRxmH66ISgx9Mc0jpjjUsP6BGHZ7QmsX0
         e6OFgtsVM/CY4PQKVUEMMfAn1tsLbByv7B6X9y2OWvXTIjr5f6OPgOzLu6HwyyyBYnD+
         fZfzhJ8yLDsbNOjEvrmDp4QbF2A+h3v/tdEy36WbnYqhjlv2kOAPShWEVCm2pokSH3ib
         4ASfGzxKgd7BEJFSsHYE/IKvk3laT/I898RprWD8SZdLqlSlhdFG98YHoNi0a3BewOyx
         BZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696912325; x=1697517125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nKNkeB60RcbKm6PBPumuMk8T7ADkJrETtJNbo1qqOk=;
        b=uosltJ9A+AB0V5P3LiQl6yvPN8l9Yf9XHqLaNmkXazvLEEr8u3vY07VpP+lHy/8zbY
         N07VGE7+Guy4ONwkehtfsOsB6fDNe5Q8PVb6BevNtagCnMRd+XRNTUCmeyrUTEFr/j2m
         U/P7iaktsgN3kY7z6F986GKZ0mHjxeuXLbrDqqX+E2SO7oAxFp/m8jMRoUzvU4yrPkYT
         1GfzZO/O9eHzvSO8ZE1jzvxTXsVWS7hXovpLfWaTOYvGpNTgxtGKCe9dDQbUvPEbjAMK
         CPg4d0YZe98cI6RZrWPTMd4gk14Qf5lwhyallT1BJ4pbgcH0zYK53PsCQkMpWmirvqMI
         5U2g==
X-Gm-Message-State: AOJu0YxJr+w8TrC0ufEOqF7rTM4ei13kbnqqDG4oW4yx6WGf3m0Q7lbO
        ODexvVug40UXTYRrYcqXd+V5LWph3PaTMA==
X-Google-Smtp-Source: AGHT+IHWRx+A7cJPzt73D92sd+iDa7yee5wkK1MMtlIDbr0A0Xd9lNB4XQli8GkxmceQ14MGPzKuqw==
X-Received: by 2002:a05:6512:3b28:b0:500:7de4:300e with SMTP id f40-20020a0565123b2800b005007de4300emr19372157lfv.58.1696912324724;
        Mon, 09 Oct 2023 21:32:04 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id i12-20020a5d630c000000b00326b8a0e817sm11351688wru.84.2023.10.09.21.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 21:32:04 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     sth@linux.ibm.com, hoeppner@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH] drivers: s390: dasd_int.h: resolved spelling mistake
Date:   Tue, 10 Oct 2023 09:31:40 +0500
Message-Id: <20231010043140.28416-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
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

resolved typing mistake from pimary to primary

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 drivers/s390/block/dasd_int.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 2e663131adaf..1b1b8a41c4d4 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -283,7 +283,7 @@ struct dasd_pprc_dev_info {
 	__u8 secondary;		/* 7       Secondary device address */
 	__u16 pprc_id;		/* 8-9     Peer-to-Peer Remote Copy ID */
 	__u8 reserved2[12];	/* 10-21   reserved */
-	__u16 prim_cu_ssid;	/* 22-23   Pimary Control Unit SSID */
+	__u16 prim_cu_ssid;	/* 22-23   Primary Control Unit SSID */
 	__u8 reserved3[12];	/* 24-35   reserved */
 	__u16 sec_cu_ssid;	/* 36-37   Secondary Control Unit SSID */
 	__u8 reserved4[90];	/* 38-127  reserved */
-- 
2.27.0

