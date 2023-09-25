Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996537AE2A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjIYXtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjIYXto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:49:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA25FB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:49:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PNEORT018799;
        Mon, 25 Sep 2023 23:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=e3d5lxM5i7Yf1CglmpEJ7qKUrP8Ep3pehO003LFZGic=;
 b=rRBY7d0tGvljZMpmHwlegwdhMoKUktycPFlKDAgZ7NViAFyWC12HYQtTgAthTgyEA25/
 6vYjXJe9Pr6bfRKBlK0PiqgQz+hMFNc0QrNS9I3gVf5wQioltaMe6ewLieyl2EX2kuC8
 yTesc8nfl9GWT9KepMN9lZyP0qu95zt8iXX0xj47KVsOapTQLu2A63czZxOS68Y21Ce0
 Wc2W7yPqDfjnl3T5v9tNJ58LwT/Gd1E8ZvGjfQFBRMO+5skBqe57D+Gw2M8wqU1RoECg
 yqd2V6oFnav2DasSM7aiaE+dP3GmFf6Tgv8S01X2xJudaZovjf1t/M14+K8V5mw8DqzP fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbd5jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:48:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PMFvIt035024;
        Mon, 25 Sep 2023 23:48:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf5ghj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:48:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WodVeQ22lOzvv8NwsaiDnC7UAIEwYKKO2hznSbHfBFkdL2MVw1o45d+GF9JAPYXpKIdvcZvRwz8Mi6UAXoxWiPtJQH4nivapNvxfBsOGOC+LZqKLhgwYc41Eurd4NyAV/dN/KCep13XIbwJr1dV4ljUgUlTXdpd+a5g2/x0lvq9sAbxHe9/P5+TvTtIBcDoBaqJaSOPFDBUmPVggiYhTivWepKWNIxpJZv0W5DBO6t65ah9U1fV4zuFYPNmaSDlX8T82I6qYee/mtFMxAmqXwI2kEGUPuhsaQz6RoMxbYpkuiDKt7qg3PWdEg/gqZy1j/sj7qVGDLPT1GKZcDlW/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3d5lxM5i7Yf1CglmpEJ7qKUrP8Ep3pehO003LFZGic=;
 b=GQoA79v2/RNWRlNXSBejznW7PhMWzxBckLK917rei8H2ZgHRmsNLunR0xXT38vPhed4P4/dWH4VeABeCiPpgNpmIv/qhiYm07XNYDWw0HYCxmB4ncSbFplCQSjxds9qNV1qI2TJWvh+tj4kacuiCIGZ9KlREuES8EnLt8cipAeasQTt70UKWgCYFxHSoP9e7NsT1DbwbmFFT8RiTbQVS5fqd+ghX7YTBQKD8ZXreKBiGcvhY3JUk/iqHrH87FLW+IJBUsBbP2y8WxmA9NwkVqCK4ADatsiW61sSIdY37TCL2gqOwN07kPPa8LcCHX0fubw8PIvMYk8XooKewYCnBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3d5lxM5i7Yf1CglmpEJ7qKUrP8Ep3pehO003LFZGic=;
 b=ejB3xmZ27UHlFOFQFG/Oaw+ABu2RHtKeSf0/xgGu31VdGYEZuMSpMy6O0+7bFNHYzXOI1Sv0iOcFkHqo+LDlkwNkUh+glkLnWl42pWuJT+8AngXfoogXxHDPMcuZ6QIIkSSH1n3QvDc2ugtQqkuZuwVJR+T1IK+xoRil5NHBxV8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4523.namprd10.prod.outlook.com (2603:10b6:806:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 23:48:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 23:48:43 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v6 0/8] Batch hugetlb vmemmap modification operations
Date:   Mon, 25 Sep 2023 16:48:28 -0700
Message-ID: <20230925234837.86786-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:303:b7::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: cd40ba7c-8478-4037-6ac8-08dbbe21f374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAdR+LBVD5B6MZlfSQuI9Nrz03T1N1UOIwicWgvcH6Nzd2uE40BEnjBc9f96rVR247FIJmD8AmmnRExHzQCL1YR/St0urs9Gy4rP3yu10szWfJFcibFgiurTCvP3zQ70Om3rkTKf4UBysZK/t6rJ9t+/PkMayTwbvkw3LC7jH02r6hLexiq1IcM2osnozog0sl92aatwV3K098S/4kDnoKj8R9S3cbCjY0sCCauBxHcP7f4VLCZLENSmx2N9pRiKVMliqIoNxJRx6tISsCy2TuMWtPtr+K1g67d8AmjJQ5fdEEDBfePBHWenMUKb7CmSUZ/y++L5HJfgSam8drcrBVCXsvfXZgXFxp7FAAg25omfeT+W95jW+Awa5AbXx9hsKSztkz8Av1wgE+JlefvnEzxRMY3unda1Syu1r2H7EA1zG8SKXh+S4LTWakCeR/Lhl/m7psU17PuwXBs+jA4fUDR4D77RO8ft0imY3iGJuOhvfS/xfwyVDGvet3xYCFn/MlqB/Do8GzTb1m4Pk7hOvJWJyEjC1+U+S9cZemY9WeW0ou0OtYkRBIi1U2hARz8q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(2906002)(7416002)(1076003)(66899024)(6666004)(6506007)(66476007)(6486002)(5660300002)(316002)(44832011)(36756003)(8676002)(4326008)(66556008)(41300700001)(54906003)(8936002)(2616005)(66946007)(86362001)(6512007)(107886003)(26005)(83380400001)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2Z0ZHgyZXZ1V1JsWVgwYWJsSFN6RDMxSlhHenkxelRvL1J5Vng5K0Z4TXVQ?=
 =?utf-8?B?dGdyOVowSkZlMzlsUTF5a0RJK0dzK3JJSUY1U0JwSlVqWEZPKzh3Zi9GbGNK?=
 =?utf-8?B?UTU2S2Fzb2dHQk9aQUJOWHNOWnVGRXJJRDBSSmtIV3FCZ3RKaWtGT3JNamYx?=
 =?utf-8?B?WWh6MmdYMGZFb3ZCTEQ2L1FzeVV0VElOc2V2Q3dTTHRraTBrZGFmUDk5Y3JH?=
 =?utf-8?B?UDdiZWN5VC8zTldZTTczZXJwc0F3UUM1SEwwRVdvVEo0YlQrMGxHTEJmaUUr?=
 =?utf-8?B?WkF1MUhLdE5IZFFnOFB0bkpueTA5cWVYTTBGNEJxTUQ3Z2FzSUkvMnNGMXF2?=
 =?utf-8?B?QzVYUndHV2U1NUhLRTR1NWRVTWJpTnZiRFAyNHRjVHRTdWJtaFBHM2hFME9k?=
 =?utf-8?B?NkFoUmpzbUdGdnd2ejF1VnE3WHJQZ1V1VW45cnptNlJLRitUM3dlSVF1bW1S?=
 =?utf-8?B?cVdURElydVJhcmFITksxNkk4c0ZhckVpaE8zU3lKU0RSYWZHWXpPZnlTUUlr?=
 =?utf-8?B?R2ZjcGlqeTFUbmI3S0lvQXcyQlJMc3dlTUhxQ1h4Mm1lVmdhaHp1NE92TXdn?=
 =?utf-8?B?aUwvNzBwUFk5Mkw0bEpKVzhxdXRLZTlGVHBWWUowRWpBRStUSGkzWDBlUTg5?=
 =?utf-8?B?RFV4eTZOVytYUnBGelEzM3dqcVRDWm5FWHgweTBOempTQ3lCMXR6ck96bWRC?=
 =?utf-8?B?R3lNdU4wUVh5Zk8wYi9Zc1laZ0UwMlBXQklFN2ZnNWJtVjBiamd4dmFzSCts?=
 =?utf-8?B?RUN0R01IN1ZvSTRLcHVTL3RiOGZNV1hGR00yMGNhN2dNbWRvSHNUQTJWdmpK?=
 =?utf-8?B?SkwwNjA0SkNJSjVkZlhxNTRRWitwV3RmZjJ6MWpqM1FOMkhlMnN0V1hBaHMw?=
 =?utf-8?B?U3VOV0JUT3RYc0ZOalVrd1AvOEFhaHlUMTBLZ0Q1TFpRcFg0S0I5bzQ0MFZ0?=
 =?utf-8?B?M1BDVjJOdzgxemdhRllFQ2EvNkxYc2VvWXBRTzRPaUJYM25mY01MYmE0OXpm?=
 =?utf-8?B?bmh1d0U0Vmc5cTFMVW5GOGh4U2NDS29XTEdsckRzeXppejRETGtwZUdPMDJL?=
 =?utf-8?B?T2kxWEIzb25XWFFEdFFkS2RMV1Q4ZTgrZjQzNmZVZWRzMlhPQWZ3MnJZRGox?=
 =?utf-8?B?RnBHTzJoU2RBcW51ZitxT1V3MXhmMWtqZlBsSTc4eVZmQkdxN0gvYlBSa3dz?=
 =?utf-8?B?aURxUlhDK1pXSzdxWXRTTzAxSDF1TjZRbXBFSlBrZlVUTmlUbEZraWR6ZTdT?=
 =?utf-8?B?NklqRGZtTlA1RStzaGFBRHZ1RXNTM3NteDNacit0Y0RzMzZMaEM5Tm92dTdC?=
 =?utf-8?B?ZVpxYzF6K1pYaExWdjY2SXlJMVhIcE9RQWtpeW0xNjIzZ2FlcjdWcWlpV0Zj?=
 =?utf-8?B?a0JzSDBISWR6S3B3ekpmeGVYUzY5blpWdWJ3Y21ZQmF6dkptSlVrY3hLM0FP?=
 =?utf-8?B?YkptL3FsbTZ0V0o1K0xKM3c0dTR3YWQwOXVCSWQzK09zUlljWTZNUm5vNkll?=
 =?utf-8?B?NFNlS1NLUG5TYzFXYmN3Vkp6cGZWSEtXQmlQMU9OcytwMFR3bVZTdUx5WUdl?=
 =?utf-8?B?dmtteElHSUs2Q2VGWmFjVjVYaWdURlpNRUdrR3F1dGVmUXhqMmZDWlJoMndO?=
 =?utf-8?B?RXpDTnJJTmdPOFJmdGFPWFZKYnRVVUdvaVBOOUFvUHdUd1o3aWI4UmMrYnNB?=
 =?utf-8?B?bDFHaWhHNklvMG13ODUrK21tKzF2TE1xYjFvNngvQWl4VFA4RWlVZkIyc1d6?=
 =?utf-8?B?S0JtTTR4UENQemRuL3JLUmxXNzc2NEpxN0E0a1VWbTlQdkQraVVHWFdhVkFN?=
 =?utf-8?B?VW1RUGNKVklQRkt0Y3FPRWRoblZ0VmlnMzZ2TU5mNHo2dnhJWWo2Rk9xWFZ0?=
 =?utf-8?B?Q3N1eDY5STgya1VCTm1QU1YyQ1NjR2NCWjBwQUlqUUU1dmtNT2JNMkpFNHpl?=
 =?utf-8?B?dDBWbWZ5L0ZFa3ZXTnBXM2NXa1RKZExhUC9VUHpKL1NUdTlCdGpMVFpJK2Jq?=
 =?utf-8?B?dmZPZ2hNelQ1RTM5ZGFJVjdXdmlXNm10NTNxR3RDQy9CS3hETFE1YWsrYnRK?=
 =?utf-8?B?b0RPYmNzNFI3MWV3dmZCd0xkZHQ4dTQ1Q2czMFFDaXpua0RuZXlDb0xuTlBY?=
 =?utf-8?B?WjI5UTRDZE9CN3VJNG9BYTZnUGNkYlptWlM1UHpWdDdIanROY1ZoNnF1dE5E?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?KzFKOWNFYkR6SXYvdHVlaERMbXNBaHd5QWNUZ20zbXYwdlB2YTBkS3I2TGFB?=
 =?utf-8?B?dzZ2OTVVdnBLWlJTYnNLQUZ4aWpFSVgxZEozZC8xT2JOcVdFYkRXenltQVNm?=
 =?utf-8?B?VTIvNlNjRGM2MU93Q000aEtjTnFvWmdBS250c3QyWnZOalZWS0xLTGgxb0hX?=
 =?utf-8?B?QjVaSVhPN0R0RVBzSVVQY0oxaVpZRmFrdzdLcDQzWXdTaTh6THd5T25wRGlZ?=
 =?utf-8?B?UnRaZG9sTUltNTd1SjVYNUZEQ2U4VzhBL3dYSXpQMW9mYUkrbVVUL1VBZE41?=
 =?utf-8?B?bFY4MHFFSDNtTUtEWTY5WXRYSEdtWGl0NVFDczBxaW5rK28yYTRJZXNCWith?=
 =?utf-8?B?NklmU1puV1QxOHZjSW9yRXgzV21tc0xYc0FlcW5QVVROa2kwSFJnYVhYRGVn?=
 =?utf-8?B?b05RWSs0a1IyWjJlcGI5cmlZSTl3RXk4eGEyTUsyRk1jdDJZZkV2cWE2ZStQ?=
 =?utf-8?B?QjdPY3JKc2xqQ0pkUHAwdncvblp1TUJWMTg4OGtxR1NXMUhYemUwaTE3S2k5?=
 =?utf-8?B?N3BPOERVaWhPNFBRbjFlQU9HLzJmZnVDLzlvdjU0bitqMC9NZVQvaS91dFVa?=
 =?utf-8?B?WE1tMURVZGhpTjRlcXIzSFJFbFVTZ04xN1NQeVdHSG51U2QwT3VHYTlKZ2d6?=
 =?utf-8?B?WUo5U29GM2cyeXRLWUlzUjVKQ0xCVnZqRDBOcW9xTmVPaWM1SXdmYUxna1N4?=
 =?utf-8?B?MGF4b2MrS0M1MFVjand6amtSYTRsTTA1NzBMcTNKWXJFNVdZbkNsd05EaGow?=
 =?utf-8?B?S0hsVjdRWVFuQUJma3RrQTBKZ0VaVnVEcnZDY24xNnJXR3VoZlZhK1NJV2h4?=
 =?utf-8?B?cWw3VUlFOE45T1M1cEJTMmM1KzczYmpKZ25QdFJablhvbXRBc2ZXYW1vQmJJ?=
 =?utf-8?B?QWJMLzZNOXBndmphQWJhZ2l2a3k2Z3FSL1A1QlRFQktLRGIrZDIzd3YvNTBr?=
 =?utf-8?B?MVZ2S1hXTmZHMFlTd3NiNjJ4aEpPMmJpZnhXQUFoaDV4eWdCd1MwMjhhejZQ?=
 =?utf-8?B?aTh1MlRyWVNjUEhYSTFiY1RSbzl1ME9XOXVhQmVER3gwakxWekl6YVdBZWFQ?=
 =?utf-8?B?MDhhL2tsaGVDYjlmei96bkwvTjVWY1I4ZWgrVk04Ym5WeGs4VUI0a2RDMGFl?=
 =?utf-8?B?N3owa0UvK3hiWi9GUkFnaUtvYmYwR3JBRCttSUd2V1VFODRhUG1ZZjlrY01M?=
 =?utf-8?B?U1AwTjg4SHFSYlAxTWp4ejJtVmYzeDZBbzVnWW9mZkpicmh0UGRpSDVzYXI4?=
 =?utf-8?B?UWg5ZHRJWVZsLzlXZW42dEIwOGlQcTJWZjZ2emVGQk0zcks2SDhFcFd3cUlI?=
 =?utf-8?B?RGw0RWgzeW94eWQxTXZoSlZxcXVMUjE4Qk5iaGtUOEZBb1psSmJwd25aM2FV?=
 =?utf-8?B?VmtYNGRhSVRhcG5pMGlZYUpXKzN4OERRRlQyOEtLLzUxaklpR2o1VmNIY1Zp?=
 =?utf-8?B?RG9qdUkxN2xJR2tsTERPVC9XdUVQRm1rVlFlbEtQbXptUjFrOVZaaEltRmt2?=
 =?utf-8?Q?X/F3Z03zJ1fVDs4r4iRNWKtMaPw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd40ba7c-8478-4037-6ac8-08dbbe21f374
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:48:43.2513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JrOa0QvjSzcKxQLOglf5LpcctxFgTHl4T/S37qRfC5TqKOGr6wlFSImn6s8izWXyCBSsgnI+DZ5t8SWezcPWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250185
X-Proofpoint-GUID: uKFOuJIWbeeeAY6V26qHup2el310G616
X-Proofpoint-ORIG-GUID: uKFOuJIWbeeeAY6V26qHup2el310G616
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hugetlb vmemmap optimization was introduced, the overhead of enabling
the option was measured as described in commit 426e5c429d16 [1].  The summary
states that allocating a hugetlb page should be ~2x slower with optimization
and freeing a hugetlb page should be ~2-3x slower.  Such overhead was deemed
an acceptable trade off for the memory savings obtained by freeing vmemmap
pages.

It was recently reported that the overhead associated with enabling vmemmap
optimization could be as high as 190x for hugetlb page allocations.
Yes, 190x!  Some actual numbers from other environments are:

Bare Metal 8 socket Intel(R) Xeon(R) CPU E7-8895
------------------------------------------------
Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 0
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m4.119s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m4.477s

Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 1
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m28.973s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m36.748s

VM with 252 vcpus on host with 2 socket AMD EPYC 7J13 Milan
-----------------------------------------------------------
Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 0
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m2.463s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m2.931s

Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 1
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    2m27.609s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    2m29.924s

In the VM environment, the slowdown of enabling hugetlb vmemmap optimization
resulted in allocation times being 61x slower.

A quick profile showed that the vast majority of this overhead was due to
TLB flushing.  Each time we modify the kernel pagetable we need to flush
the TLB.  For each hugetlb that is optimized, there could be potentially
two TLB flushes performed.  One for the vmemmap pages associated with the
hugetlb page, and potentially another one if the vmemmap pages are mapped
at the PMD level and must be split.  The TLB flushes required for the kernel
pagetable, result in a broadcast IPI with each CPU having to flush a range
of pages, or do a global flush if a threshold is exceeded.  So, the flush
time increases with the number of CPUs.  In addition, in virtual environments
the broadcast IPI can’t be accelerated by hypervisor hardware and leads to
traps that need to wakeup/IPI all vCPUs which is very expensive.  Because of
this the slowdown in virtual environments is even worse than bare metal as
the number of vCPUS/CPUs is increased.

The following series attempts to reduce amount of time spent in TLB flushing.
The idea is to batch the vmemmap modification operations for multiple hugetlb
pages.  Instead of doing one or two TLB flushes for each page, we do two TLB
flushes for each batch of pages.  One flush after splitting pages mapped at
the PMD level, and another after remapping vmemmap associated with all
hugetlb pages.  Results of such batching are as follows:

Bare Metal 8 socket Intel(R) Xeon(R) CPU E7-8895
------------------------------------------------
next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 0
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m4.719s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m4.245s

next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 1
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m7.267s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m13.199s

VM with 252 vcpus on host with 2 socket AMD EPYC 7J13 Milan
-----------------------------------------------------------
next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 0
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m2.715s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m3.186s

next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 1
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m4.799s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m5.273s

With batching, results are back in the 2-3x slowdown range.

This series is based on mm-unstable (September 24)

Changes v5 -> v6:
- patch 4 in bulk_vmemmap_restore_error remove folio from list before
  calling add_hugetlb_folio.
- Added Muchun RB for patches 2 and 3

Changes v4 -> v5:
- patch 3 comment style updated, unnecessary INIT_LIST_HEAD
- patch 4 updated hugetlb_vmemmap_restore_folios to pass back number of
  restored folios in non-error case.  In addition, routine passes back
  list of folios with vmemmmap.  Naming more consistent.
- patch 5 remover over optimization and added Muchun RB
- patch 6 break and early return in ENOMEM case.  Updated comments.
  Added Muchun RB.
- patch 7 Updated comments about splitting failure.  Added Muchun RB.
- patch 8 Made comments consistent.

Changes v3 -> v4:
- Rebased on mm-unstable and dropped requisite patches.
- patch 2 updated to take bootmem vmemmap initialization into account
- patch 3 more changes for bootmem hugetlb pages.  added routine
  prep_and_add_bootmem_folios.
- patch 5 in hugetlb_vmemmap_optimize_folios on ENOMEM check for
  list_empty before freeing and retry.  This is more important in
  subsequent patch where we flush_tlb_all after ENOMEM.

Changes v2 -> v3:
- patch 5 was part of an earlier series that was not picked up.  It is
  included here as it helps with batching optimizations.
- patch 6 hugetlb_vmemmap_restore_folios is changed from type void to
  returning an error code as well as an additional output parameter providing
  the number folios for which vmemmap was actually restored.  The caller can
  then be more intelligent about processing the list.
- patch 9 eliminate local list in vmemmap_restore_pte.  The routine
  hugetlb_vmemmap_optimize_folios checks for ENOMEM and frees accumulated
  vmemmap pages while processing the list.
- patch 10 introduce flags field to struct vmemmap_remap_walk and
  VMEMMAP_SPLIT_NO_TLB_FLUSH for not flushing during pass to split PMDs.
- patch 11 rename flag VMEMMAP_REMAP_NO_TLB_FLUSH and pass in from callers.

Changes v1 -> v2:
- patch 5 now takes into account the requirement that only compound
  pages with hugetlb flag set can be passed to vmemmmap routines.  This
  involved separating the 'prep' of hugetlb pages even further.  The code
  dealing with bootmem allocations was also modified so that batching is
  possible.  Adding a 'batch' of hugetlb pages to their respective free
  lists is now done in one lock cycle.
- patch 7 added description of routine hugetlb_vmemmap_restore_folios
  (Muchun).
- patch 8 rename bulk_pages to vmemmap_pages and let caller be responsible
  for freeing (Muchun)
- patch 9 use 'walk->remap_pte' to determine if a split only operation
  is being performed (Muchun).  Removed unused variable and
  hugetlb_optimize_vmemmap_key (Muchun).
- Patch 10 pass 'flags variable' instead of bool to indicate behavior and
  allow for future expansion (Muchun).  Single flag VMEMMAP_NO_TLB_FLUSH.
  Provide detailed comment about the need to keep old and new vmemmap pages
  in sync (Muchun).
- Patch 11 pass flag variable as in patch 10 (Muchun).

Joao Martins (2):
  hugetlb: batch PMD split for bulk vmemmap dedup
  hugetlb: batch TLB flushes when freeing vmemmap

Mike Kravetz (6):
  hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
  hugetlb: restructure pool allocations
  hugetlb: perform vmemmap optimization on a list of pages
  hugetlb: perform vmemmap restoration on a list of pages
  hugetlb: batch freeing of vmemmap pages
  hugetlb: batch TLB flushes when restoring vmemmap

 mm/hugetlb.c         | 301 ++++++++++++++++++++++++++++++++++++-------
 mm/hugetlb_vmemmap.c | 273 +++++++++++++++++++++++++++++++++------
 mm/hugetlb_vmemmap.h |  15 +++
 3 files changed, 506 insertions(+), 83 deletions(-)

-- 
2.41.0

