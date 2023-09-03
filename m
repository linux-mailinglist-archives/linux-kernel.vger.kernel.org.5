Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F20790CAE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243766AbjICPNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243448AbjICPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:13:43 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514E7118
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:13:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79564282cb1so21312339f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693754019; x=1694358819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgAxpZm73/WsgHgaKL7ACBPFmNc1ioV85z5utVL8UIg=;
        b=F5dCK+GqTQVl1k+uFsaHVeTN5U2FjlKUR1h/NjZBntD0W//PyCHe1JwuE2/i+2mLiU
         +e+So368aqLL+pYA5SrKgZo1d1cYlKgDs4qZYTJJVCI142wEua+giqC6Yw7nxRY3LlI9
         gB+xUnm8jAQySFj8+HFURo6kWaSCPp/T4fe1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754019; x=1694358819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgAxpZm73/WsgHgaKL7ACBPFmNc1ioV85z5utVL8UIg=;
        b=NmvbirBwEO7iX9KI6ZRPptIPysoUc+yqIIEPmvYXpmzlf8oJp/nsYQftg76PEGCp1g
         x6JhTWZsEB8ohHjxlhyuqvhvEQHtS5D2LF6a+DiIcL5U/lv/bnSrKxNyAH0oiUoxfIiq
         nBEN8I/ChFhGNSVHNaYYR1pEG4ZpoSL7fyeL5rrPMlLnHlro8J6gOQnCfk4nYHU4MBrd
         xs3abMLFmBp5KWEMfqSrSSkH2b9gepcSZTw6f5TecxeD8fwMlNkI1PoHB+GICMnZNanT
         9cth/8vzNEEfdotDVIPXplJiXhdhR4Mc7Fxxf/m9h/gZnIfkKjuOHkDQtNJ1sVoliOzp
         6OFw==
X-Gm-Message-State: AOJu0YwihYbSxSU20zN0zK1WK8ooRItFnFb0cLgjRdtmKL7AV5mSjy2S
        jEzMTeYp9ODMrMSwR915+Q0XFyZN3+nCppq3SJ4=
X-Google-Smtp-Source: AGHT+IGK6R6X5iL9c9EiJjuyIOAcTh4DFWseDeYLr9pYLtkVVy11PWLKEcH+AWQJ5HZZkLqaClZ+hQ==
X-Received: by 2002:a5d:89d7:0:b0:790:a073:f122 with SMTP id a23-20020a5d89d7000000b00790a073f122mr8739172iot.2.1693754019346;
        Sun, 03 Sep 2023 08:13:39 -0700 (PDT)
Received: from joelboxx5.corp.google.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id f5-20020a6b5105000000b007835a305f61sm2605897iob.36.2023.09.03.08.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:13:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH v6 3/7] selftests: mm: Fix failure case when new remap region was not found
Date:   Sun,  3 Sep 2023 15:13:24 +0000
Message-ID: <20230903151328.2981432-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230903151328.2981432-1-joel@joelfernandes.org>
References: <20230903151328.2981432-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a valid remap region could not be found, the source mapping is not
cleaned up. Fix the goto statement such that the clean up happens.

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/mm/mremap_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5c3773de9f0f..6822d657f589 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -316,7 +316,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 		if (addr + c.dest_alignment < addr) {
 			ksft_print_msg("Couldn't find a valid region to remap to\n");
 			ret = -1;
-			goto out;
+			goto clean_up_src;
 		}
 		addr += c.dest_alignment;
 	}
-- 
2.42.0.283.g2d96d420d3-goog

