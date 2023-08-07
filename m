Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18140771D01
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjHGJUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjHGJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:20:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6379EE68;
        Mon,  7 Aug 2023 02:20:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 376MvSbT013599;
        Mon, 7 Aug 2023 09:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=IoX9Fvww4jlZ7oPqmNo5WsZZJu0sF2XIMPJR9tUMh8o=;
 b=z4OCfc25/8gj+gKZMI+AbmhNPBOtfCP4tZ9G7RXuKiWTSu+/qfMbfBXxQd23gtdzIWxt
 wmytxcS+pB1kSsaf7u/VqG0IPZMC3TWZCTelLMwERnR7TDX7YYiypPHoJJZpo52Gi0lB
 O7BJguIkjNLOenIz6O4/kCz8UbIleMX7sSY7uSZI6gMMzqAGenhH6NxpQB7ioFCZDGYz
 33ybbM2hx/cn2n43NAkKgPTemVHjiVL8Xh9aKHrHLxQHqRjzGhbhoEwwv04ZPvEvpC6/
 mCbf3AQlGG+cZOi+pT5Kp8h+5yGAWnAFmANuA/cd5S1KA/DTjBi9f8zuP1l9AVuDlygO pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d73ac06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 09:19:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3777ebvp023046;
        Mon, 7 Aug 2023 09:19:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv48sf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 09:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0ENX3T5m6GiAzqQ1y2kUE3fnNHCbfPcPd2gVXx+WlqduA54A7kCWUoYGBgVNPmmqA7LSPF98C4e6a7bq+ja3SzB55pf2LXwr7wxHwOG25y54FRpQi6dcvdwSU2v5hAp5vCMA/EgKH0dVPMXPNSNAscpeL2aoZYC+Ka0+ihUM/3TBgdpropGoVDfJmAfuNI/mvVe3RGB6UehD7Jy6sKr5hnIOG/EMIP7SsR1t8z3xhY2ay/xmJtQNEwrDnKFcjDavEP2Wz8hDgkwZSJLExsvVi7y4d8g67aqpAm2j4aEhbkrt10X6rS/hUhsjBFPEGPC96EuSkF4TguPa1VAN/nyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoX9Fvww4jlZ7oPqmNo5WsZZJu0sF2XIMPJR9tUMh8o=;
 b=h5MsC9UkqbviJiENii7q3n4A9z40gfgeq/cNGtDOGfBcFipyRoZFzp4zewQzbfQaAunbj8VxFB23CUOa3bU6yIm1MGqSTXvG9AsV0TczC1AoRHR7OXiJfEd/RKuSwJDyJzWOfsrfb23Kei0BmV7XI47e7T1D556GueR2CEPKjnAjOEcjXT4H66yqDKnYDN3dcS20hB+f0VlLYF1yJY05mPA+0M4ppV+0YD44Vtcv+KgzzXRbeTEMmf0kXRtpmkg/jHG/HtqjgOMibBcD1R0yijs/ETuXjvxFWqr5yKaYf8sBSXtPVp+JUOQfjrNfhRwFs9gcN1hYKLJWJ9pBL/p/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoX9Fvww4jlZ7oPqmNo5WsZZJu0sF2XIMPJR9tUMh8o=;
 b=FyfFCsy/B54aBB68kqJDE/XERZGgXzEM87ok8P8XgseQDjtV+A/ahzsiW+AaQmKDDiJEr2+PHD0nHPggB84gHitpxS7wKB5tQw3ivj6UaOOM5lhPqC4wd2Gp2xhPzYs9Q9Z7ECZxDaPCX/9loW//s4YjgXqtbMAsSIwP2mC/yNE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6916.namprd10.prod.outlook.com (2603:10b6:208:430::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 09:19:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 09:19:48 +0000
Message-ID: <1a2c7977-2337-40d5-449b-18a3e3711686@oracle.com>
Date:   Mon, 7 Aug 2023 10:19:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/7] perf pmu: "Compat" supports matching multiple
 identifiers
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
 <1691394685-61240-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1691394685-61240-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0265.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: a1421d8f-fdf5-46fb-790f-08db972772a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OR31rDsLa3TNE9t6/zjTy1qyV4cOld1SW/u44/MXK82XDDRWmj851+sfzhkaVxs3c+hE5byNkzABg9Xf+FZsbrmYU8tTst507o2FsQiYt1uXkj3W3/n0LUvbw7B/dk6y2cCJ4hJ1iPvi/UVJMY7hBKP9eXPDNUQQ4eEa03mqmxWJAJJw4UHRzPew7ZVzFBe9MlRyuQaNTNvL6Hb4tkT28Gjj4t4//PGscCHmvJAdwPUQ1f9Ml+zdaRwVDpsnwMdYzFBrDfwq45tak6bJIzmu+hNyKTdshRBOZcPlrCn0ErUi83p24qHXNURTpziFhhW4Uikb4tL+XWCvJiNsL6sHbkQgYGEq1/Fb7MDYD0seNzohsj/vl6t/e/k0knZKmhETeM4ShYni6yBSxAOi+7OpzeDPFXADva7XwrUiCsBCwBRziVHTKh7J1a0JJsjrAervlxiXv6zVvDk64oQoVr+8FH0a4V3YVnrk41d8+VrMHZ8NqO3yWCln/sYBdUa0qvtuDhVRC2KUleHjyvv7XDuScED4XtgNGz0HVC7CsuYQmdIBzXkpYQzWFghkwX+viNs2YbhOfs3d78YgT4vWHEO+taAfwX9HuHXdG1U8/PXxO71zC6gOwMSBxKITQrzAk8RyxItM2kwqEoLpzqXR68KGdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(86362001)(478600001)(54906003)(110136005)(38100700002)(6666004)(66946007)(36916002)(6486002)(66556008)(66476007)(31696002)(53546011)(6506007)(41300700001)(26005)(8676002)(8936002)(4744005)(2906002)(83380400001)(7416002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXQ1b0Yzb3dPaFRvdi91WksweTdoSkZEMnVGSGhSTDdjMVpTL0hrRWtXZVRB?=
 =?utf-8?B?MlZhakNESkxNUlhJOGtMVkNBeVdiNjVrMWdHWGZ5N1BvV0FCTjFxdS81eVNB?=
 =?utf-8?B?MGs4cHBaL05EY1BLSHlHZ2xEdG5xZWxBVy9wR3o4YW1YaGJFNzRNY29HZFIw?=
 =?utf-8?B?RWtxV3l0NkdLYS9DNFJMa2tuMVVRSy8wTG0zT0VNTUpsUDcvZzFxOHBVZkt0?=
 =?utf-8?B?MU94cTBPWkdJTkJFNDUvQTl3WklVVmNKQjBnOEYyMHFFSjN6QStYQkZ5cGRL?=
 =?utf-8?B?aHVIM0I5dW11WGVaVkRBMEtQeEp2Z1BPaGc2OGNNY1llOHBzMjdtTWZjVmgw?=
 =?utf-8?B?RzhlSVd5OTF6aEFrQXJ5SGxnM2NuQnRMNEh0b1ZHRFoyTzBsSnJiaG8zeWR1?=
 =?utf-8?B?L1I2L1FHbTBWWEVGU010ZEo2ZFpqdVNMZjhVcTA4ZnRHVUFVbnZGaWpqd2Zl?=
 =?utf-8?B?NTdwWjNUTTl2dWFnWDBxNUNIMi8xL1FDVEJTdVh1R2h5SEdWNEF5T3VzbWVv?=
 =?utf-8?B?L0xjMXdoNVV3ZFpCeDkydEpmRFVhRmp5dTZBU1IrWWVWdlNkMlRiQ2t3dmFm?=
 =?utf-8?B?cDBHK2M1RENCZnpmTFNLb2x3Y29CdU1WL09uOGNQMUJRMWFmSVBwbkhlUGth?=
 =?utf-8?B?OEVDSGIvMzg1V0ttbjJrM3BySEpEUWN1OVk0UnYzZTZQd2JJVGNhYURjbmwx?=
 =?utf-8?B?eTlJSFB4Zjh4ZnlOdm84VUlsZ1pQN2VhK1RFWm1memxleDdnRWQ3V08ybUl3?=
 =?utf-8?B?ZFJMWm5XZzJuOFo4TnNMalFRL3JVcGdYRlFsRE1ONm90OG9lL2g1czNxVUF2?=
 =?utf-8?B?eWpOSnVmR0hVMXVZYUtqOVMvSlJCdDQxS1RJeG5mVWx5eWx1MWtnVFlUb3pq?=
 =?utf-8?B?bEV1c2tQaXBrZkJFSjVRZkZSWmVGZXQ1WXRvYjZ6bXFRV0FGMkJvYVowU3lL?=
 =?utf-8?B?SStsMmhETGxVdGRBdVdHSFlTd1cvbE95NUZaSVpHMXFZRG5yalhxUDBveENm?=
 =?utf-8?B?cElGeWQxOHpmNi92ZUw4SGdXaDY5eEUxbnc4TGFJS2J5QzFQNFBKOG9hamoz?=
 =?utf-8?B?Q1lCOFNDNHEvR0orck9lYTBtVkFLU1pLbjVYbHJaTnIxWmRDSmhxMjl2bkMv?=
 =?utf-8?B?SWQ2RXRsM1dZYUd3WFloRzJDcHJ3VmxUcTBSTWNkeXE4WWZBN3JnVFJaajRj?=
 =?utf-8?B?d2M3aW9TRmprTGJtUHZzZ3F4Vm1WVmxCNk9sSTIycEh4OVcyK0VTeTltRlpL?=
 =?utf-8?B?TTh1WDlhVTRwS3BYV3JjZzVsYVJXMGM4eFFBNm1sa0kvckYycWpQblE3Mzdr?=
 =?utf-8?B?Y1dyQ0VIZldSK2VtQmV2V2swTGdhMzg4cnRVVitMK0dkTlBpWGRXRWNyU0Fs?=
 =?utf-8?B?dzZ1VmcwdndYU3RQTVRPbU9QMEMxYldlVkhmQXR3ZldMQWUxdzErY2tyMFBD?=
 =?utf-8?B?cStRT2ZhT0MwamowaU9ScGhjYldSc0o4d0FtelMxT0dFYXMvNWVHVmZjVXpo?=
 =?utf-8?B?MFRPZHErR0p0aTJ0V09DNW1kcjB6bHI2WWhMd1NnSTNXNmtLUUwrUG1iUWpl?=
 =?utf-8?B?eVdaYThuMm5IOU1WNjhSUHErVVYyOS92YWxMVC9lMjlWQ3lFQ1VVdThpbGlZ?=
 =?utf-8?B?WXVMMWRtcC9vY1Y2OVNmb1hsQTZNYXBXYWFOSFI1SU54Ty9seTNQWkVLU1Fh?=
 =?utf-8?B?M3hEQjB3elFJaTNRKzUwdklyVFJDbmwzczBQSjl5WDAzVG84dEs0SlJIT0J3?=
 =?utf-8?B?T2Y4SVc3S0htQld0c0pHc0RLRmxIWXVjMVZJS0cwczdzTW5tdTUydE1PYWpS?=
 =?utf-8?B?MlRtTm00a0FoRlU0cWp0NDc3dy83WExuK3dybS9BZ1JaaWZ3VXNaMUI3ckhm?=
 =?utf-8?B?THd6SDRHblNKeUlVTW9vNHZ4UUtuWEY2aG0rWWZ6aDIyYkJ4bytCQTZtek9t?=
 =?utf-8?B?OHU5MTRCWDlxU2o1bzkyWUU4d2ZFT3NRWmNmbDdRTHVTb3lhNVlBZGFVbTMw?=
 =?utf-8?B?bjFndENoRGZoK25CVlBMVkl2dnlOa2RKWDFGc2JJVkl1ZERVZHNpRFBUdHN6?=
 =?utf-8?B?RTRPNGlEYXV0T1RLUjBLTWRQS0M4N0ZWdFZqUDdLLzNjOHY1b0JTQzR3NElT?=
 =?utf-8?Q?d3igXlaML35OomL2HVeW7QBsg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VWV5ajRqQmg0dWtOa1JCcXFQZWxEb21nZUVxdjAzQ2lJVWV4RmRhUHpKbTNp?=
 =?utf-8?B?YTRjdGhBK0RUM3phZ0VnL00vaSthZ3duZ0hub3R4N3gyTWtPczFabHJWNnlV?=
 =?utf-8?B?dDVldVJiQWNxL1d4MlM0UGJjZ0orRkVZR0J3MnpuaWhOR3NvRFY3ejg4cGNt?=
 =?utf-8?B?Q2tIUjAvZnBUdFE1YWxuaVo2aW9reVdQV1VGakJNQkF3amY1NUo0dFBsN1l5?=
 =?utf-8?B?bytIM1FBTjVCQ0RTeWZUTy9JTDZ5SXVxQS9IOFpaZXd0NkRvMUc5U09LYTJV?=
 =?utf-8?B?SjNDcmFja0JpR3lWVy9aMjFDejY2RFhyRDBpbnZPcVNXTnRpaWhaNG5UTExP?=
 =?utf-8?B?ZERScUhVaVVuek9qM1ZuclREa2xYaDNaeDlCVCtMbVdXd29WRnZsYlUwditt?=
 =?utf-8?B?WGVGZ0tiMzN2RzdTbStuRVlVUEZ1blE0WVgxaUZRa3pzaWIxK3ZzeVdzT3h1?=
 =?utf-8?B?WHpJemxveXFBalZJaUJTWFg3aWVaK0xlVUZXRHU2NXJVM3FZTm11ZGdJclJz?=
 =?utf-8?B?NFhqMUMrZWVSN0V2WE9Ka2E4UzRCSW1FM0hVNklnWW9McE16aHhjaUVEQWhn?=
 =?utf-8?B?TnJpeExlTElkUE1Ib0p4Wis5bFI4bHk0YkRXTlpJZi9KNmxYTlRSRUI0OGdP?=
 =?utf-8?B?QjlQSi9QZzN6UWVLOVNDeWJueHllUnlKWVlUMldpOFpLaTFOME8wT3pLR0NJ?=
 =?utf-8?B?ZXpYUU12YVBlYTNiTHFOem5rOXF2bjRmV0xsZ3FxU2Q1SFEydERBTzQrN0xp?=
 =?utf-8?B?Q0VqMjd1SmpIOGFsVjFNRUtzclhOVG1OOHYreWRYS05lMFNUNkx4d1RDVTd1?=
 =?utf-8?B?eGJxb080bmtSNVpvUHJ1YkRUbXQvcFhic21zOHpHY3FidnRWZnQzclRjNzBC?=
 =?utf-8?B?bjltdTB4OWxSRnFRS011akhIdHk1cHQ3aW9PbktOMkhsVG5aV1pibitjZUh5?=
 =?utf-8?B?ejB4V0g4Wk0zTGxpWjBIa1NRQWFwRU9vbXZzRU1WZDY1QUw1Qm5hRnd4SHI3?=
 =?utf-8?B?Qi9FOWFBZUtNc3B2Y3FUTTduVzNqcStacm5MQmFUM1NyMVVsUUJ1Mk16UjQz?=
 =?utf-8?B?MmNVY2hwOVVXRVFLYklRcjdWUGt3YWg5OWVScEkwSXBDazgraUdKSmU1OVJC?=
 =?utf-8?B?V1gzWHhnUzIzaVFpTUdEOEZMTW1tRE1qcWx3eWdHejMzRThvcnBoM3JvaTRh?=
 =?utf-8?B?djRxR2cwOGFEQmRoTEMyWExZWlM5QTJpSG1MczBOQjMzK1RQUkV2N1VCV2Mv?=
 =?utf-8?B?YkQ0ZE5iTWsyUVp3VGZrT1J3ZURIMUs0MTNLTERtaFVYeUQvcno2TVJTWDdP?=
 =?utf-8?B?QTNSWEd3MDZCTXNYbkVyUFZjd095OGUyL0pNaUhHMDJHNFo2NWJGQjhSLzlH?=
 =?utf-8?B?aGFPWTJrSCtJMVM1TjZlM1JwNXdLT1ZuNHErVWhUWUZmVmtpYlRCN1hvMXN1?=
 =?utf-8?B?bHc4WHhyVlU5STRsSkZ1Z2JaYnQ1cXJETDRmTmU1eHRFQXFBOTFDaVNVT2tC?=
 =?utf-8?Q?a/YZ/0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1421d8f-fdf5-46fb-790f-08db972772a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 09:19:48.8993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zpggnDz1Da4uJLQCEA/YR88xctPG92G1+XEMRDU9BnCv11uxFXbjBhp+576kLzVRnUDvH5vQA4mOYEKREObdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_08,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070086
X-Proofpoint-GUID: zbQtpHV74QPDK1jucMV64DsSU0CfWTDC
X-Proofpoint-ORIG-GUID: zbQtpHV74QPDK1jucMV64DsSU0CfWTDC
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
> hardware versions and types, but they may have some common PMU event.
> Since a Compat value can only match one identifier, when adding the
> same event alias to PMUs with different identifiers, each identifier
> needs to be defined once, which is not streamlined enough.
> 
> So let "Compat" supports matching multiple identifiers for uncore PMU
> alias. For example, the Compat value {43401;436*} can match the PMU
> identifier "43401", that is, CMN600_r0p0, and the PMU identifier with
> the prefix "436", that is, all CMN650, where "*" is a wildcard.
> Tokens in Unit field are delimited by ';' with no spaces.
> 
> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>
> ---

Reviewed-by: John Garry <john.g.garry@oracle.com>
