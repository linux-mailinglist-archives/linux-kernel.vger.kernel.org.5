Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858047BF20C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjJJE7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 00:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJJE7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:59:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F44A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 21:59:14 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399NxXCw016701;
        Tue, 10 Oct 2023 04:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Qx3AeBtaqNhaRH8Rm8kN7AM2zWXKIJiMu3xhTDZoX0A=;
 b=iDo8I43sQPhaPcp+OzMV/w2+f3tPCFFR3RTmu7J8E796KyY/Ak2jP4Adlc/pNY6q2jkG
 jcj73Mf0xYYDsX6E/+XzEB6PXx/Aitc39LI9jE5SVt+z3PVA3a1cu7f8MQWyME0BLANj
 ijZ9unwy3AadiNKreQz7upvFY/3CVPQs21jKTtmXubznGCQzOjwl6o2NPWDqbuMsY9GZ
 v0uWmfJlq3JLZ3L7pdlXLpjmeQo+uSBddGPhYPLg3BH0SsjC3sTjhb03jAtbpUAfCMBx
 EyfQw5fkQdUlPj1hzh+LDoj7Zm2K2P8lQIZer49tntupBV6YN3EUk2kVgX43KySR2c+q MA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cc6yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 04:58:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39A4h62P004744;
        Tue, 10 Oct 2023 04:58:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws5yttt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 04:58:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBqKWyGt9ZjJ9TiJkbH+wq+nIfjrfTg7qibVT0pJKLdTN909myjxKjm9YYADnVleIYkm43uPwiyH59oUl0MKFSbkaNeDwL3E+eWvPMwnmogJlFZnMhpl8w43E0uK7piCAv+gwE14ueW4FYVahRwwuNovNs9AmKjOuEvel0Fbv4WFrGghjnNzR6MPELBWQKp9ejVv38u4jOAxKuYL+3qSzJ5X6uqEWM1CjXcg2Pjbhr2FT78/Kn8V5bZ2xJmR0x9+stITl1iP6qmudJvPcIeeYXuJdcg3tcjyJgafhVrdD1FmtuXvUqoQ/rT34H24oXCFMFBHedVbuymSynE3/IgrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx3AeBtaqNhaRH8Rm8kN7AM2zWXKIJiMu3xhTDZoX0A=;
 b=AbSyNWmlbtySpiWv2Um+qQ7QBKoIwDxzG34R8EBJxX7Lua3vyxllBUevC+L5WUpQyQ/b1gNx/nYmRYxfD21zM9FJL/XFQyJAJSTuQ3yEzaO80qON0/EtUvl8z8D3jpYs9lCkOZCreqwn5PhiUif4rXT7LrK29vl/yExvJyI0xs34XCcWEhMf1B5dMGE49xdrRUzO7C900aKh+gsvGkVPcjtdz4ZAVrc6d1Y/MaDUc+JpjB228q9IY0BfUFPSrH5GKjlkYJ8MN/EFSPPP3sU69vAUdGfiVs5SDYQIn8zOQr4W2A6b32c9OheWAZ4ZuAw0fjYLhCHnz1tvZdYemSapOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx3AeBtaqNhaRH8Rm8kN7AM2zWXKIJiMu3xhTDZoX0A=;
 b=x6ggf2myWw4NjpSX02uCwpBprS/JW+7L0lzwntbJTVlYAvhuqRi2005d+EMU8BsZPDEaavDS7Z/gyvnQASXHnRX3STg/ItAt7W612GnQjtEyCXsBZ1x1l2G98Ra8bNei7LujRE4Kr/p5oSMeW37rYfQ9bfVm/sR48OojNk+rANM=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CYYPR10MB7608.namprd10.prod.outlook.com (2603:10b6:930:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 04:58:52 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::36b5:886d:bb6d:50e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::36b5:886d:bb6d:50e0%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 04:58:51 +0000
Message-ID: <89062478-fa97-c265-3b18-de55eeae3c1f@oracle.com>
Date:   Tue, 10 Oct 2023 15:58:43 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH smp,csd] Throw an error if a CSD lock is stuck for too
 long
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Leonardo Bras <leobras@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop>
 <c87d7939-a88c-ad2d-82f2-866e04692882@oracle.com>
 <a77da319-3161-4e42-894e-521d29fa8348@paulmck-laptop>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <a77da319-3161-4e42-894e-521d29fa8348@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY0PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::6) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|CYYPR10MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 247d80e5-e3a6-4ca2-4dc5-08dbc94d98c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bzia3i+FUJnEHy5V67cl9C7d+Hh4SslxbL8GIJrW1f0PW24xhu+Ng+GxTFOfZjO3WcksRpHQq7wLUpqEJ7jn8XStIPy2sqD7J25eVS1hrRVXMmAN9K3nxEx0DCUkbrdd2BTJe5C1eKePSQy41ecrKyr2iX4P0K5NvP3wc03asL5mJf+s8TnDFKRlTZ2M6GClZH9rKq8v4+fK6KDaAbF7z6f3IKx2Awhl6yQE0NQZSV2/CjZAVGSkag/vRm/CShVJDyLy85ASlxnn39wsUn8ieKZdd9RpCC1AftlVDAb6cL3fGL8UHvglovVI7LoSqaxwqNg3dFi02LTqCbUOhqC4vTpZv4DM7CaLxt0eBulzXMP3bVLqmlIa5LT4vKnvh9voK5hnTBb8cmoEcJXanReIKf2IX9QAhkAU5C3GNuVTqeE33qb1IAmtFiJkUnijkLsM4THY0i8SRKKB16rCBLKGeYlaW+9krMF1ASqULZi4zfVNwYUu8MWYjmFkTHqtkpYX2ZL2F1sfMJ8XDuBKPI0QGd6xKrzE50wAKxueSEPR9xEIigTr2M5v4oZK72pUwh31P+KPf/OxzQLUfV/7noPDc9ftr0WVPrCZ8p31bHs99e12LYGJvl2XGvxt8bvdqi4rtfMfllD8Pi9HSnhb1v2Bxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(53546011)(2616005)(6666004)(83380400001)(6512007)(5660300002)(41300700001)(8936002)(8676002)(2906002)(6506007)(478600001)(4326008)(54906003)(66946007)(6916009)(66476007)(6486002)(66556008)(316002)(966005)(31696002)(38100700002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0I2YjV6aEhsS1YzWWtRRXFXcUpmUGxyd0ExOXc1RlZSakhwNng0NkQ0ZkRa?=
 =?utf-8?B?d3lmcE5Sb0pML3NxWHk1Q25STXhlUVhQWE51SldhdDVWbUhnWlhJT1hvYmtz?=
 =?utf-8?B?ejBDbGwzSkR6ejQ3N0lVYnZod2hRcmYrRVRHN3dwZ0hyb00xVEVOL3JlYm5m?=
 =?utf-8?B?ZkJWWDBzbTlOdG51a21XYTllZmxXckx1SzlRYTNyVURrUnVBcldPTEJzSXJG?=
 =?utf-8?B?SGVGOFFQTk9nem9DLzN6Y210ZFFRazJyY0tBSjZlQlM1MDhKYSs1WTlNWFRO?=
 =?utf-8?B?Q21EK3E5bnFuU2FWR0VmQlZ0YjdlUzQ5Z0M2K1lXMVRzeEJPNWYyYzZNckd3?=
 =?utf-8?B?RUNzS0RnTFgrVGpRTlZpVEEvdkRKK0wyN1lmYWFyRmw2dUJCNHFLMnBqWWpq?=
 =?utf-8?B?Qm90K245TGloQ2RCL0ZOL3F6ZEhPRHd5Z2FLTkdRYVdWSUUxTjErM1VocHdi?=
 =?utf-8?B?WVBZNFVhdHk5Yi80Rno3RFd5QkhoTnZaaU52dFcyVmVSWFhmTitBYkRXWVNm?=
 =?utf-8?B?ZTNUMUhpK2M3STdSc1FLTStUZVdhV1pxOTVsSUJLYnhxYS9INVRxb1pidEFL?=
 =?utf-8?B?OWwxb3pmcHppcHROMS9ReUtJb2tFbUdJLy9VR1Rtclg2b0pCVFovOHdmbVAr?=
 =?utf-8?B?VFllMHU2QVNGdUduMEs3d0VmTWkvRzZtdUF6bWdzQ2ZGNTZnemZCL1FGMG9C?=
 =?utf-8?B?bDUrMzM3dDdHd2VOUy8rWVpXem5vTXF0cllTZTAwWDY5aGwrUktFNlBKNHpz?=
 =?utf-8?B?YkM5TUFLbjFBbkxoUVc1MHlzOFhQcm1vbGVLQ2JsejVwb3FpaUFiN2QxRnRw?=
 =?utf-8?B?RXJlVHdaVU1qS3lDQVhLcHl1U3RIOTRxMHBhNDJmYmw3WGM5b01TWW85cHph?=
 =?utf-8?B?Y1FvLzJCWlczdDhWdXVyQUFwU0ZNQnFKOTNlL29wSjIzeDF5OWxWdytvS0Iy?=
 =?utf-8?B?Rmx6Q1dHeHdKUlZvL2QyQTNFQjBRQ0duNnIzZU9icUVubTRWQTQ0bmNhTjU4?=
 =?utf-8?B?R1hhNDVoK2toKzFJQmRoVXk4ZytpSW4yaDN6YVR6QVVTWnVsZlVod1JjNkkv?=
 =?utf-8?B?UXFSMGR6N2dGT1JMVGF3cHdiS1VBSUNGQ3JybldhVjMrbU5NQjNMMmpWUkNj?=
 =?utf-8?B?WDJmM0hlK3pHNmNiWUlhaVJHQTNwL2NZbVIrYlZRNlF6Vi9ISW5NbytDWkNX?=
 =?utf-8?B?ZmIwNVQxUTNnSTVaeUhSeWJNK1hka2NUTm5qNWxPZVh3RGJmREtwazRUS0dH?=
 =?utf-8?B?L1Z3U1IrUHRzZzhLQ3ROMVh6bHpBQlRCTTNTR25YS0ZzbDJjWTNxUXFIaFZZ?=
 =?utf-8?B?UjRkWmN4VU9rdVZickYwbHNnTm5UazdIbWFyTVlIcmgycStOaWhPczJCTWRW?=
 =?utf-8?B?MmFVOGhXSE10NzZCL1BWbDJ4SUhxeFkrMGNqN3ZwRlhjckozWlkwV0hndTE0?=
 =?utf-8?B?NEtkVzVzSzVOLzM0TkRaZHBWcmVsS2loUnNzNWRsM0x1ZlJMUlB2a3IxaFgz?=
 =?utf-8?B?Y0lBbk5McHhERUxSbXFnc25ZbUVnN3ZTZW91d2cxcDE3VWRzNXl3U3BwRzNk?=
 =?utf-8?B?RTVYeDNuUWpTbjJ0dTFNano0eTlkZXVwendRNVRxdnNoUmNyeDhLVWlvVnJM?=
 =?utf-8?B?MXRqa2ovbDlPYWhHUW9rQ0pnVlhUeVo4NU5oRlloeVEvMVo1Q3grbnZUazlv?=
 =?utf-8?B?V0dpOUV1VytwMER6cHh1WnVlbmpMTUJQeGNYMGR2QzFEME4rTGxJdDI2aXdY?=
 =?utf-8?B?bktOTE1iVEljM0orYTgxWmd6aDBaK092dWJmbzdBaEp1aEtvMmNDeFlzU2ht?=
 =?utf-8?B?NE1PZHZDcTVaVUVqMXdLQXd4NnBIRFRiVllxUXV2WjQ4a05sZ3Y4aThmaVZy?=
 =?utf-8?B?RlFNWFhEQ0VvcmdtbGZwdjlBbHBDTEVwV2J2c1F5WVRQQXJSeEdrT3QxWndM?=
 =?utf-8?B?V256citIb3pYOGdyZndhcU5OK3ZjaTFXa1ByN3pRVURFTC9wWis5dlNwRk9C?=
 =?utf-8?B?c2ZtVWhIWGxGaUlYcDBRdnQ2SUdidjg2Z2sxb0wvVHJLRU1EODJjbGNMSCtN?=
 =?utf-8?B?cHNRY3YxR0pndGFqaHBMaWh4dDBYVDJJVVB0N2FWMlV2YWJ0ekpSVGJiQzQ3?=
 =?utf-8?B?Sy8zV3I4aDZ4V2pIem5UV2lDaHVwODNwL1V1YjlTbHpZbW1HdzgrOTVXclhX?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CYX/L7t9FgPPlzfhk/SOKog2WlsmTgJ6WCo7yYCPUC5PGIAcQh7+cd2b7FvrvnrA3miW798O4e038Og+EdC3d/EfuXraO684LzkaaqRAaoFAbJQ4IRgKDGjb2NIPzGTm+oIyS/h1xT3e4SueocIm014G3FKB7MEjIk3YCuGUwkxKLPfLwY/0UJU1WstKvMWy0xaZsrmFc6uu6lH2U4q1XaWAKi2cCHQW0ijaawM31C80vTJBG/VjTD1jsJ+tWwtPsaYaCs4nHwQAjyYadEBfcbXSD3P2RejSBUFRHcSaxnvvPBPi1uBea9/nRDC/7atYHtnYoFbm8iJZEU1hWJD1Z1+ZaUZvJi7VPGEbd3D8ZUwtFq1lveetihxPUwKutIRwKfTZcPzMQaVDz8ANim6+WPdv6D1v/rzQBqJQzefq2DI82G4Gp3j6BmHEuMEwLkIWwv3PhoKdH3NXyr79u2LKoM5MlWKWPwDt4wxVs8eJePVyWQgjmjl7J+XbOxGdq4EI0WA6ir//kKPWVSdgD3HYhUdeftJIpdl6hnSZBH2Qk9amJ+1v33+wf+guaKyPWeuwP19Th5slQ/yebIR+3NoPKd5SftkkzcRsaTGw55fC9XwHcVkCY8ILxDR+Aj8Yc9fJD2ixflwLpRwQGqPMS6e7huHFU7SWYHJQKPbJNFVnaVy1jODaN8AAp6o9JfB+zypxJsG7ddpg3ecV41OXg78bLPusnYqYUB9TZ1zQPG1FVoa8lEFr5HSfYmHZoTtPogQ2tlbYVf9eiw19SAtTxtsz/d/Xce+FfpKEcy+a10BCCgeHkaotmmpryIR2GoMj/TTrhqdx5gEuqs1HvTifLeF3Pt9fVjdbl3sOGdBVVoYCiLJEcc9LjideUz3v10ntJ1Hk
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247d80e5-e3a6-4ca2-4dc5-08dbc94d98c6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 04:58:51.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7Q6E7bjk1H4ErrnH+wndgNJuxVArK4R/gYg4eRfgMTyMfg+i4FJpw9ld9I1HxMGOBOkwkiGfX0DPtW5yyE8xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_03,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100036
X-Proofpoint-ORIG-GUID: Zl86mALMwhFPvRqGnvTOWUIbzbgsbtFq
X-Proofpoint-GUID: Zl86mALMwhFPvRqGnvTOWUIbzbgsbtFq
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On 10/10/2023 3:39 am, Paul E. McKenney wrote:
> On Fri, Oct 06, 2023 at 10:32:07AM +1100, Imran Khan wrote:
>> Hello Paul,
>>
>> On 6/10/2023 3:48 am, Paul E. McKenney wrote:
>>> The CSD lock seems to get stuck in 2 "modes". When it gets stuck
>>> temporarily, it usually gets released in a few seconds, and sometimes
>>> up to one or two minutes.
>>>
>>> If the CSD lock stays stuck for more than several minutes, it never
>>> seems to get unstuck, and gradually more and more things in the system
>>> end up also getting stuck.
>>>
>>> In the latter case, we should just give up, so the system can dump out
>>> a little more information about what went wrong, and, with panic_on_oops
>>> and a kdump kernel loaded, dump a whole bunch more information about
>>> what might have gone wrong.
>>>
>>> Question: should this have its own panic_on_ipistall switch in
>>> /proc/sys/kernel, or maybe piggyback on panic_on_oops in a different
>>> way than via BUG_ON?
>>>
>> panic_on_ipistall (set to 1 by default) looks better option to me. For systems
>> where such delay is acceptable and system can eventually get back to sane state,
>> this option (set to 0 after boot) would prevent crashing the system for
>> apparently benign CSD hangs of long duration.
> 
> Good point!  How about like the following?
> 

Yes, this looks good.
Just realized that keeping panic_on_ipistall set by default(as suggested earlier
by me) would not follow convention of other similar switches like
hard/softlockup_panic etc. which are 0 by deafault.
So default value of 0 looks better choice for panic_on_ipistall as well.

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 6bcf3786291b86f13b3e13d51e998737a8009ec3
> Author: Rik van Riel <riel@surriel.com>
> Date:   Mon Aug 21 16:04:09 2023 -0400
> 
>     smp,csd: Throw an error if a CSD lock is stuck for too long
>     
>     The CSD lock seems to get stuck in 2 "modes". When it gets stuck
>     temporarily, it usually gets released in a few seconds, and sometimes
>     up to one or two minutes.
>     
>     If the CSD lock stays stuck for more than several minutes, it never
>     seems to get unstuck, and gradually more and more things in the system
>     end up also getting stuck.
>     
>     In the latter case, we should just give up, so the system can dump out
>     a little more information about what went wrong, and, with panic_on_oops
>     and a kdump kernel loaded, dump a whole bunch more information about what
>     might have gone wrong.  In addition, there is an smp.panic_on_ipistall
>     kernel boot parameter that by default retains the old behavior, but when
>     set enables the panic after the CSD lock has been stuck for more than
>     five minutes.
>     
>     [ paulmck: Apply Imran Khan feedback. ]
>     
>     Link: https://urldefense.com/v3/__https://lore.kernel.org/lkml/bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop/__;!!ACWV5N9M2RV99hQ!PDFpjgGTCPjxqCyusua5IZWkvdWEMf51igFDc-yb9cVK9PYr7FpEE1oGpWp09YK4lc15C2taMdcuEOqyH8k$ 
>     Signed-off-by: Rik van Riel <riel@surriel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Valentin Schneider <vschneid@redhat.com>
>     Cc: Juergen Gross <jgross@suse.com>
>     Cc: Jonathan Corbet <corbet@lwn.net>
>     Cc: Randy Dunlap <rdunlap@infradead.org>
>
Reviewed-by: Imran Khan <imran.f.khan@oracle.com>

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0a1731a0f0ef..592935267ce2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5858,6 +5858,11 @@
>  			This feature may be more efficiently disabled
>  			using the csdlock_debug- kernel parameter.
>  
> +	smp.panic_on_ipistall= [KNL]
> +			If a csd_lock_timeout extends for more than
> +			five minutes, panic the system.  By default, let
> +			CSD-lock acquisition take as long as they take.
> +
>  	smsc-ircc2.nopnp	[HW] Don't use PNP to discover SMC devices
>  	smsc-ircc2.ircc_cfg=	[HW] Device configuration I/O port
>  	smsc-ircc2.ircc_sir=	[HW] SIR base I/O port
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 8455a53465af..b6a0773a7015 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -170,6 +170,8 @@ static DEFINE_PER_CPU(void *, cur_csd_info);
>  
>  static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
>  module_param(csd_lock_timeout, ulong, 0444);
> +static bool panic_on_ipistall;
> +module_param(panic_on_ipistall, bool, 0444);
>  
>  static atomic_t csd_bug_count = ATOMIC_INIT(0);
>  
> @@ -230,6 +232,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  	}
>  
>  	ts2 = sched_clock();
> +	/* How long since we last checked for a stuck CSD lock.*/
>  	ts_delta = ts2 - *ts1;
>  	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
>  		return false;
> @@ -243,9 +246,17 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  	else
>  		cpux = cpu;
>  	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
> +	/* How long since this CSD lock was stuck. */
> +	ts_delta = ts2 - ts0;
>  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
> -		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
> +		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
>  		 cpu, csd->func, csd->info);
> +	/*
> +	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
> +	 * to become unstuck. Use a signed comparison to avoid triggering
> +	 * on underflows when the TSC is out of sync between sockets.
> +	 */
> +	BUG_ON(panic_on_ipistall && (s64)ts_delta > 300000000000LL);
>  	if (cpu_cur_csd && csd != cpu_cur_csd) {
>  		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
>  			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),
