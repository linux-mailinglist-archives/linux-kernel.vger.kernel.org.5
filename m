Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908E87938BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjIFJqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjIFJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:46:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EBC19B1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:45:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3869Z1aw011420;
        Wed, 6 Sep 2023 09:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ivMdj4oKiW/+4wV4sn4HUoWHJ60CV+OjPBuMmnFQwvw=;
 b=ZSW2HeE5Bae3/mcqvEu1ddLzESqBR1eb4ZUrJJKfRlmb98DvY6oDQai4ILXtDkNa++eK
 ry8vDjpeE1+Qe/qNTQeEvqbR/D3kdWpPB4uopwt/xmTiVidl+V/hF/Lo4DYdHWkrOX2a
 6J7m2mCfDU05nqnz32/a8q69rEMYOqdQmYXe2oE4Y1rCw80aAEoP95qnLEH0ua0eTHpm
 jJOvLTPQj1nEdThY3nrptja5v8GlbGMQQhlZK8CCCbbK78doSE/IGtHjLr0jVI4wu/ad
 vX/cAHCK8VMHeKPDwSny45l7PfuUDajDoNGLabdS6V03K31cHNbAH6QfyHYrdx+fyA6n Tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxpwqr0qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 09:44:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3868sr1Z010443;
        Wed, 6 Sep 2023 09:44:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugc7xk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 09:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC408/nPOsyt64AQlS+TW0QUWpJiG/jTKUXwZIlMa37SwazD4R7mB1kLGxe2Z2K4Ko+3G71enyZ/CUupCNWv6uODCqnvmZLhqnruwynWnxMq1ZB8lhVx/nh+Yxoc8WHy2WD5QxB2ffRBZbQma+QNwQ2XXM6WDWwFxLXI+oPPG39wdtFIHiZ+G/JTDmnM24exCWBePUHcekwfs6pKsr5ToCVhymnKQV/u0Zxqvhq/lNTQ+8SlujHhB8AfqgBa9iM49Ob9t/9g7GCab0IkssXSYSzooVTxfLYmYOitAxI+5QeILZVD3NC2jBrjgXs+zjnFGPWVMAuEo5JrY635lAp6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivMdj4oKiW/+4wV4sn4HUoWHJ60CV+OjPBuMmnFQwvw=;
 b=Wfr5ilNkdupsN9f0EePePUg1BN1r5XwU8STcG6ScHuHNy1QSsJD+shwhBvxBW4zcbcArQJhR3WBUITAhfR7bGFGP+n+E8k2nWy0WR4Nrq1N/6lhsBv3ZVoGb+ATLoa9OU1S1aOJNwqu41xLhEibwETDLA8LG9FxxIiqh20U5XhJ2sbgDQGGKpTZy0t5Kc9zgq7MMTNpbPebU8WNt2J7Eq4XONOxTtwAhlCzq1dtSoV9Zo1kSgOD7Q1GfwRt4wZMJop/RJ2BiuErQe2pOCe143m2k4YRsuqByUJx56fFsu0R+MJ4zmA58MWhFY7ZYAVNLl9OWjlt/NS+K0Dc/vLsQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivMdj4oKiW/+4wV4sn4HUoWHJ60CV+OjPBuMmnFQwvw=;
 b=kP5zhK5THLoNvOLIfoxMFYGbGHSkmI0D1ueLJwo7jfxmAfYDRB2Bx6o8RR7GaXJHy4DV8TvORN1Y5ff7OK2uV2RHWW/9WR2LP7N9pqnEDUUUX9ATLPE9zn3Syo0QAFlIYhKdzG/wldvssaaetkCUQbzo7Hv2QrqLwfOx/AvpF7g=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CY8PR10MB6802.namprd10.prod.outlook.com (2603:10b6:930:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 09:44:23 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 09:44:23 +0000
Message-ID: <ab9132b2-34bb-de9c-05d9-d927a435c99d@oracle.com>
Date:   Wed, 6 Sep 2023 10:44:15 +0100
Subject: Re: [External] [PATCH v2 09/11] hugetlb: batch PMD split for bulk
 vmemmap dedup
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-10-mike.kravetz@oracle.com>
 <0b0609d8-bc87-0463-bafd-9613f0053039@linux.dev>
 <CAMZfGtU2HX4UR1T2HW75xY70ZMSOdzNZ2py=EggoBYqP_1+QFg@mail.gmail.com>
 <2e942706-5772-0a93-bab3-902644c578e7@oracle.com>
 <D58A4D84-A397-4283-BB24-D31A27809DF3@linux.dev>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <D58A4D84-A397-4283-BB24-D31A27809DF3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0354.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::27) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CY8PR10MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb3bc95-f096-4e56-ea01-08dbaebdd9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPMGW+jxbr8Is3cdM3Z0uDze/XTnmJe1kV3QVJBFQMpnuxCxeUpqoOS7tpEQUNkYWAHFyuwaohO1ZdLtItz4aqCoeQmJZutwQk8y0MlAZMRo4Dc6gYyIzHmusTPTLrhwJND4KuPVL44qKEeqHtjPauDCB4Rj2MZy9qYrMGbO9SuXWADFPgS1N/fuTBhXvvP/wO2NVbOGpG6zLGFE73XXJviPWWvgBE77dxcJ8OlvB54b4MPcQ6MEGkOLqeAudEKFKUXKWqu0HoNQ4IXUQRRfNIhSJbPBGfa3CzGDWA9FxM3CRIjbxG3VdKVPSTadn+RM3m9Zz/IFax0yNkIir1YaZgWdccrU1/vABrzRbkMDbXeDiggKZfirVDvpkvOsXAfGg1phiYkfJy8Uo6lxK3MVoP1zFl9EsoHv3LXuZh5h/Hnz2r/v7fCpDmPDfw8vMMHpjgoQhuRwutPiZfiASYCLXoNk+dJHeb//CNVgVZvv2pqSePcpl5NY5MkQ7aaN9hXNzvPxVNI7IqKLs5ggD0oGR1Pj9oRs1dF9oUYX9CM+vW2Pbui/LwIG6ItSfCma3aFTiAWbNQjsD299cKy3AO93pZX5MfvXogsFaiLNqQpxhB+WnzZ9mbm7N8z3/Fhs5vdj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(136003)(366004)(1800799009)(451199024)(186009)(6666004)(53546011)(66946007)(54906003)(6916009)(66476007)(66556008)(6486002)(6506007)(316002)(41300700001)(6512007)(478600001)(31686004)(8676002)(4326008)(2616005)(26005)(5660300002)(36756003)(38100700002)(2906002)(7416002)(8936002)(31696002)(83380400001)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGE0UjhadWRGVWVvOHlsbnU2YWpQL0Y1MUxnVWZJNmsrbTc4Z2NNVGhJREJk?=
 =?utf-8?B?V2taeGF2SkF1UzZyM2FMQTBGblVNYzMwZTJUQnpyWnhIK3FRU1ZpKzE1MTgv?=
 =?utf-8?B?RHBEYVk0eENvWDZBN05pRzd6aitqU091WFA0QUhpdHkzeldMMzBPKzNmSEpp?=
 =?utf-8?B?OWpMc0lIZVA4YThidTc1UmhDVGdiMWw2SXdmSG5OSlVLazNCQUF0cjJJQm04?=
 =?utf-8?B?MzlJaUgrMEp6ZCtwZ0JjSUJGY3FHOUZYZTJ1Znk3S3RpVnB2VFlsQlM0Tm9x?=
 =?utf-8?B?Y0RDZGpUY0xOaUI5ZC9DZmZBeERZcTlqWGltQk5vNmlHVm04VmE2Q2hqME5k?=
 =?utf-8?B?K1lpaTNNYndaSnFKVi9tcStaSDlLak5UcWxwMlpDanJ4dGcramFrQmRSc0Qz?=
 =?utf-8?B?alpPUi85MEpKcExLRjA5YmtIS3crci8yZ2dOUTVscUEyNjhjZ2pEamcwWEZr?=
 =?utf-8?B?aHYydG9YdlAxd3BobXR2Wk5JUVN6Q3ZKeEhGdHF6VXdwNElhQXdSQnJPeU9U?=
 =?utf-8?B?WndlcUN6Tlp3eVRwVno1TUF6cjcwZkw5RERGaU9mU0g2NnZSSkljWHJOM2ly?=
 =?utf-8?B?TGt3T0VsNTZxNzluQWJPK3VtbVBuZThPQVd1YWkrTjMrdE1BcjRDT3pjcjhB?=
 =?utf-8?B?aUF0Skl1ZnExcnV0YUxqOURrczBYcDJNMGcyUVp4cmtKOGlYc3hYN1l6dlY5?=
 =?utf-8?B?RFFtaEk4WDdQRmZyUDF3RkNmNnU3eWZteGUxMEtwSDVvS1NzczhkcHZQMlIx?=
 =?utf-8?B?cE5hTmh1bDVpNkduaW03RjlzaTIzQ3ZCSUxMbHM4RWZpVDJFY0diRnZOekRm?=
 =?utf-8?B?U0NGU0hON0tjdmZ2N1JuREVLTm9uOVN4YStGWDJXVDR0cjlGZ3JPT21wSUsw?=
 =?utf-8?B?N0NVTFdkY3dDSlBxTnRlNGI5aldKYnd0TG5RRFB3bGE0YWZwTjhZcDRtQkdh?=
 =?utf-8?B?MWJjVkVINUJGR0VDM0UrL1p0ZkxUZ1lWY0VKb3RwNllyY0RpbVV6bTUzMm1L?=
 =?utf-8?B?K0c5bEV3RzVnSi9mWDVKS0lUa0lnWmVTa3BSVFJvQ3B2TmRtWlpYK2svelcx?=
 =?utf-8?B?ZkVlOGVvRXgvaTdiYU04SWExa2lMSDQrUzhaeWNuWVp2SDM4WUxhS2JqK3cz?=
 =?utf-8?B?bDM4RHhHa1hDNjJYb3U5emlOcWdNakY1ekgvRnllczA5dWNoVHRJM2REd3pD?=
 =?utf-8?B?ZDZSbnpKa1JPbzJwZWIzSllXOEtsdEtKM0gzdUNOWGhoNGM4dzlyWU1rWm1K?=
 =?utf-8?B?eGhkMzRMK0lSTW4xNDdTMjhBMTBhbEEwcXlTL2U2Z1VnbFp2VGhKdG05bjIw?=
 =?utf-8?B?RkU2TTJ0RzdUc3NHOU8zTi95YWg1VDBTN0dvSzlZTUJDM1B4b21KWDFsTTRB?=
 =?utf-8?B?bzVqeERGblpGcGRrMDFhZ0RidmxGZkVSdFpydnVSQ1V4L1JjYkwzOTNSRS9j?=
 =?utf-8?B?N0hNdmdvcnREOC9Fc29Md3V3QVdQMEkveXhsMGhGbmoyQVV4RXJ3SXJsUjRr?=
 =?utf-8?B?RE1BbkNTaStPU3JDTTlSRVdUUVhROHN0MjMySFhVQTFUMHRuRG04MUE3QURx?=
 =?utf-8?B?cWdqSWg2b0F4U3c4MzU2Ym1iZ2toQWZxQmNxV0k1UzF2RElXZHRRMEVwQmVX?=
 =?utf-8?B?NjF0eDVhOVBzS2tBRk4zUU1qaW01aHlWRWpVTGR4ZmE3Q2RaTllwV0RFaWVh?=
 =?utf-8?B?czBrM0ttQ25qUDYvV2lWZzNvQmM1TWdac29LQm0yMVVyY2lyRlZsQ1ZnNW8v?=
 =?utf-8?B?MmZBd25ydUF2OEhkWXV1L0RCaHo3dHBlQmEvaWRRbXVPd3BSSzBHNnB0QU5C?=
 =?utf-8?B?QXByVlArdDZlN04rNWozR001YysrNnB0L245cklVMTE4RWhIdkhIcjd6WU8x?=
 =?utf-8?B?TzNyZ2tNQ0xUeG4yZWVNcWJubEx1SHlEK043M2dmNHZxN0RFSHFaZ1dMcWY0?=
 =?utf-8?B?Z2h5L1UrZGlraXBMYzYvNEt4UnorWEtLVlpmNmpYTEtadGhMeU5jdGIrV05Y?=
 =?utf-8?B?SEVJVGNKTnh5eCt5bTd4dEtGdjRzSENtd3BLMDEyMDVDaHk1U211bkt3dWw4?=
 =?utf-8?B?NG5yQzgrcXkxTmYrMU4yVGEwbHNIa2pCaStQZmlwUVAzTUJjWU0zRDBaRkNL?=
 =?utf-8?B?SHo3QWtsOXdiMGYrZVJGYnpMNDFuMi9NQ0ZIaVpWcU1HNy9JWDErSVl4MCtU?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VlhEM1VNckhCT2FBNlFTaHJBMzJmaThCd0k3NHhIeHYrL1FDSWc3SGVuc3g2?=
 =?utf-8?B?YWoxMnNXUkJTdEZGQ2JpeGhHKzUrdlBwV0phUm5NMnhPUmx3TFpOc2diSWc1?=
 =?utf-8?B?dW9mb08zZU05VGkydUY4aU0vV2NBV0hRM3c4S3hnZmMwSElXVlNmS3lnK0Zs?=
 =?utf-8?B?TlduSkI3RGptaGJSMnZNaE5HRGJqL0xueVFnOWNXc1ZYVHB4VElaNUlMNmtL?=
 =?utf-8?B?SXhsZGY0VksyUnc1akpUZzhHT0JLWFk0YStQR0NlVitKS20wVzVDdWVYRjFP?=
 =?utf-8?B?M2kwWmxmYnlQM013WkRudm9zTXgyaWNPajBPVTlqM21scjMwVkhFMWh3eWFj?=
 =?utf-8?B?YWhZU0oxUFV0elpoWXFUTEpPYURvL3FMK3NBMFJJL1NxL28yNFFlWDlFNnhh?=
 =?utf-8?B?azhCUzZvL253cXFIdC82dmdRT3RUVytOUnhScUJNQVVVZzRFSG82cEZqZ1Fm?=
 =?utf-8?B?VFR1T01xVU5ZOCtCbGFZV0JBbkJVWnZtREwzOUlBN0NZc1UzTVAvSnhjcUdh?=
 =?utf-8?B?YUtRVWZxcmJHQjRvemJnZTAwRnkvZmxuMXh2M1VheW9xdHBNMW9pUUdHdWZm?=
 =?utf-8?B?V2VQRUNpTHZ0NWVteElrSnFxTDFqcENRY0VXUzV0cGcxUHllcVRONVJ6V20w?=
 =?utf-8?B?MER3K0dhclhiMklVNGg4dFpIVWVUT3l4d0QyYlFUYXg3a0RUWjkwaWFueHR5?=
 =?utf-8?B?SmZXUzRSZkVnZm1Pc3ViWDRwb2dRS3BMSjEyYWpHN1R5TEJBY1REYmFNUURT?=
 =?utf-8?B?TDlCL3JKTXc0NWx0MkVOSC9GTVl4M0o2dDUzT3ppcC9ERk9sUjlYbWwybGRK?=
 =?utf-8?B?VDh3WW5EdEcwdDlUNVNudU9tR0gvWWdSaC9rZWdWSEVSaHY2SU5PcXpBc1ZW?=
 =?utf-8?B?UC9TZ1lJbTFLR3JTaXZWb0tJMSt0MHd4OVhUdld6bGVHZEMyZCt6MUgvaTNH?=
 =?utf-8?B?ZVVmNFU0TUFrYlB5S1p2US9rdHR0UUdKcW8xS2k2NGQ0dHl5bmxNWVI2NGNL?=
 =?utf-8?B?MnVmRzVPeHVUUVhoUGxXRXJkMUZBNDcyZHhtSDdUbmluRkZzUkFJSDk4UGlj?=
 =?utf-8?B?cjcwRG54SHNzWnd1c2V3ZGI2ZkxaYUNlRHlnNWhxSk9IR3RYR2VjUmwxR0Iy?=
 =?utf-8?B?YjA4dVIrei9nUjVrRHJLTjFUb1RqZFRUSms5cERIcEljSy90SFVXeUJhc0lV?=
 =?utf-8?B?ZjRqdm44UXkyV3JQVmNRSEcxM0NKYU83NnlyTitWbDM0cytUNlRwNHQ1T2Rl?=
 =?utf-8?B?T3FOVlprSHVPcmpHbHJZZlZQL3BQalNzd0ZqeW14S01YWGRFdWRKTk1iYjBN?=
 =?utf-8?B?V1NoQ2FsazR1Qm9JVXAvbVc4dGZGWWRKV3NuYUhRSHlaUmc1YmU0N25XV25V?=
 =?utf-8?B?OVFlRVk2QmpSNk5VM0lCckV2OCtybzFhcWZmUWZVcmEvKzJ5a3NLVjg4ZEVG?=
 =?utf-8?B?Vkw0NHRLZnVCd1VTSVIyMG8xaloyM05IdUtQYU9nPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb3bc95-f096-4e56-ea01-08dbaebdd9dd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:44:23.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bNoyFf7/bgDqsWnx37gg9fC4MsVg3XVBblUBE3P46Z6Ly6WdR7EjFIpItoPIlrBdr7CXNH4nii1eCvK5jLOSusfVnmHq2OBqL+8ABDmCqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6802
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060081
X-Proofpoint-GUID: DejFIx3jeeHwCWZjt_ooH_xiZeXqA-S7
X-Proofpoint-ORIG-GUID: DejFIx3jeeHwCWZjt_ooH_xiZeXqA-S7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 10:32, Muchun Song wrote:
>> On Sep 6, 2023, at 17:26, Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 06/09/2023 10:11, Muchun Song wrote:
>>> On Wed, Sep 6, 2023 at 4:25 PM Muchun Song <muchun.song@linux.dev> wrote:
>>>> On 2023/9/6 05:44, Mike Kravetz wrote:
>>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>>
>>>>> In an effort to minimize amount of TLB flushes, batch all PMD splits
>>>>> belonging to a range of pages in order to perform only 1 (global) TLB
>>>>> flush.
>>>>>
>>>>> Rebased and updated by Mike Kravetz
>>>>>
>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>> ---
>>>>>  mm/hugetlb_vmemmap.c | 72 +++++++++++++++++++++++++++++++++++++++++---
>>>>>  1 file changed, 68 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>>>> index a715712df831..d956551699bc 100644
>>>>> --- a/mm/hugetlb_vmemmap.c
>>>>> +++ b/mm/hugetlb_vmemmap.c
>>>>> @@ -37,7 +37,7 @@ struct vmemmap_remap_walk {
>>>>>      struct list_head        *vmemmap_pages;
>>>>>  };
>>>>>
>>>>> -static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>>>>> +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
>>>>>  {
>>>>>      pmd_t __pmd;
>>>>>      int i;
>>>>> @@ -80,7 +80,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>>>>>              /* Make pte visible before pmd. See comment in pmd_install(). */
>>>>>              smp_wmb();
>>>>>              pmd_populate_kernel(&init_mm, pmd, pgtable);
>>>>> -             flush_tlb_kernel_range(start, start + PMD_SIZE);
>>>>> +             if (flush)
>>>>> +                     flush_tlb_kernel_range(start, start + PMD_SIZE);
>>>>>      } else {
>>>>>              pte_free_kernel(&init_mm, pgtable);
>>>>>      }
>>>>> @@ -127,11 +128,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
>>>>>      do {
>>>>>              int ret;
>>>>>
>>>>> -             ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
>>>>> +             ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
>>>>> +                             walk->remap_pte != NULL);
>>>>
>>>> It is bettter to only make @walk->remap_pte indicate whether we should go
>>>> to the last page table level. I suggest reusing VMEMMAP_NO_TLB_FLUSH
>>>> to indicate whether we should flush the TLB at pmd level. It'll be more
>>>> clear.
>>>>
>>>>>              if (ret)
>>>>>                      return ret;
>>>>>
>>>>>              next = pmd_addr_end(addr, end);
>>>>> +
>>>>> +             /*
>>>>> +              * We are only splitting, not remapping the hugetlb vmemmap
>>>>> +              * pages.
>>>>> +              */
>>>>> +             if (!walk->remap_pte)
>>>>> +                     continue;
>>>>> +
>>>>>              vmemmap_pte_range(pmd, addr, next, walk);
>>>>>      } while (pmd++, addr = next, addr != end);
>>>>>
>>>>> @@ -198,7 +208,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
>>>>>                      return ret;
>>>>>      } while (pgd++, addr = next, addr != end);
>>>>>
>>>>> -     flush_tlb_kernel_range(start, end);
>>>>> +     if (walk->remap_pte)
>>>>> +             flush_tlb_kernel_range(start, end);
>>>>>
>>>>>      return 0;
>>>>>  }
>>>>> @@ -297,6 +308,35 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
>>>>>      set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
>>>>>  }
>>>>>
>>>>> +/**
>>>>> + * vmemmap_remap_split - split the vmemmap virtual address range [@start, @end)
>>>>> + *                      backing PMDs of the directmap into PTEs
>>>>> + * @start:     start address of the vmemmap virtual address range that we want
>>>>> + *             to remap.
>>>>> + * @end:       end address of the vmemmap virtual address range that we want to
>>>>> + *             remap.
>>>>> + * @reuse:     reuse address.
>>>>> + *
>>>>> + * Return: %0 on success, negative error code otherwise.
>>>>> + */
>>>>> +static int vmemmap_remap_split(unsigned long start, unsigned long end,
>>>>> +                             unsigned long reuse)
>>>>> +{
>>>>> +     int ret;
>>>>> +     struct vmemmap_remap_walk walk = {
>>>>> +             .remap_pte      = NULL,
>>>>> +     };
>>>>> +
>>>>> +     /* See the comment in the vmemmap_remap_free(). */
>>>>> +     BUG_ON(start - reuse != PAGE_SIZE);
>>>>> +
>>>>> +     mmap_read_lock(&init_mm);
>>>>> +     ret = vmemmap_remap_range(reuse, end, &walk);
>>>>> +     mmap_read_unlock(&init_mm);
>>>>> +
>>>>> +     return ret;
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
>>>>>   *                  to the page which @reuse is mapped to, then free vmemmap
>>>>> @@ -602,11 +642,35 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>>>>>      free_vmemmap_page_list(&vmemmap_pages);
>>>>>  }
>>>>>
>>>>> +static void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
>>>>> +{
>>>>> +     unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
>>>>> +     unsigned long vmemmap_reuse;
>>>>> +
>>>>> +     if (!vmemmap_should_optimize(h, head))
>>>>> +             return;
>>>>> +
>>>>> +     vmemmap_end     = vmemmap_start + hugetlb_vmemmap_size(h);
>>>>> +     vmemmap_reuse   = vmemmap_start;
>>>>> +     vmemmap_start   += HUGETLB_VMEMMAP_RESERVE_SIZE;
>>>>> +
>>>>> +     /*
>>>>> +      * Split PMDs on the vmemmap virtual address range [@vmemmap_start,
>>>>> +      * @vmemmap_end]
>>>>> +      */
>>>>> +     vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
>>>>> +}
>>>>> +
>>>>>  void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
>>>>>  {
>>>>>      struct folio *folio;
>>>>>      LIST_HEAD(vmemmap_pages);
>>>>>
>>>>> +     list_for_each_entry(folio, folio_list, lru)
>>>>> +             hugetlb_vmemmap_split(h, &folio->page);
>>>>
>>>> Maybe it is reasonable to add a return value to hugetlb_vmemmap_split()
>>>> to indicate whether it has done successfully, if it fails, it must be
>>>> OOM, in which case, there is no sense to continue to split the page table
>>>> and optimize the vmemmap pages subsequently, right?
>>>
>>> Sorry, it is reasonable to continue to optimize the vmemmap pages
>>> subsequently since it should succeed because those vmemmap pages
>>> have been split successfully previously.
>>>
>>> Seems we should continue to optimize vmemmap once hugetlb_vmemmap_split()
>>> fails, then we will have more memory to continue to split. 
>>
>> Good point
>>
>>> But it will
>>> make hugetlb_vmemmap_optimize_folios() a little complex. I'd like to
>>> hear you guys' opinions here.
>>>
>> I think it won't add that much complexity if we don't optimize too much of the
>> slowpath (when we are out of memory). In the batch freeing patch we could
>> additionally test the return value of __hugetlb_vmemmap_optimize() for ENOMEM
>> and free the currently stored vmemmap_pages (if any), and keep iterating the
>> optimize loop. Should be simple enough and make this a bit more resilient to
>> that scenario.
> 
> Yep, we could try this.
> 
>> But we would need to keep the earlier check you commented above
>> (where we use @remap_pte to defer PMD flush).
> 
> I think 2 flags will suitable for you, one is VMEMMAP_REMAP_NO_TLB_FLUSH,
> another is VMEMMAP_SPLIT_NO_TLB_FLUSH.

This means going back to the v1. I thought we agreed to consolidate/simplify
into one flag, and use @remap_pte to differentiate between split and remap.
