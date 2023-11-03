Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA26B7E0C71
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjKCX6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKCX6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:58:00 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C2FD49;
        Fri,  3 Nov 2023 16:57:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c515527310so36600931fa.2;
        Fri, 03 Nov 2023 16:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699055876; x=1699660676; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5tRGRDD9iUOnf+TSyluTXFW45x82OJKqu/PEWf0C3A=;
        b=VG+erxz6tjCF2xozAm0wfc2KTgSZJ35A20CpI3kfTw8Jh835OpsuOtn9NOM1aKe5wW
         qPlR2MxwU0pHcssPKfUNbhuCWqhPlBlu0/1kyocKHrRACppR9MFvFtv7oOwrGoVwJRL+
         bj3UvybLm4hO0lXV3V/eN4VFJ//QjqWhY2jbBv3A2Oa9a8ywQgVuz8nrgMadT7hQg+BA
         U/oWsJ+o407+p+Hgrwm/IYbC6xkoCnCpn3G3x/dzmZJD5V9v94hXP1e2n+pK5cxpDCvn
         WIf0NQFpr8G3o+9lxKcI9yaalfk4GwbGKUoS0VMupmANm7JmIKycQZpNj9lVoD7WT88l
         2f+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699055876; x=1699660676;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5tRGRDD9iUOnf+TSyluTXFW45x82OJKqu/PEWf0C3A=;
        b=gs4eYIMsltyPldlXxvZB+QcTQNsGM6IRSpHprUF7Mwpcdw6F8ZpZRFq1M2clablPML
         bC+exmg/Y85jX5nUMAG3EoNsecBoV/WfkYNaZ+Ycmus9iMM9bL1sVPGNyRkOSNWq4w+y
         5rZoyaWB34dJoGR7byHvjpm3sZPAMCX0hklZGYCitCkUjXzy5pDWvQCGHRfZEfAVIk1M
         sPXuEM0K+QnjGff+RRRsQlJuOzSf5g3N8/J+qIz9FCDx1u9ZYPsbiB3RvlW7PRaA8K5f
         uR51KVxPSbkQ/NOcsEF14lrk+RGaVV2G+Gaugg+lS84EkxDDRUy8G1EQgz1k09ZzWy1E
         vjVA==
X-Gm-Message-State: AOJu0YzrB1d1U/OrzD71mPvMCEn2rSkN4fJ+RrWrkQ84pSk+MbhUlb4+
        WXwre5Z1QlPplYNOTgGvvg==
X-Google-Smtp-Source: AGHT+IEG9TqEqILz0vjn3OO3CyHVqnQStQg65Ehxz/evYh2guUSxcm9NbFPRWNZ02K0o0AxoYRXKaw==
X-Received: by 2002:a2e:9410:0:b0:2c4:fe14:a85 with SMTP id i16-20020a2e9410000000b002c4fe140a85mr20329212ljh.18.1699055875875;
        Fri, 03 Nov 2023 16:57:55 -0700 (PDT)
Received: from octinomon (202.51.199.146.dyn.plus.net. [146.199.51.202])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b00401e32b25adsm4011858wmq.4.2023.11.03.16.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:57:55 -0700 (PDT)
Date:   Fri, 3 Nov 2023 23:57:52 +0000
From:   Jules Irenge <jbi.octave@gmail.com>
To:     irogers@google.com
Cc:     adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3]  perf/x86/amd:Convert snprintf() to sysfs_emit()
Message-ID: <ZUWJAFlP2pM6ko0-@octinomon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle reports a warning
WARNING: use scnprintf or sprintf

Following the advice on kernel documentation
https://www.kernel.org/doc/html/latest/filesystems/sysfs.html

For show(device *...) functions, only use sysfs_emit() or sysfs_emit_at()
especially when formatting the value to be returned to user space.
Convert snprintf() to sysfs_emit()

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index e24976593a29..f2fef75d464c 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1279,7 +1279,7 @@ static ssize_t branches_show(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
+	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
 }
 
 static DEVICE_ATTR_RO(branches);
-- 
2.41.0

