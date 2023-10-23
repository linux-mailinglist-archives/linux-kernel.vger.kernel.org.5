Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7678C7D2A95
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjJWGkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjJWGkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:40:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C426D6E
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c96a82e93bso33725766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698043199; x=1698647999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Y5DjY0fyjQw4FmJ3KRfuE40fsBqLvsoancRvTj6d54=;
        b=Z+j6shu6JPz17+th00THkdC15kdRCt4UEZDrh+OZydVn587w4ThVTpUu4LgNRcQlbg
         wmSUukpr34/eimXfl+a587y7HHQ0W8yNkpuqikqvaV3mE3sefgRx6L1ob4m411BoXV1o
         YmhYodFWMnTpUlatEx2q1KcnahvNhm2E+gmAnWmfHuiaU/twN/+kawIlFfSYHAy0eWdx
         +/TTw+gpBB9YuJqfixXJfYU4ZKGn1DL03LscO2sRH4YDWFew7CUsd9+NpRJ64EPmn1NV
         zl9x0l3J0n/M0kiNNyb/u6E51T4YpWs++cKhUZa4VQjKVi2j0po9B4P701sO+14o2jV+
         bC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043199; x=1698647999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y5DjY0fyjQw4FmJ3KRfuE40fsBqLvsoancRvTj6d54=;
        b=iKkpcPDMWv/o+1ZxEmaA+OONlho6TbxPNDAXogrY6+oKKS49yHTjkHmylVDAF65pLl
         5hFWp+IOtLoAdagIpvsfIFxQ8yGlPWTuMEnG+qwbQu7n6IjkGCU3ddOdljE491E2eeoH
         DxBNAAs+K46CKPxg3U5y9+nVgwk2gsGbPs70c19kV/XtQSQDqJ0gKRYzmA79pnDc3Kcc
         fxo8wlnZVo4aMpLhSjszJQpQyYo/2HcGqC1017IqJdo8EcxR7XdsfNxbn5EExHMYdcCm
         pNj7mVwirDdud9akisSU+9fMsuHLSRQXXB1k+GQk8/kphakmBEDrRu8btF8iPr8sBSkS
         nvvA==
X-Gm-Message-State: AOJu0Ywda/SyyiOEl8+XMy3FxgXbudoT6prdAk/KXIC+E1L1As8NA5pU
        qgAxO+hbu998JhPduOCDCt0=
X-Google-Smtp-Source: AGHT+IHYMKHz44gyX9I+1TKCNnnSYaKVJmXf/24AVyP3Hxk6Uyo5yKZYJGyqosDUiFxwmTm1Jh6xYQ==
X-Received: by 2002:a17:906:74d1:b0:9ad:e1e2:3595 with SMTP id z17-20020a17090674d100b009ade1e23595mr5263127ejl.7.1698043199372;
        Sun, 22 Oct 2023 23:39:59 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id a19-20020a170906469300b0099bd0b5a2bcsm6117011ejr.101.2023.10.22.23.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 23:39:59 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:39:57 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] staging: rtl8192e: Remove written but unevaluated
 variable ucUP
Message-ID: <724cf398d27f74cb7e0f290e1a8e55ed67dffcc3.1698042685.git.philipp.g.hortmann@gmail.com>
References: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable ucUP as its value is written but never evaluated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_Qos.h    | 1 -
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 5cdecec496e0..7f086b7a1b88 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -11,7 +11,6 @@ union qos_tsinfo {
 	struct {
 		u8		ucTSID:4;
 		u8		ucDirection:2;
-		u8		ucUP:3;
 	} field;
 };
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index af4d31a66853..879e169539c8 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -320,7 +320,6 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 			   UP, Dir, addr, *ppTS);
 		ts_info->field.ucTSID = UP;
 		ts_info->field.ucDirection = Dir;
-		ts_info->field.ucUP = UP;
 
 		MakeTSEntry(*ppTS, addr, &TSpec, NULL, 0, 0);
 		list_add_tail(&((*ppTS)->List), pAddmitList);
-- 
2.42.0

