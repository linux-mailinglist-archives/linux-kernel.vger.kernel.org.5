Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45521771D06
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjHGJUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjHGJUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:20:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08AFE6F;
        Mon,  7 Aug 2023 02:20:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 376Mvx8Y004775;
        Mon, 7 Aug 2023 09:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Z0CVvQEvg6ajkn5B9y5jOxtMI7um46+kSdBiuL1V1Ow=;
 b=b4+PCJG2LsKWA0W2mgxH0K1/BVbIss2p3oi3MNLHOJMFCyyRpScufbrIxugADz+MAztN
 0IUs17Ak15ayPnQeO5yyKPm1gprCfTAZkuarmFXjjxGVMBNgQGKXpaa+TbYzx9Hq15GH
 noViP/gPMPqLkUO2dGxfhnq1mdpE2P/SVN1HRVRp/kIfl+NHD1Sqtin0y/KQpnk26qWw
 tRYr92g1/yakUgluROkrRo4f5nwJg8nCpz94LE023XQY4T+AyrZhotQc6n2uKpqDMsuI
 eATKT8HNFOldMmTJTkJ2+HkNMy1FIKUWVjlpYncPyQ7jn6A/XW50YR3NlvN644D3hJp7 9g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9e1u2ax3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 09:20:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3778v3TQ027721;
        Mon, 7 Aug 2023 09:20:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv40v5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 09:20:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjlMPB5Av6Srgw1qJZ69Gq1Ws4eYL3oCEP9e1WHRm2yEwIZK04LTt2mT3fRhAZKqfVBKKBVIF4LUmUuC0iIkuOi9TIuSaXdRRjDk7zQ4/tu2qpnfpzPodxMMlxmKnmnykYXE3Mk4JfyM9CkeSza3LCT9k10a/SrdmwVc/1oX4+33KGn0l9sT92kIrVjg0fmJaiD0ces1rYAK18c7rApiUwubvZe/D6FH8Pf13PAj26fOuKSDMyxfRRbKxgDJFUVBhyxcjaKwQSwWKRTzlNa+gDCxkkZOVkvFFl66whUccRKuLNHvAVcdW8K8AUVeuJj+3HhInTo7fyUPnoYAKHOGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0CVvQEvg6ajkn5B9y5jOxtMI7um46+kSdBiuL1V1Ow=;
 b=JsLqhkDKzIzp61+uI60Mo/J3P1RktZhn4sIz5mJVSxi57l5u1AUsP8UIt0cXDpHFSd3xxV6CihGb2odXJlqaSIazljBaqf7N19yxOVeDoNk8dn9nkf5CkoWQLWrHniWH58iWWtMmn35UOCa2Db78SBvZgPkTQEVBQj0f/w5b3wk5AdY9Ewd6+HKNQqOY5MpUY6lCCe0tKspMnt9AEPW/7w4pyQiWPvxW1kcT6Ep5w58OIs8F5d+PFbcrqgqDrqiIUxu8LJyXkjcqTmYdEC+B+jZgUS69Zjiej79mNK34nViiT+DYYXMQcIHccwYDxAGHDfEugtXHWFhRzXBQxV/hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0CVvQEvg6ajkn5B9y5jOxtMI7um46+kSdBiuL1V1Ow=;
 b=rFgd55sl60I0IgXQnEedFi7mG3QFVsp6/BMPAMwMe8AucMgUM9WzRtx1Uw+5i5HpxqTROZijgAtND0dxq2XgzW7Gcg6h2m+Oz1mT/yKIQBFrCTXs3RbbjOjj+aLvhIYtT356FMchZ+vZDtTREwa958lAykP6pvOXF9wgLynqTgE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6916.namprd10.prod.outlook.com (2603:10b6:208:430::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 09:20:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 09:20:09 +0000
Message-ID: <d538966a-4fdf-3712-4b53-f020f4c40172@oracle.com>
Date:   Mon, 7 Aug 2023 10:20:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 2/7] perf metric: "Compat" supports matching multiple
 identifiers
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1691394685-61240-3-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1691394685-61240-3-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0270.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d7e745-1fe1-4384-d0ce-08db97277eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMpiMao4X5S1AJCnOUjmwn4jzXiBO9LJvD4uhKQzQZRr8XEt2tA35H2GpOBGZ8cTnM+M3H0nlcx/0AhClbn3PI3qe4U0NPbU3Q+3BgeQNpYXSxYwmFhFln8PQ/PpyYfPhcVz0Sgej9MoLNe4HfxA3Oa8eHLHGoL4R94Izf8n8wKkMsQly6SqXyeo6VifqodWiWKMn01Sci3rago7MOuAD0GShz2i01elYMbSN9r9l6ztE/QwMorcm7bHNlDIx0dcFX2+OQHPp39fHodKONw4bnrJpC5XGK4RHriGob2ivUbm46Ex9JE4PbqPhxvowYDEdSIKV3eYQGDybMdnp/iJbA/VuYCbveiQGllPevOErdYURTxsYx+OleTFnpqovq9SFYRTqXwGdt+f8kyqRApN6ACEgZNDuFwpXH7iZjqictskNqnfEXceJ+nqX6jjT/aXen/2pjaQf9moCSkTxtVnIZo+konEksGMG8k0jhtj6DMMbt45Hpw6fieoiHO5WvgUzx5DbP8icNRM5qxRis5gbZoaQVr+vUj/Z/1Ld/pm9o0+mxBarIrln7CeNclVSJj956Idcse2dlxm/+qzAueyKpcVEQQkQMVfdjPJr5UMnBNUkFfrGGA7R3R0Ai40GzpZAQ8ePKxV5nWrwhvPrLuO5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(86362001)(478600001)(54906003)(110136005)(38100700002)(6666004)(66946007)(36916002)(6486002)(66556008)(66476007)(31696002)(53546011)(6506007)(41300700001)(26005)(8676002)(8936002)(4744005)(2906002)(7416002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1lwYkxHeXhIaWJtRVVjVE10RUg5c0R5QnpQTGpMVmhIOTV0K0RFeTNkaGMw?=
 =?utf-8?B?THoyVmROZ0wwSnV4Zk9acm9CMWhhWHRFKzJnR2IzTm12M2E1QllWS2RnY3hY?=
 =?utf-8?B?RSt5a1ZxZlVvY0pWbDk0K29iUVFzYkpKTGRoZUJQZnNHdm9NYTlNVDdNSTd0?=
 =?utf-8?B?Z3JZK0tBeFdaZUNCNmkzb3MwZHlWeTRXNGQ1c0NRWXZHOVpxWGhhTUkrTzV1?=
 =?utf-8?B?dURia0IyRmZEbW1RL2QvRXo3WHpMa24zRXZGanJTQWRpeXYxQVFtUzFQdWxY?=
 =?utf-8?B?YXlncGFKekhjaTRaSE0yQXl2MS9TUUtwclZRM2tNdms0U25UbXRIeU9ob2N3?=
 =?utf-8?B?U2E0cDNLbkxSOWorNnUvWWpFUzl3SEhNZ0VYdkdvVE5yRVpJaXJuck1YNGVG?=
 =?utf-8?B?QXZpL0ovZWNNVVpyZ2Mrc3RhdWc1dGdSZDJGMm9tc3FYRi9HNjB4eUhZRlFj?=
 =?utf-8?B?NEp2NlVWUkEwVEhja2NJZlZ4S2UzaHg5cTVPOHhzL1pQM2NHd3dVR3E1ZFhm?=
 =?utf-8?B?alhocUVGWThQYVNLMjgwSUh5eUJjSXBFUVljNWcyY0lGdkc5MHN6VnFRWm5X?=
 =?utf-8?B?YWsyUnpta08xZWtZMytrUGViNU00QzFYT1VVckJhVmJvK3N5N2JsV08za0NZ?=
 =?utf-8?B?OEVSNCtzMkpRdzlQbS9GK0VtS1RZUm1KZHhOUUFXYTBKMjlKTk1rM3pHLzdu?=
 =?utf-8?B?dy8raGtVTjlLOTJ4M0tWMHdDbi9WWGtPbFZnNE8zaHZNdVFleVFZeUFQb2Jx?=
 =?utf-8?B?TWpwMzBCdUVDL0xEZXVHNEs5WDVRb3E2MXB3L0dxcHk1TW9ST0VXVStLUFQr?=
 =?utf-8?B?OGhjU3VtUTdvQVNDSXJuZTJ2V3o1b0IxVlRUWUNwV1dLVWNvc3VxQmJHSjhB?=
 =?utf-8?B?aXQ3Qm1ZRndtM0J6c2NWWGE2ejZDcDFlNDFncXZGKzNiZUNObmgyei9vdm5J?=
 =?utf-8?B?c0Viejg5RmdlekhiZTNJQzlodmFSM0hFOUtyVjlwYkZzNGkyVGJEVWVzeUxR?=
 =?utf-8?B?czNHNXFIZGZVdHpwUVBuOWV0aFhsQzE1KzUzMXZZV0pYVW9adnFpL1dsUTYv?=
 =?utf-8?B?a2VSckM4U3BHcjRsRXVoZUpaUGZpcUlkbTNjS0l6MHJMbnpCRm1FdHE0Tm01?=
 =?utf-8?B?MHhGYTNSZ1R5eGdwaEU0c1ZrRFZQRmY5OXlrNDU0MXBGRkFPN0FBWXNLOTRv?=
 =?utf-8?B?NHQ4MTZNUHkxb3dGaEoxNlZ4VzBoai9lWHkyeUozSkIzVHJ6TkU5MmRoeitT?=
 =?utf-8?B?ZW1HaHRCakdVc21LbTI3Y2pvUHhWQkxoemRqdTdtVjFXOUhCWGNPQXlGMjRG?=
 =?utf-8?B?RkZ5MGVVcndFWmNKS1Z3UHhLbzNrNGRaS2kvaFlyNmhLZm1ZZ1lscFF6YmxK?=
 =?utf-8?B?OWRhTzduVE5OU3hNOUdPUTBKTG9uSFpOTjBJTDZBU29NQS96MzkxWjdaUmtt?=
 =?utf-8?B?SEF0bDdFbkZmOElPR0xSUkxTQVpGZUNwS0p4NUxtTnkyVHNxT2d0SjVrODNB?=
 =?utf-8?B?bjB6cXFlUzgwaUQzVllSZjJleXZCS0pwOGJRS2xOblVoMGNKSXZ4UGJoYXJo?=
 =?utf-8?B?TmwzczZsWW5xZnpFa2Ixc25xbFJQVGROSEVibXZwYkh3Nk12R0VTaW16QmxQ?=
 =?utf-8?B?NWlscyt1THkraDhDcTFzNXlETTZUaDNrRWpNVEovTUtlN25leGYwY0lKQ04r?=
 =?utf-8?B?ODB3S0pDbE84MWxuRE5WK0RsRExLSG50WllseXgrTzdjb2FuUHd2UlNubFJX?=
 =?utf-8?B?b0w3ODl4NW9rWDRTWk5ZbDRVRFl5dytvWkxlNGlXaFBjcmxhTnRLUmwxWC9O?=
 =?utf-8?B?RFNuTGxkTTQ3WlZIeDN2OHF0d1ZMK3J6Q0lGdkcwRWcwZktpVXFnc3N0ZjFt?=
 =?utf-8?B?cjVZR3JGTDFMazdkOE84MEFuRVIxTmYyRmlKK1RpQnVJY1Aya001R2sxQUp5?=
 =?utf-8?B?ekd6b3VGaW9peGhiR3pEc3ZqSm1BcGVzQlBKSDRGMjRNUnQxbHhVNUtZaUcw?=
 =?utf-8?B?cEVwVWRmRTdIUFlNWDF2Q09nUm8wQ1lvWnU4b2EvVzZMM2FQckQ5dkYyNW01?=
 =?utf-8?B?eGxhL3ljbDRDeHNuMUFFNTZjczJCS2pvMDFNQmYxVWZHRzl6YXBkNGlhKzJ0?=
 =?utf-8?Q?m3MPrw8ZlbFg7/h45oYgi5rjx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?enJScDB2TGVrNnRPVU5PM3lHQ2puVkMxRlBnczV1dmEyMERWRVo2KzJmcldi?=
 =?utf-8?B?RWdBa1dCczR0QVIxZ0x6dHpuQ0cveTl5KzRsMFhKYlAvTGVySloyS0RMdTBT?=
 =?utf-8?B?YUczbE80ZithQTNSV25oSUVMMzhNMEFNNnkydENzSWdXRXpacVpGbVpNelFz?=
 =?utf-8?B?cWNPM3lLNXZlUHVUWEZJSU9tRUF4VnBqaXNYa1Rna2JpdS9XaDRoT0t1djRL?=
 =?utf-8?B?VWNPQU0wb1dVOE9YYVBJUUNULzUvLzJUK2ZFSUJuUzJUbUt6MVBHWEJYKzdi?=
 =?utf-8?B?Ri9wQjRBaE5LR29wRFgxd2ZNY2JDczAwd1VxQTN5VU9IMmd1cXUweXFXOFZs?=
 =?utf-8?B?ZlVKV0kwUTRiWSt2QWdkQVB3UnVkdXAwSDVPM29Vek1ROERub0FDVmpVVzho?=
 =?utf-8?B?Um51YkE3NHNxaGhuTXdza29nMVBFUER3cU5zSzl3WXpSYzI0K2d0Z0g1Lzh3?=
 =?utf-8?B?UkdjL3hkN3lFem9vdVRyb2xCcEJBbGY2MzhKMGJtelVRTnVKTi9RcWkxR0dD?=
 =?utf-8?B?TWlFU1k4dnFEelRIU3NyL3lmei9FckRxVWZnSXRiMkRXYVA0MnpxTlNGUkxm?=
 =?utf-8?B?blJHTFhKUVZiY3h1NkFjdWsyRGhUdEI3ckJ3NVpDTTVPcnJ2NzFRbWRReTBK?=
 =?utf-8?B?M013a0xPcEY2VnRubnlzakNNTHhSN0xmUzJuTkc0bEk4UklTLzlpSG9pSnlH?=
 =?utf-8?B?cjhSNUpYMnkzbmdpbHRNVXQ2UEhaN2l1dUEwby9UNmlGcnlUTTN2dFZ0UHAy?=
 =?utf-8?B?UU5RZ1lIcG05RDEvRlJvOUkySUhCK1psWlFtQVBmbUpLSVpOYkFHQ1AxdDYw?=
 =?utf-8?B?d0ZWSEdMUHZEY2dYZTVJcWdvdHloVHE4RTJNaGdzRC94ODNFNEcrWjhnS1Fm?=
 =?utf-8?B?NUlSOTVxa1NuR3lQdVJqOUM4Z2tVeENJTFJtQlI3SWJtb2k2TndaRERDdnMz?=
 =?utf-8?B?QzRhN2wxZFc5RzRuNnpmR0EyNmZrQTZRSlpjV042YzZoL2hlTjVRUDZZbVMv?=
 =?utf-8?B?aWU0RStzakE0OWZjYnB4ODlmeXFiY1NjVHMrc09zeXRSMVkrVFF4bEtKZG1j?=
 =?utf-8?B?bmNzc1V1YmpUMndZRjl4SjNTa3cvV3VDanZpK0xid1dOMzV3SVZXM29taUJZ?=
 =?utf-8?B?NGZRaXhES0JGQ1NtMndIMTRCdTNDQmx2eFJuUkdyaDhIOHpwU2FiVDdEM2pk?=
 =?utf-8?B?OGFPVWpZQU9tNnJUZ1haNkNiU25TR3V0emtzby9kdHdpZG9KTnpYbU56eHRl?=
 =?utf-8?B?YisyaWJVMFFoRGhGaVNtRERjNVZPdHBtRVVvT2NiYmJzdXZvUDk3ajRsSHdB?=
 =?utf-8?B?QzBWUE9yLytOdGl2VGJadXJzbnJsRysxc293aVA4ZkovajdxLzY3N0JOR3VZ?=
 =?utf-8?B?NVcwUzVtQWtPSmlTSUVRYWd3TW51TjkxSjFtYzZlckRzckgvNmxvTWFkblVv?=
 =?utf-8?B?bmpIWExsSnBRQWhWV21JZUhiQy9FN0JtOHZhS0UyOXVkeGF2dURFYS9USlBm?=
 =?utf-8?Q?RGy2kI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d7e745-1fe1-4384-d0ce-08db97277eb8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 09:20:09.0510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvqSkR77TdqUobN/MzcUNaRsUesAV0r19TPQSuS8XvL7Hctq1/0He+vO40pVN+UmYOUOZ4wJH05pxKkz6dbdmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_08,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070086
X-Proofpoint-GUID: -0XcIxRoghgL9IhjanWbjDJqm3bKFWdp
X-Proofpoint-ORIG-GUID: -0XcIxRoghgL9IhjanWbjDJqm3bKFWdp
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 08:51, Jing Zhang wrote:
> The jevent "Compat" is used for uncore PMU alias or metric definitions.
> 
> The same PMU driver has different PMU identifiers due to different
> hardware versions and types, but they may have some common PMU metric.
> Since a Compat value can only match one identifier, when adding the
> same metric to PMUs with different identifiers, each identifier needs
> to be defined once, which is not streamlined enough.
> 
> So let "Compat" supports matching multiple identifiers for uncore PMU
> metric.
> 
> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
