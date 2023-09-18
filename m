Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD237A5441
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjIRUnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIRUnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:43:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF66B6;
        Mon, 18 Sep 2023 13:43:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IK4wMv015840;
        Mon, 18 Sep 2023 20:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=s4DAuwzhrSRqcw7vKdrwcdqdwi5R5/VkF+vca4tCp1A=;
 b=koVJSuoUd67XGBzInnGZV2DPjVmsVgdL19D3ZRRqLRhzDI4C5UWBHgziwOx3LeyF1jsf
 H23h/UTgcDkYRZ032TZ73gpLcZ5YHK+3c2P3/+/5w6mPcG3H8vAFC5DYtY13fxp5hnP4
 XwdafNW6gsB1yhd96skizQuY0V6GIagIRxhUA52WL4o/4bw48+Hqlaep8n2Zy+Y2rQ3R
 yVq5l7jKrF2hAsp5zHvzw0J4bccY9pNNEf9pWdgBbpyVwj6e7Y2X1PToXlva6W8R94K3
 pwgMpJtPdT2sXGn0WSkOYf+mUO/WqMrkecMVqe5ieVfccfKU+d6XStC8j2HqRl4o6nA3 Ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54wukdse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 20:42:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38IIlbnj015866;
        Mon, 18 Sep 2023 20:42:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t4h96t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 20:42:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnSrcNNEW2YP7cjCGsVKxdBqkhIGuTIvj0uJ520pZVwisiHZtPqwtDHaujdJ4Sf1d+QKaiTPFz78BVTEDw+amCN+9ioFHcVXGzqOTyGiqaeuzKf1gliI/atD/KQaksGakGm2zsvJcFn6KeDBTcPTLLIMZ1cgq8p71mbRrk7fm8belY1Ko31/WHxxLyq10t9vFcyRQ5oJB4j964iHBSFgLPofVFflL/JsHwENsX88/LotgCVLemqXHDSgsZjzSoJYvyaR4LgtCHkaEDdgrmKaYzkKDTZh7MbgA5lA9O1SbNZpQk+m4FCLpue8BgCpsCrIcnUCvyyQ74Ljj9K6WUz5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4DAuwzhrSRqcw7vKdrwcdqdwi5R5/VkF+vca4tCp1A=;
 b=MzAF6ovqedwtzYV+9tOuxetjfZvKY82hRTTSaGc3p6N93idhh7sbJm4275NHN4ECHaOm+5Zvtn5iQ8++o7WIZtwVEqedkuiwJAsN2PONzRbpw9hSjIYlZTuVmIrmVmhkdLBUQdEPGbFwKgTLt8tw9Si0Jczji3gPBCzxvVbr5b80sEQL6IrTEwfY1e9elqPf4pc6Qy7RMRr8pHLYgaqqvnkw6DSs4ZdT3pAdIp+Ik/RSPkN/sIM0od0ZEncMVF/FCSgb6G5UL/8PbtIdy/WB3KdvD92lZWEaXZttZ25HhituacvCZcJn9L0T0MjV1U1Luna6Faq02X4YhhbOheFSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4DAuwzhrSRqcw7vKdrwcdqdwi5R5/VkF+vca4tCp1A=;
 b=yyT9b+XFzHiM2M6O2IPEAcrmViQYvquRk5tpkMMu7o2BCkgwn6SC1fYwuwe2lgtBda6rPc5fIayEyxidEdBfOMwXERk2VmpPCMO0161PcxVx868lZhH0DJ5HMo/h8tYJK7nus0UGifZWqeaBeE1zEgMR0f6d8A5UuFsb+QC1s5s=
Received: from SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14)
 by SJ0PR10MB6351.namprd10.prod.outlook.com (2603:10b6:a03:479::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 20:42:23 +0000
Received: from SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::d7f3:3706:c034:bcbe]) by SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::d7f3:3706:c034:bcbe%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 20:42:22 +0000
Message-ID: <e7ca0354-a731-27c7-08cb-b91abb5275d4@oracle.com>
Date:   Tue, 19 Sep 2023 02:12:06 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 000/511] 5.15.132-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20230917191113.831992765@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To SN7PR10MB6287.namprd10.prod.outlook.com
 (2603:10b6:806:26d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR10MB6287:EE_|SJ0PR10MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 90457ef3-1cc6-46c9-1539-08dbb887c21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWsJS6Rk3I0y//g+q0gLQSMIZTxMVZSj7OWnyujvLJ0n0HMe6DvXX76ABd0tVf7PvlsD+0/8jdOn4MUOrPJpGQr9pvUFWdgdflP04oiHa6y6Jo/uQS1FqeYuBgRpfgeqK5+FZ0hKtRLOlQjhwtWks0/iI4O4DbU4brBujOoRV6qZJO5ph7UWI/MrTxjlgNHTW3pXOvG8vP1Hb0++uXt4hIb/F6EJcD4ZhIsOb5kkVHyMPhO1DlUMHsmk1Gv9tgbN5/02p6Lm6HpxmTTS+KAlZlMjWMw8cO+7zvpykqC8nkw9WBKUsdYMPiiGRtz7zfbtQubQIPsjlV4dLv389LJATGCjup+ALpLRQxsOEHh9jk1RV11TGQbmrr9YG8kQJBJOgmFcCBJsDr9nrkEUJ1dO2AZugsATIVTzl0urku0KFAz4bNgy+Ym3oz/Zb/dr/HbvZK7ooJA698wrp/CnT9btJ3esN3czy+F6OLNrYaVsauxGjUOm1NKcHEQzXsOScPdUlX4TlnSBQToUjPClB3HMBca7UO95IixjJOHdZGcAHTAS6+YWLr2ElbswbCiCcbkSdOrqHZ6MYwsBXljO9Cgctddx+a0995yuVWX5MqmJ/ZTNX3SY6TAIN7p9YUDc2ZL00TXaDP5a3il9Dm0mC0vjXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR10MB6287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(186009)(1800799009)(451199024)(26005)(2616005)(8936002)(8676002)(4326008)(107886003)(7416002)(2906002)(36756003)(4744005)(31696002)(5660300002)(86362001)(53546011)(6506007)(6486002)(966005)(31686004)(478600001)(6666004)(316002)(54906003)(6512007)(66946007)(66476007)(41300700001)(66556008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1lmWFA1Z2g4WGJLSTNvR3dXZkVtMlY1SkhTUURpVCtlTW9maUhIUEhiNDlp?=
 =?utf-8?B?R0t1ZURYZzRxZ3pxNk91R0xuWjZ4dWNjVDJwVWFaWFRGN0VGT25KS2NBc3dO?=
 =?utf-8?B?Y2FDSzJiWk5kNENEeWNmeEN0TWxnL1R5OTFrNDQyWVBXdW1FL0Y0OExjaWo4?=
 =?utf-8?B?YVRBUzljS0FUbDhlSFZmbnI3V291U1RYbllQd1E2c2ZoRnNrcG9rQitGb3Fp?=
 =?utf-8?B?QVc0M05GOWtYTEhZeFRRQ2xzMVpIQTVpcGd5OG5Oam1ud2JHeE4xYkxrdjUz?=
 =?utf-8?B?Y2xLYlVQUmF0NDRZYUxNYjJObnFIODRUd2sxczlRcU1DL3U1Ymx6OTNlNDRk?=
 =?utf-8?B?TzBHV0hKVlhTMkVqSUtpcFVYREdpQWtJWUcxd2VKMnhyWk9qczBTQzdBc1Zp?=
 =?utf-8?B?Nk1KWloyZTZObHNERHNkaDFCUEY3Umpwak9kTkpQNmZhOVFzVkxHNHk2TFdS?=
 =?utf-8?B?bHROVEtvT2RicE54clVuTjliOTc1UXRQelZlT01GdlJiaCtRUUdMMDdyczJo?=
 =?utf-8?B?djVnNFhUOURiVEdqN0RJbmJWUHRDSnIyODk3aXV1YVppUEJ6cGI4dmVYZEto?=
 =?utf-8?B?QkUzQVZhNTJFNnFjRHhCRFlSTXFmZkhQL3JjVGZxMlE3YVZXYi9kTEJ6Wkp2?=
 =?utf-8?B?dVdCQ3d5cjE0MmlGMUhkeklORU5Veml4bzNVVzhxMHNkam9xOVVhaEVISG1k?=
 =?utf-8?B?TDB2RTNvV3dxbkRhaG9VQnB4eVBFVUNXV2kvZmlwbWg0d3dwTytVbEtBVmh0?=
 =?utf-8?B?SzdGZ1plN3Z2UCtyWWhHL0N6d01yaGU4bm9ZM0psSXlOWkQ1czFxV1RBNXJ4?=
 =?utf-8?B?K3FUdUtiMUdDbmRYWWlsbGNzYk5DWWpjck5NTTl2eW5MTUFDSDhjM1VuYjZQ?=
 =?utf-8?B?Uk8yNTBZRGRvVnBVMkZ3anExS0xOaXM5cVBEYXhBTHdGampRU0cycFNXWWxv?=
 =?utf-8?B?S1V4S2o3NjQwY1dzNXpINkhnYWo5Uk5JUitwSHc5VU83eTlBNS9NRS9MWXFM?=
 =?utf-8?B?YWpzZDBZVktKeFVCZTZnODJWa0tybjhNeHh0ZHFJSXV1NlJlNWhXR0VrYTlU?=
 =?utf-8?B?c0NuQzBMWlV3RENVMm8vVzFFZ3V5bXBMZEJpVHJqWFdPUUszRjZsRnFkdUFs?=
 =?utf-8?B?cGhyTFJiZG5oZjBseHlGSnYzbG91eUxRNlhvMjc2SFluZnhCL3c5Vnp0c3Rl?=
 =?utf-8?B?dTZ0N3RqeHZzRS9tTFFKRDlrWWRaanFMNVVtNytoMElTRkpheVh2WXpnODky?=
 =?utf-8?B?aVB2MEhUOUtxMFN1RXRvYUtCWHZNWW1SY2cwUnIvWTgzYWFuY0p1dkc3UlMw?=
 =?utf-8?B?VmtZalQ4SEJMV2lrZmpQYi9nL3E4NFcwaVpwZ1dCSGhDbmVMMjI1OUpUUVZW?=
 =?utf-8?B?UFpqaGRteVR3UmNadkNFZTNwOSsydTkvbUd6N3Nwd0VSeUlKTGllZVF0cFJW?=
 =?utf-8?B?azc0cVRNWnRWenBzK3dqNGZRblFRdEdtcnVJWG5aVjJOYlkzaWo1SHhueHhK?=
 =?utf-8?B?SEtYYUxZNDMxTFptYVFocFMya2xHSng2MkVhR0pjdkJyb0FHcWpjYmxwVHVH?=
 =?utf-8?B?elBXb0JCSHF1eE1iVFVWZk4vWHJKa2J3bFRvcGxJUnREZUJrTDVRMHhaSFd5?=
 =?utf-8?B?dElkeVE3VW1YbTAxa3FIWHpmTHY4K0JoT3pKMGd2SkpPWTE5YzZKb0hHcmtq?=
 =?utf-8?B?V0NUYk51eGlOL1hxd3ZlamRGNGwxT1JEVWt6K21iSmRWc2ZuTFh2UGgyaGNM?=
 =?utf-8?B?OThUeDZaMlJwYmc5dUlBb2l4Q2V4YTFyZGhpaGo4NTdIclVrc3NxSHlsMER2?=
 =?utf-8?B?ZmkzMjNqRlFyUTR6bHkxVzBRN1Y0UCsveE5vWHVpVUZlMzN0UkE1bXNZWTlT?=
 =?utf-8?B?SlczS1FwSmxJSm5oMzdHUlk0M0o4RzJzaEE0VCtlL0loTk9tanM5SVdiZGZ6?=
 =?utf-8?B?T1pSdmtNMjUyRHVic0Y3dXpmNlpFQnp5WjhBQUFyUit5VWJnVGRYb3FuRFhM?=
 =?utf-8?B?S29RaFJoS3VTa29hbjMzcjdxUmExQXNOVm5kL05RbmNONVN3eXRlOGpMZUZX?=
 =?utf-8?B?Ymw4V3pnTXhHQWlic1J6R3JYWWtEMitBb1J5ZnVaaFdxMkVKbnpxc1AzbnIx?=
 =?utf-8?B?WEhNdGZ0R3dYZjIvdmZDTlpLVFV6L3BQNXVwdURaaEl3dW81RHozdjlxcGxG?=
 =?utf-8?Q?h7ToNA8UiXhqBVdvj5bOFMk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bFJuR0czQ3RTWDBTMEtCVVNycytGYnhGdXo1UVRjdjl4YnJyVGd4UkVsK0Rw?=
 =?utf-8?B?TjNUZG9QTTdYVTFwcDdodzV2bnZ2M1k1eXFYVXZrYWhFQ0JHVVpDYnhJN3cx?=
 =?utf-8?B?N2dPWFhBdzZ2WHpuV1RPUWJ3aElKdnB3QXAzemV5SG1QNURzVXpjbVQyRWVv?=
 =?utf-8?B?Zjh2RVR5dFlwTTMvWThzVFg2aGNodXdpUzdtRzhnN0xsSUdBeDdyUis2MGp1?=
 =?utf-8?B?dS8yd0ZsK3ZMa1lJVWpCTjh5T1htek1SZVNabWZONEhpcWt4QStvN01JTmJR?=
 =?utf-8?B?Mmg1WmJYZEpoUVQwWjlBdFFZdEdNOFE4dHFoYWVVWFpzcEJERVo1NmFjUU1p?=
 =?utf-8?B?NmE2QzZsWVRWNmdGZytySEdZZnM1VysvTW1XWk1MTmdvVFNGbU9ML2liTmlF?=
 =?utf-8?B?eFlKQmFrVWNoUGNtWDdTWFhQOTVQbEp3dVdydE55QWNuM0hjZk8zcWUrM3Bn?=
 =?utf-8?B?VkV0V2dCbmsxeXY2NTUzbVdKSU5IdkxMeWR4QkFWNG1hRVBBZmphQndIUXRi?=
 =?utf-8?B?RysvZkx2bitkY1h6UjNPcDF1OG1Vb1plYjFVcDZ3NHJZZWRiZ0hqT3ZzbVBK?=
 =?utf-8?B?WjJESEw0dUhDdnFwQitsaWFVMmdYU3B6bmVsS21sb25WNG5BY3FWcUZIay80?=
 =?utf-8?B?dEFaNGcxMnpUVjdDb0h2bzNsdmo3aGxXNEFyYUNQUHhrZ1RHMVo5L2hZTnI0?=
 =?utf-8?B?WkpWYytSSjhMTjh0ajZ2Ym9aNDJmQWswVDczQ2JMUVVGRlRVV2IwSlBWSnBh?=
 =?utf-8?B?b1N0Rjc1aWJpRGdyazViWlRzcCtHRElmN1FJTDJrUHg0ekU3MVQxWkVaT1NF?=
 =?utf-8?B?YXJvaWZsOFk1aEpudDlrNzRvYTd5bk80NDRGQnlOeUtqQU9DRzNvOTQrblpT?=
 =?utf-8?B?RTI1SklQMVRsNVp5bEZhc3FDSUhKVGNQU1VLdFJmdm5nMTgxS001akMzQ2xV?=
 =?utf-8?B?WGpGUThiZ2JPb2tqWWN5N3FZYjJjUlNvcVJEYTFFbUlJTmxRZ0YwVXdmT1NF?=
 =?utf-8?B?YnYxQlRXbitIR08yNmtSM3JPcjQzTWlSOUM4R2Z5ZGlBVHZJK2dsZVgzQklV?=
 =?utf-8?B?NEFKUUdJTHhocXpRN3hTUVd1SE5jc0xZWnBTdUtuWWpveEVaMFpVSXhuaXlO?=
 =?utf-8?B?SzhSdTB3cXRzNkhDM0NkN2ltYWdSckZCZ1hKaFpuTVVKeHVBbnVhUG9tN3VY?=
 =?utf-8?B?SUdLNEtkQ3k5eXhwV2I0Q0dzL0lmbUpuUFN4bUNHcWs3bSsxMXpzWVI0S2lS?=
 =?utf-8?B?TnRlZXJiTWNYWVpNbUx1TnozSmtlVGpOaGdDakNjcThXMjduNjloQldnVzBa?=
 =?utf-8?B?VWxsR2syRjNQcCtrVFdpTm9EZncyVUprb2JoUkY0UEEzUkFXWUhYM3R0SEFj?=
 =?utf-8?B?MWlCVFFWczkyc0dZUU5FT3J2enFuaUFLcVlZUUJuWWhJeXcwTFp3TVMyUmZr?=
 =?utf-8?B?QVNVVld3MUMwUmRiOE8xQ2orZ2dteW9qaENwQVFZSm9ycHlYVmM5QjVWYVpH?=
 =?utf-8?B?NGliN2pYdk5qZDhrT0FCbG9PNnRENTM0dWZPZ1pqOEtEa2lnbTZZd1I0di9p?=
 =?utf-8?Q?dT7lFE9I9H5j3UOfcsdAtrL62sYsdldZOotMlyvUShgLEr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90457ef3-1cc6-46c9-1539-08dbb887c21c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR10MB6287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 20:42:22.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grRziTRWP5V1SvskrOdtSqe/gnxq7YwjWp+CQLeNQJ0XARl8iEtrpIoBNUiq9t3xWmHLh0MDs29Fd/de1oMIufA7QfoFFI6yhYgg/l4FIpm/zlWrq8FIMeFDWHld91zh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_09,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=975
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180180
X-Proofpoint-GUID: yDRB9x_4viEIw9UQl-e3BewkCg-phxVs
X-Proofpoint-ORIG-GUID: yDRB9x_4viEIw9UQl-e3BewkCg-phxVs
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 18/09/23 12:37 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.132 release.
> There are 511 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.132-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
