Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A710A80ED60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjLLNX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjLLNX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:23:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0DAB7;
        Tue, 12 Dec 2023 05:24:02 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hh9P004096;
        Tue, 12 Dec 2023 13:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HkyUdiqHKyX6HiFKv1+l4bNkXSTQOg/8CrnFSF9IcO8=;
 b=DH+DGSj2Cy3APRL7sr9LhhBr+lsba5Dj8XH+VljVhnxt+AQvEyE69ZBN088eouz6DSaE
 xN+xY1NH8NKM6nnjPRsDlcqCmDN+DVmd106YpB4gwbo1HS5r90GUb/xVUmAshXFxy6q6
 SbVtjzfp01T6/W/7HfNz86dxy9iLN6MlCeT/KuFh3D2xT1MR7GxuD4qZJV+ZKQI66WCw
 +6jAqerk8SKpPpPZc8EjKEyAwoN32YYLf2WSPzg83NI300enEVWHdUrf1Xj+eq6VIyf+
 6RL8s3O3FsAvautEUa4K5ojejC99tcmGZOw16SeiAr9lr54Mq9hD0cjsPaDu/zAOU62b Fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu5jse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 13:23:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCCoE4N012855;
        Tue, 12 Dec 2023 13:23:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6juyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 13:23:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHMMMve74LcoNjk3bV6/t0rea4/187mgz51F4ddWYsjrpUkYoYGERXGiWAuHYaiF2APrF+dLsJkGMe610vCroXescXAF79M8hYRfkEhPv3oeGXONFK4g6E3P1ubAsGRbvWq9h1Yf8iFyVoGS5LvZy4QcQUPCV9AiddeCXQCDIsZUxENoSiiCeXDbFJjt/Ff9dO8MAaNnxg6QoJOh7QZB5b8A505PIu1RgP7Qrs7PzofZ9i+PWAPCMKtu4gXr8AHQKxoUG9FmHdbcqYGxj2fsdy97RKKlG/bUTlkTdUoZRz+0TxrUUWbLNMRqfM4DIdkg7qlmb8+DNMtlGPEUKTXrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkyUdiqHKyX6HiFKv1+l4bNkXSTQOg/8CrnFSF9IcO8=;
 b=Ly44Zuvs5muiRFwEorA7lquCy03q4/7fjVti0vxQE5Xcx7iOJ7n7RtwD3gjnXmFM3ahObCYZzmC0ffFlH6VrmcA8wpPhNdvjMMfsrMiqBM2h/iQcxPm4g5XjUqlNbQ68X9HYo2apUQhJd3SkDiLOGrCGUcAantDOyUSlBvLnJYL6xvW1vdgr/uamOPzrOIEToxW5Ebe/EcHkGXhwlCROc/gkcyMM5iPPQrjk2uyn/0ZAcMQmteKBRn3ijXzJe0CnxECE+WOa8kBsFflB9OXr7Z5OIen70wGpdD49WPBexzJvFaHTX/lWgPUZVYwnmXLQenz5/aGhFxgWY3KGYVUfPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkyUdiqHKyX6HiFKv1+l4bNkXSTQOg/8CrnFSF9IcO8=;
 b=0IA81M9d+KVZPJtFBe9gDk0wd8t+54huQa3vXy4btATrUPzkd2R1KbSVY2cUFZfHuMAl9n9nVJf+JkrgVaVgDuACG/d6h9ec+K3LW7QRTBeOljOUI6sh1Fp3FaAcXHGZjK2STn9POHXFkCr1kZ2ECs2+aZu9/sU6n5Wr1HfWmoI=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CH2PR10MB4373.namprd10.prod.outlook.com (2603:10b6:610:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 13:23:21 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 13:23:21 +0000
Message-ID: <09c5f53c-59d7-4342-aab9-ab962fcfc342@oracle.com>
Date:   Tue, 12 Dec 2023 18:53:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/67] 5.4.264-rc1 review
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
References: <20231211182015.049134368@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0159.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::18) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CH2PR10MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 480b71e8-9054-4780-29fc-08dbfb1582d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8wLIFqAOr6pR18+/n1cmMUFFSZz23bBKLgYF2B9qWhd1wbtEntEqXVkQMPHR/Y8XM+PQHJiEVRRZLJvHrfTnY7HA1I+7K4jUo2DLPZMXWRo0+QIs0YgeO4gsjNq1j3u5U0uvtMsrDW2zbxFCpEiVdgkqyDk/lfG1S/nThOUKYy+XYgK5eUErnKD2J04UM2Z6mgEHpcZp/03UtqlH6szvBdMY7i3YYzQvJl59hDgoVP8UaXvoTzOw0zakuAMZqf1pOTM48w2e7zfoJB8udAW5xpboo1/KsRwGYjrS6kWfo+Vkr5saFUXyMs5HjrWQLk7qbMCShd7ShalYxL8WCDJTR6bHU+qSaHHRK5cIgIdESX8cAxuxkN7bKsRfGZvceQC+AFIKU8eDY3cy9eMQkeqbw8ZOW/08z/qDBvJj8oChKjSM0KC0Dm87FKQVu5mFAz5jDH5e+11Yjs6kWSVfgbLjQXrt8f8xqT/+KVyInZ+itC3uHZAwnGMxUgHFxsBUWXpWb4/KhU0GpZfIwXJ3ru9eFZksDxwyTc+ie4Q3wcWtdTZqdlRfOOaN7U2r60zo4vXKbulpX0hXQsiQ4a/i9atufx4nzOQZEtGUPAMX1d/ljC8ksLouhczxi9pJw9A4KkaSjsTauqye+VpWl2COpNDcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6512007)(107886003)(966005)(26005)(2616005)(478600001)(6506007)(6666004)(6486002)(53546011)(4744005)(7416002)(5660300002)(41300700001)(2906002)(66556008)(66476007)(54906003)(4326008)(316002)(8676002)(8936002)(66946007)(38100700002)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3hYTWgxdmdUZXo5MUlTUStSYnRtQnJyNVY0cEJ3bDdkM0R5TXdnNTA3OWdV?=
 =?utf-8?B?VzEyU0tXZWJmRk40UGNweWliT0NIV2FMOHJPNER4RmQxdDFZbUR5aFdlTEFU?=
 =?utf-8?B?aFJ4dFBVMm5MRVl0WlFUeEVQWVd0Tlo3UEdXQW1xQkNQQ3JOSGhWTE94Nm1H?=
 =?utf-8?B?bmpvSm5OUDQ5OGtSakMvV1BnSGZWUDk1cUVyc3hGYWYzRDh4L2lHMm1sYnVJ?=
 =?utf-8?B?YjBWTEpQSEZZY3AzNURtSnpob04xWGVnM3FjZjR3NjNaWHU5K21TVTNkdS81?=
 =?utf-8?B?UWwwWVZUTVdUSWpINk5vZGp5bmI3NnQ5TzF5aW9RNFV6TjhiVE1yeGEzUC8w?=
 =?utf-8?B?dEhUVFpjMkdDL01qb3dHT3IwYkNPdkZGVll0WXVTeXlaZWZvZ3dhNTlEUGdx?=
 =?utf-8?B?dHVzcjRPZkdKd3FubnRqZG1sdUU4QzVXZVV3akVHb1ZjWktvL2FzN0Q2Z21x?=
 =?utf-8?B?UHNTZ1ZxTURMTkpOaDVFTzEyVThGbWNNZys1MHN6d28yS0J6MnphdU82eGlE?=
 =?utf-8?B?bkEyWWFRMkxWbkcwNVJyYkZMUjNDS01XYXl3THUwdTIwVzZlQWtXRHJvZXF2?=
 =?utf-8?B?MFlYMnZidG1LakREMXNWNHp2MlIwTFVzd09adXJSL0VUait3TGtmMlN0WXlY?=
 =?utf-8?B?d0FMZC84OTFLRSt1MlBVN2JuZERmdGh1TjVqeG9FdnM0SXRVWTQwTXgrbDdS?=
 =?utf-8?B?YXZyUHV2Z0Zyd3N4emVPVG1walVHZXRTYWpvT0tYNHVNNTU1VUh6T1hyOVBM?=
 =?utf-8?B?czhQRVQwSDFUbGRnSm1sekgrNjF4djJKTnRad3o2T2R2NERwV1ZFTUEwVzJZ?=
 =?utf-8?B?UXhFT1l6N1dQRmcrc054ZFpkbE9qT1d6NmpiYys4TUpkRUhiS3JKS2FEN3J4?=
 =?utf-8?B?RkVuWHVOakQvaTF0eGhxR01zYlczaXNPYXducGNsakdiUmNIRExYVUdQTVVN?=
 =?utf-8?B?djN5anE2Q1hFajFZdUNUNVUrWnlZRFZ6bzNDUThYVTk0dUN5YnQvUklscWRi?=
 =?utf-8?B?WEhHQnpvQlZYaHJ5a0pJMnBRblZzenBDUCtSVG5SZWttWnU5bWZoVHh5V2JV?=
 =?utf-8?B?aUdJK3hTY09Na3FRWFdlQmswNnU5QTF4V2pmQ3BJc0U1aHJmd0ZwY25MZmly?=
 =?utf-8?B?eml4U1Ntcnd4bzZwQWwzQ1BJM0puMGU3czYrcTl3TG9EMXhrTHFnMUpWb3hn?=
 =?utf-8?B?bkpjSHBMWktleXViMk5lSlhzWGtCV01FUEFIcmdsdkVDbjZxNmlyeXJiUURS?=
 =?utf-8?B?bkRPTG5mSXJFWUxuNEw5OHo5WmpPWUVOSWJvTERQbjJLTW40UlArY2pLbFR2?=
 =?utf-8?B?ZEIvSGNYVEFFdzdLbk5ZdVNEeG1abDkyeTNJWlduTW4zL05ZeUdudGw0MmF5?=
 =?utf-8?B?MjM2VWE3RE9BWXRUWFhGUDRFOGJaL2xrdzRhMG5DbHFlVlA1ZWpZbU50L1Y2?=
 =?utf-8?B?UzljZ0x5VVREcnl2LzZKdlpJbVdZVXNPQk1nZGRaL3Z1algwaFczelF6VDBT?=
 =?utf-8?B?OUo0ZFBTbmIycEd0MzE4Wk9nOVNlUmlTdUJHWGVFRWYvWXBBcFE2eE5DcFBx?=
 =?utf-8?B?bXFXVVJQNGpIZnA2ejBnbWZXQXZ3WHRCa2dZVGxlUDc2UTZncC9CNWlna21O?=
 =?utf-8?B?ZzVTU3FBNXY1V3dZU2NBUk5LY0FMOEp2czlNbUtNWDl1U25ncTJrdjUvMXND?=
 =?utf-8?B?Uzl2Q25GYXhvZ2pqb0ZEMldMUzZ1cElzRjU1REFva2JzVmU1b0k2Ui9lQVN1?=
 =?utf-8?B?d3ZDbUc2MVkzT1ZZdUU0M2VkY2FBa3BSejd4d3dkQ3I4S0pONzRJbEtZNWRa?=
 =?utf-8?B?bktzUnZZRTIwV3pId1lQRk03ZmN0dFB6Q0VleVlMcGtrMkp3SjFLa0E2ZXlC?=
 =?utf-8?B?ZEg2UUI1TWlYN0xuQXV4ZmxhQVJaTnlMSjNML2hZdk0yUzJRR2xSUVlxVUkx?=
 =?utf-8?B?UmVTNlQ5UlV5T2pxSUIrMnhvb2hCM0VIc2ptTWo2RWJvUXd6d1FHUXRaT25x?=
 =?utf-8?B?MDc2Rjg0SWJGeVMweHUrbjBGYVNnUUlaVGxneG43TGw2RTljZ1VUOVFmNkti?=
 =?utf-8?B?OWhQMlJub1dZaHNXTXVoLzdISU9vYVRHaXdUUzZlMFZQVjZTRS80WUZkcjlq?=
 =?utf-8?B?OTVaRXVmRzd1bFlyYjdtK01BTmlhdnFGclBoc2pFSWRjRlRjZW94V01hb0gz?=
 =?utf-8?Q?Ul4c9AhjFkjtWw4NMxSZ1CE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UXdDK2VQaFdXWnVJdWRoMWlTUG96VkdoSzlkaG1tTGFocWEvTWtCQTh1aHhO?=
 =?utf-8?B?L3E4OHI3U3ZhTStQb05lVlNoOS9jRFZReEtCMkZ6Y3JEbW83bjBLa0lUQjlo?=
 =?utf-8?B?bDJVVzdXYS9ydUZ3Z2Myc0pyMGZJY2I4a013TVFTMGRhc1RhQ0R5SFErWnBk?=
 =?utf-8?B?eG5NSGp1eVFRMzRpVTM0TnN2Q1lrQkpvWEhlRmoyTTFFMHZwL0lOUXA3a2hG?=
 =?utf-8?B?ZkxyM1ZNT0h3eDNRQStEbHluTHNQMTh4VkRRZVA4Z0pOeW92RllNU1NXNGdj?=
 =?utf-8?B?ajU3TGNuSVhnSU1yNnJLQ2xvZVJ1UUhFWTRzVDF2L1d0WVo2WnJ2NUpJSGFs?=
 =?utf-8?B?TnJKSHFnWHlwRFh5N0ppTFRmYlFxbDJyWGdlZ2RiTVJSNzBUcEZ1bGtHRENk?=
 =?utf-8?B?QU9rVUp5NkcvTWdHajJUS2syWlBEVEtYaW4xQ3BnS3NoT0VMcGgwdlkxUE5R?=
 =?utf-8?B?cGZXd2lZOEdDNzN0SjVGK3o3TWM1a1YwRjJEang4bHg5M05hT3lPcjVUQTlk?=
 =?utf-8?B?YTIxQXo2RVp0ZUpJY1JobGh4WjhkZ0tFdlZPazE0SGZUNlJwaWZCZVA1UmhI?=
 =?utf-8?B?WXFXeXVZVTZEN2V5bXJmUHE3dVpOQzdTSFVxM0FWUG5DSXg1Z2VONnByODVC?=
 =?utf-8?B?QUdHUXFiT1RiOWFVR2F5Y1oyNE8yS2c5SmEyLzdkaFRIcWR3eEVybm1ob3hx?=
 =?utf-8?B?NDYvbjNPME04Uk1rVGtUZEVDTUlCL09KUTlMVlVPOU9WSFRUR2pjRXMxdnpk?=
 =?utf-8?B?NU9XblViRDh6QnZDZlpqK0UvOE1HVFFOeUk0b3FxZ0RXZTVsc040ZExZUVNR?=
 =?utf-8?B?UkxtcWNiZVloSjZjejRxY2F2c1lOYVg3OUtUZmR3YkJwUjBCWkIwRjVzZkJY?=
 =?utf-8?B?VjRKbHBocmhGTlMvNkNrdmZjR2ptNmE2R0RPVDRDdnpZSTJvdTlqY1hveWpz?=
 =?utf-8?B?NDdzRy94OTBRZkVzdG5sdE1mN2dpNytRdjg1dVRadlI1WFUxYTZKS1o2SEJT?=
 =?utf-8?B?SHA4WHh0d3hHcWFxL1Avbk8vSVozdzRoYWRjejBLdGEvYnRBZkRkTHJzcDI4?=
 =?utf-8?B?MHdoOWVpYWZabkhucjYvNjdHOWF4MU9FM2JQTkIzcG5ocEFwcWprVTNzWDl6?=
 =?utf-8?B?M3RmVDZFTHFVeWZzUHlEbXpQZ3g2cEprTUtSS0FqRkVzbFFybTc2bnFPWVFn?=
 =?utf-8?B?alRITkpPRVpDRE9BdkQxeXVrTnRzMzJ0SjFQTitxcTZtaWlVSjVLWW01ZGRY?=
 =?utf-8?B?V3FPaE5IOXl1cVliQjFTSnhmNFNSZjVvTTZjQVRoZ0dVR25iNUg0WHBHcUhW?=
 =?utf-8?B?L25NR28zcWpiSTZvK2xtSktuMUZDYUFVeTJQNXdQUTZmL01rM1lJL0xzQnRE?=
 =?utf-8?B?dWpEME1SZGlvU2lhVkpFRWw4K0VGZXJjbk1USXA0OVFUZDZPdWw5aGVrTkdY?=
 =?utf-8?B?SXN4OHZMRG1VcnZZUklocUtERC85aFcyanYxUGNSeUdJQ1JUV1RlOXY2ZS9u?=
 =?utf-8?B?dXBybzkzbnJURFZNNVhKR1RwZjR3N21Kb0hWaGRROWw4NExvZmNkZ1VrRm92?=
 =?utf-8?Q?DXT9677OPZBRHzMeLP72sxsi9Htgz6jQnQaMbnvtRe82at?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480b71e8-9054-4780-29fc-08dbfb1582d0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 13:23:21.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Mh7G9cgx3mv1xeyNApytmLAKHUkuq337X1QakjMvLKMjvypdNgbQ8QYKALFs/jpSjDDf8tj35sFjwSXW0ZoRM4a/CbQzDamAYwuQgBRtPpDGb8XRsojmsT5ONAov0ed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_06,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120103
X-Proofpoint-GUID: wbe7M_M3-6X8yKLtsePhn36PmLBoliCg
X-Proofpoint-ORIG-GUID: wbe7M_M3-6X8yKLtsePhn36PmLBoliCg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 11/12/23 11:51 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.264 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.264-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
