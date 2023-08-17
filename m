Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB777F4C8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350172AbjHQLJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350158AbjHQLIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:08:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED710EC;
        Thu, 17 Aug 2023 04:08:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HAOiSS009689;
        Thu, 17 Aug 2023 11:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CiTbpTCmRgZVvgdc+nacW1VvkIpOtIPqyDSs6oGUkew=;
 b=Czrri+b7aBOiK5uFZ2tMJWyPyzSlfGJ/nfpK/L+PszUaPVlsaH4YZ97dwcENsZAUxoub
 Y0dKiQdOftx7Cdw3PcyO8chRdXqs2qk7a8zpqcNfIBczTzje9Or3ToPPnFWgFAMxuELB
 eQj5KpdjRLQkeo3vKVu7mGUK2OZTI61/JRkp8+k4QwwEMoXMi6QCpwrZXbGxB2RHxPm+
 89ZiguM6U69ipW831/tzMpYX4x7+m5RMZBYyFbL1mc3Kkj4NK58SrpN8rrjely+OTzH8
 jOf2HidduhIliIs9yeKPC9k3Jn+jcUJIjOguTjAmxbfstwiWfVSKN2YkXgfTm0vICw/F 3Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w617pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 11:08:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HAmdxB006780;
        Thu, 17 Aug 2023 11:08:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2fq3ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 11:08:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRfCCRlGF6DjcxVpzXMANksRB0m9bwRK0M+Ksi3qEPYDMSFEfEf7phhVlWwdZGr1SLKuOubxDWLFT6cKN9AaqtRUvfOhszYREGPrhuBR59tyK7vCWY6MtUuY/5lm14CAhyD/PT1PGaQLOhqpXcXE9NYqwAkNCGbuVYgXy/MMOqF8led320llCxLwFG3G7kpkEvihKrzDWn+7d981Wx2rUjBJvylxKvCXvxgPCYM3tuS7WKwhCoB+ypETU0CQb4juIWBF9M+O/DvpAw4dnoqDYi7mjvVo2yy4Lqwhzu3Duuzg857w1KZ/VGzkJFToy9k2SpHoXGNkpkrweyjxt3wg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiTbpTCmRgZVvgdc+nacW1VvkIpOtIPqyDSs6oGUkew=;
 b=RCEzA+oX2Z+ohy2wOXsyPtUd78pHDhS7qkdWGqZ5sPlu4Hsdj9ON9V3Ik5PH3V3sGBH6Ngq2DdHDsetOj42LzIKxm0pKc6v0A5f8JwKaey1Tj4JP7eWnC+FP18hYGSe/TAeJ+RRaNUNJt0xI3V+Oa0xJz7rSLd7KvPwlQaS4EXZCvWbNYAKFiKMfXOUdXqofcSzHbFkruPePZT11YlvXlC1bajA6qY9GoyS0OQBq+Eyh+/sBHFvZzZTYqjOySV5T4YqOxetX9NJIJGtlr3h3AJ+9g5RFZlhNgalFm0Sq8Kcyoa8Z7hg6HgICW3agKUxuREbgn0fbaM86t6+XZ/fNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiTbpTCmRgZVvgdc+nacW1VvkIpOtIPqyDSs6oGUkew=;
 b=g9YhfOh7skJs4dzXoKp0MFePzjI7LuHtekfl2mIuXIdvA3rLQCg4pV//i38docv0zZQP5RJTFAOAjj292yAtCewuNPPS0X8kWL+57AqPdLE/rEFvP7at3BByuaNETr4Pausekr356Nsq3rvqKVuG737sHbII+uRj9RumGTZQoOQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6787.namprd10.prod.outlook.com (2603:10b6:610:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 11:08:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 11:08:07 +0000
Message-ID: <cdc3c536-6e43-5694-f6ba-6cd7dabf9a1c@oracle.com>
Date:   Thu, 17 Aug 2023 12:08:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 5/6] perf vendor events arm64: Update stall_slot
 workaround for N2 r0p3
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, acme@kernel.org
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230816114841.1679234-1-james.clark@arm.com>
 <20230816114841.1679234-6-james.clark@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230816114841.1679234-6-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c26e34e-52dd-4208-1bad-08db9f123c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRXatm7FhsrmWalM8Dtz/AZ9DnNIVr+c3kNkCDbdIKFMLzr7JnpZ91xjt/dtDsMYX0iw1mF8zY6PSegaa9jp4ZuFu0sRW8sf1oY+G6iHwd5N3+zKlvUGJ9NPoEKjcKfeIppqNm5+5xfxTtYYoDYr5Ypr9f4gjB9eqLyHzIW/rd6hH1sF+6nIJw00IyGPbRoC8UpAf8dWriLLCXj5h1ZraDtHrBkFeci80D/Y30pagX45zJVgR7rQvocvBUrhRZESnpN56r/zjvbQydBfoU4jkAah/cbmeBH5HpFqcPhhpvWDtzzfMD+bNHOmDev3VZscYEGV0xldRJNm0FjhHbz7Z9MlyurkH8RfeQBSvsP0qzBKnnDPh28zYXvYkzagMb9yXjWNRfrmggThLPG3bX6v7ngQc02C6gIcPfcsegwVECL6+qdOBuCeU3xB9rygWWbwmOi1DaY94ibMlyyf+r9jcFIKplKCp8ormayfKahmVol3h3sjKWQYX59QTtO5QjqtMirUFoL9In757TMYvI3RVcKcbr+yN8FuT4TsD2lkoacjh4usUCgRWYeL74ZnvtuuFjJUq+CMiJgBR+OatQa1x298ADrpRv+hkO149LUBTv9lDFSHcjruSRARgkVelfOG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(316002)(54906003)(66946007)(66476007)(66556008)(31686004)(5660300002)(41300700001)(38100700002)(4326008)(8936002)(8676002)(26005)(2906002)(31696002)(4744005)(478600001)(7416002)(86362001)(53546011)(6512007)(6486002)(6506007)(36756003)(6666004)(2616005)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmVjd2RTbmMyVWZJa3J0SGdFUFF2enppMTRUS1drd255NVdMSEZ0emErZ3Np?=
 =?utf-8?B?dWdHamVtSjJVQ2JRMU54NDVOR0pKUWFPd3NZWEpoV2g1SG5LYTI0dnZBMkV0?=
 =?utf-8?B?T1lYQUZwenZtd09KM1d4L1NsQVJxSzJFdWVBU3ZVK1RFSkc0WGtBVW5OMnp3?=
 =?utf-8?B?S1E1aGVIQ1V0VWYxYVg2TFV5b3BUbVFjOXpBY0hCbVMrTGxuTHpuZ2ZsdU9L?=
 =?utf-8?B?SHdxcEhudHVSeGxnTDhRNlJnbG9YMDNraTNOTjl3dzY4RHZyVThDaWRDUWc5?=
 =?utf-8?B?Wm94VWd0WWsvT2dRQm9oWmwvcTN1UkFDTzhXaFhqWXpqa1I1QWhxcWRPR1pp?=
 =?utf-8?B?T1VPUHBNVkFUTWdLSjFsZ0dmSHd6Ykp2cU90WWt2bkEvRG11ZU1tZWQ2R2x0?=
 =?utf-8?B?TDlQMm40Nzg1WVQ4RlphRWRNeHFFODljWEkwcmhQOTJ3Wk5VVlZ3RzNydVYw?=
 =?utf-8?B?WjdYUlNxbUZWOHd5QWRpT0l0UVFOMXpjdlRyL1FoekI2enRNRE10K2ZvY1NL?=
 =?utf-8?B?akk4ZWVITzNFZjJKQUk0NkREcFpzeElOUnVoRFhZRzgyMFNjUUQrRnhMUGRS?=
 =?utf-8?B?cklveGxLV2FOMUZLL0gwSGhTdU1nUWpVOTdiRnA4QXpFSlNZNGEwNjJTeEVG?=
 =?utf-8?B?emdaYjdSRXQ5MnNUY0pCTVJDYUUvUWtTYmM3SjgyZDVnMG4vSkNpUjlHSkZa?=
 =?utf-8?B?b2VEM0Nmb0tyZG1SNVBGY3lYTGRrMmhhS1IwM3R5ZVNhOFJKQTk5TXUzSzVm?=
 =?utf-8?B?VWNCaUZlaUJCQmtBNmtMVUV3Q1BOLzMyRTdQeXFobjR1UjV6L3U4Z2tSd1ZW?=
 =?utf-8?B?Y0VaZnRPWWgwNk4yRjhxVnQxTjMzZGRNeDk5OVJkMG5NVmpONnNWMmd5Skx3?=
 =?utf-8?B?UXhMdytVa1k2Z0s3b25KZnBwUmNINWd3bWJiR3BmSDdZMHVSTERPV29wY2Vo?=
 =?utf-8?B?ZS9MSGhyVnNUQmhLTEFTaGowLzZRZHZLdEVpZlY1TGsyUUlUQUt0UU4wTkpZ?=
 =?utf-8?B?V2xvY1RMcDNXQW1kQ2xlMWl5TVNFcU45eC8zWkpTMVQ0VkNoMnIyK1g2MzdC?=
 =?utf-8?B?WFRhYzhsZWRuZG90L1ZsbkFVcUZzcFZOVzR6MjlFVkx5N1hXWUNXK29mSWNL?=
 =?utf-8?B?MTIwQXhVYW0wVXZSZjkyUmg2bTdpQWFLamNTNGlVcm8zd2xQM0JqQzR4SWlN?=
 =?utf-8?B?L0NBVTJ4YzgrNDVEMkdmakZWb0NWbmVvYWVseWdWODNKemtBNXlvZWxhVnRH?=
 =?utf-8?B?VzV2eGVLeFBqRUNwdkU5a3VRVGxmRzF2dE1jZGNQaEE1clp0bVFMbmIxUEtp?=
 =?utf-8?B?YW9DOU16emNFaDdUSXVrdHFUSE5pL1RCWU43RW1NZHVrSmZXOGFxZDEvS2Jx?=
 =?utf-8?B?aVl1RGpWcE9FMWYweHpvTFlXdFVuQi9jNEhNd3oybHJoQzltZDlmZXI0Vzlx?=
 =?utf-8?B?M2NuSTVocU9xb3ZVNzRNMVRaQ1lNaTAzRndTZHUwODM5cWFRU2V0SXo2UzRN?=
 =?utf-8?B?T1Z1eDFOU1RkanBQYVV0R0w4Si91MnVYOHZFdXcyK2NiaFdSdXg5NG95ZDN1?=
 =?utf-8?B?dFNaVXBsTzVLTnVscjdKa3NHK3FkVUFIdWprczFEUmU2cDZHdUdweGFqL1Ey?=
 =?utf-8?B?VkdWdEN3Rjlab1hNOSt0K0ZsSlRzWDhUM1ZhaFhoR2VmN1czRXozNDR1cWJS?=
 =?utf-8?B?OCtZcFlETWMrMjdXbFBTTEpQdzYwZTI5d2JIeGpjbzVkSmtoTERON0JETXpO?=
 =?utf-8?B?UjQ4UDlLb2hxOWhQZHdyMjN2TUc0OWVkTWdlajVQV3lEUFFrZWQvL09ZOTVs?=
 =?utf-8?B?SFQvMDhYNFFuMVkyWVNyVUJzTkdTemh6UTFkSVlDb25ETERHL0NwUWJpQUFq?=
 =?utf-8?B?MmdiQlVIWXViUCswemdUWk43ZitTZXk0SmZCN0pQWEl4WFdoaGN1Ti82M1Nx?=
 =?utf-8?B?ZUV6ZUFvZjZqWE1XWFYxeHNzTWszUFN1bWxvdDBaejhCUGVNNU1RZWNsUGh5?=
 =?utf-8?B?MUljZWhKaDBubXV0R0xCeE5zMmZKT285Y3hlQUV6QkNzaGZZM0d2NnMrUWNj?=
 =?utf-8?B?SFVtbVROV3p4MDJIODhmRWxncVVuUnBJcTFob0lGL2kyNTJCY2NDZVZJNml3?=
 =?utf-8?Q?CeUvG/y9JY6NegIqdCcWnkWes?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dEQ0ajRjY0trSHNrbHlMc2F1dkkyTkoxc0szNS9Fa2x2eExTbTVYZDlPUU0z?=
 =?utf-8?B?TDBJOFZ4UWlUOHZjdnVNZ3dkM0MvbHBGSmZXSzV3VkJDazdBT1FWdGVESGln?=
 =?utf-8?B?YXZnWUV5TldEb3VtbmFhdm9vaGZaZU5qNzN3cVlzLzJSVXlrbXcyY09oT1gz?=
 =?utf-8?B?NjllK0lMUnI2K0dvVUFZNnlJZzBIdkxYWFZDVW9jT3ZpS1hoNEM0d3VJSkwx?=
 =?utf-8?B?ajgzeW5LWVVRQ1hudXFDWWpOY3VtUk9xcXpjWDY4MFZ4NC9TM0FWdlpvb3pF?=
 =?utf-8?B?eGZiOEZFZ3RLeGhiYmE5bEY1SkwxNUpSbzFaNGpiZXlScndNRnR5YmVBWEQz?=
 =?utf-8?B?bVYvbDZRVXdIRkdJNDJLREZ0dlNRTnVUMTA4a1lveVJWR2JlVS9kQ09DZXpT?=
 =?utf-8?B?cVQ2SlNlbEUxQjhsTjRkd1g1ZStjazhjR00wdDZucnpHK2M0dGFZVnJVVXRZ?=
 =?utf-8?B?cllOR2I0UzhFby8zS1dPZEVES05MQW5EVk15cHcyVXQyaG1MWnFNOTEyRGJU?=
 =?utf-8?B?dTM0SGVMVGxnMFhzQ3M0TWpZQkNJaUgxbU1OT0huMUxiZUREeVd5aWtTbCtQ?=
 =?utf-8?B?SGg0TEdIRFkzYmlUYm5IaE9UZFpzbUNiWFhiTlhEbFJaTkl6VTBPM3k2bU56?=
 =?utf-8?B?UTh1djB4b3ZLMGNwaDNrWmNaRzlNWmZEa1U5UXJUVCtKRHZyQWhEa0xXYTEx?=
 =?utf-8?B?V0NWNDFXcjY2Z1FVWWZmeFZNSEJnRXA4SWFDdW5GM0Y3emVZS3hOc1hsRWNx?=
 =?utf-8?B?cFNrNExvN1pDdjlOeCtzckRpYmhnM1o1MnhMcDIrdHRaeUl1cGo1ZkpGcVNq?=
 =?utf-8?B?TkJBMnhZR1NLNG1zdkNMTjJMVkhKVzFsNEFVTnBQUkQvejRkcGtLTEZEZzRG?=
 =?utf-8?B?Yzd3UW04a0QzNklCY0MxaU5EYWlSWUFPc1JLSjExYitxVlYwSEpNQzVCbVVT?=
 =?utf-8?B?U2JDK29sVnl2cHBqZjRSVEtaVXA3YjFXVTd3dFFVMHpPVWpnNnc0dzBqQkFP?=
 =?utf-8?B?bytMQW9DOWpZbkhqYXFwc2ZnUVBVcU5aK0pZMG9UaGFZaE82M0c4TzVIcmZz?=
 =?utf-8?B?MTRSMmppVFM0TXB3YVN2TDE3RmwvZStzZGZSMzdqV3VTNTVzM29hSXE0djNr?=
 =?utf-8?B?UjIxNmp4K2pqMzZBcGxHVjJWcUJSaGRmczYzcDdtMHZzZXpWVnA5cGRlM3FH?=
 =?utf-8?B?TFVrQTBKT2xBY1NKOW41cW85ZktWbUZRTENILzRJdEhBREtIN3FRNFRCdEtQ?=
 =?utf-8?B?UmZnM1k0OU5qdVhsMnRhYzJTM0F0OEVHY1lweEJvOW00YUFDSnczSVNzQW1n?=
 =?utf-8?B?WWpqcjQ2c1FkM2RCOTJnWWRPaTdaeHU3TktkZUdKd2RNSUNkdkdCU0doMWFq?=
 =?utf-8?B?enk2SFFSYnVpRTMxc0F4d1IvZGhnS2lHWXFHZGJLTU9HQjVqdndaR3VTUnpv?=
 =?utf-8?B?TGJBRTUyTUlEcEpQc2NBMkwwcms2TENhbWtoeEl6ZjZTbG5zblRJNnV5ZUZP?=
 =?utf-8?B?eVVCbzE4eC9aZGtaeEFBa3I1Mm92a01jT2FQVkd6Zi9XVk9IWW5uUVU2dCt3?=
 =?utf-8?Q?Vs559YotdDPG/uiaDc0RdtsLM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c26e34e-52dd-4208-1bad-08db9f123c24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 11:08:07.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eL08ioEHuBPBf8etGKFKaLSAwM/0VdfZlZ9rywSar10XvMET9oeru/BxCKnJhY8oEXzKxLK8VxyGiMJ6anH7Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170100
X-Proofpoint-ORIG-GUID: 8G1o26qvIfE5gwA8ir__QUNPBgH9vtMb
X-Proofpoint-GUID: 8G1o26qvIfE5gwA8ir__QUNPBgH9vtMb
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 12:47, James Clark wrote:
> N2 r0p3 doesn't require the workaround [1], so gating on (#slots - 5) no
> longer works because all N2s have 5 slots. Use the new expression
> builtin that allows calling strcmp_cpuid_str() and comparing CPUIDs in
> metric formulas.
> 
> In this case, the commented formula looks like this:
> 
>    strcmp_cpuid_str(0x410fd493)        # greater than or equal to N2 r0p3
>    | strcmp_cpuid_str(0x410fd490) ^ 1  # OR NOT any version of N2
> 
> [1]:https://urldefense.com/v3/__https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2-r0p3.json__;!!ACWV5N9M2RV99hQ!JvpXOAN-7zsKcA750zS-vMlcJKvvIZ_H9zg6jitWJRMitlFGDrx8bXoMrhdK5ubhO8CtXObRFx7bDYM2R5Feqg$  
> Signed-off-by: James Clark<james.clark@arm.com>
> ---

Reviewed-by: John Garry <john.g.garry@oracle.com>
