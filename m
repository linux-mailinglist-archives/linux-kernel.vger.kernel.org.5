Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48876FF2C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjHDLD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHDLDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:03:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E930E122;
        Fri,  4 Aug 2023 04:03:17 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373Nxolq029945;
        Fri, 4 Aug 2023 11:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aw20BaRtEGqB7eZ/H0uqGjW9wB26WCzku44tR9ZicQg=;
 b=xAAFMHddscWjPmv9FFR20QseVOJkn2WRN5Cw9d5w5sqsGlIZ+fm76VmgUrzLRCEHF9/i
 ViDmbKaFzfTpyKI0uBoT+x9c8EAiFIc/Uv7S1TQhkX8egsAADNVvGuxDuO85z4yeStZZ
 G/OYqPRC5b79dzSBQ7T8adlU6X52T0F/YNn4HOzi9SsTittmzM5IMUjE8jfSMmg06c4t
 Zkba9HQEyduU9lqFGz3i7w61tzgzKgimckVjct+L2kCGpEVluamZhiZbJZVy12gFm4Qo
 dLxztiDHbYsYKl3uhbP0lJvp+d6tkrgnc8i0Cy/54KL/Ze2HyCj/uaD+Ck3OUGy0sIvK Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tcu3g2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 11:02:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374AuaM0029301;
        Fri, 4 Aug 2023 11:02:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m28vk3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 11:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdIVJrz3QZLBZpVT5YYSYhifJOMRVw8iKln4PlbED32Ua1RzaWaqXzco/lTUWTGrxkJcsmyIYbJHrOjURz8d5fFQg13Dw+B4Dr7dUbH7a8V7pufQ/D7kXiQ6z3Ea/fC6NPf0POyNHjY7eMT300Y0VxNxSZl0g/ZhGwTXVvp4/6feGthg7crZ89yqftsnYE04ZEbV4APnB6WqyOKIqcHFKqlikK02QH67Hi8RS6i2Lm7iZ30pRleNPl5GlkE8B9ZhixiopOPwy61LTRPB9iTp8W4EizRXcf4TYO+IyHv//Cbz9WJ7n1vt4tj7H+AhPE/aDAbQAdEhm9oCekLhMK+8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aw20BaRtEGqB7eZ/H0uqGjW9wB26WCzku44tR9ZicQg=;
 b=NAK38Zw5/MvWKZc8tp4vHsBQoxSZSIUIPB3XluJJSGLv8OuUlV8FkbTIGetZCYSMh/MwUjgVFn+pvnL7VloLnyqaLy6/oVKFXydZ9lO1X3MHp+LHyC2BFUVCchmswIQxFXxiQPElj1yq8+ajj0VbvAqjFHDSHoq7nvQXAFvd0tBVz2TI/cnJu2igtga5x1NEIwDxGmu7xYpR6l7R0FePy07ohdGvOSqqFZ0IMdkyqG6PiqweBmN1sDCaiIKnYcGTPNcmfSPLRNyvMwJWogX+3I8ZurMGguBxRjFwvQTUX27evkVL7wmFuqwRN4+jeD6vLCM7MtDmmytPLLENL7Znmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aw20BaRtEGqB7eZ/H0uqGjW9wB26WCzku44tR9ZicQg=;
 b=DNG2faSmgErEL2dxHdxs+m2QcSoyLzuUEcSfE98NLu2FLkVuV+oMjr0arWUSmcJFC9cqeZUuCwMSCTypsHx3wx+HKRWozt7qZB54mQ0RZ9pjvcSvvp4vnoo6IZ4H4QXVe0t29M+NGYV7/s6iVAHz62EJSZu1J/sQBQu14fhyKdI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4385.namprd10.prod.outlook.com (2603:10b6:a03:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 11:02:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 11:02:40 +0000
Message-ID: <9e851e2a-26c7-ba78-cb20-be4337b2916a@oracle.com>
Date:   Fri, 4 Aug 2023 12:02:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] perf vendor events arm64: Remove L1D_CACHE_LMISS from
 AmpereOne list
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com>
 <20230803211331.140553-2-ilkka@os.amperecomputing.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230803211331.140553-2-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0437.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc8dd49-4c95-4457-d7be-08db94da519b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l41UM1a2VzBJPr4LcxObgGCqTgUCPseenVY4BECRuGmAouICP4JEleXwW+B/6U7N6nRoiGi0kVEhkJQmF8gtFYAn8mF0qrY2DEcTHdZpYkOksIA9Hi9BJy9RmvxFuDHQKnByzFaolEAK8sh5SbNqGERniNMTA7dYM3k8ZnEiotgSYjkyC0ehVRY3EWMAG+sSIV5OW7WNZtyF/SFxKMXyKrT0VyGO8MtioL8B4jBUseN6JQmwN4E9+VAjpQuaZGsn/D77Z3/lhhFg2k0w3rR68m65UZpSLr0IK6N41UIj6h0k+26eei60p4aBeVomBTP+1G02Byj4HMvudzpsI7j7SASrqNQKrgffsvdbhZmztfXT19ereFMy2fWQx7+KV1VUsiSrYjfvWt+IBVGVcoQ0qVY5kMcwTMQ9vMAd1hkkaJyhpCmq13Q1KUD0q60xKYF7pndWlbcotn1qcH2CkzRxVTDArsnIiad34dsOYbrkvqEAHRrI9qTSS6XiiYDnQytqbHTpLtcjvwWG/vmXjm5xwDvUYCluIEZ0YqdHX8TYKZiBQUnfQCyGWV2zSOao0NmsozuuVH9ENVQYL7kLm0zBiQtLNxwd6ISo+w+M+rvBC+T/3Jbh+a83aqSy1cfDJwT5xV+jZ/jxszCY8iZHxRdn0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(1800799003)(186006)(966005)(6486002)(478600001)(83380400001)(53546011)(107886003)(2616005)(36756003)(6506007)(26005)(38100700002)(86362001)(31696002)(6512007)(6666004)(36916002)(4326008)(66556008)(66476007)(8936002)(66946007)(7416002)(31686004)(5660300002)(8676002)(316002)(41300700001)(110136005)(2906002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VENJY3lYRzN3OTV5b0Y4a3FOTDhydnRWbWFjTGFkVVZ6djYwM1duLzArYXBE?=
 =?utf-8?B?ZGxnbVZSMm11N3RDcjVsV25vTkM0emxwQkQ1VUNSNm9KNXIveTNZZWI5RG1U?=
 =?utf-8?B?djUwMW9UbGNqUElwbW0xbjJ4d3NsZlNrVXNicDJMVWRvY2dmZnAwUWFVMFF3?=
 =?utf-8?B?WWxjbGVKN2w3T2EwbytCTUhxcE1NekpRNmp5eHEwY1F5ZE1ub1YzSGhWMVNT?=
 =?utf-8?B?S1hwSFNobUJIbGEvQjdHMHIwK0RsZXQxQjhmTmVLUW5teTBWY3piUlVEWEhp?=
 =?utf-8?B?UnFORDRvVDFSQ1JCbW8rbWVqdW56NktUcnZHVVBoRTJYUFZRNVFRUkZBVEdI?=
 =?utf-8?B?a2hXdGFrdmFCZlVNaUE4SnBGbDlHTkZGNkV4djFYVVdlcDBma3YvaGlabEFV?=
 =?utf-8?B?SktZdy9tTWQ1YU9oU2xvT25WbnRRbjNvdEM1U1dYbjhtbFdzQUdZaFFVdlAx?=
 =?utf-8?B?bHl1NzZ3Uis2Sk8vcm03eFV3QnpQT2dYUjA1YXR6ZCtTb09QQnY5dHVxVmZh?=
 =?utf-8?B?WUVGU1AwdnlVa0kyeXZBdGxTcjlxell0enc4WnNCNG13YVgwejFScDI0ZkJi?=
 =?utf-8?B?RElUV1BXNkdPcjd4VGxCYW5MOG5weEpMMDlHRVBrdzdIZW1vRmMrNnRKSktH?=
 =?utf-8?B?eEE0aTI4d1NIMi8vYUJad1hGMWwzbXkrWFZTQy9vWjVkUjFwTzlyRGRnYzdU?=
 =?utf-8?B?OWNIdkd3ZzdlMThFK1VhTVkzZWI0dzNuYWY1RjVCMTdOOE1JRm50K1V6WE1Y?=
 =?utf-8?B?dGFjaXJnQlVrWm0wclZRVUhkRWFncWJmL2JpTmxSN1JLaHJ4WVBid1luR2dW?=
 =?utf-8?B?TUU4YnR1aXVIK21rT3BmVVdQbXlhbmd3NG12SFNQZ3lqeFd6ajk0QVlXWHVx?=
 =?utf-8?B?bHpVMHpRRDF2VVQrblBkV2lTTWtxbDlHN213a0lBTVVMM2RRMEhpQ3dmUjkr?=
 =?utf-8?B?dU9tSEVNZkJWT0FPNkJuTHFGa1hsOGxWSXBuN3JrVTdHSlZ0ZE9SS2twUmxY?=
 =?utf-8?B?NzNWZGhFcVRxeDNWUU8rYytlUmYvZE9HRGFLb0ZsTGhsTnlMRWRxWmkyeTVX?=
 =?utf-8?B?R2tUWEloWis3czZIbkJGb08zVnhrREFianRua0lVc01nd0pNcHN3ek92elZJ?=
 =?utf-8?B?ODBza3U4WGhUdjZRUWt1VFlySWFoTVJNS1p0QU9YazdBR0xRbE9HdVY3MjFY?=
 =?utf-8?B?SUNIVTRycnVNOENLZXlQczBXREpzVERRSEpQaktjZ3VRZWVyVXR5WWxhZms0?=
 =?utf-8?B?ZnpOVCszT2g1TzVyL1RFVmUxb2NVTGZpdm5EZUQ3SXZ6a1llbVNvRkpPc2Nl?=
 =?utf-8?B?NXdUT3NGODBreDlGcGVnenpKSkJ2SStVS1ZNaXc2c00xdFgzbHo0TGUzekdm?=
 =?utf-8?B?OS93c2xVckc4UWpmeXdrd0pCUkJMd0V5bnc3My9yZCs4TDQvWG9jR0dSNGtD?=
 =?utf-8?B?enJTZW9NbEFNNldkL3VveFI3bUZTcnpZak1uSjk1ckxlNkVmc0FPc0t3aG93?=
 =?utf-8?B?RHZKZVhzOEJEUEZSMnBpTkhaa2oyTStDTEVZaTYvTUhVSUxWNkR6S2kwanVZ?=
 =?utf-8?B?aUJaNjlLYXgxaXREWXA1QnpCcXltNlBhUGE4WEsrYWNvZXhiTDgxRXQ3bFhF?=
 =?utf-8?B?bjVFdnpsR3VJRk5NYm9raExVTStmNjRVTVpzQ3NFWXRuVGVENzNLY3Q1SFAx?=
 =?utf-8?B?d3pFU044K1gwS1htNEJkWlRwYWRqSUVRRUNSVWVPVTJlYm5KdkR3eXRrZjZX?=
 =?utf-8?B?N2F6ek93VmVkdWtwS3VYNTZQMWVlSmNRd0RzVDROOXVTQzBkY3oxaUdBWnlN?=
 =?utf-8?B?SmxxOGdCRkl2d1Yrd3dKWjFqTEpJM203ckpJaUJoUGpKWW1PMHEvblhXa1M0?=
 =?utf-8?B?S2NPOGx5cFRlUUk0K3REVkJxRURETjROVitIQ2Q4aTI3TUJET0M4Mkt5L29r?=
 =?utf-8?B?YUdFVm9oZkdyclJwSDJhdnhHSUNkb1lzaG5OTUhackUzZjJ6RkQ3bFF0c3Fa?=
 =?utf-8?B?QTBWYlA2SnZLWUVwM2twZFJLVDRvaUl4OEkrQzFhMVNRMWNuMHlXTEs3RnNh?=
 =?utf-8?B?V0F0TGxjVmpYS3I4dFNqc1BodHNjVWh1bXRKYXM4bUI1cW9TU3R1ZUJpZUw1?=
 =?utf-8?Q?HtwBqKTKe3jIv2fo7gW3JjEKp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dk9DSUNmY2YyRHgyaW9sNUF2ZkQ5UDFUbmpzVDdFY3pPUURHMk8yajRORjNQ?=
 =?utf-8?B?VlVTMHl2NTVsdzBEM2ZrK0hHYUFCNjNiNzl0dTNqc2ozY2FYYzdzaDAxSFFL?=
 =?utf-8?B?OFhhd3hvbHBTZitLVXRNSkE0aEZjUUtuYzljdmtQeXF5TG5qU3JsV3l3Ty96?=
 =?utf-8?B?L1JaMHhySXV3cGxsdytndVdjU01zNDZKRmZIdEtER0ZNTk85Z1ZFYU5kRVdu?=
 =?utf-8?B?bmNNZ3BkNjE1YzNyaW5MUWdWK3NHWDVkRHZFbmhhbXlhaDYweEtJMSsyRFBI?=
 =?utf-8?B?aHJOZExkZFZYS245ZzluZ2cwV1lHV05PS2k5a011cEhaM0VHWnB5WmQ0VjJa?=
 =?utf-8?B?RTg0QllPL3BDeHpPOFVqaWxGOFU2Q1lPbnAvK2lPdEpDN3JFSi9VUUVIUzlq?=
 =?utf-8?B?S09UZmd0OGFxOG44czZXRUJkZHBRdUt6VXY1MFpoWUpMcHNLamVtZ3BoTUpD?=
 =?utf-8?B?bnBiQ3Z5eWJUaXEzOWQwQkNsSWN4SWp2MlplR3RlTHgzbk9QUGh1ek1BSjZu?=
 =?utf-8?B?bUo0YUN3U3MycDN5cTBMalRscFNUWncvWGtCanFDbTRmVmt1OHJDWEFpZ2U5?=
 =?utf-8?B?cGN1YTQwSDJGR25jamFNKytGd3AyYTZBTHFwRnpnclNpTWxGdmVPUko3eXBq?=
 =?utf-8?B?VzVtRHRkNERSR3U3aGcxNWYwNVJ2U3YrVmkrWEJLUzZpcWZTelZ4Y2tIMDF3?=
 =?utf-8?B?NVo4cnd3eEpuSEVON3puTUc2OXdyMzRON2xQWTc2clFsQjBiUStJUHFON09o?=
 =?utf-8?B?Rmg0RHZHRWRONHBsSU0rN1dlMlVVaStlVDE1VTNjQmhXUUdsTy84L1NkaWlV?=
 =?utf-8?B?cVdUNGtnYjZlcTNBV1N3QWp4MDMyVWF0OUZ2RDVXa2lueDVHOGNnS1RwWmZz?=
 =?utf-8?B?aTNKNUJKVW10M1hPWUt5MGFnUDBQMGc0NDBIemEzVjJsWks5SW1XRUl0NWl1?=
 =?utf-8?B?VnVBdEJaVkdUbUFYd3J3Zld3YVBlbTlBN3pBSW50RXNOUDA4RHBzWmVSVEZi?=
 =?utf-8?B?aHZkbDl6bkkxc2ZtZUx3OEVaUkpVeVFjS0tzZm0wazNRcFlGVUw5VmFYVWVI?=
 =?utf-8?B?Q0hvUzNjY1hjcE1yaTdGV0krS3d6YjluQWxmUHp4N3lMY0hHdlUwWmtRVGZs?=
 =?utf-8?B?QmxRQk9iaGVhQTJ0VHprOGRsT0NGNlVFZGVDRTMrZnp3QjM1NEdyUGlnUUV5?=
 =?utf-8?B?TXVqb0luaHFvb3ZmZEFvK052UDQyUXYreGYzNUdLTDcveVlTdFZCQUJOOXlC?=
 =?utf-8?B?MmdkUHYrbStyQWl3RUd3eDdEd1h3NnZRQWY4VWxNV0t1RHAyQURJS1Nndyta?=
 =?utf-8?B?ZlR1ZU1wSHk4ZXZaTzlmdkJja2pqWGNJdis4OXQ4OHhnN2tWT2Z2T05pL2kz?=
 =?utf-8?B?T01rQ0RKRFJ5MjZpNTJiWTRLMUlXcDV5ZDVvcVNGdXFRbkhKU1NETWNtUW1q?=
 =?utf-8?B?Z0U2T1l6TE5VL001bHpYL0NvRWJTWXRueEFHZWh5MDc2TjYySTVVSEtQb1o3?=
 =?utf-8?Q?vtLhAJOwnTo9s98h2p5fJsOCl3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc8dd49-4c95-4457-d7be-08db94da519b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 11:02:40.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twiG6TWWdjvK5TDWg7j6xGzk7vN0PhAAiTer6kWVmJpGqxSC+iv8k4cidXI2sbx22Pm7ZFVJ9KVxsiB9D7BM6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040096
X-Proofpoint-GUID: JfOoAl-LMESZU4dTS6BraHjgBghUar3w
X-Proofpoint-ORIG-GUID: JfOoAl-LMESZU4dTS6BraHjgBghUar3w
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 22:13, Ilkka Koskinen wrote:
> amperene/cache.json file tried to include L1D_CACHE_LMISS while it
> doesn't exist in common-and-microarch.json. While this bug doesn't seem to
> cause issue in newer kernels with jevents.py script, it prevents building
> older perf tools with the backported patch.

jevents.py needs to be improved so it errors on these events which 
cannot be fixed up, like it used to. I'll look to do that when I get a 
chance.

> 
> Fixes: a9650b7f6fc0 ("perf vendor events arm64: Add AmpereOne core PMU events")
> Reported-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Closes: https://urldefense.com/v3/__https://lore.kernel.org/all/76bb2e47-ce44-76ae-838e-53279047084d@oracle.com/__;!!ACWV5N9M2RV99hQ!IlO3yUW8jhm6wp8BJalODmD7WjzJleyREtTWS2pdn90Af5BD3P7g0fTGldbw15pSn49ycWiKpWDysjXw_ECS4XbbJQ$
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> index fc0633054211..7a2b7b200f14 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> @@ -92,9 +92,6 @@
>       {
>           "ArchStdEvent": "L1D_CACHE_LMISS_RD"
>       },
> -    {
> -        "ArchStdEvent": "L1D_CACHE_LMISS"
> -    },
>       {
>           "ArchStdEvent": "L1I_CACHE_LMISS"
>       },

