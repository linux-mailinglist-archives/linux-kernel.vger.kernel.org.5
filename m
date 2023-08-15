Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C7477D4F8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbjHOVNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbjHOVNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:13:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49DE1B2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:13:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FJjMHj000636;
        Tue, 15 Aug 2023 21:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=UjOKzX8EvQg04VP37tItvpxGkSxHLAJw7MNj+s9xTR4=;
 b=289M0BxNxi3BPaqEIVbPYKQ8tcgyVpIj3pv9ah9UJy+hdkIk9gerEh8DCOTguFFCnqhc
 jP5il3TYP308NDB5TIsiEJj4WXgwf6bQj0gPrxcS/pcPlu333Bh8u6cOpvHDxLW3Nzpo
 pWbz/AYU5l1jgsRV5YZwj98+YSzTPwvjHPMyojn4CmNQBAkVbpSDSPgH+kBaZ+PcqOtd
 Fvldpc8wMaY1vrU0diI8mvafC8yuGAriOAyBSSWh5fG8i6OUegkc3UkRcxdmXItIM64k
 /MiTLHu5cOBC8lWjvLguAp1F2Ksh+Xggd3acXUENfXLy5vivqzEg4IIoLu0PGqNrUALl pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349dqte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 21:12:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FJHYXw027394;
        Tue, 15 Aug 2023 21:12:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1sjt4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 21:12:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu+Bi5ilib2gnTfDpzmfeZkQcO2LFvbXJrgl7q3f8Tk7M90MAI4KnR1+qQ/zFjwXS59q8pdMwRwMX+7QhHsRkcS2GMcKploXXyYxHMG3ASNGy4YDoegkPRol7+Bb400VrS3ZcxVRZVwq71RC7QtFhyN+PpSlTueMm182NRjzODv6P2ZramvtCPFFk2xWf2IgceF0dtrwUJbczfkyCy2qFt2jIiHdMHBtkYkwgZNfASiWgKnbODjJG2n5I6VlUPm8vMR02GtE05vKxiF/TAe+7JNdT/omYbSX4903MATN/5dFiUaaxAK/T4vZVdNIV/2r1SWUQIEQrqzQmBhBvFaEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjOKzX8EvQg04VP37tItvpxGkSxHLAJw7MNj+s9xTR4=;
 b=k1uUO9EJ878SCNzRPYZC3vOPwYipfnJ91r6kEaZY+V6w6qzt7QwbqbiLkKoW6+AEd5/4FmQdh48bEeJIUNM9WDV5X0Tz79wEq1O9WqPCYTSfi245B6I//vbH6xH0eLbrB3rWSi61P3wHL860BXX81JOr6zgXWEAGQ2Cvb5P5baJtDUL2AJnUmm8Pag8MfPiKiKXpPX/SpiQDLMpVzDNtVhjWoczfMPHPtj5bOGm4ym+i6JB+YV4S7Dtvms4+6OexhgzQUcAyOfIysdVt01pcwbrcxeYn//piwaccTbCuozhSlWMjJrL4Fo15cUM8eUdC8PxLh0dTb4w3bAAabteg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjOKzX8EvQg04VP37tItvpxGkSxHLAJw7MNj+s9xTR4=;
 b=b5iBu9RjnP/vLGVJlE/mYNiyUwXR0bKzrf0UNXuJFQwqbOWURhdUJ+y/vkkqiFjcSLfCGJu1V2OV8OKRp//Rrio0TUpPCG2It6oVkbe+579eS0nirXcwqNa965bRETf10G8C4KwijXmbIQ86d1BJYODGXUBbdbXxPiY3dGsTVgs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5892.namprd10.prod.outlook.com (2603:10b6:a03:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 21:12:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 21:12:29 +0000
Date:   Tue, 15 Aug 2023 14:12:26 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>, Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
Message-ID: <20230815211226.GA4150@monkey>
References: <F2621E68-F36E-493C-8619-ADFE05050823@nvidia.com>
 <d184ba78-97d1-a264-fc31-87dfdbe6fdff@huawei.com>
 <de0100e4-d673-428b-8d50-11ae2b7a9641@huawei.com>
 <5BBFF5D3-3416-4C0E-9FDD-655661657D67@nvidia.com>
 <a34778cb-61dd-4853-9961-afd7568cd0f7@huawei.com>
 <20230809205316.GA3537@monkey>
 <20230809224424.GB3537@monkey>
 <2da95492-079b-43b1-a950-d290984a21c0@huawei.com>
 <20230810162920.GA4734@monkey>
 <87wmxx7y9j.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmxx7y9j.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:907::46)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: c4eedf4b-835a-43e6-b854-08db9dd45514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22kWptDpD0iARTSitFwrmB/XxFStkt332XxCzAPuhVwmSOx/SqdnN1oT++zfiIdctLKmvJmmmijbtR6DJxujjO6RtHnIHMn0ANs4OXO+mJkTPcchINGmiQ+GcZTzHeZG0rMkKuRaoZRLXf1bQEF5Zfy8VQULM9R0jK1fUxTiHfhji0icKA1qLkDaZ4Ml7U2mZS+yyLvpXYtjaXKb/cC0zMvT0W59p/+yPsOMNJpk22K1eajlVCtzIlQjDTL3Cl1VmNoHnYtriay+s0rDG3FwYRLz4hAqoQgBFra5o2LSr5ILTyfR6wzvUY36a2QgI0Rub1DjS/6TffPvHvNt4XbPnVQpX+Kc2LrAkBhOS+6LTvW5rJVpydPXSvpwGeTXpzRBv4cyDfNO+2ekhrvB/uOfpqEtU49s5Y+0rk4k0E+TxjwgXCFhiYJ6r3JW9shnOSJe+KFr899ZLPmBc3Wk++5Genv47vTaCjCYSMljiezVtIEHB/FTefEGsw2rlqhZWlUVvoOtBc+vCDmrJM+FyI13TMewt3HPHSs1HpPgOq2ZJqYX0lweTMxc53+crDV6budU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(366004)(376002)(346002)(1800799009)(186009)(451199024)(38100700002)(66899024)(478600001)(4326008)(44832011)(41300700001)(53546011)(6506007)(66946007)(66556008)(6916009)(54906003)(1076003)(316002)(6666004)(66476007)(9686003)(6486002)(6512007)(2906002)(26005)(83380400001)(33656002)(86362001)(33716001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3BWbUIvcUJXOWkxZktVb0wram5CMm54SDBCd29qUjNMVGduUjB6MWxwdHBv?=
 =?utf-8?B?MytSblBDUjFxZktweGhNZlo2ZklIVzdTK1A3MjZkaFI5cEZ4NEp5NkxJaGpM?=
 =?utf-8?B?NkpaRHk1eVdGM3pmV1daaktkN0RKUGQ3cUFFMG5FQldodmUzU2d3ZkhJazRw?=
 =?utf-8?B?YnlUWXQvSElIazdtR2NMbjVJNHJNNncrQUtYdEdhYkFDZUR6KzhJLzdNaHhS?=
 =?utf-8?B?U3RtN2h0Ris3Yy9na1JNTDZhM1FOd2thL25IVnBwTklVdzZTU3BKSzlvcDVH?=
 =?utf-8?B?MzN6NzFLQkh5MERQNFIySVFhRDJJejVMREEwMEV1STU4d3B3bGRIOUQ5dTVO?=
 =?utf-8?B?Rm1ENkZCMUd0Q2FOWVZ0VnA3VHFnWFRKdUdlK3lYaUx2RERCODlrUk5yWnd2?=
 =?utf-8?B?b0VYWHFSeVl3UU1Dc0dWYjZZemtOaytIUjQ5VHdQNlIrekthTUcwSnh5UFBT?=
 =?utf-8?B?cWR6SFpJTDlLOFcra0FIUFBUM29rN3FTL0Z2Wk9ob09uTWdpZkxldlMxUnhC?=
 =?utf-8?B?ajMwRmdnei8vd1RzVWdicUdoWlh1YW4rUXJ6dnVnNW9oMisveGlaTnhZVndr?=
 =?utf-8?B?akRkem9sOWR3ZW1Ya2xTN3ZKZ1VrVU1nMHRQVzZIblBrNWxtRW81cGRLYkZW?=
 =?utf-8?B?SHAybjFGbWUrcXRwM3pJcVh3QWpyUzIwa0xRS3RudEpiM0prTEZES3Rzd25K?=
 =?utf-8?B?UmxaUVYxV3BvSWxhYjlaUE51c2Nlc04wV092NUc4aHdTRXRuc2VSS29aNWRP?=
 =?utf-8?B?VE01RGF2czJqdGZyY1RqakV4NDduZmFUcHc5c2IraGtxTnFqWFhpOXNUWWd6?=
 =?utf-8?B?TlpqU0RJQWlZNlU4aHNidlNwVmVOT3Q5OXVlTTlTR1Z2VkJrUDhlM0s3RnFr?=
 =?utf-8?B?cDBRem96MEVzQUQ0eXBndVo2T2w3Z3Rsa1hlWExvY2QzV3RmL2FQMEc2QVlj?=
 =?utf-8?B?c3VmUytlR29LWFlndlY4RUg4TGdjU0k5WDNMeXcwaDh0VHBzdWlqTXR3cExn?=
 =?utf-8?B?akFxVFBmYUswNUtKQzBrQ1B2M3hXSGVCOHMxbWIrRnB6ZTZacE5Wdi9oSlNl?=
 =?utf-8?B?MDJuYlh5bG93TnZMV3Q3aFd2eU9hR3ZVcmI1dVlLNlk0bi9jaXp0Z2JlYmxp?=
 =?utf-8?B?amd1SGdHcnRVN3R0Q2JRTUp3YnUxbEpCWGVwUlVUSkwwQ3kvVjFjRXJEeUNI?=
 =?utf-8?B?Z1pieXo0ckpaSURUL0xaYmtjQ0ZsMmFHeUw2K3lmKzUxbnZtMENHZ1hqSzFP?=
 =?utf-8?B?bGt0SWFENFdzSVZZaFlqemFGNHh6N0JqUVB1RDhxMFZ3c25sRkx4NVlCNUNw?=
 =?utf-8?B?NDVNbExqbjFKOHZwbW9tQ0ErbWs5cjdWYmJlNnlic0xuZWlrYlBJSjl2Misv?=
 =?utf-8?B?alRiNS9LMkZ0bGdmbFdnK3dCY2x2SzRiM3luR3BMVVVrd2VPNEhQRnVNRk5I?=
 =?utf-8?B?bVZjdGIyUWtxbkVRYnRyaVoyejBzc3pBZVF0Y3Fvd1hTUjhMR0hidGtwU1R2?=
 =?utf-8?B?V2ttVGc0clloM015NXlqMWZQem9mR2Juby9pbFB6bGU5VGovdXZJK0xieWFy?=
 =?utf-8?B?c25qU1hPdDdocVQ0R3JBcW9adDdqOGNWcHhPWjVJQTlNRGtXdXZVWm84dko3?=
 =?utf-8?B?QW5sVVRoYklsT1hSYkhvZTBGNHI4M2pNbG1zek9TelRQMFRQanZmWW1PVTNQ?=
 =?utf-8?B?dVhPVUw5THRTdytHYlRuSEoxOTg0L2FJR09IMlJhcXlVdmZiTit5bzBlajVm?=
 =?utf-8?B?WTA3V2lBZm1Sc1NGT05FREpLN0lUM1d0Z1JGWDJZSWxpTDNkczltRHdmaTdY?=
 =?utf-8?B?K3ZxNnQyUkNzK3VLdk5rWTBiUEdpTnFSa0dvNjVlcnFHc25hUzJKaFdPcHJB?=
 =?utf-8?B?bU5JL3JDSVlmNFBoeFFnWGVFTXNNcFYwLzBieHlqSWUyKzB0aHZjbVloS1Yv?=
 =?utf-8?B?b0FxQmxNWmZtV1pMUU9zQ1F5TnZ4TUQzRW9DMmxOUGsxbllDeWJMb1c5VFpm?=
 =?utf-8?B?UHY3ZDliWnNoK2RmUEZteVB2ZDZDZmFPSEhONllZL1FpcXl0ZGZVcGgwejRZ?=
 =?utf-8?B?RlVJUnFLV0ZaVlN6NjJudHFPYXppSDhCbFA1alR6emZxUmh1VFF6bUF2allK?=
 =?utf-8?B?ZmxUcmFvUVAzWStqUWs5bUUwYkhjanRRK2RpVHB2NjRUQk1zS0FHTlhMb1BR?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RTZVQnh4eC9pelVYeGtPUTBwR2lQdE5vL0ZtZnJJV3pKR0g0bzFISWVidjE3?=
 =?utf-8?B?Y3lYQzhvQnNmbldWUUhjaHV1UkJnOTVFbWZRdnRRRTNKSTZUVC93ZW9qQnlT?=
 =?utf-8?B?YVZSUHlPVTcxd2RLL0lkd2RPeit3QmtCQTRUK1JSMW1LVEZRSloxRUE5REl6?=
 =?utf-8?B?eDZWc1ZNalFOR05oUS9Ka2l6OXZmc3VsQnd6VlJEaWltcEI5czB0Q09ueW5r?=
 =?utf-8?B?czJkUUJFVFlCcm1ocTdiV0xrR3BiRG5zS0l5cm1xODRQK285NDZYR2trVWZh?=
 =?utf-8?B?aGllSytSbGdJSXNQOTZKeGRseWtuY2E2ODZPYTUrM0NwQ2xoVWQ3UlVRcmdw?=
 =?utf-8?B?cnFpaGpJNVFBYjRDQWdIMjUwdjI0Y1ZHcDFTL1BhZVF1NGR0ZWNqZitTUjBM?=
 =?utf-8?B?U241alkxM1gwS3V2NlMwU1lKTlphVzYzYXVRTDdaUDlOY2pwNlA2VjR6OSti?=
 =?utf-8?B?NTdZYVR0M1RwZDZvcDZTWU83TEIvU24yZkpqWStTZk1FRkFudHUyZXQ1SUJz?=
 =?utf-8?B?MWtBRTRyeUd5VnE4aTlRcXZzTU0wVTM5QUdxbmZJanlkR2lWRVQ5QUtoZnRs?=
 =?utf-8?B?YnFKYmpyYmdORE5iUllVaWJ6bnN2Yk1HYVlSaG5SYTl4dUExblVVOEZPYnk4?=
 =?utf-8?B?U0dBTDg5QWlLMXlpWmdmakpJWFhjaVlhZWtnYzlDVlF1K1lEVVVWVFQyR3FZ?=
 =?utf-8?B?U0YySFBSelBPRVhhU3J3aXdCYkdLY0RFbktMbTloTzZ0bC9tN2JUbHFCUmZU?=
 =?utf-8?B?czJrWHgwVnZkTHdwSVFnR0N3bXVhN2tLR0NjY3ZiNys2NGNjQVFudHlNVmF4?=
 =?utf-8?B?SHZqQWtuWWVXRjVmM0hGQUdMV0NLS283R2pjUU4rYytPRTNMV1Rzb09NODRj?=
 =?utf-8?B?UGl0bEVjajQ5NTh3ZzR3VDNMbElRTXRyZ3grT0xHOGJPUFo2MTRFSUpuMnFD?=
 =?utf-8?B?a3BvN2tHQUxOS1JSdERxQU45Ujg4REprcmFiSUxpaW5XbGtmVXFZa1ZRY1gy?=
 =?utf-8?B?SjNNcTVwWitaY2RkajRWSDMrZnh6Q0ZIUGMwZkc2c2N1MEtWaDNEUExYeHk2?=
 =?utf-8?B?YnZFcGUxYnJvTjZTUzNZZU5veTh0OHRWRkkzODJPWW0wVFdNZzV0VG1oQTRM?=
 =?utf-8?B?Y3ZXZlNlbTR6a0tUMFRKMGVlZC9aTEVwMmlqdFRGMzRiNmoyUWtidXJLalpU?=
 =?utf-8?B?bGJQQWtYeEJQMEk3QjMzSTJXaWx1blZvSVV0RVdWUElBOEY0U0UvZEJ1NEQ3?=
 =?utf-8?B?RVA0SWgrU0xOYUZ3TldZSFE4MTA0Uit0OHZqSy93T1AzNTV4SDFIOGp1dlZi?=
 =?utf-8?B?aG5BcU95RW1veTlFWVdkZy8zbHhkWWxXSVlCdmY3THRzNnFWQU50R3M4dFJS?=
 =?utf-8?B?Z2M0RHBYSkpGWnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4eedf4b-835a-43e6-b854-08db9dd45514
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 21:12:29.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCFwxYK2l1+U771b6oJS2M3MoCNqAJFKrN0xzxi1r00fsCN5BK30eWkcJu42+t3Fxjbq788bSnlI6UN0lUJeRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5892
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150189
X-Proofpoint-GUID: zvO0wanXDyaShlRbVlEB3UL9kewBgJQW
X-Proofpoint-ORIG-GUID: zvO0wanXDyaShlRbVlEB3UL9kewBgJQW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/23 11:58, Huang, Ying wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
> > On 08/10/23 09:49, Kefeng Wang wrote:
> >> 
> >> 
> >> On 2023/8/10 6:44, Mike Kravetz wrote:
> >> > On 08/09/23 13:53, Mike Kravetz wrote:
> >> > > On 08/09/23 20:37, Kefeng Wang wrote:
> >> > > > > 
> >> > > > > Cc Mike to help us clarify the expected behavior of hugetlb.
> >> > > > > 
> >> > > > > Hi Mike, what is the expected behavior, if a user tries to use move_pages()
> >> > > > > to migrate a non head page of a hugetlb page?
> >> > > > 
> >> > > > Could you give some advise, thanks
> >> > > > 
> >> > > 
> >> > > Sorry, I was away for a while.
> >> > > 
> >> > > It seems unfortunate that move_pages says the passed user addresses
> >> > > should be aligned to page boundaries.  However, IIUC this is not checked
> >> > > or enforced.  Otherwise, passing a hugetlb page should return the same
> >> > > error.
> >> > > 
> >> > > One thought would be that hugetlb mappings should behave the same
> >> > > non-hugetlb mappings.  If passed the address of a hugetlb tail page, align
> >> > > the address to a hugetlb boundary and migrate the page.  This changes the
> >> > > existing behavior.  However, it would be hard to imagine anyone depending
> >> > > on this.
> >> > > 
> >> > > After taking a closer look at the add_page_for_migration(), it seems to
> >> > > just ignore passed tail pages and do nothing for such passed addresses.
> >> > > Correct?  Or, am I missing something?  Perhaps that is behavior we want/
> >> > > need to preserve?
> >> > 
> >> > My mistake, status -EACCES is returned when passing a tail page of a
> >> > hugetlb page.
> >> > 
> >> 
> >> As mentioned in previous mail， before e66f17ff7177 ("mm/hugetlb: take
> >> page table lock in follow_huge_pmd()") in v4.0, follow_page() will
> >> return NULL on tail page for Huagetlb page, so move_pages() will return
> >> -ENOENT errno, but after that commit, -EACCES is returned.
> >> 
> >> Meanwhile, the behavior of THP/HUGETLB is different, the whole THP will be
> >> migrated on a tail page, but HUGETLB will return -EACCES(after v4.0)
> >> or -ENOENT(before v4.0) on tail page.
> >> 
> >> > Back to the question of 'What is the expected behavior if a tail page is
> >> > passed?'.  I do not think we have defined an expected behavior.  If
> >> > anything is 'expected' I would say it is -EACCES as returned today.
> >> > 
> >> 
> >> My question is,
> >> 
> >> Should we keep seem behavior between HUGETLB and THP, or only change the
> >> errno from -EACCES to -ENOENT/-EBUSY.
> >
> > Just to be clear.  When you say "keep seem behavior between HUGETLB and THP",
> > are you saying that you would like hugetlb to perform migration of the entire
> > hugetlb page if a tail page is passed?
> >
> > IMO, this would be ideal as it would mean that hugetlb and THP behave the same
> > when passed the address of a tail page.  The fewer places where hugetlb
> > behavior diverges, the better.  However, this does change behavior.
> 
> A separate patch will be needed for behavior change.
> 

Correct.

Since the goal of this series is to convert to folios, we should maintain the
existing behavior and errno (-EACCES).  In a subsequent patch, we can
change behavior.

That would be my suggestion.
-- 
Mike Kravetz
