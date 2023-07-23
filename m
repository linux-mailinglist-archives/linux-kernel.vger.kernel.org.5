Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B2575E48D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGWT3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGWT27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:28:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F06E43;
        Sun, 23 Jul 2023 12:28:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NJ9ves026576;
        Sun, 23 Jul 2023 19:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=V0urFDAXAFkrOvUT+n+WM5hDHHuV4X6qP2Eba4WXtsw=;
 b=2ENiRYTc4vR+lTFCApZTsXCgrxzRnfaAa/M6/h8999GT3ITDFv7MSEp0Vht99vgdm9zB
 nwOTKJ0ypCoLMszeObEqi7ZC/CWQKtl+k25Ubi40l8Kh5hj2Dve2+tPhmFEpcu3GoQpb
 gxFAHkB74lxxhLFVEqH+ladnjgQcSjxGOTJy6T5GPtVQrxhgAZH2qpCoU3bB2pmDOheB
 C17W8qxiYOKTS9aMcNRQSU9obSpWZYT9hh3NDy3b19rU4zPStF63Qg542YYLR4XIlLqm
 RdyDbUzeCCmMwfCYpt4gEJ6qIDXwtsFVYcqfpIZKCjHnOMzk6FHMI/Y01bzRMTdKA+a0 yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1sgvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 19:28:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NFEbhr040860;
        Sun, 23 Jul 2023 19:28:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j36888-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 19:28:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THMdturgmqHUISYl6MbD+cOYwHeHcmujZHyYiAhWdCfabEQ3knc7HCLKIa0rGY1dNhqsgJK3Uh6JFEoCW5e6uPt0WWYra4oMhlZsSz+p1UoupJPMyhUYTMPr/O/QG7A6hq2xhlsl2ZrPqpcU99+HSXD0n+3jxwdk2QiV4oWZxmAaZdeZQNku1hjoscT//cNYaJE/Xxa77Ogz5+RD2mgRfBoNtj9e5n56IxFMMTi5tRrLR5abHVYU+nqzFZHQwDd3bBNuw7eEQ6zhut/OHcFvonJgP+pzAfZ4qsQuB8l5jHCzhRB1XHO9GRDcrF218GZlhT/lcUVPa+gF1Nnh1WLNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0urFDAXAFkrOvUT+n+WM5hDHHuV4X6qP2Eba4WXtsw=;
 b=EaaQ+W/y8cQ+MOePMLr+tDVEoVuBw3BiYaTQhJ9947MJsQ1TmJzbMGTvlzAu8i1Ga4iEzL1KQZOFa5gJVwn3HDSelRhioA2QC0+gyK3L8YGzsQJT2MpGhUN3UWFozzrK/GwfOVdpHFxfs6k6m3pbgqVUj+ZxYOLlEPYbPOPik5+U2S+9XnZGHxarZd1DddVCflo1o+m3FE7SUPvkMGsXkq3Ey2VdUhJDgufTmYrTnfdBa2qTyfXc1B1arlHJ4lDs02n5I74NRLpDZUNTYcf/snQG2/OVmJN9NDiEhNzAkFY4xR5bz3AI1dOkjxQjPzqZUVU3tyVZy8B5iuFNmZJh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0urFDAXAFkrOvUT+n+WM5hDHHuV4X6qP2Eba4WXtsw=;
 b=xISrsozTVhtVdLC/38duK5QgRIB7JUsawrGEVo5zKUSlVSikXK/28594Frf4sinBQT8b+dWTMqRqlgwqBn9/S1tbqs2Eou2pmRnGM162I4mqE/dCrGWACXkoWTyxl0/fv/c1QnsSHa4kIYt6XKqfDZtREg22EaYSbH1Ly8dkAas=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by CYXPR10MB7950.namprd10.prod.outlook.com (2603:10b6:930:db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 19:28:47 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536%7]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 19:28:47 +0000
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] scsi: ufs: core: Fix some kernel-doc comments
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1jzuq5swp.fsf@ca-mkp.ca.oracle.com>
References: <20230712075836.15375-1-yang.lee@linux.alibaba.com>
Date:   Sun, 23 Jul 2023 15:28:45 -0400
In-Reply-To: <20230712075836.15375-1-yang.lee@linux.alibaba.com> (Yang Li's
        message of "Wed, 12 Jul 2023 15:58:36 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|CYXPR10MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbfee99-41c6-4186-2586-08db8bb30966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fm7JNK7Fx4lKCMv0NymCCc7whtNJeWPyfyFLFbVkcTeVcKB9e7efFhsUManRktuXDFtIkHwbianmMKBRQKwrTW07dNw6UUzppdM2tfyRGLDeJ583XSJZOvOTVFGODMwd/2va5I1eV9wEZ3pEVWsL5JYjtwEJLLwP/5JNxxLTAFi5vXblou1ZTz5IJaLjkZ5t5+sQwT18VHQwwsV3Je4ri6OfXBZ64d7amj3715gfbd79+ph7RsIEJ4Hi2bhHFfg7roWgXnCvTRPK8SzD8qtzg8CuQi5iE9HH1h/GYNcoU/DeDtiSVfjy7LUhO/3nWWaB8YD5CEFOrGsuk61n20URxQKr31+Ezz+lDcpMAtEv0r3xbT30Y7U3fO7kYXsrjbXIEhD6Ja1H6vV7eU0mFhXwSuy47GQJlqaILDZYCnQKH+85FMkP4ONYgSEKC8CBy1gMys7xxhyvV5Q/EviPQrWcAq0HY5LhjOo5cgEY6O77Q1lG0d2njCwNZrc12JCFg1MP8Uqum17HXpLuCHaLcf1SwjE2tdbQls0yG3fy7rYQqmfKc0SrHWPRgrnaZEu71lT7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(366004)(376002)(346002)(396003)(136003)(451199021)(6486002)(6512007)(36916002)(478600001)(186003)(6506007)(26005)(2906002)(41300700001)(316002)(6916009)(66946007)(66476007)(4326008)(8676002)(8936002)(5660300002)(66556008)(38100700002)(558084003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HqpbbB2Q9PYHabn6j9vAVpmC3E767yziCqXiFX2f5mlYvIGuWmUHVKVgM1yo?=
 =?us-ascii?Q?yQjarz8k8GDZjj9xrRPKq18xplAcNuIm03rO1sPYGXlIE94SpGDhq50hAYJ1?=
 =?us-ascii?Q?2D0yb3BQ84uLT07SV8oO1YEB9UHBuYOhBmWHuWCrJfibUk2gJAEomk3e97rg?=
 =?us-ascii?Q?H37Iy4tA+CF6aSAsf681LwLksbHcsR8VHIerUKf9+ZJmVy9l8rOpXPQAIxqL?=
 =?us-ascii?Q?PqiXbQxBNZNnQX50O73xl6aeCAcEJRP5qDFKx0x7MFzXNL7vt5ktRHL0ErD4?=
 =?us-ascii?Q?1A425yunt/VNJ6ZHjMj7DpYrLdrriUFiam7iR6jDi5zDvq1BPpW95aMXlHHf?=
 =?us-ascii?Q?DxYmbbJ5FlZB1MMjilbX5uuf31KxvgpNrp0M2mZ3VWIkIUlKMhR8tfeGsdy4?=
 =?us-ascii?Q?FnLLj4eS6RiiaU7Jz06qwvqzMGS+cmcy3hOPxe3a0DBvV4+Vb+9NlikilnKo?=
 =?us-ascii?Q?Ayo5gq9NVoNWYa6R/QW+Duf9ZDl+xPlR2qrPOZLQ3XjPRUf5uG9T9s3T2a78?=
 =?us-ascii?Q?/rQ53xP+5uohVdui4QP68V9ahWGHaxGeChatpfMwEXqwlRn3G09nAQHIprGQ?=
 =?us-ascii?Q?UpYPJZQAhe4LrFAHQXxXRZDwkCmTb2ZOFxnPjVi9b1XCT+ykCQYpo9ods1He?=
 =?us-ascii?Q?hoeiwBP1xQxPrrQH2wgaIFr5ebCTuhysfdadctynWBzsrqsEQvsqC06PlroM?=
 =?us-ascii?Q?0AoPz9lIPIaXzWfMqcB3yF7x0OZqTjGBoJ7MZPg4SHUPfG9LUlDSwq5R4ltd?=
 =?us-ascii?Q?kKfrmQhdjJqWbLiOjhth3x+ouN4ujTQAgUkqmv1JgBwyaeC6lcSQZjKKFxpP?=
 =?us-ascii?Q?qek3cMbdXH7+9RSNL8v/k4tXT2ndD5gmr8LEtI2qDcOtXplvONB0xCdfuibm?=
 =?us-ascii?Q?JwSxGUgK795iuVDrcA/R24PXPG6Gl4lWQUr902VSKLbDHeFEzuxUafnKKzG1?=
 =?us-ascii?Q?qy58BED0+1jjjBdAnxWgCMeK5ZRf2Zl2S4YCN0ZNWO9gKyIzgXgN17PkYiUh?=
 =?us-ascii?Q?RbyoOHHGfMprR7HOB923ldFUHM1L/wh8obt1clfjKqHB9KR56L/yAg8ppkH/?=
 =?us-ascii?Q?Y3siGWbjofFg/UPWTGOZTD5NusRfk6iDOZbWwk4dU0l9DVCaxJROSXLgK7SS?=
 =?us-ascii?Q?J/X4MMqZyF13oYElE33UBfws/rdqL8AredBJ79XgFcaH1iE7Wti51FPFtk+o?=
 =?us-ascii?Q?77bvgC8SMghVdzJhZYED1mruBoK28nOG6gV6Ek4T9tX7ngSiT/HKXn29MO4L?=
 =?us-ascii?Q?go+eThvd4bPMTpfY1NiyO2hCVDeo+6Xzhg1Vc2cCwFKw9c4jrZB3fR5nv6dN?=
 =?us-ascii?Q?pjJ7qsXWySXmbp8ffjrQxFHUn6X1CpovnQ5EMfVa87YVt2v+dhEicduu96MS?=
 =?us-ascii?Q?cD6OzYQnqF9jlXRY3sZL3bfMh78SEkxEBcC8uDIEmClYjrelBWpsgPU++2md?=
 =?us-ascii?Q?uoTZL+GQhcIpdv2dykZ0dJ23EkXgTn6AqWZpmbfcVI2WdV6JatiROqVedFdk?=
 =?us-ascii?Q?cewsPxelaiKdief7NJxgSa7W57YwG1Q1NHaO44gI/YyaazmKNxo/yBPFAx2t?=
 =?us-ascii?Q?LjFSS5S0guakP/YihFEzCK70LeDAs5nZKp3qD3y2bPjwnG9I95WUQClwX7Up?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5fN8QIwD3fwDuKF9Iknopoeqfu2Kj4FIrk9qYuM2+rXDDo7h6zvzs+9U3Ji/NiQpKmXdGfGoX3KUN5GMsFik9PNMA/4wakxBETGe58epN/JGFxs/62ZeO6qp3UWHuQvIQ+IZbfyC1vN5TKvrazExV9ee9a+Kq9sH9pMq26wv63foG3Q5nNu/b6b6xWg+PBxgXPvKHQHiELXK3bMpAXW8xWJaV1kqpVVkB/U1O08oFuuLP34a8Aj98BEQY+0ROHN6b+HKQTNE0/ikbOGlV7itUMqoEjOPHSL1IM8ayqR30Y6DY5j9eDQnNw1o6XStSc3+JOiq6ZTkVFP4wpf8yUUpFnm4124hfBBO7zBtquS51LQJlGI2BXApzukGt8FJL2IKO+Xat6SthiksZ4eFXJ7YOdGlohuwwwoAmodLxkRsDvWfBsXMVkqd+pF6aJXb5J6EnAJrn+6j0ROS/Q9ASibuVuU9rV+xmMCsbUbn+DalnDQIPEhoeY2PbuPZQIUainWSGmST8TrlAM2Yh51LBRwc+BfYk2/tXPvExcouncG4LSGT/eJLJqyZc3R6tAHIq/hrnptov5Zbg3qLdmh7S5wRhgS43vpeSOcjjWbac0fS+eZFtSbHmS+kQ0e3X96B6jPYf75ZwGI6YDFo57lI+A8UUz5oY7nUFg5Q+TV0DqoZ7JToviEuD7G62cu4EWbS+Dqx1ZYKluL1PsrHYoi6ZtiOplBjeNxLk/Br3WSegZ3maNyBncFDxS1bbqmUg83eh2kZRb1EplW3d7GgYCR8X3hGZPwVV9kzIRcP8XoeTR3cGDNSwqBayLng67rHVhvdriQYH83CnF6iGazqWEhkndSntwgWc8rmCbJy3wo6JLlSDOreI1VxJxdg5EspaLyhs32W5DIKXDZdLt8wVXnS36Xd3iS2VIVBAGG0DxZgqqGtndc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbfee99-41c6-4186-2586-08db8bb30966
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 19:28:47.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8S/h9z4bJA+ycdkGle+23mwu7l7UBsfIDvc3Jsak9HxxBT0UnZOPC5/j1fjv3IQl5YNI7ulVC+A2YUX/qDFvXszB79HtZTrJHITAdvTmXb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=892
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307230182
X-Proofpoint-GUID: rz7OIESjbH326f14vYBTfizCkf3oCQYL
X-Proofpoint-ORIG-GUID: rz7OIESjbH326f14vYBTfizCkf3oCQYL
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang,

> Use colons to separate parameter names from their specific meanings.
> silencethe warnings:

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
