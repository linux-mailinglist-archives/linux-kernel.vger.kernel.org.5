Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC1F7E27CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjKFOzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjKFOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:55:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C2B10CB;
        Mon,  6 Nov 2023 06:55:38 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6E3rhn028427;
        Mon, 6 Nov 2023 14:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nlmANl39sFNkINzrUTbwKEisqfkRIkxNnSR3kqDF99Y=;
 b=KX+Vvj3Vh844Up7abzjOaDliIH5etcjHOqoh6WC9BsUI8v9cnD68XjOpg4y8IxfdUbXK
 fUeXzi/9TIWZjMqEXa3BuTKS6AN+t6OFgnGq/ZJUE3TVezDLpuwHXHVxMIpJqQ9/ma6t
 pTFK7RBpLEWmUaEqr8dO2k99IocmvY0KECFFOTfrj0fVKnNcK61MC1juQ0e7Ndpue2+R
 oCpgZHt3M4zfSGvmc1fZuiyuE9nkZyOjOOHcMUy0bgRG+3kZqbR2BRliLi5P3qE3ssBc
 dAcxKeGcBiDVlcwZpfxZkiszHHhfIhKox4T0/o88mgKA4azFHKSPSYNhl9mWKMIOOyx1 aA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5e0du8p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 14:55:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6EXCMP030416;
        Mon, 6 Nov 2023 14:55:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd50eqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 14:55:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyJC5R3fgjE5KUTsU3qtooa7+XjKmHs931NTj2wJw+bMlOmEtga/UaqLMvecI5hQho0VGUuglAeQr7s1voO1I6U3RCaYbcqsc/UBDc2j0nS+oZYxDtUJBMf7ivwkI99nfRsaHohiGDKDr2b3s7MOSfIEBIikstt2q1fJhG1xoW9vQ9+z08pAD2Q1/1wM+IffFijHY9As4AdaFP/GzlQQSn/2SCKy9UtsfvOtOBfomXO6t/3s4AD3VDwJryDKvtoK69xQ72D8Suij+Ac6Ay01XbYFd3qYIQbNMJydbEBv4JT415f4hHHVl03MAyIfcyFfwBAhOwTMxYlo4a7dOTOczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlmANl39sFNkINzrUTbwKEisqfkRIkxNnSR3kqDF99Y=;
 b=gvNSNTropXpbkQchsOP+Eqi5Hyh15ld1oMmpAFIxyLwMm3jWUCLH/oDqgzNJbqI9PvwKsHzIRnpB3rxXYorqTz3d4Hf5YTJvgK7PsJ3J5rt1OgM4HnOdIfuSADVgwRRZAlT45wRWSA68nJNsUc5ckQuTDNAcPRtMsrFm1aw92l7cox7FU2OuucCGVsqxl1Rr6GPyCiYnQ4DBUATmGxRNF5M3vmr5rcJCTrGPX5MhSTydi1GW7cWfhkQnoFkhcBEQ0dUZFjQqSDCAwm2wUh+/fjldsqbIrrYGYHgnbp7G42bEbY/hpQq4yRfcJNj8rJTuAm/0uOK2uPyT/0tpu7Wxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlmANl39sFNkINzrUTbwKEisqfkRIkxNnSR3kqDF99Y=;
 b=YIKfxLujQIDNgRynfjhxcYTmhbNWTwvjGNuJTirPV6ffW+MY9KyNpBY4yWGOaBkLCJRuRdLh2yb62kS7t0MJHVbc8GWtVGontWHvwoaSikJ/gh50wqPzeNtN6gDqem7KgxqyWWE2IJAD/m6D5uIKsEdkWiDvD4g8itWAPXrrvvw=
Received: from SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14)
 by SA2PR10MB4729.namprd10.prod.outlook.com (2603:10b6:806:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 14:54:57 +0000
Received: from SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::f3f5:8ec9:ab84:281a]) by SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::f3f5:8ec9:ab84:281a%6]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 14:54:57 +0000
Message-ID: <2665d8bc-111c-45ca-a473-b1c892867e9c@oracle.com>
Date:   Mon, 6 Nov 2023 20:24:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/128] 5.15.138-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        mizhang@google.com
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231106130309.112650042@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR10MB6287:EE_|SA2PR10MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: 936ee3e1-76cd-4b41-535b-08dbded857d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7p6K8o+DlfowPgDwKKy3gYOQmKnrnfSlT5PlpC1MB32XfHPVxzu+YIN9ucfxvYip05rSMuMVxmNkRITJlsasThgIIW6n0qTUpKfTNNf0bO1LPlMNZAn5DH67+xxjKbBblp1QMze9i5+Fcd5OpgKefE3XUFQyabgACP2fIOIwk6MODh7m3nG6rREET/5YXY528gfGYlL8Bv2Inbk/nP8DRQQMAEYSak2+wftVwULoPMYMT1OUiic+yo5wgP7jZWGmDr5qSpsqZARCBjxzse5TzIetfdWQX/vIq8ebixxKSRDFtQyyibsDWCtCjHFjjXLiGPZ9beYZ4UYj13eqwkZyHV5JnQMpdju43puunIp5ifZ8DaXd5QlP0K2GC+LArxvYouSVYc/PZcEY/k8Rf69zJt3y0ep2KOC0kSDu+oauMw4fsHjpbA/EV4WTAyr0Zn5DgxceP7OhzPnUjAYREaJbsb/bnqTOiaEvbMhahWWNAPpAH/MWazWNtuWM/Pxr8YdA1JKA6iAHBDdcrHkkINLfU7VG/EOcU+f+nfHy/NjwYFx8iSai0w0nLPmhOr17N9aHMdkH6hAvcdfSAmLbrpo/+2iCl+Hdl0VrQAw1hWcS72DPrUTYAXrA252+bLG8k8ksVjPR340T97JTD/uovbeCPPa91eyocBn7YckLcfbbS/oUVSJko3CJweI6ZrSTsZgd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR10MB6287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(83380400001)(53546011)(107886003)(6512007)(66946007)(110136005)(2616005)(26005)(478600001)(6506007)(8936002)(8676002)(4326008)(6486002)(966005)(66556008)(66476007)(54906003)(316002)(6666004)(5660300002)(7416002)(41300700001)(38100700002)(86362001)(31696002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SytwUzY1cnlwU0w1WktwQnpBL3psMFVTb3dMdUpZcjVzY1FWWkFUc0U3SVRY?=
 =?utf-8?B?THNOcko4QWRuZlArdzFPMFpkazcyaEw3L2syWGNtRlpIb2p2a1lEOHp3ZG13?=
 =?utf-8?B?QVhRZ3FlRE9DVjRKSFBpSklZSzRNVXE0WFJHc0R4bFg5cS8zc2lrK0FlSXlt?=
 =?utf-8?B?WGl3Qzc5RnpZOWFDOHMxcFpaWGpFeU9FeWhydlRRd29jaE1laEE2OHZaU09a?=
 =?utf-8?B?VEczeUJFMUdwV1pVTG9GQVdidXdUdDFmdlFtSzc1Y3dhRlQzYVJRbmppbEVj?=
 =?utf-8?B?SFN6R08yeVBuSU9QamFUNTVUSWZaTE5lQmt5anFpWDVTZHJILytMbHM4UDNr?=
 =?utf-8?B?VVZTdWRBdE5WUTFrVGdZOThoOHZzSEh1ZGV6em0vcnY5UWQxUVdpSUtCTXZp?=
 =?utf-8?B?SFNjaFhRd3pscjhGYTczd3JmNFQ3eVJsRHpmdXd3TGVraFZXY0dvQktTSUJu?=
 =?utf-8?B?czJzZ1NIa0E2ZjlXVVYyRHZvWjFKdXFvUGtkVkhnR09hZTh3Q09mL0laeGJr?=
 =?utf-8?B?YXY2RloycVBJL0dLaSs0ZVord3AxUytnWnBCQWM0eVFGYTFPNG9kRFJQNWVq?=
 =?utf-8?B?QkNKRGprNzdGUW5saHVtNGxMT0JFNEZIeUtZVW40djI1a3haWEtETUpXeUF3?=
 =?utf-8?B?c085N2lTaWlXM01YelpBMVRvb0Q0N1lsOHdnYzF2ZHluTnBucmt5SzFDdFRN?=
 =?utf-8?B?aEFIZDJlOWtWR1lNcUp4MjN1VHFjZFo4SytycjgyNFNIdmdpTXowVm1oa2Rh?=
 =?utf-8?B?Vnh6UjdOK0czZkFGL2xtVlBKdVRXTGptSDd2cU1kcExwUHBCYmlVRjhCME11?=
 =?utf-8?B?encxQms0UkNBV1lTTVdlS1pKMkh0MnMzeUZYYWlubDQzSytDeVhiNWxtZG13?=
 =?utf-8?B?NEJQNEdlSGV5bWZKZjFpaVYzSzRTMk9zUzJUVGtCbC82M3FuaGlrTjE4enBa?=
 =?utf-8?B?QzNHOTc4T1BKWktWN2drTWVoc0NKUkoxc3ZpV1RMaVNjR3RwSXVGd3VaVFhS?=
 =?utf-8?B?VmI5V2Zwb0JJMFgvM0IyejBhT2J4ZXZsYVljTUxDeGl2SmIzNFBHM1B4UURz?=
 =?utf-8?B?NTRjOFdsK2VWRENyeTNaODYrY283Vzhzd2kwS1drdzRVQTZDQmRDR25yYXoy?=
 =?utf-8?B?bGExMkdWNWZORVErdnZQZ252YUVpSm1MMkhERWczeWpmWkFlcHZYZGl5Z0Jo?=
 =?utf-8?B?SStpZ0kvUHkzSFpKUks3bS80R3dzQjdhWjRqd2tXaGlhVnRSL1lmQXlWZVRq?=
 =?utf-8?B?NlZLQk9YbHhsRjJKRlNFZTJtc2Fic2dOK2hkZitOcjlSY1JBU2lma2Q0c2Jh?=
 =?utf-8?B?djhEWDNYdkdWUTBhWkxrMlhBcnBvMW5XaHpRM3RpYU1acS9tYjlFV2gvM1g1?=
 =?utf-8?B?Vkczc3ZpRVhJYVF2TlNPOForSEphMVhKOGZJUTBzcjlSTkpVeC8zNWRZK2pF?=
 =?utf-8?B?KzdQMzM2c0Z2TkNwMzFTK2hpN0EzYlRsZ3crS3FraDZCT1lkTVZRaXArdy8r?=
 =?utf-8?B?OHZSMElSc2tiMnA3aXhhVDFOckx0WEtJY3FDM0JoRHpIUFFiWUhwclFVTm9X?=
 =?utf-8?B?ZWgzVnI5WlRiQnZDR3hHVldVMjdaZElJQmJvaG5xLzc2OUZTOXlhT3FpRWZn?=
 =?utf-8?B?T1VpWWZXODczQWQvbkh4QnNQQ1A4S1RUVERxT0t4eUxoeFlpWmVIejMyUXM4?=
 =?utf-8?B?MTFBM0dYalRXdnpMc0VnUUlOWmJLUFRVNXppVG95UkJwYno2cWl1SVdHNFVE?=
 =?utf-8?B?K0xNbW41MUdSSVRNeVh1enltSEZoS2xtMmZWT2kxdlIvYkJML2p0aTdaaTdB?=
 =?utf-8?B?aWFPenBtSHNlS1dXQmJOTVRtUTc2ek1vVzdLa2xOaHNjckpKQmVNbi9LL1FY?=
 =?utf-8?B?K3pLYXk3c0pVTGlHaVR2amcvN0h2ZWE2ZlI5ejY0Y3JHS3pLYkNMQVI3NUNG?=
 =?utf-8?B?eEpiaVdmOTNFNDNNaVZsdHllcWRPOEM5ZmJWVTAzWkhsckhvSU5WNCtIS0Fx?=
 =?utf-8?B?eDdTQ2k2OVBvektacDZRRHRxUlNSVUhlWmNFUjQ2UGxESWpCaHhFY3NDRjBy?=
 =?utf-8?B?RDZ2bmc4bkZOc3lEVElQUVc3Q1l3RWFZYTRrb1EyZGc4NExKVWNzcncxdVFO?=
 =?utf-8?B?TzRnNzZDWEtndTV0T0RsNEhBTUNhQkNDWXJMS1BSTEI4enFXL0R2Y3V2enJv?=
 =?utf-8?Q?2MHeUkcIUycy8v0vJ9qWG5k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dldGZEVyYVhGeC9EUFNyaFptdjFlMlAxemdyUjhBOE5lcEdSSzk1WjIrRzlu?=
 =?utf-8?B?OUp6bmVkYnc2akxiY2JWVWFrdUJnaFJEcFo0UFQvZ1BTN0NHRXRrZ2MvVjRk?=
 =?utf-8?B?RFJWL1doVXNqTFlvT2hobzdYOEFScWg3aS8xR0ZUR3I5WkpXdzRsZGtzMjA2?=
 =?utf-8?B?SHJPT3hwWlVPaVNUSFFYS2hycE1JLzgwRUZvWWxWQWxPb2h4SnlWSUxacTVs?=
 =?utf-8?B?WENpN3ZMRnY3bC9SQUF5OHJscWhYcFdlYUhtYnl2WFAvQzVRaWM5eHlXTndu?=
 =?utf-8?B?MWFpdXRpMkZ4M3U3dGdYb240TWtZR2UxZi9LRExIdmc2dUxUb1V6Zms5Z0pG?=
 =?utf-8?B?TFFndEk0bEwvWnRnSEhRM0MzVG03cjl5V1R4SUFmN1lnTXpCZW9OSUtObjBn?=
 =?utf-8?B?VnZnbWdiRGQySWtTaWZtd2txaCtVMUQzek93NTQ0ck53RFJ0aW5NOVRTb2tL?=
 =?utf-8?B?Rk9jcVdzWmpYQWxqYTUwckNydFN0c3Z6VkJkeGk3MWl2QVNKZ3FnOE1kdzNU?=
 =?utf-8?B?Y2QrSElwRkxCWEIzblNXM1gvanF6YVR6RGZqS3lrMitJUHllb24wMVg2NUNa?=
 =?utf-8?B?RmlrREFoZ2U2WDVSL1JTY0pZZ004ZWhpQTNla29VMVdhbG9mK2ZwaGduTEFz?=
 =?utf-8?B?djJZMG1wbWV2WWxMNVZKMVpsQWVWT3lyVXpWWEUrcU0vdHpYMlBaWkpWaC9W?=
 =?utf-8?B?VHdua1crSFppaUxlclUyYlc4N2czbkpXTUhjTm5KanRuNHRSQkhTUXBpNkVG?=
 =?utf-8?B?M2dvWVYxQ2hNRS83QmRta3F6VitKNVZUZVk0WmlGWVhVb292enE1a3dnVmZ2?=
 =?utf-8?B?WG15Z3o5N1FHSU9ZR2RHWkZxWlRJbCsrbGxvQ3d0NHdFTEVIWnRmdU04Q2gw?=
 =?utf-8?B?cUh0LzMzeFA1ZlAxT25wYWFEd3hBQ29DMmt3V3lwenhqb3didDhhTkh4VTBs?=
 =?utf-8?B?M0pHbGxYbjNiZWFOUU96SE5jRXN0VXNXaldkSnNHNGoxVGZnY1lsb1lNZjlT?=
 =?utf-8?B?SHNQSFlBTW5ISUltbklqZ3N3d1VIbEl3QnpZVlhZc0dhYUh0TnJDemcxMmdS?=
 =?utf-8?B?SVJjaHo3WWt3MEtHM2lTc2JwT2IxZ01BOHViQlQ1VlRSNWRWdmZiaW9YWHVI?=
 =?utf-8?B?S1J3N0UvMnhXK21yMUxQZWc1cyt6TDB1RSsydTBSc0RjYy9XSWtKbzNwNnJT?=
 =?utf-8?B?L2IvSHRkNHIzaDMrRGdIZjlnd05NeGVaQ0RNMUZOSE9pT014R2xEYzBJQ2Vz?=
 =?utf-8?B?M08rMTNETTFlb3R6Uks1TzJXbFRKdkVPQ1Y0M0p1Rnd0SCtHQkdLZk96bUE0?=
 =?utf-8?B?aTZMcDJXUG5UWWxEVkdMdmp5a0pRWDcxMkZNV2JHcTNDQ0Nic0FEakwvY2xF?=
 =?utf-8?B?UUpxa3U0dnRJNkE3MENiNkhPbjJkN1NzUklzaFlSZTEvYWRxbHFqdHRHQm1S?=
 =?utf-8?B?eEU1QnJYbE9EWnRRZEFrV00rUTc5bGg5ODRqMjhDNU1RUVluQjM0eFE5RGQx?=
 =?utf-8?B?dXQyaXUzSWduN3B3SDcwVTg5aG1pRXhvZmRodjVwT1dTTktVWGZZUGRnVUNu?=
 =?utf-8?B?YUk2WkZEZFppc09DOGp5ZUYwZ2RSZXhZNlcrdjVab09zNzhOZ3ZCQWJvTlJ0?=
 =?utf-8?Q?7AbMAmGm2AkuiAp2ld1b6QL9hrwiwKwjV0nFFlEaf+ew=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936ee3e1-76cd-4b41-535b-08dbded857d5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR10MB6287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 14:54:57.4429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnRwarxfhXw/5ClxyQutPYpbNnwt+Gw8fD4hFlOOLdycLHfmTgJBaFMVaCz1P6Llx4Y32KHmMVSLVqmybqW3Hd9hF05YCD7rwIteAi9q4WaAUV/XYW8PF99YoAbatNNr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060120
X-Proofpoint-GUID: 77i7wWuFdPrftjLg-FrUfe4vVgvmQN_Q
X-Proofpoint-ORIG-GUID: 77i7wWuFdPrftjLg-FrUfe4vVgvmQN_Q
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On 06/11/23 6:32 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.138 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 

I am seeing a build failure with perf:

tools/perf/util/evlist.c: In function evlist__add_aux_dummy:
tools/perf/util/evlist.c:266:31: error: implicit declaration of function 
evlist__dummy_event; did you mean evlist__add_sb_eventâ€™? 
[-Werror=implicit-function-declaration]
   266 |         struct evsel *evsel = evlist__dummy_event(evlist);
       |                               ^~~~~~~~~~~~~~~~~~~
       |                               evlist__add_sb_event


I think we should drop these three commits:

20a5799cae7dc perf evlist: Avoid frequency mode for the dummy event
7de783c81c7e7 perf tools: Get rid of evlist__add_on_all_cpus()
141ce9207068e perf evlist: Add evlist__add_dummy_on_all_cpus()

Backport was requested here:
https://lore.kernel.org/stable/CAL715WLTjMGQrhm6wWqFSeL_Oq-HzoQd5CqewvLRLv0Xbnibgw@mail.gmail.com/


Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.138-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
