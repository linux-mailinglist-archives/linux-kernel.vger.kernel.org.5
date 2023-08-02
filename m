Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3C76D4D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjHBRNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjHBRNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:13:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F356E0;
        Wed,  2 Aug 2023 10:13:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372FY9QF026990;
        Wed, 2 Aug 2023 17:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=syDBB2SiYw2tGLlN3ILdrY+mAyUiYyYlF4BLOQl3zqo=;
 b=Dpk8vrMdRRRLpBFq9CzwtepGMi8GmjAI0zebRnmqHTDxY3TnNFZBewy8n8C1pA59PBqI
 mS2An9eS3LBFLE7FyYTKl2bXu7tB9E606yLPhg2nR/Otb0hm6CJQItutoek8OA04fVj1
 xPZCL3aMGcyX8NZR1gDh64QJg+4psdQYe0OpgAK3r2CCgzJvm1LA8KkGuX03UMuO+TxD
 ALcKx7GX3gQOjO/AdfwNg0070M97QGuprqJWydyD7t0Bstwtk2hT8M060zHNE+Ezq1uy
 yglh0PORBQ2Fg1IkyWsBdJB+7vEor9B2wgDZtKlgK+DSJhooqcFHUFJlFBdCtOsjExoc Cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s79vbsu06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 17:02:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372GnGDb025217;
        Wed, 2 Aug 2023 17:02:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7ereyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 17:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDp1KJEorvgvhUTG+4zL+9XaSjXYemcqU4JYLQ5a9T9XMiPW4F2J2NcLJR4V8osNeOBx174rPAqcWbCcRedcjxxRelsi1yvQpPmrf9cv6jbFsT+/9UIChzPJOVPIdLEjore658AXNlEgQ+eJJ47pXA13CobzOYPvIIUC8LN6CdZTCJNfPcBgvMBfWDDaApSdu58aPE+RsJEGKFdAsW3XLuToquiaCYNlZiHeCrpnuPE0h7cKnb74+VyNGY0CBdupBU54xmQaW0OnUv/7ts9rakpiDeP6TX5VX+6ZUHQUitQoGJQ6oKkASTvJnI74946C53Z883Phy0Y6hTlVld5XfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syDBB2SiYw2tGLlN3ILdrY+mAyUiYyYlF4BLOQl3zqo=;
 b=JJJPXoBTyPzamJB9oaIx8nRWaDeFmg0GxvX4cs1ywNNnDRBhivND4UM5QDNTw2yVCYxjpMrOIw/01KAxII84x3V7huIi4xtmXuvj+gojakQwMJzhaQg7142Hr0SUr4RST4ZVbdyOMuLDTRWVeFr8MU3QFNsCqt2CnQeQtSZBS+aPHqBy3W997SQ6wObHoK7tEbB/ZCprGVEnT+cu78yCch7utLiCMvpEDV5eL4iTiRr09jTMf0vJ2Ri54gzl0+vkMQkkpqjFiuxVj53XYdnbQhxuof2B0eUN5TYJoUwyPI8ZrYmDDPjZKZtJYeeRrt2VcQDPPsSghOYhliJ8J9nhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syDBB2SiYw2tGLlN3ILdrY+mAyUiYyYlF4BLOQl3zqo=;
 b=Oj7DZ+AziTQlx8r4Lhl7sSqA7UFRRinciOeYciw8w7DkdIpLLYIeIdgKrLNPpbTmj9oFeY66W+fTwvW02ONI/XoD6m1puE9ne5bLpXfG59dWJxbF5vhgpcPaUWnCfGgB37GjClSDTDADjBbNR9jwEBxeD0ql8HJxzrzmN/JHNls=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB7346.namprd10.prod.outlook.com (2603:10b6:8:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 17:02:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 17:02:40 +0000
Date:   Wed, 2 Aug 2023 13:02:35 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        jannh@google.com, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mm: always lock new vma before inserting into vma
 tree
Message-ID: <20230802170235.rqofihlvwbisxstr@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
References: <20230801220733.1987762-1-surenb@google.com>
 <20230801220733.1987762-6-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801220733.1987762-6-surenb@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0207.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 687f5bc8-8cc1-469d-2cc5-08db937a47bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hmrdx9UynG1ktRibqLHH00c0eKQilM4mimBRN09WI+kqKg//A7W4X/HMcQqzZpYAp2Jfwc65x5JXGwPCf41FSi1wcB8ts74DoO7P/ab0j+DQIaZLKl8ARoM7SSBgBDMl8Vc2P8x1AmWw2KhjJcw+j0DsnM9KjLV5rABBU9sRG3HE2+jByzehZp/XTSdYEO75V+3gSA3OJdribiTscyzH4/vRIGRJtRFFrDY6lvX2tOO3aOFuGOTyYRafWtqikzbd2bhZDOBDR2nsY9Aujx1OFFkGi9KqN6lc7/lQ/gKTlmvcfPRQoL5DIIJV3ZruN8x1Nb8k9wP/yguEpDYdoyC7AcifcsvUJMnCMt8eYNLcWiZuYSN0D+/dQi/vtY7AsrZ5JGxzg8cLjS+bm0lgAz28ffBAWqyS+FqY0tSV9/4RhtERdzVmwLCuu9zmGEdhlWjZAlKqKVVK6BoycTV8gFSL5HcVSYKNymin23fBhScmMLaJmwF0NBVMQQENZ4VycHC9INJH9Q/SDFprF1G2jmp0B26GYru3N17/4RdGBsB1Dv0cOqDfEEQyTaUhIlBfoptP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(7416002)(8676002)(5660300002)(33716001)(83380400001)(38100700002)(41300700001)(316002)(186003)(8936002)(26005)(1076003)(6506007)(4326008)(86362001)(66946007)(66556008)(66476007)(9686003)(6512007)(2906002)(6486002)(6666004)(6916009)(3716004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EmjLAxw40GaOc9noNFKhkWo+9cCyYogU6WHsuRw95p6HvgCXw26T5ipvYMdj?=
 =?us-ascii?Q?kJXTfzHv1R8fNJ5Ohy1xc0Ap8XDE+i56TeUB9wGuxJFLH6mi5MHLF9U8bWM3?=
 =?us-ascii?Q?lEanCRnblN8F1FTn1+eA70mKsb4fQeLfcq4ZfELG0JpUB+Wx6IHAX+rzaZd8?=
 =?us-ascii?Q?K6Clz2tNJwop9X9pemArDk8Kbt3hk8zLnn6PhLGZNxqKbWUOl1v0qcXZmzN8?=
 =?us-ascii?Q?1+sTiL+I+lPFCEjPFFsjd24Tr9kvpRh+AjQbsMcIwJmlc1Kcembknnme/DDJ?=
 =?us-ascii?Q?2OUKo3weinet9+LjFVQWrO/1Yh7qvtonQ4m8Tz3sVahjjgBicMsPQhhI6PRW?=
 =?us-ascii?Q?3n0PpXi4ATjtmxMrwfazLsPx5A893f2HbZtSWXm6iCkf7YPg/beuNXIN4PiL?=
 =?us-ascii?Q?Bl8jNtSO7zibSy8EoZ0mOfErlM0ljAQsLeWOnZC5f18XlhyvVYZdawunhkLr?=
 =?us-ascii?Q?98Tt1olqhzvCMUwMR/aq9ufULWuRGOtVuG5rwVpfNiuJf4gDm5n0SCwViGvx?=
 =?us-ascii?Q?HWTYHV98xJVX2SFGCIJY1oaiBYWUFLqA8a16glulrU/GVGKxnIo6EMv4HNuP?=
 =?us-ascii?Q?fjyF4PZTNq9cmJOzbglr8s65GiyxqxWnaHQ8zPBcBdJcF8cSsnu0FAWIpDt6?=
 =?us-ascii?Q?wk9KFtdNXv5IygTl6U252gPPjJo1lpcMLay/DVAIGdggdbYPsy3w9SRB8SK5?=
 =?us-ascii?Q?YGgUEQO1lZitQ9+lJStmwpVWPBq0Dx6wD47tm6lzNCH71JSd3WEyy7/XEr9J?=
 =?us-ascii?Q?VSAbKxLdv4sS6qUzw7zKK2GjYguLcbVYdxaxmMBAEDpabwBp5rTQgNdNSkkh?=
 =?us-ascii?Q?ukAkHHPQxe3oFoxkhPQBRZkHDMLnk79qDSGtpb+L+x/VNVxr8ax7EYxFYGxw?=
 =?us-ascii?Q?MfH64xSS1o2yf1gLBgRhtAqX7AHnTQgJE82+wtqtlmvMbPbx85QzK3YzFaxI?=
 =?us-ascii?Q?wYbzaR3FwsZqa4uHZLxb9nUSTy69vD8BZA6zY0CuTt3L9t7Z5Kok68heLOrv?=
 =?us-ascii?Q?pIo1vJFNOq9LHXWhGT6qdFMT0nvKZz0zz/coDACUzXg/MOXQkeemqtyFkl0E?=
 =?us-ascii?Q?iyRNwm4Ceizo4bOhJlPSPXqs479Cjl4CDUvKNRp5Av6rgdl5iyBHRk4OUXg7?=
 =?us-ascii?Q?PZ5C9QExbXlsle3ev4z7Nf9rYLMcT1/YAMHoh8Ko1UZGBAUWULYSxv2pYVZ/?=
 =?us-ascii?Q?DJRWjdf5T3i2j6W128Ckmg3DaLY1pzSq7W1NZO7RCjE7e80AAqdxKeHNAKyS?=
 =?us-ascii?Q?DvZA7wKLLR2eiZ07bqFucSqP8uBGOKD9tPax96+5UPvPiK6BorCN2JhLgT+f?=
 =?us-ascii?Q?xQ09j2KduHqn4qa9UH299DsUoMBCsDSnd9FLt88TZNkzegDzh8/bf8mFOi1S?=
 =?us-ascii?Q?cNG6popaLQ47Ok9NX1tbOQVRypx+/PhvPIUyQTBfpR8xrzn6bVa0j9AZUNi6?=
 =?us-ascii?Q?VrRSPcfJcwE79QlMygOSl6HRrk1Jq7o81aEbT+C/TT8eX5YC0P7wp94MWPN/?=
 =?us-ascii?Q?+AjBvRXkOpNt5eXQvnyKNu3s5FdZAj2GjEOmNN0TYbC8GGipypK+/8M39Ues?=
 =?us-ascii?Q?ebUKjPorB1w/PJOPWQxDcEZCCf7C+N/3sjkUJBzHuVeJfSW1kryyjLTcO4ph?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1vWHcNz33dQxwLZet5b1FYJEvisGHZ9KAZzfPSjaeHqz7hgQee2ktiYM5v9+?=
 =?us-ascii?Q?fXU/r/Y93lsvHtT2koOBbKPCBoZt/tVqSDqTbc2owr+raiBw0p6W+fPvye/9?=
 =?us-ascii?Q?yoaApY4JSDEY89NfyLFWPr+VKrKI2cB2VA/LOfRTEDkljzrguZ/Cb9PL2yih?=
 =?us-ascii?Q?SHnqKOKLeSUFzWnjBQa/pF8zj0zYXPqYKK3UerrkfBCMQgI9UtUp5fvnIsj3?=
 =?us-ascii?Q?CuXKPu6C0vfymE7xa3qpc4uIy84DJ8ZqN4xCnSZUpd+n/Tie7SLSaMLTUcUC?=
 =?us-ascii?Q?XASuGegRU+fS+HngDbeguC39K9lIgv8VKHApRMXZARZK+1Rc4GEYZyuqEcmX?=
 =?us-ascii?Q?NCA+fLSP/cpmALgbt4gT/f/tai5kE0wE6sOLaRcnZtmW13Yb2egcUk9Me1ln?=
 =?us-ascii?Q?CtPRinYikxbZ9LSPPN3kOT04pHr9j5BlvEqnc3O0xpFL2LVT6bk6XGfIfrzN?=
 =?us-ascii?Q?uNY+CrVdpygkvj2LKi3JV3+u6QNmdCyN4J5pbN5xZy9mebQQsj6CdH7cITx2?=
 =?us-ascii?Q?+q2NJeviCaVanacwgY4JLCylD/Tak/9SIv5OMnk10thAF2kd9eTFVXWXcP0t?=
 =?us-ascii?Q?fhskR6fOGrhR946qw7q+i+ta0xHYfyBQiDfWhhkaiyaF3Yl+Lci5BpVR1Fwo?=
 =?us-ascii?Q?lCFPxPpnbBNsCkdmX72LXtgpDGUkucVryoxSTpiiO52FLQbM1k99DJj2Ueb9?=
 =?us-ascii?Q?0MlArhDims5lMirOwe10syd4q3mCYGN3iqh0V08o1UBkSV1VTS2wl0TB+YPz?=
 =?us-ascii?Q?inhosys0eJyoUPCpQ6/gvhmC2Z3Y9ytpUFyZBFYN9T/hwiYqvld+AZDpqi5a?=
 =?us-ascii?Q?YPnTQL5Ep49qZd/RBRV4QX4R0EpdQW452H/DoHkMTQuaM+xCJtisHpo85mNn?=
 =?us-ascii?Q?pGM7ikYqjOPSpBEwdB9IfWis2DTwDdlOey/0UGkiFUA2Z+QebfFjoobxkibC?=
 =?us-ascii?Q?ijQf57u2gkPxG0Vb3CpMOMsrwhgVyyxBpnCOekV2IGQGvsJiKsCluEA59utI?=
 =?us-ascii?Q?I1CoG/RWKjLDFcAVZEs7kk4vnSdkMX8L+CkYZHGA/bfQzhCIPMTh+aREvIXG?=
 =?us-ascii?Q?jbpnLzPNnQKwd4uUTbaiAB4IgCwl2TvMoAbrmKNP08Qf6SKI2DSzxGa1ECW0?=
 =?us-ascii?Q?C+8HyO1cXx2N?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687f5bc8-8cc1-469d-2cc5-08db937a47bb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:02:40.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbHp8xjlVJoBp0BX45E+WHRoIRyw+YzgL9j0YadjQj1J+x70/na8MVKK4rr720thB8ZgNtWulfSFGAuhp8l8aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_13,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=797 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020150
X-Proofpoint-GUID: jzWBtQXQnDwBeu_Uu3lufW4aYi9xBmoE
X-Proofpoint-ORIG-GUID: jzWBtQXQnDwBeu_Uu3lufW4aYi9xBmoE
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
> While it's not strictly necessary to lock a newly created vma before
> adding it into the vma tree (as long as no further changes are performed
> to it), it seems like a good policy to lock it and prevent accidental
> changes after it becomes visible to the page faults. Lock the vma before
> adding it into the vma tree.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3937479d0e07..850a39dee075 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -412,6 +412,8 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
>  	if (vma_iter_prealloc(&vmi))
>  		return -ENOMEM;
>  
> +	vma_start_write(vma);
> +
>  	if (vma->vm_file) {
>  		mapping = vma->vm_file->f_mapping;
>  		i_mmap_lock_write(mapping);
> @@ -477,7 +479,8 @@ static inline void vma_prepare(struct vma_prepare *vp)
>  	vma_start_write(vp->vma);
>  	if (vp->adj_next)
>  		vma_start_write(vp->adj_next);
> -	/* vp->insert is always a newly created VMA, no need for locking */
> +	if (vp->insert)
> +		vma_start_write(vp->insert);
>  	if (vp->remove)
>  		vma_start_write(vp->remove);
>  	if (vp->remove2)
> @@ -3098,6 +3101,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	vma->vm_pgoff = addr >> PAGE_SHIFT;
>  	vm_flags_init(vma, flags);
>  	vma->vm_page_prot = vm_get_page_prot(flags);
> +	vma_start_write(vma);
>  	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
>  		goto mas_store_fail;
>  
> @@ -3345,7 +3349,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  			get_file(new_vma->vm_file);
>  		if (new_vma->vm_ops && new_vma->vm_ops->open)
>  			new_vma->vm_ops->open(new_vma);
> -		vma_start_write(new_vma);
>  		if (vma_link(mm, new_vma))
>  			goto out_vma_link;
>  		*need_rmap_locks = false;
> -- 
> 2.41.0.585.gd2178a4bd4-goog
> 
