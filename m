Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002A57DFAD1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376852AbjKBTVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKBTVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:21:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E2012D;
        Thu,  2 Nov 2023 12:21:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2JL2SC006106;
        Thu, 2 Nov 2023 19:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=/F/wl6FY/AUS/Wmc3uS6IrGf3SKq+EI6CqMe4XjV9HM=;
 b=eITxoTmY4830wPXphyUdiNth3+/sO/T/uKsf/mViPRcUchCuPs9kKCIpIV9mEHRtI8JG
 +j1ZO8eLMFlivX1kCl0toBYlGzUOIIrz7rbio6nywFMGomweUpQkGylcsUDKm4H3dRFO
 o2F3bD0IRfZgQk78yEUDxKKR3GgNfSnqnH4Xa7BEWBj1Xz5F9uXunZfcAr+ODt2O7RWl
 +AZGFtSryKMnSMaFD4xI94oiLZ7v0IB58ZHkbn+ZfY+aYALPf/53/gUTw7hrzDm3zEo+
 agvLGGNSY1qHS4i3rREr/P3H0ThhoRpQRZ0EMhDbXyHJFy8j8lwcIXgltpVmUlQixO0N ZA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swttndk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 19:21:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2IeQ6c020419;
        Thu, 2 Nov 2023 19:20:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrf9reg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 19:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZvORx3Kx/9lafUB+Nf7vxxZ6WSf2zatrs6fvZoneeh1vG/tpq3cg4cvEtxVWW+1jlt6gZtYhAluU96k6Ba3cF1mH/sWnrQO2UNv4yahdE4ioN8MHRaLv0kS2n39XlQTaaBIlZBq2U5kZKTFdpXvjhyMvJz+5uJtJnuA4ixUt/hYlaa4/vG+4MHCy3aNEsXMECV3MFF0pofpTdvXNHsH+C5+mIOh3pFuA/DgzyetabGPpbtxk5mB4XTZs8oAr7Q73RehdCXK07VeGsQJHIi9o/daVeBrrcUhjC3DtUj/1vCW2Jui6xwhnFctgHPJxJmQvOe+bezLOz0Of/dDKcJTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F/wl6FY/AUS/Wmc3uS6IrGf3SKq+EI6CqMe4XjV9HM=;
 b=YyGVF3ei2ceBaSM7fGfku+sb0z46s84kIR5gm0+m0anVFR5OjA3yw1H/CC7SvtXmVIOB7u4ipbOSnC9TqyFNxnD0IGCa7JPEW1su9hbZZB7rrmGUnrw7Xee6RSeY8ZM90912gtV6dm0zQ5uWxnydE0TyY+m47Pn7qjBwWx94fQyFEQPKKmaqFoHaBLLBJorqv8U+Hf1SvxSsjo2ytPsumA9AjINxQLpLW4DFkSUf/0lVKB9V8i+WCB54ygRbz4jWSdghkbVx0hymAU6EUUmMvzTZ3kDpi9XJ62dVba2YWKVAbLtAuNH0KsYz04iRV6rvaG7qAQj/3s113fQRJBJ57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/F/wl6FY/AUS/Wmc3uS6IrGf3SKq+EI6CqMe4XjV9HM=;
 b=KK82aRVCypA3/Zn0wp4iwXnbj2f2rCm0Ml1KkAb7tRsibsqQiYnMTD9qH+WeYSYRpbV1k6kvmo1GOsplJNjzmhN98FGvEBF8sInzXSWbcljKGxWKxq+gO6mhJTv7utPMncJpxd5bym97lzi9BhlFjBruTYseIWrCfhM6O2rzbpY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB4974.namprd10.prod.outlook.com (2603:10b6:5:3a0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 19:20:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Thu, 2 Nov 2023
 19:20:54 +0000
Date:   Thu, 2 Nov 2023 15:20:51 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, stable@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 02/21] binder: fix use-after-free in shinker's callback
Message-ID: <20231102192051.innr2tbugspgmotw@revolver>
References: <20231102185934.773885-1-cmllamas@google.com>
 <20231102185934.773885-3-cmllamas@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102185934.773885-3-cmllamas@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BN9PR03CA0792.namprd03.prod.outlook.com
 (2603:10b6:408:13f::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efdcf9c-e7f0-4a54-a311-08dbdbd8d552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4pxdS/cV5Ec1alFtIUiLbQLc3DKHm67KdEI5eVlaSs36rIMoxYGQLLm+7ALa+SfabhUnctUM9gdg8iLNuJ7yJYpVtDd9Zk6F3oqj1ZMIb1TV01pKDW8yxjfYXrKORQbn86ihW9dV5LDXnIWZU6Z2cHGZedrBmgNx+7U1OjMx8VvEsltUKGYDVQL2Lcg1kcn7zZclCtTJmh9HE+/fa30pAgVdv8JbjWdZePVvDFMiMA8teSbz1zHrkrH0o3VbD2Dy/nwMwdHuUjXhhr/BpRCka2b1CKCK1BBwZYuEvl5US74u4VfaR6fp1LoAyyWXiATC2cISond9b92/rHxpxVwaU8x83fvQK+Fagt/wYHiKTZEfy5c7oO7Uo6UK9BazvMGXTDf6K3yApchRT+2zejI5XA8DpZ7zGUwez8vd8m2u1lbBCHfpE53RcZScBVT7Wvb6TZ5OEiwVI0qnP/rHUvV89uApNQv7ALvqvNHAV63fs0xNP27+6SyFZCqQD6PeVJzhu+GpjNiYnPcChLPfvfjEcnDDqz/zDvDxwahtQTTqIcJAUjhNsrvay0Mv+cXu2vod
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(9686003)(6512007)(1076003)(38100700002)(86362001)(2906002)(83380400001)(8676002)(7416002)(6506007)(478600001)(6666004)(6486002)(66476007)(316002)(66556008)(6916009)(8936002)(4326008)(54906003)(41300700001)(33716001)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b9rFFrM+nkKZQYtfXbQhN+NOw9EOsm8SIl8P9GW1GcBq90AEbiAdgaIdeDGq?=
 =?us-ascii?Q?Mlkz1XFHkhdfXb7Ch/eBZ/NMvXf2Qw4cM/JpVTJCxH9Iryhlp780fBUVn8pO?=
 =?us-ascii?Q?Gxsbgv5i7SZfnz4r4gpK+YNPhs+/hF+oHx6Q6apo1KWIBZkVxwjfAgtnOnp8?=
 =?us-ascii?Q?mEuXUnNSHc00UiaIUv/dGIeK4rc9AjCkT31dV5xDhNZNMbpWIFDFhx0t4scV?=
 =?us-ascii?Q?rlR7WNd/oYxWt/hN1CVBVO3tUn6yp4GyMPGewHD6o52yLUE4w9uCfBwmgsM/?=
 =?us-ascii?Q?2160PwJxgUBVapTaQV9EXh+oGGe/vkT38g76lWbCKZDK8UqPqMAKWqzhHz6v?=
 =?us-ascii?Q?N1bMJ8BGMywdqCBiLi+Q8dsiqmgOMS9zYoGh3jGCHWcu/RIWKn4cnGQY8E/m?=
 =?us-ascii?Q?0L1F01B7X+KxGLDdCWWlhxjgwp4mdZu8fuYKzX8DiZuoiA9xLby46+QJJgOi?=
 =?us-ascii?Q?GLJ5N+3h6nqCIuYhlROvp/7JZc/w+7ENr75wphzTPagvsCosw6FpNCmR0L01?=
 =?us-ascii?Q?xcZGMUTgPZxPiyhFUa64dswUf+ku/yK+9l80bQPbgVXxRqY/EmeDljofz/QD?=
 =?us-ascii?Q?vZPjwnfvEiZfxqAoy6T8q0ZMOgz0A6qn3LZ5in38Oyj6b/fWfCZ6nQaFQTSK?=
 =?us-ascii?Q?IaQV0Zo9APyWRUJECag8Pn+hXshuI2YWGeU9ZO0+j5Do7Wkfwy9Ncq/rGFNh?=
 =?us-ascii?Q?IJNxAqtnKQUtq0QduZuwrHsS7L19EH22XZWneRyiP4oAuWMn4s0HZWJ0tJV2?=
 =?us-ascii?Q?nEFdFPHXaIF5yP8STDSY3HTiNnLlxMukssOx8QMQ9fao/G9qFrImU+FK2Zwg?=
 =?us-ascii?Q?YXIy4Pm/E2PQEZaLdnLPjx1C6DhIHoqeqXeXehzhkTDFM6LXhe5iWoeR1gzl?=
 =?us-ascii?Q?nlTZ2tNXQ2r2O7QqdfFnruc3S3FS0ORKZywEKfhox7AVHJPI7ulA5e6SXnXA?=
 =?us-ascii?Q?ZqWfHgMO9QDyK3degFlRhQzOn8zSOeSOXL5RGgNDbeGGHLWhqJh2qVXuvkmS?=
 =?us-ascii?Q?AaVtFMkh9dzY5w5I//D/NtdFZr5S5wo68wLWquWJECVwc4PNQZ2EaI5YGWP4?=
 =?us-ascii?Q?FkXwDRBw/NAdZ0UoBnLtrQFvme8hJWGajr+qPvlO2QUSr9jiRcIYKmdUJB4b?=
 =?us-ascii?Q?W+w4D+1RvMyU//ifzzuzEQJXwp4CBoJOjzK98miZ7fh158JXrjWs4ON7Meow?=
 =?us-ascii?Q?L7DRna0v9LOGhiJaA6uuFicYLl8qNdlPTu85tG6yGgB0zsRS+UY1wcyLwV4W?=
 =?us-ascii?Q?3D77njX/aVdJeETFwgeaF5eyXKXRFmQjuvpgi48oaOx23GWdf4fsXS5jutEx?=
 =?us-ascii?Q?+gdWRaI6wEsCpgAGwor9iaLRE2GRovD6Ge+jBOlcwSmcDeGo5j2z3DEH65az?=
 =?us-ascii?Q?2xTd5Bb4bgIf4PrK+1qJ8U3aEFof4SCSmgQavErUCX/vdzlS6btD0mujMB3M?=
 =?us-ascii?Q?eaYyDcPVFnEb/kcNjCrZeeSxMVDMUZxfgbzQwi4NacTWbYIPOUnphhpADvZJ?=
 =?us-ascii?Q?rMg+SmSgeH939h+FXGJ16UbUUAmRxED5Z1Dvk1iadxLzj97+9q+tg6Sc4WrL?=
 =?us-ascii?Q?8W/c267VG2iOvZuEUq0n1MsN1/t5B57DJPeDvLFX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CCo8L6b3hCGi18yUSkay2CyTFyCs2xRsS8LMNhzjOxAvVZq1ZyEezXjZ5RUS?=
 =?us-ascii?Q?wJ83z7zGi/RrgtUj8Du8YLi8xYGu9MtTJoUie1xnHOz5HTQv1LYDqwemIAx1?=
 =?us-ascii?Q?bVNsicnGOsci4ZMkcZObin9I5yhhjnsu/AbNB2HeOj+SqD1/Ca049eNmXNC+?=
 =?us-ascii?Q?F07RjA4PB7GD3OfVtUOt54MnJuyGM++yn9LeLYRGavpnpfaqE2qZK1ZfEcWk?=
 =?us-ascii?Q?gi2o3rkO/Kbkp9Z+UPZfBe0F9cCUgRG/LlFxI9iTefmHT+W1lzNlJvVuFB0V?=
 =?us-ascii?Q?JvvmpGVks4Fq5wSkof9jeA1Cm/bNN26lhkiUSOxFPyD03hwnGL6tP4rLOPM1?=
 =?us-ascii?Q?BiyKRkEyledOevsxtBChFRhZT0dpgsJfazbFVyJ71mLWX6So7elB9LOig+05?=
 =?us-ascii?Q?E62M3ekACp2s9Gbu4m7ZXgUCFs4rqGgUSy4LFntP2MRSbcYtUWaXYo+uVSaz?=
 =?us-ascii?Q?Mx9FkMzqmAFaQwH5gVbBVxuZUZi4XqkU7CLDpMIif0RN6wfHGI2LlPSCp6MQ?=
 =?us-ascii?Q?ipiw5OyrOs9efD2AGtHuX2q/GLohq62DwjHqFvANtBndk2Ivfj+tX1KWqxkm?=
 =?us-ascii?Q?6LPY4GGimhptzq+ICU8RXLc1As8lfK1NxK9yUX2T7vy+r18zsUhT+RqXvQBT?=
 =?us-ascii?Q?a3d+zvKsHfrnPoSuB2YYzaGY/9m6e60r5PM+cINWmJK25V2H04k/ZYQmZc1S?=
 =?us-ascii?Q?fvcUiLyLxMIZr8GpKmvL/ij7Zz7LNuBy3PDabED7qs0ug2s5Uj//7gPPwfZx?=
 =?us-ascii?Q?VMblHbZF9Cn1yXOdY9Ypa179LVJmvRqQxi3My1efYM6WJUMWg3D1MXqe/VH/?=
 =?us-ascii?Q?jsDRS6ePI6Zq1pvF5MEv7uWSyXzTBufiFQQIVPUWR3XDv27bHOk9HrzEA9WL?=
 =?us-ascii?Q?SotVYpuMh/pHx422sPtRgIKqc+FKTp8AmIULAygsUat/24oxNkRwu53p1/n5?=
 =?us-ascii?Q?AubcJSGCdAEF4ymXz85Tmzl94/LCGrkq+1x9EEXC353MDJE3M6TwGsYz4n8E?=
 =?us-ascii?Q?J7SWNy4xtCaCaMLt2v+moOU+ZfQOBqOiRYuf2TMbQtehUAs+YMG8Dm8jAAt1?=
 =?us-ascii?Q?D0YYqfGPCz0mL4bc8scSSadTx/wXVAqm0R8K73N3tcvzqdyFqa4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efdcf9c-e7f0-4a54-a311-08dbdbd8d552
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 19:20:54.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyjO6VuYlNLZ2uOQQWDTF5hT9zVShgutSWfeq+k2dCGT5zja2UHHvbATolOe3L2/XMrhWZQOORXb/KtPCfyFzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=863 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020158
X-Proofpoint-ORIG-GUID: BwWwpUx6kujQTz1robVxXb5ANmNAINdo
X-Proofpoint-GUID: BwWwpUx6kujQTz1robVxXb5ANmNAINdo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Carlos Llamas <cmllamas@google.com> [231102 15:00]:
> The mmap read lock is used during the shrinker's callback, which means
> that using alloc->vma pointer isn't safe as it can race with munmap().

I think you know my feelings about the safety of that pointer from
previous discussions.

> As of commit dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in
> munmap") the mmap lock is downgraded after the vma has been isolated.
> 
> I was able to reproduce this issue by manually adding some delays and
> triggering page reclaiming through the shrinker's debug sysfs. The
> following KASAN report confirms the UAF:
> 
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in zap_page_range_single+0x470/0x4b8
>   Read of size 8 at addr ffff356ed50e50f0 by task bash/478
> 
>   CPU: 1 PID: 478 Comm: bash Not tainted 6.6.0-rc5-00055-g1c8b86a3799f-dirty #70
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    zap_page_range_single+0x470/0x4b8
>    binder_alloc_free_page+0x608/0xadc
>    __list_lru_walk_one+0x130/0x3b0
>    list_lru_walk_node+0xc4/0x22c
>    binder_shrink_scan+0x108/0x1dc
>    shrinker_debugfs_scan_write+0x2b4/0x500
>    full_proxy_write+0xd4/0x140
>    vfs_write+0x1ac/0x758
>    ksys_write+0xf0/0x1dc
>    __arm64_sys_write+0x6c/0x9c
> 
>   Allocated by task 492:
>    kmem_cache_alloc+0x130/0x368
>    vm_area_alloc+0x2c/0x190
>    mmap_region+0x258/0x18bc
>    do_mmap+0x694/0xa60
>    vm_mmap_pgoff+0x170/0x29c
>    ksys_mmap_pgoff+0x290/0x3a0
>    __arm64_sys_mmap+0xcc/0x144
> 
>   Freed by task 491:
>    kmem_cache_free+0x17c/0x3c8
>    vm_area_free_rcu_cb+0x74/0x98
>    rcu_core+0xa38/0x26d4
>    rcu_core_si+0x10/0x1c
>    __do_softirq+0x2fc/0xd24
> 
>   Last potentially related work creation:
>    __call_rcu_common.constprop.0+0x6c/0xba0
>    call_rcu+0x10/0x1c
>    vm_area_free+0x18/0x24
>    remove_vma+0xe4/0x118
>    do_vmi_align_munmap.isra.0+0x718/0xb5c
>    do_vmi_munmap+0xdc/0x1fc
>    __vm_munmap+0x10c/0x278
>    __arm64_sys_munmap+0x58/0x7c
> 
> Fix this issue by performing instead a vma_lookup() which will fail to
> find the vma that was isolated before the mmap lock downgrade. Note that
> this option has better performance than upgrading to a mmap write lock
> which would increase contention. Plus, mmap_write_trylock() has been
> recently removed anyway.
> 
> Fixes: dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
> Cc: stable@vger.kernel.org
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder_alloc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index e3db8297095a..c4d60d81221b 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1005,7 +1005,9 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  		goto err_mmget;
>  	if (!mmap_read_trylock(mm))
>  		goto err_mmap_read_lock_failed;
> -	vma = binder_alloc_get_vma(alloc);
> +	vma = vma_lookup(mm, page_addr);
> +	if (vma && vma != binder_alloc_get_vma(alloc))
> +		goto err_invalid_vma;

Doesn't this need to be:
if (!vma || vma != binder_alloc_get_vma(alloc))

This way, we catch a different vma and a NULL vma.

Or even, just:
if (vma != binder_alloc_get_vma(alloc))

if the alloc vma cannot be NULL?

>  
>  	list_lru_isolate(lru, item);
>  	spin_unlock(lock);
> @@ -1031,6 +1033,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  	mutex_unlock(&alloc->mutex);
>  	return LRU_REMOVED_RETRY;
>  
> +err_invalid_vma:
> +	mmap_read_unlock(mm);
>  err_mmap_read_lock_failed:
>  	mmput_async(mm);
>  err_mmget:
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
