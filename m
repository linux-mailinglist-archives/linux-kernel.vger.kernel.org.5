Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94247FF0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345769AbjK3N5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbjK3N5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:57:33 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269D6B9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:57:40 -0800 (PST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 78D133FA52
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701352658;
        bh=JiMwEX70Mmq7JJA6SKHo9LkE/wA3v6qQVTVhutP/NRE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=tFwEMU/B9Vrhb3t853LbvhY9e4rbjRmj1TTU/IQoTzkFBI8yeoxXzzfMAnlix3qX5
         tN/w/AxmXLDDsptK1A01l1e72DtvPqmE5SAeeGb2fl9w5X2fOSv4B/O7yKMDYJHyaq
         94QZZAoaJXMmvHZKUn+2t35u2v3x9cKaFgOSSU3FhQqlKk8yFP6NKsQLQnKyp2jj3C
         GL1k542vhFi9lVEJ+Jfi5OG5bVXrF21p1r6bwdOvjyOLdrKRWlQDLLOGhpx73+uljz
         D1SIHgYxYKPf5tN0gFJgrzO2+bQ32W0rU0CsojWHRqPBYnU92Q1KGyqCF5/SEryJ+L
         MCeNEEEPJapDQ==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d03cf821e3so3666775ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352657; x=1701957457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiMwEX70Mmq7JJA6SKHo9LkE/wA3v6qQVTVhutP/NRE=;
        b=fWh8ro/oFXHdeLIkZFo4NUbG+jSRzRD3LdTCQeQV/JGCfs8xuDVNXvyKFQfuH4sH6d
         pOl5XTUK8EHgy6BlAfiawnr0qCCcHOBQQx6rBfgVeJ0nDcNNEc9srZs/n93hLpnb6KW9
         Q1eOtZd6wxwL/jAieRrMP0/8aZmALr8roKiuufUvc6iuIe73OK7+5r8JrKnWFaFfq3cB
         lo9SM6pApGF2REcnjfblPjIvqk+iuFdT5Ac2Y4L2uC05/inj3j/3bborP2qEK/Tp1BpO
         BF0ssfNUx8nu1nrHxHyWOTau4aX1oyk7yDFA0UQ7AK1PO3rtTCspbHZqgGKnEiJFUbyG
         JhWg==
X-Gm-Message-State: AOJu0Ywv5+JIbqGAq+jGTyQb2gze42fzq3oUzuvBKYiBlfmYLzSBUQ/T
        CGQmdOo/+50FHeAEYrhX/k1okBNu2f7tWIE1UdrOC0QRV8szJ8AH/I9IUiG1bDiiweza/k3pPCz
        h6loxscenbXYojr/I1fQZmrrNjc0B3DILKpos6ZWR6A==
X-Received: by 2002:a17:902:ea84:b0:1cf:87f7:5dd1 with SMTP id x4-20020a170902ea8400b001cf87f75dd1mr20074200plb.1.1701352657160;
        Thu, 30 Nov 2023 05:57:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeTTxfOdzeODnzR/xhLs8dtxM+rJ6KQDnMyI0c4oTzAOA72NLkE8Em8AuyuuFxE/ZPx4u5qQ==
X-Received: by 2002:a17:902:ea84:b0:1cf:87f7:5dd1 with SMTP id x4-20020a170902ea8400b001cf87f75dd1mr20074184plb.1.1701352656897;
        Thu, 30 Nov 2023 05:57:36 -0800 (PST)
Received: from chengendu.. (111-248-138-204.dynamic-ip.hinet.net. [111.248.138.204])
        by smtp.gmail.com with ESMTPSA id ay7-20020a1709028b8700b001acae9734c0sm1380486plb.266.2023.11.30.05.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:57:36 -0800 (PST)
From:   Chengen Du <chengen.du@canonical.com>
To:     namhyung@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengen Du <chengen.du@canonical.com>
Subject: [PATCH] perf symbols: Parse NOTE segments until the build id is found
Date:   Thu, 30 Nov 2023 21:57:23 +0800
Message-Id: <20231130135723.17562-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the ELF file, multiple NOTE segments may exist.
To locate the build id, the process shall persist
in parsing NOTE segments until the build id is found.

Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 tools/perf/util/symbol-minimal.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index a81a14769bd1..1da8b713509c 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -159,9 +159,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 				goto out_free;
 
 			ret = read_build_id(buf, buf_size, bid, need_swap);
-			if (ret == 0)
+			if (ret == 0) {
 				ret = bid->size;
-			break;
+				break;
+			}
 		}
 	} else {
 		Elf64_Ehdr ehdr;
@@ -210,9 +211,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 				goto out_free;
 
 			ret = read_build_id(buf, buf_size, bid, need_swap);
-			if (ret == 0)
+			if (ret == 0) {
 				ret = bid->size;
-			break;
+				break;
+			}
 		}
 	}
 out_free:
-- 
2.40.1

