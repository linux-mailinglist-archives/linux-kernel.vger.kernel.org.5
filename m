Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E126577590B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjHIK51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjHIK5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:57:07 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB692108
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAUkSTnOHjZL+65XTc4NzfoJdXC/iVyhd0XrffNYtR6U13e4UH2GT4/vat9cBTKy7yFKD/f61ki0cV+k6YLdX9Xt8auMZMz0BgI9Vr3aV96vPQDvTE01AfiTJiZ7aNcrQ+ry9wRbgMc57rL0qO6TeBltpQ+cJ6de0cQcjUiATgVCMCS2CsiZFTzUlbJx/AUPjUkvjteHV8uOAZY3p4wLkBRVvrJvLoONNgSBOKt5yKhOtIgIOMVfZ+gm/W+ZHQaF47bY10I6UDqzNVwLG6OmLsQ+gCP7BnLBW2NAr1dRgAAKwyaYkntXPmPdzIfehyuv+kPLIdLpXJB+aO+gd0sKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0kQXRQ2qdbtMRNblJpk5vxi3CpBmsy8Mcm1XXk6GPk=;
 b=jzRybF6Xv/45th7oe4JH4U1Dyz0cyPOVzdUm8ERLQyUSqzB0H7HNvcHUmOHLqnL1lSTVVzU+eLQUALFlILIQ9U3QAROuuahXyDRYDlU9+RpSSAoxfNhX999/eX0lbt7Z/71hVfWqS4mlr9+6RMlP8wmUIPkBqPP/vxh2zoWFl1VBpcQUJpGbVMaDL1GuE4p8jOxHLgZxssuRCsg+Zc7ehqiFkzIontRSOkxI8LokHCR4mpjO2rXqFelPL7ayidoeX1LhJVg25n5nG2CyZ67HJ4Sz6+B+oR4dxcgmWHPVtdQxz6EH2u9nK7v9uzioXdyaerqSOVUyvnHGTbgqh9tUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0kQXRQ2qdbtMRNblJpk5vxi3CpBmsy8Mcm1XXk6GPk=;
 b=jnk+HjZuA6oIvphjLwZBqRGSHWq5SMPtrJx7gXBOnr4xSXYw7jDYTVwU5c8w1Ve1XIPJeMOrxrEw0AuCo3oEEvDl50KA0wRn598xOFC6hxiMrfhWbHL+dLMnazfhhfZf5xK65MV1Kh8DC5/OslcThJL08/sy2rmw5hwHxvbw2/LuZmhMUEdpN7b5gDNTBxZPqRPpL6qTaXwAIUlBJJ9stpRaUe6MLaKEruyrgH0l6PD5D7LBIPlNPhhvXHQt2ahhwXV6jpPcwjOpG/J8dIDJd6PweqPDaoMpTi76Bg6nOXDyMZrrwPwOVOoeaKdnqwwi3p+KCOBjdKYOsPbql1wPXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DU2PR04MB8869.eurprd04.prod.outlook.com (2603:10a6:10:2e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 10:57:01 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 10:57:00 +0000
Message-ID: <a33a3ad2-c809-b99d-dcaa-46ce77e89a90@suse.com>
Date:   Wed, 9 Aug 2023 13:56:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] driver core: cpu: Unify redundant silly stubs
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230809102700.29449-1-bp@alien8.de>
 <20230809102700.29449-3-bp@alien8.de>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230809102700.29449-3-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::35) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DU2PR04MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d26720-5e6f-4c39-eb70-08db98c75b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYm4+ODQaqnaD1P0zpK/sA+IWy7p/h/auxUKSvPUPPqh1m8gCaPs9FIP8seMY6FO5P54HGTR6XDbQctxdDeJax4hBntVQCfbzFrobZrSVqWjAWdu7hiRQezAGLk6qWOVJqE49Zo3iCsXu7U1EkKmTiPXhHbeUVp/6Vc6xPXK8W267cjOq0qUjd9uWfmGc9Sf086WFoZYVHBW85shbYhPlO2Zj2Crhflzl7JakLr3GvH6v+nu3cd8BUG+YVWG4uUQfAqgc7fmS7Y/iqRq1im8od5Ps2QcRfAHfUlxQQ8gQPYgAQ2vEg1H2DnlALa4+gJTryulCxGXH492+1L4/5O5Er9uRMDfYm7yZHD+iv/15IBWMosAP8EZpcTEJD1+Ar1c1o996eBY3j2k9Qlc23STl2BA64CNcSKscYMHmgSsdSYgwz98nGWm8tJexdS4juXRa7mwekgC2dIZ7yhzSLjI+G/fZc/bFo11/bpBWNqMKwjrUbRdehDSWmI9FkzPYAPdmHxcwIJq4kl/6hgc4Uabn7IRlJhMyv7BucLcPNZHodPseN0mMcPHIUmWoH9zZn//EP2s0XPfLbtVcfcjSUNxWLjf3MCCT+KXLdmf33GCZKKomHv/TELf7TLR0bkIkj404xlj4carhuJM9wvXb/RbOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(136003)(39860400002)(1800799006)(186006)(451199021)(26005)(2906002)(31686004)(5660300002)(8676002)(41300700001)(8936002)(4744005)(2616005)(86362001)(54906003)(316002)(6486002)(31696002)(6506007)(110136005)(66476007)(38100700002)(6666004)(66946007)(478600001)(66556008)(4326008)(6512007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nys5UENSbUZsWGpMaUFha09ua0xNdzN1Zm4veDRFNUtyS2dsT2NiVUZFM0tN?=
 =?utf-8?B?VW9DM01ScWIzaGoxNXJJMDdJRmVidHBkVW93dnQwVkY0d3dIS1pqdFhFQkZH?=
 =?utf-8?B?VnJHQUJnWEtEWWJsSVZxd2xYanV1eW5WUEVlRzZwWkovWVR3TmJ4R3plc2g1?=
 =?utf-8?B?U1JIZlgxRUhyRHNuL3RodEljMjRHT1gxR1UzZTdUNjNLVlZNb0pDMWVYb1pM?=
 =?utf-8?B?eFJIdzJwK09uc1Jnd1NmWnI3aG1MOWRiN2V0RDBwbUlkTjNKeU9rcjVkaDdI?=
 =?utf-8?B?dXBzUVZWQjVRRGdabmFub3E4bkxwdENweGdpanpnc1UzMDZPdjkrbHBNbkNZ?=
 =?utf-8?B?bXhacWRxTWU0VjA5R1hrTWwwRHdMZ3grL1lrTG1rbWZBeTRRUTY5dTBkd2py?=
 =?utf-8?B?K21hUmpRaHNXWFFta0pLcnVjNjJLYTdoYWxMU1cycFh0WUxYWW03VmM0b3Uz?=
 =?utf-8?B?UDEybkFQL0FIRWJnd1NQNkpKdVRFS0NMaERTQWR3aGw4RnFhK1drNXp1OW0w?=
 =?utf-8?B?Tks5T3VVbmRkZVdodzA4OHRXQmNGQ0g4VXowcTFkK2pOa0w1RXIyY2RhdWND?=
 =?utf-8?B?OFFjWU8zMW5nbi9kNE5Yc0lFMXlzZktNZDBrak5TTVVXRzBNelRRekI0NkZu?=
 =?utf-8?B?bVhMWFpFU2MzdnZhclNuT2hOT21HaG9UTmovTTlKMVRDWlBrQmlnSGROQitR?=
 =?utf-8?B?S2ZTcGtOdnNhcDltZDdPcXZ3cHRZN2lpOFN4N2JZT2pON25KbTBHcERzQU9U?=
 =?utf-8?B?NnV6VVltRUxKelplMURUOTl3SVVSRWttNktMRy9EOXlDNWNBaDEzUlNIZDlW?=
 =?utf-8?B?U0c5RzZtdEh2TWpoTWNoSzNRaVVEMlp2VmlrNDFtd0RLZ0tTUGtIQlNVVnUv?=
 =?utf-8?B?andpK2M4U042cjdCUGdVZ21pRnRhS1BCRnMwSmIwZGtGSjZSOFMzTGh3SFRR?=
 =?utf-8?B?bWc1ZTBqL2FUQVk2c2V5NlNkVGMrd2xOVGs4RU9CNG9jUVpSUldod21MY24w?=
 =?utf-8?B?T0dPRWxRZmV5b21HRTBPb0R5dW5GTU04R29melhKaXZaTE91NXgxSSt5Zld3?=
 =?utf-8?B?VCtsVDFJV1BSWEVMbHNOYnplV0h1ckoxd2Q0RWl0T0lWd1pVMCt6ZGhrZHdQ?=
 =?utf-8?B?UmFlL3dmR0YwS05lc01CZUF5cnVnS0t4b2Mzdk1vK2JSV3h0azl4VUZlWGN1?=
 =?utf-8?B?VWZhdENiSmFXM0VxSWhxSkgzUElvcGxZNW41VFRFYVloY2JGVTZJMkpkVW5K?=
 =?utf-8?B?eENIQ1JQc0ZOV3NaNjF3OXJoNEJieW0wdDdLbzNyQTZ3aU0vZUtDazYvQkdU?=
 =?utf-8?B?anV1M0x6ZW5OVmZkLy9mbzlHSGVVYVZCSGx2aTlRS1REWWtxbW1kKytEQTJE?=
 =?utf-8?B?Ry9JdzZkRGw5OFlKLzA0ditCOWRHeVJ4elgwak04K0V2RTZxRE5HUS80VlNm?=
 =?utf-8?B?WktwL1RncjFzdnlHK0hMNmV0MGNac00xVlpJcHpyb2YvU2Jobmx4VENsWEph?=
 =?utf-8?B?RTVGK1RvdXEzN2M2L2p0ZXJ5MitBN1Q5dGdWTmw2VmpkUzZOZ3Z3ZllwQXE2?=
 =?utf-8?B?U0VKY3A5T1hPZ2xRUnlEWERSRXRXSWdRdDZzWVo2ekN4NFJzcjFnN25kaGJP?=
 =?utf-8?B?dzk0NzFkK01jbmNSM2FYaTZyci9Sbi92UFZ3c2lldGNkYjlFM2xONnJwdU80?=
 =?utf-8?B?Y0RyWExDNmMxSWoyd09BbHZwN1FwZnlvN1MyMWhDUS96c1RkaldhZzYrUStB?=
 =?utf-8?B?Z25kTjYxK1ArdlBlUERWanlxbVh5T1liU2kyQUEvbmZ1Ui9oaDVxV3UrSDJJ?=
 =?utf-8?B?YUxXV0JLdGVZVExWMFNnTWNiN0piVmR6ZlVmcHdteEtGenN2UENReG9kY1pI?=
 =?utf-8?B?V3ZrOFNFWWVyT3B2TVNUeU1QZnR0d29WT1F3cTJXb1BSTWFNUko5RTgzZmov?=
 =?utf-8?B?R0hzekxUM0M0ckprMjFGdHFnSVFicDR5ZE9hZXJ2NG5vOEV0eTY3Y1hzT2Ev?=
 =?utf-8?B?cU5paVNPYTBsd3FSS05OcTByYmxpRVppZjVMOUpzcnRBZjNaakZ1c3cyZUdr?=
 =?utf-8?B?eno2WUs4ZmgxMkJwa1ZteXZDY1pOS3A2djl3dFM3L09URFlnWWg1OEUrNDVM?=
 =?utf-8?Q?Ir+AG9L+SxBYsgVvzDU1Rz3s1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d26720-5e6f-4c39-eb70-08db98c75b59
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 10:57:00.3972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGLdPvtLasPXB8FjVI2nSTefXiXz80ncV3Y/Ds6JyDc55rG9TQ9hfLREx7figFAyGWCKcY11La4JCgK9cYltsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8869
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.08.23 г. 13:26 ч., Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Make them all a weak function, aliasing to a single function which
> issues the "Not affected" string.
> 
> No functional changes.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
