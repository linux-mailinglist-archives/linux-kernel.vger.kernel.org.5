Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1509F7BD3FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbjJIHBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345305AbjJIHBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:01:34 -0400
X-Greylist: delayed 387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 00:01:31 PDT
Received: from qs51p00im-qukt01072301.me.com (qs51p00im-qukt01072301.me.com [17.57.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01731A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 00:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1696834502;
        bh=OOfAgmDYVOQicq5X0MA5p3SFEeB22oSU0yAtNuNFDtI=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=YAFIrWJxeVX4A80lJ1LA07ES9t5RLnSmUzkDsEaAX7SLDCDqP/bxDProMVflLzO0Q
         vWCTJ6xO/SBpgv/6ZSTkRJWPDODyNN2gG2tYBPszI0OSEz916A/R8/6++rAjbsGemY
         tbvtI7MJD0Pg+DfD3qcRqCkimb36zZ7aOvCg3SadIjo/k2C+zSvug5/NWdBm+odYuW
         rin19sWlrrwOkENEkpO/6c/Cbk4mL7Ta+PeSRScwhfN1jcnC6evMqC7G9a8FajiNnZ
         hZ3PEBHYPH29T/hfqzLyBe/BWwiA2Ht4Akdq5lRudTxhHv163tCsRrQWaRdqFwMUkS
         0fDE6hkerO+fA==
Received: from fedora.fritz.box (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01072301.me.com (Postfix) with ESMTPSA id 5401425400F5;
        Mon,  9 Oct 2023 06:54:58 +0000 (UTC)
Date:   Mon, 9 Oct 2023 08:54:54 +0200
From:   Lucy Mielke <lucymielke@icloud.com>
To:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel/pt: Cleanup kernel-doc comments
Message-ID: <ZSOjQW3e2nJR4bAo@fedora.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: SkIzOLu8dFU5KpPNtAj0PLHmVMZP7Vdm
X-Proofpoint-ORIG-GUID: SkIzOLu8dFU5KpPNtAj0PLHmVMZP7Vdm
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310090058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some parameters or return codes were either wrong or missing, so I
cleaned it up to the best of my knowledge.

If anything I did was wrong, please let me know!

Signed-off-by: Lucy Mielke <lucymielke@icloud.com>
---
 arch/x86/events/intel/pt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 42a55794004a..8e2a12235e62 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -736,6 +736,7 @@ static bool topa_table_full(struct topa *topa)
 /**
  * topa_insert_pages() - create a list of ToPA tables
  * @buf:	PT buffer being initialized.
+ * @cpu:	CPU on which to allocate.
  * @gfp:	Allocation flags.
  *
  * This initializes a list of ToPA tables with entries from
@@ -1207,8 +1208,11 @@ static void pt_buffer_fini_topa(struct pt_buffer *buf)
 /**
  * pt_buffer_init_topa() - initialize ToPA table for pt buffer
  * @buf:	PT buffer.
- * @size:	Total size of all regions within this ToPA.
+ * @cpu:	CPU on which to allocate.
+ * @nr_pages:	No. of pages to allocate.
  * @gfp:	Allocation flags.
+ *
+ * Return:	0 on success or error code.
  */
 static int pt_buffer_init_topa(struct pt_buffer *buf, int cpu,
 			       unsigned long nr_pages, gfp_t gfp)
@@ -1281,7 +1285,7 @@ static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
 
 /**
  * pt_buffer_setup_aux() - set up topa tables for a PT buffer
- * @cpu:	Cpu on which to allocate, -1 means current.
+ * @event:	Performance event
  * @pages:	Array of pointers to buffer pages passed from perf core.
  * @nr_pages:	Number of pages in the buffer.
  * @snapshot:	If this is a snapshot/overwrite counter.
-- 
2.41.0


