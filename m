Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795180A2C0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjLHL5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjLHL5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:57:33 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2083.outbound.protection.outlook.com [40.92.103.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BFDC3;
        Fri,  8 Dec 2023 03:57:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9MMsDnOsw9Ru+bCHLDlc/0OkihQLtMy4Yt+gcADReFSNlxleYGxajTAIWdUdfjp+HcBuCgjcyLB3Vx2leWs2TeNXKhhlrHqQmp/pewnPCeI3cTyQiiZVij+a/xRwRPXLBd7ymdD0GMkRv9cAKrE49DMN7EM5ymEUY/N2Fw/1RFQhQfZDNvLlcSIZTkBh9vbEQrowuot3+0TypjS6/QnoGEL+SGu3zx1nGCjfJvagA1jVFgUwuPVx3v7wywIh0CnF/1kEB83IH09cI3f+F0eMGlrFneONiqGXKpyED/WSimcTMQVKM5RiwzU9yfT5FWbIHUVKVtHSLEp1OOgfgIPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8tChMfbis9BLYzxg91Q49qgx5PBOXP1MXBlC9WdBtQ=;
 b=XFO0oFOrmFRLR0/klqLzpu7OUxQlCNO0S0B3icXJDijfLJfUhPxr3LSON1oZFn4P87wSvZrpGhpCKmvkyUQ+5KNba69S9+Voz2A6xoyg28x67hI5MWMmAsLn9dzJ+rOhFOrw5K4gS+Tg/G6WvHh8+NALJr+CicgnMUe1jp6A+aewObVy6cGaynjwBRjkLYEkJM7NgqM/Z429Nl/cCU84hTsMgAH9/O9DPyAz3z2IOxxZclEMKgOWW325SIQDzbo3FUZ6czBXuO5vHY1weN7b0ivsgM8fl3pWQLg2L6Y6lLuBRf+kwtg9iHRCZrQKRusgCzTZax1AWLshJbZaesuiXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8tChMfbis9BLYzxg91Q49qgx5PBOXP1MXBlC9WdBtQ=;
 b=R2mRJT89PxEbSqtN8QxgcFyrfurgghAi+zCmurs5ckNAZMUbONupxfG1iR1v2juNyH+F3xpNFFbWFVZepPfmkh/0fIRb9RHgheZSz3U1/kDirdzLEbfE+piElBe5+syst0G61O4tPo7I5xrEaPhb998/qCVsl0nRPC8+zt+Rk0j7+a1nUGLgZrS54von7kxMNoiJQDbLrODcD/Tdwtf2FHplW4s/SJKsQZ8avWzTQkdnqCMKxiVU9LDR7pP1oLliFxwr7qTUQ8fHUfNTcp7gaOF9Enrc3rnefekLmHHLXlhw0KjVaPDI0ledADe4wzpq2vRKUbtTzOlgHEWyaU2Gcw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB2020.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1bd::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.28; Fri, 8 Dec 2023 11:57:30 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 11:57:30 +0000
Message-ID: <MA0P287MB0332C1ACD7BB3607694F9E05FE8AA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Fri, 8 Dec 2023 19:57:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] riscv: sophgo: add clock support for sg2042
To:     Conor Dooley <conor@kernel.org>
Cc:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, richardcochran@gmail.com,
        robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com,
        xiaoguang.xing@sophgo.com, guoren@kernel.org, jszhang@kernel.org,
        inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1701997033.git.unicorn_wang@outlook.com>
 <MA0P287MB0332EEB2858B8B39F151CECAFE8AA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <20231208-item-rubbing-e32503c6cdcf@spud>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231208-item-rubbing-e32503c6cdcf@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [uCwqi5fXIf2X+6tVIkwMCCdO4ndt7W0C]
X-ClientProxiedBy: TYCP286CA0224.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::8) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <62ea0685-ec50-4640-b1a6-ab3eea049c2c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB2020:EE_
X-MS-Office365-Filtering-Correlation-Id: dae4a89c-5e02-46d0-de33-08dbf7e4da8e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BWcZfKPVySd2NWieCMpym5ERHm0Ub7O9xuXElZKGHu3BB9YzBds/wuO4IPZMQhYh1FoAPYLvupNBAjc3yuCAJXqJjqJm1mjB0zyiGUKaE3MU6fU14ADJeqv4is+uPBl5fJ0/Y282Z8R1kZ/pYZ3X5CgiAAc26b9ka7W52P0iMh8gNlQvU3yWcpQCIpCj2d4wi480wIg56rCPQzt7I1murmAxT311frsHorgGYyz9JzjM2apP6jHp0/ldw+Oqrv32OJ3i+uGa/KfRjJuaBHGaQ/kU9Q8WorXGiHTwPd8t6TQNah2wjWnbobFVcJp417hnZijYv2Sup+lQ9Gt+699ENV1aY/r0bFMk4SCPJHzZRLTnnWcZ114ia/ITnpcY4Mn5qvABwyPJ5AjKJNDH1uLXCsrMA4F94VpJFlMnLnPqARJgulhCA1zhd99A7kHKBWX9cnP06rts13x+ScgsxagkcirG2pnnxfCuNqAGtjaSICn6IWlgKx/YQtXmZaLgPtdrZdkehCNEANdlxflxd3ZMUSSjdVlnhwTqQIX88qupg5Gmfrwv8j3XfShsRcHWLtbr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy9RbTJnVlJVN0hjSzFPRmZiN1R3M2VGRS9DVTRVcUpySmRJZ3AwTjFtRzA4?=
 =?utf-8?B?WTA0SHh3RFE4Um1UUm9JOXRBTDErUVExRkJtWWd5WHRVSEdqcVhGVU5oMnM4?=
 =?utf-8?B?NmFKRFJBV21TM3BvaEtSUlF5R3dxYzdTQitnN09lMlI2Z0VEd3lXWWVkeTQx?=
 =?utf-8?B?RVZCVTVGK21kUFR6K3hSMW5aa2NjMnA1aHhYd014akNtU29IWGVqUThWenRs?=
 =?utf-8?B?dE1xR0VkakRDV1NGUlFXYmtCQ3JCUmN3SmpJWnJ4Qmh4K2UyTXdDUVFGekVs?=
 =?utf-8?B?Unloa3hFeVdIdXpYWlQ0ZVRDSDhka0NoRXNoZnVJU1piWkx3d2ZGTUJTT1Iw?=
 =?utf-8?B?aEg1OUd1cnhNK0V4N0JwM3d2eEpyRmRkck93eE5oMFBqeFFnbHRiRzl3S1Nk?=
 =?utf-8?B?RzUrY3R2N0h3NjFVa3U5Qmo1Q3o2bnlnK2RJWVJiVmlFSkloTjdIZ29PaU5s?=
 =?utf-8?B?RU5SZ01vVEtpQklONjBrMGxXYm4vZFpJVTRzc0ExMEI3cFJRSzhSKzlFdEpI?=
 =?utf-8?B?amtoK0RjNEtONDN3WDZmYVF2WjdRc1NkSDhCNCt6L3YyRzRjaCtLeUVCYkI3?=
 =?utf-8?B?YUVSbkhDUFNhSEdmT1hJWGp2alM0Sy8vbHMrNzg5dXpkU0hEVkJBTVpFMTln?=
 =?utf-8?B?cEFnaG9PZlgyYjc5SmhqUG9UcXhMeUExZ2VjOVVVVVZOTWNESjlhWjFyYVMr?=
 =?utf-8?B?Y1NHK2xQbnJERFpsVVBvQnJtOEdUekpKZlgvTDdpK3NQUXVOL3BlU0c4MkVU?=
 =?utf-8?B?T3ZCKzF5UUI4WlkrSTJlNDFHWFJGLzhXZ0VWN1gwa3lOMEh5NzRiSzl4MUE5?=
 =?utf-8?B?aERmWWVaOXlNNjhPU21QSHhaMGVBQmhNU0NsOERiWFBqeEVuUU5CbVdoNDU1?=
 =?utf-8?B?Q3ArTnJKeTUvN1RqbnQyU0pBaDd3Ty9mRkdxSEl1V2kxbGxadmo3R3F6dGZw?=
 =?utf-8?B?N2FXdEdPUWlJbGhNTDJzSk0wUzRsTHJmMmtTZjNuSEVTVXhrSnIzdmpVcHdR?=
 =?utf-8?B?MHdLUWNpZU0yd3UydUFzQzU4M3hQTVRqeWJLeWpTWUZLMnRHdXpHR09FSTdN?=
 =?utf-8?B?aGxxV0I2aTlHK1VCY2pRNWdDR2lSMklOdEpQN2dGSHF5QWhBd0xUY1cxZHBa?=
 =?utf-8?B?SFhyUlR6ZzJVcjFVLzF2WXRsaloycjg4THh1QXZjSTZpbzR2NVFYL2pkckxw?=
 =?utf-8?B?N3BqWmJNMnVVYWwzVkZ2QkdVekdBYnozM2UwUW5WR0VpUDQxR0YrcG5sWmpY?=
 =?utf-8?B?MzFWUnVBQlBpTmNyekJ0aVJKK2tLRHpJamFNbVR2QnF2dTY2NmZjMzBQaCtU?=
 =?utf-8?B?QS82VWhUeWRxbkpPdjErWU5JaFptZXQ3TUhuL1hETzdpd0xZMGc0MStpZUtl?=
 =?utf-8?B?OTBxSWI4c3JQcnNvT3BCQ2hFbDM5SnZLWkV4c21wY1BEWmw1R3FjVGxUaTY2?=
 =?utf-8?B?Z1BjckltV3V5Z2J0alNaeC9SQlhlMVFVcG9QbmplamlLMTh5bHRDaUgxRy9x?=
 =?utf-8?B?c1JmblhzclZUVldPNmgxakJjYURrWWZIRjdLVmhoWGRkS0pyNFplWTcxdWJY?=
 =?utf-8?B?VWFkL3BKTlJwTGliOGFoNk5qc1pvWW15cXV3TDc1WGlkTzNVOUdSbEhLS3BC?=
 =?utf-8?Q?lCTirazxsVCwfHPHlSLdZlo2n5aEeScWU5kfF+bICXMY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae4a89c-5e02-46d0-de33-08dbf7e4da8e
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 11:57:30.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/8 18:30, Conor Dooley wrote:
> On Fri, Dec 08, 2023 at 06:11:10PM +0800, Chen Wang wrote:
>> On 2023/12/8 9:13, Chen Wang wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> This series adds clock controller support for sophgo sg2042.
>>>
>>> Thanks,
>>> Chen
>>>
>>> ---
>> Hi，Conor，
>>
>> Can you please have a review of this patch?
> Chief, you sent this patch only the other day, please give people some
> time. I, at least, have an MMO addiction to feed in my spare time
> alongside reviewing patches.
Okay, no rush. :)

Christmas is coming soon. I wish you a happy holiday in advance.

>> And I'm not sure if you are ok to pick up this patch so it can be merged
>> into the next v6.8?
> Stephen is the maintainer for clock drivers. I do pick things up and
> send them to him as PRs when it makes life easier, but usually that's
> after other people have reviewed the clock driver itself.
>
> Thanks,
> Conor.
>
