Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB677F15B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348558AbjHQHjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348495AbjHQHjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:39:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C322D5D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:39:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bdb801c667so49201135ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692257959; x=1692862759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GP/YjygoFF08lKY29w0+zEUUxywWJPtXcSkEiYxVUq0=;
        b=1iTAFWfpmZga4r+G95k2++vHmVPcxtc/WjH8bBREx7ocOQJ5xjgyIPZBZIwXQh6MJY
         8DkK9RWSKdSiRgMd4vYP8Xw0YYX6vHUqrvcG37SkDAA1cVvua1qLtCDM0k/YyBfNPDX4
         GrBzDa43/qLtm1LNKgWLm2ycGAm3lB9btBNogGZyPESsxjhgkW08t6cZ93Iic9LwZZZR
         yHV2rLDVyFwXOADKgL4zQwbVugJPm8S2iXzHknJNm6ryOX5SRFZoaoPpqj9Y36UCrCj7
         QzHgfcsiTJweW47/V4e0UDyLTRHCm6xVEZ673mP0x12DecE59dKZXJ6Hub3y8RczcxDg
         20Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692257959; x=1692862759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GP/YjygoFF08lKY29w0+zEUUxywWJPtXcSkEiYxVUq0=;
        b=UCzw3nCMmL0gzjBWuBYexjyY2uQMIxipx4Dx2X+EssvNqK9PxKWiLvMBerRH1u9KXY
         zNAWdVp5HEYUWjvNw8ButtkSP8l0zqhER18USBay6R7FyvlWb3etP0F+ZmIfGN3Azae9
         JknmQxP206ieqbPUSxmocd2o96w2DhJsDhHEGrqr3BHw3ZLdhiyRpeuf20ZQz+DDVJJL
         KfkQ3TF8y8n9YElsWRjOzWSrN/IIPBgn1+0rfgIuvVGvZfuVJPgWKeZwWkQ/8llG1S56
         C8H82R20CweUeG+M4/Q0VppafFGqk6HrWuEECZmBcHFz68VjigtCYikXrnv6CuYdukzx
         VV8A==
X-Gm-Message-State: AOJu0Ywd8Oew8mly5Eo4nFQGSElU7jc8bh6tSdsYOsD4NyOdBPD2TOBz
        bkffW1S60Rp1G+SnjrFNApfD3jFFbdMLXU4MyySrYwFCbSE=
X-Google-Smtp-Source: AGHT+IGnGG8VxrVBoOvaKAHseq+oyFKkMBN41lyy/3WqKack98k/JMdJUSR63V3APa6SSIFqmLfT+A==
X-Received: by 2002:a17:903:1251:b0:1b8:66f6:87a3 with SMTP id u17-20020a170903125100b001b866f687a3mr5336702plh.52.1692257958866;
        Thu, 17 Aug 2023 00:39:18 -0700 (PDT)
Received: from 64217.gitgo.cc ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ec8200b001bba669a7eesm14503188plg.52.2023.08.17.00.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 00:39:18 -0700 (PDT)
From:   Li Feng <fengli@smartx.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Cc:     lifeng1519@gmail.com, Li Feng <fengli@smartx.com>
Subject: [PATCH] block: fix unexpected split in bio_discard_limit
Date:   Thu, 17 Aug 2023 15:55:06 +0800
Message-ID: <20230817075509.1438569-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bio_discard_limit() enforces discard boundaries within the range of 32-bit
unsigned integers, resulting in unexpected discard cut boundaries.

For example, max discard size = 1MiB, discard_granularity = 512B, then the
discard lengths sent in the range [0,4G) are 1MiB, 1MiB... (1MiB-512).
The next discard offset from 4G is [4G-512, 4G-512+1MiB).
The discard of the 4G offset boundary does not comply with the optimal 1MiB
size.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 block/blk-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e835..ec95508c3593 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -32,7 +32,7 @@ static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 	 * Align the bio size to the discard granularity to make splitting the bio
 	 * at discard granularity boundaries easier in the driver if needed.
 	 */
-	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
+	return round_down(ULONG_MAX, discard_granularity) >> SECTOR_SHIFT;
 }
 
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-- 
2.41.0

