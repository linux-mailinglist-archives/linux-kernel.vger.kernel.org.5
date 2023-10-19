Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA43A7CF1BB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344906AbjJSHzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjJSHzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:55:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CD9124;
        Thu, 19 Oct 2023 00:54:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507c5249d55so3058587e87.3;
        Thu, 19 Oct 2023 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697702097; x=1698306897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXJ/Mr+spXECJ9u0aAvXnCzzdApNwtlPUw+XhQPOmiE=;
        b=e0DCnjIJ0KC82mf+oqwh0/o+YUCkFPpsjshuG/5RB7trYriLGI0Q0xZ/GrZz/acjOk
         bUJi6HsW+tPDbwXNmaCnkuh4yE6WKk4Vm+5KLI9Iz5bgNIi/z6HwnMO9/7JDyfWwyfIX
         uC1qBvJnPApas892IwlilYShHIzJ2qL+THAjq82nrmqOe8F3JiWFemfhWcs5BgmdfLI4
         44+pua6NizIl3/SHcqfKUA+Lov5OvMktkOFRguzbnSa4GCevDPDigREHISn/dxRk++I/
         lOrgBb0RbgeI9f/KUWQfL0P4kb6BhyLlDTbeCtag22qR9l5nIe8C04Wsbgd9VOlWrvP3
         YIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697702097; x=1698306897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXJ/Mr+spXECJ9u0aAvXnCzzdApNwtlPUw+XhQPOmiE=;
        b=WHg6W5QMBMfLh+V1IrMG8lBzFTYoKp76oDKv8MNAwTzwl8P49M6mPUCD6mnZ4TXcDX
         dBa4CKYALW1Tay0zqrINczffF5fFg7pErXX7wV8dpCR52RWrBjuNZtITdkDZDps6sZbm
         /fZqtlXA5aDLFZAnLlv5yZao7HpuSmCBGT62Qr/QE4UEDDcGOoU9D6vUeiSyze5Z45BE
         HAsqBTMSVDKVxCb+NMndj2Oe4bjaei6RZgc60Gly23cU05dez+enmqNC7MnY/tNKCodN
         MG2YAE5Kgz6qD3Vn+B1X+Uu3IUTX8XZD88TtHUEU6ztFEcBlaozPWeQdxeegwIBS3vgD
         e81A==
X-Gm-Message-State: AOJu0YxYjaDZ2eJAjNj1HZPDLyWhmK/ZEiDrrSOeIx6fmu3HdgE06RfZ
        dPtRFgQzmPvwZrvIyOzXfxCFzx/j2Ns=
X-Google-Smtp-Source: AGHT+IGhBCdv3F02RoO6WXb7swa56I2T+hnTKGyT76SnzWyqXbwC7LTjG7c2oBJSqzEOTMfGgxaX3A==
X-Received: by 2002:a05:6512:455:b0:507:9dfd:f840 with SMTP id y21-20020a056512045500b005079dfdf840mr909014lfk.68.1697702096870;
        Thu, 19 Oct 2023 00:54:56 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c18-20020adfe712000000b0032da49e18fasm3881275wrm.23.2023.10.19.00.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 00:54:56 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] bcachefs: Fix spelling mistake "strcuct" -> "struct"
Date:   Thu, 19 Oct 2023 08:54:55 +0100
Message-Id: <20231019075455.369650-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in an unsafe_memcpy message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/bcachefs/buckets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index a1a4b5feadaa..9e93de2670d5 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -475,7 +475,7 @@ static inline int update_replicas_list(struct btree_trans *trans,
 	n->delta = sectors;
 	unsafe_memcpy((void *) n + offsetof(struct replicas_delta, r),
 		      r, replicas_entry_bytes(r),
-		      "flexible array member embedded in strcuct with padding");
+		      "flexible array member embedded in struct with padding");
 	bch2_replicas_entry_sort(&n->r);
 	d->used += b;
 	return 0;
-- 
2.39.2

