Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6918A7EE0DA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345057AbjKPMsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjKPMsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:48:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF91485;
        Thu, 16 Nov 2023 04:48:10 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGAsgmv023607;
        Thu, 16 Nov 2023 12:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pb4v2jxN84B2i/9UIrdvQNz35DjGNdf99k2DEz4qYus=;
 b=JT0+sLxjAVbBu2MZqZ6Cu6M6rgAA7W+sKOPVof6nnc72MDMAH4eWfDDwH8fp80OrmoRL
 OJesOLDoJ3GL2SVk26Raa77WqZSFLgTNSmc0LKaUL8GnMwR+r9JV8lVnJGEUZ+7TUyt1
 Nxweevxry/Nx6p6i4NuhKBAzMKcqmSQ3kAYe1qwAczbRw0GJ1hqDQRbIsKzPj151AqCR
 RsY+VXsgsmedks1treKNqoPNZRUW0U2I2t1IguYCxpCpt8OIz70mrTUFfPIlYLj93XH7
 D7sGI6+xcVY3Y5Mgg3ud6xdcI2RmW4kSIcUkuZEc7Jucs2NRNDT84T8hNorCREEiLR0q pA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2sttwqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 12:47:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGBoNht036988;
        Thu, 16 Nov 2023 12:47:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k6tmut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 12:47:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaNcoPUPuH6JOZLIryPje1zdeo+5c+MJ8XI6TjJwIi3VmRCRHsRJ/Uuo3WSY9SYUMLBOpbFP0Ry9ro9U4cJpKzWQ0k/0Hev6/j+rruC2urkuW9MJ0FrKEW3Gz2ZvLMzi0jYSQ7okrOTD3BDqYZ9KfMOEfDIV+4BvplLkuzdOw75yOuRfWMZha0kZBvUdKPKBQflthxjT3HwRQHU3VAxUmviVNHxHWhKWyZIR+BErHP36pJhdZA4JV64aqKYW0QpynIAfiSVlMMg+NqFG+d4H/toSm/JCaXGzGbAwoD9MBHXikVEparQ+0khcso8b2WBaMmQDZKPnM0ZaRuawef6DJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb4v2jxN84B2i/9UIrdvQNz35DjGNdf99k2DEz4qYus=;
 b=DuwTE25UkbK8azn28GQMN1Wei3RLFs4cR41PS+d6O5tmgK56TjZqTuqqHhqv5rl7CdN61HlBf0uNuIcjUmoTw9dCIh4uK141nOGzPKUvNMG/EcI1JfBK8LdZMVa7QMDnAEsB91uiskxyeJd+y3WojKknjbmyQLmzGFIyEdIDt6/CoKbiOYBy0ek/bRpKYYGB3knH74WzK9sNLyibECPG9fSypaxuCTbkoqoOqvlRg4IdhX6wjp8zgcLE3Keon5QHpvxTtvMOvV59mCbzfUImd7WNjR2S3ir3n4qHrSQe1exCVKrlIYrcGvSNp4zNDE2drJlbnnvm3y2FQjPqF8I9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb4v2jxN84B2i/9UIrdvQNz35DjGNdf99k2DEz4qYus=;
 b=yKHMUYPfcrsiCSF8ZHT4s8V4Z+96y4p/qPrHkEsGcYq7lZAipIKpGeT+GUdYuCIFidT+OC4nwny0uoRggy+B+sAirxJfIjsoT2CIbPLKwSu1CcowO12azhMQctGjB/BUBII2+Rj1UXQXZIBJu7O+DoI7WdiqduJiqwypGLn2iOA=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS7PR10MB5149.namprd10.prod.outlook.com (2603:10b6:5:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 12:47:21 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 12:47:21 +0000
Message-ID: <c28572d6-fcd5-480d-9409-ad9c807d7b45@oracle.com>
Date:   Thu, 16 Nov 2023 18:17:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/119] 5.4.261-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231115220132.607437515@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::10) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS7PR10MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2ab7bb-1e25-4dff-618e-08dbe6a22c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgDC5D25ZHPwwRTFNMkq9nRP50DezolCSvVvuXZUA/wC06spwuQD6n9ixETCcOvj8lIc7bX3SIjA7PLFDfuIEBwsk/j7jKtct5xsqGkHk4XjkNudKcGRL031OqLu9HrgxAeoLe1taFmk4w7F01KCV2WKshyfffWUNKyxv0Eu38SYB51wyGH6bwlrOX8jNvguWsxw9Rw0pQqbCB71DQYUYyLBdTRF9MNaIZBglijpeKl7gICNwPjuGSEbzmjYhDSYIKsV7cSZ2BBQULkbqKX1sqvv5k4yx2Qfjayt1qHoE+6eX9ecp7/GEnctxpoHWwFvAdh/usLQP7TZePDRD5msqJdyesAL8H9Rrr/8OvghEgi/q4xUbrlHQemGFelt6UujuUOhK/qoqN/uPCvL6GFGchdvl+NxZPveZLLFel4njOt0qijeDJF5kYSO4bZYndaHpa53WiH0pYhJxlDLmcHqVgsKLhHlAZXO1AlBdUnbUC1Lwlk9epi3oLZnR5dYbq/cuJyyO0xSgnReLarTAbRrn0d23qol7KsqTA6UxlYFLSKU0JHTWfX1l1XwNkROop2BasvDKlRSbcjfiZGvoOxu+f/SgeNAuL3igHSBorLfWRB1Sjl0CIqEtA1XKrylNSobMtbZsq9F4SfPKN8iFPkmZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6512007)(53546011)(6506007)(6666004)(26005)(107886003)(2616005)(8936002)(8676002)(4326008)(316002)(54906003)(5660300002)(7416002)(2906002)(4744005)(6486002)(31696002)(966005)(86362001)(478600001)(66556008)(66476007)(66946007)(38100700002)(31686004)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkZZKysrRWU0RElDVFNlblVQMDVZWHEzMXF3bmw5dVQxc1FNZFN1KzZNVllw?=
 =?utf-8?B?UTZFSVlZbmQ4SVBXQnVRaW0vazE0aUkxb1lJWnRUakRBQVB6YTBhL093MWxW?=
 =?utf-8?B?eE1UOXpqNjB1UTZTTHpRMVZUWUJYQk91UjlENTQ0RFIreHoyUkIxRWlicXFx?=
 =?utf-8?B?MElDUHRRTm9NS0NpcVpSWmM5MlpCai9ta1hWUVRKd3pCUW9PTjk4R2Z6SER1?=
 =?utf-8?B?cUh6TTNCQnRoN2Z3Mk5JT1FqOTd6azJnQjNKY1FzUU5ZSzFKVitWOWpoSjJI?=
 =?utf-8?B?Tk1RUWxaL1B6bW9TUW0rWlhZcTB0eFFkQ3BYelVud09QWHlXejUrdUhDSGcv?=
 =?utf-8?B?UjRzMXhabGtjZ3FMd1FLOExYVmhLN1JIb2k4dXR2ODdEUkdMeWZPUU9YcFdM?=
 =?utf-8?B?OFJaTUc1U2R1eVJkTGNxNThxNTF1Mm96dnRBU0xjN0paR3dqeVNWaGxFOE45?=
 =?utf-8?B?UjY0cjc0UE8reFp6OGl0bDluQzNxdnZ4RFl4Z1I0b0xxeURaY0ViREMrOExC?=
 =?utf-8?B?ZHZ5eXU4cldBVG1KOVpXbnNuUFd6M2kyTEhGYU93aCtKa2VTckYxSWg5ZHJo?=
 =?utf-8?B?YUdTTHY1d1FuSllsbGREYXE1RUFNZFJIZVNFdXRvVUJSaVRBVGJoVVpqVDVp?=
 =?utf-8?B?Rndoejd4WDVxeitOQU9BOFZuQm1BRjJWL3NjUDhacWUrUmxqejh1dU9sNU15?=
 =?utf-8?B?QnF4VUhWcUtPbTFOejVVcE96eHJ0dVRtUnJJT2w5Y0pGWVllSE5qRUVHQTRp?=
 =?utf-8?B?YTZIV2RPbUQxTnN0eUtFUy94eWoybDZFdlVPL3RuSVRVNGIrdlRXa0ZubFFU?=
 =?utf-8?B?ZTdScUY0dk12b1djZWhWSTZZQWtqMGRCZUF5QzZORGhGa0x2cmJLRHFCcHZx?=
 =?utf-8?B?bXltVU51ZlB3Rnp4NEtVQU1rbTNRUEJ1WnhSaERnSkFyM2RRL21lZ3l2QTZD?=
 =?utf-8?B?NFFCdEpJRDQzMk41bDFpOGVNSzIrc09Bb2tQaWk0K05qOWpUaDVKZzhDeWM1?=
 =?utf-8?B?WTY2MlREeWFlb2NxSFFORUp3YlRYVWVvTjJGMHRabXRUWThiYUVXV05RdFpq?=
 =?utf-8?B?RTlNaFcvZzdBSXJlV3ArMkxRZ0R1SHptVUNhSHBLMlRGTjV3SkY1enFleXRa?=
 =?utf-8?B?NnRsSzlQRUJVZldFK0dYZUp0TUE3ZkowNnlTUmduMmxrdVJST1c1UjV2VG5x?=
 =?utf-8?B?dWYzRWdCTXhrZkV2YXdxMTdQQkJhU0xSaXNjWDAvZUI4VzlYMkFIaG8xL2V5?=
 =?utf-8?B?anVDa1dzTE9UZWdJbjZMeVdWTG90RkpRSm5PYVl6UWhFajRRUHgwZURocTlM?=
 =?utf-8?B?bm5kbmpUb21kOHUzTisveE9yckhramlyMy8xeEhiakdWZk9Wc2U2R3Rvd0FC?=
 =?utf-8?B?Z1ZXL3lFVHpRRS9OR2c2V3R0Y1hHRm5BT1pQbFRKZFJpdkVVdlg5MitoSkFm?=
 =?utf-8?B?NXdFRldPTXZ6WlVYTmo3TTNrTkNHTWZYQXp5U1VQa3dwSk0yOURYTmJ0ZStq?=
 =?utf-8?B?T25kN0NmUEc4cVNiK0cvaGpCcGdFd2kyejZib0RnTFd6U0loV01xcTQwekJz?=
 =?utf-8?B?T3g5Rk5sY0crNVRTOTlNNkFXZ3JpSmVXay9CUHhSdlczNnlaZmdab2JNNEds?=
 =?utf-8?B?dlFzd1ZzOEgrOEJjbDhKTDMrUDIySDhYUmxBMjQwdVg3NHNNMHpEckVWS2Ri?=
 =?utf-8?B?RVpNR3BkY1ZJV0hrRkphQU1Xa05yczd5d1NlTTRkeGR0Z3NEZkg4TWxRT2xU?=
 =?utf-8?B?bDdFQlFGYnNhWnM4eUtRTFVMeU1jcXNvVDVRKzhGNHZPdWlySVJYVlhLN2hJ?=
 =?utf-8?B?cFlaQmlMSGV4aW5FM2trUXplZkh3MllrUTNVM1VpdWhLUlViUzlUbWZKZU0y?=
 =?utf-8?B?MDFOS3JHN1BaWjVEK1RlR3I5NXE3alAxd3Q4R3grV3g4aURybkYvRkxpbW5r?=
 =?utf-8?B?ODd1Sy9mNXlrWG1PVnBEVFdnTzdMQkRsczF0U1NLc0tEQ2tjcUZBUjNTNkRL?=
 =?utf-8?B?L3h3cWtyN2Z6WmVWM0VYNG9xbGpWcC9UYlQzODdZWW1pQkZsbDhlQ1dJbE5x?=
 =?utf-8?B?SXlHV3NPSklmeGd5T0hWd05lOVEzbUs1RUZ5a3ZTMnU5RWxqOHEzS1lVS0wr?=
 =?utf-8?B?Y2xEWXZlandha0xiejVBWFM2QXpRd3VJNnJJR0N2bGJwWTZMTzhBSGRBU3dt?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UGsrOUFERkJWZzV4VzRRU21wUk9zRU1IZTNMNUZQRUVGZFc1TmV2WlFncXV5?=
 =?utf-8?B?S2s2bHJSRktYL0hxL2xja2NBUjFtd2V3U2ZJQXVScjI2eHd6TTgvaVl6RmRL?=
 =?utf-8?B?eENZamxLUmFRd2tpeXNRWTZYUktaczk0Y2VyUVNnemVvdHd0RTcyektXeUtz?=
 =?utf-8?B?Rk41WnhzekQzWG1Kcy8yYVJlVTFzZElWcjExdy8vWCswY1RXQmNPZEhjdVBl?=
 =?utf-8?B?bzhkS25YYlI4MUg4N0UwSkovLzN6eEJOeW9wdStOdFRQR01SUERjRm13dGww?=
 =?utf-8?B?UWVnRzZvWmtvc3ArUTh6YjN4QU5yNGlwMmdnYUExSzI0dkgxWURnTFU4UlpT?=
 =?utf-8?B?V01xYWMvMk1ManhQMTdnYkFBSXU4MFhvK01vdkNFUzFwWU9JMlFVN1BSdXh0?=
 =?utf-8?B?VVV2SXhIMkdYZHovZHRTVGhpVUZ2UDBEbHExVlE3YjM5dGJ3UjhObmVnWUVm?=
 =?utf-8?B?QXRod2hZQWRwcEV0ZCtISVBVeU5JY2wrOS9PZGNaWDRQT09kLzZ3NUhDY2dG?=
 =?utf-8?B?dVVQSUdFbFZHTkxoOVp6alZ2cEltZysrSDZaZTNtY2w3aGZ2QnR5RFU1cGxH?=
 =?utf-8?B?M1F3SEJhbDNFLzI1L0tmUlBZam9mM0l1QnFKNHVJU0Z6T0dha0srckcxbmhk?=
 =?utf-8?B?bnJlM2hpS0NPZzloMDBUd0oxR0luQUFaY3FDZlpBYXJVY0kyd1RTdUErcGo0?=
 =?utf-8?B?SDJJT3U3ZWd3clZab0d3VXR6V3AyU3RSbkgyb0pRUEdlQXVQSVEvNGpZc2NI?=
 =?utf-8?B?d042c3diMTlCdUpuVWRYMFNlbGtNVTMxOFhIZWF1cXBBK0xYc2NSOXNjdHIr?=
 =?utf-8?B?bGQzdXV3aGxZelU2UHpkQWZZUkhZdHFUMVlqWmg1aDBhTG83OU1kWmpNZWpi?=
 =?utf-8?B?YzJ3MWZDb1RkeUl3NjRqb2l3cWpmbVJUWUhUeS94RUM4SUdleFI1M3pTNllY?=
 =?utf-8?B?bWxWS1hjanRtOVAwNnE0cThUVHdFOERHY2RxNzYyQVUvOEtRbUFkaTFKRjFT?=
 =?utf-8?B?VGJlR20raEFzZjNTZkhjUHFQVDlHV1VhZ1FqeVJSM1FyMm1KclhWWEJhYnBx?=
 =?utf-8?B?TVVIalNKV0lvMWliTFlpNENWTkkzMnl2QWhOQnBncjIrRXdMYmkrQjhkbEpk?=
 =?utf-8?B?dDBWQkhmYk81ZkNvNHpZdmtXTGNtSkEvYmk4UTBudElxbFR1VXF5NGpIYnRw?=
 =?utf-8?B?RnV0UnVzRlR4amo2blRCZjlvN2VMVHpyRXlweGdhZWd3aUNDUmJib1VtSGls?=
 =?utf-8?B?dmNDa21lRlBpNTVNOEdWbGs1R2hVb1ArbE9Ib1pvUU5XSk9lK1JBQ1A1Zks1?=
 =?utf-8?B?ZERab3NWdFcrYnJ3dTlua2l5S2dCUGNzZ1RBZDY2akwydEs1ei9pc29lVms4?=
 =?utf-8?B?ZDFZSkxVVFViOFlmaDIyaU1zaVNuN3pjUG1XTmg0MU9CMkp6NGNob0d0cGZO?=
 =?utf-8?B?VTcrZy9RcVUwek1Sd0xQU3V4amFzNXNPeGZGbjVDUGsrYVlHaTdUN0djL01M?=
 =?utf-8?B?TVpibURZVjdaWUtyZlRqUXRxWC9pU0NwYlB2MU8wWWJXLzdGZG9kS28wYitL?=
 =?utf-8?Q?b2p0vf5P2tvFaiaB/+Lt5fP26VLwT2ZnnXI0NFGapN22cV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2ab7bb-1e25-4dff-618e-08dbe6a22c70
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 12:47:21.0295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Be/2gZDa/QG9aYwarPZVJ1u3w7JDXPs2+eANBRquA8mvPDk2uKx/O30nVke2Y6ScDqMwXQiLZNSowx3nypRnZSDcIccIIRFdM3BqsTHhjjviJuLnh8hUIchsJIZdSIvb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_09,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160100
X-Proofpoint-GUID: uyYA2vR39TP716_CHYsiUCDtEXlKqSXr
X-Proofpoint-ORIG-GUID: uyYA2vR39TP716_CHYsiUCDtEXlKqSXr
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

On 16/11/23 3:29 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.261 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 22:01:17 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.261-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
