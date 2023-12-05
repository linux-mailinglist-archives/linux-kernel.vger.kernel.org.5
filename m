Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D6C804AA5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbjLEGzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344480AbjLEGz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:55:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA39FF;
        Mon,  4 Dec 2023 22:55:36 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B56bcrA021732;
        Tue, 5 Dec 2023 06:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Xio8GUcs+fYKncThH6guZpgqPBn0WFCoq8nAQfdtAIM=;
 b=YkDc84844zsmgi9cJXhQkVGri8EzytoqhlEqX9y/qi2pCWlREaXtKfeTfgCWoQytPG5D
 +7RP3RAumbShTXLFjEB5Q7aeM8sCeBO+otiKulfWE4F8B1i/hQxd9fqpiSZY1Mr5SFUK
 14NYJ2h70F+MVaZSBZwEXnIbrhp+BsXPhWE2xpsvJKMUdhtPgxUcwlKWsrBagkPhIRrB
 sSTC9mGeopozoGw7gufBzU4gg6Zc2c7taMuWT87BZ0n93h1kRE6mkSFlim7gHC/crWH3
 GFqPk9XD+7URQpm/yLesuO01XawLeziGlfhrLto17JZlkK2Qg3Udj5FhPp3B9FBarodN Yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uswjug4xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 06:54:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B55inKf028834;
        Tue, 5 Dec 2023 06:54:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu1deyag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 06:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0E6lU7JM7zC8UEz4pUChdO403LMVVadvGoekEHq5B3nVwdCQawte50/6F6CzVLB/DjLW2dOyeX0LsdRSLbiSCMmnnUXE3wuxn+xuPHGJULhx38zoCeS67LVmBc041xVcZ8HLx5VgcWB8e43Po2rloGQdyHXFyT2GdfebT0DfoSNJ4clkpHimaCIbFlLmhBedmrVsroPus3TC0sscO29LzfFBylbvKPm4DioMtqgVhC3GeSIh1w7QmU7mt+AbAkF30sx57348vNRlpERm9PXu9sHOVw3xsFMXY+zGIR/1H2kBDqrigQBiqKfC8XFmwKLtBFOzgSyhyRu6Q5/P4hZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xio8GUcs+fYKncThH6guZpgqPBn0WFCoq8nAQfdtAIM=;
 b=dy3nl1XWxVBpJN6BmzFdvNEBQ1cXbvNg7sTtShEchnGntz0whAbjt4ZfmenvELZj6brw8hiI4Gefsh3wILpEQklGjYa6ySdzw9pYhPJptLnNqO1ZUrEseeBot4nvjgcR4cWtm56H5GXWnunwhjl3ZzD9CJ9iVEazY0DiPqTu3PLRruECQzfRfl5KSy/Q3DhELYE4DGZxd8B1oJRlVZcs/o+5zB5fGsDaGlYUY5mP8vjmwpTo8wV9L5wOOYJ7ssQGQZiUaQl+hPREz16bC4kJ5Rm11Z6327YtAoREYPxec8yVnOetrfwWKKcK7rfe95eTEMQFDslLOkIt9kui+8DNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xio8GUcs+fYKncThH6guZpgqPBn0WFCoq8nAQfdtAIM=;
 b=SyVm4S1K59CrlAoxTWHEmrFwDU8CizdL81O6x6sizi+Ixp1N2BFbcTC6WCFIFAUQBl/+aFnQsRYAze9ac3UwZnt901x65VRiuVrbQ2vRlwSD+Wg31/k4zaAFZfqQTRckeVkgf7qPky+vKr3NDese316i9XmLvLCnnq6oSqI1De4=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BN0PR10MB4965.namprd10.prod.outlook.com (2603:10b6:408:126::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:54:50 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 06:54:49 +0000
Message-ID: <cbac5816-ab33-47c2-9066-73f933b86471@oracle.com>
Date:   Tue, 5 Dec 2023 12:24:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/71] 4.19.301-rc1 review
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
References: <20231205031517.859409664@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BN0PR10MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: e414f3e6-01e8-454c-1468-08dbf55f1340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNd42MQDf9ATl0VNw/VksDXgMK8S4UOAJU8fb+M5jH8CkqI+9W0Oe1SZloFESbbLYRYKW3srtkvVOYzNK72q6OftgRyRegZak7XVs1mb6VfjzvvWUugMnPhG9KlW10gSy6Z48HR7KVz85gMxEw7Nj3h2bvQjR+kEEniE91gWs0K0G10dtqmfrc7Bfd1h86k5t08Tf7JkIV34sI//s70kcElzJBONO2eY/XvwQw7UEtRo7+5NA8fQxuKpYcrjI32Yj92FYd1pttPWPTar/LXKY5wkNu3fG4T2IqlOdARdxODFJdhWJMtc25KygvCJ3rx5bvJDFTIap8w9XUIIfd0LX/ZRUwyKE2Q8/dICXQRu4X2UzuxIFNhsk4SbidL+CGUoHA9PnlE1zZghywKcyHNFOU/EqHoRW6uqm2wpNo0tGSLgB8TiJDbB9Tf1gJdpF2P4Jv+TgS60D79yY+mpTdfVkNJfHF4yhod7RmoHKyFh1eSw1ZoOiCp0vo1jbzS7UAa6E04JQOZZGfjmgauVv6n7xvYSM4Ss4JpbNqLbVACz1PsStFGwVco8kYOlfA6CQY5pgzkQXNspynEcMIBfujjZgbyCHq+tQ+Hd5JbCIKkghVkFPnKlchqIbKw1wF0CpRVXVJvWLAwsMeLSshOzQPc2AME2AL05BknjAPyA0BsElTChfG45kG/YPKjc4t8st5uH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(478600001)(966005)(6486002)(6506007)(86362001)(6666004)(53546011)(6512007)(316002)(66946007)(8936002)(66476007)(66556008)(54906003)(8676002)(4326008)(31696002)(2906002)(83380400001)(41300700001)(38100700002)(36756003)(31686004)(2616005)(107886003)(5660300002)(7416002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ptcXVtd0FHM1RNeHczaDFnU0xUcndyUkNKbUF1ZXVqZ1V0U1lNMHVtRHU5?=
 =?utf-8?B?VXEzM3YyVTVsTDJYQmw0SklqZXVDVm9uRlR0Z09jTE95VHhPTEl6eDFNSktV?=
 =?utf-8?B?c2EvcGJBeDh4N094QmpjQng3T2xvMXJVbnBpNW9lMFgzREw1Q1I3b1phbHZC?=
 =?utf-8?B?OGk5cjBtcExlVXRiN2hzUGQvR1AybTR4ME5lQmZLUzVpTlhGSGc4OGxzRmpO?=
 =?utf-8?B?WmxkTHJPVVBJeHNoNzF1alZCMmhjelk4TmxSMXBrN24xWGNaUlBFQ1p4R3RG?=
 =?utf-8?B?R3dRRy9qSVVIWWpDaG1jaUxDVmI4NzFUdGZVWXBReFQ3eHFkMGZVamk5SEhS?=
 =?utf-8?B?U2ZvOWlPZTNLMVVpQThOQzc3bG1tcWdia3BxWUQyWVNBcm9VREczSG0wT1Yw?=
 =?utf-8?B?VlM0dUZXcitHYWVsMGxDallPMzBOUGFodVJmUStTK2dKTElmWHBibUVYMUkr?=
 =?utf-8?B?TTRsMm5uc2g1MTZzbFVGa25pVXUrbHU3YXI4MW1FeFBIalNkRElCbXh0cU1u?=
 =?utf-8?B?b0RPdGg1azlENFVLUGdpeUQxUUpZNkUvTzZySkZlVXEvSm9EWEtDVnQvb0Js?=
 =?utf-8?B?TS93UG5qR3o5UGlRQ2lYTGNaYVNqWW5OcWpobjBwWVpXYkFiK0p2Q05SNlpW?=
 =?utf-8?B?REtSbm5VRVNXZ3ZONFdYSnd5RmdSWVB3Rk9QMjd3TGlaNkNacG40ZDNTQldj?=
 =?utf-8?B?dkFTOFdLL2RQRGdYUTh6Tkl4N0IrMnJUT0dsMWJsK2xDaVNpeGNRaXd1Wm9M?=
 =?utf-8?B?YnFUMVMyS1VOb2trK2huVHRYUjhUd3U0M01TQ1BhQzRVcmFtUk1pSW1QYlNv?=
 =?utf-8?B?L2RkRzI4S2FXbXl4RmlhTjdnOFlBMHJGWWVuZHVSNitjUUZpcVBZZnVwdG1J?=
 =?utf-8?B?NXE2UzV2WXIwc1dPMlpNcldzMkVtWWoveDJPUjh1ak1jSDlVZ2NOTzF1cE5v?=
 =?utf-8?B?a2w5ZGpNZTNUYTFCTWpKT01xQ2NhZGRqQS8wVVJuT0tkTHpzeERZZlZOSG8x?=
 =?utf-8?B?NTk1aDNTNUs5anRPUytiQ0prVkpGUk1KSFhQdldBSTlzL3RYYUFDa3NodnYv?=
 =?utf-8?B?bjdXc0I3eVNoUi85VHl4MTJWK21mVFhuRnJudmFUa0t1TzMyTEVpOXA0SVlD?=
 =?utf-8?B?K0k4RHpYUmRnaGd2Q1ZJNmhnM2U1VTdldVVRNkk5ZXNqd1JpbVlIa0NKYVFi?=
 =?utf-8?B?WmRvVFZ3ZStWamxkU0l5NWxLek82bE1sTjZCeGxud3gwTDE2TTNyRHpZUFZP?=
 =?utf-8?B?dXk0YTJjWXpMR3dOMFlOZ1BHNXhhUFZnZ1BWb21CWVhRMzV2QWwyTkNDdWxq?=
 =?utf-8?B?MDNyT2dhcUtGU3I0bmN6T1VmN290RXF3bytJMTFhNmNxNGNMMFFpQnhqYzh0?=
 =?utf-8?B?SXB0cE9HTlc4VldrWE95WUZnWFFNZVh1anAra0gyZDlGc1F3SFJLQkkzcFk1?=
 =?utf-8?B?YnNweFd5K1R1SCt2cVBScElLc2N1Wnl1elcySGc0L01wcG9rUE84MHB3RFNN?=
 =?utf-8?B?OGhxSk5iU2VnVk56Vyt2UEd6SW9BN0xVNzlmMjZCMFptbVVBNStFYVllOHlP?=
 =?utf-8?B?cUs4YTVCcVBoZFpwK3RRTDVzcGxVbldlcU9mYmplWUVuQUlrWjkzMnhMV2lL?=
 =?utf-8?B?NmpqOXF1SEhYVDMxR2JFRW1OY0paRFErdTBvRTkycU52ZUhwWGxsa3FEU09r?=
 =?utf-8?B?V2tTcHNmVmpQdHFNK2V5SS96WGpGRXdwTUhNZG5RSHladHZVZzBSNFZqczIz?=
 =?utf-8?B?dXgrNzVlR1FXSS8yTWJoTW1XV1FIdEY0a0h2MG1EZzE3cTY1UzU3b2tyK0F3?=
 =?utf-8?B?dmQ1VEpmclVjNXdHdldQVlNPTURhemtyUTJlbUNYcE5BZHp4enc5N2I4alVx?=
 =?utf-8?B?UnBlOXg3RUU4MUV0cnN0TG9wVGVrWndpYVVqWng1WlJ4UmpXOUppakNRbFQ0?=
 =?utf-8?B?U2E4UXUrczBCYUtMaDZWaTJNL1dseUtFbEZzejdmYkI5L3hjbmpLUVRJSmNl?=
 =?utf-8?B?OFlnaC9NbDU2alVYSmRkRXU2b0N0dVF4dmtFSE52dGt3Tnl2MkdmeVZBL2w2?=
 =?utf-8?B?dHdzdENPRWExKzZFdUtxeGRrcmJBZnlJUHJNSkliTFNQWGVDWTlOZm1uUjh2?=
 =?utf-8?B?R3dMYjFqMVl0aFhRb2dZclhkUjVGRkovVDljWVZnUTZJRkZMbGpxa1IrdVRu?=
 =?utf-8?Q?PXSt4umlWVrjvepmeVDlKPo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cXBrSWEyRFNsbithTnFXak5TT05RdS9XQi9xazNaWEYzL09IM3k1MnFOSEFV?=
 =?utf-8?B?MVVvanVMRnFyVHVjcUtsdTIrZjcyWE5aa3c0SG1IMjc3VjFLaHhQV0FySjIr?=
 =?utf-8?B?Q2dadHVzT2crckJRNGVZWE5uR0JhWjdlRDRFNUlOUWFwZFRsVFlyMUVJVlRW?=
 =?utf-8?B?bG5FZW9QN0ZuaWpnYnpxSWtBa0dnUkNRb3ZQVWJWSDJId085d3NlWXZQaFlj?=
 =?utf-8?B?R25PN3J0cVhadE1FZ05uc2lvMFZPYmVlUXNZRC95ZnlMaTUxUmE5TWlIMG1B?=
 =?utf-8?B?dG04bjY0YzVtOE9rOGNyR0R6QjJBM0RwUmFsT0FjUTVkQ2IraVFERHZOajhL?=
 =?utf-8?B?eTkzQWdLeUdQNGZDMzR6V05MT0MyeE1ISTlreXh5U2d5SlpDcS9nTFdqTnM3?=
 =?utf-8?B?bkNSZFEvVExjNllPdEFabkVrVVcrZlhlUk9kckNuT1RzWEtjVXU1TjdZZzJn?=
 =?utf-8?B?cTRlTjd1Tm55c01JU1lnWmxiQVdZMDNBN3o3ZWs5dVNqWXE2N2JhWVI3S2xv?=
 =?utf-8?B?cUFIRGlxUDBwdE5HUEVBaVRFelBXcjBhWm1ZQVNjUE1CZWd4enFiWC85Lzdu?=
 =?utf-8?B?eWRJc2VXT0ZYcGxYbS9kbkZIUlpLYkFURXh2TE5rNUk4RkFhRU5mUll4RjY5?=
 =?utf-8?B?T2xKeGFHZzhXNDlNeXhxcHlHYkIwWlFxY240RFJDWm1iK01hMHhGUVRwSWYv?=
 =?utf-8?B?WmRDUWdlVU9BMHZUU0lNLzZRemsvQjJnSVFiL0JTQktSalVJVVBkR0YwRHY2?=
 =?utf-8?B?bE5oR1lKbUs4ZjlpNGZJeXZMYjloMTBQeVBJK1dTNEpXQzF6ZU5ZYnkwL3ZI?=
 =?utf-8?B?SEhJTVlGYnRaTXR2bFdzOG1OQ2dBejVsWHFOai95dEQ4cURLaTRseWRvSzZi?=
 =?utf-8?B?UWF6WDZTMUlqMFRQdTM5aTYvNXliWVdXNEJsL0J0aG5pc3FIbjROYStHaUg0?=
 =?utf-8?B?QU15YmRGRzRRc3pqYnJwalBoN1c5a0o2T2ZhSzBzcy9la1E3SFB6OEFmVC9n?=
 =?utf-8?B?YWVJOGUwTlhrK0hncW1XR2F0RjduWk1tUGJyeW9UZ1RGeHVnbmlheDR4MS9P?=
 =?utf-8?B?dEZjRXRJa0RkckRKbUNjY2NXSFhiT0ttOG1udmZCMk5CUjRaSVJtcVRJTzdN?=
 =?utf-8?B?c1JVSnFLTnpOR0s1aE9FUGpSRGdXdTRtK29ObUJCVWhlWlpKbmU2c1hFNXl3?=
 =?utf-8?B?VHJ2dzNoZDFKbHVxcHd4QnVNZktZU0hNZEVaeVJRUzlMOFljcnBGdzJJVU9z?=
 =?utf-8?B?ZVFNMUxndVFaYTBlOWhXZWVMKzh0Zk45eWtpcnAraXFXZU1OdDIzUVBKdzN2?=
 =?utf-8?B?STV6cmw3WC8reXBncjJ4VDZwNVpSUU1pVTYzOVBRWlUvemF2VkNzbGNDM3NB?=
 =?utf-8?B?K3huZlkwSzhOeXkyUytRMHpHekkyR0VLSlhRalE5bmVCR3NqY0VqU3Mrb1p1?=
 =?utf-8?B?eWJqVzFhMWx0WlhDaWhGeUIweUVRZFdySFZvUVdYWFpZVlVnWW41UE5IemZk?=
 =?utf-8?B?NzRoTHdHTXJYeXhmbFgvNWErNkFlWnd4b2dEalZQVmQ1TFlJcHc5N08rZXdy?=
 =?utf-8?Q?65tON/Yo7+jfcdcx7X/ZyN0X8oStpYu9x6qcgJuHVfyyuU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e414f3e6-01e8-454c-1468-08dbf55f1340
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:54:49.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KvrpRdkzNShLIRyO+6UhqLNfRXbM+WK0d7KDOwR/8E2mfskh+Stzxc1Isfs0AoBK3jMkhwsj9pj2TvG+Aeh6mTz3zEQWdn//CmGcQ0oukYkses854NorjVpjSf0SwiP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4965
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050054
X-Proofpoint-ORIG-GUID: _-qv619e9NlqEtNuKfT9YjSuKtrdMMPq
X-Proofpoint-GUID: _-qv619e9NlqEtNuKfT9YjSuKtrdMMPq
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

On 05/12/23 8:45 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.301 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 

I see build failure in tools/perf/

util/intel-pt.c: In function ‘intel_pt_sample_flags’:
util/intel-pt.c:906:38: error: ‘const struct intel_pt_state’ has no 
member named ‘from_nr’; did you mean ‘from_ip’?
   906 |                 else if (ptq->state->from_nr && !ptq->state->to_nr)
       |                                      ^~~~~~~
       |                                      from_ip
util/intel-pt.c:906:60: error: ‘const struct intel_pt_state’ has no 
member named ‘to_nr’
   906 |                 else if (ptq->state->from_nr && !ptq->state->to_nr)
       |                                                            ^~
util/intel-pt.c:909:38: error: ‘PERF_IP_FLAG_VMEXIT’ undeclared (first 
use in this function); did you mean ‘PERF_IP_FLAG_IN_TX’?
   909 |                                      PERF_IP_FLAG_VMEXIT;
       |                                      ^~~~~~~~~~~~~~~~~~~
       |                                      PERF_IP_FLAG_IN_TX

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.301-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -----------
> 
> Adrian Hunter <adrian.hunter@intel.com>
>      perf intel-pt: Fix async branch flags
> 
> Adrian Hunter <adrian.hunter@intel.com>
>      perf intel-pt: Adjust sample flags for VM-Exit
> 
> 
This is caused due to these two commits. Let us drop them.

I reverted those two and did a make, then I see another build error:

   CC       util/genelf.o
In file included from util/jitdump.c:27:
util/genelf.h:5:10: fatal error: linux/math.h: No such file or directory
     5 | #include <linux/math.h>
       |          ^~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [~/linux-stable-rc/tools/build/Makefile.build:97: 
util/jitdump.o] Error 1
make[4]: *** Waiting for unfinished jobs....
In file included from util/genelf.c:27:
util/genelf.h:5:10: fatal error: linux/math.h: No such file or directory
     5 | #include <linux/math.h>
       |          ^~~~~~~~~~~~~~
compilation terminated.


 > Adrian Hunter <adrian.hunter@intel.com>
 >     perf inject: Fix GEN_ELF_TEXT_OFFSET for jit

^^^ this commit is causing this.

Earlier we have seen similar errors on 5.15.136, some notes on what is 
causing this:
https://lore.kernel.org/stable/fb1ce733-d612-4fa3-a1e4-716545625822@oracle.com/

I think we should drop these three perf/ commits.

Thanks,
Harshit


