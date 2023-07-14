Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30062753E44
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbjGNPBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjGNPBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:01:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5D81BD4;
        Fri, 14 Jul 2023 08:01:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EDQb01001141;
        Fri, 14 Jul 2023 15:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ilVDoeo/O0CHMM74j+4G0XxNLY4fRYeJhFvpHuqGevA=;
 b=pq9Kt9EeVDi4iZrDm+yf8YjRrXpanuKlwKZ8OUo0eJ44OwwwaZcfen0fWOvhcAoIAFDh
 GdMucBaBLnDfTe3jScjHiyHwYtVjQGwwRSDUHYbVVhx4pGKWtwXGQIfg7aB+qlsQeVcJ
 7R3szcpoD4lgOych3BjDqqJlBCjqy1vEWX5fJ15JvL/xaWS/76OcS8Z70OY3xJHoiWzI
 ycCUH++7laJUfTekrw9RbFDISxgvTsLUjpWZK8DJ4XLO7hmaJESEU5G2qpcua6xLXzGY
 dvGVE+LlPwq0TgfAN8rkfwwyTrvZicR+if2jNEMVzvLHS5b13bGgZ/fSBuMeIefRHGaz hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtptn1q6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 15:00:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36EEE1vl023323;
        Fri, 14 Jul 2023 15:00:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpvx9e56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 15:00:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSXyWbonj9Nyz0441tHLAq7EN72pY7nYJCmJxjkU0OpQgmlZ3E9yjIVSAbuJ3YtzjZMW2vduj3g7rP7ja4HNYMv7Xac1ecwgGFSVBihta1E5HiOUR/CRpX82cYcR3iAD1aqC5fq0y3a/gYa7KRFw5c1Ssz6jm/BaLVtFhliTzj18Um6QQzcCQ7Mbs9BoUjy+Hd6Scxdw1vsum5WAAQgAHjPamUjGGCL9xwgQe/eNdMQn815LZAriaARcZ42wVcZiIVL4egLxqdMNMfEIrx+a0nBhY+ywEE50kEuUHdxOs9mOoxJ+y1hVQDMEeRSkzjU2B/ROoVDS+vDaiOjeLxw3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilVDoeo/O0CHMM74j+4G0XxNLY4fRYeJhFvpHuqGevA=;
 b=lqSWu5hVxidaT0z7WKSEYvD1rez8vweb8jgGtmPTrLBEeEDTdzPJ1TqGCOC56mRqKwvIgUzthzBrXhh6Md+T8YAQFoCSgJlZ48JN3IFu34BqjCDPwaThblywhhPtxCrYXVOFUTXa/yVjtrO5EupIaJNyz4uFMuF5GKFm1/UoidHIpHGAtZ7H3Avh6nGL4hzQhZzBexWZGL8X3yrYMc+1IaaclTp/2Ymjk2l7iroFNjBtjUAYcJXIS2qw54lJrXSNcHzhH4Q4ZUvbS4mi16p+Vwel4qIVxzVWm32WdcdzI1jv3Psgn6nJxQ65z4ImDwKYqJqunL1h0Fz/+0jZ9hqMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilVDoeo/O0CHMM74j+4G0XxNLY4fRYeJhFvpHuqGevA=;
 b=tYYIpJYNmDWxJhqR4f1wm5FJH4xcOrc+OcrAbGYWnhDezHoVtHDTkjux5nL9AZCT6e5cnLMe813UIWCpdCGA2LUGfsvqTfnfxCn7jh6gZTXYhBFdutdFvYwwppxEykuc6LBCTkUuYUP8/FRsx4wzsMXIzRdMuBEoTMaly5ayPzU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5207.namprd10.prod.outlook.com (2603:10b6:408:12c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Fri, 14 Jul
 2023 15:00:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 15:00:43 +0000
Date:   Fri, 14 Jul 2023 11:00:39 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hsu <John.Hsu@mediatek.com>, stable@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH stable v6.1] mm/mmap: Fix extra maple tree write
Message-ID: <20230714150039.xr4wdigb6us27ln4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hsu <John.Hsu@mediatek.com>, stable@vger.kernel.org,
        linux-mm@kvack.org
References: <20230706185135.2235532-1-Liam.Howlett@oracle.com>
 <2023070748-confiding-abnormal-b7e3@gregkh>
 <20230707164507.mfekysya2jyupghp@revolver>
 <20230712005442.r5ehzbkcxu73whvb@revolver>
 <f8177a33-f341-d285-ff9a-24fdd3936f9a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8177a33-f341-d285-ff9a-24fdd3936f9a@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0003.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BN0PR10MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: e36d88bc-2c19-4a63-b305-08db847b185d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /K376JiU8Z1BgHz1OjhMWvr+A0uBPowhkqeW3B4mr4a/cxUtPa6/2sFTCNvLyi4gieoYimrwy54sFxL6HYKfiOe8mHnBh+2SfOo2Q2rfhRjr7/Sl31+agBEVipJMkXVCQyH2AZckM095qNWqz1WIzH/tyTDqehb70IZ40p5DvhxZsxrujScru0qfilMF8OtFWU2ZZzXdk8h5Cf0gK8nfxGDR/L2mzwdxU8Xrms+aFnCdoytZwgE+W4wcfgxehXWCQ2sgJHsyErw10HvGBATpSZCeqA92fX87a+zaIyPaoPxAUjRb1fK6TYwUjcY88aaGDd6zoQbVcKuJ2Mj7B50jURd5l4Fz3+bMec6DnXoXwm/j7ilYg68fU7cAzUhpEnSzkYDgUYSUo5p/XT4oUPoVw4IiWWg+JS6YHWx346DNNVDY0T6BJdmjwGzO6YTdB5DE7dTpI8vtpKX2wutMFKkK99v/ZCROLBl+oo7v2lgfMRDuKDcvk7iLGtqSdV1T2c1SlLYpVM1EubV5bYI7FY2OQZAP5+Ui1ENM4z7Rt1StvPjqpnudyhKHjY+XoKjsv+qf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(2906002)(33716001)(38100700002)(6512007)(186003)(9686003)(26005)(1076003)(6506007)(53546011)(5660300002)(86362001)(8676002)(8936002)(478600001)(54906003)(41300700001)(6486002)(6666004)(316002)(4326008)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9R7W1Gbx737lndr+Q7R9mp7bPGvSYR9kaTJDlDbRv12zMo1e8VRdH64jH68+?=
 =?us-ascii?Q?jG0lxXA/PXlTFtiJzqnruVwOhRqNNbTuKzj17RcI2KO920IFl1a/dLd5z7HW?=
 =?us-ascii?Q?ohkPI2TYgPgNitT9Hce+HYHyRLCv0GRuiVW5hh+ec4mWuluM9UWvZRFYosQ5?=
 =?us-ascii?Q?cpWjGI6xoV09er7oWEqtpU/PdLnXnuI+tJ+5A/7YOS2lZRawytHYZE5m/5o3?=
 =?us-ascii?Q?mQgDnvcqkhW8jzan4TFbiEFO4giUJRVTwjLg7YFplkcplzW/7ELlXyAeO74S?=
 =?us-ascii?Q?WYgFxcNLbDMuAXONZ8R4ZPHyzmyvu2+TP9ciWQkEYMgVcj9mmEDg49qzH+Y4?=
 =?us-ascii?Q?IxLAc1LtERh9ZvbticgBfAEKyWokatjJLNTfFbgg2yjqR3KvWN4LyXo58sYR?=
 =?us-ascii?Q?FP+ZcomwWfJ+vQ5jW+Sw2FjVjwtPgPcqsezygbaZiYltvr/hGy4CFauN0RLT?=
 =?us-ascii?Q?W9rS5UGs8W01VSiQSGPvi9PDzi5BywqFwx+sFD0p4Hr50L31QkZC2CUKRYvQ?=
 =?us-ascii?Q?Dh0yDXBFzhvbXQ2SFHEXjpZemyf2bqjqLdecKBUcKnfXjU0Zf7xL8JKdIaG6?=
 =?us-ascii?Q?rTIGO4u0PwweyRELU5tvIXcATGE76R8M+n5YZ3XvPrsKY3CHnFxjNGSHpFj4?=
 =?us-ascii?Q?QKKEBbyPt/3msl0wV/4EsLWf05qywn/V5Wg08iAIas3N1n4y0LyTgS2oNfxP?=
 =?us-ascii?Q?iJaVmii36brWyJxhCvY/pY9GYQmwHFluH2Eg12FloyBl5CQn2kyF9NRwGUlR?=
 =?us-ascii?Q?DJECLKSMQV2d8Lhuhq7gLxbuYSuk9rw1qLioVFYhc17P9XRPUcp1ukXtCzjB?=
 =?us-ascii?Q?DeVVrHWQ3+DfSMnB01L6SQYQoOSTK27o3b7CY65x1GVSRe2AUXo1/MkkJAGE?=
 =?us-ascii?Q?Mh8MFdLWpWGM1N3iT4/tIjKBsylQzZW5gBi4ZBwIm3eGHtAJO1i6T1SxYoit?=
 =?us-ascii?Q?ObXv9Lb0raopC3qT+ps4CAg50lFv/kqsctTewGly59/fmX+pUaMFr+f8gAxi?=
 =?us-ascii?Q?+C7uP8p+7m55V2plUrpt7Mn4Mlb2FjHnAtGuAc8cQ34f3MCIqNmkRA96xPmZ?=
 =?us-ascii?Q?hn9v8H7sUUXfieLlduFbQtMJ5FO8LfPOe6i405DfeKvc5GAAdlPLLktZXn2k?=
 =?us-ascii?Q?H2WeZuE/ioxqXFq9BTvI9GjKOArM6reHshAPOkCMsnA1obN+PcaF/lHyeXZg?=
 =?us-ascii?Q?QxGjwSOkVQ6caA45ysa3ebA7U6AbsoAmZ/z74ynVQa4bZQgbES6X1Vh7Q0bp?=
 =?us-ascii?Q?SIUyaVuZU9m5PZKi82MBGsWB2TU/xg1En7Y5RaxyxMhj8o8ymN4ZxlUYZurd?=
 =?us-ascii?Q?sc6hI+6g7NADBDpMBotMXwjlyT5VO3H+LEGzbKWBoue2gaoEOqRqzNpSqNGG?=
 =?us-ascii?Q?k4TquNRKS+ui+JD+Bt/zmLTRk7ANZjuypEr1+7M/GMNK4EIYFi26ovh2JAhl?=
 =?us-ascii?Q?5Ewqwp9j6Tq5CCdp4ppQqOSum3v0Fres4A4CCwmh3CzOwSnuzEePaUyvdSke?=
 =?us-ascii?Q?oj/Sd3nnuCbzryple6wYmZz55AwJQsY0GGlDEu/vOprHlB240OXZ6v7ciidh?=
 =?us-ascii?Q?1zFA08WaPDegxf7x5Ma05yyC69uGdJS6bFQDBgVc1hmdC+w/bZ0ziszd5/4W?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CKEyE1OBTYLwTYLvO0RqYEa2OFViG7fGjsfB09HE5gvvWrRBlpqxWxUhIJdD?=
 =?us-ascii?Q?5Ov8NgAaEsii/8YOd8WXyvqHTU7TwT8Q8eU9nxLwEO0nwGTy1oYK7jPFALax?=
 =?us-ascii?Q?Um2ietljB5JNI7NKqoa33pLaD4FWgNTRpSQ1hMRF7ATvrBUzlOXHcy3+/Ssk?=
 =?us-ascii?Q?kDY8jznNCkxXDn2m65kVqkPNNGvthkaGQGDFX1xpKnIenFpeiI0nRtqYILu/?=
 =?us-ascii?Q?iiHXYnjWTZ806g5mAr/QiQscuZwZ78gsc6NfKvdaniAFavEP8+yusImSVAH1?=
 =?us-ascii?Q?u4/pq6/HmQd5mW5qwlncqPibULi3iqpYDkK33uCXiuqPk18edrIMWx1+slrI?=
 =?us-ascii?Q?3p7MUDdhXMMWIs6YZFUYUHmSnnuKnGx6/o9S80vz7pkX/jKczEq7g5Ngg6ed?=
 =?us-ascii?Q?Vj7FiuBxM2/jzboBF5hpxNcL1U1OPn5tuNWr/IsiGJ+yi/YAvJzMV3Kv3nX0?=
 =?us-ascii?Q?b8wkLIHjdhgfb6ARXz58iwGRr8NxOCuhyoqCRgLGw9PvC3eHrI3HwLyf8+F3?=
 =?us-ascii?Q?pHnpq3MtgRMK1pwgGCT9VWtPAtU3fZxbLd+BFEjBrDMPUHjOkqk1X8OlswaY?=
 =?us-ascii?Q?yc/EJ5TPXRcWcLtCU5SyIcFNWjHll3pnq8S6V6fz5/sJFO+gtCAQhKy7MmBj?=
 =?us-ascii?Q?acR6vxLh0moj11qX/DAUxDcNz0x5q1+Ro7qU7JU3pFO/OhPpX+Wa2kL80st0?=
 =?us-ascii?Q?ko7x1pUuzX5xXMwTpo9+soyY56UldxTZwfk+cHBOL2NDy9pQwhCD4o8SL9g2?=
 =?us-ascii?Q?B2soNDVq9LGbGIWxem2/Wq7/3+upDubsvN3in35Y5rbUOcHk9Vdgkz0S+HRW?=
 =?us-ascii?Q?YKLUbUxP1DLBpm4NPoNdpVW43XdDuUMWhQzaUNy1LtY4l/wIDvKYpYEOOwFK?=
 =?us-ascii?Q?jYSTAgz5QhQEsMHcSFTJGh5tNZDr+nleTgaUWtDzkA7jzFkZ5ZQwr7SuNhwH?=
 =?us-ascii?Q?KUkAThzYXU5dKaQDWjnFOg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36d88bc-2c19-4a63-b305-08db847b185d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 15:00:43.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fW7pbRFhPLTXA2ch1pda8KhdYwAJj6pwvyFBX7f5yj2B0RSF/2FyNJt4ntsXn/KhfFrRhWkjN4VQSxPI26cCag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=811
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140136
X-Proofpoint-ORIG-GUID: aLL4CqeaLiBCXLiM2Yg-eenTpDQTnYIU
X-Proofpoint-GUID: aLL4CqeaLiBCXLiM2Yg-eenTpDQTnYIU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [230714 10:44]:
> On 7/12/23 02:54, Liam R. Howlett wrote:
> > * Liam R. Howlett <Liam.Howlett@Oracle.com> [230707 12:45]:
> >> * Greg KH <gregkh@linuxfoundation.org> [230707 11:55]:
> >> > On Thu, Jul 06, 2023 at 02:51:35PM -0400, Liam R. Howlett wrote:
> >> > > commit 0503ea8f5ba73eb3ab13a81c1eefbaf51405385a upstream.
> >> > > 
> >> > > This was inadvertently fixed during the removal of __vma_adjust().
> >> > > 
> >> > > When __vma_adjust() is adjusting next with a negative value (pushing
> >> > > vma->vm_end lower), there would be two writes to the maple tree.  The
> >> > > first write is unnecessary and uses all allocated nodes in the maple
> >> > > state.  The second write is necessary but will need to allocate nodes
> >> > > since the first write has used the allocated nodes.  This may be a
> >> > > problem as it may not be safe to allocate at this time, such as a low
> >> > > memory situation.  Fix the issue by avoiding the first write and only
> >> > > write the adjusted "next" VMA.
> >> > 
> >> > Are you sure this is the same git id?  The one you reference above is
> >> > _VERY_ different from your 2 line change below.
> >> > 
> >> > And the changelog text is not the same.
> >> 
> >> Yes, but I am not sure I've indicated what happened correctly.
> 
> "commit 0503ea8f5ba73eb3ab13a81c1eefbaf51405385a upstream." is indeed not
> the best indication. For stable it would mean you're backporting said
> commit, which is not the case.

Okay, thanks.  I am certainly not doing that.

> 
> >> The bug exists in the older __vma_adjust() function, but I removed
> >> __vma_adjust() and inadvertently fixed the bug.  So the bug doesn't
> >> exist upstream *because* of that commit:
> >> 
> >> 0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")
> >> 
> >> My comment after the commit id indicates what happened, but the
> >> documentation wasn't clear to me on how to specify what happened.
> 
> I think it's because the process discourages stable-specific fixes. However
> this is the case where such approach is much simpler than  backporting
> several series with non-trivial vma_merge() cleanups and subsequent
> follow-up fixes...

Thanks, and I agree.  I want to avoid that at all costs.  The chances of
introducing subtle bugs would be unacceptable for stable.

> 
> So I agree with the exceptional stable-specific fix. Can you pinpoint a
> Fixes: tag? Some of the commits introducing the maple tree?

Fixes: 3b0e81a1cdc9 ("mmap: change zeroing of maple tree in __vma_adjust()")

Thanks for the response & explanation,
Liam
