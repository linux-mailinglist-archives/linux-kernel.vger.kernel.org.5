Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE1B7DF86B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377141AbjKBRML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377120AbjKBRMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:12:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BC4B7;
        Thu,  2 Nov 2023 10:12:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2Fjk3a027657;
        Thu, 2 Nov 2023 17:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=V1tM7xtedj3rxMbV+/0lIKjcYvpFnmyRTr4zeGt7clE=;
 b=eb7oV4oPE4itVHdzH3OVJftwPhyapQuTC5UyKZNp9Azu+/rCrQ3IXmsEiqQ2G+mB2RBl
 0LmcihBdX3kQANK8T8o6hAnQ1ev3x4GIgx2gY7M1w/iDrHf6jtsG8VVVQIoPuqkuvA04
 rziIobKq6n/o2pRsn4UmBcYpZxlJS8h2Htbif6eyEKzfwwullUAC3g+ekJebMKUcwCJe
 rwqBiWK8Nyy2pSf7k7as9g/l2vIzlzeaE0ZXICv1UOE21DM/avJWLlRo4s0K/FK6JLpP
 /C3GcJx5rivxFuf4jK2+lfVlUpSQcJOHnG27WLkBe87/zpSsTFstaPGocFwr/KU4pIix qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqe2a6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 17:11:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2GFwGC009121;
        Thu, 2 Nov 2023 17:11:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x8r9sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 17:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVUQodJnyo78pNyIuvFf4XQ9jPsi5hEMqI0lclf03KoEp2k/+2aDWvTWVooSzTMZgvnV/rX2EJWcu7wyJhc/WFF+Dun7rB6/ZmWd68PkwGUfH2sDDkp3GeWsx4e9kIi8d3BlmdlmKkS6O73M0ljJyzYPRuLZ1foyFpPQ5bcMV+JnebkQ/dLOq1SLF07XLeWD9SDrNBTruEe0lzhNbWz555WTsBPcDmlOATvIqElANws9nnkqUtR+83gWvf5TRR1Bw9sUrSOrtwBg81T7nUnul07aWPuOUyaOZ9KgSrWevT4KtYRgx5A6OA1MjFDuF0GCPXu4grQo4EJmOWqr/sdZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1tM7xtedj3rxMbV+/0lIKjcYvpFnmyRTr4zeGt7clE=;
 b=hVqpD0ChehOjeR9/f0szof9zBfqRHEwPBM1YSi3dfL7UMMAcQ+EBTqd3BEtNb5ACIw9D5riBBLgjf+PdiABiBwDY+bcY8cGxXatrgdCbrN+gJi8sXRyPB61netbXss7yzFsoGuXHAJlPDmghfyKXVRN6YFxyVwdGCJlU3vI15Wuz6XM1iGifv56VpJtU+dcJooYQVIPE9zr8ykBJLLtpywj7b9C95RGq5aGHotU540jZ180aa9c8mlAG+eiaNV9Gx23AJqmrHehZPZNXGnXkUynsap/3JbodC3+DwgqqP256rpWzJAwBMaCiTirW8TAXYuSSVt+Lp1vx9TWPYryvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1tM7xtedj3rxMbV+/0lIKjcYvpFnmyRTr4zeGt7clE=;
 b=yBdfNQ6bRVlqZP8Zw2sGFT9e8rkcsbzESO8I4jnTRrM2cBq3CecrJ7kcyM7qBTobCkkboRxlWYMQnTWhWKYAIp+1mBlChK3Tdsr4czBkh4JtL3hnTR8SI/GcSdUhBlfgM98gjEYvhh16NQC0lbEHaNrKJ5t5eu1/aBcMuu/b1Tc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH3PR10MB7139.namprd10.prod.outlook.com (2603:10b6:610:127::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:11:47 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:11:47 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, jarkko@kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ima: Add machine keyring reference to IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
Date:   Thu,  2 Nov 2023 13:06:16 -0400
Message-Id: <20231102170617.2403495-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231102170617.2403495-1-eric.snowberg@oracle.com>
References: <20231102170617.2403495-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:510:f::24) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|CH3PR10MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: c09b63e9-5ca3-4147-4b55-08dbdbc6cbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUnrHxoiTCt8Q/cOY+rAzCdKFOy9rAaH8u4dsvKFVpurKjVbemwHo/gdE1n+5J158HyDA2TFz0bGmzMreGc+lzgjzPU1m5UaKzWOJ0wKxcu3PJhFCSotXAE/epbmJ0R+/R8vJoEijkWX2jDWy6HDA3ltV/gmZbCVJcTHmwouW4db0zNRpC7hzMRzLk7sO2eEvsS6Y7t+zxUti8qsDn/sg3JS0vLfgmGIAu80/6JjU0dewfPK39WN0ZH7BknoV6iCPrcSSI7hLlsYMY2DMhVQNRxFZZMMkpxL+yDVOVBik39+//mqIjr9BKeVVAMU6SexHQDAd99+PA3myRC9Jy+siJ4lRYYdhGjKy26b2scnWc2GufXGEvKTjY30o3YXjRZX8M4pCm7SlN5MgD+7wvWJX31drxVJWudp4YJUNEz/sYGpx18iWEgzmN4BydJVvGSQSuPLBZb1cB2rJjuVxPCITdRoNuektyRfR0EFB5CaiEhcCaiumsyh0H0QL1WinxntfCtauAQvPUVptZaKEvhlXF8ATR9p7BBJC6/plHwpKDQpU8q8qb6qpB4Ijiwf+etM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(5660300002)(4326008)(41300700001)(66946007)(66556008)(66476007)(6916009)(316002)(8936002)(44832011)(6486002)(2906002)(478600001)(8676002)(6666004)(6512007)(36756003)(83380400001)(6506007)(1076003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TnYvpZ/GVPJRHvuBT8FjYXMH2Y7u4h7XNc+XnG/QWhuVwhbdhD9zz2FVNWXV?=
 =?us-ascii?Q?XAiaJD35R2l1WChxyWQ8ngC6HWTtV7TX8Ce58yvgdacu2hFDOTqfOC7coYKu?=
 =?us-ascii?Q?YdsmBHgxd5aMr7Zul4Rvpq+vJhGxN022T1h+Pf/ZuFQ7pKWpwvVoYn5/UDLs?=
 =?us-ascii?Q?AGsj8Bkr1ZV/KVj6GvBDGf7QNqC9ALFyEBQJCMxn3PxdI4c3d1OxSQ2liveA?=
 =?us-ascii?Q?Y7u+ym+Ol5BmuEsTq+MImStM8SdcLyv+2MwUMdYSYRhQDVqVEO5vfpeUTfMI?=
 =?us-ascii?Q?Pq/MEXhbpVHuZi3XpiZBabs/p7Nua7ZLe6jorFKFOLM9lqYXt8XkPd5SiztP?=
 =?us-ascii?Q?XlbsnzfSLzI344mUCzKbg5j3tiLBjxl/TdrvGeN9BrzZYB9U8Div68Jc2F3d?=
 =?us-ascii?Q?nUFIGu5qqTzGt/XlDwnxvoSCbmPESzaD2woGpIQ7wDd4gz6smpPV/jm1iMgA?=
 =?us-ascii?Q?73Wm1E8M+IEGsWHxQCUTxRAxNvBNtzQi2IwpwOLmpgM/tumsDJgAfoQ0w5ep?=
 =?us-ascii?Q?PB91epbRse1Av25aOap708KC9zR0E3wrYL18DDGUtCl9U9B+fpDV8kP/77Zd?=
 =?us-ascii?Q?37PNVtNq2UsZ3bv1oEU0XyZgTxnwdH8r7T12H6JRkgXLInnqUx+hytcdZcJd?=
 =?us-ascii?Q?is/C0G1cHTV4ybxddGWtjIr0ysL+rikpXEaT7S0yIviPyEYHVk4nsEIkw50I?=
 =?us-ascii?Q?bOlIfpcim+AQYKiUpHJA111o0mrORVMXXww0L4RLKTsjnJtYy0nfqTDkgrwR?=
 =?us-ascii?Q?gVCYN42Y1MGF/dJfX2/QhvCLO7WPHlFJdvVgUXwHIJEKTPAOIni1PDLkUVMT?=
 =?us-ascii?Q?pyQA6Y6wH9Go6KBsZpuk+EWv8VaHd72UjscStO5vuocr8h6zi5ECv0ZRVhZZ?=
 =?us-ascii?Q?VEZT6zfRb7IJiNQg0scfL0LlA6k+XaiV7RZ38TX4Oh4G+ZIAhD20+nya63iv?=
 =?us-ascii?Q?Rpg0X/X8945Jn4lcBBUqLUqKLtmxv/c505fQ2tOEZFzOosL+yIdoxpkPqMn3?=
 =?us-ascii?Q?wYQ3TNEbUjcNjpQDoEZLcr5wN/aDZhyXXDzg4Cn3b8bifTbx6nQNV7vethuK?=
 =?us-ascii?Q?RpcATRgq6MdMrwbW3+e12FQcv3kkIJjTX5pudShDgQjCbqju3hZg0Giw/i+H?=
 =?us-ascii?Q?qFEU4hBuWd4njgy10/fYEUKmV3TB3ptcuhJ2T3ZEM1Ho8mwmPi7oRRVq7XBQ?=
 =?us-ascii?Q?mQrayD+OMGPovAXsaOp5QM1v295eBD0n0WW3lHD18Hd3x0Lm5QH+KAsQCIzq?=
 =?us-ascii?Q?ZxAeYVkUUs8pnPUx6jRH3gXJdxlAhNlLDODHAIoTLR34naWTGucqGndHV0ya?=
 =?us-ascii?Q?eX+BQVIIb0dL1VUX3EmFyvBnNCpCh00YW+7mhwWddGEZLiE08GL3t82ERf0F?=
 =?us-ascii?Q?ic2JMu2ZSUo3WgxprfsYF5VaPWMHg2Mi+tDQgoTo4uloUgnaayKl2+3lSwun?=
 =?us-ascii?Q?krGOMvAxj/6sb6XP7C5UPAEzlKWx3UmeFKjiCz+jS/df6191VM89F1Nu4cUo?=
 =?us-ascii?Q?K43AP/1cZiTvsiRQCUAAAloq5vItlK6EvW50jsqMRGnhq8YJSNfc5Q+hMqzM?=
 =?us-ascii?Q?L49yR/Lj9+iW6x6fFcL11iZd2SEqN+kQnFJcxY5nwSxpOEGKKU3UafqBr4aP?=
 =?us-ascii?Q?6z5ZN+948h7Etxamlh6jlrw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NXyobZ+B2G5M7nMqQr3G8p1U4C3eVJhb3CpaaLtaZc7V2s2qZx2pyD4AwGMY?=
 =?us-ascii?Q?qIxMjJwv50Z+ZPDI2W0Z6beyVkRWJMqDfxmyMjE6Tmyr4jixg1/zV52IjXx7?=
 =?us-ascii?Q?p8r/M89TyYRxf9eD2fLACLtUjD6JgutwUJBJLkFbdR92lEGWqq14jjgsZ68J?=
 =?us-ascii?Q?Qiz+cz5X41riRcp5K6PX92N8hoJEBR4qKinqsSJF7SDZwNb75wIQqZODEbkm?=
 =?us-ascii?Q?/f3eBg6m6vvEYIfhcTyFR9uX2NFxIzkYGU1YcTTFsf5xyC/9+WKgIbyc9FE9?=
 =?us-ascii?Q?/AF1Uzv65JJwi7Y+R9dSdSpuR7jz1gkAfvYcssS6CPZXf+eDi+XCAwPxnKQZ?=
 =?us-ascii?Q?ySSwHjl07z+gSswhvda33eutZCUn1rLHOcIYMxHsq4SRER5k40wMcIAKk9kU?=
 =?us-ascii?Q?bIODRLrbCwNq3NqQJ6hb8mtzRJ8VipRCzpzY3xzUWwA43hyD9ki0ugk9pWO4?=
 =?us-ascii?Q?KubmKpoB/q19lGN7wfvkYkapVKz/XoMbgF6LGAQl1DJ2+FG7EsubSjNbB1CM?=
 =?us-ascii?Q?cXuIt5QjbEDjRP7NeJr2FSKEpAF8+4qgXP/7z4nINzGj4RqeoV0WbaipyiQa?=
 =?us-ascii?Q?PgALN8SEyJqq1xI5TEpiXEX5OZWXpgvqdnjH/z2TSOpnAnSr76ZADCRY/08O?=
 =?us-ascii?Q?ja8cPlOM+Va4YL5DhJBeVGschmdRjagMxu/B5MU/L7HnoykKHkq6m+v2USLr?=
 =?us-ascii?Q?963QZ7cZmXtmebJl/6S03BtlfkuU+CZcC1xWEKF0ew+NWUr7iRM7mzpcxcrE?=
 =?us-ascii?Q?VCEJfAcNRxSZx7HUQJVf9Tv/boAEiskSNGmg8diDHDkCqUPkNZhVF/jAJQ2l?=
 =?us-ascii?Q?bEj/Y1zwUUIQznSE0GUymJPyzQ8Kz1FGg32XYEFkkVe9RRPSmYrF37q8tand?=
 =?us-ascii?Q?kD082b61xvy3m4BkcwfhuIxIx0HXVkN9CFVGMf2+WmBmAkrOaixdp4fR6/u7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09b63e9-5ca3-4147-4b55-08dbdbc6cbdb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:11:47.5290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cazL35H48cWYuIKHydZQJ76naVMqhz8xUfKw7scLAPB5zz6zpDBfLrppoSp//p/I3xnVlteqqBCJhkDxdOeAQkIASvKAjZee5wvHwgYiGGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020140
X-Proofpoint-ORIG-GUID: uvtmQxg7hSuwa9ykkOC0uGeC2M2A1H5w
X-Proofpoint-GUID: uvtmQxg7hSuwa9ykkOC0uGeC2M2A1H5w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the machine keyring is enabled, it may be used as a trust source
for the .ima keyring.  Add a reference to this in
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/ima/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index a6bd817efc1a..c5dc0fabbc8b 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -243,7 +243,7 @@ config IMA_APPRAISE_MODSIG
 	   to accept such signatures.
 
 config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
-	bool "Permit keys validly signed by a built-in or secondary CA cert (EXPERIMENTAL)"
+	bool "Permit keys validly signed by a built-in, secondary or machine CA cert (EXPERIMENTAL)"
 	depends on SYSTEM_TRUSTED_KEYRING
 	depends on SECONDARY_TRUSTED_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
@@ -251,14 +251,14 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	default n
 	help
 	  Keys may be added to the IMA or IMA blacklist keyrings, if the
-	  key is validly signed by a CA cert in the system built-in or
-	  secondary trusted keyrings. The key must also have the
-	  digitalSignature usage set.
+	  key is validly signed by a CA cert in the system built-in,
+	  machine (if configured), or secondary trusted keyrings. The
+	  key must also have the digitalSignature usage set.
 
 	  Intermediate keys between those the kernel has compiled in and the
 	  IMA keys to be added may be added to the system secondary keyring,
 	  provided they are validly signed by a key already resident in the
-	  built-in or secondary trusted keyrings.
+	  built-in, machine (if configured) or secondary trusted keyrings.
 
 config IMA_BLACKLIST_KEYRING
 	bool "Create IMA machine owner blacklist keyrings (EXPERIMENTAL)"
-- 
2.39.3

