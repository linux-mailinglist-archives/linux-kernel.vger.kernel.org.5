Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935C779FC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbjINGl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbjINGlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:41:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92346CD8;
        Wed, 13 Sep 2023 23:41:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E1SuSZ014717;
        Thu, 14 Sep 2023 06:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=n4gpomVaGRZCPAZfrZ1eIRn/7c3Q+vomeaztCsuvNH8=;
 b=Fm0byI7IZUjMUjpczsR4C2pCqS0OdtNUuEDQ9NKWBsv86nBNrAdr7ZDspIWulIV+6EV0
 ypsPh2IrFEldgIi1he5fBDa7ZIA2ryswa+7+JeLz3aNtvaetDpUUaRtO8Tr+ye98sMlU
 8AcCfLj4Fqy7uDXdcQSPedloEfJIQi4aRNFJJ7C+zANrMtr19pbjC4XWk2lKoYAu7tuN
 NVvrwqZtBBNzgPc0QJQoDj7QCPYVOIJTiyeSdV/KBIEbdbYKm2pqq7XX/lzRtsIjpC7z
 sNPLNAworNKDJtZzV82CS7OUpgNSXCAhjHxcW0b4Y2M8Npu2zWoB1eW+IypiMQkQAp8X Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7pm9jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 06:40:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38E6Qjbk002299;
        Thu, 14 Sep 2023 06:40:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5ehtyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 06:40:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgKXkcecFOoQ0o9+LYP0u+SuuQdDQ7hVR1H26IP4vocxtI3S9g6PhIApbYXkreO/baDvmWEUep9JEbKfv1whDAXnnNF6RF4aA2Yyp7ulbCWKzAmTjym7S5JFcdlKDglfUNEDPaKPFr1We8pmQQ+gCgUPCuFpvVZNPCwEhXaT+fLDSji+nz9fZtWmiotHCw5w+E9LX7YZ4m0b7JCCrnpPJa4NwSE1McKWxaz/Y9aq5PqeZAsBkr2eCPf9f1/QYyEA1ChrXt8v6JIYM7Th6nb+T3GViJ5sNX6rtbDy6EXAQtGx5b6uaXxx8I0L42ceQ6AFwla9zbU/JN3JU4rMaWNFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4gpomVaGRZCPAZfrZ1eIRn/7c3Q+vomeaztCsuvNH8=;
 b=RjftcbRC2yBS7xBW2ylbvxyqxXwB4MzpCRkXuBzLyhIVaqGY4pfPTQuQCs+9vLDnx7n/H0+vIAM0I4yTevX353VPwYUPMjl0Wd6d8xQtWC8qsCtzQky92ITHiOgz8/FzfSLlj59ZkvBKDMuaj/eBQo9HKSzjFo83nMpwIu3djjEdss5ID6OBjei5I/oEyY3UdfFjXEib8mmeCDETa/jBkvDlzHNt/wPbCvsd9tl+VnZbuwMb4HFdPjujvpW+hS66axzfpOCzt9z/FvtXym9U7L69GiD3nnDV2Ib5KijsM6vG6q2HlGn2F+4AK3ng995L6LnrcERGsfDn5EQRv9Qc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4gpomVaGRZCPAZfrZ1eIRn/7c3Q+vomeaztCsuvNH8=;
 b=SyuxImOFbYutz/nZieY5kjq3jouZvlp1NyI/r1xDrCX57EOZQReuj8ZNikrs31/nDfC7MF0FcQpNjgJmkPOGw3R+wl7A4sCOT12JTh2P99A4Vv/agCi13CaexfbtlWFEdb9OZhJ8aATQ0sjkPWKhmxgZf6hA3x0EVd4BYS6PK8I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4286.namprd10.prod.outlook.com (2603:10b6:208:1d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Thu, 14 Sep
 2023 06:40:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 06:40:48 +0000
Message-ID: <b1c47465-013e-f5bd-e2db-8764ac0cab80@oracle.com>
Date:   Thu, 14 Sep 2023 07:40:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/3] perf pmus: Simplify perf_pmus__find_core_pmu()
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        acme@kernel.org
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230913153355.138331-1-james.clark@arm.com>
 <20230913153355.138331-3-james.clark@arm.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230913153355.138331-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:208:55::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1e76c5-f897-4783-9bdb-08dbb4ed8777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GnIMtVUhsEX7ruXGn4YzpJuXaTrK2bunUnkf3UHI3t0axqzypOwJ1uzQMr46xf4vYksP3HpyzkfSXSdJw2qkz+YyNCxj58XGqeSfmS71/JD9vDrD8B3zQFHzZmOT2aTYE7x8qfOGOWx1GufGzIpU3Y6LvB5kAEPkVWRcnpX7KmfwMR8OIRzwDlHJNycsVorgZmykABQk9oQz42JR100tpY4BSrYFCvuX9oCWYrUA9cXI8LTFQbQvIOB1RY6uD0dIEC2udAK3ogcnI0+sr6GXGO0mCeR4DLI0xG+TQsj8kHD8uo18z3ttIYu8jbr+GXWPI/X+uczGD3n7fHMmS5fg5KkBUMTl2Q84765CLfxShuprQJkbTanD0hdrhZed85vwre71L7hZjCbVU+Jn20Uf45KenAlSZrK38erDx1p24zL2D4Yi/fIrALErKt9BRNt+kns5cRmM5Y7QXINYC5ppPQstXxZ1iVedaQ3crJ/7gA/Ej24lX9i7sdjkar7wbZU8GTCsW1HWwcHyAfBOkCj2tZmiwXxlWVIE9POGnMiLZHd5cESrUByZkmSiBJV/rtWAICNvTyAUKA3r8LigU/wq13u2droE/19MNDiemY9yoJ8wnT7M77Un0lNFVIMBEUW9Xqlje8wyEB5+6reHu0DyDdaS2wdaqwraLLIaUQn00cpYwXM7GJRCfTxEWsfDCMPA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(31686004)(6486002)(53546011)(6666004)(36916002)(6506007)(36756003)(31696002)(86362001)(38100700002)(2616005)(478600001)(2906002)(4744005)(83380400001)(6512007)(8676002)(316002)(5660300002)(4326008)(8936002)(7416002)(41300700001)(26005)(54906003)(66556008)(66476007)(66946007)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEVRMGtSOFVVVEdxTGVoaFBGSWxGZUl4TGpHUXM1YU9zUko4Ny8xd21ONTlG?=
 =?utf-8?B?ck1pQ0Fab1hpZ1RyMmF1N3hhQWV2Vis0TnZINTczMjRZSlhZbXFYZ0xsVDEy?=
 =?utf-8?B?U09lbk1kV2R6NDJLc0k5ek5XOXZVanpOS3AyQUt2Q1NMZWJPaFp2RkVQcVNh?=
 =?utf-8?B?YW45RVhDK2dQckttWVd1d3BFRUVLSS9NY09zcERkbDRwc1JISnZ6ZUtEN2ww?=
 =?utf-8?B?RFIvZGExZ01SZnRlNFgyTWQ0amVBTWNnZjJncEZsWmthTEd4QmRRNlhxbXUv?=
 =?utf-8?B?YU9iWnFLeFV5am9iZXVJNUNOWjJvRTVnSW5YVXlTaXhYNmVtU1JTalJuc085?=
 =?utf-8?B?d1U2S3BKc2o2bHFVNjFMYnhzOEdZbEFDWVVzM2hNdktlSlNyc0U0RWxxdzBI?=
 =?utf-8?B?dFRTaTdBYjlxVHU3eCttb2FZTUlXUThOTjJLMXcxQUd6SHZ4aHB6czRiK095?=
 =?utf-8?B?WitmM1F2SERST3NtVHk2dEkxanV1aVBvbmtrSkRQV1loc2Z0VUN4YlJMVUY3?=
 =?utf-8?B?L1FlSVVMcU9iWDJwR3pRdzBqSmJwTzF0WWY0YWxna1JRY0Z5eWRLOVFxZC81?=
 =?utf-8?B?T0VzVzRQdjJTMDlJUEdZWWw3L3hJa3RhZzIxL2dEa0IyZ0gvN0cxRStDc0xo?=
 =?utf-8?B?a3JwWk0yRzBnMzVESTR0V3ZrTHpqKy95a1JWRmtWT3dzMzVmQzl2cC9kWWJG?=
 =?utf-8?B?YnoybysrSmZjZjRIdmpnamJJYnZGR05Qazl1OUkrUkp4TFB6dnc0RGlSRU8v?=
 =?utf-8?B?MHZEZUZjdkdaemtaM2swUnVrRXhmWmJtS3o4clZlNFF0Nmw4Zk04T29IQlh1?=
 =?utf-8?B?RHNQcmIwb204MFJuc1d4ZnlzQTdJL3Qya1EyVlBWRkdYbi9KNUlBM0NXRHRo?=
 =?utf-8?B?R3lGTVk0KytoNlRJMlVSQXJGTkdDS093cXNYdzQ1WFFjTTZpNDAwbzNNQ04w?=
 =?utf-8?B?a0tiS09RbkVmWk1NcXN2NURxZmtEdVJlemdUeHlpY09YMUl4Qml2MVFQVVlH?=
 =?utf-8?B?cW9VWlVQU1ZQdTFNQ2xrSnVMZEJ6azFvQkVNZGNsUEVBb0dJaXFzb0RHV29J?=
 =?utf-8?B?QUVML0ViWHI5Y0N1OE9veS9OZVNGV0RYSFhSL3dXYS9EZmVNOHp5MUFaVVN4?=
 =?utf-8?B?Q2Q2YnhMRTVYWExyWEFsUERqcjBwUUQwU1JFTHBqbUtGcXVxWHloNHYyaFor?=
 =?utf-8?B?MjBlcnhSRkwya2xndVVTb2p4d3R4c1IyRnBEMWFiaWlWYmRkcXdXNFhrVG9w?=
 =?utf-8?B?SEptY1FweWp5SSthanZjRmFHWXVDMXRMVlZJQjBkVE5OdUVXekZZbk9VWE55?=
 =?utf-8?B?bEtxckVRVHZMcDdXbkM2ZzQ3am0veHQ3Y3kzZ3R6dVZ5bEVHL1NUS3M5MWtq?=
 =?utf-8?B?SmxDREd5aUdnVnBWYytGU3diL1F6bldhY3N6ZVk4dG1tMWdTWi9icTFpai9S?=
 =?utf-8?B?L2lGYTdaejRmbjZJWERxQVEvcFZiUEpCcHg1dEpoYUZrTWJYQkVPRm9EL2FP?=
 =?utf-8?B?bFUxcUJIOWRjL2VqbVJZYXdtdm8zWHVkV0EzOC9wQmlXMm9jN0RPUWlXOExK?=
 =?utf-8?B?dkV1aEJ2YVhubDRSVGlYdmpBWjE1V045bHpSOHQvN1pkTHBLdjE3b1c3SVhq?=
 =?utf-8?B?c0Q4Q0UrMTd2Q3NFbzRnVE1VZUJ5b1V5NEYyenE3NUVaZVpvUGMvcktTYTJV?=
 =?utf-8?B?NkMrVHBjTkh1YlJrZ0ZrSE9FUnlNTHBUR1NnUVNWZDlJT0ZFb0ozSjhmRy91?=
 =?utf-8?B?bTVreDR6cFM2WXM1TlBiZzUrNUhYM0N1ZXBmZ01KT2M1NDU0UUdCTDkwTXJa?=
 =?utf-8?B?OGJGUVJwUDJyeVpyTXA0aXhLeFVzd1dQWGo4Qzk1dGJZNUJyU2Z4N2tuM3VT?=
 =?utf-8?B?UG1zU2pVS09rM2xSWlhNbmFUL1NacUVkU2lSL3FTNktOcjFzbTdMd1hkeWxw?=
 =?utf-8?B?a1dJWllLcTdBdWdUaS80UzI5cWFTdFNyMlB4VVNJMVlrcDU4bWFIS1VXWkNl?=
 =?utf-8?B?SjFvTGJrNDc3OGhZV20yY1VUald4WVJwTkZHTGhIVVBPS0hUTDNzTU5hWVB0?=
 =?utf-8?B?a3h6dDNmNDVSSE9PT25CVUNQZm9IdXNZZjZUZFBoMlRSdkF2RVdEenZWdit5?=
 =?utf-8?Q?g16y9qqMS1C3CSthuF7qZgQSE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ejNKUlg3dHlTOTBtNmk2T01xWmdOZjIwYjN4R0ZXZXp3a3poSVN3UVM0S2Fk?=
 =?utf-8?B?ZGU2V1VMZml5Y2pYdVZiaFhRQkg1V1lEUjhsOXAxaFRvM0xDNzB5Qmo3TERz?=
 =?utf-8?B?WTdSV3VobjJRbE5CdjlGVDdIRkNYN3ViVG9KSUFvVk9PZVVtQWlUREFuQnJk?=
 =?utf-8?B?Z1dhTnNuK0VyUHRkRGV4dncrTFU4cTh6WHVIdjNpNnJXNTlnSzJWdm05djM3?=
 =?utf-8?B?akxqMU1TajlMNFJSQkxqZDhQWDlrVmwyNWxYZnZTK05BM0M0bnV4emJuMG9S?=
 =?utf-8?B?UE1JbE5MeUVjZHJEZ0ZFTmNkZVE2SWNGeFhwdmYxM0tTd0U2VHpISzgrQ1hT?=
 =?utf-8?B?UWdtQnNnMUtLRXJOWWdidTJhS01WSWhjb1dWeWFGUUxpV3hBajhnVjdCU3Vt?=
 =?utf-8?B?UFlmcFQ0eU9tWS9yNnNKY0llU0dHWDdyS3k0U0hyelRuR3N1WTc4MzN4SE5Z?=
 =?utf-8?B?ZFpFcE01ZThpdm41K1hIRzF2TW5yMFh6NUJCc2hKQmcvek9wdlBHSWFXVmtX?=
 =?utf-8?B?YUk4dUZXUk96UTA3cndQL2ZMK3V6aHVqbUZjVlc2R2ZkWjhpUi9EdU11NmRB?=
 =?utf-8?B?SFlZUmova1hpMS9VTEZTSFpLT0xlV0pMOVZHRk9DTzhFUzlBVTdzU3NTakt5?=
 =?utf-8?B?ZlZoV3B0MXhFNkw0eG1nb1AydXFsZCt6MG9IQVp3emo5V05xbjVJSWgydVpH?=
 =?utf-8?B?OExkQ2JKQkhxUC9iYVpQWlRiM1RZN1o1WkdMZmR5MTJPYzJlNEsyQUxJeXk1?=
 =?utf-8?B?RHRoRHNVU0NHZis2UWtnL3Q1Z1BQWGlaRzZxYjZCRkNibXRZZmNacTkrNDhz?=
 =?utf-8?B?K1M2Y2dPeTBZVmUvaERlTlNsVnFWRTFFd2R0R1NlZlp2QVA0amRxSlJYN0lH?=
 =?utf-8?B?UVZOUGhGejFhS2JCTS85K0FUdThaLzF4WStCdmo1Y0pVZDB0bFJtS043dlJY?=
 =?utf-8?B?T1VPODVpQTI2SXZWQkhtT3ZmOHgvSUd3VzBYZHFubldFeDk0Q1crZlBBcWRB?=
 =?utf-8?B?VG12YW1aZlJwRGxTUStwdnkyVnBKVnVFa3l6RHFKdmszQzI0SE9jWmtkUzVr?=
 =?utf-8?B?NVJGYjkzS0M3N2RJSitFQjFCUGlWMXVQazRyelpCb0hKVXdtS0xrZWpXNEVG?=
 =?utf-8?B?UjBhNTUrRjJ3elM1RHB6UksrZUFoNVp6RXlpNXRMRWxWLzZPN053Z08vdDlI?=
 =?utf-8?B?NndKQmF6NVdxRm5HS0wwV05lRnpKQ0R1RXhGdWNNN0xTNTdLZXlxcER3bWI4?=
 =?utf-8?B?RUlUYmswVE9wQmlqajlOZlNkTUkvY2d1UjVkNDRSZSs1b2ZlOFlpSE9qU0Y2?=
 =?utf-8?B?eDhsRnM4Qm1KRmZuQm1mSnBIMXJaWnlDWGE2Uk9ZcER5eU1IZkM5dlNhNmpn?=
 =?utf-8?B?Y2xYUnVwVU5DOFRuMVlueTBFTTAvblpEQmdEaDlzaGpBa0hGQ2ltSy82TU5S?=
 =?utf-8?B?VThXM241NmNJeDQ5MEZ2RXBEWTRnVHJSaklhT1o2eXkxN1EvcHBjNnhUT1gx?=
 =?utf-8?B?ODNsa04yTXBnNVBHdWUxN2FUTUkwLzVMMlBHRUdRVUJEcGc5Vzl4cHUwbVJK?=
 =?utf-8?B?SFc0QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1e76c5-f897-4783-9bdb-08dbb4ed8777
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 06:40:48.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxcNQBdl5yMyvHkz9AZV4bNds0mDBrFtTbKio1yzH/UrW4RUBAQAi0eHNy1d6rEOugUHqsVa4EdTpC4sYa8b2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_03,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140058
X-Proofpoint-GUID: UDECaUVqMiTCsoHeEMVTIfp6WkUPcI8P
X-Proofpoint-ORIG-GUID: UDECaUVqMiTCsoHeEMVTIfp6WkUPcI8P
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 16:33, James Clark wrote:
> Currently the while loop always either exits on the first iteration with
> a core PMU, or exits with NULL on heterogeneous systems or when not all
> CPUs are online.
> 
> Both of the latter behaviors are undesirable for platforms other than
> Arm so simplify it to always return the first core PMU, or NULL if none
> exist.
> 
> This behavior was depended on by the Arm version of
> pmu_metrics_table__find(), so the logic has been moved there instead.
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

