Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D8A7EBA27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 00:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjKNXMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 18:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjKNXMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 18:12:53 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2060.outbound.protection.outlook.com [40.92.43.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07157F7;
        Tue, 14 Nov 2023 15:12:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX43tF1zlfF8cxYINt9nbu6STEKO4LYFk133z7k99nTshe5+7MFDdkh3bUQZl5OFQz1fbbqZmmiOAgLT/wr+ICHHwozBjY3P1DKc4jRsEpwD7nMAo+b1a0Ad5k3f8dKbILNjzyjnAmEeq8X/9d1ha5wKDZQB+Ubkvrr4THBcSDk6xjA6qEqFM/xqOsb3BWq2PIru768YZ+DMCNHyWQWHUA/MMY2rP/EtrVdC9g7JwtTrsY+64uv4QXn/eR5R/cyf1/YeRULVDrzgug7+Ew+KCS4bpfu8R7xjDjRBmAd6nI0VEHRci2d4J82T05FtyTygyYesEZQqV5R9SuUM9oHRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2alvUoYHOWl+JD8ICyPYsqayg10Q5Cx1C1ipyBrrUG8=;
 b=Nm2Z2DDu8Plw03Et2EjzREcZShtHS9/eNdGN0Fqo/sMdvTP9GWaKm8zdV6XSg13qD75t2zmFpxLgMMPv2YXyChnfbFSESIaSl9u61kxMa0BJ7RP0109kmUpmZQI4S3EL8TQI+GHU90CIysk0kaFZWKpV0npg2o9cHkmeM1g6KwTdmvJ5zugQTGj+Vp9+ahs76O1ILz4sKyJTLskL3LAVuCG/zV+T8NY6TYYaCkEz/L63A+4fiBOCkhcK9qYzhdTakNwHmY07tNVAhduMLQMzupwoUb2kZhPrJWXc+ZhbsE6TmEHvYJ5a+3Gq5W7kck+ym5vP0FUSPutugylMqP+ksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2alvUoYHOWl+JD8ICyPYsqayg10Q5Cx1C1ipyBrrUG8=;
 b=b13CqQ0JM1wcqzNo+52zT6S1WqUfQn4ZyvzoRzl90jnlK66KrXXifPxhIHWCsZQWLg1HDm3ZGfqHAOUMIuksNyImkXxLY1/ZKY35GsC6lr0GsTMlX0lrd/1Q63uYdAupt07/Si3Ji4MIAsx3Q9pgU3/Jw2r63JB4JOVyDLqdoSc0dG/WgTnvbaBk8EIlzn2b2XAyl9NQphSNOTrKJ3KiDVVkHim5HVO5HDidzcnY3v1eJ5dyst+mJ4XTcCHqQtFh6IdIbo46QygDktUZcOZ1YWCIK5w4WFQBWzBxTBPFMooVUgxhnulBf0haJoushghn0wZdfgKfYP5P/QTdpup1pQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA0PR20MB5682.namprd20.prod.outlook.com (2603:10b6:208:43a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 23:12:46 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 23:12:46 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint format
Date:   Wed, 15 Nov 2023 07:13:33 +0800
Message-ID: <IA1PR20MB495391BFC32D280993485C04BBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231114-skedaddle-precinct-66c8897227bb@squawk>
References: <20231114-skedaddle-precinct-66c8897227bb@squawk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [GRbtOsz3Ia481d9WtdzJuPvad9ZZwGkoABsbFMVjgP8=]
X-ClientProxiedBy: SJ0PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::35) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231114231334.6109-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA0PR20MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 44dee9aa-c73f-4785-01fa-08dbe56736a5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XNW1Gp2WzNOnMFees3Ji19LHhAx4m2CMMwaee0nIh27QxMlavySUXK0mLkFTwHO26vqqwwrzAdZ9w/XnZpOgz6EFfMoToqSvL3XGszEtdVmcHCtfLxN/5OtsoW7xR+3i5nis0pc2HzpRsEODR6iHH8TjuIkm1EMomQ0F7MwZZX/tIp8uh8nKOOUrSXBeqmHrpR6Am3XrjSlny6YTtOTLNbFer2gW8JxyzSsb99TAQnf2ToF/3dFTPtuAjQWAzxaKgknN5UlrzmLMEducvensZR3nSVJKDpxNQS+ty74anKmeKFSbjjXeuz6nAxqyzqukNu0T19o/rMcsZTekFYnUBOhP6H0hyI44jLl+1IQmXsAFOMpoGhxCwJRtUvl4q+3v2HddX/WEWMOJAfSUV7wTh1uQVcRRrVjYIxF4F+z8SgbGw25PqmOl2X5rEdhe6FTcrbEA40s1l0m6wkt+qfsai+IHSGEr4KREU/s+oR0Q8qeUuU2loBylho6m543utUxmsKCi8fiBhh2uuioC9P5slIqEDKS07+srWGK19Y9rF7EhtqoJsQhu9JtahtmMjBolexW41k4tavK2keaW2hxF+U2rsRCXOAdIcTr2Gg1TTUWCN9GxUi1wBa810/0xL3BE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?imfBnb9TjN9yUdxE29tym0m+WcN1Q3pkQwNX8vARaXmnu2e8WmX1BgRS0uMu?=
 =?us-ascii?Q?xN42KNu2a17AC5SAdavdxbc8Mx47t8pyGsUD29jZJXt1lQxAjju7pzM3gi21?=
 =?us-ascii?Q?lwFG/mhKTK6iflitwwruKYAdk50uSL3+uHklFTK4wBFRO/uP8x97L9RSCG8V?=
 =?us-ascii?Q?qWkOKCxmJOZ6F52tAFV/ySGSIgP0y13tPyDSJ8RLdlzQnKYbR/tusBU+hUIX?=
 =?us-ascii?Q?QexO3Q0azpwqcwarTsZmbhjkwUvYfh0THI2I6/uV76iOgQjPBjgpyLKpt+TD?=
 =?us-ascii?Q?W096H1+ZjxKoug5N04ah9XY1diZcwAh9CnngOrih7FQnXkadkhgdG55J6gbh?=
 =?us-ascii?Q?FcHh7PMRKlkKBERkK2r0s2mTiW9zM8d52ogkM77MaIuoLmr2DS0qcD3JdJtW?=
 =?us-ascii?Q?EOKrkjavoJOzoVQHeSRfj9tb9fNWxCOImvxjDXHm5JCQ7Uwg9PIz7KRcTOpZ?=
 =?us-ascii?Q?YPPuk25T5OjTsQ+G9fkPLUPu4Bp3PpCK1bQza5oFc4uoNUuuELnYHhKFMXl5?=
 =?us-ascii?Q?qdfiRtz4oksXnTQeDu5bKt6CWia/zinnZSszrdMhng6Xm5+a7VvOMxkl7zo0?=
 =?us-ascii?Q?susMfVrdmttLTB64lFUaxic/ZRXq3/IJDGMoXsLVIb9X5hY0NwpaW76RU1ZS?=
 =?us-ascii?Q?b2kGLn4Me3wGSSialswkb2YbJ+EHCha236Tqm8+ZCBf38xLiFpocdd9PMYRF?=
 =?us-ascii?Q?my9BOalQ18rh6BHGwaEWTBAw1VYnTKNAWD4AqfJ1zLvw/jLXuVGn+q9qX9Gg?=
 =?us-ascii?Q?flVafsQvK7Hlu/THx+YeutsL+4uPwM/Kfb7lkWJsrmM3bOjGzsCyOyTS/9a0?=
 =?us-ascii?Q?PuZ9+DwcaaQs0riEKaDjsgQq0ocvxbaNYJL3ruz0AJ5KzL3HmUt82L7bzGtP?=
 =?us-ascii?Q?eci2ZfpNRmxZ1fzHvOpJ0fB2sfVK1YxcdEXni1RVjfvHFPYMmpnIfSjDDmbZ?=
 =?us-ascii?Q?eYY58JLpfn0s4EON5sQkOrdWDLLgzJhaNDIGNXJkfdzELJ51M8gxzGDGDgRp?=
 =?us-ascii?Q?W1NKqIaWZCoM3goxBebEmBa2OQzYde0dqjWCCUtxr4l62xs1R3uMo14R7DG/?=
 =?us-ascii?Q?/CNfydvXoCjeXn2u3POl82WztQ1uu2K95DDIwARGutNGnKsl5xOKxTm7oO7/?=
 =?us-ascii?Q?iXLuF/5HevBLwk1XPnXSnjLe1F5BYLUVU7N97FXtjrMe4pY3o2JOP/tDc0CV?=
 =?us-ascii?Q?ZbbrOef++tuPtwY13kBt+EcyV+W7bfmvY2F25rnHuUsxbpQC+i5GAd9Y5gk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dee9aa-c73f-4785-01fa-08dbe56736a5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 23:12:46.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB5682
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Nov 14, 2023 at 09:47:19AM +0800, Inochi Amaoto wrote:
>>> On 2023/11/14 8:45, Inochi Amaoto wrote:
>>>> Change the timer layout in the dtb to fit the format that needed by
>>>> the SBI.
>>>>
>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>> Fixes: 967a94a92aaa ("riscv: dts: add initial Sophgo SG2042 SoC device tree")
>>>> ---
>>>>   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 80 +++++++++++++++-----------
>>>>   1 file changed, 48 insertions(+), 32 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>>>> index 93256540d078..0b5d93b5c783 100644
>>>> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>>>> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>>>> @@ -93,144 +93,160 @@ clint_mswi: interrupt-controller@7094000000 {
>>>>                             <&cpu63_intc 3>;
>>>>           };
>>>>
>>>> -        clint_mtimer0: timer@70ac000000 {
>>>> +        clint_mtimer0: timer@70ac004000 {
>>>
>>> The address of timer register is changed,  and I guess it is another change not directly related to the topic of this patch.
>>>
>>> Can you please add some comments in the commit message?
>>>
>>
>> As it needs to follow aclint format, the timer offset is applied to
>> identify the actual timer. So there is a change.
>>
>>>>               compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>>>> -            reg = <0x00000070 0xac000000 0x00000000 0x00007ff8>;
>>>> +            reg = <0x00000070 0xac004000 0x00000000 0x00000000>,
>>> Why the length of first item is zero? Can you please add some clarification in commit message?
>>
>> I uses length zero to address that the mtimer is not supported, so the
>> SBI can know there is no mtimer in the timer.
>
>No, that's unacceptably hacky. If there is only one of the two registers
>present, then you need to provide only one of them, not spoof the
>presence of two. I suppose that means you need to add reg-names to the
>binding & get your registers by name in the SBI implementation, not by
>index.
>

Yes, this is more clear. And it can fully utilize the change from DT
binding. I will figure out how to improve this with reg-names.
