Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8775478C514
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbjH2NWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjH2NWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:22:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3D2194;
        Tue, 29 Aug 2023 06:21:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TCCBSF002656;
        Tue, 29 Aug 2023 13:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VydZEEfkOK49tGqj7lNuZrl6Z1dVQOswU1f627zZdL0=;
 b=uhUAu5CYn2FeECiEwoTKFnq6tiGXPqI6lSfkmrL97TGKdXHdds4sn3OPSEU1Tjdy0JSQ
 N0yejNN/zjNCmuq++IP4/8z0lgJ9C+5PsvywE45tg6Z6pXblg741ueP6HnN7BKzjkvXj
 lsM3/QcAtXjN1RLyq4yC5vrzc8gOJ2IzCiA4yhE6JMsp5tYqgFtW2cvnXzpCBn/JCfDQ
 xs6uqctd4hP57gT6yAUJongDJSSTkQV7FR6XUVQzq5wh2iFUCGT9vOjnUwP9EwuAEa04
 OxGoeIYI1Oo42VqE78Ag5176hwQxrr5oXw1Mlg06uYlZFqNM49+5vT7vLslx167236V5 vA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9xt4yxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 13:21:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37TD1nBD032796;
        Tue, 29 Aug 2023 13:21:09 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dnjvd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 13:21:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVsCTDjc66DfJQdHLnScaHrOVzGZIIX3RKlgy9ecvkYnChF9Er+mA8n0z24CE/OVHLWgUZR5YSG322TDNPxBLHjhRsJf5jvKjbdbYti2B2iGRjjLw76FngVFQsfnaUKK1ykZf8YklDcNfWc59Jpi3QEyXgMNFy8/l+i5dKnBhsVSFEA+9EFsrZQnFYInV+fILdEs1TqZnCX4jGNLUsLuLo33B+2aHNITuIpjSlQJlEygBd4/cNcTALOzKmosTDaZOuiHK0ibYBesoouky4b2+ZY4IyUuNfdqyE4f5Przyl1YShazi7XN+tjyFfwHvPauLCpq2IPiS8dh6CkYpaKl2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VydZEEfkOK49tGqj7lNuZrl6Z1dVQOswU1f627zZdL0=;
 b=T6u/xL1IzMmNswb/cyzDfrSAcdQtPk+xpRNcOIEb9T7G41uHRzfCLXyje/2/U+/qVWthsQVbajv1PjproiYrjDTYpkK6nGC4taeeCkLskYBXB6TBGzDBoYuu93iO7LeSypauNTFlyxt0KQVEnuJxZsrDdzGkHH0BeQFM31QQt0aqxML3DXq+iEFzaoOG/QYzkDNEQjlZPeLrJdOMSEmbe6WwgU1kVTQv4S+EY6mYSQ2vWGhDELtCVfHpHh6ixFexKsOq+EndEk07Kc4RCD2CHCwDh3eYy9cE5T/rgcNB1iXEiXG9jGN7Bh1ecuA6aTZknTqh8KfpUmNQz/GXueIf+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VydZEEfkOK49tGqj7lNuZrl6Z1dVQOswU1f627zZdL0=;
 b=nVydeSBzJ73WcYu/ebaLO794sN49637oOEoU3EZCAr2zyih4Nzk0PmK9m+/OamY24ivDdK6PuvtVII9XbjYMvnh4g3a37W7vL/UZoFycgDME/kAq8UGs9giinKkRbsIZim8SBNqZF01/NmYi9GpaHG//enhwAEzRJFWCUptA1zE=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA1PR10MB7554.namprd10.prod.outlook.com (2603:10b6:806:379::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 13:21:07 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 13:21:07 +0000
Message-ID: <4bdc5c66-56c3-9a6d-31e9-e5c96c697799@oracle.com>
Date:   Tue, 29 Aug 2023 18:50:53 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.4 000/158] 5.4.255-rc1 review
Content-Language: en-US
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
References: <20230828101157.322319621@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0063.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::12) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA1PR10MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f612e04-204c-45fd-ffff-08dba892cd59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ywjqFuMXUWmx/IxF3+keGS6MlyzbLNUPim5iHX9j3kpwwZrzwOTIc3N1M/PktxJCfEdhldNCfRpKO/xKoOKlEZibJAF5rEPWRjY4x6IbToUzlcibJW3s6VJ+utTfbCp8RkC7BfEJtuTxWAgA0CxVHbLl3pe9+4FZ2IpR9wCsOec9H6yU3SH7qOdgapXhXVGT3xLZl7OVMo1a6+Hy1CmJ1SB3B2FGQqWwSyDUT0KPv3EZr+dGNndReSORZdg0sNidUpNC1C4s4oJhxQO8et6AhX1L+w4DxYp0a4ukAMUJczQdZioGHdn4vKGU1ifCaRAqRHGDku+Nw9sMG24Q/Jwn5mwuDsfUCR6WuGivWlMngAsnQ+DAJ3xcTKr1E6P8RMiOYv+4uBIAyIsh/p24RGK+g+e/51M7ZWYxuTRwtRlipQt6Yax1zOVfP8O1MFubiFzXWsoTUyX2vQt2OFenDfMDdddh0sKIAT9Wx4LPHlkxK1sIvRbN+MIHVVh9ofqSl+iMqpCrdCnU9tjtsrx5X7Db0/fo+A644jo6Q31XvWNSQg4cKUaOOaKUzg88LITCXBZCTiof3LEiZ0uFNhHNHh6vqj46jEMBO9P/lojxbn1kxOpgDmeiznCsLCyfFuWQpAfMYfGHVFS9ioFxiX3p60PRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(54906003)(36756003)(66556008)(66946007)(316002)(66476007)(5660300002)(2906002)(31686004)(966005)(41300700001)(6486002)(6506007)(26005)(53546011)(7416002)(107886003)(6512007)(4744005)(38100700002)(2616005)(478600001)(31696002)(6666004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmFoODZoWmZJL1lRQkVlS2cvTzBHSlJnQ056R3AwWFBwUG5kQ3g1NHBuYk5Z?=
 =?utf-8?B?N3JuNGJ3MlpRM1lXV0hOeVJxT2JDT3I2Z0JieGk0YlJoV3B4eldnK1gvR0dT?=
 =?utf-8?B?QzBVZ1EzNFpLOEkvcS9nSUQxM1lsZTBKZzJ6UXpkWDQrdVVnWHVON2hDdXZC?=
 =?utf-8?B?MHpxOHZ6bXJySXQxRVQ1NXdSYmdrbXVESHJpSElXbjZnWmx0aUZ0SHloc1FR?=
 =?utf-8?B?eDZHZndUZzhiTnFvZUJGS2hWTEpjZDhYVThoYmVhU0d1dThNV2lIU2ZleFJD?=
 =?utf-8?B?UHczT3F6ZjZjQUZEVzZlYTZaRFp0aTAwQ0ovazloKzF4MHNnWmRiOWF1QkNB?=
 =?utf-8?B?bFZuSThGbGxrRTd6VkVSQTI5RHVKekltb0F3RkZyYTZuWmxjTTFXSE5GZGdB?=
 =?utf-8?B?bjdqS0w3Q2xGUjlpVXpKTjVqUE1yZ0Y5WFpmTC90V0ZNUld6cUx5bGNnLzlN?=
 =?utf-8?B?ZEppczdWT3ZhWFdONWROQ1ROcUM3bEhtaFEwNTVKL3NDY0oxbnU2WXZRekNa?=
 =?utf-8?B?OWpNSlpOS3d4anpvTk5kYXEzdldiWlRORmh6NjRkZWoxcE1ZUDFsdW1Nc0VH?=
 =?utf-8?B?K3cxanhiSXBadnZOWnZsQVpUZHgyQWM0YUpiQUFkRm5Rc0FmS2w5Tmh2TmhZ?=
 =?utf-8?B?ZERFMzhLWXR4cFZ0dHZ1T0E0Q2d1VDR5VHFJaGZ3TnJoT0x5T1FkbVA5THB0?=
 =?utf-8?B?RUV1ZGc4OEl2VzNaRUJUMkN2dGF6MC8vSGhsWE9RcFFYUXRyWXZiNzAwV2dC?=
 =?utf-8?B?UndOcFNKUDVhenp4TWRGVkd5NmdaZEZOTkhYeUpFdUxQbEdWT1dwMkdjZ2ZL?=
 =?utf-8?B?b0tQd2JaT3NhelVLa3ZPOXRWQWFNL01tb0JzcEZOb2hNWGlMUFhIVVc1aXEr?=
 =?utf-8?B?YmtNTVErR1phK3RhSWZueXdOeStwL2F6WTNYSWVjcVJWWUZYSllCSDg5T21P?=
 =?utf-8?B?Q3ZOWHhxaEhVRHNid2FkUWtyY1R0ZHNEUmhPZzZpVFI2L0tLWmM5TE84VmJ6?=
 =?utf-8?B?a2piM09UajRmRkhQUlBibzNlSDgrQVg1ei9GVlVqWFZzckxiMTFXL2xWT05I?=
 =?utf-8?B?Wk5HMW5VNHZDUlRWZnFjUFMrTEFkdUJDZ1FCMkpRTTBxcmZPSjZLc1NTZlQ1?=
 =?utf-8?B?OGpxMHhaUXRwV1pabHBKdlJ6WGt5by8zeXMyVDIxT2t1bzJNa2JwSVdsMlRG?=
 =?utf-8?B?V1F0SUczdHU0R2dEVHhkSjVTcExoVVBBS3hUb0xIR1RzLzZBU0JUazJzSHN6?=
 =?utf-8?B?VlVQN2VWdjI5eW1EKzI5d0N0Tjlhc2Z3SlpFUUZtb0puRkRiVW8wV3M2eVpw?=
 =?utf-8?B?ZE9yUEwyN2pUbis3ZUNDOVlzWTBKV0ppRjVvTjlFQnlxZUlyZlN0VkhjN2dZ?=
 =?utf-8?B?SU01TjRTTVdVcGVwQ3Jwdmh3b2EyU1hOWEx6d0p6QkhseVAvR0psT3M2K28w?=
 =?utf-8?B?TjZzTG9xRVZzaVhwOGtGRVVCOUlFSm1keC9BakVPZnFJNWZURU5JSWhCdXRB?=
 =?utf-8?B?eGYvV0JTWDVBbytGYVRvRlU0M0J2QThmTjBNd0lNbFpFNnFKTGxKbklMcUxP?=
 =?utf-8?B?T1o1eVhDSndxckMySVB2cjh6bDdwUzNsWWVVeUFaaEFDNW03RTJkSFVZWEZ3?=
 =?utf-8?B?TUdqc0xNMU1yVGhsblB1MjBuTWpTY0UrMWQvYzN5My9VaFU5NnpkTmVjTjdH?=
 =?utf-8?B?b2lwM3I5SU9aa2d1NTZXcFBIRlR4V2R2S0JGOGVpaWg5TUpsb2RmdHY3SWFi?=
 =?utf-8?B?QXhpbkFLZVhDWGduQ1NRUHlEQ2Zic1I1NzRFaFdqRi9YbU1Rdnp2MExUU3c4?=
 =?utf-8?B?SGpwOGFKVGF2WnNZZWFOUGlLSjZZa0NLTFdMNzNJVWtZZnVxZmREV1duWVQw?=
 =?utf-8?B?cmxVSWV4U1RPSGRqWmloYWxsTGtQMGtUcDhLWFhzM1hHd04vME1QVThYOFo2?=
 =?utf-8?B?ZXJRc21aazNMQ2drUE9nR0doODFNWmhzZTVpVGpaY2NmT05sVG1ZM1F6YWhw?=
 =?utf-8?B?c3FFNGt4U1ZwOUJTODlZTnlIdVdEL1Q5aGpxUkVGR0NIUncrQ3JKU3dQbjZB?=
 =?utf-8?B?UGJtVVhmQ0lVQk5xeXdyMGtaVkNzQVc1WlNPVWlDVzNKeGlITjNUTk85OEQ2?=
 =?utf-8?B?NU13ZzR1R2Q1d2VCR1krTG5UdFpFYXYwUk5PRGlLY3B1eFFTcWJORy9ZK0tl?=
 =?utf-8?Q?ID1opkZtF2XIj2cELsm+jQc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eVBGeXhKOHhkdDNoWVU2aU1ydjlhNWNtdm5tNnBDNnUvV3VpWXgydzFqUlhx?=
 =?utf-8?B?UXI4KzdIdU85cnAyZzhNUmdEY0dpYjcycHZiT0YvZ0FqWkdnZmhvNjNIcnFI?=
 =?utf-8?B?dzdCeUZFL2Z5VkkreWRmQS9BNmNTaUpLNUxEWlhkS2xDSVV2elFlMWt3eTBL?=
 =?utf-8?B?Y0JVQ0pDbWdOTkdEY3Y2cFlJSGpNMEdwN2hQdEcvbGpSbnBtOFVhSGhHRWJj?=
 =?utf-8?B?N0hIdEJ0NVZnQzk0REZoR2VRTktZMjBMZmFFUExRK0N1SDN2bGRPdmZFRmtL?=
 =?utf-8?B?S08yNkM0a01zSnU0NnBjWkhxaXQ1ZVkzRldNcHorOVRVbDRzQVdXS21BZTNt?=
 =?utf-8?B?ZHR4VXpUcUdkaUw0ZzAxeDh4U3kvN05PVDJTME5HOHprTWppeWpMblo5WEJZ?=
 =?utf-8?B?NXpnYkZhZTlIdStwR3cyVWh1aVV4MjcvazlCQXpwVTZUWGdpeTdVTFhCS09K?=
 =?utf-8?B?dUxsNVprRUNsVm5KK0FQV0dqMmRsVmQ4VUdxWjZjOXk5Y0p2bjhoVG05YkpK?=
 =?utf-8?B?WW5POU9hMmRTZ2ZyenhGYThyQS9FdzRJb1JhOGJVdGhpS3hPeDJDeHpETCtN?=
 =?utf-8?B?cjNBSVMvWVZvQmpscjVMOTFBaG9tdGxVbU40R01xOUZveEdRYlF5SUVkcWNs?=
 =?utf-8?B?NkpuVHQwR2ZJVGZlazVTUmVuNUpKdkdiS0dYTW15SHBwdU1CMFUvaUNlQlFJ?=
 =?utf-8?B?RDk4M2REWTVwcHNpL1RQKzRSZjJZQTc5YmJLSHdpTFZiOU5kNllweWZNNk5u?=
 =?utf-8?B?OXhKamorckR3TzBnRFNVai9zelgwSlc0ME1hbEhTZEFKbG4yeUlTd1Q3RUhF?=
 =?utf-8?B?Q1BQZVNLdmpxbmdzTWk3M01ZSFRpTVpScXhtTmNtVldHM25pSGZFVUJIY09w?=
 =?utf-8?B?VEZXNG5ua0ZCaGZPY2JicHhpQlFPQ2pHT1g1MUNydEQwQUdtZDJlMm5Jandx?=
 =?utf-8?B?Nm5aWStEQStxOUJRTlF5bnhSb2JXbVRiRHg2V0ZLMnZrMkxpL2JrMlBxdUVu?=
 =?utf-8?B?K3lDZTgva1lFUE1selM3cnNSUDkvbVJQTXdsYnNURE82M3E4UWFHMWNuZUNW?=
 =?utf-8?B?U2haSkNxZHpaUGtQbGE5ai9udE9COUVNb0F2anF2K3ZOVDdmNlBuNEFGZ05Q?=
 =?utf-8?B?MUpjTGpUZjJEK0JyaVhPVG9DMEtYaUdQdFdyWlhzM011OUV2d3hqektJWGVJ?=
 =?utf-8?B?cFZ1VTg1TzgzaW9WNDN1aTY0bFV6MENrdTVkTGQrcjM2aWRXRmd1bEFIbGps?=
 =?utf-8?B?OTJkcDNLV2Nhalh1MUlmLzN3dE9VQVpjZDN1WkZ0SjZNaThHRnJCc3loRS9r?=
 =?utf-8?B?VHExWkYxaVQ5dm5aWmx3VDM4a2VVTi9jK0VWU3M5ZUM2MTdqcFlZcWl2Y0tD?=
 =?utf-8?B?NFFDc3ZxalpoRURTNEV1OGczSEVObzlhMlk4VDBNOStnV29oMHhwaElPbldl?=
 =?utf-8?B?dGJQOE5KYUFNaU82R3ZGUmpiUjRidXFGWTFtajh6MTE2MDl2T2Z4SVViWDBQ?=
 =?utf-8?B?NHFweHk3alEvRHlRQ0lsNWw0d1A4NzBjWU0wTkxFQmtTaFJnUjM4UHN1ejVk?=
 =?utf-8?Q?xuScPW8q2AwFBgJAwAdTSlQH/PW+GrP4i1cUcxPS+ZsJWF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f612e04-204c-45fd-ffff-08dba892cd59
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 13:21:06.9594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVB5kByTKn6y0aLuHFoyDWTaH+HnytaNm5a7osgGovmLuAzuCfQ0uql/yw30k0XrhrYdD2cl6cXwReH/i52Xz2sNhomGe/Bw6yVICkXHOsLUsEt9ZS2GUv2qP1Tys3U8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=969 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290115
X-Proofpoint-ORIG-GUID: 2V5qNAQNJQB47m71BsOcfrbloRApeIRi
X-Proofpoint-GUID: 2V5qNAQNJQB47m71BsOcfrbloRApeIRi
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 28/08/23 3:41 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.255 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.255-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 


No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> thanks,
> 
> greg k-h
> 
