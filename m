Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A1077CE53
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjHOOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbjHOOlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:41:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8AE10C0;
        Tue, 15 Aug 2023 07:41:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAKqBr015301;
        Tue, 15 Aug 2023 14:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SJPx/GlkWpJrNZrBlojamPZ57DrGgWlPa3smFeX6CvQ=;
 b=tgv6ahlER8xZiuymKR/8JpG38HzzWlty3mgV09x76/CwSOy+ArqVs/usrnyDbaMr2QkJ
 SnXBmcZNdhC4e0H6jJiDE/CMCiqHIC21sREgLfH3Ro/H8c9dLMo31iU04djINT/XBKl0
 zCTf6gMzQ8dg7qFZxGYvRF6ENtFdePkcp0R8QUuOrAUIjcE2Z8LkGY9lkI733YIB9K6I
 u7JnCwNAXthPpupPR+srcYYaEF7bHxzkR7wrOSVwHVAh3ryIwL8XaDuwSdLc4jmjd0VH
 dnKZHwjTWh1yhE7QcnAda0JQWQSDUHRpzK79R27WqRdm5nleyEVMN4vzCdJBA+x8X6AO Dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwmw2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 14:40:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FEQd6S038898;
        Tue, 15 Aug 2023 14:40:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey7053cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 14:40:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvZe3/awgFd5zE4x860ql/RHpkLqpy0GRsjNL52Lu2aP+SMZbaGu+4Tsz8JwKwhhre3vcGmVVk0NoXBnlTZcTxCqXKGA0o/PdcQEzRuMjw2NfM+Rl/vvea+OqSAbHTvblh7iu6Z+V0YqfsCMbZoDFjOiUbRaen9PngSwiQSiD0NHizg/iT6qoTh1QtgL8K7BDfBgtBJeFUml6k/I9Yyagz87/gi2/suHe9aOr+z7G1ocwQepj38rSW5dlX1dIksDGo2UZR5fJYlmXzrsoCi+wvdC9GRSRKfkJ6pbhv7ih7gdSjOu6PTQhn2NqHFVgz3ADeA6cHskFEsQ3c4zI33xhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJPx/GlkWpJrNZrBlojamPZ57DrGgWlPa3smFeX6CvQ=;
 b=n2PQ/XDkeN8qyWxVwK+xWGVa6msNmgdlJXT6VQRNmntSZBJuUVoOZ3QBtw1SriRajJOD2nvM6SsTN2JtKA/NycfPtUj98RnqUsKrehxqlWeJ5JDa0NbFr0OQghbkch1GaFL6P/Ewm1do6jTLY/Ppu0y8i3TQKxatIQxaiZurstvLA1iz7UpXScgT9tzeTXDkhNOWXcPU9PzRwZ1r3OaS2lCcTo9x3duvVg1epnAftPuofp+oC5nBQ0rMRn+3hIKXmo4YY6wA1uzIv9KyJixDeGZFgCuZJoEbLrcp0opDV3lbUMBQnz1luz4iy1S2a3QKhr2iKN6pjYQke6OJGlMWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJPx/GlkWpJrNZrBlojamPZ57DrGgWlPa3smFeX6CvQ=;
 b=a/COj6kPi4ItYc48mY5bzdTdhEJlGKdgyt65V8uXdXcJha9F7eU1iyrFu9O5bfxr71DKTO7JPwwbIvGVfQ/ERvJSxEXqG5xTega8sQ2cu0A6Gw9OfJ+0O9iDjtXyS7ihqOS4AbTEh+A6En7aGZep95M0g0w9TtS0qsByLXtqq1E=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB4859.namprd10.prod.outlook.com (2603:10b6:610:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 14:40:39 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 14:40:39 +0000
Message-ID: <36c4a86d-7b91-24c7-bdad-0f3ee1c2b7e7@oracle.com>
Date:   Tue, 15 Aug 2023 09:40:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v27 2/8] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230811170642.6696-1-eric.devolder@oracle.com>
 <20230811170642.6696-3-eric.devolder@oracle.com>
 <188cfb39-7d10-967b-3150-22dac6e95baa@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <188cfb39-7d10-967b-3150-22dac6e95baa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0182.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::7) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: efe1be1c-5d9d-45b9-86ab-08db9d9d9806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ucavBMNMUIqaS0XmYxJAGrsNqOCkorIzdiPzEcZW0GXsMyZ6w3Zp+AdLwHVjFS3lbn92Ru+TY1sxclnBcQgRS4dzxRBAJlfgdJU1qYIGIOxMpn0Pg0TOn6d12W985FiANpftFnRWri3HBJirEOPSqJA7QGCPyIjjL5d6KTA50GHKpqenajbmhXeHvq9BGofQLc4KmbvfDWN9v40nzL/6OaNHAXuTOvNyrarf4XxuI/MoXKrO+nhhEwMfu+uAoWismpH84k9updCcNqxaqaj6NYa6vMnwj1IcCRKNMSP+UgqPPfn0XNErjIkahhoq9GpPP1iDnRsPZqYBIC8TAYAuZNRh+kqsFxOpAyfdqdOChQy1I7SSqPRkIIK7I7bBF84MrwQ9F8vvlxNAY8nvk8kTxl2p313aEa9LsuOBUmsizEKZBfjMQxT8wP5arO6aQ8/s+pbs+CVGlrnKiasayuhsC8+AKHDvnqoN2I8YkNw0MlBL+a8YBdf9hmA/VQH3oMHyP9G32lNd6nY6jcDtok21NWrQUJ/l76HqHAlAqNrMBirjoiwXt9DVp7b05ztRFNS70b7cpOIqSvMPjkC9nE7z9v8KQOxRnosrNI/GReDPU1Yc+0dbjfrZv38eCFBzJffq+5vgdl2kiXiQ7pj7bEVWOqvZv00ur4ApBxdls1ywwojMAgZehhPmbpjB6Xan9Lmf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199024)(1800799009)(186009)(31686004)(86362001)(2906002)(36756003)(31696002)(66556008)(66946007)(66476007)(4326008)(7416002)(6486002)(7406005)(2616005)(53546011)(6512007)(316002)(107886003)(8676002)(6506007)(478600001)(26005)(30864003)(83380400001)(921005)(5660300002)(38100700002)(41300700001)(8936002)(6666004)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk5yT3dNbktvbndXdzcwZythczNiWGVYL3FoNFdleE5FeUNENHVIbk9MOW54?=
 =?utf-8?B?TStJUkpYektTZEJCaEloMHhTTEtaMEpRY1NaWkprVWVRUUJWTjA5bDRtM1Rx?=
 =?utf-8?B?ck42QWlNakxmT0wydzR0b1FFMjlHSVQvWWpxc1JaMFMwdXpQRU1DdTVZNmx5?=
 =?utf-8?B?M0d0WURsWkZvb3p1UVE1NkVRclJsbUpQcGRtWVhXdUFtV1k1TXlrSE5HclVj?=
 =?utf-8?B?MDhmNUxkZDEzSHVvY0MwZll5dEJHVy9iejlhK001OUJkQzVlTGFyUUg3dVYz?=
 =?utf-8?B?bFl1TWdsMlpiQ1F2bEY3QWIxVHJIcVJXSzR4NmZwRDZPS05PQ3BhT1dGNDIr?=
 =?utf-8?B?QkorNUVvY2FqcWRVbkVCZkFYeG1DWEdIbnBXTi9iNENEamExRHl1VUlEZ3hE?=
 =?utf-8?B?TGFwYlhqNytaZU8xN1lZeTBGK1lsOGRkOHZ6UXNwNXBMZXdkS3hRWVczbVpY?=
 =?utf-8?B?ZzlIclhadUkxY3Z5TWNBZGR2SWMzM3JjY2MzQmZTOUFTOThWWFU3T0IvWTRB?=
 =?utf-8?B?QnNyck1rRkFmMTY2NTZWQjlXYVp2c3pLOTRDQ3MzSVlkM0xVNWozTmpzVHV0?=
 =?utf-8?B?MTF3Sms4TnJPR29uR3BvY25XdDRWQVRLZTA0aTVyREpyenhmTVRrejdkREk5?=
 =?utf-8?B?UUdvY2ttck91M1FEbWRUdlRpYnduQ3YwRi9ycThKTlB4MU1NWXhNSWlHYWQv?=
 =?utf-8?B?RHd6V0k3RE8zTHAxYjBCeTQxQm1jWWRtT29YU0RHbUpzOXBXcTVFVm50ZXRn?=
 =?utf-8?B?K3d3NWdybmlVYWRhTmwycG9ER3EvKzN4U2dJZWU1K3FSTm54ZjZzdFp6U2VR?=
 =?utf-8?B?aE5oM0pUZ291Q2FkbDZlejB4SnhyUG9MUllodWk3SllMSzlPRnpBYWRUcm43?=
 =?utf-8?B?b3VwRm13OHhkaXhOclBwL0Y4RjZTWHpYL2ZjZVExYmxtRDlOQVp5aDIySUFy?=
 =?utf-8?B?M0dMUHlCalZPWURnQWl3Y09GR1VXSHJGek00OGl1RkNBeWcrSWtxUXdqUjIw?=
 =?utf-8?B?UHZqbjdUMENmWVRYQW5KaUVpcmFCZGN5K0tDekZSVm5RZ1R4TVlja3YydnRY?=
 =?utf-8?B?M0xqdTlSZ2hsR3BDcGoyQjJMYW9SZ3IwUDR3UnR4QTVyOEhwR0JscDVMNFln?=
 =?utf-8?B?d1dXQ05NRys1QVlUcDBoNVRubFdkTmUrYWQwTGpYQkJVSExzQ2FSTkNjNXJX?=
 =?utf-8?B?Q2FYQjFHQ2grUjlseVlLWTlES2I5dVdnd0ZNL1dUc1V3Ym9WZExmSGo2VWN2?=
 =?utf-8?B?eVNIL29aMGloSExnc2ZOWWhUWFdKOW9DbTl2MUJHeVl5d2QzSFMxWHhTR0xQ?=
 =?utf-8?B?MjdBUUMwKzJWUjVnOU1oSlV3aFBUd0t5cFdYQ3F1TFRsRHVoTkF5K2Z2N01h?=
 =?utf-8?B?TCtoaUxkam5ieHJyTHR0ejNGQ1Jaa1pFdWNzWW8xN1ZzWjZNbERtc09zZmVr?=
 =?utf-8?B?NzJtT1BmbVF4aDhxdHZibUk4N0FXQ2Zvd0VZQlNPZmZyQktMV0N6MnViMkxG?=
 =?utf-8?B?RU1nY0NoRVljeDBZa2hObXVOVllwdHlDTFZHeFZBSlBnN0tUMzZ0Wk9PVjJj?=
 =?utf-8?B?UXh4WEJWcjV3NGYyb2hnY0tGSWtXRkVDT214b3g4NlNISlQ0WkhtTUppc2JF?=
 =?utf-8?B?K0hQaHhnbW1RTlZOeE15YThxb2o1Z2FtRmdsQkhhMmFrSUc1TyttQkw4VGU1?=
 =?utf-8?B?MjhabGQxaHplZFJWY0FmVkNHYnc5VEFNSERxMm5TSjNpSDZ0d0gyeWZYck4x?=
 =?utf-8?B?RkFySDg1U1o3TWo3bGVHajQ3VVg0YndFNWZwOHRkWk9iekZxeW14SVE1Z0k2?=
 =?utf-8?B?bVFRalJTNDF6MmIra25iOC9Td092dHlIVXJwWkxOdE9HSXdjTkZOVHVlR1RV?=
 =?utf-8?B?a0lqTy9MbzNKK0E4b3I4SGZhbjRZRW9SVi9EUHR6cnFJZ1l6STZKWUtENTRM?=
 =?utf-8?B?MEllYzdDcXRJNy9YQjl6bklISW00MTdvS2ZwMi85b3hzc2p5Y3VmNEtlV1lS?=
 =?utf-8?B?NVIrZHFlbzcwcnoxd0Njem42RXBkZ1RXQXorTmROYjFGR0RnV0FZSFRwT0sr?=
 =?utf-8?B?WmE0TzdqQnRQYjNjUHY0RmxtbzliZ0VVNUtya3huV2lHZC9rbzNuRjBISWtK?=
 =?utf-8?B?NXRvVDhnS2pZZlVXY3hPVmRCYmdJbmNETTF5bjlvR05Ia2lRa1BpVzF0WDV3?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QjJKRGNhSlM2cWgyd2NQUGM5OUMyb1p1ZUozMHlUTkl4cGE3dEVQZWo5UHFx?=
 =?utf-8?B?T0RxV3BYdjVmbS9majdLd3IzTFVvVUU0NDA3MnNVNjFFTHliQUVyeGF4Uk1i?=
 =?utf-8?B?ZVdvV2pWNWRRSk4zV1hrNEp1c24xYitUVHNUL2pVZVU1d21OVXRmSU1JVmRJ?=
 =?utf-8?B?Mzl3V3JnYnVkU242eHFWTmljemhBWXlaRkNWT1pDd2o2bm8yNTE3ZlpjSFhl?=
 =?utf-8?B?MURhS0FTNlVmT1AxYnBVUkZ3WXo2ZHpJN0VrYkNYSTk2MmlRaEp5a2hxSE5N?=
 =?utf-8?B?MjZHNjZQSGZ6eDhmZThQdWVxQ3RUc1dibDRVVmJ4eGVLU2FGUWEvSEd3QVla?=
 =?utf-8?B?bmFjQjNvMWsxcCt0dStwaGVHc3VGaHd5Ujg2QlhGL3JOQWg3QlpoY0xrakpk?=
 =?utf-8?B?bFUvUGRacDlOUEJDZk9UTGFoVlM2bU5Ia0dlQXN1ek80L1dROVg0TStxcDhY?=
 =?utf-8?B?YTNMa1hsLysxQkFGcTlxSEJqcVNja0ZQZnFyNFNER0RMMkh0dTYxbVA2N2NS?=
 =?utf-8?B?bjNZVmhZLzV5dlNmOC9OQkhJMzRqbnZYeXhnZGZUdkVUZkFyRGx1cUE0Rnk3?=
 =?utf-8?B?ZlVIL3lxV3VNYm1PaXFoaHBhVmZCZ0ptNVNBcC9RSHlpbWFRZURNUTRneXpm?=
 =?utf-8?B?SVpIanM5UFJKNjExdnNBaEdNd3pmbzd1WW5jakUramhpTDZLTWc3SUxBVE0r?=
 =?utf-8?B?UjE5Nmx2NnpwVnZMb0hMb3NndENDNCtibXloSWlPNzBqc0dwMEtzcmxQZVkx?=
 =?utf-8?B?SXZ0dllEY29lajJKaC81Q0xlOGNuS3hpV2dJMWljZzFxMkVTWlE4ck55OXZU?=
 =?utf-8?B?QlhuQXZuMno2YXF3dHMxM0t4QWRXbjZJL1RnTWVySzdISFZxUUh1aGljVXJB?=
 =?utf-8?B?VGRrYS9uL094emZyKys3NHdCUVRxNm1RTjlBTUZSc2FXVFJNSjVJUFcyZVNN?=
 =?utf-8?B?a1NCUHJaZTBtT2VjM09RMnV0U1JpWmJQdUZ2WkEyVGZJZ04vcTI1TE5kTEZK?=
 =?utf-8?B?UzNpdTN4eXU3SjltOWdlUFMrUG1IdVZzaVU2elQxUlM4a0lZV1Rob0pSQ0xF?=
 =?utf-8?B?R0lTUUxZWVBCNi9MSmI3Wm9LazBvOXBvY0ZLZVRyeEFQZWYyNFg3aDc4MENn?=
 =?utf-8?B?dWl0SGJUanQ2a25keDhzMVE5VFI3cTBTMmNDTmNwRGQwcFhhYmR4UkFyQ0RO?=
 =?utf-8?B?RExoa3ZTV1lmditrdlVVZDBaczdEd1VEd0tXVVdwNjJPVEhDbDFNeW5vVXhM?=
 =?utf-8?B?S0ZpSVB2WSttMFpibGcvUm02L0ZWMlRTMmZVNEt3eEpiUWwyNnUrYkVKbE1m?=
 =?utf-8?B?QU14NDdYallTNW1HM2sySCt4NjV0RTluVWE3ZHJWUng3MEJheXFWOUI0WU9t?=
 =?utf-8?B?eCtvUzV2NFl2T3FOWTJWNWoyMkV2cmw1d0NzOG5pcElVUHhhbjEzeGttWTBQ?=
 =?utf-8?B?ckxFTkswbm1uVE1HSzd4Q1M2aFphWFVHbXVWTHRySVRVeUpyTDV4R3ZtRXZv?=
 =?utf-8?B?ZG1nSzVNbDRLdERxQTRKc0VRUGQ5VEhtclgvZUNsOWI4aUxnaXVkS2crMXlz?=
 =?utf-8?B?STVId0lJNEtuTXYwYVdaMER6VVdqajNNK1JUL3YyeUIzWHB4eHBKamk0V1pC?=
 =?utf-8?B?YWtYVnFIU3A1eFVTRU8zNFhKSUNoT2JJMEE2WXhXN2w0Nm11bStrdVFrY0s1?=
 =?utf-8?B?UmZLemh1QmlrUmxmbmJ5VlJOcmdsMjZ6NVd1bzY5Z3E1ZmQ5Q2lKQUZQVjVX?=
 =?utf-8?B?Qmp6aFNmdnlGbmtKTStxN1RpdUplZFMvY0VXR1JHeGk0ODVZaTRwaW02L1E0?=
 =?utf-8?B?WkNVQTd0RzB5WUF0eXRNUWFnTWdQZGlwNFZXOTRhazhNZzBWT0gxVGYrYUU4?=
 =?utf-8?B?OVJkL0R4eFhFMXhzUmtEL2ZhZE1FbHk4eUJic0xnc0pHVEU1dHcvU2hLQ29G?=
 =?utf-8?Q?EMXkTw/679E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe1be1c-5d9d-45b9-86ab-08db9d9d9806
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 14:40:39.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfNTzvOnVK6AELaF33LKdFJB51dbu+VKcVFBensIhHWfsQ7JhFJCFZp2jibZxk8+v6tF7GZYWSVuR45isT62/+AE7TE5GgUnh0fO8hpHdWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150130
X-Proofpoint-ORIG-GUID: mEYmn33S_N4i1r6eNc91yQ0w2Qk1kxrP
X-Proofpoint-GUID: mEYmn33S_N4i1r6eNc91yQ0w2Qk1kxrP
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/23 05:47, Sourabh Jain wrote:
> Hello Eric,
> 
> On 11/08/23 22:36, Eric DeVolder wrote:
>> To support crash hotplug, a mechanism is needed to update the crash
>> elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
>> onlining). The crash elfcorehdr describes the CPUs and memory to
>> be written into the vmcore.
>>
>> To track CPU changes, callbacks are registered with the cpuhp
>> mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
>> crash hotplug elfcorehdr update has no explicit ordering requirement
>> (relative to other cpuhp states), so meets the criteria for
>> utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
>> state and avoids the need to introduce a new state for crash
>> hotplug. Also, CPUHP_BP_PREPARE_DYN is the last state in the PREPARE
>> group, just prior to the STARTING group, which is very close to the
>> CPU starting up in a plug/online situation, or stopping in a unplug/
>> offline situation. This minimizes the window of time during an
>> actual plug/online or unplug/offline situation in which the
>> elfcorehdr would be inaccurate. Note that for a CPU being unplugged
>> or offlined, the CPU will still be present in the list of CPUs
>> generated by crash_prepare_elf64_headers(). However, there is no
>> need to explicitly omit the CPU, see justification in
>> 'crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()'.
>>
>> To track memory changes, a notifier is registered to capture the
>> memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>
>> The CPU callbacks and memory notifiers invoke crash_handle_hotplug_event()
>> which performs needed tasks and then dispatches the event to the
>> architecture specific arch_crash_handle_hotplug_event() to update the
>> elfcorehdr with the current state of CPUs and memory. During the
>> process, the kexec_lock is held.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   include/linux/crash_core.h |   9 +++
>>   include/linux/kexec.h      |  11 +++
>>   kernel/Kconfig.kexec       |  31 ++++++++
>>   kernel/crash_core.c        | 142 +++++++++++++++++++++++++++++++++++++
>>   kernel/kexec_core.c        |   6 ++
>>   5 files changed, 199 insertions(+)
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index de62a722431e..e14345cc7a22 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>>           unsigned long long *crash_size, unsigned long long *crash_base);
>> +#define KEXEC_CRASH_HP_NONE            0
>> +#define KEXEC_CRASH_HP_ADD_CPU            1
>> +#define KEXEC_CRASH_HP_REMOVE_CPU        2
>> +#define KEXEC_CRASH_HP_ADD_MEMORY        3
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY        4
>> +#define KEXEC_CRASH_HP_INVALID_CPU        -1U
>> +
>> +struct kimage;
>> +
>>   #endif /* LINUX_CRASH_CORE_H */
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 811a90e09698..b9903dd48e24 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
>>   #include <linux/compat.h>
>>   #include <linux/ioport.h>
>>   #include <linux/module.h>
>> +#include <linux/highmem.h>
>>   #include <asm/kexec.h>
>>   /* Verify architecture specific macros are defined */
>> @@ -360,6 +361,12 @@ struct kimage {
>>       struct purgatory_info purgatory_info;
>>   #endif
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +    int hp_action;
>> +    int elfcorehdr_index;
>> +    bool elfcorehdr_updated;
>> +#endif
>> +
>>   #ifdef CONFIG_IMA_KEXEC
>>       /* Virtual address of IMA measurement buffer for kexec syscall */
>>       void *ima_buffer;
>> @@ -490,6 +497,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>>   static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>>   #endif
>> +#ifndef arch_crash_handle_hotplug_event
>> +static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
>> +#endif
>> +
> 
> Isn't the above function should be declare under CONFIG_CRASH_HOTPLUG?
> 
> Thanks,
> Sourabh
> 
There are no compiler warnings/errors, due to the nature of being declared static inline.
And most of the other functions defined in a similar way in this file are not guard banded
by CONFIG ifdefs. I'm inclined to leave it this way.
Thanks!
eric

>>   #else /* !CONFIG_KEXEC_CORE */
>>   struct pt_regs;
>>   struct task_struct;
>> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
>> index ff72e45cfaef..d0a9a5392035 100644
>> --- a/kernel/Kconfig.kexec
>> +++ b/kernel/Kconfig.kexec
>> @@ -113,4 +113,35 @@ config CRASH_DUMP
>>         For s390, this option also enables zfcpdump.
>>         See also <file:Documentation/s390/zfcpdump.rst>
>> +config CRASH_HOTPLUG
>> +    bool "Update the crash elfcorehdr on system configuration changes"
>> +    default y
>> +    depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>> +    depends on ARCH_SUPPORTS_CRASH_HOTPLUG
>> +    help
>> +      Enable direct update to the crash elfcorehdr (which contains
>> +      the list of CPUs and memory regions to be dumped upon a crash)
>> +      in response to hot plug/unplug or online/offline of CPUs or
>> +      memory. This is a much more advanced approach than userspace
>> +      attempting that.
>> +
>> +      If unsure, say Y.
>> +
>> +config CRASH_MAX_MEMORY_RANGES
>> +    int "Specify the maximum number of memory regions for the elfcorehdr"
>> +    default 8192
>> +    depends on CRASH_HOTPLUG
>> +    help
>> +      For the kexec_file_load() syscall path, specify the maximum number of
>> +      memory regions that the elfcorehdr buffer/segment can accommodate.
>> +      These regions are obtained via walk_system_ram_res(); eg. the
>> +      'System RAM' entries in /proc/iomem.
>> +      This value is combined with NR_CPUS_DEFAULT and multiplied by
>> +      sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
>> +      segment size.
>> +      The value 8192, for example, covers a (sparsely populated) 1TiB system
>> +      consisting of 128MiB memblocks, while resulting in an elfcorehdr
>> +      memory buffer/segment size under 1MiB. This represents a sane choice
>> +      to accommodate both baremetal and virtual machine configurations.
>> +
>>   endmenu
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index b7c30b748a16..53d211c690a1 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/vmalloc.h>
>>   #include <linux/sizes.h>
>>   #include <linux/kexec.h>
>> +#include <linux/memory.h>
>> +#include <linux/cpuhotplug.h>
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>> @@ -18,6 +20,7 @@
>>   #include <crypto/sha1.h>
>>   #include "kallsyms_internal.h"
>> +#include "kexec_internal.h"
>>   /* vmcoreinfo stuff */
>>   unsigned char *vmcoreinfo_data;
>> @@ -697,3 +700,142 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   }
>>   subsys_initcall(crash_save_vmcoreinfo_init);
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "crash hp: " fmt
>> +/*
>> + * To accurately reflect hot un/plug changes of cpu and memory resources
>> + * (including onling and offlining of those resources), the elfcorehdr
>> + * (which is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories.
>> + *
>> + * In order to make changes to elfcorehdr, two conditions are needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources; the elfcorehdr memory size
>> + * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + */
>> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +    struct kimage *image;
>> +
>> +    /* Obtain lock while changing crash information */
>> +    if (!kexec_trylock()) {
>> +        pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>> +        return;
>> +    }
>> +
>> +    /* Check kdump is not loaded */
>> +    if (!kexec_crash_image)
>> +        goto out;
>> +
>> +    image = kexec_crash_image;
>> +
>> +    if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +        hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>> +        pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
>> +    else
>> +        pr_debug("hp_action %u\n", hp_action);
>> +
>> +    /*
>> +     * The elfcorehdr_index is set to -1 when the struct kimage
>> +     * is allocated. Find the segment containing the elfcorehdr,
>> +     * if not already found.
>> +     */
>> +    if (image->elfcorehdr_index < 0) {
>> +        unsigned long mem;
>> +        unsigned char *ptr;
>> +        unsigned int n;
>> +
>> +        for (n = 0; n < image->nr_segments; n++) {
>> +            mem = image->segment[n].mem;
>> +            ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
>> +            if (ptr) {
>> +                /* The segment containing elfcorehdr */
>> +                if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
>> +                    image->elfcorehdr_index = (int)n;
>> +                kunmap_local(ptr);
>> +            }
>> +        }
>> +    }
>> +
>> +    if (image->elfcorehdr_index < 0) {
>> +        pr_err("unable to locate elfcorehdr segment");
>> +        goto out;
>> +    }
>> +
>> +    /* Needed in order for the segments to be updated */
>> +    arch_kexec_unprotect_crashkres();
>> +
>> +    /* Differentiate between normal load and hotplug update */
>> +    image->hp_action = hp_action;
>> +
>> +    /* Now invoke arch-specific update handler */
>> +    arch_crash_handle_hotplug_event(image);
>> +
>> +    /* No longer handling a hotplug event */
>> +    image->hp_action = KEXEC_CRASH_HP_NONE;
>> +    image->elfcorehdr_updated = true;
>> +
>> +    /* Change back to read-only */
>> +    arch_kexec_protect_crashkres();
>> +
>> +    /* Errors in the callback is not a reason to rollback state */
>> +out:
>> +    /* Release lock now that update complete */
>> +    kexec_unlock();
>> +}
>> +
>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>> +{
>> +    switch (val) {
>> +    case MEM_ONLINE:
>> +        crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
>> +            KEXEC_CRASH_HP_INVALID_CPU);
>> +        break;
>> +
>> +    case MEM_OFFLINE:
>> +        crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
>> +            KEXEC_CRASH_HP_INVALID_CPU);
>> +        break;
>> +    }
>> +    return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +    .notifier_call = crash_memhp_notifier,
>> +    .priority = 0
>> +};
>> +
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +    crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
>> +    return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +    crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>> +    return 0;
>> +}
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +    int result = 0;
>> +
>> +    if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +        register_memory_notifier(&crash_memhp_nb);
>> +
>> +    if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
>> +        result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
>> +            "crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
>> +    }
>> +
>> +    return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index e2f2574d8b74..5d323255862a 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -277,6 +277,12 @@ struct kimage *do_kimage_alloc_init(void)
>>       /* Initialize the list of unusable pages */
>>       INIT_LIST_HEAD(&image->unusable_pages);
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +    image->hp_action = KEXEC_CRASH_HP_NONE;
>> +    image->elfcorehdr_index = -1;
>> +    image->elfcorehdr_updated = false;
>> +#endif
>> +
>>       return image;
>>   }
> 
