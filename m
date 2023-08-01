Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABC076B938
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjHAP5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjHAP5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:57:31 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FCD1999;
        Tue,  1 Aug 2023 08:57:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D192A5C00FB;
        Tue,  1 Aug 2023 11:57:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 01 Aug 2023 11:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1690905434; x=1690991834; bh=ty
        2Jg2JcDl1vsDdHl2O0KnSHDnTuySWYs7sri+QdDRE=; b=y5QYxconx2yNgUnGRd
        qWNidKlBBWnkxxusQK/EVP7tcJAM3buOWza73ay6fnKJOkRlTJ8l11qzJ4V7Vh00
        leNF1jpqP5poLDtua3QXuquLJT6UoMRgAZY6H+3JVpP2IzCZFoPKSNWE6wSM6jHL
        qVGuQyCnZOJ7zMAhUxsH5vhOxxT1CLyDFMNUuHYSHEqAu9Q6DxxZqlKIxdSRFaU+
        WR2Fio8BFyD/5EKlRY3lh02+dEl9dHeTl2T5kDdPY8uBmfJyf7WE3Ov8hjbU0vys
        20uFwB6N+eR7053yxMgHpYMxZs/AuB1q6XY1FQ+hCOILg1Pa8cSH8PdprOrpV/eE
        pifQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690905434; x=1690991834; bh=ty2Jg2JcDl1vs
        DdHl2O0KnSHDnTuySWYs7sri+QdDRE=; b=wDKJzvE/xGU2KZr6wCLJO+4kaHY6p
        DSbcMmzrZY7TL0h3Nc/ck3TO7+r110tKikjz53D1UddibQjMu/94Fq7DYHcTQoA2
        2RwmC5BwBMpu8epWsWXDh8TscEVNmDYplsy1ea/+3QuOi1qmB6wEVR6yMZURdI+C
        wRMLNlgvTLHmqBaLNEt/0E8vUnrjzGhZX+cdy1ODjlWOpYaeguZn7ZxujHNN2onw
        Y8l0086PLuVKxfCexV9BEocxhb6OtMgvI0+iAE/U7i/Caglbibg5Hmrzt1mduNXh
        /wts5At+5nRoa4wiGuM3CoRkMAKKXfWUrc/Y2oTA40wvkYeSaTWDU+qaw==
X-ME-Sender: <xms:WivJZKgYxwr5F9B17UmCjlE4p1wCSYAVSG53Qv7aiEJ55LCpBJhReg>
    <xme:WivJZLCLwimKmYOuIAwzzCw3pj-Nv4pUSEuJf7nH896Q0_OI13VmCAkQdAhTKikEm
    15LlIOKl7nuyLAiDbE>
X-ME-Received: <xmr:WivJZCHy9e520O9tApzExctx6ws2s6CagOA0bfX0Aju2jP5xP9SW9yFif1_j9BiIiIRWvoBNCxJ7q3QPH9c5pxtWs5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghvihguucft
    vggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrhdrtghomheqnecuggftrfgrthhtvg
    hrnhepvddvieefleeggfeftdejtdffheeuieffheejgefgffejveduueeugeetkeehjedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvse
    gurghvihgurhgvrghvvghrrdgtohhm
X-ME-Proxy: <xmx:WivJZDQqkc-JHd3fKMOf5eAc84fqCf5WzH80WzQXmkj5KaeN4-DoPw>
    <xmx:WivJZHx07QhvDivyC949iSNWzYqTwhRS71WV3mbJYYIywklrrIhJig>
    <xmx:WivJZB6d-I5L2eo7wPrkiKSPEFUJt4efNWk8BrycGOddlDZqP9dVKg>
    <xmx:WivJZEhj7sGnr-0x6ollsFHxaV7srl2zeEFFfRIXma42svx_qZ3Kxg>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 11:57:11 -0400 (EDT)
From:   David Reaver <me@davidreaver.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        David Reaver <me@davidreaver.com>
Subject: [PATCH] perf/x86/rapl: fix Using plain integer as NULL pointer warning
Date:   Tue,  1 Aug 2023 08:56:51 -0700
Message-ID: <20230801155651.108076-1-me@davidreaver.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 0 to NULL when initializing the test field of perf_msr structs to
avoid the following sparse warnings:

make C=2 arch/x86/events/rapl.o

  CHECK   arch/x86/events/rapl.c
...
arch/x86/events/rapl.c:540:59: warning: Using plain integer as NULL pointer
arch/x86/events/rapl.c:542:59: warning: Using plain integer as NULL pointer
arch/x86/events/rapl.c:543:59: warning: Using plain integer as NULL pointer
arch/x86/events/rapl.c:544:59: warning: Using plain integer as NULL pointer

Signed-off-by: David Reaver <me@davidreaver.com>
---
 arch/x86/events/rapl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 52e6e7ed4f78..ae21bb2ff0ff 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -537,11 +537,11 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
  * - want to use same event codes across both architectures
  */
 static struct perf_msr amd_rapl_msrs[] = {
-	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
+	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL, false, 0 },
 	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
-	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
-	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  0, false, 0 },
+	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL, false, 0 },
+	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   NULL, false, 0 },
+	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
 static int rapl_cpu_offline(unsigned int cpu)
