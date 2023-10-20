Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DD07D06F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346921AbjJTDhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346873AbjJTDhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:37:53 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2138.outbound.protection.outlook.com [40.107.215.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53233C0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWFx3CREPk7LTrKppvREe8InSaac9V4xUfChXWnU34LsXtHWBJPV65qYfRWjUliwGBQxGWQ6FFjcAq1Z27pgza/JJszteILWqor0gWVIhz6be+T2aM+XQfm7b2PwuFTL885MQodp9CwruDHzQ6OTfX0JaUKTMBijpLY/sGAt2rSsfL1tz+WK+Cyk6ME2GlVE5kG+0s7OOekkt63IjL1mtE0MjupL8mktI/q6UOwKZ4UkVNVc/8/nML656+2nCd6UgPvC4+bZ07TYYr8cgu7T18C6emG6mRczcorFdEK60rSLYnLp9UqTRA7X8kRk8s2j9Cd3Lkd1oq6zOjYrSK3fFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuPsCV+wDdaN5JJKDxKbeTyfukDgPzJqqblflDbN5ng=;
 b=iNZs0HY9esXi4w3i5n2sJ95+chrnhy3ZiKw/7v03YE5yCpfcWvywrrlT4S4X7mB4zqqUfB4Fcb71J0cXqgaejxF+nn72HIaiSl3M0XdZW7vbeqNvTIsaLBnYyAzKubH7FmCF7Wl/a/83wP2cZZE5MGDkIcJo31VDfc00es1XNK2yL5NnFoz8ocu9kQwQHzv4rbc8hMJE2HehQnL52iBychqEKGGeVbm4FUsSkR5pAZ/MxyCbCIK91TD7ZJC1lC4TkmrERteVq0/QWj7LOgThYWNXDeiz30BiXXDMogoC/bsuaWV1wm75oojHuYoJBu4AKlK8JSMrhaWyIv3FVE8opg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuPsCV+wDdaN5JJKDxKbeTyfukDgPzJqqblflDbN5ng=;
 b=WMoek5PasEy/6gW697KN9lTyf8rY+7fk3qd2SEhMglWkRPRhvf8idaP9zWvzQrvFaF4e3vxWP1KgWtetosTxysNq8p98Bu4AT8C4NvugpVd2Hzw1XqO/ytFoJKlrj2/TcOeZrE0pjADMoKmSZNvgGIcVZtzuNRgbPAjp6iQoucGXl1KgzUiTZ27NjsX6rEhVKgUmlkx5NCBEKK/E8G83VesDOBoPLz3LNzBplirBbBvJYnU2iPjKzj+LVwkuRmJed2lM6U2BpPwVIMu9i2OAvfSF0PWUZRqNs+vEKQgtxRpO82bGGRe88THdskW3QcZy+tZ62ARvL3pqIRAhzV52kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TY0PR06MB5496.apcprd06.prod.outlook.com (2603:1096:400:267::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 03:37:45 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 03:37:45 +0000
Message-ID: <e38bf11a-9372-4302-8405-af44422d879e@vivo.com>
Date:   Fri, 20 Oct 2023 11:37:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm:vmscan: the ref clean dirty folio skip unmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20231019134211.329-1-justinjiang@vivo.com>
 <20231019134211.329-3-justinjiang@vivo.com>
 <ZTH0Aob4srLnnjCM@casper.infradead.org>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZTH0Aob4srLnnjCM@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TY0PR06MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: 0270a854-7002-4d9d-191d-08dbd11dec6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usFI9oVPB8jUFIJYoIJ5ofV8jW1c3pnTgp+jTFtJQEQcx6PqFT5aIdWbWwPq4nJ1jE/uo+5uG8HKlhlDKJRpZ9xgmkxL/cNG1uL751VFpO3u7nQn4Yf+jQ1s8gsxP6zXCdl1+ExE9w94MRCN5qMmcengtq5f0g2OKyXiFQ9MYTv2mN2LsX83mVjlCQohOL6/jHoq+7ucXb20psqo01prBzL7HzRsL9mX05MjLysiIRJ/AF4V4akUb5hc9ifNEimnQFhH7lkQ9sIJ7i33NDjTJApNi1sXgFV6Xk6mMKFBVzVAFFOOVYAA4L42cdFIoNuZEcOO22gGG3QFRF+CW0psL2oppu1g3sS8qI6VOdVKkei7DuCmFU/AFnS+L1fhdcsTJRaj5BvA0pxQG8xqCVEETao5aGCPq+OcgXCfmZbhHYjtkY1APgGFN8HLrGbURap9bq7sbnb725WVDe3mZtoPHeHrArTFsTtdXyeP5jgn8UqeKLPd6hMKT/yCRIPcNC5DMZD7vPd7vUbF5f6L10ZRh22WNUhLfcbDPrnnGBQaVlIMF5Owgi9Os9oxuXJ0aDPqyuWLNKDr7DSUGoGkVsJsaPXxiMkw5Ma/90nErH9C9/8N6BzW+dvpSZ2Qhs5RpkYypxWRkqLFCLgGxDVodqE6RT25v0F0L/zN7P0yWUleZcmHa8cL+BFp+COL23EB9dRu7EeXxSRRTKdBALcZ67s+vQndYWf7cNfIGgQc5dpY7iY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(31686004)(6916009)(66476007)(66556008)(66946007)(316002)(478600001)(8676002)(8936002)(6486002)(83380400001)(4326008)(38100700002)(2616005)(86362001)(31696002)(107886003)(52116002)(6512007)(26005)(2906002)(6506007)(6666004)(36756003)(41300700001)(4744005)(38350700005)(43062005)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFlOUXVQdFdKV2lnVVB2QzIrMmI4WDc2VXpyZkdOVmpzeUQwMDZLMk02MFNx?=
 =?utf-8?B?dW9HOHIyRHFqblBybE5xRkx2TnNRYmFBalpxa3NxbDZMakZJSnpkck1pUTZB?=
 =?utf-8?B?YllRUlF5V1hWQ0tHSnNaUXF6d1V4WDF6blZKRTQwMFpSL0xMSjI0V1JPR2p2?=
 =?utf-8?B?MVBYMlhFdUNEWER4OHJ5R1FVQzlIcXpMTzRHNHhVY2VEUGF6Nzl4d2NiUlU4?=
 =?utf-8?B?OVRFSWNUcmFic055NmFQVW5rU2pIM0NRR1ZzQlgybEFQMTV4YWVNelJaRUwx?=
 =?utf-8?B?dkloQjhZWXFEVmxlWGs5ckcyVURRbUR3NWd2N2Zic0EvdnNwTmtvUFFOMVRI?=
 =?utf-8?B?MVpGTlNORHE5WHBjVWtDNjM2L2tSUFBGb2NCQ1N4MjJHK1Q1NExkMjNRdHJZ?=
 =?utf-8?B?Rjdrd3FRUlcvcHIyd3hqRUZtbHRMT0F0bTFFVm5aa0VKTXVvN2xWR05GSXBK?=
 =?utf-8?B?QlljZktOMlBSTTAwckQ2OURySUxVU1dONUgya0FKYjhucjF5NnNwZVJoVHJE?=
 =?utf-8?B?c1BtUm55UlhyejJmSXg2WUU2Rm1SclBENms1MXFaR09jVUlzNjVJMFNGRkR4?=
 =?utf-8?B?dTJDNXVXTVIwMGN0ajFPLzRaNENoeDdXSGRRVWxBMHVuRGU3bllxS0lIWkd5?=
 =?utf-8?B?ZDFQMVBoak9Gb1lScmJ1aFdJM1p5RmZ2Qm5pcWVZaXRGNU12d2hiOGI2OS91?=
 =?utf-8?B?YzluYk9XQ082V1FhSHFFNndrVjdUT0tCZUdhQTJzam51SkUxcVAzN2I0TDdv?=
 =?utf-8?B?VHZ2S2QzdE1CaEtPeGVuMXc4UnRodVJZR2FoaU5DQXdhQzk0MzdJUHZCeWVp?=
 =?utf-8?B?dlNxNHFyY2F0QnkvZ21FK1hPTjZiaTM1MFNGWmt2RHZNeFNxUUNXVFlkOXRj?=
 =?utf-8?B?Nk1OWEU5WkE5OFVTeU5ubkNhcVczMTlKcWFiQ2hxSnZzUUZPbFBib3dGRGlR?=
 =?utf-8?B?ekN6UmZaeGg0cWJSWkhnbm5qUHNSL2RVQ3JyU2FzUU83KzNuQmc5Ti83UXNI?=
 =?utf-8?B?aTdEVkpLaEQySy80c0hVT2RtbnFSOVpFTXc4NTZKV2NneW1WQmxjdy9leURH?=
 =?utf-8?B?bnNDb1MxdDErRkFGNU1BZXh4bEFWNHY3am9JeXVweDgrYW9Ld2E0TDdXK0lq?=
 =?utf-8?B?TUY2U2RFcjhRNlpKTUtLVVBXSGgvblJ6UHpnU1BiUURneDRPVUxtM1dXYXpW?=
 =?utf-8?B?NDdXNWU3TDdINld1L1JwQ2J0Mll5OHFNZmtVdWxBUmg0aGJBUTljTTZUaElT?=
 =?utf-8?B?UUVUWWQrQWtNZy9LNVM4d1ZkR0pTbUhpRHpnU2ZHeFZ0T3pycGJTWmRqTTdW?=
 =?utf-8?B?amZUaW9pQVBVa1ZjTDdlWkxxVURnN3FkbWl0bFBkTFdrVE5JUGNhbnRzYktL?=
 =?utf-8?B?Umt4akNiNCtKSFgzRzFoNGd5TkN4NTdzSTU2T0tuR0Vaczg4OUlKRGUvd2hK?=
 =?utf-8?B?RC82eC9ycXdJRlNibXBiQVF4T3FqMlJheFpRcG02cWJxcWRXWk1iTjlHZFdv?=
 =?utf-8?B?SVlMbzhUNno0QVUwb0JHdEkrZk5EUHdBRWxKNWg0UmtXcEZNTUtmR0JnVFR2?=
 =?utf-8?B?RWxRR3ZqSDNoQWxEVGl3U0RibmFJSkpOL3dDRlRsaHdQZnRiWmhuR0hNa0g1?=
 =?utf-8?B?d1NwbW5QeEI2Zk9BMlV2akJHeUhKSC8xOExFcTdUczJyU3lmRTQ3MjlObGxX?=
 =?utf-8?B?eWhrSlAvcy8vYzdwUGd5cDFzbzNyLzNEMHpNUE9sV1V1RTR1NHlHa2NBekd4?=
 =?utf-8?B?d1JtS1pZQmhXZktFd0xhdlBIQlZnM3BxdUdkQ3dZem5iLzh5ZWE0dTFPam4z?=
 =?utf-8?B?akZpcXAvWkJTWnJ6bENzUWJUeVBkU2ZjYkJWSGlIcjhMRTVZMmkyZVdFSGR1?=
 =?utf-8?B?cFFUSi83bmV6bHdWMlczVlJFbE9xdFBrcTJHNEdnbXJ2eUNnTFIway9SSUhv?=
 =?utf-8?B?d2ordHM5L0Q3b3h0eHNCaThIZXQ0cDZKV2hYL1lJY3Yva3hUS2ZaaHlUTHBq?=
 =?utf-8?B?aGxJWkpWV2RiUk1GRHo0dnBrUmxDcGliVHo1SERWdFhRM21JWXVYbEthd0ZM?=
 =?utf-8?B?c2VZSmc3cWJjcGpRZmxjQ0RSOE9neUpQdmxCc2s1dzA3eXZtTzRubkxURlpz?=
 =?utf-8?Q?Ci0R6kzXcgT1jsHISrMBfKJDW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0270a854-7002-4d9d-191d-08dbd11dec6f
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 03:37:45.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP0x2MrGZ0OiWqUsDdoxDnWjQfw7LU5PhwvpLdG+AIclY2OMirwVrmSvqf2MjayyFleFexK5oXi5QZTIBW4X8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5496
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/20 11:29, Matthew Wilcox 写道:
> On Thu, Oct 19, 2023 at 09:42:11PM +0800, Zhiguo Jiang wrote:
>> +++ b/mm/vmscan.c
>> @@ -1225,7 +1225,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>   			stat->nr_ref_keep += nr_pages;
>>   			goto keep_locked;
>>   		case FOLIOREF_RECLAIM:
>> +			break;
>>   		case FOLIOREF_RECLAIM_CLEAN:
>> +			if (dirty)
>> +				goto activate_locked;
> Why activate_locked and not keep_locked?
Hi,
This is  a mistake, should be keep_locked.

