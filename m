Return-Path: <linux-kernel+bounces-1109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D5814A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 650B8B23159
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC06C34CD3;
	Fri, 15 Dec 2023 14:35:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2045.outbound.protection.outlook.com [40.107.239.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306E1379;
	Fri, 15 Dec 2023 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czeoSTM9sj2aMlDb/pTPzOx6iKlm008V8e9fYeFRvqBYas7vkYr/YS791LLHypLmLNIzzUF+JjF8o7bpfLZEx12N4ZtU/U8bXLxpXRJ3BonIPx2R2W47z8pmWej4We0OT+HZQzCe2JgQ9E4eC7BNVBlyTFhgKix2hSKn0dWro31k9Y8X4XkbcWxIAHZ42x+D3xV+7JMZaawZqmV8hDIMjiF/yTnJxad0sc7D+Rj0hjmoiHWlEXuUFeyDi099BZffMZs1VTuEMNDGo1o+coebm8AaPuLZRyqA+JGRUHTSOLHjsrNxdekymZZer1QP//XrLPZ/BBnjkA1iAJkRB9+syA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJTRZ4reRGz4Tki8DbCg4GQ8JpDBEtLn4D2r1otZ+uY=;
 b=etiSEnq1X/nBBAePYaGAo03WZrRn4bIK7TZE4iIAC8O0hqHV0I5VwIXcMt/dxDEqoNokYleQAEnT0w+dCLahpxJFRaSxzz6as97f03bATYgA/XRqR2PbKEHO3D5Xzh7YnDXrrZuwxSCpPDmAC5BgMh0En1D+t1Hk54xlHRNcdjaHa7eNvnFgHdmwB1SJ3yN3wo1as8Ijkmf0cHDxoZ8le2U1YD9YS53o8ZUf1ZvU0Uo7JQtzfgVaOFTf27YzYY5f8u3kol1FF4PHvyMYNCsFfJfGEZEO7T+ruWX+f+soXMhWYCgEBVzWo0wH6/myjKMTX529nq4o41EugbzNxxgJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PR01MB4908.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:8::19)
 by PN2PR01MB8971.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:114::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 14:35:51 +0000
Received: from PN2PR01MB4908.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7c37:5b8e:a99d:65be]) by PN2PR01MB4908.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7c37:5b8e:a99d:65be%4]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 14:35:51 +0000
From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To: Thinh.Nguyen@synopsys.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: himanshu.bhavani@siliconsignals.io,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: imx8mp: Fix smatch warning
Date: Fri, 15 Dec 2023 20:04:57 +0530
Message-Id: <20231215143458.158810-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::19) To PN2PR01MB4908.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:8::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PR01MB4908:EE_|PN2PR01MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: c60ed3e0-55b6-487c-ca8c-08dbfd7b2289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uhqiA9AP7Qh/dZOW/101BxU+EDnYvHvbi3nXk7BAKYk300zn7QIcnsjIK6/kPpdi6ZWbRtRelucus+M5xvBUjMetnv+oO3Siz+fgkUQ9/rJ7Aj70bW0GMmgCZ+956DcZ+ar/lOZo3hfJokWmAbv4Bbz71pHazwSGqq+Yv8uyJtxpZncSI+6Y+HR+AHuvVNDmx7kAI4EEpLH58M2cjtTrmomALZL2PB7YvJ3KNCtDq6bN/VahrLkDyVH8Nu+Xa0/SHGgSGCtYdMgOH3I3KweSk9X+4ShwYUDwaaieyOflBWRny/Gm+tGb8KmjidFqMBli+jPlRGN0uFtDjc8XcIErHpG82eYSp5FPeCzePkNtonzEQxECcEeGWhXpzhIJVBF/R4F9NGLQ37WK/0zh3SInVxKfAtqsvKhOccWKRZlK+RB8JObSsu8ADcSOfVFzzL3kju8grqNo26LBHwA/z8Fdn8VPEl8vbnmQTnGLqIcWfIfMVlGYJKfp+wcCv2kYGoPHKUS9sMN0v/B0UYvYrqX0HxVMsOGmQfAGtvN2TqVHCGeWLFTG9vxoD45yOLAtY0PjAFS+a3XExqcZWmIP9EsyDl/HRkCDynJcaZPTEaVMONEKfrj7+nTkNYplzzoUjdolo12BZcgLO1kmoznz9+ay9A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PR01MB4908.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(136003)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2616005)(36756003)(6512007)(52116002)(6506007)(2906002)(38100700002)(83380400001)(38350700005)(26005)(41300700001)(86362001)(1076003)(66946007)(66476007)(66556008)(316002)(478600001)(54906003)(4326008)(8936002)(8676002)(6486002)(44832011)(4744005)(7416002)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ohJwRQzMgdICugFIeoYPnDhN0dmp8RyIDSeLcxpEJCjaJ8LrmwoRrQMbQS3j?=
 =?us-ascii?Q?jz4SJ8PtkHlB3A5D75oTFyeXkvycZCiBWFI27MkGuFlade/nzE2XBYchSgIg?=
 =?us-ascii?Q?n/Nru4fAbFqGSO/sOKaXRlNum9K4kuNLuJ/dvmW9oAo5QNeOlQd60svviuhi?=
 =?us-ascii?Q?15Mi6dRVU99BBIfszTVupwBzQI2i95ahWlGrzjR0QeL9B81pYSevNJ2EnTDs?=
 =?us-ascii?Q?QMK7IS8zB30Od5umqcOnJV/k4OTud5XnIIgwsejTVSyXMNDjLhpLEBhNqoaR?=
 =?us-ascii?Q?Zsi647XGfad8u9bR9H4Bkra0svHz1k6ThTWbmLoKj3OwZ65CApGrJRIaplJr?=
 =?us-ascii?Q?FMREndOvXJSg+E/0pu0HfpqVkrIh1tLqbQRlEWLeT2D3uIkkdFUQHQBKRt2j?=
 =?us-ascii?Q?i1thO4s3KcYXUWj4Sg5hmtnvRi7da1q8x2lFnlKkRRqnyWJcJv3v+RF6K4/P?=
 =?us-ascii?Q?/RbieamG3VT22aTAD+sgDIIyoH6/fqybz9RIQggmuaUIH1fciH83Hxu7Pbpa?=
 =?us-ascii?Q?PbQwzR4WrgPMR2o7tFNoB6PCCvxPBIWus5O1pllN/WFZ2nfPwFCWD7w1xTha?=
 =?us-ascii?Q?VponLcpzo/T30j74PKwq25+inZUyCubOcF0sPrZiNusjflgn0W0wk7qIW0or?=
 =?us-ascii?Q?W6CM+ts5joD19YneSd7/NcYLUtj9KzzcGt6TAI4QBewPlhlMfvgeQw8nknRI?=
 =?us-ascii?Q?Ck/omSe9/0qav29vyppo1sKER6P84+2ZGzh5svOw3h6OqnHYjJ41JYqAXNy7?=
 =?us-ascii?Q?kc725x3RpOAGYQoM7X/ZqxXOrTV4hDLBjPdQmIl4dekkXsHpOMzhhLd4hY3Y?=
 =?us-ascii?Q?+c528SV5JxlbI7Btr4ZjR9SvogVl0wqrd1vdwbv8dRetVvWM5UBxbLIJdl1s?=
 =?us-ascii?Q?ZNIevz6VouVopMmPSc4BNOKbCC7KPhD6D2L0qSiE8my6GR704hFPBIPNHE2E?=
 =?us-ascii?Q?GUfwYkd2gX7MLouA6bSz1eTHdGCprAI+V8IitqCIiHWe1SP+QUHvcG7pp4Ap?=
 =?us-ascii?Q?/wJC6Ggpdt8ngQt+wZvxokTV9YolMt9MuLO4ftyfz6pxRi8u+9yIEJAktwi3?=
 =?us-ascii?Q?gCtSs42POLno734JcBBhdf2IvoFfl7w4bompSDbzaqD7Ij5Px0r3W7m4DHUc?=
 =?us-ascii?Q?lmuKPB3liigUQb6dtMTDiNJmDvO5bSry3v0iyOzj0yfOWBkMonjGr8Zxh48l?=
 =?us-ascii?Q?Mxhl32w42zpviRfzEW3tcD18vTxjcxdzOhP7NlvM86+aPDazglzER2Dwdhjd?=
 =?us-ascii?Q?Hrwk4LBF9p4xmipIobPW6/ajsxVIIqEOd2uD8OjFyNu+ofXgrLBPEDv4+rOv?=
 =?us-ascii?Q?w6ixkeD2QELU2+A8JozUIPeJC3JPcCmKkEUoQHMGZAHWpx+qgjvqw1FAZbk9?=
 =?us-ascii?Q?u18WT+IyUPhtKlIHKQ7mr81UaW2PodKR/ckStjpeTJqtXZfdnd3Bhh7rv+ly?=
 =?us-ascii?Q?Hh9gywHseVIhBeOvt62ukcLvYyTM9MNNKmFQf58XKng1/U4QA7UI2ppg+kYp?=
 =?us-ascii?Q?+WEAdDRDW68puN1ZY5wZcaf47v8ZJmKyUXXZTo3RKoDQIlUTHrkA2JN5oxab?=
 =?us-ascii?Q?Y/isUzAduQOKIwhU5BCW0lA5YqRz0t/YnQdf1r3ehzr33lEW1C/6TqZbSXmN?=
 =?us-ascii?Q?1vOPewbiis2EGc2VSR8svho=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: c60ed3e0-55b6-487c-ca8c-08dbfd7b2289
X-MS-Exchange-CrossTenant-AuthSource: PN2PR01MB4908.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 14:35:51.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nA/oQ+dn/7HVfwZlPMIhcLEzOjU/+Lec8C4aqpLINP9nTc86yFfXrDf0yrssnvKojGTw+MDjdbLVfDL1TegcftVXze/AopAagfzOEL+L3FqQhWg64cgUHpmWn4HaRzmb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8971

dwc3_imx8mp_pm_resume() warn: 'dwc3_imx->suspend_clk'
from clk_prepare_enable() not released

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index a1e15f2fffdb..8ee448068503 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -363,8 +363,10 @@ static int __maybe_unused dwc3_imx8mp_pm_resume(struct device *dev)
 	}
 
 	ret = clk_prepare_enable(dwc3_imx->hsio_clk);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(dwc3_imx->suspend_clk);
 		return ret;
+	}
 
 	ret = dwc3_imx8mp_resume(dwc3_imx, PMSG_RESUME);
 
-- 
2.25.1


