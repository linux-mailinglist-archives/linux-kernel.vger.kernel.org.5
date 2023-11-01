Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B337DE1AB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbjKANWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343920AbjKANWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:22:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC38AF4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:22:37 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A184evY005406;
        Wed, 1 Nov 2023 13:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : subject : from : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=xZ+jqYdX3Vto0u9Q19/Ikw4AyvJ15h/CvamnLdP7+Zg=;
 b=JDS5mwt4bXICZNKDbHCRHl7AkQ/4xfacaOigseZ3DbsL2bMGeKzvxzgedwTCSRqq2hwa
 9esvOPmAVryTJJjepZFY0jCvg0JFY/AGH+ZJkhJRrqDvo5evB1j1JjHDDomgSEZFpNKS
 raKBaKj1UTQb2XZrRi+2OEk/1VqLlpY7z0yRDdL/5Eas7MWCMBPeJeMtUNizXTJnclS0
 DifApRBaD2cSEIv1L/+kNJAmx82apOL98ORA6fJD6n/sqjj8hVWMjJ9XTSfcq3aXFDEv
 5IE9vTUjQfEPIaP5jWxpl4us/l+cZv2x/ajgmIiP61OKroNH+xcYoIXInUad0u9/wy/d DQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdqewd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 13:22:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1BOGEm038116;
        Wed, 1 Nov 2023 13:22:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrd95wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 13:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XboW7TsqKRPQMFax0e9CpZYBAkxkJe8C0247wxfZo7ZcSZXaS1khsnoZJFGgWPPa4NcMVhLdXlVOzsr8Ef3ApuBrUOxqugEIKKn3gI+ip5fKLyfIZ6UfxjHN57voM0waej3ov7bwHhz6aepxJWFhLJlk/6DCIdq7Q2KsFirLYt8vVSmRoXDxIkGoTZsdzBXS3fdEieu3KqTlRcb/fYrB/SkVn43Sq8PmYnMVB2pzrHrb5LYNMQXJOi21oEjRFTB0SlCVK9WiCQjzBc17gZx/bYt4YlJMsvCl7kgTnVa3Z1lwDC03MQjvjdR9R9+XLs6u26xV99LZ2TB7kIUr88MJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ+jqYdX3Vto0u9Q19/Ikw4AyvJ15h/CvamnLdP7+Zg=;
 b=NxNieTR3SvdOo3Efpp9C2SrRDDxl4o2HKXBj2gqAiwqoUm3wVuw+gkoo0eNTKUbaRCm7HxIhYgUX6Xnjz/U0vZX9PhRyMWM1QFRWVbmXpRHzJ2A21dv8CnvcrHrmZcrYhzY1Izx6cERjdZBPZFyrAecjkKH1SzWTEocFKxoq4fTBvSE5zFW85brgtMOrDgKhgbtKYMXLcvagvWX6TdpPfu9kIIjjGlT4eRLt7K7QOoPCuhX/Ezc9TApQflrInC3tf2l6FJTqbjlaVMC26L83Y6m3B2PtMN5nH4K12Jpr1mLK808AqBaiK/7EEcNqrIHyTripFDBbS1eF9E3B/HWVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ+jqYdX3Vto0u9Q19/Ikw4AyvJ15h/CvamnLdP7+Zg=;
 b=z2+P5I5bXUSDQGMuvru4gayFZ1AxbIklR17daKv2sDWV+ufcsTlLdo6mt8Lb66ywfazBUYmck+qQ5jO/cTQCxvEL1HQlVxaD6mGUDyDsOWurMFFBIUmZizA2dBVn/lDuqk8EFBKnuB+dZ3I4UDwbUICg4q+asPeddU4uj0pRtUE=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CY8PR10MB6491.namprd10.prod.outlook.com (2603:10b6:930:5d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Wed, 1 Nov
 2023 13:22:12 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435%4]) with mapi id 15.20.6933.022; Wed, 1 Nov 2023
 13:22:12 +0000
Message-ID: <425ffc38-a35b-45c4-9819-e51464f58450@oracle.com>
Date:   Wed, 1 Nov 2023 08:22:09 -0500
User-Agent: Mozilla Thunderbird
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>
Subject: [GIT PULL] jfs updates for v6.7
Content-Language: en-US
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:610:20::28) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CY8PR10MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4ebccc-aeea-4574-9b45-08dbdadd8e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYxrGu2C4guVDmjjL41K8QlWqrje+EX1sFHNLIq6WRAIzSCMyMm2NHLUZNekns1ch9WfIcWkT54Om8Clr+LD8kSGMpfP/+V9bsxKdbWZgVCUOWrVyJGAdA3t/hSJQVz971fSdrHrDwc+svBv2RfnMCb1f2xF/aTTqncB2P9H4Mhukin6tbiK+nVyqCkW/nx1JhCNOAW7ifVR1Kyi9WNE1QHqFRqpNfpSa9D7Y3ThrWbq2x7gvq0Nb8dD1rVr3bd1mEmDA6UN236PG9PZac2BoVFam1xaZjqco31byn9UZt0pUU84CL7pmT5h8BX8j/2+pbOT0ou6qVy7QHpZ9BCBbOc7nsnNYlav1cWEP+SOdR0lVdsRGaJatoS5c86p1ijoEnKK1THrNHVz6bZ4auAlaRtfjkTIth5sOat5od5/xI0tEsjCIuQuDIce02jUIaIXUMqLNS8vDDSKGfL4PdYkiUl7XLk+iKTxwsRyoy6slUHogZCosfm6LUh22jGPVoFZWbLQGSk0JqzUVsaQ1hIWVBjxXtAXca6AwTGHCjXdvfBMNYRGE6/ZvdViRn8v/h9+G0HrJ/OnBRZqZlJlC+MNbKKGZ+KT4yl+cXQdDcM3VfQmwpWwGezjFfw8gKd15uIZ0Obs+Avzj+T1LkJ40HfR/YB14E3iQcH2mWNaQ0WVDmyqK8O+ah/bc8K2/T9dHDV2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(2906002)(31686004)(31696002)(83380400001)(4001150100001)(5660300002)(2616005)(86362001)(6512007)(41300700001)(44832011)(66556008)(66476007)(316002)(6666004)(6486002)(6506007)(66946007)(8676002)(478600001)(6916009)(8936002)(26005)(4326008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lQNlYvcUREWmZhbEs3ZWZFMW0rODM3eDY0R1VjZ1EwNzRwQmNBWUZpR2Yy?=
 =?utf-8?B?em4ydEpGWnJIakhnQS9wU2w4UXpBWmRUK0pkMGZ6anEydTJyTDUyRENFVnhK?=
 =?utf-8?B?czVtL3I4bVBUa1JNNjAxZUVFRktFdFF5SjBGL3RVMEpsRWsrTExya0hjMUxh?=
 =?utf-8?B?cThjRzUxeWJmVW5Sc1l0TlFGQXhkZ0REcTF2cGZ2WUJWR3VxSHNkV29yVS9Y?=
 =?utf-8?B?Q0I4UVV2d3N2ekxreEtxQ1JwTU9FSXFtUDhFSlhNNHBoNThrRkRaMWpNYmZB?=
 =?utf-8?B?MWMzdDk5QkczR2drWDBJaFhJOTFOeUhVUEI3Wnk3Wko2ZVh0YlQvOVJuWTd4?=
 =?utf-8?B?UDZHQW9XK3RpN1N4czVuZXFLNlFad0lmbjc1K2YzaXZRVnU0eEdYbXV0N3du?=
 =?utf-8?B?cjhocGszZWVlak5YcWxtMTB6Nzh0QnAyYmVGUW9IVXYrSU00SmJvbHRSLzZv?=
 =?utf-8?B?NWxUM1FzWlFhbjI4UW92YVlLMGFuN2YwOGpsaGZZRExXV0tpZjNBbi9FNzkv?=
 =?utf-8?B?VEtFSFNzbnEreUYwT254OE5kQXZiNE9MNG44WVYrYXNOVm40aTFzVklIaXM3?=
 =?utf-8?B?bjRhWFVyQVd6V0lSeG14N3FLNFEvYUFKeHZTMlA4S0Vsa25GN2h5ekwvTGdi?=
 =?utf-8?B?Z1BRN21hUHl3UlJQbjRCWkh5azAzZFdJZVdiZGoyVGdEVUUyNDhOTWwyZ2pC?=
 =?utf-8?B?dTVJVmNRY3ZpanQvUDR0emp3T0oxT1RuZGY5ejNOb09QaytNWEhsSU9TS0M1?=
 =?utf-8?B?L1pkblNmTmoxTzdPLzlvVFBIR0RrenN2Nm11Wi9vUnBFMEoyTlB5MWsrNERi?=
 =?utf-8?B?cVZxai90Q1g2eFF4Q1RCVy93cUEyMWdIMzdrWjRzNTl4bzdCWEZ4eVFyakxp?=
 =?utf-8?B?ekNVd3ZFMDNGU0ROT0FzSmhuRVRRNTROVlF2WlZRSmdTM3NxZHF5UjM5d2NR?=
 =?utf-8?B?YlNPTkYyT29RMGFHTDg2WGw3VHRacWVrNDlwRlF1aUpDZmlRY3lvM01kU0xX?=
 =?utf-8?B?dnFXbXFod2VGSXpORWg2czFmR3o3VjFPY0MxYXhUS3g1WURxNG0wbmZ2NEVK?=
 =?utf-8?B?Q1RsZ2xuWG0vbDZTVkpUSWx4MUEzUTI3RFZNNDRYZUkxZXNNL2puV1Vtb2pC?=
 =?utf-8?B?QUFvU1FjVFEvb2M2R0FRajgxVWZITklYM2hZU0xEcm01R1QvRzFDQUdXbm9M?=
 =?utf-8?B?V1Fja0dTS2Nva29HUDlLZnBKeldPSkNqVXlGOElIOUlQUjdYNStQYnQ2Y3My?=
 =?utf-8?B?YWFJZFdxbWxoQ3phcU96YkdHQmQwRWxyZ2tnRGpXeEtmOXFxKytWUThzR3pp?=
 =?utf-8?B?VUExR0NwTjZsbzVzQ296ekpRc1FJbXBESlFDTzV0eVBsdGErOGZqUTRaU3Y3?=
 =?utf-8?B?Y0kyWU9UdUFqSGJGSldQK05uMjVnQ1RyM3B6ZFc2aG9GejBwbG00a0gybjQy?=
 =?utf-8?B?TXNxUko5cFhkcjU4S25NYVFaamtreElXUmUxcXp3ZVdkQ1V4NFV1eGk3a0Ns?=
 =?utf-8?B?b0VKK0d0Q1FxbTRBYUg2cmlvRGdyV0R1Z3lLb3dsRGJUTkp3dG5WNlQrTkZp?=
 =?utf-8?B?TVYzM1J5ZXptK3BuUVVkR2g5MlVYUmd0VE1haGFWanBSUkc5UzRXcDNaZThn?=
 =?utf-8?B?dVlXdGdkMjlLZFh3SUZRZC9TZWV2c0JjeElRVEFYczBOcVg4ako3aXJXK2Np?=
 =?utf-8?B?MGtsN1RHUTZ3eGZBeVN1TU1Xem10dmNOOHZQeE1DbGh4R0k2ZFM2NkRQZmF4?=
 =?utf-8?B?cFA2SUpkWnBRSnNEdVlNMWNaVWdMK2hoNW9OZkxySjQrOUtuNGNLUlB2bHI1?=
 =?utf-8?B?L0ZtZHhyT0h3M2NLbFBZK3VINThMZzQ0YTAvTDk3aC9Sc2lkTW9idVd0ZUMz?=
 =?utf-8?B?T0hBdVlpb2J6VWRkVVc1UkFkTU9YTGV1THo1TDk1MVRqNXdPc2IzaXkwSTlG?=
 =?utf-8?B?b3BLdDA0S1k1RWlIZ2F2TlRkNkk3N0QxZkFMNlVCeGhBWmRKeWNDOHVNdEZq?=
 =?utf-8?B?QUVKN2c3TUUzd1gycGhaQTNQTzQwNWc4NkNKYVNxd2UvTlNnTVc0TnU1UWcx?=
 =?utf-8?B?NWJpVlJDWkF4WWlsdVI1Q0xIaTVaYzRoeHlld2dOL3J6WnBqbUpsTExHV0gw?=
 =?utf-8?B?VVhGRGpsYWJRQ3JYMGVvQVZsUVd3WEZYSSsyZkJSZ2xMQy9pcUJYbXF1THk0?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1Bw7fI2yF4623Hv4Yb+5B/sFNPusyj+jijwFZV4wnYJ0hWWP7Hpz6hsOtRqbcFrnbIYRBGBL0USMZO2eEqc0XflIx0YXLqPOZJLERmFg164AKQZ762MN9pVUvKyFiLpgfHITM2DhV1V1d3sQThKvDpY5b1zJW5v/U2xJgQ3FZFnCzHqJUhpYg+uLv5yVJBwkV7HDxmuSG3IUM0xshqtpSEpUdUtXprJ9/UJCSVguvZGs+5mztp3HeXqZiUFBz9ikZycpe7ngrAVPrdiDyc0HVwI4o5WYecRmuOExkgMG1UW6FHjhHypHLjU5W0XVzUHof0MbDPAtms6pQafYziB5lVvAVQPFhk7QwkbTAXfUBu2C7nsMbOCDF2l5YjQUw7PWW22+8nlhBpQF7C7k9TYF3XD5da3Kil53MUr/EvrS1jnHX67FTKsKTh7i+84b2dGhYjM6HFs7sgiNx9UYSk55bX2kPNJM0rYtJizjXqqBXpMeV6VaRqDG//nS1ELq73Xk81Gab4vvHw+/YVe1MMuGCMwwEyBIsXbK+hzrJ8CnZu91g0EVr2r7Ip2HEBSNsYJBL1OQ9MxLnQ9zuTZuHkozu9vPWklBwqiEZxqVzsfFUj9vuv+xUEyvESwnXAgMuMWBpsNTAuPOdf4IyjBqOIFmIqs9u7tLAWlYtDNoaqwlObqd2crk4N3lMUCvqrzHjLPY1T9XUsVPDQgXloLu56fmzwZrd1ISwzBF93tJc/muqV9nzNtRsJMCgO7rFa/WJoi5qWde1p1qZuzwQknLjyXrd4IBVClBVP/Pt/FU4drWoL4Ghks579+hbHSPQEZR+LbiVJbH5gS1K3yoiJPiAmML4TZdCC9pwBL51LyVnSkiitwa6pZgu/GD0spyMo/6mknI
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4ebccc-aeea-4574-9b45-08dbdadd8e97
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 13:22:12.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygdHWBV5ZWStSl3dXJ9mE1aNOLal5YZMimiQvcepYMM3CXrXmtVvZGTeLj1M4t8PwA2kUxx/hrR2Gvjy+NIk6tr8gn3AI6uVcMhGLSJ4DDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_11,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=792 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010112
X-Proofpoint-GUID: C0Uuti6qNEWXHQ_BN-3XQm3EeTOaJiKt
X-Proofpoint-ORIG-GUID: C0Uuti6qNEWXHQ_BN-3XQm3EeTOaJiKt
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5e62ed3b1c8a397185af53d6b94f04b9ff21ec7d:

   Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2023-10-03 10:15:10 -0700)

are available in the Git repository at:

   git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.7

for you to fetch changes up to a779ed754e52d582b8c0e17959df063108bd0656:

   jfs: define xtree root and page independently (2023-10-13 10:39:25 -0500)

----------------------------------------------------------------
Minor stability improvements

----------------------------------------------------------------
Dave Kleikamp (1):
       jfs: define xtree root and page independently

Juntong Deng (2):
       fs/jfs: Add check for negative db_l2nbperpage
       fs/jfs: Add validity check for db_maxag and db_agpref

Manas Ghandat (2):
       jfs: fix array-index-out-of-bounds in dbFindLeaf
       jfs: fix array-index-out-of-bounds in diAlloc

  fs/jfs/jfs_dinode.h |  2 +-
  fs/jfs/jfs_dmap.c   | 23 ++++++++++++++++++-----
  fs/jfs/jfs_imap.c   | 11 +++++++----
  fs/jfs/jfs_incore.h |  2 +-
  fs/jfs/jfs_txnmgr.c |  4 ++--
  fs/jfs/jfs_xtree.c  |  4 ++--
  fs/jfs/jfs_xtree.h  | 37 +++++++++++++++++++++++--------------
  7 files changed, 54 insertions(+), 29 deletions(-)
