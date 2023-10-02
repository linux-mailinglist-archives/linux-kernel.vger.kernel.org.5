Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DAB7B4F93
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbjJBJyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjJBJyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:54:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F8E0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:54:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-692779f583fso12025961b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20230601.gappssmtp.com; s=20230601; t=1696240453; x=1696845253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:cc:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/WeJY/PqNDvxvNMtQMBDU2MORKpRU53y8JzmRVuDi1g=;
        b=QdTjfUB2rxhds4Ts1F8vJCXMBV5o51XpRNOJU/Y+MVuDQZSX+6l06gmhfuexlmUDw2
         8MsGOKd7h7BxjwQ0fcDDXR2Z1a1sukvWdRocb1eYFVistdcYlAzOMNCoJdaqizCxOKNN
         6GG5Catn3GyG0M+16UKxOkwWuBzhovwWZ3Ck2BJEgR7+4ySTKegfJc86wThu7R3NJ9Nd
         Qe437rJFWAL9sX19D0ZkyevB84DRU0e02ydBiYv8q1Prg1OvctqZbuN5GEedbIQC1b35
         sN0/Nb5v/ACg1nxa6lOpe6L7/EUWlRFZEuhcs9AF2WoBAg5qZ4zVhxaoeVJMAgf4NW0J
         8g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696240453; x=1696845253;
        h=content-transfer-encoding:mime-version:date:cc:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WeJY/PqNDvxvNMtQMBDU2MORKpRU53y8JzmRVuDi1g=;
        b=sIKevpDmynWrQqTLXMWKkmvxhJZU7wTArycAxsD+vkIvXMsNe649I0azLNVVsq58XX
         1v3BlO8lxOzOqGwHxhSjOlXt3RQJSbou6OlYZFo8hnHvKroZxhCDzkrHkkNwVM8HZVL9
         igGTEzj2R25gLrKNclA6Fq+QZu4XPKYxo304XQ2HckoaSCDFKqmUU6zakbhY0hEqiqb1
         4D3plX2ZmV0Rl7z+YLi6q7jhP/O4WKfICb7C0bi7sj8y7cAsJ4/RlFjWmoSzdkkUcgS9
         Dz7srUbzTY8aYDaVGjNo7fGugPtd0nEzz2XFewaAKfTF0dCzpgXgpxI/O0NxE3THVrK1
         XERA==
X-Gm-Message-State: AOJu0YzdS7E9gvYh9U+fdrECFO3uYNwXI3SbW1LdgE3W21kO/UtQjsAi
        /lOsHACreEBHE/1h6/yiqbH35g==
X-Google-Smtp-Source: AGHT+IEviW7j5XCFdfsYtjJIdmNTgL39+izAKE+TL+5UUgJ/nGOyRtatzU29215y+O7nGR+sclWD+A==
X-Received: by 2002:a05:6a00:24c5:b0:690:ca4e:662f with SMTP id d5-20020a056a0024c500b00690ca4e662fmr11052853pfv.5.1696240453410;
        Mon, 02 Oct 2023 02:54:13 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id r25-20020aa78459000000b006933f657db3sm8186374pfn.21.2023.10.02.02.54.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:54:12 -0700 (PDT)
Message-ID: <514898a472dfdf0502afe27d127ed5145a1fb915.camel@areca.com.tw>
Subject: [PATCH v3 3/3] scsi: arcmsr: update driver's version to
 v1.51.00.14-20230915
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     bvanassche@acm.org, kbuild test robot <lkp@intel.com>
Date:   Mon, 02 Oct 2023 17:54:20 +0800
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

his patch updates driver's version to v1.51.00.14-20230915

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---
 drivers/scsi/arcmsr/arcmsr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 2f80a6acb..12c4148fe 100644
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
-- 
2.39.3


