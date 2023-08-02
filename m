Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B43776D479
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjHBQ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjHBQ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:59:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9E81981;
        Wed,  2 Aug 2023 09:59:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372FYKce021746;
        Wed, 2 Aug 2023 16:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=BZEWiAcxx3y2K1spA6Nv6GJRqYoS1LYwbOd+2vWOfZ8=;
 b=FjaDQuTaOzjAi/SJh3dB6fkWHGLi7ZoPcM0nwzbVxJiPCOu42MKn+EIOwt6mNOJB4ruT
 O3c+2Oo7aTBFGyTVbj5zwkupbqGKDhIkaVSj0A4pveB6xXjIRXDovZ9E0qoL8R5i7cyf
 TjMa9hVvHpgk7cHSzjqPtWH174PiIcW8AyiZe4iP3Gky0rONdxO6KomFoGVh5OobzuDA
 i3Frqv0WA4pnpq1UlaJ1ous09+Y/O1pSIa8cYCZHgZ1Y+G+VwOfPzGuTvJYb5Y6ySn31
 zus9hJS3rYVnheoxhkTcJrdasbCIcxovIUJN9NYRwRL77uTnyoOEGOhOPRcoyDbcY54O 6g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc7uh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 16:59:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372Gq6lB015674;
        Wed, 2 Aug 2023 16:59:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78efew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 16:59:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrIKff6OH8gCgnIovafBidlqo9d2h/GD0Z/A8zuEJ5+DqWJx/16eH5hJZmprP8X1+oQXW8gQu3ey5ztqUfhYxweOBYKX9wQJaU6huMjvt6Hb+MTflxKCH3nGfg2odHAWNp+5FcF2bni2kKPFYaAlNJdKOLMIL2N9NCQi71H2RQlDrof95pQxXw1dUlgyqZcQ9Fe2MiMIWobeuGJoHOwS6uXswOgG3XhBhLfLxjLP8B7Qg0v+vw+XMRajvGQpMZaZWhQ8URj0ZJ8+VJf7Sb9xHkuziTaz/RD9pHBjuYy/QDGjTjHFDYluGiPkpq7f2cBvBAPca+7MIA3IBe+FvwwA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZEWiAcxx3y2K1spA6Nv6GJRqYoS1LYwbOd+2vWOfZ8=;
 b=Ijg1/+HKWLBh/mpfSnpaX1JeKP7lf3OJ9lC3GUaFYU4JYZtpk/o0ZAnz0dtBS7O+NDS7G/PosPVOwszyCLLNVxMtFoSeFaeC3yRr3Was/M1WGzWkWn4EYBhKBB8qvrn3a58j/YI7ywP57Qtk/cOkzxaAfIwz7CvzruqBNbAraN5L/s3nmTgRwd2vLcCsMzEEo2Sq4jdjtOA6lugrMo0aI/VCkAT7ZDIrm2bLNfZLRKbDXbPlOZK8fCIrQyMsmVBksSpX3KELNL2D1BhTat1wM75oFZsSBu5X5a+vSh0AFUNbdQOpcSKeAfF2lPS8J6pCz6pJIz7xxdJW7nr50mCgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZEWiAcxx3y2K1spA6Nv6GJRqYoS1LYwbOd+2vWOfZ8=;
 b=a5yB3vzn7GAXuqG4b9WHhACdLvO9voFuVQK+E6GAptiedp/tcT4Q2T0ytoWdZomsoR75KLj4wz4tUAZLhXABD7IS8butdXN4JQjdYJJ0KPBRtGBvojOS1K/v06WGB5bBvNzLN8NT0pU4qJxLBu0Hww7oz2rMj9SOdftbF5Q13Bk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7510.namprd10.prod.outlook.com (2603:10b6:8:166::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 16:59:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 16:59:04 +0000
Date:   Wed, 2 Aug 2023 12:59:00 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        jannh@google.com, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v2 6/6] mm: move vma locking out of vma_prepare
Message-ID: <20230802165900.otlirhbjr54wymvl@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
References: <20230801220733.1987762-1-surenb@google.com>
 <20230801220733.1987762-7-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801220733.1987762-7-surenb@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0430.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 33645c14-fc56-44b5-f2be-08db9379c707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FTLRXWlHzKHrIBCr/s675BFIE6IK268uC395GQtIstSxAqGc2jB1mIq9T62yVK9sBO82IQexDpbPJ3ZuQuqDsW4gevdVIukGqyTupBNze4C/R60ZaiKGhKxXxt/CHUvnD6bRBpu3iYQY1Cn9++yPgN+x/4HGp6+/qdAyxqREJydHvOkZ5AR5VxxZDXew7lVtxzUdgBs/nRb+t1MiNDhNXoUYz0EC/iSgVTii261zfJZ5jdEqyxiW3D033eFYas1hVLzUYTIcwnQAiS3vVAtnsH9G+PWv5uKiQGDkfDXoco2Nqz/9utxhkEXycyGO6mOT8AAoIwmpczQO9acisu2zBYak0KK3N0n7OE8JVwaqDOlZ3ML0xcCS0cWDjFQPNQ2S43UiwwseyacRcJGqZYHd4WDFiqj2woebbGAr9IneJrfZdTEO3fbkHcpglpHBCz1pQKDDq50w9ly97BmSHoEQTucc+FK4PodgidtVWq9MfrAa7rEKRuNqa8all0RS+lJrfxH51BI1BOBzFvhntrwmTU1Gvk3xa+StKHNhydfEknqQX/zy7PZay+0e7m+0JF5A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(83380400001)(478600001)(38100700002)(6512007)(6486002)(66946007)(86362001)(66556008)(66476007)(4326008)(6916009)(316002)(33716001)(1076003)(9686003)(6666004)(26005)(186003)(6506007)(8936002)(8676002)(7416002)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FiGiI1QsyVaLfsiurSVo6ZhbAnAg8aqwAl6CecuV/FuuUUd51zy4XIC281Sf?=
 =?us-ascii?Q?z04qSDoIUxTMFe7fvB3IaYL5Q5fkla4EqBBlHFXjrPx31axIi3Xuzlh70scU?=
 =?us-ascii?Q?WUiNc2Io2bykNW1L0onNkhJvEK6LINxKEsKv9PRCuSu44fhVgp/D4C1GT88O?=
 =?us-ascii?Q?WRiUE2zh0gmbbMAhdPid2svoDcVhV5wy4UG0IbzSsAuoEQ90FBryn2ukwqOV?=
 =?us-ascii?Q?WwaVEOtAc4R2UCvV4AebNwFX9U3Bz3mwjJ0veJ51QjO8nYKIhg5PvOGqDnVQ?=
 =?us-ascii?Q?gmoxPZDrWU+Sw19C2lEjzmp2Ego7C8+VWB5WtySlqe1/d64AT3Z2GYjetYi/?=
 =?us-ascii?Q?8rxL6Ayxt7gsupYnExp6lx8XpEl+4y9QXGiAj03AJOpIs75XNwl3X+luIva6?=
 =?us-ascii?Q?W2mvSO5zQIsiWh1rJrK/FSs6MO4qlDQ2gTB0ullFj6OOIvd0hVXb6JXAMmx9?=
 =?us-ascii?Q?6sboe5dyuY7N/7HZ3fd3BLd0bdWKSmcOZO0JI9Xa25OduwLGirYSMfQOi83/?=
 =?us-ascii?Q?YEfwzjJDslrwUsOGW/7rFWIVuozd0J6EI7B+kEyCvOao0fwVt2I5pGsoMngA?=
 =?us-ascii?Q?2KJiqWY1bRXNBS5sUMxlpR5JseMLPNTkavCaWZxHUPL9QM2WQoAE1Ry8EqPJ?=
 =?us-ascii?Q?DX1Tn645asr06mJG6Y9nwTrrUt+4tvkgDRh5NqxapZlhjf56PeZkiskXeSi3?=
 =?us-ascii?Q?EPYypbdD0sjhd7FsP1ek+HybaEV0okqQB5qZjlvtQnbS922WcpmZnnVhTGLh?=
 =?us-ascii?Q?UnkqiNO7/XXoA16dgeOT7xq2DQEaxd41QkIQ2yP6VxI2uwIywqJwThw584Ee?=
 =?us-ascii?Q?ZMV4oS3GKdDovPY63p78Irr54C8proI52yaisZbSxNLNTX3FfThzMSPjfORh?=
 =?us-ascii?Q?TOh483WO4z9ZUyNgXJ8wR421V7ye6corSIOo8F36VtEb2gHW5hz/HYLNuNUf?=
 =?us-ascii?Q?5yrwPARfexHPODn0C3hSkxIRFAfhXuSKQfw6TT6woG+awzYIinsl3VLRWXAz?=
 =?us-ascii?Q?Zd3J4JMnhJ6SFVsK7GojgdmbH1vFXrXYyF6VEU48piT4YKitmiiFc/vba4am?=
 =?us-ascii?Q?s0o+Uleyvw8HaDD++JRJeaTxBt1cURBAMOlpVbFfx7vpwfEbZ8g5ZvcWK1Rf?=
 =?us-ascii?Q?zgb73fWlnAHGZJt1d13bGHD5KZCHos0j97RppX++MGpanJXA2Kvo3z+J8LEd?=
 =?us-ascii?Q?V0dQTGaqkPM6/m2Yu/kVAPuigX3YjKulz8w7CQj1sqVeZBMkoAOqdIZNRSYy?=
 =?us-ascii?Q?Zc8wJK2/zfqe/O8dxjvWkyWxl/kauyDUzx8bo+aPGDqQkRZiy4lM685s62I9?=
 =?us-ascii?Q?oTUSvF4fkjIG93QdnR9HaFKrhh0Zmd8hYJ8wwIdngeYAiMlVzfMAxJpW51Nv?=
 =?us-ascii?Q?oBxGaZ16i2BW4VLa1GDy88Li5PsaC33MGcpI9eyu1zS8p9riZ3tL+dtcrTNy?=
 =?us-ascii?Q?nDbhisErJ7zOh+0gMbHGorui/8l/f8SDR+4j+x40EtfPc/Edg3FymJJBNefU?=
 =?us-ascii?Q?AJ6r6j9l1VsMB+XSZ6eFzJwCaGoG+205J6lm/dwvdBgwPJeS6Dx9yYjUJ4n3?=
 =?us-ascii?Q?OThpgc0B2yC+DZpMTfsO6XqUpDEIeQG17DoiOsl12a+zLGaBR/jxLHNyCsbv?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0I6lm6vBUf3LX4rI+5+N08eBhkSPXTFC9rvxsvPLeDtCGD4PWcahL4juWKt1?=
 =?us-ascii?Q?c9Jb939iNK0Cec3VpC3sGXL6QL0PoBubeUEAXnmAmX+P+u6vEQRI38R0bZ2r?=
 =?us-ascii?Q?QhhfGWT05EYIjB7pEVaREaxPnWovviXNK4VZ7a9iXrnkbXMrRMjjNwDGUNC6?=
 =?us-ascii?Q?l2bO+ovMUv8QtOygDQZIi0AGudv9d6hc1sWT047w6BAJn8vdHreHWK7tibbD?=
 =?us-ascii?Q?nghPqopVi2ArCn7RWOQRzGQHyrgQG1oLilnaEry8a4q2M2jIQ3ympmxjMRU7?=
 =?us-ascii?Q?grNa0+x2Y1GYP65qGKmH4jY642E/mizfD8YXlvHMhJ0NJCqy6gvW2tOO/z6q?=
 =?us-ascii?Q?+TC3phgB9lPhQ3gbKibB+zU1PxH/d6SfPk/6EueritNG5xGcfqT7oAe+kbec?=
 =?us-ascii?Q?MhbxuWwsSTU+9LdsMpCaB7RDlRcG+32Nqy6ni2UT2CQixQp9/ELpeicwx+78?=
 =?us-ascii?Q?hrn4stQvc10wcLYhYI7i4GnzYdrdEELIRuWSButpYtN5p8iIH+ZBOBZBrlqP?=
 =?us-ascii?Q?W5Y+gCMIgMbbp+fxMv7at+/bwfUK+nrm3r0JudJudmozTFIC+alKM1sELX2Q?=
 =?us-ascii?Q?C5Ni5i8X5V0IVUAXmxG6FiWxY4C8DRAnNld1ojYkBukMOuyjUJwM3xfTS99W?=
 =?us-ascii?Q?YwSauINneusHTRYqdu4/OHKxIW2JaRHpf7fcEXZ+FTA6pFqXBfpmQ/XTV8Pw?=
 =?us-ascii?Q?t4I5vmjNU44BdIGuidf/e8XHEUrLEwlJF6VoB7fsrReKEElrcoi7zU+NUQOP?=
 =?us-ascii?Q?LMqpzurccff3buHTxRBDcmIuF3kjmf9XJyaJujQzo1RKgLp4vq9LUaPjtA8a?=
 =?us-ascii?Q?FQXrwlDDoDUxo2KhOkuaPMLYlE6PM1ugLgDrwsszTTWqmxnSf1GE7HX6Q5Sn?=
 =?us-ascii?Q?r2k/v4mPudMfiIJCGwNAbE1xMrdax+/C1CvT/4K4IHAZq3Fiu8zr3MVANKMk?=
 =?us-ascii?Q?CkfBpFWcXr33GFk1VzYrdPRJSYAS0Atc5n0phcuq6cnNNhl5k6ruBqjI+7Ak?=
 =?us-ascii?Q?aq9e73pNd8W6b7N7TqSz+K4KsRzBwv/Ej1n3KgpivASRo/7X0eQQFBL5NDtA?=
 =?us-ascii?Q?ne9CDghx6Pva/yVeMxU6sdw5qvdKtRVt2DUtR68/ldoeNXDacsbfvZfufUd8?=
 =?us-ascii?Q?PxiwdliJaKODA+8g2UJxKUuHiiLJ6m6vnsyDCyssujNjUB7SGLnDKzk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33645c14-fc56-44b5-f2be-08db9379c707
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 16:59:04.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4j7i1j9E0bZgqiQqN6ZITLrcHjj1jAW4Zc0Ps+q1vNTOtVnS6Rzbshf4co+Mt70NnNLMTj3VQ2ElvGIj0fSYig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_13,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=589 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020150
X-Proofpoint-ORIG-GUID: LDN4aSkiZ7CoX3n0R3CmtpD6gF2ltWC0
X-Proofpoint-GUID: LDN4aSkiZ7CoX3n0R3CmtpD6gF2ltWC0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [230801 18:07]:
> vma_prepare() is currently the central place where vmas are being locked
> before vma_complete() applies changes to them. While this is convenient,
> it also obscures vma locking and makes it hard to follow the locking rules.
> Move vma locking out of vma_prepare() and take vma locks explicitly at the
> locations where vmas are being modified.
> 
> Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 850a39dee075..e59d83cb1d7a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -476,16 +476,6 @@ static inline void init_vma_prep(struct vma_prepare *vp,
>   */
>  static inline void vma_prepare(struct vma_prepare *vp)
>  {
> -	vma_start_write(vp->vma);
> -	if (vp->adj_next)
> -		vma_start_write(vp->adj_next);
> -	if (vp->insert)
> -		vma_start_write(vp->insert);
> -	if (vp->remove)
> -		vma_start_write(vp->remove);
> -	if (vp->remove2)
> -		vma_start_write(vp->remove2);
> -
>  	if (vp->file) {
>  		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
>  
> @@ -650,6 +640,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	bool remove_next = false;
>  	struct vma_prepare vp;
>  
> +	vma_start_write(vma);

This lock made me think about the lock in dup_anon_vma().. the only
reason we need to dup the anon vma is because the VMA _will_ be
modified..  So if we are to remove next the dup_anon_vma() call may lock
vma again.  This happens multiple times through this patch set.

If we lock both dst and src VMAs before calling dup_anon_vma, then I
think it will become more clear in the code below which VMAs are locked.
We could remove the lock in the dup_anon_vma() (and replace with an
assert?), and drop the vma locking of "vma".

I think this would address the confusion of the locking below that I
experienced and avoid calling the vma_start_write() multiple times for
the same vma.  I mean, having the vma_start_write(vma) obscures which
VMA is locked as well.


>  	if (next && (vma != next) && (end == next->vm_end)) {
>  		int ret;
>  
> @@ -657,6 +648,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		ret = dup_anon_vma(vma, next);
>  		if (ret)
>  			return ret;
> +		vma_start_write(next);
>  	}
>  
>  	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
> @@ -708,6 +700,8 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (vma_iter_prealloc(vmi))
>  		return -ENOMEM;
>  
> +	vma_start_write(vma);
> +
>  	init_vma_prep(&vp, vma);
>  	vma_prepare(&vp);
>  	vma_adjust_trans_huge(vma, start, end, 0);
> @@ -946,10 +940,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	/* Can we merge both the predecessor and the successor? */
>  	if (merge_prev && merge_next &&
>  	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
> +		vma_start_write(next);
>  		remove = next;				/* case 1 */
>  		vma_end = next->vm_end;
>  		err = dup_anon_vma(prev, next);
>  		if (curr) {				/* case 6 */
> +			vma_start_write(curr);
>  			remove = curr;
>  			remove2 = next;
>  			if (!next->anon_vma)
> @@ -958,6 +954,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	} else if (merge_prev) {			/* case 2 */
>  		if (curr) {
>  			err = dup_anon_vma(prev, curr);
> +			vma_start_write(curr);
>  			if (end == curr->vm_end) {	/* case 7 */
>  				remove = curr;
>  			} else {			/* case 5 */
> @@ -969,6 +966,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		res = next;
>  		if (prev && addr < prev->vm_end) {	/* case 4 */
>  			vma_end = addr;
> +			vma_start_write(next);
>  			adjust = next;
>  			adj_start = -(prev->vm_end - addr);
>  			err = dup_anon_vma(next, prev);
> @@ -983,6 +981,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_pgoff = next->vm_pgoff - pglen;
>  			if (curr) {			/* case 8 */
>  				vma_pgoff = curr->vm_pgoff;
> +				vma_start_write(curr);
>  				remove = curr;
>  				err = dup_anon_vma(next, curr);
>  			}
> @@ -996,6 +995,8 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (vma_iter_prealloc(vmi))
>  		return NULL;
>  
> +	vma_start_write(vma);
> +
>  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
>  	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
>  		   vp.anon_vma != adjust->anon_vma);
> @@ -2373,6 +2374,9 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (new->vm_ops && new->vm_ops->open)
>  		new->vm_ops->open(new);
>  
> +	vma_start_write(vma);
> +	vma_start_write(new);
> +
>  	init_vma_prep(&vp, vma);
>  	vp.insert = new;
>  	vma_prepare(&vp);
> @@ -3078,6 +3082,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		if (vma_iter_prealloc(vmi))
>  			goto unacct_fail;
>  
> +		vma_start_write(vma);
> +
>  		init_vma_prep(&vp, vma);
>  		vma_prepare(&vp);
>  		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> -- 
> 2.41.0.585.gd2178a4bd4-goog
> 
