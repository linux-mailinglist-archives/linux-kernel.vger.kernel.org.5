Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34CF752624
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjGMPIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGMPHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:07:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C10E4F;
        Thu, 13 Jul 2023 08:07:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DEJGcP029232;
        Thu, 13 Jul 2023 15:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1BkcxBVRb6l0A8UihkteW1qUDg63bzAYO3+8h/hUNsM=;
 b=je+BKg97BwoAWPq0tblVmoIzuFEHLiUdJ+yn4Ygt36Khgrgd+oG6+L7PaZXstCyWAnfL
 5wtQieTGJBKuJyslNC98qOKDw8wekgnPorhtSqdJQyfNE/tWwfUdwJ373ERwfHOCrPip
 7lRhdbNIkFBngxQvcTbCnHapH1UlBpJKZvVVhjGXMKVm6HLNqmh28X8S6ZuqJJz8UPlf
 Kiu+O/uBWB+FsMG+aPXDyYFtPRcJ147B7cwXc0MtH2EBQR/7nXGNPpWanXsk3tv+G1y9
 CMyxe9tssjoDWA/dbacX1aQgMBFPPgqSppslyvr7g4Ssk80b6dmSIsF1pAMhhk28oibO ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj67np3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 15:07:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36DEKxDm033393;
        Thu, 13 Jul 2023 15:07:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx890d6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 15:07:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEIFrF4y9VtKG16auKEpgKkQb0bJSDU8ovHpqfIuVQ1iIgFZIbCg/dKyKqRZovKL9Wplu6wljKtAX7l1xjAaAv6hF9uSBtWrmcSwQTsLGKQNHkSicMiJSvRLe8fATA9cVR/335R5nFRS4cmBqemKzURTO+q2/z5x19j3y9ESMu0OTBqICsKo4KerGna4q+pI8u5ZhA5x6xyjNn3BzFKXE67alOn/eBsY/K5Ikp9n1lHGvd7tIMljQbGY0XFiOd/sDH3hA1QMpPbh2jMGzIR8Rb0Se0BqqoeNuk9+uPLunTxKPvaZurGnwpkMC5+CSXYgE5/aNCaPxKY498/Wrl2TLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BkcxBVRb6l0A8UihkteW1qUDg63bzAYO3+8h/hUNsM=;
 b=IQIm9/0f1eVZrAGpkGgQdLzCAL+g2pZIHjbv6oA+NjBGuNihnF8WgoC2QulcvL8Gb/7Zo/Ka3KUBx+lGGe7gQMirx6zQAWYvYQJf49A2+TT/AkP5jrpJC8J2T/qDsTYjYRoNBZ28cfioUxnEQRubMvAVzFxwa+84mORj2ot9iBcyMFDI9DAOs6ycTE/m3YltgLkVa8mFvqt+Cm3nGFXj+hek8bwtk4ulzpHJUReUR6Yf3vdbfm+6XtsN8LF3ifw+VH3+rshOyPdPjWO2pxE5/bgOp1ODwrMW3tJuQqEbJ5hiCGDYc5K+3zCZXMl7W7m0nSZQtHd1J7GctVV0C+KJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BkcxBVRb6l0A8UihkteW1qUDg63bzAYO3+8h/hUNsM=;
 b=JwpiztXmLv3WrTSU4Cwnsb4IH2dxRrGSvV+jnCvCA3Vu2EiwDl0naHbpD4pfCA5FZoTEEWTgMCovmFOwH8kzeFOU0RBetpaFQnVLd14cSEJpcTI9aDbsjXfGNp6XV43482QtNIxeYJwnMiM0qbOsjZTkvw0Y+0wURcYdFXa6PiA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB5966.namprd10.prod.outlook.com (2603:10b6:8:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 15:06:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 15:06:58 +0000
Message-ID: <297ddf04-9b35-7613-8efd-2857668b6835@oracle.com>
Date:   Thu, 13 Jul 2023 16:06:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com>
 <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
 <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com>
 <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
 <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com>
 <CAP-5=fX+rz928LtFs2MWYUH=6Mcvz0XQcLRkO-n9BnVnX4RYWw@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fX+rz928LtFs2MWYUH=6Mcvz0XQcLRkO-n9BnVnX4RYWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 95acd7ed-ef42-4943-dce8-08db83b2cd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ys1xm03Fu5pWqrXCUKxOfd7/+U9G1Eq0bOJptE924UfUWF1j8lThvHvzRrpVTSdFCzNEsCwSGKcprpv401WMcVkqWiVCH4r8svBgmBbC3oXE2Y2OVPreGwEoQID29lSW1imx2ERh0c11Y3yOmw4BpPxZmrywwwMi0iydKeq5UvzEADflTk1FgcVdBJRRynixx812pBdJ6ytsvzUu+K7CgnFC48saeV+YODxa5MgliL0bNLiktbabrxlPZRit9iHafmIQnDQBRDbgQG53cBdt3cZUfM8FIhD835f4o8SRRYydBRpg8M28StuS8r9tzvKaHFLo7gg98ww2iXxkgobw9AuBN5atRXKcblv0tC1TncRL9bY/JlttDrB02gLzgfxVMJ72BttKq9DEIEs+9mMIfARnREKv2D4RjLWJVzEwfgdHAQiYrzvjbvBzNmMpd6wOjdhJhHIAwXD7WZqYPHyGkjTveVdTBVAqo67wShaf4lAuqR5F2s39ea/q1wfTvEpMleShDqlBrGeGe6nHpPZCLTpCn2jW9WGcAog4I0nThd7UJe1Rrfi/E/iSTKZBCPxkUrjaXZjneGLfF4YCnKfIQK5cXVMkqH7VwCqSu8rz8l7u3DR141swyhyChRvup2ON9SVe1QhYnUycJOgupShGmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(83380400001)(2906002)(2616005)(66476007)(6486002)(4326008)(66556008)(66946007)(316002)(36916002)(6916009)(478600001)(6666004)(26005)(6506007)(186003)(5660300002)(53546011)(7416002)(8676002)(41300700001)(8936002)(6512007)(38100700002)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RCtqdVpySUtCbmRSZ0ExODJmSFZLMWt2VldhOFNEVW5xdkducW5GU1J3Rkwz?=
 =?utf-8?B?enprOURENUFxNFZKWCtYc1FmQUFUaE5yR0xHQ0puajltQmYwOXA3cG9IMVRK?=
 =?utf-8?B?TmZxZDJ5Z0hrWGRCcUMxR0xXZHd1TmVXWFZQN2dzUVQxT01QU1c4L1dQWEdx?=
 =?utf-8?B?a3lUOHRPVlU3a1FKUUhZZFBMS3pPMVBaeDZKYXRqR0FqbGNQcWNpQllFaktG?=
 =?utf-8?B?eTZ3OWNRV0tsNzV6UHJEU3QrcjExUnMzK1JidUlQRnMxbTZhMEVNTDdCN2Zp?=
 =?utf-8?B?b2kxNlRqOTE1L1FUNXFGeWxCK2lVNUtxdEVSWUg2RW5Bd3U0Nm5yZThSWUVX?=
 =?utf-8?B?V05TdjRoZVRLNmNjeDlLeGxDSkJTaDR6RDQrbTZDZGxPRGlpM1htREJza3Z2?=
 =?utf-8?B?Q0dDNzRTOE1MVm5vcGNDMVlsRVROR2NseVluM3c1ek1ROStYeHBHNjhUNFdI?=
 =?utf-8?B?SFhwcmhmNUFsS1hkdWpPVGpwTTkyc2xjRlYzbzZTZ1M1WGRvb0ROajVBRWY2?=
 =?utf-8?B?YnUwSHV1QXZIZHl0cVlsdW51U29NeGltVC9IVGFxLytBSzJvck5ob1I3M0Rz?=
 =?utf-8?B?dnlUYVo2SGxMQjVZTjNZaWl0NGcyUEVITDM0K1pDYkVDeDJwSEhiekVZQk5u?=
 =?utf-8?B?VkJqelhHVFY5cEpBdTJUcmdMVENTeHZ1cDhxTDQzOUlid25rMjFRNWxHWjJn?=
 =?utf-8?B?UkJndmxLd0RvSjJtVjFoZHdQSDB2ajZrSEJ1bmgvNlBIdGNteWZySzFma3pU?=
 =?utf-8?B?VWNab1Rvdy9WQjZmUVhLTXc3b3pBcmlXSkFSRUJ5SzdnNGlOQ1NZL0dJQjE3?=
 =?utf-8?B?ek5YdUZOeXlzUmdZbWZHY1VqNlhTalp3RlAxZW4wL1h0SnJRWGR5OHdnZTRw?=
 =?utf-8?B?T0NwQkorLzl6ZXhHL3dzbDFoK1lVbXFVdUxDVEVabEVyOWlBcmJ5dUgrNWta?=
 =?utf-8?B?eDl1eElEN2xhcThYeFZUbDNoS3RvMStmTFRTeFdZclUxQVk5Y3ZvRVRNbUVD?=
 =?utf-8?B?YTkxU21YelhyeEVSK2hIQ3JGSEdxeUE0dHNlbVhudUZ4NUs0cWkzQ2ZkUnQ5?=
 =?utf-8?B?WGhIM2VqL254Ti8rK0F6clRZMlgzQ3l0VExrZTZRNmJ5bUdvelg0ekFmQUQ5?=
 =?utf-8?B?RERFOTFqa3p2aGFDeVRjOGlPUURsR2w3YnlkSzBxeVRBU1VmSngzQ0VGTUQ2?=
 =?utf-8?B?eDVNaHFUbElqbmc0UkZJK0MxYlc4KzJDVktuaDdxTG9wOGN6ei9raFVxY2hQ?=
 =?utf-8?B?ZXllbEFmRFN3R3FqRVpBK0dCY3MxVWtUU25NMHErVlQ1QWkyK3pkOUo4SWZG?=
 =?utf-8?B?OThUMjJoc2RML2xtVFJPa0VyWGowS2xFYVF1aWdSRWlDZGtONjlwaUtXbERO?=
 =?utf-8?B?RzhzdHVqNkRuR0Ztd2tRL1JHdGh3ajVjK3BVZ0dSZGs2T1A0QTloZUM5SUtY?=
 =?utf-8?B?RWtmTUZWdkhZZHZsWkxzajBZVVE4enlObm1BOGpUNWY4NzFHMmNJTG0yem9Z?=
 =?utf-8?B?dTVnR3ptUkFDVW9KZDlNSXpSWXpZbkI4b2lINjFWeG1vYWYzVUZrK2tQblJa?=
 =?utf-8?B?QW5KankzWkRhTkorNWxCSWROTkRJcEQ4c25vOHVOa1BIM0dNK0lERURzVlVk?=
 =?utf-8?B?Y1c3K0hJMkkzQ2pOZ1RmVzZaZEwveThxaCtVbEhWWU9zZW5RYktUS2RHUCta?=
 =?utf-8?B?ZmEzcTg1UUZnUmJyOGhjYkxMbkxFZXVydkx6WjBNQ09jTkE0c09Xb1Z6YnZZ?=
 =?utf-8?B?YlhaeldseTNFOEVaODBlRnNJaVNrQkJ2OEJmTUxKVDNQSzBzS2xPQmo1MDdT?=
 =?utf-8?B?VXlLbHN4SjVRYW1WdHl2UUh3c0ZTNkxHeEFVMnBJdEM1OHgxVDJ2T2gzZmpk?=
 =?utf-8?B?eCtrUS9WWU9xMUdPcWdFSnRMVWlJUTl1T2czK0VGc0VTWERDZ2dUNzJWNjlJ?=
 =?utf-8?B?NWxIWkw4REI5ZjB6UVlXWkNNeERTb1pDb1RqMjhJNSt3czZFR3Y4VmdiTzAv?=
 =?utf-8?B?ZlI2MXBkYkhwbktBbngyWWx0c1B1WUppSk1KcG13djYwNjFHZmFHVzdwTFBz?=
 =?utf-8?B?TkF1bUpsWFdwVDgycGpRZGozb2NtME9JYk9Ub0hLTlBwRnpjdjZJWmwrU0g4?=
 =?utf-8?Q?4mfky49NkqUbaNfmzum3WYIf8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Ni9kbU5Dd01kRHJxWklpQnRRRkFTWHBwT1JhdkJJNUdRcnlVblBJc1p0NE5G?=
 =?utf-8?B?U3FnWG9OMjFpdUdYWlA3VDRRd3JBaGVoOFhzalIxYkZvNGdmL29PeE1aYzNW?=
 =?utf-8?B?L3ZhSXY2elBBTENGR2ZBRWoyMi9BNGRyMzBiYXdRcHV2dklWbTVyTlBHNjN5?=
 =?utf-8?B?cVZtamwrYk9vU055NmVWbC9ReWlRMzhsU1RXRVpPU0RhODhPUXY0aytQQUFM?=
 =?utf-8?B?Wi9hbmgxNzFDUXkxWWtCWG9XUGg3WWFEcGtyRHBtRXVLTENlUGVVOEhGSC9a?=
 =?utf-8?B?cnNwUmZaa3ZmSm96N0MwU1MrZ3lIQzZQcTFZc1VGTGJkdDM3OWRiSEhaSXg4?=
 =?utf-8?B?WHcveGQ3RUFpZGwyTWlDK2NqdzRDTW95SU5BOGd4MENRUjg2b1oyV3RpSHhF?=
 =?utf-8?B?OVBaTEg1eUxxd1RHZHhTdDEvdVJhVDJDSE9uZFUvZ21SdE1peXVIRXF3NzYr?=
 =?utf-8?B?VCtzc1hLVTBkUU5ERzBYRzZvUUpRY3dVMndmVzBnMjhNS3ZxRkR5M1JiSUZ4?=
 =?utf-8?B?cTlJWm1JWmhMS1Z6bmpoZHc5Q1N4eG5SUHU0U3o1Qko3U3NEc0h6dHFnbTJN?=
 =?utf-8?B?S2hkdkRBaWl1Y25yc3MreHk0QnRrbElqcnl3RG9DTmprY0JEU3VXQkVoSkZF?=
 =?utf-8?B?d29aclNZanBZb1pXY2cwS21BQzJISE5KcXFOZzlxaERSWTd5alY3OTRldnpx?=
 =?utf-8?B?UndkOWczMGsxc2c5NmhONHRBeXJnMmkwajZacGRPZ25JWkhINjk2VjdrR25h?=
 =?utf-8?B?Q1FyVWZLSDJIVnJCK2Q5Z1d6bGFrMGwvYVhXdlFvT0ZFZWRxUVQxSHhVeHJq?=
 =?utf-8?B?MnNyaFF1bnFRNHhLaDhvOTV4OUFHbTYzUmtQZzJHUDJtWHFzOGdQVlhzUnRU?=
 =?utf-8?B?QXR5cDl1eWFiSUROZG9VYmJlK1M3YndDMytnNUhmNC9WZFhMcGFWRmkxR1oy?=
 =?utf-8?B?RTlFcTBBSGFsb1N6QU1HRCtSWHkwaXpJeEk5SUxkbU5RYlYyQWFsVExKWlVK?=
 =?utf-8?B?NGdZUlNJSXI3UDlQWWhvZDlNZlJMNy9qTlB2Q01PQk5rUnhET0c3VlMzQWIv?=
 =?utf-8?B?U05YeW5uZjF1SkY5RXB0Z1hHclFwTTNSeHE5SjJESW45akJqNG9icnMwdHlm?=
 =?utf-8?B?ZE1uUEJHTzRqR0RMTmUxN2VNSzVnQ2N3Y2ZoZVZiMG9ua1dKSzA5eEY0NWNH?=
 =?utf-8?B?MGhZOXgrb1lwUzRGY05xeENtNUs4Rk9aN3BZM0lrT0Vma1VnSDlQdU5nK2lk?=
 =?utf-8?B?eGFmTGNTdHp5dUdjQlZ1Q0V6WWY5Rjlscm01VWdlOC9YdFBxN1dla3JHTVRm?=
 =?utf-8?B?ZEdFZUlyZ241L2MzKzJ1cHVjNS9tWEl1YVQxbGJ2K2NTN0pIL1cweXhFY1hq?=
 =?utf-8?B?b25KV3ZrcVJQWXc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95acd7ed-ef42-4943-dce8-08db83b2cd94
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 15:06:58.2652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkLiKitpxUeA234wPjoMJ46DBFke2gL1JRM/V3sjTReKwZ7IxDpVA++2C4MgONtK0E9Lz/rr0tArDnqp0rKSOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130132
X-Proofpoint-GUID: KKsgy0KhsznAdAuWnUCAjQHRsvmIn3r1
X-Proofpoint-ORIG-GUID: KKsgy0KhsznAdAuWnUCAjQHRsvmIn3r1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 18:52, Ian Rogers wrote:
>> To be crystal clear, when you say ">1 PMU", do you mean ">1 PMU instance
>> of the same type" or ">1 PMU type"?
> So I'm meaning that if you have a MetricExpr where the events are from
>> 1 PMU, for example memory bandwidth coming from uncore PMUs and then
> instructions from a core PMU, and you do something like a ratio
> between these two.
> 
>>    in a metric wouldn't work though as it would
>>> appear the event was missing. Having the metric specify the PMU avoids
>>> these problems, but is verbose.
>> The message I'm getting - correct me if I am wrong - is that you would
>> still prefer the PMU specified per event in metric expr, right? We don't
>> do that exactly for sys PMU metrics today - we specify "Unit" instead, like:
>>
>> MetricExpr: "sys_pmu_bar_event_foo1 + sys_pmu_bar_event_foo2"
>> Compat: "baz"
>> Unit:"sys_pmu_bar"
>>
>> And so you prefer something like the following, right?
>> MetricExpr: "sys_pmu_foo@bar1@ + sys_pmu_foo@bar2@"
>>
>> If so, I think that is ok - I just want to get rid of Unit and Compat.
> I think we're agreeing 😄 

Ok, fine. I need to check on implementing support for that.

Then would you have any idea for testing here?

What I do is to ensure that if we 2x tables like following for separate 
SoCs:

soc_a.json


{
		"MetricExpr": "pmu_unit@event_foo@ * pmu_unit@event_bar@ * 1",
		"MetricName": "metric_baz",
},
{
		"EventCode": "0x84",
		"EventName": "event_foo ",
		"Compat": "0x00000030",
		"Unit": "pmu_unit"
},
{
		"EventCode": "0x85",
		"EventName": "event_bar ",
		"Compat": "0x00000030",
		"Unit": "pmu_unit"
},



soc_b.json


{
		"MetricExpr": "pmu_unit@event_foo@ * pmu_unit@event_bar@ * 2",
		"MetricName": "metric_baz",
},
{
		"EventCode": "0x84",
		"EventName": "event_foo ",
		"Compat": "0x00000040",
		"Unit": "pmu_unit"
},
{
		"EventCode": "0x85",
		"EventName": "event_bar ",
		"Compat": "0x00000040",
		"Unit": "pmu_unit"
},

And we have a pmu with name and hw id matching "pmu_unit" and 
"0x00000040" present, that we select metric metric_baz for soc_b

>I think Unit may be useful, say on Intel
> hybrid I want the tma_fround_bound metric on just cpu_atom. Currently
> the use of Unit is messy for metrics, ie uncore metrics are associated
> with core PMUs, and what to do with a MetricExpr with >1 PMU. I think
> we're learning from trying. I'm just hoping the migration to a sysfs
> style layout will still be possible, as I can see lots of upside in
> terms of testing, 1 approach, etc.

Do you have an RFC or something for this "sysfs style layout"? I think 
that it would be easier for me to understand your idea by seeing the SW.

Thanks,
John
