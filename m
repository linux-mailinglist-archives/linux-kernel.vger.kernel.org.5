Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5958125E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443099AbjLNDZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjLNDZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:25:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC1A100;
        Wed, 13 Dec 2023 19:25:33 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0Sbe5010215;
        Thu, 14 Dec 2023 03:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=dXSnZhXluEhNutpALxzi8ooi0QzO5Bs9g9QnMmzPdoI=;
 b=KvAOtAOQUOGqAkVvltx3m3rx+QeZu20+Ef+MNXMue6JPhXSeC7eeBS0cDGutCUgZS8OO
 eu81rskvM+j5utaORyciG4XdenoneawGsX2XRNLa8VH+2KonlURyTEoQogvpoS5sF8aT
 19o0GE/WaB5RUZ0CV7BR+umZvRxnmTQDcwnu+LSmGzon5PnbiOuoNcQifkSBbjB1uWtf
 zYCqdfYUGRKlD2rFVlQGNcOPTPSOyoAMjHhKcVqUBExe2SFC1lA/9vHp3BDkY5aXGTWJ
 ZzFXvXZvL+kATchl5Ten3+v1pK7wsWvV5b+heMXCSEyq6lGK+tv/pGFK1QAreopgRSmM oQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu29qhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 03:25:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE1A2dn003288;
        Thu, 14 Dec 2023 03:25:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9c6ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 03:25:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoCyqb1If8WP2GAKYmkhnMRpwBlGyyBTRodT6lTNEr24XPjRpfM8qFaq+ShP1jA5K7S/YyntSeGFQsc+oPvvvG2nvekz51p/tsC/zhRKeglRPSSkksRRUCM+qNdnhOJluNRVTBA30ZkTm1IQ/uDMAjyPe1X2pqdya9IhNjYuj0ZfLdMnwVSPttO0XpEJc5QrZE7P3ANmiJV8RJvofMNIPlR5B7YtwCsLfGobJwtH8ABx69oAhUzdbIFUZnY/FGuoWCHDRd804a+0z+Qb3Uscy7uE68daQtzK8tBwye2GNgvIMrtuYFSbj54RZx5Ek+C8J9JE1zk3wS6Hs5iV50sUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXSnZhXluEhNutpALxzi8ooi0QzO5Bs9g9QnMmzPdoI=;
 b=Uwew1WdPGzcemBE0/8kCBnZg0mF9R1pH2ybC/DxESAujjvMjfh40/75hCxT9zj+ihl2BNWAw4D63oG0jf8Jqy9cEEh0GeK058r+4LCcUmUdrl5Q0gKD6HGmZ/VHZqePTFMASY9Mhwh28xiYG2AD2Qd2un2li9obdjTU3WXO+LaKo2VRlrI+iSl/8QcrueygAvcXKv81XzB6ldHOK6hh15V9ywfnMjJaYdgoPIOnY5NcT0mo0qmmrtlZYE94cFp3XoLS9qX+dkHqmBSjW59qkmCrsjV2SvxfmzCi6YdAQX6xC54z7bfDrUQ9f2VBY+e6vaSOBRFZJ6jFGPZqZUl5k7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXSnZhXluEhNutpALxzi8ooi0QzO5Bs9g9QnMmzPdoI=;
 b=iJr6EU+J4aANaFWVivTo1IJpHPf8Etgopl2XgZ0pqIekQuXiSixwjR5i5kesSd9wQr1b9bZ9yjYKZ6cbeC0jI/TpEJ+uS96hcHZ9yK+pbD8ZyXqVKajP9eboPdD52MGIuZiSYsrwri+Di8pxRQt9gAjTh7WdqlrRI4xcWgTXAFs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5685.namprd10.prod.outlook.com (2603:10b6:806:23d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 03:25:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 03:25:20 +0000
To:     Justin Stitt <justinstitt@google.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: fcoe: use sysfs_match_string over fcoe_parse_mode
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1le9xh3e1.fsf@ca-mkp.ca.oracle.com>
References: <20231212-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v2-1-1f2d6b2fc409@google.com>
Date:   Wed, 13 Dec 2023 22:25:17 -0500
In-Reply-To: <20231212-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v2-1-1f2d6b2fc409@google.com>
        (Justin Stitt's message of "Tue, 12 Dec 2023 23:19:06 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0366.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb6761e-a7a0-48f3-cad7-08dbfc544ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaefV3yZ8lr4jOBXnoV4m88BYZ2sW077QJbrlNxLyIDh+u1mOYnN95pxgPUwwZbhR1hiJLhe4IVZZbTE++O1DajqgDNlsMjrABPdFbgJdf/i5t1Pc4BGaIImE7YOpWn92PzYmCxHetW2G8+xI26DKOGCzk1IIkPacOXuqyl2JCh6i7BhyLlLJ/k8kx63ghFejqu/u0kgNdWWECMln9kCMitOxMFhsL7/IF2tWoTW7pVmO5tZqjg7ZV6DpjgR4+qnY23qZK/6pshNaq8AoUB/bXaUF+7vL3IjcMGx1aGgKBm3ymvxrQB90meUsziqH9E/EAGPTppiVZFeT0CxSj/uDov6vUvbfV7imxBKCDVfeFPQjRY28R3oUrR70AxfxsyCp+dwuXtB5U3GZNsDAL1K4OH1H0AmoanI+j6To56Fgt7vrhSvK1DR3r9v2mHNtK5Ppsm5pEwT/PNNIhz4ljs2620jsC+w17Z9yYekaAdgVtIjKxp33GV+BT0bnEHb7dQ7ysqA/QV/6snGK0LYmZFY48svV1q7puDETZVSNb1WgYDxR75tocSDC1GrF4RmocoH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(4744005)(2906002)(86362001)(4326008)(8676002)(8936002)(316002)(5660300002)(41300700001)(6486002)(478600001)(6512007)(26005)(6666004)(36916002)(6506007)(38100700002)(66476007)(66946007)(66556008)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vX/lR487xlpPFATHmgsV0sy3bSHMuWXqnyMl3tG/S8ov9NLvXGDdq+Ya/cgZ?=
 =?us-ascii?Q?8TfpwQa/0W3y7dPFW2ffyPlRqo1+06yUYZVCmqQVXCDWXfs6fLuhyf3NfwWz?=
 =?us-ascii?Q?F8//tjOaKONCMkxQJPmdOOuB4WiTmbLnPmIMNyGR9h8sx7vYmUtfyuoh58yM?=
 =?us-ascii?Q?11e3/vU7o3R4RcuL10qaY/2aIs4nMZIKsh5uyP0MIUOgcw9ajbky8rmybjGR?=
 =?us-ascii?Q?6bAouGdD5KAqU/Jk47pqKluHYENjPRS/sfwQ3qZWGphNvW7YRXb5L6DOK2cD?=
 =?us-ascii?Q?jzuY9kYKUC/m65DBToV2BI0MRw+PTPHyA7rn/OPP/RakMPjindvo6M+v+xt+?=
 =?us-ascii?Q?WKYMsBfR4sddUgN/7xwnuP59nNkbticN8DIlGNLetdGMom16B41Enxzb/GLH?=
 =?us-ascii?Q?ylZvZDfZWstLJ6rXBBbgE1LVQpV7MbO0I/2zzT/t6A1yix3U+Q+3paeqJM7D?=
 =?us-ascii?Q?/58XofvuifCLi3320zFLKLCEf9j0Q6wcqqiTjIz0ZeNKARDueurvWn6mU/7e?=
 =?us-ascii?Q?gw3RaneeJrT2H24SwRg51aT6+gGai1OtBDFuOA6GqdWqQxU5X+ZSQOZikem2?=
 =?us-ascii?Q?6yWbO6mezNeQaSlyMnkhh+YKZXzApbyT3lq7ymiSP02IiLNLpp+WIajio0Cp?=
 =?us-ascii?Q?wJKuMSqH1grHUCk8ohAEaZBhYqJ7mQgmR8NtlkXXxCuACCiZYT5CHgE/wd6E?=
 =?us-ascii?Q?tZS7cN2xRHudO04GZFA2ZRWHoZ8+1XFJ1jP8AzP2lAZe8ahBwnb7Q4cuwRi1?=
 =?us-ascii?Q?+epWeSSCqDP/fEvP0KzXkj6nFOVIdnxEoR1vbgJfQEYaIfQ+dH85paxyBLIV?=
 =?us-ascii?Q?yu0BVrzhKbUjda0ezBoH+Ht/R+dlh71w3B3qsI0qNdcpW4AREIGsb0K9/EYY?=
 =?us-ascii?Q?rKLCurXfucexxm82ypvC8OP+Cat8XNuMI/6+RruRPv9eiVleyiI5FxYUfxhk?=
 =?us-ascii?Q?R8Mw8NtMPc35yFLQaJTrlKYxqgwe8TonSqWhh7OQqC01qqAkWChdDochK/oc?=
 =?us-ascii?Q?PsJONfzZplAbM/g/Cu7aeiO3hoMRdVDbekJ/XKHAwvkBsvEzFBBHOTB9vwCU?=
 =?us-ascii?Q?SuxE9n7K1RE+ZA5Obzc4VOYBZCiitAixWmkKB9CJe/b0CW6jUupqi6zu7ICw?=
 =?us-ascii?Q?rCReLNBnrD3UEIa9Jer0jyn0Cc0xyHk9wgO9648A/NH/0VdHO00FqmjjCrHL?=
 =?us-ascii?Q?/iTaUcyDTs6AEGE6YQCubHvHoEKlKXQhshnG9v4Pi/etF/Zp2HoGmu2ROK0c?=
 =?us-ascii?Q?yGhnwhkDna5SaVpF01xFZM0C5yfLjXQmVC72z8AUkDlPuM9mjHqa9mkehBGm?=
 =?us-ascii?Q?VHmeQFKQuIVv+GGoVCp5iNh3rpqb+EoWF+d+8RHOarn2k6hCeZ6Ib0HV2Mto?=
 =?us-ascii?Q?uS8WE4HMAV3KCydvqdJpQDrNCc9rqczh1/t5ZmmesL0XgS+V8oPOCKiyyVO0?=
 =?us-ascii?Q?vZSEpSPDqjTL5yPeNpGhz+y1ht2ow9CFdXxKxtcMTH8t/7l5FGlr2lmtH4a3?=
 =?us-ascii?Q?pGnjJxQG6+y5p0oNFWsUDv0tDx6tJ/k0VeXdUnh/z7qSc1PIYtpcqepZnduc?=
 =?us-ascii?Q?oHeraxMUINNE7LOiToUq9LrhS9kmkU6sSIxHx0TFE4a10wuyExdyjEjTd2di?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IM3fwxKmOQyUJKP3YNs+Y31IYe9CSAJU3MPxumn2XqGrWEC+znpB0tipI9CmGWi8P8bOFCDjkBC/30ZqszQHO6iZZWlKos1eEyxDZnd7c3MUbNrJCoCk8BZCVtw+9x+YmS+JsKy1qHuucuA/EON1frMRnXMeIie1NfkfRstFtEHBnIbbNGvleyM4aeZEPyt8wd8Pv9sOXvpadD8eLeKPcTVJJnbMXUdFMBFuc4Hl+PkCuN+w8/566qiuJvpBJz4BnGRuVc6MS9WRNpiH3hF/cgt7PYDTtx4Gd6qSB0YOgvNZ/9gTZSZlz/8NUAKegf9Kf8yDUYwW9AaxiIp8ycH5u206Em2ZyJ+IHmxQu0XObBtkNEA7lHxoQRDVL+51Btv7yzdd3WQTHhHbB5xzIM7cvMJE2gFssiDZXAMKkqkYpU0OkdZxLRDYMG8auhNynF7dQcteF6hh2TV2aVRc7kfK0tm7c8cNYLpgx+SivKGCoflRkI10YjgRCjsOzLdCeLrmXEtBgMTzzE/7HoxAI1EonoeS/ftmgnoj5u4bZM0hkQY7bxAQ/zCS9Cx4Dro9tjBSudjkY2eDrxQF0weRTwfgN0WytHv4NoAEQyR5+hVZ02w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb6761e-a7a0-48f3-cad7-08dbfc544ce9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 03:25:20.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFt3EjYA7jdl3p66dMjsc4UNFhSoZlCeZR/Vyz0rnSu9nIitHQV1G4i4U3mvUhmie9Zvi2JsXxVnhf7d79XmcttDKf5IV20u68S6xNbgZvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_16,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=942 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140017
X-Proofpoint-ORIG-GUID: XY1RNJ6exhIK5ACg3oscf2Bqjd8EquC8
X-Proofpoint-GUID: XY1RNJ6exhIK5ACg3oscf2Bqjd8EquC8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Justin,

> Instead of copying @buf into a new buffer and carefully managing its
> newline/null-terminating status, we can just use sysfs_match_string()
> as it uses sysfs_streq() internally which handles newline/null-term:

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
