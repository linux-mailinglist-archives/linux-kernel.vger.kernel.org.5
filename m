Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3507D3806
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjJWN2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjJWN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:28:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E64510C9;
        Mon, 23 Oct 2023 06:28:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507b9408c61so4539420e87.0;
        Mon, 23 Oct 2023 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698067680; x=1698672480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2urRTeG3ufYgcsCQiPb5uV+eiXVppkz+Tw64mxpZfeY=;
        b=VG8WgYBCnu4eF0j6J04vYy11wA5RSF9DlylHfWgoeS1FpC50RFyUxEHkKPBnLstd2C
         RjgtXyh+B9RcxJtzrHsVXYCp/RaOdTYIgIzhdJZ1yrleEkHQr5vFaUdlMsaZ8iYAmfmu
         pzat4CKxxEyQlRGwG/s+PU84DSJb2rnUWm84IGVYZx0nYccc34Ku0DjCMl4e2bXX6O6A
         pJ0qGBtrxxPy0MUis/XJaVvNIoiu7SJzHVtJknZD11F+i4weonjCo/4st2LTXJFXprxW
         WkuDbGZ9KmwAUwjdv2HGKNB99FQx2Rkf77iXak1JAHWb3uLT8hN+IvWdrslIMdW457AI
         muPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698067680; x=1698672480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2urRTeG3ufYgcsCQiPb5uV+eiXVppkz+Tw64mxpZfeY=;
        b=vPUiScbF7nIhbRYpjJp0pqHVwuHNLJThEyqkO3u8jnuytIY3s1TGh+8zi+c4vRFrad
         j6SC9cuhmSOj+v3qJk3UK6cpwq94z9TaHJE0rj0qnBxSjXSIek6NVYe0iNA3ArETvdba
         X+5voGvLG/txFTdH8/p8HeWTbgqr/WRI17x9kjEu4E8hR/zlHiJtmfoijcEKLG+Z85Fn
         2mgithqUU+AKqg40ftw8zm+EdrAVQlrEzqYPCKpRpmX/kYTx99Y3hXp2xcdJOW3AZaO+
         t0CME7PIXQ1xLT0s7NDfaqmiXPLrbVHVVARPKnFVzfhx9ervjNVa95xIXT/mcKgWDG/Y
         itBA==
X-Gm-Message-State: AOJu0YzLLYkrjcElRpBKVF3cQJ5CuBk7+JKgpd+7ZfX1TUGnc8monLNR
        IFbdX79cw6RkS5Uj2fvT7Xs=
X-Google-Smtp-Source: AGHT+IHoOqLfenpIDVx8JfQwy19YnxYvRmL3hM1j1nZMRcsvojnGLGLzBNAhcIvEp+gdH4N+YYLicg==
X-Received: by 2002:a19:5e1c:0:b0:503:1aae:eca0 with SMTP id s28-20020a195e1c000000b005031aaeeca0mr6397211lfb.44.1698067680102;
        Mon, 23 Oct 2023 06:28:00 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d6843000000b003143c9beeaesm7785417wrw.44.2023.10.23.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 06:27:59 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] agp/amd64: remove redundant assignment to variable i
Date:   Mon, 23 Oct 2023 14:27:59 +0100
Message-Id: <20231023132759.666224-1-colin.i.king@gmail.com>
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

The variable i is being initialized to 0 and then again in the
following for-loop. The initialization outside the for-loop is
redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/agp/amd64-agp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index ce8651436609..47bd3b8a54b4 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -333,7 +333,6 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
 	if (!amd_nb_has_feature(AMD_NB_GART))
 		return -ENODEV;
 
-	i = 0;
 	for (i = 0; i < amd_nb_num(); i++) {
 		struct pci_dev *dev = node_to_amd_nb(i)->misc;
 		if (fix_northbridge(dev, pdev, cap_ptr) < 0) {
-- 
2.39.2

