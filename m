Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BA078DC57
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbjH3Sos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbjH3LQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:16:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA83BFF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:15:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9iOID022323;
        Wed, 30 Aug 2023 11:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zSDgRuC1Mh8YjrY+JFihI2wRZgzlokziU1zUl3y8354=;
 b=nrXM98bo5bqvBHAadBbdSixh7bJBS2pff8AQCDIC12VxO3XjENFPXahW845KHQgs23Xe
 xlswI1MeEUHHfn0LFQ7ZOT2tTU5dHPRydGtBywzlwSrjP4lyy2311LgWnuRrdL56Fn8B
 Zr+ZDbW3rA5hIknx3T39TgaFIFMAwkDlSXGXyAtXJar3d5SWGdT3tb08+dMUt2/B98L3
 WO/YfaBrZZafjCsx/oT7nN2tM1scFJCOqRqpkhdh42xEq4EC3E6CtmuiANgCrnR9Bny/
 98cP6pSXSU7sLz2NsDLxX8em486HdbNCOOa+zkaTVReuQ7xYsjn/4VY99amWGMfqq/H3 Gg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gdy12k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 11:15:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9YBFf024335;
        Wed, 30 Aug 2023 11:15:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dpcg67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 11:15:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlkZ+5eyYLlegdMtUdLzGXEJtgJMoyKxDSOObH1pzy293m4GwyudpoN2uijbgFWRySEnLAKB24T40Ovi1A2unz6kxlcnp3/ZhcmNUji1PaSMzg98ZP9J0yW9jqTh+zxyGw3dIwrNZWs6uiT3sEvCtsYr66TW5EgwjVkBad06r3Rcr0CrWHH+s0zC/gvvWEAknA1tXFHyGWVICMRqrBnVogSkRMggVxKhj/ivYX113I6eZCaJMscBJuRfoe/eARX3BHSdZbYpt2bg2MSNde9+hTqVbXWvRqLaSD3WDtOmoDsmlsD3nF6YynS9YNH2BD7yMLcY+7MuZ/AUEI6LIqHgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSDgRuC1Mh8YjrY+JFihI2wRZgzlokziU1zUl3y8354=;
 b=TtLDRZoEFweVmi8vDTzWO36mgpz5YcXNuAV+ENRzOTCvKeQyy8bIN+fsM5V/dgn56aOtRHr1yJsNKl0oJlVyLMv/ijuZEbon0e+ma/vbnnuQuU14tYxkJGn8g/yFWfzEERZGFQjIdCrje7TcrjPPV8bN7gnXYHSOdo4p5ZLL3JCnMpZIQRjvwysn8PYO0ckzhEfk6klKOYRXW5HK89dVDHfCNUU/jAdA6vmb0zvv2rf3JlCj3sH0/0GY0UOeuzz3/0ZbVuBtni0V3AlQ/82A9qimt2e7LyT9983thLNjj+XE77sA8lL380hdEXE8NpyQp56CL/VnwrvWH/xTokXj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSDgRuC1Mh8YjrY+JFihI2wRZgzlokziU1zUl3y8354=;
 b=pLQjFHOjmxW713IaxguEkrqNk96ob4RM3q50sZ5Rnq6eLzN55eAwTTb9HAAaPePk/GBJhqUM1QMDAbRXG4mXAiY1uUAw/CM4+wjVd6XXel0H8JW7pFgPeuvYIT4Vz7VPumv5OJ6OlzsVQxph1y12giUt4eNJ9w79z1xfDKj0tU4=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH7PR10MB7767.namprd10.prod.outlook.com (2603:10b6:510:2fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 11:13:40 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 11:13:40 +0000
Message-ID: <e20692b8-ae64-b2e9-4177-062bf0c937ba@oracle.com>
Date:   Wed, 30 Aug 2023 12:13:33 +0100
Subject: Re: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-11-mike.kravetz@oracle.com>
 <e769f96e-cd03-0530-da7a-35d9de03edfc@linux.dev>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <e769f96e-cd03-0530-da7a-35d9de03edfc@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0438.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::18) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH7PR10MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: df0f19f7-ed0d-419c-9af0-08dba94a29f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKykhuciApme2GYx/sU3NWzHuCxPVwcET7/oLP84Ea7rlfmS4Nua4Jl91hha0GoEG3+qajYwgjMHnK6gRb98Bl0FylGNP5Tm07EAJ+Fe3IkfgBEfLNRUPQVFMclr6ddk/mvwSE+CPuoLmppDb3okWUwiqIj0YbJ2Spq4E5YZu3k+HQn5rB36gUL5pjpekpl8ej+DmjYrUgqP47bHHpynkG3plZY1L0IQb8drMYyybpgeUkqad+l/AwcbcfkcQU4P2qCAqG4JCvWxXxqDEwwFWYAR98vUjTdwb2XPFN5gvYmTll0rh4bawsgy2hOTK4a8VUpxgkWLhs8/rF+LoHkSCop52cnhmSaw8NSxhhEAtVH2NrgDEvVutayManiuCpLKAtgoUZKR/9SuruUXhotjcvH5dUz3Ev3G0gxr66IgLENv9AY9hIkGM80z6RFBQNjt8aJdJe4ls0sJtUucdyXj+upxZhMOgX1qHaYVdq0FBzTqQe5ReuCsVSXZGWuH5nv99X1IRQC0Qaq9N7Zw8bGeUQvSWiA7jhXH3y3W5bsJB54wCf5M1Hp8G+wOtr6uUWK/JS/GyQa5qSN9IUSjqep/YWrQFacHtukov4iza/nT8S+kNtlZ2mzJfeoV7+qhSQdV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(6512007)(26005)(316002)(38100700002)(6636002)(41300700001)(4326008)(7416002)(2906002)(31696002)(86362001)(5660300002)(36756003)(2616005)(8676002)(83380400001)(8936002)(6666004)(6506007)(66476007)(6486002)(66556008)(54906003)(53546011)(110136005)(66946007)(478600001)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUtobEk0WjNkWmdpL0FyYkFraUJHcGNuQzViQloyTGRYUm9OQUkvRVNNaWZt?=
 =?utf-8?B?YlpRZ00xZjljVGsxdXRyTFNOZkRjRWZLR01WSmpYakVpY1hUeWdscDZ0di91?=
 =?utf-8?B?a3B0dko1SkF1WGZxM0o1WE1zZjBhRFZOa3I3U3g4aUxST0p3SEVuT2ExQWh5?=
 =?utf-8?B?eTAydHNwU1hHYXlURWZXQ2JMQStYQWFDSk05bmpRZk5paDdXa1NtWmRCVURz?=
 =?utf-8?B?R3gwTThFUGNQQlJGb25HSTh2aXR5RERVV0ZuRW1iM016dlN0d2pPOGdwMHN2?=
 =?utf-8?B?QWQ1QjdCNmV1Tm94dXBza2RWa2JQTFk5VUtTZzBkdnc5Q0ZPTWtCQzEyaHRu?=
 =?utf-8?B?VndOVnA5ZlNlaUtTK2F1bHYvZzFFYXh3ZkpzdnFPRTBuT0VPNVM1TXFsWVRO?=
 =?utf-8?B?QVVjNDBoY2Ivb2E0amZ3QUljellBTmNFa3Zhc3FQbTFXL0hEYURVaERXZ2to?=
 =?utf-8?B?MW91cmdtclpESnJHd0pXOHVUc3hrZExVTzcxRGVmdXFpN0dNSGNCSVpBaUpy?=
 =?utf-8?B?ekkxVkJacDZCaU1TaGlsQjM1U1dvK29JTFlmKzlyUFZ2VW5YalhmdzZ4Rmli?=
 =?utf-8?B?R2pGMFdONGRnSGRpN2VjaDhDTENYNHhIeVA4YU4vTWNTRFhPRGIvMXNIeG5J?=
 =?utf-8?B?QkQ1TzBtZnl3bXkxQ01iRGxFVFl6bmVCMURJNDFOUkFIL3d5Z1ZiU3k2TG03?=
 =?utf-8?B?cC9wU2NMYnBROE9POXgzTXhRSUJmZmx6UzYyenNINUlwaFdVY1FiYnZPZFFH?=
 =?utf-8?B?czYxNUlHRnJhODNpU0dVeldCZTNMRlBvZHpybUg3Q2drVmRDWVFmejloMUFS?=
 =?utf-8?B?NWtWWXdMN0pCS3daYUVqYUUvWWlKcGp5VVovSjlqazJ5QlVqT0Evbmo5dDky?=
 =?utf-8?B?c2ZoR05pZ2J4L05HWkF3cjNscm1aUjRSaUlkZTRUTUEzaENmb3NURmZNdkRB?=
 =?utf-8?B?SU5CSXc0b1oxNndzK3JLTEhNV3pieUlLMkcrNm04MnVrdTQyRHdYejJNMWQz?=
 =?utf-8?B?Q3c0dDhrai9jV1AycHZmNkpBUkthV2J0NXJoOU9IQytyY3l0ZE5QczYwMU0w?=
 =?utf-8?B?bzZaOEQ2a2RoNHdkYVRPaVg0YnpPZFk4Nmh5eWtlTVhNem9ZeURvcDNUYW5k?=
 =?utf-8?B?MjgzNnZCZ210dkMzQUhMd3Vaa2x4NnkvdTFSY3U5ZDBDdC9FNmJSTjNvZ05M?=
 =?utf-8?B?WlNrMXlWWmcwL2VaNG9XVGZPNVFrZThOREtHUC9TWThRSHkxME9qcHoyaDhz?=
 =?utf-8?B?Y0UrRzlvL0QybGZ2ZnY5dHdrbXhNNURhdm04U1pUN3VkZUVWTlh4czlPc0V5?=
 =?utf-8?B?L3J3R0YxamtCUGZuNXFaV2VyRlY1enRMNjI5OG9KaFU2UDJBSENPeldZN29q?=
 =?utf-8?B?cE9GaXdvcjkrTk1uTHl5L3VLYldDZUpVWnNhdWJWYjNJRWYvWDR4QldGb3Y3?=
 =?utf-8?B?a1Y5QU02TVBpWC82NkxJa2R1cjl1blQ4ME5GSitqYWo4Z2thY2JJTUtWcHFH?=
 =?utf-8?B?OEJGUjI2WEdVN2hFbkpiNm90UDAzNVpRL1Q5MUZiL3pDcTBGVHFFMi9ZU3RP?=
 =?utf-8?B?RUY5a0ZXdUJ1WEdaSzZHd3N3Vm5IWDBteVlQaXFkWU9EVndTaWFwUzVzbWlQ?=
 =?utf-8?B?ZERYdzVtRVAwRTB4SWxPcFllQkJMdVFkUmYyeHhRUUw4TEJ4Q05CdnppTUU0?=
 =?utf-8?B?MjVnRU9vN28zRUExajNxa1VFWWQreXRsa3hzZ1ZFNmlRQjc3eWJuWGlMWUFp?=
 =?utf-8?B?MVNHTFF1Y0ZVTndrczNjUGpzU1hRYUtzdmpzZVdpc1NNdVhzOFJQR3hiNC9a?=
 =?utf-8?B?OTJDMHNXaUQxZ25tZklWaHdCVFlEN3VxK2NyZG83ZkVmNktwY0YySlF5RHNZ?=
 =?utf-8?B?RkJmL3JycE0vYTF3M1RBVkIzSE9KTmIzaVRkR2JVOFp3dG5wNU1DNC9VR3Rm?=
 =?utf-8?B?aThpeDMzczVFTnBzSTd5K3lLSHAwSUJiRFlSTHRzTDVnRE4rcEJTZm1xcklJ?=
 =?utf-8?B?SnZudnY4cno5ZUxzQzRxdVZLRWRhekRzaWpOVlRrbjd2UzRxVnU3RFpGUS92?=
 =?utf-8?B?MTNBd1FQalQvcWdpeGNIQkNmM3c3bnVRQ2tGWFlGMXU1b2RWSXFmSUs2ODJ4?=
 =?utf-8?B?VVYrVVE5eGZNWkZLTmxMSXI5SlJKbFZQY2dJZUNrTkZuOGx1a216bWFqazlx?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YzJraU5FanFIdFJMVWc1MC9EblZUTnJqN3draG1udGFBSTZ6OEZ6YWJNcVN5?=
 =?utf-8?B?WWxOUUF3dmJMdXZkaGpLTkEwbmpqZDVhb29rell6eHFSckxDZlRORVY3RS91?=
 =?utf-8?B?SGpSMHBQd1krTWdYK1EyWU9kaVdoN1ZGdlJ3NFluVkhpZ3dOMVFPUkovZUh1?=
 =?utf-8?B?a0VaVkd1cGVTUURGUmltMVdzbi9NcGZvR2dQdzk2ekFLYzdYSGdtRHJjMDJD?=
 =?utf-8?B?M2s2SWFJODhXeXdyNklaRWpuaHBGaThNdDl2WW1iMHdLQm5aQm5KMktKNUhO?=
 =?utf-8?B?bXhSY01WUkxkRlR4VndTOStPR2x1aDdvT2hHeWErZWpiVjZaMUhnMDRteVlU?=
 =?utf-8?B?NXBBdWJ1MFpSMnJLRDZHbzJCckE4YTFYWDlrOFJubm1KSFdsWWJPMTZpSTBV?=
 =?utf-8?B?ZVNUeGFkUnR3dnBhaG4rdGsyUEU4azlTT0lRMGF0K3BCRWRZZUxhZEpJKzQy?=
 =?utf-8?B?dzNYNDlJY3BPY2JZZnJjVFlHWFZ5MFJteGtBZ1doY05yR3puK0xhcy9TcWEw?=
 =?utf-8?B?OTIyLzl5c0U1SUpZNHducFpCS1VlS1FwaXRUTTdtaUgvSDVVWXV2NEpHUFdk?=
 =?utf-8?B?cTlvNGtIYTVjbWRyWkFvVTVlYjFac3poN212Z1hnVG0vVDQzZzdFT1E3RmxD?=
 =?utf-8?B?RVM3cXUwRU8rdHk3Z0NDN0gyZWZtM3BXTFR4T0hvay9KUEh1VG5ha0N2SHdV?=
 =?utf-8?B?UDdKOGZ6a2VwYVVld1ZWYiszMURvZDh1ckpaQ0Z5dW0wNVNWRVV6NzFpcDUv?=
 =?utf-8?B?N1RuL0twQmlvSEhVU3FjMndMa21XVlRFOFNwRWxLMFgxQnEyMUJkZ2c5TmJD?=
 =?utf-8?B?dUFZaE9hOG5jT1Y2YXU2Qjhlc0MzRHlwQzBEakJEV0g2SGFDUEJyemt1MnRY?=
 =?utf-8?B?SEVjai9NTDgyOHV3TW5vZ1plK0JZRUJld3BrZTBRMElVUUNxRlVmb1FBNGcv?=
 =?utf-8?B?UyszeU9vTlhUbUhJQzFZZmZlNTBXWDZxMWxabjRta0ZSV003R284YlN5RWR0?=
 =?utf-8?B?R0xDMkIxQmlhSkd3YkNuRDUwSzdjOUM5NEtWVHZ0Tk5hbEJUNXA1cVdvZklM?=
 =?utf-8?B?R2w3NE1PQ1VRTVo0dWp1ZjE4ekJUM1dUYXNXM1NPbkR5TlRmSHZDWGZyaUdK?=
 =?utf-8?B?Qm5ML1BHZ3ZDejB4ZEVKSjFidW5HVEtpemxZVXp1ZTE5TXk2anlqc2NqcVRW?=
 =?utf-8?B?NmFUSTY1RXRrOEU4emF2SE9nUHl6SklXYkdPUWp2eXZiWFVCTWo2ODBTZXZD?=
 =?utf-8?B?c0I0SHlXb3c1d1YrN254TTUzb1Y3d3lEdlVxTVdRUWZ2eUFMUUQxa0NoTWR3?=
 =?utf-8?B?c0N1TXlUWmt4NGY1NWE4L0lGeUg2eTNadjdFN0x1cmx1dGpCWGF0SUZieEox?=
 =?utf-8?B?TVcwaFdrZmxidm9GTUxIY0lGb2hwTVk2NUJ2STVxQkhZOEgzTU0yb2VIOVhk?=
 =?utf-8?B?VEZ0dXUxUlBMS1pFSU1BbDg0YjMxTFVNekluY3hIUG1GUEVtNU9Lajl4d281?=
 =?utf-8?Q?3qAWjEQWUWyI4LkwrSCIwtfYBQm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0f19f7-ed0d-419c-9af0-08dba94a29f3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 11:13:40.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dmdpZrXsPZZP+QoRx2glls415t7eAFvsfIcO31/uGxkN3eDSAQkim3VLeP6lgvNtcEbP28r+1BX3QCA+gN0IbCcGbKf6Vio7Kd9JBzFlqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300105
X-Proofpoint-ORIG-GUID: -6wz2yMpg5__vv8zllyh4NFyfIKa2Zcv
X-Proofpoint-GUID: -6wz2yMpg5__vv8zllyh4NFyfIKa2Zcv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 09:09, Muchun Song wrote:
> 
> 
> On 2023/8/26 03:04, Mike Kravetz wrote:
>> From: Joao Martins <joao.m.martins@oracle.com>
>>
>> In an effort to minimize amount of TLB flushes, batch all PMD splits
>> belonging to a range of pages in order to perform only 1 (global) TLB
>> flush. This brings down from 14.2secs into 7.9secs a 1T hugetlb
>> allocation.
>>
>> Rebased by Mike Kravetz
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>   mm/hugetlb_vmemmap.c | 94 ++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 90 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index 500a118915ff..904a64fe5669 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -26,6 +26,7 @@
>>    * @reuse_addr:        the virtual address of the @reuse_page page.
>>    * @vmemmap_pages:    the list head of the vmemmap pages that can be freed
>>    *            or is mapped from.
>> + * @flags        used to modify behavior in bulk operations
>>    */
>>   struct vmemmap_remap_walk {
>>       void            (*remap_pte)(pte_t *pte, unsigned long addr,
>> @@ -34,9 +35,11 @@ struct vmemmap_remap_walk {
>>       struct page        *reuse_page;
>>       unsigned long        reuse_addr;
>>       struct list_head    *vmemmap_pages;
>> +#define VMEMMAP_REMAP_ONLY_SPLIT    BIT(0)
>> +    unsigned long        flags;
>>   };
>>   -static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>> +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool bulk)
>>   {
>>       pmd_t __pmd;
>>       int i;
>> @@ -79,7 +82,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long
>> start)
>>           /* Make pte visible before pmd. See comment in pmd_install(). */
>>           smp_wmb();
>>           pmd_populate_kernel(&init_mm, pmd, pgtable);
>> -        flush_tlb_kernel_range(start, start + PMD_SIZE);
>> +        if (!bulk)
>> +            flush_tlb_kernel_range(start, start + PMD_SIZE);
> 
> A little weird to me. @bulk is used to indicate whether the TLB
> should be flushed, however, the flag name is VMEMMAP_REMAP_ONLY_SPLIT,
> it seems to tell me @bulk (calculated from walk->flags & VMEMMAP_REMAP_ONLY_SPLIT)

bulk here has a meaning of PMD being split in bulk, not the bulk of the vmemmap
pages. But yeah it's weird, I should clean this up.

> is a indicator to only split the huge pmd entry. For me, I think
> it is better to introduce another flag like VMEMMAP_SPLIT_WITHOUT_FLUSH
> to indicate whether TLB should be flushed.
> 
Based on the feedback of another patch I think it's abetter as you say, to
introduce a VMEMMAP_NO_TLB_FLUSH, and use the the walk::remap_pte to tell
whether it's a PMD split or a PTE remap.

>>       } else {
>>           pte_free_kernel(&init_mm, pgtable);
>>       }
>> @@ -119,18 +123,28 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long
>> addr,
>>                    unsigned long end,
>>                    struct vmemmap_remap_walk *walk)
>>   {
>> +    bool bulk;
>>       pmd_t *pmd;
>>       unsigned long next;
>>   +    bulk = walk->flags & VMEMMAP_REMAP_ONLY_SPLIT;
>>       pmd = pmd_offset(pud, addr);
>>       do {
>>           int ret;
>>   -        ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
>> +        ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, bulk);
>>           if (ret)
>>               return ret;
>>             next = pmd_addr_end(addr, end);
>> +
>> +        /*
>> +         * We are only splitting, not remapping the hugetlb vmemmap
>> +         * pages.
>> +         */
>> +        if (bulk)
>> +            continue;
> 
> Actually, we don not need a flag to detect this situation, you could
> use "!@walk->remap_pte" to determine whether we should go into the
> next level traversal of the page table. ->remap_pte is used to traverse
> the pte entry, so it make senses to continue to the next pmd entry if
> it is NULL.
> 

Yeap, great suggestion.

>> +
>>           vmemmap_pte_range(pmd, addr, next, walk);
>>       } while (pmd++, addr = next, addr != end);
>>   @@ -197,7 +211,8 @@ static int vmemmap_remap_range(unsigned long start,
>> unsigned long end,
>>               return ret;
>>       } while (pgd++, addr = next, addr != end);
>>   -    flush_tlb_kernel_range(start, end);
>> +    if (!(walk->flags & VMEMMAP_REMAP_ONLY_SPLIT))
>> +        flush_tlb_kernel_range(start, end);
> 
> This could be:
> 
>     if (walk->remap_pte)
>         flush_tlb_kernel_range(start, end);
> 
Yeap.

>>         return 0;
>>   }
>> @@ -296,6 +311,48 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long
>> addr,
>>       set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
>>   }
>>   +/**
>> + * vmemmap_remap_split - split the vmemmap virtual address range [@start, @end)
>> + *                      backing PMDs of the directmap into PTEs
>> + * @start:     start address of the vmemmap virtual address range that we want
>> + *             to remap.
>> + * @end:       end address of the vmemmap virtual address range that we want to
>> + *             remap.
>> + * @reuse:     reuse address.
>> + *
>> + * Return: %0 on success, negative error code otherwise.
>> + */
>> +static int vmemmap_remap_split(unsigned long start, unsigned long end,
>> +                unsigned long reuse)
>> +{
>> +    int ret;
>> +    LIST_HEAD(vmemmap_pages);
> 
> Unused variable?
> 
Yeap, a leftover from something else.

>> +    struct vmemmap_remap_walk walk = {
>> +        .flags = VMEMMAP_REMAP_ONLY_SPLIT,
>> +    };
>> +
>> +    /*
>> +     * In order to make remapping routine most efficient for the huge pages,
>> +     * the routine of vmemmap page table walking has the following rules
>> +     * (see more details from the vmemmap_pte_range()):
>> +     *
>> +     * - The range [@start, @end) and the range [@reuse, @reuse + PAGE_SIZE)
>> +     *   should be continuous.
>> +     * - The @reuse address is part of the range [@reuse, @end) that we are
>> +     *   walking which is passed to vmemmap_remap_range().
>> +     * - The @reuse address is the first in the complete range.
>> +     *
>> +     * So we need to make sure that @start and @reuse meet the above rules.
>> +     */
> 
> The comments are duplicated, something like:
> 
>     /* See the comment in the vmemmap_remap_free(). */
> 
> is enough.
> 
OK.

>> +    BUG_ON(start - reuse != PAGE_SIZE);
>> +
>> +    mmap_read_lock(&init_mm);
>> +    ret = vmemmap_remap_range(reuse, end, &walk);
>> +    mmap_read_unlock(&init_mm);
>> +
>> +    return ret;
>> +}
>> +
>>   /**
>>    * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
>>    *            to the page which @reuse is mapped to, then free vmemmap
>> @@ -320,6 +377,7 @@ static int vmemmap_remap_free(unsigned long start,
>> unsigned long end,
>>           .remap_pte    = vmemmap_remap_pte,
>>           .reuse_addr    = reuse,
>>           .vmemmap_pages    = &vmemmap_pages,
>> +        .flags        = 0,
>>       };
>>       int nid = page_to_nid((struct page *)start);
>>       gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
>> @@ -606,11 +664,39 @@ void hugetlb_vmemmap_optimize_bulk(const struct hstate
>> *h, struct page *head,
>>       __hugetlb_vmemmap_optimize(h, head, bulk_pages);
>>   }
>>   +void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
>> +{
>> +    unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
>> +    unsigned long vmemmap_reuse;
>> +
>> +    if (!vmemmap_should_optimize(h, head))
>> +        return;
>> +
>> +    static_branch_inc(&hugetlb_optimize_vmemmap_key);
> 
> Why? hugetlb_optimize_vmemmap_key is used as a switch to let
> page_fixed_fake_head works properly for the vmemmap-optimized
> HugeTLB pages, however, this function only splits the huge pmd
> entry without optimizing the vmemmap pages. So it is wrong to
> increase the static_key.
> 
Yes, you're right. It's wrong, it was a copy-and-paste error from
remap_free and I failed to remove the non vmemmap_optimize specific
logic.

> Thanks.
> 
>> +
>> +    vmemmap_end     = vmemmap_start + hugetlb_vmemmap_size(h);
>> +    vmemmap_reuse   = vmemmap_start;
>> +    vmemmap_start   += HUGETLB_VMEMMAP_RESERVE_SIZE;
>> +
>> +    /*
>> +     * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
>> +     * to the page which @vmemmap_reuse is mapped to, then free the pages
>> +     * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
>> +     */
>> +    if (vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse))
>> +        static_branch_dec(&hugetlb_optimize_vmemmap_key);
>> +}
>> +
>>   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head
>> *folio_list)
>>   {
>>       struct folio *folio;
>>       LIST_HEAD(vmemmap_pages);
>>   +    list_for_each_entry(folio, folio_list, lru)
>> +        hugetlb_vmemmap_split(h, &folio->page);
>> +
>> +    flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
>> +
>>       list_for_each_entry(folio, folio_list, lru)
>>           hugetlb_vmemmap_optimize_bulk(h, &folio->page, &vmemmap_pages);
>>   
> 
