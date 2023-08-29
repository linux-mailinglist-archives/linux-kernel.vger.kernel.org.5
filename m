Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFECB78CA06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbjH2Q5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbjH2Q5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:57:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAF1AA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:57:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TCCVAk025366;
        Tue, 29 Aug 2023 16:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=OSrEX+inJ+oD6mOuX6jgCHTdJWMoBvMfvewT5hNmAB4=;
 b=aNdC7yZSVxFMYAaiG0pKze0nW0phONfO7nbh+ZasROKtSpEtjnELt7O8qomzDzvxX5c5
 LOAFtmj6fBHQ7hSINJoUuWWGqP51yoTDs5YgbNAw9J6dMrvmeh6rZmu/NfCHHBL0dQ1T
 HyLHwPSlbLsarMyiqvfiLGnQk4quHZhDFq7G1pigtS28ptZsVH7uMCpr8VDEAg8OHVZZ
 NwLpOt6Alq87k0i8I52rMLr6+lZD1cagax2WrdCMAHivqlOAxrz0C7vzpocVKs1NVHVW
 ws3lB9RazEPHkyyh+LmGP7Quo1cIN1BANeirnzHr6ZsxQqck/2eINcXysrdT+ae07OLx kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gdwfda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 16:57:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37TFjmwY004193;
        Tue, 29 Aug 2023 16:57:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6gbdftv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 16:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLZjJ2q9i7RpLk7ddK2XoCjIK4jWxZq4UuJE81r/XR75zWQjgRwc3oT4podOnyBlV8CZO0xxkZ9uor9Q26Q3Sy+aB/NWd6EfQzbq+4qGf90Q9MPZV0tq8KnYxjexqbuM066apxsjQh/wEQ2Od0SEg0RLoDgtTbf73O8IJLMeQJ2obqTNBkBl6ZqQrwa6An8il4/toR3nBBnEgBwalcYB9FTs4ig281cCavPJgo3rAy5L2B8kC9cfjv37alFrAW/b6BlOvh2fUa9TIRbXoX8sTthKu6lVxp48oEW2cpTiIMUsVQ8wtqsK2fS/6v5oTtg4HLgIAzMeRuZUPuPC2aRqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSrEX+inJ+oD6mOuX6jgCHTdJWMoBvMfvewT5hNmAB4=;
 b=jVBM9996i0DFonKZTBflgeydv9REUMdSfXh2j8fDyekfxth4jv5BzKlSsg5AHFaJUhDNDpZmYclq5vdCTAmXWfsYK0aEVKHm9kXcxlekP2TNHbeNWhHaaKVGF2X4RTc8z2aymoiVWqNHY0l6iyXJLqbfGiIE6iD+RFXyqFOzqbLflaDOrHS2lsbHJt8AkQ8il/zyIT/XNSDp7pnGOTt+/r2kPQqtTgG8sEBnYaLsv0rcA5BVovnOobOT3HrWJitgr+k9KX4KniRfFH+hyzkYgmJtbP9ZQBDHKhxukmP01oBQnaJIf+g1ilEnOKyZTi7OIceC89hD5yrwnZy6GgdQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSrEX+inJ+oD6mOuX6jgCHTdJWMoBvMfvewT5hNmAB4=;
 b=KQPyNiv4KQ/TSHJMOjX9yHABrWWJvLghuKeJIKnu4khSV/k62yhcYBrNSHycYcMQ9WZJlNRp8M6LCmytPHfIdHeFzTWE+976WEVpwSFOeJluBSzE2AlKhzTWupR7qRMsoekuqonrqJcTdpRpTvmsprzMydXMv5zm8OZ7NLrz3rw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 16:57:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 16:57:10 +0000
Date:   Tue, 29 Aug 2023 09:57:07 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Xueshi Hu <xueshi.hu@smartx.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hugeltb: fix nodes huge page allocation when there
 are surplus pages
Message-ID: <20230829165707.GB5644@monkey>
References: <20230829033343.467779-1-xueshi.hu@smartx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829033343.467779-1-xueshi.hu@smartx.com>
X-ClientProxiedBy: MW4PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:303:8f::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 000010ad-31df-44d2-a2b6-08dba8b0fc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCpWq1zbN608RRZAnHUJyPnAHj4Ig2fxjr7GZCO4EJGLj/CgfAZtcub8I8pYhWkPHIBQuDw+TxXzRUwv+fOXkiePP0uYWY62ER3KBmdul4R7nzjAv7Wf5mnnzih74ngzw2my0/0KTnnhsmIg5PlnuLgVGsUgvusDcVggZhF3j4ndG17Lg1fbj/xQOaiG27ai3X8zvXhM1WP5fDd7WDws4LcuYHFEfwmBKYnYeapxFC/Yp6E8MbmncGWE18zFLtoiKt3PPirIOjsNKMdXUyNe9jkUs5Sj4ae2tUdXsYjn+xDppw49B8BvWGOwLUbMjudZSSY3HrNmK/XPj7iWHRaQqGnRCL6y+iGvrb56A06OaDVud+oA0AQzx/iWBuRxAUjbb2isAG2ZcJ9FcO/gT6DqBWsERd5Sm/Z5KSVOOFsqzRq+rUgJMSs/gzyQwg6ATJPLuTGMdBrvmAw4FD8EUn8C8i1OMzhq/1OinEpOKx7v+Me7JRoqB9nTTmsQjUtL8eV+lQCl3A5Wd9LtIozK6w+qXpbq7tohpqkDoYOaiUnloQVSIk1DdcfumPZFNP+t9uVWa6bIwtNKqL4KEHeymzn9/BaOj6W3tV1MPNzPMfVL/bk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199024)(1800799009)(186009)(6512007)(9686003)(38100700002)(316002)(6916009)(41300700001)(4326008)(33656002)(2906002)(83380400001)(33716001)(86362001)(26005)(5660300002)(1076003)(44832011)(8676002)(8936002)(6666004)(6506007)(966005)(6486002)(66476007)(66556008)(54906003)(53546011)(66946007)(478600001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QMcRFfDvi8LMXc+KgFCQHCLHYSM9K/U/pR/696VAAq20IQv+sQv9203f9m2W?=
 =?us-ascii?Q?B75/IKdvSV4sUEpWEBmMmU83f8M762zCSgkmqkRsBBone/ejSE1zZx4Hj0eS?=
 =?us-ascii?Q?KDfjmabB87YL0uzLToDU9VO4H7d1zwPGahthS3ad8xXOFg38muJ9wkIvqJ4D?=
 =?us-ascii?Q?QPTVpSAorLe4W1yi5+fxQ/yOvrsHNZzWHrkRv4+1411nB0PLH5It/OFcgnQF?=
 =?us-ascii?Q?GwIH8KCbBPfxNoAT9pQIxxI1mbXPsyyoYs8U2GGkGE56WRk7Pyu/AqIUeruH?=
 =?us-ascii?Q?5EDE3apa1meQikuMx9DNlyUW/1niNI+6e+d7CAYWL0ZC2uivkR4sVAHAFeZb?=
 =?us-ascii?Q?r5MAqV8LwSfGVvjCcs65Lugc61wb65GSdBeKqzjyQPB/PvlS/Z9vPSKGA1ug?=
 =?us-ascii?Q?QKhc8DKUNTcFOzXX59y/GYYwNXJ48TwOJvkxgfB3I124ulCTif63ksvMinDD?=
 =?us-ascii?Q?OsBRI0myH1AfokRmJcMSiZaOMdKNjobe/dtiOWiocLxBhRbjS66GQ2dCBqd7?=
 =?us-ascii?Q?yEC3MC0ZR+E5lEO71bsYoke2tfArqZC9Xh3ebW4WZmWIFrXvIFOp/Ukt12Ah?=
 =?us-ascii?Q?tOxvl5PPGIDxdP/ZMxf3YovOUAvvUIz7I12KIqmpUOv6eDx8hAG7ggAbAus3?=
 =?us-ascii?Q?s0tPH0X4xWvtVq9YIFrOPc6DFVdVVXPGvcxmrhqyRgNvcPcCkDE9Pn/htYxY?=
 =?us-ascii?Q?SFBXGja06+Xn7gNj3dil7oj3d3XCLBplqs5sGfKWGaop78KzvuZEzJBylcVX?=
 =?us-ascii?Q?7ElTobjy4d1QjcMJ+LDvaHdSxScwFrNQmDDyXFOXYNh3IGOKyyTSvLhPxblI?=
 =?us-ascii?Q?y0hgHYeKvZWldYF49+JzWqKRIHrGRZriacQJeYqYVkfPTuE/GfzzGu14IKJM?=
 =?us-ascii?Q?In1mGPg+MnmnlayVASRz5xeVUxgg4TKKB5RAqFrYHGSzCzKyv7hM0dC/s/dm?=
 =?us-ascii?Q?G9hZI0SU4pwB4O2FbYE0hnFAMGTMQpWEsv52TLNvMyJwbOuRl9O7TAxvFx1m?=
 =?us-ascii?Q?y7zmGjLLKryE0PxQ/6VRE7vcCQjRyfvM2GUR21xSod1LPs1XOHNO5+Rc0Os0?=
 =?us-ascii?Q?2HwPeHIhuEWE0p1qylv4CsiCupGU55Xa5e7EbJYLqH9e5UeEbkgRhy5Os2Ea?=
 =?us-ascii?Q?RjvFvjHlnXP0vTmQaAEYO49K34i4B4IzhLwB9MNh2ZJeuC/Mavbv5iLCLM9b?=
 =?us-ascii?Q?TlX8RymU33znnuND/VKmV2RYNWXPZPUzGqTZnxGXM6e5XlnCzGi7VjoxmuRY?=
 =?us-ascii?Q?9ZAQ5FejsndfOm9t1uiBAyKqxhTx347QC51hyUC6wUYhuNgegV6qNtaPOcqm?=
 =?us-ascii?Q?tGkJXZeduO90dUxKRzuO4hyGNIfxKP6cSYcxDOod03BZf+Tpw+B55j7gWXkP?=
 =?us-ascii?Q?BILMwNFNN62KZtkI9NlmxZvoK6sWufuwp73PhYUJPLVbbX6grMhJk4UoPjOr?=
 =?us-ascii?Q?8kxmyzxO+95hQG5NPjLQ0wHKadSM5t95ATLZJRGU61I1NjhF/I0ccWl7xFnO?=
 =?us-ascii?Q?/3mir4Hd+qPNgkTvmmqcLcmPAZeqaiOOe6jWs7G3BFgbAAX2e4nQ8WxKn0DY?=
 =?us-ascii?Q?ZnnZZdH4Fyxswgcwq7KdDXA9pdR+ZmQK1qrt6hetYw4boKngVhBMrx2V10nd?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bnuMCQuqPukkuxGl3L8Wiwa/PxR9gBBp4O1Wg1DRMT6WJMSC/uVIapoQo+9d?=
 =?us-ascii?Q?LQpuUgGyes5vj+2waCDN7LCoBz9gXh4Z0cNc19RuJUX4p3epFINcUi8gEtfI?=
 =?us-ascii?Q?xcJqQd30uCwylEWpDyeurUL6xU4MVl9vYLJZPBTl08blFLqWhY+NmHxtxGfB?=
 =?us-ascii?Q?BTG2BCFbpGmRj3mPfBqaBjmMHnjJQx5sIjLyoZOsrREVmdtMRr+T8tJJmGhO?=
 =?us-ascii?Q?8FXNZmy+AeIvbrGAIGzGGViletwFItAfS+qCVKdR3r2ZU6NpjnbeB2kku5xd?=
 =?us-ascii?Q?6zRiXC3DMx4RQ97zM8rFbNlwqbu5fTHNogb2J+IuDDNEjIW45rsV1kFtelKU?=
 =?us-ascii?Q?RjvIHbbfpkr3jBzY1cKeLxbNNcf6jW1S6md8iVWnWDQ89ozfcLMq8Z/wSWBA?=
 =?us-ascii?Q?WNgd1jZg+CaAI2Bu2dbMVPV+QEXyMttEdnwBFIEpXfIUj8mOGkj+GRQEVrru?=
 =?us-ascii?Q?ZJBPm0987B5v21cIVAoxPC4ZXVywdNEi3EUh1G4rtUrUGvQaB9pWU0Ax+vtf?=
 =?us-ascii?Q?lychNBdArytaQt7CJ3DwCFrBFvpiZu1chhsTEABKxiaflnoN3Py46R2WcOUz?=
 =?us-ascii?Q?7wf2xCsV+a41TC4L49dMTO56PN1EPjsTiv3HVwx1WKEfCbRW/a2t8mFjSx4p?=
 =?us-ascii?Q?ER3lj0/9d24kAYG0f9w668pow0dbH9Y7pxcEbYgljJzHHzrPoAZtIlvS5eEv?=
 =?us-ascii?Q?x47BVKmKu5k16V/tX8Q6lzpjJGlEShAQQxUmT6CbNCIGmbYidZ8zyWXr7H/h?=
 =?us-ascii?Q?t15YHa8wBxHmNj5PLxCr8mHDncecGtSHf1NhLriGuKpnc+DZigHozuNFL/gX?=
 =?us-ascii?Q?zn7YB3NfFnIXK9qafszljiidiMGDp/l9FezD58MVvQb/sWUxmli1BRx08Grd?=
 =?us-ascii?Q?AT3nQ8pNz6us4/2fvK7VIKErlyHbZnPhLdUlDGByI4t5zdzbLpyExAkHJemB?=
 =?us-ascii?Q?3jcAjpRH0czyjCY9oaHQxBTQt9loL5/ijI+crD//xQA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000010ad-31df-44d2-a2b6-08dba8b0fc1b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:57:10.3073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0ovxIipvf4cG31ylLbiTwmkiF6MdMsGMRV8MR+6etjhQ67e5fd/uilHl7EAEj9dtrNhPbkS2yYIqizjzB0E7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290146
X-Proofpoint-ORIG-GUID: _mdo5tOBY8NiDd0wZC5ejfdt9YeoC_Xk
X-Proofpoint-GUID: _mdo5tOBY8NiDd0wZC5ejfdt9YeoC_Xk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/23 11:33, Xueshi Hu wrote:
> In set_nr_huge_pages(), local variable "count" is used to record
> persistent_huge_pages(), but when it cames to nodes huge page allocation,
> the semantics changes to nr_huge_pages. When there exists surplus huge
> pages and using the interface under
> /sys/devices/system/node/node*/hugepages to change huge page pool size,
> this difference can result in the allocation of an unexpected number of
> huge pages.
> 
> Steps to reproduce the bug:
> 
> Starting with:
> 
> 				  Node 0          Node 1    Total
> 	HugePages_Total             0.00            0.00     0.00
> 	HugePages_Free              0.00            0.00     0.00
> 	HugePages_Surp              0.00            0.00     0.00
> 
> create 100 huge pages in Node 0 and consume it, then set Node 0 's
> nr_hugepages to 0.
> 
> yields:
> 
> 				  Node 0          Node 1    Total
> 	HugePages_Total           200.00            0.00   200.00
> 	HugePages_Free              0.00            0.00     0.00
> 	HugePages_Surp            200.00            0.00   200.00
> 
> write 100 to Node 1's nr_hugepages
> 
> 		echo 100 > /sys/devices/system/node/node1/\
> 	hugepages/hugepages-2048kB/nr_hugepages
> 
> gets:
> 
> 				  Node 0          Node 1    Total
> 	HugePages_Total           200.00          400.00   600.00
> 	HugePages_Free              0.00          400.00   400.00
> 	HugePages_Surp            200.00            0.00   200.00
> 
> Kernel is expected to create only 100 huge pages and it gives 200.
> 
> Fixes: 9a30523066cd ("hugetlb: add per node hstate attributes")
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
> ---
> Change in v2:
> - Correct the fix tag

Thank you!
-- 
Mike Kravetz

> - v1: https://lore.kernel.org/linux-mm/20230828233448.GF3290@monkey/T/#t
> 
>  mm/hugetlb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6da626bfb52e..54e2e2e12aa9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3494,7 +3494,9 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	if (nid != NUMA_NO_NODE) {
>  		unsigned long old_count = count;
>  
> -		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> +		count += persistent_huge_pages(h) -
> +			 (h->nr_huge_pages_node[nid] -
> +			  h->surplus_huge_pages_node[nid]);
>  		/*
>  		 * User may have specified a large count value which caused the
>  		 * above calculation to overflow.  In this case, they wanted
> -- 
> 2.40.1
> 
