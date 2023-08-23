Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C419785515
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjHWKO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjHWISZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:18:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE6010C6;
        Wed, 23 Aug 2023 01:13:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MMDpuW015274;
        Wed, 23 Aug 2023 08:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=shC5ryzFfw67u5eDJ643bVTecWqSG9FewRm1umZNZac=;
 b=IVuaIWGyDezmwnFnFvMtYYsCiu9B2JPFPrFKVR3ahCw1FYFIEPJ3kEcHG8D/INNoRMUa
 HIsPrXVu1v+d0p5dJDfpw47Bkfvffn3yGHIqfG19v6jNxTxfLQRqBeDWEdiiPY+IPXGf
 qBHxzWnQzSX/OnNtj8FID332uGdr2qPx379Bwuum365R2f3V91SZ+tYt8A3BuM3hzslg
 +PIqXfR6K2QLJ657uDmlBUKdPY91osWpWutEYfQ8/sEGJCWyj//0Mqc5TQ/zcip41Qc4
 Du3OYvJNdHgJRPdE7gPvkvp2PZ4a0vd8x/CNfZ/pZiCnaPh+cPZWudZS31PvPxzetAUs Bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yts7v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 08:13:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37N6avmA036104;
        Wed, 23 Aug 2023 08:13:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yu80c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 08:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGy5Lbn/c4hs51tgHWsCdIQvrZAvbawGM8V20b7v+tMrrfMn30TuDSZMHjOoU6rSh8OcDQ4EZ6epUIuaN2Sb2Qhl4devhzrarT5JrebGHJVmryOpnZEfY0FcnYa9Otzpej3mVw4jIkAZCtjGqgGhKdaFOvgMSkH7pAblr5YJQ3lR+p19InVhtgq4nsLsNe1NPbZA4TTuGzat2JfOGSpoTGdQIuK0OQggjIzZi3HNyM5v5RdvVfXIRhYSLMRx4ArMw9Nss+JADMoGXTPsf2Yx7cXb3W4fk0JXK/JfUOlylbkeUb0kFiB9nCU+q6Fwm8tbKw5oU5U25iwQpGEzpIlJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shC5ryzFfw67u5eDJ643bVTecWqSG9FewRm1umZNZac=;
 b=Lu9Ysxwx3jVoqE2Ce3LMigQDgb43v4QZKM4thCXHXLMZ8fKDHNRG1LUc3niR/WTS4xUaktPzLhq1kgyF3Ge3v0yJGuhzJ8KBKVojaAvc/FZS/MiXZjAFIwC5PoZhA3/oJiVxfJwGlPJKHTkcNf8YB+0iwvYgrGHs3h49Is5YmU4BoSTa88Vbe/5dWXth06i26CSSoi+T6JbEcrjg1UYwR8BV5ujH57l0aQ4cCjRMzxaGyeiPDV3xNuGC6wdF4afOLJ0wDstJr5QiCq4joiUareI5PMMJhy2HsjlirfRG9It57K0DPcda2bpO4vgE/SUL51Ns1UfWJAG+4Ldq3zBWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shC5ryzFfw67u5eDJ643bVTecWqSG9FewRm1umZNZac=;
 b=y8yHoxjzTgg9UaGP3aEit51ryzJ5DNO9Apslw/URiu81ukTwV9wBVC2/eZyXDFhWSFOCBLZ+9KZl71SL2DLDiHyJ29idycXbIadcl/qfJnhlOL/sgyQbynzRAqyPTvm1PyKO1QQGx0umx5z8k6CvumFUGiisvfrDFWB0DbS/l/I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5319.namprd10.prod.outlook.com (2603:10b6:408:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 08:13:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 08:13:02 +0000
Message-ID: <566ec1ff-fdea-336e-3cb8-503fc593f8ec@oracle.com>
Date:   Wed, 23 Aug 2023 09:12:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 0/8] perf vendor events: Add JSON metrics for Arm CMN
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
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cf909f-f5a9-4d46-b6ee-08dba3b0c549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aF0//CTEp9L+V6q6e5wOLR2jLqac0OLuOw0yTnClmSU4/wAauPni3gFK7+e22/vymr3IrLc8MKp/j7GAGX/wS+cJrA1WJGZPT2+XarYhxK/rdaNNdz3SEO62PsHQJ8ZtPLYPEyx6zYS8cmQrxZAYgyE2/Dihj7RGUj+XNJi/Wocwwfu55fa5MqtWwhi05lTIf2Kx8FLsmQ0in0pCBTNPVzbTb92ZQRu/UGrCpFTI/1DCVAGL1tta37tUwM0mLexExOisB7lGw9TUoT6gdcxysOdsqaatMievRYGUQ0eQmK53AdfLgteAbc+i6Yq9vX2NWXLPwNBpyx6bA9Q4uj9gv7xFtkjoHUVgvexpAyVtUmPC/5nM7tQz6wpwgO0xhfztMpuSYo38VGM2nsLi41wdaMbClfLSKTapFozAUq/OvY6aYMLLnj1rHCTJDtC2cDWJqzLdNfbdIsYyyJjTmaJzeVQoNGU90ysQzrIlwS45n3SXJWontFk0nZUVb/4IfjI5bCYbaEOJPH89U6D6ofDAYc7EtGUA5Uq6lN9wa4lrW+tJIBHLy8CPjPoQuV9mX5nij3WtUtWNg5fA89/6g6POGu7yuQq7sB2d2NQ/q0go5uNR9Vmz8i6UE4JG6Z/baWHUTAzrSsUS27k7sXpKrizdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(1800799009)(186009)(451199024)(83380400001)(2906002)(38100700002)(86362001)(36756003)(31696002)(6512007)(41300700001)(110136005)(54906003)(66476007)(66556008)(66946007)(6486002)(6506007)(316002)(36916002)(53546011)(2616005)(4326008)(8936002)(8676002)(966005)(478600001)(6666004)(31686004)(26005)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFQ5MEdVRTNSaEp3cEhjWjBmVjMrb2M1MFArSHdiSXIzVzdqOVh1VjNFQUN4?=
 =?utf-8?B?L1hxNGZPRlVlbGpneFcwZ2lTUnYxNkZRL1UwUFBiMGR3M2RWNWZoZWUvOTRQ?=
 =?utf-8?B?YVh1ZmU1eCtMeTVObXpiaTJUMU9rLzh5dEtaZEN5dkVWNG1jVWRkVlZoLy9S?=
 =?utf-8?B?WWZhUXY5c1hkZi8wSkk4RmlZMXpCMFo5YWJNY3JTOWtoYW45K1pkUjh5S2Vu?=
 =?utf-8?B?QmtFeTJabFhPWnk2OFU5UThlSndjM2RFa0k5QkNCOE93dmhuckFQcUNUbGFM?=
 =?utf-8?B?aStaZmpUUjJDa2dkcmJpcnpYTFJsRzJXdjYvRmZDMzlOZlNlZ0Z5Vyt0Mkkw?=
 =?utf-8?B?T0NSeGpJUW04VzFBTE1kS1ZZWFcvK3hZTlhVSXV0OVpKNjdZL2oyWmdOS2RE?=
 =?utf-8?B?Mm1ZS215cVNGdDdmcTFmVUJxeHRZNDlkOWNrazhnampHeWxLM1pBUWZkbjJQ?=
 =?utf-8?B?TlErZUphSmFBeUFQaUlDb2J4WEk3UitrR1pvUW92cnhndXl0WTAyWXhXSWRk?=
 =?utf-8?B?WEtLYUpjTDV3NitianR2cVJldklCbzlWRmJnN0JtOFBBZ0FORHA2RHNQZTA5?=
 =?utf-8?B?MUdKMUdMZ0REbXhUNjF5Q3g2MXEzRHJESzZFb2RHM01mdkJZRE5UNWx0aldm?=
 =?utf-8?B?OHd6Qkk5bDZRR09WYWRTcG5RNzFqdUZJLytYL2RxTnE1WDhQM3FHU2NiajY4?=
 =?utf-8?B?a3VWRjNsUmFlV2ZSZ2VHOUVtMDJRMWkwYjQ2bE10YjRVa3NQNnVPRVBJdEQw?=
 =?utf-8?B?MGNqTFZLN3p2ZjJKSFEzUG9qQTlOVFZMR2ViT0o0dVNJaE53ZCtQRXZYMXY3?=
 =?utf-8?B?NTJ1bEFMaDhRMXgxMWhmUkYvdHd2UTBSb2dlellxZEJzeE4rZTNsVDgyOUM3?=
 =?utf-8?B?QjhRVGFjeVQ1eU9YUVJrTHV4TEpEOU1zV1N1OGJVazNYR0RoVDNMV2hrS29C?=
 =?utf-8?B?dThiTU1DU0MrSGNPRVE3RENLT1oyc1NHSmN4Zk5BbWJsdDNBZWJQRlIxeGpU?=
 =?utf-8?B?M0xyNHlnNkt0RzdFdk11S2o3UGl5TGp6Y24yU0NVK3RJQmNDMVlNN1hUK3JW?=
 =?utf-8?B?M2VBRDhra1NTMTdFQkxUNlgwdDU2eG9XL2hKZjg0S0dqdkptY2lCaXByZ2RG?=
 =?utf-8?B?N0xJK3l5bG1RTVBoTXc5U3lERU51VUZCWllBRjlFSEVrNXE4L09QNGZ1STFw?=
 =?utf-8?B?eTZOY2U3Sm9BeWxJdW5Lcy9MMU81Z29WMFY5L2ZDR3RjRHYvcWwrU0NLNHQr?=
 =?utf-8?B?WHF0aUdNbXVET1VFQnVWMnlmMkVodS9UZEtiWnRYVWtjS0JNdzJ0c1BURFNh?=
 =?utf-8?B?VW9MaDJqazFtc2o3L3hvOFZjT09maExZbjZZOWpNN0YxanVIRzFLaWZ5Kysr?=
 =?utf-8?B?TG11Z2JZeDZoT2ZtbUJNQWcwTnpFLzNIK2NBSFYvWlRDY0c5UXMwdXl6QkVK?=
 =?utf-8?B?a1orV280VDdaSklUSmVsNFZBcTdYU0JGSFFCeDV6UHkxeFlIVjl4S2tpWklL?=
 =?utf-8?B?T0U0OXZSM1R6YVByMlZiMUxZWlFBRStYRXhRM0xEZ2I4VlRvSFBBRTZhVElh?=
 =?utf-8?B?VUVEU3RYT1JjU2J6NkZkdWZYY0ZKM1NrckxJYkI1Q3Q0SURnMXpQUXNjTkI5?=
 =?utf-8?B?bXBoZjVTd3ZPVW9nNFpUUVdWYlB2a3hvWmlNTUFLQzVhTVFZYnExbFNKOXBD?=
 =?utf-8?B?QzBFSnNNYnBqdE12QjNyTHByaC9YMHJSdThFRElvSGRTeCs4SFJTRXlSaFNv?=
 =?utf-8?B?aFZtVmFlTGJoMk1QRDU0VlFCN0ZKaHByN0t2azRRcXQ1Yk81V0NCNC9lUEhM?=
 =?utf-8?B?QU1KTXRrRmdNZlc4OG94eWVMaU1JNFE4dytDZzQ5K2dzdnRXMWFvUDlHcm9R?=
 =?utf-8?B?eEJXa0srK3BJQ3RMeU9TMVRmYTJWYU9FYjJJRTdCaHVveXFUVWR4Z0VQak9J?=
 =?utf-8?B?WjFCUWZDZzMzSFhSSkx5Q0ZzN0JqQlVaTTl2ZWcvMHhmWi8wa1VIZzlFWnF1?=
 =?utf-8?B?cHMzclU2clNzb2ZLZFBBbUEwc05OSTRpNjdVa3NNYzlCdi9aZmdST20zUnU2?=
 =?utf-8?B?aEdvd2duVTl0QTY4UWNocEE1Z09HN05TNGcvcmF6YkdlOXlNZWVWZFJhN3du?=
 =?utf-8?B?WFZSVzFGR0FVdkpJcW5USXZURE1BOU1iM2ZmQzZkRDNDRkJoc2xjVS9McG1h?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M2dwMVdReS9qOXR2aVJFSEZQYkpUM0FuaVBYOFRQL3U3TXNtK1F2MlZsdHJl?=
 =?utf-8?B?YXV0dngvajM4WXFOUkxxcDVjSmU5Y3RhQ2lKc2hEM29JOFNBUlg4VURWUnRH?=
 =?utf-8?B?aUc3N2lCbTZuTEN3S0hvRHpqUmRUblRCZGZ5M2FFekFINkNhTzlwTmpSZG1N?=
 =?utf-8?B?Zks4VjBBOEVYbWp4VjZ3Tnl3bWJieGJ5QWJiWXFvcUxSbmJ2a3FJTDNvT3B1?=
 =?utf-8?B?Nmkwcm5UUVZYRjd6K3hJRXdzeGxWWmMweFhab3JJcEtlRHZadi9sdXg0aUlM?=
 =?utf-8?B?NWxkeXRjUXViVzE4ZjJ3WWJsOUFWdG12UmJkRG5Eb3VJWENPMlJCQUNmZlBY?=
 =?utf-8?B?OFY5Y0JtV01vUEdIdi9RSFhnejFoSlB3UXFnaUdsQzdNYmU0eXYvSnMvYVJH?=
 =?utf-8?B?TUhaRENRckdDRzZlTUhLZ3ZBRFM1My9ZbEdpTzYxcDdMd294VkQwWDBKYmpr?=
 =?utf-8?B?NXN5V09CbFh2bDQyVnNyWmhBOEdra1N0a3FrSWFQaDVDN0JycWxQekNFWVpW?=
 =?utf-8?B?bko5QUpvVlQ0SzhIRnArbmYwNkhuNHp1RmZTK1BIM0IwT0MxS2lkVmNra2ps?=
 =?utf-8?B?QzVkRXhIR2tYYzA5MEo4cTB3M3R1V21TczVPNGl0VFhJNXJOYXJPMVZpVFBw?=
 =?utf-8?B?dFZmc291WmVMWWF3ODdwTGlLNUlqMDdlalJZR0Z5UExKNk1aQzRWTUhubkdE?=
 =?utf-8?B?ZXEwYUFJTFhvb0FVL3ZvRGNGaHF3SXZ5WVR1RlNoMjBob2ZjMVgrbU5qKzZi?=
 =?utf-8?B?QlZjZW1CL1c4SFRUd0xaVmkvZmtCZWpsQ1ArT2tCMnl0WHlsV2h4Q2dPVnhE?=
 =?utf-8?B?bG80T1Bqa0RLMm1sN3hqNTYwb3VJRW9WMStLeE42SmhFNlcxeXYxOWFvT3RQ?=
 =?utf-8?B?M2l0dk9lbHVwZGRTeFBac3RkWDRYTmxzWG5PblFpUnc2TU0rL01SajVWT0cy?=
 =?utf-8?B?Mmo1T3VxdGRiZkFSTjdWR3hVOGdJNGQ0L3lYUWo2cVNVTVAvSXM2TnU0ZTVD?=
 =?utf-8?B?R3ZSM1BKOGZwRER2NUNMQnRJRm51WjRsNURrNld1OWNVenR2aGNicHBOWFpm?=
 =?utf-8?B?YUN0N3p5NXJtK1VDcG82TkNKdDArbnJ4Vm1CK3ZSNzd6blJINGhtQ1JNQlZj?=
 =?utf-8?B?ckhLRk4vWE9mYVFQeVNDNXBHeno4ZHZBeTY5WlpsRFhIb0FIY1FBRm01WE1I?=
 =?utf-8?B?ZHZqRG5BM0xWNzB6N0JDN0hTQndUbU96eFYydXQwcEFTVjRhVGl3dW9nNjB6?=
 =?utf-8?B?UzlJc3ZoV2pla2wrNk5Obk5xVWVCNWp2RmlPOUhsWTkvN2N6aHdrMW1nNzJY?=
 =?utf-8?B?eGRxZUJHVnhqZXVCWUhpRFU4YlpOREhLVndTNEdBTVo5c2hsT2pOZDFiRlZG?=
 =?utf-8?B?d29UT2l0VXdrYW5acTBwZFdQVngwbXJ2NmlueDgrV2FncndTOTNUQmF5bWtv?=
 =?utf-8?B?V3JpMTFIclBWUXNsRmhoc3JkRnk5U0lJUUxmeml5eFhoYnVVRnBnSXFvR0JY?=
 =?utf-8?Q?zscRAA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cf909f-f5a9-4d46-b6ee-08dba3b0c549
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 08:13:02.4958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEbssH4Kk+BUrVJGZhHhHyN5cKrVSqwil8Ai+TjDSHQW7qsv/kzuGdltZpXTPbcFdELMTBcy9ES51aAsm48SpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_05,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230073
X-Proofpoint-ORIG-GUID: N-vcjWfA5Rr4TPHx7oICATKzvFkuXWwU
X-Proofpoint-GUID: N-vcjWfA5Rr4TPHx7oICATKzvFkuXWwU
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 09:36, Jing Zhang wrote:

I'm hoping that Ian can check the outstanding patches here, but I'll 
also have a look.

> Changes since v6:
> - Supplement the omitted EventCode;
> - Keep the original way of ConfigCode;
> - Supplement the test in empty-pmu-events.c, so that the pmu event test
>    can succeed when build with NO_JEVENT=1.
> - Link: https://urldefense.com/v3/__https://lore.kernel.org/all/1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com/__;!!ACWV5N9M2RV99hQ!Lakh7Lf-6l6Hovm4Tt5S5pqV1xHm-LAW2ICVl6gLONlN4CNk-BvyADBfjwQe5yQQj89yMK7s7rSjMNHCyFsIUxnHXg$
> 
> Jing Zhang (8):
>    perf pmu: "Compat" supports matching multiple identifiers
>    perf metric: "Compat" supports matching multiple identifiers
>    perf vendor events: Supplement the omitted EventCode
>    perf jevents: Support more event fields
>    perf test: Make matching_pmu effective
>    perf test: Add pmu-event test for "Compat" and new event_field.
>    perf jevents: Add support for Arm CMN PMU aliasing
>    perf vendor events: Add JSON metrics for Arm CMN
> 
>   .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++++++++
>   .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  |  74 ++++++
>   .../pmu-events/arch/test/test_soc/sys/uncore.json  |   8 +
>   .../pmu-events/arch/x86/alderlake/pipeline.json    |   9 +
>   .../pmu-events/arch/x86/alderlaken/pipeline.json   |   3 +
>   .../pmu-events/arch/x86/broadwell/pipeline.json    |   4 +
>   .../pmu-events/arch/x86/broadwellde/pipeline.json  |   4 +
>   .../arch/x86/broadwellde/uncore-cache.json         |   2 +
>   .../arch/x86/broadwellde/uncore-interconnect.json  |   1 +
>   .../arch/x86/broadwellde/uncore-memory.json        |   1 +
>   .../arch/x86/broadwellde/uncore-power.json         |   1 +
>   .../pmu-events/arch/x86/broadwellx/pipeline.json   |   4 +
>   .../arch/x86/broadwellx/uncore-cache.json          |   2 +
>   .../arch/x86/broadwellx/uncore-interconnect.json   |  13 +
>   .../arch/x86/broadwellx/uncore-memory.json         |   2 +
>   .../arch/x86/broadwellx/uncore-power.json          |   1 +
>   .../pmu-events/arch/x86/cascadelakex/pipeline.json |   4 +
>   .../arch/x86/cascadelakex/uncore-cache.json        |   2 +
>   .../arch/x86/cascadelakex/uncore-interconnect.json |   1 +
>   .../arch/x86/cascadelakex/uncore-io.json           |   1 +
>   .../arch/x86/cascadelakex/uncore-memory.json       |   1 +
>   .../arch/x86/cascadelakex/uncore-power.json        |   1 +
>   .../pmu-events/arch/x86/elkhartlake/pipeline.json  |   2 +
>   .../pmu-events/arch/x86/goldmont/pipeline.json     |   3 +
>   .../pmu-events/arch/x86/goldmontplus/pipeline.json |   3 +
>   .../pmu-events/arch/x86/grandridge/pipeline.json   |   3 +
>   .../arch/x86/graniterapids/pipeline.json           |   4 +
>   .../perf/pmu-events/arch/x86/haswell/pipeline.json |   4 +
>   .../pmu-events/arch/x86/haswellx/pipeline.json     |   4 +
>   .../pmu-events/arch/x86/haswellx/uncore-cache.json |   2 +
>   .../arch/x86/haswellx/uncore-interconnect.json     |  14 ++
>   .../arch/x86/haswellx/uncore-memory.json           |   2 +
>   .../pmu-events/arch/x86/haswellx/uncore-power.json |   1 +
>   .../perf/pmu-events/arch/x86/icelake/pipeline.json |   4 +
>   .../pmu-events/arch/x86/icelakex/pipeline.json     |   4 +
>   .../pmu-events/arch/x86/icelakex/uncore-cache.json |   1 +
>   .../arch/x86/icelakex/uncore-interconnect.json     |   1 +
>   .../arch/x86/icelakex/uncore-memory.json           |   1 +
>   .../pmu-events/arch/x86/icelakex/uncore-power.json |   1 +
>   .../pmu-events/arch/x86/ivybridge/pipeline.json    |   3 +
>   .../perf/pmu-events/arch/x86/ivytown/pipeline.json |   4 +
>   .../pmu-events/arch/x86/ivytown/uncore-cache.json  |   2 +
>   .../arch/x86/ivytown/uncore-interconnect.json      |  11 +
>   .../pmu-events/arch/x86/ivytown/uncore-memory.json |   1 +
>   .../pmu-events/arch/x86/ivytown/uncore-power.json  |   1 +
>   .../pmu-events/arch/x86/jaketown/pipeline.json     |   4 +
>   .../pmu-events/arch/x86/jaketown/uncore-cache.json |   2 +
>   .../arch/x86/jaketown/uncore-interconnect.json     |  12 +
>   .../arch/x86/jaketown/uncore-memory.json           |   1 +
>   .../pmu-events/arch/x86/jaketown/uncore-power.json |   2 +
>   .../arch/x86/knightslanding/pipeline.json          |   3 +
>   .../arch/x86/knightslanding/uncore-cache.json      |   1 +
>   .../arch/x86/knightslanding/uncore-memory.json     |   4 +
>   .../pmu-events/arch/x86/meteorlake/pipeline.json   |   8 +
>   .../pmu-events/arch/x86/sandybridge/pipeline.json  |   4 +
>   .../arch/x86/sapphirerapids/pipeline.json          |   5 +
>   .../pmu-events/arch/x86/sierraforest/pipeline.json |   4 +
>   .../pmu-events/arch/x86/silvermont/pipeline.json   |   3 +
>   .../perf/pmu-events/arch/x86/skylake/pipeline.json |   4 +
>   .../pmu-events/arch/x86/skylakex/pipeline.json     |   4 +
>   .../pmu-events/arch/x86/skylakex/uncore-cache.json |   2 +
>   .../arch/x86/skylakex/uncore-interconnect.json     |   1 +
>   .../pmu-events/arch/x86/skylakex/uncore-io.json    |   1 +
>   .../arch/x86/skylakex/uncore-memory.json           |   1 +
>   .../pmu-events/arch/x86/skylakex/uncore-power.json |   1 +
>   .../pmu-events/arch/x86/snowridgex/pipeline.json   |   2 +
>   .../arch/x86/snowridgex/uncore-cache.json          |   1 +
>   .../arch/x86/snowridgex/uncore-interconnect.json   |   1 +
>   .../arch/x86/snowridgex/uncore-memory.json         |   1 +
>   .../arch/x86/snowridgex/uncore-power.json          |   1 +
>   .../pmu-events/arch/x86/tigerlake/pipeline.json    |   5 +
>   tools/perf/pmu-events/empty-pmu-events.c           |   8 +
>   tools/perf/pmu-events/jevents.py                   |  21 +-
>   tools/perf/tests/pmu-events.c                      |  64 ++++-
>   tools/perf/util/metricgroup.c                      |   2 +-
>   tools/perf/util/pmu.c                              |  33 ++-
>   tools/perf/util/pmu.h                              |   1 +
>   77 files changed, 679 insertions(+), 9 deletions(-)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
> 

