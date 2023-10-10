Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7DC7C0338
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjJJSQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJSQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:16:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A4F94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:16:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AI5UYH001223;
        Tue, 10 Oct 2023 18:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=7zirVj08cmZXZdZWJuGdQrT6jUBD0FFvtwoZIfYxGNY=;
 b=xjLNVUCfdBYk090C/N/cNPzmc6iR6ieR3Wy8tl+T4QHTwIWTIMYMsKPpSmUlPyB9fha9
 ndCjePRulfqlX9mDIbvdySOEBriO6eufdX0PX/0AJ6EP8Mh14Aqn5X2btKM5eocldWTm
 qRywF7q0mkLJvtOlIPbOjjitS9WXXntsaj+YKuPtkp+arwzENkSnlMREmCQ7yu8n3GZ1
 NfkedigiIx5W8T8eMrI/E2XtdH8gTQkp+CoNKvrusUWzGMu8Q6uPJLTvFMtaK60ZP+6c
 23px2a/AHm4QifUJehYD08o6Z/YH9Ai3kVlh8csXQwJLtjzz3uApAm7mMI8hDLiSTYJd Tw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx25wye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 18:16:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39AHaPAX014841;
        Tue, 10 Oct 2023 18:16:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws7ayut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 18:16:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXpQyZpXEMBXwMCMLL42VFsee0Jho8ohPrNNr3+KonLxbd4IW/Qq2Relu+XgAwyc0Tb5qhd5dpOh9J8thkUgSH/fTWnpN3smRY7vjJIihxV8G7rDDjFrdtwS4cFDOq9bCwdxpN+hzuioc01koumTZVrmFR5GEwacAtC9FcRruYmW/VensXoTeR57GolH74QN65wpu2tAZ5gki6G73LLNUUo6RLJQWdSjfJeyx7kipZYDI4Y0rPuI3qNM4mRVWkhD/l9MEj2/pD0dDeDOrlhOUp6RkBLv8gqs0muod2+pnSniNF5z77jHnaGpG+BRZK6Ennvg+J+EkWCURVVhVj7Zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zirVj08cmZXZdZWJuGdQrT6jUBD0FFvtwoZIfYxGNY=;
 b=gWLoMzn8DFQMd/8b4wZ4tPJoMMqSe8CUoAqRG1mkQr9KIXQ+sS3j1NEPNp7lihbuk1L0z0h//91bYUJqdj0V8Dhx1DrEBqd2OncuzJ+fJzaWorZd5tpsvewqS51LSww/9Fxu7SnC2D3NRhqunfYYoT9qlZ3BX2AE8508Nfv0RJFPDKfACfqwo0QLShzTWzsW/rnD59kyJVsB7HV+0FIY4k+YzVvxGKrOZVw8wnk1H8dQT6hnKGMhvki/yJ/SXKeUbCGbhbsKa/wFdv23dFk+mCrFnFleNyu5THuwv65esYIn6Wc/EMwqChQ4NRo+4e6GXwwWs18EqgGj33OzbscBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zirVj08cmZXZdZWJuGdQrT6jUBD0FFvtwoZIfYxGNY=;
 b=vj6iWSv7xBS9LwjktqI/Dg0DjXvslO0iaRVxODDQVYnLcvjkZ+A/nwYjK7vVKcM9pnMMc8aBkNHe5X/tACypBb8nSVKhRG5BwjjnTDevKxWWKVoBE5+GvrDCxrUldWIAstdeLxz2LyBxFmyncw5XsslIO1ZLyS4jTFsTcJJFm4s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7420.namprd10.prod.outlook.com (2603:10b6:208:447::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 18:16:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 18:16:00 +0000
Date:   Tue, 10 Oct 2023 14:15:58 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, akpm@linux-foundation.org,
        willy@infradead.org, zhangpeng.00@bytedance.com
Subject: Re: [PATCH 2/3] maple_tree: use preallocations in mas_store_gfp()
Message-ID: <20231010181558.2xebit6nsu3lqk2m@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, akpm@linux-foundation.org,
        willy@infradead.org, zhangpeng.00@bytedance.com
References: <20231009201639.920512-1-sidhartha.kumar@oracle.com>
 <20231009201639.920512-3-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009201639.920512-3-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BN9PR03CA0382.namprd03.prod.outlook.com
 (2603:10b6:408:f7::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c112db-2df6-41df-7393-08dbc9bcf4f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2w5gm7JWRBAiMNBJ81BNC9rHpRuYPqENtBvzBdd2saqQxTX9d8fdrg8f8DKPLhPGIpxtTKma2tBbwSEq34Sj1Rt3TRgiBZHSWbvoKqdjdCHv7tFg9h3qa8m//Deh/PdRbuOamObiYEwsDVgGsxw+SdcNN+m9B5AFW3/co5g34aa4HSr/cAarHtbhY9xbS/S407Imu/bWfWknXnl+Q6RfOTbwMsiy0NqQ0zRr18Bzk9KNA63V8d6DGHapZkDZFtE83Qe6C+Cc/diRskQbnx31WTNUtHw0JTvJJg3JyU0x2nb3j4lt26m8bxiFQbcOUwU7OAIoqRIkkXqMWjNiag6J8PSdISyNXnb7R2GBBSLRXpAo7aXw+W3G8S7k6VJPX+0p6HMZpZFyqOqxU3VC3Cp27wfBL6TfCousFAXsDZo8PaJzPfkCQ+62OyFxhr9UF5W+b0UdvprV4lDLFbDxkQvRav2+GBGe/5xRACoCyi/hscR+/2z0Omq8Fvjvf5w+fxPOA0LWvbzo7PMzh9MNim4by4NYeg1L7sxnOtmMtucspImzhdaVXnjVUv4rEPPntB9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66556008)(1076003)(83380400001)(6636002)(26005)(66946007)(66476007)(316002)(8676002)(41300700001)(8936002)(478600001)(5660300002)(6512007)(6486002)(4326008)(6506007)(6862004)(2906002)(9686003)(33716001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tzOuNqu8fOTlyKgdi4TNwM6870EiUOwkl/OgsMd0DPqP5yaz1RlFbC8eWXlM?=
 =?us-ascii?Q?3XLehfmNJFo7/pilbgmz/pFPIZTwj4NWtoW2GZi36rHLT5Z+/pOBLRwtBQ26?=
 =?us-ascii?Q?db1AH2V7Miszvu1KS/Zoj99ete3rIWYJdPwM3Y94p/PjKaY+vwUBVtHfXgEY?=
 =?us-ascii?Q?ze9C0pWFH2edkNjMIFZqcrzz+mwQr7U06ByFIMlnjRrte5bHQNF9rI2C9YZ6?=
 =?us-ascii?Q?B6XX9Uc2N8JYMq0n5zzqHApCM9pIxTXaeAewQomAQGSDF6NlV78Q/O4VAVcR?=
 =?us-ascii?Q?Wdu0mQqBtzkYop2z1CLHOOsVcEHon+EGO5H8rbClvWo1tqhe1U+20IYEcOvM?=
 =?us-ascii?Q?zfjQq8Vtx3Cx0wqKqeVhFipX0sToKclLgm+oI6Fp/jzr5kKH0G+4h2NaEoKU?=
 =?us-ascii?Q?92mK0KJIMmH8lWYZHJR9DzJhSBPifIcSsyVETG6lj/3cSFCOQ7mFHIMyOx5z?=
 =?us-ascii?Q?9GfLkYDw/KXQe9hmz6JtOWlM4ma/YM+z2KNK3RTi91CSlyaODjIDYoVbH3oN?=
 =?us-ascii?Q?pxLSP+HILrstVpnd6oh8uTEKsMCcBFTvFd5pvD2hyenA4mWzAuEHeTx3F/Oo?=
 =?us-ascii?Q?PMoOJ4o+OWFirS73Yq6sbMbNMjNC+SghFGOH9cTTJ8U8Shtb3NT+R7o1UwDo?=
 =?us-ascii?Q?BmvQJgkV0J45WuWvcZja9hyMKSkJmuBayXsQTv3Ck6NR0DxEkmqdNE3tZeCb?=
 =?us-ascii?Q?it5TRGLR80zlP2iREs1rBplMcfxjDgQJk9Dee8cBc0Nnw0JA4TsVxF+BUbxZ?=
 =?us-ascii?Q?VKhdL2B0QDcUEY4Itu58R5V5x5h3/d3UTUePozTeuKuzVuzS2xvPhYIKajbv?=
 =?us-ascii?Q?q6vv+yv1+ioKfAKkod+tv8wwt68siPo1K9bdPkvf/zQqucVtCbz0uU5a/erh?=
 =?us-ascii?Q?ErUKsb2mPJUPohe2o3sPP9SdWTPfIUPYOnqC/QnExmPhdjXfrGIwTVR+1CMg?=
 =?us-ascii?Q?Kj0Bsr7bSBWEA4g8RXNkSYAwXJk9XSffHm9bK7YM8Lc/PTMCG5L1SLoKw2sc?=
 =?us-ascii?Q?zfzMWb/+9AFl12J8D/WyguuGIab6ylbXvNUl9okjLuG/u9WZLXgTMVQ6m5Ih?=
 =?us-ascii?Q?0VxZCxTtKKdjjujOSNleYzY0Bzdh0HqUHvqg0Hykjusi9yB5FY7mCQ0ahJeD?=
 =?us-ascii?Q?5rWD0oksRz1fHqHjEXQosnQLHsJBkshAzhbQiEoQvVQFxLtHrnHrTk5Sg/lz?=
 =?us-ascii?Q?LVcqjSgVLqDBKR5c0Ce6codlnwJOYM0MfF5C0z93vH0nydtvbUgwb6jkW9jB?=
 =?us-ascii?Q?3OXiD/0BQlFCyHmMWUIbvOPhhBqUjELBF1pu9VlPT4hNBigCLYEp0AZQB1kz?=
 =?us-ascii?Q?gd9nWagDaWOEFHStPmLsdekDml7hp9g8s9e03xDpap/SpmVnKGi5oNEwsxJY?=
 =?us-ascii?Q?vA1Ffe9N6BqwyGRHikED8euJMr7+0QZF2yQs1RM9mYze5bLmnTY7Ge+5OgfQ?=
 =?us-ascii?Q?p+w1vR0xI9vUtf9+jNvTXeysb3eFCzt4QZwNcdzJbEYit4Lb0WdAj0V2t+l7?=
 =?us-ascii?Q?1iGkqugUBq0LnMQBrxn2iYYfZMMEn3r3O/nCl7PHZAdRiD6/EihJW5v+4NW6?=
 =?us-ascii?Q?+UJ88QVWAr3TkM1udN0ug13aQCL/AUTxmGwvEOE7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4qTvKtC7ua29CgRASyw4dUk1PdCbvhjrDUFXGsw29R/TdJDv4GKPHOQTBPS2?=
 =?us-ascii?Q?BPSl/yGysm/RUiMyW7wMmpjSTcRQ6cpSgFxUKBUJ2HYNhM4ODend629MkEsw?=
 =?us-ascii?Q?c9eABA/WlVLmchzOazL0qM/+AhaIg324A5mT6IzyjJ/meaD3gyAXTbZs0R+a?=
 =?us-ascii?Q?e4eizOXj1zocptuN2Ud4Jv+PPt8dJ/ewEt/wPpjxii39imEYOq7w3xwis6x8?=
 =?us-ascii?Q?8eIxwrVINH4Kb+VgB2hgykWsh5eTBuKH88v6cPLxqlgI9LNgjmpnBQaAxeT5?=
 =?us-ascii?Q?KTt9Oa9UMbqiU1CZDU+79umoUjmhy7fY6h6RklqBzs8bnmR3YMJMYAEwclKG?=
 =?us-ascii?Q?6JRHhpRfcDQsdeWAhu1PM1iv5lAgLAV1xsPz40Uf+fck5U3YSgLcxU/r0yfP?=
 =?us-ascii?Q?xhJpJJWLmMl/u7q0f22MVuWKTrt8YB3kXiscRGHSSKPNp3JBfFO0j8IHtWkz?=
 =?us-ascii?Q?t5TeeH4Vuiq1pI/5VkphOlQyUhpQJ9SUoSo6qFcpk0OBlw9PSVitQrv27CpD?=
 =?us-ascii?Q?uM4GJSsJYpIKqu9+NzpWamz0tNhgGpa8DBxttioMnKXu8Fc48EZdlrbjbsiv?=
 =?us-ascii?Q?zDVaWKI+2CfX/mc12KFXFVXaiOqbbj/UPD/G2EzajlRnYvWvZfKikzvjHPDc?=
 =?us-ascii?Q?UPZaaLgm8ZYlagT9O2ID5ds/Vk/evfSGQjukyvOEZ+nNxI0O/RzqiV6XQL8W?=
 =?us-ascii?Q?X5U4nEaf9NrkS7wp/+QRB1ZF/ox4OyU1UbfsP4kMkWj9f9SnoZgNj4eh6lXQ?=
 =?us-ascii?Q?VNMys55ckJ5ONVVA/EQknd5qcIOD8eGUclOlKw1JeKDePXtDq+1WeDv/xoCZ?=
 =?us-ascii?Q?jA/+RhtICdaLlhdHyhmZ63yxMgf2jsQ3ACljfBcWeUSKrGyIK1XIVxOg387p?=
 =?us-ascii?Q?UwLN2iIWqPHhGGYMONRxEHUEbd6poj6WI9apZ0jCwZnL1dlaB2a72M4l90sS?=
 =?us-ascii?Q?ww8RaP5l8anSxVWRteqfxh4KcZAQXRkHhjxju6Xomi0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c112db-2df6-41df-7393-08dbc9bcf4f9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 18:16:00.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwEBUPuILGHdCQ46gPTj7f+joRVS9oAzhjcprgKqKWG3aSPX2GTWujHNHi0LvCSjOJUaNfnjfbyIkRa7AugOxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_13,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100138
X-Proofpoint-GUID: YbDkFEUsLagzK0EpoXVgXkgi5gi0GzGl
X-Proofpoint-ORIG-GUID: YbDkFEUsLagzK0EpoXVgXkgi5gi0GzGl
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [231009 16:16]:
> Preallocate maple nodes before call to mas_wr_store_entry(). If a new
> node is not needed, go directly to mas_wr_store_entry(), otherwise
> allocate the needed nodes and set the MA_STATE_PREALLOC flag.


The way I'd like to see this working is to preallocate nodes prior to
writing, but also to end in a state where we can call the store
operation to continue the operation.  Both of these parts need to be
together in a patch set if they cannot be in the same patch.

Thanks,
Liam

> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index e239197a57fc..25ae66e585f4 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5478,17 +5478,33 @@ int mas_prealloc_calc(struct ma_wr_state *wr_mas)
>  int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
>  {
>  	MA_WR_STATE(wr_mas, mas, entry);
> +	int request;
>  
>  	mas_wr_store_setup(&wr_mas);
> -	trace_ma_write(__func__, mas, 0, entry);
> -retry:
> +	wr_mas.content = mas_start(mas);
> +
> +	request = mas_prealloc_calc(&wr_mas);
> +	if (!request)
> +		goto store_entry;
> +
> +	mas_node_count_gfp(mas, request, gfp);
> +	if (unlikely(mas_is_err(mas))) {
> +		mas_set_alloc_req(mas, 0);
> +		mas_destroy(mas);
> +		mas_reset(mas);
> +		return xa_err(mas->node);
> +	}
> +	mas->mas_flags |= MA_STATE_PREALLOC;
> +
> +store_entry:
>  	mas_wr_store_entry(&wr_mas);
>  	if (unlikely(mas_nomem(mas, gfp)))
> -		goto retry;
> +		goto store_entry;
>  
>  	if (unlikely(mas_is_err(mas)))
>  		return xa_err(mas->node);
>  
> +	trace_ma_write(__func__, mas, 0, entry);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(mas_store_gfp);
> -- 
> 2.41.0
> 
