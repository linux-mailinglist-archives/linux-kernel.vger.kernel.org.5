Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B037BA5E8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242335AbjJEQUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbjJEQQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC612724
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:32:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3950ZhFk026765;
        Thu, 5 Oct 2023 03:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=LTSTN62mPpydIU4EFrL8uI9AN5U8PJ5NJd55FDL38yo=;
 b=MezWtQZf7txg645Q59rpf0Q9AVeQbUJqzeJjuL3d+4rJPW+mOoRb0gV14CZQUxR/X+0w
 4K3Z8eMGxsXfRBDywmmjgScCG8I2vmGyCLdNKbekqBCw53CMR3mCMfS3OzX3pN9eR0S/
 s33650ss3k8R5cXOXN0TZdtHn17IqzVvKsaYHG2/69D7R76lLnVbKBMLSGkWrHzFf1XQ
 dGPFepVUAvCxwBiYKNTHHDdRCfsdrz/GHPMCUsCalVjJT360lPDv5sVw2NMr8gIAwp0F
 hXQyDDjeFkoXnYAPLEen4+eQPl1R+hHzrOi4Vjf10rXb9H99jiACn3yF5Vk86qYWaWbf hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3eghb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 03:20:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3950ImAj009722;
        Thu, 5 Oct 2023 03:20:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3thcx69cv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 03:20:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvGSlp/miHUM3nF661bcMHsDAHVzTEwMhfnr/kTSd3Rf6eR3BOjm0WptyAB52bw2pO8WWlIWwJj4gzjuShURHhVLnBw2ZQqMMahxKV3Nj4y+qETuSU8+WvtQPYMKSpC8s6pHo7bxJxZypDdAVVLmXwY6qwXRzHrcN0g0HgpIWpFTUfN80XM3MMVVTSrvzfiTbc1vFm8DP73B2o0Y6HE2X6z+OPG/J7REZ1o3U5WJ+1KYdcXx/z+vEV9t1ZuNm5uM0PvpYI+yh22N1wi1n5YoW/RbDOfQzXbOuAHg5swEqFkHM+3OdCZpLT6Lgzh5NiANB51dcFQNrSgUdllmncg1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTSTN62mPpydIU4EFrL8uI9AN5U8PJ5NJd55FDL38yo=;
 b=CXPfefJnOSo7PjRhvGXNz4NoQlB6R56FVoQh1h9WS7dPT4nASu38TATzCPVXkuKsfGsKxVRR5t0m36Pm5m8kFiEyevHIeccFIYnugHlQsfffyYx3JF9m8cnsKUANOSa/lpS4oVaFKNmdTiL8NGc6zgS/RdXpcMqugNE63gFiHdVJISMhItExN2PG+fRb3KZZlzemYonUs42Kf3+a0u1S7eavNhpj1N1RmCwkhNSYK+aWzarW3PMmaKgxYr09cscY2PQ5/3Sa4k0+4nXkY9k2zzWs/S00uwF3D4/2sF5u42i7FiNg5uJMlEUZhoNZpzvGN3rok3rbMLIQountdf23Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTSTN62mPpydIU4EFrL8uI9AN5U8PJ5NJd55FDL38yo=;
 b=NRNwQcFi8rPYx5gUFP8ZDjDQo+7WHL2ovof6R0pGhsrDtF8gKVVC00zDRySyZ8GtDxiS0y9u0OyRiL/qmLaS+SpNDVD/yzJRKwS28+ueAK5lIdnrsHXAeHye5mDS4VYlSL2y3dHLChCTsy/F3C81m2Uw2sgxqzRHI7AuZLkz3IE=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by SJ0PR10MB4816.namprd10.prod.outlook.com (2603:10b6:a03:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Thu, 5 Oct
 2023 03:20:04 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::f843:6c6e:77e4:20b0]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::f843:6c6e:77e4:20b0%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 03:20:03 +0000
Date:   Wed, 4 Oct 2023 20:19:59 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org,
        stable@kernel.org
Subject: Re: [PATCH 2/3] hugetlbfs: close race between MADV_DONTNEED and page
 fault
Message-ID: <20231005031959.GA13437@monkey>
References: <20231004032814.3108383-1-riel@surriel.com>
 <20231004032814.3108383-3-riel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004032814.3108383-3-riel@surriel.com>
X-ClientProxiedBy: MW4PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:303:8d::16) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|SJ0PR10MB4816:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3d6f86-4a61-4fde-91b0-08dbc551f740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjwq52vnsK1o5V161lfKasTJUil2F3nt2if6Rcj66N2YDVZLndFU0UXkdu2+96UhyAux9CVbO9b+QJl6oRZMKZcG3A96y5UbOLmUlGErlpC5Dm8j8t7FYEpTe0XCUzXD/MaoXEWmmRm5f9ny1oTNXafd2elvMtW7mcFVl9wautWeaq7nSW7LKEBg0m/P7V8ZVxf9t/FOaCuynAj+ZsOotYxc6qxsriSnxuGaFHLwMxu/8v6Z5gso4KnRrOYm7mgeTEO4QY/94jfkjVtBE2esIT4CJ6tqBQPF+eQbiz227aX7odewRKDNBYC8Qx71xgqYuoPtKa7dUvMl4YBj8h1unsAqKOK7XJFeq0FmRwZWsSQfhe8gX0Tp66Eb2uIn6F4bIrx2mmo7ELpJoKNfF+e39aOKRQZ6j75qsHv96eGXT/wpxYlrwNbHdq4pNrCVXTWpUoY5yrZnNpZ5BZRJZPy5OU8y0zj0ZXWdrytWLhd35hogS8npPZ8H8s0eL5MkA+JQTAGpnTij4MLMnbYpkv771+QstSqv0DGyVjeoefXDcZVG166cBXedTbdghvcuLn+UyXrN2yBTtHisOS8vU2+figY9Kvqfjcyfd0GZqI5oJwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8676002)(86362001)(33656002)(6506007)(38100700002)(66476007)(6916009)(41300700001)(66946007)(53546011)(6486002)(478600001)(66556008)(6666004)(26005)(6512007)(83380400001)(8936002)(2906002)(9686003)(316002)(33716001)(44832011)(5660300002)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mJKsj4rrO+OyKy5KIb/met/sZFf0SXbV8bxjbAmLN/BU0h5aGpry9n81TNlY?=
 =?us-ascii?Q?xSS1eP8/mHsb+vO3TN/jNtb5Ar6jSOQsZWySUVfztfloyk0VjZ4xwPYkbPss?=
 =?us-ascii?Q?kNU6o9rpxGZddnh7H+Su/K1vxY9PzT2R5EHGb0H70AEs+0bvGqSNF5BXhUzp?=
 =?us-ascii?Q?F99PkPUulXJfRFo+1v8lAcOA/a3zYLHKGrH3lKagzTplnv9rLoz7RDFLtVAP?=
 =?us-ascii?Q?HHrGdz/AMhgRvT4MFbRWaSZlb+dteTH9zO6jjfQZsU8HVE/tvph0VXJYP8SK?=
 =?us-ascii?Q?vKvxhsuaUhM1knB5wAteMngOZg1iKjKbXAUz3tHpZR1U6GT77d7jQfzhv4Gi?=
 =?us-ascii?Q?UhvCrMGxz+odZwvsspERjNCiLyCGM7gXcaazW2xmbyDEzkS6V2rYyw6k/d0G?=
 =?us-ascii?Q?9x0kxOe3zA2LEe57BEJXVmPhhIBDnjCtD06pz96+1AF7LWO/i3WN7DG4EEII?=
 =?us-ascii?Q?+gFc8A2AlQGHVyF+atIck8a8yQh1i15oZ7xGe6G51kgpiP7PUUYhjSD2ACbi?=
 =?us-ascii?Q?k5PYk3Bt3dihl4XnZXytmU4EKwoJzVVJxN+7PlF+/6PbzMTv6c2FvghflrG2?=
 =?us-ascii?Q?DI2QZG3tYBie3Wi/MdeBYFAcnFKL75gLTBg4SwYTWW1RBepSkAtJswln6LDU?=
 =?us-ascii?Q?l9biQveaSV+492d5gXJEX9Iovxr6wrCNtIwN1uYMpFmT1RFkcow9YliAzkLr?=
 =?us-ascii?Q?dFJoAFMoMVQ6uJJKGQeieZ+3/B4onhxG4ri+OIMjWns7kE9YP3ltL8eHU2a2?=
 =?us-ascii?Q?Ilcfs3iYxF2jYaomrLYYrXiivFFS4yJ/aqukF5VRx9ajAJ9Ds+sYblcCoYlH?=
 =?us-ascii?Q?0T+bTkm7B2uFVhqJyM/VFrDa5uCo05UaimNYgyj4eaMzYRF0HlEYU5jh1AKd?=
 =?us-ascii?Q?/BM0Ojq/eoZk0Zc7J/p8tyfKBJsSXIubUQzJKtCov1j5MrnumQmQX8xXDJZf?=
 =?us-ascii?Q?afRaxLfbyR5KPDZ7y6uqSiad4txgAChJMFFA4oIs4CPCZt0pQyxI4Z9zfj21?=
 =?us-ascii?Q?wyZTDybHGws+OiAj2DaFSXNU43zI18rnpmsTp45yT3DX4cP2XrCP0iFXyomM?=
 =?us-ascii?Q?iyUN3iU6PdWO87UnZM5d2BnuHq5Q7NoER1NBBsZpPzOE2dopRiSW/xd7GwJH?=
 =?us-ascii?Q?sxOxqvpRsxc0DfJtlNlPmOszJbHLpYE+I4rGXejDJO3qgq5SKcZNhJSGDBiF?=
 =?us-ascii?Q?OFogogB/Wyi7GfJVzk8+nKOHQ0I1q/RYGl/vauDy0y3T9yu9YPO1z22JGQkZ?=
 =?us-ascii?Q?1tMQj8liDbYivksW8ENmpXGI4DIFESgC/QvGUXjbBXLzpZy3jm3iHPLmKyT/?=
 =?us-ascii?Q?DW/yw/JFL3Bv9kIDQoVoAu1qpYmZ9o3cTeD6JDfZ6PHN7Xxq2VQISVBM+WaU?=
 =?us-ascii?Q?TgiD4nhXaTumXZgva71RyvJ/5QkV4jQuMQf570CNCr07R/CyigyLGKPOC4D1?=
 =?us-ascii?Q?x5rx1oH+ReXDdcAQF3OeKahLlBENNjGcF8c/64VxDIyNIIO8BZAjbKnNfb/H?=
 =?us-ascii?Q?sEX0s82cEzcgWuiZyyWBspvVPlk7Ywx/n5sIieZ/4YzSWgYqMBP/VnQpge1s?=
 =?us-ascii?Q?5L/xWg0PfTj9O5wlAByPBEPeVJOn5SVBnxZzUGlL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2/ltnd0uaG5DM3j5/x1+gxQTj469Hq6zmjULNE5sOpoj/jsT3fm3Uc9XSY3Y?=
 =?us-ascii?Q?dLlhCNr+LRdemeHoC2OTz2aYgVKXvhmT38DLIjqddQRv6F2hovu2EIxjP7pc?=
 =?us-ascii?Q?lQUMZIkFV04ASFQsCjwEOWvA/0ccaONqnkemidOGSqLJl2+DSmTc1OV6F+Sv?=
 =?us-ascii?Q?fSYeQ8qSDIPIVwkZglm5mJkbzxdNMcEoo9DQuC8vnFra+DqtOHCfXwWtgWip?=
 =?us-ascii?Q?GZRDetCrWoMYjzgJou5Drd0J0vaqXogXorCb6pXA7cyqM3ELkOgqrMdLbRiQ?=
 =?us-ascii?Q?IqycpgIEbkqFV5Z78GChKrGxmv61Rh01zDM7ubaqDDCaTQAY5CsCz2Sw/9w0?=
 =?us-ascii?Q?J2S3EtL6qPJnok0fxiklCA0pM8q9Q0jxIri70GkUA99M3Uxlsc86MR25VXtF?=
 =?us-ascii?Q?86zvMkbwfQ68Uune0F4vEPOuDFD9sLEW67DUsZVXCAMpn/LTolKZamVUx9YL?=
 =?us-ascii?Q?5FI6hxBu7wiiwnLYsaIKngrk90R2DdSe+551ZbgerxeU11DaGQp8DjU3CsQV?=
 =?us-ascii?Q?pgnMNAO9wnB1v3lJniw+uq7GuWm61i1KY0ZP/LrYTnCuULYb3IMqemgV/I26?=
 =?us-ascii?Q?hxSn+JRhhswew9cUZJq+pLU/oHjOwyUbIHW+SyRQ01oFraaBenHyPgp5Fy7B?=
 =?us-ascii?Q?RpcvQMTEjLyspG8K4CGUUzAl04yjXzNgn5h1L4xm4aZPQxGokEoWzane7l+a?=
 =?us-ascii?Q?qd10EcYJQzQzp2d+WIOR90oBLSkHLxAs0APOgi4acYjuQ345vnzo/YyFJDb6?=
 =?us-ascii?Q?TltnZ+ZvqZtEnn+kCfm30eRm1wnmtPWYUxTthVevYMJog19tDOnu7yqaCAEe?=
 =?us-ascii?Q?Cg7o/k4Z8BfiAFvxXO8ckVgsCJX1o0rUk3vYuqbRPVQ6+Sqzpj7zKRiFclfn?=
 =?us-ascii?Q?bq79UCMknz+XepuGNfs2mr4SCaNIFLoIPG9JnRs2cJd/yid9+xrm/65jj5Us?=
 =?us-ascii?Q?oYXqkMQ+6vivWOqMkIzMdB9hxo1L81CPPlqOQxdXRnM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3d6f86-4a61-4fde-91b0-08dbc551f740
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 03:20:03.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2SUj+2ltizQQxGsZQhye+JYGaEJ7L0xdIULUrNb03QrDWQPecbbNK5UPsDVGHOAcoESIc6NUOUBcIqWOfYDPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=376 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050027
X-Proofpoint-ORIG-GUID: cA3qUfqh_bb9kNTLGbe4EQOuKrVWG13-
X-Proofpoint-GUID: cA3qUfqh_bb9kNTLGbe4EQOuKrVWG13-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/23 23:25, riel@surriel.com wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Malloc libraries, like jemalloc and tcalloc, take decisions on when
> to call madvise independently from the code in the main application.
> 
> This sometimes results in the application page faulting on an address,
> right after the malloc library has shot down the backing memory with
> MADV_DONTNEED.
> 
> Usually this is harmless, because we always have some 4kB pages
> sitting around to satisfy a page fault. However, with hugetlbfs
> systems often allocate only the exact number of huge pages that
> the application wants.
> 
> Due to TLB batching, hugetlbfs MADV_DONTNEED will free pages outside of
> any lock taken on the page fault path, which can open up the following
> race condition:
> 
>        CPU 1                            CPU 2
> 
>        MADV_DONTNEED
>        unmap page
>        shoot down TLB entry
>                                        page fault
>                                        fail to allocate a huge page
>                                        killed with SIGBUS
>        free page
> 
> Fix that race by pulling the locking from __unmap_hugepage_final_range
> into helper functions called from zap_page_range_single. This ensures
> page faults stay locked out of the MADV_DONTNEED VMA until the
> huge pages have actually been freed.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Cc: stable@kernel.org
> Fixes: 04ada095dcfc ("hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing")
> ---
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ee7497f37098..424bb8da9519 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5435,16 +5435,19 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
>  		tlb_flush_mmu_tlbonly(tlb);
>  }
>  
> -void __unmap_hugepage_range_final(struct mmu_gather *tlb,
> -			  struct vm_area_struct *vma, unsigned long start,
> -			  unsigned long end, struct page *ref_page,
> -			  zap_flags_t zap_flags)
> +void __hugetlb_zap_begin(struct vm_area_struct *vma,
> +			 unsigned long *start, unsigned long *end)
>  {
> +	adjust_range_if_pmd_sharing_possible(vma, start, end);
>  	hugetlb_vma_lock_write(vma);
> -	i_mmap_lock_write(vma->vm_file->f_mapping);
> +	if (vma->vm_file)
> +		i_mmap_lock_write(vma->vm_file->f_mapping);
> +}
>  
> -	/* mmu notification performed in caller */
> -	__unmap_hugepage_range(tlb, vma, start, end, ref_page, zap_flags);
> +void __hugetlb_zap_end(struct vm_area_struct *vma,
> +		       struct zap_details *details)
> +{
> +	zap_flags_t zap_flags = details ? details->zap_flags : 0;
>  
>  	if (zap_flags & ZAP_FLAG_UNMAP) {	/* final unmap */
>  		/*
> @@ -5457,11 +5460,12 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
>  		 * someone else.
>  		 */
>  		__hugetlb_vma_unlock_write_free(vma);
> -		i_mmap_unlock_write(vma->vm_file->f_mapping);
>  	} else {
> -		i_mmap_unlock_write(vma->vm_file->f_mapping);
>  		hugetlb_vma_unlock_write(vma);
>  	}
> +
> +	if (vma->vm_file)
> +		i_mmap_unlock_write(vma->vm_file->f_mapping);
>  }

In the case of a mmap(hugetlbfs_file_mmap) error, the per-vma hugetlb
lock will not be setup.  The hugetlb_vma_lock/unlock routines do not
check for this as they were previously always called after the lock was
set up.  So, we can now get:

[   47.653806] BUG: kernel NULL pointer dereference, address: 00000000000000c8
[   47.654967] #PF: supervisor read access in kernel mode
[   47.655900] #PF: error_code(0x0000) - not-present page
[   47.656814] PGD 8000000307415067 P4D 8000000307415067 PUD 30587b067 PMD 0 
[   47.658005] Oops: 0000 [#1] PREEMPT SMP PTI
[   47.658777] CPU: 3 PID: 1224 Comm: heap-overflow Tainted: G        W          6.6.0-rc3-next-20230925+ #19
[   47.660428] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
[   47.661931] RIP: 0010:__lock_acquire+0x1e6/0x2390
[   47.662784] Code: 46 24 4c 89 e8 25 ff 1f 00 00 48 0f a3 05 f2 84 0f 02 0f 83 e9 05 00 00 48 8d 14 40 48 8d 04 90 48 c1 e0 04 48 05 a0 89 27 83 <0f> b6 98 c8 00 00 00 41 0f b7 46 20 66 25 ff 1f 0f b7 c0 48 0f a3
[   47.665890] RSP: 0018:ffffc90004a03ac8 EFLAGS: 00010046
[   47.667009] RAX: 0000000000000000 RBX: 000000000004138c RCX: 0000000000000000
[   47.668321] RDX: 0000000000000002 RSI: ffffffff8246ce26 RDI: 00000000ffffffff
[   47.669580] RBP: 0000000000000000 R08: 0000000000009ffb R09: 0000000000000001
[   47.670825] R10: ffff888303c51ac0 R11: ffff888303c52430 R12: 0000000000000001
[   47.672070] R13: 3b97e6ab9880538c R14: ffff888303c52458 R15: 0000000000000000
[   47.673285] FS:  00007f3065e7a0c0(0000) GS:ffff888477d00000(0000) knlGS:0000000000000000
[   47.675504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.676646] CR2: 00000000000000c8 CR3: 000000030409a004 CR4: 0000000000370ef0
[   47.677975] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   47.679264] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   47.680603] Call Trace:
[   47.681196]  <TASK>
[   47.681723]  ? __die+0x1f/0x70
[   47.682440]  ? page_fault_oops+0x159/0x450
[   47.683246]  ? do_user_addr_fault+0x65/0x850
[   47.684082]  ? exc_page_fault+0x6d/0x1c0
[   47.684838]  ? asm_exc_page_fault+0x22/0x30
[   47.685611]  ? __lock_acquire+0x1e6/0x2390
[   47.686360]  ? __lock_acquire+0xab9/0x2390
[   47.687123]  lock_acquire+0xd4/0x2c0
[   47.687811]  ? __hugetlb_zap_begin+0x6e/0xa0
[   47.688595]  ? mark_held_locks+0x49/0x80
[   47.689321]  down_write+0x2a/0xc0
[   47.689976]  ? __hugetlb_zap_begin+0x6e/0xa0
[   47.690862]  __hugetlb_zap_begin+0x6e/0xa0
[   47.691707]  unmap_vmas+0xb3/0x100
[   47.692480]  unmap_region.constprop.0+0xcc/0x140
[   47.693518]  ? lock_release+0x142/0x290
[   47.694304]  ? preempt_count_add+0x47/0xa0
[   47.695109]  mmap_region+0x565/0xab0
[   47.695831]  do_mmap+0x35a/0x520
[   47.696511]  vm_mmap_pgoff+0xdf/0x200
[   47.697419]  ksys_mmap_pgoff+0xdb/0x200
[   47.698368]  do_syscall_64+0x37/0x90
[   47.699148]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   47.700307] RIP: 0033:0x7f3065f77086

In my environment, I added the following to this patch to resolve the
issue.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d25db18c9526..48370f5b70f5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5503,10 +5503,12 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 void __hugetlb_zap_begin(struct vm_area_struct *vma,
 			 unsigned long *start, unsigned long *end)
 {
+	if (!vma->vm_file)	/* hugetlbfs_file_mmap error */
+		return;
+
 	adjust_range_if_pmd_sharing_possible(vma, start, end);
 	hugetlb_vma_lock_write(vma);
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
+	i_mmap_lock_write(vma->vm_file->f_mapping);
 }
 
 void __hugetlb_zap_end(struct vm_area_struct *vma,
@@ -5514,6 +5516,9 @@ void __hugetlb_zap_end(struct vm_area_struct *vma,
 {
 	zap_flags_t zap_flags = details ? details->zap_flags : 0;
 
+	if (!vma->vm_file)	/* hugetlbfs_file_mmap mmap error */
+		return;
+
 	if (zap_flags & ZAP_FLAG_UNMAP) {	/* final unmap */
 		/*
 		 * Unlock and free the vma lock before releasing i_mmap_rwsem.
@@ -5529,8 +5534,7 @@ void __hugetlb_zap_end(struct vm_area_struct *vma,
 		hugetlb_vma_unlock_write(vma);
 	}
 
-	if (vma->vm_file)
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
 }
 
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,

Another way to resolve would be to fix up the hugetlb_vma_lock/unlock routines
to check for and handle a null lock.
-- 
Mike Kravetz
