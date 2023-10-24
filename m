Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633417D5BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbjJXTqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXTqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:46:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF7F111;
        Tue, 24 Oct 2023 12:46:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OJi7xZ001542;
        Tue, 24 Oct 2023 19:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bupNOOTAiMkp7CKkrc1OCy6cSQSVbGIy9nxSWlek1eM=;
 b=kydKGeTRqiwaOVys1rTWPXPkaFRBLC3VD8cHdH92ZsSSmY7z4mBNJQbT+tn5TTuGTD3I
 ZoieZu/xaEPngUqlObvwfb/EXg+yMBv1vc+aPsPgfgebCoQcxmIhbY7/zdb/pbFtB2oC
 nk12/Nei8gMFc13aSD+sbOIewaIsA4W90wsYfC/KipfrsEDJEzXO2WIaQKkrovSuyzIk
 oyeQS+Ww7kGsMtMKh7P4bHyGqbKQqZTxt7xPf+irzHwJCBQWoWMbRh6cklioE12rxI0j
 Umdin/8OSeHskcW/YqiqUX7uC0aofTSOAkzrcVTAAYf1KYNy7xvkazK69Cp9wU83E8dg 1g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6hap7xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 19:45:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OIKSIv015046;
        Tue, 24 Oct 2023 19:45:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv535qjuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 19:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu+kxwclCBWRDNBiabYJ9DhB9ip33dHQI0+g4dZsyVlnN+jWKvCw+snavtsyb0OSWSPH6zxZehl4/6INTk3z7noOsrLRb9N7nsmM3s5wlBCG3YJmraQmsBhWHx9Y5uZBwLr6KWUrElQbH8XniJxTtuDzwPS2rwFBD/jHyrN2BR0uVcEb6rGRearBLQJRn3diKG5xxEXG29Wu7rSeBPp8+9h3ct58cFZUXag0RjB8GWfe0ByJp/KbdLae5ViUdzi1UFflQc+59U8NFiHRgpUqyJI34PeYykOhRft6xAVWIygj1YxqfBqKhZZJvZ/XJl9n9hvZZIdNrKaj6wgbmn1dEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bupNOOTAiMkp7CKkrc1OCy6cSQSVbGIy9nxSWlek1eM=;
 b=OhfSEpv/1Mv8tZWwdOO6SMtd6VlZOcOGS7Z/6MmXyZ73R2BT+BrGRzMPSZgjs4YtPmLXsrt6errUlIvNaeLgttCL0kxhPgzMXEGVCAnuyInh1rL93iD3VIqZ1Mf+1GVdHucl68hIl25NMUcz3dUyPkxXGC2SisGUMcDV1cqiK+ocHiCT1EfHmohPGsWMJqoH7ecKEOe8i3pye+ezT8MCCQh3VAjQ+KsofzxbeQhj6FAcIzpBWQVuRdTroBx4c4xn5tIxsE9xIZtJCPwQ2Tll/3RdKM0pKYdTFrJlCWsFE0wUi8hiSxyfhw0dYWq5+ZMc6TIKyNE1ppVDA6NcZUu8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bupNOOTAiMkp7CKkrc1OCy6cSQSVbGIy9nxSWlek1eM=;
 b=GvLAUy9/t58dh80bkbERrqv52SbInaOHwNLSFNcoMee8zUvKLU40+2V+R0lgcYWVOPL2l2cS36GZcK4rylrIUDPPTEocXW85eCYc7SQU/uZhxGlDJ3tm96/6U91OLS3TU1Luo0srRROR/OMxw109CFUmAE/5SbwV8TWQ0fIRH4s=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CH0PR10MB7440.namprd10.prod.outlook.com (2603:10b6:610:18c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Tue, 24 Oct
 2023 19:45:31 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 19:45:30 +0000
Message-ID: <a06fb68d-9627-4fa9-ab44-f563114e0933@oracle.com>
Date:   Wed, 25 Oct 2023 01:15:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/65] 4.14.328-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20231024083251.452724764@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231024083251.452724764@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CH0PR10MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2f4d7b-5645-42c5-7072-08dbd4c9c792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLdXKGfQuouwNaMAUUgJc92MO9JQwf6fvGgf9JQUVuEfFom8N6pRoGHLYOkOhWI/TkzuOLW5asej7D5TfOB9sdSDuFJvtm/0jrr7RWW0PqjoINw//7hklWMemSldViRrMlb5/eT849rUk0CoNLBEZAe90By370CbqkCRHLgY10Z/Qe3AOdoWkiynMTTvyLXscMiskfaaawP7BVY/guB54StJKLOV+chQ7SmlHz8iR24/+tkaWXFvhXZGOjQAbbxSDiDLCHg9exEgEVRvRyzNv0FY40Wwp4xYQcKp9Bw4nyTVdQ4XfXeuGwHJsdHXssUqU6Z7PeHIUOm7tyVX/wdsgFhQ9w+tBPLMdIubBX6K4BJ3K9U+ySBmzVUM5OtiwD8TuXqXJYWHZz4UaxYJvyIG0w96l+6zJa9RCSJ8gkZx+VQ3hnAD5ANyMMGd3huTLSzoWZR0k0il4iNtrVrwRaUqbpl0VZnrqPOnjJkCFBt4E/bZDqEL4cheoNaAacr9XTtYYDOW0vY72z/PJ/n6NcEnSiJpw8Li8hA2tsm1/1QPmP0jwODqA0qFuPIFqBbtoxqhw+KQCOOl4q5yjZB9P8GTIGQ1Q3AfbgMxq1L/0QFv17ksMNXvkj3I/QTLBeu1wJYPUGdSHQtwMOANlKRN8CJnVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(66556008)(6506007)(2616005)(66476007)(66946007)(53546011)(38100700002)(6666004)(316002)(5660300002)(8676002)(8936002)(6486002)(31696002)(4326008)(107886003)(7416002)(2906002)(86362001)(966005)(41300700001)(478600001)(31686004)(6512007)(4744005)(36756003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU14MnZXNUZWdTMyMmlSMHdNZDVQTDAzYytLeHJHYnlIR09QWEZMTWtsSWlh?=
 =?utf-8?B?SXArRC9uTFZuUlhmNGVhTVl3VERJS2QxQS9jaXg5VHFSbHBtcWhxOVJEeUgw?=
 =?utf-8?B?Vkx3RG9Hcit4SElXeXBNaytQci9CR0NmL1BacmlQSVc4K0RkbnJ4UjZSWmZ5?=
 =?utf-8?B?Zy8xVTVmREVCQjlwSXpKQ1RpMFV5UWdDdDZrL0VkWW9uZU1NTWhJZmtJcjBn?=
 =?utf-8?B?Q05LT2RHUlducnNqZFRYNGRGNlY3ZHlmbVBkMmtSZmwvcGcwSm8xYlgwWGRa?=
 =?utf-8?B?YXhIVHRPMSs4RXl1Z0MwSnEvQ05BYXcrVTMrR21qUVNKSDdCQ3BlSEZVemJH?=
 =?utf-8?B?SVBpS21vaWQ0QXRIN0RVa1k2aENrZkZ6UW01VlhhWWpobUN4VUhwV2lvQzJB?=
 =?utf-8?B?YUMrY0VnM3phUnFJeVF0ZkVQa1BBMVVtWHlVNkpuZk5oUkowYjJETEFpY3FG?=
 =?utf-8?B?Y2M1ZDRRYjY4WXorS3F5Ym8zT05SV0dadmlFNnA5VWQ3cHJrdzIyQUhwSTBt?=
 =?utf-8?B?aCtUaW5lUjAveEtITXFYZnNLYkdWcWdpSHBZTEh4bzBDOXZ3NnY5QWk0eVNa?=
 =?utf-8?B?a1dscWZhaGV0dE02YmdJc1lPb3hRWXNaM0dJMWczV2NGcU41M1piU0QzZ3lq?=
 =?utf-8?B?cjlnU3NvY213TWtneDlJSEorRUxKdmFjUXlGenMyN0ZPVjNDRldqZzFpdGls?=
 =?utf-8?B?RGttNVo1ZkhreUYrSzNINTNmWW8zRStBb2hTZG1wRmJSTkxxaUY4eVArUFdp?=
 =?utf-8?B?cE9aVkV6OUkyak5ORkw4UWJLNlhEUHJSWmxQUUk1eHAxUk1GWXgzZXBjNkl0?=
 =?utf-8?B?REJJcmdSUzVJYzlXeWxJeTJBQm5VQ2Jnb1RDcU5OU2srd3pOL0h4OExrS3RF?=
 =?utf-8?B?TU91SEJPNjVZK3pCRm4wVzVuOXFBY01sUmpHSDNMS0lRQUZjREZQY1VVMG0x?=
 =?utf-8?B?MkVESHlWdlBvbUl3eWJZR08vbDBBaFZhWHljcmVoaGpYUXlHYi84azhCdzRL?=
 =?utf-8?B?Ylg0TEpuNFYyaXBpMzcvclRqQ1dveGh2K2MrTVRwMWR3MWEwemFSY2hnSVZu?=
 =?utf-8?B?QTd6SFBSODdQbHVOVkZCU0grTDYrMGJVZ0pGaDQvMXUwNmxWQ0d2N09rREkz?=
 =?utf-8?B?SUEzWlJZSzFQelJyU2plNGlwMHFCcjc3a3dmMjZMbDEyM3IxMFFaNTZEUjAr?=
 =?utf-8?B?QnJRMnBYVzcybVFFL2lQSXR5WG1MNUpkSmRlMWFpbTczMit2VXFtRk1UVE8y?=
 =?utf-8?B?dy9zRmZaZVEzYW9ybGdidnRURDJrZEU3cFptMVBPYjk2QW0rVHB5VTJEbFZ3?=
 =?utf-8?B?K1d0VFlJK0tTTGZhY0Q0RFVLL0tlZENMWGdSenlRU1g4V1F6K0k3RXZRWlM3?=
 =?utf-8?B?RnQ0YTVGWndraDY2NVRndXlZNjVmcnBIN1R3SVpscFN3ZVJ6aFJNQWt1RW1h?=
 =?utf-8?B?eUFSVTI0ZGUrZGNES0tscnlqcnBhRjBLOThFUzZITzV2ZitleTl2TGlFa2dM?=
 =?utf-8?B?UGR2Mis0MGd2VG9pT2JGL3B5MjM1ZDVHM3U0TjA1RzA0TUs1bHBzb0N3MlVL?=
 =?utf-8?B?UGJ4K3g3OFJ6czJSU2FXSzlsYjVLS2VmWEhuaVEwbW9QUzhrM2x5TkZQUE8z?=
 =?utf-8?B?dW1iOExkRVE0Y3krRUJSa3RkVi8wSVoza0N4VzhkQjk0RXFaK3FYNkR1ZXdE?=
 =?utf-8?B?MVpoVG9HYzIwMmFzdS9rOG80Tlk0a3NwZHZPNGsyRFJhZ2ZVSzFKVWp5ODFq?=
 =?utf-8?B?eXpVWW02SUtTcjFiM3lTeUZJTHUvWFJQS2VpZHYvdms0eHBNcVJVU2l1ZEM2?=
 =?utf-8?B?ZGQ3dElQZDJJUWFQN2lrWDVHM0JWaFpGa0kvTWwwb0EwaTY1UStZQjFPY09z?=
 =?utf-8?B?THI2WDlwNHlFN1QzYmp3SHFPNUdHSTJwM1ZXbWhiMDRQQWNyUVlnVXpFWUJQ?=
 =?utf-8?B?dytWNnNoVHJGUlhGOGR3RW11WjV6cVJZV2lHOGxSdEtJSU1XSThDdzhVbEs5?=
 =?utf-8?B?WUVFQlFLdjUrdDZXRVpuczg5QVVWRlRXNEVsc2tkU3d1ODMxQlROV21wekRC?=
 =?utf-8?B?Ni8zdzRCSkRES3Z4QmpjQ2FyTDhBZXNBWHp3YmVNdG9vME9KOUxmRlArN1py?=
 =?utf-8?B?eWM4S0pMTnJDOTgvRzBjdVc1VTJGNUVJaDBMS1NDdXIvQnNqek9vdVIvdndW?=
 =?utf-8?Q?wRrJbB0ArulI2hSfUS5NVYw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YTdkOG5NYVNkaWx5dUViTStpZ0doK2duNlF1S1NNWTZFSzAxMnhQeS9rT2JY?=
 =?utf-8?B?SGlZL1RaUkt4UFErQ0xxdHpCa3V2Z3o4VDArM3hvYm94WEt2Vk9vOEJQYnhz?=
 =?utf-8?B?VVRKZFBJWi9aWkRaOFU1UVRtalVmMDVTTlA4Y01hS3MvMWdzcWk4d1MzUCt4?=
 =?utf-8?B?YWZnQXRoNk5QNklkalloZ2R0OGdyMzhibmpkTWx0cnVsV2wzdWFwNEdlczBC?=
 =?utf-8?B?cXNaYkZqNjd0R0RFQlFXRlhyTk52UGRQODZWQnZCWmRxYlZMNDVGa05nOU85?=
 =?utf-8?B?eVhnc2YzUEYxdjgyU0FwdlBQSzN2Sldqa2FZdy85MlhhUWg1ZktHN1ArZ2x5?=
 =?utf-8?B?LzhoQUlYTVNTem1kUGlUUVQ1RUhEZ0lYSStPNDVXNXliRUp6M0gxQmlPYi83?=
 =?utf-8?B?L3RTQ2x3Umo0em1WR2JzUHNHeG5VWUZuejhkbE8rd2g5WTM5L0hZbUtYVkZ0?=
 =?utf-8?B?eTdZbWdZZW52RzBodm1NU0FNNkpIbHZvVzVmRE9Pbk4wWVdlNVVoajJWTWx0?=
 =?utf-8?B?b0FGZXprZmVVdGxkMGNLaE1FcmI5ekI2cUUzbVRRUlF1OWhPYTc1a1dhQmsx?=
 =?utf-8?B?QzFPcy9OZEM0bWRwSE1Ddjh0ZjJaUnRTbUlubmpPeEFhT3BQR1V0VDFXZXVj?=
 =?utf-8?B?cU4zNHNKTGNScHI4MHp1M1ROMVFjUkxDSnNkK3E5YUN2WmpQT0VZbGdPYmhG?=
 =?utf-8?B?RzV4MkgwUG5rc3RzNFpIc1YyQlVSQkVQNUtDWmxaK1k2YXFBOTU2eHVMSi85?=
 =?utf-8?B?dnZBVHE0UFhYSTV4c1NLaURUek5JckdrS2VYeXVHYnVoNUF5VkJ6VVAwUVVY?=
 =?utf-8?B?UWh5MVRwWXNlQ1E2cWRsa2FlRUdaMno1ZmRNZjRTQjA2TS9lL1pMaXRUYi9i?=
 =?utf-8?B?RVd4WGpiNW5rNlh5MWp4RUFianVGQzV6TXRMS01BbnpKWGZuMUxyUFBZc25J?=
 =?utf-8?B?UUo2cFhKTUw2eHVDUExjWGVhSVRpTWZRUTN1QWxSaDkxTXdpdmhiSjRCVVpy?=
 =?utf-8?B?RlA2WlJFbVYrVUU4M2xwTW5ybndLaitoZXZnTmVxRTR2c1RHczZOVzRYejNn?=
 =?utf-8?B?M01FTE1nWTEzOFVLTnFjUFhWSFZxMmNjbHlMNmN3Ym50dmVSQU1YeSsxQ1hs?=
 =?utf-8?B?QllST0hGWDd3eEg3TlEzMGE3dURiZUM4YkkxNkRBRjYvM0RsMUxiQUNsTXly?=
 =?utf-8?B?V2NUdno2cklMbWl2VlFOSTU5UHhsMjc5ZEVLOVhsODV1T0ZNK3ZtZ1AxMVo3?=
 =?utf-8?B?UDZQZFh0Q0dOT3NQK2t4Um5MNktTL0Y5dzV1Q1FqK29yMlI4aTh2V3NwTU1X?=
 =?utf-8?B?SVpabllhL0I2MzB4T1RmVEd3ajNmVE1yRHpKbzRNT2xoS0h2ZWlsalR3ME05?=
 =?utf-8?B?OUxLejNBU3Z0TXJlUnlZN2pwZHhLL1h2ZTVpKzlKZHhkWnBrcnI1TzNIMlpB?=
 =?utf-8?B?T1VIYk1LSU5qclRqV243QzVqSHUxVjg1MFBLU3Q3UGx6Y3NmcnVKQVlRNTd0?=
 =?utf-8?B?ZFM0bm5aSXFJZDFzcFVqcThWT21NTmVHNUVYVWUyeFliS1JIYjFJcTFZcGFu?=
 =?utf-8?Q?/cQQtU5e9wR7+KM9f0zmixsAfNFBTc9VIdFNZMhVTz1Rwf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2f4d7b-5645-42c5-7072-08dbd4c9c792
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 19:45:30.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0e0C6eu1rd9bYZBg9AQt1JXlUFmsg0FyTAHhrX3SzFuhHhyxWorqzFjZgWCB5VNomRI1rQLIzn/Se0hERkqKIgP5ruDob3Gh4GNhKB3urFBgaFRg8NXDlzfZSJom68D6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_19,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=984
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240169
X-Proofpoint-GUID: JckEIp06Ig0sDeIYWiZ64SiX7eLlRxPU
X-Proofpoint-ORIG-GUID: JckEIp06Ig0sDeIYWiZ64SiX7eLlRxPU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 24/10/23 2:06 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.328 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:31 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.328-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

