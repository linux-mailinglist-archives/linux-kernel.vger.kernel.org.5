Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FF980F998
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377346AbjLLVlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjLLVlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:41:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEE5AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:41:37 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCK8PxA011222;
        Tue, 12 Dec 2023 21:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=IldGJE6QaZeuhVU0CyBJZRYeqAhNeoGum06VP+OHDCw=;
 b=e/r7P/PSV+mket5YJPXOwXPlfyJjvVJYjKbizzcJOdAF52o8sZTbi7YtrRlx/UNpL4J0
 B/pOb/hBjDwv5R0ARk7X7N4ME+lG2IF/rJX2vOQg3opTuwXkEkSfdbTlnQtUSp9TVLZg
 UnOqIcEYILmVIxGu//ppIXE9vfHOthXydiPq7MF4QCNObZvBbyohqyrkD/hFU4nii5cC
 JNWPClBQZVHEl4WR9aeQLC2Ol3hMqjJEOyLzW1oeNPYwmG+jATwztldNtep3RGjeyPOx
 URF1WZ8s8yfYis1aBk+kqIHD/kBikdWN12L/d8ExI+EPpw2ylACHBjvaekH/ixWCNqNU jA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d6ucn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 21:41:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCLSECA012911;
        Tue, 12 Dec 2023 21:41:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep78xgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 21:41:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XY0v4w8t4CXkVP3w72K8wY1yAio9dzqWYilqBEx70x/qDuu1ayn1vYY7ZRlZ09sZSjtY3NTwdTK9RizP6FjreT1l5qkscgiw9/wK4Qdko4SWq28aTAGcSia6QBilZCWeSDRDBtM0IObu73BPG1Luwk8af/TD6m3r9M23mgOqZjLb3JuHANxLpHEthZ1Dvxjj3WtNwvu+0cDWL/fpGpmAA5KSpqNRcBJ2V1j5vpkzVLCsCwq38Hvoxx0YRj0HC3MAt5UAq36IzDD3XJ7HITJgUC6ApsUf/H9PEj+aIfqAls9TBhwOjB9njjqjYx+JE54jWlsgFY/r701YV6lGYdyJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IldGJE6QaZeuhVU0CyBJZRYeqAhNeoGum06VP+OHDCw=;
 b=YdV9jeoJNjLBHlNMgoplmAVkbvXXgVXZFoTAOnfGBalPtWR0BqrVweCp1PxZNDu4fN9Chk4KhJV4pYLsiYJopkxiKM1ANhy7mH33RqHIAt6Lzib+NX/WdMtTzwwGYQCjvb5Mt2zT2QEio8vd8IkOwRIZV/2jBSgmrHJluQwGYNks8Pi8VE1VAsI2c/i4WZsZiOAxaa+V59Llg48WfzSheaFrdFbjCfrY9yV4ityqQ0Yv7AcIhzKsxa8YlCq2icHHGMihMXZCjilxvZTGiY8IWn4W4j1RD2ShE+z8OhVZ1+uK3CeRUeTrbH7uFjJcifJm5pBdTGQsHg6SosbB/JwxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IldGJE6QaZeuhVU0CyBJZRYeqAhNeoGum06VP+OHDCw=;
 b=JcvCmSKG3oC8isxJ2USpoPwmti5RWJUKuzxRJv0ZjArbQAdmAk0gKBBZv2axDMTgCbLn+hrpqHLnSv6RYuSEMRz9AdVLY34pxoEYTm7lwjTJ8gJSFb/9PkUluUYhmSIza+UEaDXt2PpWAzqZWIbPsxFTzQ6pj/2aL+o7HVZGnV8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6282.namprd10.prod.outlook.com (2603:10b6:510:1a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 21:41:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%7]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 21:41:07 +0000
Date:   Tue, 12 Dec 2023 16:41:04 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, akpm@linux-foundation.org,
        zhangpeng.00@bytedance.com
Subject: Re: [PATCH] maple_tree: do not preallocate nodes for slot stores
Message-ID: <20231212214104.fz7ifu5g76ayl3on@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, akpm@linux-foundation.org,
        zhangpeng.00@bytedance.com
References: <20231212194640.217966-1-sidhartha.kumar@oracle.com>
 <ZXjJTM0pDksnslgo@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXjJTM0pDksnslgo@casper.infradead.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0ac229-894d-46e8-bde0-08dbfb5b0c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+oEDJtV+E66MtgBVdqEIV0tPgXc8fEeLQs+P3tTvngjaq++Gc1v8RqLDFdxST8ohqaY4szWb6N1smNc9nQ5AmOpqg3v7PJmWt4CyLFBh9zUSvIxnNALWiiw/97Ya4PvfpvAGbXV72TBWR2YZHemT/CuAmyuJmnK+0opJvSay4HBO0RIlavLkm9IeGj6G71BFSGuj/PDkDZvXeqjcDoWOW6XSDqleJNYf6UvD2vC7v1qqNycRZoDOgzN+Pcsyuy2Iq4/PSMu3gmjF3zs/O4w0eON387dfzwSZFw9vWiIEBKxV6gcmvZEpL97xTLx+s4O8JBaUH5/Va2tHLG9xheUNBXIVB3+Rbn5cSzvDwRNP0b6qQMMkCAQ6wV1jluN2x6H9pbBc/RGmaLvagDEShsfghFzfvY01pzHOr0Q6llVWCkLlDrk+esK0vSYjcDqVvmRPUqGD+/ZMlIchtHAAC+gAh6vX7Pmxs6p2QyhFukqRGSjCbEURF9f+GcyLO9WtS/ubnMZnzB9GAmg/tjmR4wnYsL1CKmQZ5MTv1ZQfrRYQ4I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(5660300002)(478600001)(38100700002)(86362001)(6486002)(966005)(9686003)(6512007)(1076003)(26005)(6666004)(33716001)(6506007)(6916009)(316002)(41300700001)(8676002)(4326008)(8936002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QfcaR+MWmolWqDixrbgWhiHoHKD/xp1Y9/FgHQAAMstz+LJ8uHacoWQHSGbr?=
 =?us-ascii?Q?RdW2JEhgTXjsTjEse1uXJ35w65AUeU7xvRoSv6wuHFlwuogdKc+4WGC17rhV?=
 =?us-ascii?Q?cOjGHHUClAz0rQ+7TrFU6VRJLMuuxT74jDWUv+2lQzW/RNwkXZGrfXI+fT6O?=
 =?us-ascii?Q?N5MWXi7ODL9sMNXm7ZLw5cMrxV9unBBQjgGePR2vxigbiEg74s0jWes9YgkU?=
 =?us-ascii?Q?12zFL6CqhgiR9PgDoYYD1D+sKpJo5r5cKSKpS+/feHpnG1p16GpQY5M3vtUv?=
 =?us-ascii?Q?uRJ5lgsJMKQowCr+8EW2XLoKzrAhUpZ0z9KECDmspb4CBDDG6pOkqzQgsSCl?=
 =?us-ascii?Q?8DeXCII4PEKJJMDMJre7xfqS4+b4Z+uqktiJ23ooOSyePJ4oIvUioFeEEqcK?=
 =?us-ascii?Q?K7qT/JBaJr74S7M727DEo7I5zxvTblbWq2ri+anCYQKE5il3vi6h0u2B3YRx?=
 =?us-ascii?Q?e2c6osQG6VSXYqU4mXqhgv099vEOCgkJD6FecwHnCUqGI6ve/qFibyfFeuxJ?=
 =?us-ascii?Q?nhxcZCP34sGZYeKov1CJWvO8aabr2Nmb/TN65acUxeim9C+pXiubBQX4kA/5?=
 =?us-ascii?Q?eCXAHjT2DyfY5qgt2Kt5nxYcZUAP+uk5oHELUCjE4s/CvkW/iKGhWkbAQtLx?=
 =?us-ascii?Q?HQeACI66jniQtg5cUqQJOKLhxQNMQ13qjg5q+JnsNSOPR3NmrqkwmWmVBV2W?=
 =?us-ascii?Q?3UZ77xGj841eYu+crOkJRFbVTDvXCcMgB2cPPhoH8cWN30a/c0HpZepKrLw+?=
 =?us-ascii?Q?E3NEJfUSy8V6CbdFEeUAWQbrldADsGW4GcvUI7wcjmNcnc14lfnH0Z1PIeIy?=
 =?us-ascii?Q?KdkBa4C6szlE3UxOn2yTWvnMAVEglKaokTW9FFoOXU9UrhK3FZiVazpKZq3V?=
 =?us-ascii?Q?f3l/De5SKo57Y7fq5jgSXcXXGxUirUFf8tWQQ4Ss2qzqR68iMzt3MLRwW7q4?=
 =?us-ascii?Q?+jS7PuJhTer3xmT/2JbMTLEeUEQ6DSwL1xy5ish6sOehAASQBvxZtj1x2JN2?=
 =?us-ascii?Q?qCAVySriSfMHR+hYX3+tcxckGhgxusCD14s1IphJLriQ9PN9uOvWuLrs+/F9?=
 =?us-ascii?Q?eq6XlFrh1mmAPgf1ykYVU/Tpa/Yo0qn5K2WWCsrxmzlbh0Wm1niTZWEzKeqa?=
 =?us-ascii?Q?P+dEWu0aQqxHEa1hx12+lPunr4l9e643MvrboSfiR6kYCXdc7yo5wpEjJwSu?=
 =?us-ascii?Q?r14NLviduldqp2xKc43rpvInyInMaNWj7KBVu1vzTqevtx9oLWOHVUy5uaaQ?=
 =?us-ascii?Q?AUQpHLQ7RkIUXd0C3gnKe/MaKK1S2k9+3KLUul6ddelPu6gFycsv9IA/hHL9?=
 =?us-ascii?Q?iLeiknDTy9LI+M2ch59kNVwMYgKbY41GqojJdbOy4mCOIKSasNOn+H6DAnx5?=
 =?us-ascii?Q?Aky6PDhD+bvPDoJarDRhI2n1/zF5Iyu28C3wxZByvSieauGllXbbme5wD0Y2?=
 =?us-ascii?Q?8yWylnS6lC4zfHRF3ASlaQWIdM901/0LSKAMk1C+rCp5n/0LyWFze+DjiApZ?=
 =?us-ascii?Q?KczMkuJvMvfsHPDfNet+bUVGG9P4kklTz/tP9eJfDw30usp4JoWNMIb4Okp7?=
 =?us-ascii?Q?BU7cOFiWy9/ZTXysEE/7fbv434XTX2TGSeQGadJ0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KBIbGoofltgIQqP2sf+LAujEnjJt+05FBb0L8P4lV1r0CIrFfVXQYRgejMwm?=
 =?us-ascii?Q?Pk2fzygOgCbIFvw6AV1ubxuzxWry0unvtjBYqxd4NIxrCosOxt9OrRvKVTWA?=
 =?us-ascii?Q?AyBbfp0ofgKprcx3ChLusUkCT/AWNDYmb6FYDMyy4UC8k7oIoIx5oP0kvfa4?=
 =?us-ascii?Q?YL7Yili6T7YnMctkIYkE21guxrEF2p5jryvwo43RuiSkocXHbXaE8h4kSktG?=
 =?us-ascii?Q?sfn0aLT/YbisEUM0AVAwzqjkJ9J5S0fpQOLNWYYKTRpJFlhi084P7D1bEx9C?=
 =?us-ascii?Q?llJHjW3hNWOZuOw0TpVqNJxMzoOS3NZaRc4NP1lEMDHuRy0lMbxit6xwDMPX?=
 =?us-ascii?Q?Zd6TWNIfXfAPJ8gFby78wbd/MstajlBI5gurBjsJl1R3jjZ7pBj6e/K8AEQJ?=
 =?us-ascii?Q?4yGq3yuxcOJCEYKxk/etP978gnzWXLDokDYeGYk9Mm0m0hwi461ivPqWF4vr?=
 =?us-ascii?Q?Rw9L+GQFqZr0maj2GJ2TIzNcPmNSqSs7NfH4BqxHdkPQwung2WGNkkbxqPDP?=
 =?us-ascii?Q?ZJXtt6jSEcQbWOev2YqMXPWSNTyFpQoiuVogeBNcelkectnE8o9td/nGPtfX?=
 =?us-ascii?Q?qH4GCFREKGtAl6EdWsza1gxLiq+34NLiEfg+E5cCy3/aBHflbsTdqyu7CIIM?=
 =?us-ascii?Q?+RE2ObEsFMyz/M9a60G9tokigaOEvX0+P/6uBnBopdSyjtfVwBCd06Igslm5?=
 =?us-ascii?Q?hrZoYs2vlmUwNqvYZ1e54ZwytZWqK7lkS86aieiOj44hs1FgmHfHYVh4fZA8?=
 =?us-ascii?Q?q6P8Q1/oS6Wf6o60uwkhhdLCocopTuQ+X1wzxiShj/aOPfCYR4Gdt7k7o1Q9?=
 =?us-ascii?Q?PeutUdTOiYOEwuo6lMBc3lGkQlAdsDotWvCtNo4E2tFRAaKNFxklV0dsOiPP?=
 =?us-ascii?Q?W4B+FqDuzboYOn/Sys5XcAbGqK0kgqYHyiZgUAY5pIfuqAC01n/+If53LTw7?=
 =?us-ascii?Q?VuLKsH105rWAmhc/ZGg3DnJ8USrBwZMwUlK7J46TYBw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0ac229-894d-46e8-bde0-08dbfb5b0c79
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 21:41:07.4026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndrGssVT4qpg2/4Oq6AZhfutFqHjKETlfiKk+V0eVdrDQZ5mUil3Ea0nIpytgdqt+FTz8CZw24K8w6rClbMrgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6282
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=975 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120168
X-Proofpoint-GUID: g8sRg4pi5S-Mu5AyfaglUdLKe75LHrFL
X-Proofpoint-ORIG-GUID: g8sRg4pi5S-Mu5AyfaglUdLKe75LHrFL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [231212 15:58]:
> On Tue, Dec 12, 2023 at 11:46:40AM -0800, Sidhartha Kumar wrote:
> > +	/* Slot store, does not require additional nodes */
> > +	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree))
> > +		|| (wr_mas.offset_end - mas->offset == 1)))
> > +		return 0;
> 
> Should we refactor this into a mas_is_slot_store() predicate?

I'm not sure it's worth it as some of these are deciding factors on how
the store is executed so I would expect this to live in a single place,
long term.

Although, long-term this could be two store types: slot store rcu and
slot store so that the check only happens once.

> 
> A few coding-style problems with it as it's currently written:
> 
> 1. The indentation on the second line is wrong.  It makes the
> continuation of the condition look like part of the statement.  Use
> extra whitespace to indent.  eg:
> 
> 	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree))
> 			|| (wr_mas.offset_end - mas->offset == 1)))
> 		return 0;
> 
> 2. The operator goes last on the line, not at the beginning of the
> continuation line.  ie:
> 
> 	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree)) ||
> 			(wr_mas.offset_end - mas->offset == 1)))
> 		return 0;
> 
> 3. You don't need parens around the !mt_in_rcu(mas->tree).  There's
> no ambiguity to solve here:
> 
> 	if ((node_size == mas->end) && (!mt_in_rcu(mas->tree) ||
> 			(wr_mas.offset_end - mas->offset == 1)))
> 		return 0;
> 
> But I'd write it as:
> 
> 	if ((node_size == mas->end) &&
> 	    (!mt_in_rcu(mas->tree) || (wr_mas.offset_end - mas->offset == 1)))
> 		return 0;
> 
> because then the whitespace matches how you're supposed to parse the
> condition, and so the next person to read this code will have an easier
> time of it.
> 
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree
