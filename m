Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D131C78E44E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbjHaB0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345545AbjHaB0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:26:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4496CD6;
        Wed, 30 Aug 2023 18:26:10 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0E2d3009258;
        Thu, 31 Aug 2023 01:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=1icmN2cTOV1YJvbfsotjdWIi0x9l+XcaLpfYj0XPYU4=;
 b=ihzqwNDYz02A7yCqpaqMr64MPNXs3Q6itZnXeJiHjRGKHfbEsvQnYJ234iWWyG3uYnme
 g4ek28YsckwE21Cl47KLT+huvOXeCcQFB7ek2yee5/433H+VKBrD+CrSHyZs8btSKRSD
 L4Rpui9lN5bQZOtk32VLXXUj8n/0H7KnXjm3scz3YF/pFy2Nh26YPD98twrtxWelDO4L
 iCC2xZjYcfW5vYTSeW5Q1G6EA3+CLN9EpJoI9CtHpRZ1P1rpLyQMwVoHKdP5NphzARzS
 NjMlMXh/sTF0634mJQfcUbYcYNcJI/3CSsRUWhl7i4osHL3xkALg/BUAfYQKzoSoUdS7 jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4gspa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:25:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0PPYa032785;
        Thu, 31 Aug 2023 01:25:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dqtg7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOrdBiEIPI14ducYgNfQ/+2gWmfD7E9VFZv/2p7QfxjHWIetPXAGJ9HCNZZZughQ/fmgz2ybnkYTemN/A8sTn9tZpWfggVuVEy3qgxDMMi+PZ3K+3cr+cx+4mdxLZv3zPTlfiKCZZKwGBbTE3lfncZNuVd5IyaVCilGDF64QQdS8TSJ9nwWpxGt/EF10ETevbZM63D1s143EBunID2YYlQTi/Q0qXJKUPvrVlwILpxPh9dd83lUjIhnIA2rNoZDkoIRJcdrNOGFg+S9yS7/K4OZBqJup2Nls9wyDb6E7FF4oFylGF/gqW5y/0d1fw40yAQ3GrPV9V2lMq143kbaz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1icmN2cTOV1YJvbfsotjdWIi0x9l+XcaLpfYj0XPYU4=;
 b=MryW66IspjJk0/4Jq1qWk1aZieaMgBC9wYH6eSchnlc5GU70tqNWpAKPmUhk8TfZxDvwuO2l04vRtoZoPC4mc9yyL9NRQrCvM9/ejJXXLR7AIW7wX+G5dc9U+UabEqx+L8ld+Ok6FNyvP4x1ZuBZ286d7owR1V5CYjPKjuEfAM9CkcibI9wls+N/GiD8UwZnfFfH2cuvuWOzTNIsNPsmCKc3PPO5EsfJaUNEJTb85ElifMJGaYDK4xK/gB0nvKoDwFEzZtGp95DiN4hZbBLhpvxAzQJn0M1Zrv5DPY7vs4dgpqs3JFknTdcq46Wq0M2lIjCH3sHwrJikE0C/4Nrc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1icmN2cTOV1YJvbfsotjdWIi0x9l+XcaLpfYj0XPYU4=;
 b=iYesnWGGk4scv3KeES6B7N0mdl9ql0crzbNpDe8tiP8nPV6RmYZa3++cfwddZP6lCo6uObgEQVM3CbjXzSHLpdtpgBgDCVioHlEhpSlVwk0a59LoIyb1K86Sji+C5XPy1dB+z65lLu06xBkIzG3us1zDRB6VGkuFe61mvZTB+Go=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by LV8PR10MB7773.namprd10.prod.outlook.com (2603:10b6:408:1e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Thu, 31 Aug
 2023 01:25:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 01:25:46 +0000
To:     "haowenchao (C)" <haowenchao2@huawei.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>
Subject: Re: [PATCH] scsi:libsas: Simplify sas_queue_reset and remove unused
 code
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zg28t33z.fsf@ca-mkp.ca.oracle.com>
References: <20230729102451.2452826-1-haowenchao2@huawei.com>
        <3fc45984-46f9-dec2-ecce-68d6897874a9@huawei.com>
Date:   Wed, 30 Aug 2023 21:25:39 -0400
In-Reply-To: <3fc45984-46f9-dec2-ecce-68d6897874a9@huawei.com> (haowenchao's
        message of "Wed, 30 Aug 2023 20:52:36 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|LV8PR10MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b82462c-1c82-4c27-f951-08dba9c1335c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0FiPbqPEQFIACe2fxkeyuItFvJSIzXWL39BwGE4QklEC9wkH5kmluiC+2VlmRlciZ9tPwudNQ0olm6Ufnlp0IDUODfPfzXY5b28qjLSmX4QoBZBn1pi6LA4ErWPT4t/jrVrnLxGnRtuhOoFXIcjedSq5qw7Rg7h32m5sq07NISKZ4e6SBOVaIeTC/nHuQV93Cl1jRktiV9gIN1BPXIgZphfFuPUhyF9oOIk67koWBBkYvBVVtPfw9HzEOFnMwtYvJhXQ0ac8fXtoC389ke5qlsa/IqGXM03MM4gJKKpOXhUsI2oJu4D/JlApVXBOv9fVmRv60UwUWB4SQScgQUvQkJpGIJ6A+xxrgzhB7R9TN6uwLK6ZN9+hetfoTK6uZIGg41e7Q3ywo8G2NBrV+iUrOBEHLZSh5o4nqhIOm1D+k0HqjTd9QzNXNnxybZxyM6PMirVQsnJnbT9l5rO6fAIIOjkejETe86RxKsAR/ifuzWDpyVXZtOtq06Kbdup1wEhMTNpRYy/A5jDSRjgg359+HBb6Gsfw5F2IQPYDSt0Btw5SV2oGLtGaFlam/ovMufeo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(451199024)(1800799009)(186009)(6512007)(38100700002)(316002)(4326008)(2906002)(86362001)(8676002)(558084003)(5660300002)(26005)(6916009)(8936002)(6666004)(66476007)(6486002)(6506007)(66946007)(66556008)(36916002)(54906003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?08AZkoZJIvz9lhj1IWUhqBk4QBawkL7abXhLZAHUYRyGdYjhzr1yOLpj7O/h?=
 =?us-ascii?Q?sKUmGBnqTW/g8pB+7kanzV26vE0/tgfaK/rZeHDMBx1e3l4OYrDRrGi9XvbR?=
 =?us-ascii?Q?7DWLs/T92G5QgrEI598nuh8vyLymO34glFBI5JaNtSlVITVacuIN8jF0zwoW?=
 =?us-ascii?Q?KK0NOGNMXDFUVAM74EdgSTXNcCYVgIu5dF2/4wvFT21uht9BXDYtJ+AhE94i?=
 =?us-ascii?Q?FHiwNI1DDS8n/plUR0qE/d4TE4CpYSudC6cY8gQI9g/wAmhG83cLwYn6fJzY?=
 =?us-ascii?Q?tNRpXKScC546zzGV0HCtplg6X2XJsZ4i83Wt3qFcrmIwOmRvg3RMQxq39cHL?=
 =?us-ascii?Q?naZ6BFXv2r4N7X6u4TPCEXmkYHCtuRWtrYayqEZFxIH+WE1Td+h/XJZiQzAb?=
 =?us-ascii?Q?RNGPnCo1WmtlbgTrlXPzsiaR7IwdyKU7E3c0yjnDVGfU6xc8uza4Ki+WSbhY?=
 =?us-ascii?Q?WMdfUbe8CUQPIPX/lCbXJdT+J/JzI6VApr8Szk0afJdaXa0ZBU48XdxyYCFg?=
 =?us-ascii?Q?vWtc3f4MnFrGVL6MbCWgjmo6Ty/hBymwz+/0ouHFXdqpyReahUhJjFvilcYb?=
 =?us-ascii?Q?nkNoH7J3vxlhzx87BnB7FPoKYtIlja5xyfVz7f5Ub+umgTXjqe8fTINgAIi9?=
 =?us-ascii?Q?A1EQDfO0RoWTFO+wxc8Z5Sxhvy6+nm4hIv6dpK6XNQCrjh0on6Dirz4/5xgS?=
 =?us-ascii?Q?3bPahpg/M71+ct6pRw9UtDT1toLH9oe73nXtluxtB2xQe7U8IUE61op5xKBm?=
 =?us-ascii?Q?mDbg5cK/D07qzv+U4IIg8uGCO9buDHc18JWPAdrQUV6U7lThnuS9ZzX2M9eW?=
 =?us-ascii?Q?Lcb0JvcpeDo4x/67SpFH4BGVe0lRZJiI8tNfIbhLqUUpsFSyBF6i9Y9rXZ10?=
 =?us-ascii?Q?zkFBqYrCJjaCyzq2r9dlXSPKQ7L/hTf5reWu8wC+ua6mjdplTsKm5Ah84Y9O?=
 =?us-ascii?Q?FgMst6/wXSZaJrxdz8v6dneHA4g3cmxaucRqd+56X+L34WEAisx33RgUrl97?=
 =?us-ascii?Q?8xE1pHPAqD/cWePic6em2iB6JbEedkvaNirU9Q3+534twvSeUcM32t7BWvdX?=
 =?us-ascii?Q?IrQ+qNbHrxGdSq1exQU5eozGzSXGXmXhnA2Nffs8/xcv1zAytXEIQjfoU5Kb?=
 =?us-ascii?Q?4Puy5lfiDZSKa6qjGKZHbCN2v0kXjTtqWKrDihCYjHHf1lf8yQBru4gbZxcl?=
 =?us-ascii?Q?zGFw4HcCrQtjeI5QbHQl/gNHhuvsOiWCU8GRhisPXoxaLtF6cbSf1pe8ky2Q?=
 =?us-ascii?Q?HWSlPEUKjudOmXIrrpykjNohC/f//gO77+vvxsc3gKkZMOfU3OCq/x7AYWpJ?=
 =?us-ascii?Q?nZCm6CCQM4hh2khXOmtWq/3yZgXh7yk1DaGK1jYTRI/YWtB8RA1nxcdnoWPn?=
 =?us-ascii?Q?+22Eqt54NMBkP9HLL1hGsDI5ZJGY0A7x8xMDUDIzOPiOCoFDv40qtVa1/4Pc?=
 =?us-ascii?Q?V+8VqqxxaDVHLCrfkmfEh+qYAM1uUeHNjHZjStkrqqQF9KVspgXaWFh7V+pU?=
 =?us-ascii?Q?uxvWKflYtYdOFa7ypKrm9T9gWNjsApxPz4MzB/ehcVcDHiLwofKX+v+aqGl3?=
 =?us-ascii?Q?bsq4iTnS15cKYFMH6Und5hyF/y5cS/sNyZRRqTst1cm20virYfqLSmqcf0Pd?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wOCa84l9jdotNb0/J7IXi74tJZT/gtPd+U83UirAHwtpyZZH2dBh9+IV0XmfUJYUEPDIphr0IXNbI7vxyUVEMNYPuORzig9YLRpQ0jARhBds50ZM71yO3wlK5S07ga+zgurqQkd15y17vaxETVM2LHv457cpjl/GcMace6wo6VhljMR+/3cYN7SlniFHmtscXiG/KpR+pKbzipuy6C46pB98vfJ73BtiyTZVfeqotNp3JwfEjbG9MchwcuA0/rU1/FZGH5ZcZxbGUkleTCR2ukOPnD8Q96eP6f3NP4ww5OUnelScew+TbWlVvTf3xNst+vtdfCdJqRAyRjBnDzITXvUcLRkmOZw4EEnHgNX2VT0GAEqFyvnx3Xz7xl3vaoZUfLULIvNlmfLidK7dCTjE2++lDbbQgLwURmrAG9Bk6+Qh0NBo1dIIevGpFjFUkhwZ1N+DOltjeE8hS123V76jEXlArRzN71W3LEw9f/nx6/XMN5gUGEI4Dw5uMu20c1oucdJC/LG6fGDIQiITp5pUUzLfHjJSZn5HyIp6zCe3/04AUtpYcl0w6GXhOwRJ1Gci+uLiwAXI9eN43tZmNO5K5BqqqnD+VBbGCa9QQK0isE5TQ4/K41wc/tVkQw9tkQ2OTiP3Cxaw8Bh7gFvIo5vsrb3bFSDsatHyxaIW2C/3XwXcP9FlV2JuajX1tAvkzmRJddtLUz2A7EB+2S9sK2GuAHEHvry21ZI5RNu02P4ZApfEs5e9D4gaytjVz1+hVT9Rt0KSLmSmpEr1uo5hfkryFp7Npv6JLHt94Sxg7cxw0/Mvfsp3nHn1AeM96w3yb4+ylrFWq2N+VdhTeA17UCbtlnE7tnwKI0nfAFkRsayQ1E8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b82462c-1c82-4c27-f951-08dba9c1335c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 01:25:46.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecmpot9k5gz0FViwH60EpBz/3Hm9F4IO217MW4p32ebhgNxr3VJ98OAbbhUQbq9cCn5HtS8NG+7fmu/9h/4zAZ7emzDa5GCVoKaOSJN4QEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_01,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=978 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310010
X-Proofpoint-GUID: gne-OP1MhiHRUtS6MpNQ2zW90DnT-Jlu
X-Proofpoint-ORIG-GUID: gne-OP1MhiHRUtS6MpNQ2zW90DnT-Jlu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> sas_queue_reset is always called with param "wait" set to 0, so
>> remove it from this function's param list. And remove unused function
>> sas_wait_eh.
>
> Ping...

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
