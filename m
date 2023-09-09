Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB6E7996A1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 08:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245304AbjIIGlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 02:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjIIGlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 02:41:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9101BC1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 23:40:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38969UiS004035;
        Sat, 9 Sep 2023 06:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=AHkR0j/dQwdjx++tWh+YgyJOJpaAFpDmkUkvtd4YDsE=;
 b=do+INNihw6SDgIdKMAFHBCOOHGNrfI6IDGbrqiqWFEzuUkDvzeSDeMHwyxzalJQHXZAR
 qOoy3OVKAoRjBpiDZl67X4XWAnYSkfSHURB3zuZglVLzloVnHsLdRAO+Xcnxuoi72v85
 KEpFLycicgZevil7KfoDdj16dzsVOAa+fTSVaoSugQPYIU9PsofG1LMV49svRQDKcdA3
 iOei/1kVXooGYJpXY56Csxw1wxkSjTCd2MX9X9RDKWW4yIU18A7v6Nm5heIQ99+F6rn4
 dNEKxDj2GO/HVNZQWtXFyo2mwonRf35uIep63f3cvyWEw3mv5CHWCMn5UDHqIUj6iTfr tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0k6fg0u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Sep 2023 06:39:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3895lKod014757;
        Sat, 9 Sep 2023 06:39:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f58n9sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Sep 2023 06:39:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgoYcx9NQYvQyXkEMqe1JSK6mvZ4KprYPKiQqQCAm9aIufHDQtV135zEHc5AqdFMsZY7grzPbz+3qV4/3jheZkW0P/O044cq+XIdO8aRawaj2MpadU9QAnL3oOtvbwyXqgVhiq9yUmNoqSSFbGLEQoffNZIjA9cFOFwIjD3WSrtcmYOPK2Nb99pYjd+gUeefjPNO9vjvVTxG0wYlaY8dxOIT6YrUp/l/eIY+kn32pOlDvpEqTCTlgB71IhwrProzFKn6B/jre+bLhXGod4L1pSdCFCpatqOLwvVNfotaxDSpFSvRiSLtJ/K76Kj2R4XfrI+++XdcGlPWxzYCkT51Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHkR0j/dQwdjx++tWh+YgyJOJpaAFpDmkUkvtd4YDsE=;
 b=DvRXThJMHH79H3KZpoqFKqnAmXhUFsx5BumMwyfugHsaSolWzRmU0les8gWg6XRQIIpDH2OsOpilS3gmvg7NAy1ex0k2K6mZ+b5cjNBt3s9VfNs3DGz3M/h6kyvr+65R81o8jUi0SqcGX+HXRAHdP2Etu1XziHWURS42wPMK6ONccA4xqT5QLZuKKB47KXkDleag91N1tyOGFexh70Kp+kZ5GK5ETXINCBnw5Ym9kz7PgavzfqnaUfecTQjobe0mJyO3bNJpnsakvPQ8FbaWF+iUZimy3F9BpHg0H6v7vlAHUlPxyNHLheO8HaeDwcs+b7hnJtaRdCJpSpraaKdXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHkR0j/dQwdjx++tWh+YgyJOJpaAFpDmkUkvtd4YDsE=;
 b=dfxafauYnORWLr0FZnMZMFnr0E365hdzrP9e7q6UxpbWVdft2v6i2CVJxaOpWMiTEzL4Oo/fmC3dYsYl4DntUv9YbW0tCocxLtIgY5Gc2MUOyj6EPRodOco+wiXJICCRD+oVXBwrw9d649ZqcH85oSjWMvQI/AT2p3Y41J45/aA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB4541.namprd10.prod.outlook.com (2603:10b6:a03:2db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Sat, 9 Sep
 2023 06:39:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 06:39:49 +0000
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <CAHk-=wif4WMu-k9Pi9BoVRZwH6npjS6Km9DR9aROxANZzN2iRQ@mail.gmail.com>
 <20230908225018.GB32012@noisy.programming.kicks-ass.net>
 <CAHk-=wiU+5XUG4mDcjjBZFbCrZO+mGY-LfCCMshRbt+NjSmWyA@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <CAHk-=wiU+5XUG4mDcjjBZFbCrZO+mGY-LfCCMshRbt+NjSmWyA@mail.gmail.com>
Date:   Fri, 08 Sep 2023 23:39:47 -0700
Message-ID: <87sf7n6ea4.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::44) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aafcfeb-3192-4c77-b2c4-08dbb0ff90c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0UgjQQl/54WSCJ0sB1XwL9gtN7Bfc+pKm/kySbojEdeTMl3p6j6kn9J/9JS2yCCNgqLmqqAno2RssJKWN7qjOLkFeWPi9OiJpxC8tBFHFfuIZjmSSFjy3aS0mBflNbnaDsYYABwTDHX/tlPuUu9Q9slBPxR+CODZHb4LCI0DZ1GMm87zqpQuI+LQyzcSKGru1kIKnPkpDuWRZGDR+yZ0A9vwSMBoJIS2aWuTzMC+2JFkX9qrWyjsc7Oa95dTQoUyJux5Y3D/fE/sHkuhGO7AEbYNGc8X4kuPFbvztiTwrPcrK5R6xojermP2ToYJa84jPCeGDdZCAJOClGqdGGHuu3PUoz/j+rzGwafwQwlLBMbc74oSmfB8mkeAb0fxxs5vkm4EZAB6F8tyUpXphx7GEE9HvhUuJzFwEqnKExNHyR6jZlwDfUFr6BhdSzLmgS9wz/I04/f51JtuOj4qKV4h7mozYONFKuK9+Z8HLZEwXwzmj3YisAephs7Qjw/EKwoyUgjGpfUHYkwhSru4G0xFaeITAWwJaAziVBHHNwzK0EAlBKHxbDMI4XknbzP0qIq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(1800799009)(451199024)(186009)(5660300002)(26005)(107886003)(8676002)(8936002)(4326008)(2616005)(2906002)(7416002)(83380400001)(86362001)(36756003)(38100700002)(6486002)(54906003)(66556008)(66946007)(66476007)(6506007)(6916009)(316002)(478600001)(41300700001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NFZVWJHWmPL9IcPw8lpbkcVLFp05CAw8X4Fwcrk7BESIIy/N6w8bMa8PUdZg?=
 =?us-ascii?Q?2yml4olIgfDKstoX9IaMWE7bfJVg+vqV2tpPWNIddav0wzlh05nXKQnGNvlb?=
 =?us-ascii?Q?i6WU9Gn93Mq7oUOTv910zqXnLF7iyBkCjJ6simOEWXpjn8nViYaDcYs/sbPh?=
 =?us-ascii?Q?WDfoZmZx+z5eYADRufWGE8OlGBQBVCbgpQYI1zy8ua5AYIn3rk3239FRT2tp?=
 =?us-ascii?Q?p1zq5Q46wPBHnAx2tr9OgVYXffSR6YRA0Va0X91+sex5X6MjonYAmkJ7Npqt?=
 =?us-ascii?Q?J3zMmwkD5FmuXMD9AsKv2DDHnAWGsPw4U+nwwjHDC8RIkwG2EkNYMTnAkdHw?=
 =?us-ascii?Q?KaRcWwXvFpZgNvKKZo8N/1bFhhga0iFLCRMif+wen5LENPjLu0hIdn1ncYzy?=
 =?us-ascii?Q?LdUeM5CfOZJep59bM0NiqdNoB98sA96VKelJDIrvkqQW+A2Y5jevYIFwABzA?=
 =?us-ascii?Q?szrV8/uEwVxxbBaKfRul3j7hpDKhfl5kz1urGC2Vk9c2OC+E1V7jVXxAl9Yw?=
 =?us-ascii?Q?lSW/Hux7qxkRqaP0zygZG8RRWcXP0yvt6iXrePRLwNyMmqD4XbNAK4IrAP7+?=
 =?us-ascii?Q?VvA2U4+gcSJJ4MiV8omTu8BxA3+obIj1nW5coHR7dGs6MeyiqvXQuGvOxD0E?=
 =?us-ascii?Q?9UCXyBD2lEkFgfaEo7NgyGNzaLZ5YSajKUO+nousjZc+KvmSl8hHYz9qnjta?=
 =?us-ascii?Q?FJ5LuLTt//cfyCUU0VV34oA2MFsAbvEdevGEfwoprhZSnv4YM6BMSNWDJK8E?=
 =?us-ascii?Q?XuLo4YtX7hvL91TIo2XMG+5KrHltEKS0r0R6FHoZDb8KXgp5mMVSAcf5CYAA?=
 =?us-ascii?Q?i1BeSEY0qifOCHADbRV/WZ+u6Rvl+nq5Twh7V+CYa9vivQozfhkg8XgMY92q?=
 =?us-ascii?Q?Q3dFWfCoRy3HrfsYWyOKZMC5XehQVOVgvnQGyDCProvpSWUl8YuuWWKQlhaV?=
 =?us-ascii?Q?0vdYjnkjy/ntytuyPFd/irHhv7QVDtJAJUOMepQ1/iTpC3jsbJaIvCbFNxO0?=
 =?us-ascii?Q?g/8RLpHLNoBkjurMFzk5Zh1tnCnieDZxJKchyMWMjI+gI9Dq8yecVo9N0uJO?=
 =?us-ascii?Q?N8+e4XQ0I+Q/r1iR6PREXdeMYC14u7Zj+yNtr2jLx92Dcd4RD78lRhLg2DRc?=
 =?us-ascii?Q?tvlZbgce5Jga3QlKJSNWeRpmuLz7tfV4hUlfhkTXKds36lYUdncmzO4mCsBC?=
 =?us-ascii?Q?zOyinisxsDfKO65KOr4QO4Rz/vjA0e5cW0V4s0faD0+//u5wqxxs9qnLS1Cr?=
 =?us-ascii?Q?tQwCP41117kg0bSqp8kEffQihtZ8YndRlE4TUqoQoh1CM8NT4Xj6b9VTtQ6S?=
 =?us-ascii?Q?yTX40/vWVJ+AXtQ0Ac9Mwr7j8/pK7W/oTEmi/VYIA9ETu398N01op8KTtLra?=
 =?us-ascii?Q?nduMyGrkFqOOERBeA5DHBYX7944lVV40EoVYEm4QTbrXHE95nrVR/IGfgIeQ?=
 =?us-ascii?Q?7+s00vY9wgx+tJAtUcrRcztLddUZxs3+Op9JzFi6UTfxfpk3cFFc6UWxZcPj?=
 =?us-ascii?Q?RTeQ0yRBbdBlo01yjdD0PM0oib7sSANvwjlB5kBS4+4Llqq6rlvtm6Be5zss?=
 =?us-ascii?Q?qsSa1Ysqc7zXl8JrvlcfortmFqCBg2VjYWTGb3UyhpbgP+BQo3fPuN793FFO?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?64+hWHXSi4wQxNBPms6CuqhjP6aOTAVi49jetUqW2uAlfnw1ENJuYztmNJLA?=
 =?us-ascii?Q?/F2aHl9bXez+xE1gpsXMcPn4KNXKWp8NWmKhIGM9UUPYCmLmC6/3eXBvN3wR?=
 =?us-ascii?Q?N5AoapWc9fKweBlVTw7qKxKEQfaYR1B13b4eDRdLl5F7jguB9bJTGp2cLzpj?=
 =?us-ascii?Q?OIlthwly/iotlchZrHZgn9dvaUis5pg+Nt2KVwKrTCvJ8ChyxnZKK5JgF04M?=
 =?us-ascii?Q?PywL5jHkrXuHbreSV866y/5Luw4Cv/ojCMRrTwqPHpMRJef/s6GXoir/76hD?=
 =?us-ascii?Q?5vy99AC+cNjOZsfh9q4v9Iwbalu31oBPIWDZalzhhF5U5vsBqaQke1up1WUZ?=
 =?us-ascii?Q?/7yzJIE+8oUK7JJPxObgC5sOVYEw3AhuOwcqDaUIS2kMb5bDE8xkYK/c8Acx?=
 =?us-ascii?Q?yTR8cUNH9Tvc9J8qps6iC5Gqu3VS8OZMeIHhmeVtPRFL+8/dobvy+5lB5Oa2?=
 =?us-ascii?Q?xJwM1KnuKjJmkq+8/RQ4iXBtDoxfFPryQ1EYqCa9nJdtop1p/fH+cHoT72WG?=
 =?us-ascii?Q?gNEJ7OU256o8O2RW+8A/AlmQiXOQYtMQWQRtQTl4QPzI+ApVcbHXahiEd1E0?=
 =?us-ascii?Q?uNvwBI3wfneGHnwAB4P6P9hysm+32NE7Xm4KkRRvBKU+0JpBdnNUkn3wJDil?=
 =?us-ascii?Q?Vj3yaKATT9w9Tvr9dTxdfEKMeZ3uOUW8WN97uQyVOUDWQEyMDv90WDczvHpt?=
 =?us-ascii?Q?JHdJizwE3swoS8/ayZVmKhC8g6/4Ya/wuDlcKMPs1Wc2QN76DHzsWATrRmai?=
 =?us-ascii?Q?X+Cl7HT0GHhjHbdvSO7bnJ4p8ErEewyURhZ1wZyPQVyP5lOCWaS6o8ATWriv?=
 =?us-ascii?Q?f0X63671+8vbzS0sLmyacZXc2R6Yi0KnGwzmZjDsfDahRh8HKwGAwNmPr9Q/?=
 =?us-ascii?Q?lKjEoNPYvhtAYRolBj7ZMkVS0Saia19dy8X6fZqzq19OBzikgf2xzkDKbX+E?=
 =?us-ascii?Q?SJQgBJCMyfIumRIqLXClhVQbAQ8nCr4OV/AVn0UKNcJnMCDWZplhKcWCCV/n?=
 =?us-ascii?Q?apzrsD/VzaUuKUEU31GDIucGdOMtWqU37N5PvQDQeSL6Xcq7s0xY/irilmuw?=
 =?us-ascii?Q?tRs5A9XKAAbZsnYn2MOflJ6LhNTTrSz2sTQWQapD18O9pEMhY/zm71+GdNvZ?=
 =?us-ascii?Q?/yA12sD5bLAnRhRfxZLhHhcDP/qqSmovdKW4q9mzVERm0jxUkBIAjDs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aafcfeb-3192-4c77-b2c4-08dbb0ff90c5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2023 06:39:49.7753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXH7p/Yv0C/lXdBgZ9uy5H7rnDj6XKaTBmeE9ZX86Lm9tqD6dob5oIyIRWSkFpAWHJtRom9t8MEnhWKEct99h3llswuJyEYdRpbhYc4J7Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=615 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309090058
X-Proofpoint-GUID: NTbnp122IDcMYxkVwIB0pMZAuzzyBMp3
X-Proofpoint-ORIG-GUID: NTbnp122IDcMYxkVwIB0pMZAuzzyBMp3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 8 Sept 2023 at 15:50, Peter Zijlstra <peterz@infradead.org> wrote:
>> >
>> > which actually makes me worry about the nested irq case, because this
>> > would *not* be ok:
>> >
>> >         allow_resched();
>> >            -> irq happens
>> >                 -> *nested* irq happens
>> >                 <- nested irq return (and preemption)
>> >
>> > ie the allow_resched() needs to still honor the irq count, and a
>> > nested irq return obviously must not cause any preemption.
>>
>> I think we killed nested interrupts a fair number of years ago, but I'll
>> recheck -- but not today, sleep is imminent.
>
> I don't think it has to be an interrupt. I think the TIF_ALLOW_RESCHED
> thing needs to look out for any nested exception (ie only ever trigger
> if it's returning to the kernel "task" stack).
>
> Because I could easily see us wanting to do "I'm going a big user
> copy, it should do TIF_ALLOW_RESCHED, and I don't have preemption on",
> and then instead of that first "irq happens", you have "page fault
> happens" instead.
>
> And inside that page fault handling you may well have critical
> sections (like a spinlock) that is fine - but the fact that the
> "process context" had TIF_ALLOW_RESCHED most certainly does *not* mean
> that the page fault handler can reschedule.
>
> Maybe it already does. As mentioned, I lost sight of the patch series,
> even though I saw it originally (and liked it - only realizing on your
> complaint that it migth be more dangerous than I thought).
>
> Basically, the "allow resched" should be a marker for a single context
> level only. Kind of like a register state bit that gets saved on the
> exception stack. Not a "anything happening within this process is now
> preemptible".

Yeah, exactly. Though, not even a single context level, but a flag
attached to a single context at the process level only. Using
preempt_count() == 0 as the preemption boundary.

However, this has a problem with the PREEMPT_COUNT=n case because that
doesn't have a preemption boundary.

In the example that Peter gave:

        allow_resched();
        spin_lock();
            -> irq happens
            <- irq returns

            ---> preemption happens
        spin_unlock();
        disallow_resched();

So, here the !preempt_count() clause in raw_irqentry_exit_cond_resched()
won't protect us.

My thinking was to restrict allow_resched() to be used only around
primitive operations. But, I couldn't think of any way to enforce that.

I think the warning in preempt_count_add() as Peter suggested
upthread is a good idea. But, that's only for CONFIG_DEBUG_PREEMPT.


--
ankur
