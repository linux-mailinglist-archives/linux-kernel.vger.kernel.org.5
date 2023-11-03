Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160617DFE0F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjKCCZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjKCCZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:25:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940631A8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 19:25:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2NNv3Z029335;
        Fri, 3 Nov 2023 02:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=udsKh8ncq+b0se1w2ttnGJLTdB+hpzYHq7O/Fl772zI=;
 b=EfjjPMpdQXx+Sl7mkTly8rwEJjtiMe6iXgMHbnj1ysqT7FJb7LktMnAU+MzRGfYmLGpb
 uKG5qrN53XkQATEnOlN4NIlcU3bOzjnokQ8PqO2o+ekBEyOe/G/5cog1zv2215WT4Tg7
 sQvFgtY4Ehel/ePsFXDfiplYzjGLvgKelDTslYE04eB2Dexu66wcxkR6D8sxLEKF4Zpm
 34cBNWgm9QyykfbQPFSFVeqZtsuMRjPcs/Gey/KC6ylYQVhFyWvvQMwiOm0BjCjwNq3D
 Z+z1YB5PkdBCArk/LwKN515hZpdUNV+ZxYft7qxcF1sx1JtfzggHp0Syiq2rumy3azDu 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtu7ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 02:24:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A31Lc4Y009075;
        Fri, 3 Nov 2023 02:24:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x9a76u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 02:24:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af7401fFOlZgXQGvRwGkg0yWoIOWsr/pnuTZagkRz5iGBAejnvXhUQl+FW3KraZmAJr+yHfFWHIdH+RrtB6KgWfYNQCBlpMYqWkJCzSn8iKBCC3gc+2X2L/2gWbx4+KUHtZPaCkJUHDwEOCotftGpn4fBTCCqzZX92GgFg0ne+ulseFrcJH8O7+wdJoaiWTJb0Q7GGscKcPjq7B0LtL8OEZHuliabVJfsYGtKR/2j1+fDbaDyUyoySgeRW8PSRRiTW2MM0XnDDCfdgdf4RmtUP4xxN1NKSKB0v19RvvigJzI3alNBEGoliPNZ253xEUgPfYeP93i2mFnu/2B4K7Npg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udsKh8ncq+b0se1w2ttnGJLTdB+hpzYHq7O/Fl772zI=;
 b=ApClsNuSi0YnP4iWtqWGca4U5XQOCgZ100bygKa1dLTociKsnCfnP3t8Ic6bQfNVuv0b0iQQR9PUkNnPmJjsSSEGuBPenJmh9yqtdUeYzg7cC1XdqfLxIKAvWAwUvE4JLRRqxYw904cCVsQoDv4hE47ZJa9I+6YwYmSTlBELLY13Uf3s4MnPCF57xQqjrnv3yznTMZWl5Q3kuUQn9Q6kVmSvDNQrvF2EJC38fvHPTv1GEpmwOtDbRtqhSxcx2lkKRAccRy4Phv4Y8gbSr1Utq+WTXMlMWRAzB8uXYSM+DOwxc2GQm+Fvg+x1ySq6ewLKysenboshOww8mxPbQr86ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udsKh8ncq+b0se1w2ttnGJLTdB+hpzYHq7O/Fl772zI=;
 b=X7/HMIbJzWlQ0CODVKMxmbeT+ieScIZ3sWufwkCROTi815LSiGJy7q6aokD9mDYsjfR1ymzElngDogRK5fcTcBMODpXnsCdDq22PgRYQfAvXw2Vw1Lhb6OWDhT9hNg2h6ukqm7zTadwNdJ2+VYc2A5cG2lU3icHcQmJkoQ6sIsY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW6PR10MB7590.namprd10.prod.outlook.com (2603:10b6:303:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 3 Nov
 2023 02:24:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%6]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 02:24:29 +0000
Date:   Thu, 2 Nov 2023 19:24:26 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     riel@surriel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, muchun.song@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com,
        syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [PATCH] mm/hugetlb: fix null ptr defer in hugetlb_vma_lock_write
Message-ID: <20231103022426.GA3531@monkey>
References: <3382634358afa9b95dc4f6db8a53a136d4b9e9cb.camel@surriel.com>
 <tencent_164A247533766D667C3D873798968236C409@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_164A247533766D667C3D873798968236C409@qq.com>
X-ClientProxiedBy: MW4PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:303:8f::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW6PR10MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 484b65db-f231-4d61-e619-08dbdc1401d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hN3vVUbEXt57pjwjY++tG+oO2ZOStwZ9wBQIIpgmuzwcfeBkGyApDaW7woVmSG6n7iWoajQh3vQGU16/VBcLF9suEzNCb4joyg+wQ/Z9zrQBXjYVTQv+aPQd0H77hHf8K5HSn35bkn9r90qMC95/YbWWVLRicSP9x4W9RJ94BzwZF9zC8QnFMCPMOs7ZlQfqhLZFbDZBChvhwI3RC5x4FEtgfe6E8eyxxf9HS7htgELZNwHRNu/0gAFDfO28vlKN72ijeQfvWw2iu/oHFwVJCroaEBJsxnr/PNOrwr/eIelAxqeL5+Q7avMTe7nlGgbNuyVZcG2bthhkSMRdml3Taw96z+LIk4InLowe89U9XoHkl4gR1kuv8NqPhbD/GS2MXeXnvZRLuAWPKP/soShnQrFV7t2njTsbx4apPrrGMTbhO4CVbS5yfFTtyOHAcZLOCFywQXewoKvmI59RfIMal5BRPXJKH8s/EdHiVKnQzuPgLRiLwmsviuvVadaWtmixqmsOudqF/qNn8u/CJ3aPG9ViBlAUpdV5T5b7ZHSHhbMsUKQP1WV+dlZyygYJVryk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(53546011)(478600001)(6486002)(7416002)(86362001)(6506007)(6512007)(9686003)(6666004)(8936002)(33716001)(4326008)(41300700001)(8676002)(44832011)(5660300002)(66946007)(316002)(66476007)(66556008)(83380400001)(33656002)(6916009)(38100700002)(26005)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zhjmRSJ+Y0xaN01HQ0tDRvNKGJ03KyxJudTN/Dql8wjyz762legs0p8PVQ06?=
 =?us-ascii?Q?zQP6PUuAncHIEhqCCLc6YF9exbVSe0+VXR/MhRZb2HYk0V3IJuxXy0zPm6tn?=
 =?us-ascii?Q?SexbJYnHlyiF5BnIv0Wj2OrqFLLEuagLx0I7ylwJ7Kp5PXM28J6BseUa0Fyf?=
 =?us-ascii?Q?fv7t+1C0zpiVCxzcx0MUCusJq1xkwEG1ntjnIumeAOKZA7PRl9+OWXVwUYzR?=
 =?us-ascii?Q?CThLsoVj9iEZHp5ZJLmVa/lg68gZjZG4PzeSvSieTJ+9xan4ZOzicgTJ8sga?=
 =?us-ascii?Q?Qg9WFkcYWRgL2y0j6hMDSxthaEEq4a82ZEiSTFLBuGRvUOl+5UfoZb3oKkgA?=
 =?us-ascii?Q?TY1hfdPWIxiVSwJD2DqPzd95jLDazb0rfjh4KuCWbf4rnINGsY5xpNjt3VmW?=
 =?us-ascii?Q?UejnGtzwhRcrAfXwbS97bshlul+IL52fDKBQWkVP5VbNIeA0TRLEZp4HRS/2?=
 =?us-ascii?Q?j3s/7EsFnb8/rIGkscvgtk9AhNtJKBGXXDQ/Po3B/txdNECAAsTZxWmZvraN?=
 =?us-ascii?Q?614J9NkI6hNSgin3QnVPTD+wDYGkKwDlod5EfSMObj+AjP5G2WAIE9OqWrBC?=
 =?us-ascii?Q?Cewc+p845UX0NEzyr7jsl7xPoUYJIkqE+7lav+CHH9ik3LuULI/1Yvn4QNnc?=
 =?us-ascii?Q?Xp+3eBhb1RnNXk3UQuImZevfAmxsSEblKfFGSEcmKobmk9ws7LGgN+LBwz06?=
 =?us-ascii?Q?mBNKdqeIM5WZT+7EZRe+FDNXJtLDr5wsRKwkHQ70gj6c+IKEeol1pGfTr8U0?=
 =?us-ascii?Q?2XCOQLQk8dVq3Wo3WhkIG7HDFP8rFjRKul5uZb0cXfjgoKL0EufIFsj48Nsl?=
 =?us-ascii?Q?tMZHdfS3lKMm6nPG7jo3gTHY5MDqu23ZIDiYrmPCpZoqmuFeqWhCm4y8feDf?=
 =?us-ascii?Q?yWOEHtNiYO/WER+XdEQCyLsv3Md6RHsVLdtHnCh5iSuQ7+cB5vTo2gY8rl0V?=
 =?us-ascii?Q?tbNfJ1+XhQyItCB7cTr7SoQEOFHpdNwsOF/V2UwISHXU3bS0Yv2xo/kLk8Lt?=
 =?us-ascii?Q?bjuYTcK5fBV0x1Z6bGJb9Zu59ByrlvGzI4wNXn4plY+rR2eOQRjOoHR4Kt62?=
 =?us-ascii?Q?rUDhL2oYNLpAULoanC8hzjNMJz4FTKOPDQ3mV09d2gFFIeiEYOKKaAfeTBTj?=
 =?us-ascii?Q?DjWxtqpZ3QOsxPSYIu2rvrZshjbBHlOfarC4UP5yLAkVEr4HJjWD2xLm/SX6?=
 =?us-ascii?Q?xhHr1AJjW5FkGmm3lbS0f9o2TXwJDgM9Sv6NStju1F8grIJfy3xxIZjcnpFb?=
 =?us-ascii?Q?YMR1YmdfYL+UHuOO5pV5GWUXXpYLjRUhQQrLuWSf2Xk5fOJ2/wsgIIKhuVS6?=
 =?us-ascii?Q?JhiJE0KszRXeIRb5KL+3k4V+w5DkiVACXnpCjwYzq8zDQ1DxDfLHT7z0hlz8?=
 =?us-ascii?Q?9PC3dDW8UPw8EHUt4yrvOliwkOmT3dW+/accipbh85WDPs1Y8Y4XRFQTNqwJ?=
 =?us-ascii?Q?gH5iegw6fzWu/lN8yYfQlKd553b9waGcBlFXrSsuihZlnNFr7LNNtqp4vr4U?=
 =?us-ascii?Q?rwFPrx77fDX6CbBKgQUbn0GCvb+W9tsDZIJeUnU7Ef4sehLzWZSzKYsMzKCr?=
 =?us-ascii?Q?Qj/MK8Kl+yDzYsxmBU6VJQUc4UYD8tyUGB+i9tZ4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?gxAXzhRyISLJctNeSLVcie4RZEWC4kS9WvKw4V2MWL31jJ28GnrHUTIOJP6V?=
 =?us-ascii?Q?UnIw0GzWhU5ZDg+X3uX2Z1xisBUTLfppP2EkwfjnfoUw13/BdY6OsgGXbSqK?=
 =?us-ascii?Q?+sFyL2lyZGkhRy+ZLYmpKp7HJ0s4XnGevF8xJNILpsuhBN+8deNg+Y+5Xkcl?=
 =?us-ascii?Q?tpOHfg5jxLFg9D2lUwBa/yOHtF+evtLL+mRyBORir+NpjrUscOe/uTTPvMS+?=
 =?us-ascii?Q?+oRr+uNkuRytvo5vnYZ0+SKqzmGTYmhMolGo02BmTnvbbn1i1GQjKMFD2auc?=
 =?us-ascii?Q?jDPi8BGMiu6pHkDi3Aa1xFrtVebvxgpQOhwtVSUSDeGYItI64PLjQsowbsv+?=
 =?us-ascii?Q?iuqjcGGtJmLeRtYYPfo1N1FsfLxUfZGScvGtg95n4+aXG06+w78ZSL38IFIG?=
 =?us-ascii?Q?1mNqF5AiMteTLfoZyllChGQ8Cq8xnpdJ2b5wvVf3Jm+UznB8mmSx5FyQ2CHY?=
 =?us-ascii?Q?/Bj6Wb/1/k7k81W8jRLPvgVBuLCIULCI4KlGF2jQk+xsUxzIkGwU1rtMAzz+?=
 =?us-ascii?Q?yUfbN7PlSF6QuYudf0VC/8B+OIZjfqJ8RVHCxdabsC3e+4e2VyWnu0gqtGed?=
 =?us-ascii?Q?23DNM9aGpjm6mV2Ig/qNDKHGkrGRtreBAje0k85/ml9MQxGAYmAXRXo0H45Y?=
 =?us-ascii?Q?vR+nSfX1If9pzWK7acCACU+mTN+lp6UqthgU3lzIJ2UZdp2Rk/fw0n/CmifL?=
 =?us-ascii?Q?kueTlnLBikWQhDxOIdHZnw8J3Xaj1iMH+vug7E1wW72kHZAFapAKvha57a1k?=
 =?us-ascii?Q?7GnclOBawtD7MZuAFVk3bENgz8iM/S1PaI4U+QPTOsv4D/MRcVItMdwqOV5z?=
 =?us-ascii?Q?fXR0pVW1j8dGVJy/lFZrIJWBPGnuv0E+GjOAd71oDzz+e4lMuw8GiSThy2E4?=
 =?us-ascii?Q?1mj7oLIhzK8HSfZQJRiP1YD3fOyWSFVmmJZAPVqY9UT2TJAfIY7IbjmF03vK?=
 =?us-ascii?Q?1B+VQfwVIKWcFq3u6ci3L0AUM8oyGCe34VEVDO2sNKpD63wlbnG4HprWXLQf?=
 =?us-ascii?Q?ogeU6jM36lnlLW1jU+eZfw67R9rAe04NXaP85FhQerf0+GEy3Jn/9tIhTG8J?=
 =?us-ascii?Q?BAz0lDyAKdxEntPU5fT1qvM1qMU04L0h5tjYeH8e1oBduVdGsO7oFJ1Y6z2+?=
 =?us-ascii?Q?Tv9z3aNmKzBXlyLpnrcmL0eTv7cSXYs2l3LZlVzj9invjhElXD3ldmo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484b65db-f231-4d61-e619-08dbdc1401d3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 02:24:29.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTIjjP/wx5m8BxAxc0kwXOfCpvZMh6JAErJYwrQeyNXacCJjvZgOCm9Dd4Ylq0REcx/XI/NV/e4upiENZMHc5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_02,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=571 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030018
X-Proofpoint-ORIG-GUID: 5MGceVOk39SXZNBf_euC3HNyGd9efpCo
X-Proofpoint-GUID: 5MGceVOk39SXZNBf_euC3HNyGd9efpCo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/23 20:58, Edward Adam Davis wrote:
> When obtaining resv_map from vma, it is necessary to simultaneously determine
> the flag HPAGE_RESV_OWNER of vm_private_data.
> Only when they are met simultaneously, resv_map is valid.

Thanks for looking into this!

The check for HPAGE_RESV_OWNER does 'work'.  However, I believe root
cause is this block of code in __unmap_hugepage_range().

		/*
		 * If a reference page is supplied, it is because a specific
		 * page is being unmapped, not a range. Ensure the page we
		 * are about to unmap is the actual page of interest.
		 */
		if (ref_page) {
			if (page != ref_page) {
				spin_unlock(ptl);
				continue;
			}
			/*
			 * Mark the VMA as having unmapped its page so that
			 * future faults in this VMA will fail rather than
			 * looking like data was lost
			 */
			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
		}

In the specific case causing the null-ptr-deref, the resv_map pointer
(vm_private_data) is NULL.  So, set_vma_resv_flags() just sets the lower bit.
Because of this, __vma_private_lock returns true.

As mentioned, the check for HPAGE_RESV_OWNER in this patch 'works' because
only the HPAGE_RESV_UNMAPPED bit is set in vm_private_data.

I was thinking a more explicit check for this 'NULL pointer' with lower
bits set could be made in __vma_private_lock.  Below is something I put
together.  I just open coded the check for 'NULL pointer' instead of
moving a bunch of code to the header file.  In addition, I changed the
#defines from HPAGE_* to HUGETLB_* to avoid any confusion as the header
file defines are in the global name space.  I thought about also adding
an explicit check for the HPAGE_RESV_OWNER as done in this patch.  This
would catch the case where the pointer is not NULL.  I do not believe
that is possible in the code today, but might make the check more future
proof.

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 47d25a5e1933..7b472432708e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1260,6 +1260,15 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
 #define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
 #endif
 
+/*
+ * Flags for MAP_PRIVATE reservations.  These are stored in the bottom
+ * bits of the reservation map pointer, which are always clear due to
+ * alignment.
+ */
+#define HUGETLB_RESV_OWNER    (1UL << 0)
+#define HUGETLB_RESV_UNMAPPED (1UL << 1)
+#define HUGETLB_RESV_MASK (HUGETLB_RESV_OWNER | HUGETLB_RESV_UNMAPPED)
+
 static inline bool __vma_shareable_lock(struct vm_area_struct *vma)
 {
 	return (vma->vm_flags & VM_MAYSHARE) && vma->vm_private_data;
@@ -1267,7 +1276,9 @@ static inline bool __vma_shareable_lock(struct vm_area_struct *vma)
 
 static inline bool __vma_private_lock(struct vm_area_struct *vma)
 {
-	return (!(vma->vm_flags & VM_MAYSHARE)) && vma->vm_private_data;
+	/* Careful - flags may be set in lower bits of pointer */
+	return (!(vma->vm_flags & VM_MAYSHARE)) &&
+		(unsigned long)vma->vm_private_data & ~HUGETLB_RESV_MASK;
 }
 
 /*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1301ba7b2c9a..d2215f7647b1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1028,15 +1028,6 @@ __weak unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 	return vma_kernel_pagesize(vma);
 }
 
-/*
- * Flags for MAP_PRIVATE reservations.  These are stored in the bottom
- * bits of the reservation map pointer, which are always clear due to
- * alignment.
- */
-#define HPAGE_RESV_OWNER    (1UL << 0)
-#define HPAGE_RESV_UNMAPPED (1UL << 1)
-#define HPAGE_RESV_MASK (HPAGE_RESV_OWNER | HPAGE_RESV_UNMAPPED)
-
 /*
  * These helpers are used to track how many pages are reserved for
  * faults in a MAP_PRIVATE mapping. Only the process that called mmap()
@@ -1162,7 +1153,7 @@ static struct resv_map *vma_resv_map(struct vm_area_struct *vma)
 
 	} else {
 		return (struct resv_map *)(get_vma_private_data(vma) &
-							~HPAGE_RESV_MASK);
+							~HUGETLB_RESV_MASK);
 	}
 }
 
@@ -1236,7 +1227,7 @@ void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
 	 */
 	struct resv_map *reservations = vma_resv_map(vma);
 
-	if (reservations && is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
+	if (reservations && is_vma_resv_set(vma, HUGETLB_RESV_OWNER)) {
 		resv_map_put_hugetlb_cgroup_uncharge_info(reservations);
 		kref_put(&reservations->refs, resv_map_release);
 	}
@@ -1282,7 +1273,7 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 	 * Only the process that called mmap() has reserves for
 	 * private mappings.
 	 */
-	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
+	if (is_vma_resv_set(vma, HUGETLB_RESV_OWNER)) {
 		/*
 		 * Like the shared case above, a hole punch or truncate
 		 * could have been performed on the private mapping.
@@ -2763,7 +2754,7 @@ static long __vma_reservation_common(struct hstate *h,
 	if (vma->vm_flags & VM_MAYSHARE || mode == VMA_DEL_RESV)
 		return ret;
 	/*
-	 * We know private mapping must have HPAGE_RESV_OWNER set.
+	 * We know private mapping must have HUGETLB_RESV_OWNER set.
 	 *
 	 * In most cases, reserves always exist for private mappings.
 	 * However, a file associated with mapping could have been
@@ -4833,7 +4824,7 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 	struct resv_map *resv = vma_resv_map(vma);
 
 	/*
-	 * HPAGE_RESV_OWNER indicates a private mapping.
+	 * HUGETLB_RESV_OWNER indicates a private mapping.
 	 * This new VMA should share its siblings reservation map if present.
 	 * The VMA will only ever have a valid reservation map pointer where
 	 * it is being copied for another still existing VMA.  As that VMA
@@ -4841,7 +4832,7 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 	 * after this open call completes.  It is therefore safe to take a
 	 * new reference here without additional locking.
 	 */
-	if (resv && is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
+	if (resv && is_vma_resv_set(vma, HUGETLB_RESV_OWNER)) {
 		resv_map_dup_hugetlb_cgroup_uncharge_info(resv);
 		kref_get(&resv->refs);
 	}
@@ -4877,7 +4868,7 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 	hugetlb_vma_lock_free(vma);
 
 	resv = vma_resv_map(vma);
-	if (!resv || !is_vma_resv_set(vma, HPAGE_RESV_OWNER))
+	if (!resv || !is_vma_resv_set(vma, HUGETLB_RESV_OWNER))
 		return;
 
 	start = vma_hugecache_offset(h, vma, vma->vm_start);
@@ -5394,7 +5385,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			 * future faults in this VMA will fail rather than
 			 * looking like data was lost
 			 */
-			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
+			set_vma_resv_flags(vma, HUGETLB_RESV_UNMAPPED);
 		}
 
 		pte = huge_ptep_get_and_clear(mm, address, ptep);
@@ -5544,7 +5535,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * could insert a zeroed page instead of the data existing
 		 * from the time of fork. This would look like data corruption
 		 */
-		if (!is_vma_resv_set(iter_vma, HPAGE_RESV_OWNER))
+		if (!is_vma_resv_set(iter_vma, HUGETLB_RESV_OWNER))
 			unmap_hugepage_range(iter_vma, address,
 					     address + huge_page_size(h), page, 0);
 	}
@@ -5625,7 +5616,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * at the time of fork() could consume its reserves on COW instead
 	 * of the full address range.
 	 */
-	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
+	if (is_vma_resv_set(vma, HUGETLB_RESV_OWNER) &&
 			old_folio != pagecache_folio)
 		outside_reserve = 1;
 
@@ -5865,7 +5856,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * COW/unsharing. Warn that such a situation has occurred as it may not
 	 * be obvious.
 	 */
-	if (is_vma_resv_set(vma, HPAGE_RESV_UNMAPPED)) {
+	if (is_vma_resv_set(vma, HUGETLB_RESV_UNMAPPED)) {
 		pr_warn_ratelimited("PID %d killed due to inadequate hugepage pool\n",
 			   current->pid);
 		goto out;
@@ -6756,7 +6747,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		chg = to - from;
 
 		set_vma_resv_map(vma, resv_map);
-		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
+		set_vma_resv_flags(vma, HUGETLB_RESV_OWNER);
 	}
 
 	if (chg < 0)
@@ -6853,7 +6844,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		 */
 		if (chg >= 0 && add < 0)
 			region_abort(resv_map, from, to, regions_needed);
-	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
+	if (vma && is_vma_resv_set(vma, HUGETLB_RESV_OWNER)) {
 		kref_put(&resv_map->refs, resv_map_release);
 		set_vma_resv_map(vma, NULL);
 	}
