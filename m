Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED667745F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjHHSt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjHHSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:49:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEE56E85;
        Tue,  8 Aug 2023 10:01:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3788QvqB003084;
        Tue, 8 Aug 2023 10:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xZChMu+a2Mf0XA6oA/IcYS1NTIrhmrLDKTUF+QCb4X0=;
 b=FdIpLkDggVYpoNPl5KZNtlBU32F3kS+U/+stF64qATVs5fJ2BCAgB1hQ3HihEr5mPNS4
 RHL9XxJipMWZTGdhFihBBsz0qXNSuJ6rfDq5RyyXHMlWDxEip6PZa4bUi9MVR+d4fAPw
 Dt/0nwizsItRrjQxhWfBE1P6afI+LRSP11xC3rwZZlDPk788gtNrUqKgfTLSRsRUW343
 cWYoWMiaY5INYmEr/yDw0HlvyEq8uzVTXpfLTilfb4bOErueMsTY2+llzdBc/+aKnNZ1
 ESRJfZa5aQjCkyjPuvvXSiIsvK4bVoKHv0Jve791mUh7XTJV+M3DI1ziVab7JM9SNqWd Vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eaams7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 10:18:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3787xcZt027685;
        Tue, 8 Aug 2023 10:18:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv5k63v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 10:18:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/bGLgHF/EAd9XXI6IdsMx4Xz/7ujAgbd0JQEJnyuNSDl5kpB903TVes9TETkPDahqd1PewG54DUV/8ETi6GEkJ/PR6Cx5J1t0eYwpaSp6HfqDchwFdPqDGKMbyEuCh5umng8Y93G3piqgqT66zArQIdFDgerWam64vKaOwS4Q2L58h7mOPga667Z6kUeC9VOhR0JAjp38nLpQUvz0eZRFEwKRu6A5C54MVz/AIjHuqjYAZCav34aqRj2y91GRB2Yes3d7FNrk5jFMbJWO8VdI0QI/nQBkSSRFfgKlvvQO5cCWt4RmsCMmWg4/YO+G8TZD46uPGDnarUCh/3Ui45kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZChMu+a2Mf0XA6oA/IcYS1NTIrhmrLDKTUF+QCb4X0=;
 b=Mq1r9+jwOOmr8oyAyFAV1YFBqXuj4EzEqBBBJejLmt7KtXs37PIpqMfYDTBy2q6sGItCoTswdmzUQqs/AjMLhA/4icOhcUyptoe4ZTLcghq1yRwONDi9O0ofuq01EaCTj4kL8JcE5ziunbx0jm/A/EvdDB7Da+vDIAQr/Ld/4pX/H5N4A/N7Qx1PK/U+k2b1axaQxL+fONyahTJ7TSGlEd9XuBcltrhg+q8O1aRu57tTT5jT2FfS16GUVcWTlUqByEkrQtreBb0jS0ZdDCqQ208eUdFGEt1szbFyfRsFhFlDdP1y/bj0CG0MnRV95Xq2xjht+nqEJcP7fPvqrpyVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZChMu+a2Mf0XA6oA/IcYS1NTIrhmrLDKTUF+QCb4X0=;
 b=opvWGe/hgJYxPE9MRW0VYJsTv79D7I4aulCkXzASJZXw55k3qvf0q2H/57F/3VEf89B/vOKcZeE82ypAtdCuWbosiK7cxh0RJc573/a/OVeKvH+wcF8TcX3puTdeFuo+Bn4lJbJGFMYuBbzcGRn5GUgNLrE+TGC9uYGY+NxsQXY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7510.namprd10.prod.outlook.com (2603:10b6:8:166::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Tue, 8 Aug
 2023 10:18:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 10:18:06 +0000
Message-ID: <6b3d8f28-9a38-d544-e396-706022f2e5f5@oracle.com>
Date:   Tue, 8 Aug 2023 11:18:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 5/6] perf vendor events arm64: Update stall_slot
 workaround for N2 r0p3
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230807142138.288713-1-james.clark@arm.com>
 <20230807142138.288713-6-james.clark@arm.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230807142138.288713-6-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f490876-7973-4b0a-e4c1-08db97f8c1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKbr3Rfj1fHDOCtAD1CZoRab6dxbeq3zQZX4jvZNxAJvdsV4p4VLHI/Y60gI0OLyDNFabHb/cxuEi6eQIbtoylv5HQ9dnKvgYkBb/1xtkGrYyCfzz1rzMsHL07fORDCUNGYuwpUZGOQNcARRsEzW3hmk2XeQJUIJjposju/+iGY3mxiQTcHP3ESbw6ekKIYC19KPxUhd57JQMueDL6y5GfMn86m7HgBK8g3671z1XqlD0L3lF449IekSkus+5WxypkjdjQ9wSgiBUgAmiiexSo9UksLVANHsvZglcftrd+0DCLLRp4TDa/8OCV5H3yFdEd+tJsE+Nrb9aY8m2MFMMoqEo10ugUIO7DrygbmqEG4Y5nZ/4Bbr7i69NdGjCFh/n8fNOemrN8YjZ8QhQu1R7AnYvLlcKoMtXES2H7azNb+RDpRh3i4WcOHBiGyuMIKzdsFSmQwTREGkn7XQHBtN0u6wnC2OmKlWwD6jcNGDtxyLaJCm6WHf0xgXRZ3uAT0wVkAle6bPTcfsxAX8WeGC4zCvynsqPBtWVkUPOdjE/nnOKyKTwSD6M4smO936GPKAfdGd/14HaA1j17k4fEHuhmlIti/y2tqZA+EHAvqQjy6wIeogEDSeXnFuytjtMwDn0l3LwCcB/RZo2qu4idBLFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(396003)(136003)(186006)(451199021)(1800799003)(31686004)(83380400001)(86362001)(54906003)(478600001)(8936002)(6666004)(2616005)(2906002)(41300700001)(36756003)(5660300002)(7416002)(6486002)(31696002)(6506007)(26005)(8676002)(53546011)(6512007)(66476007)(36916002)(4326008)(966005)(316002)(66946007)(66556008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnFVN2MveHpaRGJJdG5oNTBzdUZ1K3JPNWxSd2tqbjl6NHQ3UDBNWVdzS25p?=
 =?utf-8?B?OXhMaXlsSE5qeDBpanUxLzBqUEdySDhOeHZ5SDZzZGRiTHEwZWF5OUtCdHVR?=
 =?utf-8?B?NU1Eb0V1QllzZ2FZVjFUMUpRRDZPRnVScW1wWDBkRXg1VWFNRXhFSi9xdnNT?=
 =?utf-8?B?QkFlV09TRnd6Wk12VFB2bHpHdk80UEhtcVRSNURVcWJkdS9iY05UekwvNnNF?=
 =?utf-8?B?RlFNaW5kbC9xTHNjYVZZUVovR2pGU01QNHdOQVdaRzJ1c1V4aFJlVFQydlAr?=
 =?utf-8?B?Zy9uN0FmbklGTlBhSWh3VFlzUWh3ckZlTFo1OFhhR0V5SFJ0QmtmY0JDUlZI?=
 =?utf-8?B?RThEZDNQM2U3alQvVkxHZWlDQjF2VjBxckJCTktjWFJnRTlWMmdMa0gxZnBL?=
 =?utf-8?B?a1RkTytWZ3l5dlFyQWQ5Y3FGbUwyNjBiWHBUdFpjUUkwYTZFY3JQNUZsNTU5?=
 =?utf-8?B?ZlhkV0hlYUxib0FscXo1ZnlxVy84QnZIZmFzc1dpV2hMbUNZMFBrTDJoQW1P?=
 =?utf-8?B?cklBOEcvQWtlS29YdUI2Ujh4dEs3ampMMWFTbUVNbmRqU1Jlb0l1MTJtM2Q2?=
 =?utf-8?B?WGg0U1JBeGdmK3RlM280OXlrUU8vU0ZUUm1XUlBXaDRtVlVpc2VqTU1tNjFF?=
 =?utf-8?B?YmVpSWcxMDQ5bzlSS2lDOEZDbVdsUHl1RVlLcC9sNnUvRFROWldJZlVFUFBx?=
 =?utf-8?B?Zm1rQ0taSVFsYXhMdlZhbWhlZ0pkT08yNytKUWxwOEtocTRpU2JuTm9lc3M0?=
 =?utf-8?B?Y0Vtb2E4Uy84OU13VERWVXJkR2ZvcWZKRUF2aGJwcUJiTjRKcnZybUdiUFBi?=
 =?utf-8?B?S2c4VGs0NDZVQkVBaDNGSWlrTldNY2JZSVhTbUZGbytiU2tmMUdEL0pwdFFt?=
 =?utf-8?B?RGs5ZVJHd3RPNHNlQVpwYktRNzBGamxMMTB5RlZWWXgxdFdhOHoyeGtEdHA2?=
 =?utf-8?B?ZGkrdEdtMDJab1FuSU9ZZEZJb0h4emNzc2FsaXIxTmJrY2RRUWJFYS9qLzRR?=
 =?utf-8?B?bHUyWVUybVR2MzVuVmtDOXFSSXo5cFIxQmRMK0VOUUFQWVJmTnBseGFZQ1Zs?=
 =?utf-8?B?bHdhZDIvZnpYZldYOGNhL0RIOGhnRWZpSisxV2pVdEZ3YzczZ3VSYTRzNjhS?=
 =?utf-8?B?SzAvZUJyMkdJRjh4SXdCNElCYkFZSkZROVcyaktHRHAwMlF4Z01Tdk84SFV2?=
 =?utf-8?B?OVBiUzN3dVYya2hhVEZXVUh2UmdlQnNubUFoVTA5VEpyUmtiYUg4OWlGQVpX?=
 =?utf-8?B?c2x3Z3EzTzVZSXZ3ajFaMGlic3NRNWNsT1ZzTWJzNmVxZURPaFNvYmxnL3NM?=
 =?utf-8?B?OFcwQVNXNlM1dlhRZUNHR3FaQW1PMnZRMGJTb09SZlN0LytYYkhNZ0piRUpY?=
 =?utf-8?B?dmtVYTlkamJhUndlOHNYRWowZFR2M1FlTTVaWXovMUNxMjdYVHBSWmFXblF0?=
 =?utf-8?B?QWxHTHV5WWdpRUVJTTNHM05SQ0huSXk4OVpQQXFvcmVTeUxEVTF2L3lPM2pj?=
 =?utf-8?B?UnVOQW9DNGU4SmtNWTVBUFlSZmk3TEI5NjlMZkEyVjNKL1J6RVBSclFuSi9q?=
 =?utf-8?B?MHZpbm5nWHBBcy96T1psanlWZkFaSHFvK1NnTXZWczF4K2VGdGtldkZJTWw1?=
 =?utf-8?B?cXhVNTFZa2I2bFZrSVcwNG4zKzVSRlFacjJsSlE3NDdIbTU2cEJuR2l6QjU5?=
 =?utf-8?B?elRYbnIvTXNVL2xvRllhUE9JdGZ3UkQyV3BiQkx2Z3RFR2tkYS9ocWFBeWI1?=
 =?utf-8?B?WHNOQnFjU3B2NmwvQ29BK2lCbCtDTTJuRU5IUEFRMkg3cllnZzM2TTBTa3hW?=
 =?utf-8?B?a1FUZmduTnkwK0dteElKNXNIUStRRGNubzEyRklDTTlZNW9LaWFsNEIrWHdN?=
 =?utf-8?B?eEVkam5RYVZJeUFoUmkrM3NWcFdwMFRnRytjTmJMV2lYSDZ4OTVJN1JaMVJl?=
 =?utf-8?B?OTQ5YjhLNXhLV1BaV0JoNXhLYmdMeXE2MnF3ZklxSFZHZUs2WDJnTGlyWEZy?=
 =?utf-8?B?VlloMVplUmVNL1QrUDlRNzgwNGVPTFA2VEJxWEE3YmhaTitTNWFuNkphRjNS?=
 =?utf-8?B?VmJsa09JTnJpTkhvSEFwTjE1cElwcG5nUnpCVWlpUWJOUkdmWDN1SkZmaUow?=
 =?utf-8?Q?lfm9VkSt3J70bnQx7uUc98Y2T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S1ErQWFzQUlvdHpLTkNYRjYxZ3VYbE1LVWhHbXZGai8vaERzNU9hdzdLb0Jh?=
 =?utf-8?B?N3FrWmZmT0NNNDRZcnZHa3orUjNabzl2TGJhR2d2RjFldThxM1Bja3JLeWNk?=
 =?utf-8?B?bmpmOFh2dFlxaStOM3NzczV3dHFMd3pSSGRNQkJEdUZGY1h3bm4zNVlRY04z?=
 =?utf-8?B?eWZ6YTB5cXBzSTA0VzcwYitPek91M1d2T2xzMVhVRGVYZmh4a2lPaDF3Y280?=
 =?utf-8?B?SHB5em5nNEo3QXZXdWpqYkxKekFyVkp5bkNJMTBtYmpzQ3kvcDFVdkRuSisr?=
 =?utf-8?B?QVNueHBqZjREMUpVTFFidWUxRjRzWmVVK0VoV1ZjU0R6NEZHK2x0cjNwdGZG?=
 =?utf-8?B?aXU3SGZYMEo0RktVZnN2cnl1Y0NkNkRJdWtMV05VU255SVcwYWVQNDZpVmtX?=
 =?utf-8?B?MzVvaWxWUWVzRWlnaGFBdCtBci9zcmJoVFBXZmRrOWJmc0Z5d0JveWF6Wm80?=
 =?utf-8?B?NkVaTkFuT1lqSXdxTER3eGd2VzRIVUd0T1pYWThxR2x4TDBWVFBpWWl0OG5B?=
 =?utf-8?B?Rm10MnMwNTBBOS8yTXBtNnVQekJZNW9oMEljc2FYV1JHQWxOS1BTRVNYekor?=
 =?utf-8?B?RFNsRTR4cjlHOFJ5bXpVQTJLL0pMS0ZPZjhmWXp1VllSMW5XZXVaN0hCS09n?=
 =?utf-8?B?VzgwNTJzajVVR2draGU5M3VWQ2lnLy81QjVJUWlQUjQ1MG9VUnZYUWwrM2F2?=
 =?utf-8?B?R2p6YURHaDdRRWhvREY2Z0R0UG1rRmFIOEN5bE8zMmtNQjJzQUo4UHpkMCtv?=
 =?utf-8?B?a2VoMG9sbDluUnRJL0JHN0d2bjUzR3Y1MmpodXRIeG54RmQzOHNmVFExcDI3?=
 =?utf-8?B?RXh5ejdLRHNUNHd5YU9WVTEwMGJzMi8wR0JJSDlFZE1ramwvWlNGVVc0djFv?=
 =?utf-8?B?OGtoL05ockw0QWFBWkp3UGN4ckl3aFhiK3lCZDZZYXdmakNaVmUvUnl4NlV4?=
 =?utf-8?B?T0RCdnRaUUtRMzhJMy9UMWlEcFFhY3E1VUZDOHVRWEZFMzVIcWNvdUg1c0RN?=
 =?utf-8?B?SmRJVHpqOWx3OWZSa2p0RnlxV1lvckJrMnkxak1yV0U2OXlOM3Z5UGV2ZEN2?=
 =?utf-8?B?ejMwQ0IrbVo5TW1DbjYrZUQ0VmxZT3h3UFRZTURIQURFV2oxdE1KY2MvNVRh?=
 =?utf-8?B?dFMyWFg0V3NYRkpxeE5TdUdKWU0yc1BmeHMvMlBxaWZGZkdEUjJKV0lHWlVI?=
 =?utf-8?B?U1VpUG9KRTFsbThRQU16aEhyQVZSYzh3M3F0QlhxT3Azc3h4Ym9rU1Jzd0Jv?=
 =?utf-8?B?MXA4eEYwM1kvY3Y3dVNNWmRZWGpiS0hRQVRhTi9taGpCUkdZQ3B5Mmd6ZlBQ?=
 =?utf-8?B?VTkyZnFUcjdJM0tWTDZ6N1NNZmw0Tm5qNHQzaWVXbUNmWFFwM1E2KytsemZG?=
 =?utf-8?B?ZEVrazFoQXpza3hnKzd0WENPdTJTU1IwSHAyMkpmS0VqQU5YQ3VVT3h3OC9N?=
 =?utf-8?B?RlZlSFJNWnN6MUFDVDJ5eFFuTSswcm9LMm9ZT1YybEF4RHVRQlR2MWkvWnZp?=
 =?utf-8?B?bDkxYmlacUdtSElvZjBqQ2wzRE5HWXhFR01BSjMxUHA5MHg5WlIrWVdISjg2?=
 =?utf-8?B?YnhnZXcxV2tkWk1PaWRhUXdZQUJJc3VzcEZFWFI1azlrRGJrZ0FpUElZSzNi?=
 =?utf-8?B?c1J2U0krQTNLa1NTM0w2VFByY0lBSUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f490876-7973-4b0a-e4c1-08db97f8c1ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:18:06.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJnMOx5UoF9jJFTFL2+zP4thMK68R821/tMnPALpalAp+lc/rlAOjo4h3Zs1uQY39bnxuHQ63Mf6hMX5yuVAVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080092
X-Proofpoint-ORIG-GUID: 8Vo_fqoWY8czo0NifTrHibD85vs0MqwT
X-Proofpoint-GUID: 8Vo_fqoWY8czo0NifTrHibD85vs0MqwT
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 15:20, James Clark wrote:

Hi James,

Thanks for the effort in doing this.

> N2 r0p3 doesn't require the workaround [1], so gating on (#slots - 5) no
> longer works because all N2s have 5 slots. Add a new expression builtin
> that identifies the need for the workaround correctly.
> 
> [1]: https://urldefense.com/v3/__https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2-r0p3.json__;!!ACWV5N9M2RV99hQ!Nx1xgWXXS9GBasNpOKQXHWKe8VwpRB0h8lAfOmwUmkkOQTjFqn2NswO8ti8vTcblUfAYN9NAtxqAh-sf0TEOvQ$
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   tools/perf/arch/arm64/util/pmu.c              | 21 +++++++++++++++++++
>   .../arm64/arm/neoverse-n2-v2/metrics.json     |  8 +++----
>   tools/perf/util/expr.c                        |  4 ++++
>   tools/perf/util/pmu.c                         |  6 ++++++
>   tools/perf/util/pmu.h                         |  1 +
>   5 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> index 561de0cb6b95..30e2385a83cf 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -2,6 +2,7 @@
>   
>   #include <internal/cpumap.h>
>   #include "../../../util/cpumap.h"
> +#include "../../../util/header.h"
>   #include "../../../util/pmu.h"
>   #include "../../../util/pmus.h"
>   #include <api/fs/fs.h>
> @@ -62,3 +63,23 @@ double perf_pmu__cpu_slots_per_cycle(void)
>   
>   	return slots ? (double)slots : NAN;
>   }
> +
> +double perf_pmu__no_stall_errata(void)

While I like the approach of encoding the per-CPU support in the metric 
expression, I find that literal "no stall errata" is vague and could 
apply to any "stall errata" for any SoC for any architecture.

If we were going to do it this way, then we would need a more specific 
name, like perf_pmu__no_stall_errata_arm64_errata123456(), but that 
should not be in the core perf code.

Could we instead add a function to check cpuid and have something like 
this in the JSON:

"MetricExpr": "(op_retired / op_spec) * (1 - (stall_slot if 
(cpuid_less_than(410fd493)) else (stall_slot - cpu_cycles)) / (#slots * 
cpu_cycles))"

I'm currently figuring out how cpuid_less_than() would be implemented 
(I'm no great python wrangler), but it would be along the lines of what 
Ian added for "has_event" in 
https://lore.kernel.org/linux-perf-users/20230623151016.4193660-1-irogers@google.com/

Thanks,
John
