Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D407FE7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344309AbjK3DkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjK3DkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:40:11 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469BA10C6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 19:40:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtuoGjM3tmHq+RRyxQod8PuSKiwWWpG8J0k7/nF1hR7OsMfZAz+5+p+uWFhC8BJxnskrDpr6CZuT4iRFHBr6Fr/ZzBLnEOYhswez+QjHpt7wa0C/9rMMEq2q0/DGLghOyuncOrbLR/lZCuqevXXQKcQJvnNwYomQ/mqrP0TjmpCaYdU6P1nYAgulCDm33954dNdLFv+DR99dR8aG8gQDsq9AzbTdWlTGm6iwWGcc4gFbfToaDjDF0yWymt5uug9uKkNOaSqhsptOSoM32/RFKuLjHRzRCZOcAVCElkOhONr/koHpIsutHVrBdb1TXWzHVivMsBtPbUWUBncyEr/TGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug4/dmi23ed5P5Cw7ssN8JUJj/zmTeoD57L9WwLtK9E=;
 b=ZSCgmxjW8vnx6H2LcxEm/Ee3fC14/0c6pZQsHbAIi7D7KHP1aA8vdjdLPgPC1Me8ZGCg3bMhR5qnRw85wNh25fNDTJ8ZRhkuxHzDL60qKdtCyoTSj0D6MtAZAVOHRZUPM6vYVbmpQD0xqzaBbCNtlizpEe3TkmAxSjy/yIhNaUFA79M0WmpO5ZT5pOVpodNlD/XVKwHZVIUHx5PCVEbycl2ui705efVTXz26ulpj6rYOhwLKQbJLTJ6eYmokienzmgakzg3qPiIyI/OJW08z2dDEuZ+6wUHmkzRBKPFG2Q87XGcwPZE3M5V4FpUaQuZ961fOuLsuKCVmpuPeyja8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug4/dmi23ed5P5Cw7ssN8JUJj/zmTeoD57L9WwLtK9E=;
 b=W6JhE0rZz+L5AcOyX3waB4v9UNRIUiOZrTj3diPyZHKuH4nvW+Bwa1cQZrmNt9oM4dJ38fFVITXK/AvY3vhFq45O7s8WXiWKPsm+zbGXFDLQW04Ut4D+alTbL9B5VHvqk6hqqJ12TtlFd3nbeQVwKBbJsFPQBBNyE8GfdnpGXs6E+uO5IBydxaG96RKYloLlkK2bkmO950f5wLNQ7/DvmvpksZNjxZCJ2kY9RSA91RxcXGd6MK8tOTDET5nwoi/jzSykk/MUAAwNm1hfosPKELPSxAo5ciNP5hcGYG7k1VpIJ2K4dzBkQqgm6YII4PRgS2rwNYESHhU/l0rEoTrIGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB5644.apcprd06.prod.outlook.com (2603:1096:101:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 03:40:09 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 03:40:09 +0000
Message-ID: <620915e2-7b4d-40b0-9af3-71abbc18d586@vivo.com>
Date:   Thu, 30 Nov 2023 11:40:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm:vmscan: fix shrink sc->nr counter values issue
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20231129130126.2130-1-justinjiang@vivo.com>
 <ZWdWFx1mXl29dP5U@casper.infradead.org>
 <dc01e0d2-17db-4531-bc7d-7d637d96c2f1@vivo.com>
 <ZWgBl07bJqrLTpzZ@casper.infradead.org>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZWgBl07bJqrLTpzZ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f5afe3-76f6-4b8e-5e07-08dbf1560d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ziIBoZ8lfOS5b7xJA3qu92iJ3/TAfOl7UDwl/4A/lJh1cpyhz/+NV1YuM5KE/vl1ucgpTzhfb1dwbK5sH6nJds7vo6/PZ1QRGN2pGDVSqihewNQxZAiw/z6i+BWyS5PZDF5ZzOdnhj4CbNLLy9y+aBKRpVhGc4coJJfgJIvlVz+EVwK6Fq5qkXJIAM04yeN2L0jccxyFoig++2vPKcfhkb3TdnBGj0HmMgpJ0yEBrmresRDBfwY+xWjJwt5/4NgtrIxAkNCxb1biTznwIeyiUYRpBgr40a2mBvW5P+0hyQEnC1CzrYEqZ8UDY2lkk3F+C6VemGiYdKYixU9Hy2RM2bt6hjMOvxql3op0CEp+eLiE8eHgK3WRBc/CN+U7XXOoTh2ZKGt1xncFATmG1e4U20H4nzs/lHmAcYY0scoQ81i18Xt0qc2CPuG0RPPlyjsTQgYYoypVdJkGluaFXP5rQkx4kypVoEXbl4k8hbZXgnPlOukkxil23v2LSBY8UIh5jdfrBKRWkBPOYy5nRJZjRTXYJP5nP/KNOxEe57o/d+1i3iB1Rq5zNommZ64+kRUFYBEvsVcCvBUv5TxlBVBhhE2HBgpy07GoVU7DVjNFKowwDofI0D5r0bUd02JBVUnj71nHlROb524IHvVt9sKEOTEi7gkNZNnAg6wPZ022N1w3rcJWdLZAYDXL8hy/vhpvVd5VLT4QvxBfWE4TbJxADGfKnOc4+0MjIEBskth470OEiYF0WtRNWV0Onv7CtSVB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(202311291699003)(2616005)(478600001)(107886003)(26005)(6486002)(6666004)(6506007)(52116002)(6512007)(38350700005)(38100700002)(36756003)(31696002)(86362001)(5660300002)(66946007)(66556008)(41300700001)(6916009)(66476007)(2906002)(83380400001)(4744005)(316002)(8676002)(4326008)(8936002)(43062005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmFqREpibFZiM29DejJrWGpEOVo0aGlqK1RiM2FDWEZReFFLdElDQWpvVTJ2?=
 =?utf-8?B?dCtTeFNYZmNxekQ0YmZLcENjRm14eUxZMkZTRXBuczJCbGJkQXVVTU1Jd0pk?=
 =?utf-8?B?aGUvSTlrL1hmWVFxdDI1SS9YaVhYRGQzNGFEZDNRQ0lIaCtSUUVFcFI5clhQ?=
 =?utf-8?B?NUVnNFFNOVh4dEZlcUw5eHgvNzFwWkVKY240Tzd3TmgxWVJINHN0aDFXWm1p?=
 =?utf-8?B?cXlRR1FiVEFFYk5TWlhyVFd0Tk9VOVh5Vy83MUdFajFDcE9CUGFEOFZRVnp4?=
 =?utf-8?B?N254U3A2ZkpleHl6bFJwNFluenN5bmdBK3BLQUZpNzBVcFBPWVlwUXFYMmcy?=
 =?utf-8?B?NXJsM2Y1UVp0NFVhcFpPSEs4ZGswd1I2cVJpa1dIL1BCU1kyMndrNGJTcXQw?=
 =?utf-8?B?RWlWTGN4TTUxek11MlQycmpMWmJwRjdXKzJ6c3Vways3UXhVN1hRWGxleEhC?=
 =?utf-8?B?UmRUZWwrSHpSUDlUSk8rZE1NTG9UcUYvSHgybmxvSGFLNk1IcVdFUGNzTVUr?=
 =?utf-8?B?Zk1CYVdUR2I3dUEwYXducDVjN2tFV0J2anNsbUJ4UGZkQ0EyTmpHQmtHVkRK?=
 =?utf-8?B?ZkN5NWNuK2l4Y2daT21ZVjlGdGJhWTVKK1JWSDgrbVI3VGpGb3NsdEQxWWt5?=
 =?utf-8?B?NHRyZE9SZ1FKMU9NM2hMNjh5ZkhKOENtRHRQcDg5UTNHUUJYY0VlZTc4TWw4?=
 =?utf-8?B?eFdmMGJRUkE5S1N3VTJmL3c0cUloNjdNQjJjN3FqcFl4YXJoN2ZLM1JCN2pN?=
 =?utf-8?B?OTcwY1k1MzI0aEMvUVYwYWpFaWlUWTNXdVV1WXVISW96cmlTV1J0eWl3SWVh?=
 =?utf-8?B?dTJlSXcwaDZSSmlESFRqOTV0QjNSb0RyczZUQzUxeTFoQm80R3c4bHVQOS9Q?=
 =?utf-8?B?M2Z5eGZRcTFMRzV3TzlQZk12UGlBZ1lGQnlkNWRpZ244VEhVbno0SUR3Ui9z?=
 =?utf-8?B?WXpoUzlEbDA5NEpqSlY0ODJadkh2VTFON245RzFqM08wNVMvb3kxU01oZEJ1?=
 =?utf-8?B?T3ZsQ2xSUk9hMnMrL2lHdXpGQzlwYWxBZ3M5a05JL0lBRDJ1b3lYUmszdW41?=
 =?utf-8?B?WkxLZWR4d25RSktueHJhc1BtOVUvN0dPWEx1WWQzUEtiWUd5VlJBVERmOTZE?=
 =?utf-8?B?bjh2OHZzb2FZMUo5eERPdmR0RE8vQ3Z4V0dHdlhjbUY4UFloV0xFdWdLYktH?=
 =?utf-8?B?OHllcWJiVUJrRGJLMnEzaCtWeVFmeGlIcHpHRis5RUxldFRmcXVkSEZXa084?=
 =?utf-8?B?Mk5yZG8rZEdRbFgzNUtURWFkYTEwZ2hmNzA1MG04eWJWV25JZGhoVEdBelBT?=
 =?utf-8?B?SmZDZWgrVTdNdng4WmNlc25pS0I5ODV4RDQ0VVkwU1RHaUdPT1hJV0xTWUsy?=
 =?utf-8?B?R1VIbVFlRkY5N2VETWErNWlibjlwTkFXQmZrTThlNEhRL1FMOXYxMmczM1lN?=
 =?utf-8?B?T2FBcG9WSjdWWEM0Q1M3QXlMRlIzaFJyOFZpMlVPcTlOYTZITXN1Z0NERVll?=
 =?utf-8?B?STk5d0ZpQUdsYXpWaC9EN0JLT1NZSzRtQ01SSXg4VEJDWnQ0T3g3U1pMd0xG?=
 =?utf-8?B?cnRpd2EreUUzNlROYnVRNnkxenBXRFo1ZU44YTVnTGhrZFM1VjNJcXQrcSsy?=
 =?utf-8?B?OVU4a2tGb1JWSjdSWldIb1A2Y2hPZU9mQUpxdDNseTlOMjFqRFZDOVByZDFS?=
 =?utf-8?B?VTJuZUc5MlBNS1A0MVkxclM3YVliQzBLYk1QbEtOcWVSZDhjTVNKZFd3Q0xQ?=
 =?utf-8?B?cVdCOUF3MHc1ZjJlYUFYR0ZoRnJaMkQ1dHB6TWMxTFAzcVpZNlA0b1JiWGFK?=
 =?utf-8?B?Q2RvSk5MN1pZcmk0eVI4QnJmcURkcW1LUmhYY0xtTVhQeU9xV1pLRFBOZ0Er?=
 =?utf-8?B?TVBvZElrZFNmUDBxZ1lFVm02aFBabkNmU2tvNVhUMGcyb2tiUCsxMmVTZ2Jr?=
 =?utf-8?B?cjFYYXhMdnN2d29OdU84c2Fwdm5idko1T1o1NzJwK0FsZUNkTk5JRGJhOEFP?=
 =?utf-8?B?cDdrNjNEa1I5YWM1VHZxQXZBWUw0UVVoR2NGUWkrMU5odkVENm1IektvSWdz?=
 =?utf-8?B?Z2ZUaDhtbFlZSTFrTG8rSDBDa2NsMjgwYnU3bDQ1SGowdUExTVNZRHRYZGZW?=
 =?utf-8?Q?bowi6uyD/oq9gpl2AOFFctWg6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f5afe3-76f6-4b8e-5e07-08dbf1560d34
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 03:40:09.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ei111plG9vGR44NBEkyo2z7Frcx2A/nNijYGzfRsfHrZjEdjmnl4eVdLdlrdwXGqKQFbdapXmLVNGJ4YyuEBPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/30 11:29, Matthew Wilcox 写道:
> On Thu, Nov 30, 2023 at 09:56:59AM +0800, zhiguojiang wrote:
>>>> -		 * If kswapd scans pages marked for immediate
>>>> +		 * If kswapd scans massive pages marked for immediate
>>> I don't understand why you've added the word "massive".  Do you mean
>>> that the pages are large, or that kswapd has scanned a lot of pages?
>> The added "massive" means that there are a large number of pages marked for
>> immediate reclaim on evictable LRUs.
> Then the word "many" communicates your meaning better.  "massive" would
> mean that each page is very big, while "many" means that there are a
> lot of pages.
>
> It was foolish to send out a v2 so swiftly.  Best wait for someone who's
> familiar with this code to respond to it now that you've clarified what
> you were doing.
Thanks for you suggestions, I will update the newer version patch later.

