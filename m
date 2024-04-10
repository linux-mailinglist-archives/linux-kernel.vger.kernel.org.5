Return-Path: <linux-kernel+bounces-138344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FF889EFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6A11C21CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B921C15920E;
	Wed, 10 Apr 2024 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="luuJDcZK"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4A2159572;
	Wed, 10 Apr 2024 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745453; cv=fail; b=LWdnujN6S3qBK/nFxsGZXpwLv3u/c1OgzUfOWWQfJRtZG8/uwOKHHSwoUQuOf/0pcqjYG03SUndTuchtC/ZYW3iTYRYp4N/avLPhwLvNKLIscJ49EnnbhD7PgDL8TjJcJfOAcaMyJS/35Q1TGMLyj+jLGnVgHadvNyItyhlCOPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745453; c=relaxed/simple;
	bh=yalxmCTmoAFvGxDLVoO8wlaNeBW+wLf2LSFefTg1uZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6xb7PIb5fFYOJFPORstJyV3BC5WT2m8tLkrcbP6Z+TPTjYgZpg3PuuJV6TC5E5tKEmwMKJBMho76Tu1jvGjRbQq3zir9TxjuuSxsyYFWu1NFKz3YEbvagDJGVFICm+O7lZbia3JFm9rqSxshU8PIBrjeF7ETSYorTXOZa2rOOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=luuJDcZK; arc=fail smtp.client-ip=40.107.7.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gazckOwgcK+I8cckStg0WxSeKbxkC+GvRHd8W7s54L5go28RbY9R6mzesOu08It4MyYahr3iPuuOOSZvcRNZqJ5wg/oGSAB/MtNY59/mVgrC5c+ITlTY9MueVbtOyykgHE4Ey5nH2QzoEba4UA5IdwCF+JEkLcBjpPs9jeBcpyJhMaBH9ZkbxzeumPbgCYfaql5MTO9Gqas7DcOMpm+lzwrVq5i5V9d/QM7iwekEn7NOjlo3OGDCL78gKaAz3hoNW0P1yVqr0cOmkR1HCL9aJlqYqoWvo+Zajlc6po8GdoImxWhMx+DltlTJkbrKMwZyC7MuKcHitDEi19ckS776hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB5o2tPHl8tynEgWQ8KGsDeUhZ6mXckoaoh8e89dbpk=;
 b=UkW6v9dGdBeWGXeHFtKlvYl1MqPOiSYhs+EBL98qCt4jcX0Cl4dKgRaV6LGQ9SK7gz2/6pgZXzcHUdBObLpRh6jnAFMFOIhRH/YZH9MOmdtVEhRWrONzuSYB9LQYfcrvJ4Yi0m8yYI67VGjuoPahl3ZWCrwiwwBAFodz2Zrn0dcC9jK4uqQsmDk5zoiMl8sNzGdR3U1yUVEPzbVLU2xf7Dh8Ioam/b5nNoSTPp8mZpShiZ0yI34qjBghSqcuvZtla/VNkQGW+0NhNdpZss7hLrTQ4u0wrcGS4vGNHXi4BLvsj1XbGcvEV5MLr+7EOVxk2STmuCIF2Hh6zwwfZdsE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB5o2tPHl8tynEgWQ8KGsDeUhZ6mXckoaoh8e89dbpk=;
 b=luuJDcZK47rVmshWIUQ4jmTuzO6E3Ykk9E+VDNP5PY+Rh94ilO3iqt9UTeUOrAsLy2AA+6ZwuMfJAQXuBjezyudxoMz8iycjr9Wwq1O6Fs7zNGjKuHl/j0DLEd2g19aEnvWwwvJMBLkcv7eJ1t9xBFrckeX5qiklhVEzx13hdj0=
Received: from AM5PR1001CA0017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::30)
 by DB9PR06MB7898.eurprd06.prod.outlook.com (2603:10a6:10:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Wed, 10 Apr
 2024 10:37:21 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:206:2:cafe::62) by AM5PR1001CA0017.outlook.office365.com
 (2603:10a6:206:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 10:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 10:37:20 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 10 Apr 2024 12:37:20 +0200
From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
To: joel@jms.id.au
Cc: bsp-development.geo@leica-geosystems.com,
	Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] iio: pressure: dps310: support negative temperature values 
Date: Wed, 10 Apr 2024 12:36:00 +0200
Message-Id: <20240410103604.992989-1-thomas.haemmerle@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327084937.3801125-1-thomas.haemmerle@leica-geosystems.com>
References: <20240327084937.3801125-1-thomas.haemmerle@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Apr 2024 10:37:20.0697 (UTC) FILETIME=[11140A90:01DA8B33]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|DB9PR06MB7898:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: baf30ff8-850b-49b0-01f0-08dc594a33c0
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZsHxDHbCwYlQQZyKjWOSwcHsO0N/x2gQ5sLj0pJj6Isg/YFIh0eJFhh1vqvf4r1+dkSHusUBJv7+DWPYuB5+ZUSlUZMK+zP4FjevbU3T/iZ50vLKJ44/8Je1zYcyKsIE9Wo2YmxhB5StaTi2YjQ+VaZowb9l3/EOSDtZygpIN+0Y3N6acKMhW0XJFkGmyXSuJ7kannFASjVth0ZIkqCXFkVN2LMxDU+LaA5vIxDa67QNLS0paw9EoeIldH992vOSIiEjuYrcPeD91e5NOodQ2LSbWa447N23kShydFBmnRIlqvAof3EBd2KNuS+EM/fJ0QV87SO6+maiiIvrrT638RUiV2DTdk8UoMu9odz1JzGBQ3HrTDg2CTfKqFVJ9sArJXkMBvwtFI6W5x1kZ4sslNJL6dL4cddh7U8ZGCfKoYAHJcjdhZnsu6n5ff/84arKpQ7ZZQLdFQkRq9oLdN+4Uc3yMrtljI3xuSBYK0Th17AvL6UsY5OVNzwVQ6SsypKdEEx9PSwc35ut8m5/LN9QcpMrzkLrxi93sdCtuJk3DauW3jG2Q4/YC2bvFtIlxCGAxZKlB0vm+2yR4hxI/a6C/URIC33Sdlwag/TDnWKodIEAQ0r+cql10fz18DiZiDEHORRY55kWgy61K2wTqLw99KIsjjFULYmOrHWwhhO87CXPhLhaa2F2mJQKOabF3E86y8iopLjR/lWn59/H2M/YJmXDs6jXkp+AbiWrHzLX7t+LabDSAlNOwrxpkzxbA57O
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 10:37:20.9347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf30ff8-850b-49b0-01f0-08dc594a33c0
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7898

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

Thomas Haemmerle (4):
  iio: pressure: dps310: support negative temperature values
  iio: pressure: dps310: introduce consistent error handling
  iio: pressure: dps310: consistently check return value of
    `regmap_read`
  iio: pressure: dps310: simplify scale factor reading

 drivers/iio/pressure/dps310.c | 138 +++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 61 deletions(-)


base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
-- 
2.34.1


