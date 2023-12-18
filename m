Return-Path: <linux-kernel+bounces-3114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC98A816793
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF4E1C2221D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFC410790;
	Mon, 18 Dec 2023 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="I5mFNRgU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37422F9D8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.19.56])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 6556E109EA891
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:40:52 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.171.117])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 814CD10000C35;
	Mon, 18 Dec 2023 07:40:45 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1702885245.214000
X-TM-MAIL-UUID: b216ee90-1167-4d77-b81b-6e29b7d01f2c
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 3476D10020CE3;
	Mon, 18 Dec 2023 07:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4nN89gvE3TMetq7g+vY5m5FnE2W4ozOoE6siZAkWLGcPiJSN1PkvutVwAYA2JMru8mrSL3T3ZxTod4edgnARTiVrnpt5NFBPAuLXqakKGDZJSl/Jmum3wJwo91WRLsUkI1rfljLBqGqtoFi3wROVXf1Iqi+UusNekNDAc2gwQYyLC4vs5f8FdQNRVIvL+Wx6IROpfp24c0dqNR+8TJIAmevEWDgKk1Njlq0dL8qKrT+H+/nv5FiHA9fm8QOSTkUl6i9mVrbbOvTE+ORKivLJd2R4oGKuCCjS2yb6fUsOWSGB0OMkEXJ4S7zJv2MNrrpunY8r+kQnnX+Zta+yezytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJgaNBEzp9lR6H6IY7NbUAFUz6Y1OBwJFLiNK5ZnaYk=;
 b=g449OVrwDB8rw9JYqbtAPh//nyToH/kOHp/6up2l9vbnuWFHVHOA3RaU35VPFPW6CoHVHayGNWl8iFWGuMKRE4U+3xurcqwMRSkpvff/Z1OkJEgQuvwomxOUYh27J6QVlvvWvLtcorW8mST0PLACdAUHhmTQv6+h9qhvAdjwy0HILJ+L4Qmu4DmEd6TOb8pMBv9AVzN//QZwR7s9R4XkC5cXo+CMXU+mGrdqGV+qqYEtk8gRz54+Wpnqw1S69YbPaSATqRv4FeR1XYJYy5/k6CnWeVuddrQ2rVy+XhtvyY/XK+2hoOqR8wDxQDePvimD4GaU43FnydFmrbK4puqXgA==
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
Subject: [RFC PATCH v3 3/7] timekeeping: Fix cross-timestamp interpolation for non-x86
Date: Mon, 18 Dec 2023 08:38:41 +0100
Message-Id: <20231218073849.35294-4-peter.hilber@opensynergy.com>
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
X-MS-TrafficTypeDiagnostic: VI1EUR05FT064:EE_|FR3P281MB2203:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2447cebd-93e8-4ef9-8df7-08dbff9ca43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hV/4Lpf/4GS1iU2eNA8WgohOhtG/czIihIksNJVOh0OV+KVQQrTt+o1wJUfMeWbbfbKJLbq0huNlTdKSCOTYrAdSv+9lOF6nE/vqtPKf7anvV5U6uQJgEYc9BX2Ns2/ScvOtALCRM4H9SBW0/bezCERBXCIIQVzKX0GXlAOv2BB8tHCFRHdXIb681kdDv9KeIysv/ftKooubWi7H4B+UMYS256XKHQ5URIaT+WiaPEIy7GC5HHSJOJzrS+YUSMO2HzpjFyAH+93C3KzPqO+cM12W2wec/Xmn1t6ZrI0vZ7EyAtxEqbDLFnN4VxjWOq6LyI57MBquqqQOe6JvjnftuPICu1/vd3JZThMp3LMFdC5zJLLy7Efh/h055kAeyashPVIbZcFibBcEztHyGyNHLPukMvibIj2xRVwzx+sDHA/5zcAsloeZyafp0ZUk+gQpNBQc73mdzb1sXZscOR3Tcq2hea4iZn2VDPlMCJIfw7YLicXSGuaeIDGZDA0a7/VcMn/7u75oryKGk4MjCYGYYhvCOi7p9vg1VB6NqYFxDttlEM0xd+XCrBZPZGmYHcROgntJ+nTVZcSkDQtSj8VayZk3hvLE81AR33MpoV/BfG52gFKgdT7MCsaJYTE4Ycd7rNee2/UUQ9EWRDwxsB22LNbcbwjUen05U7cDzJtO/QIIKVmaszGSkqVkFphNTvd4/We+gJWaLP7s7ANhFPOYtn/swnoO7V69oZENhAtpwF3OVxmROdiKKIJ/7vR9/D1ZJBMf7oR9AIslm2jGv9LUMWw8VQmfVvpcKf7jjNEorYY=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(39830400003)(376002)(396003)(136003)(346002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(36840700001)(46966006)(26005)(336012)(2616005)(1076003)(83380400001)(478600001)(36860700001)(44832011)(40480700001)(8676002)(4326008)(41300700001)(8936002)(5660300002)(86362001)(47076005)(36756003)(2906002)(81166007)(6916009)(70206006)(54906003)(42186006)(70586007)(316002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:40:43.7557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2447cebd-93e8-4ef9-8df7-08dbff9ca43a
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT064.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2203
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28064.005
X-TMASE-Result: 10--4.970100-4.000000
X-TMASE-MatchedRID: t1u9etd7zexeKR/wKUhyN50UyaWO1QCnDNB/jaV2d3ufOd3yw6VkrA9M
	5f/N3N4Qthzaop7IM7sxRT5xs1+q/LIfFXYUihhJ9uL5hOvaG1KVmuhG06IIbTji23k3pyJLKLe
	iMOXj8x3VCWoGLJ7oTkLgBLH/nEyhKI9YY0txdTpSU7TOghylToHV87ajhAZw5LGd87xcOHdwLp
	z8B01lud9cNTZyIRQywqMZFCdDzWHPE8gn5ga5qlvIId8M26gTcEVHZ4vVAlhmrG+H0FSHunGDu
	y8y1qkuSOzJLIeTZAaj45JdBik2YvV6Jv37/R3WO5nVDm0S/sD25GFUd8k/Fw==
X-TMASE-XGENCLOUD: 96cd9daa-7b3c-4ac2-801a-e6e48ee1ddd3-0-0-200-0
X-TM-Deliver-Signature: 928184199E900A744B7BBEB1C3B61368
X-TM-Addin-Auth: D+SUBOckl6OjIKaLJA0rQHc0X50yKi5HY80Iici+0iapvjj18OcDxWHQv8R
	IqRKegDLglAreiv1SAHJOupQtQuWZhPbmRqZx+y/Yl0ci7oXrhmcCbkvivbxXgzpZ3kGYIIf/OF
	LHsCCQCiFhthJQSlN41U9EIy8fIX5PTapcAxBByfBfYnvJfSwIOwY1xaix7rzRoi3Vue920ygwy
	9kE8aE47mAaQQJ1fT/JEh1XdAjxKVe3qDmShFY/1K+FFLQaoqL3XYG/bkt7FvJDi++dRBZIz0CX
	/4Le3U7PHYvWtgM=.gnmt3d8QzuNc/gGm2gBBuJmGrq4UyAqlTuplSuT9ETxP9cYxRF9rDLPvKS
	l/MjrSnT+M6+5rCHEqTgqTorWOMRXpQmuwMAXkUKP2kjQ2RQKYVdSxFgwPi/EW1DfWpcdd305CD
	HaT51J47yR0hasdTHELwRtTmE+ksAdnqaZtfmJijOmj6/iO8a9EFUgaxIa1B3t7Z4rlOEeflTbL
	OeR+0Z9qOX1EAm9VgyNColBcZqQn3PbHRbMnIJb3FG228g5z9uydBHP/5mXILkm3oN3nQNSVWMd
	9wAyvZKa7aIR0yC0MODzB++u69tsKZUFUUj7CIyEd/iYZKdNNZ4K8tDtnBg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1702885245;
	bh=4Y3l9rtDRj9fZtWY1TyW5Z1YIMRN5Dq13DtOFcxl4/E=; l=2127;
	h=From:To:Date;
	b=I5mFNRgUgKybw+zW7adHWb3URb4DQrNLOfpi9NS75s9xOFBpA0vjvxocmAR7ubbiB
	 y4tcRZL8zHyHirIv2C440HJtQ26Pt3ZnugoEvtMDiPVyj/IedB2sjiJs+pBufYQOXJ
	 tFPza2l8xegk1vL8vPv4ff8PtFYkX1pddqhY1b4bUJISviNEiyNp7TfV0TZWvc8nm6
	 zSoPjLsyOIxNv3m4EZQSkr/A+85vBGKII+JGccCVSELgXHZfgUOD0ZXK6ppZjJXX9B
	 +YGYtLR/zXZ114tyUmv8rd9aHYkGS98VB8DV/GPUIutQ9kqXFNTr093JU46UJB2YBO
	 QU9tVVMkMjj0w==

So far, get_device_system_crosststamp() unconditionally passes
system_counterval.cycles to timekeeping_cycles_to_ns(). But when
interpolating system time (do_interp == true), system_counterval.cycles is
before tkr_mono.cycle_last, contrary to the timekeeping_cycles_to_ns()
expectations.

On x86, CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE will mitigate on
interpolating, setting delta to 0. With delta == 0, xtstamp->sys_monoraw
and xtstamp->sys_realtime are then set to the last update time, as
implicitly expected by adjust_historical_crosststamp(). On other
architectures, the resulting nonsense xtstamp->sys_monoraw and
xtstamp->sys_realtime corrupt the xtstamp (ts) adjustment in
adjust_historical_crosststamp().

Fix this by deriving xtstamp->sys_monoraw and xtstamp->sys_realtime from
the last update time when interpolating, by using the local variable
"cycles". The local variable already has the right value when
interpolating, unlike system_counterval.cycles.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Acked-by: John Stultz <jstultz@google.com>
---

Notes:
    v2:
    
    - simplify fix (John Stultz)

 kernel/time/timekeeping.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 24ffd681aa23..b58dffc58a8f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1262,10 +1262,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
 				      tk_core.timekeeper.offs_real);
 		base_raw = tk->tkr_raw.base;
 
-		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono,
-						     system_counterval.cycles);
-		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw,
-						    system_counterval.cycles);
+		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono, cycles);
+		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, cycles);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
 	xtstamp->sys_realtime = ktime_add_ns(base_real, nsec_real);
-- 
2.40.1


