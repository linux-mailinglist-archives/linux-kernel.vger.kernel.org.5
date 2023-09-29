Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AB47B3612
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjI2OxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjI2OxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:53:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D980D6;
        Fri, 29 Sep 2023 07:53:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TEiPYB022551;
        Fri, 29 Sep 2023 14:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=esTx1q/dCUbt/aIZWwQ40ZH6kO8w64Gygm8B4vCyeBA=;
 b=VUhQJVMLMYRXvQRZwfh7pJfzoClfca8uK8iCPAsgHKrMb+DE+erOVSS7Lf5Ui3a1qWh5
 uOMuxDeLAJKmlyJ0cT1STJIkL9pZ9k8+RxJb+Au1aFmJHJPuBgz31PHLxdzzYSzjAxHr
 ICJEb8QshNhyYJ69eCkUMfG5su8EPKU3+VaFGQJ1smWChhbolPGafcwDPc734JG0xrdh
 G0acErDRDxjtsmzF40uIzt9eAtYg6javQpDNfZZiZ29Ik10YtTlXEILirlwYnV7cefbc
 HTyM6X8Hnjs6B8BN/cCTcPAEtppgIBrux9XySrOs7HkfMbfG62kba+uu/ufd4Sh6oplD Nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3xwqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 14:52:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TEUHOP015849;
        Fri, 29 Sep 2023 14:52:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfhemx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 14:52:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt1Pv5GH/B8g9XWPs/Est55cgSi43peUaHXPVLQkT+O0Th71XGJcn6WaxgWC7Z3PFeTHHW8f2kwiRtxhgpaK4C6MfsPd/YLDCzpCYVgfrsuhoyi4DTG1YPVV/BTnvI9jzBnyNYPj5iAb/6mxMko+hewQ55NM/m+PAILazGEx0i5bBOd9/76+SuHGvSgNFStx4WkFufXvVqnKCVXFy2cLHwhBqoHu4j0mjJeHUZfKmVKgUYsNYiMHPmXSJ8ib4ERw/O5QCLENrwkNNY3pZFI+mX79rHYtcEwGDnOtNDk+7i/LD8zgD8KD5+QKtHhGIOdpTlYpeqGEqxPliZpwR+6IXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esTx1q/dCUbt/aIZWwQ40ZH6kO8w64Gygm8B4vCyeBA=;
 b=NKPJMQd+xSvqxVFg/pP4q4X5fBZMlSzt1YwD1yd/ViGM8WOGFQQcBTZmsix+Gb7t8FsUIm1FKPqVOVzPRM9/9eQLFoa1wFq2kPw8Ou9raadRHdsjBORWhxJ2fjBdnaaVZP37xJk4UrZYbKF9ydv3DOnlmB/y42Y8TjWXijYuknV9TgolD/rOr/TRKFWwYGWCrXWPRMjLDD5s9a3VkMrungQ+AIxOG+KIvMvxic7cl/y4yP1Xbb3buqFws22SWPTj+Ip4XLDTwAYWxYqhjU6LQzZqYJ0u3Gp7Kx6yQ1y2FPOH9e+yrwhxHeLCs6pIUNwX/ZvgBaj0u3z0DCaKK1ZNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esTx1q/dCUbt/aIZWwQ40ZH6kO8w64Gygm8B4vCyeBA=;
 b=cidYd+MZjFX6xqy/Yep0KivWwRc48L+ejNep42ql+TPnms73UiJXzlW+CGSuW0WiVIdQ5ojG8ggNbJm82O76Iecp7XovmHFaDrgO+KJUT6h5guYjAQKfdf2YU4IaYyX7jSx0J7nun75+yxqYACV4+lL4aDTlbLCmjsTKX1mV3yo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4632.namprd10.prod.outlook.com (2603:10b6:510:34::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 29 Sep
 2023 14:52:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 14:52:52 +0000
Date:   Fri, 29 Sep 2023 10:52:48 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] mmap: Fix error paths with dup_anon_vma()
Message-ID: <20230929145248.uzrxislyblgxh2j3@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
 <20230927160746.1928098-3-Liam.Howlett@oracle.com>
 <437896e6-c54e-4c5a-f1af-46d91ea6f155@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437896e6-c54e-4c5a-f1af-46d91ea6f155@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a2101a-7bb8-427d-fad9-08dbc0fbc1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDpKYFyWE+UgAzvG8zb7auC+Z1Lyk66kaNqHjNPaqU5eXqgYDuEvAUiwKkj6vYLO7E+Q2TmzHZtgo6f+vVTaPUAQB9UDMNwVqtlDgQMD5UhnmLs7gsl1UQ/fD3wtLylz3j1LJ4GFUbQxBmHxarO6zo+e1JPsMzkNLyYkRLLG1i1PFaYe7ZDo4aDsTNkjHN0MaVVLHcsDQ9SP6ctr8NKUxHQbLaj4gOHV//tn5dd7GjRfiuhf4Z2js+xsEeF7Bj+wPfzGT+Gut2r32ifmlEPD6KEpajhAy5j+DldfBZUxvlrKHPX+xV8exmgTtoysZvv030UIct7mekNmErllkofZ6fwujIbPcRNc6ol8wAfoTahWwW7sbRBuN/fGtfvCtaeHYcVfC6w1t0ftJvk5vMSlz54mD25m4jud2uTfKRW3o3UCg1Ln6U6I87gm2SeOaVlKChPJQ7WNpx2JK7JzzCtaLsntDLCyMwKldHeDRR80jDASZz0GeKc+gSzYIB/V//sPd1WnB5TBqvtGqj7gntlkBqTEUSlhp+3rIw6jlqFBVxfYg7l08zcGglvEsOaxHWhx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(2906002)(33716001)(86362001)(7416002)(4326008)(38100700002)(1076003)(53546011)(6506007)(26005)(83380400001)(8676002)(54906003)(8936002)(6916009)(478600001)(6486002)(6666004)(9686003)(66476007)(6512007)(316002)(66556008)(41300700001)(66946007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fWMD8jkhDFV3WggWtcBEwiCAcOpNRSwVpYqF3hIPSTht/oId6HwiU/jFPNgz?=
 =?us-ascii?Q?9oMEm4kVmwlnwyEVTvBlPWK/qBfaHVWG+e7c7O39RMxnGJhpvw4IuNqRTfzi?=
 =?us-ascii?Q?iERfkkdyNXrhYaKuSlcI0dk+BnwCG9V1jnjytBDV7FUp9K+Ysfo8mak0xDH4?=
 =?us-ascii?Q?6eG6CW6/z2FKd1+A4o0CtJDPz7KEo9BiRIKkxzpHsUqZNe4DoyPe3I8tJjZz?=
 =?us-ascii?Q?nIzCDvWsfVc0lXmK5OvSZj7hwsWKl9psWoH4fli7f6/ni6YKYwkIEtROk+I2?=
 =?us-ascii?Q?DHgdhYXm2avFgxeN1EeZWqHN1Y9dY41UZnoSFJcAtTa3qqB+wjwWKpuMx+oH?=
 =?us-ascii?Q?TDljfLXLNc7jyOyy97iITvFkoByf6mbUAE5oD5UTEF9wckmBOJ91OdM/bqki?=
 =?us-ascii?Q?PhzHlGXGYpA+CSXgFSDLJsCCG3KSKhNA7vqhD0FjxW1EY/c8bM2CgsfLPtA4?=
 =?us-ascii?Q?rt/QbK3FGOgaSvx0ZTV0Wz9mM9oOehWGSnr0Yg73gtZqKiQjUh3QgIkfQswG?=
 =?us-ascii?Q?AAVA86gGCQxDWta0r2oe9QrDVZDDLP+41ZEGxRQlnIf0DAIUw/egKN+kLhfg?=
 =?us-ascii?Q?x/5SLSHbXrSN4/mQviWHklTe1Z8LRqpLNOPi+0GyY2BsxeIU3oe260KPZWIy?=
 =?us-ascii?Q?jCKtcU7NO0MfTirnywrNmLR4vRn7xB5WLIUvu1OlgA1ae3V8YdBbMmQJk60d?=
 =?us-ascii?Q?8ibwnCF2bNYOcB/kqU0d3/5GQrOuzL2lUc3VruC3zLuGxEgl0rjDn3nGvDOS?=
 =?us-ascii?Q?7JKPdRfJ++3vMrBKu9FWNrl0oFV3L4qzWDcqXz55+qt4x6lVwKvdSQ+yR3p5?=
 =?us-ascii?Q?nDSBe0/EG2PAFD5LfLjDZnsOVCmGutfCP3HM+6z9CLR13Q0U8JWeuDK2ijog?=
 =?us-ascii?Q?djBt5Q9Y9hvvRTK86OG7qcdGggIM1TRYbDLKLRsijIRa1FX3iml9sEaspz/a?=
 =?us-ascii?Q?B+1rjY3Mt1/MnXJsa9ZGqetQUCSsgO2niB1vTEzx23NmX0xSVPs1znFPgqSI?=
 =?us-ascii?Q?qnLSt/yVKWN0ufL67FtisrvNfOI6Wq7vHEMqUr8QtiTcw6+yYOyiZcIA1R+I?=
 =?us-ascii?Q?yw2C6iCb43AAVhJfX0ekhS9I+e8WB3HaqL7kkk7b+g24caTBE3zntJsaSPeN?=
 =?us-ascii?Q?sf8oAojEqCfR5JhAfSTvnH1zfssWmjioV2P1D66Vt+SAeAh9uKjOXLs7zl0q?=
 =?us-ascii?Q?e3s3JLqRjdJvzcAGy4FzqlnVrqasMNHsQNvVDtV3u7HjsvA3TbdPZrP2aKyu?=
 =?us-ascii?Q?yIOkGG7kJB6ig26uwkyeiO6ccTQ10Mmo1AbJd/lE9JdwzHWl4/Bq7d+rAUgV?=
 =?us-ascii?Q?dZVgh0e/iVTxJKf1h9qB5L0lq3SkD9dqFQSM3y8CD5oa9RIKlIwOVnpdEd0b?=
 =?us-ascii?Q?uLhjWUksdsxsWFPhGsGbfTVSE9XbM4OtuY/L5ur+HVJooCQGz6P7BLqKvK72?=
 =?us-ascii?Q?6BsrOOEN2m9uQ0/YjHnAw1JMYGVuGowpe0vd8yBKogQ6KoHZrx4O9dbDeN26?=
 =?us-ascii?Q?zFJBs8KMt/52Cnupd/Lw4HyhbJFeH0zu1aPDclOg0A2PXXmX/jQe9L3ElV2B?=
 =?us-ascii?Q?p2P5FTEfRt5DUDruuP1fKWSZO0MDVy2Dz1uvStqX5i/caF0ZQXDpeiyxqic0?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?13ufOV56nn4xraLOrI5WzsIbX8mRB3o6O9B+ZoORvz1HLmVvlsaXtTx3jGx3?=
 =?us-ascii?Q?7DKNvKhPiElBunhOsJd+jWKBRv4ijVvHqmsqwUXFh5PT+u/t9UEybV6+SaRC?=
 =?us-ascii?Q?CM9Iog2SGwCbmeUoXSb6GZcvAR4mS3qNs1Y/uAApQAAiIjajuIycU1O0jZpg?=
 =?us-ascii?Q?42Q5ZRezsku+ZwDKGBP4wXQz4ipse9dZhY5EF5IXc0wHjOLbEBHpH88WzwoU?=
 =?us-ascii?Q?noqyUZdC+vxCjMRpypbukesY51yZ58NUqKgeQpZwc7ZE+fEf9BEAVb5QhFt4?=
 =?us-ascii?Q?XswWG7nKKXmN3uECeyaDxmj7rikzyKR1+OauK7bqX4HFFrfWFWwTqZr43OQI?=
 =?us-ascii?Q?/mUdCCRiWbhf2rUvKZvD41mX8zsSjVqPfifkJFngseR20nVdzfz0hR2NcsXK?=
 =?us-ascii?Q?MvfkQzHh3M//zTN1sZTu0k32H0Q0Xab47+2BjxyTsvn6MThJp1NMXekAenFv?=
 =?us-ascii?Q?yiCiti3cM9561nWAPYwF2QyZLAJVTiucFcxv3zNuEGDIlrY68FOQm0363prb?=
 =?us-ascii?Q?DWH6fjoIk9Ocrr0U2JEF3GnOPZJn/lT52kwclWSHAloZLHgqwZAlNnqp8HJ5?=
 =?us-ascii?Q?KJIb2miE7IW+9q7s4T+R3CkNd2MJUcA8Up1KorUeKZjV4kEgHK/+lCsjAQwu?=
 =?us-ascii?Q?JvvzKHvJPiXTDSJg2/X1Yh3qYMSBFORb3lJ86sdIq8fD3GcCWUhfTHaWtDbC?=
 =?us-ascii?Q?4IWgBwnBSpxjV6EKLUZgj4+jeAqMVhPLb2vMBVmwYYP1PTyrVXEFurzrOzvO?=
 =?us-ascii?Q?CUrV5u5F/L9soQWRYdfWpJ3uwiyPHxvWsGTfFVCXQvh7H/2ILa2ddbO8FWS0?=
 =?us-ascii?Q?VgFY1tJRzs5+LQxR+jhtnb0EVLcuJlyZcRoAfGmtxZiRPi3/SnjaHsRWbbfa?=
 =?us-ascii?Q?Zie2Q9RTdDHmAau3vtbu+vsRgQh3OGB6K/2mJFv/c7Jy+K1lbCidFfWle2N/?=
 =?us-ascii?Q?1PS2Mi7/zuDhpcGj4zJYh6f14mKrlC/NqPvT0da9LCnNqe/P9cTYUYwuUlvx?=
 =?us-ascii?Q?LKcH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a2101a-7bb8-427d-fad9-08dbc0fbc1ce
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 14:52:52.6549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D83vjArnBPcNnzJXbjMxkU+ky3N9gr6qRicPu7P2g95wYcrbfDwOzaJy6xdBXw6wt4ckYYVD0OxEdE/PXiV0+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_13,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=787 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290127
X-Proofpoint-ORIG-GUID: QzTnzszEKITXU5m1ePc7XkCdavhv4Adi
X-Proofpoint-GUID: QzTnzszEKITXU5m1ePc7XkCdavhv4Adi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [230929 06:08]:
> On 9/27/23 18:07, Liam R. Howlett wrote:
> > When the calling function fails after the dup_anon_vma(), the
> > duplication of the anon_vma is not being undone.  Add the necessary
> > unlink_anon_vma() call to the error paths that are missing them.
> > 
> > This issue showed up during inspection of the error path in vma_merge()
> > for an unrelated vma iterator issue.
> > 
> > Users may experience increased memory usage, which may be problematic as
> > the failure would likely be caused by a low memory situation.
> > 
> > Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> > Cc: stable@vger.kernel.org
> > Cc: Jann Horn <jannh@google.com>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/mmap.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index b5bc4ca9bdc4..2f0ee489db8a 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -587,7 +587,7 @@ static inline void vma_complete(struct vma_prepare *vp,
> >   * Returns: 0 on success.
> >   */
> >  static inline int dup_anon_vma(struct vm_area_struct *dst,
> > -			       struct vm_area_struct *src)
> > +		struct vm_area_struct *src, struct vm_area_struct **dup)
> >  {
> >  	/*
> >  	 * Easily overlooked: when mprotect shifts the boundary, make sure the
> > @@ -597,6 +597,7 @@ static inline int dup_anon_vma(struct vm_area_struct *dst,
> >  	if (src->anon_vma && !dst->anon_vma) {
> >  		vma_assert_write_locked(dst);
> >  		dst->anon_vma = src->anon_vma;
> > +		*dup = dst;
> >  		return anon_vma_clone(dst, src);
> 
> So the code is simpler that way and seems current callers are fine, but
> shouldn't we rather only assign *dup if the clone succeeds?

Fair point.  I'll address this in v3.

> 
> >  	}
> >  
> > @@ -624,6 +625,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	       unsigned long start, unsigned long end, pgoff_t pgoff,
> >  	       struct vm_area_struct *next)
> >  {
> > +	struct vm_area_struct *anon_dup = NULL;
> >  	bool remove_next = false;
> >  	struct vma_prepare vp;
> >  
> > @@ -633,7 +635,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  
> >  		remove_next = true;
> >  		vma_start_write(next);
> > -		ret = dup_anon_vma(vma, next);
> > +		ret = dup_anon_vma(vma, next, &anon_dup);
> >  		if (ret)
> >  			return ret;
> >  	}
> > @@ -661,6 +663,8 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	return 0;
> >  
> >  nomem:
> > +	if (anon_dup)
> > +		unlink_anon_vmas(anon_dup);
> >  	return -ENOMEM;
> >  }
> >  
> > @@ -860,6 +864,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  {
> >  	struct vm_area_struct *curr, *next, *res;
> >  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> > +	struct vm_area_struct *anon_dup = NULL;
> >  	struct vma_prepare vp;
> >  	pgoff_t vma_pgoff;
> >  	int err = 0;
> > @@ -927,18 +932,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  		vma_start_write(next);
> >  		remove = next;				/* case 1 */
> >  		vma_end = next->vm_end;
> > -		err = dup_anon_vma(prev, next);
> > +		err = dup_anon_vma(prev, next, &anon_dup);
> >  		if (curr) {				/* case 6 */
> >  			vma_start_write(curr);
> >  			remove = curr;
> >  			remove2 = next;
> >  			if (!next->anon_vma)
> > -				err = dup_anon_vma(prev, curr);
> > +				err = dup_anon_vma(prev, curr, &anon_dup);
> >  		}
> >  	} else if (merge_prev) {			/* case 2 */
> >  		if (curr) {
> >  			vma_start_write(curr);
> > -			err = dup_anon_vma(prev, curr);
> > +			err = dup_anon_vma(prev, curr, &anon_dup);
> >  			if (end == curr->vm_end) {	/* case 7 */
> >  				remove = curr;
> >  			} else {			/* case 5 */
> > @@ -954,7 +959,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  			vma_end = addr;
> >  			adjust = next;
> >  			adj_start = -(prev->vm_end - addr);
> > -			err = dup_anon_vma(next, prev);
> > +			err = dup_anon_vma(next, prev, &anon_dup);
> >  		} else {
> >  			/*
> >  			 * Note that cases 3 and 8 are the ONLY ones where prev
> > @@ -1018,6 +1023,9 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  	return res;
> >  
> >  prealloc_fail:
> > +	if (anon_dup)
> > +		unlink_anon_vmas(anon_dup);
> > +
> >  anon_vma_fail:
> >  	if (merge_prev)
> >  		vma_next(vmi);
> 
