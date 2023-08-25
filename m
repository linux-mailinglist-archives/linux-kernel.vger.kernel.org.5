Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420BB788F22
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjHYTGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjHYTF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:05:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6A92132
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:05:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIERgW031110;
        Fri, 25 Aug 2023 19:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=BTzPIkANJp0rh79GHiBKzRm23vMFSpwqWk+/XhZ4h5A=;
 b=kydeZ/2cgre0OpdYHRijEIzbb68yyu8XGFKGFNACIesfAyKllbQHNeOb1AWCCcjDQ1Mx
 Xf4I78ybUPVJIIrdlWsK6fH/vumxVXwBMDHgGb93i9h2TCZ8gjF+SFPL0Mwz1Rr2MyV3
 PSjoVk/OFzE0MBgesNRXcemYtos5RKfnz3OTk4Gmwk4vtRxfopfDQQu1uUKC4cyOoLn+
 eqp0HUFTd5Jlr+ChYRGoM6CMzgUoDHGfTMrsVQzYZJdAcy/DdYV0qGzaftKwFPzqMmWP
 aJXZc3VyrtzpA21QnLvqxztg91UpBqjRxEZD7ZYjAxE2QehcnpNJELwvf15DvqwOaTv7 Mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cq0ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIgohL036118;
        Fri, 25 Aug 2023 19:04:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yxqs0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwGV31fmJU4xUmZPoeNIUEd4m2Rd4uCai4ZpS+jH5pzYHTsVzFknOnnB/I4qu95ndHj1eG8nh9ylFEbycxS8Xp8v75sF7kUuN3FcxAZLuQuLJLUkmc+AZesni4KXff4RswvzPKwRRh+7dexWQpR35xw5GhjPhfnXzkaZwJWKmI096OvxchWSAN1+Eab5DkrcTBnqLcQ5WjqV7R0RlURAlDpbRojZNNwQxqHEwAeDZmnrYr8nl5aEvMhOn4O0pdAZchTHUTa6A9/zuMBgRda6gaAAXgD++EpBlB6+BNe4QZLDee6jqreCRJb9u711kcKG7TGfC6BDvv6IZveGcayQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTzPIkANJp0rh79GHiBKzRm23vMFSpwqWk+/XhZ4h5A=;
 b=Wqs9k0Q+/UDyWTwXiT/pIDA0/sX4SMr6FL+QCpSiBffIxJjerYIdap/yUs3FpLocEGZhVVPoa+0zIhlVY1/OXMsABmuSkd+QSx3bEaJnH5qluPiYOfNK07y/COjAi5a00TNp+XAtBsN9cKpPTTpHHpjon5fABJ8KkIVAAId//eBwU3N3iEuolgLfcmeoNSCHXccvYzreEXDABHO8xeAZUf0KSeNGnr+6nmjA1JAAu0VKF18yfZ+2r+AIsN6diG6uyHoXAdW69qugZMQ00rH1+LFiO9w00oLQSnBMj47LqR6qFylAqG+sC/io+83tIEgkt8JyL7lZArnCH0aHlAdHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTzPIkANJp0rh79GHiBKzRm23vMFSpwqWk+/XhZ4h5A=;
 b=LUiAa428XUOe4OnZe6m3Ay3Tf55DXlhTfIDhSFbrYZ8Bxm0XNgnsn8I52JYRxM4vAdiAB3j6aDZ5wjtMCK4TBaDb9CZ7QFZeqqvCE6KSJ16+0Yf1F0878NhGNfFR1CPm3m62rXPbMEBT41RjHtTT//quJLthnGpFe5/38NqwtmM=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:04:43 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:04:43 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 00/12] Batch hugetlb vmemmap modification operations
Date:   Fri, 25 Aug 2023 12:04:20 -0700
Message-ID: <20230825190436.55045-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:303:b7::34) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e203b4-c728-442e-0063-08dba59e2433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYu6yuSnkxZCy0k5IDVEj0UuBjF26l51q9i1npUHYWs2CWITcdmqcOT/KEcr6EBbXzlKqMPsBo9Epi86w6AOYlgEsP3ylh/hzmhOZ/OvVBncHXKsH7QM+bQd5JQtH4B+cGyv76OTtT8PTEn1NdH6VdvVvxHBqqgoEM8R9oigYHL0GIsF3fHpchG2FJQIMC7UhJOD2GfxLN9bokKtHbFv2fRLXbU92aicZBB7mzFrbG89zRa6bE3GG9MR2iMxg+FpP8aEglkRcnM34JasxkYiF0uUxaKoneabG2OTzRVDoom11/kVoAx/NudKweQiu0CwiucgJg0UbDZDR6PgFqbjPtM1L3Uq9DmrIqtXgZGvaPXn6sVD2X1SSi8QyqVGx0jPHzJPtOZmQHsG0OEswvaMu+NCyImRgFiw6RY4W2HM/sQQYCT5EuH6r5mgoeKOjI0b65VxniI674DT/Ex2ehekHvFZEoZg5e36hHk/8/rkskP7d0fX3GQGzM+OhRi7VYWHocyurw9FB498Er2vz3/ZwxR6lo9h399vQ9MxoGYuMEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(186009)(451199024)(1800799009)(54906003)(66476007)(66556008)(66946007)(316002)(478600001)(26005)(38100700002)(6666004)(41300700001)(6486002)(6506007)(86362001)(6512007)(2906002)(966005)(83380400001)(8676002)(8936002)(2616005)(4326008)(107886003)(5660300002)(7416002)(44832011)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFwbE83c3MyT3VoZHJWOFplb1Y1aWFVQm9IcEdIVVdBYi9CM2xncEpad1l5?=
 =?utf-8?B?aUpRYWJiQUU1TitScVpVVFVjUWRzSWJMZ1FPNUhsSkkzZThIQnIzMzRMaXlH?=
 =?utf-8?B?S2p0WExSb3VsVWc5QkVEN1lQUE1HLzJIc3h6aWpyUUl6Umx0akZZTVBuQzBH?=
 =?utf-8?B?YVpMcFNMK3J3N2VMaEljcHhubE5YV3BrSUhxOXdYbkpBTkJCM2JMZHBEOGtX?=
 =?utf-8?B?bkpNR0ZPQkRMRjZQWENKUXhEOXlwYm0zOHJPRWZDRkI1Rk1IWjRZN2NaeVU2?=
 =?utf-8?B?VG9CUktHcnRvTzRBY3dIV2h3S0xvV2EvTGJ1ZGZYUm4zZERYOGJETzRXR3U4?=
 =?utf-8?B?Q0R6aEVWWEV2Mk9vWnV3dzlVK1lLK3pXSFBRLy9USlN0MGlBTFBJNDZvSnJv?=
 =?utf-8?B?YlE2YXV4eUlhZHR1SDQvS3ZFdGVZTUJjZm5FU2d4ZXk5amdiV2NxT0lrZzZh?=
 =?utf-8?B?ay9peFl2NzJ2STdYVjJ3Q2I0bEhTYmlCeTFpNm5icC9rM0kzTEVwM3M1R1VX?=
 =?utf-8?B?NllOd0hiZ3dkd2ozN2JnUTZLYm1PMnR0YURYN2EreTQwczBrUWdTajBzMC9B?=
 =?utf-8?B?bmllUm5QTXA5UUREejNQcU0xa2xGQTUza3BqQ1lYQ0ZnWVgzUys0QnJIeUhz?=
 =?utf-8?B?YjYyRURRVTNkck9rZk92TmZCaWNTSlFrK1kxT2JuZ1JrQnFIZDNRZzJZZlRO?=
 =?utf-8?B?dHpCK2wyYXpHT09SWTIrcG9zdVRNSjROaWx6VkVjb3UwWWErMjNZOGFscHBn?=
 =?utf-8?B?ek5JT0ZKWlg0bm0zeCtmVEhXVFY0RWJ2VDN5NFZzMWQyV1JIVkRvWGQ1dXFw?=
 =?utf-8?B?M3lVeVdjVUsyVXB6VVlDR25SV0c1T1RUMTZEQk5vYXFCR0FTWlI1eE55Wmtw?=
 =?utf-8?B?b1c2aElpSFBDdDRZT01xMTNLQ20vL2l6eklFMGNab2ZKdDN5aXhidmhNVjBq?=
 =?utf-8?B?NFBwWEJoZ0M1a2YwS0YwcjFlR3JIUGFLOGNBeG42cklkekdtcmZxVUlQK2xq?=
 =?utf-8?B?NVd2cURETmhiOEZ4OENaQ3VJSzY5SnF1SmRlUUdySFNwN3E4L3RlVG5RR1lK?=
 =?utf-8?B?YU45aHREbkVqKzNwYVBhd2FBZHgrZ1IrUmtoemZRajFjNGxjNUdKblBTVDNQ?=
 =?utf-8?B?WnYrTURaRUEzVGxXYXdhWExTMVQ3akJxbXlVWThRUG13aEl4UTdDTU43S0JW?=
 =?utf-8?B?TUVGbTR5ZU9Zb01KUmFkYzdyMGF1NzVLa3dHODlHOTRNYy9Eb1hRa1ExZWlV?=
 =?utf-8?B?UmJMYlgzRkluYU82cnJ5UHVLR3p4QWtjQVo4Sm5sdTU1d2FhQ1dVQUR2ZWVT?=
 =?utf-8?B?SEphY2ZDK0ZHRXBaNFNyQVRhUXhXTk8zc3RrZ0Evc2ExYTVaK00xS3ViNVFu?=
 =?utf-8?B?TVJWc1EwbjRvaFlhWWpvbDdadFFwS2YyRndLdzQ1cWhYTnEyT3FMQWN4T1M2?=
 =?utf-8?B?YWJ1dnUyc2RKekw1eTRoRkpWdWdUbGM4VkF6RDZrb1QycVZRaWVFZDZnOUxu?=
 =?utf-8?B?dkVqS3pnbCthMzhWSjZodEo5T3BZUHBhcWp0WTV6THdMa1lpbDF2R3ZOOVQ2?=
 =?utf-8?B?eTlHdGh6UThvL05tSzZqOVMzcDl2UVBVenQ3VU55bWFveG9uaUIwYWRBRVFM?=
 =?utf-8?B?Q3JZZWYwREJNUUs5eGhJZmFhRzFqUzdYZzlpSVZtZzRxN1lBd0VTcnZPMjZq?=
 =?utf-8?B?VWdod0FtWFlHRkRmblAwMGRCOEVTM2FqcloxSmpLMUdVTmtvQkZBN3VNMjBL?=
 =?utf-8?B?bnU2dXZWRnl0WjZycVZmVGNXcHk5NW5tckVWVmRXd2sxWnJNc3RlRWZrTHlx?=
 =?utf-8?B?eFh6WXRKWmR0NzltZXEwdVVjMTBTTjhQQy9YbllTUitjK3NjRlBGV2xiM3Jq?=
 =?utf-8?B?enZqaFBRMHUzejVSY1I4K1EvUWNVY3p4R09OT2lEd3o1dXFQeS9BTFpZYWZN?=
 =?utf-8?B?R0xLdUxSWUdCKzkzTCtlYTc5YlhvbTI0RWdCRDAzSnhqZS93a1RWcHI0c1BG?=
 =?utf-8?B?bW5UcDlXdmVWYjRscDU2bHhROExqZ0ZjdEZzSmo3UFVhUjRKZmhNUmNZLzZz?=
 =?utf-8?B?dzkva2J5M2RQcEhjaXpJWWRNZWM4UFluWlpNa0dqUlEwbXBVTUJKYVVNbGpL?=
 =?utf-8?Q?hRysROSeALB85w6Nqjn0KpQRC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UVBCZmVOSklHbDBZRmZGWU5WSnpPNjUwSDZHOHI3Z2U2Wk5tRGN5THNGS2t1?=
 =?utf-8?B?MUljd29ZSXk2QXRqRTlyN1BGcjBOZHpYb0NtdE1Oc0dkOXAvSmhtUTQ4UGlN?=
 =?utf-8?B?bk9Fa09IWTJqOE1lNUFpaGdBbml2bXdzU2hVV3h5eFFIVUpkWDlhRk5uTkM5?=
 =?utf-8?B?MVhCZlpUSHB0em91UFNYSVZ6c2JYZWFzay9mNVVXRU1ITVR4REh1eExMT1JU?=
 =?utf-8?B?d2FxSDl0Q21maENGVzUzWU1sNzFDQmhuQ1h1UXB6ZDU2dGU4bzdZREVsdjZC?=
 =?utf-8?B?V2pPRG1YVlpSYS9RQzQxTk5yTkUwNDEvUFJsTW8rRmpkMHFMemlZM3hIRFBH?=
 =?utf-8?B?QUo1RWk1QXhmWC9HdXJGTk40NmhUV253cFg1WWNpYWk5RGp3TnJhcHdGaXdC?=
 =?utf-8?B?dHBkOTlzS0FYbUYvcUFaZ0xzYWI3NU9sSlVKSWFVREhtbGpWWHpCdFRjRm9E?=
 =?utf-8?B?djByYXA4K2FvN0hCTW1YUlI4cGVuMU9VVjEwNzNkKzk0ZGRPbWVaL3ptazY3?=
 =?utf-8?B?dnNmRFA3T055MWJ6SUlvZnVnSS9ud1N5ZldWbWMxbGZoNUxNVTRxMGp5YUpK?=
 =?utf-8?B?NUpRUHVWUnBIVjhvQ0JodmFrN0Q1UjRiSHFWQjVDVUpGSytVVUx3VjNwR2lU?=
 =?utf-8?B?M2NEaTZJUVludWJUaVZEMkpOLzNYeDNWSFE1Rk1tL0k1R0F6YW9CWk5wbCtu?=
 =?utf-8?B?YTNWcU9lL3d4czlmajMveWRxL1VMR0xMRWpvbE5rTDBmR3FkbU5nZDhUbEZT?=
 =?utf-8?B?VVdHSjNQaGdLUTB5ZVRYWElGeFo0QUFidUpsUHZvSG5lOHNpamlBSDB6N3Vi?=
 =?utf-8?B?WkpHOXRwUWVOTklzamJRMWQxOFhFV3h5aU5VcVNsYmhGaThsbnd1dytPSmhB?=
 =?utf-8?B?QUJVbk9VcHcrTlQ0bEJCdnpUV2pYdU5xWjJrRTl0eDRDaWRTdWIwLytuME9u?=
 =?utf-8?B?RVAzWWd0UnoxL20rQU94TjZFK2xQdkpaOUY1RUtmQmNrK0lPbXhXZzBDYldL?=
 =?utf-8?B?UEpzaXF4SUxKWjE0MTBuVlRCM1R6WUxuWXRpb1g4Zmc5bGVOS3RCZWtlOUEx?=
 =?utf-8?B?RTYwY28xTlU2Uy9HdmJrK1A0OEMvZW1YVHkxNG1KcU5ZYm9ycDBBa0VQN3BW?=
 =?utf-8?B?S2NXSzFXeE5FbkYwbmJvMm9iYUtxSUxGTDVkdnNZZGpWSEkyalRtaUdsanhh?=
 =?utf-8?B?cUMyN082TW50LzlLNStoYUFUVFRrMmFGR0xlRjdCcE95anNjam9KZzV4TkRY?=
 =?utf-8?B?bDNyUzJVZ3NLMXMvL3pwWURWNW9WOFlQTWNBTDlOcks0ZXBvWFBLZ2ZQTUV4?=
 =?utf-8?B?TGhoanl4dkhxL2ZhaW9WUEo4QWt1SUgvZk56dys4Nzc2MXFQN2UvVjRwWTRV?=
 =?utf-8?B?SDVIeWJRL0NlK2dBenJhQzFFT0hUUVhOMndiN3ZvWDdNWW1VMkMvR1ErQlBr?=
 =?utf-8?B?cHpzcjZhekJjSUF4Um1hbVRLemZBYnp2Y2p3QXBQWTRYMjNJOHZUOFlmTUtQ?=
 =?utf-8?Q?MjUbS1uDaeOsCvwwhvwHq1pU5ZI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e203b4-c728-442e-0063-08dba59e2433
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:04:43.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cb829GyHTVnCnNmpLUxFj0LbTw5+b1NT2KysVzmGJ4eUEk4Z9/ZbtxdQ7EKXQaFLPO87i60UX6VQPrWOL70jbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250171
X-Proofpoint-ORIG-GUID: KLQGc-luRAyMFKnEbBNBC1dpACx_DpMK
X-Proofpoint-GUID: KLQGc-luRAyMFKnEbBNBC1dpACx_DpMK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hugetlb vmemmap optimization was introduced, the overhead of enabling
the option was measured as described in commit 426e5c429d16 [1].  The summary
states that allocating a hugetlb page should be ~2x slower with optimization
and freeing a hugetlb page should be ~2-3x slower.  Such overhead was deemed
an acceptable trade off for the memory savings obtained by freeing vmemmap
pages.

It was recently reported that the overhead associated with enabling vmemmap
optimization could be as high as 190x for hugetlb page allocations.
Yes, 190x!  Some actual numbers from other environments are:

Bare Metal 8 socket Intel(R) Xeon(R) CPU E7-8895
------------------------------------------------
Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 0
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m4.119s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m4.477s

Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 1
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m28.973s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m36.748s

VM with 252 vcpus on host with 2 socket AMD EPYC 7J13 Milan
-----------------------------------------------------------
Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 0
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m2.463s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m2.931s

Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 1
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    2m27.609s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    2m29.924s

In the VM environment, the slowdown of enabling hugetlb vmemmap optimization
resulted in allocation times being 61x slower.

A quick profile showed that the vast majority of this overhead was due to
TLB flushing.  Each time we modify the kernel pagetable we need to flush
the TLB.  For each hugetlb that is optimized, there could be potentially
two TLB flushes performed.  One for the vmemmap pages associated with the
hugetlb page, and potentially another one if the vmemmap pages are mapped
at the PMD level and must be split.  The TLB flushes required for the kernel
pagetable, result in a broadcast IPI with each CPU having to flush a range
of pages, or do a global flush if a threshold is exceeded.  So, the flush
time increases with the number of CPUs.  In addition, in virtual environments
the broadcast IPI can’t be accelerated by hypervisor hardware and leads to
traps that need to wakeup/IPI all vCPUs which is very expensive.  Because of
this the slowdown in virtual environments is even worse than bare metal as
the number of vCPUS/CPUs is increased.

The following series attempts to reduce amount of time spent in TLB flushing.
The idea is to batch the vmemmap modification operations for multiple hugetlb
pages.  Instead of doing one or two TLB flushes for each page, we do two TLB
flushes for each batch of pages.  One flush after splitting pages mapped at
the PMD level, and another after remapping vmemmap associated with all
hugetlb pages.  Results of such batching are as follows:

Bare Metal 8 socket Intel(R) Xeon(R) CPU E7-8895
------------------------------------------------
next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 0
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m4.719s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m4.245s

next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 1
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m7.267s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m13.199s

VM with 252 vcpus on host with 2 socket AMD EPYC 7J13 Milan
-----------------------------------------------------------
next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 0
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m2.715s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m3.186s

next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 1
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m4.799s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m5.273s

With batching, results are back in the 2-3x slowdown range.

This series is based on next-20230824.
The first 4 patches of the series are modifications currently going into
the mm tree that modify the same area.  They are not directly related to
the batching changes.
Patch 5 (hugetlb: restructure pool allocations) is where batching changes
begin.

[1] https://github.com/torvalds/linux/commit/426e5c429d16e4cd5ded46e21ff8e939bf8abd0f
Joao Martins (2):
  hugetlb: batch PMD split for bulk vmemmap dedup
  hugetlb: batch TLB flushes when freeing vmemmap

Matthew Wilcox (Oracle) (3):
  hugetlb: Use a folio in free_hpage_workfn()
  hugetlb: Remove a few calls to page_folio()
  hugetlb: Convert remove_pool_huge_page() to
    remove_pool_hugetlb_folio()

Mike Kravetz (7):
  hugetlb: clear flags in tail pages that will be freed individually
  hugetlb: restructure pool allocations
  hugetlb: perform vmemmap optimization on a list of pages
  hugetlb: perform vmemmap restoration on a list of pages
  hugetlb: batch freeing of vmemmap pages
  hugetlb_vmemmap: Optimistically set Optimized flag
  hugetlb: batch TLB flushes when restoring vmemmap

 mm/hugetlb.c         | 238 +++++++++++++++++++++++++++++--------------
 mm/hugetlb_vmemmap.c | 197 ++++++++++++++++++++++++++++++-----
 mm/hugetlb_vmemmap.h |  11 ++
 3 files changed, 343 insertions(+), 103 deletions(-)

-- 
2.41.0

