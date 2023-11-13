Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9E7E93DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjKMBFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKMBFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:05:03 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C011BC0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:04:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+5AtjmNXvcHXDJIQ4pGWjVGcuR9Mnenmf890/P38Xgc9tw0/P+1q61OLRLVgLwoGMNTceY9uh26nuJ1lH0umg4yKtefPXsG62/n+ahx/CWDKfdogmiBrMmwlBE/9cHE4t2i9t5RvCypNFBGsMdLBf0f0xNdHyedH+HMK8fFYHFHj7yVjXs0EovGL4Wv2fASkhPuyC6MkT0hYxbKASXpGr5gZOHMXy9vGrpYVl0mzYiJySeCaIwXyg9T4KsjyE0LQdzUiz8Mf1MCck95KYK/vgSLXKu34g9tNXgTGpnZrfab+hsd16s/ZJKdoGDXej9k7j0+cUtxi+YEim5Y6MPGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La5fEWIw+hFWkQDndzVcirIBF9c1GOrrlQpKtaE1nxE=;
 b=JuEIDL5ihHcuE8jxkPUvqh2VQoPjhWQH3X0BpOHwzdYZzJKf8rqKYTSrjuYkn52ryCvz20nZ2SWd5c1nUhx7suycgcZscvpz7lNLPOBCGYNRP3IU9Dnkg/BRodfHGGw5X7EIb/IPAcFKNiS5Hv46Wj7hgzu7FCRTIFzzif5l5LsGHdTqzacwn2UAv2Gowr6TsDRUOONchwe2SQK5+3Mliy2bITJmZKb48XH8fxMQOpQe2HwXcttFNgoSGtqkWVA0FRuXTvpdDPNISCvzqGXlUHLqAmoyyyo6JjoVPH9bg/TM81jha70Ck2fZXhLlpH8xVBdZ1cOOQ9hXm7g3TSsYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La5fEWIw+hFWkQDndzVcirIBF9c1GOrrlQpKtaE1nxE=;
 b=W6CVgL1YF7xnGqgs1bAe3Vc9PXqe7IKDeRb2ePOM1z+chGDJYC9HEjp5Rmh7wUwXdSQCk/DcS+761NG/alg979thudXPxYdp+85jnmeaNKBdlymKPQSAb3yNqyMzilT7DOxLWUAnuOhhtzjdjE/64NVLCYc2cI8mZvGotgtSfmg+q1KTPI5hO790U7WrowXzWCRniqXKRG68P4XgA2gLWcJBKHvsJ6Lm699hJ1D42yHOO+NdLr5GYtNOqULsbseusSead7ovd1znsyoUJqqf8Pf8TS37Z2J5phFAMyL0u+UEUQeWrSfraeOXTa+pYbVsQ4dZn8bdJGNSvEmFaTx8RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB6287.apcprd06.prod.outlook.com (2603:1096:101:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 13 Nov
 2023 01:04:53 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.6954.027; Mon, 13 Nov 2023
 01:04:53 +0000
Message-ID: <4911abfc-081f-4d3f-aa15-73c617a81c36@vivo.com>
Date:   Mon, 13 Nov 2023 09:04:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: ALLOC_HIGHATOMIC flag allocation issue
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
References: <20231109073133.792-1-justinjiang@vivo.com>
 <20231109073133.792-2-justinjiang@vivo.com>
 <20231109094954.dd4b2a5b1f5dfcc9a721edba@linux-foundation.org>
 <ZU8eRWQvk/Mm4VHO@casper.infradead.org>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZU8eRWQvk/Mm4VHO@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: b13d33b6-8d60-496f-fbd6-08dbe3e48b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZ4wN0SWvFcc4qHoltzgBYHfhyjvLM/ThsuN/o1FYINYT3nCTQ8tyU73HAoZ1/MUrG3p4ab5G+oPjx2fQ+OLTTwsNu30yY8qtpsk82gV4zE2G/STuf5wtDxRaBCzk1XmbG5A0n8UMYiZKN4macwN6P/bYEqhF8FONQb4ZR1CNzC3b+U1qnSk+AO7Uht8HNrlpgXeDRktZRc5w2OuU5EQhHFXLDBo8M62Y9apJSe0+AjhqXfpNzQjFodqMYiqabb0PsOM4ZCDTaIcHlf+8GgDz04k/d8uLopAUyh1FEnm8KCVjG/YYV60sFEuS+nP5gZc7Hq/EWJvnMQG/iJk7JYSbAAvNVB9jy7DOn8QuGFI9ULrYhDdKg/ClL7SgiBOWcGp9i874N7KD5yRP8mtIFOZl1M3stu/h+esXTwD17X+OLS7ZHbyI+AjV6KRvMY7JzOrnIzdA84gm9wEuafzxZAnCpWAb+6TUTDD5sr8BSbV0I7ClSJT3HBK2GrZldySeDkJ2UVH9feYx5pwM1jHsPwygKFSJXpJs3oeJGa3Np9axZwHZLrjHja5Kyw26BRlOxw2H5TQz5IrTE3HG20MuOTdCB9n6Ps4hJMW7T5A4jVXh5YH4CeDib5A4vnYstAScciVjjs7v32udZz1cfstsh8zHfEJEVSpSja6IXmpTwndl6TGy4UzHS2LeCNqtgXYEuS6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39850400004)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(4326008)(8676002)(41300700001)(36756003)(2906002)(5660300002)(31696002)(8936002)(38100700002)(6512007)(6486002)(66556008)(966005)(66476007)(31686004)(4744005)(316002)(66946007)(2616005)(107886003)(38350700005)(86362001)(26005)(52116002)(110136005)(6506007)(83380400001)(478600001)(6666004)(43062005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1lOZFNNY0FSR0JJb3loejZLN0Q5T3R3amo3bGlVcFhSR0ppN29BRzY2VTFy?=
 =?utf-8?B?WnZUMk5vUlZJMXhoY0JXdkVyRlMxMXRiK3d5cTROQWRiUTk3aURlbWd6dkJV?=
 =?utf-8?B?Y1NmSDdoZHJ4TkdURDAxTktrT1ZCeU9HRnpwSUN5eGloV0ZtcmhzelZabjBy?=
 =?utf-8?B?dDV3TnNYaDc1MTNBeFg1K2FDdXNvemtVRGsvd2MxczVSU0dnVUJlNm1pbUFM?=
 =?utf-8?B?SWRyVnM1bXc3eGIyeVhkdUhnL3Y2d0I5RzRwb0xQcTA2ZlN6eFpYdGsyWTBl?=
 =?utf-8?B?Y01ZRkVBTTA2NkJVM0JyZnJoNHE0NVBMVHJCblliZVlsVjJzS2RkRG41cWFY?=
 =?utf-8?B?TE40MzVDUXI2c1lGd0lvcHJkNjVTUThTa1VYTHBnY3A2ME5Yd0xoN1l1M3NP?=
 =?utf-8?B?bERlVVNlYnVHRmtJTGFGMTVIbU5Pci85OWZGeGlzYWl5ODN5VDFieXFzNFdH?=
 =?utf-8?B?STVHZW1EVVg2QjcwdElna0p0SnFqWGhJdzdYdExhTVF3QVRLT1dZdUV2dnFi?=
 =?utf-8?B?M3NINk5FZVUzU29kMmhRbGs0MFJGMzBhcm0wK2pkY3g2VEJPSVRNVm5TM2lp?=
 =?utf-8?B?b3NzSnJ6bUxSQi9aYU9hOGRzbFFQVDFOTUM3bmRHMFVoeVhMTEh6d0JFalN1?=
 =?utf-8?B?ZTNPOGtBNTdMamVjeUJiMUdOdll0TVE4R0Q5SHFFbkhIem8rbDVISnBBeVo0?=
 =?utf-8?B?bWZjODBNOGE0Yi83SDFqRFFqa0NRYkdSMkQzQjd4elF5TTVIZThYamdMZFhp?=
 =?utf-8?B?SmxzUElWY0Q5UGdCNk9kaDNkUitqNTFHMTYvOUdSa1hGejJwUVYxNXJMY3Zw?=
 =?utf-8?B?bmdnUXlxL2tPM210VVA3b1RCL1Zvb2kwazF0ZkFsS1VRSmFHcVcxN1lDNzhl?=
 =?utf-8?B?Z05xYkg4SnhmVDlsQ0o0dThWZ3pseVhlZG0zTEM3NjJzSEVoSkFma0RhMlpM?=
 =?utf-8?B?T3liT1VnMzlpTTZBSVBGdDdVdFE0clJ4RXNFcFRzalkvV3ZaNjloSm1jUCtH?=
 =?utf-8?B?ZERtTzhQdTJSMDZ4S1FqMjNOOFNndkZRWTJOWThycTJNMk1TaUxlWWtGdHJV?=
 =?utf-8?B?S0tHbWdPUHhDMzRzRUZWK0dhTXgzaE8zRmpSMFNJeEZFVUwydTk5UHR1VTdU?=
 =?utf-8?B?d3Vzc2drWjhwcDZJbjBZYW1VOGlYWkp5K3ZRQnVXcWttb25DKy9SL3prYXVD?=
 =?utf-8?B?eFhDS1FFZkJxUnpsZHJmazlTaTlKaWxGM21BMXduSnlveGY4dEhwa2tjQ2xv?=
 =?utf-8?B?QSt1WURsNmxRb24wMURuamY5V3FqNGxWSVcrVmVmVFdhb1hFUGo4czBUQVUz?=
 =?utf-8?B?YUsrRmpPeEpTMm5lZ1RtUVB5MWxKcUZMNGhZcWZRQ1M0ekMwWDFjcmd0NnZO?=
 =?utf-8?B?ZVBNV2FiR1ZpN0h5ZUhUclQ0MkV0NjVTRTRIZXBOcE9VTDVGSndCcFJMV0Nw?=
 =?utf-8?B?aW1pR2I3dER2a1E2SUUrbnAvWW1yaFA2RjFWeGFEZUNFWW4xSm5FYk5yRkJU?=
 =?utf-8?B?dEZFdlhXYlZidkwvTkw3NVZLaDZxa0dQYnNUMjZWajJmeVFJcEZoRkYyNFc4?=
 =?utf-8?B?RldGMTNaRGVwREVaWktIM1dweVVlbk9TcFhzT0k1SC9pa0tQSnJpQmpHM1dU?=
 =?utf-8?B?YzlVVTlMY2cyczRIL3ZPd1F6VHBqVEFwSE1qZXg0MndyK2NDdlM1dUZzZkJx?=
 =?utf-8?B?MitEd3lNMStOYTc3YzJLYXllRFhhNVRRSEpqRkw4QTI2NWhibzlUcm40UXo3?=
 =?utf-8?B?SU85WGJNdXpKaWxUVTNSSlRlTkNyQU9nTXJkNGZrNHlnczFxVm5jSW5zR0or?=
 =?utf-8?B?b1N5d2xnSVgrM2ExWFJKSnp4ek1uOFBPRDNzbURNSGIxWnFxck85OHFobDZu?=
 =?utf-8?B?dmd5VE53RnZYZmRDeitCcVUrSnB3Z3BUNDA3c2NKczZmZFdia2EvOTZ6VC8v?=
 =?utf-8?B?Tk1nUUoyTmY3RWhibEFvak56SkMzVGFVNXR2YjhpZ21lRExPdUVuM1lUbm81?=
 =?utf-8?B?azFuYUE1NXVhWjhteWwwanh1WTlTSzdjMUd0ZnhqN0dQbE5wK1oyc3ErMnJ2?=
 =?utf-8?B?SjB1dlgwaUo0WVUrSkdDMkZrVFphTkRoekJ5Y2hMUE5UNGtzd2ovV1ZSWGhw?=
 =?utf-8?Q?U5N9X6OcfZQAK/wkTJrziEB0u?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13d33b6-8d60-496f-fbd6-08dbe3e48b54
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 01:04:53.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RFvfH+OQoqTK9XNPGk0d9lGCiUiCqzjIFy0dXO7k+T1FqalsSelAT9IjbSjQfUN9R6O+qlxpFMaihaYD7S6Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/11 14:25, Matthew Wilcox 写道:
> On Thu, Nov 09, 2023 at 09:49:54AM -0800, Andrew Morton wrote:
>> On Thu,  9 Nov 2023 15:31:33 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>>
>>> Add a new bool* argument to pass return flag instead of *alloc_flags
>>> and add the related comments.
>> Please retain (and update) the changelog with each version of a patch.
>>
>> For reviewers (please), here's the v1 changelog:
> This patch isn't diffed against the current tree.  It can't be reviewed.
patch v1:
https://lore.kernel.org/all/20231108065408.1861-1-justinjiang@vivo.com/
patch v2:
https://lore.kernel.org/all/20231109073133.792-2-justinjiang@vivo.com/
patch v3:
https://lore.kernel.org/all/20231110020840.1031-1-justinjiang@vivo.com/


>

