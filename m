Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46BE75A2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGSXYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjGSXX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:23:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B4D2101
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:23:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOM7Q005141;
        Wed, 19 Jul 2023 23:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=awn4Rh2lYHrHnMrr3x1mZ7HX7Uf6p+YqXQr2WTnbVrs=;
 b=UxrEWACdvMC9EmjhHUEFpkGibnX9NS+YzX7oP3cc7odgtSNX+nKpl5NCWRGRD6EiVbge
 qURbpyfmwmV9nUnekSr2VlGRCz4IZytpI9V/UDtSEHBcgABUvXNRr9EsRYR4Ekc+DVFP
 HNKkAb5Ud4Yz9QPlJrJnSlYgd55Bw8s0JJ/WqMUxqSXz1Jr7ibH+uoHU2DqnzFCktshR
 9kGQPQ1YW6yEtHT6pMyoifdngpNjDGU15xM9IXh7HfPO2Nnfei1waG+MDOIHYU1m/8Z4
 DykFKTMuUE4kXk7b9DMGhHq38h1f3fx9mJkFbD/uE8plKhfR87eeRiqAxseOej7Gl1rP kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a8mse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 23:22:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JM6v9p007779;
        Wed, 19 Jul 2023 23:22:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw7f122-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 23:22:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0Q69/qW5GuBwPTg+eWzcH5+f6lu7QG8Nqo3AhQVZpZymvQgrPP+ro+P3Q/z6CbqdLhpFksZFrkTqngmvAoN83nhtvncjY4uz/Qxq6gjIy7a8dLontpyc/jPVALD63de72UnTvbW40rkPXjLbhSIoKzZJQxRUg0HuVzU2nID+VQhk8GFKr5zcPVyFjjGyWklv0jYRx9HYnjFfRSLNefaevCfZK/qicpHVZji47Nke92XVMsz2ELD4IGn1zKt4yz/0ew3+kR0PuPi/vTz6wBlpqOYPZfYWk6mvYQURfexyxe9+ys4j7yT76mrNJCh1dxb9SxG3l9ul3uILQ8I/H+aQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awn4Rh2lYHrHnMrr3x1mZ7HX7Uf6p+YqXQr2WTnbVrs=;
 b=VHzjN5JPlrd26WXeL3vXESjjMoP3saqHPD281RbZlzQFN9BPs738+AclilhkJYgYNM2DGFIoUodIImUwDY9Xl0fX/K8OD8NN4KX53cYl6A9GywIYn13mGqKPacZKCiXB3Lmrd5QxCrckepk1T/NA1D62xlNv3+KeYDdKMoCdzDrzJTPM3kOAk0PW+0cPGjTYPeHak1pmhzj5HTao2V76G/3RP8yLURZfycqD6PaIV/l3TL/4Vgb3fDWuweA+8xdjtTiFavjx0fR0fqMgvrV5AbCdAjwc6RdtcGa0S3BXsdYduiIZOEv/3GuqY6+GLhDieMc7qWoRUrfJN0U048qZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awn4Rh2lYHrHnMrr3x1mZ7HX7Uf6p+YqXQr2WTnbVrs=;
 b=SPf+i2gTxHVXydQcGlPLTI2XLVylRquJ8ldaElDqCqrEAtRgWKEohKm6YvHKBFGH2T/Eq2oQ6zVe5i9/QYc8fRRhiZjbsgZZE+0gplGjF86Wqtv6nXOVHueqBzrOZ9IFOe9fJY8aTQaeV24cDVztEwVAKipij5wDRVrCVvhlv2g=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by LV3PR10MB7796.namprd10.prod.outlook.com (2603:10b6:408:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 23:22:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Wed, 19 Jul 2023
 23:22:51 +0000
Date:   Wed, 19 Jul 2023 16:22:48 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Linke Li <lilinke99@foxmail.com>
Cc:     linke li <lilinke99@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        trix@redhat.com, ndesaulniers@google.com, nathan@kernel.org,
        muchun.song@linux.dev
Subject: Re: [PATCH] hugetlbfs: Fix integer overflow check in
 hugetlbfs_file_mmap()
Message-ID: <20230719232248.GC3240@monkey>
References: <tencent_8D245D1A87D17619EA8475E8F005A151000A@qq.com>
 <65f4c60a-9534-56dc-099f-ee7a96e0ccaf@redhat.com>
 <20230712235813.GE6354@monkey>
 <CAKdjhyD4RVHFVLrcfcuEnvwrjjxAk_GL=kjcm1iw3WTrmmFb9Q@mail.gmail.com>
 <6c3191e1-23fd-4f9e-9b5e-321c51599897@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c3191e1-23fd-4f9e-9b5e-321c51599897@moroto.mountain>
X-ClientProxiedBy: MW4PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:303:b8::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|LV3PR10MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f60ddb-80fe-4f81-42e8-08db88af1232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akTsGZVOI7Iypb/b73P1SbU2gS1XAihUqjC9drSZP38zqVlC4EZDUtfeBJ0IxgYMOH341+XUbWEPrZDRBN38JRpwcFbzAO9VcNYcl3/6xZhXLU2iZzIOLTSMKfxpQ/rXdfglki4xfGiwwxrGRuM9pcoBqo8kpsTtwzH2mZWCH1vk/tmK0j32wFZUKxc9H9EjXPFJPDFe+bBUKsGiGzskHFX/mjsC0eTyOhe0l99fmRjWpTvy7qAlmSmGwsxly06qGvM+UmEkkriprXmdCNRLhTgLOICrBV6IlLB6MPRP5kLwwg1XbU/lfUXAn2DO0cWMYsOl3EihjZVVHWaRrZZG1HsJq3GrYg8/R7v4UCCqiyqsiHZwGBkV0YMPR3Flb3zwroaaJIE/ifcV4+PP7T3OCHHqFwpE/RVPkU1sX/I4lHxIICpdHwhPjOvhLPvHYDm4VTTzwhhAia4NuTrixfMkW+A8J8QwXIzklV2gJaX3QJlEKQH4BZP31Z2xLwNt33Vp8Jv1nqSfyzNwAVvlcanKV7KNnzzKXGeH72osUx2mI0u5zdadX0uRPExfjeRz78TP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(66946007)(6512007)(44832011)(9686003)(66556008)(6666004)(6486002)(66476007)(33716001)(2906002)(53546011)(8676002)(7416002)(316002)(8936002)(4326008)(5660300002)(6506007)(38100700002)(186003)(1076003)(26005)(41300700001)(86362001)(478600001)(83380400001)(54906003)(33656002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ocy+OFFRPskhVOGknld8E/2wsk7nCY2OBquG4fqhnmJhe4TwWZ7LLXhqeBmh?=
 =?us-ascii?Q?VHlCkHlMD9iJtO93b2RLPpBwMmEHWdZKC6IxaE74oSlcl1c520p8fPEgJMWx?=
 =?us-ascii?Q?2AizG80pm+G6zk+HokzUHhSYE/00Yam+O/1o0aO2b3+Iao968OaW2DFUclCO?=
 =?us-ascii?Q?cTOpjIUKuHTld7vD46GjibbR4X4cDEmebDSNSoQraf+p62qj+YZyJJkX14id?=
 =?us-ascii?Q?/zMcci6v6/tDXBBmZebTwTh7n36RqhdXkt97Y3b3TbVCnBB3KyioxNAq31x+?=
 =?us-ascii?Q?iNJqqkI7zOej5Fon8rEoE5jrRptv8w2mI2bxHBqKO7bxPSO8oSrd46Vv0lhu?=
 =?us-ascii?Q?a7kMxVls9r5oKi8di/7S76RaoQxObRsZygti9IhL/gkPFYuqC404aBDFw9oi?=
 =?us-ascii?Q?nEcqoWGudUrwYhOZUYtbBRqk5sMOogeZKiQpt4Dgix70FbnJzZh6dmoJDw8Z?=
 =?us-ascii?Q?TCJ2Xj7igUk2RNMm49mxlX9uXqQhSZ3lwBCX9Wpffe129lZdBXX2tt8sW0GC?=
 =?us-ascii?Q?uV2o06bq/AKl+LmcxcTGAc31qC40TzYPhLd0WPq/TtgMYcNn7znnHvy3xF2U?=
 =?us-ascii?Q?/rjsnlk7XTSBi5i7j+Z29xIO5G1UrnpPeqFfn5sJHPLCSj1HQRUjwufvAI8e?=
 =?us-ascii?Q?b5e6PjDXWUQsn79QuxE++DRyQBMpAsvP9VegJHVIdQkDEVRvyFPYEq0RQvC2?=
 =?us-ascii?Q?qk3Bx9JJZv7zutscAj6iQpyd69OK5uKuOHNawe63pU1Qe7eTQdEqz/eh7egS?=
 =?us-ascii?Q?x4t6u1sWQfPIfb6q9oxq9BoEKyy/xUQLTJfpvvPVPFPFEI3xWH0j+6pxy5EY?=
 =?us-ascii?Q?CVZv+C37hIkWU7QZrpNLfSj0FgyNcVmH4uvIuDW58B1nyVlt7dZhOTGbuGkQ?=
 =?us-ascii?Q?nFcIQWAmc/i8IY5ojI6qXnnFz7pqnsyZtf6vCchYZCKTcqbt1BBq23wlpLWY?=
 =?us-ascii?Q?K1yL1QTzCYSAhRahWkH1Ur8DcrbnRp++41MJhs42lrfiFSY00F+XrAPpF5IB?=
 =?us-ascii?Q?+/4EEUdcgt3OMs/wcugUVN5Ng2YkaTkULcmQxaKN4BIycaUm5xOQd09kXJsT?=
 =?us-ascii?Q?tUdzGDbR920gZjf9mbxJfSF7YlkSWX5P7SQtPRgIMnvXNAsQoAiVp3SIdz0o?=
 =?us-ascii?Q?fEIEoN6FnI6euupwkOpu/hkc5iYuUgU7eYQjRK6ngACEefzDxAU0zY+vzFb0?=
 =?us-ascii?Q?xeLf4rhDBuJgvUEjnh/ayWts+6zf419WRnf0S5EfB3+WO5pRTTm2SjpMIw42?=
 =?us-ascii?Q?yScYaOsPw4WUuX1fB89kz9elUjbgzTN5hKkLq+81kCzTehgLmVp8mXbqzgWW?=
 =?us-ascii?Q?fxPtJlrzikch5xd2kxmVUvuhghPL/geExBW0t99Ix7ZQvd63OmpYHCgutgrM?=
 =?us-ascii?Q?1c7w3PyA838R7S7w3BsHaWXRbf/WbDcLmcZpq0xN437mqT+BMbwF/QjqREa/?=
 =?us-ascii?Q?VaGHijfBiaA4HmaAKuckUuVU3ONB8DSPbo4m2AuKCdZ+Z1HsAx2yuauTraF0?=
 =?us-ascii?Q?y9vBvPIDY3fbdC54s+UJSgSr597H76sbTpkuJZ80I3W1kXFihNJQSD00Fxy/?=
 =?us-ascii?Q?7hMp0dho9HpT8kP25ZbspMkZfMBKuNjRM83OH7Pj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?H06Ce8GCHXCS/rkOyL2AtYxW/YuGGQPqRAJHERkXGZPXbHrC6XQWGBq3+3Tv?=
 =?us-ascii?Q?sT4QipLt90Vx/nOrGmggep6aOz8KYv8ALNx0uC+aJ0VhF1A5d/6+ITqfr5Rr?=
 =?us-ascii?Q?7mnYJAsvd3PTi3GQvl+m/UEFc3VnvNQCHzoM9iIdZWE0Hitjkrj/cnSddLTj?=
 =?us-ascii?Q?1qOnQWby5idvD2BYbsVjbidRFUhCs/r4aDapVF8RlhUR1mrkvGE3JxSx1HvY?=
 =?us-ascii?Q?iwEO1Bi7X+QffqgfaW0R9Vv+Gb1JlC0sJPafMgyCNSz7WxPuLPYBALuS0H8m?=
 =?us-ascii?Q?UohU+UDfT9h2YRaHUyUOmecHdxq69qJjFeCjaqFp79nMwA7zVyqEZ02VM7Cs?=
 =?us-ascii?Q?toEpbjXeyGjiSW53wFUFhHABTsvJal5ogDptflUlHfWcetPv4je718ODwPoY?=
 =?us-ascii?Q?7fCd5femkWOuUyg7IreRhsZ+JfVd7ncuzsOpgNHq8lM8oTGtHp4EOVJm2Jft?=
 =?us-ascii?Q?hAMFiOCDrZ1FCLM565Vy2ov0Auoz7pf/PD5G9SIy3/15qcKP3cyFsE/Yj0Uc?=
 =?us-ascii?Q?kNRGCfcNtTdjGUbZmk5WMIZXo1DcbpdHvjjVW5cLAu6RQm+EIjQpE/KMV8TP?=
 =?us-ascii?Q?HZg/eQs0GdYOPnl6k/7QFUVdJGR3Ump0U786z8A4VrNFyEWY3aKuU15hEnkR?=
 =?us-ascii?Q?buK63FmYyg+7DxjEdh0JX1wlWsmvqeEUVEMDFn1zp4efVgzwbSclfiBmHNsq?=
 =?us-ascii?Q?9HCoCCOrN89gT5RQxJS9F3vzmY/jqF9/CZXJk3wLD9Mag4gK2V+BmTf6jAKz?=
 =?us-ascii?Q?/8U2Hit0tEbFPLWNOnlWAR2VL970CUOUndg1eFKMy6cO7nhKIv+U9EgSs7J2?=
 =?us-ascii?Q?Vk0p/BH4swE9wfNEUUCHIu3KXeG5x14UUle3NRvzV2buGO125NjhvREkZIzH?=
 =?us-ascii?Q?dvaGpB4aHGVCsRLN+0PvFj+sESfW+LxByGgZXeeHRssr16fdyxDkMonA3TGm?=
 =?us-ascii?Q?He5Aj+439MkIw1R6otH96Xs5GjakmgYIQ8PsaDr8kGj7XxTaGqXONJFxWyUh?=
 =?us-ascii?Q?NI4bRp9Nh3Yfp2bHBgHzG2Guq72yDLE2ql8/rRLVIqIbqks=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f60ddb-80fe-4f81-42e8-08db88af1232
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 23:22:51.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MxmWVtMmK1Ie/PoeJPFvRK8Tui3MGOszWuIOA0hC1S7pUvLc03TZLfuojhxjnDtcWtuS9bvUaQbnOP7zy3+TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190210
X-Proofpoint-ORIG-GUID: 7zN0MhwAlzlSdnBKWnGx2ThZYdpRldF8
X-Proofpoint-GUID: 7zN0MhwAlzlSdnBKWnGx2ThZYdpRldF8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/23 18:10, Dan Carpenter wrote:
> On Thu, Jul 13, 2023 at 03:57:00PM +0800, linke li wrote:
> > > However, if this is a real issue it would make more
> > > sense to look for and change all such checks rather than one single occurrence.
> > 
> > Hi, Mike. I have checked the example code you provided, and the
> > difference between
> > those codes and the patched code is that those checks are checks for
> > unsigned integer
> >  overflow, which is well-defined. Only undefined behavior poses a
> > security risk. So they
> >  don't need any modifications. I have only found one occurrence of
> > signed number
> > overflow so far.
> 
> I used to have a similar check to that but I eventually deleted it
> because I decided that the -fno-strict-overflow option works.  It didn't
> produce a lot of warnings.
> 
> Historically we have done a bad job at open coding integer overflow
> checks.  Some that I wrote turned out to be incorrect.  And even when
> I write them correctly a couple times people have "fixed" them even
> harder without CCing me or asking me why I wrote them the way I did.
> 
> What about using the check_add_overflow() macro?

I like the macro.  It seems to have plenty of users.

Linke Li, what do you think?  If you like, please send another path
using the macro as suggested by Dan.

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 7b17ccfa039d..c512165736e0 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -155,9 +155,8 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  		return -EINVAL;
>  
>  	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
> -	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> -	/* check for overflow */
> -	if (len < vma_len)
> +	if (check_add_overflow(vma_len, (loff_t)vma->vm_pgoff << PAGE_SHIFT,
> +			       &len))
>  		return -EINVAL;
>  
>  	inode_lock(inode);
> 

-- 
Mike Kravetz
