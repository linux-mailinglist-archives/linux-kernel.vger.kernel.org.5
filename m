Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE37C91A7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjJNAFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNAFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:05:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52448BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:05:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DLJLPm005956;
        Sat, 14 Oct 2023 00:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=+/n0FF7MfY2ZvOJaHSHihAoTpNI37cX5WC5eYdetTtI=;
 b=c+rbEyFNT61iiNAH4mV8D6L766OE/E0lqGErGW+qB1XuqoZYbgmfbUc+D8/OObA0Vgrr
 dNQOF/53EaGkS45Od8VVWGAC/Uaz4dquuD5lEASq6GfEWNyMSoIuv4VdDyGRjVGyC0Kp
 rXY0UC3l/AV/X1AITuytmDWyAZ+3ZYv8FlXphOUGRq7y7xW5P//BwIWwNKUXqagAx7U3
 UkdPyd8uTGAvYNwZhZ8HsFXqJnVdHiLjPuxgFI3tOXeFO2zxwmB/Fw9ik23RM2Tg7FVi
 +ixH+zHPaan7ekXKl0TyPLuWKiRVpipuFezYowSRLdIREB+kg0RIPidBgjMwfYH6fs00 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxue36m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Oct 2023 00:04:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DLJQ3F020217;
        Sat, 14 Oct 2023 00:04:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tptckb99x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Oct 2023 00:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwSqizJ1dP/S7KdYmek8gV95QA+EnufhnUdrQMGOIqJSIQ4s4RQmvvFBWfdQML1doHQNg2WYZQ+0nBGXRLvTjF+MqL2d5O4pGIckWFe1r1eKaI83dXeJpudixmd3GnDrTZXbHyhyZpSghWmT8XTHWm+36zsx/cvbHc+8tp33DCVUi8vGRgyghEA/MC9d875mH3MztrwNMELNFEpExpXQf1yvRoW07YZvb2OVzT7h+SCHx81HbYnScRiaJSYl9Pcm697k4eBoSmOfH9Mvr4szWVc4tQSyMqrEGXoaZfmHLg694tmq4cQbI+DX1xsiE5E+cSnzHIinQohZ6wh3ed82GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/n0FF7MfY2ZvOJaHSHihAoTpNI37cX5WC5eYdetTtI=;
 b=R/D3ItJ2bDup8hBopfnr8wu8WcOhevKwa/NyMef0Ld+7h4pLpXEcvJnGwkxO8UHQI3uhAnIJykSeyWzYDyPMwP2RLcGfIK9ktYsHzgH3n1IajCNrFPPCfFIkjfDykkZORC2KVxNzSZm18vyprzT9X0oRlqkpviTYFZgeSHDFD2UUlfXYqnJu0XguYXVYMyKBNbd6CW6Y4HY/Gpl1Gd+p9+5MHvwQgRP1EHR2N6ApkfKxrTdGa551h8h2krm0xWu8eHqdiZjXuA8uOn7RAAnEJx4MB9KrbLdFTRcnlh8LQKPLBe/hdsDQgQDKqUWQo1ZNGtaXD9C4rdEkZYj/ts3JmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/n0FF7MfY2ZvOJaHSHihAoTpNI37cX5WC5eYdetTtI=;
 b=wQInknbgJ99LevASJBgmNVTwO0pmeRacPdokXQZCi+PnjIM2+LOsc1C+4QQseINHHGBcLB6/nHONJs0JfS5Rh3q0TAGMQmF4R+aUpwHf8ZBeOWUSK83asnqZ1+DJDeLPQ1rMPHjmXTLV6YKtTl2jDYLMSz4btd/vn+GNh3pLN8Q=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5248.namprd10.prod.outlook.com (2603:10b6:5:3a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Sat, 14 Oct
 2023 00:04:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Sat, 14 Oct 2023
 00:04:53 +0000
Date:   Fri, 13 Oct 2023 17:04:50 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] mm: hugetlb: Only prep and add allocated folios for
 non-gigantic pages
Message-ID: <20231014000450.GA253713@monkey>
References: <20231009145605.2150897-1-usama.arif@bytedance.com>
 <20231010012345.GA108129@monkey>
 <20231012000327.GA1855399@dev-arch.thelio-3990X>
 <20231012145318.GA5127@monkey>
 <20231013001203.GA3812@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013001203.GA3812@monkey>
X-ClientProxiedBy: MW4PR04CA0340.namprd04.prod.outlook.com
 (2603:10b6:303:8a::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5248:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0d83e3-1159-4b7b-3465-08dbcc493125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +M3taQaWpS48+jkEiNotwFr683ctvA9/d53LR7nZeM+CP6mTsrQR9SX6sDBWWL+3eXlIR/Y7LaA6saaXjI9QsT4xSWGrMrRl7czRS24+H53ukDdYL0hf6fQVe8vp/2RcaPA2BaaTOwP4fcOvyaZ7b01DK7ZqxwwefT5B14z+6HZtSUyfbNKtB6+xqN9E0GybzSgtWRoBqBJJht1NztSTqjUKSDWii7oxB76CENQTsphcnVrd5NkhTGnPshyljOH4ZYKS4TCiJ+L8/VkCG23gqMcLNBOGwvhZqa9Ptt4/UQGiNEshLO7yGQ657DrIpNtvwxxUPTIado8bJC8jSR1iv3hfFtGX7y/mSWYDtTXQ+gSDG3y7W7HeJLj8Z9P34g6d7ZtgLZSP3dopgcteS4ae6kDEaLrjI+JPkfOZXpXBHecEgb9YT4ovk+lyCFnmKYxBvYiloX6DeCdr0XXmdeeKjxssIftKbG/vW1aCz1NVhtH2UW0TNJccfRnMHSjdjG86rxCPwRDdyoju2mQQeVcvNA7Boy7yptdhyT3BTSaS1cQpBYen1lbXR7mE6e81JrQY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(53546011)(6512007)(9686003)(6486002)(6506007)(478600001)(316002)(1076003)(26005)(7416002)(2906002)(83380400001)(33716001)(41300700001)(54906003)(66946007)(66476007)(5660300002)(8936002)(6916009)(4326008)(44832011)(8676002)(66556008)(38100700002)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QM09jqWZKTD9+YC1WuoT1MO3urCW47xPYgnHgxmtsqUJnzWZ5x4uFJGn0u0h?=
 =?us-ascii?Q?w3AyZQDKFZZfI8qZRbBNrfr3xIy8UVxMyrQEYZhtXnNnl4KN+/eFnO2bX4xK?=
 =?us-ascii?Q?ZhVWGz1xa0bKqFCYslvZ7cPUWWjRaqBEfiaquax4J6oFzDcZ4B5lmbKgY6Rw?=
 =?us-ascii?Q?UXuBRKKrpRx+dpziU5gqOlVcbjs2POoJTP6e3F1zlSheoJ/+1gVAoK8wBI7C?=
 =?us-ascii?Q?DYa6/8dmOhqncFVNHZV98y9SHQZp8gQ3MsUnsqwPwyRJWnLF5OZDHTOc8xff?=
 =?us-ascii?Q?0lUBAqrKP1HnbzuQR1YlCr6NkT6fBV0p/12KQMMcyMRKpMJexIvzY523HLfK?=
 =?us-ascii?Q?FJOL5MfG406Kz0mQnDslePcLF/Y0ZXrlOdeKqKpMDCKksMFWvYCW0HgGfXdx?=
 =?us-ascii?Q?Jpm5N7svtIA8WUQdd/GrRwx7tKSNyJRa5pZWIrJHzP/6aF9JJlOcVWVVOz3l?=
 =?us-ascii?Q?/8svdsMZY08ZZLcyidnQVvJrSl7n+BrRSE0itUZWhxVF9TpdYJRrRHnB25Pc?=
 =?us-ascii?Q?bGmTG+wkYwYDa4GshhO1EMjVFEFR5VLQBKq0O4nFKxDcfBuvFlam2IYLKSLK?=
 =?us-ascii?Q?vvCVaiokphLgy6WQqIqinxpkPsbPpDSVrQkGfWMb2h3V+o6H2kb46/ZCeZ1E?=
 =?us-ascii?Q?SRdCZEQIZz1eWcV8IPh0f4tUG2/NjFzshRw9V9Wy73WbH6GUMIMGJGvRAieV?=
 =?us-ascii?Q?6CJ+nknZJxGOe+crl/0x70P936UnD5QGtImIxqrJXT9POmNC6PS7f1ucLbD7?=
 =?us-ascii?Q?4ZM0yRXZK1bSsFBo8o2UbGBLeuOKCJylJ2Xvvf7wbQkQdyP2BuWy7gLkfHQl?=
 =?us-ascii?Q?SRaemr5pKP4fs65d0Dv8hBDqzzwwEB9oJqyX6qW1Lh/WryDpc8d5/1jl1F72?=
 =?us-ascii?Q?RZ3Oxoe+MXkazdeo7La3mHrszmFvHMP/Lw1bdASNrkI9cBunwuuI55fwN0Fc?=
 =?us-ascii?Q?F6AJe0YfdDQGnO+c2rFFGL5CnRSH5FpZ2wldf08Z6ctPwInRTiG8DtvCXlcM?=
 =?us-ascii?Q?STCxT7fhZbKTrZ/ps3mwBPLFIX43K38/9dqovnPpld0neqyh0TOByn4L+GZ1?=
 =?us-ascii?Q?fpILnBMX4wL7MD+3Nr6jiPMkTE7+cIGVs3m8cikpxRsDYX/bqwVUnoIGj+oc?=
 =?us-ascii?Q?38aCERnIaw9WN0fdAiHxxPrdWW/q3zLLfcZBNcxcPTtmdkUttdBUwYg0p7rH?=
 =?us-ascii?Q?9Yf/dWCExzamfXgXM2w4Xt6E1gQtFD/tC3HCa8bFLqlqt3BIMiwsDnX5T16q?=
 =?us-ascii?Q?tg49qkcZXMcR9965dE4n17yHBGYfvH4e7599hF6OR+eAb+UlC8o3vVFSjePE?=
 =?us-ascii?Q?DD8rFbR8gq/LdO4gQ2G7yWQO5xBD8IoFh1CoEF8CGSrbB2Tugl3/eP876FGj?=
 =?us-ascii?Q?lbrvg3MoWyciXc6zd6knlawQW2UulQtYfPIpZEk/rFpoxQhjUcfoayRun173?=
 =?us-ascii?Q?/mPTsIPrYWohaAO4aGlwbQJnEC6t0avTYpI/NyxzxiA+NoPrTt0tangB/9LM?=
 =?us-ascii?Q?N1faeirZ2m0mXrljECceK4fNv8zDaPuxZL4oulS2pcxwEKOjzkuAof/c6xqW?=
 =?us-ascii?Q?r5RG1ajnOBWDQYoJ7Irg7Y5m3OMG0w/9mSKuPefqqd+gAQKOBzdS+NHuJsnW?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6zeJcAt6VbOru12HXqSDch8ntbpU8f1kN/dDN5/fdDWC0BtZZ7AlwYDpH/W7?=
 =?us-ascii?Q?Z9mV93VwvhCVkL/wyt3n0WLOtXxC55GQoksaa0g+f/nc6wnlhdvbAlsTMuIr?=
 =?us-ascii?Q?aUgM2a0tCKKWsxpNiyCvOr/WOjQG0kutXU9jKfhftuwuL5yZLABMuq12pyHm?=
 =?us-ascii?Q?9EpJnu1j5DszJJvLXIC/DKv8esVEWaewf6q1TVaAJ9kVJ59XGGnzf6NdLR/A?=
 =?us-ascii?Q?vXIQmLtrR6OFqc9f1LLwKekY1NUoJN+QCJy31wrDxPP3s5VwufUoOWYIam92?=
 =?us-ascii?Q?zjRiE3yunUtnwCPprR+z85619N00FVWyjNuqs68yH+WQdVR1nXVkwv0dgQNH?=
 =?us-ascii?Q?DWGOTL0DFJDOYqbnb+jOjWR7YHreWsdQ0a856M6OVYXnHp8MBhk4F2anBhjl?=
 =?us-ascii?Q?DaKE52gIB3WgWQR5yQqaJsrtXyF+3Zlpu+2HsrAkkLFbp8DsKTDMXJ4LlEK3?=
 =?us-ascii?Q?1kmqmc53VL1hWoGExBiWYKDZKC4yHnwsskefGlNktQOAfjErxOMx5OE6xJNN?=
 =?us-ascii?Q?o9qXdSmAPHa/jbsiR15nZEO8BKTHG2KI4NcTGMedVCvMNdrjAFFFaPLYHqF/?=
 =?us-ascii?Q?f1lhqjUOB36bMdB7JkCULmlQyPtHn5sLmZpI2Mj1r9dKVPEE7B0HXyFXKm81?=
 =?us-ascii?Q?Ip2F85OZ9L1Bx3r8FFZ2TXUB+3WQTWg3PVGFW+4fdJIhjErJ4er2R/d7nyu1?=
 =?us-ascii?Q?jfQ33vexANBZWrXpds9rht0Td+DwOCC7KbnyjxM6H9e7WaIizFIs7UwtZmBv?=
 =?us-ascii?Q?hPprAdY4hMgmVJLeu45/XhX+js/xYGUi7f3cf8nu7c4yS6HwHtd5sZgf79FM?=
 =?us-ascii?Q?0xUuvS65pAozzZqPwZo9jlsxKdOXugJbdUkefrMCoRuxM2qApbpNgFDKsUgN?=
 =?us-ascii?Q?In7mLVsPv9zuuLQHBzihPPhEO2d8DEKNN2LDPoWXsqMKY47ODvlfeXsjr3hg?=
 =?us-ascii?Q?Ie18Ppcx3E40k+p5rETG5y0JjNiC2WmavuRIqFZrT4MDrYQ3Iqi/g2mTFhIR?=
 =?us-ascii?Q?2swRYgK17mC9ExbGSPX2OMLm/oJEv8UzYluN3OTHpALRn+Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0d83e3-1159-4b7b-3465-08dbcc493125
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 00:04:53.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q///OlfSCRkbeHbf2cbkU12XtJWANdQfMSdZuvlyvmBKwaMzLYCDiqJ9BiRIxwebVmjH37BTgVX1lu+3EXICjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5248
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130210
X-Proofpoint-GUID: RgcUmO2XoF4syjyKg8bKC_6G_8TjyAyz
X-Proofpoint-ORIG-GUID: RgcUmO2XoF4syjyKg8bKC_6G_8TjyAyz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 17:12, Mike Kravetz wrote:
> On 10/12/23 07:53, Mike Kravetz wrote:
> > On 10/11/23 17:03, Nathan Chancellor wrote:
> > > On Mon, Oct 09, 2023 at 06:23:45PM -0700, Mike Kravetz wrote:
> > > > On 10/09/23 15:56, Usama Arif wrote:
> > 
> > Thank you Nathan!  That is very helpful.
> > 
> > I will use this information to try and recreate.  If I can recreate, I
> > should be able to get to root cause.
> 
> I could easily recreate the issue using the provided instructions.  First
> thing I did was add a few printk's to check/verify state.  The beginning
> of gather_bootmem_prealloc looked like this:

Hi Nathan,

This is looking more and more like a Clang issue to me.  I did a little
more problem isolation today.  Here is what I did:

- Check out commit "hugetlb: restructure pool allocations" in linux-next
- Fix the known issue with early disable/enable IRQs via locking by
  applying:

commit 266789498210dff6cf9a14b64fa3a5cb2fcc5858
Author: Mike Kravetz <mike.kravetz@oracle.com>
Date:   Fri Oct 13 13:14:15 2023 -0700

    fix prep_and_add_allocated_folios locking

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c843506654f8..d8ab2d9b391b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2246,15 +2246,16 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 static void prep_and_add_allocated_folios(struct hstate *h,
 					struct list_head *folio_list)
 {
+	unsigned long flags;
 	struct folio *folio, *tmp_f;
 
 	/* Add all new pool pages to free lists in one lock cycle */
-	spin_lock_irq(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
 		__prep_account_new_huge_page(h, folio_nid(folio));
 		enqueue_hugetlb_folio(h, folio);
 	}
-	spin_unlock_irq(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 }
 
 /*

- Add the following code which would only trigger a BUG if we were to
  traverse an empty list; which should NEVER happen.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d8ab2d9b391b..be234831b33f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3294,11 +3294,21 @@ static void __init gather_bootmem_prealloc(void)
 	LIST_HEAD(folio_list);
 	struct huge_bootmem_page *m;
 	struct hstate *h, *prev_h = NULL;
+	bool empty;
+
+	empty = list_empty(&huge_boot_pages);
+	if (empty)
+		printk("gather_bootmem_prealloc: huge_boot_pages list empty\n");
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = (void *)page;
 
+		if (empty) {
+			printk("    Traversing an empty list as if not empty!!!\n");
+			BUG();
+		}
+
 		h = m->hstate;
 		/*
 		 * It is possible to have multiple huge page sizes (hstates)

- As you have experienced, this will BUG if built with LLVM 17.0.2 and
  CONFIG_INIT_STACK_NONE

- It will NOT BUG if built with LLVM 13.0.1 but will BUG if built with
  LLVM llvm-14.0.6-x86_64 and later.

As mentioned in the previous email, the generated code for loop entry
looks wrong to my untrained eyes.  Can you or someone on the llvm team
take a look?
-- 
Mike Kravetz
