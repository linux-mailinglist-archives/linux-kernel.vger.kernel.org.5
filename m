Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4D756C90
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjGQS4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGQS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:56:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F45123
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:56:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HEwtJU030128;
        Mon, 17 Jul 2023 18:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=QlpG3gGq57TLpE5okzy06Um135aQE95VfpJUKCCyvw8=;
 b=AwPUPyb25VMd1mOtk49UUBfj5J+7yLRaIo4KUVaQiDj099c0qkA9j8i/jF2cxXQD+gmZ
 SMk4XiKzrntDUc8FnDS9NuHXTq/cIsauHv2jkxiddwe6MrJyutYynyjCFOASVGvq/pqw
 kxXyE1mqu4xuURjszgpnRjOVo5wc6eieSg4SXnVTd1NaVu2/KjTHO5Z5YQBfav1H+ePS
 OwOAcf8ZyKyQR00dmp3nUFXOog8NjWqN0gtz471pNplabZ12E/m7Qkv/CLhQYlTkU7B+
 PLOK29DFCGI1mcUnp155W8shdK1FYcDKPZXHh+2WaUxaDjRVA1ao9rs4x+TiSWctT0G6 VA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run783cfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 18:52:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HHhUbN007808;
        Mon, 17 Jul 2023 18:52:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw3u125-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 18:52:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVz4yFtXtSDx29aAX1BJXR0T5cBONbTvHWbnb3ShkeD1yRLqCdzWVzIs/cFOIiZ7oN+TBjbq8cGRdf5qJpPk+uAKsRGwiaRHdrIdJZEPpmmCYERpbHO9+XhIzQrN2ahkyoVe1linIx3IiSEZNJD2tcMt0IWhQqLChKmH57bwAmhrz5ory9NOs/9391pRbhp+T9X5bkYrXPVMuWfGrtJ8qFilZGwPaknxIIeeXEIfFUrWNZj5Vqdx6tTm/1ERS6TXS79pEDPobD+DTV2paghI0AxLHCwC6AHcMgKkLRBSVoF3+p+b3ANRE1FFZQzwyF5E2Gsaoo8xfEa19zFvTe3HKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlpG3gGq57TLpE5okzy06Um135aQE95VfpJUKCCyvw8=;
 b=ZHt9/uTEnys02eNuD6OY7+VPSp3a/rf03N/XhIF/iAK+GWLM42B2APaLuaiEJ5Jp2G/Y7I/vjAdDzKjD1RHyifQeMHtW34br48wxkN5UJmP+MvRFY8H6faSVVrKf1FvmbYRm3q8vnMX9H+52NnF6337huf2coA85lZuzAWMjOwPUXlTptAbKeBht1WXx6gR+A9ddamfEHmtLGwsplL6lGEB64Iuj4wE8W+R7c1AISgh3MnWAKidTI8b1FSItuyGI0yzaUXmdFnU8gHFAd6AWOwbp2PMeYNVf9nNaeYJXERC/u4vw9rKRQkSe0UuKNJVyTpDiu0i7v5VkZxnGQPNacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlpG3gGq57TLpE5okzy06Um135aQE95VfpJUKCCyvw8=;
 b=UB/JvoP37LRnuapcSbavWf5Z8f3bTjXN4+X7K/zomXIExB1bzaYpWMtFv5x7hJilW7S8JBHXqBAgx459kJdu5oMMdOnT+wdxef87vAIJo3wZkBX6Ru67vvOFnXiFPdRFmwx7yEhpmnABM/e1lxfvWqMg7M5rfgmNq2Fwy1VfPHE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4547.namprd10.prod.outlook.com (2603:10b6:303:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 17 Jul
 2023 18:52:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Mon, 17 Jul 2023
 18:52:25 +0000
Date:   Mon, 17 Jul 2023 11:52:22 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: mprotect and hugetlb mappings
Message-ID: <20230717185222.GB4741@monkey>
References: <20230705230808.GA41006@monkey>
 <ZKX7PerFpnoMT5Pc@casper.infradead.org>
 <20230705235322.GD41006@monkey>
 <399a6448-184b-1433-3f23-1a599656a713@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <399a6448-184b-1433-3f23-1a599656a713@suse.cz>
X-ClientProxiedBy: MW4PR04CA0292.namprd04.prod.outlook.com
 (2603:10b6:303:89::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eeeb211-56a1-47f4-d21e-08db86f6f657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5usNtqobWirjtDkC70ApU6QLsJvb3X8tWxzex1av3ZHDT7aHjCl0bPKdaNymQdPmQ5uvIvfuIVeMZgR6uz9sFcaVk/gjd5h3OZMjEF0mV1r80v+JTj97O2QH2rSBG3iOdmb+hAjdr2dFvnWMx3AD3RMY+lnc3M09gTr3Ppni5jGM4xsbdmEDO35SVAlLfgujM8ETqlNlfKBj5Ki/3yVLKwAL2SgpbFaR2asQn9JHH+Ubs7l82Cixpb+QSew8ZEpYNBM004acAp/3pYabov9bT9zaWk5V8497mjSg9CrkyfI7YWKZ5nRiaFvwW5aSE9UOvYfrBi9YNcPRNZKUKDP5gpFrhYJq3Oqz8iswrCqX4vbHj8frSDRpuNE/1WmStOQnHCduOa+OWpXnT39qOEQDhMGOH1xpHnVrZxoXvwpnSvXnWG4foUknZMW4W6h8XYmYJHKB3uPtKmwXzzDFPoov19NYjBn6qT4E/OALASDo6J6GHc6YZ3jvagfpq7tV2xtcXhCkRhyPtKZAxZWzZrXKU7hFIddaOF/oJYiH8YVnty8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199021)(33716001)(33656002)(86362001)(478600001)(38100700002)(3480700007)(6666004)(8676002)(54906003)(6486002)(6512007)(966005)(66556008)(4326008)(186003)(44832011)(5660300002)(6916009)(66476007)(66946007)(41300700001)(8936002)(2906002)(316002)(6506007)(1076003)(9686003)(83380400001)(53546011)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Jx/t1XEtM+rmgn0tvKBCJKil2fRtZ7/pinoZVLJ9IV91ol7nQ7THg1oXt/y?=
 =?us-ascii?Q?5S4Gd5MQRwoIxqRksM93qa0GKYbw3iNKbMb+6lwPHWWWdnnK9anSdLBB65XU?=
 =?us-ascii?Q?j82XC2wO9ak2+OOrYWsz12MyRsN+K6sTiPfm+MUolgF0PUDQOs9hlzoc7G3Z?=
 =?us-ascii?Q?DL1NNLx9ltYok5Sp0NK+rTpy93bJDfzBRIrGOUlsQ/djNKe+aeHx3/kqoMXA?=
 =?us-ascii?Q?iayuEIlN77njr/dzeKBHDJFBhd3+cYaJWkucCschNnJhPNV3cZhj5PDxk187?=
 =?us-ascii?Q?bvy8k+kIwnSUQcXCM3Q7K4Zk0pKbMapZmKD5S0XONdvVHOuIShqjflQu+sJ5?=
 =?us-ascii?Q?B8CBn2nxOnH4YAW1CVT7+eajh/Ty9Ld5gLksHTl9K8Ia9cTHEYdTHImBctKT?=
 =?us-ascii?Q?eROBzzW0JmZ1krIfFmBzbdo+qvGQulwsQXG4UCdgKOyOkHBQylsseuU7Wst2?=
 =?us-ascii?Q?Yq1aLQreJbgSJYNHl59+1HhjMYm/K1O7fHYqNu5f+IW19FOVW8bAu8H8Q9xe?=
 =?us-ascii?Q?Mu+tr2dWwI0i1EDuVHDfD1n1J2/ozc5PKrN2Vo0KUWL2YkKUOvZBu4UJY8V7?=
 =?us-ascii?Q?ZN6/QbCLbXM0oC9lx8vcuzQJyJn7soUt/qmqsQYcQSsZh42SbYXXY6xqDpu0?=
 =?us-ascii?Q?XSd6Rv6v1Qz4ghjTRxMY/htbA0NfLoOVGTxuYkA6omADpzVGz/dsIR9+PKpi?=
 =?us-ascii?Q?vRVsDIwYN7f7BEmTIWbAZWkqxdZpwLCdpJqvTHkwf5+HQKhqG+qbjxyC0LNQ?=
 =?us-ascii?Q?JfMm2tXvzaffVnE/kph7IPOShP08lMYQyAa2N7Le/HL9aS4cWDcC1hGI1unp?=
 =?us-ascii?Q?gXCOvfDPeuRJKlJvJT0CMMiK3Xuu9gF1jcyUcjSvK9fXzsRi5ggPZuERbqIK?=
 =?us-ascii?Q?iEPeis6zK60hM6uBDKWMD1erYROy5kd+c4Lor2NZfLX5umbUyrSanKRoONdf?=
 =?us-ascii?Q?qs6LVamX1i8sz6dlCi3AlC2PO6lTFpGDsHmk0bFzHC6pVzax7nf4nG8nddgx?=
 =?us-ascii?Q?uh2V8pfGBPXMSp+EGz3OwZEkJy/yf7m0uNMedv/9Svi1upkecP0yoTcjxM4N?=
 =?us-ascii?Q?ClJRsTGfC4wgSzHFTFit856kbXwcy9KTZ9Coe+yGp4yYxDbN934NKPm0FEID?=
 =?us-ascii?Q?+WnkA+F6ZA799ZeQ1FPBo9ISZqBxT5i1QUm88x8EUoYPunNZZdtMLncZKeUr?=
 =?us-ascii?Q?ZBHWAdRGPqPZ8ZCyNZYNk29dvcSj1L3O7WLDwncPwZoj2kWcBKG+h/7eCufD?=
 =?us-ascii?Q?YOMS0TvaxreBby9ws+zDWfgHg8fGhVyTE6JEJGYC0e1aKYLRekx76cIWXFtN?=
 =?us-ascii?Q?scjR6mbxseIX11kyuAe/Cq6D8HrbBpETHvzHSIqqkByg9VyYz+XHBlk3grNG?=
 =?us-ascii?Q?zeMQY2y6ICeun+QCwfNMFgK22TZX5obqIoyMczwan/u+GukcOEwzbIy1sp14?=
 =?us-ascii?Q?6ZtFO+6yiJfbluamt69DZChuclDVbtYYlIU6e+pOlJ9SVruT8+24k+xbiIPM?=
 =?us-ascii?Q?neKfXY7vM/dUxLgHnWlEfCMzkdHFCUzSB8jaM7NQFeLs71wJx8uE6yjuaC5e?=
 =?us-ascii?Q?bVoWOPZSfABa1bykCRa/SuCNqQjVM6S8LCPq9YBJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nGLjphbyvot0BGH/M/opR4evx+Z8d1OBAaBlBuyzUuu0rGaqiTLSVbnB3Ps8?=
 =?us-ascii?Q?l8AAMtBPDphTmeXiHpHEAihHI+tb3KlYlYOmoZDSRchk8eJIoXzR6Wy5lalA?=
 =?us-ascii?Q?U6YwOtv+oY0ze2ucl4JIjhhdtacfVwBf6Pnty2JbEDSjgjcF07lmSl667R7G?=
 =?us-ascii?Q?8XT2i3sVD/jDajgxcEJqoouhAXlaUOm2Q/ApQQZUvAg26alMYFB9r1afMJ3h?=
 =?us-ascii?Q?pURENthyLgjcKnizEF+ED9PMLPpwtfT3nsTmScc60912Sl4W0rqKsJAkQ8FK?=
 =?us-ascii?Q?evuHyGyBTdDEhX3j6W/BloQBNizFoc8giHZ2V2DZZYflCPbxY723FEEId1Us?=
 =?us-ascii?Q?09XTv8dBZFvTkqXzyhs52X7Hxs7boMQMrFE7sFjHqmbPFYVY4MS1R3wM071n?=
 =?us-ascii?Q?WyR4PEVf7+W/fn2XcEB3COMO2YSTZ/Bi7iLuJsERwAOeJDISwK7b5+j2x61d?=
 =?us-ascii?Q?6lCgJkFZVYnQtWWsMG+FILfcg/N8zgtcsWyRFV3w5RK6cfyGm1KpTyKaJVAV?=
 =?us-ascii?Q?CQYiFvKdjfyIDiybKz1KMbgfSG2PgHZiW5wagVfITx6Y8neEttZmUGfT437F?=
 =?us-ascii?Q?SQOoxO3LhQ6DZk600aG6emec+U/sHX2Oyi43mQI7VDqNq+UqPBy5xR4f0K+v?=
 =?us-ascii?Q?uSehYoqmEMb86Sjoc8XqL5ynuUkMbUwg1l/IaKAvNAnpr+v+xWen30vOLuLy?=
 =?us-ascii?Q?ZuE5LCQQqBJJkgG1NY0k/9f6xqHQnH18L20dQo3eAahmKxhLxkZNSKSj/CO2?=
 =?us-ascii?Q?QEq+nKls2q0dHiJ2ulXnJId6pbNJFNRel7SFn5PBbnVerfHV3JcED6L2Hugn?=
 =?us-ascii?Q?iNBptaTHr3ONbKCyv8htNUtHM/Ea9V3pEQ8vQeefjwoidssxzHplQtCjdiJl?=
 =?us-ascii?Q?a3CrxltsL6QMXmeEThxHBkIHDdtMEXVsVLM398pjhNe9ZZxdqsc8zBVPvAUn?=
 =?us-ascii?Q?gBH8fV32Cr3tiEw6jEwBB5h0YJ9tB9IGUZNa5RDGUDA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eeeb211-56a1-47f4-d21e-08db86f6f657
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:52:25.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otT1Xdqpuidgc/1N+ATmfULnu5OcVioF8nnJzUnAyYXmEXq8r7jVVdG3i+um7KP1sJJiOyxVknd7updzwFfMKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_13,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=746
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170172
X-Proofpoint-ORIG-GUID: 5TOXXXrniglFG7Cdf1-a0B-a6_PoAyoh
X-Proofpoint-GUID: 5TOXXXrniglFG7Cdf1-a0B-a6_PoAyoh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/23 18:19, Vlastimil Babka wrote:
> On 7/6/23 01:53, Mike Kravetz wrote:
> > On 07/06/23 00:22, Matthew Wilcox wrote:
> >> On Wed, Jul 05, 2023 at 04:08:08PM -0700, Mike Kravetz wrote:
> >> > I was recently asked about the behavior of mprotect on a hugetlb
> >> > mapping where addr or addr+len is not hugetlb page size aligned.  As
> >> > one might expect, EINVAL is returned in such cases.  However, the man
> >> > page makes no mention of alignment requirements for hugetlb mappings.
> >> > 
> >> > I am happy to submit man page updates if people agree this is the correct
> >> > behavior.  We might even want to check alignment earlier in the code
> >> > path as we fail when trying to split the vma today.
> >> > 
> >> > An alternative behavior would be to operate on whole hugetlb pages within
> >> > the range addr - addr+len.
> >> 
> >> After a careful re-reading of the mprotect() man page, I suggest the
> >> following behaviour ...
> >> 
> >> addr must be a multiple of the hpage size.  Otherwise -EINVAL.
> >> len should be rounded up to hpage size.
> >> 
> >> I wonder how likely this change would be to break userspace code.
> >> Maybe some test cases.
> > 
> > My concern is that this is the approach I took with huegtlb MADV_DONTNEED,
> > and this caused problems discussed and eventually modified here:
> > https://lore.kernel.org/linux-mm/20221021154546.57df96db@imladris.surriel.com/
> > 
> > In the MADV_DONTNEED case we were throwing away data.  With mprotect we are
> > only modifying access to data.
> 
> That can still confuse some userspace, no? I think realistically we can only
> document the current implementation better, maybe improve it without
> changing observed behavior as you suggested wrt the split vma fail. But
> changing it would be dangerous.

Thanks for the comments Vlastimil.

That would be my thought/preferred path forward.  Simply document the
current behavior, and MAYBE update code to be more explicit.

Any other thoughts?
-- 
Mike Kravetz
