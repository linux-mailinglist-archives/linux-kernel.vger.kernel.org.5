Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A120B77D4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbjHOUuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbjHOUuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:50:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1DE26A8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCkhxGAWv9UDLeQYppO4YGg/XQN+JZPUH+vzaKqum+uLWx+G2i6qcuZXtKkAr4L+TuDpXYjnjbPms4pk561TTAcSAZ8s9NijKiP/Rx0VmWV9mCsZpIUUYtSu11kbmoCLZzOWjuKlTbtIjcRQjZ4r7IHL3zMgH7EP1HxLe/LayNk2rgZH6ejf+3loFdybxU5nVO0lQzv3xNmtYNzTGaOx9R32a/c/NOZKEKQFdw25i4o1nwDXikjTNzkVwtYARkpAG0ckq2ftZQLhroG3X0E5UWNZzuOTMYzZgVSyy13dmosJbFrwnH1+WCKXs/e4BfzC+ZcRpxnmULv1gttOacF9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBK00EXEN8ECZqjMObZqrkx1ETRoBQABIoELYgRb9UM=;
 b=O6a324r6E+0TRKh7v+eAsgnxLgqdBaMtjTqxvQ9nvvGYbjPDnZLseRugDanyxaKhZZnxgAE58Fn4vi59CVYHIVeb/RBsp2btYDxgm3pwHeUI3ymxdfuzMZCKCo3qphDgUpgSVA0RPcjvCAxpwdivBkew7yw2zL1VpNP8wAtJa7+6KbErGpDxW4N+3Stm7c/spbUR9orYidtdDUdtyr2KWN2vjtrYjhUHOuvAdtopm+37Q8UdKvOL1NrcCTPYKmFbsz9FSggJ01pAXFIHE41N3h/mp3lgEGXeM1qjQFepvYbaLFGQQUUSrcyJJ1sIQZ8f5YsIsfYJSaIhcySTulAhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBK00EXEN8ECZqjMObZqrkx1ETRoBQABIoELYgRb9UM=;
 b=RWrgbkNXL8MF2NzZ4ZC0RzFdHaj6/2tPGZcpWK2aABKvx8RQCIJkuxaQiXCWVltOWmunVXCdegDK9H7Ceq4kDQd1hnTvx6icXcD6aRwBgtFiqJ6jAWbpGZpfSDHlVLQeVDnBivlJqEjE02J5+g+VsrVTFjIsZcsdkNRU3Wbhs5Lo8dd5SnaY8OYY6EwQqL3JbJ1GoU/CfDmUx++yBKt3ML4py6dy6QRVjA0PgCdUujvK1qazIvAqw7tuEdaRRBXoJYfnHUHFYJ7HawvHuAxkt5VIz72YX2P4BUpkuSxi3LNKiTWPCWg3K5kF4hKDoi8UPYyIjqYR2jwHc23uInHIlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DU0PR04MB9323.eurprd04.prod.outlook.com (2603:10a6:10:356::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 20:49:20 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 20:49:20 +0000
Message-ID: <78fc3de7-9e7c-3fd0-e7d3-c94a3cc1df02@suse.com>
Date:   Tue, 15 Aug 2023 23:49:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230814121149.176244760@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0205.eurprd08.prod.outlook.com
 (2603:10a6:802:15::14) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DU0PR04MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d157e0-3e9d-4313-aa5a-08db9dd118f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0c79LnYjDsUhV4FCwPcADJ9DC/i9MRty1SN6FvCPtmRrP6Zljv04plQYk02+U91HTs3hVtfQRFGlQtMZRPuipxen2DQ6Zz+gVdshE6KrtlX/SUp8qehxiD3s08A4HUJSzu6RhrfemfYP5Lzhva+a1W3eny2KkuGzLBoi9iZ8fGNe0tRiJ/pDVh173xA9J/CE3Jvb+H5V2Bf2vuMWuNxhdp/oR6A3+CKSjtsK7D294rBnVRnVlepDmvPACsMEuTRMtC+Q2/fq6gUU66t+GFUXizLKgw0L7dwA2uVN07gF/LePYrPYG5MgoWz8msOuYQhsBTcWSUXiULDLnNJ2BwSl501Ie2dpcJZV7GW5kPEOqzTUORparea07Vm9LoTTRrQA4SgXX2C1K5xMLQRRUwTTvs5P8wiYgboifBVqZWogXQV12YYFGajhqaAnJDCyFXJkH/r7Liw7AKdY05iC8IeFFCrmGskT3O5nw1RweNdjPG466OvmEJ6u7vFiw+JweJT0PJlvzEiRqwYVmtEtf10FFNXPI2edXOGm6BW+fNYu63ND04eEEIDNR6DFaRH6gzZeKX3T9APARWBJXThafwhE7NEqjKMCMMp0fY/exRF+iM1QQjm+o9FS8wsvjcssqeGO6VRAzlDSOy4sCHyNlDAuCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(1800799009)(186009)(451199024)(36756003)(66476007)(66946007)(31696002)(41300700001)(4326008)(86362001)(66556008)(8676002)(6512007)(6486002)(8936002)(26005)(6666004)(6506007)(5660300002)(2616005)(2906002)(31686004)(316002)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emIxMFpZY3NQMCtSWHJuRXFSeHdDRlVRSXBTWWRyMTV4a3pGOHdYQ3c5UmMy?=
 =?utf-8?B?R2xLR2hiV1dHSEEwa25RMXNoWEdlNkhmMXRrTGRNd1FERzcxQXRHUWV4RkRv?=
 =?utf-8?B?R3l3dzFaVHdMMjJDTndUa2hIa044VUJ5eHpwUzl6K2l0cDYvM2Z6NUVFNVhF?=
 =?utf-8?B?d0RBWTAvK010OFplbHZJY0g3c2JZcFlOTE1nUkpWbjF6a0xBazI5TURWZDBz?=
 =?utf-8?B?SzF4V1cyT1ZKamlPTDd1ZG5NMklwU3Nra3VHTTA3YmdTTWIySnA5SXltUWg5?=
 =?utf-8?B?S3k5MUlrNHllOVhqb2U1dC9PcWRNeHNOODhMMkd0R2FkYVhTZU44Zm9ZSzJi?=
 =?utf-8?B?b0xiS2NSR1pSd1cxaGtDSFdnaHRJNHdya1Bwb1JMZ3JpU25oWDdMS2tQbkJZ?=
 =?utf-8?B?cHNWZzFFWTFod2ZiKzVxQWVzS0xxWXduZ3BSTUd5bmd2QXZBR2sycVFpQVhY?=
 =?utf-8?B?YmlyaS9ML0prWlExTGQyZkxpU3A2TFA3dDdVekIvblFYSU0xMjBOY3V5SGpD?=
 =?utf-8?B?RE1EbnRUTkNyMmpTSUExdm5sQjYrdTJvM3RuNmRxcmxiSlArcWJ5VW5lN0gy?=
 =?utf-8?B?UTdKWFFwYXFHVEEwM29aVndUMEo4aEJsUzJsL1F4Z1lUSnlSYmtWUFh1MWd6?=
 =?utf-8?B?cmdxN1UwWHRxcXRyQWU4bGFwNmM2SjJvb1BZZHZJNnl0ZGVQdmRYdm56a0lU?=
 =?utf-8?B?TFRJN0ZjT1ZtMDlJdkxkUDZqdDZUajZoMjhEcWsxbitYSHdtejJaeWY4SUp4?=
 =?utf-8?B?dUszenBmQTM4azltRjVNcDA0Uml4d3FDbWNLbGlBdyt1bEE4dy9kTFBGUHZ6?=
 =?utf-8?B?TTk5REdPYitDd2RrdVArVjFFcGhzSFVFOS90YzU0L0Mvdk05ZVV1dUMxakJI?=
 =?utf-8?B?QVRGaDh4SFFVSGkyZDhZbjc4Yktpc2o2dUxVYTNWTDdjNllDRXpZaVdZVkQv?=
 =?utf-8?B?allpT3dvNkF5ci9QK0NZOFdMWk9VNE1YWGI0TTgyUko1dzdZQUhUdEtFaVpH?=
 =?utf-8?B?b00zNmVMS3F3VUEvVWMwZXdXbVdZZTUxQWU1czMzZFNkN1hrSStpenJ2K2hr?=
 =?utf-8?B?U2xnU21Cd3hKK2JjVXhKSTlUcnBGWFc2SEgyUkJjQlJyYUpuM2JndWhTMVU2?=
 =?utf-8?B?THVYTDB2OXNiV3ZEQmw0NGFMNm5ZeFg5akdmb0lwVzh6QmJMeGdHcDVDZHJD?=
 =?utf-8?B?dFJJbE13amVic1Q3bGNNWGZiaE85YUlVK0lldTZTSDBra3AxeUtmWGl2aFBC?=
 =?utf-8?B?VVJvV1doU01xaDEvaFpxcFlzTStTQzdoN1U4dnRhaDh1Y1BGaW5UeHRJa2g2?=
 =?utf-8?B?SC9aazREZnU0NG1zN2tNZWlQcnpyeVp0dXFROTZOSXQyQUN5Y1FkUFExVVRF?=
 =?utf-8?B?Y1ZHOHpvNGRpVGI2OGF3N0s5b3NzSXBLYmhqWlM3WWQ4Um14WnN2SWpUV1hT?=
 =?utf-8?B?clA2L0VJUE5IczF2V0QwaWFEUkg2eThodUcwTmRIS0ZpRFlaWmdvSml5cGIw?=
 =?utf-8?B?VmlVSXBmUVBhek01TDlHaHdXd0Q2eWVMeEJqL05ZcEZPdTUzOGZkT0p6NWlw?=
 =?utf-8?B?bEZlU2RYVjJuQ1ZHalRUdHplSkF6ZEYyem1rWXYzbDZ6Vnc4cjlTT0NZVG5U?=
 =?utf-8?B?TWhvNEwyL3NmSmZ6K0tCdE1ZWDJydDRNVUVCUXIxQk1zc3JZcmczejc3VWNR?=
 =?utf-8?B?R2V5NUJrRVZEekc2TmRUL2RsR0d0NWRaOWVyYU1aNmxpa3N2QkRJMi9WQ1k0?=
 =?utf-8?B?KzlTV3FGZnkyUEY4dzFsUElRaTFmZ09Ic1QxVmR2UlU3UmtQbFltWi9IZDhI?=
 =?utf-8?B?SjZON2RLNnpkRjBHaHo2WWJlWWwxWFVSTzlHYkZXZXBEUWVkZXVOeGF5NVB5?=
 =?utf-8?B?cVl0bUFwVkNqYjM5K3N4Wmx1ZlpFYUdlVjJIRzhIalBUakp0QjB1YUZyOWNN?=
 =?utf-8?B?V0NiUXpYTzFacGJiYmZFbXFTYU5ucjJDMDNDa1FPYWx6ck1oUnZXODVOVmQw?=
 =?utf-8?B?NjBtQnoySU4xNytKQkZLRXdRQkNuUDFkWlp4K0hXL1JCbWttc0prYU9VWHVP?=
 =?utf-8?B?b1p1dlR6anEvaThMdzd6azNBcFZOMjBDRkY4L2ZnT0NCRmZibmJnTXRDb3Ji?=
 =?utf-8?Q?S2+UHiPsxxnueEpIRK2fSGVxX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d157e0-3e9d-4313-aa5a-08db9dd118f8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 20:49:19.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nj3s2JEhm4mIF+rajTcCrvapaB/wdeVHQ7Cnv02BWkqwiraBjBhs8R13qIDUqs3ZDgOPQIL/UNCtZdkdujwdxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9323
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.08.23 г. 14:44 ч., Peter Zijlstra wrote:
> Instead of making increasingly complicated ALTERNATIVE_n()
> implementations, use a nested alternative expression.
> 
> The only difference between:
> 
>    ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)
> 
> and
> 
>    ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),
>                newinst2, flag2)
> 
> is that the outer alternative can add additional padding when the
> inner alternative is the shorter one, which then results in
> alt_instr::instrlen being inconsistent.
> 
> However, this is easily remedied since the alt_instr entries will be
> consecutive and it is trivial to compute the max(alt_instr::instrlen)
> at runtime while patching.
> 
> Specifically, after this patch the ALTERNATIVE_2 macro, after CPP
> expansion (and manual layout), looks like this:
> 
>    .macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
>     140:
> 
>       140: \oldinstr ;
>       141: .skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90 ;
>       142: .pushsection .altinstructions,"a" ;
> 	  altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f ;
> 	  .popsection ; .pushsection .altinstr_replacement,"ax" ;
>       143: \newinstr1 ;
>       144: .popsection ; ;
> 
>     141: .skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90 ;
>     142: .pushsection .altinstructions,"a" ;
> 	altinstr_entry 140b,143f,\ft_flags2,142b-140b,144f-143f ;
> 	.popsection ;
> 	.pushsection .altinstr_replacement,"ax" ;
>     143: \newinstr2 ;
>     144: .popsection ;
>    .endm
> 
> The only label that is ambiguous is 140, however they all reference
> the same spot, so that doesn't matter.
> 
> NOTE: obviously only @oldinstr may be an alternative; making @newinstr
> an alternative would mean patching .altinstr_replacement which very
> likely isn't what is intended, also the labels will be confused in
> that case.
> 

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Ps. I feel very "enlightened" knowing that GAS uses -1 to represent true 
...
