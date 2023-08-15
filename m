Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA677CAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjHOJlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjHOJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:41:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD30A6;
        Tue, 15 Aug 2023 02:41:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOJlq021641;
        Tue, 15 Aug 2023 09:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jsxW4Re4AQ7IDUtNqq+MZi2nW5w+ZFbzxQPvW4oBwuE=;
 b=NGOZ8gG5hzf6H6wmZQhrsn72/5wb6k1b6hhGh0Xby3kiWp89ogCocjfo7QAD0h3WTCMw
 n9+/kMbzTPuv45lR9meKUDMCuiIPJ1xBhJcn90uOK0uI1KbPYaTP0vuMjgqd6xdKoXnH
 5kGa8WM0yDTwxm8+QE74s1pHtObMgxvUxZ9OiIZXtbcK5Jy3LD4vEK7GxrjKFhXbU7bt
 s5JJQBK3bsk8ZbE5gvE8CqmvLqMUdsiOGYLlPAnm+i0XBAbZLVzh8PTwV5MZp3yEyUEa
 jIH/w226b74LQhatLr1X7OUloqQUJglvPY+xipaRF47imllXyEZgRzJE9klUvyjRmCCB Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfmbn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 09:40:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F9aefY027555;
        Tue, 15 Aug 2023 09:40:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rw2u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 09:40:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2Cfvik7HSBh1HL7MsVbIfXQrp7eunIa9Defv8WPjjx59zBmMJgB+pkgvbMmHHamcU7g61seCStdpx4aFC0gIKC1zWEvHp6jaN2cSjl9UN53E2xaxQI+0ULFNnEieblHIjHDuCV/55waDd1K1UtZZJUZW4HNYRa6kg7N/wBevIv55BV5xY66LEHroT1MOTuZBa79xsMWDH22gElCv67MO6lV2ww7FQqjBP8OpShooNaSgaNtfzm9ziAQov5ZdKqH7Wj+AcoaCw4rB3M3/HWZsQ+5PbisOQUYVKdaTQk814NCIx9l5tgxDGOh+reNjaUHeaaR3VKX7QMP2uoRBr6LaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsxW4Re4AQ7IDUtNqq+MZi2nW5w+ZFbzxQPvW4oBwuE=;
 b=MizJiwNdEEj4RnJEp7Hav/iQeAoYa4c9xoomJd4+rf6hWsBvohUYfBflgHgfVX7w2Y7jnM6fi15xtRDhDkXF23ynMnKyeNrs/i8J6WmzvR3hx/t86rNnfd7kRz5pebhkUDuBN8bkkRigdjY3+AmnbQZHTTwonkOgs5wMThgzdXqa+j09Jq7FU+7mmO9k+tYyxmPBCkik3LAVMuH60HULXflbBXeo/zbYfV8ugOuED4cDjzffw8FtzNe7bHOh1DZrVuzK4XWiECK62yZEx+0ryMKRfrfXG4L6JAJNkT0BLks09VZze4KedixfuqseeXesQiD7jEbxxYjDnE+0FNK0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsxW4Re4AQ7IDUtNqq+MZi2nW5w+ZFbzxQPvW4oBwuE=;
 b=NrB1e/mjON37cuJt/2zHzWDLWoMmdfala+pTIFioCfjVK8gqt2v7QcO0a2RKjoRk6/iO4F6ERASoq1zJHqp7ho24cknzTn819UGn+RbzRMudW7wRXsITFXteioijf9z7CjE4tze/Z3Tzy6XLSZTRHhxhRdtFuRZRUiU62fxsjZM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 09:40:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 09:40:54 +0000
Message-ID: <18140960-e8bd-a331-8322-db7254c43bdf@oracle.com>
Date:   Tue, 15 Aug 2023 10:40:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 5/6] perf vendor events arm64: Update stall_slot
 workaround for N2 r0p3
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
        Kajol Jain <kjain@linux.ibm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230811144017.491628-1-james.clark@arm.com>
 <20230811144017.491628-6-james.clark@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230811144017.491628-6-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0479.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d12026-5820-4ed9-85b6-08db9d73b885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCfjWYrfOE2TLAfU8e0A/7vWWZYm6VKtxd7ZgJ/NApq4XHOtllWvIBrEXWsjSC0Td+SSIOWbfDP4AQaIpBCoO6LXzKficpaTpacQ2nQ+G1mEUZJZJMs2WlLuovF3Gfli9+5btkC3wXt5lWDuORoIYS1My57bNjs+wS2ZTNgVNn07GeR6dGujpvBzlNrClkpqAKfPznwQdY2II4vtXcIm5puIVvHCh/mLcnYQzSG1wNYvIyotaDP+EhJGQrKZEV5a/CTvX2gK0Sa1ffuGqTkIWMCOfPY0qkkFc8NV6b7Urt10TQ7N6TTMk1tfmJJV+FgZUEthDWAtM3HdapGYW7PTAhRH3VH6jSyuUf7QpQ6P1BzYp7L7uMRn/5i365t9S/evExaF31W6dL8IsY6uAMxVkgB+FwvQDYEilZIoIX8jaiV7UQgLYVzaiWraSAmk3Pe04L1hAHJkbfRAyBDrX+4414QAuzARYQNYOyktB5Ye/L0LUdp/FbJFh2juD3YsrCZOe3lMs93MAaKhJb+ItOjMA4IspF5G7a16lrLbqDFHPfMcaFONvS1Ezfb9md9lUMjSkY1c0juB4zTHE0Skd3dzeGQTGUk3FpzjLhIihxrfVc5PcQ3PeHY1EIhzgxamYog8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(1800799006)(186006)(451199021)(31686004)(7416002)(2906002)(36756003)(86362001)(31696002)(5660300002)(38100700002)(4326008)(8676002)(8936002)(41300700001)(316002)(54906003)(66556008)(66476007)(83380400001)(66946007)(2616005)(26005)(6512007)(36916002)(53546011)(6506007)(6486002)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG5oK2tyVVRnMDNkVjRJM0F2bVg5OTZjbTZPVThqNHh6czA1RjZrdXlybm1L?=
 =?utf-8?B?L0I5TzFKU0M0N2hJTlp3YlJWNXBwL0diRU4rRVRHYnpqVUJwMjgzNnNYemVv?=
 =?utf-8?B?WjZsSzVaT3FYUzltRTVld3B0OTlOOXVOUzNKOWJzcVdRSyt6YzZPKzFSblRz?=
 =?utf-8?B?ZFMzRFVwZ3hXTk5UTExtVy9ROEpkLy9FRXhKVm52MEVhS2pjb0V6NDNSa216?=
 =?utf-8?B?bytzb3RlWGNBRWFzajBiR0ltT2dSTGFWdm5vTW5mem1IRGFtNnBUL1EvR2xq?=
 =?utf-8?B?SllWaGtKSE9IT0RjS0VaTjBTczlwTHJBOE9XSVpydmZLczNnSkUvZDRDMC9V?=
 =?utf-8?B?N01GTGxIbmV0ekVzN1RUMVcvSHBIcURFbHVCZDZSTWxTNWdPci82dDJVWEMx?=
 =?utf-8?B?QjNNeUtnM1RiQ1JueWtNT2czNVAxV1BzdUxNcVVuNHRnaS96NVBXWERDK1NY?=
 =?utf-8?B?aGVzUGlzdlFVVndjMzFkb0lmOEZqMUxZaFJUSi9sZmpwS01VTWhqNUdKRGN2?=
 =?utf-8?B?dGNMc25mc21aLzFRQlZVTUYvWUZ5Z3Jja0JVTkthcjZvdm03aFdCY1hSR3JD?=
 =?utf-8?B?VUZoUlpNUWVqSkZ3bVlIOEdGczBYcnNZQk9pME40ZURCYkNzTFI2d01lZWNv?=
 =?utf-8?B?b05NZmd1SW05dU5LWnA2RkQwRTB3L3pQT01uQ29FdDQrUllQdGZxK0hMdnVj?=
 =?utf-8?B?S2hzUWFlYm5SOEw2Z1E4STkwRzJuSUI4TDV2ZkM1d3hQaU55OXlQeTdXZ1pj?=
 =?utf-8?B?VStOQmw3bzJEOTQ0aXB1TmgxMk9pWUlmMmFPM2p1d2VpejB4ck14bFJoc2g5?=
 =?utf-8?B?TEZwSTJqbEtoWHdIeFcvNGZQWWlXOUJhMG5NZjF3czlqR2J0aVZSTkNvNmpI?=
 =?utf-8?B?bmFQd2ExN2hRSGhXOElqbUxjcmxwWlE3OGlmbEFGT1FzRnFDNVNISVNXbU5L?=
 =?utf-8?B?N3MwRnVxc3ZGMUxXUjIvamN4cmlsUlRUbytnMklZRXFpc294d1F4L3MwUXg3?=
 =?utf-8?B?WUlFeittT2JWaHpmWFpIY2c1UExSRE9HaUEzbEh1cEhTeHVjQlpZdGJTVHZI?=
 =?utf-8?B?TkNwczVsbGdLenloS2NwRmhTWGRydENzcW5kaFB3UE1FSUxOSU1pR05hbWxu?=
 =?utf-8?B?bitGZkhicW9jMmQ2RjJLdVZwV1BCOW1Jamt1UFQ5a3ZuQSt6T1NuMDlVcTNN?=
 =?utf-8?B?N1NrRFpvZHBBS2xqb1NyS21vRDNsK2NwRFBwK01GZzZxV3dLdHNiL01OcnE3?=
 =?utf-8?B?eEFSY2JKTUYyNHZvRFhHeVA3Q2xZcks0L0tjTlpyWGpFeXdtK0pNQ08vTFQy?=
 =?utf-8?B?dEhNZ3dhSVVTcTRZOFEyUnBVMStFY29UOW93Vmg4dEhRRkl5d01lZE4xdmth?=
 =?utf-8?B?U0l1OVpKMjc2WlNvNzArbVpVV0ozWHNxUlpGYmxmYjZsKzFiTW5pcDduYnMr?=
 =?utf-8?B?cHRIWnJaZUt6ZVhCSFowVDJsU0R3U0NQRnNHVmtZVlBtREc5NElaZUVLWEpY?=
 =?utf-8?B?cTJLY2dGRFBHM1NLc0dTcnlhQk5nZUFYTVVDUE9DWk1NemZ3VFAxbDJtcjB1?=
 =?utf-8?B?SFd0ZnBEc2hWdERDWHZ4bHd1dWR0V2JOZXZwU1NtSTRyUWE2ZVFlckpmNjVY?=
 =?utf-8?B?dmtmcUlEZWRCaXM1L01maDlBV2pqNDJPb1IzTm16Z2Rkd3JFMUtlK2VIQlo5?=
 =?utf-8?B?OThFdzRJM0F2V3gwakdtRktMMy9TZjAwazFobnBGbzJhc3NGdjlkTUZRMzE4?=
 =?utf-8?B?eHhSV0xQQ3VrZ3M4T3VoSHJ5ckYrUmpEQ0NJMjE5LzFWMThBdXpmU004a2NS?=
 =?utf-8?B?UGM0WjRtRkFWWFdpK3BKQTJ4d0czSUZPOUxSR3N5RlRmQ2cyeVJBTnptSHc3?=
 =?utf-8?B?TFplZ2R1alcwMG4yOGw0K2tjTmkvT1M4c0RJVU92RWZsUVZmajhvRkl0RE50?=
 =?utf-8?B?YXROazZKekdXSlNkcEd2VVZsMk9vWWc1ckFPd09PWHBhZ3hxcmczS2pqYk0w?=
 =?utf-8?B?NU9QeDZBaGZHWC9tc01udHJ5RENKZE4yYzNiRWNGaWZzanRKdUdIUVJ3Qm8r?=
 =?utf-8?B?MFlzTmdWN3FtdUNNMUs5MkF6VXhtTjRQdWdmV0FCWkluUTlMeVI3a1gvTU5C?=
 =?utf-8?B?VlNYZFl5NmlSZjZNY2RtZ2JreE1YbEpaSVRKMm1RbndZUUs3OWplSlpLYS9o?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VlB2dTZlMnJXOTY4TFRJN2o3d3dielRGa3A1RW5SQU1jYUJleFF3TDV6VU5l?=
 =?utf-8?B?MXUrUlVxUDhicmpKYVlqNFRUYmFkSlhHR3lhTDNKb3ZKMmpmMmJtbS85VHg0?=
 =?utf-8?B?bENrS2ZaTGxHRTFVbUNDSDV4MkdHUFJBY0lKUGt5VmdRZnp3QjBLbHl4NDMx?=
 =?utf-8?B?QzEvUXZ5dWc3Ym9JSkI5TjFPeUQvTWprU0dnMUNORlNoeDZQYytvV3ZQTitB?=
 =?utf-8?B?ZjhFNjRpdGRxNXcrVlpuQ3dnV2xpN1ROUjZoOFE4ZWpNSUE4UTNpU20zTkFZ?=
 =?utf-8?B?WGlHbUg4S28zYUFJM2Y2YnErclNIKzNSdnQwR1RINlVtRVRpWEIrcWh0K01F?=
 =?utf-8?B?c2t6Q2FtcVVlZHd1THBwYVAvK1ArK0lZQWpwaCswZ1daYktKZWo2emtaR0Rz?=
 =?utf-8?B?ZEJ5TWxpUUxpRE1nVk5zZmw1TWRzNnlSRTFnVktvMXYwR1YzOExKK1JpUVpD?=
 =?utf-8?B?V1hGY0haK1NIUUJab2xlYzUwNmtoaGZ4eStmZUNkRVNaeDNMY05VQ3krLy9E?=
 =?utf-8?B?a3VDcjZsZ2NGZkFqSWs3L29CazFPY1R1NVUvVTlBSWlCOG9qRjdRQ0JTVmZN?=
 =?utf-8?B?dW56NjJaTnByd3dtZW1xN04vUHhnaGFadkEwU1JFSmRKS0NEOHNDMU9iUUZa?=
 =?utf-8?B?bVB4VnpiUXRLT3RKb3krejdPZ08yckZZa1kwQzRueThCaGg4VWZ4RHJIQzZP?=
 =?utf-8?B?TVpzRHdqUkQvdm9vMFplSGV4TXpTL2ZEM2tCRXRNWXlaQTgzK0FuMERyZU1U?=
 =?utf-8?B?Mk9kSS9iRVZoc2JyNDlqaW11aXlaSkw4VldxZ2plaG5uWmdFVkdNaVE5K1lT?=
 =?utf-8?B?RENYNE92bEgxK2xBdjJDZFVaQU9kdDRmYkpsbEVQcXdKaXFaZndhNVY1cWVK?=
 =?utf-8?B?eE4xYkNzVjV6SDJVMUpOTjRBV1ZIVW4vNnM0TmVIT0F5WndRTGkreEl6c1hT?=
 =?utf-8?B?MHFhdkhsQk9oTVFFUEQ1ZWpXbytWMjdSRHp4d2F5QldaT0RybnFFUWlxM04v?=
 =?utf-8?B?Vzh5YWRjcU5UbU85Q2hyc3RlMmdhM3dFT3ZqMWpTZFZtM1dncksrck1YdmdE?=
 =?utf-8?B?UDRad2dXaEVac21lUjk2enM0SkVDQWRvT24wWm5nd1BOQzdjN084SWU3WGtY?=
 =?utf-8?B?dDZCSW5TUWhJdk5BS2s2RjJuUGFwWVZaeW0xT0p4Q3Q3Uyt4TS9FSE5vbzdJ?=
 =?utf-8?B?Z1N3YTBRNVJ1Ti8xSk04OERXeExqUW1CVjlUZlhxU0dQTVdPM2IyUTF3cTZQ?=
 =?utf-8?B?b3ppcldUVU80UVNYSmZHUEZlbFVlb1oxK1lvY1dCL1ZzUnhQVHAvU2s5MHF3?=
 =?utf-8?B?UHRnNXdDVTFOc0lGYUc0bzBkTnNNRVZlMS9aVStlMUZkZUxySklhYktoVi9C?=
 =?utf-8?B?Ym1RNlNXcUpKYWFpKy9ablZPMGFnN2VtZm9qeW0rTEtzdCtiWi91djZBaDFD?=
 =?utf-8?B?NldBL3Q1ZHBDZHR0d2FpbWozSVJVTW1xMHJJKy92cHBoK2xtbVgrMjlweXFP?=
 =?utf-8?B?K1JBT0Z6ZmxPSnJXZjBMdXRkSDIxRGFMeFFuZ2tLNjBNblVpV1JoQzJOWWRJ?=
 =?utf-8?B?S0J0WTFyNWFRcWNBQnVsRHFVMCtmL0RDZjBxaU9yRWJoNDFQUGlUc0JxK2s4?=
 =?utf-8?B?LzlzUTB3bzUxV3VCOFVsVUhvSkNVWkE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d12026-5820-4ed9-85b6-08db9d73b885
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 09:40:54.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OTstcdLXemrlbUjC1A44J/9VIwd6h5NChAkSAAdZ/2oxy7VK5NvRFsz8UfDztMqjq20/u3s4CGpT2SuBd8czg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150086
X-Proofpoint-ORIG-GUID: aemBFH5pcw5c5KYWV5c5HFIi9-P4M7G5
X-Proofpoint-GUID: aemBFH5pcw5c5KYWV5c5HFIi9-P4M7G5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 15:39, James Clark wrote:
> N2 r0p3 doesn't require the workaround [1], so gating on (#slots - 5) no
> longer works because all N2s have 5 slots. Add a new expression builtin
> that allows calling strcmp_cpuid_str() and comparing CPUIDs in metric
> formulas.
> 
> In this case, the commented formula looks like this:
> 
>    strcmp_cpuid_str(0x410fd493)        # greater than or equal to N2 r0p3
>    | strcmp_cpuid_str(0x410fd490) ^ 1  # OR NOT any version of N2
> 
> [1]:https://urldefense.com/v3/__https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2-r0p3.json__;!!ACWV5N9M2RV99hQ!MaXDALyhn3HmfLdPUZRKTItKxg73C-qP4aTNAAdFwzjW5cFEBTHtD-VyqBzUTFbXMvABB-daDD01AfI7um_BtA$  
> Signed-off-by: James Clark<james.clark@arm.com>
> ---
>   tools/perf/arch/arm64/util/pmu.c               | 18 +-----------------
>   .../arch/arm64/arm/neoverse-n2-v2/metrics.json |  8 ++++----
>   tools/perf/pmu-events/metric.py                | 17 +++++++++++++++--
>   tools/perf/util/expr.c                         | 18 ++++++++++++++++++
>   tools/perf/util/expr.h                         |  1 +
>   tools/perf/util/expr.l                         |  1 +
>   tools/perf/util/expr.y                         |  8 +++++++-
>   tools/perf/util/pmu.c                          | 17 +++++++++++++++++
>   tools/perf/util/pmu.h                          |  1 +
>   9 files changed, 65 insertions(+), 24 deletions(-)

This patch looks ok, but I think that it would be better to separate out 
the metrics.json change into a separate patch.

Thanks,
John
