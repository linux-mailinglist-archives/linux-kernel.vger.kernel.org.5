Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B9C7B3A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjI2SbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjI2SbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:31:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535BF19F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:31:19 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TIJFNB018135;
        Fri, 29 Sep 2023 18:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=hJe3qHblJsXBEKNLWuPWb4ai3qycBxBwm7gvqKoRxLg=;
 b=L7JfHgqlUeOmA01+WIdQ/gjNPb58GGmZIg4ZEaAhA/ZqrpwfLNMurelLXD7COOBdQhCT
 +lAsGdIjely+09E321csjjKDNINlj+nbVoIfpJBmCCGDz+JifISAfGOGsAifK7kMcQlX
 4G2qLiwZqAu3y+QGLGq7z0i3d5ncEqxDCMm7gxIa9CdAE8xpDoo0oAWVD+k/WGOKjoMV
 zjGWIn6NPt57af2G+bLszG63lp3t+8mhxZOmmegTUrELR7L6b7BaL63ksVjPOBNdTadg
 E+mfcbov7u0qFYNfXgqRHZJtB3bDV8YgCDWkUWrAqeSWZuj3QRA+/jcshiuN2/Ayp1ri UQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dqh2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 18:30:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38THpMmh040662;
        Fri, 29 Sep 2023 18:30:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfj02kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 18:30:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWqUz+kUhUAXZoOtUPajp5y+yRnKk2mHLKAhWeOfO3BPtm8bz8GnWybP7FcMUrypy0MgvdyN1Ar18+q59MdlDixlnXYERIyjvLo3vlbTMrz2uWEPlYHivFdeOdF35CeCIlaYKVBNakO/FKJ9Z8tldZCO90j2tUnX1HC6kSUaojOawyf6joRlIFyu1JyAbxQVMoeSuQUgx4wrTbEZ7sZD9GpgHYok7gy6bx3ipPP40wTqug74x3311dihoeQd0Tkudh0oqCBFSrM7kaxGuaXDMZ46jXuzoxO2W0SyIiZk5wc3pcWHvvUgTjwtytukZA9sP78jfWV1hhAITWXq0qNEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJe3qHblJsXBEKNLWuPWb4ai3qycBxBwm7gvqKoRxLg=;
 b=gcA7SH3LQxyCytyMrk4Kj6RCWQSKBmK5lB5nnhtGJcRzcfu4A2BRINd98yD4QP+YN6W802CeXiow2vQYmzySuyxtFtKecO/iT5NxUSlDGd2Qkb3DVmr238PavJicycnws1n6db6VT7pPaVKkI9AHljXHYSE5rrIpVQcebKsyY+9GnLaS9GDjZ1UWxBvqXfjXDVoWHgJVNxzJbSOq0xsH4lPAVvQqs0en4zYnKUYc6bmEU7ES2Kundpig/P0diq+8qU7Ws+oVy5y1QDPHJxx3+qCN8d2dq6OSE7s165JyhqXMjkZv5G5YLxulKfdcO/H/ZZAZNNBB8oVU5M+D8K5Xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJe3qHblJsXBEKNLWuPWb4ai3qycBxBwm7gvqKoRxLg=;
 b=sRRfs1Vre89gR6obd+pAmeVEr3SN+V6pKu7BDWJuB/HefsOjmEeHeF5gRCzDxrq7Vn4+B1Ht8VW69YP7X/nBVlksBxlNl4PyBLKkyETRxzUxuT1Szjw3cBW3xq4t+163vRcMOhcYculWMXsE8CQwCRAySO9ReoMPM1jEfUosHp0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB7482.namprd10.prod.outlook.com (2603:10b6:610:18b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.35; Fri, 29 Sep
 2023 18:30:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 18:30:46 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 0/3] Fixes for vma_merge() error path
Date:   Fri, 29 Sep 2023 14:30:38 -0400
Message-Id: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 2778f911-50ca-4dad-1d42-08dbc11a329e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSs5EkwmOUTsOQ3IYWoZqxIdohZbCQAhQpC5rQ27vtEXyKCgtj7GACTSXX82DTfmjAwr1HYv9/kndPv6M4jZ5k/fHp6uuWDFH8PyzzKFI0Hhxe2WeuoCKQ3kYv3WhXIa8JJknETVGiu4yAn/iQuW/nmichpCP+1450+l+KhOmYLJ6dNToEkr8JpybHcdBwPdxcB5sco1OTowBlGDlsJyXK5uOBqOv0dLjBezdHqePkjXiKRm3gtSJeOPYGTtRD8lUBdjpe4HBclwaPKGDEIr8CwJsYSnrtYTa7S60Mc+G5HH9mADEwm7d9HFpTiaziBi4uDt1TOiEYDC4SJtPVB5asw9O5HTBR/DFw9R5jk34zHGX9acdGAwdqsgYd0uiNVM5/am8YLWXo9/LGtrbSh7MFciDp38OTvSp6R4Gv9IlcPKOd6piTVRgP9NErm7bzb5JyYHzGa+qglMaKwhcJmrCsq8Gd8cNRZcO9lQ7vQb+OhOVdqZ0CVHn3CLX2VexzsvSTykZ4kaDU+M4PhF6B0gMCKJuT3TLfM9j4/kcX39ibOmngZtyevvHLAmtw4Cs+ea4rjW0Ttvu0wVkzJe2Dgqv9HUoU0MAARyOWEXa01nlLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(41300700001)(54906003)(316002)(6916009)(66946007)(8676002)(4326008)(8936002)(66476007)(66556008)(5660300002)(83380400001)(6666004)(966005)(478600001)(6506007)(26005)(6512007)(1076003)(107886003)(2616005)(38100700002)(86362001)(36756003)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UwBnTrFy+wSCkdH9AniUGKOni61Yph61yxHDjNTr1o1EI3jD9jOPrhQPKnjD?=
 =?us-ascii?Q?K/H88NLHLFc9kQwW/Mq0zlpZxjx7l6zQCBKztssC/W5dBymZ4RAkEklIH2xN?=
 =?us-ascii?Q?QRLLaL2190K020uQZsvY/3jXE9Z49TyW/hZTi+pTt1frcZW62NJeZP22Mxrl?=
 =?us-ascii?Q?jvtbvEWRh+9Z+/ki5leVTrE9/GCA1DaFpxauvN8Uvz3EJi3SUHrPQEiuy9Ey?=
 =?us-ascii?Q?76VvVZ7xAMOpl7PwXWJlPsZw14DactY9bACP5rsDZjsNFYFD0EgVzSV4ibet?=
 =?us-ascii?Q?vsZHlDZguPt/2KiJQkNkwwABOdRZY1X3oFOZ8Ng/xaoTGxGj8yeS2OWOtsn0?=
 =?us-ascii?Q?BCGkb4+poLJXwUOXwTOcqzVhSVp7JyIS80bPKFhTVeqT0Z7cablmnap3DdKv?=
 =?us-ascii?Q?BpPnSSKO4ZZ8zc6Imojr3rWjNQoyEUSxKPZtzjRF1C75j6NV5NCUKctT5Rc4?=
 =?us-ascii?Q?FodSxB7srXxlIw+amcG4wEUvzE6lr4XbnmePAZQPdKEmLW7KLfWFsKyN+Whk?=
 =?us-ascii?Q?WWgXyxF/VYnH4RKcQaekCTCswBR1fams2fA+BE9IHtvKHmS/doVLiWG4VXIY?=
 =?us-ascii?Q?4b/tgboK0F17rUCsriFLhPupDvrwefMZTa59KnFztB++sFjjAHwVsB++xVJa?=
 =?us-ascii?Q?mdT9mpgYLGQU8XO9wGJJEUydyRitd9Aughs+pHggdISYgHGp1YVavFguzbyR?=
 =?us-ascii?Q?4qsqp8y5VwUVpjkR9LcTMvMgAy4TO2IbnWMbnH1mGYfwMzrfOaglD4DDOnHx?=
 =?us-ascii?Q?xWJWDC4bITDJkU+rNkz7mo10U4EA8brJNEQHfM4UifuEtlBeBBBdYWhEjsqo?=
 =?us-ascii?Q?8vqGEdhzY9D63aJH0wV52vd4CNbFfM/F9bBzCplHe1mpq/vwftsF2MmVLly7?=
 =?us-ascii?Q?WoyntjsCbpGrGb7HfSQfDqXxYkSKnANHcTCM9msmmXm7uD3eg+aXI5im+wez?=
 =?us-ascii?Q?0LsjIbqISibR9Boo6tOj4T7+Bsu54kZakR5skHuA80IiWjknY9uQWn5CYNfc?=
 =?us-ascii?Q?zypPDdMiwywrXV6JeJ95WVyxm0K9QDTdOvL8DmwTrgaxWJWbkLhO2fBTRru2?=
 =?us-ascii?Q?lzTqA5jtqpsP8pxPMhJniSEkCa0M1OCRRwazeUQhEQ6Mpwe9e7RlqVe3LFXL?=
 =?us-ascii?Q?P0+OcZVgqRMcqRMq8vLOKxXsPU37hqtnrrNk4l5HAzKVcDWXlBg2+cZTnf8w?=
 =?us-ascii?Q?cPCNLx8LA/aP+OZhC2SKKrjVBiIru3cmF+2ULsX7ltC731CkMpkzPZr59K2N?=
 =?us-ascii?Q?OrSKbvE7C+rRNL11O+3b/RlyMnESfKQACOXHkMXfHKMFnnBky3VqPj9/TIXJ?=
 =?us-ascii?Q?VSC8WDUp3W1oS18XOhOygvnFTt0kUrqT6VugNa2BpnA4ow+ebXqTeCK+49dC?=
 =?us-ascii?Q?XTco5WHT3oaAdXTm8quj0bv0REc0whE17o+98cNm0w+YnxMglFCH2zvtSbxD?=
 =?us-ascii?Q?sTXL9QxbQR7KgOa3v6tjWWYPMGnZF04TOMJzoWQICKcjw7pwAGtWxBRBIhwf?=
 =?us-ascii?Q?XuUhTduNDMsrM4l4fLL5VXluhBKEVy8Z5ehQRwh2HrkALVQKSxXKecBEfiXJ?=
 =?us-ascii?Q?3eDrYx+eAKUeNhGhaaoy9xx5PQeeqOBNuZ4uAEuQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kjjvoYCjJ9QvcC0nsX4aq9WNCfHvLG549SN/BaKx/wTHvTRn97rqP1EZ0ExV?=
 =?us-ascii?Q?hDbs+zwtIBuAo7fEgsZxYGCarOzBRh99x9dHaIAyc/5CF6nPZMHGO8yXAXkE?=
 =?us-ascii?Q?UGodRmG+qYHSaulqqvoQzFKGK3qYNqDnmoC13ASWbbDAMHS4LKwz5js/QBpj?=
 =?us-ascii?Q?Eb/QkAWk97+1m5glJdiIQWiJNH1uGtCO4rE7WkoiLVt6gI2Qb2jV+BN1adpi?=
 =?us-ascii?Q?cVsUFFe2BbbzuWhEkr8wS5PJeO+4JANZon8eXWeexta1qsNxs9h4fIVmh6bQ?=
 =?us-ascii?Q?VIRuIluFYrgO7qti8tPLbsjIfaohhIja1h/LW6Xm7WGvToSMMaXZ4S6BOyOe?=
 =?us-ascii?Q?03RcOMiSCxnHT1ZWY7vD5kCJ1pyQGBnJpbEoqMmOjM6ITX8bucR3JRWAcbJf?=
 =?us-ascii?Q?1nd/EC0Ou/MM9u1VMieqvtvaR9tIqhRAZV21vaF3XHHyHKovo2cPTVYvEj7P?=
 =?us-ascii?Q?z6dzdXcVmYJkCcOZhw0CE2GqscLb8cbK32OthrUw/qcGydng2UbDwndl0hWk?=
 =?us-ascii?Q?sKWSqd0C1wcOBQGEuLEJZjQOZf0PZU2stcIjPOppLEHyrdeCWDmRITzDbY5P?=
 =?us-ascii?Q?I36ZZz8fSq9uRVpEUoYna6MioGwnX1jkdCg/nMMvBLS0tteK0OvdI07lZrZK?=
 =?us-ascii?Q?udF2CYXees0KxjsledDG2ChjRKHHuDw3JxpLn1FvJRf/RfiYyzsvBv9QakTf?=
 =?us-ascii?Q?zLF+5uWucBXNeQA/D4czHcA2FYIO01r5cIzYIlTGTJ2VJgia/kBbZGNStUlQ?=
 =?us-ascii?Q?1DfSZ4zVltucmL3hPezMYPcErotwdFmkxIFnlk3zPjVzX7IxEnXSplSwGovx?=
 =?us-ascii?Q?ZcbHQq/DwYiNKyCrmjtgphjdBhV+5p2idxbPrfiGTmamSyfM/+rGLTxNp168?=
 =?us-ascii?Q?S3qdK5ImNjUEtE3pe4Ms+l7IX4pGzaN/rt4+Jdr+Q1SdMD92jpCSz0kA1fQo?=
 =?us-ascii?Q?RAQ1jZKQwHDK8qkIvNOUgA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2778f911-50ca-4dad-1d42-08dbc11a329e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:30:46.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnPcC/BbcBY21m3FxsEp+wLldKGxuQmH00vmtykkYr1SUi0ud6A8/7X7xFJ0ugvlTaMj2qDCY94GzgWFisLO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=559 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290160
X-Proofpoint-GUID: GpvI_SnBfxkjuax37aBSHxoDfQNObRhj
X-Proofpoint-ORIG-GUID: GpvI_SnBfxkjuax37aBSHxoDfQNObRhj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn reported a potential vma iterator issue in the failure path of
the vma_merge() code.  After examining the interface, it seemed the best
course of action is to simply add an undo path in the unlikely case of
an error.

On examining the vma iterator issue, another issue was discovered that
would increase the memory usage during failure scenarios, so this is
addressed in patch 2.

Since it is unclear in the code, another patch adds comments to the
vma_merge() function on why dup_anon_vma() is safe in 'case 6'.

Changes since v2:
 - Updated dup_anon_vma() comment to include new argument.
 - Change vma iterator undo to a reset and rewalk to ensure
   vma_iter_config() changes are dropped. - Thanks Vlastimil Babka
 - Update user visible changes in patch 1 again. - Thanks Vlastimil
   Babka
 - Only set the anon_dup vma when the duplication is successful. -
   Thanks Vlastimil Babka

v2: https://lore.kernel.org/linux-mm/20230927160746.1928098-1-Liam.Howlett@oracle.com/
v1: https://lore.kernel.org/linux-mm/20230927160746.1928098-1-Liam.Howlett@oracle.com/

Liam R. Howlett (3):
  mmap: Fix vma_iterator in error path of vma_merge()
  mmap: Fix error paths with dup_anon_vma()
  mmap: Add clarifying comment to vma_merge() code

 mm/mmap.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

-- 
2.40.1

