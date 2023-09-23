Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982C57ABE4A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjIWHOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjIWHOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:14:08 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103519C;
        Sat, 23 Sep 2023 00:14:01 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 46e09a7af769-6bd04558784so2106654a34.3;
        Sat, 23 Sep 2023 00:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695453240; x=1696058040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5wNl5BJ8gcnnggkuY+vRKw97Vo+2bqxg83VB63bOWl8=;
        b=bk6ppflbWAjsklN79HxmVFxASbupL4zewXKKvuwneg8voKj5aXjJ+hdMc2oHq4S9vj
         6Z07oiE41zsbM8wY87N6YKR+3NZYAa7p6IZDliJAUholML2psP2B/HwndKNEjwo2pyJO
         sopNySXj6AtNGLTq5KTewWlczjyl0VGZvFC8dISt/9TzOzUrls0TnKclgIjJHatlCZXJ
         rpyrZ2R2oCRNwFZatM2Fr3bg3ghr2lYcJGGt5i7ieuHaeHsHTozND3JMGhELg+ArxlXO
         ugoTFRxNdkmb6oB7PoiBbHh+iZiPTh9JvPuR88NQ0tQU+PzKtASeH0bt2jOPW2CeaXPK
         yU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695453240; x=1696058040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wNl5BJ8gcnnggkuY+vRKw97Vo+2bqxg83VB63bOWl8=;
        b=rzn6Mn4H/7Tg8j2JyX5KbFNDvQUnH8ubZ34ei+PqBRWUFPrxHwbj5j03/piSCYbekN
         0WACIbtIRnmAjhFpBIwge0VFw2uj+cx14CQDC5cZYDgrsanuWrOLgC2VDC6esUV57vol
         95jH9j6H4O4vaxoLvqkzz7agGsNZhgruc5ytjiBn0yZ/akTU2crnK1O6EpojowR9GpOK
         KVl8qRF5xzerHs16xmvRNVgzBWn9sPphouylVDculYln1ByAEIX+yLO5HBh+5GOM8rVU
         V8mhLmEq1WVN0QwxVIS0onAQGmpkZH7OjL0Z1rvouUgra/lP02Zj44u/WsK7Giesuxgm
         ETIg==
X-Gm-Message-State: AOJu0YyTrd8gPuBTLYLDlVVkDQTs8nw8PVCUbZI0cQ+jhZyAi/jLTWwp
        oVD0gCpAQforktn1HVHSizU=
X-Google-Smtp-Source: AGHT+IHUfdoy7CjQbWdS9m+R0sBXBZv8WhO5L/m/psbBj4/P+EpfeZ4GF/16P6C2uWOtFeX24PF/ng==
X-Received: by 2002:a05:6358:9222:b0:135:85ec:a080 with SMTP id d34-20020a056358922200b0013585eca080mr1678964rwb.32.1695453240497;
        Sat, 23 Sep 2023 00:14:00 -0700 (PDT)
Received: from localhost.localdomain ([140.112.90.93])
        by smtp.gmail.com with ESMTPSA id x41-20020a056a000be900b006877ec47f82sm4315136pfu.66.2023.09.23.00.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:14:00 -0700 (PDT)
From:   Jianlin Li <ljianlin99@gmail.com>
To:     corbet@lwn.net
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jianlin Li <ljianlin99@gmail.com>
Subject: [PATCH] docs: x86: Update spec URL in x86/iommu document
Date:   Sat, 23 Sep 2023 15:13:45 +0800
Message-Id: <20230923071344.540894-1-ljianlin99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous link to AMD IOMMU spec is no longer available,
replace it with the new one.

Signed-off-by: Jianlin Li <ljianlin99@gmail.com>
---
 Documentation/arch/x86/iommu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/iommu.rst b/Documentation/arch/x86/iommu.rst
index 42c7a6faa39a..41fbadfe2221 100644
--- a/Documentation/arch/x86/iommu.rst
+++ b/Documentation/arch/x86/iommu.rst
@@ -5,7 +5,7 @@ x86 IOMMU Support
 The architecture specs can be obtained from the below locations.
 
 - Intel: http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
-- AMD: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
+- AMD: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_3_07_PUB.pdf
 
 This guide gives a quick cheat sheet for some basic understanding.
 
-- 
2.25.1

