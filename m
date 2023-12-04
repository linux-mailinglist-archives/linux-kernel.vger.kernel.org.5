Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44BF80410E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjLDVlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjLDVlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:41:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77D4C0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:41:47 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4LYPFd009124;
        Mon, 4 Dec 2023 21:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=zoJrff7xV8vbkUUc0v1v6727CH4m7tv5Russzo5ZChk=;
 b=a7tAiuI1dnr2M0biIjBT+skTgO4Bhb1DmTRHYxshCvUTeVT6oX1ns/KHhP6u+Xsq0uwj
 bKlExcwWWZckDk8kDtttxXlr5bJ0RXjSvqMv1P6bOwQtrKSW2X9CZK6Qk4x/eoh/VJkr
 ZO530RFz4sYX4PZqgLMae/R5dDzQanE80WYz3oKkulWC/t7/lh2F7CtflbPG3V/j9jlt
 uvFdw6ivOqktVKajz5DEyRBPLpOpUYGDul2oYFKQXxF4NtJvrfx+Pvq/rRUYbROcTru9
 fvgminEpKwgMTnUy4clGgZVSetqLTSuCWsqWN66S8G04de6qcIysXLk5OR8HhzLveGim Ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usm45gdg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 21:41:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4KWPNM022565;
        Mon, 4 Dec 2023 21:39:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu1cwues-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 21:39:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDB6L7fPzq6KRlXtMEoMNZqcgcEg0uFuLH6L92WmNdqAEggBYUl6ebyD0PDe/ulzNoC0vy3t03HFO40mIMQaqHSsdgkRwvpabmCLLOdbA3QCqxhWFQSwtlET/cZvDV9jXJM0Skhq7HTY0ixZPMACOz/9FcoO8C9ysrcPoEZ1LzYBqZy6ga3+8C/yAJD0QWGcsMNWyNRmdxB4EKT7ECQK2NjU9DNVZUvxiHtSufJf5Zx8pFVg3A8YLg5rCabv6sB+iYP5nXmgklr7xGKSLeRwPz89sJa7BQPQGguuZqhQfj7t9xY12WOdW89SIU9YI9x73pP1piN/eGcetfPUBsfDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoJrff7xV8vbkUUc0v1v6727CH4m7tv5Russzo5ZChk=;
 b=RUE0EUij6buiWBuS3LCMdhkUwebFJG/chWhz6Td6nWQjbIuNcFCPi0F9gdCal7maxgzZg+/UIUYoBYqEYjdEm1W8rolTxablUd4yK99S8Ra34UHoiXmQuFa6M6SLQhQ10gpzenCRRDa7hRCK9OapDiVTlA5i9GNtxh1F1y5UxESuznclO/q0lAykfHo380erGerFYm47QN80D2BZTekMiqPjLBLywDQWCHEHLOfvGIPHij9AjGXY1hqIpkx2F3hTSKDdodix4QVRXEigt3gM521fBENDOOuiSVvMaRqH84SFHXxJfc1EJiujEcVBZLB4gcQTe5Uzhx8GnS4foxsGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoJrff7xV8vbkUUc0v1v6727CH4m7tv5Russzo5ZChk=;
 b=UinBOA72lzRxankAi/Wig+jUdzVH2ZVlB4qF1EKtcfibSXlfuDDM99hUI9rOIq+5b1+WcJEgmYn4MbQnNfApBshZ74+kZwOIDFGpbL7sgumuvBBk5b3RXGmYroLgsYhRQvofKpoBUiWomauqqcXRrIF/qpfFPEqEbfnkNmdkd5A=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB7383.namprd10.prod.outlook.com (2603:10b6:208:43e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:39:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%7]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 21:39:45 +0000
Date:   Mon, 4 Dec 2023 13:39:43 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Steven Price <steven.price@arm.com>, Jann Horn <jannh@google.com>,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: pagewalk: assert write mmap lock only for
 walking the user page tables
Message-ID: <20231204213943.GB4129@monkey>
References: <20231127084645.27017-1-songmuchun@bytedance.com>
 <20231127084645.27017-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127084645.27017-2-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:303:85::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c34da2-8ae3-4842-7da3-08dbf5118881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0fEbT8UjewbXm9F9F/kO3JLs+6uaVyJ580fJfuMnGPcxAItNNaP3pVurGJ9h03peOMAnet9W2mx0iuUIvHPI/YUtoJb5Os1WZuJV/yzLGQerpRmfebPBRn36WD/82mFqoIYh8nVYtqOsn9qS3lYxnvSn+umleWMT1Yg1jcrqAqBAZ+i8Hx0HpGW0BxOpZtpfvLwnkXcpId4zZ2duRP6V3M03TFk0JajFtBFKrMt5mFQlZ7M3gN+dkIl1yukfiyado7rm0csRd2QQHskUaqYtpsUaPnK6nSaxWe02uIjzMjNtxGZJeomW2TRRZ/oi903nSJ7SdBcz02Webdxwm2CDX6+rO9rRjtNF2zMqQWNBnpcgYqzPClsH410/ixAgiS4OTlVNdaNeIrqy1qLGX66UQP7zS2nobCzQ2DsTWLcRGU66wmEHAoWSzxvJsRo17G9NBEAq2kpp/xfgAJ2cLKYMwXSU6xAyP8SW2vrTI+Ckq0ArHwJnmyM4Hg/8kC7n9poTPAuRUSCWCD6sePe3ijK6hdrJFeUNgzYKpdmKiD8RudIxEJr+MXi3NoSMPFk4qzz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(44832011)(86362001)(2906002)(5660300002)(41300700001)(33656002)(33716001)(9686003)(53546011)(1076003)(6506007)(6512007)(26005)(83380400001)(6486002)(478600001)(8936002)(8676002)(38100700002)(4326008)(6916009)(54906003)(66556008)(66476007)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PkUQ6s9oqLH+bMXIYSoTPzSx5384fNycKL/NogrTgFMmCyHPbEncBUH0S8W+?=
 =?us-ascii?Q?dR9FNKfE0eLEYeuMaiP+gjQepO8RnP07M4TgAvn5F2i1FZhzfaMVW3G0Ingg?=
 =?us-ascii?Q?RtXm2OOv3mUZpsAASwrZpuSBNTwI5s7cUuu4cvYrNHI3jqmJu8l8HZdmWM88?=
 =?us-ascii?Q?Q33E+nmk/j952G4b8YcLqI40/smOS/qx+NLil9rwpFp8yzUpR9e9BtMqidew?=
 =?us-ascii?Q?iGwlKiDYWtF1rR/TtVFxrynRyfhURGbvEgC/T0IFqvrnp07JnqqJT9UUuRMG?=
 =?us-ascii?Q?otoKYEGqhhoitDMyKhWoKL7BGWtoDz8a30SRF5Lz89m8ux5/9OvRRJfdxI2Z?=
 =?us-ascii?Q?b/Ae0VB0ba52ujygiFFi84UCILgf/oCrg6sWtZ5D2qq2XNa0dBcQYzEWq259?=
 =?us-ascii?Q?KESvd90muNHjO5zHgoscDCZTcwTMiDFQ5Ijpg1CytblizkIyBtu3AI8Om66B?=
 =?us-ascii?Q?aSWW5OMPa43pgOeON+Mh+UtDvcpiLv0kF9MbT+OM4bSaRwb6V8jRlcVrpDf4?=
 =?us-ascii?Q?g3QcTqi7ZZeoxBhgFIEiQFzXnDo8MxvEtagG8PgQgqiJaUjSfdiUekiJqc5W?=
 =?us-ascii?Q?KEaILceBiWDpT+Yxm7H57ob+6ljjtQLd0JFw89XvLXKSIoMBOFfDdPR5eiVA?=
 =?us-ascii?Q?T6Z9XNbLNCndnuLQYcsQsjba0PGR64XWwqOTLBkg2wWHck0seDuQrwJmwZly?=
 =?us-ascii?Q?J5pPacDzd4Rc0QM8IjLcGV46VSZoyZyVyGmJOdoxz+5gZFKaqHKMDCmz1jRp?=
 =?us-ascii?Q?/B+SNHVwY7QRno7kIakLgNK0EJAgGz4WvffU40ucIKKOcKgzuY0miwFLBdCh?=
 =?us-ascii?Q?vCAAWWg0lInpRx9HTojAUdevCFIMEuMeTgqlldzQargzmR/eiyVb40Jaya68?=
 =?us-ascii?Q?dKo2SBoke6CDbYEeVSEPgGuCI+tGtEm7zS+ryb4RYFBhQc+RCg9BjUQGU6No?=
 =?us-ascii?Q?wq96vjBs2TRCjydBHxl69G1AhXRtckGXXTqsz9051Rzb8jvJx1Bz5jnyARSD?=
 =?us-ascii?Q?aOvg6HVnKRh8dV1z1xxo8Ex7alCZhoDvdaH2DKxecT5dD6Te5T9VbHQ/aFx5?=
 =?us-ascii?Q?7Joo6sMK2spG5JoD68hwGP6SXm2HE6wkIQcRBsNw/jrzGEdRUNtEVgIy6YE5?=
 =?us-ascii?Q?014dPJpoYvJca8DrwN4BvSyk477juzEV6aUDzlYBTIbo92UX7qzy8foA/5Ss?=
 =?us-ascii?Q?wkZqSPjcVlh53ZMTNQF8g77aaRW6ZeEunmiuMRQYRzzflB4HkuiGvocPrV93?=
 =?us-ascii?Q?G2LheLD04ysMCNnE6D9IGlREtKVBBvr3xWPEj7jY+Jw5vxtKvk7549aBulZk?=
 =?us-ascii?Q?uQZ88Kpg9JxEdgOAKeAmkON+gOMmCVwk62vZCRyitHJPNoG3x74+5DYWvzU6?=
 =?us-ascii?Q?YeeS792N4gdTtOjDgnMEypZWCudZZg/7Z5rNVdnqUE+HlyEIW/C71hb9rvlZ?=
 =?us-ascii?Q?YxjRCtDS89yVEwV4McPeiTmxVhvLHwSKZohexUzxHc8iL5gCwSKpBGj9l58+?=
 =?us-ascii?Q?X78maYwawVIUvAB7PWO597auPR7fduQiSLakLts1t+kZiTJ2CSzSAUmYINHc?=
 =?us-ascii?Q?WCdSApqgfPVDYRgUPhbyGShelRFw1DCiZiAM0aswHTzXIjujaETS39Z6ljAn?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cKkARuHPcCUWk5dPyd5rYE/fMWUWk+byCGR1P39jcz+g9au/DWqX5QZZlVII?=
 =?us-ascii?Q?cgDfcOGm94983jaIFAXlugW9RbZh51cHy2Nio6aO+vvTCOzfTx7YdH3zDXQh?=
 =?us-ascii?Q?5cdlDWt2mNXoneI+7VB7ngTE+DkT7y6T+PlRTQEj+EA0cudcRQifsQVMSk5R?=
 =?us-ascii?Q?42zTm3M49d8z8ua5SeB0WB8Tx0+wGSs2z3H2bF821ZoarZd/wv3ZUZ+cstSJ?=
 =?us-ascii?Q?mHlzNCFAslqapYCqmKclWhWiy7uTg5WoFrmx7K2GrdBRkeghuog3CiV04jRp?=
 =?us-ascii?Q?TD1OCZvDWwUOJE/rsS7+A/5ZBB5B9fN3/MC678HSZV6CVypMKWObRZTSu0Lz?=
 =?us-ascii?Q?UqHIj9DZd9PMK/orDIcBZ6tJNoMlN8aemaOivJ7tybKH0oltN6RdCZBJQ+Gr?=
 =?us-ascii?Q?Jd+zqbNRMlWDxik8mX9aRUL0027YpsUU7wKPW5EJe6JP30OefhZzTUAKxdmx?=
 =?us-ascii?Q?rJqSNLpKpX0slx8eTtJRALM74jsqzw23Y43IQzL1CDul/8G01cUXugHce7hu?=
 =?us-ascii?Q?3hVRnScyXaXXs1eHe/185GP89JkH78KtUsgE7t/iBIk2drnIl0799zzf12HS?=
 =?us-ascii?Q?37YRmk/4rGwx+g8n0PIq5nB3CkeirdwQozr6WHOXcc+fXlz51vah8aAtEr3a?=
 =?us-ascii?Q?4Y4WGKPLvQzK/Befo/jU7d28QGTCL/AUm0xZFUAlNH58x26v14SaCSDt8s15?=
 =?us-ascii?Q?eabPujkytUQOdMU3eHMyN8USTiWlcq/vOHJORilVJwZ1jWLLy6DYUqAfLVTy?=
 =?us-ascii?Q?nds+A4BhBbg1379A393uVE3Q++WF/vCEZYUbcu/em5K89ANoYVLCnI3Ay+3z?=
 =?us-ascii?Q?BDw4greAjNYMrZJTylmOfQbYFvLQuN6HUaBku/bTwU2gJLLiUFIo9BSdYKsq?=
 =?us-ascii?Q?I+1dUg/4WIVhR6ljVmjbAYyZvtLXNnIFK56VHxaOC3Y1jMWfljOA5lT2efXl?=
 =?us-ascii?Q?R5mCE0O9zTI7hGkIwx7Gyg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c34da2-8ae3-4842-7da3-08dbf5118881
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:39:45.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdwZ23Q5EhMhYzbh+Q17sE92BZU9aqPFMU2TLvrLj9Yj7yC4dGr5Ha5pPP8XlrIXAZMPtmwDnHukAVVI4o4C9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_19,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040168
X-Proofpoint-ORIG-GUID: YP1wygTI02R8Lx8IUe4rdbS7cIuZUyt0
X-Proofpoint-GUID: YP1wygTI02R8Lx8IUe4rdbS7cIuZUyt0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 16:46, Muchun Song wrote:
> The 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page walker")
> introduces an assertion to walk_page_range_novma() to make all the users
> of page table walker is safe. However, the race only exists for walking the
> user page tables. And it is ridiculous to hold a particular user mmap write
> lock against the changes of the kernel page tables. So only assert at least
> mmap read lock when walking the kernel page tables. And some users matching
> this case could downgrade to a mmap read lock to relief the contention of
> mmap lock of init_mm, it will be nicer in hugetlb (only holding mmap read
> lock) in the next patch.

At first, I did not understand your motivation for this patch.  But, it
makes sense as your next patch will replace hugetlb vmemmap specific walk
routines with walk_page_range_novma.

Directly Cc'ing Steven and Jann in case they have comments.  

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/pagewalk.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

Looks fine to me,
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
