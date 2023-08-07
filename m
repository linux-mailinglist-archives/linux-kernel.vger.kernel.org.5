Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD5771D14
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjHGJY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjHGJYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:24:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34901703;
        Mon,  7 Aug 2023 02:24:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 376NsPH6003828;
        Mon, 7 Aug 2023 09:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kk3TqHwKwwjEmPTefbV+rU4csHtt/LWvpcXL2FiFQEw=;
 b=muX7e/PIhoTR9SxpT/kbLvoxK16aLKwHcxWUOFSd2dwcJ/Nr4tmb9YsnygfhVG637j5z
 JbTem9mjMR478D3Xj0Z3yTX8errsGpxc/VaFembhqDGYxHDevXXmwP9F3oQ5eGjiSrO2
 iKxxpsRs8Ly6JFAAQiRywRYVPBaadBf6wWZT5kmX2DZ48qChR5IbrGCYoJWjbv06Qn9d
 xS+PEnkSizyB6tOAzv4n7os1l5QxlIcruwAompLlv9QhGVAY64ADd2rgYMMoAaS4DVHj
 Bad5ZxkVG45H7peGomeXKsq9VI8llH7hUcuRx4Udh6DEPFgjn9M75Wnz29bgXPoPUZxD ZA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9cuejc2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 09:24:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3777ebxR023046;
        Mon, 7 Aug 2023 09:24:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv48x3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 09:24:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2QL6lY8iVNUpMhbMvcUHwqVBbo1FvdjoWcylDAQlLe9Nr6rN9hSPWFUcqwWiJD5G/xzGg+8dc4bGA1ycRAdpvthzhcIDZidjsltAO39HDmwXxRy5KYiHccgmvgz+vUj6KWZ3qTpkAYU84ZlzHBM52NxPsNxxC9xMeqO5x+EOj/E1J3BG/nOQXEgVmnx+VCAsJ97qCxqyqwN3fpbn58WXfNEdc7KL3A6xHSoAylLfwmxzHuaeFLlIfP1awOBwjDSFbC9rfgApcALig+8jFhQXBe9FHJiYEa585k4nCPa4LjMX/viYde8UoMwbiVgxrv+OLZphuS/UXui8YbsyrSDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kk3TqHwKwwjEmPTefbV+rU4csHtt/LWvpcXL2FiFQEw=;
 b=J3yNbbN9MU0F++oUJIhn45/nLgW/OC68dECU3sX9oj7blcmo6c8yC/eQnp/4vhObznuJ8QHJFSTVNHFcgged0KPqZ9R459QTRjcTSGBujHXMlblg5ma6dyP6bftiSnUkqMLuxb0VudX2O2vL9SpZ564t3pPfFO9FLXl5tLXMRjPC1gCa/3qwFfNEbD2WP4DZdBOT5FRoFqITHnL+IEMIl9yXYkat/6WGyWugRpJ2rtdBiLFvjmh56heie8oi/z4rn/xq0GFnrdtpvoPjIApJdfWIiLF0R8fMcEC2RlSNeuDZbhYjFNFsXuxp1D2dKDXWVwgR2cnM5nUBvkVFhvzBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kk3TqHwKwwjEmPTefbV+rU4csHtt/LWvpcXL2FiFQEw=;
 b=fvQrAb8yVnJa6kf2me9nCkgAskiJgkLlDcqJbHSPMu6fmwANkWZZI13d6s//ERQ0vWpPmpWPjPEBah0M6vMtskVTi6i52QaD9Vd6OY03gZZ1Hef8IVolzgznPO/AqNwnjZyOGFdlNLbKqbLt/2CePauhNjOR0SC+9ZSdmVxnbnI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6916.namprd10.prod.outlook.com (2603:10b6:208:430::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 09:24:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 09:24:08 +0000
Message-ID: <50a8778a-ebe4-5b3b-9367-c8547d6d991d@oracle.com>
Date:   Mon, 7 Aug 2023 10:24:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 3/7] perf jevents: Support more event fields
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
 <1691394685-61240-4-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1691394685-61240-4-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0047.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::35)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2ea3aa-90f2-4539-f8a0-08db97280db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEB7Pv5C1vE5qv62dUu/H6LsvyWMW55MNFk/qe8TRZ6UmluWvVrw7pe/yZMPfvSErdwelkxYEsgujq5yiBA0YFCEFkheIqjY3NYYJhMN2RkcN3vH0nh+RzkynSa9DUX1jxBrwOydh8YaycPaY4MnkVnI8pkzD/RQTvCuGz+4D1OfAhVuV4H9R1qXUTzLOU/ymwUITs3NAbfCeLpcAwyTprXIdjNFcQqha6W6GAvrD/pSQ1bt1JXFFch6ns9L0FkWuX10iSKdoeT16DmJagw+CWqpLQMIJ9WXJQmdSWqzwh/dyb22cWGFWpA9kJOZklD6wuEUJXuH7E3FsFA9hROEctGDjW1wxbHQLLaiG2ljwB+4TO0klmMXSPawQVgHQ1vUY9dXBjmstHbq4bu7ZivTG7LcJmbNpHsH2jac5nY4xgHTCJqTJa12+rzRaSnLmqTWIsbFieAiIqBneEhxaR3Bpkggkvk7Uc4Z27zmnpV0/HegdgwM8f0f+SHC2d5wdJe+DtrKCpqytN+JYla5jNyd6W392qQyWDvtAOkYLTA2Kx9whm1tB9m4vkiJx7eE80ahCj/MFZ0PGC7cU1NF/KGKwqHsPQJZQ1Kkf7QxpfaB0F1/Kl+mYCp5FTYbWAF36Ik1ixzSG51Up5ei0uLXCpt8e9MLGd+xcqPCYBoA7CP/now=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(86362001)(478600001)(54906003)(110136005)(38100700002)(6666004)(66946007)(36916002)(6486002)(66556008)(66476007)(31696002)(53546011)(6506007)(41300700001)(26005)(8676002)(8936002)(2906002)(7416002)(5660300002)(31686004)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1NTMEVReEFnbWhGN3VOSEUxUER6b3EwNDNGczNid0VzQVYxaC8rMXR3dVNE?=
 =?utf-8?B?Qzk0UzQzcE0zVFUyb3pMWFJiZkdFUzAwV0R0NjhWMVNJQ2Y3a3lxK3pjVjBQ?=
 =?utf-8?B?QnRjWlpzSU9ndTVJZDVpM2JYUGdqRWRRbnhYc2xuVnBBMTUxYnR2UzBWc2Ny?=
 =?utf-8?B?RkFCRXV1OU9mZ2lGV1lEdVRGc2tKY29kL2tLUWF1YzN2bG9DamlWczBYQmhr?=
 =?utf-8?B?WkxNOVJxWUx3b1JVVnhHZmd1WlY5WE50T2MydE53OEZqVCtQRlVta3Q1bzA5?=
 =?utf-8?B?NzkrejhRb1dSbTVPVW1RbjNMQUpzSzdGZDhudnMyOXp0bTBLSThZWXhpUVpU?=
 =?utf-8?B?STlWMXpueHVmMXVlWjRqWVdjNEFyWWhGclZQQkRJWEFRVm1KOEVPSHhwUVBG?=
 =?utf-8?B?RlkzZDRoM3hHdjl0QmtRMk1tYlJHaWR4eHYwV0wzdkpqYWZjMWFCUXhqbEdL?=
 =?utf-8?B?ckgzazdpY3haMk00dXBKVHZEV0VHQjNFc3BpR2xJODNENnJ0VFVEMktlb0lw?=
 =?utf-8?B?MU55T2N6QVhKUE9aNDh2VHVnSE9DcThRT05NUXgxc1czZUdkM2lqTmdCZ1lx?=
 =?utf-8?B?eFE0WEduTURObnFUdFM2cTZzc3Q0NGFKa3pwN0JQVFVaZE1EUjdpUDZuWHBz?=
 =?utf-8?B?NzFPSFNYVktpZmYzS3grcTJUZFBTVHZ0ei9qRW9HUmtTdkU4dys2dnJoVENL?=
 =?utf-8?B?K01rRzNVTmdqNlRtSnJwTFAvU3RtSFBLVmh6eDhsTHQzNHlCSHNjYVU4Mzdx?=
 =?utf-8?B?djhFdjhGTkFoSGpYVVpzV2dzcjUwaXFFNVMxU0JCV1NoUUV2b2hXbWtEWE9i?=
 =?utf-8?B?amtHMWlUOG5DL0xSQyt4V3NqUER0RGhLS09OT0hvRE03bnBybCs5L2V4TEZy?=
 =?utf-8?B?ZFUrNG82bmxseUZRMXU4cFRDUU9tWHg2MDhCTHVta0ozQ203UWMrVFNyYmZx?=
 =?utf-8?B?MndJaUFpbXhrbkJMcnNuK2NzbGhEYVZuQnJ5L2lNSXdZK3BwOXBYRFpHOVo5?=
 =?utf-8?B?QlZHb3NlZmpHOGlPSlVjUVFjOG9DT09TRG1RQ3AyNTNId1BLWG5TNE1LTm1C?=
 =?utf-8?B?SWp3RjhsMjg0R3d4UjhOWDdRUWJKOTRxaHpnZEx3dnJ5UW1yZStJU01tZVZL?=
 =?utf-8?B?ei9UWDBmRzhOVnZHV3VVbk5nWXJiTXFpbjZLNEpuWXJIOHI1b0gxUjBXdnFR?=
 =?utf-8?B?WVNXaWtCdDNDaEMyS09tR0hweTZoNTRqZmlGeWl3SjhORzNhbTRHTnhTazZP?=
 =?utf-8?B?ZmhIdDdUNzd4cUVybXZWTzVXVWFOYVlLakFMcmIwbGtPMnJOVkt3YmpoTWlK?=
 =?utf-8?B?bGZ5eE1ONTViRHkvUXRoY0ZCRHk5VzZnQWhZKzV0S05TTmdFdGtLT3VFQjZZ?=
 =?utf-8?B?QWo2TXFYNFFJaGZvSW1hMElkMEd2bzgwelFuajlFb3dYZHFnTXBYemE3OWxF?=
 =?utf-8?B?bGVKYW52RmpPSnFCY1hCZjNkbmNyWjdPYmZ6M3pRZEpVZkJKTjFYRkJ6OFo2?=
 =?utf-8?B?U2FGU21vS3RYNjJrOWFjSm9VMXJzNkxNUTBEa0pnVnA1Q1k2bE13UVFzMnlK?=
 =?utf-8?B?SFJJNlI1UjFZN3JOU2ZQQ1JxNEw1aVlvMUw2M1NUckk5ZTRSeE9oU3llb0Ur?=
 =?utf-8?B?UWticy9HcDRKK2oyYUJKUzJQRjZZVkJtR3AyczRQa1RFV1ZJOGhndTJkcmcv?=
 =?utf-8?B?UHNzYk9ybU9YZ1U5MzQvUzlESmM0aEkvZlJlZCtvN0hQNmxNbEkrMmx1bzda?=
 =?utf-8?B?NlRiRVV0WHZuQW9FOG1veGZzT0kxbXNLZmhpb3NBMFVjNTJvNXhzbmJxQmgx?=
 =?utf-8?B?cEx6cDJmVDhmYk1oQWN5czlRVHZZZmlhUlExODFqaytvSnN1dG9QRzBVWng2?=
 =?utf-8?B?bXJMZDkwSUJEVE1MeTY5ODJXRGczVnoxRmxackJDUHJ2SlZjQzJKUDRvV09U?=
 =?utf-8?B?U1hkbXpTNzRTcTZIelRqc2tSdW1MUjRBclduK1h1cytvaENRZTBqTTdCVXAz?=
 =?utf-8?B?ZlBZa2FhbnAzdkhDWGZUTUx5ZUxsaWFLSlRlenZ0Q2ovc1pGWUhieUd0N0FQ?=
 =?utf-8?B?bVJlRVMrYzIzL0Vpa01keW5hQUNRQmRuMDYvNE82TURERFBBbjFmbjlEdTdR?=
 =?utf-8?Q?Mcf83SxAL0Xr34IqNeC5Jk2ZH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cDgyNWllcnBpeVRQWFpXT2V0S2V4TE9XQStTbktYWnJFN0JNY3cySU1VUzBw?=
 =?utf-8?B?Yjd3UVc4WEx6SHFMemdlaU1uWXBhVmFGREdBaWFZTGNqRTZpR0FFQUtpYVJE?=
 =?utf-8?B?bGNzdzc2MnlUU1FmTFdEY0JPemNqT3ArMGFVRzlDeUlPY0xjTDlOd0RMTlAv?=
 =?utf-8?B?VERXY2EzcFpUdGNrUkxackxWVit1VXFDUXFITTFSWmlEUkd6WGtVdFd5c0VM?=
 =?utf-8?B?ZFh0ZXJWQk9PTHROazBVUi9VMjl1RUE5d1pSa3BWN2d3ODlvQ01JY0V4N1g4?=
 =?utf-8?B?dXd1ZGZwcVgwaDFkeHZyUDkwMVFxRitUeTZoMjFjOHB6L0JzOW9NazFJK21j?=
 =?utf-8?B?ODNNNTF4dzlnZWVlQjVBV1JORVRQRHFKZzVjR2RGdkZsK0FhdTU1bWJLWWVr?=
 =?utf-8?B?bCs2OVp2QmRTb041dlNONEZVVW0za3RZYmRQQjRuVzIvOHR3RzdxbVMvcXM5?=
 =?utf-8?B?SWlPMnRUMjg0MENHQWxEWUlXSjJXNzVZM1A2bGZyQy9iRG1JUXFlbWQxdkha?=
 =?utf-8?B?RHZORjk3NVJidnNtRVBFRHhTTGpZYTRORjFZN3hBYVg5RDgzSHJ0UHg1aHpu?=
 =?utf-8?B?czdOZVpIc1prT0xHY0s5TjJJVy85UlpiNk5KdDIrdFp4L2ZWOHVlTlpSdkxw?=
 =?utf-8?B?cklZV3lVWEdqcElWYzViZG1sWHVWSWtpWGFyU2RDWmtUSXFQaU9WL3R2aEM4?=
 =?utf-8?B?OTdxMEtkQWVkZVhrUDJrcEpGdTNZT05yM2VpK2tBZkV0d0p4dTBaVmxrSjNh?=
 =?utf-8?B?dkIvaWJ1WlRQamdBZkx3aE84My8va3MxYWRWdHgrVG92Z2dOZ3hDRzIvUFNK?=
 =?utf-8?B?MlUyVUlUTjd1L0cyd2Rtd29IV1YyNUh3Z2pYVjY2UUVsd3V2NUp5WUN6bjZO?=
 =?utf-8?B?MSt1VFhLUVNRMmU0WUVNNXRBSjZ4b1E1bUxicmVrNS9yWXhBcmw1RWJwZG1Z?=
 =?utf-8?B?dTc2OFJNVFVXVVhqZ3JRVU4xZnY1ZmRRbVBiYklxa2dxZHJuQSsvVXV6dkFj?=
 =?utf-8?B?eTQ1UEtKY3Z6d0NZc1M1eGV0SXY4cUUxcys0b0s1N01TaHVDNVh5K1A1VUt6?=
 =?utf-8?B?MjBmSDNORGU4MTFmK29GQU0yOSszeW1SemtRS2lqWk5UUys5eGtSWEdDdDlm?=
 =?utf-8?B?VXc4R1pYN0swRkVvZ0VlZktUNDkwTmNjMEhpUXdMRDlnUGwwRzljUUI0U0ox?=
 =?utf-8?B?TFFlWlgyVnpIQU5RZllDczg2MTQ5WDRRalMwQjBvWGhFOERzaCtjUlltbFFL?=
 =?utf-8?B?aEkxbk1ibk9URFB3dlZ5RDlmNFBxaWpWd1JKT2hPaCt0YlQxakdmVlZHVEtM?=
 =?utf-8?B?aWNBR3V0YWtkNk85ZTVJQnIxTWFFSWpzdWdXRFpaWTJOMWd0cEJrNWVWMkdt?=
 =?utf-8?B?ZU4reE1qZnRQUEM1Q3c0T2xrYTBSWHc3cGF6QmdmajVqWVNyck90NXAvR0VM?=
 =?utf-8?B?VVNTQjhqOVFkWXhJWWY1Yjl5UmJpZndBT0svOXBRN082Z1N6SWFVK1VxT0ZI?=
 =?utf-8?Q?FLkqPE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2ea3aa-90f2-4539-f8a0-08db97280db0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 09:24:08.9059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXta7oCnMrBLtsMDO85RdEJHdWDuX0EtIeKRDJgCX2XN8rh2TtxpWN95rnrsBNhLbL41zQ/ddUyJy1xExl3TPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_08,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070087
X-Proofpoint-ORIG-GUID: R7KU4l7y9wztynwhiMY9vbc9ep9k8ug2
X-Proofpoint-GUID: R7KU4l7y9wztynwhiMY9vbc9ep9k8ug2
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
> The usual event descriptions are "event=xxx" or "config=xxx", while the
> event descriptions of CMN are "type=xxx, eventid=xxx" or more complex.
> 
> $cat /sys/bus/event_source/devices/arm_cmn_0/events/hnf_cache_fill
> type=0x5,eventid=0x3
> 
> When adding aliases for events described as "event=xxx" or "config=xxx",
> EventCode or ConfigCode can be used in the JSON files to describe the
> events. But "eventid=xxx, type=xxx" cannot be supported at present.
> 
> If EventCode and ConfigCode is not added in the alias JSON file, the
> event description will add "event=0" by default. So, even if the event
> field is added to supplement "eventid=xxx" and "type=xxx", the final
> parsing result will be "event=0, eventid=xxx, type=xxx".
> 
> Therefore, when EventCode and ConfigCode are missing in JSON, "event=0" is
> no longer added by default. EventIdCode and Type are added to the event
> field, and ConfigCode is moved into the event_field array which can also
> guarantee its original function.
> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>

I'll let Ian check this change as he is more familiar with this code.

Thanks

