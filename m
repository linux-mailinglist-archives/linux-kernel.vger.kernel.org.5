Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0576C462
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjHBE6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjHBE6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:58:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D838F2115;
        Tue,  1 Aug 2023 21:58:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371Kxm3Q016951;
        Wed, 2 Aug 2023 04:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ldkp20IkueGTd4+IbZ9K213/7T7ZQskFpSIxPCvX9lc=;
 b=WQkdcDKWqsgxsiasaqmfHLN7LMqv8pZPdoluuQhVK72TDLRm5KF3lEsTTyYLqTVENNnc
 8eDraY+yRBd/kHG0kTAN08huZLQw8xp7IGyRRc3LqEDbNfyYd6KsRkyaj4vDqTQpOGPx
 Mw9yYon5UT18DOVcl8oLVSpLQ62mjB2B3qiVYWrJHDjY4OJ4ZkoHpgGo02hGEsRiF+7l
 onpwFNCC1lZC43PE62aUSC0vkmJYiOZb2fxns40ZfHyTL8eWc71nYLGF8sMiWRSp21me
 tCqK2z5OqBjQ2QDDlPaEZji3CrtdFeZE2yA7SykJRXyftmEjkHVJr1LnTV99HngE5Kj5 gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uauxba9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 04:57:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37223rri033467;
        Wed, 2 Aug 2023 04:57:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s77mu2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 04:57:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIE0J8fWroEmMK3f/M6a6igHtyu+oQ4s/L910aiMtmpYCnC3Zv4tD2PQHRt2llf84X1vsADzjBz8QamIUBJysrKXQoZmFLm0KX9BRgVzX/R/PjBqXkeE/wSASF7jVfkJ5r4F17lL6FSdQEPQIxJdaQfGtZRBdhEiTsn2lcK67gt4SmGmEbkNvDmVkz084FCzvNTflo+02FqaY2A3J67jFhHcKlYc0pC2m3j65kuUK+ctC92UKRChtfHrG7YWPK0u/sED0ehPKBG+Gy5Hjz0PnYJjXakj1PTHyjMQzCBvqToKlc2Iavo+6QSq4eXGTV1rp+2lZiYd6LEvwPbQT5HgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldkp20IkueGTd4+IbZ9K213/7T7ZQskFpSIxPCvX9lc=;
 b=dV9mU1qAcEWiRNGP7dcpJtubaMUo6wn+gXmOOH3lHTbmwaBYdxZmQWlbgmsTNE6hQyO+VINufDVOEBtEN0lEe9JSZWQrrePACn/zHe613s/9/cShO8MWFJYT6gQ5hUEiVcN8IAh7SnNTFXJIPDifIpSQ7jrYrEk2+rW+S8nr43pOX90RxH8svjIcZqX6ByeIWEJO+5u2z2J2vcNnRl+OyRO1pBE71spvp0rEcTQAq6GPhFrszKjEFgj4glt0wIaOadHF7rHPT2qjOwXP4IE8Oa7ipObz0uvl7yc4MaPkD8MhC/K5794KPxEy4vPGJuB54XLhlT/PJPX4mOuhCtf0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldkp20IkueGTd4+IbZ9K213/7T7ZQskFpSIxPCvX9lc=;
 b=si6GES1SEmE/mLS0Mqq6eUheNYOR8jrG0HaUlEmrV7YSBs5/6XmvFOaqh761B1LnviSTS0orNEdV38xigy0JLWFDbfZLT8a+zy20ypnPhbMJfGv8j/t8l+54HIKojwx8X6Oos9zSwpmMQg9B2SIqG/3kJOiIuNUYqVqzn4QodvE=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS0PR10MB7406.namprd10.prod.outlook.com (2603:10b6:8:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 04:57:51 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::6943:17f7:79d0:87ab]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::6943:17f7:79d0:87ab%7]) with mapi id 15.20.6631.043; Wed, 2 Aug 2023
 04:57:51 +0000
Message-ID: <b73edd40-af8a-6eeb-1ccd-36bf02e814f4@oracle.com>
Date:   Wed, 2 Aug 2023 10:27:39 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 000/155] 5.15.124-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230801091910.165050260@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS0PR10MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: d69e3591-eb43-49ae-5f86-08db93150635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4wPMMXoPWyEbxtKIwstRFIAyUbJufGqYMRgPutc68WHv9CrvIxd9WVdrUrMGzbzDdVSB3srmHziqZZvuh6iFn/q6OCov9OjXmFVneFMgtkpAu4I8Zc2Dhw+9v02OV92I+PkJ/nItMjGhOJI7V12M8SHa44HbFuxWbn/wiGmktHktoDDSvgwXVexvSJ8C6y4gXaPL/4eoznSFzbRZIQtyRYQxWf86sRpm+zDy1biWn1MJJvp5fxTho139SwblEZSMzTtCyU91uN8FkEdKj0hboNZ5KJhSmTgoX/kOWCRIlQ963lxkmiBxs/DzA4jGkFPo4wtVPmzE3Q20JYMKDXPvGrCB6sjDEZ5hU/1HznDfdFIbyR5skZ+aKcHdoODsiC90QswtVbYzXheAPRFsGp4jp31a6gR8Do1H1r5AgQM0qTNuFTAOoCPKeLYKh8QFBlRkOf5Yj/rxc+hMzZKX59xbMlxkXg33rRqUy0LYH3iI6k9D6wa+FxJCJuTz94q3PG0f6pCLRj+J9Hj+OrskA2E79Ljsy4RCwzjRTTpS8Jo/sUBcHaNFyEgwCQ5vNpdCzwxM06zdEtkiKfkwXWG/DOhjl1OX4eeQ82yFJdimZ1tj7WSJirlILAEzHR22AGhXNudzC8M2heFgWIFpmLs3F49Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(66556008)(66476007)(4326008)(66946007)(2906002)(38100700002)(2616005)(53546011)(186003)(6506007)(26005)(7416002)(86362001)(31696002)(107886003)(36756003)(478600001)(6512007)(966005)(6666004)(6486002)(4744005)(41300700001)(8936002)(8676002)(5660300002)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmtsUm5kOVA2cVIzaXRoaSt5dTc1b1VzT1IrMXVQVXByRWlEaThHRG81MjBi?=
 =?utf-8?B?VC9EUnZCOEhwTWpxUE42OFZ0TEJxOEV5cDM4Zkt1WFZQMnQ0TDBzVUsyblFk?=
 =?utf-8?B?TUVpbkdaaUd6QktaWWZZVVRFK1E3RmpFWWNuSm9LZXFJNW1mUEljdlhVV0FP?=
 =?utf-8?B?dWErQlN3WURZYWQxNXh2alVlMUppempXTFZYZ3JmMXdFWHN5eFFHM25obFV4?=
 =?utf-8?B?VTJsQ3pSZ2J1RnJqN09SU3IyalpHQ0RjK3RVMWMzUy8zN3lQYWdzKzdVdjAv?=
 =?utf-8?B?SG54YldybDdPR2dMa1p5MFkzRlV3ZTA4V1NtTWt2eEVHZjFRRjUyVGgvNlRt?=
 =?utf-8?B?R1kzTlNRcWVKVC8wZTFSWk52TjZjN1RWMjcxZENtd0V1OW5qZ3BmaCtnVTBM?=
 =?utf-8?B?cHBsTk1nZk11bmlVa2wvdVFIOFBqRzcvUHA0eUVTVWx6VC8rZ2dqZnBqNWEr?=
 =?utf-8?B?NUtmSCtPRFNaSVAxYTIvcUM4VkhPVGVnUkljV3l5ZHNpSWJnTnAzN1VjTWlo?=
 =?utf-8?B?eEpnRzJyc0VLbkMrSFJYNTV5Zjd6SzhLVXJkbGkra1g3OW1yY1BNZGdLL20v?=
 =?utf-8?B?S0FtWlhoenhyQ0RzRFA4UEhrdVhRVzRZTFhaL3FoL1B3YlNsSnprZEpDbWYz?=
 =?utf-8?B?V2dmYUp1UU50azhOMjd5MkJGRHR4UW1ES25Ub1Y2U1VBTEJOZmIvWERUU244?=
 =?utf-8?B?K1B1OGlhTUlZWTNGR1lXbTZhOHBiWHJLc3NCUDVRd3J2ZHVwY1RibHVFd05h?=
 =?utf-8?B?eXU1VnhUb1l5ZlBTTzk2SnV3dGpkRWNQc2RTT1VNSkNkMUpNTzBoOFczUE5t?=
 =?utf-8?B?Y3lDaFM4NTFIZ0JXM0NEM25JbHgvYnJ0OUI2Yi9XK29BYUQrUGF6WWFzTFEz?=
 =?utf-8?B?VXdHb29saUZ3Qmh3N1MxMUtzaHE3ejJteDJJeFRYSzFNZ1RGbzFKanpPTEkx?=
 =?utf-8?B?THo2c2RhR3Z4R0NhYSs4blg5SmRadEdMWFhCMVRUdng5VlFyZksrSzY4Sk1T?=
 =?utf-8?B?ck50OGRNOGw0V2pZSlVtNk1oSEVoMk1tUG5YMWk3bENQbG02ejAxeVZLanN2?=
 =?utf-8?B?dkoyQjBjZ3RZZlptaVBRZWFURSs3clZ3Z2FmVGZGSUlPTHpkT1Q0MmxUUGRR?=
 =?utf-8?B?b1NBd0lNRFRhakxvbUo1L05GT3AvYkpOK2tFSkROV3d0OVlkUVJxVktCdUY1?=
 =?utf-8?B?WmhYTHJVRmZnNmF3LzVUbTAxQjVqTXlpUllKUjNEaUVEZnRrY2JLcUlKUml4?=
 =?utf-8?B?bUlpS1E3Vk1FQ2JEdlNaMy9OYmRZcnFxa2ZiNGJXUGhudXVkNkUrejZqMnBD?=
 =?utf-8?B?VXVlWGYxenQrSGFDSjY3R1ZRTkxNYTRZSG5iQzZzUUNNZjFaRk1sVTk4b0s0?=
 =?utf-8?B?R3pJa3dLQlVhVi9EL0ZiZXZtQ0x2OURjM2N4UmNoM0ZPZWNNR2pscnZ4TWdB?=
 =?utf-8?B?VGdqeU9wRVpIU0FBODBOeHlWb0NsRFQ4cks2MnR4c05uRncrK3lqZnZHdkNP?=
 =?utf-8?B?d3g2cVduSlpQeGtVNDZDSnpPVngzZ2J1YThJRmdkc3FJOHF4aER3NXVYdStv?=
 =?utf-8?B?eHVlR3ZrVG9nU2QycUJZRTlrVVBHQUJRU0lPL2lmZHN4MkJ2Tk5UT0luTC9C?=
 =?utf-8?B?OHlvY2pjWGhtZ25PSHFkenBZWml3VmJwbnQ5allFcEdUUG9IYUpZR0NnYW5D?=
 =?utf-8?B?cldQOGl4L1diYW1ja3BBZGNKOEtreUxQQU1BUUFlZmUvZHMvb0JRVHo1anNp?=
 =?utf-8?B?SmZ0UlhlQTZqYkJScDcxVVpBZG95N0dGeDB6ekpZTktvTWdLSVkycGMvQW9i?=
 =?utf-8?B?K1FVUHJQeDlNeHVWdXlnM2ZHTGR2MmpqVURzQUQ5N0JZREZBZDNJQlRWVDlJ?=
 =?utf-8?B?YnNDZUIwcFRpTXJGeEs0QzJ1cnFpNW4vbEVlSzJVNCtXVVMwdkxwQmgybHov?=
 =?utf-8?B?aTBXOWtPV2h6M3FzcGhseGltaWNwNDhCUlFidmZLcnJ0UG9KOUFuV2pTRVBy?=
 =?utf-8?B?SkdBVEtIYXF3TllCOVNwVjBpSUNmRXhuZVlZT1ZZTmwwWUdueXZxM3oyY1pW?=
 =?utf-8?B?RXUrK0U3ZUF6Nm5lbHRaR1lGY25NNGVUZU5hRjNVNWZLeUM3cnhHMGRxSXdm?=
 =?utf-8?B?eERNV1RPb1IzdktHeFpaVGxFNXp5WjIvdGVaMDgzUVdBYk9rRGUwN2V2Sjdu?=
 =?utf-8?Q?/AlmL2VyzrA0LYPBRxp1IUM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bEcrYkZRK2VMR3dMQmN0SmNUNEd2bkYzMHdKdDZTVGw1emxyUGVaRUIyNDRi?=
 =?utf-8?B?NWErMytsYTk3K1EzZUR3VWxNdjdkU0w5UHBYaUlJMHVGTXg4RmhQMGFPNGQy?=
 =?utf-8?B?ditaRVZ6cW8rTjE3WWFJUFY4Zkc3UVNmTXg5eEJsZ0EzTmZWTDRINUVkT2Np?=
 =?utf-8?B?OHNucEpsWEhLSnMvaTVCMFQ5NWdlb1YxZHhRa3Qrb1NybDE4QnpNdFpiWlps?=
 =?utf-8?B?U3lLamhnT254aUlxU0lqd3dwWXBHSVNPQzE1dG5EemZmQVY3M0VQTDdHbmht?=
 =?utf-8?B?YmVqOW4ybGxSNnJiMmtYVDF5ZDVoSTZuc0N3eDB3dXN0bWYyYVlyUkZSTEk3?=
 =?utf-8?B?SEJ5QjZhQjdkZlE1YkdNS2pFZW9pUDF0d1hoWHJ1TjVhcCt4dDJpREFuMVhB?=
 =?utf-8?B?dXhiQlFCOUd3S2JMOUxCdkUvd3kwWDVXWmpqOWVDRzVoUk8xZXFzZ1dzWW9m?=
 =?utf-8?B?bGZiMGpub2lPZ1JtTnVNdk93dFVEWlhPbmJkSTFEbldPR3hoOFJKZGk3YWFt?=
 =?utf-8?B?Uko1THlLMVdNeWJWc0VhUFUyN1RDRWpjU2pHdzVHZWlQNnI0ajRydjl6MEJL?=
 =?utf-8?B?bURZNVNUekorSmh0S2htMG90NVdudTVxdVMyOUlsc1J3STVUOVpNblBzc3RB?=
 =?utf-8?B?cDlQamJ2allMTVlaTGRUU0swaXBQcFBLaVZhK2xYUW8rNzRFN2FQTzQ1L0hj?=
 =?utf-8?B?VFZHZ3VVZ3kwbDRSWmlBbWVLRW9mNm9tRHhZWUIyZjNZdWdhZDhJaHRnU0RU?=
 =?utf-8?B?UUdoTDdVZWRNN0V2cnk2OTZxeFVmelVqaEFJUGtrd0xRL3hBeUJpeXRsQ2x4?=
 =?utf-8?B?bTFuYWJwRmlXNUxEUnJzcGNuRzRJSkQ1NEhCZXJrODVIN3JkUjNNMEdUOXRE?=
 =?utf-8?B?VkYyejlWUVBjUE9yU0lUQ2ZGakdWTHRyYXpvWFZHNy9yOXN6MVRSMXAzNlRv?=
 =?utf-8?B?Vk15MnhsR2tISnhRMGdJaWcvVnVKekJHb0g5S0prcTVtMzN4KytOWmVPN2xk?=
 =?utf-8?B?b3JYNDBiaytCRVJiNkFLeTRGL0xuOGQzUlFIWVNxajQ0c2UyVmFHV1JFUElz?=
 =?utf-8?B?dHd6M0ltaFF6eDhIMjlNTU05OVpUNW81Z3M0bFRtbDg0Rm9QR3drNWJIY25w?=
 =?utf-8?B?RGgwWFR4TGdGTDVrUll0TWo1VjJOR1BmRDlNSGpOM1FnaWpaYTN5bHNscE1K?=
 =?utf-8?B?aEdFV2tEODJoSlY5cmcwcm8zZzlrVTFybVJhMTc5UEhWanAwQnB5cTduZXBO?=
 =?utf-8?B?TkdXL0lKYlR3K2VidlFYd1QxWGk0eDZCNFdQQmhId2RtOFpEbGxOelVZMGVs?=
 =?utf-8?B?dDZ3QXYwME1tMWl2UUJSRmFvWmJoZnp5MjU2MjVVSDQvN25DSHQvMmxsQVg0?=
 =?utf-8?B?T0VZV24xckpMV2JvUzMyK0I2U1BpMDFabm5FY1UyTXhseHhXRm5Vc1NtcktH?=
 =?utf-8?B?YmZsZjd6VzJhb05oOHdwZUxsbTFKU1Z5b0x6WHhoLzZrZTNPZmpLRjJ0cExB?=
 =?utf-8?B?cjgvTEtIQmw5WVRmZ21PNDdXOE4yZ2RRd2YrZEkyeS8zMnpCUHYxb1lSSkN3?=
 =?utf-8?Q?V4ayKBrlqzLyA2TunMHAPtlCcj1UO69I6JU0ou1nxfYjqI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69e3591-eb43-49ae-5f86-08db93150635
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 04:57:51.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvcdD/1WbY/093QXHUv2XbY+Btn6A0HZGcYJYqsk3PjD/FejJ0pxH810dkzpj7vW5DyK3tgJGg3PmkZ1uYI/C/l3V/p0xg1NXSYSI0l9FIJEg6oxECTcRLj9jvuNNE7o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_02,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=976 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020043
X-Proofpoint-ORIG-GUID: ei6hboFQsAjsMG9YQzQ3BJS6OBf-Qu7d
X-Proofpoint-GUID: ei6hboFQsAjsMG9YQzQ3BJS6OBf-Qu7d
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 01/08/23 2:48 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.124 release.
> There are 155 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.124-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> thanks,
> 
> greg k-h
