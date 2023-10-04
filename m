Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB547B9729
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjJDWIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjJDWIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:08:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF821BD;
        Wed,  4 Oct 2023 15:07:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FJ0Sb026758;
        Wed, 4 Oct 2023 22:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fvOYeua8oTJ+siqVZLWaw9/b6SLPzypGdhIxxmiExeE=;
 b=Yml6ek4onBj8ix+aC2sB959BRzWEEOMy1hBFi/QKoLb0B/3okWr9W/hraMD7okYS077T
 aHakGBKtf12GSLrONbYC7ZxWuf9CY505uhr80i+c/BBj5yFpXrgQ9noB8RNUR+zPRMbA
 0yaee+YqK3KPUj6RgOj0nDC4OPXsx4ipHPWngshzm9f1d+bt1Ul+ZQ1fVd6Ni5oCZ18w
 E2ZWbFv2CW38sVNIADL6uAtgTA4KuVrvREaYiMhXTSowDLTxpfi2m35ogEy7cUPyCH9X
 Mk6n9qWNt2IjuDf7/ri6H4MZCVSoyto96kPR1XymPmeVnVjKrZh5wa+ComnGD0BdjgPq Pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3eg68k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 22:07:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394K2gSx005824;
        Wed, 4 Oct 2023 22:07:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea488fw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 22:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyyESgJMrjryFXd7ft+eOFz/eXYvwaWKJIIhujvttSqmRi57CocXUKhrEc8lH3HaDuEo2OkkBzr2ZjVjIqElErkO9ywrjnaWQdCV8/UNL5/XuTvH6HksdTFGf88j4GejecWJJ6T5UOdyAxKeNc6KVuv8jHI6aK2QRIIQWVWXXRkRXCAAZX8GZaR35MQ3oi0B7ZX0tj9ZNPCJV5IUK8/aAoipnl+R+PvizUzcbPoEE5FKLH0sKVR7Crt1w4Qg0V7aRIck699mGStO5FeiXI0R88dgBEfSAY2cPeweqiDcIrwDtlwjRhcvoZ1iwDDGhOx21YC8ojdYuktVH3zOHzbR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvOYeua8oTJ+siqVZLWaw9/b6SLPzypGdhIxxmiExeE=;
 b=I07kiK7KPDHNjI14qZmkOqoX85W1UgpXXnIseLZqnC/xScnFWmYv4BFNQ3Zkr0TroNkU6r0hbNzX1juTkUHFGa22Rk9C0lJvSZosEg17asEwTA/fUkwXROHy9AiwD9J2GkyieP+52HwcWaD4ytKmKFDVYASnq3O2rArWxkVKyW/jP55/0Cq36wDNCzuisKKWGKdBCJM43CEJFQxj8LTbTnwc3639iYO1dcVd56WTIXrKdJAkAmlIzjIRn283q1/tEeqUD98p9Bg1UGO1dwO7FL8NxiSdhvUcwGE+YqLMyCP2qkiYo5hEWtPNlmQXh581iXZWQZHnz8C/Hn1onn6WwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvOYeua8oTJ+siqVZLWaw9/b6SLPzypGdhIxxmiExeE=;
 b=MK/JSX4KUalAX6Pty4K4LfrdOmCcvVkbHv6X3ST/WlhsKiGGcL64pXym9sMDEiuAxMMhLe/Fi2ODOdkfCq8LvFHVyHDo3YaARefGlCJkhnG4fCSjh+awcMv0Y8ARxgI/9a56ivuLIcnRlbIzXMtx45SrRgSeLb599RUa2x5b3Zg=
Received: from CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23)
 by CH3PR10MB6786.namprd10.prod.outlook.com (2603:10b6:610:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 22:07:40 +0000
Received: from CH0PR10MB5276.namprd10.prod.outlook.com
 ([fe80::5b90:1cb6:408:90e3]) by CH0PR10MB5276.namprd10.prod.outlook.com
 ([fe80::5b90:1cb6:408:90e3%4]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 22:07:40 +0000
Message-ID: <ce2c92ea-9160-f14c-f3e5-aa11edd2e05b@oracle.com>
Date:   Wed, 4 Oct 2023 23:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
Content-Language: en-GB
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20230921085129.261556-5-johannes@sipsolutions.net>
 <20231004092205.02c8eb0b@kernel.org>
 <20231004123524.27feeae7@gandalf.local.home>
 <20231004095431.1dd234e6@kernel.org>
 <20231004132955.0fb3893d@gandalf.local.home>
 <2f749ade-7821-00fa-ba34-e2d25cbad441@oracle.com>
 <20231004174321.5afa2fb6@gandalf.local.home>
From:   Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231004174321.5afa2fb6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::21) To CH0PR10MB5276.namprd10.prod.outlook.com
 (2603:10b6:610:c4::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:EE_|CH3PR10MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6a28c1-6d1d-4d19-2a73-08dbc5265396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvFlJFVYWgbLLNBrCcC6gOiLBjjX8ts6gi1/e6ItiJDlSaj6q3YTk+nPDpMcTln4psgukPl47AYLoPbSHfVQ+Rtig7/CCptL6lA8NXcAfk/2YtPNJC6+n2+KeeHBVHcfga3a/FSSg1Cf22nrkHYZzI9RhswGf+zh5flp3zzirS1IIwN77AB1QrEBmyU6+ZC1DLEkNYNdP2COcyxBuKJdZpyrIhArshrj2Kw8xpdSQ5KZORxjnd6bo0NWoMb196uDvJxl7nl3BTRWg+40n8ij7DLQGHaWUfzUYRpi9AZaOHK8/gMf6g+mYb4AuKxkZ+bqutWQE2Ux3De+Z3AhH72xH6COCsfcdxMzYvAbWZInRd2Vg4TgMjmpkUW5FunYOQ8sitCk75B4sRgyd4ZoHm9rGpSBosGPslvZuRdEEmx8ASmaKXUu1j2CEGVrlduhGUoMT0OLjX76coroQYa56RLv6IvpKZKZwYwYPs00dAqmf/mqppxJSu2H5aES4cmONptLoOSetUNnrdKBUdc1M50CNkvksZmj957n8Wbv03ITko/f9jiEcw3WkNJM+pmtLhNuyky2dJQBh7zEzDKR95azJ6d+yYJlIGtoFbm1+ZIea3fpNSI5SThYVtLt3gWXb9xcBaJgUxchCH2m2bN8e7g0lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5276.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(31686004)(53546011)(2616005)(36756003)(86362001)(38100700002)(31696002)(83380400001)(2906002)(44832011)(6512007)(6486002)(478600001)(6506007)(6666004)(5660300002)(54906003)(316002)(6916009)(4326008)(966005)(41300700001)(8936002)(66476007)(8676002)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHYwMHZWaTV5bytQNVJTdWhkOXlMNmpYbmJ2VGlKM1FGeDV4M0p1NmxXNzJG?=
 =?utf-8?B?L1czMWhSQks4R3NOYkF3R3NJT2hBZm1acjA0dE5tZFRId3dEQVVneG96VEYy?=
 =?utf-8?B?TGpxU2Mzd0g3cXZFUlRwK0l5WHhpeUpDTllNVFNSOE1YZS9UZmRLTFVWdnN3?=
 =?utf-8?B?MVNZSk5WenBiRWpqM2pBQ2pVZDVEcHlNcHk1clhFZ3o1K1RwRkJmS3BzcG5O?=
 =?utf-8?B?YW1SMWZpMjNhZ2JUcUppYmhVWDRzQ2dzUUVyQ1gwSlhXS1FESXRaNTJBOEcy?=
 =?utf-8?B?dkw2LytSRWE0QWhlV3Bxa1lBVU9RSE5tWmE4VjNCWmhRbmNsanB1TjEvSG05?=
 =?utf-8?B?WUVoaCsvelRNK291WWpRaXp4bGRWbXc4WVBwMWdJN2JFRlRUbW1VMWc3Q1hB?=
 =?utf-8?B?S2Ribk4xMjdiRDZ5TUhRcFJOREtHaUhoeGF3NlJ0MVlHNDdRUHBudzlFcU9n?=
 =?utf-8?B?RzZjSWxaU0tyL0IwbXBrTzljaERYYzhDTk8rZ21lZ1ZSbXoyN2Izc0dsUmRX?=
 =?utf-8?B?ZnpnemFHWnE0WVBwTnY5cUozNmhJWis2ODQ2VnAvZVZyRjJIVGZ3bElpTnlI?=
 =?utf-8?B?TTFkZUplWDlrWlEzV1NFWTdyeWwyaElYOTVrQklVVXZFTWUzUjRjS2xjcHVI?=
 =?utf-8?B?eHZyc3dtL0JWQS9HcHQ5b1RRWE9qc0M1czNtdUJETitwcE44UjdoVmJoV0JB?=
 =?utf-8?B?S1JTQlVPNVNGMm84WVNPaEhuZC9WK2JFdzhVT1hKYmFRWHBQTUd3TEZwQnlT?=
 =?utf-8?B?TlVvcUMzNklodGpWZGpsS1gxZTA3bE56MVFtYlVKajNZeWhwU2JKaWI1VUVk?=
 =?utf-8?B?U3ZaN25VS3FWNXNjV3lGOTZ6MWdoZy9pRUlMSmZCVnNoNnR5ZkNmUkxCWEQ5?=
 =?utf-8?B?THlnVCtreTdYZ3Izc2orQzJCYTZDRDkxaTNFU3N5OE4yeDZWTFRyeW5DVVFx?=
 =?utf-8?B?SEhJUTl0aXZyL3ZjU1RTTU9qUEZHNzNzc21kYy92c0tWaTZ0R0dmblZtMGJE?=
 =?utf-8?B?aVNKVms2ZjBNb2FJL21VWE1sODdUUXk1Q2N2TGw0dTVKZ2hoeU9JeSsxZ2Zu?=
 =?utf-8?B?aTVCTmRwNXk4V0tZTks5SkhWZTVZb0EwTHlsb2lsNW5HQmNSNEVNbDBSMTkw?=
 =?utf-8?B?dTN1VStOMmh6QVBLdVM1WlVwdllnUkpRNXRCc0JsdDRkWEhBUWhKSFBoRU55?=
 =?utf-8?B?Vk1ETXorMjV0Sy9vSDE5VWFOczQrL1g3dkdyUnB0VDRicURBWUtJTHUrdDR5?=
 =?utf-8?B?SWk3YWpGL085Vnk0dTFseUNVcVk5Rm5UR2pLUTJXbytHcVMvRmdhQk1ZZnl5?=
 =?utf-8?B?WnVXdjFlbjFPWml5Q0xCcG1QYzliR1hjZ0gwQlBpUUNNWkU0a1pXWWlHSENW?=
 =?utf-8?B?K0N5bzg0d0ZFOE11YXJueS80MTBoOWMvT3NlMUI0bS9zSGlxYTR1RXVKT0tn?=
 =?utf-8?B?MWRGSFRaUTdqQzZqZTlwMWsrWVBjVlRoNjVMTk16M05KQmlkeGYyMFJhdHNp?=
 =?utf-8?B?dTdmd1RqTkVhSm11Yk1sVERKL2J3QnQ0MzNheVhqdlUvMXRSeE9xS0h1WW4v?=
 =?utf-8?B?dVZnWkZtVXB2U0hjN1N1RVc3VE9iYlprc3ZkeFlGeXpCK2hCOEJmdm5WTjlT?=
 =?utf-8?B?TjlTblppWmVVb0NmQVBIbVlqN1VGVjVsRStyenQwMFdocnhRMUE1NnFwUUZZ?=
 =?utf-8?B?UWh4NTh5Y20vLyt3SjA0ZDNOZ1cwRHNwMExPTzFsTloyYVM3ZWVZNUtBc29S?=
 =?utf-8?B?WTJqSm0vWUNDb01EQ2cvTStFVzFLdkFTU3JpbVowTTRSdTRnNlRwN3pZNk9n?=
 =?utf-8?B?cmZSSDh1QllBUHRXMmxwVlh5dFVsWndzZGVONEZhNUZWWkxHWUF3S0M0T0cr?=
 =?utf-8?B?bndxd0hMN0h1MFNhNlFyenBnVlBybTZUeXpMLzlmVmtjTWpMOWNTanNSWkdo?=
 =?utf-8?B?UnFXNFJHMC9qTFQwczQ2a3AwWityaTlKdnUrc3dLN241RkR0aWlBbnZEeXZN?=
 =?utf-8?B?T1NBQWpKUEt4NWJzeFZZWDZHSlhWaFZIUHFhaEVidTJxWG1MS1RrbGZXTGx2?=
 =?utf-8?B?SElsM2c2V2JFS2UrKzR5cFRqVXpNc0ZwOTU4eGRyc1lidGUzVUtPUWRuZytM?=
 =?utf-8?B?YTd4RFNYZ0hSdGd3QWYwR2FpNEZ1RzlkYVRpU1VrYVBSWnAzOHIranlTT1pI?=
 =?utf-8?Q?Kek4Ppnq6LpCim7qYrhwh3M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YPWwaAUIUnl1jUV5rJ1zutnMU6rjN/TKajp7EJzkYmx/mzlH8wj7FPyhAmsHDHia4syn57WzGdL2KTFvWTcso7AzhY+dPGplpdTt16pepF/WXEH/9tkxEYhHcq3QGhp5uejKcBFtd1pVnzSF2DvsDoGQ8bEKnIkjZtJmqMhIXmGE6SeIalgGx464+uTawOPOtdrVWxePIauujd3JBsJacXefSBmErzBLEfuB5pAB1s2T+Yl4hhjXSP+ujJWj4VTBFjmQigf6c8v2F+7n9Kcsp94uBVU7/01F255gkdJj2mX8aQ5ty3TZiKwlg+MSjq1Ku2ScOvtL5I7r1BaWv2kxAl2y4dLf2VwK26Dp6mBCHOQZ/xvH3/WqE6l1yn2Kkw9kkBT1tIprioHOVCBXgVIHYBCkCST8d/FdTPUi7tkoD+MGJJGZwo3V1/Lc9zJyfRaNS9mFLCMCbOTjr8DZpEWhvgqfozBCrQY9JPKAKCl56js6YH3ZNFAumsbJlGC6nfQEZ5h/agCj46DqjpRc2VLnfXQUAd54IcF/4H3506UhadiaXub4ft7IpHqPkU4NTCvzfwmBOikcNp318Mb8oFdmiiYHIJBFukyuy+FExQqcUNhXDwnvZ+2N8rvAhLkTEVHAmFtehc79bmL2UyZw3gXVypoVJTCa6G2ysGBFh8FLud/Ibd1EGASLiJgl3pdJA4raOHTboxmTrguZzdrgtln8BTBwPn/ImgLUpdhcwJhxG8qHuAEKAqXjCXzVt9N4ZiTJ5+l5+MzBL9pvyhbbKW7Se6fwSC1eSKMu31RI3OWnSVuZS5IdYh6cyRREbAkHRro1jwGKszU93k3GehCzoXV2oEPCwzcD2b26tYC/jnJe0wimTMTF4kVbZpt7MkTIqzQP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6a28c1-6d1d-4d19-2a73-08dbc5265396
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5276.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 22:07:40.7374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMR8KVP3ksyPcDU7bu/Zd1cx91gh1UQdQGpclMjEeSGhXmDAv+qZKmHbDszXOrVaX7ydHy3TZ3obMDPASkFeCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=928 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040163
X-Proofpoint-ORIG-GUID: UA3ipI0AhHMiyPwC8CCx8ODrh55nf0sk
X-Proofpoint-GUID: UA3ipI0AhHMiyPwC8CCx8ODrh55nf0sk
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 22:43, Steven Rostedt wrote:
> On Wed, 4 Oct 2023 22:35:07 +0100
> Alan Maguire <alan.maguire@oracle.com> wrote:
> 
>> One thing we've heard from some embedded folks [1] is that having
>> kernel BTF loadable as a separate module (rather than embedded in
>> vmlinux) would help, as there are size limits on vmlinux that they can
>> workaround by having modules on a different partition. We're hoping
>> to get that working soon. I was wondering if you see other issues around
>> BTF adoption for embedded systems that we could put on the to-do list?
>> Not necessarily for this particular use-case (since there are
>> complications with trace data as you describe), but just trying to make
>> sure we can remove barriers to BTF adoption where possible.
> 
> I wonder how easy is it to create subsets of BTF. For one thing, in the
> future we want to be able to trace the arguments of all functions. That is,
> tracing all functions at the same time (function tracer) and getting the
> arguments within the trace.
> 
> This would only require information about functions and their arguments,
> which would be very useful. Is BTF easy to break apart? That is, just
> generate the information needed for function arguments?
>

There has been a fair bit of effort around this from the userspace side;
the BTF gen efforts were focused around applications carrying the
minimum BTF for their needs, so just the structures needed by the
particular BPF programs rather than the full set of vmlinux structures
for example [1].

Parsing BTF in-kernel to pull out the BTF functions (BTF_KIND_FUNC),
their prototypes (BTF_KIND_FUNC_PROTO) and all associated parameters
would be pretty straightforward I think, especially if you don't need
the structures that are passed via pointers. So if you're starting with
the full BTF, creating a subset for use in tracing would be reasonably
straightforward. My personal preference would always be to have the
full BTF where possible, but if that wasn't feasible on some systems
we'd need to add some options to pahole/libbpf to support such trimming
during the DWARF->BTF translation process.

Alan

[1] https://lore.kernel.org/bpf/20220209222646.348365-7-mauricio@kinvolk.io/

> Note, pretty much all functions do not pass structures by values, and this
> would not need to know the contents of a pointer to a structure. This would
> mean that structure layout information is not needed.
> 
> -- Steve
> 
