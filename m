Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137977B4B0E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 06:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjJBEkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 00:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJBEkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 00:40:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E88B4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 21:40:25 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3924NmXl011582;
        Mon, 2 Oct 2023 04:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=my6MAzNvSP4tBm5qDOp7zP3vStGazXA48SAkzShIBlo=;
 b=ypw6JmIHyoooUEPTNr+kuphV/PPQuGgAF42LXyMBaAJghbHyODmGxLEyAA2fBqC4xmNK
 AoClRnOHOLOX/XBvLl/R6rebEjOBnge36CbkVol3Q8dzxzZeD56n8zaTmuNF0hyqH7QO
 GMZ9jEcqpzvB7geY6UfKbVo2dY8o6hNtjf0HxhGmgnazxkxlh+DRvrhlhzkVkg6iZLXJ
 vjFLTLfkhgV+pHQqoT03bYwqqFQ8vDWf5UQywct1lbEWWyZcav9xkFNAEj2jsBTP1u+X
 72mAiwSolG4vGONnGYo5zPhRYMdy7PVKRRoUemIFA8tjH2KZb1VJITPY3XPZtFB3vqA2 yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqdsrcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 04:40:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39211whF033323;
        Mon, 2 Oct 2023 04:40:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4ajq7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 04:40:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKJP2bd3EDhMB0rkaECf7DaJQMBx+F6wMpZd3nYF4W0aPSmcthRqdCQColoCp1ees0rSochVeIx8wzBNN44VCA6m1RJDZsQVXNkUDvl1VJQNU+DoypB4U2ayco45Yvc42WgA3bkQwekVLvhSFlqjq52DUtJFONKREFLr+MRkRb6un0jG6ZWtiT1IQqlmjcOhCcd3G/Bs9KaY/b0BlUHkXkuf7LUV3ULwRSGenh/Quzr+08kow1U2qSC8NKA6VmmDaU/OWqnHNoPLSJQ+QRxYA+OGoGacY26nsL2B5KagJowp8/gBbMcLCG0AyPkt5+Ez+MbW8zy0KA7tB0QOi2w1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=my6MAzNvSP4tBm5qDOp7zP3vStGazXA48SAkzShIBlo=;
 b=QGlpvb2SlZaZs8ZJB/bdGK86rPp5v3XCbdjZQqIDge5wtr7FzX5OqliMdSW/SLFdmzU+mMYril0DaJE8Gciv/Wj7/5+gMA93ElQY4/7LaxW5XLlhZwgbec20yiUHTpTVAbRmk1Aq3bs1kWpV260QU41NUXCFirIYnEGRNiPhWxekhrxZ5wNGH80x3vgX6Qu6nC9EVo5DCzBo1UG3zVxxfHK24vxSKc6MwzxunLnkJ+4fNZm5fuaQur6ApmJHfqhWQspDSM40A0rqMx1zAQN2XQk92YhPrqIydj+F/HS41KZadckNBisdMKu30ypEdencQCPmDdd+Q6CJPAqBwO+p1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my6MAzNvSP4tBm5qDOp7zP3vStGazXA48SAkzShIBlo=;
 b=TQ437qserKiZtiSIPAe5vyoaePF34LqqT+cRUmSra+luydDmy8S+JsX0Rhl1ww4WHEEum6yDW2aNIOzkHN/zmQoqH2TXSBW2QfwyCjUR0CUIblSrlG1gx1HshuiGw+isR7lL32NTnJUZtIixHBnsEXxQmh19YGptccb4+JLS/yA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 04:40:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf%6]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 04:40:02 +0000
Date:   Sun, 1 Oct 2023 21:39:58 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Subject: Re: [PATCH 2/3] hugetlbfs: close race between MADV_DONTNEED and page
 fault
Message-ID: <20231002043958.GB11194@monkey>
References: <20231001005659.2185316-1-riel@surriel.com>
 <20231001005659.2185316-3-riel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001005659.2185316-3-riel@surriel.com>
X-ClientProxiedBy: MW4PR04CA0129.namprd04.prod.outlook.com
 (2603:10b6:303:84::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: c13eb723-208e-46b6-d313-08dbc301a3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/nlbSJn3OuViaN3dXssr+/jB2spqjVOEbTpMe1fpsYa3bmudN3YHd3Cg88UfReebVrrW8bbeRE1ch5YPsgEluwPMlYqj48mBLXmPKx0OmXc/HJcYpD/jZvjtcyUCRETI2O6YyQRivBPftgMuAbH98OCIkBeUvb1W6DMUHZB+RKAzlYRa7zfFRziB+J1l9qxD4U03snXui6eZLsLmonp8+kDN6s50MNxObEi1jHws9bjtCQM8O7Gkf3J/NQt1Gmy5PGRPf8SZSc3ps4mY0/jCpQOFJFmYyTZXVKFdgoenA/8h57W9zQBXo6HBYwH464UfHkIwhSKzp70s+aXiIXUwa9xzjo4B0zleWfJMozxP5LnLHijoOYm+P8vzn8LiKFcUtYxZCLec3C7ZZ6KbqRyOL0C+sA9Y37QFcwf1fo1+ahbAI1zouFrmhEkSZJPFUIKgkXYB/L2ambzUn3G7vWhFNj4yRk5CumvH9Jr/bIyJGbUr8DccHz7MQcymjHDNLRkoBYyWP+qeebecSR00p1Pmbnt/pEtGlV070dDGN97DurxgeE3JRHDM0wnUMuAbEng
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(33716001)(86362001)(33656002)(38100700002)(6486002)(6512007)(6506007)(4326008)(44832011)(5660300002)(6666004)(8676002)(8936002)(53546011)(9686003)(83380400001)(1076003)(26005)(2906002)(66946007)(66556008)(66476007)(316002)(6916009)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zqrk5vqv56X59hAqaXiH/4QUouIZBu/X5AQFvHDADDnSGy8u9VQDC1taTRit?=
 =?us-ascii?Q?yY00Kxyz79P4PxbAgVYyp0Ellk6XVV2XAUKxyelxQRvnLB4IBFeuE3TRvAxY?=
 =?us-ascii?Q?7jkGnqkNL3O1Bn/tHVLz/F4Sp5XRAvmP3NPB2JK8moFkmb65dDn7SpVH2hPz?=
 =?us-ascii?Q?de0UNA4+5meswye7o6FKR1CV9GcPBIOvZRL/6QbWw7o5VBNapORlTmLbulDM?=
 =?us-ascii?Q?Y6lv6axi/FTV3Urbvs0iQJOsf/Ge+ZpqsEfJITNY8ZOKf1X2w/QWWFyhzcRE?=
 =?us-ascii?Q?HV2S/c0IKJjZzbQs3/4ihtNVQ40okQ4U25lvxM0v3cZ8OEK1MvVMtICXzdD2?=
 =?us-ascii?Q?9eH4J0RwTSQ5Mh7vIK2ZXNUOrO1cyA0fBUeYKp2cLc+VL/PePTB9BizkVI/b?=
 =?us-ascii?Q?VR9OPRfsPnHezQDT7rhwvPjRwSd6CQi4HwVKcedhGuEWlnwVw86Cv/F+NZ9u?=
 =?us-ascii?Q?XV/MV8t9NQveKSSGKpRzW3VeSU+Th9zCeR4pFBx2q3wS7G+hXCNSOJdYdc2B?=
 =?us-ascii?Q?1VqimHV+bg3PI/kbsNtqE4VGi2Y/vrftU8A091oYqgZlIWK6YlKCfBOhNKm1?=
 =?us-ascii?Q?lhu77Hw0ZNwHNzX+44jhtDq4NCuVrtpYZZHouG6rQzuHTlrJJq9/45kgv3r7?=
 =?us-ascii?Q?HPr0rc0BF0ka3NE1ltXZFTzEZTvHQZerX5vziWtCd/jUW6MZE4SND06tA0Z2?=
 =?us-ascii?Q?4Tv5iWQ4+lNydxbo++/kNJpOQBnYF1yTZ19m6i0y6UHdWGE39XPeLO1kNz5W?=
 =?us-ascii?Q?blZgRI4YUINZle46PP+OvJP3MMCeuKa0zquwWsUIdZBWVOo58a3f7d/rbeBd?=
 =?us-ascii?Q?yqXN/otGbpETP3H6Kni10K1T6f5Gy6EcinVzC08i6s9sb37lw5Tl8WBQuAam?=
 =?us-ascii?Q?1D9d71kIZTgiEqF3SSbjjGpNoFAIcU8T708wV/Xk6Qyvhczm5VHIKFIr+xGn?=
 =?us-ascii?Q?1Rw2FpYxvRgcHvaTUW1HmIPTK/8efrpezJeiNl2EkVFjJRRO2y9TXsjncZ4A?=
 =?us-ascii?Q?WySWny0GoJIo1UtvHNG4UWyXAVF3AP0SBRaNT/J6EJjfkDa5VPEsNuYaGXGb?=
 =?us-ascii?Q?HjDzA0bddc2Q/tWnH8g6FnGmug+xRycU6hHIr+QfWVPKsfhRNLZXvft3f4YH?=
 =?us-ascii?Q?V2c/J4lbIO7CUGln5L8gZHMXEhRx2Y8E6wrlte5+DPzH74e2PDwr/GYZaHfq?=
 =?us-ascii?Q?FZxTBIJzZ+zmBx9FBRDD1WUSJAau8tSQlDy137AnxBxhEstdAllA9fiNI2XM?=
 =?us-ascii?Q?Tf8nxzrVI22m7Up5Fpam+XcZHLnOPs70RtaKHk2XGSnzCY+bVw6qTZkqq+jJ?=
 =?us-ascii?Q?Kwd3JLb4wxlsMHlX1hoFatWAFq1cUEesalMe+oeHGf3kjr/jUPoGRBAra//s?=
 =?us-ascii?Q?pUTktaDY3ByiYZJ5LqXAqqZZKIwwE9OmixuBS7rAUA3NLRQjwIZludWnuICC?=
 =?us-ascii?Q?9pLOszPlnyrFXxPKuo1rY6Qwp2jtCrpLNjmwEEu+9fF6UCX6L7SInEEjZyDN?=
 =?us-ascii?Q?5jYcyz+dQvDOyweSWx9PKnEj1xkM+7E7Q0YruxMyycu9RGbyLY+J/Jpt7GJh?=
 =?us-ascii?Q?QiKWNQxBripFTI9x/0E1Tp59lh7ZYMKKkkPx62Qb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3Ji1up+pV5GPzJ3SVs6JLSpRvmI4HORdsXTUI5oZ/Wx3QVkGIB5mhOPPxK/6?=
 =?us-ascii?Q?lQSw0gUp8CEJrvKPS0r1x3ijCMUiJ4EbfhMj7MiXpsd6qY6lv77INn1cQta9?=
 =?us-ascii?Q?wvbBIDJqn0yODPFxMWwhCitdCqEey3vDrRnFjYWkfBnTPWC6oBeOk1NXdGKn?=
 =?us-ascii?Q?n75PvidIMb4ytfHaXaYkDYTGBAcKuOfuCrxI0BrynNtN3SJ63qAjHNFGO7rE?=
 =?us-ascii?Q?tDhqU0WNWmODn7PFTpWNWEL352KsPp1jay5ZsqRU4ps5iScqTvJc3ca5tVJt?=
 =?us-ascii?Q?k+e89bKC6CYbtnRuviCrpKmWH0AB7gOc7W3d8Z5JI+4+GH3bPLKgauHg66rk?=
 =?us-ascii?Q?BKebK/47h6Z0wNzgHlKstYVH5Ksx0gjG82wo9oIcnTpAP6z3ploEsj5RYruu?=
 =?us-ascii?Q?iwfQF0SMyLk4ztjMxOlA6hPgBw+q+jnwWlyyk5W1z8UkXvXQZbtZJGMPkPbu?=
 =?us-ascii?Q?8Q4z7msGPC5PkVEKNdizgHC0lIX19/uTKj1JxfI9uHe4yD5moYqNhVErbOJe?=
 =?us-ascii?Q?s2z94nspbHekApJJcm24VrojPn6SeMrHo4IylQfDxqV4Ty7FyjQQb9fOXxvh?=
 =?us-ascii?Q?lMV/cFeCEEifE4EbRBVV0Eevg38QwN8+VprSLU4CkjvSiLHUJebZG0rYIhrK?=
 =?us-ascii?Q?yeapLTWXMR2ElQV8H+QpRcDK/AGqEx2MCHzmWqBk417p0lP5FYB1MpUHj+/i?=
 =?us-ascii?Q?yE+RMjeynorf2wUSAvEGbWLlATLd05pyynTZHoWdrycmtFY+FCBZsmgritbZ?=
 =?us-ascii?Q?3zo/Q0VIFyTFTf70W0/2eBdaeCum0ZmDAI2rbL+YT7q4QQ6Zk/9MMDwTaVcZ?=
 =?us-ascii?Q?meiOych9eN+fTWKP2B4x8/5xNf7Thu9Y62yq8prbJXLEywxAFvbt5Zwf1T37?=
 =?us-ascii?Q?L6hQEEBRj94VNjyKYn62v03Qb1OA7TDTxxfjPesS8rMeUL1pJ+Y+Aj0uDCu4?=
 =?us-ascii?Q?QSYTOuyf129wk0qS67eK6g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13eb723-208e-46b6-d313-08dbc301a3e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 04:40:01.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61iNFFcx26L6Apl83PE5/8x8qP77pAaM/DLRhBTXQpAq0DUL7CdcFWOHgPT+o2paPGPLTpmq92h7kx6NJZvWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-01_21,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=2 suspectscore=0 bulkscore=0 spamscore=2
 mlxscore=2 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=177
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310020036
X-Proofpoint-GUID: VuaEjLFtQ7jLKf7gw_l_pXPKYZ97KFnZ
X-Proofpoint-ORIG-GUID: VuaEjLFtQ7jLKf7gw_l_pXPKYZ97KFnZ
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/23 20:55, riel@surriel.com wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Malloc libraries, like jemalloc and tcalloc, take decisions on when
> to call madvise independently from the code in the main application.
> 
> This sometimes results in the application page faulting on an address,
> right after the malloc library has shot down the backing memory with
> MADV_DONTNEED.
> 
> Usually this is harmless, because we always have some 4kB pages
> sitting around to satisfy a page fault. However, with hugetlbfs
> systems often allocate only the exact number of huge pages that
> the application wants.
> 
> Due to TLB batching, hugetlbfs MADV_DONTNEED will free pages outside of
> any lock taken on the page fault path, which can open up the following
> race condition:
> 
>        CPU 1                            CPU 2
> 
>        MADV_DONTNEED
>        unmap page
>        shoot down TLB entry
>                                        page fault
>                                        fail to allocate a huge page
>                                        killed with SIGBUS
>        free page
> 
> Fix that race by pulling the locking from __unmap_hugepage_final_range
> into helper functions called from zap_page_range_single. This ensures
> page faults stay locked out of the MADV_DONTNEED VMA until the
> huge pages have actually been freed.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  include/linux/hugetlb.h | 35 +++++++++++++++++++++++++++++++++--
>  mm/hugetlb.c            | 20 +++++++++++---------
>  mm/memory.c             | 13 ++++++++-----

Hi Rik,

Something is not right here.  I have not looked closely at the patch,
but running libhugetlbfs test suite hits this NULL deref in misalign (2M: 32).

[   51.891236] BUG: kernel NULL pointer dereference, address: 00000000000001c0
[   51.892420] #PF: supervisor read access in kernel mode
[   51.893353] #PF: error_code(0x0000) - not-present page
[   51.894207] PGD 80000001eeac0067 P4D 80000001eeac0067 PUD 1fa577067 PMD 0 
[   51.895299] Oops: 0000 [#1] PREEMPT SMP PTI
[   51.896010] CPU: 0 PID: 1004 Comm: misalign Not tainted 6.6.0-rc3-next-20230925+ #13
[   51.897285] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
[   51.898674] RIP: 0010:__hugetlb_zap_begin+0x76/0x90
[   51.899488] Code: 06 48 8b 3a 48 39 cf 73 11 48 81 c7 ff ff ff 3f 48 81 e7 00 00 00 c0 48 89 3a 48 89 df e8 42 cd ff ff 48 8b 83 88 00 00 00 5b <48> 8b b8 c0 01 00 00 48 81 c7 28 01 00 00 e9 87 3b 91 00 0f 1f 80
[   51.902194] RSP: 0018:ffffc9000487bbf0 EFLAGS: 00010246
[   51.903019] RAX: 0000000000000000 RBX: 00000000f7a00000 RCX: 00000000c0000000
[   51.904088] RDX: 0000000000440073 RSI: ffffc9000487bc00 RDI: ffff8881fa71dcb8
[   51.905207] RBP: 00000000f7800000 R08: 00000000f7a00000 R09: 00000000f7a00000
[   51.906284] R10: ffff8881fb5b8040 R11: ffff8881fb5b89b0 R12: ffff8881fa71dcb8
[   51.907351] R13: ffffc9000487bd80 R14: ffffc9000487bc78 R15: 0000000000000001
[   51.908648] FS:  0000000000000000(0000) GS:ffff888277c00000(0063) knlGS:00000000f7c99700
[   51.910613] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   51.911983] CR2: 00000000000001c0 CR3: 00000001fa412005 CR4: 0000000000370ef0
[   51.913417] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   51.914535] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   51.915602] Call Trace:
[   51.916069]  <TASK>
[   51.916480]  ? __die+0x1f/0x70
[   51.917057]  ? page_fault_oops+0x159/0x450
[   51.917737]  ? do_user_addr_fault+0x65/0x850
[   51.919360]  ? exc_page_fault+0x6d/0x1c0
[   51.920021]  ? asm_exc_page_fault+0x22/0x30
[   51.920712]  ? __hugetlb_zap_begin+0x76/0x90
[   51.921440]  unmap_vmas+0xb3/0x100
[   51.922057]  unmap_region.constprop.0+0xcc/0x140
[   51.922837]  ? lock_release+0x142/0x290
[   51.923474]  ? preempt_count_add+0x47/0xa0
[   51.924150]  mmap_region+0x565/0xab0
[   51.924809]  do_mmap+0x35a/0x520
[   51.925384]  vm_mmap_pgoff+0xdf/0x200
[   51.926008]  ksys_mmap_pgoff+0x18f/0x200
[   51.926834]  ? syscall_enter_from_user_mode_prepare+0x19/0x60
[   51.928006]  __do_fast_syscall_32+0x68/0x100
[   51.928962]  do_fast_syscall_32+0x2f/0x70
[   51.929896]  entry_SYSENTER_compat_after_hwframe+0x7b/0x8d

I think you previously built libhugetlbfs, so hopefully you can recreate.

The stack trace (and test) suggest hugetlbfs_file_mmap returns an error
due to misalignment, and then we unmap the vma just previously created.
Looks code is now calling hugetlb_zap_begin before unmap_single_vma.
The code/comment in unmap_single_vma mentions this special cleanup
case.  Looks like vma->vm_file is NULL and __hugetlb_zap_begin is doing
a i_mmap_lock_write(vma->vm_file->f_mapping).

        if (start != end) {
                if (unlikely(is_vm_hugetlb_page(vma))) {
                        /*
                         * It is undesirable to test vma->vm_file as it
                         * should be non-null for valid hugetlb area.
                         * However, vm_file will be NULL in the error
                         * cleanup path of mmap_region. When
                         * hugetlbfs ->mmap method fails,
                         * mmap_region() nullifies vma->vm_file
                         * before calling this function to clean up.
                         * Since no pte has actually been setup, it is
                         * safe to do nothing in this case.
                         */
                        if (vma->vm_file) {
                                zap_flags_t zap_flags = details ?
                                    details->zap_flags : 0;
                                __unmap_hugepage_range_final(tlb, vma, start, end,
                                                             NULL, zap_flags);
                        }

Looks like vma->vm_file is NULL and __hugetlb_zap_begin is trying to do
i_mmap_lock_write(vma->vm_file->f_mapping).

Guess I did look closely. :)
-- 
Mike Kravetz
