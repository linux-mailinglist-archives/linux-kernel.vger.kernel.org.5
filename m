Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A159077CAB6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjHOJsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbjHOJr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:47:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63FA6;
        Tue, 15 Aug 2023 02:47:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOs9i023639;
        Tue, 15 Aug 2023 09:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oH609Iwv5o8F8em+tnwMguzYwOVqkbjnLw2u98cnV0Y=;
 b=tgerefsFbw1quHTwaaHId0+vzjlgWF493MvjNhe5NZO6b5fZ5qkKhUpJvGiIINqWJ38N
 r5LMo1czw9CIN7qM44VVwSxZXKtpnY/I1g0NG2YsBtseB/4l93PPcAwfS6KV7u62pJvq
 q9rgVRDu655Ukj7vrTXELzXz3+tbT2Ag+eWS3nInuTmXi2wDLfLANduIcNR+MtcMwEdH
 dstm6SSJviFD0GqzbP2cPHRdfIszG0+pCnP9M/lLAnnqom8kjnWsJVvs9skxgNfXHSGw
 dr5MXnTBsKBsGHAhwcDjGKdIHIJLlM/VHfYdKR7aU9L57jU8ENNH4FcIJpRlGDWIaLU5 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5vb0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 09:47:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F9QSLu027483;
        Tue, 15 Aug 2023 09:47:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rw6ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 09:47:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rta155qV09nJPfJaMrPifLEA3H65d9VJckEicRagn1FyqqSfxdgWxzFFGtNQMiKcY5z+iCLb8CtDbVZxCq1GqhsKyP9wLE3V2Xvo7YFLv9qcmb/ppK+apF0iJqtU3DYrljJt3aJS1UJSC4Ppg0tNtTzplNULKBsZlCNa5aBPbQi/SYPP3eNjZoBcNyVsP+txSfwHI9QgWtyNl60vITliTaJZ1Cnpuuh2cbZ99AT8YP0g2TYhxlcKWMIrTdwslpd8ktU4iuBU4B+8wDFScZ+5d5Nn4upHib6i1y1CIxdjfZmHMVUYGapPgESaThdtA/BdnajAHUelUY4QuRHVv7eeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oH609Iwv5o8F8em+tnwMguzYwOVqkbjnLw2u98cnV0Y=;
 b=YVyIUnqtEha60H984Hwa0iNEbdEmBWMcb9jBROFESEO1IISWx0DNHGGgq3HrpJ5ukPVB9Cmktfzza26ewpUok7geNFIZNB9Em2YLEvE20NOpC0sc2+qikQN6BABN/SbTYsnLZeHTOSfuiJsDjfDuAKVfbNGvONh7pb1X1idrYPeAiAQ3xtCRl+wz96+JM3nICrM74dQHw4Fds3M/AgEB37f7wmigaQBjgoc6diq09NKeKpu7keReZQI9cL6qBphJ2po0KOz75XUQ0kIYgyetjWU91PRMOYT5L1Twfxz1HJ4GFyIFPz7jE5IKSiFmFR4TNg88qgwXSsIHM6cHnxidQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oH609Iwv5o8F8em+tnwMguzYwOVqkbjnLw2u98cnV0Y=;
 b=MmKlQz7SInHGjOYxPMYxW5csPC1z80JwyTUclhyYHmI+Pa5LXXhCEZAv7ql3PxsBAZEU29bXw94BAH2Et+yWZYBkudkcge57rCEDZX6dxBeSFDjufNoHokrQmu7wypeJ1tLizbX4jgdodQLGQSpXTlcqI0VdUKwgVr4oOS3OxT0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7251.namprd10.prod.outlook.com (2603:10b6:8:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 09:47:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 09:47:20 +0000
Message-ID: <3c382d80-7666-8207-a534-0b20807d3f6c@oracle.com>
Date:   Tue, 15 Aug 2023 10:47:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 3/6] perf test: Add a test for the new Arm CPU ID
 comparison behavior
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
        Nick Forrington <nick.forrington@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230811144017.491628-1-james.clark@arm.com>
 <20230811144017.491628-4-james.clark@arm.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230811144017.491628-4-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0076.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 7932577d-668f-46c9-3012-08db9d749e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cse877fHaEB2HmuSjhr3Um3yiyq5+Dq8/X4bcaF130TQk4snVmq/Vp18cFo5TlglAMPE7HibWl/D5jhuFL3DJjPmJ3zZ8VE1ic/GsgTTSt+zJy/zJ10cAnsVXyjDJDdqS9Os+fbAkNyN2zsM6va7lAlM84319IGaFYVgkxyprLpxv4rUkyy4SWX5fjFI6zxF4PU1NqffY2EtCaH2Y2STKS0SF1XX3x/pDn3JILelw8mpC56hmtSVbUdhpaz7DL+/AYylCQ8mITaHwORCCQ4QF9cbX6VSOIoy+4mNrGzu5AbUu77K/WE14DdH2liofFWgyNjTx1xMKvsnLKCgAF5sBsm83lhN8c+gy0wYpTg097xe2qQTfY0BNdg6awgSdc1vfgwxzbPBud/2PL4hnqlbIr1LsRqv0aAbrtf1GXpG6Grag4ZmnqQnjS90Bqx/PBZA8NHBAB3OFZuNClYWU1x+9ugFgYmtz+N52PrTchyO3GC8hliKzQ+Zyoll9cDR0zl6UR3SIz6wrPmEuwiKJzHkAFlGEYxX6p1UoZljE34Q2BuTaBuuvtsd0KBkFfT4uhb0OTxG/oqwn1YLEd5FbIg5dzCkGaX8M2/ezhcDshVGqQ4yQf87ZnkHf0EBLZkqtUhzV8qs429VKvUZYQHWyb5hQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(366004)(136003)(1800799006)(186006)(451199021)(38100700002)(31686004)(4326008)(66946007)(31696002)(86362001)(66556008)(478600001)(66476007)(316002)(41300700001)(36756003)(6512007)(36916002)(6486002)(6506007)(26005)(53546011)(2906002)(8936002)(8676002)(54906003)(2616005)(83380400001)(6666004)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUNFNmxmRDczQW9NdUJLUXJJT2VvMUpueFFlS1hHOGdhT2pnaVM4Y2lDK0w4?=
 =?utf-8?B?Q1UrWkNmWUNpRjVvWkNVQkxOMFRTam9KRGxCOSs2Ry9LdWVieFNNMDJXV2ZN?=
 =?utf-8?B?TFNZdnlnQnNaa2UvOFdaMk5hR0dadGVxNFJGMmJhUGZXSXRPcDZCcENJYk4v?=
 =?utf-8?B?Q21OcGhRaHA0RGcvcElMMy9qT0lSczZVRFo4TFFmdlMzcENJWFo0YWd2TytJ?=
 =?utf-8?B?MzhxamNLNUVRaDJkK3g0SVllTVBHK3FZaVJielFvU0g4RERrMDJQR295WFJP?=
 =?utf-8?B?dTR0c1U4NzRFbElEdVZoWXI1aUVNMXUyajRoTFdQeUZsYzhMMkM4bHQza2E4?=
 =?utf-8?B?QWJSc1hQN3Q1MEE0VFNRTTR5QmpSVDRGVWYvMFVxMEljcVdHME1wcktRLzVW?=
 =?utf-8?B?eTZuRWRoQXQrck9XYWppUXdnNGpqWGFoT3hOdXdhY2xVejlwRzJKS2h5WlZI?=
 =?utf-8?B?UXBLZnpBc3ozRmVyQld2dVNxZTdSYmEyMStiZEJ0WFA1NEpLODlQUUhpNHpZ?=
 =?utf-8?B?b2xiaFpWQkpvZGRaVHpqSHdUNmRHOW1vRU9NR0dpdUFWRWl6N1Y1NzVNVlc2?=
 =?utf-8?B?RWdxb0VPcnpUcGNIUlAxd0pYK294SFg2Y3NmNGhJaW1pZzE1M054VXk0N2Yv?=
 =?utf-8?B?V2U5TW9nSFpsU21jZzlpSElEakkybHlTMURNeUlWQ3JjaDczaGt3aksrbkRx?=
 =?utf-8?B?ZGdZUTNqSythUjJLR0R2ai9hYmRDMXZac3U0dGY2WlBSWEc4aWF4aG4vYTlN?=
 =?utf-8?B?VU4wRDllbS9JeGcwdko4UVQ2dEgrT1ZURmZmTi9yYy9NZlFPQ2I0YnpNTjh0?=
 =?utf-8?B?Qy9zOGR6cTd2MERyUTRTbEViT1dNQkorWG9aVmovSCs2U2ZlazNWcE0wTUpq?=
 =?utf-8?B?N2xzVWtrcFBSaFpFamJBMjJSU2kyaHpkUWxHcDUxblN6Nm5jTWdiT2FJdjVk?=
 =?utf-8?B?YVZub1N1dUZadkhUQUdWeS9FTlp6aEtydndiK21rZFZhaDNLSkxSNERxOHJR?=
 =?utf-8?B?UmdGTU9LZWI0WVVVaFlrWnVrOVhlRDZnM0w2ZTdoSW1qYzA5K1pUenFGQkVy?=
 =?utf-8?B?b2xRdEM5ZzE4Nlc0RTdLNWtsQURNdXhSbWIzSEcvU1llM24xTXpndU84WWxx?=
 =?utf-8?B?M0lSeElNeC9KTHZOS3JyOXUrSytZaDFhUGt0ZHdaYnBiUGtMaW1LYW1qcnFr?=
 =?utf-8?B?eXE1WnNMVS9BbHVxbFVEWDhqOHU3cU1TcXVESVdyM052UGNGMitCcEQwS0U4?=
 =?utf-8?B?bWRaREV1NGVGZG04TmowdzNadnpyS2s2TjhHak43Z2dGSHdpWnpmNFJSNWQ3?=
 =?utf-8?B?NGJaanJqUE5aM0RTZHdtaWdXQkNSaG1RUTk1RGE3VTArQVVnYjErL3hibHZP?=
 =?utf-8?B?ZXpqNkNDZXIvQTdLeU84UWprcStPSkhOajVZR0ZsOEJaVHJGc3ovM04xeE1C?=
 =?utf-8?B?aXF2SmNTQWt1emRWYm8zY0Z6NVRkWTJVRXN0NjRHdm1WSG1FdFJqUDByMy9o?=
 =?utf-8?B?ZUtnOWh0UTJXWjlDR0NzNDhhZks1bFpSVW5KZWNuS1dyYmNWSDF5aXhZLzRx?=
 =?utf-8?B?Ylh5YzBlNm9WQk00SkpYNlhxSEdVMXBKRGxUWDVleVhjZ3llYlZTWUxDN0px?=
 =?utf-8?B?MmNKTzViUFhXRkJlS2JSRUpkTnc3Qnl5N0pZcFA3c0JHMnpyWlZuYmFNelR2?=
 =?utf-8?B?TFE4cGZZOTlkeUNkb0g5WHZBb2FwdC9EQUpaRWVjbUhXd2FjY2pPcExNU0dr?=
 =?utf-8?B?RGhKTlF5RkYwR0JnVmR2UzdnWjF0TWRQN0NEOTNGOVg3eDc4VXIrUDZyTCt5?=
 =?utf-8?B?Z3RZVndLejBvdUVoY2t0UzM0M2xNUyszQ3VlQ0I4S09GU3FnQjJ5aE8yMnhJ?=
 =?utf-8?B?dlZaWWJVK1E0dk83Q1U0eTRXaytUK29ZTHdlWXJUQnR6TlNlbVZzN05lYURP?=
 =?utf-8?B?TnFrTmpzc2FFdzRSLzduNnBjN2pRSXRQMFlob0h6THo3c2pSKzZteWkxWDBh?=
 =?utf-8?B?VmE2YmFWQ2FRbEpISUsrdlFVSzhLTklNTUI5aWkwVU1PQzVBRlpZOWZkYlBW?=
 =?utf-8?B?UFFlRWdtV2lZUXlVRFJHdVJTcC82OUhRSHk1am42c21ITDFVTW1hSzJqZnVQ?=
 =?utf-8?B?emdnVUptdGpkYTlucUZWWDBrK08wTjIxeDYyRWdiMlVIcWxURnRNbTZqd1lN?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N1IwQnM4Q1oxVk9mRGc3QXEydWJVTURtVVg2K3kvb05GTnJnNzZnYmJlOE9Q?=
 =?utf-8?B?VU04amV2d1h0VmNndzBWM0xJeEx3TXplTFZPaEtwdUR5dTNEaXQ0UDVIeEla?=
 =?utf-8?B?QTM4Nmw5bm4wd2NpREZUUDFCOUJPRlpDUzY0QkE3bUF0ME5XOEprcXJzMi9E?=
 =?utf-8?B?UTdJeGxQajFzT3V2Uklxd2lLWmF4R0k1UlBuQ0VRM09RdS95ZFNkSkY0MUsy?=
 =?utf-8?B?VlhQSVlIckU2SzdkQjlaUnUydloyQ0U0ckVGalp1aEMyVHpCcXhOeU9mVGVO?=
 =?utf-8?B?ckVFU3lvMUkrOS9kNUFBUWt3d01xM1JrMHV4S0hKaGlHTkJmNVA0Wk9Lb0FF?=
 =?utf-8?B?ME1TZ3E0a1gzbUgzcEhES2dVT3pSVEZhZXAxQmNDbjlWVTRoVjZqbGVFcXZJ?=
 =?utf-8?B?YkxIb2RTL2ZRTTgzcnBJZm9Md1VIWCtUYVVOSjUvNGp5Wi85MHNJOHZUL1d6?=
 =?utf-8?B?OElvVU1JQjMwQ0c5K3RDVmJnUG5VbHR4amlvWnZMR0hZNG41REF3akdJYzZL?=
 =?utf-8?B?Z1BqcHRCekZicDducGRXdVhBNVQ3MFZQSGtUYmE5RDM3MEpXeEtVMnZpWGdW?=
 =?utf-8?B?WU9OaHZWcHZrbUl4azRIUmVPdks2VjQ5V2pHOHRqZGYrRktVVENNT0QxMENu?=
 =?utf-8?B?dTYrQk5MMko5YW5MOVhHN1o2Vy90MHM5bFNYVldtTnpnQmZBUklNUGdXK01D?=
 =?utf-8?B?WHE3eENPbVBoN3lLd25oSkF3Z09kenFlUzYzUk5Kc1lyM05uaTcyMkJiY1dk?=
 =?utf-8?B?YWRpTlpra3JWWlhoUENnUEF2VVZZRW85S3VTc2NMaDhJRWtkbm1JbGtmMEp6?=
 =?utf-8?B?VG1zbktDM0RNSFIwN3kzdUpxS29oWkVoV0xQU0hBQ0xVVzlWdGRKUm1UZ3pZ?=
 =?utf-8?B?VFF0UFFrMGFaSU5OTzFnUTdlUmJ4b3RqSWxhTVN3cHFRbDNPQkVhSVdTQWdO?=
 =?utf-8?B?N0NXd09ldFVKSzY3eGlWblc4M1FyZEE0STJ0Q1Z1SllxLzdWbnM3ZVNxVHd3?=
 =?utf-8?B?RlJ3Ykl6Q0JjaGY5aTBYYWlKQmcxOTYwN2FyZlN2ZkRhK1JJVzc5ZDJWbVNP?=
 =?utf-8?B?clZnVmJxSnZ3MkpyaE52ZklmZzRlLzNmZEUrcWZiZ2M2cUpRQ2Frb082bnJw?=
 =?utf-8?B?cFhoR2d5L3dNOVVNcjJxOFY2Yk83aTUyMnV0NTR5MGYzbkgzN05nM0ZtWWcx?=
 =?utf-8?B?V2hRamtIRThwUWxIVG5LRHNzTUxCMUp5UXV6Uy9MQkUvU3g0NjVxb0N6Vm5y?=
 =?utf-8?B?aVFhTWhqUjZiV0c3bE5YampMdmp6ZHk2ODNZaEtsZmw3c04rTUZ3bU82Y0Nv?=
 =?utf-8?B?WDJjN3M0aGF6Njd3QXAwVndzU3RyNUdoS2JVZWlpTHRXN29meHNDVmdtejNt?=
 =?utf-8?B?QWdXUnNkZXVtQXI3NEViMHpDUDRKWk9IakVnVE9KYXdvS3RLdVhIVXhHZXFY?=
 =?utf-8?B?MGJTdWhjQzBYeDJxQ24xZHJlTnc3S2ViTW9VNS84emZ0M05rUEoxRzJTS3Jo?=
 =?utf-8?B?L00wOFVUUkxldkllcGl4cHB2UmJlYjkrZUtjRDhiZ0lETU00MnFqS2Y5a2FN?=
 =?utf-8?B?a0RBRXJ5VjNBZGcyaTZoU0lmZDRJcW9BYUtIdk9ja01XN1BXZW5ZeVZwckNs?=
 =?utf-8?B?eUZER0lVQ2N5Umc2cWhJMmhyWVdRY0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7932577d-668f-46c9-3012-08db9d749e46
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 09:47:20.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hdkSCRzSPj9t1Hc2iLrfuY0LJFG36N2nkHu6ZImpZHgkp+tuby1YKGbyesYb2ktBrgOPNwv1jcNj0OdlOkM4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150086
X-Proofpoint-ORIG-GUID: zKIA49v8G0LEk0-rtnM6qDscz8acLa8k
X-Proofpoint-GUID: zKIA49v8G0LEk0-rtnM6qDscz8acLa8k
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 15:39, James Clark wrote:
> Now that variant and revision fields are taken into account the behavior
> is slightly more complicated so add a test to ensure that this behaves
> as expected.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   tools/perf/arch/arm64/include/arch-tests.h |  3 ++
>   tools/perf/arch/arm64/tests/Build          |  1 +
>   tools/perf/arch/arm64/tests/arch-tests.c   |  4 +++
>   tools/perf/arch/arm64/tests/cpuid-match.c  | 38 ++++++++++++++++++++++
>   4 files changed, 46 insertions(+)
>   create mode 100644 tools/perf/arch/arm64/tests/cpuid-match.c
> 
> diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
> index 452b3d904521..474d7cf5afbd 100644
> --- a/tools/perf/arch/arm64/include/arch-tests.h
> +++ b/tools/perf/arch/arm64/include/arch-tests.h
> @@ -2,6 +2,9 @@
>   #ifndef ARCH_TESTS_H
>   #define ARCH_TESTS_H
>   
> +struct test_suite;
> +
> +int test__cpuid_match(struct test_suite *test, int subtest);
>   extern struct test_suite *arch_tests[];
>   
>   #endif
> diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
> index a61c06bdb757..e337c09e7f56 100644
> --- a/tools/perf/arch/arm64/tests/Build
> +++ b/tools/perf/arch/arm64/tests/Build
> @@ -2,3 +2,4 @@ perf-y += regs_load.o
>   perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
>   
>   perf-y += arch-tests.o
> +perf-y += cpuid-match.o
> diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
> index ad16b4f8f63e..74932e72c727 100644
> --- a/tools/perf/arch/arm64/tests/arch-tests.c
> +++ b/tools/perf/arch/arm64/tests/arch-tests.c
> @@ -3,9 +3,13 @@
>   #include "tests/tests.h"
>   #include "arch-tests.h"
>   
> +
> +DEFINE_SUITE("arm64 CPUID matching", cpuid_match);
> +
>   struct test_suite *arch_tests[] = {
>   #ifdef HAVE_DWARF_UNWIND_SUPPORT
>   	&suite__dwarf_unwind,
>   #endif
> +	&suite__cpuid_match,
>   	NULL,
>   };
> diff --git a/tools/perf/arch/arm64/tests/cpuid-match.c b/tools/perf/arch/arm64/tests/cpuid-match.c
> new file mode 100644
> index 000000000000..af0871b54ae7
> --- /dev/null
> +++ b/tools/perf/arch/arm64/tests/cpuid-match.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compiler.h>
> +
> +#include "arch-tests.h"
> +#include "tests/tests.h"
> +#include "util/header.h"
> +
> +int test__cpuid_match(struct test_suite *test __maybe_unused,
> +			     int subtest __maybe_unused)
> +{
> +	/* midr with no leading zeros matches */
> +	if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410fd0c0"))
> +		return -1;
> +	/* Upper case matches */
> +	if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410FD0C0"))
> +		return -1;
> +	/* r0p0 = r0p0 matches */
> +	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd480"))
> +		return -1;
> +	/* r0p1 > r0p0 matches */
> +	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd481"))
> +		return -1;
> +	/* r1p0 > r0p0 matches*/
> +	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000411fd480"))
> +		return -1;
> +	/* r0p0 < r0p1 doesn't match */
> +	if (!strcmp_cpuid_str("0x00000000410fd481", "0x00000000410fd480"))
> +		return -1;
> +	/* r0p0 < r1p0 doesn't match */
> +	if (!strcmp_cpuid_str("0x00000000411fd480", "0x00000000410fd480"))
> +		return -1;
> +	/* Different CPU doesn't match */
> +	if (!strcmp_cpuid_str("0x00000000410fd4c0", "0x00000000430f0af0"))
> +		return -1;
> +
> +	return 0;
> +}
> +

Would it be possible to put this in core test code, since x86 also 
supports strcmp_cpuid_str()?

Maybe we would have an structure per arch of cpuids and expected 
results, like

struct cpuid_match {
	char *cpuid1;
	char *cpuid1;
	int expected_result;
};


#ifdef ARM64
  cpuid_match_array[] = {
	{"0x410fd0c0", "0x00000000410FD0C0", -1},
	{"0x00000000410fd480", "0x00000000410fd480", -1},
	...
	{} /* sentinel */

};
#else if defined(X86)
  cpuid_match_array[] = {
	{....}
	...
	{} /* sentinel */

};
#else
/* no support */
#endif

Thanks,
John
