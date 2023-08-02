Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5862576D4B1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjHBRHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHBRHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:07:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A111A5;
        Wed,  2 Aug 2023 10:07:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372FYATd030137;
        Wed, 2 Aug 2023 17:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=At/sKCrKkjsje5C4aKZrCdvi5koa/tVrReAydnbnuVk=;
 b=0HPgoBL8OoCZTc5o4kRWD7vy9r0m7phmB9FXLQ8yQ8ACxCJuSpT5I2q+5zel4XRP0sYt
 zbADUIh6fTXjvK5LIqWsYR1G3Vr9VqElvVaq04JwVTBknzQD2Z+axDMqIEVk6HbypxjJ
 3+QoXVBzllt30HmiDhWAZULVxmM3RJ5Haz74QU6pa7NgrHVOt1jfs7WnMWlHuSCmzwjm
 yIUEFmh9v4WCfpsKMjELZ3HcXwCxHJY5pyINzdLF+luLAOgOFyChCJRIbeheKyvqFwoH
 LyJnh5E8OrRCaqGA+qmg3qXCk1dQWR+sZlX147Xo3XjSPLLfzf5pkn6JNW6bVCIUHx8X 8g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e7s6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 17:07:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372GdxpW006902;
        Wed, 2 Aug 2023 17:07:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s787w86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 17:07:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ4rqER84YwKawjD7+I/ZZ0GaUH39v8kq1+73LmvY0jID7Z3fAlmA7lbdFEzTbpUDOtqkO1IvjXyPCkT4WMp9QLwo3HaGmrKfZ+9afuAorRmxK6Rrb5rKB/ueZMPTo4dT213BeZpZeoHguDtBqIfRfNtMXpzN769ggrniPpoOlp075Dd4p/OIviWxZ2reWf/m6DV6LEWi0tKovEtCXgJ/b8qodQhu7c8MVXZzrtfNe0l7DtZOkK5VPYFUuS2GtICC88BiqinXm5AFW+jxCtBAZPafdclQGF7FfKr2RbfyeMjnukN5oEk8LOE6LoGZuILibTi8pzMIGpmH8dPE/6xSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=At/sKCrKkjsje5C4aKZrCdvi5koa/tVrReAydnbnuVk=;
 b=ID0K5BAk4ynFwb5YiAyJc+70lYpqwUPfg93/v6GbDgs5qD180YcWOlqV1YGmasxKSNjswwZ8cBlD3/eBQAZlkxIQpgVF7H4WGcMQj7ynDoZDdTYK1X4PK0GB2EaCTVfHljUobI10PObqFxD4yQTMneB8gtKFgMmRHP2tmg1UyoIY9jraPKk7D4PEErI/kzjBgrrZQfovUCJ3261CjDrKVoFM31JdI5SQ6z8ffPMM2aSA5ARHuZeDAnocklEIgvYvyZCFpmAnUAa1PhUks/TPlQ9/Dn5w09ztTn7E07Zq/CmjBVSPP6YQs1nraK2oq4FnR10ALWNJIN6R5aTyG65xtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At/sKCrKkjsje5C4aKZrCdvi5koa/tVrReAydnbnuVk=;
 b=kDhO1759CN1P/My4NtIaly4lN0ugS9Xg+qZeDRvZoSX6WlAKS0AgeNN5jw1+saq87reiehiaQuSzEq/pGfKIPes2W3I1qi1OR8OkwJW1DBGbaTuqqt2Ho5kJF43Pp6w3shf+1EzlXXOV3Pmb8rDjPte9o8/ojK/m1cA+O4I7pMc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB7101.namprd10.prod.outlook.com (2603:10b6:806:34a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 17:07:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 17:07:06 +0000
Date:   Wed, 2 Aug 2023 13:07:02 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        jannh@google.com, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock
 assertion for vma and mmap
Message-ID: <20230802170702.cj6vwixrksqsdqp6@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
References: <20230801220733.1987762-1-surenb@google.com>
 <20230801220733.1987762-3-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801220733.1987762-3-surenb@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: a34e43f9-967e-4cc4-24c6-08db937ae634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/oOXaxM67mE+xmm40rJ8fyTcjaQVN6SOD0Fi3PWou/BZIi2rZ6l+XTfTNTmf+NHEQiBypJ0TVpuHe+LxLI4eaUorMBjO+l4GqmIqh5SnZtUozxouanjC097Gl20Cir25J9DPAfSUHD1re5IKuQJ7w74WzcmFRzOibU1mvfGNik5d1F8GbwymeJXJYJkH+pCHTl2IYT5vCSFvDpHGv6Qeb1ly2WpeAN/kf2N45L5+Z7DH9RjNnN2tExiF+FuqDQQS3emsTb/nHhy5fzSumEWTqwkdS5Nmcdjnw6tUcTOsMVnhB8OPVH4VFa1zhoKKY1bfxqD4WrwDqMCb7v4iDPR7isDwgpMp9r8PmOhJFyXzVSLZKfJWaDLojcKXMeXGjFlziWD9GQopcRI8q6JvBMtR3tjtNCiWicifpg/UGpJupUU86QaamYMB/dhMDYIKGOoumGzdslwn3bum8w+v69Uh1VE8Wd66FstTy+VTieFsZ9IddQlbT2q6u7P14Fw7OZwQKQS6ec0pcPDWt87RRHc+0us0+3csAyNYmMocIfIMD23+sW8ZeLEg1j0+MfqgMv2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(86362001)(66946007)(66476007)(66556008)(6486002)(6666004)(6916009)(6512007)(9686003)(2906002)(4326008)(478600001)(83380400001)(33716001)(38100700002)(41300700001)(7416002)(5660300002)(8676002)(8936002)(26005)(1076003)(6506007)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OGP6zOnoUnBc6ix7WkxcTMO2+AiswfKkk7RB4o0vpXvTkPMvX11FEAwlUUc/?=
 =?us-ascii?Q?loS1lCdG3/JEHHDF3Fe/43nKcYi5I91R4Wf7sqRvCSvUxKxNypoCdcR5I2u2?=
 =?us-ascii?Q?+/xgsapL5/nPfVcNJzrw6QfWAlpZhAWyapONFHpPcYz6CeHOcZgy/61QlGWG?=
 =?us-ascii?Q?I7icb0s1c08uUMC/3prsmhs6DNO4/U4RFJ3qEeXrT+nC9hsN7FpxqtaH6/Wh?=
 =?us-ascii?Q?gDX2TMglyUd0CCv3ZsCmNOEKdZ9ONchMAENBi3T4wLG2cjjQsFrTPjJnrJoh?=
 =?us-ascii?Q?QJNxp9KWlBk8X4OZp5o51tXjWCKCzNpjGfLoqE50/uowX/53Qi7e4VRfoNhC?=
 =?us-ascii?Q?+CfB5+uoFCm5aMWYXdidse4QFqYyibFeDYHJYm/6VJplmOv1HfLn1O5zUIDU?=
 =?us-ascii?Q?rcTHX0sovi+XzV3G1wyopoEo3xGoUViqW2e3UNzO+cuBfTGLH0HFg46mDH8I?=
 =?us-ascii?Q?YsQFzqhYxaxajuCOro8ciqcms4Te0nq3FMlyaqJkXF9IZ2nF/P0pGJzG0T2X?=
 =?us-ascii?Q?eixQA8/Hs8s7aN1/EyL2k3zAlj4er0z4FJn5H9pfcmdj+ZvWWJTK35zLMhYx?=
 =?us-ascii?Q?G+G9Fba2pLZpXaeEJOwvs6e96t0OVdQntQCiaxgIIK1KwCJRNz7GsTp/OJER?=
 =?us-ascii?Q?PR/S42YCDjvq5zL1SZBMU4e2IMVsyogXiYWJw/upuqb0EV5qUvXPkcGiK+Km?=
 =?us-ascii?Q?4wiJibOsH+yOf7uaAYnG2QfbN8Nfs44+D6YwbHKm+lzo75BywO4H1I85tqoe?=
 =?us-ascii?Q?4rofPrhPSXq3TvNPbVUVQZqLC0NA6jkAVVV4wvVTCsxwECBbp3eoIfQU0fMd?=
 =?us-ascii?Q?Jm+OYtd1ts5CN5CqoTr8Dh27mrzecGlyJlGFEQh3qrnUJX2gVT4qa6zfTuGt?=
 =?us-ascii?Q?2LqNCmCpaJhZE3fpoWcUrmfXBpPY3ekyKsTGWWosV5P9fY2kJZcwI9mRWZ4n?=
 =?us-ascii?Q?uWIv446F0gyOmheG7m9qGW4ljZUdW9H0F//hA+Pqbfs1MZvsf1H4M6FEZzWT?=
 =?us-ascii?Q?7xiYEMbQ5622arSfaFbcxG2N95mgP1rjeFUgkfX9WCzK3Rpv0iiJdp4hIhLv?=
 =?us-ascii?Q?nj2pb3EQ948P8qUWWSdhUMWpmo/PU8ji1F/hT3TJiUWVMHuZz2KBSBft6P/g?=
 =?us-ascii?Q?qTny2gnFihdT2Ti/JeqEosTkFbJt/8CzEBmePlQ8OUgh2Bns7ZF8+n4lN9KB?=
 =?us-ascii?Q?5vg60512GmtA0WTVLfOKRt5uyzlB3ct7M/FK4VK4kckr4PjlTLHsIx1GV7aT?=
 =?us-ascii?Q?7EgdM4DBoriLBnjcVjc3DgGoXt1dABNsHF21G+kvPOCFW4wMKakoVBkoEqSo?=
 =?us-ascii?Q?uBfUkrGX2vELzzek4f6pS7TIe0PnbvNCXqcmp5qy9I9XNbCAFSKWiT0mmSjE?=
 =?us-ascii?Q?hGksepexoabPGV6E/C1IsxNi86sGNhPxHazGecmmsc/aZqr+Alze4/PbbxB5?=
 =?us-ascii?Q?goKEnbYVL+/8ZH+qCnVUbCmP+jbJuDpMlafOAI+3nvhW6r97AkmtihBX1yEl?=
 =?us-ascii?Q?1P/IueCEAkHNRctoRb+oytHvtpbJVzMNpy1gXYoPk41A4jkTLrkn2HKE/Onc?=
 =?us-ascii?Q?2YSlRaMn3CxGv5HaBWbQVLciebu+3C8rHwW72VwGiqgTrUJuNhPmoP9WEa+y?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8KVUu5Qa4XcoSmzZneGlLdQcYX9jSHZXIhJQr/RK6AomJpRERt8AwzAyrB6/?=
 =?us-ascii?Q?sSvVzkYsYW0wn7MjZeKTMPP1SbUKeF7jpXhafLSrL2A1v4RPSCF9D5ToWwPP?=
 =?us-ascii?Q?aO0kuJmfyz+yZAYWMs5J2CLEDDO9HKjG73eox7enD5sdSZUfcH+LL9oPdiHF?=
 =?us-ascii?Q?KcX8xXF/+nqM63Sgn46BuV+664gE09Q2cadQjcma9GNHNwyP8REUSRlmnYgL?=
 =?us-ascii?Q?+8MIbyXKF12uGpgB3ifhSq4J/FlKe6anqdKhl4IyDP1eo6bPRMF74nU/iM0f?=
 =?us-ascii?Q?zszG6mbmqfVVYBPMMNObaoqY5GQFfeB5HYtmN65HLIF2lNKU2EfEvuVKBeYo?=
 =?us-ascii?Q?rOPA3q43xL5kCi2dCyV6CFwtYSUxzxf2Qa7Np5F6fJ5mFSY9GG5SaZl4agrc?=
 =?us-ascii?Q?LQZpLQWieWTNVL35k8YriU8MDKHDCsrp+gb5frc7hIoWZeODODeiPDONtKvR?=
 =?us-ascii?Q?KNB1m3xDbbxkbGGbzDxYBW8ZGY8mwNRda8aciziC8HddUYwmpFhcmOsYkhNP?=
 =?us-ascii?Q?EcRkJ3gUAIuJ9x8/qhc9QtO1P/yP82/08JDCJZGh/RU/79uoIwwCfaKO0evv?=
 =?us-ascii?Q?UFba35jslMkzRQAijBz697oUSInrPgX8LrvP+/JkdaZgnjKL6YC+PxjJ01hS?=
 =?us-ascii?Q?KZ0y/acPhxwyLJa3RkM7LuzFWqu5vTkSMSQ0p+Bo6g9de0c0lG7t8uuSWt5D?=
 =?us-ascii?Q?vVvxhb9KClA4e7BY6NafCkr/IHhWlmMeMFoTuNgybMMy1gIxV5yl7c1Wib6e?=
 =?us-ascii?Q?2MSnGEES7rHSOYq5sFdWlgCRLANxtr1FoBW32gyXSzmy/1cQe61X4grg0/lN?=
 =?us-ascii?Q?Whgf3v/YHsrd6ALeLZ8uqchbAleOBPtgeAz6sx7ME8VrFK5zjT2UbDMsCorQ?=
 =?us-ascii?Q?Zm4lfdaD9IzBha+e+cFyTvYb+Cq5T61REYcuMvZIK/mkJ3lIw+oatpj2qFXA?=
 =?us-ascii?Q?sz4XNREFRnrsYkn+AUY0ecf/q8xLlgHjV/zcN3CdYUtxZmHuRX1nMMjB1Yox?=
 =?us-ascii?Q?+JFf6WaG72r/PGXXcX9xszS5blohs+b/HGsgMdidB3xQUrUp6Dpr5gdrBIbu?=
 =?us-ascii?Q?SCNlESzfoNn9JmOTw6CyvZ2YGtCT6C3KQ1rYs6rY9JH7+UxBiJOQVPa2TT0D?=
 =?us-ascii?Q?KpVLXGw4KwPc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34e43f9-967e-4cc4-24c6-08db937ae634
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:07:06.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTqA5Oag0UwBRUuPG1sHZsHwEVJoT1hZRyhDTEwUVl61ag9Eeuq/pNrJ29Ag7VNVJY2wn8ucrSnIj9zIPU7QMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_13,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020151
X-Proofpoint-GUID: 1BCQ5YoW6EUAMizRXrR7uyH67SMkfvgI
X-Proofpoint-ORIG-GUID: 1BCQ5YoW6EUAMizRXrR7uyH67SMkfvgI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [230801 18:07]:
> When CONFIG_PER_VMA_LOCK=n, vma_assert_write_locked() should be equivalent
> to mmap_assert_write_locked().
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 406ab9ea818f..262b5f44101d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -750,7 +750,8 @@ static inline void vma_end_read(struct vm_area_struct *vma) {}
>  static inline void vma_start_write(struct vm_area_struct *vma) {}
>  static inline bool vma_try_start_write(struct vm_area_struct *vma)
>  		{ return true; }
> -static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
> +static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> +		{ mmap_assert_write_locked(vma->vm_mm); }
>  static inline void vma_mark_detached(struct vm_area_struct *vma,
>  				     bool detached) {}
>  
> -- 
> 2.41.0.585.gd2178a4bd4-goog
> 
