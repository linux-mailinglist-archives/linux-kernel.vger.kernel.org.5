Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D080B7C4295
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbjJJVax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjJJVav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:30:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E70692
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:30:49 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJiVIW026530;
        Tue, 10 Oct 2023 21:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=MhaZv1GM1sE9BWu1kJmobQQzF+gYdQOJmdepRVx603s=;
 b=XZPzHcjpQysUReqfDVMxnCAyi0w47zoOxWukHIhldL4xhxB2XHn5kL4SsUSvWe6pqVpK
 ZIEjeRB9ROAqK31fGw3ru8xWxE0E5chAuQylJc9bcGh5/m9c3RAiXO6FaVDwkSgW2/0n
 ttVd3+4D8leUNlGENizSLu1cwJmU5BE5EiOGYCRmI8lCHZ5fYlVItAZj4qRLHGUDveOM
 OLJVgzwPGQmoScp7W2ALqNJmw8MSwfP+IvotBQmx9x84XZvWvXrJOiuAufi9XvYkYFy3
 V226GqbQoPuOnXhXky4omaZrYZwuDD2N0UAmq/vW/VVh6kuzWzLkyYuoZALFmNBwjkZ3 KA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdpgmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 21:30:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJtLau014851;
        Tue, 10 Oct 2023 21:30:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws7ke6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 21:30:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHV7LAtCMUKSIjND5GzwortPTC62UJODoCa0udNYKWiDdCxECx1vCzvt2ISPHD2H94+lztmLsXoqKJSETMxH2SO4aUa3tfs8uwJy7Mj6/tKs9EIn0d0E/S68Ziv6bGPBM39rAxuPbcegxRwRHn5xIUJHWLUA1edb5Qmxqeq9Fi6xKmHlyboiFP17NlCBk4A/bZfc1/6p5dGB9ssyFcxG7xP1fJX8+bXMfE1vlSXmQWEtVJwTEHZ9JTr/03dfJIil5Vfs0AAtoy/lpf3DKKLOJdD9Hl+d2b6WvLsBv9xCF5D3DIB952CC9yVLddDuYkuF75InhFnd999BM76+8kFsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhaZv1GM1sE9BWu1kJmobQQzF+gYdQOJmdepRVx603s=;
 b=LtiDOiBeE5E2BK/O985KoMqMRMeleB7IYoX3Ms0BNiriq1IFzC3K/Clc2AFtWX7Biuamap/V+f5HBSly53lIv09o7KaiC6fE5dibvN8EH9TbCw/9UZt7/yvCp+5jM90UEcnWoVFeTtXZIyeE364TCLGaU5a9xU7P8PkWvd1HKx0DQiJRjfnAxVLpN6GvDuAERVxZeDPGZEufLjNPe2WBmn6U6bgBwugFjoMBEBcXsOcHfPrTbK+M36MeWKYFU0lzGp9Zr95Xs7zcgJpQ9NGMiiH+BLZxKO1a+b8UkmpaWhgBP7UJHWXT7GRa/L0++Q4fnCzSgfIOIVzRhhZah0gc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhaZv1GM1sE9BWu1kJmobQQzF+gYdQOJmdepRVx603s=;
 b=VKnanP24uGMY/Q1kR8KcUmNd41B0+prpK0byWQ4gRleERF/skGNk9Fp3vEd/euOKWpF8nd2RKknHY4JRdZHRIsMCa9wOTUVrGTAaCuh5I2pTWUAXO5VXCRWAZC0nnorgmn0kU0vjwFJ4dmNzk+lDqYsBjT7ZL5mlBfOvjE2ktHA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by LV3PR10MB7818.namprd10.prod.outlook.com (2603:10b6:408:1bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Tue, 10 Oct
 2023 21:30:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 21:30:23 +0000
Date:   Tue, 10 Oct 2023 14:30:19 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [External] Re: [PATCH] mm: hugetlb: Only prep and add allocated
 folios for non-gigantic pages
Message-ID: <20231010213019.GB279095@monkey>
References: <20231009145605.2150897-1-usama.arif@bytedance.com>
 <20231010012345.GA108129@monkey>
 <6b1d9860-3581-0b99-4fb7-4c1f5a2a05f3@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b1d9860-3581-0b99-4fb7-4c1f5a2a05f3@bytedance.com>
X-ClientProxiedBy: CH2PR18CA0050.namprd18.prod.outlook.com
 (2603:10b6:610:55::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|LV3PR10MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cf8bd5-4189-478a-741b-08dbc9d81c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aP+pksoGp5Csx1M9mRtAagWpbki500BUViRQ4an0Evv/TonZUGo93l3O3lP2+uguWpXa1Jeq0bj7Y6cCRMiaFkjKoO9b3sEphx6n+uWzXfOe7K6sf40iPVeYZG5jG3uGhdGTL+t613IJ7rvQDsbKpOQmp22+qwXhnDwgjdbU9WASJhSKDqFNRRDQjhb3Lx1kw4PQl0F6xjGM5l4Ld+2oYw+o/i+0sAQH3UIYTWJElHIbOhmCxDSiJKn2KO9Hic2Hs+aHoOfFoQ/7dhAIqDv0lfPqQrJj9ygsy2j5QBq2wKqao6dxUfMfZGbmRW+R1oxw+Alpq5zkOYXeoVneKI9ZZVJxj5gfef5k715QOvGps9kNXu4GMN9IqGXOXGptdlhwwr+eq+oaYHH+TgGZUuFHKgwtI2HyzSeWkbgSvyI6Q7KS7J17WEAOLMP0JTJZ8t2L84PV22aM4qqPLZAtzst1+9fwW1C1+glv7fmhgELmBetYJ/7P33eLkQq/m1Z4RXPHB0QRMPNernhWX6wPMi8jqeKaNFg0iHZC75c8HFLT3oJoEpqfDOmdkXvaQwsWXyHH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(41300700001)(6486002)(478600001)(316002)(6916009)(83380400001)(8676002)(44832011)(8936002)(4326008)(5660300002)(7416002)(66476007)(66556008)(66946007)(6666004)(2906002)(53546011)(6506007)(9686003)(6512007)(1076003)(26005)(33656002)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aSNWGejW/4gpOh3H1Gzs47vuB2EjjVRyPYxuGVxtPLuN55uqfbefXLgFUeW9?=
 =?us-ascii?Q?PfdqCr364hru/0v8v2uCi8SdVuLYxNQkU/fh1TXbqKWcs/Vs45DgrD5n86yC?=
 =?us-ascii?Q?txIs/ZR7c/TMrX/7KLu1b77hwpyCz1JDwI5F7LTYe9FgstunuN8+k8BFxwXz?=
 =?us-ascii?Q?u8EVHrvtnvdCMqbQQqu+v5vbSU1AXkFs6TXlHZPUi9xXRJw3tJUYAQ+KCaQ7?=
 =?us-ascii?Q?EauRtVA0W2d3yLtxkTJdd1c+nYPDn4R6nOTOCCjz39VgfCuFpAfFtTyqqX4D?=
 =?us-ascii?Q?WUHk48yV8rmBQ8wbZ+0ASy7ZPJqpAp/WdVNjQYDcCuSAawMxYV1fsVFChXr5?=
 =?us-ascii?Q?NMSax/vDhVShpn8GQGfz/cfoa6PIav0TAT9kDjcH6/fMU+p3erqFXIx9GDqG?=
 =?us-ascii?Q?/KFEd/OVZr+WnohNkyPZlISQZLbh7idjtrD739NLU9IBlO7+tj5wMq9zM0Mb?=
 =?us-ascii?Q?AQnB4wo7iu20ZIaBTzBnJK2eRgiSY3cRjggA+5Bq1sj0m+D0WEAarY5IHXor?=
 =?us-ascii?Q?EUDuzFjUCuIcx2MK/yXX0QHmQ+/AlQdkAAiClIKpnL8wKHtaQB/oInuLQ2Lb?=
 =?us-ascii?Q?afOXdXaslbqRchu5z8UYSlItfYL0oPfEUDN9Z0IMLjQHxkQ/t5MBp5OMBFPh?=
 =?us-ascii?Q?Or76ArIzywMr18mkS7VGnEGH8E3cX1/J8mLbSlIos+VRRv8gcKWCEVVcPjbi?=
 =?us-ascii?Q?60aq+I5+p6vb68gVR2XLTxx4xyIjhgFfty+7WVP0Ryf6ZEvrvRd4PH+4pwOE?=
 =?us-ascii?Q?s0WOYQh8Q5Bk+sY3uwvwo0H6C7hN6//XlHVHKj+FjDQspCBaP5Pyb6lfZ71M?=
 =?us-ascii?Q?BBF6f+213maN3qmSrX7zXpqICWGByVepAUf/p8xE3cgjbP70uPpbeUiBD99l?=
 =?us-ascii?Q?8+qM7J+GXwoIIuO84jusR/xoCCP5Z0bDsaWtXNzic4Vv4tff4q6V7+uAdhP0?=
 =?us-ascii?Q?ipqdT7ECAUZfLRGnfHLM6LPJ+DjqL28FGWXs6WivPykuHOsry/6Oc1RQhsaI?=
 =?us-ascii?Q?U7YtG3Rz+xlJBwReE1gNBjbvMDeMjV/JCw45TzSLosNHcAfvhrg4rPzAKvDX?=
 =?us-ascii?Q?M0E3s88QLHBff0Es6544TU3Swc3Pr6C1f7yvpZ1SSDWhkCovLpYP/Rf2iM4o?=
 =?us-ascii?Q?LoV5XSyNtzVrcka+VxZoTznGGiQF2N1BfY1S4ZHFRtYP9T3plc+yWCrA4xss?=
 =?us-ascii?Q?vW7LpR81T27Pe30j88Z7xxzTwgI+GnMv85zk+D7ufaMX5KJa74JUjDbz4+2R?=
 =?us-ascii?Q?+AaL4yAKbGWASJPm+lP51O16j8+3NxYl/yBIAbKmw8hwNHPurOSrnF7yuTNG?=
 =?us-ascii?Q?QPisnLXjIV9tKjd/9Mh+lz02fs+2ZqBF6riy85pNswztYVR8bWwIkBtAvXgT?=
 =?us-ascii?Q?r+d7OV2T3OhgmZZlcklNTXPwNeMhfLeKpZHPovaNiRF/35nttClj2EKx7zKQ?=
 =?us-ascii?Q?WOnCc1mV149H9nj2XKqQ3dUKHt0y9qwsDOxcIncqffWU0oUy89pcW2xJuKie?=
 =?us-ascii?Q?4u9qh8xVTTaLtiyu0RE7LpsSVCnGm0wDtdWckV/xm+n/OnH1YpVHx9eKqAtq?=
 =?us-ascii?Q?didkJoWe4jQPeuGcFwdsco+aHdZ2IKMXQEvN8NnLyc7kXhsPoDqqIGvsGKYO?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2NR8YIoHsMyzG8Gn3lVKM8kKYG/c5sQWmb7Uz3PCZGKSHirNm8UpmuAW7lZR?=
 =?us-ascii?Q?6JqoZ7wrRf7eJgqjcp9ApekgbTDDQ9F0PcGPJf3SFsz4C4xoDIAAagDg8OJV?=
 =?us-ascii?Q?XThSSFUjsG8C9QpJ6ULQWdda5gwq2oYOzUqknMoNToOK50bD6phVGbxtZVdD?=
 =?us-ascii?Q?ycz8XtvDA1qhxcZ2opLPxvOi3E6JoCR5sD3if74oNvG2nkzwzvqKNZpjCf+v?=
 =?us-ascii?Q?uG4iV47um8HEaUyFjNX8WKUXXsXn5K+INAd8qOgEXcHl26wKacVuWJcYqdKq?=
 =?us-ascii?Q?/eGxZh0GrxZt4XT/76Av3AoIdUlk5X2r5IYA1iuR9/F5vI1CkUmYV7hRUz35?=
 =?us-ascii?Q?rMBkUe5S7Q1fFnVqVNPvrPa+S1YjHvTXU0YuSjAoA+Shuoi6eKR9hEdq+vgR?=
 =?us-ascii?Q?vrJeMnYVrqYuC+YQnJTHTYFmKeFxPDlOwEx+dn4Ocf1I/HYTQ6jcpWDw4VcN?=
 =?us-ascii?Q?uYoYDaqVUumYTJwhfBH/sPlokfDIEpHXdooQzSl7N+FFExVjAmMKsuiokKME?=
 =?us-ascii?Q?wGQg6EweUSHJ4vSK5ZcMSekAaIGB6d+Z9ob2WT58McoebiClBuvjnt9RNOOW?=
 =?us-ascii?Q?odjpd7y3YY0I37l+zxBda23u2JhPKbxQRIsIIhpfrCQSiEj7Jy/iqlm69DUX?=
 =?us-ascii?Q?OwufZHxBzb+Dreon1hu/h6yNjlphhnUOCLajr6DpHOaI6JyEuWHIbgttxDOW?=
 =?us-ascii?Q?4IMPKsDwxiBPEvFB0WPO00XnXbsrAcwVZcZkSzjuhVPOzxrHMJeoyO7a9COi?=
 =?us-ascii?Q?OrArNHZDfOoinEwRBDfnCBTfMlqLYw9wHLef+zERpbGqnDdBojX/rvdyBJ5S?=
 =?us-ascii?Q?2ZTSpTFMOXWOhzNEXQ3Q6SDzEcPeeSsbReUboV7n/PmPySOCQgclPeB+X7dl?=
 =?us-ascii?Q?1Fu7CWHQzNSLtNZWDztGMFTWexmFNd2YEb7pJW3izfpveGLvgpovFV6tGF8z?=
 =?us-ascii?Q?pLtxLio6e1fvOIZ7y3onQfzrO/fRkPZgesiXIVuTwNc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cf8bd5-4189-478a-741b-08dbc9d81c7b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:30:23.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtbB5eUvaHkzitGSrGCTNt2GlGj0mNrcd2sEm00saSEjE3zkX6G7h7YjfRjHT9RJQRKlHFUv4/t4wPNs0xDGGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_17,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=780 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100166
X-Proofpoint-ORIG-GUID: 7_VMm1V_a1XwapSNzd4UNyylH6jvvwem
X-Proofpoint-GUID: 7_VMm1V_a1XwapSNzd4UNyylH6jvvwem
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 18:01, Usama Arif wrote:
> 
> 
> On 10/10/2023 02:23, Mike Kravetz wrote:
> > On 10/09/23 15:56, Usama Arif wrote:
> > > Calling prep_and_add_allocated_folios when allocating gigantic pages
> > > at boot time causes the kernel to crash as folio_list is empty
> > > and iterating it causes a NULL pointer dereference. Call this only
> > > for non-gigantic pages when folio_list has entires.
> > 
> > Thanks!
> > 
> > However, are you sure the issue is the result of iterating through a
> > NULL list?  For reference, the routine prep_and_add_allocated_folios is:
> > 
> 
> Yes, you are right, it wasnt an issue with the list, but the lock. If I do
> the below diff it boots.

Thanks!

I believe that may be that may be the root cause of boot issues with
this series.  It is unfortunate that the failures were not consistent
and did not directly point at the root cause.

Hopefully, these changes will resolve the boot issues for Konrad as well.

I will create a new version of the "Batch hugetlb vmemmap modification
operations" series with these locking changes.
-- 
Mike Kravetz
