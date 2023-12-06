Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE7806C68
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377485AbjLFKof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377467AbjLFKod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:44:33 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8D6137;
        Wed,  6 Dec 2023 02:44:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfabcbda7bso5688995ad.0;
        Wed, 06 Dec 2023 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701859479; x=1702464279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEcYuPBlZQ9K89kJ8KLiP513yG9gnFFCALFubbK3TyA=;
        b=UY4FOXFKFawLtVu20rFTnPbzVasgwW+X6yMl4KN+CwjCsUXIGWs8AeFLRehbe+1+AX
         WFdkyZWdlh5RuZfuPbk7xkh9+HwbV6qFRGjf1KwF0StYnRun1vmEO8qmeakg1pf0godV
         avNAkTGiq/JmAEYdo+7qvNgv59dIp3KZ14340m7eg1r5j//1EdO61cUZc/ggcMdmV3lF
         wGXcWACedC0ilb3MAJEZstB1SZLf8zbNWd9gS5IAF2Z+3WYoNsrPtS9Bwt5kTVclJGRI
         l6QWWQhU27uuoSQ4o625eKxTCpuNKFYKP9fi8TO11CLuxjxW7tlvr//BlpL4al87+Mbh
         WPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701859479; x=1702464279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEcYuPBlZQ9K89kJ8KLiP513yG9gnFFCALFubbK3TyA=;
        b=nlxQjSN5YkiYZHlHIObMGL0vnHkH6Lu+1O0kI32hwfVdzjaUgYVWoZTL4rgp8lh61s
         cdsEalgM0oEcGkwSo7tJd4UVa1j3gbZJSIn+LAMGjfOpQh5PO8GQEIMvfGJQVE58unvE
         RL2X9ZJgQa4FzgXW+401ES3mtL3Az4tKphLg31IUVsCCIRfkJuRshSNjqxqv+3sempyq
         4W92F5KtsLvJqpybwHxl26cQ27Ol7u4M2ibcxYKSPojTI6k+I8qew9w3h0TmkgP14KPu
         jhgdXe3Ik7xlL3PyCvzgwIbUX91/HIRhxszya7W35iSuiCvTHzrVHNbq7dxtBXrVxZEK
         p3kQ==
X-Gm-Message-State: AOJu0YyGc8vNN7h6Z3lGXGWQ9oaPpj7xWfbpkqhNa1cc0PHl2yARGie/
        yLj8kghzErlQy9WOQgS3hjxadC6TOUE=
X-Google-Smtp-Source: AGHT+IGK7LvDP/h+H38FgIdLJC7ablhYJtMDJ+TDPMwcdCvqU35XSmVhETIKV77MblhK2M/UXOcLzw==
X-Received: by 2002:a17:90b:33d1:b0:286:74ba:a1d7 with SMTP id lk17-20020a17090b33d100b0028674baa1d7mr949163pjb.26.1701859478921;
        Wed, 06 Dec 2023 02:44:38 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090a2a4b00b00286596548bcsm10020811pjg.37.2023.12.06.02.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:44:38 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 1/3] ACPI/NUMA: Remove unnecessary check in acpi_parse_gi_affinity()
Date:   Wed,  6 Dec 2023 18:43:16 +0800
Message-ID: <20231206104318.182759-2-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206104318.182759-1-ytcoode@gmail.com>
References: <20231206104318.182759-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_map_pxm_to_node() function will never return a node value
that is greater than or equal to MAX_NUMNODES. Remove the unnecessary
`node >= MAX_NUMNODES` check to keep the code consistent with other users
of the acpi_map_pxm_to_node() function.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 drivers/acpi/numa/srat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 12f330b0eac0..9d2d0deb256e 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -430,7 +430,7 @@ acpi_parse_gi_affinity(union acpi_subtable_headers *header,
 		return -EINVAL;
 
 	node = acpi_map_pxm_to_node(gi_affinity->proximity_domain);
-	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
+	if (node == NUMA_NO_NODE) {
 		pr_err("SRAT: Too many proximity domains.\n");
 		return -EINVAL;
 	}
-- 
2.43.0

