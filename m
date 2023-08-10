Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E0E777E46
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjHJQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHJQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:29:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B800BA8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:29:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AGOMAd014556;
        Thu, 10 Aug 2023 16:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=d9GdrhYZyNYcwTQxeij7WrO1HBErK4cxrKaGo8wHFTU=;
 b=0t0lWZYZb8cvJxzUi5joJBEfeM+5HlxkOsFDakN7vy2IhUMwSSPjGb9d1oyKGYuy035L
 pcDDrQ2b9D2eyFYVQJ0y+mt+4gRp18/cW7yKFNFHg8bEkKxfjGbLUydVw0bDcpi5xzhW
 lK+gW8ZQfPKmyjp+HypcvUc6dbOmtXxRkltdnsLNlHDQHbzpsitqTCpulOk83/kWAnlh
 lbOxdzqs65J2RsnTsZf0l9wYhjDCEM6JN/hRznhZZShAn8W9kbs2ZfVAMSes1CaesQyz
 HMJVLN/5CbkEqfN+gCQG3A5jhcGURoi5kihwLOz+oMRTUHrV4UYmjMD9+Xfe1ScU/FYb vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9e1ubj72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 16:29:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37AGJmHI008835;
        Thu, 10 Aug 2023 16:29:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv8q4b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 16:29:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz7Yo6zN58F4IgKU6/dL5Chr/sPYvTh7f8baWdO92ymmpm99tiLLWbn67ZhtRV5WqeNNorZkWY5pi9TTo1hGeB0SYZuHF4q0kofZmBxyJbQ7CvvMft9V90cHa2uqxcGNIhofPqq0P+oipTSXpDTf9vdDT4BCHA6THRngGsYt6y3+vh0nLiFQyeYwbuab8dMYvob9f4voiX9QSX6ZCztHzsQSIuDaJGpMTDUWsIzs4qtPwayVjNt8luhGyFI6yrCgddOzqDcHkmqQpmuAW5aN9j3QccevNwkYiPKF6g+RrDxwNDKnEBTpFYTgYEJukRhgtYh3buxcerBKYzOMffwzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9GdrhYZyNYcwTQxeij7WrO1HBErK4cxrKaGo8wHFTU=;
 b=CMTrYXCt45IXMTV1efZMCnNWF1vk6DfuGvg+ky73fypWFwUpH1yPivoAEXlU410wpVeW78x1Q0R3Rt1zvYTgnJRNhlnbkSlkZmDZ+Jlvfax7jElq7vSOVemxwHV3K3T+2/A9Yttevn0htwl763QUmu5HJt4M6yS1PLhjVBYHv9CvMib4jCa0JYJwlKWJART+iOC7JwipMiYUDVsWEzWtUfWBmQK324Rv4ZnaMoD44XbORJXKsj1etKZPiBVwT04c+vTQ4K47LXzW8c+8i7tS4p+XeGGJZISaiwzWg1Yd23V0JiNToe+c+fZL2zpuqs+uFbh12ywkxaJD68ybygoNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9GdrhYZyNYcwTQxeij7WrO1HBErK4cxrKaGo8wHFTU=;
 b=c7ThhTH9L/LJI23PhrND5GAkclGabI3BEEsZPKmAkWEL1UJdGYpCJDlERY3rLJEimSZQu7JnxJvxxbK7u/wmbsqnI2xr8216coQAe2+oJUMC5VCESEVmMENalnsqop1lcq3ix6O34bqEt2ffX6BmpIp/B2xyN/IhuXSBASxcDBM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB5899.namprd10.prod.outlook.com (2603:10b6:208:3d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 16:29:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 16:29:23 +0000
Date:   Thu, 10 Aug 2023 09:29:20 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Zi Yan <ziy@nvidia.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
Message-ID: <20230810162920.GA4734@monkey>
References: <ZMud3RreEpsvFKuA@casper.infradead.org>
 <fb2a22cf-14ae-3594-f5f3-8680c2100d70@huawei.com>
 <F2621E68-F36E-493C-8619-ADFE05050823@nvidia.com>
 <d184ba78-97d1-a264-fc31-87dfdbe6fdff@huawei.com>
 <de0100e4-d673-428b-8d50-11ae2b7a9641@huawei.com>
 <5BBFF5D3-3416-4C0E-9FDD-655661657D67@nvidia.com>
 <a34778cb-61dd-4853-9961-afd7568cd0f7@huawei.com>
 <20230809205316.GA3537@monkey>
 <20230809224424.GB3537@monkey>
 <2da95492-079b-43b1-a950-d290984a21c0@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2da95492-079b-43b1-a950-d290984a21c0@huawei.com>
X-ClientProxiedBy: MW4PR04CA0297.namprd04.prod.outlook.com
 (2603:10b6:303:89::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f8903f-5ee7-4f65-9929-08db99bef4fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJSMTTFe6mgf36AWcAZJEu1xqrTUMwDZ5/SoFiTIo1X1hWeVTQL6Onu++ms0JbcTfyanmzzxuhUC4MqZ8JuRVtmVvcN5wr+pvBbwu1GNhua+UoTmVhDm4z3pwVngO/gQps2qipbUlsdbKMZqng0YSdGCHR2VCDZWbT0yMSLbdyFSBpdAAl+wuFLC9vMY4sbkGaUkgbx7W3xSdylFgP/owg35pZo+DuEgK/O5YgtFqkrr+RONPyGzRmy6REfJjq65nHOnjnwNCfXnU3/GjRGK0Yt8vX7N0jpUJYPxfS4ZOqeSE6WqF7Z/Ha1/0lEPkQrKR5AwP7Kfz5viveMHs+lMFrp8pmhdbBbeZS4V/PnntPFyT1V2GMRBhNrG3awVzNjcmKeUl8XsQmwu25So4P0gBV1LoLyIHaBYHeSddmziR3t2i5r9JcXnvCG58FwM8WkLc+OTwxf71UleeCUAAkA3kJ+aRIoJQEtZLkMaGuOr6avR52mvGuXkSi0LzMGllE4Re9IrPjJkhKIP0XcEfMCUY4KzKoXanw6U3R213w5hQUCE9siuVac9/9rOQ2s7TXWS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(376002)(136003)(366004)(346002)(186006)(1800799006)(451199021)(5660300002)(316002)(4326008)(6916009)(66946007)(54906003)(38100700002)(8936002)(8676002)(86362001)(41300700001)(478600001)(2906002)(66476007)(66556008)(44832011)(83380400001)(66899021)(6486002)(33656002)(33716001)(6512007)(9686003)(26005)(1076003)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzNUVFlLbUdHTUlYcEorZ0p5U3FNYzRWQ2llSEpyVmNVNUxxWWRjWHFUOWFG?=
 =?utf-8?B?VzYrcmV3UjgxS3Q1dlMzQUN3WXNaa0JyNDVIUFVPUm5sNnluRDE2dG1kbmYv?=
 =?utf-8?B?bmZwRGx6NVFMV2F2UkpoMGt3S3N6Q3ZrZHpNMkpmUThKTkhZUS9KdzZxbVVp?=
 =?utf-8?B?dHhCYkZVRXVJTC9vbUkrRnJOSmw4KytLVE1ZK0FIemIrUEpFeVVMWllQUlBw?=
 =?utf-8?B?TERVZXp6dFRQdVFESzVlNmtYdmNrb3FLVE1rbGNveGRKYkhDaFk2Y0tERlVJ?=
 =?utf-8?B?b0k4QURpVExjaFJia3M2UE1jRkloT3UwcENscHVDV1hzR1c4djltdEs2WkRO?=
 =?utf-8?B?eFBLZW5GWXhFcHJYTm1NNi9ITGljQWs5dGRycCtlRnNaZ21UMThMNk9LRUs3?=
 =?utf-8?B?cEVYMmg3c2VnamdsYk9jVXh0S3dmZURVRHFZUVJFc05YOC9DQXJqc2FSSnRK?=
 =?utf-8?B?OHFXRTByU3lGRTdNRlNWdGdSWFJJNUszR3pMNGVQeEwxd1VmUEVyaUFUbXdz?=
 =?utf-8?B?Y2ttSVNSc2htTWQ1L01YTEFEWWgxTVZvQllwQk1JZlRqak9JeG5pM3EvSFcz?=
 =?utf-8?B?OWtISlJadHRKYUE2SUJoOFZzbjJtc0c0QjNXNjlONis1bzRxTTgxQ25rdFBK?=
 =?utf-8?B?LzgxWHRoaWJvVGxDNzhDZldVbXQzZFBYWENpRTBGMVVYQlMxU2pSVzhra1Ni?=
 =?utf-8?B?MU85Q1V2SitBZE5yQnBXYTBseDREU3R5Z0h2YUREME1PcCtSL0FzbGp2c3E0?=
 =?utf-8?B?cVlLb1hjVmpjRHBnd3U4V3dBK05ZaDZwOVZvMjF5QXJRZGtabzNCbEZUdjB0?=
 =?utf-8?B?bGYvVVpseFZsWU1QOVZ2TnNLSWtLcHdXdnYrN0JqcWoyS2VUbldFeE9WZ2pv?=
 =?utf-8?B?dkNXZFJKSDR0SlN1YnlzYlBZb2w1R2c4dUJLeXNJSTN5T2NRbVkyY3ovNzhL?=
 =?utf-8?B?VW1FdC9tMU5JZWV5QmJQVkVwZ1RpVWFxUFlCVnF5ai8zdmRibWhhK3BNSGtx?=
 =?utf-8?B?K3RBSGo2OW81VzV3VlN5VGl5NjBMZzRicGlUUm1OUVhQQzRFczM1NmZGVzVu?=
 =?utf-8?B?SHZxK21BUWg3dENoZFNuNU9rRk5yKzZ6Snh5NkpDOXBHOUNSQW9BMGtQaFdS?=
 =?utf-8?B?QStIdWFyVkpWVHVtYStsRVRuY0JyMGtxMUhBbkJCUjFzUWQ2cFJmT0VaQWRI?=
 =?utf-8?B?ei9KOE8xQnRPNlN4OXdubDBpOGI3Y0lXUWkySS8yUS9MOUdYbFRyRU5pRkQ2?=
 =?utf-8?B?SFc5K3FSeGtDeGlLalc1K2k2YjNubmdzM3I2NWlnVVlQMXZSbE5Lc1FJMFlz?=
 =?utf-8?B?OU91T3hjMm5Qb1MwN3BCNHJaOEVPOFFDbzBRWlM5b3JRWGRZQVlxbnVHT1VO?=
 =?utf-8?B?Vk9BamRtMzNlZFJYZHk4OXNIMG8wK3htSXdwaldmUFJvK1FPN1JHMW1yaEtr?=
 =?utf-8?B?VVQ5R3EyUmZVbWwxM2xVZHBmc2dQa2ZPTjAzRm1GWDB6MGVUeGJwR2ltclhL?=
 =?utf-8?B?UmREOGx6dmIvdFdQU0JjYXV6N08yL3I2OVo5bkU1VVZrYXlrR0ZuMXlscy9h?=
 =?utf-8?B?bE1sNUdzNElrZ3R0TUZraEtXVHZOd1hTaWNTSUlyK1V6VzNxbjBQV3A2OXRm?=
 =?utf-8?B?endLY2IyU3I5N01LeUFRWjQwcm90ZVZaRmlRZDVUWFpidkUzL0FScHFIU2cz?=
 =?utf-8?B?UEg3YzRoM2ZINTNjSFc1QmtHQ2M0VW9MZ0ZFblVnUnJYeHA0Qm9UTnJmZmVT?=
 =?utf-8?B?THowZldReGpuMWtERlIvSTdUc3Zzdjgxbk96QjVnVERVVUlCcm43VDBwK2xO?=
 =?utf-8?B?ZVFJeVAzY3gyNHgzdUZTZkVOK0hxcmk1cW5JTWdNZkZOOG1tRkxNZ3U4MlFU?=
 =?utf-8?B?bU1ZaGR4Y1BhYmkydDU2M0hUakpseTJWbUlUL0xiT0JWUUcraEcxSHRCYXFG?=
 =?utf-8?B?eklXZzJtNjI5M05UYzRDRStlT2I4R2tWV2NiM1p0aDQwa0lkcmxGWERRcmdC?=
 =?utf-8?B?Qkh4YmtEQnovaS9kWmFlYmVhMUhEcVN3enl6RVJQLzRNbXJsZkNWZmNXQkNm?=
 =?utf-8?B?aE9XNGViN3VaeCtUb3BkeUM2bHh6VWlWVndsQjFUaEJ5UHk3eUNVR21QbXFx?=
 =?utf-8?B?T0lJUGVrYkJ2c2VSRzRWVGFGeTBVVitrVUtKSHdZSVQ0OFNIY2Q1dys5OTUy?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bkduem02NHhPaGtjNnBQQ0Q1Y0hMV1BLY2VQQ0xrUlRSdzJUNmVlTmtXKys2?=
 =?utf-8?B?WU00YmJZZDZnNDZyYUdYZnA3RytLQWIvVmovTUkyRXErbkh4S09meGF2UXZa?=
 =?utf-8?B?NEs5MVlvZENDYmI0TzlxV2Vac1hFdjhaM21YYVJVV1dLeVd4RjQwazM0cG5T?=
 =?utf-8?B?OFdncHpCTzZMV09UT2wwVlVwNzVib2VKYW9HZm9pdXpNb3hRQ01nYjFhRFd5?=
 =?utf-8?B?LzVJUjdhZll0Q0xGb0dvc0RxRGgyVEJjOW94dmE0UDRUcjJDY0d1MmkyUCts?=
 =?utf-8?B?eW5xR2loRVRPRmJRY00yOGNnTzE0NnpGdXRXNGF6YWExdUN3QldqT0FMWnpV?=
 =?utf-8?B?QW82ZDh5Y2hMOHF4VzB1RWk3V05mQnl1QXBpQlNxbEwybUVtZzR3VVVEVll0?=
 =?utf-8?B?eGV1OENUMlFvMFNnd1FIeWFWSmtGd0tveTlmSlpVbmtKS2QvSXplMkxmWHlu?=
 =?utf-8?B?MkVvU0l6RWZubktQblhqblllSWRzblZTM1ZiU3RnWUlacUhYY0ZmL3pGN2Ri?=
 =?utf-8?B?djBZTlFOUk0xRHdIays0L1VBY1I5YmFidlpDbTBjdFhKK1N5TUtlOFBsZnJK?=
 =?utf-8?B?d2RSOEc1R0VTVHZDUkFaaG5DaXE2cFppZWhvS21CZ0I1YytGR3ozSFFDeWpX?=
 =?utf-8?B?OG1wb2w1LzBnYlhTcnkyZjJQdlVVSy9nYjREUFpmdktTT0R4Z29kUFNtaUZ4?=
 =?utf-8?B?QksvM3pvMXBuNXlZZlp2K2xnZ0M0YURoaWtJQ3dkckxxWEphaGJJM3l4UVVC?=
 =?utf-8?B?QlhSTnVBelV4U2I0YWZpczNKTnZ5RENGM1pNUVhHZGs4Q09ka3dOeGNEeFRs?=
 =?utf-8?B?NUJ5TkZ0UjNESW93blBlbTc0VVhVNi81UmlLeklTU2hUVGpKNHA1WjV5aVJ1?=
 =?utf-8?B?dXRjWlNIYjdWcFUvRXcyazVPQ1dTQVFmU2QyTmlGTnZCMmVqMEw3KzZ6TktW?=
 =?utf-8?B?ajJNb0V1dEJMaWdXN2ZHaVFISC83RnpXclFRMjJJMk9URDgvWWtxVXR2TGtt?=
 =?utf-8?B?aUFuOHFORkFxOGg5eGVzQ0hSMzd3TlZsUEE1YTJ2SE00SjZEdWMzdTFqOWQ2?=
 =?utf-8?B?Q2FNTXFaWmtmdXBJdjFYWGZ2OFJRRytLVjl0M2t3NGtVQ3dmNEp4ZDN0Mm9L?=
 =?utf-8?B?bThMa2JDMmsxNTlXc1VTV3JlYUVnWjdaTm5qNUx1MWxvK1lJOVQ4YTJYNldV?=
 =?utf-8?B?NkZYQnRRcklIcXVkSUs4eHRDdFFkWDYrNTZCVzJZa01PWXlXakZmSndzdWt3?=
 =?utf-8?B?NkRJaC9WZnJuaWNxcENxTzQ5aFZVam9qQmplYVhIbjcwc3lITnpIWTBZeHVL?=
 =?utf-8?B?NkZ1M1BYYlFVWnRCUG9rMnpJa0REU0RmcnA5STVSTS9sTEc3ako2T3dPRmJv?=
 =?utf-8?B?emZaYzJUYU8vR1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f8903f-5ee7-4f65-9929-08db99bef4fd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 16:29:23.8396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mS/gT3TFv2AqkZqq1jBajoAstd17TJvLVWMe9LZc0LCtdZnVchwGwBZO+M9paRmF/uaE7ZhFUwp9EihandLLhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100141
X-Proofpoint-GUID: 140FHvDZ6kd3-ILb7yZ5_cpvjB6FQ4Dv
X-Proofpoint-ORIG-GUID: 140FHvDZ6kd3-ILb7yZ5_cpvjB6FQ4Dv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/23 09:49, Kefeng Wang wrote:
> 
> 
> On 2023/8/10 6:44, Mike Kravetz wrote:
> > On 08/09/23 13:53, Mike Kravetz wrote:
> > > On 08/09/23 20:37, Kefeng Wang wrote:
> > > > > 
> > > > > Cc Mike to help us clarify the expected behavior of hugetlb.
> > > > > 
> > > > > Hi Mike, what is the expected behavior, if a user tries to use move_pages()
> > > > > to migrate a non head page of a hugetlb page?
> > > > 
> > > > Could you give some advise, thanks
> > > > 
> > > 
> > > Sorry, I was away for a while.
> > > 
> > > It seems unfortunate that move_pages says the passed user addresses
> > > should be aligned to page boundaries.  However, IIUC this is not checked
> > > or enforced.  Otherwise, passing a hugetlb page should return the same
> > > error.
> > > 
> > > One thought would be that hugetlb mappings should behave the same
> > > non-hugetlb mappings.  If passed the address of a hugetlb tail page, align
> > > the address to a hugetlb boundary and migrate the page.  This changes the
> > > existing behavior.  However, it would be hard to imagine anyone depending
> > > on this.
> > > 
> > > After taking a closer look at the add_page_for_migration(), it seems to
> > > just ignore passed tail pages and do nothing for such passed addresses.
> > > Correct?  Or, am I missing something?  Perhaps that is behavior we want/
> > > need to preserve?
> > 
> > My mistake, status -EACCES is returned when passing a tail page of a
> > hugetlb page.
> > 
> 
> As mentioned in previous mail， before e66f17ff7177 ("mm/hugetlb: take
> page table lock in follow_huge_pmd()") in v4.0, follow_page() will
> return NULL on tail page for Huagetlb page, so move_pages() will return
> -ENOENT errno, but after that commit, -EACCES is returned.
> 
> Meanwhile, the behavior of THP/HUGETLB is different, the whole THP will be
> migrated on a tail page, but HUGETLB will return -EACCES(after v4.0)
> or -ENOENT(before v4.0) on tail page.
> 
> > Back to the question of 'What is the expected behavior if a tail page is
> > passed?'.  I do not think we have defined an expected behavior.  If
> > anything is 'expected' I would say it is -EACCES as returned today.
> > 
> 
> My question is,
> 
> Should we keep seem behavior between HUGETLB and THP, or only change the
> errno from -EACCES to -ENOENT/-EBUSY.

Just to be clear.  When you say "keep seem behavior between HUGETLB and THP",
are you saying that you would like hugetlb to perform migration of the entire
hugetlb page if a tail page is passed?

IMO, this would be ideal as it would mean that hugetlb and THP behave the same
when passed the address of a tail page.  The fewer places where hugetlb
behavior diverges, the better.  However, this does change behavior.

As mentioned above, I have a hard time imagining someone depending on the
behavior that passing the address of a hugetlb tail page returns error.  But,
this is almost impossible to predict.

Thoughts from others?  
-- 
Mike Kravetz

> 
> I would like to drop PageHead() check for Hugetlb to keep seem behavior,
> which will keep seem error code if isolate fail or success on head/tail
> page.
> 
> Thanks.
