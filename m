Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCD57D4FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjJXMfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjJXMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:35:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1028EDA;
        Tue, 24 Oct 2023 05:35:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OCJO7t016074;
        Tue, 24 Oct 2023 12:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5CpkHwmOWVfZLNJ6+2hITa6MFEvATDe3oNU9cc80zOE=;
 b=YTKYQmsB9UIyIoW7dcIRi5DWBOyOPIDAGJzpz8z7nKZLhxaJoVEAWJCGIx1eFLPkskRc
 pvFYEg9GwUbyFCeJoktua9FjVBr4iiLlVLdKTJyCUabmlOP9B1ENpZNOmxHpyC+2iGnl
 MfH0JpXMapO7f/3UzuTKZYDlWFz8CIygxIlOGX/HfpcyXuJWlVpH01KPD0L2hFhrWCE8
 MeFMG+RU9uIKHkGb9BI9zbkfpXhjUw2Kcs3EuR35eH2O2Q1aq+QL8dTvaExZdx08jqGX
 je+q5iuKHp84LusC+okAUR1PaNYla6skR5RWvTutI99PLf5niUCrM5QH+CBoBLNTIMb7 Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e35bpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 12:35:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OAV4uQ001754;
        Tue, 24 Oct 2023 12:35:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53bpbyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 12:35:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkL+e45NSdqkbIXYngz54ac9+O1cZfjsyEpdHgvgmtvjjn3dMfHgCKn4bKBBqX4CGCc9wUjSDWN0ja/fLm31tfcPNAfU1mFBzFEKYoneVuSilIvpjbjDIjWPrKfY8pOIK01657SE7Dm2q5+Cf302yBGFa59DNWsjR72OLjgykvTUrOBDG8jakh6eBxN0P/MVnN5/0H48N/xxqpri92yLLk/3ntReUhhzJFXs2CtwlJvu5tPxoI5N85UxwRng+pQ1ABvvuCq0B63d5/FjBm37g1/im1bXWar3rTBLndkGcqUp2PUtwOJW2XxzdxcabOmjQDN2cckUyQxROVYdpjAiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CpkHwmOWVfZLNJ6+2hITa6MFEvATDe3oNU9cc80zOE=;
 b=aSfNT3cUBHa4VPMrsXoIKcCk9X8+6+KKsFu669BUGCijJlcja5GQR1iDmguLYRSFXS0K/w8ktB/UOdN6JknzjWe8IXxTERPeGHGVIZCfEtgus3eF8sGzk+ERsxQHCLEH942LAPotnGnijX9hC1Lg61SEiCEndKHcIIVB1QxqLwvbEBP0UJ+Kd0rEJXkQE2/h57qdA6oerEFM4pcef5XOihVOcxQxjpy2GEZdZg7IjLXWVr9Ek76yXiZ/wKiks8D+gtdIGdxUWjtAgYLV93CeA/FN/m8YdQqKcQKOUz96sBnL3qRgVz/+4ho1X0yuqzS9rBMod7JHThNQEnscm9Nmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CpkHwmOWVfZLNJ6+2hITa6MFEvATDe3oNU9cc80zOE=;
 b=gnLwnDMiP6Y1SsYqGTOZF9IOoGCXqKlcAioWpUbSDBj2DhNgthydnwg22S6sNwMhqEJG/d3OpNY2GeWXy4NllxetprKK1dvuDhxDAuSdcG617TUERagM3Icua5gR7y9/b7BhAw5EtiPxaZIQaK4JC3zL7TOWHwTm7YXmTmnNdx4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7344.namprd10.prod.outlook.com (2603:10b6:8:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:35:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::2c06:9358:c246:b366]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::2c06:9358:c246:b366%2]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 12:35:36 +0000
Message-ID: <7da93082-2985-85f4-7688-a082728de0a5@oracle.com>
Date:   Tue, 24 Oct 2023 13:35:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] readv.2: Document RWF_ATOMIC flag
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        martin.petersen@oracle.com, himanshu.madhani@oracle.com
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-3-john.g.garry@oracle.com>
 <20231009174438.GE21283@frogsfrogsfrogs>
 <ZSRk9Z6/i2E+YV9A@dread.disaster.area>
 <20231009210531.GB214073@frogsfrogsfrogs>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231009210531.GB214073@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c85220f-1551-4a3e-8e56-08dbd48db94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zX7dRTz5xp0EnCcCazO/EaWdzGB4TGFf8wXDGnb+45y36uyd+mGrb5bhWISffHg1h8LU5b8svLbR+VUQc3gNHAWfblJEjGdR9pz5G0kAM5WbXVRG6tmC9fkvvzD2SY6kzCajxd0kZXSCdXs+N9PK3FAN7mKhe4qt2TOzbBY/CIn5Y6UbIrkw5tMqdGs9D7iYa4Pi+C0OmzVzcvYTPH4Px1EQFfMIlEgkJjzHhjepjMNvvEqASLeiCnEAmrke4hZdTRvqHtS2EX9BR85vcfquYxeAhRi70TAzoq4V/t0ThsEr9jE+NObfuzhw42Vo/TJqMTH9UhUsgbO3sotcOi09/4gby4hShQJUHeDu0Kxi3SLKnHSG1o0FLGMhqbCR5PDaUD/48xxO3x1FwtoEzjYlLVu5gv5Lh1EFwiQbv2ziHlVoTFFxLc9x/WQMexhLYGHsF0DUBVqFK8AN4We+/DvTa3WthuPr6KWZUuYCpzmfDE6J9PNxe1gnZSj0FOBJBHcCYraR8+LAFDX4JZhIGQ53ZA03zpT2eOX50+1Ry+a9PznmOxMFGULBMDXTfr3Irp1xlJaimsRg+j8ER7OgMPlsbN43t9LfeQ83PiWTqPNGh2oBltx8HRc4YZ+dg0CUHwU4Le/dUO+hPaVOB7TB7MDHiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2616005)(38100700002)(26005)(107886003)(53546011)(36916002)(8936002)(6666004)(316002)(66946007)(8676002)(6486002)(4326008)(66476007)(66556008)(36756003)(31686004)(31696002)(41300700001)(86362001)(110136005)(83380400001)(478600001)(6506007)(6512007)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2dwQ1FURERvWDVva1F0R2VaVzZScklSZ3RiV0tvOW53RHh3VWwyTDN1UE1s?=
 =?utf-8?B?czBYc1ZVVEhucmpka1NDM1dqQ1RoK0ltd1hLUDVmTFJPMU42dzcwNk5iM0lB?=
 =?utf-8?B?K2NyYzdrM0pwNEJSc05NRkpOdEZ5N25Jdi9jbU5tckhhdUdaTEoycGdyRzFs?=
 =?utf-8?B?V0JlRHVremJCdkliU2xyMU9qbmV6QkNPdVVKa0s1UnVpWGZOeEpQM1ZNWDdj?=
 =?utf-8?B?SHFJUmdOV0hGS2FnN3BSN2Q3TWJ0T3pWVUUxVVBsTmRPVEdsbTVEblhFWWZt?=
 =?utf-8?B?bnRESzMyczNqYThqeGN0TmdBRWpmclo2MmZyQlVGQnhHZjJTYWRsV05sY1A0?=
 =?utf-8?B?bVVUTzd5MTY0eE5hdTBZKzdoUEN2aE1JRVB2OUJSWXFHNXk0b0RGbVkxaitR?=
 =?utf-8?B?bUszOE16Uy9DY2VPQXV5R3hKcWNaSW1yZDVNRVM0VlhnWkhKaDlIQUQ3YW1m?=
 =?utf-8?B?TEZzNldyZUFtUmRGQVFycDJJSlEzdS9MK3lDbFdpUUU2SWZzb0k4Wmwzdndy?=
 =?utf-8?B?OEd3MWw3T0RRVEdHZG4yNGorUzRBUlJUckY0TVZoY2hUeVQ3S3hNNWt4YzJ4?=
 =?utf-8?B?Q0JVM2orYjRXVmkyZjR3ZFR0cEtVVUY1aWZlNk1tQlZzbXR1aHRlT2tUelhv?=
 =?utf-8?B?ZVZjd1NBQ0tRS3hLa3AxTDBXUGdxQy9rZjF1TC9LT1duTlgycXRLNkRxV1F1?=
 =?utf-8?B?OGEwTyswZkdBbjZucCs1L0VtVVlBMGRPZ1JwSDNWTWZLSUdtUDd2OWZGRksz?=
 =?utf-8?B?U3k1ZTBqY292UU51aU1Vbkxtc1E5eTZsUTNOdGxTRitTK09FbWNPOVZndmNB?=
 =?utf-8?B?VytoUXFxcFVlTlJnb3ltMjR5RlEzWXlkVDZKOTlmVjR6dXFONjk3ZzJvRkhZ?=
 =?utf-8?B?OHZ4ZmVXNldmaHEzMVR5ajRGdVMzWlRURys2azFrb1JmbUNxQmkycjJxaEhu?=
 =?utf-8?B?TzFvYUpRWmwzWTBJcnZEUDdzWmhxM2poTUF1SXlqTUZ4QlpUdkJJbDZiTmcx?=
 =?utf-8?B?dGhsbkRhRE9uTS9JSTFjUVpCRlByajQwdENoL001UURUTXhJSEZwNXZnbXN6?=
 =?utf-8?B?MnpkV1ZQODF0RHJ6clVLbC9wVDNodHQ4US9NaWQ4RmU4VitOTjdIbUVhRzRq?=
 =?utf-8?B?UlhLdHQ4NHRIOFhVanhwemNjWlZTTVpHRy96aFlUZFBJTDFyWmQzQUREVzZF?=
 =?utf-8?B?RUhjeW4yWWJtcU9SVGp0NkVSVTJiVC9BeElSc0g1L2hIL1BUK3psRHNxOFlo?=
 =?utf-8?B?U2U1NTFSMmloYVkyM2d5RU5RTzMyOTZDL0JoRjkzdUkyUTh1SENGVE9jdzJv?=
 =?utf-8?B?MFdXbUpPU25ZZmhweDZiWlUyNVdGQWZQZ3JxWGczVjgzN3J3cFNmeDVLVld6?=
 =?utf-8?B?aEZtY2RRczFqczZsS0t1YkZjYVVBR2IyWDEydWk2T09LNTZVZldXNncrZVpp?=
 =?utf-8?B?ZzlwT0V2TnFSdWszR0ljYkQ2TmNwSDc5UE1GMFFwMGczZTBtMlc1TmZIU0NX?=
 =?utf-8?B?aGlONTFoenBNNVVxVzl5eHFDc0p0N3dVb3JsZ3Z1SDdxQUFWRkNpeHAwSjRl?=
 =?utf-8?B?NVpFR2dRdnlmNU13WUthOVRsVjRRSzJmRHhzMkNZb3RyYkNPbHpHZWZuV1hL?=
 =?utf-8?B?WnpLNThIaVNHd2xKRUJyaHAzUUxiNXpWejRMZUtMRWJxVllySjMvWnJJdXNP?=
 =?utf-8?B?TnlYc21teE5TS3M2STU3dWhYUDROMnd5VS8rWUhDczhqdGk0cFY2NkM4UXRB?=
 =?utf-8?B?VVpHVWFkUXFZM3l1OHNKNW1Ec0txWTdzRy85SEgxcVhBTkR5c3g4RWZ0Vmtm?=
 =?utf-8?B?N281QTArZm1hL0RrcHhCeWtaWnhBVVl2OTZ3TDB2bEE4dG1NZkR1YkVpTHFa?=
 =?utf-8?B?cWl4ZTFtbmE5VlArMVVSSkZpbFczMnJVT0VXK1FoZFJZQytNVzVFMzR6MjdT?=
 =?utf-8?B?dkVhT1F4bWRSdktKRVF4djQvQkd3cmJXay9ZMHdaeEJEN1c3RkJ2d3V5bExi?=
 =?utf-8?B?ekVBaEtsckZwKzArT2dYK1RqU1dGc0ZxcHFLMlI5bTZ0MytFMGFQWlE5ZWJE?=
 =?utf-8?B?WXltZzB0bnRDUVB3bHhlY1NmUWJzbVdxU2toR0NCaWwrSE05anRNL0M5UlRL?=
 =?utf-8?B?UmZKVXA2TlVNS2VMaFdyWEFQNStzQm5YQkJQUktMWk8yM0l2VnRDUkdVYWtF?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zs8zzmjasB5NOAw5MYnE89kyUDH+rwQNK6E0IVsVxM3r1t0TpORyFNvd0hJqYFLPwNnWbBR0cKBC9Zqv1KJ09wC52Wd9fS17myg3rrS5puj+/RRbA+Izc/Oh6JMa89uZg2Wo4Pxky3tdslhrFZD8+MTDymzSSCN53xSXDnJ+Qb7KOKmwe63poi8ShHF5OqlzTYxtZ3YMjLWfwUJF1aQctsgqjgabOx9X6eiYiM9jwk5OYE1Sc4GRcObb8jPypLecbcqO/aviFxVBHRLfctt774ygR4VFbfcQXYHa8GQZhHbuPa5md2w0YgH9GhLtaphe6M41JQkxXC9JF4D+wOFmqAKkVWY3C+pl32nf3B4/SrtQcmAQQu7zGXUm8FNBGTzHSK+xWOsALyFBrA1Z3f2f0AchxHgar8cU5NHpFJyx++9Gr3JMi1wIL5Jhgh1LWJpbNVLntuGXs2jz4kx+N+BbyQCwyWhm6tohs3IZhNovcZtZO4R/5kuu19V/z/Kg1Ai+PAqVIyJs0BrIcf4ciIXtSadVe/iMSBpQPnXRkYoWOZNwlUvFio4DJ7zohTYNCXcTa1ftwwxeKoATYVXcbzOENUOMoclX8947qhMzEBw/DJo3hbeUuUxrcYe3+5a+zGPcQYnOCaJSVtNXzSor/xbWkPhQ1uZ+AUnj59qo9R110Dxyp6Yd8y0jm935POIRwH2oPfioMzHa37fi5f0/GaFgYXZeaALbCGXUf0KIB6Lr+MpeO8zwMuEdx/SZ8gWI4px9wKhllMyBQ2ucDK7mZ/7c6HByGLB6tsTPiwRZZDE3zUhXwKg6ycJVisdgRlvYo4JljZ5naE8d4n+1UvKqRA+HHg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c85220f-1551-4a3e-8e56-08dbd48db94d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:35:36.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRVsm8R0AFBORSkbqzqy+0Tm33tONfh2liiew/ExKXDCwvAgYRBdpOxq1LknTY6cjOvlx0hN6y9xvXs5UumWBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_11,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=910
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240107
X-Proofpoint-GUID: qvlG-nkLtWeVL4jcp9jMFLSGOnbuazhw
X-Proofpoint-ORIG-GUID: qvlG-nkLtWeVL4jcp9jMFLSGOnbuazhw
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 22:05, Darrick J. Wong wrote:
>>> If the file range is a sparse hole, the directio setup will allocate
>>> space and create an unwritten mapping before issuing the write bio.  The
>>> rest of the process works the same as preallocations and has the same
>>> behaviors.
>>>
>>> If the file range is allocated and was previously written, the write is
>>> issued and that's all that's needed from the fs.  After a crash, reads
>>> of the storage device produce the old contents or the new contents.
>> This is exactly what I explained when reviewing the code that
>> rejected RWF_ATOMIC without O_DSYNC on metadata dirty inodes.
> I'm glad we agree. 😄
> 
> John, when you're back from vacation, can we get rid of this language
> and all those checks under _is_dsync() in the iomap patch?
> 
> (That code is 100% the result of me handwaving and bellyaching 6 months
> ago when the team was trying to get all the atomic writes bits working
> prior to LSF and I was too burned out to think the xfs part through.
> As a result, I decided that we'd only support strict overwrites for the
> first iteration.)

So this following additive code in iomap_dio_bio_iter() should be dropped:

----8<-----

--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -275,10 +275,11 @@ static inline blk_opf_t 
iomap_dio_bio_opflags(struct iomap_dio *dio,
  static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
  		struct iomap_dio *dio)
  {

...

@@ -292,6 +293,13 @@ static loff_t iomap_dio_bio_iter(const struct 
iomap_iter *iter,
  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
  		return -EINVAL;

+	if (atomic_write && !iocb_is_dsync(dio->iocb)) {
+		if (iomap->flags & IOMAP_F_DIRTY)
+			return -EIO;
+		if (iomap->type != IOMAP_MAPPED)
+			return -EIO;
+	}
+

---->8-----

ok?

> 
>>> Summarizing:
>>>
>>> An (ATOMIC|SYNC) request provides the strongest guarantees (data
>>> will not be torn, and all file metadata updates are persisted before
>>> the write is returned to userspace.  Programs see either the old data or
>>> the new data, even if there's a crash.
>>>
>>> (ATOMIC|DSYNC) is less strong -- data will not be torn, and any file
>>> updates for just that region are persisted before the write is returned.
>>>
>>> (ATOMIC) is the least strong -- data will not be torn.  Neither the
>>> filesystem nor the device make guarantees that anything ended up on
>>> stable storage, but if it does, programs see either the old data or the
>>> new data.
>> Yup, that makes sense to me.
> Perhaps this ^^ is what we should be documenting here.
> 
>>> Maybe we should rename the whole UAPI s/atomic/untorn/...
>> Perhaps, though "torn writes" is nomenclature that nobody outside
>> storage and filesystem developers really knows about. All I ever
>> hear from userspace developers is "we want atomic/all-or-nothing
>> data writes"...
> Fair 'enuf.


Thanks,
John
