Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E76C76A0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGaSru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaSrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:47:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977B99E;
        Mon, 31 Jul 2023 11:47:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTaN3011544;
        Mon, 31 Jul 2023 18:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vAH0+2vKsB7A1trO0LLdw2A3JMcZPbpfyR4S2ua7TJY=;
 b=GXzg13WYvBMI78gCucK769THGAvtjM4IRZzYsonI9sF9Nbuc7GeXL8ve7xmoBtN3F1us
 kqLDjvnSShG4jEs9T+aBhqizvCIpFdYkMNp4xAKZQ9zLiBFfC30xyxMNqSFIKrhSLP5e
 l0W9l/zTZqv2BlAnUInlEAso0RTlxcZHB8+6sHwhIFRLDb1//8MifGTv660VQbUaeTGO
 bi3eP3s/kMrjL0NFwz1AQkdwoJ3yMu75rg8rHjUl84E9/3anfjDmvf0tvY5OePpw4/ln
 EXeu2TGCx/ODgY56Q+UMQCr+xTSHUnQOHztF4CBq9fpIrDorbkNws8XiGVPy5F/20D+8 XA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sj3ub2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 18:47:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VI3vQC008572;
        Mon, 31 Jul 2023 18:47:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7bjn0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 18:47:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR9l/v6aVlO6g+BBYM/sSpJYg0gBpirjGcJX2O2g+NdxUFRHS1D2bFtecG1EzdCncjYZtHvIZhuqdZkUibqzhpwKFAyU5YhW+eHpVvwkq9MvKjVHaueiz7Ei0MXOACQdDVa7DJK+LJZpzk7aA8+hN8bgHlGPHfKKwA+/ceLpaVq+a0TyMil8g5Oskz0kabepfflk0YyPzfvueTO4/4MkOuR0g3gatkvb/4vLP3DF7RD1lB+K/pZ3t27fBzxCDlyLJSQRx7M0iwy9OGnr2bAwNSUa6wHLyU1U+2CFxoC1ktSMSqygR2J/ZtnqDmhJGpxx+PZkNh+sJuqXmZ/660Rqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAH0+2vKsB7A1trO0LLdw2A3JMcZPbpfyR4S2ua7TJY=;
 b=PthaGV9frrH1UdnYPcGfsBE39DyVSUy/LTxqs3ALiZkK2gixivUlUlJyd11+3xa8r6ZDWVm2dhG/jXznUboP3mJjZmMVPLLoB4rNrFFBHMx6j4QXc1ht1XGbMo9UsuAGifM0ITMxlJ6BXtmqS0KJnYEWLQWg36FNDIClqYPoq+IajfFHTWuCDSbvIJNOt4nI8XH/EiSWuxkUS+kBW9miic93j1furlkwnAcBfzkLIa0SlgC2Hr2qsSjz6RKD3rmMRJ8ipFh85SXtSpwLHSw5t2IKO9QFUyToaDFmNWj9zXpxZrmEN3VOPPpWSO4uSnHJz6kBwRDFsbcPNCcMsmfp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAH0+2vKsB7A1trO0LLdw2A3JMcZPbpfyR4S2ua7TJY=;
 b=BubLfg40lHcxmxNRzpirWqOZtFqu6w/7akeyh6fEvLxAdx7xCQYOMfBIccF2dfvkyBU5F5xNKQ6d/mGt7wxeMNzeoPx1+P43Rc4i2dhvqcrbJ31iDZxXjWrbJYffHYCF3jo5hX3ucewK2vaosTDKreMKbvO1H8IidZ004JqANN8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB5105.namprd10.prod.outlook.com (2603:10b6:208:325::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 18:47:38 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012%4]) with mapi id 15.20.6631.041; Mon, 31 Jul 2023
 18:47:38 +0000
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] scsi: ufs: qcom: Add interconnect support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18ravrk8z.fsf@ca-mkp.ca.oracle.com>
References: <20230731145020.41262-1-manivannan.sadhasivam@linaro.org>
Date:   Mon, 31 Jul 2023 14:47:36 -0400
In-Reply-To: <20230731145020.41262-1-manivannan.sadhasivam@linaro.org>
        (Manivannan Sadhasivam's message of "Mon, 31 Jul 2023 20:20:18 +0530")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:a03:80::37) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: 09852658-2282-490b-4b37-08db91f69cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65k+WnZtjjFdIKboFcCISgalytfh5qLS7Q8xon8N6vjjC6HKlSsHK9m90/4xPi2+oM9Cv5HZNGXr1argjBUaD1oxw0aM6LsFWiHdJ4PfCnFoGqyGUsMTViAvLMPpHKTNY0esI2x7P8g7crXI82AO54lUQF116SwmqbaXj2u/3uI0j9wq4YA6iYNW1YI2VR5aL2x1RJ0LQCEVfOPaUJjVvhWs51H+rcB+m14eReSLBA6UJEyX6LbDjPHY0CYPzhblqwZ6WaNGf2vtOwOUKf5FRA55WLZN1UPNoMm6CiwoAKIr3JpYwM85Ccdrlmpdc/uFbjVbgVwrITZ7YH4cugwyabcjQ0478HX3jp2epp9PjXyflMpGRj2nTAA39zlYKhKwzdLwAuANu1r0PBoGB82s0ChoXCd5oA3Cl0UCJeHI+xe/EFYtIGGzwM5ok7agkCXSlO7jEGBfItZUpqGANEEEUhhwb/HzvLApVcuMCdyh9N06oComJYzAW9o3O/hSJUnDC0BvkdJJovgcKKauin+5t6N2eJ1LM3nY8UbyDoCoRbxjVvLuGNXgb9T6Eih62V/4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(5660300002)(66556008)(2906002)(66476007)(6916009)(66946007)(4326008)(316002)(4744005)(41300700001)(6486002)(478600001)(36916002)(8676002)(8936002)(6506007)(26005)(186003)(86362001)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BnEI6zwQP9S1grxw4dnTkGLTxxTvH2tnfXSHHIKeYZp+zZcO+A8vfj239W8M?=
 =?us-ascii?Q?Hj8PM3MUOVeP4sxQfpVCTr6/K+5rmdkVAVKMHP4vMwAsUp1erfKD7XSkT1Wq?=
 =?us-ascii?Q?35i7fp24SzugLExYyA7VUfBJTQdXVAs4uGJiSKXuWpaix8BI8MRuO4niNwGU?=
 =?us-ascii?Q?GNC2i91s8cnHHj9Iz8hFdUh5D7xmR1f5iHbjSw2DMdZzs/taqFf1Lety42sQ?=
 =?us-ascii?Q?q29BrfPF2KzQmjxS/0SmCsKNynXXOpTg0oZvCHsCzU511zlFThoyUTgHp1nS?=
 =?us-ascii?Q?ARcO7vDgR3jbGm05N1NV/TPJ3HgVQbYINbNHNKUZgnrfDmZ+MWo5MRFSg9go?=
 =?us-ascii?Q?b+88WcAJX5VGMfUwp+LLFkPdLHZSu6upH30SbaTsbf/zcMZAHrE7gT3rqdRq?=
 =?us-ascii?Q?5lLT8UFiCEtquPOK4VDpxULr3d87mPlXFtqI61XeFDGRpYu8DaEQJqw/eO3d?=
 =?us-ascii?Q?MvDo5IjOJYLiW7YKBa/uMD8iu+gB/sMFGyAw6cq9sgHFmtfKJ/HtszRwujNL?=
 =?us-ascii?Q?ec99Hvi5PLG2XCzfGh8pjm3ISHWfASv31L+0MxmGM1MZ36lkHcIyBlTQAOIA?=
 =?us-ascii?Q?jKuulMNP/k4oSAQZmw9kozTmtSoQXvdXBB8E68bz3mZC9cOSBl0zP5NledMj?=
 =?us-ascii?Q?Tryp9iKHCedc/gwLYHzYaeZB22wqbHd6tNw3I5tzNy8FZHjNpiD699N+uapX?=
 =?us-ascii?Q?T+7DdQPJhMShso199UZQlwWRyXNuhRt2L0HaRuccs+Zggq2Kdy/oe5/Qdzae?=
 =?us-ascii?Q?Joxi+kQxe2TEcpv/92ENCMjNZ2GwOglSNNU72gj56WIH9XVrR9XCYuScartl?=
 =?us-ascii?Q?x6oH9LmjMyAPfYAv3D3gaDHao3ckkBJwo+QZsz8CV6ywsfD3S0y1oF2y7aBI?=
 =?us-ascii?Q?BdrDZv36bEq5OHMWcj1o94DB1XmhZuJiwLqiKOvaXuLuE4AAGL4AJx9XAZPV?=
 =?us-ascii?Q?P50/Ke4mQdjppvMGCtEuOmGihzOWCBQ2FWOdJVQCMrPNjaMKQSK2fXEb0aXA?=
 =?us-ascii?Q?4tItAuhCNvRfhspi/tkMQ2tKsG2psQp+B6Y2TjVJ6/iCklWZqpc12iTjJkCi?=
 =?us-ascii?Q?KNVO5kbBiWbX3jyAw1pXWoFl4V6DqnWBc+FWM6B5CBCF72r/j4HEwYAbJd93?=
 =?us-ascii?Q?Iga2iD7xhoCddmixvWiFTZvKbXp0cfH6oVi7uFR+t2KyKA8nwPZduxzfjWjN?=
 =?us-ascii?Q?WZRePiFEZ/Oq9b8FCGA0HVZUSffb1dIbB+j8u3mz1ATrhoedxfBEagUF6wew?=
 =?us-ascii?Q?MF8T4gMVe0eD3TA7EjzrloKEAXvIqPHvkqGHSMLYowmGirez8BywI4YHqUVe?=
 =?us-ascii?Q?yaQbpOf5BIKl4XcHx6LbBzoCOBHL1RyGUjyG0jVtiBsLsmsYQGoda5iI5ygr?=
 =?us-ascii?Q?6RuEJuqebunVxMlIBwHREJotnRnZze3KniXBuMvk8ICAG2/SL9Y95MStCuRI?=
 =?us-ascii?Q?0zdDKtDGJDYdnCXXfOA1nYl/NzwAy1oW+6Y4JwENGpisPOvbbuk+2I0zS12Q?=
 =?us-ascii?Q?DGEjY+x+O4bzfWoJBtvss7gU7TPGg3sSV+ySbLB65AGH6RynecHxK7Zb7/9l?=
 =?us-ascii?Q?kQ18qVyhs73LeQntx+AIfwBG0wNy5Yo90ZJSMjKeGcUBGzuEyghT9cZM+yc7?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Dm3gJl4R2aKnrleT+ee6nS+7DTgJjjk57++m+P9fAFQJqVSwSh7g/Ul4URoy7WZ5qMKO8/+RM4Xfkrl4baAfSi2tpvAnRrDKicR9BtOKQ8zmaK0eUQFM7N8ZW2LMz1Z6Di+Z5lreE72sWYXEA8iF1kYm/q8Lt8IB3Pv1Giv5p1LROzrb4IBAzsoGlT4DHu941/R/LeWjsr4N1rBUlGS2bpo1tBgYU45RQIWLeKztWyd/nbZPtesa38Ety2mKs+skXTmAJ44xiZYZkDPdpj9/CgzbtrBKK/eXBCTieBaR7a/0A67mkwYeXtSz5ki497PuIlwVpLDWVUObbPZUYRMMhznlI49dcvZblM81FxThHlN8K28uNbCJVJDep7Exty+hytNB99kS85iXO3rlc/SWMsa6TG8dBUk0AoM+Aml7xwlW+I3oSFxih8pdamu/fX8qE3aN7DVicqxxXKLqdONZEppdyXoKs5wVx2GhSGMo5LAaHxMEvZt9lmF8jbxiJq8nnrb4ZRtLaanwRbUZJzwAzRlZ4NzurIXio0KvM0QjtuznFxrhhJL4azkoaUXmha/9h3uR0G90fWGexydAP2KdKL+ouQBa1mc/NBL+WVO9e61nMMPAt34/X9Q/XZh+FYw7j4rWttlFqEHpWbPQhx1xdZI7Q81g+Jb4QNn2/4VQDhmgnMGjZJHtephWbJWyAvs6lcXeXEA46sk/Zz8hgEDSP0+y/fpcynXEdwhg4cL+zKA3rf14t/j3rYl+wofhrWbGAgqhEUN8pveX0mOtlKJzTUeuimYWeuu/XW/ccri+x6sOSIHjhesa6RBz1Ldeef4cpzcdsYyq1UfvUVgmFua6DwFhARc8TY4jHlypNxROxcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09852658-2282-490b-4b37-08db91f69cd4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:47:38.3421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ur5WqXhMPrxsgKH6ezHhbTtZf+4DBuoZN7ZyMgCve3RlCk4UiC7zZdTsfG7M2W2DEPLCv4j+cia6Dz/F3dyC9hH3Mln6KLHpM0aQ5maLes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_12,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=700
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310170
X-Proofpoint-GUID: YrVzySw3OmFSJivp5-Pw7K5_OCBifkFc
X-Proofpoint-ORIG-GUID: YrVzySw3OmFSJivp5-Pw7K5_OCBifkFc
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Manivannan,

> This series adds interconnect support to Qcom UFS driver. Interconnect
> support is added to Qcom UFS driver for scaling the interconnect path
> dynamically. This is required to avoid boot crash in recent SoCs and
> also to save power during runtime. More information is available in
> patch 2/2.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
