Return-Path: <linux-kernel+bounces-17816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF3B82531F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187451F23D62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C423D2C6AC;
	Fri,  5 Jan 2024 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="gB0Ec0zO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75D2C848;
	Fri,  5 Jan 2024 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kufPvAV8BQhzKmJpsQk/zRVqdt7n1Dm4g9uDctGPK8VBKSCKiZVvL4dDDcTPWFnFYw1P9bE+WK40A599MLpToo4pD0aIm2yvnxg7LYYK4mjdmfuw3CsSlYey8t0SsCOyEZeLK96dXuheo7lGLIyqrAsz0XlNNNSlLuzLRLo83iMGTH1GgS/MKQ0KEdA9uijxrm6/ufTpznjfxAH1kIXYi7oFq8SWERM74XOyp1JtFjopbpoMDkjnngEBtvL0z9I5uhrH67ow/DPjivl6zszCFflIe/N/8FoMuNIRuCkHeA+viYoqZltgl79Y+XZYLkL/aXN5XjgeXV+7vsY047eLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdMhVx5W4qmt1DoI9yagQDMLzbzAPKsTpLntPZZFH5I=;
 b=bcWLEV0EWFboJu3735kaKDAnReHufkMYDsalgk+apjvBNHadhptXlBWORZRikFMZsK6gW3OMyjuRFMW6A7xKkQ0YUylhfY+Q4PEW3ikO32xedFaEY+gQABdH3wge44J4lEnGAfouEP5QFUiCt46gUU9rfKjUbQoTR4LMZlxWwq/mTh60nzTVP2pMFersoU83N8+F7P37WqjYVSo9iGWb1iEuxEHI5sKIpUsM4wQ4oSofrat6yYVQfdBJxDwgqVJyo60+ckh5NGiOJFxuDO3T96kJlpt9GnOmhJI8OLfYUXifYY2rea8cONFuFJowqoYRQ0qwG5g8wCMWw7pHlT/WlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdMhVx5W4qmt1DoI9yagQDMLzbzAPKsTpLntPZZFH5I=;
 b=gB0Ec0zOlm/nba+LLqYI3z3pEXHPDKGbao+OMwN5cnfWmvilmTY17jzuRr9gz5OX6eCDOVpaLpY4sUJz9wBF6mchm2KxeyCLlwp+NvNugoeIk+iryUtvMMZO9TuQdUAW0iNnLBJUlvL9Sy9YSltWKXezbNdNv43haKIKWC+TywomARKDN9hqvZ4S8ulow/UvDggQ4YEdIdgljQucwSXbKJ/Jkzkow33Qr9d5c8IJ292Xo2QQZOc/q5Rir+u5tJ4GtVK3XEIMuqr0WZJhQmc2S/5FvQ1TiQeXU3Qw3ueIM1OKKBODkfCv6jCI33XxmFUggQZ1QPDIouezppsRPlbYqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by DB8PR06MB6490.eurprd06.prod.outlook.com (2603:10a6:10:124::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 11:50:31 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::820:f7b6:7f2b:324b]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::820:f7b6:7f2b:324b%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 11:50:31 +0000
From: niko.mauno@vaisala.com
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vesa.jaaskelainen@vaisala.com,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH v2 1/2] usb: core: Amend initial authorized_default value
Date: Fri,  5 Jan 2024 13:49:55 +0200
Message-Id: <20240105114956.30714-1-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BAD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:7) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|DB8PR06MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d78e36-d2f3-49d7-cfc5-08dc0de4851a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZHBl0bJmEO62aZC3qLX/bTnyQoQ0sJgJ42VTM6/L4M9q3i3npV0KWeLvD9IzYC1pEACp4sT3FXxpchWz0OoFWFcuc7+xpd+kDtqZxc5aKjiHyO4+PW2J86zPORMScJw6mGg72d42kHCUupPlbLFRovltEIpsg8yrI0nCI2VDGset8cf18neZDjanAlg/4hQELzdwZbitSTilhN7To77stLgTR4/zC0f5jnuEyinzkm2rp+cv1rjIvjhamPRPC3K49fd74GrOZEaQkySJoXwOaAtLZ/NnshuSQVrzlNQObKLupdVGCDVW5EgbkNqGlYLdfz8uLUvCwGzKNGDDOpbpBeaix/0bIyYpoztP4DPJDhpLMxct0w8RcfVM0zv352wjRj3PJ6QhMLjbajUJ6I/FY860msrfNhsmcbirgAhkekGfPiP1dJiF09lv/kuh6+5b9eAig/tEKWpCLFiUsQEKWGHcx3aW3G9TK0pr4X8myuOn01Z4tuI5wSt8Dat17m3WxQozQ5YmU9ZWuHMHQ7vSTi9h6yAQkqLqL373bEkdTdBlfNHhiCD/bfcGbAnxTjvncmOVuNjuY2i1+W/vMAnQMHKL27xElTOk0811EWtsn8AW9xfZWZlrbUP0imlUiU6V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39850400004)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(2616005)(9686003)(1076003)(478600001)(52116002)(6486002)(6666004)(6512007)(6506007)(107886003)(83380400001)(41300700001)(2906002)(66946007)(6916009)(66556008)(8676002)(8936002)(4326008)(5660300002)(66476007)(316002)(36756003)(38100700002)(38350700005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZedDQ+MMfETmmPz/+bIFf/wkCtHDQd1IcPGhyTvngw6qh3HDE86tOHkzu40g?=
 =?us-ascii?Q?oLJ/V+e7yhQt9K7B5Dxuxg9L373c4W/C6lmuWTWOvTFPBSlVieEy+TrkBobS?=
 =?us-ascii?Q?K+BmjHPOXqh/qBD9XskcdGkkTP5A1glbiug4Mmc4X92wRJoF8PGYCfylVmEl?=
 =?us-ascii?Q?tuUqkwHvcvKwrYWrQCWPlTSaWXpae+ql/NF/hEP3/wy0IhMO+5ZZvxEp+25y?=
 =?us-ascii?Q?Y4n11XysEkjlrKoeIXB4LxBNjbz8ZV60G8wxN+Xf/dXw5MTMVbE8nRRLIZ7P?=
 =?us-ascii?Q?TFLwrsDqEG+EQQ3STt8jkpg8S0hyeiZlFmBgX1sGOlDUdUpdN36jCJXQPy6j?=
 =?us-ascii?Q?mmQIqwxA0on+SC0ELdgigKlIltPwtER8Ru+7IczMD8P3q/ETbdtbHAu7KAH/?=
 =?us-ascii?Q?LFPYJ7XqM4TH4sOmdUUkFg7al2la9vOtV7+Jjy4Gv/1FWMaF9nZx1YXlQCXD?=
 =?us-ascii?Q?+KmcyrMGh9Phzkc+uER3txzZKSFxjY9QJB16oMMlOzDgGdLsq+qmKdqRyxmu?=
 =?us-ascii?Q?nqHtvu+PrWXSOoH70n+0MphN+kUd+YcqPdLVKtXwIeSU5dseM+K/h1S1T0Bk?=
 =?us-ascii?Q?N9/fII+Z9Dj45HixK/fesAv+kvHmf4FlZ/QGS+PT5ldDi+24hUHl3xZOzX3K?=
 =?us-ascii?Q?7+pEwsLR5ilUzHewJ33MnOYK1CL0ZuCZNkTiEOAIKGdwVP/mHvDGlkEfo4kX?=
 =?us-ascii?Q?G1WepAeyo+PPx84C3WGBprO8wiVenJ8Pwaq0RO+qZ/7D/K/oFAROZSDIr41v?=
 =?us-ascii?Q?wCaJzcEf2LtZv+eJzRcbIA4gypJUBl7H9BspONnJg8FDe3QHSnDCEtrvo3HY?=
 =?us-ascii?Q?EU3ppBmCshlSF1NZgoujFXx/Su8/+xK3YDPwvA7Bx/WuFbb+yQgOAnTVoXaf?=
 =?us-ascii?Q?1m3kwqH7b5sFxAahA7J8N65YT65XOK9vNLPIUmADNG5sCcDw1bRoOqYX51o3?=
 =?us-ascii?Q?/k6XqSIX+RoDzsxOzQ0SVdiAG+ILzPxeDrPctGCxu43foIlOjOr1sKktiMk4?=
 =?us-ascii?Q?r4ywInUC7KlpO9Cl0aAB++v1uiXRxt87Ape+Y7RzipnZRYM6LTpqgqkfO1B/?=
 =?us-ascii?Q?rnB7QSXSob5NBdMpMwMFurZpOGybSKP4J95lfqXQuHfbNxvSTnBjvTewTGI/?=
 =?us-ascii?Q?YtkOoGkFoKLtWCjUUpPuUycCq9ejgVo7tye/r3va6QtWklOYklLYnjq6SG/s?=
 =?us-ascii?Q?ltpD7ssdyIgGvUm0DC5g76nGWs97oc143x5mBhu1KC3CL5/lXAO7HZooCHNE?=
 =?us-ascii?Q?gGVHuUcHGfBnstkC5Rt2BTGrvIKVjJqEKNOKXAgjIHKiADg0ieeDrtLMZ9/a?=
 =?us-ascii?Q?gyuLVUP9nhkDfMdRTUBNhzkhlEe8sNR+ycUXl6NeBCQ569nW+ZydAb6wUkIE?=
 =?us-ascii?Q?EFGB9+VRhMI5Vju9ARL/mR8YK7mn274MRpqTkmUgX7glkExRq0ah7mgiAUk4?=
 =?us-ascii?Q?3Qojmu0Pm+eAjpZ9TKKoofOIo8BccigehRRrA3WYFsCp2xECLwC8DfI4CzI4?=
 =?us-ascii?Q?ExqFPp7nEIlXDOwQSBkXJC10dprjLwBgVIjXCQLj/+yU+wJwO1Q7jzImCm0L?=
 =?us-ascii?Q?aR+sJe4MVFzLf2AY6JrzHMxv/MASrb1q70AVDLUEnS/4phqEI9d8b/9gsCh3?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d78e36-d2f3-49d7-cfc5-08dc0de4851a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 11:50:31.7619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lVvyR+wfkpCszI0nT2pPvLmPQTLAOb+DOrtI03FwiOq6Yt1oU5sQlZfa3/s5F/0A2PWlZmS6PgUuMqYT9VUwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6490

From: Niko Mauno <niko.mauno@vaisala.com>

Since the wireless USB implementation has been removed and since the
behavior with authorized_default values -1 and 1 is now effectively
same, change the initial value to latter in order to stop using the
leftover value. The former value can still be passed as a module
parameter to retain backwards compatibility.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/usb/core/hcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 12b6dfeaf658..9aa5e6bf9b9d 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -357,12 +357,10 @@ static const u8 ss_rh_config_descriptor[] = {
 #define USB_AUTHORIZE_ALL	1
 #define USB_AUTHORIZE_INTERNAL	2
 
-static int authorized_default = USB_AUTHORIZE_WIRED;
+static int authorized_default = USB_AUTHORIZE_ALL;
 module_param(authorized_default, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(authorized_default,
-		"Default USB device authorization: 0 is not authorized, 1 is "
-		"authorized, 2 is authorized for internal devices, -1 is "
-		"authorized (default, same as 1)");
+		"Default USB device authorization: 0 is not authorized, 1 is authorized (default), 2 is authorized for internal devices, -1 is authorized (same as 1)");
 /*-------------------------------------------------------------------------*/
 
 /**
-- 
2.39.2


