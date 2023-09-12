Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC079C72F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjILGue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjILGud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:50:33 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF5AE75;
        Mon, 11 Sep 2023 23:50:29 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38C5wov0030331;
        Mon, 11 Sep 2023 23:50:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=eKmNdnF4GCGMmnrE6L
        EQ70/RSAQaGfr96uZwvHn0cIo=; b=jcb73T2vy9ncsTGN/gV7DEmSbNQJV8z9+e
        k40AO4urtGi2/DDX1Kem+aGqU2c7x6BDakuwfNtV9UYscMIrp5tIrEypLAznjQkr
        crZ1hsDjDgW/mVNTqinPQxYB9IFMpLbbAxVfyL97aivHxmHb3FI1T6O7OKrsVV6E
        O6dafR5msCB6VZEeJFP0/eNkxi39XVt9q9P9S2IWjM+Mzd9LaSoyAjz/FMKvvcnP
        2zn70ITZUZYrbAYy5xwgbpuHqJPFR1A86PW+E2Y/zbtrVwVmbtOnVzzq8/tDV/Fp
        Wf3dwDxLGRUPfRhySMbi4lYLSEodz/A+TMjUvOpKrI4pfZnt4+uw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t0r7ft3ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 23:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDYEj5oXgViFJVHr+bHX9iW8v3x0S0BmOzBbGonsJXkO0Ila+7HtmDnFRs4hzYKDmlkwVokOhVd6C2oZGRKAdBgXMTg22vsZMdryuFYgo/aUOeo1/nVAGTFEPIVXBlTOe58tHlM7yX0nTafPPKqsFxk/gsfOd1uRI69mcff3sKZcDhIpvEcq3ySQFuCEYqncTfAgfKiwyWn0zdPo5Fs6B8r8Ie6Tzq3NnNET6HQ1og73eo0ISZeOReR4SHEGiuI1+YaCOX4frj/wAlZfmiV86TYsyFLCEemGPVYlDUAzGFnABQ6dB2CDeT8zneybkFSxkOP6Z4AQCsTYd1Y+uETCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKmNdnF4GCGMmnrE6LEQ70/RSAQaGfr96uZwvHn0cIo=;
 b=ibI/EuS8e7RJwmtUYxThPP7CLTjZ/R7n5RapowLNx3HJFyGzxwWwMN3tWxVLXFRM8Pw3PwaWM+71UcFhUU6rKUrVqrSSFDvMQXynUFWzkkE5gJkcPDLNB+clzSsc8VAzSzocCxX7oBrj2qDunJlLauAK5Cd868Q/sgssSEHRzWdVgrFziP1Yoo27ybUDAktZYC43MIrtPWX6nKoRtfpBqbSzb1iiXz76afOWH/A807TsMdtGY+hX9rJM3JkRl+3HE4IhSM7bJ71X4I9JQ4P2HGDU9NmOsVh5Lc/LN4Gs2EgnVmoRwD0jV4gQFdafkAUBVPks/deLLPcZeP8BjM22Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by CH0PR11MB5708.namprd11.prod.outlook.com (2603:10b6:610:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 06:50:04 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 06:50:04 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        gregkh@linuxfoundation.org, pavel@denx.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: cdns3: Modify the return value of cdns_set_active () to void when CONFIG_PM_SLEEP is disabled
Date:   Tue, 12 Sep 2023 14:49:46 +0800
Message-Id: <20230912064946.1405848-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|CH0PR11MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 25395f50-0591-4fee-b9b3-08dbb35c7e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kV5zzIAfnEywckhrk+XTkEG8uY1JSQErgk7OSV8IRWmke1fU7JLYfM3bHl2rANHosBeR52muB9DfakTjsrUVrgxy2Amiozy/9NzSIw+nC/xw3tF7Lz62NsfduJlOxJFjoNSuH0pNLONghC01XW4oSiUWYu7tRHoaDnRB0PCVyod2kYX9KMKEc1WFhyO6hAYTeTMoOr+I0OD5+UqIOFom6VYFlta6wQdG0BYV9ztLcyBx78Sfzma4LakEhPCGCdDArQD0G00O642z5jo867xyImuKhAWt3JUzmSm7bpGDgEM5NTer7Qu/pVf0M1AqQrq4IuT/jEvyiPcH9dPynqjVmsEja5VmSrHriV59CuHCe5fqubG3KotHHcbyyhEmxSJrXY6v6S4OeRzo3MVIGngElEo3LDrz/uwsYkGwwMDUBIl1txNi2kWqaFGhaxwfc593M0bDBLCXNf7OOAiy66oI5g5YlCfUr3Vt5nrJ23OhuUAFC3pJqWJlmpm2VW2t3sVjiGJ8NV5h74+4Cr0t3VHBeOTlCw9HlQDg489OepiYLeGiz8PWBkbCkuIUNInyojLx+NBZufBllTTSJdRUQRHjOzBgWPv8NzL2V2tz7bJTm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39850400004)(376002)(346002)(1800799009)(186009)(451199024)(5660300002)(8936002)(44832011)(8676002)(4326008)(316002)(66556008)(66476007)(66946007)(41300700001)(86362001)(2906002)(26005)(83380400001)(6486002)(52116002)(1076003)(2616005)(6512007)(6506007)(966005)(478600001)(38100700002)(38350700002)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?imbcUvSsUwJ0+20zSa5iG/j9qIL/P2gypFWhYrJs3xaqRiQfMmDdoRVJ3bPV?=
 =?us-ascii?Q?Rn3gd5xS7yGqLjaDPmGq/fJTt65ll+IzJ57SYA9BzJPaZFuld/vp19d0whEJ?=
 =?us-ascii?Q?J+Rl/Q8NzechnYScBl7WU6nOWE08Jiz9CV3MX40ogjBJ81T9rjAk88LtixtH?=
 =?us-ascii?Q?w/KiwJRSvO0gZhF+lbfyeuGIvWb1uPLBLXOQu3m3FNNLcZWgDWuTfmiGhw3S?=
 =?us-ascii?Q?6sQAG/lyyEhlLHGUD0vNMFnBLhMLnaBw0SFWAN3aaXJFwIfQsQc7Yqad85jv?=
 =?us-ascii?Q?puPAhlyvfYCiHp8sox/gIcLWWJdZ+NTthuUVq2joq1gglkt5VdVwzVPp0tba?=
 =?us-ascii?Q?pOaxKK+jRpaWeRolen5S/55KcdgBqbVcHZfHOLeKoYRaatd2MqUWlmdcralF?=
 =?us-ascii?Q?ZL7/Lfhb2nmK2zvxmPvGlka0Jv+rALRKY+bj0coCbS33wJHeJjlJDOwJH5p/?=
 =?us-ascii?Q?Bcf+J/gXLjLeV0b+ud0PR4x8W4ZycgU313jol6YHs2f+8R+phgV8R4F2KPDq?=
 =?us-ascii?Q?IC7oPc0vBmvq8jYlLvMMcJWX+0qVcTMgMdU9fCK8CZSVbqjEx5FV8HkXVUhh?=
 =?us-ascii?Q?g2URqviQ4QPjYEDY1go4PkswpGMwIZobZAtmuotnRSo4NxytCEaxrFpcOrD8?=
 =?us-ascii?Q?7h8dEm5YoEDgHKeHt3qfPk350Wb1OH0BVcF2u16/z+S/9DKOM+cvWxoeFMS6?=
 =?us-ascii?Q?/NyQjgwU41U7BmdIAHIbne2r984A+i91usscIJyUT1hJtBKJmjprZ9FbDK/3?=
 =?us-ascii?Q?VErDFlrcS0sPypMZ5ScbEiJhwH0/H+rVhNZOr6pKLf6XAue/4lvuPJOMyyz/?=
 =?us-ascii?Q?aWWl6h6Km4liSZ0N7zthnBleF7uMARV9jY6+ei8+f07s22MNJDN8uTw9u1lF?=
 =?us-ascii?Q?goV8spo2YodeZ2LXs2H83UJpOT+vIytZFK2Tp/lxf4uH+c6TgRfx39eZdhLy?=
 =?us-ascii?Q?+CeQrLMdQU6dCykkYfKJV9S+kPk9kZ2W1mxI+bIea295TFG8sb12/CYvMEuV?=
 =?us-ascii?Q?2izpUwPBNMgxs7Kmu1WPl2QU7gszhD7WtRPS8finvXm8EAvJ7eroiJiheBpz?=
 =?us-ascii?Q?yliyrn9pTVSdIRLAkUJOj2yqeVfTsOAMMTF+il3k4IfWEsRfP9U/O5wXDd5m?=
 =?us-ascii?Q?AirHS9xHG+UlooaBBTM6MqD2mrmQJ57kHgJsm6EEOKVNCQJPM14D72habvSa?=
 =?us-ascii?Q?+e1/00607pfeMJfHEqsV4IF7yCbwoubOFhMEz7XRgpsu4OA8TB7kYvFA6cm2?=
 =?us-ascii?Q?gAAAk22eGPo7tfHmgih+xfAMk0ye32PdfNiw/ZHAMiEbX6mRBCwt0pduaw3t?=
 =?us-ascii?Q?FfMXrNME7681Ttgj4f7l5KaRdejUA2BUhIIE5bLyWQWWiNmM7cqh7Au2n633?=
 =?us-ascii?Q?XPqr4i2HPs31daIZ/QMhOo03DsYxW98WxbDlomH7JHEivVxid40PG+Fg1KlU?=
 =?us-ascii?Q?rGhzBKUV2AojFjT5EMh8rZUNfcoH+TaL7p44JFrU+esfoKZIK6fjdxXEup48?=
 =?us-ascii?Q?XyHiYG3/BbUVWFSrWhGKxsXRUCkrTyLB+R/Sx1+kz5XM+xIyWO7RJ5qlFHVu?=
 =?us-ascii?Q?HbCx7SmSx/JNi8pieF5cr6rImn2XBnvvEwUaNfzNik31ULOEK4UkYMqhDNeg?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25395f50-0591-4fee-b9b3-08dbb35c7e69
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:50:04.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgEadzNfATUpj/ex/Vhom6T9xz1sxlOQz1wnBjBFFBNK7lLzE2L13jzt8ww8swZV/QG5Vvqpyd/IzTWdZnhEYb7/1GqfvHV5s0++bth3Sb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5708
X-Proofpoint-GUID: _v_t8r5xYPgYK7J4VI0-LMhnoU6WXIZX
X-Proofpoint-ORIG-GUID: _v_t8r5xYPgYK7J4VI0-LMhnoU6WXIZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=622 suspectscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309120057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return type of cdns_set_active () is inconsistent
depending on whether CONFIG_PM_SLEEP is enabled, so the
return value is modified to void type.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZP7lIKUzD68XA91j@duo.ucw.cz/
Fixes: 2319b9c87fe2 ("usb: cdns3: Put the cdns set active part outside the spin lock")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/usb/cdns3/core.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 4a4dbc2c1561..81a9c9d6be08 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -131,8 +131,7 @@ void cdns_set_active(struct cdns *cdns, u8 set_active);
 #else /* CONFIG_PM_SLEEP */
 static inline int cdns_resume(struct cdns *cdns)
 { return 0; }
-static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
-{ return 0; }
+static inline void cdns_set_active(struct cdns *cdns, u8 set_active) { }
 static inline int cdns_suspend(struct cdns *cdns)
 { return 0; }
 #endif /* CONFIG_PM_SLEEP */
-- 
2.25.1

