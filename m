Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382E676A4EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjGaXlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGaXlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:41:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA791B5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:41:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKV5T0017388;
        Mon, 31 Jul 2023 23:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=asrnYO27Rm8v2vf9io2qCWlu6WEhWtQanTe84gZ3ul4=;
 b=chXSoqgB5rHn8WlXtGF6k1SIwHlXvG8DP18NB0XT6mFgYG5YFNrdrLSPQNe8JJcSsTFY
 CFDK7cfw4BhXLu4GazzC6DG3Az8JW7oPHCMUZZGZc+kQxzrrteRMYlUjXfEOzNvM47T2
 l7JYEBWaUl3YYH9UrPha3Uie904+9GiyXkXoTaPxN1KyckU/VjNirLVtG0uMUWMGUVFZ
 iXWnTuVlmrEdFp/cUGm+f82+/0syPIoGLoro5kquh/bTLY76C8cjftDQZ8cQHbXrNHOd
 PnD0LKt3JGX/2+uNjWtQlQoOty7+1ZUizfl4KDq0WMfWmjVfFx80R8Iftf1AoMewEymz Sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2bsw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 23:40:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VMHjuM013543;
        Mon, 31 Jul 2023 23:40:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s75mrud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 23:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQVVw7GBH6r8ywaQ9jxX5teaqoJlrNMQxYVVxu8CEKoJiVkDacFzjoDXI8kJKdIyQ37UGohy4cdbqki8CKVvirdzkmsmmx1FSLjYEUnifNcq8kV85ruvugR5s2ORVpuLK13llzXZpOZaTbXwn1ldxm+nEfW8Xmxqkzf2874dRkoCTeB4ptdfzEx9oymyUcKmSzkb4gViVN8MYQ93n4KO3ZDUqD050AE4qDE+iwVDX2IC7JYjMCuHeuNoGjF1RferQnrDA7asf1o6+6ONj0QnqCaFTjm5Xd9NGIRUH3ndZPo5/mtTXghzMwEfB+xxXolxl5FrAJ9Dg1ddUTcoLLWITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asrnYO27Rm8v2vf9io2qCWlu6WEhWtQanTe84gZ3ul4=;
 b=jt8ciDwF+2Ejffq6D9zOemw7UQdGjObmr7YHcXnAQ3HVzRQIdmt7nn76TXPBEoRnDjn23dAGNHUU1/rEnylWb1/AeagQnpzokj4QLPmpeHpBGIr5EfDwPb/FMKvrPhqfo3YKJjd+9eMF6East/TNIy+JOVByL1znVcLJKUKuac7SMfF6NDf610MBdj73X1FpT/xs7LyzBpkzAOeKCi8j9sUXN48dMcYpf6AxHELvd1Li0nErjYVb2cwFtcPigeaw0gU89zQXvAbzR7z5rqVTgPQXjrWbVDEQrgHoJNb23/sWdU/QP/cPGa0T9nxGQ7Jl6308L+m56s8qN0LQAMVeRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asrnYO27Rm8v2vf9io2qCWlu6WEhWtQanTe84gZ3ul4=;
 b=sgx58aY3rv9LXcsXSjMnUzQoVTm051P2Km8i+fJ8+JVO6NriXdESMtKXDA6XZxjdLr6HVplmHvxurjmN9It+EPUmDkpjN9NkZRY2JEHxPc4SOPhJsZErgDMHh/EwvrkEdUMCigk83+fqLoBQDi1XqiSzhddS8mh1YG5UIRBl/NQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6756.namprd10.prod.outlook.com (2603:10b6:930:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 23:40:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 23:40:30 +0000
Date:   Mon, 31 Jul 2023 16:40:27 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Mina Almasry <almasrymina@google.com>, kirill@shutemov.name,
        joel@joelfernandes.org, william.kucharski@oracle.com,
        kaleshsingh@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: hugetlb: use flush_hugetlb_tlb_range() in
 move_hugetlb_page_tables()
Message-ID: <20230731234027.GB39768@monkey>
References: <20230731074829.79309-1-wangkefeng.wang@huawei.com>
 <20230731074829.79309-2-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731074829.79309-2-wangkefeng.wang@huawei.com>
X-ClientProxiedBy: MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c0c2fb-8854-4d11-62ad-08db921f86cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldyCfY7DYDeiaeNPWB2TaT2KiqqA24cqYtoaaNFfTB3q7hqYJWeQ6lU0RpBH0YRr9LpZiX2iEO4b9pDzSziLV8x63n1hQWWXuynkcEsI8NO8xuKD/a8pJmrz8x473pZaDmzLIlr8aTGBt5tkQhfaUxENrszaEdaYPemajk7imY3tisJzm44BvzSKQPQSYOt5bk6Swd9R5Ux+l+JnvB1iJnPOwwvHvYwmD2XbC12W+4nHtQRBfJhCtNA5A6mn+bNsHIj87ap/Gc3LNx55MZJYk2ZbWro4G3aUydSa8TEbstHseixkQER51VECVDm/t+lEvoxMIejqugyEMsvTBtaJAyTTjcr+V4bUXqlFJOtLbdugN6gC6E2IMb17/MStYOdTKLFAlV1TzwhzDAOVzwwelxmS1yr1LUtLQ4tt6jlpURNMZxUIeY0jauK612Va9NNJmudpeguJMn8qIsnElbExmT1dL0nCxcnCTkezZvH9F9+Mcc+OHlABlnbCFep41t25fxzmnkb8ArY9SAHzLt3JDBq+6Xniq9hek5ueTCc7fkU6lQfpetdiRTqF7NTTT/8M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(33716001)(478600001)(38100700002)(86362001)(33656002)(6512007)(9686003)(6486002)(6666004)(44832011)(53546011)(186003)(1076003)(26005)(6506007)(8936002)(8676002)(7416002)(5660300002)(4326008)(66556008)(66476007)(6916009)(66946007)(2906002)(54906003)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LYRSJWTCKxrLJ0KyAcvwyopKG9P0xSBRdeNbsy9RSbhZZYqUFPEx4SxDQhBB?=
 =?us-ascii?Q?RrbX8gMa4z/EkdcOxFWEE1FyME3UaVVbiR06VBbA3jBd1mYXDz/I7R/Wx69H?=
 =?us-ascii?Q?0xhROjQ4u1IrF1e7vmOqEmsJ8yb9r40X53qQVypc/T+dHw+tdiNJ9slxC7Qn?=
 =?us-ascii?Q?/37NXvBe3Itf5RfGwewBB2D0H0yh/AkSV4u3SrCGCcSIyfaeE83u9zyiJUc9?=
 =?us-ascii?Q?jJT5c5BWkxw4Rr+n7w8q2dIydfoiy3ZkCB4dBxgaIY+uIIaNdLYHbv7wxM8N?=
 =?us-ascii?Q?Vf9LXTYIb+swISsRlv2TUKDAlsHCut8o4vvMDh4MTHo/e+kWz90Af5W5Y6aD?=
 =?us-ascii?Q?rfRH4w3yefPZYf+98Y7VhdxK/l3oefZV89OPIXtrxEaLPuTxhuYT32xxL0rg?=
 =?us-ascii?Q?qtKuvJzyHVqNSVg3AaSlHw+JGNQEnJf1Wm31lvPNMGa1FXG+Hc4ZRGtXyoaR?=
 =?us-ascii?Q?heZS4ANGgCXoChWslI63I54kdwoHLseA1HuK//rDsRmvwPbzKu1yiBVdw/34?=
 =?us-ascii?Q?L5S4vGWYQn+oLYK2Yeu7npKKqV7bYJ01rSgrwwfqHSoWndkjJQ2NrKvrEADK?=
 =?us-ascii?Q?vJs28lvpW0knOZrR85C4xGC2DBMakeTpffeqRz38EE8oZWav3uG5g96ifzSz?=
 =?us-ascii?Q?Nt06dCyB3v33LpQYeHfzexkVkNGKflzoYa0Pmr1GYUprmdjPoXAkZVeTG6Zb?=
 =?us-ascii?Q?mrVAv/IjN/fNFq8ANb/k3nLVxfViEvoNRlcugYBLMDzhjlMN93JcLkbttnCz?=
 =?us-ascii?Q?+NOO2ghhN5fR8vxPLhcHzBBdxTcgTpgUs8g41JWbhhYzc1qJxhSwYelK1Qd3?=
 =?us-ascii?Q?nUjN7oFFvGwszHBE+lmer5FY2m5Fw8Feul86s+sL+KY2W67uPy/qtDVgQCES?=
 =?us-ascii?Q?GF6U+RLPwHEHC+6/OEgAXcGZd32rc8htBhFmcSV/ZSf3VYJ/XZzd3yrAUgFC?=
 =?us-ascii?Q?4L2dhO96QW1B2UahiDntgbM6zA51wzjKgxEzlqfHNVcTINl3IwcNHqNaFv2L?=
 =?us-ascii?Q?Ub9C+1bh2I9Pc4gsLSRDCa0FFMF97GsP/YZnif5QCwBFXV/g7+rjTbtO2nWt?=
 =?us-ascii?Q?NHzV/OwuJ5JlwI2vYP8OJkHT0khyc4q8PRhtb9+QrKFXZH3lEHdn0J5Ei8hO?=
 =?us-ascii?Q?zoZlyRHuPHoollIntor54WiEU3t4lu21opN/Uz1OYNz9zC9HxtRSO+7TYkt+?=
 =?us-ascii?Q?73Fzf0pZT++3tXKT93fbSHTAQklU2Du0lFkVwUIOCAvRBUv988HPNDhou5dX?=
 =?us-ascii?Q?Nrlr6TQjflJMfeR5FPBGiMoHUQez618obghP3lvEFxMKDp41Y2RAnxwZtgh0?=
 =?us-ascii?Q?WXo7OyA0E3cYWZ7bSM2yfM96CaTfUvesKmr78ziLE7cdHS3NExBTWhLodo6H?=
 =?us-ascii?Q?64GgbUTkQrcMca3k8dSFtP3gKIcp1hZa8emM/ogB7R1MuPitxVcq0qEtRt+U?=
 =?us-ascii?Q?iCbkwK88fCrj8ApZ5MGhLs4Pop3SCza4ix6IygSFvyfy8ODRepfrF4RD8V8x?=
 =?us-ascii?Q?AQ+zqdOjZ7ErJ2+U6UPJ55n/1WxJXKaxtOxv5fRDFwwf++G/n2bATRMFZUaK?=
 =?us-ascii?Q?R3TPHPipoNR+Vw2vAiyJ+3gaK1bScaZfdGziD+LZlaVKc0a+TPmPHk1muo60?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GaW9+87hkWDum6NniDfHQrG3fnqJ/v4l9tdW8E6oZab1NQmO6WzVJ6L7nPxd?=
 =?us-ascii?Q?M5I7CaPtXeCewi1MPKc+46UDBuASErmjXIagAP6rvMrJxvUTBTV+JIvJBp6D?=
 =?us-ascii?Q?poriYibCXq6dW9qtIjy3Eq+r1OwRd0ZFEI+H6ykvH4A9crTJ0yatTCe7hfcW?=
 =?us-ascii?Q?/xif4gV25VTAwFgei0qTKSTg9XdjJP23Tu0OCzCK0hNskG8NXESWthDmlpUq?=
 =?us-ascii?Q?K6gdR2B45IN/R3hXXD5S6og3FatMUefivWSsqefhBPcSo0WEKGPHGQrvr9Ad?=
 =?us-ascii?Q?rDLZwuCqSby544YPqF/35Qd0MPMpV4ktxwxC0mHzkwA1KSAQIjqoNql+Wxgv?=
 =?us-ascii?Q?0khKKySHDLLFkLTHTJsUhu2MUtZeXF2e5RZNuBAu3bHx1cd+RZ1yM8/DnJSz?=
 =?us-ascii?Q?UYB4bfMPf5pW+CboBrXvoZ5x4s5aihCSezTt0ePd397vF2rFt7kRHJWTMuRv?=
 =?us-ascii?Q?GzcxR9l+BafMaHLPuOaE4ghS4cKMtW93dP6QS6g9HKIzV1X6X1/X0wokjfaw?=
 =?us-ascii?Q?q9b3R1E89DbpfNoz69zXrbGscKmo7qM+ge59KPmhrq7KQ7xRZggASdQO4Myt?=
 =?us-ascii?Q?EevmeCCHo8vae2IdyyXkrO9BgJNK6x49ZgmbEn0tToeO/Cq7a3mauWLEQaZ2?=
 =?us-ascii?Q?LOXB1DjYik+jbcMsBZ6ndmJ6ppay6Ew1TAy9M1teyLGlxh8EBSf52ksrBjva?=
 =?us-ascii?Q?egU6lg+7ixfzMBqObwGW/am8aCNQI4eCQSrxFZS8xVgBg4/xyX9y/Hm048FW?=
 =?us-ascii?Q?mAyYsFGQyNZOu/OFpEK5miwfWIUeTegPPcrm8Ul7dGDMQruovt9Twi5djas8?=
 =?us-ascii?Q?+ZikmV8DQS0dzwKz6syxhAnBouh0yrM1MUgyk3kWjyTT3AG7ULs0vOWOr12j?=
 =?us-ascii?Q?WWilB8w6KfoUifKLAinprHHirt7nL1XQzLdTIxmjDONGmpqfq/9gweBCuzum?=
 =?us-ascii?Q?Bj1moO49DkecUxcxqpz3GGxq2tH3lPS1bp3AKRovCIO15yspOS0l8OUp6Xxe?=
 =?us-ascii?Q?R3WMR6AVnhjjBUkoqcahFjsCUU/sRKhsFVNwmvV3T07Idzo4eBOyoK6St4iB?=
 =?us-ascii?Q?KLgOY+u8JHsYevUNn/xRng3pegqit+onCdF0dzlW6A7PI7WXo5O5XvbFKKuL?=
 =?us-ascii?Q?75Po2xPzt8TU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c0c2fb-8854-4d11-62ad-08db921f86cb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 23:40:30.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkG/Cxh5+h6+ZARXqoO1cFLAEc8tmND/YFjAaNI/ELfRKyUsIRiqVtTkUHG4rtFSlIGtP3L5HXbtRM9dZHUMlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_16,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310214
X-Proofpoint-ORIG-GUID: W-gJSwv1kAvgpmxZAGhbAG7J9RcZ6nvF
X-Proofpoint-GUID: W-gJSwv1kAvgpmxZAGhbAG7J9RcZ6nvF
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/23 15:48, Kefeng Wang wrote:
> Archs may need to do special things when flushing hugepage tlb,
> so use the more applicable flush_hugetlb_tlb_range() instead of
> flush_tlb_range().
> 
> Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Although, I missed this in 550a7d60bd5e :(

Looks like only powerpc provides an arch specific flush_hugetlb_tlb_range
today.
-- 
Mike Kravetz

> ---
>  mm/hugetlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 64a3239b6407..ac876bfba340 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5281,9 +5281,9 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  	}
>  
>  	if (shared_pmd)
> -		flush_tlb_range(vma, range.start, range.end);
> +		flush_hugetlb_tlb_range(vma, range.start, range.end);
>  	else
> -		flush_tlb_range(vma, old_end - len, old_end);
> +		flush_hugetlb_tlb_range(vma, old_end - len, old_end);
>  	mmu_notifier_invalidate_range_end(&range);
>  	i_mmap_unlock_write(mapping);
>  	hugetlb_vma_unlock_write(vma);
> -- 
> 2.41.0
> 
