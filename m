Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4569179FC26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjINGj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjINGj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:39:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE17CCD;
        Wed, 13 Sep 2023 23:39:24 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E5cJT1005599;
        Thu, 14 Sep 2023 06:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2UUYW/2X6H+0PywFb+BQ5OCaYXegNEaWDLan2IfY7ic=;
 b=v9JrMNjiFMtbQB3LacshPeoCbY7BGlmsMbegu+5Gek7oTt2shKENEEHSbiw/xl0YNO05
 7iY4WJyFvwnSuQghhbvX5IWVTEbRA+mAJ0NVCs+a3izFu9Mta5Vp1Wot43YbhckqbKPW
 7/pTNV+zMMmObUcRsQUZQF+s0FytORQLccoX+QznW+yss+lxFIi5yyOcjRA4IzyY5T2F
 3n9qjmQUi6g4p2UugTL0tiYn1qGU7FVPwJfxzNJ0C8mZC5HRWH5HEmGZGOXfZzcJr0rT
 s8wB6tLd9YuhdsjROPmL6XAAXG2+DI8COBGAUN5uV+fAQgWqKBXKc+Hf4uk0bPCOdHwZ NQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y9kv9ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 06:38:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38E67pac004332;
        Thu, 14 Sep 2023 06:38:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f591bk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 06:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0JM2hwOSts9yfgTf4uiQw26mIYtARz9HjHrnj9P2DLXhDttvhHZe976ymfGKi54TCCBlZUG1ovL2dcogTIglTgQRr8IahfuVSfrMlONwusGZzBf8X+PH1WyiI8HAoEtX3kiDZKloCXRzQT2x2D2qK5+1SrtHY6v2LCTnT+5ZfO7wej2CxboVpnqeSwH5UiJzaBxRkv4lUMAp/4YJU8DsislI1NbwSIFVphlUGQkZZOeT+iQI8gEh2/flraH/roVizqX9Bh4prLIr1eb9YxnGSDn4br7S0Ge+7Rys0xYyp5h1YDUnX4eDRxO1fUM+shhrPCsI0ee8LZR7jjcorxvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UUYW/2X6H+0PywFb+BQ5OCaYXegNEaWDLan2IfY7ic=;
 b=VC64eHWyrW3F/Q7ES5iUWiAiag6CKd+whdH1tvAnHGzTNWI0eYVHbahqI+J6XbJWIemEHJGp2FYxEdU4Ia3FVFxDzCTnTDLN6otHU64VklvimI12ERp3rHpHE8xplpy6WCQKOjF19JZVvS8gFxPVmjbYWKuhA22l36rU3+OYQYHTDxRbBoy6m+veLki1WJytDnt3XKrqg+ySXv9t7CdNvijIIB9q7y85fVmadBXVst6sq8+eXR+5nEL3yskiov4fthWukKZrcdtv28szKuy1n3ZKqQZAtJQsS4XEdOIlFitGY1dCv7PVcnt4dXk0IJFr1ZBNDG2TbxpIyvOFRtSrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UUYW/2X6H+0PywFb+BQ5OCaYXegNEaWDLan2IfY7ic=;
 b=gMerAVrXOzHLdxpjYIUb8MZ7tidLINYNS3b4jrxEhiQHH29VagbZTlO+xLFC9zuXcB7dXJong3NUWX8mM1024PrrYo3CjR2vf6b+alkor1bgAFZ5XOFMqAS67xAt3IDvs4Clz0jUyuUezEpYh/cqeaGTG6rEwLKXV4l/6jfHvxw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4256.namprd10.prod.outlook.com (2603:10b6:208:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 06:38:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 06:38:30 +0000
Message-ID: <b378eb8f-c464-66b0-a95f-9ea47f3d7023@oracle.com>
Date:   Thu, 14 Sep 2023 07:38:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/3] perf pmu: Move pmu__find_core_pmu() to pmus.c
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
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230913153355.138331-1-james.clark@arm.com>
 <20230913153355.138331-2-james.clark@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230913153355.138331-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f59c27-2b9a-488d-8bed-08dbb4ed35b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2bbDmwdSIvEjSm4mWtBNqf9UuhkPASiyui+nGOCLulmQmZZE8qEts6NbPhA1SF2od2xnMbQuYaMX1hv0sW1+pRr9dfi5R+K/vJdou+i1Pe5rHtt2GQYoXRAK4LaLGSucsNzUsfthWQ41j7p2owuY6u8g4GdWabUkY6P84TMD971Pezf1d4pun8zKOKKaKNcDiDKOEzwYa0cz98rqEdm9AmUPgSJ6fwaZBF/lEDi1tyWxrL9bPhIRqM4o8LSkR2JpC7ja6HSUoais4qXRKRyZdxAE/IlMfkr1f8GxBA56rreAThJMsTZMxvpTWVg2CilyUHuJbblSKFM1rbzjOnVKWOrEU+yw/lk6JEfq/o0ks00zFm2NvUWLl74i9oAiznkoPAQhE1ICZlvXNl/AAxAQ6tYSTIOH2/WhKVd5/qX2PXJ2LSXtMAa4ssmPfo9DsYz0GA7pRC2gnatbJjRRHwyCWiqKfjfQ42+RHIFteHNZowUfvjl5iacxR0Eqb1yx/bsdg39UU/SfBH367GRqipcaIuPXaPGGTX/Z1IzRplgBGI0ZDlxGRcKadnl2Pap660ibXK3r3DC6wnYnkp5PY98F0D+p1mtQ8UyaszhrBKCbHQjD2vDUQ0lvAix/J5YXctp2lTOTvzpK+xtwpLtjaxw3cWHHchwy7iTl0yhEunCUmqD3DSvie3lpGQY0Nm8Jj4t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(31686004)(36916002)(53546011)(6506007)(6666004)(6486002)(38100700002)(86362001)(31696002)(83380400001)(36756003)(2906002)(6512007)(7416002)(478600001)(26005)(66476007)(2616005)(8676002)(8936002)(4326008)(54906003)(41300700001)(5660300002)(66946007)(66556008)(316002)(101420200003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0dlZWhyOG9aVXFYdWRFZithdWpJTnhhTmxuZWxjSDAvTUVPU3l5TjZXaFdT?=
 =?utf-8?B?T3J2aU1rUHgwbUdOZ2lKOE82WEpNd0thQVMybitDVzNiUFg4R1crTm1nSkdU?=
 =?utf-8?B?TU0zMTJjY29LdTdNak00dTN3RmpQMnE4NkU0MTBxM3VmeXlhaW1WanpjWGhk?=
 =?utf-8?B?SFFIWlVPclV3NzBqUFlRMXlFb2xsM3hsWjNmcm5iV0EvUE12bjJTUjc5UUw5?=
 =?utf-8?B?WWxwbVZYZzErbm9qTTJXajV2ZlQ4VkFIMlErTkV0T2ZaYjBZbEtPYytXUGc3?=
 =?utf-8?B?Rk1kKzh2cVg5dG1TU1VyTkdQQVI3WWVvT3l1SnFPbHFEUmVicXNsTWpOMHVn?=
 =?utf-8?B?ZDc0RDI3ZEgxUTdMV3dFSkw3dmkwc0hHTnFIME5KU2ZRa3JrL3RPLzZrbTRw?=
 =?utf-8?B?bk1vWHdjc1l6TnlJcDJndzBFajNzVWRQUktPVktBUnBaZWowcnNpYUZpYStC?=
 =?utf-8?B?bkR4TEZIOUptdXJOUW9JazlOU0sybktpVUJBWUtIS3k0SmMvOExrOFdqTFNC?=
 =?utf-8?B?QTloZFVxVGgxQWtRamc0Mkg3NE12WmFwTzF0WjlzRGZtbC9UOUhnTjBxNncw?=
 =?utf-8?B?RHUxMjRHT3E3TUNBWTVGTHFoU1puVk13Ti9QMDFIZ3dHT1hxVUp4dnlnSzVE?=
 =?utf-8?B?OHgwRjFjelBXWG5ReHFlVmNadWt2Yk9LS1ZjdmpGbkVKYzBuTldDNGs1MjRp?=
 =?utf-8?B?cmNQU1dwYXh6alJrVUxqSmdLQlVLUVEwNXJXQ2lHeHQ4MVB0QUlrYUZXeXI3?=
 =?utf-8?B?WSs2c1ZjQi96WGdWd3ROc090NlhoZEN1dEd5Snk5S1F6SHVpZ0NMcnIwTUlU?=
 =?utf-8?B?SWd6M1VNVDNTcDVpOWNudVZsSHlOMllrQmdERXNSYWdLNGRXMDFTaDV0VFZ0?=
 =?utf-8?B?cXRrV01EbFp0ZkMxa1hTd1YxMGFMVE9RRHdVcHBEZHRVVU1zZU9TQWNaVVhD?=
 =?utf-8?B?V0RRSHRoZFIzcHoyb2FocEI0NkVkYjlqS1V2L2JYTUNvVG1kazJrRE4yb0VJ?=
 =?utf-8?B?UDZDUUppZnd4R1V4Ym1NWVVnKzlzMHQ0TlV5dzExS1FjeHdMTy9qUDdFQW85?=
 =?utf-8?B?ZlEvM2N2KzQxQ1ZQQ28ybEJjTzJNN2xSWlY1Umd5c0xoYllEQWxuSFFqUEV0?=
 =?utf-8?B?TllYWlNMdWlJdXEybkZsaTB4ZWtPV1M4L0pZZkxXbXJqTUUvY2VucHhFK0Ez?=
 =?utf-8?B?UUttY3d6bUVpZVFwZUowcFBFV2w4c1FsVGFxT3Q1RnVLc3VMcWg3bUFpc2cx?=
 =?utf-8?B?WGhEZmNrZld4Y2R2NXBqMHE3bFRwUERoUWw2SS8wOXVIZkJmWlVCbGUzNlVi?=
 =?utf-8?B?bk1pK2xvWHBLNzB3dlV0Vko3cmhiSDFDNkRka0JYSlFWeEw2aGQ4blc0Wk9P?=
 =?utf-8?B?ZGNLTmg4YnlJbXk0Q0cwb21nLzdlOG4xdjFGQnRYQWRwUmxjeVM1MTVwNU5M?=
 =?utf-8?B?eUhxNDNaSXdvOEJnQks5ODM4bnlLTzluNGpCMUExcG1idjIybEZVaEl4MzVW?=
 =?utf-8?B?U2F6eVZZV3BFcHlWT05ZOGhlZXhvSFFhVFVKRUIyZ1Q0cytNV0x4enRMTmFK?=
 =?utf-8?B?RjhVdmxTdENCSGtKdXVKRUd3SzZoZkdYd2tpV3FNUXRJQzlrSUp3OENFVXZp?=
 =?utf-8?B?U0dJc2lsczVkbzh3aGdmTEs2R3o5U2l2NE42KzRIM29PTDByTXpTOHFnb3hk?=
 =?utf-8?B?bDBHQ215R1VrR0NnZEMxTExRc3VzYmdUZHJHbFBkeUFFa3h0eHg4RlU3WTJ5?=
 =?utf-8?B?VkNlWW1VMy9jZjhQY1BPUmh2dzdmMSszQXpTMk9yT0sxcFoxZzJsK0U4MlFr?=
 =?utf-8?B?MEt3YW16S0pURDZpQ3N3S25NMStVNFdScWkwK1JvdjVjOWlIcnU5K2ZuVWpO?=
 =?utf-8?B?bzdjN1o0QUY5YmhnQjRTSHp3L1FhTFFwSGl3NndQNDVLVzY0S1NPN1FHUFVm?=
 =?utf-8?B?VUM0bmc3SGMzQ2QyaWdPY1JGbVJqWm9uSk1JM1kvb0ZCYjYwd3ZlUzF1YTF3?=
 =?utf-8?B?R1NWekl6WWhTQTN4SzR5MG0vQ1BCcjZTR2VJT0xZbnF2ditjQjVRQllMYWZW?=
 =?utf-8?B?NGZqeXRxMFNrbUtqa1k4cThVdVBvMFpFbmJzSkRwL2JqQnFoQnpkM2Q2cDBB?=
 =?utf-8?Q?YNMANL9P91mKlVWfUl/XPDNaX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VkdvdTA5RXRrTkdvVGlaRGIzZ3c3SnNNT080NDJlRUtQRHJQUmZPM1gvMlNV?=
 =?utf-8?B?dkNNc0k5TUtBZkZtKzRkYW5yVDRGTkNaMnJ2TzN0Q0kyVWI0TlFOT3VlZWdW?=
 =?utf-8?B?MXl6dXltcDNlNVZkOXJwcG9kU1hsSWgyTllJTFZVQkFzRnRLdXlZWHNZZEpr?=
 =?utf-8?B?UWQ0VVRYUHU3aFE3VllFTzVGWVVZc1BFUW5na0NEQ3ArZXBoS3g5eFZpS2pD?=
 =?utf-8?B?Y2VOT0lGYU1hbm85TGM2T2Z0M2E5TEJuUGNSVGU1UUJNQ2Y5emNsdHhPaU5h?=
 =?utf-8?B?ZXRHdXVFd0ZkcUplTEFYazhPM0FROXN2SUVOOTloSEcvblpiRTRqSExPSTVm?=
 =?utf-8?B?N2xaM1B1MDVJbm9YR0lWNktxNUt5OXlCOGw0Mlp2N0dCUzJhbXJ6YVVhSmVT?=
 =?utf-8?B?WnpTUnU5YUpPSTNHQUNON2dFOWRzMVI1RGlMeHdwWDJ1MzJHcnJNL1dQcEJW?=
 =?utf-8?B?SUsvYVlvRHFiUGNFUTU4TU94UTlibzBjeVB6L1RmVUdiMUZtWHlIOVM4ZXd4?=
 =?utf-8?B?dmgrREI2RzZXRVJ6N3M0Y0UrN3V6S1NwenRDZU1YL3VkRGY5WFRQNDZtbFZN?=
 =?utf-8?B?Z2J0SVdMY2lSSE1LM2k2YlR6MzJ6ZDl0VFdxaEF6bEpWVSt6MjBaY2w2eTZO?=
 =?utf-8?B?bHRvOUVESythekpIYjZYeHVZQjFBZC8yTiswVDFnVkFXNDJFNjZHN0d1RElt?=
 =?utf-8?B?OG5FckxQT09LaDRxNVU5d3IwRmJiWVdyVmMxNWt5cWd0bnZ3V2NkR2JobTdL?=
 =?utf-8?B?Ym5OV01PNlRia2hKL3QwZEcwbUgwSEQzWVk1N1haRFkvbTFMeCtlVHV2Y3p0?=
 =?utf-8?B?UVprSTc4TXQwTmREcC91RHBJdFo0M2ErN291TUR1UjJsaEt1OGRDaDdVWUp6?=
 =?utf-8?B?K2ZSLy9GaDZ1RkFQdlRiaHI5ZGFyVnFyRm9xYTRUMVBhVGtQSHZPODBzcU45?=
 =?utf-8?B?bDI0TmJqcG1Va3k2OUJlU2ZlT3dUT2c1NTBrSzIva25PcFlYOWd6NThXRDNa?=
 =?utf-8?B?Y2ZFSi9IVDJZcHl4TWZBYU5lQ3l0QmlBc3pOcUlnT1g0R3FEWm9rVVFScktG?=
 =?utf-8?B?YXJhRDZWVWpVTU9CZzc0M1hHR1lpMjdxcEJ6NGdPS3hhTGdWR3ozT2FTLzlv?=
 =?utf-8?B?SUVkTzdZTUgwWEwwS3Z1Rk53S0Q0bDZIMkRNVjNqUCs5dnZDNmxPeUZQU0x1?=
 =?utf-8?B?TW9CaU9HYTBIZWMwTXdSTEhBVWRHYU8wM3l4VWdSc1VydTFoQ1VrZWNBYk5X?=
 =?utf-8?B?WEZuVFgralFIUjQ2enluWFhKR1dtelluWjV4Q285SkFIYWoyRXNuK2pHOUZp?=
 =?utf-8?B?YUxlOGJ2OHc0N292QVpTaWcrVlZ1UVRvTWRUL2o4d2w1WjRwZE5aeTdZd21t?=
 =?utf-8?B?M1BXclAra1pJeW00NURUak1oK3pOaW5SR2pCdXN5RXRtbjdxZWNoSW8rTzda?=
 =?utf-8?B?THNQOGptRlZlbTY5dzNPU0dxYWZzMURvNTFZWk1JcXJ2UmNrUDdiNGkrN1du?=
 =?utf-8?B?djEvQWpycEU0QlRJbENLQlg4eEJhVUFZN1gzQTY5ajUxd3Vhbm03OXdLc1Jw?=
 =?utf-8?B?Qlg0QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f59c27-2b9a-488d-8bed-08dbb4ed35b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 06:38:30.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aZDG20UwEfchIYSwnHOtImuWMb5WDzGIvOpbCDDvGvgK/0GjR1TcdEkEbBAXjUK8k/0RDTF/yU17tX+UflEIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_03,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140058
X-Proofpoint-GUID: fPCMNZBCkly69R17CkTGLhlSS01_PmhO
X-Proofpoint-ORIG-GUID: fPCMNZBCkly69R17CkTGLhlSS01_PmhO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 16:33, James Clark wrote:
> pmu__find_core_pmu() more logically belongs in pmus.c because it
> iterates over all PMUs, so move it to pmus.c
> 
> At the same time rename it to perf_pmus__find_core_pmu() to match the
> naming convention in this file.
> 
> list_prepare_entry() can't be used in perf_pmus__scan_core() anymore now
> that it's called from the same compilation unit. This is with -O2
> (specifically -O1 -ftree-vrp -finline-functions
> -finline-small-functions) which allow the bounds of the array
> access to be determined at compile time. list_prepare_entry() subtracts
> the offset of the 'list' member in struct perf_pmu from &core_pmus,
> which isn't a struct perf_pmu. The compiler sees that pmu results in
> &core_pmus - 8 and refuses to compile. At runtime this works because
> list_for_each_entry_continue() always adds the offset back again before
> dereferencing ->next, but it's technically undefined behavior. With
> -fsanitize=undefined an additional warning is generated.
> 
> Using list_first_entry_or_null() to get the first entry here avoids
> doing &core_pmus - 8 but has the same result and fixes both the compile
> warning and the undefined behavior warning. There are other uses of
> list_prepare_entry() in pmus.c, but the compiler doesn't seem to be
> able to see that they can also be called with &core_pmus, so I won't
> change any at this time.
> 
> Signed-off-by: James Clark<james.clark@arm.com>
> ---


Reviewed-by: John Garry <john.g.garry@oracle.com>
