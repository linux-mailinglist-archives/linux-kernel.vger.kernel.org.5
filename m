Return-Path: <linux-kernel+bounces-144941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A60D88A4CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B8EEB23B87
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12C60EEB;
	Mon, 15 Apr 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="Ea4sgMeB"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77295CDEE;
	Mon, 15 Apr 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178244; cv=fail; b=FWg6XYSTQNvBsBd5zAMrDV69EEMhZXZGnJDzPckkU7mcSuJRXJ446+LUZljNs1X5/FKw2VJp6RH6h+D03A7tC9uI+tXKKbqzaxLKJsQSkhoMeduT5CUgzLszu0bg4P4gjZHlZaCm6JFzmx0gYBdkxvZOV+JFJl8Anb+ixe5JzoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178244; c=relaxed/simple;
	bh=WTGxLS01gLxelsDWrerLWJq9NtggrlV7TUCSwjV9/5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M69J+j7ErahhIdBZVwBPw6JOkSHqbW0yfnThe3mAlOo6T0mAvvlO9zPROlqSNHBfik46MO6m+f3rYhTXREbd5d5vuVoaZ/H56Wa/PH0to8be3ZhXrdyxBfM7NtT4J5bSnm2PtpzxuXQXdOU/Xre8aX8TfZEmq3BWyKGNLfAd8t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=Ea4sgMeB; arc=fail smtp.client-ip=40.107.14.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNowSJL9RW9JRUqGNFNVZS6+O9Ue7ckSYqrviBpCZS4TiEri+X74VDFyB1Lmb3vBJzo4TwciKXOBbFleUoj9IV4AyYO8DIA/fLhiAGs8eFJ+erm0Qle2UVI4sL/zUWhKL8IChODaLJc7ZMWr/ke33KtZpzVz1UzacdjmSH1KbzcaVTK1OUpvKhtUzM2UXeRHeFAIOLqgYW3BVso1NQY/xPHk8/L3lQqpQHLAyZkomyBl8p/HmeIzM15bdjJExD7iOy6lwDAmbcpiEB7Y7xxnN3tf+HY9NE9xjPA2J+a0NDFzykZ2kvFaOmHJZzekN1BNZ7ylESTrYfXodp8VmV/7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFP2T40SdOb34rdyxpvDUD1y4dLMH+6xUaQpG9xqzVQ=;
 b=NfZMeqO23wKujtDT2CzWdCH8JqDexsVesHN/BPBYyLo8qM326iDpGoDARXOUUJw7SkNMUwAT2q4FoO3F/2VATqL6Xba7acsAAomMm16FkqL21RhYBtQt/LBJnOEM3loYSbCQ+b/5+ApjfaDkx75s+3bweUO8J+Rck444bfmg1fq+qfgFynXFHNy56fZ7ENI8H0wv908j5/H4O+S6Am6DeyJWzaDzpb+THVkLOee0CozipcSx2JQ0K8HyKHF7jh+rRKmYHn9wIBEuqcRhxcv60qbapsGy2XjkpUl8B1OLPthRHGbIoqryNN3eRh3C47BMwiSF+NXzJI5pp0FewMJP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFP2T40SdOb34rdyxpvDUD1y4dLMH+6xUaQpG9xqzVQ=;
 b=Ea4sgMeBqrqO98lznAFqfM3szPObX2vx9AnvRHPCoDR4w2jSpFsql6pv/zbIHrEY5a3pjVTMExfKOzMfnG9gGOSylGSBU8rODAwJZjjYNOsg7h3go6RMboijferm0iA8MADGgbLck5xlw9Zv+HGt8HOiQKhnpQOGocBf0n7sRD4=
Received: from DUZPR01CA0281.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::9) by PAXPR06MB7613.eurprd06.prod.outlook.com
 (2603:10a6:102:156::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Mon, 15 Apr
 2024 10:50:33 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::84) by DUZPR01CA0281.outlook.office365.com
 (2603:10a6:10:4b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 10:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 10:50:33 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 15 Apr 2024 12:50:32 +0200
From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
To: jic23@kernel.org
Cc: bsp-development.geo@leica-geosystems.com,
	Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
	Eddie James <eajames@linux.ibm.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Joel Stanley <joel@jms.id.au>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] iio: pressure: dps310: support negative temperature values
Date: Mon, 15 Apr 2024 12:50:26 +0200
Message-Id: <20240415105030.1161770-1-thomas.haemmerle@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Apr 2024 10:50:32.0897 (UTC) FILETIME=[BD54EB10:01DA8F22]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|PAXPR06MB7613:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8be8960e-4cba-4707-163e-08dc5d39e011
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ct7mXbBah7Zgto4UENJdiM6EfZ3oNbuIioJdIBIjOCFoDYSHqfw3vIbOsFBFUnORIohnlEtbzRhZucjZOjRsAqVr+QJwIw1zNQVUPhWrOEmA6c7j+IoYUJuIbEYezGy+KPS0YDEqpEemhzkYCR2TYX71DRYZDwvp+Mxq1kRH3Q3l1mnJCvLGSACxZ29mcPNu8zcDwhdaVXlQlZCmTwpCd1W7DTzNW0eFP7lOTLuOwDN0qafToZd2k4pT3wEMZav1lfajifMPifV2NNkU0S/6s0sSetBjuKwWmOmtBgwq8zHLCEttC9vrOpFCe8rM6ipG5CI0Gk1WQ7NMJc5Kuqg0l/H9J7+2jXN5zPdAErCOuolwQiSUomuP0qFTCBIhHipuErBiJpH+IiH7yC3/w8fwFv02Vctjd9NhS95Uos+F+lIRBS+QiEgHb8aq8u8oU3ms76vduS6iVET//PPCZsJXWubTWBStQWxTR4MNcdgMhRwJwJpCxZhrHYYJ8jhgB39HqhyA4+Soq9zejkGHmrqp7qMXsW8o78c14DGDB2yROnTlfETxFsTnr4oVGtoCZeX6B+Ef3Tm4kHW420A2SpAqPmza7dJn8yVa4/kO4o65W8z7kB4S1C4B8EdVdM43WUIDIzck0KNn0L6l/w5q9qZWfFK8ypVBWAS/pj3v2/AQlIc32JKe5+RjFmu9BPDwXLtFc6fOlpBGxHIIu8NxHor7wpr76OAXGsm6cuJX4nXsLMZq2QQgoq1GMXSy4B2gp7LH
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 10:50:33.2096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be8960e-4cba-4707-163e-08dc5d39e011
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7613

This patch set fixes the reading of negative temperatures (returned in
millidegree celsius). As this requires a change of the error handling
other functions are aligned with this.
In addition a small code simplification for reading the scale factors
for temperature and pressure is included.

---
Changes in v2:
 - include fixes tag
 - Split up patch
 - introduce variables for intermediate results in functions
 - simplify scale factor reading

Changes in v3:
 - fix locking issues reported in https://lore.kernel.org/all/cbdafb33-fd3b-47ad-a678-83fa92475278@moroto.mountain/

Thomas Haemmerle (4):
  iio: pressure: dps310: support negative temperature values
  iio: pressure: dps310: introduce consistent error handling
  iio: pressure: dps310: consistently check return value of
    `regmap_read`
  iio: pressure: dps310: simplify scale factor reading

 drivers/iio/pressure/dps310.c | 138 +++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 61 deletions(-)


base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
--
2.34.1

