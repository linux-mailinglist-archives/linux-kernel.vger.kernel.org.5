Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3547EBAF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 02:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjKOBeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjKOBeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:34:21 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2053.outbound.protection.outlook.com [40.92.102.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6DBCE;
        Tue, 14 Nov 2023 17:34:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGodceM+M8yqVqj8TX2Fv7g0/eyIoqDs4EiiR+CHwDquHrorK+iu7NQbCgKeoVdGBgzdcnp+aifOoVI5N5KuskouR0/T7AZFGLMBp7TBlwfCtJDgfjxJlM/jVsHhlaCk3v4H8ngOaZCqfDhMAgrEM5CQOa6zQ7hkIdwv8/vUd/1qBB2LL/FxXsa5lD2jIRQw1TKlhLTB1K09T8HHlcfZ0RhcOXHdcw80dc73N13klofHjh9yeeu1LNnf5OmLOEErjxwkGGC3KIMcb4FM7zh7uKp3RFMetK8l2cyANeZIH+fNqF9MP6/EjU2bJeeyb4ceQ52T2zl1UCy2BbA0Sy4BOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nswbZK5UvjZS8620eq1WDLEAOe8wbzdlrxYGZvAWCOo=;
 b=B2NHO6eRxHQ16uGSrOgRZPT+SygADSE8WqCf8JwZpk4FbQCwUZEQo46LIWaYH0GFP+r8fir4go1Iv7pqED4K2ALYEsewxzJIBRRl+sGqbrE6qnk6ltiNVb4bUgfvh3ezFEynt347hWkXGHkeNDOQRGlJcBsfn+3feJ28HDD+hQagt7Z/YZlkUprWMrU/iX98uGFGPeBxFOsxl/rayzn1405G7w8ATC82+jSiUP3swWivIJlXPksKU3FKLPj2Wx33fUraU3IqgWMbYy/AhorwkV/9629lqaEhreIx+Qm5ct/Ulok/hkE/dvMG+JToMyUz5RPkh/aPpgQt6Yt6wnIOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nswbZK5UvjZS8620eq1WDLEAOe8wbzdlrxYGZvAWCOo=;
 b=oFxQSSuwNfC7xkwGlQbuyWi4/faYjWzUxycdUzVr36o81S2RFO4O6RTMt7NWOSqNin5UOpIOM5qLjJSYDJAkvu10Gz6uD+/A40wkcWW8lnTMFZbqd7sEABV1TgvVzwptvPGjZ+M/dPxRnMWEZzIPTySwUwav5VoETEearCbBD0zQYB9HhG4fF7OgvrQPAyi+xfAkaxPaAQ0fxLDKQjXd+mJUydRWZEZ0nkfP/637J64StJgm9SSa1bUzqzeyPzkSVOA44P3Bye6Jas4Nc14aE6V9CQ9NMjlrtEC3GBkrp97YddasIhhVrcGUbdfX+1p6svWbrnxUP8SCbI7+CK3Qig==
Received: from PN3P287MB0324.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d6::7) by
 PN2P287MB2307.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ab::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.18; Wed, 15 Nov 2023 01:34:10 +0000
Received: from PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a24:3fd5:dd38:3ecd]) by PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a24:3fd5:dd38:3ecd%4]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 01:34:10 +0000
Message-ID: <PN3P287MB032447BC501261D47E8E3124FEB1A@PN3P287MB0324.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 15 Nov 2023 09:34:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
To:     Conor Dooley <conor@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com
References: <cover.1699879741.git.unicorn_wang@outlook.com>
 <25fcbab4c04bcbbdc4577dc58822540829f91dc9.1699879741.git.unicorn_wang@outlook.com>
 <20231114-grumble-capably-d8f7a8eb6a8d@squawk>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231114-grumble-capably-d8f7a8eb6a8d@squawk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [atV7zRG6EpE2v1qux4+4kWfemna0s+gZ]
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:d6::7)
X-Microsoft-Original-Message-ID: <09097826-b2f1-4af6-9056-0355d012bdaf@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB0324:EE_|PN2P287MB2307:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e5e42b-07c6-40d2-e084-08dbe57af6d0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47vGdFp3dtQ4vrcuN+b7lJDJdHX2OdBv7n5Z6s3S6O5bc6KBXR/g1pHbPzu/1HeySn3ubJBs6mbKkrn01VrLPsE/W7LHxhYMzDQg1KjYzrYrG72Ik/Ys66tMVj3eCZIMmYk2v4pd5736ZQTVl7ZNnK52FdjyIDK5aj3V22Pp6/hUgy2HtXtgVhbm62biDg1zdmVwDDt5wOuIJTuF6kSYPrRJp4VS15sfcISRQtCyaLH1kZMsbH72A+a65gMnOmPff3LiClo/wsj3NtVGILbln+p76JQ/YsLyq+27tHeB3G0DHRPJIiVIk+SJhGSvH3MTpgK/7D+/Fzmi1wo/yUMHbFNDUqmpkc/+2Mknpcd/IX+o2d92CmHhOwsnvPweevjXJdtkhPGocF0oo4AzRcOE4gqx/ytHMKksaFwJ3Zs89hnZvDL9PfwqBdzhCMeecEFkQhZ3Ohx4CfZLidB2pa48Nt++QEiOMttZcAqAUpRbV47ay1drpVn4o/tEQbkISwlW/232s4rJ5tl/51NPsGe5KBZpUOXHjE4r7n/mIOwTXwyWJKucejG7FdX3y1sQ/b6+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czFETHMwcFYvMGFqVHRSRU1Ddk1RaUlpeDVZNWlKeEZ0Q3NFMTNseGZYcWg2?=
 =?utf-8?B?WkR6eTE5N3NaQTZDM2s1Zis5UHJGS3pZYmdWOXpNMmRRbHFFUjhpbjZpSzhz?=
 =?utf-8?B?bEpuclNtSGZKWkJwaDI2VDB6cHp4ODdBL2RtOVFtMzlCU1AxeHpuY0s1VnpP?=
 =?utf-8?B?ZjM1MTRBa012ZVVsa1p4U3NMKy9PL1N5c0xqK0xEd1FrdFJvN3IxTlQ3aVdY?=
 =?utf-8?B?WUdTb3RrV2pLSG5UWXoyc2FBcmh0c0Z4ZDZIclNtVlZxenNSWXVWUUVma3Ja?=
 =?utf-8?B?NTgwY1hhQUNZbTUyYWEweXNGWkM1L090dmtDU3VnMDFrRCtGbndwNThraUtN?=
 =?utf-8?B?UDViV2RzekxWT0VFN2lweEp5MnBrSStLQXd4eUFtc0tINlhOVzF5VVMxVmVV?=
 =?utf-8?B?VGZhUlJGOW5MaWJiTGJWRFVOaGpUZlpPb25pKzQ1SVVzWUYxcVJlenRHUjNo?=
 =?utf-8?B?Y2tLOEN0TVhUaXB6U1RHOVBkd05BaFN4Qkg4eTBJZEhlM1N0SktBWCttOEc5?=
 =?utf-8?B?RG1yMVpkYllrK2luS2NTanJqejRqYUlaUUR5djNiSEVxem8vWlJPdXJvOWs0?=
 =?utf-8?B?ZEhTNnk3c0dTWnoydmx6RFExRjhHK09XUC9yaVVKbTZMWTZIdE9KU1E5MUlv?=
 =?utf-8?B?MjNUREVWaG5ObWYyb0pIYWtILzNIU1oxcUM0VCs0NVBEZ3Y4RjBWamlvQ2pK?=
 =?utf-8?B?dFphZHdRZ200Wm5rTGZkT3VhZWZ5NWpJaTYwVEd4dUZWM2o4VHBIT1VPQTJh?=
 =?utf-8?B?MTRjaGR6WVpyMTZnMS83L3k5YnZWRU02QS90c3kyU2FlaStLVTdQWWpucHoz?=
 =?utf-8?B?M1AvYnVTcTBHcWJEeWxyNUx5S3pkR05XU2oxUmM3VzRHSDlwTmw2K1NVeWEy?=
 =?utf-8?B?ck9xbWN0dXRDc2d4SGNOcnUzb1ArR1BxWG9CR0U4bnQyRkg1bHBJeGVDdGE3?=
 =?utf-8?B?NEl3b053UnZ0UDRDRDNIbUQyRjZnQ0lpYzhBbGFycXlPVWdEdHZVZXoreUN1?=
 =?utf-8?B?MTNUL2ZycGJPY1RsWkl4Y0JDNVJJNHNoSUFRbUt0YTRqNXcwcktZeXg1MnUv?=
 =?utf-8?B?VzJNemJNdkUxZ2kzMUZXaXAvd0xwRUR3VWZzdWxIRDlUSUtuRjBGTzFFYjVT?=
 =?utf-8?B?KzRodU9JbmNxeHVWZmJRUmFsd0NrOGxTaGRDZzFNcDkwY3grU085QklwNWZH?=
 =?utf-8?B?MzdOY2dEbjlWbEswbEh3cmRnUlQzRm81cElmYWcra21OOEtxSzBLR2s3RnZQ?=
 =?utf-8?B?clpQMEFkY2RGVkdqSnZuWTlaOUJaVGpGZkJnc2NmNmNsZEVCc2tWRSt3ejR3?=
 =?utf-8?B?bjJ0d29iNzQ4QlVpYXlTVXRyZmQrQ3NGTlB5WUt2RUV1Uk83QktRMXdKaGdR?=
 =?utf-8?B?ZEhlNlBoeGg2N1lIcW1sVXVjUE43dkZnbnpSQUtCN3ZjRnp0cmZVY1JVYzZv?=
 =?utf-8?B?RFRmQnZpNTJSU25FLzBUc3gxVzIva1hEODVpODVuZXFnU2VaeHlpdnJXYzIx?=
 =?utf-8?B?MlA4bVhEKzEyRHJHTUlsano2eEZqQjUvd2t0aHA0T2FkV3FjbWJVbHNGMCtG?=
 =?utf-8?B?RG9yVnRMRk91aWVrLzhKek1HanNkY2QvT3Mvcm9jbjRMbnQxK3NsdWNjT2pt?=
 =?utf-8?Q?JxatEtpaEcqGkPc84C595wvMwQL04Zfze64xX2jio+tY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e5e42b-07c6-40d2-e084-08dbe57af6d0
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 01:34:09.8869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB2307
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/15 1:31, Conor Dooley wrote:
> On Mon, Nov 13, 2023 at 09:20:11PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add clock generator node to device tree for SG2042, and enable clock for
>> uart0.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi | 76 ++++++++++++++++++++
> There's no need to create an entirely new file for this.
Agree, I will merge this into sg2042.dtsi in next revision.
>
>>   arch/riscv/boot/dts/sophgo/sg2042.dtsi       | 10 +++
>>   2 files changed, 86 insertions(+)
>>   create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
>>
>> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi b/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
>> new file mode 100644
>> index 000000000000..66d2723fab35
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
>> @@ -0,0 +1,76 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
>> + */
>> +
>> +/ {
>> +	cgi: oscillator {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <25000000>;
>> +		clock-output-names = "cgi";
>> +		#clock-cells = <0>;
>> +	};
> What actually is this oscillator?
> Is it provided by another clock controller on the SoC, or is it provided
> by an oscillator on the board?

This oscillator is an individual ic chip outside the SoC on the board, 
that's why I list it outside soc node.

Actually the "cgi" is abbrevation for "Clock Generation IC chip".

>> +
>> +	clkgen: clock-controller {
>> +		compatible = "sophgo,sg2042-clkgen";
>> +		#clock-cells = <1>;
>> +		system-ctrl = <&sys_ctrl>;
> Why is this node not a child of the system controller?

I will move this node to child of syscon in next revision, thanks for 
your reminder.


>
> Cheers,
> Conor.
