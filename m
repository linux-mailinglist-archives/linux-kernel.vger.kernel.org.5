Return-Path: <linux-kernel+bounces-5187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35CF8187BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEE52876F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B106B18E1A;
	Tue, 19 Dec 2023 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b="tEZjmA0Q";
	dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b="tEZjmA0Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4C718AEA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=elektrobit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elektrobit.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=KiXUk/uTo9k/RCrbDBj6BUbwFiwmZoCrjT6dccVikmzsBUDe8Oql5nfYHqY4faOWtaIF3Yf/KSSu1U2GCBycvr/YguZq8Pka8ILnyIrR//lSQ2peMTJXGyexhb2VGPxZcdTS7g4tcu4452yk2fDTvcqjo1s1NI6yPjYt7qcaU35+TY071WCyXjG5xx0Nhcqgb6VUotkh9eK3b0B+ZrUrgIzVfXs/rezgj/fVpxdYvtuFA8HqdKkYGnKTJmXTZ1+USmMmZ0se2BnL0RNrIPE4jickLAC8a12sCAv68LirdPmpf/+LbGBvReXEIupfRO2hv3q9wUDGH9M/w1WjCOVQzA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgGzc/1wDr/rr1ZDDVWMrsW7VCe9Na02T3FgK6XVznY=;
 b=MaVs3vHfMmthD5qg8GVglUDfvq8147Cnbxe5/wI+0ub/l7oC2sK3mTzVLMS7GDijpKnaBD0BUtnFeOgePjVr8oEZ6Rl6t6ns1rzw+t/cuFcQp3/KagatxoUrt8fNVFFKNNma2AdUNMQdxbG7i4W0bm56OjpntFyrzVJJYRJngFxgiJaDRzYSgGr6UXMcM0K57pYqclkwMpP27ldsjG2wQO1h3edx7yzFsiw3TVRB9l8DdWp8NGF07nV83d1i/+BigP3x5U88Wb1Irg0+oD0ZbNIFKvR3yMrLMmbILN5ONkKWhN4V+Yw0PQC3BI3e0Oc/e73ci1koQxDjLLFi18PMkw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.79.107.243) smtp.rcpttodomain=linutronix.de smtp.mailfrom=elektrobit.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=elektrobit.com;
 dkim=pass (signature was verified) header.d=elektrobit.com; arc=pass (0 oda=0
 ltdi=1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elektrobit.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgGzc/1wDr/rr1ZDDVWMrsW7VCe9Na02T3FgK6XVznY=;
 b=tEZjmA0QvthMWfhjvf0iJwf01rdSDV/sKveOlyrBZE5OjRfpRTF2kqbOz5DpDEqf3h0g/7n3d7V8w2LpaU8qmxlSJZuw8DuMHoEo9ImCwMXhy3ZsjTuzQ5EpqDdxT68mAnQXjjdv0bVkEIcptr30h377jsvnuBX9/DAk5/q5eg4=
Received: from BN9PR03CA0687.namprd03.prod.outlook.com (2603:10b6:408:10e::32)
 by DM3PR08MB8962.namprd08.prod.outlook.com (2603:10b6:8:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.15; Tue, 19 Dec
 2023 12:44:46 +0000
Received: from BN8NAM12FT009.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::a0) by BN9PR03CA0687.outlook.office365.com
 (2603:10b6:408:10e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 12:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.79.107.243)
 smtp.mailfrom=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.com;dmarc=pass action=none header.from=elektrobit.com;
Received-SPF: Pass (protection.outlook.com: domain of elektrobit.com
 designates 4.79.107.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.79.107.243; helo=usbth1es003.ebgroup.elektrobit.com; pr=C
Received: from usbth1es003.ebgroup.elektrobit.com (4.79.107.243) by
 BN8NAM12FT009.mail.protection.outlook.com (10.13.182.242) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7113.8 via
 Frontend Transport; Tue, 19 Dec 2023 12:44:45 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by usbth1es003.ebgroup.elektrobit.com (Postfix) with ESMTPS;
	Tue, 19 Dec 2023 04:44:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCizrR85ofLFjhhkbL94WICPkd5+cvHmsvK4KeDxfapuHGFEI7psV2XNjlfb1CT/GJ2Q7nQPWBMoAc/Lt8TGUbKF6qDDslzNugjfHPgqLQheg3zoNsLGuOu303Fsbi94r0ea8sZ3b2XbbcBylIpp+wJP9U+MvYUyj7sbvyzXmEt9NQcMSaih6yg21XrcFOUbx4cak8L2Q1n0RXCGBfSPOcdPjMeKWaGrNqWiKv/oaRC7AOiiFTXgeLjj1nDLlOwqGQdhDxnC/2dZqDcJoHk5xQj2962THisufHiAAZrmkDDXV/OPQNeP3uBsUEokJq9mOScgU4NIIBUybgAFEFKYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgGzc/1wDr/rr1ZDDVWMrsW7VCe9Na02T3FgK6XVznY=;
 b=YhvUQnsGj3tng5jOav1e9b27NAE3gjnI7i7PFyWKfcdW03o2Mb18cSabXzbwEjMNi3Q6wzUGhz5siOrRVTWRizkmTnlccufOVxAtCy9Fq8u/+k5YJDPZeY/4xkP/tkg9GCc5HxNOenzfT0UIfAIKMaN8V7CCoY4PMAKNvteELHES/cVPKUiHUJ7JirvCFpfMl5oXUYf2Xvmdf7cJxpSl+FBlfktdB763bpmRpSi5aPODyKoqCmS8CDJAiFD4rapDDoGZA6csK9waZ1JfEzgGqOm0rvvWO1BZzSHc2Bvb7Ex5L81qDhDekxyUMeZsQUIyBLUlq9etxlYwQEVbblDojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 213.95.148.172) smtp.rcpttodomain=linutronix.de
 smtp.mailfrom=elektrobit.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=elektrobit.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elektrobit.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgGzc/1wDr/rr1ZDDVWMrsW7VCe9Na02T3FgK6XVznY=;
 b=tEZjmA0QvthMWfhjvf0iJwf01rdSDV/sKveOlyrBZE5OjRfpRTF2kqbOz5DpDEqf3h0g/7n3d7V8w2LpaU8qmxlSJZuw8DuMHoEo9ImCwMXhy3ZsjTuzQ5EpqDdxT68mAnQXjjdv0bVkEIcptr30h377jsvnuBX9/DAk5/q5eg4=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by CO3PR08MB8006.namprd08.prod.outlook.com (2603:10b6:303:172::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 12:44:42 +0000
Received: from BN8NAM12FT075.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::52) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Tue, 19 Dec 2023 12:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 213.95.148.172) smtp.mailfrom=elektrobit.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=elektrobit.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 elektrobit.com discourages use of 213.95.148.172 as permitted sender)
Received: from denue6es013.ebgroup.elektrobit.com (213.95.148.172) by
 BN8NAM12FT075.mail.protection.outlook.com (10.13.182.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.17 via Frontend Transport; Tue, 19 Dec 2023 12:44:41 +0000
Received: from denue6es012.ebgroup.elektrobit.com (10.243.160.140) by
 denue6es013.ebgroup.elektrobit.com (10.243.160.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.23; Tue, 19 Dec 2023 13:44:40 +0100
Received: from del01439.ebgroup.elektrobit.com (10.243.10.22) by
 denue6es012.ebgroup.elektrobit.com (10.243.160.140) with Microsoft SMTP
 Server id 15.2.1258.23 via Frontend Transport; Tue, 19 Dec 2023 13:44:40
 +0100
From: Simone Weiss <simone.weiss@elektrobit.com>
To: <tglx@linutronix.de>
CC: <simone.weiss@elektrobit.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix UBSAN warning for subtracting ktime_t
Date: Tue, 19 Dec 2023 13:44:34 +0100
Message-ID: <20231219124434.870613-1-simone.weiss@elektrobit.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	BN8NAM12FT075:EE_|CO3PR08MB8006:EE_|BN8NAM12FT009:EE_|DM3PR08MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1c8518-11ef-4b96-097a-08dc009047d0
X-SM-outgoing: yes
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 Gk7kr28i/kYgIOglWiG3NTIbZD7rPf6dKRN56kYIp4PBBCMvo9gw41YE720GrnK6XNA66ZI6Wwtj2fQqfnSHeHIIqj673rKI5eArT+xv0XX3tgFZUo+kkTlLyRAgSqrw1Iq3VQgcZeNSFo1n59NJ5oKEB0XxAdUwuP2YERxQIJy2bbjzDBM6up7b56kWhABtFPiFeQc+CrmzXY9yrnIiMk3WtOyg+4H99BSVox2U7HXiqIhGRrI4viX4bo704YkvOvvSK0HUIiSknb45YpuKDVwGpIXGqEFavv8yJaDMQu1JClRhEE1AR9wTBIwT2G9JtbfjtrsLuNoCrSNw6HJHqJWNdtEiWnwbNgi1MuyfOQrAVoF/EQyOGik2osR8s8z8j5ZUa4P2JdKRXu+CWiXZ75GglhdJSlVzfjvFU4anBki+6VQHhb8Ri6ZgWh0wJ8xtOCS2V7MX2hRnL3gcwCVHH6QurtxTchopZhOnnDG/xM9awJw6qIbNTXo6o+FPndk3z38ixsmYCgxWnjQLru54po8mYEN+lwhni5XCP1B1S2RsBmvnJQvGVeTY1+ZvLRKPiM33U06fQirO/KEJClWZ0fh1g6u7baZfEb9CuIkzex8KO6AdLz0xOpI5Vo/Nfx9m1H03kSRTj6FdtC34Tp8weVuk+imGm0za7UXCHOOxUwoTobdBUG1MHpHC27/Qydr8FwxoEBKWk732S6wcQjreZ0a5suR4VMeHd04FSUfFSQ4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:213.95.148.172;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:denue6es013.ebgroup.elektrobit.com;PTR:eth1-fw1-nbg6.eb.noris.de;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(86362001)(81166007)(356005)(36756003)(82740400003)(40460700003)(426003)(7696005)(6666004)(478600001)(41300700001)(54906003)(6916009)(70206006)(70586007)(1076003)(336012)(26005)(2616005)(47076005)(83380400001)(2906002)(966005)(5660300002)(36860700001)(44832011)(316002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR08MB8006
X-SM-smarthost: [elektrobit-com.mail.protection.outlook.com]
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 BN8NAM12FT009.eop-nam12.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4fd4cbe5-3d65-4e05-12b7-08dc00904558
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZJkJGNQEW203rIkqAxgAabL+2Rx4qnQCAGS4Llp/BnW4alsJ5D7y8jWfNL2dQgtVYEOI/tCGkKiZYZbq8xdrjWEyX2XA2XEQ3uda3OJCdJvkeRWegrYMlimKoLCJga67bMaZfhOjLh1TMmGnHSKuhU0SmpM7NG9BpwM9t4U5zi1ZaRIck0xQKDTFhgs4yLj9YQZplWOCYcweSN6WpfZKy+aXw9xiwehcIHaBxEy93BDlWeIkl+mZwItbfkwEjkkUDlUcHdVJNPCnlKjaU2yV512h2lK5q/g+9Dl+0zaOggi4GtdzmXI7lYLqYMZMU1zBV6xjdmtkHLMsJEg3GoO9MJpOZLCrExhf56qc0rbO5m0RUMvUjO2cKk6bvA5b1lx1NSgs4b7oMeXbxENkkZQG01x74vmdyDPDXtinZLqR9iQygblllrSN7v0VAOfH7pp8xmYFDfp0uwXHEie9ESKRKSkV3RyENRx9BvILNwXdpFo33OvSyZ6LGPCovyq+X80R7vGFdzRgN4dL1vR35YMUxyn7ZqkflaJIwuohCl0685j7ZgWgyRw1JSbfn+Eo8lnfW7A4CQJLGnZ46n/XvwE+J0CGGSPdmGcUXt5gEDv8WlRLBxl1+MS6bewZgvgYJXwAoxC3LuiXtvlSMxJu5Sm9v4Buqhy0V62n/yKsCc46e4yg0aLfYUsk9PQiSzwg8c6b6M4kR9zaslcLtyxQpmhP4enJflUZAG7N3+gjz9tND3g=
X-Forefront-Antispam-Report:
	CIP:4.79.107.243;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usbth1es003.ebgroup.elektrobit.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39850400004)(376002)(346002)(136003)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(36840700001)(46966006)(83380400001)(2616005)(6916009)(478600001)(316002)(54906003)(26005)(40480700001)(966005)(6666004)(70586007)(336012)(1076003)(426003)(8936002)(4326008)(47076005)(44832011)(8676002)(7696005)(70206006)(36860700001)(5660300002)(2906002)(86362001)(36756003)(82740400003)(81166007)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: elektrobit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:44:45.5812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1c8518-11ef-4b96-097a-08dc009047d0
X-MS-Exchange-CrossTenant-Id: e764c36b-012e-4216-910d-8fd16283182d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e764c36b-012e-4216-910d-8fd16283182d;Ip=[4.79.107.243];Helo=[usbth1es003.ebgroup.elektrobit.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM12FT009.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR08MB8962

This issue was found with syzkaller.

UBSAN: Undefined behaviour in kernel/time/hrtimer.c:612:10
signed integer overflow:
9223372036854775807 - -51224496 cannot be represented in type
'long long int'

To fix this issue, add and use a function to check for overflows when
substracting two ktime_t values. This is largly the solution already once
submitted once as RFC. See Link below.
Link: https://lore.kernel.org/lkml/20190306131326.10275-1-yaohongbo@huawei.com/

Signed-off-by: Simone Weiss <simone.weiss@elektrobit.com>
---
 include/linux/ktime.h |  7 +++++++
 kernel/time/hrtimer.c | 22 +++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index 73f20deb497d..ed90f53741f4 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -55,6 +55,12 @@ static inline ktime_t ktime_set(const s64 secs, const unsigned long nsecs)
  */
 #define ktime_add_unsafe(lhs, rhs)	((u64) (lhs) + (rhs))
 
+/*
+ * Same as ktime_sub(), but avoids undefined behaviour on overflow; however,
+ * this means that you must check the result for overflow yourself.
+ */
+#define ktime_sub_unsafe(lhs, rhs)	((u64) (lhs) - (rhs))
+
 /*
  * Add a ktime_t variable and a scalar nanosecond value.
  * res = kt + nsval:
@@ -197,6 +203,7 @@ static inline ktime_t ktime_sub_ms(const ktime_t kt, const u64 msec)
 }
 
 extern ktime_t ktime_add_safe(const ktime_t lhs, const ktime_t rhs);
+extern ktime_t ktime_sub_safe(const ktime_t lhs, const ktime_t rhs);
 
 /**
  * ktime_to_timespec64_cond - convert a ktime_t variable to timespec64
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 760793998cdd..cd0534bb60a8 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -195,7 +195,7 @@ hrtimer_check_target(struct hrtimer *timer, struct hrtimer_clock_base *new_base)
 {
 	ktime_t expires;
 
-	expires = ktime_sub(hrtimer_get_expires(timer), new_base->offset);
+	expires = ktime_sub_safe(hrtimer_get_expires(timer), new_base->offset);
 	return expires < new_base->cpu_base->expires_next;
 }
 
@@ -342,6 +342,22 @@ ktime_t ktime_add_safe(const ktime_t lhs, const ktime_t rhs)
 
 EXPORT_SYMBOL_GPL(ktime_add_safe);
 
+/*
+ * Sub two ktime values and do a safety check for overflow:
+ */
+ktime_t ktime_sub_safe(const ktime_t lhs, const ktime_t rhs)
+{
+	ktime_t res = ktime_sub_unsafe(lhs, rhs);
+
+	if (lhs > 0 && rhs < 0 && res < 0)
+		res = ktime_set(KTIME_SEC_MAX, 0);
+	else if (lhs < 0 && rhs > 0 && res > 0)
+		res = ktime_set(-KTIME_SEC_MAX, 0);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(ktime_sub_safe);
+
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 
 static const struct debug_obj_descr hrtimer_debug_descr;
@@ -523,7 +539,7 @@ static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
 
 			timer = container_of(next, struct hrtimer, node);
 		}
-		expires = ktime_sub(hrtimer_get_expires(timer), base->offset);
+		expires = ktime_sub_safe(hrtimer_get_expires(timer), base->offset);
 		if (expires < expires_next) {
 			expires_next = expires;
 
@@ -811,7 +827,7 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 {
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	struct hrtimer_clock_base *base = timer->base;
-	ktime_t expires = ktime_sub(hrtimer_get_expires(timer), base->offset);
+	ktime_t expires = ktime_sub_safe(hrtimer_get_expires(timer), base->offset);
 
 	WARN_ON_ONCE(hrtimer_get_expires_tv64(timer) < 0);
 
-- 
2.34.1


