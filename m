Return-Path: <linux-kernel+bounces-944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EDE814854
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230511F243BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F0E2CCBC;
	Fri, 15 Dec 2023 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dJ59biag"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989202D78C;
	Fri, 15 Dec 2023 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpeMq9HmZiipuc9BFZ+McFWUCQBrwyapK9Da3Y9bt2bUK0U2XUu6dKzgGCzy8gbAdHMmRgb1YP+CJ0/kJjzh5jlQzq/rv6M28RZnoJMqwNWtu+j0fVC6rVQ7sHxM8Ze18zmHpElx8BO3NSpwJ2PfGb22TPWMDWBEPIFM8AjoCenMi2E290v5JzJZKkpEfrdKNI+ay4FDeOoJW6gDpfFSuHD+L73FwS9WTHcOedrFu2lqJpBowqUZBeqiqRPrpToDOyXiqyvM39499He05bDPtn+xtqUuPHnOoxWOmPUUcb/3unJgkuF8q/7LwrLyfa+0HFmvBI/pxmv2lpagQVKLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ6AZfJBq1/R3Ehsfp2ZzikHLoqaqVdq72By7SEsjsg=;
 b=RaS1s8N9fNC5JyWqrSKQa1TP9b4SlP5xz7K/blblnvuv8W5zuSL0CGgjMF3Ijf6dw30jybtrwF+beM5mscartmK3/86d0O4V6VhuumOzj0jFJEVRhQBMH9wJ2Rx/6rBnZ0n6Cg7szdULrr9xK3o6iJ/Yl2mblKxH+O/BHTPKE7AXFD0ul/q0bmgUziz92dv3RiTRp5MjlZHmyayCP/2x94KK1ezxCSgS4OSyAbuwBYbD1qnoULRobxOWPh1tZJkvewDqq2A3Xk4gEqIxEUYG3Ln7JxllRER0tG9SlUs8wKh+Q5oGzk2w5d3EmfN8+jX7EQtVvh/lZ3+5kbVFexv6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZ6AZfJBq1/R3Ehsfp2ZzikHLoqaqVdq72By7SEsjsg=;
 b=dJ59biagbgmcHk1Iv4SH4CWkAiDKd5/U5l0Z/rw/+iegmSRKtQFCTnEgV0jYm8RIHjt8O1yj8kn1WGiGJnaYJVT/ajmiMKJY+aWRCARr4E7jbjh0q19UylJnla86Q+qmBePS/pXraQhu4g8p21Db5k83SRgVhrwuqKT7ly3d2p4=
Received: from AM6PR0502CA0056.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::33) by AM7PR02MB6036.eurprd02.prod.outlook.com
 (2603:10a6:20b:1aa::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 12:43:19 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:56:cafe::2d) by AM6PR0502CA0056.outlook.office365.com
 (2603:10a6:20b:56::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Fri, 15 Dec 2023 12:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 12:43:18 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 15 Dec
 2023 13:43:17 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 15 Dec
 2023 13:43:17 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 15 Dec 2023 13:43:17 +0100
Received: from pc42775-2107.se.axis.com (pc42775-2107.se.axis.com [10.94.129.29])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 37706FFED;
	Fri, 15 Dec 2023 13:43:17 +0100 (CET)
Received: by pc42775-2107.se.axis.com (Postfix, from userid 21033)
	id 2FB2B2FE5EB; Fri, 15 Dec 2023 13:43:17 +0100 (CET)
From: =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH 0/2] Introduce new iio resolution standard attribute
Date: Fri, 15 Dec 2023 13:43:03 +0100
Message-ID: <20231212-vcnl4000-ps-hd-v1-0-1c62a95828c0@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANhJfGUC/x2NywrCQAwAf6XkbCCbVrD+injYR+ou6FoSKULpv
 3fb4zAMs4KJFjG4dyuoLMXKtzZwlw5i9vUlWFJjYOLesWNcYn0PRISzYU7Y39LAPkwjjVdoUfA
 mGNTXmI/s4+0neohZZSr/8/R4btsORlfhonkAAAA=
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702644197; l=1072;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=31VyqmkRujamzIcfI6tW3ne2N8fczlVzWIw1S8SxjM0=;
 b=iqcBLFVHwOmvd5R+CYuuX5KzjjMcZypA98h7e3oXwXkh5IemYlOHMRKaQWQ0dIfco0e8kLVsw
 qrWHNQOvlPaAnxROFyUbt2EjxG1K1YRW1Cos+jGIhsM1aP44iLOSJYL
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|AM7PR02MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7a78f2-cbaf-4139-d6d5-08dbfd6b6a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5DSUcuvJk6bddV3BEmyhZ/BQbredBUyk6dzThQ7X7ZWRr+6mx+mjtuJdLGeyMVRCTnXaVl19Ly+Vasxnm4sdRvw9xt7Yo2yNpNWF5nOl47O8iBtQMmm9D/WHuQS7BIs7N/zd5A3OG2dpectZ1TFAdHT7LS9dbv2DZq/P6WthTk98MepJw77y2yuO+aCdwkNRvuqorM4PcIE2MzJ0Gtvi4Qe4NUvqmmuYtCCkC9e3/M2uLjU50yTznRITWQdhKDYTXb/nVxYtp6xudiFf7A9tZxnpZPnaUCBqOGqWXyHQbZo+KSYY32HvF/OgFcryy8sGUbt64ZoFQS8rYOd5x05PiP9oaCLe1JVk49ITEz4p8pYTUqHe8CXAWRa1/u/NdWcxCTw4Zy5jxJFH6M1LPyt/R+dknzvMXzsHG5EMlJ8N1HK2ZLthCDX+NN477K+UkOAlISy17ZCFhEeyxIarDoS1xZLq+IUmXzcZRep+DLBeySs7JuuADR9BVCvkFiMFvEwQQv0hM6XMX/xB+FWBadT3x6JDz1mb3a4eDmV8ZyYUL6GgB/qXH+4m5bMF/LpPbb7mrwHHBGPtv8/giuUfQH/ZJej8iMraj63hts8gtWw6IOFolTzWUdcBxoS50bvPxGm8wh9NzshdpfYOaK64bna98/315BHOuQA++Ny/yloiTluQU59gFVqzCJb+Hl84fstLXfY6jwpWeTjgp2ASd2rX8Lz5DZD5qXeI6ll1LCl+lyheOAkcuDSgbZ6zqgiw5Gw/DZHsGSK3O6pB/ucn1qrSUg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39850400004)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(47076005)(81166007)(356005)(82740400003)(2906002)(36756003)(5660300002)(83380400001)(336012)(6666004)(6266002)(426003)(107886003)(26005)(2616005)(478600001)(54906003)(70206006)(70586007)(41300700001)(86362001)(110136005)(4326008)(8676002)(8936002)(42186006)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 12:43:18.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7a78f2-cbaf-4139-d6d5-08dbfd6b6a10
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6036

This patch introduces a new IIO standard attribute to set the bit
resolution of the data *_raw readings dynamically using sysfs.

The VCNL4040/4200 proximity/ambient light sensors support 12-bit
(default) and 16-bit ADC resolutions. This can be dynamically changed,
so to support this with the standard iio channel configuration a new iio
attribute should be added.

The VCNL4040 devices will use this for setting proximity high definition
(16-bit resolution).

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
Mårten Lindahl (2):
      iio: core: Introduce resolution standard attribute
      iio: light: vcnl4000: Add ps high definition for vcnl4040

 drivers/iio/industrialio-core.c |  1 +
 drivers/iio/light/vcnl4000.c    | 87 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/iio/types.h       |  1 +
 3 files changed, 87 insertions(+), 2 deletions(-)
---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20231212-vcnl4000-ps-hd-38d42abf9095

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>


