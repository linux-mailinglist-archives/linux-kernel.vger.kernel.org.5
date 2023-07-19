Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29779759DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGSSv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGSSv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:51:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15413B6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:51:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOi6H025954;
        Wed, 19 Jul 2023 18:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=zqQqVZ1C05K5mbGVI+92kOzWifEadu3r0427EPZsyFc=;
 b=TbQLbn7h4SKRp3L8gpDgpkW2VqmudOYpw+RZGRKFDodRyttsj+MMQEnajlcfjxmag2eJ
 sE66xR87XEBhUS3jbBAFW/BCq3b+d7xL9weIaR6S4xIFLh+fWFpCLqb27GSjECWPWPwa
 y7eMlVWzkmG5+Pp0tYuZncPMawTU3rHIdqXJY68v1nj7IbxE2lFKae/i0lBiqSZbC+6U
 RC/wzddwu8sS+RqjRElLZ0cm7ap3df/pDZXfPuIidtaZhYNOkwAtr15KiZ3rL2xR4IR7
 670PJSY/PmApB8S3NBa4gwXK249735IPJ4ZM0VP3XSXVpaywMOrQEfV49TbvJnjQPraK pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run7708kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 18:51:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JIilS6007772;
        Wed, 19 Jul 2023 18:51:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw738f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 18:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAM2N55R3ZKuu4PN5X0+/EBu8sgNm9DSohOpmuCKXV2CMbS0WnJXSMWjcVNSAioWDumlUFk13lY1JOm3SEwK0STP5cy4preIkNM7vfjQdWNy3VNosPjJ1ra1b6SSR+E2afVqBpyIioCczhXkXUpanOH5qM0NRBxINee3ubL4axnXjxiYTNMYvnNrSnfFBtgVq+Pf6kPCshnyEbQLKgSWtisY4ymj0fwCz642SQ6K0ayKC3SdV5ikhtwqjGk3frZMntY5QUxPcHUG9A15Vg5U93f1YqWQqIt7pfa3gdThaYtC3nnItV+PhtnSsXwsdFo4nwAmnhpwoOu94Fd2TLfnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqQqVZ1C05K5mbGVI+92kOzWifEadu3r0427EPZsyFc=;
 b=A2WuZfi2yVWAQkrfKaTqXaddIXm0V46WgA4dnuB2g+T9m/9m02nT7S2P9qBrT0/Pq9BdSEBpt8IdJThv2DcGw+Fm5dChaGWHhv1ewRZlw1pz58eo0NbQQVv30WDXdeovYVlKOmf7JbmRbtABLR6tkh+yOdKrxoq+ya8deKJ75+U6pHYoj/i+fD53WH6MGuplnImY5MBYAJX6idWDoJ9gJZDWi4eK2y6ojt/0aOccK25uSzvcYYoD19GMgiD9q8KOyf4LxOvHdji33cwx9qnsR1B4aztyhf/zFXNF4DIwh23sZ5Aje69vKlpLGArdChhTtq49x7EaKZesbaMLEMSzsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqQqVZ1C05K5mbGVI+92kOzWifEadu3r0427EPZsyFc=;
 b=rHOHth8DudEe2sTnbfZklBeJ7uSIavHzSjLBDexD6b21orGlCVa28n7zZS5sP8KZXpQLrP9sSlDRVd0A7K/FFZNcAklHC2SslhgUpGXrcAn/0DRK4jl1GQMOhfeSQTvUpY9jXV0L0svN4HMsnIb4WDE0gS2e9tFr6QVq3qbPhuE=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by SJ0PR10MB4720.namprd10.prod.outlook.com (2603:10b6:a03:2d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 18:51:37 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::567b:a4ec:2f3:619f]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::567b:a4ec:2f3:619f%2]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 18:51:37 +0000
Date:   Wed, 19 Jul 2023 14:51:35 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
Cc:     Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Message-ID: <20230719185135.nyun5fvcuv3ydku4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>,
        Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= <chinwen.chang@mediatek.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
References: <9cb8c599b1d7f9c1c300d1a334d5eb70ec4d7357.camel@mediatek.com>
 <20230613141114.bwbnqsdazqbmyj3u@revolver>
 <3b14df2fc2a7f18fe12f87a27574b7d40f2899ba.camel@mediatek.com>
 <20230614155826.cxcpv33hs763gyrg@revolver>
 <ed7899c7328aabfbe9bc9589f0776a75e6c9d1ee.camel@mediatek.com>
 <20230706185436.agobbv72o3hma43z@revolver>
 <3507fdacf001c49f4c73f2952257beabfe9e1a53.camel@mediatek.com>
 <20230710142425.t5vhrqkjd7ugbmad@revolver>
 <f7aec937af73798c5e42b7e37adb744df5562cca.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f7aec937af73798c5e42b7e37adb744df5562cca.camel@mediatek.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0437.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::10) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|SJ0PR10MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 338721ff-ab89-4df8-6594-08db88892e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LF6KFpGOLUmoHw5bzrACJ1uNoaTxs9jjDSA1BbVIly+Dzi1KGmKpGNSGVmGugCRABSHedvrmxNyYXQ6cE5kpANFUah3SsOtwer/2D7zjMyRiCF6i0/V29+q1oYSjrSb26exGKsT4jX4zg1TjdPqeBVi4mhHDFaHXhSl1W8QYE5ew8X3Swq5S8+i8U+ofj0AjK6+02DtEWMNKLRB4VbyTHoLodWyN7IFmCf3oLXFCKI6Pwog/ld3d5kaFfuiSPyfsgGUUkp2CP20W4afgj/H/QvX2S6zYdC1ZYIQkucMc1CtS3b9FKzuBycNb2hECVWz8v+rfTeDUm4s2lq7c/6pYC0goO5qlSXdKRtwChUpOJOR0v2o2WVFjMVOmj/QHPkLcnpX4mXkEthzEgJaFinQZwsRumwS/DpDVjg9UmGxMwwBBxHTxcZp8l90dCmp6NQ03Xp14Uo+t1AHPEeL5K0HL3sqH+Z6ke7VJGgRgRDze40OIWvdc32hU7ptxudLGr9gs3iSAH0Ice14wJ/bI3aQVdYfqeou9Fc1O6uQzZ4X8VjFq5DvJF1UcUb2hd+r1B7XD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(83380400001)(54906003)(478600001)(9686003)(26005)(1076003)(6512007)(6506007)(6486002)(86362001)(186003)(2906002)(4326008)(66556008)(66476007)(6916009)(316002)(5660300002)(66946007)(33716001)(8676002)(8936002)(7416002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzRQbHdENzA2dk1GVzljbkE4aitGbElkODE1bmcyTndkTUsxaFowamlZSHlG?=
 =?utf-8?B?Mk9zdVZ1YzduNjFWM0xtY2UrdDNITEhyV0lid0RDOWkyWWRPLzBuSktRSk8x?=
 =?utf-8?B?THhocDExT2pGYm1rNElMMURHWWVKcG95MWcvTzFBaFNCNnpJOGxGY3BLT09P?=
 =?utf-8?B?dHUzQVlsT1JqSHhGY1ZveXg3dVl2YitmbUFSWlBFbkEvSWlxZys1TXFUbU5T?=
 =?utf-8?B?bEc1azNmR3luQlhmS2JrdzdvYmJnWktHdnVwcE8wODNOVTJWaHRSUnNLVVhw?=
 =?utf-8?B?RVVSL3ptS3JUc21QOE5pdWFXaXhQakdwU0lRSDFQVTRlUm16TC8zRU1nVmNJ?=
 =?utf-8?B?b2svb2grREovYnAvSDJsL3RXU2N2VTI4WU5MeVduam91dlhiWFVVWmpXV2t5?=
 =?utf-8?B?UVo0S3ptdnhWOU1mMFVnOER0N2JSeUdNeTVEcHVWeVB6YS9md1FKVTY1MnlL?=
 =?utf-8?B?VUNIY1dyT3pWWUJYSWc1SDhweHF4N3lYSVlyTXNJL3dVVlAxRS9WVlJyd0Rt?=
 =?utf-8?B?c0l4b1h3WnE2Ykw2UGU3UllveHNQVTdhZnhMZnZGOUZKMXVVcDRVcmlWTVQ3?=
 =?utf-8?B?K1pHbmNTaGpIeUs4cE1BV3hnUmdQa2RkckRncHVSUHpwVGluTUV1aUwvYTEz?=
 =?utf-8?B?ODJCMEFocVg5blc2WStKWXdmZi9yQi9WM3d2K3JJNTBmc1Z2WHd0ZmRqMEQx?=
 =?utf-8?B?eTEvNC9yWjdCczZqKzlWSUtRODZlalNCRERHbkMyMmJlbGwvYWpRVFNJcWNl?=
 =?utf-8?B?U3NqSHhTWEwvK2FQdmNkck9ZbHR0aWtzSHk3MHk4VEtsQjhMWnVsVUgzMGhq?=
 =?utf-8?B?cU5PZDVUMmQyaEFLVmhpaVJPMUs0ZkQ0cU9BVDQ3dlpwaE1rTHQvelhWV3V4?=
 =?utf-8?B?bVVvaU9KMjhsbUlsbSsrTTBhaVA5MWZJTktVRHBhcU5xNlNJWFIyaXc1NmZC?=
 =?utf-8?B?dDV5dlAwTFlvZGpFb09pKzJla3BNQnlFYVFkTHY2clR0UU54cmVBM3hIN2J3?=
 =?utf-8?B?UGc0cFZnb3VGakNON2I4RHdtdTJObG9FVjJiZDhUS2htbnc5KzE4TjJKRFpK?=
 =?utf-8?B?c3lLT3hiSXIxSDVYQW1iQUxvTEVVMVFmMHFJT0hGV2RrTEFoVHJlYjg1WnpP?=
 =?utf-8?B?dGltQ0N0a252bDhKVFJJYXd2WjhuU0NHa3hvYVhQdXl1VTNLU0VkWmRUZTAy?=
 =?utf-8?B?U0FWbEEwQlowMEY3bUtsa1VHL1JwZzJna2traE5lS29lbUhxTGxTQ1B6QUwz?=
 =?utf-8?B?MHBPT3NTQndGTzlaemNvWS8yNEdMMU00RlpkdkplNHFhdkFiNFlwZW5DdGtM?=
 =?utf-8?B?bk5RVUhIRnBLaU1odXJ2aVpBY2I1UzB2V3ZpNDhMOGVEdGtKcWd4NWRCZTFF?=
 =?utf-8?B?Ylh6VDdid1IyUml0ZWtnRXdSVHh2Y3JIalFmLzZJaisrai96Qk96OFVQSjBa?=
 =?utf-8?B?aXQzUFNkNDdjL21JNm0yRTE5dU9Bc3lGL29ycU5rL2xybnlJK0gzeUtIaDd3?=
 =?utf-8?B?Z1JWbzVmQnc5U2g5dlZoWk9BQ1VpQ2VHVXZRSm5nczNFQWhkM1ZZNkVqVGpI?=
 =?utf-8?B?UHFmOW9BTWNtU000ZklqZHVEbVJmQW1IT2tRRzhUTDBhV2tFVkJRWGw1a3dK?=
 =?utf-8?B?TXY5ekF0WVBpK1V5dmljcEV4aElYRWN2SDRsM21scHVGQVdRVkVUak9aR1o3?=
 =?utf-8?B?Ym15UXMvTG1FcXdSQjBGS2FJYVZLZGZvOHU4cWNRR05zS1F6S1ZSNlRXazdR?=
 =?utf-8?B?VkRvVFJUNjlHc2tUbHplYkxNTFBBc0U5T1FNeXRTd1dzNVo3VU5lcWtzQTdI?=
 =?utf-8?B?NHB0WFR6VURhQ09maEM0Y1hYRDFXb2J1RDFhYTd1Snp5K0RhRVNnNjVjeGxW?=
 =?utf-8?B?QzFSN0lSRTBvVXRnSnVYVTdENFVhczMreDNwRUo0K1ZVWng1SW55RXM5QUFt?=
 =?utf-8?B?ZUp0WjZTT0c5eXdWY2FSMWdwNG45ODZDRzBnTldGNXp3UnE5K0h5T3dwVWpV?=
 =?utf-8?B?ZEEvZE9RWkhxMFN0clRZOVQ3QTdmNVVCdHV6VHdNOEpiSm5BeUJ3VFpEOE8x?=
 =?utf-8?B?OG5PUE1tUFVmbDZXQml0RVNzTndPem5OSWNtdlREaUdBbnFiejZBN1YzZXY3?=
 =?utf-8?B?eWlpRjVRK2M1eGl4bENiZ3FmN1R1TnJuWmFaSituWVZMaVg1elhiaVMrcG5a?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YUFRRHI0Nm9PVG14S1JQc0tlaVVmZ05HcUt1dVRsWFMxRThrV1YybVlxZzZn?=
 =?utf-8?B?Ulo1d0pKV3p2MDVremlObjJHd0F0M0NDL3AzS0RQMEducXZPTXFCZmpkQmRR?=
 =?utf-8?B?K2FTajA4aWVyQTlrMHI5QU9rL2JLSjNaaDBJb0dWbmxIakJQZkJtM0FJdVNN?=
 =?utf-8?B?S245cUx3cEVaamk1Vm1saVlqZSsxcytzL1NKYWlOZ01ucmxPUEVqaVZ3Tis1?=
 =?utf-8?B?S2g0dGJtd3dnZytOR1kvSHF5dDU1ZWhmOGVwOWMydmR0K01lR2kvYzd6c0sz?=
 =?utf-8?B?QzJncVd2a1dTZ0haR3JPLzJLcERJSlAydmpiNmFKOVgvL0xvNm1PQW9PMlZR?=
 =?utf-8?B?dFl3bGhjOW82Y1JTdHhYYXdDL2Zvdk5UU3RRN3BleVd2MXpjdVF1NTZhNFZS?=
 =?utf-8?B?NzR1UDhhWlJBazZ5aE10dTNRcVN0ZWx3djRmV1llQW40bVNaZUxmVVRVbXRh?=
 =?utf-8?B?TFZZWGordDlxUnptb2NqRkY3cUx3QVlZa3E1d2pYZnowOEdSb2lhWVM0Wm4v?=
 =?utf-8?B?c1R3R2dRckVpTHJqNE04aGZDdmtlQ3Z0bS9abVR0OGRITWdEalg3TFY1bXpw?=
 =?utf-8?B?eFBNSEFTSkN2dXBWZlU1UUNXVTBHVlY3ZzNFUHlVTWkvd3NMbGJDRkRJM3hJ?=
 =?utf-8?B?WkF6eXJiTnBzK3dlK1UzTWVyb3pmWmhuaEFBOC9sYkRCMjVmYWdlU3BxS2xO?=
 =?utf-8?B?UWNJRlpSR0VWV2JzQ0NGbnJqbFd6U3BwbWtWTExwajhpWHZmYUQ5eExNRnlj?=
 =?utf-8?B?c1FheldmbkxPMWtjdjFudkdVUStXUnpQbVJPRU9TdThVdnRUaVd2RnVsUXgr?=
 =?utf-8?B?SEwvNkpBMFhYMk5DQkozZDI2UGpJQmRaTFlEUEViQVNXUnE2RDE0WTV0T2Ra?=
 =?utf-8?B?RmdFMlVraUZ4ZGNGc2svcWQ0ZkFyejZDTzdOTkY5OTlmR1NJQ3dZaFJmYUtY?=
 =?utf-8?B?TDZXaURUTTRDSnRmQ2JLdlVVT0U4UEcwSFdvU0hFQnRoQVNBN3JFUU1TUnRG?=
 =?utf-8?B?VzVhL1M2ZUtwMzB3R1U4TE9YejRUcDZuRGI3MStzWkErT1hhMUdxdGxuK1hy?=
 =?utf-8?B?emtZN0MyNW40ajg3bDV1RUJONmtkbjNtdWdDVDY2Mko3bUtYUUZtdU42LzUy?=
 =?utf-8?B?cW15T3BzQTVndm9yTmFqbHBkekl4MnR2UEZPaWJncU9xejZ5cnkySUJ1ZlJx?=
 =?utf-8?B?R2l3bmNYem5uQ0VxTVZaeXM2UjJYcTJLVytpam1JVGNvNTVFc0VvWDhpWXIy?=
 =?utf-8?B?VkUycTZEQU9nbUVMRC96YVhCOUI2b1RjUG5YdW1RWU9XRlRvQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338721ff-ab89-4df8-6594-08db88892e35
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:51:37.1704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCzz4XoODUJe5hgCQHp97x8khxoyllaBD4vavBaVT+KF/sIbDCVSwyCqiB759BxNBWY6AimIG+PidZggm9oAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_13,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190170
X-Proofpoint-GUID: NObKBchlHPyWHt9L5aWxalG0u2pF486n
X-Proofpoint-ORIG-GUID: NObKBchlHPyWHt9L5aWxalG0u2pF486n
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* John Hsu (=E8=A8=B1=E6=B0=B8=E7=BF=B0) <John.Hsu@mediatek.com> [230712 23=
:26]:
> On Mon, 2023-07-10 at 10:24 -0400, Liam R. Howlett wrote:

...

> > > > > > > As you mentioned, mas_preallocate() should allocate enough
> > > > node,
> > > > > > but there is such functions mas_node_count() in
> > > > mas_store_prealloc().
> > > > > > > In mas_node_count() checks whether the *mas* has enough
> > nodes,
> > > > and
> > > > > > allocate memory for node if there was no enough nodes in mas.
> > > > > >=20
> > > > > > Right, we call mas_node_count() so that both code paths are
> > used
> > > > for
> > > > > > preallocations and regular mas_store()/mas_store_gfp().  It
> > > > shouldn't
> > > > > > take a significant amount of time to verify there is enough
> > > > nodes.
> > > > >=20
> > > > > Yap..., it didn't take a significant amount of time to verify
> > > > whether
> > > > > there is enough nodes. The problem is why the flow in
> > > > mas_node_count
> > > > > will alloc nodes if there was no enough nodes in mas?
> > > >=20
> > > > What I meant is that both methods use the same call path because
> > > > there
> > > > is not a reason to duplicate the path.  After mas_preallocate()
> > has
> > > > allocated the nodes needed, the call to check if there is enough
> > > > nodes
> > > > will be quick.
> > >=20
> > > So whether the purpose of mas_preallocate() is decreasing the lock
> > > retention time?
> >=20
> > It could be, but in this case it's the locking order.  We have to
> > pre-allocate and fail early if we are out of memory, because we
> > _cannot_
> > use GFP_KERNEL where we call mas_store_prealloc().  mas_preallocate()
> > will use GFP_KERENL though.  We cannot use GFP_KERNEL during the
> > store
> > because reclaim may sleep and we cannot sleep holding the locks we
> > need
> > to hold at the time of the store operation in __vma_adjust().
> >=20
> Yap, if the type of lock is spinlock, the flow shouldn't sleep in the
> critical sections. mmap_lock is implmented by rw_semaphore(mutex). Is
> there any other lock in this section?

Yes, the i_mmap_lock_write(), the anon_vma_lock_write(),
flush_dcache_mmap_lock().

> > >=20
> > > > >=20
> > > > > > > I think that if mas_preallocate() allocate enough node, why
> > we
> > > > > > check the node count and allocate nodes if there was no
> > enough
> > > > nodes
> > > > > > in mas in mas_node_count()?
> > > > > >=20
> > > > > > We check for the above reason.
> > > > > >=20
> > > > >=20
> > > > > OK..., this is one of the root cause of this BUG.
> > > >=20
> > > > The root cause is that there was not enough memory for a store
> > > > operation.  Regardless of if we check the allocations in the
> > > > mas_store_prealloc() path or not, this would fail.  If we remove
> > the
> > > > check for nodes within this path, then we would have to BUG_ON()
> > when
> > > > we
> > > > run out of nodes to use or have a null pointer dereference BUG
> > > > anyways.
> > > >=20
> > > Yap, the root cause is oom. The BUG_ON() for the situations that
> > the
> > > maple tree struct cannot be maintained because of the lack of
> > memory is
> > > necessary. But the the buddy system in linux kernel can reclaim
> > memory
> > > when the system is under the low memory status. If we use
> > GFP_KERNEL
> > > after trying GFP_NOWAIT to allocate node, maybe we can get enough
> > > memory when the second try with GFP_KERNEL.=20
> >=20
> > Right, but the GFP_KERNEL cannot be used when holding certain locks
> > because it may sleep.
> >=20
> > > > >=20
> > > > > > >=20
> > > > > > > We have seen that there may be some maple_tree operations
> > in
> > > > > > merge_vma...
> > > > > >=20
> > > > > > If merge_vma() does anything, then there was an operation to
> > the
> > > > > > maple
> > > > > > tree.
> > > > > >=20
> > > > > > >=20
> > > > > > > Moreover, would maple_tree provides an API for assigning
> > user's
> > > > gfp
> > > > > > flag for allocating node?
> > > > > >=20
> > > > > > mas_preallocate() and mas_store_gfp() has gfp flags as an
> > > > > > argument.  In
> > > > > > your call stack, it will be called in __vma_adjust() as such:
> > > > > >=20
> > > > > > if (mas_preallocate(&mas, vma, GFP_KERNEL))
> > > > > > return -ENOMEM;
> > > > > >=20
> > > > > > line 715 in v6.1.25
> > > > > >=20
> > > > > > > In rb_tree, we allocate vma_area_struct (rb_node is in this
> > > > > > struct.) with GFP_KERNEL, and maple_tree allocate node with
> > > > > > GFP_NOWAIT and __GFP_NOWARN.
> > > > > >=20
> > > > > > We use GFP_KERNEL as I explained above for the VMA tree.
> > > > >=20
> > > > > Got it! But the mas_node_count() always use GFP_NOWAIT and
> > > > __GFP_NOWARN
> > > > > in inserting tree flow. Do you consider the performance of
> > > > maintaining
> > > > > the structure of maple_tree?
> > > >=20
> > > > Sorry, I don't understand what you mean by 'consider the
> > performance
> > > > of
> > > > maintaining the structure of maple_tree'.
> > > >=20
> > > As I mentioned above, GFP_NOWAIT will not allow buddy system for
> > > reclaiming memory, so "Do you consider the performance of
> > maintaining
> > > the structure of maple_tree" means that: whether the
> > mas_node_count()
> > > path is not allowed to reclaim or compact memory for the
> > performance.
> >=20
> > Ah, no.  This is not for performance.  It was initially on the road
> > map
> > for performance, but it was needed for the complicated locking in the
> > MM
> > code.
> >=20
> > rb tree embedded the nodes in the VMA which is allocated outside this
> > critical section and so it could use GFP_KERNEL.
> >=20
> As I know, following is rb_tree flow in 5.15.186:
>=20
> ...
> mmap_write_lock_killable(mm)
> ...
> do_mmap()
> ...
> mmap_region()
> ...
> vm_area_alloc(mm)
> ...
> mmap_write_unlock(mm)
>=20
> vm_area_alloc is in the mmap_lock hoding period.
> It seems that the flow would sleep here in rb_tree flow.
> If I miss anything, please tell me, thanks!

Before the mmap_write_unlock(mm) in the above sequence,  the
i_mmap_lock_write(), anon_vma_lock_write(), and/or the
flush_dcache_mmap_lock() may be taken.  Check __vma_adjust().

The insertion into the tree needs to hold some subset of these locks.
The rb-tree insert did not allocate within these locks, but the maple
tree would need to allocate within these locks to insert into the tree.
This is why the preallocation exists and why it is necessary.

>=20
>=20
> > > > >=20
> > > > > > It also will drop the lock and retry with GFP_KERNEL on
> > failure
> > > > > > when not using the external lock.  The mmap_lock is
> > configured as
> > > > an
> > > > > > external lock.
> > > > > >=20
> > > > > > > Allocation will not wait for reclaiming and compacting when
> > > > there
> > > > > > is no enough available memory.
> > > > > > > Is there any concern for this design?
> > > > > >=20
> > > > > > This has been addressed above, but let me know if I missed
> > > > anything
> > > > > > here.
> > > > > >=20
> > > > >=20
> > > > > I think that the mas_node_count() has higher rate of triggering
> > > > > BUG_ON() when allocating nodes with GFP_NOWAIT and
> > __GFP_NOWARN. If
> > > > > mas_node_count() use GFP_KERNEL as mas_preallocate() in the
> > mmap.c,
> > > > the
> > > > > allocation fail rate may be lower than use GFP_NOWAIT.
> > > >=20
> > > > Which BUG_ON() are you referring to?
> > > >=20
> > > > If I was to separate the code path for mas_store_prealloc() and
> > > > mas_store_gfp(), then a BUG_ON() would still need to exist and
> > still
> > > > would have been triggered..  We are in a place in the code where
> > we
> > > > should never sleep and we don't have enough memory allocated to
> > do
> > > > what
> > > > was necessary.
> > > >=20
> > > Yap. There is no reason to seprate mas_store_prealloc() and
> > > mas_store_gfp. Is it possible to retry to allocate mas_node with
> > > GFP_KERNEL (wait for system reclaim and compact) instead of
> > triggering
> > > BUG_ON once the GFP_NOWAIT allocation failed?
> >=20
> > Unfortunately not, no.  In some cases it may actually work out that
> > the
> > VMA may not need the locks in question, but it cannot be generalized
> > for
> > __vma_adjust().  Where I am able, I use the mas_store_gfp() calls so
> > we
> > can let reclaim and compact run, but it's not possible here.
> >=20
> We have used GFP_KERNEL as alloc flag in mas_node_count flow about 2
> months. The mentioned problem we mentioned in the first mail didn't
> reproduce under high stress stability test.
>=20
> I have seen the patch provided by you. I will verify this patch in our
> stability test. But there is a problem, if maple_tree behavior is
> unexpected (e.g. redundant write bug this time). We can only review the
> whole mm flow to find out the wrong behavior. Do we have an efficient
> debug method for maple tree?

There is a test suite for the maple tree found in
tools/testing/radix-tree, but it does not test the mm code and
integration.

There are other mm tests, but they will not test the OOM scenario you
hit - to the best of my knowledge.

There are also config options to debug the tree operations, but they do
not detect the redundant write issues.  Perhaps I can look at adding
support for detecting redundant writes,  but that will not be backported
to a stable kernel.

Thanks,
Liam
