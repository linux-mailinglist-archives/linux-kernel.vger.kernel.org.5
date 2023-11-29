Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A087FD735
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjK2My5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjK2Myy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:54:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B3810D4;
        Wed, 29 Nov 2023 04:55:00 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATCi7Vu014718;
        Wed, 29 Nov 2023 12:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BiMqrwaN1L/MpFqQ86i3RfCnOsiXyhvsXsGMoXEHn4Y=;
 b=eJyFIXJqipNE+2knII4hLqvNvPClRrTjvy1/HZxxypWg4opjeqyNPKWK8jxOJzP/Z+4E
 S9T2VgPr5XJxNW95etw6hR5PvrnO0XJyLdQ1lv5VrYzikB7D7HoHRIrjvIfTZ17XrT/h
 kXU54s6d6R4a7DEWtp6xhByJkN2e3KRVWbXnqM2r2pJ9SwbCm5yac14gr99RaNE6Lnty
 Lpbd1y/TZHpgLZiYRGEiN9IWk2PFSmwEJ0PJWQXmXkVSoXo7JYCBWKCK5QsVtw+roIro
 B9YPmgh//OTnoLo8C0JZHK3vxLZUSFl6K78cuRt3ZUP6edLfShgN/sYyzbClkaXKGYmT Lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3unv9499rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 12:54:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATBHQK6012787;
        Wed, 29 Nov 2023 12:54:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c8t0cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 12:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQlPVOT9A6joAlJoCiV9nWaKEj323dFiXTIC/lhm/f6KIvcyFE9ENOCDaUV4KhTI4PAagXOIjvIv+X/EU5Nxz0gWWtEeCvA2Gu08Beb5/zexBOOrScKwqW+TpcjGWYrEO6jFoZLQMhycVY/LCmKQ9W0Rk6f7tTirQp+qRa3nUOkwPX16kLtxqHuh0UhuGxr9tkaPPWIAFITtgYjslwQ4bkIFKzGC9+o6wEjBoa/V1jhJYTW4pwCb9zBfyd2OWG3mchNbDaUH8vvP5Ryfl1AMaCqZ3BIVW2DOcglHEZB160Q4+wilNIuf6s6g8G7e/y20Y0U9NaRB0Theahz1g+K0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiMqrwaN1L/MpFqQ86i3RfCnOsiXyhvsXsGMoXEHn4Y=;
 b=CKnGYOH6MxhNsUe74iHK3avlDTz/rBmJbvDB4SAyVl9eYRu343G4NNA4WWSlSbGRZSkwsJEdtrI5/wVNvpXfiFm9yjfSudjOtZ6MQ/PiRLhY4DoBVp7IjIsxB5KdH8i7Q72XFC3sBJq4xaGPzuqCtGz4vHY0OOW59komw0vaArYjpKdl1hrVhsEfvJip4xGaUo3lcl+vNBhAsvvh0Cm/J23M0DCQEVZoALlnhz6NQgj7fR86IrQb1OUiHGnyfkFZ73inErK9iCRSby/vuIvdBDtWMeSMqq8l/78qXbP/puqCR3+7NVfRhqBBXxACkP/vRCQFQFJfRc24FSRIlfVLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiMqrwaN1L/MpFqQ86i3RfCnOsiXyhvsXsGMoXEHn4Y=;
 b=piZ8dQcT4zE5mOpD04bOYFGicitl2OwalSzjL8G0jldCUH+N6Ls7Tg5GwgSiIIWfNjVsEN0p+o2GrgxEruqt7JlVm/FOVlWfSEjP+ZHbRBcGLbAdgU80km7aTV7wjRY/YZyk4ONip1RuLgKG3YNiQ4ofZkB/Mf5Wp8lrSOk6Bvg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4997.namprd10.prod.outlook.com (2603:10b6:408:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 12:54:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 12:54:37 +0000
Message-ID: <cf98eb9f-ac42-4d9b-9cf3-3085f6fc0cda@oracle.com>
Date:   Wed, 29 Nov 2023 12:54:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: libsas: Fix the failure of adding phy with
 zero-address to port
To:     yangxingui <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com, chenxiang66@hisilicon.com
References: <20231117090001.35840-1-yangxingui@huawei.com>
 <32c42e1e-0399-4af4-a5ed-6a257e300fe8@oracle.com>
 <307d251f-ff49-5d8f-1f8e-aed314256732@huawei.com>
 <a13f0419-c4ef-4b8b-9757-7cf7cea32458@oracle.com>
 <baacad33-f568-6151-75a2-dfc09caf2a81@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <baacad33-f568-6151-75a2-dfc09caf2a81@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b2ae20-7b6a-4604-6181-08dbf0da57f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rj3mG3HhZmmmuRZAOb46oQA09vPrLILemCEJfziBEZBfUurbse2zs1iwE1oDByMWxd5bYPJy8c8aViA43elN87auR5u/miXM14LZsnx//NG/lAJ/8bpwICzyN8pvuMKU4c3F1sORsfV8z5raLGeeKmO9sJae4eSO+75uNxjOxkTXhUf5gpLz3jLgRwcsSvfObieZ9nF0t3PENX38aa891PwKCbizUxofuGkqM17VYbfa5v9AvoBXwLkI03rCu55ExgkYz5UIkHo+wjeJAtaLiHg1J943ydEcZvIHOq84cx14L4ystAHkH7N+V6+nfTzJDKrarPCkxAnJTru5Z0+0cLlxC6U7PrairgQfUkflOCgYC3JuBtGqcpERvAYsROKVBTCRjaUI8jOYr/HPx9G++q4yXhIkfV5Yyd6KTMMmEgk94oaXo40Tg4jZnAOmo0N5GcechpbjRvdypl3Wmhe2TxERtpcOV5KAjIfkb9QAkheSGFuG1pkA+61JmUM/VJgOD/Rx+59K8NbO+IphvkkcUdrs0WlvMgNzHxIfgeL1Gmzh43idsHkOy53WGe0ia0oVmDy/Yb/FVkDPBqCnpKpxordAH1VWLGkpN2pWoffJdAQTMpb6I/hRSTovxiEOMmZ6OhKDDFrv5ebz27Gw/AnWDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(36756003)(31686004)(38100700002)(2906002)(86362001)(5660300002)(31696002)(8676002)(4326008)(8936002)(7416002)(66946007)(316002)(66556008)(66476007)(6486002)(41300700001)(478600001)(6666004)(53546011)(6506007)(36916002)(6512007)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVFLeUtlY2JNNmtFek5vUmRiSGw1WkNiRFRyTm12OHY3MkRZekxGRDVIVU5Y?=
 =?utf-8?B?eTdyQzd5cUk5UG8zMmFnNjRPRko5NlcvVTByS1JxcWpwSVZPUHBaemRxc2tn?=
 =?utf-8?B?Qk1FMlFidHhKbHUzOTZBL3p0TlUwaGloZi9IdjRBbldrV1BVOXJpZkdiYkZN?=
 =?utf-8?B?OFphcGF1MjE0b0lYWnFoSjQwZ1QrWDVpVzBjNStwcTdYMitRMXI0a1plZkZu?=
 =?utf-8?B?L2dlRzQvTFNYaDNGSE0yc1R1QXJ0aWE2RUg1UmtuL2trWnFVSW5iSURYazN2?=
 =?utf-8?B?YThYTUpnRm00SHNoVGx2MFVtdmF6TkorTjZFcGVQQTkzQW9KaUJSZ0NTQitB?=
 =?utf-8?B?bUJ0cUt1ejVQNmxOZ1UzalQ0Uk9hSWtSK2lyRi9GRXZqeG8va2M5S1VLUG9C?=
 =?utf-8?B?c1BScm9aVjBZekVjUlB6WG9Eb25UY2NNMHRqSkNxckJUaDhwNDliN1lhWXFr?=
 =?utf-8?B?NlRVZGozeUdZOUQ1em5oWU54MGNGVzVTWk9tc1duS2JFUnJsMjRIVU9pV2pk?=
 =?utf-8?B?dEoxQ1FFRUI3T2Q3djFRVlhmU0ptdTFzUFJJZXJ4ZmtaK0tiZzloWDNzZ3Nw?=
 =?utf-8?B?dFVZZ2FLWW9INk9YanlhMTdYSktrN2VLUnQwL1F0SDdha0NaQVhzWTd2RGVO?=
 =?utf-8?B?RkVISFVmTVVQRjRvWmgxOEdIbE1sN1VXdGVSeXNLSkxlWm1XUFZNdFFaMFlU?=
 =?utf-8?B?cVJFNjBhUUN6Y2MyMmhPQk5XdTRHSmRidDJGcndMMEVaZWpnUzFTSnNXVnVQ?=
 =?utf-8?B?cnNNQklyWWdPNHU1YzZsMk5WdGhaK1JOem0rY1NHN013ZnZCcmZkWGovYmI1?=
 =?utf-8?B?NVpFZldrSld4dlVkYnFtclZieW05RSt1T2o5Z0t2Yzl5MVRpWSs1eUNFUUdK?=
 =?utf-8?B?QXFGKzRWVU1tY3lVdDlnTC8rd2hTTE80YWxRTmplWk0vUjFGQzRwY2R0Wnpa?=
 =?utf-8?B?VUVSelJqbHJOckE1NXlkQzl6Wit0WWlMQXBaTFdXNXM3a2E1QnNQVk1BVnV4?=
 =?utf-8?B?ODZPVUZqUmNnbStwcXVyNHoxZDQ2WnlqaFk5c3k1eE80cWlURFgzanVQbnNs?=
 =?utf-8?B?bUlUNVpZVldEdS9vMDBmRC92bEh0d29JSloycFg4MjRPTm1tK3VvOGhXQi9N?=
 =?utf-8?B?SHVSekJBRzF0QzQxeWVWWFF5bmozMUM2azVUcituMFZ1S04ybk5Neitzd1FG?=
 =?utf-8?B?WTcyKy9CZkJ6VDBMNG5wanRreTRreS92V1owMjM3ZUtoZHA4bkZBVEJTQkIy?=
 =?utf-8?B?VU54aHlmWHgwd3loVGpIRytmVG5XRnVERVA2MzRvRG5tSEFsT2dFTzM5TWhi?=
 =?utf-8?B?TFNYNmo5MEh1Mng2TUFQK1l2RWFEakRXSDJmdDkwa3gzbXhwU0F1Rk5VMWNu?=
 =?utf-8?B?UkRJUEYyc0V6OHZrRHlRZzk1ajlMOWRCZ3VvTDJPNzNTeVVIRXlrbW8ya1pz?=
 =?utf-8?B?cWt4dFlLMjY4VTdxb2R1MWU5aXlRdjhCYjJScE15YnJtSHFGZTNvRmoySzlT?=
 =?utf-8?B?Z2lwSlZqUVNGbnN5Zll1TmtpT2tZaFhhOVhWOXVOOUhNUU9rdTNuVjFOUWxz?=
 =?utf-8?B?eFk3c3hCd0Vtd2RiWDhZVS9CUEM4YzVYS2VrWVVxaTFxMThmaGdJRkU4eDJX?=
 =?utf-8?B?d25ZbW5PNnRTbHE5YmZXdlMzaXI3U2YzR29tYTlZc091dE5xNzZTK1lUSFR2?=
 =?utf-8?B?d1RjckxQcmZid1k5bm82NUJrTGJhTC9OT21CVDVSUFhQTE85K0NTSy9xUU1B?=
 =?utf-8?B?eWpDSlhRL1F0N2lGdUMvZFBnNkNEaTNIQUxxUUdEek9WK2pFWUxDWXEvZm1X?=
 =?utf-8?B?ZHZRV2xPWjFxbzhBaHJKUVo3d0U4WjVzN21Ga2hieFZlV1plRHc3UUtlUDJE?=
 =?utf-8?B?anpCdGJiaGVkM1lVeDNzU0txTjhzZ2dweS9WK29HQVdXOTF2ajdMZTZ5WkRj?=
 =?utf-8?B?b3F2Y0xvcXpTdVBENytzcDkrYUZ6YUNJMnRlbm84NExNSVhkVXhDdVJuOFd6?=
 =?utf-8?B?c05ua3k1cCsxMEJsRGhveWFrOW1DNjg5NDlyNzZmR3VTdlhkMmNnVEpPczFG?=
 =?utf-8?B?Y2R2Y043QVVBelhIMGdRTWZnWXk3NmhxdVFEK09sYzFFTEtlV0VJZEdkbmNB?=
 =?utf-8?Q?bGSpQjGAvmgl324y+icdw3jkE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jMcLH/M+edDNFiqMJ8fBfa0Zr1X68V/fQdQRp+d3QU/oIcuBeG1IM6iDExOk1sLhJovNIhkCEJ/YouPSSHyF4DMXm+qddJ7On3ck4UkFlCKXm3PS6Tiv05AuezAx+HLc3ImVRvfJnVJegsejIpujyp63wczNEAa9/PTYoKzEC7aKxaVuJVQmJVnjR8taUNClxbo2GfvAfGwwCOnxDrY0hTkF+Xwg1PdMgv+y6oaRK498KL6k/skX2zZlAWgHb86H0Wh8Nw61MIiS6b+XuD0GGSIRhL1agsh3WsMD+ccV/CBwxfNrZQRVqf8NTl1fEM/eEg+vqWBYXv1st5ocCViSnDHkBQOak38q7n6MEoqknvU2uD4MhxcR5fOnaugbZsHz0krjihmmgfXEx04BUGVRkZy3S5JIGgqG3jhZVPC8TQcJVW9JzNPFV8tCPTWZq+SV0JFEfUHISdRmSAdtwcsF5+Z/dFld440nVYm3Gyoho3WyTssx4NGVQXsrL7DxlpwiOK6OnO4KXqtw+IESJNEYl0daiiZuUu+cpXfxTO/HkH6JOZw7K0MeN5QLp2Sz4i5js5RcvZHTNdRHrOJpc3Z+SEhZ1FD0jpxqxyoomNvxbLAWardQwlsAscsACzlvEslqi4999nXX3DQ7fQakTV+JC7Sv8u0U9ZzIG7vSKCPmzHpIX3QKGgKT/68xUyrzy8X/UXvC3sVKs1VNjVFo9uFezWbmvzAy6y6AJLkyINj7UM66XWqxENL68x7DXu6MUy7nWaCAGknsZ1gLca+s1p9u7x223dO3h5/yH5UYnUuj/GwFyBzmdpKV5hRWrvCK5hhDvaDUw6Y6OcOH9OmIJ3fQr4jSqqb6zruxJOAkdyfr36QbnZsRAwVxC+VktmtCQWqIFZUe65tI4UX0Ni7HFo6c3L8PJ6Xy5jlk9uNxWaQwbQ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b2ae20-7b6a-4604-6181-08dbf0da57f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 12:54:37.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b91NT0O5lr5TjX1mazRVM8b13zZNekidhwUPCyGazB/069KFJI4nHO/LMdp7NloJgn3SR6u6dN+c5mbSouHdbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290097
X-Proofpoint-GUID: ffZzoPO3XdhWwlAr0GS40EhFBUz7K72K
X-Proofpoint-ORIG-GUID: ffZzoPO3XdhWwlAr0GS40EhFBUz7K72K
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 03:45, yangxingui wrote:
> 
> On 2023/11/28 3:28, John Garry wrote:
>> On 24/11/2023 02:27, yangxingui wrote:
>>>> We already do this in sas_ex_join_wide_port(), right?
>>> No, If the addr of ex_phy matches dev->parent, 
>>> sas_ex_join_wide_port() will not be called, but sas_add_parent_port() 
>>> will be called  as follows:
>>> static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
>>> {
>>>          struct expander_device *ex = &dev->ex_dev;
>>>          struct ex_phy *ex_phy = &ex->ex_phy[phy_id];
>>>          struct domain_device *child = NULL;
>>>          int res = 0;
>>>
>>>      <...>
>>>          /* Parent and domain coherency */
>>>          if (!dev->parent && sas_phy_match_port_addr(dev->port, 
>>> ex_phy)) {
>>>                  sas_add_parent_port(dev, phy_id);
>>>                  return 0;
>>>          }
>>>          if (dev->parent && sas_phy_match_dev_addr(dev->parent, 
>>> ex_phy)) {
>>>                  sas_add_parent_port(dev, phy_id);
>>>                  if (ex_phy->routing_attr == TABLE_ROUTING)
>>>                          sas_configure_phy(dev, phy_id, 
>>> dev->port->sas_addr, 1);
>>>                  return 0;
>>>          }
>>>      <...>
>>> }
>>>
>>>>
>>>> I am not saying that what we do now does not have a problem - I am 
>>>> just trying to understand what currently happens
>>>
>>> ok, because ex_phy->port is not set when calling 
>>> sas_add_parent_port(), when deleting phy from the parent wide port, 
>>> it is not removed from the phy_list of the parent wide port as follows:
>>> static void sas_unregister_devs_sas_addr(struct domain_device *parent,
>>>                                           int phy_id, bool last)
>>> {
>>>      <...>
>>>      // Since ex_phy->port is not set, this branch will not be enter
>>
>> But then how does this ever work? It is because we follow path 
>> sas_rediscover_dev() -> sas_discover_new() -> 
>> sas_ex_discover_devices() -> sas_ex_discover_dev() -> 
>> sas_add_parent_port(), and not sas_rediscover_dev() -> 
>> sas_discover_new() -> sas_ex_join_wide_port()? If so, is that because 
>> ephy->sas_attached_phy == 0 in sas_discover_new() -> 
>> sas_ex_join_wide_port() and it fails?
>>
>> BTW, about something mentioned earlier - adding the phy19 with SAS_ADDR 
> 
> Yes,
> For phy19, when the phy is attached and added to the parent wide port, 
> the path is:
> sas_rediscover()
>      ->sas_discover_new()
>          ->sas_ex_discover_devices()
>              ->sas_ex_discover_dev()
>                  -> sas_add_parent_port().

ok, so then the change to set ex_phy->port = ex->parent_port looks ok. 
Maybe we can put this in a helper with the sas_port_add_phy() call, as 
it is duplicated in sas_ex_join_wide_port()

Do we also need to set ex_phy->phy_state (like sas_ex_join_wide_port())?

> And the path called when it is removed from parent wide port is:
> sas_rediscover()
>      ->sas_unregister_devs_sas_addr() // The sas address of phy19 
> becomes 0. Since ex_phy->port is NULL, phy19 is not removed from the 
> parent wide port's phy_list.
> 
> For phy0, it is connected to a new sata device.
> sas_rediscover()
>      ->sas_discover_new()->sas_ex_phy_discover()
>                              ->sas_ex_phy_discover_helper()
>                                  ->sas_set_ex_phy() // The device type 
> is stp. Since the linkrate is 5 and less than 1.5G, sas_address is set 
> to 0.

Then when we get the proper linkrate later, will we then rediscover and 
set the proper SAS address? I am just wondering if this change is really 
required?

BTW, Even with the change to set ex_phy->port = ex->parent_port, are we 
still joining the host-attached expander phy (19) to a port with SAS 
address == 0?

>                          ->sas_ex_discover_devices()
>                              ->sas_ex_discover_dev()
>                                  ->sas_ex_discover_end_dev()
>                                      ->sas_port_alloc() // Create 
> port-7:7:0
>                                      ->sas_ex_get_linkrate()
>                                          ->sas_port_add_phy() // Try 
> adding phy19 to port->7:7:0, triggering BUG()

Thanks,
John
