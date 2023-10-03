Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA65A7B7181
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjJCTEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJCTEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:04:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97908AB;
        Tue,  3 Oct 2023 12:04:33 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4eRd008521;
        Tue, 3 Oct 2023 19:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=U7b8MQd7frP5UZt4hLkeBowSQEAsEeZ5NuYzAt9Bl5Q=;
 b=Md0pZu+aKULjPYCQmoNqUjr1w8IKfywmaoiPW2noeoQPKUuKmMQLr8MuuwDT4YYJQY5N
 S+eXnwvibKhXD/tO+ZmKbPiwKiAz4c0VYpYaKa4i13GC8sGLLjK6R89pfOMsYwBddQDa
 YAw7R8opxgEAs2NzEWZpmX4dLwBLZNt4/idXQGUiTRzNQ/Gmhb0vsKGlFs0wqXQoH1Vg
 Xbg3ndf0X0Xl/8+Nxgsy0mNtdS6+atQydnHM1hl2vHnl4FB2fccrstlJiNSsT3+6xiMu
 VjD3BRajC8L1xDV50YbGWq3l4I6bHJxxKpL4e0OMss5vPtdXEzhLbrZbX1LwVZUAPDIP rQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakcdjph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 19:04:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393I83F5002931;
        Tue, 3 Oct 2023 19:04:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46fw0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 19:04:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzZl0ek+MyQz4k++NZDxYJPlC3uwSbf7IwPmQShT3Zd4D1CaqiwlDd748lcxzu7186xdozmAmimS3EC0K0Nmpl/yeJufMh71k2jPjirTGZtq/h6NP7zM0zL61pipbehpwmZ7B0r4Oudcq05cZ3wQkHXjTWy/JLuQb9MKxaTKAUO1ilV4gwEbC4Qd00t9unIdDmvMi3LMEMkD+umruOYnFFDAah3AoFkVVzSLUqM7mA0RSPxW59D/d21roVe/b6NWB/Y6Kb1mRW4dh7GHifs/4NI/l8aD5T7RFSonOahe2CFk0UWieGAURKDuEd6COpltd4H7rxnAEYd6DmC0zPPtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7b8MQd7frP5UZt4hLkeBowSQEAsEeZ5NuYzAt9Bl5Q=;
 b=QG/IFwe84r0IydKl1bH3snD+fqoYKD1Hut82R2n8bL1Lc37ofLWBgyyDkzvFd49nVk247vKvc3O+Uo/+uCVLKLsMCZddk6x6l8c7asyZosw6fuzylL/BKAOBIjfgyikZpvSoltyQRjf2sSCeRC0XmI0pkNz3cAJjoyND3Ny+BzSMjjBl/v+b0njFAWlYR/QkQodaee7EJKNpa2+3gThK3hmeyohtxtTwrIDGcH2E62ics5tPNw+Q/8lJnHdSDu7d23yJJny8vxYv+g8nEl2E56m24l/FJvuZSrxkIC2yJhcjoTxrEa4jsTDQxnIzwjKPvsWgF7hMrSPSIOQofxSWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7b8MQd7frP5UZt4hLkeBowSQEAsEeZ5NuYzAt9Bl5Q=;
 b=lLJ1omw+AhCReJZ3xJ9VNOGF5AJdWXy2Xk5Sumtb4/wns7iDJ1mHhq8HsSLxezAGuc82logUU6zwL8HsUMcHEVDIMFQ3hUznU02tztj565rgvxKm10W3r0btlNwMBTTkuSMz+dmjDrcbxPyGj/1RsSuFw8rWesKicFaCeA9BIJs=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 3 Oct
 2023 19:04:10 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::134:c770:8cb6:70e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::134:c770:8cb6:70e%4]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 19:04:10 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Denis Glazkov <d.glazkov@omp.ru>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v3] certs: Add option to disallow non-CA certificates in
 secondary trusted keying
Thread-Topic: [PATCH v3] certs: Add option to disallow non-CA certificates in
 secondary trusted keying
Thread-Index: AQHZ9R3HhgzwMaCRt0+XGJxT4C8227A3LAuAgAFCgIA=
Date:   Tue, 3 Oct 2023 19:04:09 +0000
Message-ID: <4A271804-9481-4454-A371-3A7CA26F40D9@oracle.com>
References: <CVS5MB3X82Q8.8KDB4346ROR5@suppilovahvero>
 <20231002104525.7631-1-d.glazkov@omp.ru>
 <CVYCTWRQAXDF.2HY5028ZT9FEC@seitikki>
In-Reply-To: <CVYCTWRQAXDF.2HY5028ZT9FEC@seitikki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SA2PR10MB4665:EE_
x-ms-office365-filtering-correlation-id: 9e546f81-e823-4cdb-8f47-08dbc4438667
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BAEX/Qb/wa4cMY8bfm1byb9vwAaDpJflPU4H/O1kuAR6wHYpg/VAP1i9OGD+0HYxWBNARNKl/Q6ADTbiPH1KPR9Etfjgc5tKXWuAb1Zdhp8JnVSLSil595G2OutEG5QLm/LhwWwYtNH4mPflWIfGiO0DsbfixIiobxH5Nc/7eWot/eJLZSMSDynMUGCyH7xMUH/V2ZOxLCtULJOGYutNW5upfrCSZjXQKl9B7ciwBvs7ya9Jog71j42mrb7ZmKOOsyeKwWqxPyK0cG97Ld9t451hmqlhfVjLuBkmN6JE9SnWPWsO+IIquJNg6zyPO7YV/hKLSDbazEcTyolJ2cOhFvwVtcOltYaYwJy5Sfjy9c9Xa+ZIxRl/ZPYHoC33XjQVLx2Fx5K4HCgYFHa7IFtBLTY/Oxb5e3wDcZ7K8c+XtEgJga2s4dIgKEeRLkRr1KH+APwQCnr1XPVj028i63Q4TOdBHgyxTTxMyplioy0J3oYyh1CFWWugfXywgMSKM8k7y7I4BEirL8iZXse0SpfE9o2pp7p9aFsUq5vsBQ7Z8ivouz3Xps/w1CZKI3BJawVbu0uS9U4UElBWEWEW2rfgzO22cx5kQiIKDomHW5L42KnU6fTOfBMDMNvkQuIMEru4eGljngWd1HTvEuRn4f2sYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(53546011)(966005)(478600001)(6486002)(6512007)(6506007)(2616005)(41300700001)(2906002)(91956017)(26005)(83380400001)(71200400001)(54906003)(86362001)(6916009)(66476007)(64756008)(8936002)(66556008)(66446008)(4326008)(66946007)(44832011)(5660300002)(8676002)(36756003)(316002)(76116006)(38070700005)(122000001)(38100700002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUQ2NEx2djdFbElRelozaDhtUnFhdklva2dIVXc4cTdSVzZjTlhQa2ZrMmlO?=
 =?utf-8?B?NHd4eE5zd1ZOMjRPYzlTbXI3dk00UmhwMFhrd2NEc3gyZ3JJRk1MSHpjRGxC?=
 =?utf-8?B?YVI4WnpBWTRobHNSYWhJRkVrQUdPYVMwRmZGL2tvNnY5Qjhtb2Z6aExjR0lQ?=
 =?utf-8?B?Y1hTVWo3U0k1WFFMTnlTaFc2ZkppM1cyd0NqVlZjcEFjOTBXWEwrdzZ4M1VJ?=
 =?utf-8?B?L2dsVjF3NXFQRWZzYUgwRlBQSVZsVmoxaVpKcVdDTFZUSitaYjN5ZnpHQmR5?=
 =?utf-8?B?aGV4Y1JtcDMzSDg0cUVCOHIrc3hjbE9DN3R0V09yeXZITDhHSEhLYURTT09w?=
 =?utf-8?B?cnk0b2tveVFDY0lKNEV4ZlZNcUtWL3NJK0UwTk9aeWJNczhUOVg3ZTVUZys4?=
 =?utf-8?B?YUtObzc4WjdJOUFLa0RWdm9TZ0UrSWNZUkpmQUl2UVIwREtxc3JQRi9VT3JS?=
 =?utf-8?B?aGtTOW1WN09PZjlDZ3VIZ0R0Mlg3SnNOSXdmcFZWZ1F2b0pGdHFDUWdobnMz?=
 =?utf-8?B?cVJyL1FDNXg4YjhBNDEzUVUwa3EwM3BXNWZocVJkWmRzdUJRZlNZRWhKRnJJ?=
 =?utf-8?B?YTV0Z0crWWozUGp5S2hLeXVzN3pub2VPWHdPcmJ0S012VDNrVGZGa1pqSWtj?=
 =?utf-8?B?azVkWE5XWkZieEtBdXUxYnVqS3ZZa1c2N0NmK28rRWgxbGpwMSt0Ynp1Q2Zh?=
 =?utf-8?B?Z1pHMHMveVNFVlJLa1N5M1Fad2xxem1mVDVBUG5WVno0UEt0VE5IU09QNWcx?=
 =?utf-8?B?WmdNeWEwTGVCS0JHeFdtZC9TNnI5cEw1dlV4UUxjbDYvd3VHMkpKQ1BBS1l2?=
 =?utf-8?B?MGIzMlN2Vm1lSEQ3YXRsRlc3bitBRDBJUStHWnc0dXJ3TDZ4K1BsMjViL0h3?=
 =?utf-8?B?YWowTEJHVmdzSzVBQ3U0bEdsalpwOURvVmltcGxkR2E0VDZjK3lhUzdxb1RS?=
 =?utf-8?B?RWF6TEUza24yTDBoWmI4Z1N0QkwxcEZCQjN2T3JtYW1VU1FIeHJ0Z1dLMnN1?=
 =?utf-8?B?ekFFQmxBN3RORUt2amVBd0pwYjd3Y2VLUTBuNlhwc1NUVnJwS1RTU0JWU25m?=
 =?utf-8?B?Y3I4Q1FUdDA0S0l2aW9OQUVFVTBYajBZYjFqUEFOL096ZXZKcjVtR0hKa3BB?=
 =?utf-8?B?VWIzTk5XT1VDVzZPTlY3bmJ6T1ZMZysvUTZVMm0wcGg2QXJodFZhaUsxcmVY?=
 =?utf-8?B?VUhXSVZ6azVEVlBFbEkyMGhZV0JYQUJ6NGpVRGxCNEZiS1FoMG9DUUhvRGJ1?=
 =?utf-8?B?dnlVM1NDRjQ5c0l6Zys4RFdiUlpwTVhITjRMUU40ZFBWYUhpRm8vbm0zQ0RU?=
 =?utf-8?B?TUR3RlAyMmdYUlV4RmFBakhmZzl0dFZpT1RlbHlpZHdEdzlrUEZJZWdkakhn?=
 =?utf-8?B?eHhjNW1IWENoTVJrdUpodWpMeWg4RlpuTUQyU0ZQaTRHQ1pIckdjOVNDOWM1?=
 =?utf-8?B?TXNHK0lTZjNFaGN1d0VQd09IaCtNcE9XOENVSTFUZVdyZkZpdFpibGJLS3BP?=
 =?utf-8?B?K3Arb0d4cXBIQmxaMkZiTnlrRzBFVTNWWUw0Y1lIMUx4Um1wSVBoZGljYi9a?=
 =?utf-8?B?OVpRTjdOSHhBTFdjV2FES3NGR3MzV0FiZjYxVE1ucmU0UkY1RklTVi9ENnJX?=
 =?utf-8?B?citHQmJOY2RIZy9PLzRXZWZ1VUNkTVhTL1dTNDZYanBoOHJmU0s3Q2s0NWJ4?=
 =?utf-8?B?Z1ZZNmNNK25kRHVqMERIb1pBemxVZTFKcFRMRTRvY1FXeXdOdklxZE14QkJn?=
 =?utf-8?B?VVB5RW5ZREM1K0toV1VQL3BmMlk1VnBGWlpxdnhuR2lzeXVpVUdSdDl5Qk9G?=
 =?utf-8?B?YmoxRmU3dzJBVE9LdFFDMldpU2ZRTU8zTStaZzIrOXMrTGxsVkpDUWNxNWxI?=
 =?utf-8?B?OG82bVRBclYySXFnWjJoSHRhRStzSStTcys3V2VOczZlOHJheDJBeEhKSXFu?=
 =?utf-8?B?ZWh6U21IVGt2Qktna3ZOdElzUC8xTTV5NHA2b2FBbkMyK3h2dmtJYW9leU0y?=
 =?utf-8?B?N2dFa0hwNzZkaUJNMWp1TTdpYVQvM20ybmVmY3pTZ1JUelRrakQydTVsaXc3?=
 =?utf-8?B?VCsxY3FmQnN0RnFWRjZta2pxM21BbXdvbjJ4aWY3ajlEYVA4eGhxS1FJZFRO?=
 =?utf-8?B?R2w2RDZoTDA3azlzU1IxbFBNVFJvWU9vblVBVVRGTE96eThuY1JLMkRuTnBZ?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3AE07DD4D897848AA2200BE8698763E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mmiEo5N8bpuL1cnL0lq5kh1rvn95pYqtLrf76xJz/aS6zwQte50BUIn+I8wFGS0BLXH9nbWU1BMfCENWntLpHrlYIc7G+pJbAVIwSn3yxKWBCwdsf1ZLpGbcB/exNmmfp7WSACYa4Sj0f7NudGr1W39S9K8Pi89wpOkDcPNqe/6f6lzpBuwTdXpMkK/o55MWriB2QlD8KK1SK3Bw65Tjl+SJCzHsrH34Pldtjn1q79LrWLCYFnv+ww6AgC0tEcBdkhlknTLoCsBKElBDrgP+2buPx4s8B8RbHLhrsU/5qaM5PDc1hUjLiZiG7xglWui/S16ZCmfo9FhR1chw1G9bIiNTYc3va/1v11DYKawgCMYnM6XNMnkEKVnfO4g6j4lws6iJerIAZpT1WC4qyAxCW1HxOCYrY+tZkn5f2yKnek2Ig2no0dUD/QnxZZ8Dy1kNfOUcvtAop+M3FlXJJLiJpU55NAqAeFw8NHPh0V0ztD4PKxvXLYYnRgiItLcNviVb3wT1giHbLcwnADpOgDFlEpo+UaWcL6/lIDZJh2wh+T8QuWi/4KKNhYh/u72oT6SqNs6Rpo7w/uMwaJFlym8ifyInogWGyFa2DNwCsrNRM7zdbgiLBKxt+fZwA5bSfDXESf56hby3Ajz2J+OCaWTfcE4fzN3ZZ8b8w/9SWqqcoCMZgPsLwCwCO/s8Vxz7e0HP2FfFvvbSDuBdxFP0CEqkCk8ulyEti9gKj5hMeFLc4klqOWmq5f4jRiztBKLzflyrr4YjnS3K73uSkEH6FVvjg/aM7rq07BcQnAeMaVcGJxhZnODfjRSZFmwh7q03Ii3q+eM1TbGIySZAyXeU7lVCOzf0ZhpWydpLeb13M7GnM9yJkX31C9ITLIWIoa5BO6O/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e546f81-e823-4cdb-8f47-08dbc4438667
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 19:04:09.9261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1Gnn1leIMm1K/aE14GsaLos+CGiOi2KIIIScvawyI+08PKuLrbx/XtjLfuN4c8WMoeeZHA12ZS6koMH6nRu4g9A8y6kygv+0nhtkA8qcwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030142
X-Proofpoint-GUID: F35oj81uNKS1ZaVRNL0KrmV-MjuQhNgT
X-Proofpoint-ORIG-GUID: F35oj81uNKS1ZaVRNL0KrmV-MjuQhNgT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDIsIDIwMjMsIGF0IDU6NDkgUE0sIEphcmtrbyBTYWtraW5lbiA8amFya2tv
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uIE9jdCAyLCAyMDIzIGF0IDE6NDYgUE0g
RUVTVCwgRGVuaXMgR2xhemtvdiB3cm90ZToNCj4+IFRoZSBMaW51eCBrZXJuZWwgaGFzIGFuIElN
QSAoSW50ZWdyaXR5IE1lYXN1cmVtZW50IEFyY2hpdGVjdHVyZSkNCj4+IHN1YnN5c3RlbSB0byBj
aGVjayB0aGUgaW50ZWdyaXR5IG9mIHRoZSBmaWxlIHN5c3RlbSBiYXNlZCBvbiBkaWdpdGFsDQo+
PiBzaWduYXR1cmVzLiBJTUEgdXNlcyBjZXJ0aWZpY2F0ZXMgaW4gYC5pbWFgIGtleWluZyB0byBj
aGVjayBpbnRlZ3JpdHkuDQo+PiANCj4+IE9ubHkgY2VydGlmaWNhdGVzIGlzc3VlZCBieSBvbmUg
b2YgdGhlIHRydXN0ZWQgQ0EgKENlcnRpZmljYXRlIEF1dGhvcml0eSkNCj4+IGNlcnRpZmljYXRl
cyBjYW4gYmUgYWRkZWQgdG8gdGhlIGAuaW1hYCBrZXlpbmcuDQo+PiANCj4+IFRoZSBMaW51eCBr
ZXJuZWwgbm93IGhhcyBhIHNlY29uZGFyeSB0cnVzdGVkIGtleWluZyB0byB3aGljaCB0cnVzdGVk
DQo+PiBjZXJ0aWZpY2F0ZXMgZnJvbSB1c2VyIHNwYWNlIGNhbiBiZSBhZGRlZCBpZiB5b3UgaGF2
ZSBzdXBlcnVzZXINCj4+IHByaXZpbGVnZXMuIFByZXZpb3VzbHksIGFsbCB0cnVzdGVkIGNlcnRp
ZmljYXRlcyB3ZXJlIGluIHRoZSBidWlsdC1pbg0KPj4gdHJ1c3RlZCBrZXlpbmcsIHdoaWNoIGNv
dWxkIG5vdCBiZSBtb2RpZmllZCBmcm9tIHVzZXIgc3BhY2UuDQo+PiBUcnVzdGVkIGNlcnRpZmlj
YXRlcyB3ZXJlIHBsYWNlZCBpbiB0aGUgYnVpbHQtaW4gdHJ1c3RlZCBrZXlpbmcgYXQNCj4+IGtl
cm5lbCBjb21waWxlIHRpbWUuDQo+PiANCj4+IFRoZSBzZWNvbmRhcnkgdHJ1c3RlZCBrZXlpbmcg
aXMgZGVzaWduZWQgc28gdGhhdCBhbnkgY2VydGlmaWNhdGVzIHRoYXQNCj4+IGFyZSBzaWduZWQg
Ynkgb25lIG9mIHRoZSB0cnVzdGVkIENBIGNlcnRpZmljYXRlcyBpbiB0aGUgYnVpbHQtaW4gb3IN
Cj4+IHNlY29uZGFyeSB0cnVzdGVkIGtleXJpbmcgY2FuIGJlIGFkZGVkIHRvIGl0Lg0KPj4gDQo+
PiBMZXQncyBpbWFnaW5lIHRoYXQgd2UgaGF2ZSB0aGUgZm9sbG93aW5nIGNlcnRpZmljYXRlIHRy
dXN0IGNoYWluOg0KPj4gDQo+PiAgICAgICAgICAgICDilIzilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilKzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilJANCj4+ICAgICAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIOKUgiAgICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICAgICAgIOKUgg0KPj4gICAg
ICAgICAgICAg4pSCICAgICAgICAgICAgICAgICAgICAgICAgICAg4pSCICAgICDilIIgICAgICAg
4pSCICAgICAgIOKUgg0KPj4g4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pa84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKWvOKUgOKUgOKUgOKUgOKUgOKWvOKUgOKUgOKUgOKUgOKUkCAg
4pSCIOKUjOKUgOKUgOKUgOKUgOKUgOKUtOKUgOKUgOKUgOKUgOKUgOKUkA0KPj4g4pSCLmJ1aWx0
aW5fdHJ1c3RlZF9rZXlz4pSC4peE4pSA4pSA4pSA4pSkLnNlY29uZGFyeV90cnVzdGVkX2tleXMg
4pSc4pSA4pSA4pSYIOKUgiAgIC5pbWEgICAg4pSCDQo+PiDilJzilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQgICAg4pSc4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSkICAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
pA0KPj4g4pSCICAgICBSb290IENBIENlcnQgICAg4pSCLS0tLS3ilrogSW50ZXJtZWRpYXRlIENB
IENlcnQgIOKUgi0tLS0t4pa6IElNQSBDZXJ0IOKUgg0KPj4g4pSU4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAgIOKUlOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUmCAgICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lJgNCj4+IA0KPj4gICAgICAgICAgICAgICAgSXNzdWVzICAgICAgICAgICAgICAgICAgUmVzdHJp
Y3RlZCBieQ0KPj4gICAgICAgICAgICAtLS0tLS0tLS0tLS0t4pa6ICAgICAgICAgICAgIOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKWug0KPj4gDQo+PiBTaW5jZSB0
aGUgSU1BIGNlcnRpZmljYXRlIGlzIHNpZ25lZCBieSBhIENBIGNlcnRpZmljYXRlIGZyb20gYSBz
ZWNvbmRhcnkNCj4+IHRydXN0ZWQga2V5aW5nLCBhbiBhdHRhY2tlciB3aXRoIHN1cGVydXNlciBw
cml2aWxlZ2VzIHdpbGwgYmUgYWJsZSB0bw0KPj4gYWRkIHRoZSBJTUEgY2VydGlmaWNhdGUgdG8g
dGhlIHNlY29uZGFyeSB0cnVzdGVkIGtleWluZy4gVGhhdCBpcywgdGhlIElNQQ0KPj4gY2VydGlm
aWNhdGUgd2lsbCBiZWNvbWUgdHJ1c3RlZC4NCj4+IA0KPj4gU2luY2UsIHdpdGggYENPTkZJR19N
T0RVTEVfU0lHYCBvcHRpb24gZW5hYmxlZCwgbW9kdWxlcyBjYW4gb25seSBiZQ0KPj4gbG9hZGVk
IGludG8ga2VybmVsIHNwYWNlIGlmIHRoZXkgYXJlIHNpZ25lZCB3aXRoIG9uZSBvZiB0aGUgdHJ1
c3RlZA0KPj4gY2VydGlmaWNhdGVzLCBhbiBhdHRhY2tlciBjb3VsZCBzaWduIHVudHJ1c3RlZCBr
ZXJuZWwgbW9kdWxlcyB3aXRoDQo+PiB0aGUgcHJpdmF0ZSBrZXkgY29ycmVzcG9uZGluZyB0byB0
aGUgSU1BIGNlcnRpZmljYXRlIGFuZCBzdWNjZXNzZnVsbHkNCj4+IGxvYWQgdGhlIHVudHJ1c3Rl
ZCBtb2R1bGVzIGludG8ga2VybmVsIHNwYWNlLg0KPj4gDQo+PiBUaGlzIHBhdGNoIHdhcyBjcmVh
dGVkIG5vdCB0byBzb2x2ZSBvbmx5IHRoZSBwcm9ibGVtIG9mIGxvYWRpbmcNCj4+IHVudHJ1c3Rl
ZCBrZXJuZWwgbW9kdWxlcywgYnV0IHRvIG1ha2UgaXQgcG9zc2libGUgdG8gdXNlIGEgc2Vjb25k
YXJ5DQo+PiB0cnVzdGVkIGtleWluZyBvbmx5IGFzIGEgcGFydCBvZiBhIGNoYWluIG9mIHRydXN0
IGNvbnRhaW5pbmcgb25seQ0KPj4gQ0EgY2VydGlmaWNhdGVzIHdpdGggbm8gZGlnaXRhbCBzaWdu
YXR1cmUgY2FwYWJpbGl0eS4gVGhpcyB3aWxsDQo+PiBoZWxwIGF2b2lkIHNpbWlsYXIgcHJvYmxl
bXMgd2hlbiBuZXcgZmVhdHVyZXMgYXBwZWFyIGluIHRoZSBsaW51eA0KPj4ga2VybmVsIHRoYXQg
YXJlIHNpbWlsYXIgdG8ga2VybmVsIG1vZHVsZXMgaW4gdGVybXMgb2YgdGhlaXIgaW1wYWN0DQo+
PiBvbiBzeXN0ZW0gc2VjdXJpdHksIHdoaWNoIHdpbGwgYWxzbyB1c2UgdHJ1c3RlZCBjZXJ0aWZp
Y2F0ZXMgZm9yDQo+PiBzaWduYXR1cmUgdmVyaWZpY2F0aW9uLg0KPj4gDQo+PiBUaGlzIHBhdGNo
IGFkZHMgdGhlIGNvbmZpZ3VyYXRpb24gdGhhdCBvbmNlIGVuYWJsZWQsIG9ubHkNCj4+IGNlcnRp
ZmljYXRlcyB0aGF0IG1lZXQgdGhlIGZvbGxvd2luZyByZXF1aXJlbWVudHMgY2FuIGJlIGFkZGVk
DQo+PiB0byB0aGUgc2Vjb25kYXJ5IHRydXN0ZWQga2V5aW5nOg0KPj4gDQo+PiAxLiBUaGUgY2Vy
dGlmaWNhdGUgaXMgYSBDQSAoQ2VydGlmaWNhdGUgQXV0aG9yaXR5KQ0KPj4gMi4gVGhlIGNlcnRp
ZmljYXRlIG11c3QgYmUgdXNlZCBmb3IgdmVyaWZ5aW5nIGEgQ0EncyBzaWduYXR1cmVzDQo+PiAz
LiBUaGUgY2VydGlmaWNhdGUgbXVzdCBub3QgYmUgdXNlZCBmb3IgZGlnaXRhbCBzaWduYXR1cmVz
DQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IERlbmlzIEdsYXprb3YgPGQuZ2xhemtvdkBvbXAucnU+
DQo+PiAtLS0NCj4+IHYxIC0+IHYyOg0KPj4gLSBSZWJhc2UgdGhlIHBhdGNoIGZyb20gYGxpbnV4
LW5leHRgIHRvIHRoZSBtYWluIGBsaW51eGAgcmVwbyBtYXN0ZXIgYnJhbmNoDQo+PiAtIE1ha2Ug
dGhlIGNvbW1pdCBtZXNzYWdlIG1vcmUgZGV0YWlsZWQNCj4+IC0gTW92ZSB0aGUgdmFyaWFibGUg
ZGVjbGFyYXRpb24gdG8gdGhlIGBpZmAgYmxvY2sNCj4+IC0gUmVwbGFjZSBgI2lmZGVmYCB3aXRo
IGBJU19FTkFCTEVEYCBtYWNybw0KPj4gDQo+PiB2MiAtPiB2MzoNCj4+IC0gQWRkIHRoZSBwdXJw
b3NlIGFuZCBnb2FsIG9mIHRoZSBwYXRjaCB0byB0aGUgY29tbWl0IG1lc3NhZ2UNCj4+IC0tLQ0K
Pj4gY2VydHMvS2NvbmZpZyAgICAgICAgICB8ICA5ICsrKysrKysrKw0KPj4gY2VydHMvc3lzdGVt
X2tleXJpbmcuYyB8IDE2ICsrKysrKysrKysrKysrKysNCj4+IDIgZmlsZXMgY2hhbmdlZCwgMjUg
aW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvY2VydHMvS2NvbmZpZyBiL2NlcnRz
L0tjb25maWcNCj4+IGluZGV4IDFmMTA5YjA3MDg3Ny4uNGE0ZGM4YWFiODkyIDEwMDY0NA0KPj4g
LS0tIGEvY2VydHMvS2NvbmZpZw0KPj4gKysrIGIvY2VydHMvS2NvbmZpZw0KPj4gQEAgLTkwLDYg
KzkwLDE1IEBAIGNvbmZpZyBTRUNPTkRBUllfVFJVU1RFRF9LRVlSSU5HDQo+PiAJICB0aG9zZSBr
ZXlzIGFyZSBub3QgYmxhY2tsaXN0ZWQgYW5kIGFyZSB2b3VjaGVkIGZvciBieSBhIGtleSBidWls
dA0KPj4gCSAgaW50byB0aGUga2VybmVsIG9yIGFscmVhZHkgaW4gdGhlIHNlY29uZGFyeSB0cnVz
dGVkIGtleXJpbmcuDQo+PiANCj4+ICtjb25maWcgU0VDT05EQVJZX1RSVVNURURfS0VZUklOR19G
T1JfQ0FfQ0VSVElGSUNBVEVTX09OTFkNCj4+ICsJYm9vbCAiQWxsb3cgb25seSBDQSBjZXJ0aWZp
Y2F0ZXMgdG8gYmUgYWRkZWQgdG8gdGhlIHNlY29uZGFyeSB0cnVzdGVkIGtleXJpbmciDQo+PiAr
CWRlcGVuZHMgb24gU0VDT05EQVJZX1RSVVNURURfS0VZUklORw0KPj4gKwloZWxwDQo+PiArCSAg
SWYgc2V0LCBvbmx5IENBIGNlcnRpZmljYXRlcyBjYW4gYmUgYWRkZWQgdG8gdGhlIHNlY29uZGFy
eSB0cnVzdGVkIGtleXJpbmcuDQo+PiArCSAgQW4gYWNjZXB0YWJsZSBDQSBjZXJ0aWZpY2F0ZSBt
dXN0IGluY2x1ZGUgdGhlIGBrZXlDZXJ0U2lnbmAgdmFsdWUgaW4NCj4+ICsJICB0aGUgYGtleVVz
YWdlYCBmaWVsZC4gQ0EgY2VydGlmaWNhdGVzIHRoYXQgaW5jbHVkZSB0aGUgYGRpZ2l0YWxTaWdu
YXR1cmVgDQo+PiArCSAgdmFsdWUgaW4gdGhlIGBrZXlVc2FnZWAgZmllbGQgd2lsbCBub3QgYmUg
YWNjZXB0ZWQuDQo+PiArDQo+PiBjb25maWcgU1lTVEVNX0JMQUNLTElTVF9LRVlSSU5HDQo+PiAJ
Ym9vbCAiUHJvdmlkZSBzeXN0ZW0td2lkZSByaW5nIG9mIGJsYWNrbGlzdGVkIGtleXMiDQo+PiAJ
ZGVwZW5kcyBvbiBLRVlTDQo+PiBkaWZmIC0tZ2l0IGEvY2VydHMvc3lzdGVtX2tleXJpbmcuYyBi
L2NlcnRzL3N5c3RlbV9rZXlyaW5nLmMNCj4+IGluZGV4IDlkZTYxMGJmMWY0Yi4uZWUxNDQ0NzM3
NGU3IDEwMDY0NA0KPj4gLS0tIGEvY2VydHMvc3lzdGVtX2tleXJpbmcuYw0KPj4gKysrIGIvY2Vy
dHMvc3lzdGVtX2tleXJpbmcuYw0KPj4gQEAgLTk5LDYgKzk5LDIyIEBAIGludCByZXN0cmljdF9s
aW5rX2J5X2J1aWx0aW5fYW5kX3NlY29uZGFyeV90cnVzdGVkKA0KPj4gCQkvKiBBbGxvdyB0aGUg
YnVpbHRpbiBrZXlyaW5nIHRvIGJlIGFkZGVkIHRvIHRoZSBzZWNvbmRhcnkgKi8NCj4+IAkJcmV0
dXJuIDA7DQo+PiANCj4+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1NFQ09OREFSWV9UUlVTVEVE
X0tFWVJJTkdfRk9SX0NBX0NFUlRJRklDQVRFU19PTkxZKSAmJg0KPj4gKwkgICAgZGVzdF9rZXly
aW5nID09IHNlY29uZGFyeV90cnVzdGVkX2tleXMpIHsNCj4+ICsJCWNvbnN0IHN0cnVjdCBwdWJs
aWNfa2V5ICpwdWIgPSBwYXlsb2FkLT5kYXRhW2FzeW1fY3J5cHRvXTsNCj4+ICsNCj4+ICsJCWlm
ICh0eXBlICE9ICZrZXlfdHlwZV9hc3ltbWV0cmljKQ0KPj4gKwkJCXJldHVybiAtRU9QTk9UU1VQ
UDsNCj4+ICsJCWlmICghcHViKQ0KPj4gKwkJCXJldHVybiAtRU5PUEtHOw0KPj4gKwkJaWYgKCF0
ZXN0X2JpdChLRVlfRUZMQUdfQ0EsICZwdWItPmtleV9lZmxhZ3MpKQ0KPj4gKwkJCXJldHVybiAt
RVBFUk07DQo+PiArCQlpZiAoIXRlc3RfYml0KEtFWV9FRkxBR19LRVlDRVJUU0lHTiwgJnB1Yi0+
a2V5X2VmbGFncykpDQo+PiArCQkJcmV0dXJuIC1FUEVSTTsNCj4+ICsJCWlmICh0ZXN0X2JpdChL
RVlfRUZMQUdfRElHSVRBTFNJRywgJnB1Yi0+a2V5X2VmbGFncykpDQo+PiArCQkJcmV0dXJuIC1F
UEVSTTsNCj4+ICsJfQ0KPj4gKw0KPj4gCXJldHVybiByZXN0cmljdF9saW5rX2J5X3NpZ25hdHVy
ZShkZXN0X2tleXJpbmcsIHR5cGUsIHBheWxvYWQsDQo+PiAJCQkJCSAgc2Vjb25kYXJ5X3RydXN0
ZWRfa2V5cyk7DQo+PiB9DQo+PiAtLSANCj4+IDIuMzQuMQ0KPiANCj4gSSBkb24ndCB0aGluayB0
aGlzIGRvZXMgYW55IGhhcm0uDQoNClJpZ2h0IG9yIHdyb25nLCB0aGVyZSBkbyBzZWVtIHRvIGJl
IEludGVybWVkaWF0ZSBDQeKAmXMgdGhhdCBoYXZlIHRoZSANCmRpZ2l0YWwgc2lnbmF0dXJlIHVz
YWdlIHNldCBbMV0uDQoNCjEuIGh0dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9rYi9kaWdpY2VydC1y
b290LWNlcnRpZmljYXRlcy5odG0jaW50ZXJtZWRpYXRlcw0KDQo+IFdoYXQgZG8geW91IHRoaW5r
IE1pbWk/DQoNCg==
