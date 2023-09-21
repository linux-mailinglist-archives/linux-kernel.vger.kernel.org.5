Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02E07A96EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjIURDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjIURCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:02:42 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070f.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B22510DA;
        Thu, 21 Sep 2023 10:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb00p46Z2x8pVNHBI6Euk8TVW1uEDdeg9ahQvzg6J4Xts5yn1/rXTgJtdTNKkRvZ+s2RXG7kSld+PxaOj//tOQYvn9MUEjujJL3MHPD5jpxN3kv//UB9RwvhuypjA6rFnwiKajDxrHsEeqibuQcEcZshbJIAQF4cQEXfOhNMZj1Jmux+mHiGzhh5b3MJOFoh2EUWyvRbawhYvGhm9u0s5pIXOEEw8EMgxFPH5Yq77M5MBJU7EncQ+TDC5A1AOeb1ogRiAiV1Wns5T1be3Pls58I3TC4FXm05s2n/FkRBmd5aqWVRAwhOJ9NEJi62rro2VkLaw9gq6yfJ1y3zZ5+I7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05gwwbnRgUzGJwLHhUnlnUTe18grLX0VdccRWcsJg6M=;
 b=F5QZHQnY946OK4JHVm6unNfwRXAuxqdCmoX3RwEjE1Nv+1A+I3q0RV/aWMJUqlO0WnoigdU3Dgt57ypUNdR3tbB/n+rHcWmzhmNS8NZidCfsrJGvm8nFCj3u5Fl2tkLbJWME+F7w5QoUfSURormM0tiFvHSwxWXdN2s5ToN4zvLPxi1nr7qIswqc7y3VjW960fL/zS0KNJWx1C8hc4DW1gq3zziz+0/mEh9VCuYQ3v1tjdkNJAmFjUGZj1RvuVm6ub1lkwChdfPq89iU/lwE3bo3WnEf6OhPXWp+aE7bBk4DbA8mJjJBtRxn7sePwOTzzGNe8nwm7HUDmOSthp+XIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05gwwbnRgUzGJwLHhUnlnUTe18grLX0VdccRWcsJg6M=;
 b=s6Im4IV2ygfc1Csu3Qm3A8RgWuI+nFe2WbBuSqEC+MyBCMTMZfbul1qAY1S67kP6rKWAZJcYrclZfAadGrSkl7ga/C5dzxGW/Ebu+JABlsKz3uxOB04ukjJke+hZkDKRNIf9TbUhkuDSlNT5pyooevsleJza+U1WDqtuGb1KMahSt7L2QuyAt6S+OhxR3t2o29WynpLy167rJUT/QBetLraD+JoLEIhtIsxMUSSyXubn6810Avfp30ROhSIXxjGjhr+bGcn7O50peRQCDcLZznOZ2h+HC0XJxYtAeLQIGBwvjPGXtpFekjvhF561xkjMcSx/sl1x23NN0x2zg2gsfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com (2603:1096:820:cb::11)
 by PSAPR03MB5736.apcprd03.prod.outlook.com (2603:1096:301:8b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 09:43:53 +0000
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::3f14:c67:12ac:af39]) by KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::3f14:c67:12ac:af39%3]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 09:43:52 +0000
Message-ID: <a791aa4b-3b8e-22c8-5d0d-d7de3e5135df@amlogic.com>
Date:   Thu, 21 Sep 2023 17:43:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 1/3] dt-bindings: pinctrl: Add compatibles for Amlogic
 T7 SoCs
To:     Conor Dooley <conor@kernel.org>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230921083407.1167510-2-huqiang.qin@amlogic.com>
 <20230921083407.1167510-3-huqiang.qin@amlogic.com>
 <20230921-fa16f2f1f118091489708226@fedora>
Content-Language: en-US
From:   Huqiang Qin <huqiang.qin@amlogic.com>
In-Reply-To: <20230921-fa16f2f1f118091489708226@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0181.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::19) To KL1PR03MB7221.apcprd03.prod.outlook.com
 (2603:1096:820:cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7221:EE_|PSAPR03MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: a56a05d6-fb06-4b96-8458-08dbba8742cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZ3u6oLVEnFrX4DfoE4n/JuoYieG6AdUS0sHZz5lGacHJK17S92rhk1343OCDhcqNyvLpXnIeOUr/8d/wKT5Hr8xl5BeknWUrI/zA/v7I8ndpDSqeFc+tI3cklWfJIU4yFrg0dOVgfqG1QDjDXS1O0K0C1E9jpCtPgOTneZZ7xvWPqYHRfsUuKXwvc0TVUq1GKqxdp3kmpFawReHWSFk2KmrOzFM3fvwmb3Ah92fkvOa50OscVe2k5y/T2/NU5fBScnX2CgetUYh+aOUiV82jWf6clzHkJ9aSe+DH/Vav/nd2lH1IqIBY1nVg7eTSjJrWE0fKzuikYgUYj5E6AA+tXGozwrG4NXVeolqfA20foSZBtj4RmfLXPkhIvFs2D/Mv/m1UubWdq8LxqxZzanRxqmb1QfmByBsxyOECkrtwDni9+sF5AZ0AhSmEF5blTjirMoSY8kncL93ibRYQmp2t3rUG1is3nsLUuH3BrxkyWs3eb6OlgGSFfdqOgLI4oFwyUbWNUi6YKBq/FVJeoJaY5QlS1tw7wxckj3IUoZQAdYLC+VMZYOBq/pZ4caSXaGRanL81IFwJwBfqe1X0Y4zLhmxsLXYHNpzg6srtYt0DlFQ6PGE2s9kF42GVkI5bUOf0yJn1XV8Yts8FSQJGzYaLIxzASP3mBygmx595r0NtjFpEtdDhkk04WV4FNpfloOAQQUiSJUjqJD+fv63DTHOZU+CtvBYGmWLsmyIay89xRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7221.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(39850400004)(376002)(136003)(346002)(366004)(396003)(186009)(451199024)(1800799009)(7416002)(2906002)(4744005)(38350700002)(38100700002)(316002)(2616005)(31696002)(41300700001)(478600001)(66476007)(66946007)(6916009)(36756003)(53546011)(31686004)(26005)(52116002)(6486002)(6512007)(6506007)(6666004)(66556008)(86362001)(44832011)(4326008)(8936002)(5660300002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW5NV2s1OVo0WEVrUnFXSTllMkZyRGxMcmFLVHI4aml0VTBzblhRWkNEVUdF?=
 =?utf-8?B?UjFKN3YySG4xNXM5ZENqS1BKV2d4Z3JFUlY2TVYyTjJuUURZMzVKS2JoN0pM?=
 =?utf-8?B?U1ZRM2V1LzlRMCtlOWhWOG5LS3RmYkpiQXQ2NDVYb2w1d0huZEtBRisrMVBZ?=
 =?utf-8?B?V1ptblNjNGVyeWxVSWFlZmtBTGE4MHJKbEJTRzVkaDQ5SXZyQnRRbFd0Wm9Q?=
 =?utf-8?B?U081dFJuajF4OFBFYmJDSDJwS21HR1c1bm84blpHdnN0ZHBDeFdDYjlRWS9F?=
 =?utf-8?B?cEtHVTB6VHJRNnNtS3hYVW53SXkwY1Z5RGVBV1p2d2Q2Rk5YVEFHSE5DVVAv?=
 =?utf-8?B?ajF5d0lNS05uRE1LN0FJaW5oM0lqNHVjTEJDeStwMHgzY1hKak1RQmNWdklT?=
 =?utf-8?B?NWtGQ2lGdFhJOFA4K3VzSFZFOWU5K1FaUmlTa2dTNXAzYlVtZ3dCWjhVUTZh?=
 =?utf-8?B?OXJRVFp5M2tlTWFQUHJvZG9aaC9BdzNXY3B6ZGg0TUMxUEkvR2FJeGhZSW4w?=
 =?utf-8?B?SVNUSWJuRDlaOERYUE5zK2JMMml1SnNObEZ5UFZBQ2Q3dkVsNVYrOEo2MGp0?=
 =?utf-8?B?SDNoSnJUSkc3OHp4WHNIVGQ4ei83Y0kyQlRTeEFKcXViMUh5QXVvMks5eVFK?=
 =?utf-8?B?UU05dUlZZlFCZHRDRFNGZEVuQTkyeGdDUlRGanVFVTZEQ1djV2JQa0QvK0t1?=
 =?utf-8?B?bUZ1REZENGtqcEVrbys2WWl5Zjh5aHFoMENVUkRpWmxSZHNCNC9wcHNhSm51?=
 =?utf-8?B?QjE3UE1ORkhzREp2QjVtZ2tzNVdkRVVrWmtuSFJUQk4xK0JIWTV2cjlxdzUx?=
 =?utf-8?B?RlVhakN3MVROYlFUMGk3MnpSdytQRnRNWVQ0NG1YaXg1M2xZdE1uMy9ZVmlu?=
 =?utf-8?B?OTBXWE9TY1RmbDdrcWMwTTVSQW44bnBPaDVYaWViQURPRE5WR1RGQW5HRi9P?=
 =?utf-8?B?THYra2xFR2JNa3ZjVFJlR3JnUmtDQUpTS2pRQmNJWGMwWFVUaHJVall1Tk9C?=
 =?utf-8?B?VTR2Umd3bzNyRDE1am9ZbkU4UytGNDZSL0ovNXR5bnJqa1Z3cXBBLzJuZHBJ?=
 =?utf-8?B?ZGFtUUJJQmJZRWJ1eGZnTisrQVJsMVN4U3Ixa1VDdElNRDFpaS9GV3ZwQXNR?=
 =?utf-8?B?NUhIMnJQbkVwWTBCMDgzME9VcDUvVnVYL1lDMVVmd2I3VDZXM1JCcTFYOWEv?=
 =?utf-8?B?UitieWFyVFBlalV6TUI2SzhqMms0NTFPL1lqTUFNNi9abVNWR0gzUVIwMHNN?=
 =?utf-8?B?TU5aSmJLb29hRGVrM2t0QkRoUXkwSmlGM2RjRkozQ0FldnA3T1kzazdTM3Nh?=
 =?utf-8?B?a2NqR0pjaXFWMHVSVFM4ck5kZ2JObUlFUitHOEhDdWdmWFRHSFJ0WHJsU0N2?=
 =?utf-8?B?VkZFS0lCRm53SnFrSVFteUpaSFpTanhvTCtoN2JyY0tHS3pIaFliZjFrL2ZZ?=
 =?utf-8?B?V2x1S3FPQ1lvbThoU1JXSmNJUzVMUGRQZlprRTlmR2dua2k0QUdSdEZYTmJW?=
 =?utf-8?B?K0ZEaEplN29wTkNvaFBJcnBtalpqQ2s4dlpYSG5LSjVWb2JZRkRsYk1uajFJ?=
 =?utf-8?B?U2hjL09SZkllNlZiL0Z5Sy9yQVJrNFh3Wk5oTFYzVWZBRTRYSXlBMGdaanNC?=
 =?utf-8?B?ZWVTY2s4OFc4VjQyQnJ4YzJNcURsZ1RMeWFwVmU0TEtZWXlRdXpuVzBMQ0xQ?=
 =?utf-8?B?YXlhNmdqUkYrSmxVNUt0WklFYml0NkhpQUJjSXBFTnVmb2dMUWNqLy9aMzdm?=
 =?utf-8?B?aHNmUGJYWERia096QndaUGhrOGxLb0FaSGlFSUg0RkpGaUlZcHNNcmptaUov?=
 =?utf-8?B?MUkyVktucU1kY1RtcS91N3lQQWNzYU4rektDZWUzNTZ6T0dhRlVMWlBGc3lJ?=
 =?utf-8?B?dk1HNmUzYmFRYjNtekF0ZE1Ub0h6dmxWMWV6OG9lcjhNWlBIcmhNOURDSDZx?=
 =?utf-8?B?U3MrRzNBZXBnR04xaXRkV2gwblU5SkF3R05nOXdzL2E3dDR0cnlqM0IwbmFw?=
 =?utf-8?B?WTNOa2Zta3dZdFVabGluL0lOdE5YVHY1L3oyN0VXMWpKVmZzQURDM0w5aTUv?=
 =?utf-8?B?VVBsMlkzN28xWkFZR0FBWUhJZmtlR0k5TjJua3dBcmlFRW1IUThmV0loS2ZN?=
 =?utf-8?B?QlhLNGNXRFYySkNvQ0VhbGxUOXo5ZldzNy9pbVRnanNWOHVHZGFzdm5FcXM0?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56a05d6-fb06-4b96-8458-08dbba8742cd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:43:50.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47vXpOo8Qv+AuxMY3cAAkMeFRHNWWieltQ7PcjslIKOMNZvTZAw4Otv3+XQZ3pqhC+XrDpCoOTMG36Cwmb6RcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5736
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 2023/9/21 17:19, Conor Dooley wrote:
> I'd argue that "Add support for" would be a better $subject for the
> changes here though given that there is only one compatible and you've
> added a bunch of new definitions.

Thank you for your suggestion, I will do this for future commits.

Best regards,
Huqiang Qin
