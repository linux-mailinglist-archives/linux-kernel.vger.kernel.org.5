Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACA776111D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjGYKoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGYKoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:44:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F4610D4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:43:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso52618255e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690281837; x=1690886637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2+LOkmbRzocNLGHFc65c1vCZRpwTkaqodGNOPSIAJU=;
        b=QRAUr/fNWYjB0sOxrI8MMRk87D1j2LMRs7ByIWGHV02Y+iFcHv5AnkKaJ4jo/3WkQQ
         gTIpW4yMlpTKWW00bLhLpD9HCS08121iceRfhHIFqs4FQoAxpigzlblcApJfliU0DLu1
         Fww/vuWbs/HhGvYYWb0vhdVa2Ygo7nbMcT200KrrjHVYquOhuDxB6vu0knKLJaamkmLp
         ToUTTPiG5CFN1T18MkEQofHAuNUr9aUIqLf7fmmDz8GMJKr0Rfb3QZvr8yZDcaRveY3u
         mIaZBorI1JvKm28Eb+aGIMu9mZCvSisgna8BS0deWIhMMwlk4OuZgBewSalsTvHtKZ8n
         Qt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690281837; x=1690886637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2+LOkmbRzocNLGHFc65c1vCZRpwTkaqodGNOPSIAJU=;
        b=PG+YOAZh4sdUZN/kRnZmUPzrEs+aoPFfGnNBtjlSJcqoh70oaF9D1FOcd8T0SaFUYi
         C9mlkDSETumdsbOtoh4c9iktMmGyejpMgkKGFy7nKRy81eg7Uore2FQXwNRbf8F3KKH1
         VJ5ofVL4HiwqcH+rUtRVfBbbSw0RzPK13soPjRXYNnrVbPw3/ZuDXp5Y6d7pB1mdhHP8
         bW2oRwTOVg26/VYU9VbO5n5s3g3neYbdP5q+jCVTxtwMzy6rJtZHzOrfukHhtfXZQnAC
         LuwerbMje4l4pq6jcwyxW1ZynEIdme+YlfTqClJsxzhN/cLvcHFhTQIkQLi2DTQ9c9ST
         sYtw==
X-Gm-Message-State: ABy/qLaE9IqKsETX1mTV0i+qgS5NTGvAP4heNSDkyzOZTUtmpkCLc1MY
        KLZwG90lmLjN2e+he5aHq/CbGnI+Tpj4jXFTR+H17w==
X-Google-Smtp-Source: APBJJlFgnYys6xLwEPqvMSaNFLz0aaGFAQiC1lUMCbKi1QUfpXLwHlZMzXcC3NjQhAM4FS+FHyhNCQ==
X-Received: by 2002:a05:600c:2a54:b0:3fb:a917:b769 with SMTP id x20-20020a05600c2a5400b003fba917b769mr9567467wme.21.1690281837646;
        Tue, 25 Jul 2023 03:43:57 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d6b8c000000b003143c6e09ccsm15793723wrx.16.2023.07.25.03.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:43:57 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, linux@roeck-us.net, jdelvare@suse.com
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        openbmc@lists.ozlabs.org
Subject: [PATCH v4 1/3] peci: cpu: Add Intel Sapphire Rapids support
Date:   Tue, 25 Jul 2023 12:43:51 +0200
Message-ID: <20230725104354.33920-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for detection of Intel Sapphire Rapids processor based on
CPU family & model.

Sapphire Rapids Xeon processors with the family set to 6 and the
model set to INTEL_FAM6_SAPPHIRERAPIDS_X. The data field for this entry
is "spr".

Tested the patch series with AST2600 BMC with 4S Intel Sapphire Rapids
processors & verified by reading cpu & dimm temperature.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
Reviewed-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
Changes in V3:
- Move spr entry at end of struct peci_cpu_device_ids
- Mention test with the patch.
Changes in V2:
- Refactored from previous patchset as seperate patch based on subsystem.
---
 drivers/peci/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
index de4a7b3e5966..bd990acd92b8 100644
--- a/drivers/peci/cpu.c
+++ b/drivers/peci/cpu.c
@@ -323,6 +323,11 @@ static const struct peci_device_id peci_cpu_device_ids[] = {
 		.model	= INTEL_FAM6_ICELAKE_D,
 		.data	= "icxd",
 	},
+	{ /* Sapphire Rapids Xeon */
+		.family	= 6,
+		.model	= INTEL_FAM6_SAPPHIRERAPIDS_X,
+		.data	= "spr",
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(peci, peci_cpu_device_ids);

base-commit: 55612007f16b5d7b1fb83a7b0f5bb686829db7c7
-- 
2.41.0

