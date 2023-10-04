Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44307B7731
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbjJDEkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjJDEkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:40:31 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9168590;
        Tue,  3 Oct 2023 21:40:28 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1e12f41e496so1114360fac.3;
        Tue, 03 Oct 2023 21:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696394428; x=1696999228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/crcVPn1Jhlshr/NTPd48q9zyU3B6RW2LIG2ZLiJMi0=;
        b=B1bZ0SUfG60nes5JWYr4EgrL18n1NWmqx9eaN1FnuH7dUNAluQ5xsHpKT22Kc74Oc4
         4WMWlfkfHgGgOkYqwQzaFl97dKbqdILzLte4bdgYW977Y1xLXQbl0o94PZO9e5vPq2kz
         LlvuZS12I17h/6XQIgZBkDnx970PG9sG0uM7BMOan3egtqvpBZdx75r2kW+/GvRjfngL
         OdMPoor76FnGDdDpRkHs56ZO9T5hMdGjncN/W1JHdgIcm8xITlYb2QfDeOVmkxhSFA6q
         PBOJ5ou2HXbBg+OJY55hMKHs5G+vv3WM2JOHRKqh8dsWVV93mk24WgFyboDPDEy86+9g
         PKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696394428; x=1696999228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/crcVPn1Jhlshr/NTPd48q9zyU3B6RW2LIG2ZLiJMi0=;
        b=tcRSMcSaoA0AHYEdDB6ScWMhPicaDODNlxPOiPCfjENAVzi5w54IMzaSQd/5z9UDzc
         LfO+QQ5MvR4XkIj2jISnOJa53QCkNdT+sCjOWxb/XmwWrncSLNLbwaxKrJGpuhs58rYc
         wR37HX7s062olzbzgbqtiCC2fYwWayNss5VE0t+QztKhTPSqh1bT6lXTA9VOxCNr2HUI
         inLrIB0U7240L8OIN7aYWBF4MpXuSzdGAMdv26xFszEcXf+Lcd/g6j8geXdVapu+J+A+
         KOeBoPCOXqwPFqEBB388iCPhwKXEfKLJirxcGe4kdKCNuuSJYXjH9+G6J6TmPHiCa8aF
         ghpA==
X-Gm-Message-State: AOJu0YypnP0swjyDs15x6AuraVL6mFjZ9pZrmRb+uU6ZEuAmPk/e2Lj3
        8P4Qio4YMYAZ9uRpgp/kwkI=
X-Google-Smtp-Source: AGHT+IFttcrU0q0eOjsvnLjSOQN8Lm6fZlLI8pJ5sFMGB3W5jMFVXO/H4nvE/ikbHMNWlmEp8xSHCg==
X-Received: by 2002:a05:6870:e611:b0:1d6:cbcd:80f8 with SMTP id q17-20020a056870e61100b001d6cbcd80f8mr1551179oag.54.1696394427622;
        Tue, 03 Oct 2023 21:40:27 -0700 (PDT)
Received: from localhost ([2405:201:a40d:5ac2:680f:b470:5925:ab0f])
        by smtp.gmail.com with UTF8SMTPSA id gu27-20020a056a004e5b00b0069348918cfcsm2213753pfb.193.2023.10.03.21.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 21:40:27 -0700 (PDT)
From:   Shubh <shubhisroking@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shubh <shubhisroking@gmail.com>
Subject: [PATCH] soc: qcom: cmd-db: refactor deprecated strncpy
Date:   Wed,  4 Oct 2023 10:10:17 +0530
Message-ID: <20231004044017.37027-1-shubhisroking@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Prefer `strscpy_pad` to `strncpy`.

Signed-off-by: Shubh <shubhisroking@gmail.com>
---
 drivers/soc/qcom/cmd-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 34c40368d..dc42704d7 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -152,7 +152,7 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
 	 * query string is not necessarily '\0' terminated if it bumps up
 	 * against the max size. That's OK and expected.
 	 */
-	strncpy(query, id, sizeof(query));
+	strscpy_pad(query, id, sizeof(query));
 
 	for (i = 0; i < MAX_SLV_ID; i++) {
 		rsc_hdr = &cmd_db_header->header[i];
-- 
2.42.0

