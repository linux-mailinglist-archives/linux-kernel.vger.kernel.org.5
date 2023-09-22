Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4AB7AAD4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjIVI7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjIVI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:59:31 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1830F197
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:59:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690d9cda925so1694524b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20230601.gappssmtp.com; s=20230601; t=1695373164; x=1695977964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HaTCJAnPpNWA+hL+ZaGbfhKHNW/aJAEE+SMYIWeebKA=;
        b=qNuo2SixK1QmIfVO9UCO0fq9I7vZMBbDWkxlOhW4mW2drF9UJU56OnuyPp5clF3Ep8
         4FEReZHYCmXdbOoIN59Zc8HOujPT81+cHkf18gKP8nOD0O2OqXAG+rPrbt2Hje7l/MYe
         xbRx+zd8YbHWl405bJjvxM2o3gov9Hrzs4FBnoRcgz6NC0BHlQbr8Mxgsf6i8g9XlM8s
         4N2O3MYDa/eVVG3ehDoAUOcEuCTF0WGjt2CkiTuv9e7+5ud9x3/4Z78+N09fdNxrlRyf
         9+lP2IyaZEXwTt7Xlf8sB0j51UjlhiwOvBA6+QG9rcLmRvL436UUXLs496vJNYSMH6CD
         FY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695373164; x=1695977964;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaTCJAnPpNWA+hL+ZaGbfhKHNW/aJAEE+SMYIWeebKA=;
        b=n+rwrfg7fn8FtmJxqRzSttTtm6kutQdB3hvCtj2fe0YjPc+oLBTdEi6E6gD7JdgsfJ
         jgpKgyKPWQGbUQnquln4XLf5DcMp2s7SK4aM5iQ0w8M6XrVQNX4aQ2a9JlIipU3XNW9W
         AFlvmhXQwpTncsJWXAf0UvPZR+Abj6lyoblk4eDSaBuFDXZkWaPnhgA6v8qcZGvxlC3M
         I7B+368keAOkAVoGc4B7yr4p6nVm+yfBYRuOAAs+l9M+BkLKd9qf0cFxiZC+UaGnyTo4
         V1wyWGelNLX1wkE8bkRZrEcm7KD7zNqgVZyIUlP47jnLlIjtU/6EQS48z/WQU2yCc2vy
         +2jg==
X-Gm-Message-State: AOJu0YwIQMEuDxjlFlbR/t+k+NP22oRaofiYfF3/Ni9k6U8YIvTS2Px1
        +H/nEI5cVDCphw+0rCpOjqr7KFP9HeRjFhC5PHtgxw==
X-Google-Smtp-Source: AGHT+IF908zNeyhLj+FFOak9pOjcMCnQv/Am5lRWt8+dnS43wTzERnpZHX2jAV0QZqoAOKkyv3c7XA==
X-Received: by 2002:a05:6a00:847:b0:68f:c1e0:a2a2 with SMTP id q7-20020a056a00084700b0068fc1e0a2a2mr8662337pfk.2.1695373164550;
        Fri, 22 Sep 2023 01:59:24 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id d17-20020aa78e51000000b0064d74808738sm2733778pfr.214.2023.09.22.01.59.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Sep 2023 01:59:24 -0700 (PDT)
Message-ID: <9e27ba1341a5474d444165891b0853137eae2579.camel@areca.com.tw>
Subject: [PATCH V2 3/3] scsi: arcmsr: updated driver's version to
 v1.51.00.14-20230915
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 22 Sep 2023 16:59:24 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

This patch updates driver's version to v1.51.00.14-20230915

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 2f80a6a..12c4148 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -50,7 +50,7 @@ struct device_attribute;
 #define ARCMSR_MAX_OUTSTANDING_CMD	1024
 #define ARCMSR_DEFAULT_OUTSTANDING_CMD	128
 #define ARCMSR_MIN_OUTSTANDING_CMD	32
-#define ARCMSR_DRIVER_VERSION		"v1.50.00.13-20230206"
+#define ARCMSR_DRIVER_VERSION		"v1.51.00.14-20230915"
 #define ARCMSR_SCSI_INITIATOR_ID	255
 #define ARCMSR_MAX_XFER_SECTORS		512
 #define ARCMSR_MAX_XFER_SECTORS_B	4096

