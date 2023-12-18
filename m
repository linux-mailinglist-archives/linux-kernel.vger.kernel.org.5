Return-Path: <linux-kernel+bounces-3111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A6581678E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1878EB20764
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04DBF519;
	Mon, 18 Dec 2023 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="z0hz/g8b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79991F9D9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.203.211])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 4D85910000D8E;
	Mon, 18 Dec 2023 07:40:45 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1702885245.057000
X-TM-MAIL-UUID: c00a88ad-df20-4b22-8af2-20430592f62d
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 0DFFF10020CE3;
	Mon, 18 Dec 2023 07:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev7X/6EoJn2tjUeFIGF9zxmVeCJ1D/YSji/0RTt+vIyHoU3vrNL0EzLVBovEv4+PS6NWRoFvihjm9gQbYUFnGwbL4Er9/KpUzuNCXH+Xld7OOcP1OZw7pvUbm79+jCRkF78CuRXAMXyPAYyVxcRIGqDl1rCZ6cKFaLr24JIVQ3wbZcyvwcnpsr+onNzYlnVb3Hoa4KcYqhypH4/qLs4/ZaLKlxtUBjkWlM7u1Ih2/lq0bY+RVTkkKpwSpVF5aBY+s4wmvsQgdgGTW1La/13Ea9/wEmeCLPGMcMpRTNNdsXOcY5KYNXZ9/qq2zw2ihg1UoRb3XVbOzdndjGO8Jxlv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2IZ507OM6ksbzs3neAB9pnVNg/Lg+qzeVPyN5kTi14=;
 b=Qde7EyVUSTEAaLXo9B76k6dT9Mb1TLXJxrM/DMUfqxC8IeSt5iLYfLPt5VA8VYr1VvJTLeTB1LUFlHc/ll+xcrmHqX32cjNDy/SfEbkjx2jGpN4QlYTxRv68t8FU+ZlVx3wsREYSI1dNozfgqSz/46Ux3xwReeeHok2dSQGcZVk1fU/Vti6k8lzLhTspdy0GmqR9/ZNectdaQKfFxBOKvBUtHoNFawNrJgbcCA6H1/CASjftT+rwuYxjoyNvW1GvVHQUcZjo4iYMW2YwP/TCPUjGMXQPa5h1W4Ii6hY2p+FGgkyyWDDeC+UlSBnI//YDK/YqGpU6PP2Zk3oy+IkRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=google.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Peter Hilber <peter.hilber@opensynergy.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>
Subject: [RFC PATCH v3 2/7] timekeeping: Fix cross-timestamp interpolation corner case decision
Date: Mon, 18 Dec 2023 08:38:40 +0100
Message-Id: <20231218073849.35294-3-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231218073849.35294-1-peter.hilber@opensynergy.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT052:EE_|BE1P281MB2401:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 26ad6a13-62c7-49c3-4a00-08dbff9ca3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	29rHFrDgD2/T5BFlSCYIQ/9QGsxI8G+VugFmhm0VLOdIODOeui4Q/sRQXjGM8vQPpmzhumR1Ho7q5jHO1vMyJ+JwOHhUxM0z2mYCi2TjjTXsE/z4aGKZnltkoJq/YQn/dfxqJsg0gYowm0nKrhAwgXy4j+/kNo/gtCAKTVL19wRxLSPs/QG7SDvyqZYHOrYgqGYz9hlXBmlS56rNnQDX4KpuMwFqgUjrhx8TAkXadw/BiAiGKYjcetFVA1xN7M2RjapwJODdsfMTlETIvQ2isX8kcFyVN5o5nJmQwuk3LIQU1/rE3Ym9bQV7BXQMHbeaFcuxIIfDmQqa4hWjS4W5KcZ4LIriMG3OQqrUcJi4pgXZNoSjgkbFAIJDBpbmrwxSo/yyNbmQcT3e2tUMh4TZtVh1nYFO94y1LfnjCGSAkacjLDUVf7HLaSEPBYQ2NkFi/M5U71BQk2OHEMUE6QGtWPa3IFw5NqJqQrjoMcZHNho7LzjU6fCS4lR27v0c2+a/sXLCPdF5XFUVwJi9Yq/OSfJYs3QJAtAIzrV610g4tSSGsKRKV4B+gLo1bzLgqIBbFlTMoO/HiGuVMnHtxKCOmizlLPgkahtuVcUJLho1rV3lmM9uAAFbNcDJOPHG2Vw3f3w3IaO04KxZ/LESLoRb3v4DXNjQyKjRF6ERREaY9/CAl7LW3cwGpvVXt69qs9K1d6fJwvYvCv9A8XQEtT/0y52faeoNIWkTmkz0RLXL0xpvywTgizj/0A8VQURhM+Gm8A7MN+p1cHESU709qBdCSBCBW+HKL8VCc3+KSUHBhC0=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39830400003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(46966006)(36840700001)(5660300002)(8676002)(8936002)(41300700001)(4326008)(36756003)(36860700001)(86362001)(47076005)(44832011)(40480700001)(6916009)(81166007)(70586007)(54906003)(42186006)(316002)(70206006)(2906002)(83380400001)(1076003)(26005)(336012)(2616005)(478600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:40:43.2363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ad6a13-62c7-49c3-4a00-08dbff9ca3eb
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT052.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2401
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28064.005
X-TMASE-Result: 10--10.122800-4.000000
X-TMASE-MatchedRID: tTXG1YCXjlyHXEtxeZW06KF4nhfuztKa59KGlOljPvtYf8LrTKM9HLMr
	1BCU9VEa9MR66Vl9gxh3ctDbGLJrCd7BQ4zNEspZnRTJpY7VAKebyUSNdkyqzgsPNAkPeS3Qjod
	z+U1nZVma3KYBmyydiEIlvMJDMU4GfNVPm/PTkb3dQKgLFATP1u5zvRYCQLoVvYvv3/bSxhtUfz
	9bnWycdWILFRMBZjgurrSryEHqYI8CvRxvTnoekIruruLIWfnx3O2+pOfl+vcwLJ9PZUBQhZu1m
	GZ02rt+IcOU43RoyMaaqpJOgb8zX/axsint/cAcLrzngQuTvvQnfL6KqKSjbzB4jJltGVDbLN5w
	GPX3TPXYeXOEzfM22ez1ZBVjJwp/DeUZOJCXHMi/2tJ3foSBQiPzRlrdFGDwHCGr2Wk5lVXInHS
	iJPmGO8dDHZX32JRzuyRrXoaR96b7npjusD0LiA==
X-TMASE-XGENCLOUD: 159f6a85-11cf-41f0-878a-66104a7187af-0-0-200-0
X-TM-Deliver-Signature: 545986F62613B371B835B9B918AD7416
X-TM-Addin-Auth: BUtqnBarHP0bgWzscdjgjGlWmOEumQ7NzaDkRCEFuqnjPtioewQeNlT068t
	h048NLoEZeQFXe90tc44TaDTw1skxkWpHtSexOZnrTT976aZWukwHq7s1oXwcPrVnmJqjjAGlZZ
	Itdzus4XVoBjT7jZ03LdN1pkb48VTetkEp0uRouDPNbJ614WYQhiunlCWSE/ThgJlq4dERSBfGu
	CcgsTm/9xpIFOWO+3ik5w9PCGJVTDVSEczjZkg9vGebucHYOxldUjoowCQxWfdh6QMzx55HO7QG
	EEPijYadLz5HukA=.hk5z7VrzTNKAoTn//xMnoW2yfZzSmi0JDBR14tXiI/rYAx2UC6ALNCmeTz
	EnL+5Wor+ywlBCRSXiRNVx9ciL402pgilSGv28bFfbWQMAnEYele26yF+1m2f1tq089b8Hca+re
	RBdbMJ5KMVbMPx1qd9iMhDJ9RlTLz46fokrzlh0t/7nfZqrnspwZgtQdIgbcR+m6BSszsJLdpQg
	x5LIFwGc0ejJ2Bd/pbk283VOD572H15MeUtSLM9j3QPTBtvQj2xf9OAlT6qqf/suhqh2IYIdoXJ
	cCv0A/tUez8Ogqm3Qwg8A4g83g0MIcInssiov7wEACOUDYJIFZhHdNEhxmA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1702885245;
	bh=6hbFW5zT7dhfs2v0i1nOXGxD6lV3W89B3HUgfdPwo94=; l=4866;
	h=From:To:Date;
	b=z0hz/g8bZBvVxNXGsqoSU9fFaGUrtGUuo7NsyuFPJj+anixyAFR+end1wDCdJRfnP
	 40+JHqMS0AhT6G4s24S6pdqTzTGnyxP+9lYrh1q140/gYCEY5ZKrP702iwD+/ezSY6
	 /JcN730AuQhqbtb5JSWSAgWfzq6Mxsr3mcpH1Ib8COBVRQNJDd4NS7eJDBCKWFZ4vX
	 dbkV/94dTuExSjo85in/yHIA+m+cgB8zHFhyGxDFtlqG6wimUZ5gGUIndI8vNdWEu3
	 B+rqxSWy6BJfYNipYOTL6yNvy0eBq/3w4PhUWkiDaECChroLNEgL59bYvfQE7rnhye
	 hTeDiAqhMjzWA==

The cycle_between() helper checks if parameter test is in the open interval
(before, after). Colloquially speaking, this also applies to the counter
wrap-around special case before > after. get_device_system_crosststamp()
currently uses cycle_between() at the first call site to decide whether to
interpolate for older counter readings.

get_device_system_crosststamp() has the following problem with
cycle_between() testing against an open interval: Assume that, by chance,
cycles == tk->tkr_mono.cycle_last (in the following, "cycle_last" for
brevity). Then, cycle_between() at the first call site, with effective
argument values cycle_between(cycle_last, cycles, now), returns false,
enabling interpolation. During interpolation,
get_device_system_crosststamp() will then call cycle_between() at the
second call site (if a history_begin was supplied). The effective argument
values are cycle_between(history_begin->cycles, cycles, cycles), since
system_counterval.cycles == interval_start == cycles, per the assumption.
Due to the test against the open interval, cycle_between() returns false
again. This causes get_device_system_crosststamp() to return -EINVAL.

This failure should be avoided, since get_device_system_crosststamp() works
both when cycles follows cycle_last (no interpolation), and when cycles
precedes cycle_last (interpolation). For the case cycles == cycle_last,
interpolation is actually unneeded.

Fix this by changing cycle_between() into timestamp_in_interval(), which
now checks against the closed interval, rather than the open interval.

This changes the get_device_system_crosststamp() behavior for three corner
cases:

1. Bypass interpolation in the case cycles == tk->tkr_mono.cycle_last,
   fixing the problem described above.

2. At the first timestamp_in_interval() call site, cycles == now no longer
   causes failure.

3. At the second timestamp_in_interval() call site, history_begin->cycles
   == system_counterval.cycles no longer causes failure.
   adjust_historical_crosststamp() also works for this corner case,
   where partial_history_cycles == total_history_cycles.

These behavioral changes should not cause any problems.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---

Notes:
    v3:
    
    - switch back to v1 style closed interval test (Thomas Gleixner)
    - document effect of closed interval test on corner cases
    - do not carry "Acked-by: John Stultz <jstultz@google.com>" due to above
      changes
    
    v2:
    
    - try to clarify problem description (John Stultz)
    - simplify fix

 kernel/time/timekeeping.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 08a3d0052baa..24ffd681aa23 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1180,13 +1180,15 @@ static int adjust_historical_crosststamp(struct system_time_snapshot *history,
 }
 
 /*
- * cycle_between - true if test occurs chronologically between before and after
+ * timestamp_in_interval - true if ts is chronologically in [start, end]
+ *
+ * True if ts occurs chronologically at or after start, and before or at end.
  */
-static bool cycle_between(u64 before, u64 test, u64 after)
+static bool timestamp_in_interval(u64 start, u64 end, u64 ts)
 {
-	if (test > before && test < after)
+	if (ts >= start && ts <= end)
 		return true;
-	if (before > after && (test > before || test < after))
+	if (start > end && (ts >= start || ts <= end))
 		return true;
 	return false;
 }
@@ -1247,7 +1249,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 */
 		now = tk_clock_read(&tk->tkr_mono);
 		interval_start = tk->tkr_mono.cycle_last;
-		if (!cycle_between(interval_start, cycles, now)) {
+		if (!timestamp_in_interval(interval_start, now, cycles)) {
 			clock_was_set_seq = tk->clock_was_set_seq;
 			cs_was_changed_seq = tk->cs_was_changed_seq;
 			cycles = interval_start;
@@ -1278,13 +1280,13 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		bool discontinuity;
 
 		/*
-		 * Check that the counter value occurs after the provided
+		 * Check that the counter value is not before the provided
 		 * history reference and that the history doesn't cross a
 		 * clocksource change
 		 */
 		if (!history_begin ||
-		    !cycle_between(history_begin->cycles,
-				   system_counterval.cycles, cycles) ||
+		    !timestamp_in_interval(history_begin->cycles,
+					   cycles, system_counterval.cycles) ||
 		    history_begin->cs_was_changed_seq != cs_was_changed_seq)
 			return -EINVAL;
 		partial_history_cycles = cycles - system_counterval.cycles;
-- 
2.40.1


