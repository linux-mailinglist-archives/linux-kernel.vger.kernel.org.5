Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC9D775615
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjHIJE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjHIJEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:04:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03C01BD9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLHOZfqcSevt1DvewGT4g/Vdu+2QMkBTzKtGl2x0SjaLzeqxdcZzbG8+ei9nI1B7OwbA/OWvL7kzKMeIuLrr1pODfBPb3/iAWamRtmjJ5OfhVM/5Og+Pa6Jz6iiMFZSYoi6SHlEntYiaXoFa9X1h5LLr4lfcmTbgFuQx8HBowLIZh/BCbgghkoZiwjD48B/23spZmpZ8af70ux7KRd2zk4zKzilwUcfhmKBRKfL/NOwx+3+pjFbNiTyr1W2nf709gHgF1pVvcdlcqUmA+PFEzj/DyEZImnIHKqeZtDQU6s637phcEEBcvh/gaBmi21bWgY2fPYx1B+S1JR02LlCEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2YFIrJUpcq0q/9C64aRMxUkSaRab0ScO0UquMpEwlw=;
 b=BO8OUgz7BjGsXo71pJpi6bJByXOjeseJc8amFVpf7UZf8UEvIP4mKSRFVvNFGjenTSFEaruJyQlnV0/3e/OIelRtXy89Q4hAxRQTmGGBcuk21FSNxvVi1buPa/nFLjvHtr/15yu9IC+dtBNgxPjt8BxXt9Y8ZoHZSZRmL51FjQ0s8IZTPamtXDG3u2HqWf/qNRCL2h0T4gBkRmNV5IwyskzsoSPG42R+M53FVbAtUfSDplcKUwbMOhS7Hy5T7V9aJkYOv/FDoYTDDI7KPMsT3eCB1Ijjr5b5e/rxN+0IsOD2SMKBoLjECR3lsGojHR5O12E+ErdYmmR4JXRh6Pce+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2YFIrJUpcq0q/9C64aRMxUkSaRab0ScO0UquMpEwlw=;
 b=YulkepGGw5Luqzlzy9xQRwQ7jPiq9a7GmWWfK+nopDksXqvewU/Idon90w1d+1PgWq+Shv24XUTSZ/yvcjYMfyUpcV8IFpdGjve+Y3FGQOYsQdis34XulvuhN8SkukRR98LVgTfh393Yp09sp/hxJkWt8Rt6hP0IW/BKLMCB53A1irILXroONZ7iscR26eAj1oBDTBei3VEuCoWq2zNqnnGzsvO6UA+xCzHo0KhnykdRYwmSnZWtYjtMYXjayY2fbAgJmhrzpnQBtq59Ey3wbzZDocjRs6dm5OeO1SZk3BwxuPQj7xHsAeT2XrIp3J8axSbO3Jr/Gr5U7zU21SF8ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DU2PR04MB8791.eurprd04.prod.outlook.com (2603:10a6:10:2e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Wed, 9 Aug
 2023 09:04:20 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 09:04:20 +0000
Message-ID: <e417a89e-15af-e6ed-5df5-382640dd9eeb@suse.com>
Date:   Wed, 9 Aug 2023 12:04:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
References: <20230809071218.000335006@infradead.org>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230809071218.000335006@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0213.eurprd08.prod.outlook.com
 (2603:10a6:802:15::22) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DU2PR04MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 77eb87d3-f013-42ef-5886-08db98b79e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5J8bHERygkFeT5gT8DShdVrIsHNFxjZAPinEuOU9Enx+OWl8kgJH8auOPz+7AwSgp/RmOJz3nZHQw6T/UxrH9vYkKUI4r0rdoDj7suDupJD/KMV/1PxxvLXM/jOdGuBxieaUhgrGiCvfEmzgc3Qt4zHCsrX2qxsZwwIkqkLGr5RNE/JJWU1W5L4Szoeq6ERolaZfb15QoT4my74cXHVmiLFDnJ92+OaUQ2xpTx4V3AOiKBzpmtRSEo9YaEo82SX5ozo1Kz+tTnYs9GbTvbSYcA4BYekIYB/dlPch1iEV5k2ndRquYHpZ9vYmY7Jg6FSTtQFNFWloNv/X4eZP8jHBlMkgdEgbJMhMeQ/FXAkcCsFFBKEpUB2lTgobmRPXYczOdHbuMCIZHaUaoGwwvhaHLR1n0mmTWPjD5Kxf9ZZ+9XOdqN4H0+YvZ6msjlUWiHw87oBlebNR8lTI1wI3TKD2UQl18oVyIZc5Yi1mwW9mAQNBYeEFzbvta74bclX3b3QwHUAjLvUTSUSS/seLaojhajvc7hbIfhqk+n7UTL6G1Np6w0v1QCE+6OmxpTyt355gRpQtl4vARM9aNLz9AOTaN+xwLfLZmA/ZfqZmI7Y4G8emG+FVY+pNNSHIpaWArrOCFuBftwjCaVCNr8sMrGIHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(39860400002)(366004)(1800799006)(186006)(451199021)(6512007)(36756003)(2906002)(2616005)(5660300002)(6666004)(66556008)(6486002)(66946007)(66476007)(4326008)(316002)(31686004)(38100700002)(41300700001)(66899021)(86362001)(31696002)(8936002)(8676002)(6506007)(26005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBTblkxMUd6Ty93elBYZERhYTRteG5ZcFBXYVNsaUVEdTJ3S1lnU2dEbk9C?=
 =?utf-8?B?OEN1d1c4Q2poL0dWa0FXMjhXN0xwTDA3R0NjdlI3WG9KRHVTdjdYcFFOdUVN?=
 =?utf-8?B?N08zcGJhVWpZT3NNMTJYS1JOZVdPUi9oOGxQWjhIaVg0Y0RtOWhENWJGMFQ1?=
 =?utf-8?B?TEZGdmZoUGc0QThaUTV5V20vaUVXa3ZHNHl2UGtYbzA3M0NtN2dWZWlSbnJD?=
 =?utf-8?B?dTU2eE4wMkVKWmdpZGxPVUp1TjVFVjlGOVdpL0VTWVJEQmRwODZUdXpaeVNh?=
 =?utf-8?B?d3JNc1ZKL2ZUK2ZXYWx1YkhvdkpXcUZZZTA2VXd5cWRRV1p1dytMRyt6U1Mx?=
 =?utf-8?B?SFJoRmErellMUGZZRElpNWlQSmRMNStjM2wwTndGWDQrZ0oySDVYRlBHTnp0?=
 =?utf-8?B?cmNEYzV6MU5aNEFQaXpyZml0Wm9jTzl5OVFScnIvRnhqY2dvMm9DYWNPZnpl?=
 =?utf-8?B?eUs2WlNGOFpkeTZFL3JTa215a29CL0psUmN1M2lwZ2FwY3ptb0QrYTZKaFZU?=
 =?utf-8?B?eURCdEVNS3BDSzU1VHhwQ0gyK1BBNmd5WDR6MWJZcjc4TzVmUXNOZlphZVBH?=
 =?utf-8?B?VXgvOVI4SVpGeXFGOHg2NVQyejNqTmNxRStxSDdPZDBVdjlHdEtObUpLaXNv?=
 =?utf-8?B?b1FBcXVOcml6bjl3QThJWW1xWW1BNDJNd3FtMUdlS01NYnVxTFZKc2FzZWJ1?=
 =?utf-8?B?djZ5SURJOXFma1hUVEdpM1p1NEVVcUNlUFVFQ2lpeURESnFJS2ZRUW5nTzZt?=
 =?utf-8?B?MGYzVU5zeVNYVTE3LzRiUytEL0xvVjV4bVQ3SUkwUzlEWFNsRVNlNlNCeDZK?=
 =?utf-8?B?bW95QUl1ak9NL3hySzM5c1lTcXN3clA4T1Z2dGl4SUxIQWp2WEQ2TFJnQkhI?=
 =?utf-8?B?ckZJcWxJSnFnczVFdmxJanF6a1lSOHAzclJjSGZVV0piSFlrL0kvRmo1ZW40?=
 =?utf-8?B?bFJ4MnM4cC9vTDgyc3ZNTU9zOTcwMHFYa2hnbXM2RUl2L1psRXExTjNBemdK?=
 =?utf-8?B?eExCcEZKS2VJbnZwWlh4N09zM1d6c1VPSE13Y2VUWm9kWGlaekZRWXhXcHk5?=
 =?utf-8?B?NTMrNXdscXg2QkUxRUpJTExkNmlPTzB3NG91UDFPTy8rUDBWeDhRQjNFMlkz?=
 =?utf-8?B?UFNiTXdISUhjQm1GWVE3SkF4bXdEckx3REhqM2p5WW5xQjY5dmExaTRBUXVj?=
 =?utf-8?B?NGZmenhJdWFqa2RIcE9BOExuTkg3VEtZUk5TaTFrbDJtcllROUkzTzY4K3dz?=
 =?utf-8?B?NGdSYU9XeUdjRXFiNnRDQi8vUVMwb0pLU0NQTlJ6NDc1dklkbW9BN3luSE9l?=
 =?utf-8?B?eXQ3dnZBTEt3YWRvT21mekxvM05MRWVWMkZETjlTLzJveVM0ejBudDAyMHU2?=
 =?utf-8?B?Y2lyUUtoUGk0VDBpcCs0WVdBVmk3UjRoTzFFMFloenNpekl6RzdBdU81M05z?=
 =?utf-8?B?Z2p5by9ibWhTMWdWbU1UR2cvRWhkb29yZ2htaU5EZW11SkNYS0MwZk1udGhP?=
 =?utf-8?B?OHFXNTlaUCswMXFLU3pKZ2ZGV0xtRllGVFphNXMrSDZ2a3lNWHUybHZmUUlE?=
 =?utf-8?B?a1pxMlhGcWVpOUM1THEyVlNEZStSUTk2YlZlbmRiRjc2b2gxb09qYlpDSGtL?=
 =?utf-8?B?MVRZTjFpeTkxdmhTaW9iWGo4M3Eya0ljNXdzVXhtTUp6dGpsa3kyR2xzZys1?=
 =?utf-8?B?eXpKZkdZUGFldE1HN3FNQkJJcGJIdTl6Wk1wSjFqOU1DUmFZdWQyYzRQZTBi?=
 =?utf-8?B?VWVqZ1NtaVdib3hBdklPREVBelM4WlVwYU1ZNmFJUXJRSVRqQTk5bERVTmVO?=
 =?utf-8?B?TkJhMGdvUmpNLzZDdU9HemwzdHpUckQwUWFWRzl1eDd3S2kvcVhKTGJXaU84?=
 =?utf-8?B?N0V2d0dVMkcwN21mamFMTHcxNzVOTGJWTWhUeHBkR1h1RCs5OG12RXFSbWlS?=
 =?utf-8?B?WDh2QlJEYWROb1haV0s2b05KM2xOejFNTzNoWjFsZ1JBU0VMM214OVMwVlMr?=
 =?utf-8?B?a3lYOVhLZW8xYm85dmRSMWV2RVBpV1J0NXB2WU9iR0VaNmVoTnFHeFNpYzJL?=
 =?utf-8?B?eC9JQnZlRThyZUZHMEtDcE1tbUtqRS94NkdvRHlEZWwyQnMrKzhzUW9BRklo?=
 =?utf-8?Q?DqxJOle6CM0rQXPt47+5hKMIo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77eb87d3-f013-42ef-5886-08db98b79e14
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 09:04:20.2880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbnTy84RO6GxCs6Z3+FQINr10aMx0uZZRZKV93Cr9+vu4U90tBRrq7XSzEvag09j6VKRp2T7IcqUyNPeAng1Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8791
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.08.23 г. 10:12 ч., Peter Zijlstra wrote:
> Since I wasn't invited to the party (even though I did retbleed), I get to
> clean things up afterwards :/
> 
> Anyway, this here overhauls the SRSO patches in a big way.
> 
> I claim that AMD retbleed (also called Speculative-Type-Confusion -- not to be
> confused with Intel retbleed, which is an entirely different bug) is
> fundamentally the same as this SRSO -- which is also caused by STC. And the
> mitigations are so similar they should all be controlled from a single spot and
> not conflated like they are now.
> 
> As such, at the end of the ride the new kernel command line and srso sysfs
> files are no more and all we're left with is a few extra retbleed options.
> 
> Aside of that; this deals with a few implementation issues -- but not all known
> issues. Josh and Andrew are telling me there's a problem when running inside
> virt due to how this checks the microcode. I'm hoping either of those two gents
> will add a patch to address this.

The microcode issue should have been fixed as Boris added a safe_wrmsr 
call which checks for the presence of SBPB bit on zen3/4.


> 
> 
> 
