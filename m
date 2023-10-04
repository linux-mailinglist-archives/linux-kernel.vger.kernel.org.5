Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5057B7E6D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbjJDLnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjJDLnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:43:52 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2064.outbound.protection.outlook.com [40.92.102.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BF3A7;
        Wed,  4 Oct 2023 04:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW8Uxlx3LdG3zmvSoxHrBf2ebPw1DQTDDPA2Di0klKR8euWMb9jiMBhSbi5yaaxlcHX/9W8ttSCK2d6J/CFu0jl7qxkw94Ng2W2KzeTDrp4OBU0rK3TOkdb3g+2vJejRBvlz2Skel+FEnM7mrOaX1BgN4YoEt0MbyP0uLEIi4Xeh0ta6fBq+kyic7MEJxfodZVYNapbUHe/UUka7ZZqrez9UYeWByu8YF6Hz8+105MG7PAMNLNsGSBGQV2XAVf4UMmijPhIiGhtHNJoePq1Y5moMuCQugadCyc4bi4zt+Cyw3R5o2woxYLTSW7bQRKhjicUPl9z8CJBItXajMTt/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ccy+yQxsR7TUqJ1fUBLvZgd9nKhfgA458BGt3N2o0i4=;
 b=LbvC1Eh1XNcqpf593p45sAt+NcL8U7f17/5UT0wJP/rbvCs4GyOpL3k4vNcVDCSsq6ujPqCXB2ovpRPTFzVSIJ26iFypfDYChyr4uSu32G/LVoizJOMPNYmnScmfwdpeuKdYJqPy4fPYLBcBZ5yz1LifSYJoM43jGPiu/EesnErlfC2eXK43rP8oGYhliXCnwPlI6+fa0LMLR4Y7bpWckU3xRPbHKNV9OI16cj3Y0H2HWLy7EDaiBzU9yy/iE0RqwFxZMLh0VRc8DgEcwhWqLFTAxYEVRZjrPoPM9jsae6pYaXRpQWSD20Um4msmRaD2HltzRRWUn0nU5pWr9y2FeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ccy+yQxsR7TUqJ1fUBLvZgd9nKhfgA458BGt3N2o0i4=;
 b=QSWoLNfk+iWNTP0VxPreigHX6KLYuzau1HT/rLwgF6/czjqw2ncGKKjhX85r8mb3kTwnbok1Hzm20Nmg/9Y5C1xHb9rofOOGVYP6uaXde3yhVWukrYucpYQlCVYgjm7PlIbp/wDboUwyhGycobKcSZmsCfKm1zKQlxvAEzFckQT6Ds3s9ILFZRbqVRf81WTBEeHzijbDzGyhj18ee+OumBiGWsgLUf9kgLs5h3e7s7uzdrDJhRozSoADMRdJFADEZw+1CRDaop8q04xFna1cJQhUi3NRh9w2Yva6EtNzDQUgSA1kmQDhYFmgVqhQJSJ46BOQZ4wvngJzAgXBnu8aPw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB0811.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:133::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.35; Wed, 4 Oct 2023 11:43:36 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 11:43:36 +0000
Message-ID: <MA0P287MB0332BD2EFF6C43DC154EB03BFECBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 4 Oct 2023 19:43:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] riscv: dts: sophgo: add initial CV1800B SoC device
 tree
To:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
References: <20230930123937.1551-1-jszhang@kernel.org>
 <20230930123937.1551-5-jszhang@kernel.org>
 <MA0P287MB033277186E21A09127407452FECBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <37021ef8-55e2-4116-8201-2ab7df9e0fc1@linaro.org>
 <20231004-caregiver-deserve-71849c94dcfb@spud>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231004-caregiver-deserve-71849c94dcfb@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [nZqIRyyNcUbGv1RM1xokrNfODBB8MVXq]
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <ac38aebc-66b9-4277-b814-4e1c00ad31f3@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN2P287MB0811:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f850cf-dbca-4e26-4e82-08dbc4cf2505
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIloQUR4cmn07S+BK9MR1ojLzCAxiF9RC7G0JVwFya3DgY0I8pc81mUwxNqVhv+yE4JP0tJhcLfvtIlpzlruICEJ4JmF+5ITvolUJ81UJVK4noIFntRa4DPCNHUzlOz4lQd8pR36+MBskE73VTONhtznErrHKA1n9T+9UzVe4nIdfRA2oM53q99QSlDvfB7/6dla64bA+IjGnx0Lz/ja0knm4d1/KrihNmThP8014cjfT1UCH62DZjNJq1KYlRMYO0iQz7mD5aOmAbnRmS6pRv78sW4571d4cuB63owKhTawngelvYOUXaizwi2UGZ0p7CuKEAt6NwWRznYLIzU/4z9MYjoF+mOdFRDvd+GwWqSHUgD48oQsY5MamZPCKpK4KJDBCip55PKmARXQHrKbxHFj6HOesyMZBVgfmrbcO1ok9aEUD859oOrF6DeSd18lQ1KIqoHlQBysnxG5JjO4ms/VHaCFLPX3jQNRAOzPa4itiSS4FvBLPaoL1oRCJB2DEgMOENfz/oXaRXf76tn5dYvl6qjHZeH/g9gEQpi9nyM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1l2UmxEZGlxV01UNDErWjI0SkhXUzRac2NjdGh6SFBnUjhpMlRwSFluMjJy?=
 =?utf-8?B?dXVTVmoyMkhFVjVncTN6RHFhaTZ3OFhiWXdqb2o0T1d4N3Zkb3o4dFhveFZN?=
 =?utf-8?B?TTkzYTlpdit0R1l3ZElZUU1uemNDZisza2N4Q0pYbERIOEFzMGEyaGExd2xO?=
 =?utf-8?B?aEpzK0MxZ3JJeXIxM3FaRlFsS0wvTHVReEhySUhXWWIzWmNFQWhyb2piZHBP?=
 =?utf-8?B?a0p0Mjc2ajRHMnhUZEFuY2NoNmxsTmJQMVc3dUtqM2lDUVVlblZmOUl1bDJp?=
 =?utf-8?B?K2NaMUd1bFlTSVdLcTdBMVVkQjFrYVZCNFdKN1cwNlpuYXJpTEFJQ0RtNkFL?=
 =?utf-8?B?dUxPcnRVNjFBaVdGSHJLeEpnbGo4cHNvbGF0OWdBV2p1bjVPcTlRSGYrdjE3?=
 =?utf-8?B?S2FRMmMvaHJtcTI3THBhYXN6L2g4L0FiUWhMOU1scG9UZ0lucDdycFRkeDFV?=
 =?utf-8?B?ZDNkYzJicjVlTjkwdXg5Z3lZOUxzc0xGWGFoY2REK1E3VThMVmlueHNyT3Fm?=
 =?utf-8?B?UmtPQUlYNDNya2REbjJXeXVsbVRVYzVuY0hvMFBVcVd0amx0SU1xN1lCdFhq?=
 =?utf-8?B?ZzBrSTRrWDhpZ1VJNkJtbGtxVWxmakdzcjlQUzBzQ3JQUVJRbDViQWhPM2tB?=
 =?utf-8?B?U05zajlCbXk2clg4YTZUWkFkS3U3VDQ4QkNEMysxM3BocFNZajY5bVhlK29v?=
 =?utf-8?B?cG5zYzZUZ3V6NzNHUjM3MGJKSkU2RFZXNGkyYjJQb241TlZ3dGJvQ3dldThI?=
 =?utf-8?B?TW9NejB4bUpKbGRveVZReWxZZ1NmUGJuS3RndzRIbU5BTzhUZmFpKzVad1hz?=
 =?utf-8?B?Yk54U1ZZdFNya1h1RXpkeTRQU0o5akY0WEpKMnRPSDJqdUo3ZXZ0YXdIRndC?=
 =?utf-8?B?U09DcXJvVmFWUEdkTkEzZnRXdmJ5U0FScE85ZXdnbWRtNERsVm5sTUF0dEJV?=
 =?utf-8?B?MGxFMU9EaDQ3RTd5ZkVlZjN2R2t3U3FXeHNYempaTXQzRzFheCtqdk1XU0hZ?=
 =?utf-8?B?QmdnTHpCZndjcW04R3RYWEZwQ0hDZGdnVTgvaDIyVkNVcDVXS2ZINjF0dW9r?=
 =?utf-8?B?Y2d2Y2VQSXV5QkNiU1Z4WkV3TzNpb3h6Q0Zib3pCMm9XamdPSFh4RlFKMU9k?=
 =?utf-8?B?c2JwNVA0WmRRc252Z3FXZ2JUeHNNZUEzOXBOaU54MjhmZExxVlJWQUVEYmlY?=
 =?utf-8?B?YXZoY0x3ZnE3RGdTa3c2TVhDK0NSRlcwV0tjSUxvb2VZU3ZMRldxdkZCakNK?=
 =?utf-8?B?OVdpc1J2M0toVnR6U3AxREprdW1sd2hMNlBxS1FSYVF5Q1d0bVNIcWQrT3Z5?=
 =?utf-8?B?SGJjU2NkcTQ3UUNSZGhHeXU4UXlaM1czSVYrV25zNGZVV0RnTGRINGRtRkNG?=
 =?utf-8?B?aG9GR1Y5Zmx6RytOcm5TbFZxSGx1QzZPK3EyVzgvNGd2SmlQU3hmbm5CNDkv?=
 =?utf-8?B?bDNSTUxsT2h2L2NrTEo4Mng1TXlUS0V2VTZkZ3lHNnJicFVQK3c4bWZxUmh5?=
 =?utf-8?B?Vm5PV2hDbmhMeGUxVnJOMjFMQnA1RVEyTHAwT3lBK3QrSnNLQ3AxSjVXVmJs?=
 =?utf-8?B?eHRqRVdtQ1VrOElONndZeVdRMWhkYVRXV1AvYzFKT3NsMlNEcXpEN1JZWmFR?=
 =?utf-8?Q?nbS0KrEZ8s4lxci7V4edwunOGI+DEQQoecCv4Xtug15w=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f850cf-dbca-4e26-4e82-08dbc4cf2505
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 11:43:36.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0811
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/10/4 17:13, Conor Dooley 写道:
> On Wed, Oct 04, 2023 at 09:57:33AM +0200, Krzysztof Kozlowski wrote:
>> On 04/10/2023 09:23, Chen Wang wrote:
>>> 在 2023/9/30 20:39, Jisheng Zhang 写道:
>>>> Add initial device tree for the CV1800B RISC-V SoC by SOPHGO.
>>>>
>>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>>> ---
>>>>    arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 117 ++++++++++++++++++++++++
>>>>    1 file changed, 117 insertions(+)
>>>>    create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>> Hi, Jisheng, as far as I know, sg2042 and cv180x are now tracked by
>>> different people and even in sophgo, they are two independent
>>> projects(sg2042 is target for HPC and cv180x is target for embeded
>>> device). To facilitate future management and review, I recommend
>>> registering the maintainer information in two entries in MAINTAINERS.
>>> The example is as follows:
>>>
>>> ```
>>>
>>> SOPHGO CV180X DEVICETREES
>>> M:  Jisheng Zhang <jszhang@kernel.org>
>>> F:  arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
>>> F:  arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>>
>>> SOPHGO SG2042 DEVICETREES
>>> M:  Chao Wei <chao.wei@sophgo.com>
>>> M:  Chen Wang <unicornxw@gmail.com>
>>> S:  Maintained
>>> F:  arch/riscv/boot/dts/sophgo/Makefile
>>> F:  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
>>> F:  arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
>>> F:  arch/riscv/boot/dts/sophgo/sg2042.dtsi
>>> F:  Documentation/devicetree/bindings/riscv/sophgo.yaml
>>> ```
>>>
>>> For Makefile and sophgo.yaml such common files, just keep in sg2042
>>> entry should be fine.
>>>
>>> @Conor, what do you think?
>> We do no have usually per-board maintainer entries (with few
>> exceptions). I strongly prefer this one instead:
>>
>> https://lore.kernel.org/all/829b122da52482707b783dc3d93d3ff0179cb0ca.camel@perches.com/
> I don't like the suggestion here for a different reason! While I'm fine
> with having some per-board SoC maintainers, esp. since the cv1800 stuff
> is very different to the sg2042, I want to see someone step up to apply
> the patches for the whole arch/riscv/boot/dts/sophgo/ directory once more
> comfortable with the process, not reduce the entry to cover just the 64
> core SoC.
>
> Thanks,
> Conor.
Thanks, Conor and Krzystof.  Agree with you, it would be better to keep 
only one entry for arch/riscv/boot/dts/sophgo/ directory. I will discuss 
with other people working on sophgo and specify a unified maintenance 
task to maintain files under it.
