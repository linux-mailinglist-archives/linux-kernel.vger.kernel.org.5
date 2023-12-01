Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97B4800395
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377587AbjLAGNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377368AbjLAGNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:13:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707341703;
        Thu, 30 Nov 2023 22:13:26 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B169VW7028567;
        Fri, 1 Dec 2023 06:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2ye4JgDFyeykh2Ty/uC7AeHuSoUbmuKgs6dQ15kJ32Y=;
 b=XNoufj9pwScNeO5eofpK2CBA1eiyCZbrc5Dp/7CPifIsw0qf0WB6a9aw9u2lXNFyFtow
 OtjugPJrHbOznLDFWNYGAt+F+q80GulWxvCRw+5xjlR4ClUYvL98d6/rBOIN4ZcG5wEf
 xpg5+yPvzkCvImB/JWFakfH1+Hi8ZyJVrwXtVwGi/EYq6pQcr5Sz5nh6ZOGhYsae1sTz
 SGcAZI3HV9g+Rw3RE+HXEjCP2jNHiNVgHnRBbeSjbEkpI7z5UDlAT8qcFvY7FEHQggYL
 CnR4fc8QzdWEtjo0XNzScb/UIriyeyCcfca3dOXL3zass333hR5S+mtMDtyHToO0g63G eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uq9sx01k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Dec 2023 06:12:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B15YYwY026973;
        Fri, 1 Dec 2023 06:12:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7chtc6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Dec 2023 06:12:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKOXVXwuQQ16QmsOgbNoz9lvYKhrt+mDjZLeWU641OJnsmHQQ5Hki8KD405TOQx3ZDpAXJi8/wymrCa44woD5X0UznUf4WCbIgU8rIHRHI90ZoOw6Durk+cojtaNH1A7rPON0Y01F0XKDGig+6Vtg9n6LBwLm2DuZaBaRP6jVLDu+bKWrPcrgeZJcIa3PIalz1og5d1ol/rrPqHiF7UW9uC9e8e4MkTqzB170XbBWe1x/tVxx7smtwk8YmrZUvoa0hJJcx3Yfa8Oz19buF1EgsduJgjJ5g+EKSmJA6kORyKqyZ4XoGiMqODANpgKUhqjbNPAuuGQFxOrws881soosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ye4JgDFyeykh2Ty/uC7AeHuSoUbmuKgs6dQ15kJ32Y=;
 b=TwLFWFEE1vAZKmCeJToCvnpWpA4pI9PcaconAY0Fnvx7BAAlU2xDzIyOw9Vw5rAOJpQOKg3JPmWc5PRAbxdo3yCWLSj11hRL6YczRVUHXGG/sx3SfIoSaGkiuPA1iQEuhOTl/Ie1b0iFXHAkjqRWI7+ibEepNPJy/0vguCHt9DzwXGxhBRFiir5PAoxklJmeeYs1wtFgkgfiNgWiOmhDeHfHkI45oe7Ll/bBsH6Fhu69hQo/sZep3q9YdodfWLQnoKSQ94WRBPcbMwelGai8fOsqwJfNYzVLc3mJ6j0I4uT9ooyj7RtjIzRw8gQMdC/77PptWF9Xly5Qp6nqTKCWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ye4JgDFyeykh2Ty/uC7AeHuSoUbmuKgs6dQ15kJ32Y=;
 b=MNLkIabbE2IsrXTNKW4tOkbMSAvzDnWe6O7BW2xkXpKOHw35td3mZ+E4frhz7EYnFEv4uJsKwkbI043IGBjbiz8cK5yv0niavxz1UsvCCiRjoC4jkmE49cSXPNDvdZHac03C9XLebOenI67UQgnXv6kCoWCcRWeN5zXImq412Oc=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 06:12:47 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 06:12:47 +0000
Message-ID: <afcf90f0-317a-479b-a05e-75412ebefe85@oracle.com>
Date:   Fri, 1 Dec 2023 11:42:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
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
References: <20231130162140.298098091@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:1::19) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: f1777953-9f8c-4ae1-1cf0-08dbf2348a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmJldJeVYRTyBNuZqUGk9WyAIRjZaw8ALWda4hQ965dOOeShvgaskO1JahCok6PppKnf6pzCz7JUxIUofjDJ+mQ0Kp2Xfia5w6ZFuttSHrmgsevIzI+QGUavgCXb5dQW9HbhoXI1i0Jk7KNmiHEMoTKU0VrzaPcj2b+lfKq58xRoBiE4hBrXN6yvFsTWsPPpuEczrVho6CxUNBj6q7MaYsdAmM7d1lHLLBS3Hbqz2LIJo7GDIaYDOcBSXy1WWtV8lko/DZiprfTwwyh6VGbr/WLeuVbkQdrXixCW2TWnzo/+XFkI4biudDkO8fKM4507352eETH4NJ8T/+9QBPxquoDd18WGJdJM4ixS2+HxtcJgNdCXAbpxUx0efwNWXUEH1RpJqkU2zYgpolglJb9f9y049DngFuaRJefOP5iKVyV5V4CJAQ7eBhrvwXM5u0LXDzmXzJoYHtd2aaqesDgJzhM3Lu0+ceADFyJzwaEQayPvjvpQRbXuDwlORAmiEH9MgZ1WEwafIAfyEdb7K2u41himXWLJQvFo6aS6HzZteTcYNeay0epOHitI+wU6nAcvxZcqPclT+xfK9menAIQDPPSaCgBTsOFHKxP+wUOLQg1VsLSlgi4MnEMtCGc7KfRyLGrNaItbiYJbHGn3IQgiog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6506007)(26005)(6666004)(107886003)(2616005)(6512007)(53546011)(966005)(41300700001)(4326008)(8676002)(7416002)(8936002)(5660300002)(4744005)(2906002)(478600001)(6486002)(316002)(54906003)(66476007)(66556008)(66946007)(86362001)(31696002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWVxQmt3TXFMdDBaT0ZGK1BBNGxYOHhZcGpUU1BrN01Cd0hnL0hEVmNQZEE1?=
 =?utf-8?B?TlFNZzNKRGVKcVhJN3VzdmF0Tk9lUjV1UkZMeGZrNlFDVVVLdXppWXV0WnYw?=
 =?utf-8?B?MVpDeDBUKzV3SkxKakQ5L24yenZWYm9DTnN1SnlEVUV4cmNVbmRMc2w5OXcy?=
 =?utf-8?B?Mm1OZmR4d1plNmlNaUZtb1RnRHBlSXZ5Rk5WbUVJOTl2bXkxWE53dnJSWVFa?=
 =?utf-8?B?UkJFVU4rVlRtYzM5TGpqc2txTzN3MEdSbnR4NDNvcjNGbWlxUkZiVmVMVUV2?=
 =?utf-8?B?YXNyZWNWekxoUTdlcEpLWXo3K0JoTWxrQlpXckp0UnJCUUhMOHZNTDZTei9Q?=
 =?utf-8?B?WldoNC91VGVGZkxCaDYyb1FZcjN0SklIRHU0VjAyUE5XT21sNS9TN0hiemNE?=
 =?utf-8?B?U1RsdUdQTEY2d2FHL3Yzd0tncDFDMFIyY3MzZ1Mrd2xKMjd4ZzZvR1laZGJz?=
 =?utf-8?B?dldrVGtTdGpFZWF5SzN3Y1dVaDdDekVDVlFhaFZ5aU5YNDczUWlCSm5JUHlY?=
 =?utf-8?B?M0tncFBWNk1IMUN0WVloc3hyNzg3bTVGL3hwLzcvaU1LMEtGdmFQNlRjY1Zz?=
 =?utf-8?B?NzY3SDMyc240Z1VEUWE5VGJCU1oxOUhjeG9ZWnpqenQ4cWZVTFVZUE5zbmlE?=
 =?utf-8?B?bG8wdXNnd3FybEowL25PWDhjazk3WEJ1bEEwcy85OEVRWElzOHBzUTZ1dE9X?=
 =?utf-8?B?MHptdjZOUlF1WDNOSDdqcmxpNUxnSXFxWDk5Mk41RGdCUzVZaHdFR1ZTdHFG?=
 =?utf-8?B?UVBOU0ZJczJlMENEdWtPallGb0lteS9jaXltczNQeTdTVjhQUGRQNDZENkJE?=
 =?utf-8?B?WlFycDdxZlFWdE5Cc0FsS1lIZkZ4Y0hlQXRMdkVlZEJXVU9qbmwvZ3lWVGxx?=
 =?utf-8?B?N2RUVlYyMmd4NzNEOUczT3lxTHh0NE5BNmE2RWZOQmNxSFlzZXU0QUMxOHdW?=
 =?utf-8?B?Ymk4b25lMFQ2T1dKY0d3eWNrWjZJQ1FyK3RNc3F5cFllckVXL3JZbnI1Ym5p?=
 =?utf-8?B?SW5CbDlORnZBUlVaL0ExbVp4Nm1idnNzTzJBbkR0Vzlwa3hENVpuQ3FrMnJC?=
 =?utf-8?B?c01DRENWYTU2NDU4enQwNWQwMnpMZ0svbTFyNUpnamRuNzFZQlYyWnR4STlJ?=
 =?utf-8?B?SHA0NVZsUUF1RUhCV1R3ZXdFajJaWUZxTXJraENnQ0Q3NEVSWUVNWGNvbldm?=
 =?utf-8?B?WUtUWWpIY0N5YUZEUmdKNW1icDlFbGE5emE0M2x0azlrejlmRXdJK3RaRFJh?=
 =?utf-8?B?bVJCK2pOWUNlYlFkbEtoamROK3Y2aDQwL0NhbjY5amNJSk1IUVdpSHNLSVdx?=
 =?utf-8?B?UTB0UEswYURZckd2Vlp5YVd1Y2gzL3RuT1FlbGRaWWtNdmpBd09oVEg3Y0NS?=
 =?utf-8?B?bjVXQTdBM3JjRzJtRlFmd1lpTTZ1SGRKT1BPYVFDWG55bks1MndpM2J5alBN?=
 =?utf-8?B?MXRRcnVqZFpjQ2tsWkZnUTN2MlplRHY5TGdHbStVR0FtWCs0ZmlBM0tTNkNY?=
 =?utf-8?B?RThBU3EreXZWaVlSVDExZEdqSm9JeE9WZEVyOUhhNnF5UmU2bnlERGlnQXUw?=
 =?utf-8?B?QWNnbng3T3FjUnFiU011QjdVOUYxemlSNGNyZWVvbkt6dHBSOC95TGJ4RC9s?=
 =?utf-8?B?VlZlNk5XbWVsV3ZBMWIyUTJPbHp4bTdtazJXTmFJSkNaSEVrQjIvdnoyWkdU?=
 =?utf-8?B?blNPY2FuSWtlMUZHUmZFM1RpMEVvTytONnZtelRVSlM3UHoxcnQ0YjBnTGRQ?=
 =?utf-8?B?MFVjYjM3bWFxb3BlQUVXcHp1MU50bUFaN2hwNm5ENmhBV0ZLQVZwSmV2SjJo?=
 =?utf-8?B?ZGhmemhwZVZOaUYzZmZFNXlCb1dpVHp2cnExdmU1eUxPRWE1STdCaFBVU0Jj?=
 =?utf-8?B?QStuTVdrUlgzcjZjenk5U3JnVEYxakxoWFI1eWt1ZU9Bc2FxYXZOV25NWUZp?=
 =?utf-8?B?bmtQWi96MlU0NkI1Qk9adFlxWmxPQjE0STdKOFFIclVuWXl2eXkvVnk1YVRG?=
 =?utf-8?B?NDhiT2w1YVlrRGFFdVp6bHkwOUlPM2FNVVU2QytsM2xyYjNTamVPSklaZ2xq?=
 =?utf-8?B?L0c0NEs3cktuc1NUZHlKaGFMSVNtNWcyYjZWNTZwZG9zT2EyMVNwYmp6RmVM?=
 =?utf-8?B?YUFSVjlzSTZQenpsK2VSSXdBWk1SYm8yMjlvSHp5elJRdGtQcXQ4UVdUeHp4?=
 =?utf-8?Q?1xxao8jwKSarA0af333lT28=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bHZZYkVqUGZZK1J1UVNVR0RTK3lmR3JxK0RDS0JTVU1QM2hzOEdCK3I5eEdX?=
 =?utf-8?B?SWtDSy9VdmphckdEMXBsOWg2NHV2SmlUWERzeHg2eVpNbFQwQ2Q4bUYyN2pY?=
 =?utf-8?B?RXRBbjZLcE94eWFOV3pBeWxiYXlra3cwR0J1WCttOWVJbmFIeWh5Ym1kQmxH?=
 =?utf-8?B?RytJWEVNd3hJRnFodWpTUVRXV2cxKy9ZcStFQmtFUTRDK3kzUFlRaW1NSEo3?=
 =?utf-8?B?Tnd6WnNPUlJFMUZtV0VPTFZ3NHMwVWlSZ08valBJU0wvWXh0VUJRN0VmTS9N?=
 =?utf-8?B?S3BYWEYrOHV2NWdlTEpsUzdQMUNZNGFxaHZUN2lyUS9iTytSRGhKQjVMU3N1?=
 =?utf-8?B?SmdtM2VOUjZGa2cySTF5TGg1Nkw4S3d0aHZvK1M0VzJHYm9vNWhPVm5DaUxF?=
 =?utf-8?B?a0dheE8zZWx1OVdJeXpPU1FKdlBFRWR1NE9CYnUvSmxUdUVnbjlab2Z4TEx3?=
 =?utf-8?B?bTkwZEN3UkxvQnhaRXBuRkVTcFFoa2FXZk5ENDJjYUczL1NsV0JMbTI0R1hx?=
 =?utf-8?B?enZXa29vYkVMTGJrY2loMkNqTFBaRGhvbWhEQWhFRmZVaEgrQkNJdDFYeC9u?=
 =?utf-8?B?QjNXMGlmRGFiK2l3cGJ3ejE0R0pTekNHRG03VFRLaHNtK0ZPRmVmVW5DM1F3?=
 =?utf-8?B?Q0s2NkpWUUpWTC9VdysyLzlEaDhES2tVdzVYTGNQSWhDaU54Zm9Wc25tNlU5?=
 =?utf-8?B?cEZ2MkVjL2x3WGpTY0pGb0luV2hMT3NzV0ZVb1ZkMDlzZExIRUh4TEt3RG5B?=
 =?utf-8?B?K3pnUXQ5TnlzVS8vN0UvdG5JWk5JZEtqNHVsbTN1d3hLSTI3bzVKU016cWpT?=
 =?utf-8?B?L3poKzNIejZ0U3o0eCtDSUxaTzhTMWFiK1pCL2duZCtOSVVkYWdmRWkwTlFI?=
 =?utf-8?B?TXdueFM4Vm9xRWI4RWFaRE4rSzFsRG56bHJjK3hSM0Fka1JSS0RCOHdkVTB0?=
 =?utf-8?B?YlphRmdIQXhyeE1sV1YzMUNjUURNSFp3Z2ZYWDV5NWt4QW5DNlNleVJpVXh6?=
 =?utf-8?B?ZzRQTWdSQ3dIZVZ0ZEtUSHZNTG5XVUhOcDd1aWhWTkdvVWpNUEtMa3A1Zkxr?=
 =?utf-8?B?MmJ0QnZVOFk3MmRXempBK3ZjTklZc2VuejJ1N1lGWmFZSWdSNnJ6TUwyU04z?=
 =?utf-8?B?Z0hQdnF0dEp2TnJad2Rla3lkWkNUZTJTM3FKSVFuc0xSbGlHRnNQU1BrOWxC?=
 =?utf-8?B?eDMvVGh0S1NvK1RWZ3poQ2wySGZBaDh2dW9OOER1dzNMM2hvdnRiRHhOb2w5?=
 =?utf-8?B?SGNmdm9Dd3VkN0x3ZWtZSEtiNW9JeDRTbEJvcXdyNUcxS0MzNFhsek91aU5G?=
 =?utf-8?B?RlhsM2NLcEVuS0JEamE5NzVwNmZjb09oeUNBeUhJeldrK3lUNTJTVVcvWnVw?=
 =?utf-8?B?VE10a0JJcDIzSGFaK1A3MFZoOG5STjhKSGdTenEwa0RjbHlPWmlwM1ExZlds?=
 =?utf-8?B?R2EwejM0VnQ4RjZBWERBV2pTemszSnJncGp4MjNmdVhvL1pvUzNmSkhFZ1dO?=
 =?utf-8?B?eTJIdHZEMlpDakhFMXUvdXhhQ2I0WjNtNTlzc0c1K2ROQnpQRWVITkgwNWda?=
 =?utf-8?Q?kv8DFHdBnp91L+C7nxQ1EJczqWqJ0B83OlH8RDkKgbpgSe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1777953-9f8c-4ae1-1cf0-08dbf2348a15
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 06:12:47.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeQXQcyBrN66Kj6vJW9kfvRPVA2AKPkgJZvw9Z9uiWnO1/iR09OuYVNrG54Pbp30DTac2SOyUrMbqXNSivVOXbeJeyt8TNES0QyYT/WWGQV30ONAlGYgWVoNeFYGVNLH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_03,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010036
X-Proofpoint-GUID: Gs4L-bEHDAcNC6W-ayYgCLiTXDmy3yoF
X-Proofpoint-ORIG-GUID: Gs4L-bEHDAcNC6W-ayYgCLiTXDmy3yoF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
On 30/11/23 9:50 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 

Built and boot tested on x86_64 and aarch64

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>


Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
