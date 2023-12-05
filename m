Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753DA804AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344367AbjLEHNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEHNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:13:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632CDAA;
        Mon,  4 Dec 2023 23:13:24 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B577of3026573;
        Tue, 5 Dec 2023 07:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=InBn+fWrDDW88JES+Vy1BNWLduon9WeGVmuRUcpWUK4=;
 b=nQJ3u4/fPLasxRS+ja2Dy25wdujW10KmzLVvqycO9uLoTF+E7hhDKnsTBn76njLwbSY/
 bfBjCPiaEh11MSA2vFqRgZnlYXWcX4sq4A88UpaBozopHV4TmklqaI7LkLbRtTdiF8oc
 6/k7DH5q9wk1cq5tWd3ZtOmC8ioMZlLdWZxJHolM3CN0yXbhbr25X4xYAV/umAV9Eiox
 +sM4K0kPE3SRW+bsTMF7iULGVterKmotYcgyCMclWX8BOmcx7tE4/uDcijS8MWAscNIU
 SNHjelWGM6Pv7UP2Nmkdd4zYEBkAgDN8IABJSU5uUuxhUg9iRX5Pb55wrmhFh79yAEKm XA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usy6yr08r-24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 07:12:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B55ZWlI018427;
        Tue, 5 Dec 2023 07:04:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu16yk0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 07:04:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPFvtO40rAL36p8rSsUksnRl0nWv/5tQ0L2RlGmY7axr0aBW5n+mgFBrjT0WUJcfmXftAlReuaRsNiP5//+E4o/roW4bpChrCGx0wA2td68HdDHtuxgGDwozKijN+YFRhXkAqFfiZrtyJf/u/baBNcJHPqxIqJnTbiWWFS4TpJXfJ1lim4GAPbHuV88y/k4sNxWjtlxJJA9E7//A1lQrffKASKlMGiRTgLifWyOliGXeHzE8ZD+KdK9tY4oziiYEQFXS/M1jWw5OkgfzQIs2Pyf3A8iNWFmjEq+KCB5vDQ97rF31d1LYs/huveJVlA5XLgMW5hCypI9sLFZe/S994w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InBn+fWrDDW88JES+Vy1BNWLduon9WeGVmuRUcpWUK4=;
 b=J/pCS5g4nBlV+9kZCMzXZ+byl6ELiarWZ9g4X7TvDekNhxRH5KQRsnEyhPZOM5f69Vv3QlWnINBJnhaJM/0kWEOoY+OcBW87lSJt/xdCQoxklqxe8qlvUo+mQRlZV/9CDL7P+7qc5uvPBGsAP08YfzK5ptp8VOSNin2gw3P2SXQI7rGdIVDHQXA3hb2J464B1/5C9jb5IfgFfM5qLem3oqN3ObNdD5Ib++sk742WbHzQesV2wFmSyLBDyXUqz6r03DVKAaJ1ECOAIEM9oYdeGaDttFkwRvq3shXFDTyLB+OMwpP7KNU39HI2a9dljMrK5kO+90XxiEwItTvoJ5DnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InBn+fWrDDW88JES+Vy1BNWLduon9WeGVmuRUcpWUK4=;
 b=lBinuLxxRJ9tpRKZ7FrlncomsVFE32zN/MOh7O2FTBRybHywd8NAKy4yIhWWyJ+xfE+vYVGcUuOrmMFrhk63viYP1KYgYw90HTHa4VmoYewDx4RuzxNXTLII2vA6SSOvFmogPW1e2C2Jqf64Fuq0Milj4FChsLCH9VmIq41SAa8=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DM3PR10MB7910.namprd10.prod.outlook.com (2603:10b6:0:b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.28; Tue, 5 Dec 2023 07:04:07 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 07:04:07 +0000
Message-ID: <9b88236c-8616-4a08-9c8e-9a6c09868360@oracle.com>
Date:   Tue, 5 Dec 2023 12:33:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/93] 5.4.263-rc2 review
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
References: <20231205043618.860613563@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231205043618.860613563@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:3:17::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DM3PR10MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd070a6-d0d1-451b-2101-08dbf5605f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLnbN/SYvHyK4wUUfOdLizOLbo/55XrhpU9D4J5hwzX5y6KqAKfrsPO3QlPofodpc8np+3FHIyv8xpDrbYx/lj839vB6hBTrzHhMF4ZID/CI/40P/cY0lOuBDBu2Gcw54qehA9PCLFeNuebQSxd1rMeLvTeE77bKv4Mb7ofayjBKidLF9Ywk75STsWo78EapCv+71XTaT3SyTDw/urPWfJORwKpf6qqO/vezMpJFxaAvoLx9azbZDaj4GTDoABujqM5lYYAcjS8QBaEusMysVR9lHokKg8j+h+MyUGlwYE7SrBGF2nfiOAlVfFgPyOPd/dIDEbF7YMUC3MJ3MYjyo+DxLI97tc/XeND2pthIH+Iz5du/BxnT8Iny5+F4LSAycg91uCpHVEs664sK2ryFT8eDzjxip0vkecm5Cfe12FCh6b/9J6nFLEypKumK7en1f5NM0Y08k6H2R16MNy2jBkQsgF0UYiWlStvAUe3jhH8SkZx1hL5UxpqEsrrMZUK7II0pkzqu0dkZEmlzQ+S1AW0ktbsjFFTSlqWGODwJiUpaOjE+3yyxWONye/9rK6FfqvM1tVoT+S3hNmIl1ed3bIWx28M5mn+eT6lNU/UVT2LR/8Ha2UcEbMepV0ityFzBrZOyI1ZYHyI+/gkdKEZ5SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(966005)(6486002)(8936002)(31696002)(54906003)(316002)(4326008)(66556008)(66946007)(66476007)(8676002)(478600001)(36756003)(41300700001)(86362001)(7416002)(5660300002)(2906002)(6666004)(38100700002)(83380400001)(107886003)(26005)(2616005)(6506007)(53546011)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0pLQkJUTXZ5U0VjTzE1OEpGVjhJT2hyOXhTdFRVenZkRG9PbW5USzZEY2dL?=
 =?utf-8?B?ZmphbktwS21sOGVJRG9EbHIxZGVMdlM5OFhqNFA2TFRvWjhkYit3RnJYWW9F?=
 =?utf-8?B?aVZNSS9vTWRwS1o2c2xoK08zWEtad0VTaDYxcDFDTkZ2eTNMUVpSN0MzbGNi?=
 =?utf-8?B?dlpaaVMweTVUSFNJU1dweXg2OHNvejJhM1ZiVTlaWUlDSFA5MENWM0kxM0tv?=
 =?utf-8?B?WlhWRkgzOFV3c2tTMmpib05FTkoxSXB3VHlaR2dxaXZmVkJCUEdxbDNmQzBn?=
 =?utf-8?B?eGoxRDlNbEdkU2RGMG5LN0swRWNLSGtjTXpjbHNQNEVzd2xlbDVuT3ppZ1Yr?=
 =?utf-8?B?TXVpUTFsdTJya0pIcWFwand0TElXYzU0bVhJS09JNnpHUFZiNVU2T0c4SjJx?=
 =?utf-8?B?OG5xRjFHVFhBbDBmL3RUeUVlbjFNdTJCS2MvdzZNSVdZcThwTG8wUGVWV00z?=
 =?utf-8?B?RmdCdUtvZ2pnSHo2VEJyMHlSSEFLNlZBNUxSTWtxSnNVMjdIQjNOeFFENS9r?=
 =?utf-8?B?T3NzYzdCUzhQOFZ6azdYbjBsY2ZzK2hzVXdQWFZHQS9WcHNUMUpkbWpyNVNL?=
 =?utf-8?B?V0ViQ1U3SUNPbTRCb1cxZnduRjBONDlRbmo3dDdXeFNRUHpIc1VsNTRPOThP?=
 =?utf-8?B?dzZsWGgrVXg1cEl5STkvb2NlaTZNb3I2ekRlYWM2UGJQSE5aSUl0ZTZ5WVcy?=
 =?utf-8?B?V3dGTk0wRktMcVl6emZ2b2dIZmwvb3dFYmtxaDZpczBRb1FFcGZEcStya0ZE?=
 =?utf-8?B?ZUZsNllYNDNqSFpYZEdJYmZXMHE1RVFwYnBlNVpxMTF4K210R3RXR0xHTm1P?=
 =?utf-8?B?YU1xMGFweHExYytkaXE3alNyYVNUazlCWUkycy9UL2VZaHUyMXlBT3RNakFx?=
 =?utf-8?B?b3ZvcVlsZDdyZWRUdWJvcStFSEJGR2xUZ2k1RURLeDhkbmxWeXNpR2p4OTBS?=
 =?utf-8?B?M0h6bVVFZmZwZlU4Rmt1QXA4RWNFSENKK0EyMy9hVHh2Ti9kUGp4SWZCZjFH?=
 =?utf-8?B?TlVBbG9qSVBraUsxd1B5TllqWVpDai9XL1k3N3JOVStjTGl6VWJVbFZqL1d2?=
 =?utf-8?B?NlNVZUxLMytZOWtxdDhlb2RiNXZDRWpVS21FcE1mV1FTeGwyR3lkQ2xKM3Y3?=
 =?utf-8?B?Si81bUJKY3dQMUFOaEZ5VnU2QTVhZGRBa2N3Sm5RK1A5RFFTdlUwVjlnQmZh?=
 =?utf-8?B?eSt6dTcwSC9tNHFvbHI2N1FNZ2hndlhwK1JnQ2NVNGhQV0tGMnNISWx5R3pD?=
 =?utf-8?B?V01ZQmNXcVNSOTlVTHZERllQMVRjSGd5ZWJYOUtuQlhzQmdaR0RzdU9sVlF1?=
 =?utf-8?B?VGk0VHFVcWkxZTNMVnVtZHY0d3JkWVRGLzdJMmY4WXNySGNWelZoSDZNZytp?=
 =?utf-8?B?a0gyMDF1Z296WFdnNStBenIxWkdqakJPcGR2WmloMGpialh2clV3WWdVbzFH?=
 =?utf-8?B?eW44SW5CRTRtR1JJZ1VBZUd2Y0h0bDRZVys0UFI3Mk9OT1A4Mm5tWVRvOWFl?=
 =?utf-8?B?VmZLcEVMTDROZ2oxRS91Zmkxd054TXNPSmp4Q1ZGSFhDby8yZk9JNTFrN2tn?=
 =?utf-8?B?Ymh3bGtpMVloRU0vbjBDZHk1bEFGcFlaNjhRa2xlWnpGN29ZQjJESjhLNUFF?=
 =?utf-8?B?TXpQTWxvTFpBcU5sQnZoZHpGQ2Vua2VuckFFVGgvK08yVEtGQ1ZwNVNiMU9M?=
 =?utf-8?B?RzFQclo4ZnJueStCYTAvRFkzYmhZeC9UbVllNHIxUEZmNlNIUndXMlhVcFZz?=
 =?utf-8?B?REdSQ05OSVNlNXYwWlJPUVUzSGlRdlYwRXhtOE5SUlAvdmhiL2hZQndvY2ZN?=
 =?utf-8?B?RC9lVHRwM1MrMEIwR2VYRDNYektkNnoxQTByYzZ5NWlxcG5tNnhzQy9GU2NJ?=
 =?utf-8?B?b3YxYXZmMlczMVhYSUU0cVRmVDhMU0FUenl6TE5EZHZQZDJxcndOU0x5VDgv?=
 =?utf-8?B?ZGNKL1JTWUNMZ3ExQms2VzYvOFpEb21JR2VRRHZvbFBLUUVUUU9DMit0eFBk?=
 =?utf-8?B?RXBzUUJXalE5SjBlWXM0cDRPRlZlTjhqd2NuNnVsL3hwOW9yc2NPZGlBR3BS?=
 =?utf-8?B?L3FYQ1EwSU5DcWh3VTkzWVJtbTZWYldnWEJpTWZzaFZQU1N5WDNDQzBQc0FC?=
 =?utf-8?B?R2hDTmdpYXd3U0xUaVMxaDhBWmYwcG84RjdBYmxCbzBoQmFYY2hPUEdpVE51?=
 =?utf-8?Q?wpZ8l5Bp/5QrOZcmIktfyv0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eVBSamc1OHQ4anVvNklCMWNweVI5WG5ZWVFTM1BlbDZ3TEtwSGNPWHdtWFM4?=
 =?utf-8?B?RUw4bXFaM2pOdURCSnlrSVVoRk1qcTlYeTB5NXl6bHJ6VFppUlRCUk5iVTB2?=
 =?utf-8?B?cXFiSFcxbUk4aHdEV250dnFnSjlsakZYcm12MDAyc2N0Z2V6NDZqSUE5eGE2?=
 =?utf-8?B?MGp4TUJCME5xdTdsZzR1NjFyU3lmZzYzNm5qUFNGWHhHN2RkRmpuYitUcXQ5?=
 =?utf-8?B?UG1qcXJ6dHY5UVovNE5vVHJMM1UrRURHbURrTWJ0Y2tBOFpqZnlyQWNidWow?=
 =?utf-8?B?YjJ6SndlMXdWL2x6aTNIUGxmOGN1RVp2NjFGLytQTDUvTTREWFU5SXNFcHor?=
 =?utf-8?B?dEZ1UjduQThOWmZrRGx2L2Zlc3RWaVVQbGpuelN1RUxVQTdhRmZnVHpVUGNs?=
 =?utf-8?B?STBsZVU2dFZPbk1DTFQzOEJTWWZ4ZlZVRkw4azVnQk5KSHdWWjNrWENiWTJB?=
 =?utf-8?B?WExkUCtXVmVKZUQrWFFxbWptditVWmVYRkVveEdiMkhFTGtSTmpiRDU5OTd4?=
 =?utf-8?B?Z2ZNWHhXc2o3VUZUUTJsQkUzbGw4QW9qczVKZmJzb0thV1d3ZjlyYjVzZXF3?=
 =?utf-8?B?dFdSTWtqSVY2aFNXV2VlZ2h5YUZWbStMcFFIT0YwaWt4eUpwL0F4RWVMMjZM?=
 =?utf-8?B?ZlNScFhTdHhjcHduajNua3JadzV5VVZtRmdzUmx2YndSOG9kOUg3Z1hOTWVO?=
 =?utf-8?B?NWR2dCs2b2sySzN4OHJ3bXpuUVJWTTNha2dqSHFYUWNiS2F4d3BKQklJMUN5?=
 =?utf-8?B?UlBmT2pmUUZ2ZjE2SXZuMndUdG5TeURQNnJ3SzRjU1VocmxCMGtiaDVDOUpM?=
 =?utf-8?B?Q3kzNzBzdmsvRGdtQkE0a2JWNUZ0dDRNakpiQkJBQStUcGpzSXBnSSsxQkEr?=
 =?utf-8?B?YmlPbmwvQlA4YmcrbFYzK2lqbVdJNU0zald5Tmk3MVlJM3lqWm9XQlRwTjRT?=
 =?utf-8?B?a1I1cHh2bFFpTFdDdDBvYmFKMGdrZTNFQnBadFlid3pGWFhJNURzSTdUeU5I?=
 =?utf-8?B?YTcwcWx1bmFBOG0xMFZmRDZlbU9MSit5cmdPZHJZeU9aMTZQZmt5TUJ3TGw2?=
 =?utf-8?B?YmxlREtWdDI3c1o2aUhONlliRndBMzJLUFcxWStXK3p4U2prbXBHYVh1QnBR?=
 =?utf-8?B?N1VDa0srQlVFNVR4UE1pb1h3NWdhdHhydDgwcWp5Y2tMK3dUM2hKNnRRYmpn?=
 =?utf-8?B?VUkvZG05UXdoaFFJdVZ6eld2YkdScytWZk54MjkzSmVSb0Q4RExZME02SlFR?=
 =?utf-8?B?d21kVk9Lb1NyMEsvd09xZ1pieVdSUE8wRXN0VjNFUjhwVTk5bTJMbE5qUGlK?=
 =?utf-8?B?cHRtdG9vNlB6emtjTFVRTWNreks3RTZwOEkzdzBoUjA4Ri9rUmMwK255Qkhy?=
 =?utf-8?B?SmNNM2FxOEl5a05LT0pvYkVXalFPNDlmTHRFb21hTzFqbm8rZ2tpeDhEbEo2?=
 =?utf-8?B?ZjNFQkRwRDZBb1BocjlCa3Z6RDhQSWJsOC9kNzBmYVhkbmFlRG0rZi9NQVla?=
 =?utf-8?B?VW5SQjU4RUxIZlJWd0JmWlJyVlppVmhsdDJDelFLQ3BRcjl4dEpwMDE1d09m?=
 =?utf-8?Q?DV0bHf+4D4Mp1LfkUD6ZyFWTM98EtN0gS4LviIFUm/cocQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd070a6-d0d1-451b-2101-08dbf5605f22
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 07:04:06.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gizpz83/XxBMBuJhLKpTQS+SblkScfZdkvI4iTWQsdMhwLGzjslHahAhMs9hEYQCzrOLl8up7ZGggWqbuIlhfc/3I6uYJcXKF4OCP50p8d9vv/4fL1r8qrCxp5XuJpmE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050056
X-Proofpoint-GUID: 29KYuvtqwB4P0u5VwcIEWuFRH0a7jGHG
X-Proofpoint-ORIG-GUID: 29KYuvtqwB4P0u5VwcIEWuFRH0a7jGHG
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

On 05/12/23 10:07 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 04:35:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> Adrian Hunter <adrian.hunter@intel.com>
>      perf intel-pt: Fix async branch flags
> 
> Adrian Hunter <adrian.hunter@intel.com>
>      perf intel-pt: Adjust sample flags for VM-Exit
> 
^^^ these both commits causing:

util/intel-pt.c: In function ‘intel_pt_sample_flags’:
util/intel-pt.c:1004:38: error: ‘const struct intel_pt_state’ has no 
member named ‘from_nr’; did you mean ‘from_ip’?
  1004 |                 else if (ptq->state->from_nr && !ptq->state->to_nr)
       |                                      ^~~~~~~
       |                                      from_ip
util/intel-pt.c:1004:60: error: ‘const struct intel_pt_state’ has no 
member named ‘to_nr’
  1004 |                 else if (ptq->state->from_nr && !ptq->state->to_nr)
       |                                                            ^~
util/intel-pt.c:1007:38: error: ‘PERF_IP_FLAG_VMEXIT’ undeclared (first 
use in this function); did you mean ‘PERF_IP_FLAG_IN_TX’?
  1007 |                                      PERF_IP_FLAG_VMEXIT;
       |                                      ^~~~~~~~~~~~~~~~~~~
       |                                      PERF_IP_FLAG_IN_TX


I have reverted these locally and then one more build failure

> Adrian Hunter <adrian.hunter@intel.com>
>      perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
> 
^^^ This is causing:

In file included from util/jitdump.c:28:
util/genelf.h:5:10: fatal error: linux/math.h: No such file or directory
     5 | #include <linux/math.h>
       |          ^~~~~~~~~~~~~~
compilation terminated.

Reverting this as well, fixes the perf build.

Thanks,
Harshit


