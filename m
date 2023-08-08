Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D139B774ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjHHW6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjHHW6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:58:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3241995
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:58:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378MhwAM008248;
        Tue, 8 Aug 2023 22:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=X/C1oyFrlBxfl9kFDi8jr+VOzUPJoHNboq3T4C9ccok=;
 b=yQzLcTYGszWYUlOBdniDthAokTWaOWazaaZ51GZn5CysLzz8QYA7fjh6bRdHjy2H8XSg
 Ku+RprhDNFpf8YS9BdRncNiHcRP3eq4xF1Lni95CsIf/6Xcl8VFA1bcYH5+Y73Y+BxHu
 TNSJFBFpHPbkHAs1CoA5Gn4LxZmqWPtE2MfdUhw/jATmNj++fJxT4biWNafEIK+DeHSY
 tx6G0e3qT/fcZVfFQoDH7ivGt9hVJn5liWD04jd6v+hIhkvW0m+gtSd96bfOH1NCMVj0
 QRsDBl9pMODdEuFYb3GYM4WHbU0eolLX96oVyM7w50hLZhgysSF9GSwQFFITkuxspdPV xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d73esc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 22:58:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378MnucH010665;
        Tue, 8 Aug 2023 22:58:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv66tq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 22:58:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmNSM0YvFz0yoKRpsIrHn9aqx18jCnatuTjZAO3fzBJwVNZxjs6SKb8yyqSVbTqZXmBSLx0r973zqx8kV3898tiSEk8yci2K1EAzU6fUNw1JSiPmytzwyOLebwoEPM0ZxsUUSKBJwVJzuuJkzdtqMNjwJSu9ZlviVOSHwVExRTlqDQNr+y5YmHKXytQjdmn8HaZcPT4BhMkyr9KuDo6LJpXjfjtJ4hA3qovkuTRMhIcUtD6nXLdMuLlJBa6YYz1L6dcXJo/jEaktKRF0/7k7luixpDrEo5u9PGK5P3G462oLxgSRiM3/1BjpMWYRMqsZKvEuJbA0EkujrYM2tdxtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/C1oyFrlBxfl9kFDi8jr+VOzUPJoHNboq3T4C9ccok=;
 b=Q5ECdQ+7NFo/PQ5VlagJUVo50Ih9qM0DKgNWFTnStWmC09cgWnH1BPmpjkNaQD4jqqUQLQJfMcHHxcPUfOPTxY/xyWGWCZT5cQ2y6o3NbanIhNnSHK2Nt5AZjJCWFHW+IfeNuek5Ha3+SiBmmgb+4/retwlZjyyOxSEFqP1B9NTSY3rXI0J4OnzETljJL0nkCL3OLLGRutKP/xg7xcOO+AVGOz74BZfdUHTBZ6K0V+iyEKthU92pho94yVnW8MEhTof2KXskOs1Wb7JKcwkXw37vMdv5QfTU9+2Trwe7dT5fWlgohBZTlTzYkYqGzv8I67F76ztYMFN0urVWhGkU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/C1oyFrlBxfl9kFDi8jr+VOzUPJoHNboq3T4C9ccok=;
 b=XXoqhuFkPCj+SSkv0GtOlg0n0Zc4/52VkIbFJNn30cKdtGF0K3+mDS+pMxEsws2xj9msCXUUKKDQ1edLgK6SV4lioJSLc8UzM1jPxjX+MRyCrd7sH0PkbyPmXol7RVQ4df2k6EchxBrMQra7HEp/fKy7xiuH0LP5TSFhWOMG8UQ=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH8PR10MB6456.namprd10.prod.outlook.com (2603:10b6:510:22c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 22:58:20 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::2ae3:b57e:171f:789]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::2ae3:b57e:171f:789%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 22:58:20 +0000
Message-ID: <3472a482-dc1d-1994-e2d7-c2bd740bbd27@oracle.com>
Date:   Tue, 8 Aug 2023 15:58:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Gal Pressman <gal@nvidia.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
 <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <741645a0-c576-e504-8ebc-6b716099d730@oracle.com>
 <CACGkMEuAUBa=ZWi2Y48KDABsyAsQFNc4AAPmkHZyXHCQ8Vv89A@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuAUBa=ZWi2Y48KDABsyAsQFNc4AAPmkHZyXHCQ8Vv89A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:806:120::26) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH8PR10MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b1b818-3a2a-4b43-bb07-08db9862f5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIF14E0H3ghLvyAcpui9baFrcDAueRRVSI9oyq8aVWks9AD5/k1QWi0NMJHn7Z7zaLxUB5/2NYP3T0f2JWkKJ3xSVOiRAxhDrUGE0zjbpzeYitfgPN+vihtVv2LiWS4DH/Uuf0sCL5auIPCkolY4XETo/dj99mkUKq79fI2e+KIavgcBN4R0F20hpq7mouCoFvz2KFUkShQDtTbs7PfnHuOMFkWSWcWkd7G3Pb2XbSm3qASfhIinS1l4FrqaEpfMq3qj7FSlINc9mmOyjyKnz7uHoqbEerQmEt9e7dtruvWucs3airQlGZ/dDDTiADmLAJ9kepvxmpIpae5yw9qbBy/4V2ZOmKiF/PzYPasTi+D9c9pDAXNTDiVf7wYhSEKQkhwNuGD4fZWc/t4Xprzay7tDyxef/xr0Jykly5sMRWO/ZZFQ0yqgbRDPF4oamd3MkcwqiYU7ggmc3UwKNFHEf3I9JihGufUf/y6GA6LiW/XyLm93olVDYJoJzc6+W/fC8xohBlLFAQTlRpc8W5uXd8ZeAxUTlJhwQCurg3BRuBT4MMe4IqcKatib8R6amBy1f1H4xkyLBwZsBb/Rtb5TnRQpt2dQI6Iqx2P01RcAHMJr61vS1Qyeei4P7ITrEDszQ8K3zo5HPDxDOCE8uDfBw+m7cSN/cGFSZfJYSAfQEkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(346002)(376002)(186006)(1800799006)(451199021)(83380400001)(66574015)(31686004)(2616005)(54906003)(6916009)(4326008)(8676002)(316002)(5660300002)(8936002)(66946007)(66556008)(66476007)(38100700002)(6512007)(31696002)(36916002)(6666004)(966005)(86362001)(6486002)(478600001)(2906002)(41300700001)(36756003)(53546011)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUd5ZENFcXdjV0VaWVpwQTlXMlJUa01wR29LSWR0RzNXRjdOVmFpS3ByVnc3?=
 =?utf-8?B?ak93N0dndGE2VFZJZlZIRG5HRDVrZUNkVDRIU0Z1ZWgrT3B4Y0UrbHUvYUdL?=
 =?utf-8?B?N0VtdUpnY0NLak5jaEF1ZFZzdWladi8xd3laNDNuejBhNld2NlBnSkRUdXZz?=
 =?utf-8?B?TWxqSXZIakVtMEcyWWh4MHpieUdjbTZrMWFHNnJIRVV6SjMwMEtDQStncHM2?=
 =?utf-8?B?bVVyZGtsOC9JZndVSXZnYnpFL3k4Zkd3Z2czUExrek1hZU82cDlLMmYzVlFu?=
 =?utf-8?B?c0lEVE9mZmxsMTVBMHZrRFYrRHNabGQ3Ty83VUtmbTVJRlRmUzUrU0N2dUpw?=
 =?utf-8?B?M1ovSkg2bVh6c09tVE5wUm1rMDFyUXJMUzhQT3hDajR3ZS9YdWowb2kwOVE1?=
 =?utf-8?B?eTBrN200VlBncG00bkRzMGk2SFpWWXJkb3NxL2dkdlg4cU1rUjlzaW5jbkJH?=
 =?utf-8?B?N2hWdVhKZWIyL3JzVnphZUU1Mm91VjNoOHl2VEJuRktEZzNQUStrMm1nN2Q0?=
 =?utf-8?B?bmx4aHlOVTAyR0FHaGtvR1ZSbWNxVFhYQnYrYXRwNXV3cFE3eFh2aFpzdmNu?=
 =?utf-8?B?OWlTNkpFRi9OZzB4ZE1mZEtyWGZvU242cmdWZE15Ym12NmNvQm1CZjhnMGdS?=
 =?utf-8?B?TlVPTXZoK2Zyc2pteTZacUMvcjFKZGRuRE9uTHVjcTlUa21QaXVFcEY1blFi?=
 =?utf-8?B?aDBneG9tMlEyRUVmQWdOVkRYdllzR1lyV083ZEFGbmpkVnU4S2xMSUljcHBD?=
 =?utf-8?B?RmZsS253dlZ2Z2tIWUR3VVFnSktsaUJvcEZFQjgvZ3cveW5LeXl2TkFMS3pz?=
 =?utf-8?B?bDF3aGNISXRlaEFtVnlnZDRoTGJwN3Raakd6enlIVDF5U0xYaEx3RXg5Nncr?=
 =?utf-8?B?UlJ3aDJqanRNb3kxc2pZUE9qdVFSMGE1K25xR3Q1dG90SU1MbWQ4a0FHL05w?=
 =?utf-8?B?WTN6eDg2WUpMeDlXb3ZCRWtwV0FTNGE5UmM2Nzgya2Y0dXN2RE5sRTBOTnM3?=
 =?utf-8?B?Q09mS0dqY2M4SDUrZ2FyUE5xRzdoeE5pSnpJYlRzczN0bEc1YytIZlBDbENJ?=
 =?utf-8?B?ZjZlUDVITzZ2ZkZrQWJlVitQazZFZ2YrekgxSGlpaGt0OXBSVFNJTFNKVEg2?=
 =?utf-8?B?ejJ0VFhrMGVzMDBwSlFWcFI2SExRN3hDdHd0amNpRCtqckplQ1B5dFFsYUNO?=
 =?utf-8?B?cFFzTVVINC9sbk9SRGYra3R3UHRSNXZBRHpDOHJ1RXNPL01wcVZBYVhoalR2?=
 =?utf-8?B?cnNWaFNwdlUvZ1RCMVRUV3kyNWdSYjk4WU5ldzE5emVSSDZmSVk3MHVVZGdi?=
 =?utf-8?B?b25FU0MyQjk1dGphdEhjWStNZHJEbkd3NkxuTnZ2cTYzbG9OQzJRSE9uOHNW?=
 =?utf-8?B?d051aVV5Q1hYMXIzZ1A5U2xnaGpLaGRSSzhKdkp0bVlJOUhveGxYVFp1UTg2?=
 =?utf-8?B?RUxlZkUwVm8wUTVMUkNNdnNNUUhMbHkvSUE0d1JZY1JScDQrQ21xbVRxVmcz?=
 =?utf-8?B?ZFZkQ0lwd1JvRVJYQnhUbjZFeXlVN3RodXIwM0Evb0pBS0FmU0FtMlI1bldv?=
 =?utf-8?B?bTJaTERRLy8zNTF6NHJxZHdhL2NtdE5ZalhtbXZFcjR2aWdoNXBycVl0SUJs?=
 =?utf-8?B?NG1UdFlkeE1yOERpS2dGMTQrNFdwTENRblJ3dC9YWkdtcE9vMFk4MHBFaXRT?=
 =?utf-8?B?MWc0M3Vyb0tTcFludVJQU0FRcDRUdm5qdG9mSllTRHdTYyttSFF5ejcxTlVE?=
 =?utf-8?B?TCtqRWlyRDk5dC9BQlphc3lGYnFPbGFwbm9FSWRiVUZ3MXJiM2JiUThYcEsv?=
 =?utf-8?B?bTZJTEdrbUsvekdGbVBKMDZ4eHgxQTZSUjRLUmVLVWQzOTQwOTEyVTRsMVN5?=
 =?utf-8?B?YktibEF1SGphNDNKa21FU1hucWtDT1NZdEU4aDZEbGpYV1VNdDVUS0RPZXZX?=
 =?utf-8?B?UjRKL0ttQTFWL3NHeGYvZ0NzaUJWRG1pQ3lrWXpvOFlRUnplY3V1a2tMSksx?=
 =?utf-8?B?eXlxOWR4LzFaT2RnRlJVTTF0MDBKQ2FrTWgxM1VXdFBObFVLNmsvOGVkaDlG?=
 =?utf-8?B?ZUxUMzIzVEtpM3NwZCtvclZYd3hnOVFyS0d2bHBqY1FGNFlCM3c0eGdMOUNO?=
 =?utf-8?Q?D/2bXFsRe1wpcee/AjkMrz6jY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MTNmUU9LaE5ONEsyT0ZZbG5zblhMVDBwN2kvS09CQ2NuRk1mTTJvNDg4YTdw?=
 =?utf-8?B?ZkpWSlpGSFRNeDd4WXUvSkpUTGJKQmI3bFViWkRSWTNTSEdZZm5ST1FsZzBX?=
 =?utf-8?B?VDFZYjlkR2dPOXFSQVJMOHBpWmxvT0JITWs5Mm05dFNSaXhDRG5EMDRCRlJ3?=
 =?utf-8?B?UWRYYmRXRGxBNmhhUkNkS2REYitFcnJ5MTRNL0h1ZWp3RVBySS93c0xSaFV3?=
 =?utf-8?B?Vjd2QVVFNU04eTlYUzJWSE9wU1dEN3pmaERIU1NRTDN1dStaU3NTajdyZk0w?=
 =?utf-8?B?WCtJRTgvN2hUS1QrN3FXR1hGd2hpYnMrSStDWlYrZm1WYzFVbWlubUlnOU81?=
 =?utf-8?B?Z2VaNGlGeTNRS3ljM3lGdFNtVTIvc3NOV1lqZmpGYzU0RWFIV1hDazdreEdt?=
 =?utf-8?B?Tm5PeHBYb2lGWWNHa1NCKytpTTdjaFIvM3pwdnpadTZFL3kxaDVJUGIrQ05i?=
 =?utf-8?B?Y0xXbFJPZk50TEh6TEJVa2ZWY0NreVdwaVBvdzREL3JES3U1VEhldVhxamhu?=
 =?utf-8?B?dGhNSS9zRjdjd3RFc3pxRlpZRnN3RXpBby9JWkJjTVVPclJQTDV0UytIeFpU?=
 =?utf-8?B?M2xJRmYxT0R3VFhIQzdlQ1F6UVJYYVVyeDJIc21iZnBPeGpxTkRqK2lleGQy?=
 =?utf-8?B?WTZPZ09xM00xZmo1Y3Z4YUpVQ1Mvd0o4RkVrV0I4L0NOcHNtV0RBak5CZUpR?=
 =?utf-8?B?WmhhcVlkaWRxczVFY1B1SktTdFg3ZXBYenp6Sm1Tam1qTnVEbVpSYzJGc3kv?=
 =?utf-8?B?dDR4clRBQlU2T00vOTkzNlRZRlRsTk1iaEpiaDV1SUpIZDJKUVgxT1lTeG9j?=
 =?utf-8?B?ejZzOHNyWEpMNmtWN3FQZnkzZWFRbWpaT1p2RStqRlVPUzVHLzYrNnhkcWcx?=
 =?utf-8?B?QzF5TUh4WGJaYlBobDlabzMvYU1KN3dVUHpBUXlGT0VJbmkrYkxXWG0rMzJO?=
 =?utf-8?B?Nkx1MFZqeWNvaXpyUTVhNUh2emR5bE9SODBwZkdjeURxQ2o1bHRFMDloRmJ2?=
 =?utf-8?B?alpld25DNDVSWWhDY01OTExyditJdUR3TjgzUy9JZmswVy9jcDU5VUhKTVVP?=
 =?utf-8?B?Mzh6U1FCZnFDa2RFbXFBVEpPQ21nVnh2bGZhOGxTeWZQMlN4Mk9vMUNIZjU4?=
 =?utf-8?B?ZTZJdXhMSVJzMkFCTTl3ZGVidHFGdkZTMFBYVkQ0V2pGZ2FFY2tZVnFZR3RG?=
 =?utf-8?B?c3pvdjFsS1lXR0YydGNCbmlpeEpIOGtoamdSMThlYSt5WUIycURjTVU2R2Er?=
 =?utf-8?Q?oGqkECrEzgI48oH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b1b818-3a2a-4b43-bb07-08db9862f5ac
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 22:58:20.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbDS/IDDAxBn954PExonK0jTm7Mjgil5w8Xl1cGDQPlbpsWgHja4rfV1DZ2XDJ7PAwmp2NyAX37MJLaJdkYFeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_21,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080206
X-Proofpoint-GUID: hdDZV88aqKu7WV2yI-zlxbt5_14mKiud
X-Proofpoint-ORIG-GUID: hdDZV88aqKu7WV2yI-zlxbt5_14mKiud
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/2023 8:00 PM, Jason Wang wrote:
> On Fri, Aug 4, 2023 at 1:58 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 8/3/2023 1:03 AM, Jason Wang wrote:
>>> On Thu, Aug 3, 2023 at 1:13 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>> The mr->initialized flag is shared between the control vq and data vq
>>>> part of the mr init/uninit. But if the control vq and data vq get placed
>>>> in different ASIDs, it can happen that initializing the control vq will
>>>> prevent the data vq mr from being initialized.
>>>>
>>>> This patch consolidates the control and data vq init parts into their
>>>> own init functions. The mr->initialized will now be used for the data vq
>>>> only. The control vq currently doesn't need a flag.
>>>>
>>>> The uninitializing part is also taken care of: mlx5_vdpa_destroy_mr got
>>>> split into data and control vq functions which are now also ASID aware.
>>>>
>>>> Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for control and data")
>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
>>>> Reviewed-by: Gal Pressman <gal@nvidia.com>
>>>> ---
>>>>    drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>>>>    drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++---------
>>>>    2 files changed, 71 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>> index 25fc4120b618..a0420be5059f 100644
>>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>> @@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
>>>>           struct list_head head;
>>>>           unsigned long num_directs;
>>>>           unsigned long num_klms;
>>>> +       /* state of dvq mr */
>>>>           bool initialized;
>>>>
>>>>           /* serialize mkey creation and destruction */
>>>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
>>>> index 03e543229791..4ae14a248a4b 100644
>>>> --- a/drivers/vdpa/mlx5/core/mr.c
>>>> +++ b/drivers/vdpa/mlx5/core/mr.c
>>>> @@ -489,60 +489,103 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr
>>>>           }
>>>>    }
>>>>
>>>> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>>>> +static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>>>> +{
>>>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
>>>> +               return;
>>>> +
>>>> +       prune_iotlb(mvdev);
>>>> +}
>>>> +
>>>> +static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>>>>    {
>>>>           struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>>
>>>> -       mutex_lock(&mr->mkey_mtx);
>>>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
>>>> +               return;
>>>> +
>>>>           if (!mr->initialized)
>>>> -               goto out;
>>>> +               return;
>>>>
>>>> -       prune_iotlb(mvdev);
>>>>           if (mr->user_mr)
>>>>                   destroy_user_mr(mvdev, mr);
>>>>           else
>>>>                   destroy_dma_mr(mvdev, mr);
>>>>
>>>>           mr->initialized = false;
>>>> -out:
>>>> +}
>>>> +
>>>> +static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
>>>> +{
>>>> +       struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>> +
>>>> +       mutex_lock(&mr->mkey_mtx);
>>>> +
>>>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
>>>> +       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
>>>> +
>>>>           mutex_unlock(&mr->mkey_mtx);
>>>>    }
>>>>
>>>> -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>>>> -                               struct vhost_iotlb *iotlb, unsigned int asid)
>>>> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>>>> +{
>>>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_CVQ_GROUP]);
>>>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]);
>>>> +}
>>>> +
>>>> +static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
>>>> +                                   struct vhost_iotlb *iotlb,
>>>> +                                   unsigned int asid)
>>>> +{
>>>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
>>>> +               return 0;
>>>> +
>>>> +       return dup_iotlb(mvdev, iotlb);
>>> This worries me as conceptually, there should be no difference between
>>> dvq mr and cvq mr. The virtqueue should be loosely coupled with mr.
>>>
>>> One example is that, if we only do dup_iotlb() but not try to create
>>> dma mr here, we will break virtio-vdpa:
>> For this case, I guess we may need another way to support virtio-vdpa
>> 1:1 mapping rather than overloading virtio device reset semantics, see:
>>
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
>>
>>   > Conceptually, the address mapping is not a part of the abstraction for
>>   > a virtio device now. So resetting the memory mapping during virtio
>>   > device reset seems wrong.
>>
>> where we want to keep memory mapping intact across virtio device reset
>> for best live migration latency/downtime. I wonder would it work to
>> reset the mapping in vhost-vdpa life cycle out of virtio reset, say
>> introduce a .reset_map() op to restore 1:1 mapping within
>> vhost_vdpa_remove_as() right after vhost_vdpa_iotlb_unmap()? Then we can
>> move the iotlb reset logic to there without worry breaking virtio-vdpa.
> It looks to me we don't need a new ops. We can simply do set_map()
> twice
What does it mean, first set_map(0, -1ULL) with zero iotlb entry passed 
in to destroy all iotlb mappings previously added, and second set_map(0, 
-1ULL) to restore 1:1 DMA MR? But userspace (maybe a buggy one but 
doesn't do harm) apart from vhost-vdpa itself can do unmap twice anyway, 
this is supported today I think. Why there'll be such obscure 
distinction, or what's the benefit to treat second .set_map() as 
recreating 1:1 mapping?

>   or do you mean it would be faster?
I think with .reset_map() we at least can avoid indefinite latency 
hiccup from destroying and recreating 1:1 mapping with the unwarranted 
2rd unmap call. And .reset_map() should work with both .dma_map() and 
.set_map() APIs with clear semantics.

Regards,
-Siwei
>
> Thanks
>
>> Thanks,
>> -Siwei
>>
>>> commit 6f5312f801836e6af9bcbb0bdb44dc423e129206
>>> Author: Eli Cohen <elic@nvidia.com>
>>> Date:   Wed Jun 2 11:58:54 2021 +0300
>>>
>>>       vdpa/mlx5: Add support for running with virtio_vdpa
>>>
>>>       In order to support running vdpa using vritio_vdpa driver, we need  to
>>>       create a different kind of MR, one that has 1:1 mapping, since the
>>>       addresses referring to virtqueues are dma addresses.
>>>
>>>       We create the 1:1 MR in mlx5_vdpa_dev_add() only in case firmware
>>>       supports the general capability umem_uid_0. The reason for that is that
>>>       1:1 MRs must be created with uid == 0 while virtqueue objects can be
>>>       created with uid == 0 only when the firmware capability is on.
>>>
>>>       If the set_map() callback is called with new translations provided
>>>       through iotlb, the driver will destroy the 1:1 MR and create a regular
>>>       one.
>>>
>>>       Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>       Link: https://lore.kernel.org/r/20210602085854.62690-1-elic@nvidia.com
>>>       Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>       Acked-by: Jason Wang <jasowang@redhat.com>
>>>
>>> Thanks
>>>
>>>
>>>> +}
>>>> +
>>>> +static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
>>>> +                                   struct vhost_iotlb *iotlb,
>>>> +                                   unsigned int asid)
>>>>    {
>>>>           struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>>           int err;
>>>>
>>>> -       if (mr->initialized)
>>>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
>>>>                   return 0;
>>>>
>>>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
>>>> -               if (iotlb)
>>>> -                       err = create_user_mr(mvdev, iotlb);
>>>> -               else
>>>> -                       err = create_dma_mr(mvdev, mr);
>>>> +       if (mr->initialized)
>>>> +               return 0;
>>>>
>>>> -               if (err)
>>>> -                       return err;
>>>> -       }
>>>> +       if (iotlb)
>>>> +               err = create_user_mr(mvdev, iotlb);
>>>> +       else
>>>> +               err = create_dma_mr(mvdev, mr);
>>>>
>>>> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid) {
>>>> -               err = dup_iotlb(mvdev, iotlb);
>>>> -               if (err)
>>>> -                       goto out_err;
>>>> -       }
>>>> +       if (err)
>>>> +               return err;
>>>>
>>>>           mr->initialized = true;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>>>> +                               struct vhost_iotlb *iotlb, unsigned int asid)
>>>> +{
>>>> +       int err;
>>>> +
>>>> +       err = _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
>>>> +       if (err)
>>>> +               return err;
>>>> +
>>>> +       err = _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
>>>> +       if (err)
>>>> +               goto out_err;
>>>> +
>>>>           return 0;
>>>>
>>>>    out_err:
>>>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
>>>> -               if (iotlb)
>>>> -                       destroy_user_mr(mvdev, mr);
>>>> -               else
>>>> -                       destroy_dma_mr(mvdev, mr);
>>>> -       }
>>>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
>>>>
>>>>           return err;
>>>>    }
>>>> --
>>>> 2.41.0
>>>>
>>> _______________________________________________
>>> Virtualization mailing list
>>> Virtualization@lists.linux-foundation.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

