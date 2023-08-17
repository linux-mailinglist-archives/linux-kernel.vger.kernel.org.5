Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB38277F7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351571AbjHQNnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351578AbjHQNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:42:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAC926BB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:42:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HCOMlX018411;
        Thu, 17 Aug 2023 13:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=a1phzVBTWMJVAnG15oRf+DoL+SEl8nMV3yw9/AEkSi0=;
 b=MjX8s8mtlu1sYyJaPctqjWcv9bHHqZN8fxnOtGjBaDFKUm4CCiMMs8G0NAiLI2xNfsKn
 PDpc5gGh9d+mwnyt8Bj8Az0gem+XfanUFE+HWcj5wXb2tL7f1kUnn/ODTvsUjbGCh5iF
 bruKfaA9nBC+n+cuyR9x8S875NUEK9ZClTCiJ60puQL+4PusJJKkeazc5AUUt8krZXSn
 dJVN8pEVneHufrRNUQ+DMldIx5xXKUm5FKsTctlwF1XqxQEDB5nm3SXsZtdey3oHcnNa
 z2UPAmx586yl0NBS2wUL2BdvyWYHaezaYeqce5prjVouF3YoCoekIpFFRqtQY8/i/cBj jg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfsehw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 13:42:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HCZABb003759;
        Thu, 17 Aug 2023 13:42:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexymmkj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 13:42:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCmi5UOp36wlJ1p+jtJqYkNfywe0UHiXwEZ/B7xgUCnVu/Rh5Ar6pSUvbB1AzCfgRNvbKc2pNoDykWj4+nUe0TNBuMwBSnqLx5zTNZB3QQ0+90uqi/rcbbkvocW50sEjwnJWk6/FLfghqyPwWJ88ClWtUvNEBqq+dc3sANHzjSjcz+pNVyzw8hwuvK4sceghda0X7AtHvIFX71bQPa0hi6rwQ5OEKf/m++jc+bY4mGHtULg3vKG3Aq2hQyN2weeGJgIBHhasIE4w7CCowojR/Qz2g1n/nKn2F5pHQJKsM9LjUX6qJlpF7pxbuv7DBSTl/Qo2wjm9ZSqFZui+2RwuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1phzVBTWMJVAnG15oRf+DoL+SEl8nMV3yw9/AEkSi0=;
 b=nB+e0vz5L3LMxJeWRQpeP3+CTCiUhYd/X+E6+Ook6grILqBChdSiqVeptI858whv9dRNKkbyCfJBHuX9lfDc3QRuYSGdwyTyolKiMz5JmN3/0HOwotI4+fY/OfdzL+H2jFEOeQspvOMmykhpeSKGXE9H9+HL0Rvk1n4Q92hyjTbOVSzzLIEa+ttZG2YSQcNJhlML/ryi3Eb/X0dxMegAxh9efEhj5qC66fZcCPoKj9Y4G3NoJ1S7c9ZKvSXd3ayhEOZ4D2vqe0JmOq2F5uKZtTUuzYnkZDXtQfrtlCPwhZa3WBBFgo5DnUhgJuWDqBeYuZKKdxkPXdS2n03wRD5rXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1phzVBTWMJVAnG15oRf+DoL+SEl8nMV3yw9/AEkSi0=;
 b=NY3iQV7H4Zuf+WmMVqFkmBlxO6dmhd0gwKJkzh6lT8aEoidTlW5Twcb/ti19sBqzGlyb6rEHRFDJtxakUdvoR18ZUjWRoLQ/91gNRiu/4T1VBTVQBzeuF3jdisrplsVp6xLQsq3nj3fay6xWjaBy4x3nIvsqYtrX5RsAbbTCZNY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 13:42:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 13:42:34 +0000
Date:   Thu, 17 Aug 2023 09:42:31 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jann Horn <jannh@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shaohua Li <shaohua.li@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [mm] VMA merging behavior wrt anon_vma has been slightly broken
 since Linux 3.0 (in a non-dangerous way)
Message-ID: <20230817134231.xji3i6w7ev3rbs52@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shaohua Li <shaohua.li@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <CAG48ez1KYR9pY1s0=9QH_n5cY-_Zejajj2JEa-se=UZQbeN4hw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAG48ez1KYR9pY1s0=9QH_n5cY-_Zejajj2JEa-se=UZQbeN4hw@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: c1067c35-fef1-433e-c469-08db9f27cfca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7zYz/NbigczI5AKDLZ/aMJLnQ8HkY5MHIDFPsXIEGcN/dOYHgNXZo8VBBnT8eLY5mpUi2mFKFHqaE52HIEUOsZUi7qvYLD1IPKvJOFMEjQdkF6bBFZSSa3e5eAG2f7dID85haR9LaFDzBbPMTUIIy6Mj3UDwHeHS5K+JFj1kbmpB4Q2l+lyQGCslOB3L0o80fDIwQovl8zpxynBR9scsdWJOrjpSsMiMbOiBh2ngFMpu5GOevueeaEh4WCu+AOZQL4oXE5qRkSG3GKFKw4y10AMQso4uw3Vs3RkpJ319K3tALUk+3bkN6FuZ6W9WNSW+RaQ4Zium4ql6YngODbZ4gZw4MG2NExT29XL5fqqK2gR7w3diF1sliNngvv22+82S0PjfTHsbnzpZQ8a1sAFBqSHBqxVlw44ACNmjcma8TPjQo6gFZy1yP93Dz7IP/hCllmh0AI3y94rZovDo0W/HL1OmlvWzrtLWIuPlq3mKXJDwY/3GLdudhW0EuliSwqv1NFOW1pJ1smCPjqW/k8BaFSNwtiTrpeNgromegq5A1jBEugEFmz2CeNAeiSxrUgc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(33716001)(86362001)(83380400001)(5660300002)(8936002)(8676002)(4326008)(2906002)(41300700001)(1076003)(26005)(6486002)(6666004)(6506007)(6512007)(9686003)(478600001)(66556008)(66476007)(54906003)(6916009)(316002)(66946007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4bVInnbqztWEr0fPvyvCREnhiIUXr2tgZ2S3RMgym2/oLBluLKkkru2KFRfK?=
 =?us-ascii?Q?TqlplCqbdhkMAWJeJgM4/BDSok3yqtA39kpj8AUGMcgeloe2rQJqeTCoCOHU?=
 =?us-ascii?Q?2oBWA9aTwLs1xFTQ/kWAm6vWsELQY9b+sS4zwuWj318MM3GLbfInzzVSeH2U?=
 =?us-ascii?Q?Z6Ah8eqel3XWW6lYr4Lv8a7i9HOr4aYsX/cDrY5NCq7diJfvcogVmbTt77G4?=
 =?us-ascii?Q?dlyRtUdBKOlxNdaRq3DQ3N0Dcj90EvylDYRlUa0xscT13qTdJkyA4XAAwabo?=
 =?us-ascii?Q?QFqp7ykcQRPzNdABn9EzQwvZmdd+p35s+QfSW1l/O1723HWI6jU51+Ui//DZ?=
 =?us-ascii?Q?lMPbVcgOHhtUSAzSKRae5/WF9KLZQ/n2zd2/nSIU2N21ks886vriME0zH2X9?=
 =?us-ascii?Q?Nf7qtXy/eJqAH1XvraG7SMOj5Xe12LAV+CcNBRbxYy9thIyErKv+bYTXVGG7?=
 =?us-ascii?Q?B4xL5+XuNl09YHfxTLvq0kYYSjmqplXK4RgikUAT8EjkWrRhSz/ShwcJTSFl?=
 =?us-ascii?Q?Lrdy7GVUJ5+x0mUfCbKyBkS+lhl2+WYK1w2Pkrg6ZwGGquMuFwmb5N3HIfS7?=
 =?us-ascii?Q?TOOo7n+tfFt3ctT6PE7ftT0U6fTxnLh91XXc5DpUmhwUC2MxjEwoLTozG8bp?=
 =?us-ascii?Q?tHjuoq4sOhj9J9s4My6qufQ35hhnD004AY82SdrZT+vFc/GWk7vfoGL1L0xf?=
 =?us-ascii?Q?lvZZflvNtEvpWZULyFBCZ9/2SkWnCVD1SxswkPvS+Wc8uxF7D/s5XcXWyNDO?=
 =?us-ascii?Q?NF8cHTZBesYpUc3QfRu/T/0VdgvVu7Thw5YWIEriO9hRAhhlqvO6bZarBKe7?=
 =?us-ascii?Q?f0lt5ryyPgxu7Lj3fdcdjjb7nDKwGl0Cphe//0iI2XJ36J8Vb/4xTHhsKzxT?=
 =?us-ascii?Q?abko2YbzgbqUeX7EKBH7A0k2gR42VEeHZM8jpRFMFj5qdGsx3497BXkSfgZ9?=
 =?us-ascii?Q?5tJeRDZelT3+9eNJL77YkSwg1PqwCDEkwygFTOgwLeVadAIzJz42ltSU7kaT?=
 =?us-ascii?Q?1BoXoc2xmBEXdEhN9JWpul6RaJJjtwIZf8Zifu1bhzEEduwKUYWqfluqVbC1?=
 =?us-ascii?Q?pzRpY63FkFHyq9TcZRQJ5v7ALlLUYgacNwdxrjd2O6UK96ITEd5wRvcxN+sm?=
 =?us-ascii?Q?Vns3ybowP22TNksem3LhJJL4Fle1MTQ3BBilOhqBEOLEcHK+IPmPgRFRZmpg?=
 =?us-ascii?Q?QFbozSnA59pFHXeKtmxVkLGTnzv+Jd6zmUcySwCuCuiZ2lYEZsbalNMn5mcH?=
 =?us-ascii?Q?+dHJE9gENIZGh8Vq1dpvO1GzanGivXBIJZ+B8SjV6Fss4r+HEu3XMQ3VcDV+?=
 =?us-ascii?Q?A7wAY8p9dXPwU9CMu99293DKTE6+G9yb4GnsYFUUy5c8yrQX+85QFGJjjnJF?=
 =?us-ascii?Q?ZYPXTbrY+kiwHLERvdVqvOCknA/4ftzvgc2pXz7OuDC2hZ8e0LeMNk3Kpw44?=
 =?us-ascii?Q?HgpgOCv7lsJmsDv0NJbf1UCcddDkpVzA8eD9pPb+rsGFnbfzjircOSKcgup0?=
 =?us-ascii?Q?QCJM9qy4oWKv0kOijiYFS6cinMZiy85UYXfSLVzlAJPRRns3t9W1v56gDcNF?=
 =?us-ascii?Q?0z7ZoVRdRf6ufx6Miq/yVNRlTvaKpbZNOX83a2jv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ItoWrFzFs+TdgRYryEpI7n+++KeYm5iWCKX0xgmJEhOXbgS4I4qPnhgP4WNm?=
 =?us-ascii?Q?IHRCZmhaUyQDscRhAvxr/LvbhLZ6AD94+A/AmpXUOcTSac8rCXNbmCsogsB9?=
 =?us-ascii?Q?rsa3bhoazpcrYvi5KjnMDYhN5CX9E0Bgmt5s5AlKsEQuHBbAmoMqCEI0BlJD?=
 =?us-ascii?Q?7U+3DPEz8aWOzy5jHgfDNiKgdtPUDbHwiKeyS1NOWrlsxShv2LSL6i0ONghK?=
 =?us-ascii?Q?UsGxPt+MAS3mEi/vykUw3szi8fqzA2yqAwo99cXzgOfFMG1vp2OzIF+rSGEV?=
 =?us-ascii?Q?WsvwbDNuvpQtgj/BLRy7eVlkPlJdxaqJwimRYCD9OXWAIRWXm0duOwTgVvev?=
 =?us-ascii?Q?uoHrgc/NlBn95aI4sU9CFNxnVnqb17dliEYSgKFX8WzBrz2tRbd9DpiftyCA?=
 =?us-ascii?Q?lNgWtBZqq5EgoUOE3uGNBerm8NT4og3IFoW/KoDA8yr/YAT9PjZMiAv/MXLv?=
 =?us-ascii?Q?Ykqlydq2EKwmnd+RPC0PpCZCHY+o1nrbClvd0Aa91i+Hvu1sfPd0ULS9Ewqw?=
 =?us-ascii?Q?pwaqvV6cftRHunAYmQY8YnXSWnAAeB16QXsf+mRtCOEtg4BEHp7SOR7WVW1H?=
 =?us-ascii?Q?SPXua3ilTESalv59+Y1eXa6YN8TfxyqYlrUVRVTe0Nx1IWEC4fvCpzHOeEet?=
 =?us-ascii?Q?YO5gedLYHE+RmMN/w7HyKczFVMHkIkovZ/hoQtJdVfYhuZ+x7yp7lF5uSbmn?=
 =?us-ascii?Q?r3OTH3pomP/GWCn4r8oRbPvzeLuZAU/H513OKVI5Ldt8wac2JxtQxc8ocgD1?=
 =?us-ascii?Q?X/nHyQeM7sUn5T6MZxCfqg5I5cZxk6NF3I2KFQJzTq67cmfpGwjmPmiMwUoa?=
 =?us-ascii?Q?fFzOrpjjXKVhLaYjUY99NpwDW4VQiCTBJCMyHvx/e/QzsApVbTW4TyXK+eH+?=
 =?us-ascii?Q?sb4M5BYbYyWGExtyfvHL6bNC+S45xWmDMFuk1ZqfhqyGdQ5scgkIG4I/Ye/u?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1067c35-fef1-433e-c469-08db9f27cfca
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:42:34.4002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfkvElHvtcrWetM3qNfOvB/n7DRiPXMUKetnCVt+DWli9uSo0fxWOSdnx8N+i9kXqYKkXU+L+Hm9yj/JT3J06g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_07,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170123
X-Proofpoint-ORIG-GUID: yNSCxFn4Syt_PS2EOiHAxuj3EInaPWrY
X-Proofpoint-GUID: yNSCxFn4Syt_PS2EOiHAxuj3EInaPWrY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jann Horn <jannh@google.com> [230815 15:44]:
> Hi!
>=20
> I think VMA merging was accidentally nerfed a bit by commit
> 965f55dea0e3 ("mmap: avoid merging cloned VMAs"), which landed in
> Linux 3.0 - essentially, that commit makes it impossible to merge a
> VMA with an anon_vma into an adjacent VMA that does not have an
> anon_vma. (But the other direction works.)
>=20
>=20
> is_mergeable_anon_vma() is defined as:
>=20
> ```
> static inline bool is_mergeable_anon_vma(struct anon_vma *anon_vma1,
>                  struct anon_vma *anon_vma2, struct vm_area_struct *vma)
> {
>         /*
>          * The list_is_singular() test is to avoid merging VMA cloned fro=
m
>          * parents. This can improve scalability caused by anon_vma lock.
>          */
>         if ((!anon_vma1 || !anon_vma2) && (!vma ||
>                 list_is_singular(&vma->anon_vma_chain)))
>                 return true;
>         return anon_vma1 =3D=3D anon_vma2;
> }
> ```
>=20
> If this function is called with a non-NULL vma pointer (which is
> almost always the case, except when checking for whether it's possible
> to merge in both directions at the same time),

You are talking about case 1 & 6 here?  To get here merge_prev and
merge_next must be set.. which means can_vma_merge_after() and
can_vma_merge_before() must succeed.. which means
is_mergeable_anon_vma() returned true with both prev and next being
passed through as "vma".  So, I think, even that case suffers the same
issue?

That is, we won't have merge_prev =3D=3D true if prev has an empty
anon_vma_chain.  The same is true for merge_next.

>and one of the two
> anon_vmas is non-NULL, this returns
> list_is_singular(&vma->anon_vma_chain). I believe that
> list_is_singular() call is supposed to check whether the
> anon_vma_chain contains *more than one* element, but it actually also
> fails if the anon_vma_chain contains zero elements.
>=20
> This means that the dup_anon_vma() calls in vma_merge() are
> effectively all no-ops because they are never called with a target
> that does not have an anon_vma and a source that has an anon_vma.
>=20
> I think this is unintentional - though I guess this unintentional
> refusal to merge VMAs this way also lowers the complexity of what can
> happen in the VMA merging logic. So I think the right fix here is to
> make this kind of merging possible again by changing
> "list_is_singular(&vma->anon_vma_chain)" to
> "list_empty(&vma->anon_vma_chain) ||
> list_is_singular(&vma->anon_vma_chain)", but my security hat makes me
> say that I'd also be happy if the unintentional breakage stayed this
> way it is now.

The commit message for the offending change says
find_mergeable_anon_vma() already considers merging these, so it may not
be as nerfed as it looks?

From what I understand the merging is an optimisation and, from the
commit message,  the change was to increase scalability, so this shifts
to using more memory to gain scalability on the anon_vma lock.  Making
this change will shift back to (maybe?) less memory for more pressure on
that lock then?  I am hesitant to suggest un-nerfing it, but it
shouldn't be left as it is since the code is unclear on what is
happening.

Thanks,
Liam

