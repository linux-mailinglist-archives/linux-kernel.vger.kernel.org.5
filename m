Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20678131A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379500AbjHRSzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354786AbjHRSzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:55:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAABC3A98
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:55:02 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IEkuIp013564;
        Fri, 18 Aug 2023 18:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dG13tgDu0m45FYs48RMeIltoL3Ok2cnt3+W4n5SvHQU=;
 b=nvsWs6zVEmTNmGkMC4mSZxNH7XcqcNyRxYnAkfG8eQkAP+uwfbwZYWxx+nLICo+VsVLM
 Txjlkyd0aA2H3663BZhocxbYNaIH940saFUlSSoEqwuXh3Ls1x4heuz1haOcVdcD4kkH
 cQxtQPoX4dp/lr48BUlAM8q80JuQGmzmXtv3u85hGKLEw9pzuf9AajFARW6IBYv6/37e
 WUwSny8gHRbbgVHzIdY/IUbStG93pKYcdjkCxMWLsc7dJmueZzhTfGXShy9VAHw15RBp
 vQQo0ny8IsZpebGObRX47B0OLvgOhXP3lFtCQSv1C8UTGOW1vRdNUhI0SBFuVRpG1Mi6 HQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30t4p7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 18:54:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37IGtFdP027629;
        Fri, 18 Aug 2023 18:54:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1wgasx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 18:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb+pxlUBVxqX8aORACflCxTt2nVtifcYi+JzomDqDqXJLOeN9eFldJ2p7TXDXzT6GoNMBZKH+uU0muNNgxkjRAzcHDOhdXwOSoXkbFVwY0pkGnD+YohTTaP7sLpNTqRYYqkQ15wZfNHbeQOJbVkde+sh/evMdyR/26OqLt/IAt1/lUffgIMvPoeOm6WCJe9LfsdqIJHnu2kNo51zO0N04GykbWIDCwHjzvgCTB1Z/o1k0c7EE8J/Yr89UOceraO8tRdzMvr4YrS+tvgSn3d5uusczascbgSQ/WQuIO27rN6Z7gN3TGYdqIqEQvpiOZnFPj52GlzOuh18BWZ3D2RnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG13tgDu0m45FYs48RMeIltoL3Ok2cnt3+W4n5SvHQU=;
 b=jddFXIY++JWmVktEFPmSIW8VyRc8lciVKoxvrHRdRMVetBMqP1sFr2+5uBJwcGr4Zfg4uxlXjLutsIuLTJD8nU+OTBKTN7lhiWT/4eBtr/WPvghvA3+7Ot+iGEzNA5xh4D++lYejOs0YVHe32gvp96vEXxk+0YEptlKYsZTfizrvTsH/EfYZPN19Ig/RwEYzqe66If48g4rrh8jMnJAmz9vzfYwCvBcA4F77ID/2HfatiQfLpRzwRgnIlX6QUaRU4EWCIqKKhsxttJyeEe3IEcitX2uli576CCfyTKLQrJfcGJiabaU4LO+7NDtZirJmUjuBOezF7Yk9MC6NUotM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG13tgDu0m45FYs48RMeIltoL3Ok2cnt3+W4n5SvHQU=;
 b=PSk7BSRkPwfXzQcDxHqqpzwznpVCIcqHSrGspkTH/mSKGeC+kjIRWAKWG4I+nRBHuN6sLpUMui9emvvLvyq2sqw0qXUQ8yisTpD1jCJcsEGQlOhYQBegDrO60yvN48kTrEgVN6SFMAWEqsAC4bKcdnzZGvcjOcrf25yHo8UwiFo=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CYXPR10MB7899.namprd10.prod.outlook.com (2603:10b6:930:df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 18:54:27 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 18:54:27 +0000
Message-ID: <71864148-6493-30fc-ada4-6bc242b6176f@oracle.com>
Date:   Fri, 18 Aug 2023 11:54:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6] mm/filemap: remove hugetlb special casing in filemap.c
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
References: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
 <20230818110309.e9debd8b988cb8ca4a1019be@linux-foundation.org>
 <ZN+z3Q3hAn/GG+d3@casper.infradead.org> <20230818183407.GA5850@monkey>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230818183407.GA5850@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CYXPR10MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: df62e982-1456-44e2-6e37-08dba01c8c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmLCNS6FG6mpSo4pZHukbADCNoav5tTeLVyftnLKo4eeewunN64ySmoxwN1v6P+wYi+jrQfiVec50TXTS3zFJWRTXRmo+aic6eBub4NfObai/vqdUSAExQ12EQ7Dwvmxrqc3HmfwoAAV6mD/E/BLUdTmTgd94C1WeF2gfvycunY7xN8kFXG+fHVkiAo2zfyW9jRxDsy0WnSNR8eXsTfr5fk5iNZCTbe7xuOlVrcntQ74FcCl/9Yu7j65ODe6q4WQa+FvsGPq7ibytuGpb4TMF7/AUCMBsDHHiWdq+z52kQMWNwH55TD6/eZmyb4AI16WYuJMavF4i3kdb5WhoE5JoihzIx3O/ugzBCHIVcG5mkgzoFVUhk0JgNK+bUsntQu6Wb3XXMMJDW6Khxpd/4C1qnUXcBOC/RsaTmri7xVoB2nqbzS9L0Ii9JGM8jhPMy+bWqPsYRgL1MKGvb3Z/u3PbOySf/qv69mUCFmZ7oiY6t9iu/YZxvzXicN9EKme3ep4cbq5fnfwCYq0X4rtoXeZgVHjdMOiEcqQAmdNiuY1fNokycEnlJdhqqz0/USZBc8Ibsa5AQ0cUfvewJWgAgOdgndOuS5yRmW0kxgzc7CUPsuHF1ayuZH6FUPT/hhj5xlif2ah8moznjvRvIQnFt7g1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(186009)(1800799009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(53546011)(31696002)(36756003)(2616005)(66556008)(2906002)(316002)(66476007)(66946007)(41300700001)(86362001)(110136005)(44832011)(5660300002)(4326008)(8936002)(8676002)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REx5RWZka1NjQU9MV3o4eXMwWnpkTmFTejViMm9Bc2V3c2Fwc0Z5NVRFaWJY?=
 =?utf-8?B?MDVjZ1ptTFk0VDFNWFJMV0VIRDZ4Nzc0b1VMa3V5MVdreHJoUmo5eUJhWCtp?=
 =?utf-8?B?UWNlZ1dRSE1IYjMzc3NsZDBrVVd1dEJWOFk5QTNqTGhyaS9qYmgzRjZncktG?=
 =?utf-8?B?NGR0SVNVSDcwNlFqNUNUM2JhVkExRDRDVGc4VFFWenpVcGZIUWtHbWVidzZM?=
 =?utf-8?B?b0pMVXVCVWRwZzdRSmd0T2JmN2ZrS1MzVXVoeE9WRHFKckF4OVVmVWtPWUNI?=
 =?utf-8?B?NEN3YVZVeXlsQWJWRmFaSTJrNC9Ddk9WMnRzSWQ5dENDRXIySTRiT1NoS1BN?=
 =?utf-8?B?N0tvQmx0OE5KWnJodHlpTFQ0T2tCdFVzM3FjVXZpN2hYR2w5Y3RTdXdMRE9Y?=
 =?utf-8?B?dXlJU2xIUlhnRFh5UFlMRkNmdS9SRTV0OEluVXJnTWtNaUFyL1FXeWdzM1M0?=
 =?utf-8?B?cHhxb0lPR005TG11MzZTbFlzcmhpYkR2TkZOdXc2K2dsYjZuUDYyVkZzaWto?=
 =?utf-8?B?bzhKZndNT1ZLamVzc095amkzU2FYOGYwcXlWUGFtVTNza3dUUGs3NEUzRi9z?=
 =?utf-8?B?bTdndk80VWErbDhEcXM2UmlxdWxqeVN5Wkk1RjdsaG5oUi9iUVJZc2V2SDlP?=
 =?utf-8?B?cnFXRTBnaS9SNzlVNnVXdlpkT3pWWWZiWFd4WXc3SWh0VWF5TkphY1E3cEZQ?=
 =?utf-8?B?SktxMEV6WngyNW12cHFIWjJSMGNXR3M4OTgxQ2M2TUlzL2tJZzZ2YkhyeHBI?=
 =?utf-8?B?YmxkZ1lYWDJOeE1FSXlEOFlMUERUcWJ3eG5jcFFGckQ4Wm5TQUVTd3lza21j?=
 =?utf-8?B?UzNHYUVqSlNGd05Xa29IU2Rwa1lpUi9KSE9NNnZlb0ZpZllzRnFLbEZDbTk0?=
 =?utf-8?B?NGxqckUyTEdqTi9iUHcxMVFzRm1vaTd0cE9mdklPSVZMVVJ1ZjJUZTZaVU1Y?=
 =?utf-8?B?dDBjcTNRNjBpeER5OGFDNng2R1RoWWwreUwrYWJtOFRrTVgzUGZRWUU1MDQ1?=
 =?utf-8?B?ZWV1dXdiWHh4OXAyOC91a1UwNGxTRFNwUXlFdThIOWVjM25FeEtFM1ZhY0FJ?=
 =?utf-8?B?R3VSMS9HaTFiZDhMNS9EaEljQVNwYTJCZkFmVXNSTHNSSDlMVFMwS3hoVTE4?=
 =?utf-8?B?b3BaOTBNY1IrWDRYTVcyUUxYcG02RjNocmpaa0pCaGtBV2JSMndCVjhCeFNl?=
 =?utf-8?B?bjdGaHM2alVidzJtSzd3dlR5V1UycER1RmhYa2ZmTjZhQUltdHF4ZHJXaXQy?=
 =?utf-8?B?cGNmQ29ERmdrMkxTYmpuMGZJSDNKZmdaV1YyQ0wrN0NSVjUxbXhRdzFJVG9x?=
 =?utf-8?B?bTJMakxFL1lFOFRmUkNkYkduNDBZUHkxOWNnTzNva01MbHR0bTZiK1JqUGky?=
 =?utf-8?B?VnBuOEY0aHZrV2F6VTR2c09iOGVPOHlpTVgranNrM1JXczBJQkVONnJzU3Jr?=
 =?utf-8?B?S3pITHhLK2t1b1RnTHpsWTJacWZSTm40RkFvc3RVT1drTVlTM0xQTUYraUxV?=
 =?utf-8?B?TDVvbGQ0NjlJRGU5OGFjTEhNTGg3MnB1SFhDYzBXMmtIbUUrd0NWSS9mbU5R?=
 =?utf-8?B?RS9qRHRYVU90MVZrYmZjM3hqeE5ndml5VmJaM3I5ekVnQnBKU1JHL2c1NUxx?=
 =?utf-8?B?UEFKWlhkeHZ2bjJWZ1Bvd1FFRFJjamJTTDhPbFpRR202YUhoZFVZU01YZWFR?=
 =?utf-8?B?RElIa2lnUnM4Uk1NTzlXYmxJRW5xdFhXWDFHTjJhall6aHQyNXhQY21EZGJv?=
 =?utf-8?B?TWJydk0ycE4zZDlCWEhOUnI0SkFBeTdRY2I5cVE0RHRiSmp3LzhOUEdkVTBB?=
 =?utf-8?B?azBOd05hSjlCVjdySWw5TVRGVXdtOEhaR1MrcER1NnF2UWJQL21HS1pSeGN2?=
 =?utf-8?B?c21PZjBFQlRqTTZxc2ZKd1p0bmllTFNycWVOU2lPN2JmWjRBQ0VWcU5DNmNY?=
 =?utf-8?B?ZWN4UXQwY1hHcnBUQ0llQ3ZxT2svSEg2L1laWG5TMUJiWmcxeG9sb1MrWDZU?=
 =?utf-8?B?S0pFRldTSDc2S3Jrb2xSdWhjZy9CN2Q5T0V5RU9TbS8vR1BqZHlOQjhTQ1VK?=
 =?utf-8?B?NUpiMnh3SFd3MWZjNDJ2ekxhRFRlRG1CblByWTZ0THZrSVc2ZTVkSEdFSnBJ?=
 =?utf-8?B?UkRkdkpvU2Z3R0NsQmMwR0NSU214WVhUUlJ0aldvcGJXUENNWmtubFpUaGxW?=
 =?utf-8?Q?wsLzkixYhYYP/Mflp18SolM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XbyQc5bE16610BaKBE7fRBu+jDbywrL1ls1XF1DX8diHdqLPMAQR5jTxnlrPkcWyPBYxSoSYVj1yTrCcMV8uRnA3QHAumOwfbL/c1IyCyLe/zfXJGxuGG6dydnjIgJ4E0IZ5xKHx3GbY2A2zvq5Ex8/6JS160K9OIJvkF+N3BPq67o7Rj4QcSvafP6sWORK9biwaZZy49Y+6fjYDev+5yGn45jWnXH+grBY5tbpDpnNQCIrbj+754qgXwrOAwQfjDqR76BSzFL/NcoPDMFe+eqs2h6JHiwnhJeliETnFMMynhezGa5SsticHgKWkWa+uIpInp02T7EZbAY/6Nk0sqx6xuYIXy1YFhQ9x3l6Zn2vwU3/ji/Dylq66PlzWchTWt1O7mtNdJOlm2xaHXhYxGaepHY6q+d2Z7etQk1FTKKtedAJGtEDCY70M0vC+sPejR0hd0JhuOUJFAoQo8Xx4oFw/J3rM+9gkUaDIOoz2N/VY9BFYyee/eMZilPHS8iH4nXtusZQ7NT4n42wAg0X5s/2zcxttRFpHM8vrkg4+iW72zLFjS1Y9Uxk/RV3BFrgnbxgrlHgTDHfP3WIzI/gnq4qQVcgJv99+f1xxhtmwon0y0r/CPrOaqA9BC9Ox3nDAgeGQ0DM/QzT+xsP6PFnlsLlYcdlEiJl+45xmoP8nJ+jfB4vv5VpL9NgwMb7+CAJf4Ccu4VbjeX8NYyWUNyyDHMaDgVk7lmnGbmV+lAOrgjbcmrLoryjDQ/z+2d+GJmA7q8hxgzG54td8IkOZO0PrSD09llDPLI079xwoW7wHKp/34+g8U7ZETXv7rSFXhWAEjupC2vrnnADlNdT4fu98baAd1SPZMkievNlwX8eN0wtiEn3K4nPTUbBHArnzSB1VJ83UDc8hsB8LU/cwDJgpXVW3zS9XYghHmbztCaHNtww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df62e982-1456-44e2-6e37-08dba01c8c17
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 18:54:27.6130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDIkcrXGNdwuKPieNx4vkRXXeZRQs4n8JpNK5onYql6/VF1E9WkAEEplByIrVHDOewz80UJ6BAWpYr9ewo6yiMJvASXSMxG56WHAd+iNtv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_24,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308180173
X-Proofpoint-GUID: T9ia5_I-kTc8_bCuTWe1TiEGwtLBwMRX
X-Proofpoint-ORIG-GUID: T9ia5_I-kTc8_bCuTWe1TiEGwtLBwMRX
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/23 11:34 AM, Mike Kravetz wrote:
> On 08/18/23 19:09, Matthew Wilcox wrote:
>>
>> There's also a conceptual reduction in complexity.  We no longer need to
>> think about whether the inode is hugetlb or not before doing the lookup
>> and scaling the byte offset differently.
> 
> I 'think' this was the primary motivation for this patch.
> 
> Recent discussions about HGM always came back to hugetlb special case code
> in the core mm.  HGM would add a little more, and most people thought there
> was too much already.  Most everyone in those discussions agreed there
> should be some effort to unify hugetlb and core mm code as much as possible
> to reduce these special cases.  This is one step in that direction.
> 

yes, the motivation for this patch came from the discussion about the 
various places in mm where hugetlb is special cased and how there should 
be an effort to unify these cases. As Matthew mentions, this series gets 
rid of branches that would occur on every page cache lookup. The 
comments in pagemap.h also mention

- * (TODO: remove once hugetlb pages will have ->index in PAGE_SIZE)
so this has been a goal for the page cache.

Thanks
Sidhartha Kumar

> As a hugetlb maintainer, I don't like any decrease in performance even
> if it is not readily observable.  However, as a member of the mm community
> I like the fact that there is less special case hugetlb code.  Overall,
> I consider this a win.

