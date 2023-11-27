Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61677F98E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjK0FrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK0FrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:47:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA646E4;
        Sun, 26 Nov 2023 21:47:27 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR5KmjO014234;
        Mon, 27 Nov 2023 05:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=gRQcFKASFHYWszdGDPw1ycI+9LnbsEpxKHyONkfZZRo=;
 b=AOE1i8V5oirDJcxdJHAZyixjOMeQFWaQJEec1HYpgE2u0YfqbY6T5BMA8HYZbqsZ8eSq
 bYO2rw95Y3AQeYa7b5oRBi8uSt30MWyaQOPFLjrMZlGoVjzOXNTBnYca+0zF2XWmDvqh
 DZTICgbZh6T8GzaO52chjVeBkRwyK7iOdZkQL67yW4ia2HMMHwDwrbgxQVp6n4XuI+zY
 RpfqV0iv2cjbCEt/AOxqnfC8d7U40Vb5t9OD+Xff8EoCnN/vG0iuwgEXHy8DO9xjmCyj
 eQLvk6ciN0L1rT5c+SysFcTOHM/gNcrmGWw12ixtvUT2kN8kiHPyRpI6pt8nA4S7Eylr vA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7ucj4ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 05:46:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR4uG2w012662;
        Mon, 27 Nov 2023 05:46:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c5398m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 05:46:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5QEi+eCpMwvXLmNGIn5TkFc7eJy48P3imnt7Qx7TYeKbH53sf2WTG/tjavoVNqRyWxEepsuaBlyysAun18/4sjtvnQMk149SUZoehsUV67hnU34SqM+VbYKc/Kz0sglSLswO9GAJeO//R4TaDSCYDjs4hgMM7PE1kYKV7XsaCR+lmsbvdrm+UrIEwno1G4MTNbK+G8ebfUlCQLpIwYE/okfmedJafQE8UfoczPN0Int3aMsbReZM9oGE1IQ400J+yhOwweYfEZS8yIxt2P0/OOyodyBDUr0xRJxwDWIZuqKH5BluNES8V5lPIiDd8zgHiIskvrGJ62/DYXyhOC1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRQcFKASFHYWszdGDPw1ycI+9LnbsEpxKHyONkfZZRo=;
 b=lT/4WLgEQyzH0tjOD1Qjk5z3wU5+Y1ELdY/lNT5RATg+Q3R1v0UzratqfXLN5w7kjggML7A3tJNyduiY++B6O0MHzoW8bP7ljUfAQtZ2AB9syX2UpOga5buTjsCEfpXYk+sMAf4hHCsYpk9a4HAmY0L4zKTw0R9XwPnOL3zqqmQDpRrJxThl1RhPXf+NbjIOYKMlbZBBAPERUveOyN1GHc0YTlJkrFXbJgQ1tkJmWYgJjw8h5kOEukbDIigrOEATgVTM9DboNsZGM8cNKK2xc3YqJLA1C2LJ1mz/6zWO0mkjmWqXcp6Q4QTdZDXsElKIAIfgd4ar0kdtiUiV/GYqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRQcFKASFHYWszdGDPw1ycI+9LnbsEpxKHyONkfZZRo=;
 b=W059uSNjo2J8h7I1FKtlGVAkOft51jwQyW8pwPE/24sEnQU72S3jJSG4RD7xq9DR5g2IcobnUERRlgaXDG5azN718FgZz9pa0AlcPq13/xuLW5j8r22yj/LugyOuqk7bm7x0e09oOPLKd9uAUdBB8qUsR3Cgz7G72PztBhv/JGc=
Received: from SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14)
 by IA1PR10MB5948.namprd10.prod.outlook.com (2603:10b6:208:3d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 05:46:38 +0000
Received: from SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::7295:59ac:ffbc:e40a]) by SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::7295:59ac:ffbc:e40a%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 05:46:38 +0000
Message-ID: <13daea3a-d64a-42fb-b4f6-95a5fcfed72d@oracle.com>
Date:   Mon, 27 Nov 2023 11:16:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/152] 5.4.262-rc4 review
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
References: <20231126154329.848261327@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231126154329.848261327@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::22) To SN7PR10MB6287.namprd10.prod.outlook.com
 (2603:10b6:806:26d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR10MB6287:EE_|IA1PR10MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: a25297d5-69e7-4553-b8e5-08dbef0c38f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SoYj6ZaJ5nDX7mVxa02dLOXqK4OI6bKQZc7/yi8h9opYSA3LVkhjINvyIFHLhd091climguYrpbpyY64C7sG+NMDeimaHviNAEFa7adhXiFZpgbtBUbV2gzPXVR6iHGNfTJUKjj6pfRFRH3Ugl0elQD3LCIzx7BXRqfCZxL6C9F7ddN65h5niYcXiZs00N6w+XShPnXVC5Gfi+BcwzbEuBphMzke0VQMHyWxRSsyx/F68K3Z5Qpz1fFOBS2NEim+TRyjuAiB/vMeVDeomWw4QkBPMussBrBvjey1c3A+3T5loylPT/ECwhHWd5lg26pT0RgAUdCZQWD7KO9afAXVN9MNJaXMM+FB8dnw3ErGRt4qEUJK4CHeppRoorazlaH71Q24n+wGrslUMtZCHFOidrLsvBt86AKDhEC3+KyCbN8Apue7lrt2A2bgIAAa2LM9bXOoiijQ5QCJXMCE/oARmgr6nDeRBi37GRoOhPDLtia2QFaj6Jfb40MXs3RG9ietlhaf376T6LnowEhYnDdqu4fxjb7GDF/zp0kOzTNEo/yWZXp3j2aXxfOMPvh31XQeCTXfqryb34dac1CQ8QV4vPKN4hpzFsMWmStQQZN9U0RLT/XHFnq5gh32A4qQIjWLr33zWVyIhx7Yf2H4tavtwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR10MB6287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(2906002)(7416002)(4744005)(5660300002)(6666004)(6512007)(41300700001)(478600001)(36756003)(4326008)(8676002)(8936002)(966005)(6486002)(38100700002)(2616005)(53546011)(6506007)(86362001)(31696002)(66476007)(66556008)(54906003)(316002)(66946007)(107886003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXlBZURCMmVyN3hUMnRLcTRyYTZXWHp5OXhzMGs4RnNYcTk4V09FMkJYS0pi?=
 =?utf-8?B?bWp2NzdhTVJueXJxK2NHZkRITS9WQ202SVphc214UjdQQUZ5aG5ZYXFvdXF0?=
 =?utf-8?B?czR5bEVTRnJLMDNpUWJOZDBEQ1dIVWpkL09NOVJOOXo0V1FaZWphSnNSZkQ0?=
 =?utf-8?B?ZWNvUE95UjBKLzZtMUhpU0FVZGZTUTVjOVY2NE5FQ2dKVi82TlE1UHo3QXp5?=
 =?utf-8?B?QzVWU2Y0cHpFVmNQZHVUeUlLUkN6cVI5VjR6Ni9qOTJ3TjdoUjJMemdlK1k2?=
 =?utf-8?B?Z1ZFUWU3a3paNVBEaW4xcytjSnhieURtRlNRUWNRZEVoemcxckhpeXRWajJw?=
 =?utf-8?B?MlllU0t6VnI1MGpYL3pvb3BrNndhTVpBVmVsSEVDdWkyYmtCVVMwS1hEUENP?=
 =?utf-8?B?a0VrUGpobUFrYmlZWW8wZ1FiM002SThzQm1WTi9VUDgxTXZHTWNqK1hpZWFi?=
 =?utf-8?B?Q0VrK3FnTjY2MUZ4aGFwbnRvY3k0dzg5YWFIa3k5Y2lDbS9SbnZ2WU43MjNP?=
 =?utf-8?B?SHQxc2l5d0UyckVrRXBRS0ZMejVYLzk4ZEtlR0RBQXM2eUlmTyt0UXU4c3ln?=
 =?utf-8?B?RTM5eTFTQi9ydk5EZTYxZ2IrM3JpcTNISVUzdG5pNENxOXJTcytOdDZPbEFP?=
 =?utf-8?B?TmU4TDJ5VUhHVENpVEdkZjNyUGRvYnpUYXI3YStTUzNHQWVlN3JMV1kvTjVW?=
 =?utf-8?B?aEc3am9waUlvL0VIVzBaRmRCb0JGZzUyQ3VtSUdzdG1qZGhMMzJpbzF0a0R1?=
 =?utf-8?B?TUUwcjlQV0FQZk42T1dXNnVuNHJ1Z2liZFJHblVSTjFiNm4zaVdsRUtISGZu?=
 =?utf-8?B?RllQbjlqUFBDVjlwKzM0VU01MVQ3RXIrS1VPU2JwWlIyMGsrV2hDc2JKSE9R?=
 =?utf-8?B?UzRldmJiMmRCMW5ycnUxUEVaWkRIQ1llY1Bqa2JMMVV2VDBOUFdkeTRJNGxa?=
 =?utf-8?B?VjFoS2ZmSjByamdMeFVBa3U0Q0VzTkJWdC8yZ2wyaFJFb251TUxXNjJhZDlM?=
 =?utf-8?B?cDFYS1pGZWJESXUyQW1vMXdCeHRuWDZKcjdJc2dOaHhvYzg5ZlVLRXRTN2dJ?=
 =?utf-8?B?TXFadTJmY0Y2d2NweGVhWmF3anNnSEZsRDRBUHRXQzlnM005YVZwOTIwVGI1?=
 =?utf-8?B?VFU0UDFlYU4vYlp4OUFQdlZEb0JYdHFsUkQ4dGJVRUtBSG14WXFYeWJWUXd2?=
 =?utf-8?B?OWJvakxOeFoxSjBBUVJEa0ZvS3gzalZodWdxQVFHRWd2ZEZJYWhuS08rYXNH?=
 =?utf-8?B?R2NLUFpqT0k1TE5NNVc4ck0xbkZDM0gvU2U3eWlsU0dKRXRaVzFxbmgvY0V1?=
 =?utf-8?B?VEk5TWNHc1lBN3R4VEtxb3V2Z2FVUkd6Y2NzZE5FZVVQNnh6VTVhcUwwekww?=
 =?utf-8?B?VjRoRTVNSFY5WjVvY2JZWFRmbnJYNGVsZlZCOUJWWW5wM3ZicERYY29JaUNa?=
 =?utf-8?B?REgwcCsrSHdMSWg5citZMEtlODVqTm50RUJLWnRuM0piMmxBODFkUTIvbGsw?=
 =?utf-8?B?bVNTVG13c2x2OFJwVTJ0bTlPdkFveHpHaE5LRG5VaHZ2ak8wQ0d6T1ZrZEcv?=
 =?utf-8?B?WS9SSlFpRWU1Y21TMGp5UUpTamdFc1RNdGd4WGV6RUVjb3h3OUd0REFVSjFp?=
 =?utf-8?B?NEtFQ0FhNjVGelRNbXI5cFF5bHdyaXpicVV0TDJBYjhPMjBHN1ZhSFhtV2s4?=
 =?utf-8?B?VG4zQ1lUaUxuQ2FVNFV5cDMzZk9YTkFuYXI1V2JzMTltMDZpUzk0NDc0YW9m?=
 =?utf-8?B?WmQrWEUvVzdiMUtaendaR1Vlc0lDVHREdUdBS2hsMHFjWHhWZkltZ3dMV2Qr?=
 =?utf-8?B?UjZCb041NmsrOTE5eDVhMDRWbTBGMmdmK256V3k1WHdrZEN4dkRYbDA3V0Vp?=
 =?utf-8?B?ZGI1OUwxQlhPYkdhSHVqN0JIeDZnU1FXcDdZQXB1QmRQeFhxaS93anI5UlFH?=
 =?utf-8?B?SnVaZitLVllrbis1ekhDTkV6K2NYdVNYL1ZaZVlwVXpNdFdCdUJPY0p1VFFq?=
 =?utf-8?B?ckthUk9kUElJdlY5akIzV2xlMFlFN0FxK2lpdGc1V1FhY0p5Q0pDaEE4WTVZ?=
 =?utf-8?B?SXFUeFZObGl0MlZWdHFZTXEwblFFd05LM3pvK3llU09aRittUXl4Y0dDUUNN?=
 =?utf-8?B?UkdFd0tUOGlmV281RGt0MDR6cHhRQU5ITDVEZ2k5ckk1YlU4R1NJbk1TYTY5?=
 =?utf-8?Q?v/8yqudYIorso7/QUAWBDAE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WkdLZHZ3bTFRcDhMTUJTcGNSOWMvWWFxR3V1MEYxY3g1RktDNHRpWEhHT0Nq?=
 =?utf-8?B?Tzg1WnI2cmdRcVVxY1hlcmRoSWxqRU5ONHJvU1lHdnl0UzEyRVZ4eTJqSytw?=
 =?utf-8?B?eHcvakZmQzdrUEo2RFhtdmdGRkJHb3QvSzFTTnEwdXdYYnVvV3p1bit2dURH?=
 =?utf-8?B?NDFyQUw0TkhISklvcXNBM2NGRkpjb0pua0l5YlByTCs5R29CT3ZhdnhsQmxT?=
 =?utf-8?B?WEVNdHhIaVR3a0NXMHE3a0ltSnloazJ2eGkxbmpjWWZ4aHFIeG41UWxpRThP?=
 =?utf-8?B?dXlNbURvL2VpL0VTTU1YZDlucTgwVFptMHZJb3FhNE8zNjhQQ3gxWm9OT0Rt?=
 =?utf-8?B?aWtwenUwMGpKT2FqRVJMQnRuK0VkM3QyWjFjakhEM0hmSzJub20xZmJBSkpu?=
 =?utf-8?B?dTFhK05yUTJMam5ybTFEcVdBcmVMU1NlOGlZK0ZCY2xPSk9na0hqNGwyNTE5?=
 =?utf-8?B?OE9WUDRPRW5TUk81bUZhT1BNRWhUUlR2Kyt3NzZyZGxKNkpLY2FWN0ZZWWVV?=
 =?utf-8?B?Z0FjanM1Vnlwc3ZrcnJUc2MvMFp6V3dNcVpFb2FFNTc4T1BPQUJFZHNlTzIv?=
 =?utf-8?B?U3lZU0k2VGZ5ODJuQzZiZ0dQcmNpL2l2UkN6Nlk5UC8wMHlqcUticGlLKzhJ?=
 =?utf-8?B?Y3dhdGdZdlpEamVSMFA3bytKWmdrbFdXanJiTDRPZVVpS3BLbk1UUmRrN3NN?=
 =?utf-8?B?VllLQ3pnMjdidlp1MlJ5TytJZDJSM2hHajRwOFYxcG5tZm5SZThoeUZCUmFp?=
 =?utf-8?B?QjB4c1VsTWNpSXlIVTJ6WDlNa0g1MWpYMWVQRWF2N0F6NVdpU09mK0NHQjM1?=
 =?utf-8?B?SE5BTnJ1OTJzbHBzeWRyRzdzMCtydS9oUDduNkxlTmVQUmVLN0V5dmx4ZVA1?=
 =?utf-8?B?KzRBWUZOa3hrT1Z5Q2tNWWxlWTgycS8xWTdLYXBIbzFYSnFXb1BpRE1oYU5t?=
 =?utf-8?B?cWhsMzU4d1ZkeVlKSC8xYk9MQ1dwMWdQTmRXWkM0dnp5V3ZQZzZDbjZRYU93?=
 =?utf-8?B?bVFVWURtRG05MG9uQ2R4RkhsL09pUlJ6T2p1bEZMVEdJOExtdEEyZXdlNCt1?=
 =?utf-8?B?dFhrRzBKd0NBTGZMcXJYdWdEa2pqS2F1S05QQjdMS0lyaGxCbVdLZ2lSQlZi?=
 =?utf-8?B?aXZER0JzdldQSEo4ODNmTk9LOC9FWmNwM2FvcW1sQ1VDaTZvNktTbEU3TGhR?=
 =?utf-8?B?dEpqb2ZWMTN0QTVCTnh1MVVSSlJuZnhJVHBiYUk1aTBvdzd6RmU4RWFpVDNO?=
 =?utf-8?B?RlordTBmWjk5VXB2TmhYTjIwZ1pySUkzSSsrdXBGdU4rN1NmMUErWHkyWXBm?=
 =?utf-8?B?cFV0dmVJdkdSVStkYUt5N1dGUnZiMmdmMmt2anVjazk5S0x1S0M1VHd5Unhp?=
 =?utf-8?B?bk5jaDNPSmMvQ1d1Wm1QUlljOEd0S0MxK1lPQmFiTWpBbk9EakptMGdYVG04?=
 =?utf-8?B?TjV2Mi9FeXIxUzhFWjE4RDhLNFhWdDlHZHkxeWx0YmVRbkg1dTVVK2JSeXNN?=
 =?utf-8?B?K1pyd0FQdkdMeFNIeDlNRk51N0NwSFlxRjkyN3ZxM3dRcVduYjlld1BzWkJp?=
 =?utf-8?Q?Qw1ouZsVYvZBIRYo7ptYt0QlJV64DcA5rCAuxrjSMfVzJX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25297d5-69e7-4553-b8e5-08dbef0c38f1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR10MB6287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 05:46:37.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVG8zLuqEaarIXouSl+nqV9BYclQFDGKxAM9BReWybmZw2XeXWUKk2PAOvm4u6EQMW4FoyWQeRM9DQhEG8mczdImvF1+KAs9mfwaOSbp+l/av2L0bT7/bZSiRRq8+OYe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_03,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270038
X-Proofpoint-GUID: BxRm_2H4mAMVzkDndYYUJT2Nk5vooyGg
X-Proofpoint-ORIG-GUID: BxRm_2H4mAMVzkDndYYUJT2Nk5vooyGg
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

On 26/11/23 9:16 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.262 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.262-rc4.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
