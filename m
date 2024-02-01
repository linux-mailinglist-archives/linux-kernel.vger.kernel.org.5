Return-Path: <linux-kernel+bounces-47464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C866D844E4C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD501C22E44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2061563BF;
	Thu,  1 Feb 2024 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="sS06fzok"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067DA5691
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749600; cv=fail; b=Z836VD9k1v9me7amGP6Kb+Q4iwOFsV/ftKLzsZ6NsFuNPP09rV6CVQM9vxIeJnoOYo10r57g/sN6BIIW2UGGPK2iIEt6hW35iX8jJJKko8bSmkc6cJ6lUgZolY3+5nYkzuck625AtVmyxrAYVo5/ri9q1QsPkwIKERoMDoJzewc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749600; c=relaxed/simple;
	bh=3qmW4ch/00o/icZapJifBzjs2SmWsMrktxdkuqgknh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnqsVW7kQIzhAPUHXzhJfk1xMvu3+PNlzuqAuEnxGqay2Zw1Pioe1nFG6zxQMx2XS5aVdJ/qzAFOD+G/DIVzy97W2IgnIbEbzLj/56cU3ubNymIgUC4JMy/7cgNt/5RDUNew9sb4m5rQ37louk1jWKaHJ9IqF3V/L+xgabqYDgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=sS06fzok; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.10.233])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 3DB1410D3A1FE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 01:06:31 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.176.220])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id A7EF110000D7A;
	Thu,  1 Feb 2024 01:06:24 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1706749544.790000
X-TM-MAIL-UUID: ccd98ebb-389f-453f-be31-8a2a190383a1
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id C0F8D1000030C;
	Thu,  1 Feb 2024 01:05:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH6ue0QNC7S8Ot1ZAo7rlHg7OjT925Jfz4JKBf4RGDkiI32gw7euIhri8kG/vysZjWTgAsu43rjNyPVTqzp6N66jk1Q35rOvoZiIBoT1EuBv8GsHAM60wCIloAhNaMtLo3h3C3XF1HFTfA/rYMH+viAW2EAwuPyEQbrqT22jf9uenBdwXrUJJMIyBYfyDY9N0Lwc7qhCTeb2KeFgDDWP0NccG+wzapjsiK7Xuz3YcTfQG6Uc8YzTvTlTtVWrFvN2EPN4ck4yOHKkLah/xjwsFOi5HkrwUOjqaqqQacZ34DvPWju8iTtAIy0c+3DO2J67/ZRO3IWAUKVEAiQVvBtoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+25KA7yyDsyn9T3uP3coyDz2T9StWj4s1Hs48TRiwg=;
 b=bCuI1W73Ek70wEqPQm0edjG67n0xO59E40e9eZoLC7KANgahiqiA1ZjhtI+dALIvWUG6Ol4kjoRmBbocU7D6sl3jmSbXfG4MDn8CEEAeonv8GuA10KFAF5LTEkTWkr9G4Hv56FG7euvqsHE3lYlnGHEXgJRUAa7apM6Xl048QayXHuXxs0+4uqZgUyPTq/cD+4WSW45n5E+IZkjGyruItD9jiAPLeMYnWyigltklR4LVjlwG12iV1nvQR/DyCGFHiQvlwJoP57zcPj6bgr9Hns/2YQjG9E1zyH6TCEo8ASEKFlWW807BhTdjaSzR/vm0Igo6GxKd7haT/sHo1c0NHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=alien8.de smtp.mailfrom=opensynergy.com;
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
	Simon Horman <horms@kernel.org>,
	"D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	"Dong, Eddie" <eddie.dong@intel.com>,
	"Hall, Christopher S" <christopher.s.hall@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 1/8] x86/tsc: Fix major kernel-doc warnings for tsc.c
Date: Thu,  1 Feb 2024 02:04:46 +0100
Message-Id: <20240201010453.2212371-2-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201010453.2212371-1-peter.hilber@opensynergy.com>
References: <20240201010453.2212371-1-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT054:EE_|BE1P281MB1938:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c3e10fa9-3529-4452-f0f0-08dc22c1e9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ALedq3XAOa7o6Yu+I7E4Aj8itoE0l9ShSeu3aX3/9x73TZ56j/tk0L4hf89RfYInmiyOZioMg/JDHU5VHRlCSBzrip1HZUNbc/6cu0FzUWwxIVPgxBv24wjisX9YZQCovGat5YVAVOHahR4QejpYvFKQGhxOQKhz5XlCVsVkV5b/u3AxvSDlYUakgLiDFK8GcN1OzCwaUkcYGUfP8g1Hu53z4V8C8wY4d+07L6tBxjpbalrz1ax05w7jZjPCO1cug3Qw7P18vN3V0afZqijhySCCcwMoG6LHSRsVGLWzQm7L3OFJ6hbxGrdMePf9E2WBv9oFiZf2kAsyde8YbvCUa9B9bpdMq2ToTKH4qTBpJTM8A3h+y00jE4UhZjSUCP6nQmbSLVRmRyqFVR6li4fKew56MqjardB0ryJ/I0vWZIRN8ddapwUz+/nC3MJQuC0O+8B6RB2zaUOlS9Sqb7bP/TLztPShBP5gCjGCy34sIPBxAKQw1mpSOksOnZ9cJtb6hfFpENw2u2uYOgdlhDHKaywQyYPNWDGBOLtXL3lPbE2WdwBQkm49ggNY8C6y2lMXliVYVFPNXKH2TEUgdyV9S6CXRnZqzW6rEZZ3e8XBmHYYL1NzgNx1Q/u/v7hlhgvA9l+6Tl8xGP4BWhgjmaXN+G6/Q6K6L4Rf5ZbVFLaRg25ff++ucafnxAmHFLCGNCBsSuzlai34RoVxAhKMjnwAgPKO+mscAdqTZc4SGLqIcbIYqdq7/KrGos7AdupIy7V5f13ul78jSbskE2NaBdZG1Q==
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39840400004)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(46966006)(36840700001)(41300700001)(5660300002)(2906002)(36756003)(7416002)(70206006)(70586007)(54906003)(40480700001)(83380400001)(6916009)(316002)(2616005)(86362001)(42186006)(1076003)(336012)(478600001)(44832011)(26005)(47076005)(36860700001)(8936002)(8676002)(81166007)(4326008)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 01:05:42.6186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e10fa9-3529-4452-f0f0-08dc22c1e9dd
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB8EUR05FT054.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1938
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28152.007
X-TMASE-Result: 10--0.724300-4.000000
X-TMASE-MatchedRID: tODJ1S9VJLP7dTmnXTe0M4Rvl6HHLe8O3V8nMuq8B6I+0J9ZTAkB2IkL
	KIflgvPFUeXkR4pTjoi80ms4ryCxPix/9VNkbVRzOEwpPzUVSKGpgIbqBDAjJaIysjVZlzq7Y2F
	KywUpURrm9Tc/GgfFJwFtWueZlMH0t5KZ74QYwoxIFdnsppreL3J8bM38R9gpJsfJJdVp3fqvng
	kjHjojpH2fbnp7T2HmiXG+DOC9634tUBe4IrvOVzsAVzN+Ov/s/MQPB64FKJ8fhSOSaTT7AYYsZ
	niTf/ZFNq3SlTCFL/QE2a65+FO8yA==
X-TMASE-XGENCLOUD: b1ab1aa9-55ae-4443-80d4-d4ad44aa60f2-0-0-200-0
X-TM-Deliver-Signature: 6F471DD760A4A03862D64D4F3DB1263C
X-TM-Addin-Auth: /8pxCs0ZOznQGWCbyrHIVkL+15CpH+IUpLHwiVMbeuP1se92o/9KUoVanM4
	Iu2mFZnMRZFozBQqU3ssNjfVbKKyyZiNUA0e0h32ZTwUurSFuV0mSkIUm3qKHeKhw0G70kBkwQ2
	csYSukE6JHQwYlkCeQTHcsMEWCgTcuqGDGfWumJCc04zQYo9q5rZVbZsDEKtxHyCQfNY9yZl7fR
	/Z15mzD4MGFj8cvcHqcv6nERT3bL31hbBeGyqMiwt4kFfb63xa01GXfy5voi3kXkfooGPZx0bW8
	LyrINyG5TmFy8pn7A4sSpfSfTHh38b1u89eo.zz+SeWS6mzZI2SDhZn3u5DcmkUQXgRtDAq36S4
	va6QgchydxtOe3qFl04kNq0Zq2FZgjDAFrtcGTlG97sl0z+AqWdEZ1URTt8Rl0XGlQyZJ0MXXu3
	umNOe56DaYC5tVHALfNKPqspS7JpHejCoPv5zlZZGLrw/kolQ9VGfQK/3oUNEOXUNbntClAYcCe
	1g753JNrnT8RMEGzMh4PcfEBKL90b6vwSGoEB1SGznOVxCh5B6SkLLTaK2+arQdBAtrxDIYNxBZ
	C9tRwD4o34tmjMLm2QbTCczozxPHTj90vjT/9kVJRclFdUsfgjiowz8SXo2GtbJXpLcggUJ7/qK
	xmwQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1706749584;
	bh=3qmW4ch/00o/icZapJifBzjs2SmWsMrktxdkuqgknh0=; l=2266;
	h=From:To:Date;
	b=sS06fzokf2OjAXGWa8oa2dvMxKVtkPyeQ0V2Au8+eZJNC8PLmMaqOynyrHRSkZ0Pk
	 4KF097nPK5/xg0dq35cUdBQOY736VpjqcAp0ogoi8g8/BNLk236kkvqIcNw1a2Huzt
	 ylpONsagIFr/I9pgc7aGzTKxkwC+SyJ7rmxXwgSSuqHCib2xLPPDVTPTHsB1gRoVJd
	 tdeIPP0e0MCOJfXjVNp6UnyGYrHo/j5Z0UhqVt8NxZohlw815Dr8T4TUsxNQh/q/7Q
	 2fgMCIIxPNbmq/V3wHKLeuqNYTEDAAZFfEf5dwdMY/E/PVjTPyA0dWhc8SiAPAIIh3
	 4kurYbMBQX8Ew==

Fix the kernel-doc warnings which show up with default arguments for tsc.c:

	$ ./scripts/kernel-doc arch/x86/kernel/tsc.c >/dev/null
	arch/x86/kernel/tsc.c:1339: warning: Excess function parameter 'cycles' description in 'convert_art_ns_to_tsc'
	arch/x86/kernel/tsc.c:1339: warning: Excess function parameter 'cs' description in 'convert_art_ns_to_tsc'
	arch/x86/kernel/tsc.c:1373: warning: Function parameter or struct member 'work' not described in 'tsc_refine_calibration_work'

The first two warnings stem from members of the convert_art_ns_to_tsc()
return type (struct system_counterval_t). For convert_art_ns_to_tsc(),
the return type members are documented like parameters.

Since these members are already documented with the struct
system_counterval_t definition, remove the redundant documentation for
convert_art_ns_to_tsc(). This resolves the first two warnings.

Fix the third warning by appending a ':' instead of a '-' to the '@work'
documentation parameter.

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---

Notes:
    v3: Added on suggestion of Simon Horman.

 arch/x86/kernel/tsc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index d45084c6a15e..42328f9653c1 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1329,10 +1329,6 @@ EXPORT_SYMBOL(convert_art_to_tsc);
  * Return:
  * struct system_counterval_t - system counter value with the pointer to the
  *	corresponding clocksource
- *	@cycles:	System counter value
- *	@cs:		Clocksource corresponding to system counter value. Used
- *			by timekeeping code to verify comparability of two cycle
- *			values.
  */
 
 struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
@@ -1357,7 +1353,7 @@ static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
  * tsc_refine_calibration_work - Further refine tsc freq calibration
- * @work - ignored.
+ * @work: ignored.
  *
  * This functions uses delayed work over a period of a
  * second to further refine the TSC freq value. Since this is
-- 
2.40.1


