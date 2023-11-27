Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70137F9A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjK0Gxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjK0Gxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:53:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1927112F;
        Sun, 26 Nov 2023 22:53:50 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR6Z0kA018992;
        Mon, 27 Nov 2023 06:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=KJBWqADaPgQJGbwccjlNwADgN7GWLGjcbrlP6g01Jn0=;
 b=Pq41IBzrH/ZS0CJ538zoD3s+dVeUJ3Xz5PKFLfO0RpGLIIBUQjg//5/07KdgebPvIUE5
 pqVNWqJDgSLW3HBQm/bio2dRtCP/ZfS6Re0rpDKOqaZF/RBcaVCN11I0t9m0GMesKhVg
 OZXDqq6D1ov7px0Z0G+5EJi7QZsDpPfeiDEU7JIKAHDxeU6lmJQWx4oZSDt7BSYqQef7
 kGZ1UVL7WJamC+ofatg8DkE3M/7eAZt+Xu//HAkb5q/0fnfQ++AmDkEtW9creygev9W8
 rrap9WV/DLBwFu0rSLx3EdxvnOeZ3qb54xzJ30i66j2vDQPszIlqQIdGGuFQfj9fr7wS Zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7h2j7vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 06:53:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR6jaow027021;
        Mon, 27 Nov 2023 06:53:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cb3wjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 06:53:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qol8ypvTNUe7WQQp4A8q3BRepFwb2P/HR9UgMXv6OYOdle39HoiOHzKZ9jIfhPvf570hz5gsgz8DX1w7nFy6uNOxc9vQmzXPQjS3I+v+4q9oLOf50ATeIBBsJ+8VRGuzkSd9/gFauVCqUvAAT+xjdXNxcP0M/Kjg0owXeL8BRUviACTZjdm/gtEMwQNuJ+0tZs8aDDAsDGYCqvSPb1BYFvguO+e2Z5v9v3Kd1SBz6hxc89AWFxS8iZ5wVroBHLDBSQUm7A7vxfTolrTPfykCvNEIda92CcSCyLRdGHXokAQa6I9O1Hf5SoBJacqo2TfCHBQhiLSDgaSUm1fBzDJJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJBWqADaPgQJGbwccjlNwADgN7GWLGjcbrlP6g01Jn0=;
 b=nzOnXJZPCTC88EFMlt97BuZ2it36eg7Z6BvKfVuVJki5Va5RLHeqDqJJyQ9L5XXTJOyGv3S7Hvzxuo6vXwNtHn3qtmSxoPmpYhz+e6KrZrXaR6RNCC6uXsPo12IxoaKHrWb6BZDfGh4sYYnX5eIs9mkg0LV1GyDCZQC4MuQj3oVXEBmKkPs3eXH66tOm60ZrNfzjzsN0V2Njc1hktBuuIEGq9sMXHjbRyIoI1B+ykpwiC1jZTEToaChar5WPqsQcVNTRaSjslw/7tiDIJI/wiYhucRE9aXRH4eFAJiQrWNl8mCpHds46f07cH9l6dVxQoYNPQSW0gCqDI4ckp3nyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJBWqADaPgQJGbwccjlNwADgN7GWLGjcbrlP6g01Jn0=;
 b=Mgi4h7W4Ix9C54FbnRPH3rj+8UpdrVF4SVEj+16Iuvsw5oXNAg3LjXs/ZHVPvLLMU4qb/Aun95S1riHgDH1bmAcLAq12csW+7IJLRFv7TE7TWmKhqOVKYxjUCs5ipLy/1dUGhp3blGNOEzKmctkmbXT2O95XY7kbvCtlryutHkc=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by MW6PR10MB7551.namprd10.prod.outlook.com (2603:10b6:303:23d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 06:53:00 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 06:53:00 +0000
Message-ID: <7d780203-c862-469b-b3c8-d87cd0df34cc@oracle.com>
Date:   Mon, 27 Nov 2023 12:22:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/293] 5.15.140-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231125163129.530624368@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231125163129.530624368@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|MW6PR10MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd13326-5071-4514-061c-08dbef157330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bD8J4lmDMku8UDAIl6vY5hcYvz7ZQ1x44FOFuBWay26wIqKKLlfWpzqlC4bfNROiriOi7o1ckjKv54ILz8fiIAS+6ylAMWJC1gudMSWZtMVRAu+iag2QoE6VT1d1U78B5/yf2ZNb2F3VcTy5h8755bnT1hIAeiA26CgGfTr8C5kjM9yYn6j05C2+jEk6TOnHDTObJ6u+3+2kutvD83cg1/TjghaXC1RacLA430RuZIgudBpt+iXQAx+z8a4293pOxeaM+Zu2vlBA9N5FrhNzBENo8oZyc9hqgc58fDxiTaWP2T/tzyvjw4pw4x+p1THRxWQCllEWMvDJhomCpCrfKvUDZMGz8y1us+m2QYMJr3aWGWNW3dJUBkCskNvHGpylogumjDNmbu5f2P34xiR4yzIjbHR1OQA71nKz7gBlV9OJSIQ49a+8QcwHO4JmuS5ArRdDaK2ms8JpOOTboZMwo1za0hWu75u1/eGo2aytD9T6VWW8HajY9wSL5+e1EkOpikGqgfrqTe9y/V7RFYPrl2fX4Kr1+aHaNj/+ZJ8Jb0mqyZdtNopDa/9Io6wVya6eP8D0w7U/JyqhtwfghjqIF1D1qrp6h4sNoxW1dGoggmz1unfFc+32rtmD2ASi8fJh4x0F2EqzfwZZGUY5CgIppw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(31686004)(107886003)(2616005)(86362001)(8676002)(4326008)(8936002)(31696002)(38100700002)(6506007)(6512007)(53546011)(966005)(6486002)(478600001)(6666004)(66946007)(66476007)(66556008)(316002)(54906003)(4744005)(36756003)(41300700001)(2906002)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0pmRTJKcDFMWi8zZ2F3Rk0rL1VYRElWcWJ3a0c2Yy9LVDljbDN5Z3Q5SG9B?=
 =?utf-8?B?ZlJSR0JaL09aWllWMk1xeTNPY0c4c01BZ3JGMmZsdEZaQ2xPSE5zTlFkTXFY?=
 =?utf-8?B?dHNTemt5NEZDM0Y4cXAxVWpmd3VKMXk3cHRMdlhNd0Zmc0gxUGlnL3VYOEZv?=
 =?utf-8?B?eUk4Zndzd2xSZnJkcXNQV2pPbHdSb3NuMUtrOXhEWi84dW0yT1cwWWVjS0dl?=
 =?utf-8?B?RHFvd3NpS1gzS1BZejZnYWFtUWhQSjg1NE5GSmprRG5ybXI2NE5RRDd5ZnRm?=
 =?utf-8?B?L2Q3NmI0NlNBWDhrKzJqTUMxYmZINTJ3N2dXUCsrU1drMXJVYmNoeDJmWTVX?=
 =?utf-8?B?YTRvdW00TjVFY3p4c2R5aGY1ZmQ5YnBPTzRRQWhaaS95bUo3cWxveFpEbkVG?=
 =?utf-8?B?amZKMjVoUWxoTC9ad0lPM0tVMlBqaXlYWFFDclVyMit1d2p3RkJmcnJtb1ln?=
 =?utf-8?B?THhXOStHTERBYXYzV3VZMDNNbUdkMzd2aG82clRsek1HUmllcUVjeDE2NUxa?=
 =?utf-8?B?NWVNZllqRzQvSTJqVVZ0b2o0NWI1d3ovSWRzUDVnaExVL0lOTXF5elhVeGtK?=
 =?utf-8?B?Rmc3M3VJRllFRzRyU2Vsa2MyakplMlJDcGM1ZVJwclNGS3FCcXlySnJ5R3Vv?=
 =?utf-8?B?ZnI3V1pUVjRiNjJMQjQyUlVaNVlWSC9QS0psR2p6bkxBTGV6aUxKVnlXOUVX?=
 =?utf-8?B?dGxob1d6T0NlTmxFN29FNUlaN0FzUUp0WG9jYzBCV0d3S2gvZDlyTUZ2QTZW?=
 =?utf-8?B?UWJ4Smx2OVd1MDdJZThrZ2c1NjdKR0ZKaTlBRHd1THh2SnBpV1RycU84T0M2?=
 =?utf-8?B?OUZqSUozditSQ21OUWxHalVVNjRETmQ3N0JtdTM0QWxEY1IrQS93SmwzUEkw?=
 =?utf-8?B?cG82QXAwT3kwQUxlNWwrR1RMbWs0SFpRMEsxOE9NcTJnTldKbnVnKzdsN0Mz?=
 =?utf-8?B?TWY0SHREZkZlVG5kUzlyeU16bitDcGh4TW5ybHBJUjRBU0lmOEUrN3JNOTJs?=
 =?utf-8?B?VG5NVHNLNUJkdEtwNnE2TDRKbnpycHR0Ykw5RDhObjBkVzl4bS91OThpcmxx?=
 =?utf-8?B?RFdpZ2QzR1A1cHhEVXl3SG1LMXQyZHE1VGdobHVtdElLbEI4MlZGcjhTY1Vw?=
 =?utf-8?B?OFltSVBXa2F2SXFsNG1nQ0Q1eER5bFVXcDFSVVk4MDZ2V2duSjkyMmEzeWUw?=
 =?utf-8?B?bzNTMDFZMHRqQTlTaERBV01DTEVXTG9oTWxwMGVVdWVxL2tnSWhnS1diVTl6?=
 =?utf-8?B?d2hyZ0FoL2NvR1hLSHNsZy8zSVF1L3p5djlNZzdsbG02VjZMZEs1UklVRFRT?=
 =?utf-8?B?VHJ3YmVYV2JJRkMrV0Z6ZW5xQWRFSXA4Q3Ezc0hMYUg3RzJMTGtVU05qbzJW?=
 =?utf-8?B?akp4QzhPYml6cjNPUGlaQUl2K0gzUHlEMTMyb041c0VPWW5YZDkxWk5BTHJU?=
 =?utf-8?B?SWRmdm1JN1VOQzVqVGdobmZWMDFYWGhxYzJQcHpjWEVSTWdEMU5PbE1sYUJY?=
 =?utf-8?B?a042L1Z3SGVzUXpKbUNKZXd6TDBDT216UGZEY1pxSXZBOWZVTFNzRjlTU0V0?=
 =?utf-8?B?RllHTlJ0K1JNRTVmbjNnOGFwd1d1dzY4RDA3eFh3U1UyYkFxdUpBYzQ1blRU?=
 =?utf-8?B?b091U3ZydHUyZCt0QmlZSVhXNjJCNXAwb3FwSk5nSGk0SGtpZjUxTnROb3Bk?=
 =?utf-8?B?dzR4S3FSNkUyTUZyQXlhVlAxOXh2TXZxMkM2eUZYMDAwUm1FaForNlo4N21I?=
 =?utf-8?B?RVV2VnZrVm1LWTZpelZ0T2ViR21uVndLU0srWkhjZWJzZnArYVRCTFNmYk8z?=
 =?utf-8?B?aDR5YlJSUnlUQ0N3R3ZXcXdMUUlFaXZNQXVZSkFqQktRMDQ5dEpzbVFxeENN?=
 =?utf-8?B?MUlBQkJJZmhaZTY4bFJYb040NTUxU2paTkQwV3JCMHBaU1k4YWI5dTZJSC94?=
 =?utf-8?B?ZTRmc1dlYm5QYi9lek1Qcm9JZnlmc2VUMXgxcVdybGxtR0ZTa3JwejI2UFJs?=
 =?utf-8?B?ZnhSaEZMQnluYmdZQ0FvaHNwcEJMSldVTUZIK2lHRVZ3dUZadE12bGF2VzZN?=
 =?utf-8?B?MjhBUjA1Tk0xbHZwcXc2dDg2TmNIcVF2Q282c2kwTzhKMWUvTWhHWlJqTWJJ?=
 =?utf-8?B?UkJhYW1hM0RidFNQRXNSc2l3RWFDaWpuOHlUV1BFVGRuTFJ5VHhhWmpqbUZi?=
 =?utf-8?Q?u8hlGBRF9CYo5Yj2J7apous=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YytKNVZNK2EvcmxhRkdQZit2OUxYNkFtRngvVm9vcG9mOTRCTXhpZ2ZvLy9m?=
 =?utf-8?B?MG9RNGZJRnRGRmtzSXl4bnIxMGFTWDkwTUVZU2h1c0FycWxQTmwrY3V5M2pa?=
 =?utf-8?B?QXhrTGlRcklKMmtleXRLRXloVzhGLzBMbkcxQS9rMUlTazNFWENLdm5NdkQ3?=
 =?utf-8?B?bXg5SzRXVGJpWlJsQkh1dDg1U051SDdPeTk5amNYS1huWE9vSCtQYnM2L1BY?=
 =?utf-8?B?ck0zK0cwTmtxaWo2K3JpSlNKMjA4WEU3TDR4SVp0WGl3MzN5cjdGWnNNdnY5?=
 =?utf-8?B?VlFyYXlQWmFzY3YwTkR1WlpWbXcyL1h0QmR6SmVoL2JXaE1DYWs4eFMwbkxt?=
 =?utf-8?B?OGFCSytQQTFwWWs4SUR1Y1d6bVUxN0dIaHpyVGdjYkZHWHcvMzBNbitIMFg3?=
 =?utf-8?B?YW5vRlgyQ3VFZ1hLbTlWR01PU3ZWamJnZERqZFpkNzluM3pQTHlWRGh0eVcw?=
 =?utf-8?B?bVhwb2dqZEQyOS9IS21RZXBNc0xGWXM2bWkxbE5GOXRLVG9TL2luamRmYXRx?=
 =?utf-8?B?Z1N2NW1YT1JoV0VrbWZ5WnFPRjhNZlI4c0hjWjM1MDY4RmJpM2VtNVRzTVRG?=
 =?utf-8?B?WEtOaG5DRmF1YlBZYVM4K2dWK0VaSHlKTGllREU0QWRvdW5iQkw4dElnRW5V?=
 =?utf-8?B?dHR6S3NONkV4WS9jdDZlbG85Z3FtUUp4N3RxVzRYWGVzcWtoS1RKTGpvRmx2?=
 =?utf-8?B?WWhhMFg0WktuZmNPSE1FTkg5TWJMNHVxbEY5L3hiYVFIL1JuVFFtUXhTaU1B?=
 =?utf-8?B?d3NCWkl5bUliQzR1K2dCam80ZWJXK0IzN2dRSk5IMU5iV2RKdEdaU2grL29j?=
 =?utf-8?B?OGQ5L2o3UFRUckd1SXJHMHJ3U0drOUhSdk9tNVBsVDdXelpOQVR5SzhKejhL?=
 =?utf-8?B?WUs0WnVNZ0thMEQzVElCUVB4cklaY0ZMZ2tadnU4aGdlazVvMnJtaTd5Q2Rr?=
 =?utf-8?B?K0szRFBsRXI1SWN3QnY3cFZ3STJMdkdlZWJUTmhFZ3ByTmhDbWltTHlZanRw?=
 =?utf-8?B?NGFYVjl0SjcyQnhoNWl1RnhnUW16L1crZmhtcmMwemZFUTczT0tnU01Qb0gy?=
 =?utf-8?B?WDZLYjNPSnNlUjlRLzhyVTM4RlFzZlZyanA0UUg1ZElLMkxqYnlPTnRoMTl5?=
 =?utf-8?B?bkhBOTdEdFFwMDlmMFZlQkNTMzZrODVoS0JDQTg1L3A5WUpQeHc4NWVUZmE4?=
 =?utf-8?B?UVpkeWVaSmdQTnhTKzViMjNEdDFwSmtmTUtpQi8vcG1uaE5iSVNvSkRab3Ba?=
 =?utf-8?B?a01FSHZkNEhyRmxVd2hKL2ZoQkpNOFBEYmFqQ05jMFNoOFZ6dnRyTlRMbTY1?=
 =?utf-8?B?M0NVWnVuK2M2aDdiKy9LbzYxbjVkUExaS0xTQWpjMkFXVWExZ0RIN3NIWktE?=
 =?utf-8?B?ZlEvT09PUWMzV3pjM2FhUzVURitRcnQ2L0w1NUZuOHgxNVE4Z05OdkJpcm9S?=
 =?utf-8?B?SUZ6Q3VuQ3RqTjlyUVR3M0h6YzZpN01RRXlSc1kxNVo2bFl4M1pVZnUyNjhV?=
 =?utf-8?B?T2Q0ZS8vZmx4NFZxU3k1ZGhsdlNsWVBBSFlMcXJJeDlmaUc1V1VTTFFtMWMv?=
 =?utf-8?Q?x/Qnfvg6xBDTowKOQtdt2CNcpe3xvgk95DYPPIuO1XxlNR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd13326-5071-4514-061c-08dbef157330
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 06:52:41.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxAfTqryshmcIqrD29vw6l3cFY8eAYqUqA/Hot9tF7LHu2G7FpXdZ1oczaoOzqfbD26QkIj0IyzLalfpu5MUyXy2K788wnPBgnghmc3makjUERiraosbTF96vc47C6j0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_04,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270047
X-Proofpoint-GUID: VdiEE3sOjmBrCrU5sdmfQT_TV4J_84xT
X-Proofpoint-ORIG-GUID: VdiEE3sOjmBrCrU5sdmfQT_TV4J_84xT
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 25/11/23 10:03 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.140 release.
> There are 293 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
