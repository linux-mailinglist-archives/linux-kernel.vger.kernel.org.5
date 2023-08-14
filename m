Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3458877B967
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjHNNIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjHNNIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:08:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D74211D;
        Mon, 14 Aug 2023 06:08:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiarw026755;
        Mon, 14 Aug 2023 13:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gq+cjWyOk/QIXZ3QQvrc223LhprCW0nOHbTRa5xXx0A=;
 b=KxSqw9N9EfmxyBmPbiddHzy2GvsxdZK2ngJS7E0Wdwj6rm0vUmERQtyvZH6eYPyXFevG
 ecRBfv5gVBBQ9Xqj6eAOxDQiMXxRZGj/WseTyIuHT6cllDND/di78kHNRrinuY94Tt4O
 sVwiSxPq1kChHzxpSkLRsj5hMi51HIznDQ6rhOubKhuVDayzIylb0B864SeF372aIea6
 e3l0xMqw/BRshEABN215OalSOtm9nF7vZ+mQkTUjT3bi+cbIp/9BpBQHkA09dWLy4NQv
 rF+C7HCstANnA7n3LzVmbM6DD2/pdMxw6X7BwUHSnVfxp2XxgkU6OYYO7jKyXqgyNhTl qA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwjj3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 13:07:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EBUIKs003745;
        Mon, 14 Aug 2023 13:07:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexygm8n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 13:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx6F5V4hEThUOOd++Qphbb5x1gsdaoAlJU64sjvOKYAmskjeNi7uQnQBDHOPSW4Ic1eVTxvJm2scONOW/v6xYXxPJ2n7yaRcAMWOw3sOUlcLgxq6gkMpIUGVkvTwAU8sz8mAyEuwY++vTgjdB94cjk4Kabqu1Z5MfCbdX+F+5aXaHPSVR5JkNi+yuAs2OnhGAc18CZviuR0TVvULpWyo57YckH+cqv7KEMnHLgrYPOD9wAUX17TuVDAtTtW/a1anf0r/UMpadcQnM8Vjp50ET5BGUYXOv+MLwyeXy7+41dh7t0l6so/OEj+Lg22Lat/hbfbsU2+DZaPS7UHq6oEdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq+cjWyOk/QIXZ3QQvrc223LhprCW0nOHbTRa5xXx0A=;
 b=NMCd8NDyWQhKwWz654NM/YKanpUuVuxJec8vTu8Ki6ytmi2DkWA2RNrc6xFve2HuG33V4o6aX+j4+WDbfStEBqVdek81ZdjXvAcAAc2/46uP+QDT+FvPJo6IOx/CjjjEUiXCsPeFrf2vLEzY2iTLnctOyIzZA0lPRRjocWWNLR1IQ9QoZxe/uPQb6ofQjGmj9SOI79JdCRSKYQTaEKt1u1iqQxvpPq4bZZdIy1SluKwFv3SjZgUEhjDZPR6bTvMdEMdVVol1rHofJ8jjZSYm3Q/uUbR4posyL6AxTgX3v/zYglV5rB2MqgmqSZG+bAToKxSQmrok4XQtZ3roxsfCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq+cjWyOk/QIXZ3QQvrc223LhprCW0nOHbTRa5xXx0A=;
 b=z6aHM9FfzitENnNeQu/UgC/266DW+R93EYRRckT1wug1LMITz/FnJEsK3fE/xg/dSOHn9kBpE3wXRIcyTzz86oBCetqyc4bKwqPU9CU6SwEGCeBIEMMKFS3wfaW0eMOqU72r/TIAMn9xaDqlI6QF4xpwZu0ccY6tJSlu7crM3w0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5246.namprd10.prod.outlook.com (2603:10b6:5:3aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 13:07:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 13:07:23 +0000
Message-ID: <47a32410-d9ca-627b-e8a3-f64d4a1ea95f@oracle.com>
Date:   Mon, 14 Aug 2023 14:07:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 2/6] perf arm64: Allow version comparisons of CPU IDs
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
        Kan Liang <kan.liang@linux.intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230811144017.491628-1-james.clark@arm.com>
 <20230811144017.491628-3-james.clark@arm.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230811144017.491628-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0458.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd308d0-5b0d-4bb2-c381-08db9cc7663c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vt8hlFrvZxG13gdGBbGn2+/A67vPzXIZVLZJQuY/T8fcEDMpxdDOtV04KgeYjkLKNOQD2z87Zzi6R/U2+GCTjoofmMyyTNGSbdKWevTB376DNVtDdIL+cFZ4F0Ld+9TQPIlBxoNHr2Vw1NSmyGiBP8wCIEs+J42rOfU3pV247vYP+jyAk9TnLgPA7jpjAU+XC3N2oXrcrPqGVm1Aj7EN99r/DVKWW9uTFVbVTkCWKR5qWGpyRpUC7wFFzQ8wVfjkih4NDn/m0QegqzYMReH1keBnMivh72QU+aQNR0e/8T+EHgHKcCYNuyC6ryEeBKbnS674FdSVmmZYRPI9MnIAJG73kZYoafTXIAeZ+koyOV0h5BQy0JfcieYbSC3EiAeWbUPnK6Bct3Px+RDNq9QwmJT2We427d67Dme1J9MmBa0a8s3bcM447Bro1D1IPS9hfY/kDWg1l+5FmEk2sUnc3uwf6XJQE0XOf2aFWJWnz0oR1elxSYwfqAlK9EViL5QJAenGQt8H7o4F7dnqTb2kv4v3A3Y0Teuu0ZXqT5sPFVSYtNaxWFAi+H61RTXDz1zlGnoG7fXyryK7YoMwkUuUiUCQAFCH+jPzRs1dsxH7Ws5ISY/TE9UTsFm5pbxVUGOAgooCgk4jr5/GaaSfTPB7Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(1800799006)(186006)(451199021)(36916002)(6666004)(6506007)(6486002)(6512007)(53546011)(478600001)(2616005)(83380400001)(26005)(2906002)(7416002)(54906003)(41300700001)(66556008)(316002)(66946007)(66476007)(5660300002)(8676002)(8936002)(4326008)(31696002)(38100700002)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THptMlgwTVhZcUR6Y3ZwTDhIOFFLaWRINXNWWEN0WGI1NExkTVl6a0xtWUJR?=
 =?utf-8?B?NHJ2cUpqbERzUUkzSmw3Z1psTUdSb1luMys3VWtnYTdlMUxEV0hXOHc0OHJq?=
 =?utf-8?B?bXNRdzhaejdjb3ZKRzFrTXdnZGtrcllrVjVEb3I4WHg3RGNDblJnSWQrVjRN?=
 =?utf-8?B?VVJ6QnArS2xyT2lkMVNRQ1pRNHpodEtZKzg4bzdlaU10WGZVeVN5S2xXc0lZ?=
 =?utf-8?B?OVZQVFVQbjdGajdyZitJcHBycFBQRXNlWTNycWxPdWRaNmZDREd1ZFFVa1lp?=
 =?utf-8?B?UWtYblNid1AwZXJHOHlzTS85Z0c4aDBDdlhGZGc2MklibVdUL2pEZGEzTXdJ?=
 =?utf-8?B?ZWlvWnoxVFFMcUpaWktpQUtFQmpMeUdxZkVadmsyVWszMm1oN0IyUVFWaE9i?=
 =?utf-8?B?MEpMd2h2RHhoMmQyZVg1enBYOWlHSE15WS8zL0JRQy8yZmdTd1MwR0RYM3BD?=
 =?utf-8?B?U2ltK3NUYlhqbzJIODZIS0o0V2p3R1UyMmNJVjRscW5kY0JEbEVabmpZZGFC?=
 =?utf-8?B?azJ3RlRLU3BvVk0ydVlEQk5JYlJVazBwQmJ0TXVkMFhGSTFMU01qV094WTMw?=
 =?utf-8?B?d1hTZzBkSlZINXp6RkxKQW4vNjJnVGZsWFN1Y245bUU3KzB3UElKdldxM1p5?=
 =?utf-8?B?RjVIcUdZYWFMdUc2U25XTEZCcG5FRGpFSXJBRTY3MlI2RGtpWFdlUjZPYTlX?=
 =?utf-8?B?UHBudGN6L1ljVDJrUFRTb1JFajFOc0k0M0NXYUpBK1Z6c2dJeVBvQnBTZFpq?=
 =?utf-8?B?bnNBNlF4b2ZYYUk2TU5NV0t6MmExekxMT25wcU1YeFFEbHFmNm9BR0xRUzVm?=
 =?utf-8?B?UzdOYWVYTUpLQVZWYkZibnZocC9hbjNMUmNXdndnRE5QYVM5Rm94WCtjaXRp?=
 =?utf-8?B?b2o3R3VJOVl0cGNDMG5GSmNTaEE3L0FQak9BaEVON095cDY2WGlET0xpK1RJ?=
 =?utf-8?B?NmQ3RWQxVXRZSDZQaXZlSmI5UENnTE40ZnlxQ3FnOXNvNEUycVJ1N2xydXlU?=
 =?utf-8?B?M090QmM2empBaEdyVlR0YlhaMFRPWGFRRUpnQ3gvV05LdjJ6SGhNdGU4THdY?=
 =?utf-8?B?YXRuc0VRMDhNYnlUQlhNM3pyNlFJNithTWpzV1ZBaFl5NzRRZ0N6RTZ1WTdS?=
 =?utf-8?B?K0JkUlk1d3JwTm41dm8xY3ltWk9IUG84M1phdGk0Nk9sK0xKdmg3NzJXZmxQ?=
 =?utf-8?B?enl3aDVZbS9oZ0h3T0RhUnBDMllmcDhxQStIZCtpYmRvUTJobkd2OHF5Ykty?=
 =?utf-8?B?aVBnZjUwQ08zSTJZcDZlcUZiTmJ3UGVSSjBROUdDN2dFamNNdnd3Q2NJYjRY?=
 =?utf-8?B?STRqVDVDaXV2U0plaVRHUGtBSUVIeXpPdDMwSzBMS05peUFuSEIxL0N0cThp?=
 =?utf-8?B?TGsxT3Nmdm4yWnIwWTk3eDB4Zzd3bHV2NlFsS1p1Z2FiOUE1SVVJZGhTRWpV?=
 =?utf-8?B?eWlEZitvejMrejhBZFUvU3E2dDBWY2lzMW9aMFRxS3RvaDJVaGR6L1d2Z1o5?=
 =?utf-8?B?YnhHOUpoeWJXZWZ1SngzR2h2OXVrb3Q2Y1FkbklBOVUreXhkVm5HUFFGVnJX?=
 =?utf-8?B?OEJrNzBKVmk1OEVPRWg2YlAvN1VBTTJYTU9Ea1ZJR0NEUWtjNFlidmRnUDY5?=
 =?utf-8?B?LzZQdmwzZW5tY3hQdHlRdXFSYzhlL05ta3Vzb3VMOG1ETThyYWpzY2NaZjFk?=
 =?utf-8?B?Z242N2I1NGIxcG9TQTJGUFFoYzBTcHZORG1jQnduZm1FUXdjamNzaUloUDJZ?=
 =?utf-8?B?K29CMUdHOE5SQ1A4RnJrQ0NiaHFMb2tQWDN6eU16eEJsZ3FGRWJUdHFabjVw?=
 =?utf-8?B?SXZZUm5iOFZZQStJTHdKWUxjR2NrcnR3NlNkSU95Nmd5eE0yNm9kR1owYlhr?=
 =?utf-8?B?MVRyVE11cTFMZGhybGRLeURFVGhIRUUwdG1rRWJzQkk3akRTLzVESk1HZlFK?=
 =?utf-8?B?ZjRwK0xXMmxheG5LU1Y5OGZTTVZ6clI2UDJWOFN0WDZXZ1p3cnpjWmhiMW1i?=
 =?utf-8?B?YkRGSTd5anRGL2lPVXg0WFBZR0FsWEJMRUFFc0ZKRlIrd1pPelczQkxKTXpn?=
 =?utf-8?B?Qi8rWkh0Y2RQdVh2Nmp2eHJ5MFhRdGpwajBmT2UrSE5iZXdGenlaSHJIQlhG?=
 =?utf-8?Q?JvAwafRu7B2lL6uEmd746WQon?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MUEzQ0xYam1oQ0FZN1R5RzZFclhaZFNRWHIxWXp4SUgzYVdmM0ZNQmJrcGRu?=
 =?utf-8?B?Y2ZqZk9HYjhxU2NVcVAxd1R2dVdjWk5HMjdOWUgyUmJ4L01FbkZKY0wwK0lC?=
 =?utf-8?B?d0NOMTRuZW94dWR6eGZ4b09UVWY5V2pnckpBSGJ0THpQUGsvYzRTR3RWSmVt?=
 =?utf-8?B?OUxpWWdYaTVzRmt2aFdCbU81NFdsL25TbzZORlc4VWlkb0lVYWRUSlBGQmFi?=
 =?utf-8?B?UytramJFZUIxZ2pXakRVQmtjamlPcXZQUERIS1BPUTluREcwN0d2WWp3eDlk?=
 =?utf-8?B?WlJ2WERsZjFTL2VpSVVuZXY3clFYTmFuYXRsc1ZScEd0T1pxM1JhbXFaU2lo?=
 =?utf-8?B?Kzlqang3a1pzTHluamMyYzI4TDdpS0hxYTBwTXRWSzM0QnlRajRReUZvcmdV?=
 =?utf-8?B?dlhHYk5JZjFiM3J2cVV2ZjI2RXVOVGZNeVo2NXdKSXdZOHFaYWpLdzJvWW9Z?=
 =?utf-8?B?VWM4U2U1Mm9zeHBncVZ1V281M052WkJrczBWallBVjIvOU5PWWRFenRRbUta?=
 =?utf-8?B?dWxQc0JraHQ5S0NiU1E3VzAxdjk5T1FLUmRKbk1WdXlmbDUyNEVqUWVaU3pW?=
 =?utf-8?B?N1FvR0YxWURZb3AxRG8wZ0Jzc0c3dWozaFNEYU9XVjRWWWg5a3lZVlpGVVpB?=
 =?utf-8?B?bXpMZVJZbXQwcmxqeFhZMER3elRRQlNZM0JLK0Z4dkZiTXhRLzd2eG9xTHRz?=
 =?utf-8?B?R3Zza0tvaWhya3dNclJWS1U1alZocTJ2UDE5SStZbjFLeHNKT2k2SWNwbnh3?=
 =?utf-8?B?ckRuWklVazAycWpydzJseDdHTGtQU3Y0UjRHTTJHZEZrczM2dkZ0Sk1waTM4?=
 =?utf-8?B?dlBvUVZrMS9CTlNoZ3QzS2dhSjlubm10NTdUT3NMOXVvdmpvRGRBZXJRVDMy?=
 =?utf-8?B?VnREaVhFbEdpSENxVzM3WG5IajdHTGJ2NGtJNHlrcC9XNVJlOHJpenlNSFFL?=
 =?utf-8?B?REJBa09mWldhOENYSVV2ZHozeW05QjNkaFZJZDRIdUxmQ2xzVWRtcEdtS3BH?=
 =?utf-8?B?TitkNk8vM0dTZUNQRXkwa0VLMzlpTE5JUll4TjM0VEQ1a211b2pIY3hqK2oz?=
 =?utf-8?B?dldWVVlqL1ZQbHJFNS9DOCtQSGVwUDdBL3hYL1BvT1BySVRQYUtVZ1o0ODNx?=
 =?utf-8?B?cGwxaWZDU3lpTXdYVjdDVWdFQWtPWnNkVmpralRQYzJ3dFM3ZUxyWU84QTZw?=
 =?utf-8?B?SW51TUd2cHpZQnRrMzMyNy94Tlp3MlpaN0JyeUY4QmpVWWpHdE5wM0xHZGI2?=
 =?utf-8?B?KzVadjlHbzJUcGhoNjZ1TnhlRFdOWjJLYmR0ZGRrS1BHVUx1YU1HOHg2bGhs?=
 =?utf-8?B?V3Z5ZEZBRmxzKzR0cEZKd2hycnhDeUVsSUFVbzEwOVJlK1NGSHl3RXFWYjh3?=
 =?utf-8?B?NFlsVFp4V2FRODhvMk9TekkrSllUamVCK1M5NG9jczZTaG9pOHJnRVUxRStC?=
 =?utf-8?B?dmxLRUM4MDBFT0FKdHlYUjFpeUdNRzZzakw4Nmw0dkpvOW9pZldZaC9NTEhl?=
 =?utf-8?B?ejNselpEMVRKZWoveGd2Njl1aVlKV2dzcGR1cHR3eld2OWlQUktvQWMwejlP?=
 =?utf-8?B?dnpHTTZYKzNTaG9LUEYwcG00enpWYjdScnVraHNXdG5uQVc2alp2cFBBOThL?=
 =?utf-8?B?Ujl1Nkg2Sml5T1E2Y0h2UGh0M2c5S0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd308d0-5b0d-4bb2-c381-08db9cc7663c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 13:07:23.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yblXiU19q+ek+5jALOBx+sX6c5VycfPMs9hDBUwXan1WpG1tz8txR2rrIN6NLHJkpgP3ALbosxdt4Ojk/T72A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140121
X-Proofpoint-ORIG-GUID: USDBYQZKhFSon-OJiVLbQiX819dxL5kO
X-Proofpoint-GUID: USDBYQZKhFSon-OJiVLbQiX819dxL5kO
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 15:39, James Clark wrote:
> Currently variant and revision fields are masked out of the MIDR so
> it's not possible to compare different versions of the same CPU.
> In a later commit a workaround will be removed just for N2 r0p3, so
> enable comparisons on version.
> 
> This has the side effect of changing the MIDR stored in the header of
> the perf.data file to no longer have masked version fields.

Did you consider adding a raw version of _get_cpuid(), which returns the 
full MIDR just for the purpose of caller strcmp_cpuid_str()?

I can't comment on how it will be called in relation to 
strcmp_cpuid_str(), as I am unsure whether strcmp_cpuid_str() should be 
just in arch arm64 code - see comment on later patch.

  It also
> affects the lookups in mapfile.csv, but as that currently only has
> zeroed version fields, it has no actual effect. The mapfile.csv
> documentation also states to zero the version fields, so unless this
> isn't done it will continue to have no effect.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   tools/perf/arch/arm64/util/header.c | 64 ++++++++++++++++++++++-------
>   1 file changed, 50 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
> index 80b9f6287fe2..8f74e801e1ab 100644
> --- a/tools/perf/arch/arm64/util/header.c
> +++ b/tools/perf/arch/arm64/util/header.c
> @@ -1,3 +1,6 @@
> +#include <linux/kernel.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <perf/cpumap.h>
> @@ -10,14 +13,12 @@
>   
>   #define MIDR "/regs/identification/midr_el1"
>   #define MIDR_SIZE 19
> -#define MIDR_REVISION_MASK      0xf
> -#define MIDR_VARIANT_SHIFT      20
> -#define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
> +#define MIDR_REVISION_MASK      GENMASK(3, 0)
> +#define MIDR_VARIANT_MASK	GENMASK(23, 20)
>   
>   static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
>   {
>   	const char *sysfs = sysfs__mountpoint();
> -	u64 midr = 0;
>   	int cpu;
>   
>   	if (!sysfs || sz < MIDR_SIZE)
> @@ -44,21 +45,11 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
>   		}
>   		fclose(file);
>   
> -		/* Ignore/clear Variant[23:20] and
> -		 * Revision[3:0] of MIDR
> -		 */
> -		midr = strtoul(buf, NULL, 16);
> -		midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
> -		scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
>   		/* got midr break loop */
>   		break;
>   	}
>   
>   	perf_cpu_map__put(cpus);
> -
> -	if (!midr)
> -		return EINVAL;
> -
>   	return 0;
>   }
>   
> @@ -99,3 +90,48 @@ char *get_cpuid_str(struct perf_pmu *pmu)
>   
>   	return buf;
>   }
> +
> +/*
> + * Return 0 if idstr is a higher or equal to version of the same part as
> + * mapcpuid.
> + *
> + * Therefore, if mapcpuid has 0 for revision and variant then any version of
> + * idstr will match as long as it's the same CPU type.
> + */
> +int strcmp_cpuid_str(const char *mapcpuid, const char *idstr)

should we check implementator and other fields as a sanity check?

> +{
> +	u64 map_id = strtoull(mapcpuid, NULL, 16);
> +	char map_id_variant = FIELD_GET(MIDR_VARIANT_MASK, map_id);
> +	char map_id_revision = FIELD_GET(MIDR_REVISION_MASK, map_id);
> +	u64 id = strtoull(idstr, NULL, 16);
> +	char id_variant = FIELD_GET(MIDR_VARIANT_MASK, id);
> +	char id_revision = FIELD_GET(MIDR_REVISION_MASK, id);
> +	u64 id_fields = ~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK);
> +
> +	/* Compare without version first */
> +	if ((map_id & id_fields) != (id & id_fields))
> +		return 1;
> +
> +	/*
> +	 * ID matches, now compare version.
> +	 *
> +	 * Arm revisions (like r0p0) are compared here like two digit semver
> +	 * values eg. 1.3 < 2.0 < 2.1 < 2.2. The events json file with the
> +	 * highest matching version is used.
> +	 *
> +	 *  r = high value = 'Variant' field in MIDR
> +	 *  p = low value  = 'Revision' field in MIDR
> +	 *
> +	 */
> +	if (id_variant > map_id_variant)
> +		return 0;
> +
> +	if (id_variant == map_id_variant && id_revision >= map_id_revision)
> +		return 0;
> +
> +	/*
> +	 * variant is less than mapfile variant or variants are the same but
> +	 * the revision doesn't match. Return no match.
> +	 */
> +	return 1;
> +}

Thanks,
John

