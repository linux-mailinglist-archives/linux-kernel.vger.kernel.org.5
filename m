Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF6F810E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjLMK2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjLMK2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:28:23 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF40AC;
        Wed, 13 Dec 2023 02:28:29 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-58d956c8c38so4196094eaf.2;
        Wed, 13 Dec 2023 02:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702463308; x=1703068108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j52kBrLhvINeYhhXoP/zRAgkW5tGnEgR5el1VW0SsAI=;
        b=SmdJzfFa9vTJuUM3TwLYOZeFhSHCXF5p7RXUSl/88TaP9QTwmtKnIahjwRXV9irFTC
         ZLF6v20lnMv/roIvBWX8jC8nQ159daoLM4ZPSCxzXeEKvBlSZMBYKdJDfYhyD6m8RML2
         y2z6AMRGVicRLYRH1l34NiSdiV6cAlATgO7K4lzkVkLdzPSw9dmtZekIJgD2PokjDCPB
         6BWBwAMDk7gKGNThjT3fwX8EYf2f0Qr0MYC4JuiG/K9MsG14+saHMds8qEWKYqVuhK7t
         m3Y8tjoRbqeoP4irPGBuCUgYChe6R9+2Jx/1X3Yz9RDV/n75Eb80SYQ0Cjgk3yA4QGfu
         S83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463308; x=1703068108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j52kBrLhvINeYhhXoP/zRAgkW5tGnEgR5el1VW0SsAI=;
        b=lzU+g4Djwkfx0bY/mdAUdvGzJX8xyyZ0b4xvmT+LplYOUnhevXnThbgxx3bJJxHLon
         zWUfoMvK0xX2R1yOWcCKXI1OQvNNJpkGjQmMogGulH+O7kdgKDVc1iH8Xt5oT+gwBSv4
         mWtuP480pXKEGgCYnOuYhj92OctMnEYeza3ywTA9cnRZ2VhyC/RIIruaNgIAFhmoAt1m
         ZlKzSAtYT6H4wbL3EUQ6Wc4T3mNr2lFPpYzhUQIiWxj2WEfBFL3cv4Plvnk0nw8AcvQF
         oPt4+SIHgfIZssO5Qwy7gxf0LS6Lfcy9M1zrvAzWPKuxAihOn4TB2hErbmQU0qR01Tki
         +CpA==
X-Gm-Message-State: AOJu0Yx15oQ3SQXHAqux9J5Mu8a21aLKq6qgNx73Pjthu0Ep2ymxZU/T
        8hYei5Akzntl0WYhoxrCUCU=
X-Google-Smtp-Source: AGHT+IGB543tj4Ly9paP+7Q7IOwL0KImlvH+5vEtMzVAk31V5C3AJXKNrb8FXKU4x/Yh/oLiqUsnFg==
X-Received: by 2002:a05:6358:e814:b0:170:2f92:3edb with SMTP id gi20-20020a056358e81400b001702f923edbmr6722618rwb.57.1702463307935;
        Wed, 13 Dec 2023 02:28:27 -0800 (PST)
Received: from localhost.localdomain ([129.227.63.229])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b001d09b006bc1sm10169300plg.21.2023.12.13.02.28.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Dec 2023 02:28:27 -0800 (PST)
From:   Zhenguo Yao <yaozhenguo1@gmail.com>
To:     srinivas.pandruvada@linux.intel.com, lenb@kernel.org
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        yaozhenguo@jd.com, Zhenguo Yao <yaozhenguo1@gmail.com>
Subject: [PATCH] cpufreq: intel_pstate: Add Emerald Rapids support in no-HWP mode
Date:   Wed, 13 Dec 2023 18:28:08 +0800
Message-Id: <20231213102808.94695-1-yaozhenguo1@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users may disable HWP in firmware, in which case intel_pstate wouldn't load
unless the CPU model is explicitly supported.

See also the following past commits:

commit df51f287b5de ("cpufreq: intel_pstate: Add Sapphire Rapids support
in no-HWP mode")
commit d8de7a44e11f ("cpufreq: intel_pstate: Add Skylake servers support")
commit 706c5328851d ("cpufreq: intel_pstate: Add Cometlake support in
no-HWP mode")
commit fbdc21e9b038 ("cpufreq: intel_pstate: Add Icelake servers support in
no-HWP mode")
commit 71bb5c82aaae ("cpufreq: intel_pstate: Add Tigerlake support in
no-HWP mode")

Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a534a1f7f1ee..39e0a2cf7236 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2406,6 +2406,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	X86_MATCH(ICELAKE_X,		core_funcs),
 	X86_MATCH(TIGERLAKE,		core_funcs),
 	X86_MATCH(SAPPHIRERAPIDS_X,	core_funcs),
+	X86_MATCH(EMERALDRAPIDS_X,      core_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
-- 
2.39.3

