Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565137DA68D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjJ1Klf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjJ1Klb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:41:31 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990BE107;
        Sat, 28 Oct 2023 03:41:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso40476071fa.2;
        Sat, 28 Oct 2023 03:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698489687; x=1699094487; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dNMR79gx4YlEM6/vC0ctcm4csKiAR8AMBm30muHjlqM=;
        b=GUuG8It/EQwfUT//O+SntxRk5HX2TJVjYdiuBGR8NM3P70knVOsmCalIH4G1M5tti4
         G+tSE2irZudoHIRi8gd6CpKtVSj+652T3elMm7YoEZZggfuh0QUpir02M/NIybqAjF4V
         KQtKAVMUgsYYKINsCYcfWEPpvXT9nlTUmMkiKVbZDpYtVhuBir+dIhFwuiZJb3RbJmHm
         XYGWukB2YnmEK0Uox37b1EYvobPMCFwKEdy5o0VocIbL+zHXZJQg1J6vHvfDVlgk5lsZ
         g0pPWKDswSp5HWVAGmW5x9JhtZ5sfNSAJno+7XlvnMUQv7P/U8sXnC3Vuf8XxRf4jzk9
         GHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698489687; x=1699094487;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNMR79gx4YlEM6/vC0ctcm4csKiAR8AMBm30muHjlqM=;
        b=ltbNA+lEyi339x1TSl6KxTJEk5rKKyaXNok9Bf0072WyEU1y5IKbL0oWQUdy8TRaWF
         unK4cSKBwdx5+y+R74xSB4u5gaybVfu+8tHZwOkCuwinfpHJTz9iumF6IDaR1oEUnQ29
         oOWfIfi5qc+HAY+cQL+FB9bwelvz1BfHnHGx2Z7xOt9dIdvuRyeZ/BUdlX5q/OcbQRKi
         P/pU3OtdfoAwADIt6RMm1z/Swy2B8kqQN95y7YdokvcEREHE8tWuZSb6tTj/n1kWVQpy
         HcUZi2I+UbsOyKfDeSs75VuYLnrw2pse2j/P+fe1XW9OvS54wCCFELElo5T+DgUI25UN
         bDFw==
X-Gm-Message-State: AOJu0YwfreQ9GG/jVdzXXv5p1fhU9EZd1H/zz/L2vvh3Z0Fo9T0nX0lv
        0RaEGZxUPLdnegZeszV/8is=
X-Google-Smtp-Source: AGHT+IFX4jpNbHwTpxGnd0cVnfbHWzie32rxupnmU5XuRdroZmWoUBbUwJZ89LJ2GKfy6T7tj51Dzg==
X-Received: by 2002:a19:f51a:0:b0:503:778:9ad2 with SMTP id j26-20020a19f51a000000b0050307789ad2mr3251553lfb.19.1698489686512;
        Sat, 28 Oct 2023 03:41:26 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id f12-20020a056402150c00b0053e15aefb0fsm2633342edw.85.2023.10.28.03.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 03:41:25 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 12:41:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events fix
Message-ID: <ZTzlUz5PMxr36K1S@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-28

   # HEAD: a71ef31485bb51b846e8db8b3a35e432cc15afb5 perf/core: Fix potential NULL deref

Fix a potential NULL dereference bug.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (1):
      perf/core: Fix potential NULL deref


 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d0663b9324e7..a2f2a9525d72 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13372,7 +13372,8 @@ static int inherit_group(struct perf_event *parent_event,
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
-	leader->group_generation = parent_event->group_generation;
+	if (leader)
+		leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
