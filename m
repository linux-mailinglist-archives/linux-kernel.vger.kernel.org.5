Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37AB769FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjGaSAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGaSAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:00:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E8BE52
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:00:19 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTJ1p029570;
        Mon, 31 Jul 2023 18:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ss9A8aFklEfJA3GL4m79r3EugQnbiL7W2rxOJ0ueROg=;
 b=ksbWWIop5VPE5g5F30UbCtubkZBYCrBVGipl3AWj6zVyi5sDFdKC3U+o6iLB9U9/QMoy
 Kbx0DMx+FsKIm3zL+0oQFkTuwlWeMGx+/IlvSo+zO3gwPV12UBepX+zJ8FFYhB1afwx9
 jpsQCjzNM58IoZtWVaR3DmhdYCLvdjLTyLs1CMfDszj9WcUVizHRYM7YXuF/8+KeI7yK
 8uXcRToo85GkVuAHPlX5BJq7dHnaO4tvoloMBjDupnRBmyFb6rBvc3G8TmKe9OkFmwFW
 0av6YQVPJRh3mOSZ61jEDwQt10F5sg6Q71F+UAMPMzktLn7fTr1hZU8cikWB5RZ244CW 9w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd38ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 18:00:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VHiX6D033467;
        Mon, 31 Jul 2023 18:00:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7582f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 18:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHEOMk6EFydkl55JXsyekSoZjqwoQeZdPUy9nVTaUIU0rjvmiF3oMCdfsfwBanuUf7bFECfjpp9Xas2YQBNdz7H8yfJ8sF8u5jMFb1i8Tb91DuiSTMPE6nhQDmiwR2Th1YRlgiqkAUYZpoGl3kYRylkaEEQqbfw0DzybouwPCBLK1SVHHewaVyHKPdlumXmy4vryIyrmTMbLHOmbr7F8CSW6NuuWe0ReGufw53ZyXRiHHk/pNQWKZmexiE1ZksfNz8K9KaOixe4vzPdffhogHjh78Jd4mDZdG6r5GYeRWH5+aKw5sB2sdifz7LY54xLGgz2YvrEaCiDpQtXtyPADoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ss9A8aFklEfJA3GL4m79r3EugQnbiL7W2rxOJ0ueROg=;
 b=eI9noJ2W9dnXC7v60zV3kG02Ykymfzy1y7fpkJ8z1xI1xtnQnM8N3qavuKBzTqunyWT1UeIQXQXBidwPnEq3CGOU/S/L1KfiEu0RdvUJs8ZnYYgUS5v4Qz63F67es8CsfXShA9tCtaUV+dmAup5P8TjsXcnfkfNGdpxWGbfeSCYW/gbAXyBvLozSeufffjZqLybSQqA8t0bT3XAMD9U4cFpiq0HoK+pnw8cL/w4z7UV4V285/s8dFkKrx8VsJVzBQOX+N5J4pZn6luE0hIhPPDJWZkJvQXqM2UKKFSOxLrn0YpSfe8eH1vUJk9/plUi6eeJO6DxFfn6HLkIChddn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ss9A8aFklEfJA3GL4m79r3EugQnbiL7W2rxOJ0ueROg=;
 b=aR2Q/EScQ2Nud/LFw+tgzg7wLKOABEtZfgH87sHigqOJdMEHgR66/dGfmJouGI4QLsVwJQw/tJB4vECMlkdtf0jQmp/jB8QfYO6X3fcMehrAWLPf5GI+al+NeMujaHmSIZbtfCrXLltSATSRlRbdIXiEpN4vY732DIg8Z23e0B4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5036.namprd10.prod.outlook.com (2603:10b6:610:dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 18:00:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 18:00:02 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH] MAINTAINERS: Add maple tree mailing list
Date:   Mon, 31 Jul 2023 13:55:42 -0400
Message-Id: <20230731175542.1653200-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0033.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: fff49816-1370-4443-59ee-08db91eff6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSGFBvTXKm7n7xbp1efNVhpJEbUsD1+JWuC8GxNktF3U6eihChjYTlrVjXTXEMZPAKyX2OSnHt0B7y2mv/Lykw9ocTCbaqAmkYkIL/hwe+hqFOitd9gfDlAmCuAgu7WNCm7zv1lw7Eg9sexVUuY9WmioIhrAKlKoQZXOLNXm4T+KPPDSal0EiWK3agCuotwA/a7t4A3ertG5ON81bk/kTCfyBVJr1Cqhmc7dMlYMOyJMBT+3yWyI8FZKjBnaOcoMnr0WUTyDDfx7ejuWildnKppOCBTmBcCx0zCDTQdo3drvE/rmQ45s/oL7mv/eF/6CHuqiXnNuP7Etjt6TdWbgutVWPBW388M+Jm5IZSyxo6cmtvn3xuj/X+iu/z7gvcSdn7O9sQAmsyuh7+BY9yrIrMiGH8LxX8sjOHpJtaB+bFBg43GsY76hEVSeC0ov9QIbaJoARO877PX0zjJvgrxdJ740Yy7WmwzI/gp/vgV+ktNKh+vO2piqtXRT7lGH8Kxw8Ji1f8Atxo+uFpkNpA1vtZ7IrNzyeUIjf6lExw5Bk6JXlsf3Fasr4xXwn2ttzNPA/oFzLhxSOt2TtuopI6fOYBe2F0iYgU7jdjebUlQusB3BSrrSAzIfIL2Iskc0h+/XExkZO9tBju4bAsfhc30+fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199021)(4744005)(2906002)(5660300002)(8676002)(8936002)(316002)(66476007)(66556008)(4326008)(41300700001)(6916009)(66946007)(6506007)(36756003)(2616005)(107886003)(26005)(186003)(1076003)(38100700002)(6486002)(6512007)(6666004)(86362001)(478600001)(130980200001)(223123001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxa9povx/VV1qEwbjt6gme3ePnJHF1GhbJl2/r/kfEANEQNrxpxxWshcYqPy?=
 =?us-ascii?Q?0o3YeQV8qK7aQilN1qC1IgyRrFY1/YZla4SrTOhbWTrc2zzvEifDEfyf9icF?=
 =?us-ascii?Q?9TI3XfBAu3al3On5HrWz0WZFOCuj4qaubDMgRaTaYLl9e7+c1HW850+lIpyN?=
 =?us-ascii?Q?dE6CmxTPhSaTTwTi0oandQn5l56Y1Viw9Nff1r+ZNhHzhyn5r26VwRtc4TQz?=
 =?us-ascii?Q?v7Pq5j028xUJV4KEZ0wtDRCZXbLaZbqmJ2cFWLjaSKtyGGKWcNm3pWfhEsLn?=
 =?us-ascii?Q?sCThMSqVVbnvPQygobD6Emd/9AJLmHXns1BcLitIr+oAFxz3XNCXlRjYsY+d?=
 =?us-ascii?Q?NcW/OBtUuPPKb8I+WI4CqyDeTlDaU/aLv3P1aPw613eJjKJBStROZImTe52U?=
 =?us-ascii?Q?4OrySLtUK+oHS8hr4rQUsoJv36nVBiFr1tEWFj+6DPhxWliO9hWS2M0KgUfJ?=
 =?us-ascii?Q?bckPxDVzxLr5CctGHUTxgDPFzGidRCu5yRF0KqAqK+GE94cwPkmU27JL5pwl?=
 =?us-ascii?Q?r9JhdNtuoSqLAA511ft8/zjF3fpHBMhV6+o8eadJRoQCZaFOo5rGnov6tehG?=
 =?us-ascii?Q?pLTqma0riSUv6xYG0L23n/TTGtXM1Zzjv8FnBFQy2h1aVrIK/deYs8KUDK1K?=
 =?us-ascii?Q?kfKbVXtJPfJ9BbFKOwT6S8+w8++4xT0wFjmpI2kVOO0Zbe0bjvjcj9MjKd3O?=
 =?us-ascii?Q?oc4FBN4xpNs3dPhK99VBvX1st9tHh5dh4la2IE9jrtKdqBGLgb3xB7h7EH7E?=
 =?us-ascii?Q?/oAQ5EAKLFpkLHevDWMZF5jmxFIclMtWRvza3AU5sBRxfveNcyrKWwIBYhgM?=
 =?us-ascii?Q?7gipxi4c4TabGfc5g/aGyVcEDMgfo7QtHfwZBHL02/leUXSjIoC3MJLKNurI?=
 =?us-ascii?Q?l3aaae32fOqf6Z+QyDwsHyMV8GrU2eDgZ5g8uVPA3957v2c/JMdRW/Ona0nM?=
 =?us-ascii?Q?ola/EDdbDQCm2jesG+/zkffgB/Q8ZMfPbiMIQvVYvXKJb8OCxVnmtZUNw4zv?=
 =?us-ascii?Q?bBi/gJAb67s8b2UGY6oaRnqXzwViHg/zfAPy30LgMZ2YZgkHgTuGbn3n4Xsh?=
 =?us-ascii?Q?rCXZeIHSWqVQHiZPeyToowLpU5mhkZWPrOZbqIDnABCLa6jmlhy3Pr2e7FuH?=
 =?us-ascii?Q?W0K68te0TZWSi1TsUosiGFSwW2beVkkZo58G/51veZ6mDw3lek48L6IaVtET?=
 =?us-ascii?Q?d9SbpPnIxQeY7628TkM8rD4StQMRr4gRCBfVgBjTGY/l5wsXAFi6QGXzHOIE?=
 =?us-ascii?Q?DYU/cR6sFTPCTY6DI8cD2fx5RA7PhBW3SNo2R0JQeuVaOav+p8TW+TR+kliz?=
 =?us-ascii?Q?KsnlbpRJQdsNOs/1UI3Kt9iGkZC6KiUvHA6/9n6BN2lxGE2FtTGWNppZ2Mdx?=
 =?us-ascii?Q?hpyP4KPb1P6lAz3VKemWpOE3N4kyn8BANP2e72Q3mmjf5Ayn2e+jTVmLvMvd?=
 =?us-ascii?Q?GMB2sLgZw8EmMb+JDCWc5U151HcY3bqI7zeavPWNZixlX9l23lp5zOph6m5l?=
 =?us-ascii?Q?67iZmHRSxPtzFqN3qLNZtlT+uTTKwGpmLcYgWMbHN77FocuE+HOF1MpjP8Sd?=
 =?us-ascii?Q?z3MEfX+M3bH1hL4WQ35Ga3dVj/TbQIUQltZ98WB0L7cYSw8XRzAoZCJMNLM2?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bGCqBQzCvFQX3jYRDulP5zT7gWht1RQQU9Wc1HLmtHr6cLCWuYMDopWf6+OUIgSJrmp5b2z6CPkTWcE+Ssp73WEg+7CH2R9dw+wp2TE1RSycS0xHj6wzmOXWJHCO+XrQdqKhFai74t25e7I1oY5vlm2j4/psEl1Uj26/qkPB8ZuNj1Hj10oBWHdoh33dZrZfdfWvfZJq3KwglOWf7R9gM3QKqs+gVNjUkm6SFpFBIBYxwXcWLsP9j67nY2FomiW7JTv6I3kHdLz9jUoBx+NoLWj7svQUjIE8qgUGTlWiCtWgzmmy8bL6KTPvVo39daJDTAVttuCnnxSo+qQy1j5eVQz9r8BqixesqNStoxu+dVyjctMYckIcgVuZhOAGDq47x15oVhJeQUoCE85t591MKxYZO1n3mv81/i2SCRYr7uy8I/T6NsTe0QeCcV0MbczSX1V6gskmIbI9dqcj+TzYC3SfktIy/UwSRhxEVijBW5jDy80pzXun0m+arfen9R/hGsalo/GNDoDq5diO4YOjWu87i+V+eyDgwCKsX5xafXkk8E0TVOGnonCVEabQvYbUOthl/88kTVXM900Ix+2VEZuFvJoE8Hbl2Cr0fK6MAl0OhIPg53OdmZhynOhmwuv1Dh+apaLfWrvDOSBUD3J+nHEeX1jeS/llsDjB0qBBi+wMcxlCtYNKOBxFKFVC4cNJPi4rugdNHDheUKCbj52M1iq9hEFjtVbP7HEqshMGN0N0Nv4M9vMzl6PwWFhsXdruLK/s9F4rUFUTbNmQeyMnUBPI7E2LhkpnijY5WCDXcx+/bbTrUemxKdbFFKjzW7cGIB4whhRUXOOBL/m8yr/9U4fjNjVNtCW9I/b4kBwa5R2BtVYu0TMjcncdZnGSyRHTaQXEciHX0lC1JwJIzAXMjQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff49816-1370-4443-59ee-08db91eff6df
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:00:02.9189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zo5xOIZxmnbf9EU4Ql2pKdjXyfxvCTDVAROZzqpnH+y4NCkWQZacoYsUxr6XU8GCYHmjYK7CmSDEOoqnqXOcLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_11,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310162
X-Proofpoint-GUID: 5nnYu7b0tpAOJx8Kmqqu9qHapgKjJsmo
X-Proofpoint-ORIG-GUID: 5nnYu7b0tpAOJx8Kmqqu9qHapgKjJsmo
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a mailing list for the maple tree development.  Add the list to
the maple tree entry of the MAINTAINERS file so patches will be sent to
interested parties.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93ad0f13ac07..01ab679b2894 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12473,6 +12473,7 @@ F:	net/mctp/
 
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
+L:	maple-tree@lists.infradead.org
 L:	linux-mm@kvack.org
 S:	Supported
 F:	Documentation/core-api/maple_tree.rst
-- 
2.39.2

