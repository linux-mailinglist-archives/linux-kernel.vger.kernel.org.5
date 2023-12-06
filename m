Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C8780638F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346672AbjLFAlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346659AbjLFAk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:40:58 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2086.outbound.protection.outlook.com [40.92.42.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF83C9;
        Tue,  5 Dec 2023 16:41:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rr1aRcMaNoBJ5yGS6XXUyhVvrZuAfoNIwWqT0Gzi5e3k5UI48CmNKTO8aAAau0zAJ4h3siUobMP2+lrRDzs+tlBcfcbLhPxuP/ZtG12nCx9JPK4+X7deL58GBE9wlbQUFMWQWvSPWK8Kapt4G3tLzevh7kYgouwJwstdh0dwHeL4mBHsm0bCDbLoC2HkVD90KOgDW/HLsM99KSzFzE29o5f/+Aesvb9F2WGCeMjF+789LjYVqSRMDTkxsR+8AjfO5rRG+U180w47Y+orgYwq93uzmrU4CMkyWqf7hsFzhKrSNDP6lr0GCDGo8d/4bmwBUZNySbf8r1eSC+ak7S18Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urrIgbngN3cnl01OABEDrokvtPbJBgQvVtYkzC5HOYc=;
 b=RGo2KNOjiDHaS6Qlkqt4U5K7sGtoBl34JAomcC+GM7dUke8KC38CwVUPZCK2HO9JltTccqDrtyuaVhdwlSWtFPBcQiVhafwWFAdCW6D2Vink2C6L7+mvP3XYimBJJtoU6AJ+VlgfGcrwPAQhowHxyeLQtmz5UKEpp1T0P6dXrUrYIoyXvUHvo9u7zznGquPDYwnK6KRIUaS50W7V8RytphYdNEgjWS7Cg5B9eqgbLkLrrk6sJBFByamiVfQPCd8GToxjKvxT6yIxFxqx2t7yxdSJ3C5Fd7rMk8+EUvgTXxhFlSeLtFDAMFYsfGFJmCOnZIyr7Pw5NzPpjUdxmWF9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urrIgbngN3cnl01OABEDrokvtPbJBgQvVtYkzC5HOYc=;
 b=hTxGJUnCiJ/1VlStjjPI3BQPijnN95otEBslZ5p0A/oMjjF8mqeq1Fhh16kVWZH0KljlrwZHOpkt7/DE0Kmp4qOUqMH5Ko5WvAvUUp521JHEKPgUBxHrA8Bvv+LlDXnQrbEoUl7sgnqmAWGnMnQ4xAWavBQLmPojCyERTmK06h+eTav2bDtqLugH9y05NjbkOp+APidO1PWOlLWfXnIEsbwVyZWV/qqIoJkp9OoWEOJhO0dZxwHG2C1kEPLHZd3UCLdI234CAOXZ/qVLH6bq1uwGrjJPBzFA0ak554UHqgcHd70GC8IqlJYE7Et9ihAPybqvz2nk8JR4digYXFxW5w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB4956.namprd20.prod.outlook.com (2603:10b6:208:3ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 6 Dec
 2023 00:41:02 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Wed, 6 Dec 2023
 00:41:02 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
Date:   Wed,  6 Dec 2023 08:41:00 +0800
Message-ID: <IA1PR20MB49531F7CAC79B0CEBB141222BB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJM55Z8DU_OPJOYqT28wtH9EGFj=y9VVPcawOnYjY=U75pt2vg@mail.gmail.com>
References: <CAJM55Z8DU_OPJOYqT28wtH9EGFj=y9VVPcawOnYjY=U75pt2vg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [PUMrGwLtShyOYHTc2H10YRe5iLCVSoEULdlgeRyU7wI=]
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231206004101.131677-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB4956:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c6b2aa-e400-49f8-e963-08dbf5f40595
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjNStZ5D8UL6mGfZiPSJKBBDFZr8H9R1UyOdsO0Gwo7T+JSFP5s1xOoIC/03c/5LQxGEeIcE6As5KMXV6Z2VpC/Iw1dvAq8hzv+6Vo5PooXjAy8gtwN0lZbEAlE6uTNdnQ9P6zg9GJFQqMe9m5f7SuymlvGPAkPEXAQZ36XisLoXFTMRTlULcyl/pYZ2L4SU7DDUzvizb/OhB34AvqndtAxRUDjg49Gcqfu+v25vCbmKN/s9UnYFcfOs9boJHy0+GeM9bWgLOW9KeK0fUO/7Wpf8UTRODZDdtLQwrLG3I6G6Rgg35EFSkk/NSe/a8AoyzsOX63H/C/rRL571Wsc+n6bKXGR2tTIwNWpobJCgmWJXpq3DQhNMfGGeMKo4vBd7T8G6QjTB7Bv7HBzVCpwJETi+HEjGjQIxqLhOQGhEL5TyJ/NIqeXwwHRT1Gqg4PmnnWi17KzVcsH1Bk++YCtVmvFdU6KVO/Dswutk+Nk71q0Ej7U95T7CKe8PBw+pX2pcZUeIPZAikusTdfFMLr22D7y6pgWQhF7ueK/b8r76veAMHo7k5JoS+bBSIV9cHyOZ1RKekifTggEN3DuW+6FS3lJIUhVB147pFEMD7UxITsCCZ38Um+OOPWyPqOXyWzkd
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?irj19usirMd85FUZAJJFDvzqdgv3KOY5vxWn4abQpA6gTF9yvl04vbfbr2d5?=
 =?us-ascii?Q?5iqR+YFkixyXxzDQ+IUrrzIbD0dwp/tCGbKBnlnWTageSmrQqY6cct33YEK9?=
 =?us-ascii?Q?+jsMRpGb+fzI30BYExRZjut+f9eEfz5Za2vk37tk1aDM4IjF/fZJmeDtnVW6?=
 =?us-ascii?Q?Mur/xZjlsAgZ6tcM2BjRRmP5UyWom/wF4QvwMvZflz3L9AordEQ5NmfbGk7r?=
 =?us-ascii?Q?0GcWyVga6hFxCQIYig4L8zxqUV/Rn/yTcP1lMBuPSRYnlE2dDGsMGao2SNju?=
 =?us-ascii?Q?Np7usw++9b7XJxzgeFFBGFKImmq9kgRfQKMs5OrhM6/mag3WWaTVHFv53kvb?=
 =?us-ascii?Q?YS+xL+uAnXLl7/gqxvKsS2xjeXg40cAbiQSlRcQugjo0yvfKLI/bRWUpUg1f?=
 =?us-ascii?Q?cIteUhClvYVHDRtdBK8VyqhULXO87Ie/+hpRVCOcQUUvhzv/Z5XHQVp1usZK?=
 =?us-ascii?Q?m+nqUIFCLNEVQb6n9pSeppO44XbN4JTINDIcoE63r4mLfBxHO8EspFpfMHnw?=
 =?us-ascii?Q?LIsAVSZUANqAAJ8Y0xGL+tTpZThZBg5lFsLOJ4AhlMpH9ggxaANNtVht3Ccw?=
 =?us-ascii?Q?fB6WyOP4Jda2yeXq62G+Obatm74UtS5H7OAhpzG1Ntov2dKs/lKF87y4WbzJ?=
 =?us-ascii?Q?yUwoSqRm9tC4Dr3p+LV4MzK6dDpeXMlByAjSrncia25/XqGDYdBrmhuVDeN2?=
 =?us-ascii?Q?/X2QxcPs7fjiuNqz6Agd3CsY2qg8z+nN6RRgd/pgr9We5D0Y+GGf4qIdIHn/?=
 =?us-ascii?Q?mfNBjZPClQGzU2YXAWFkWepHmyKgupJtd57TRf++xdO9fereh+NBt5yM+fl3?=
 =?us-ascii?Q?G9eEPEzy+RJT3jjntRiPldR9bPXNminOOMUQJ/HEeVZi6dNgO7FYlPss1ae9?=
 =?us-ascii?Q?9ScbU6cpTL+Wysshx6+9GhfTWEpBXieARbG450l6wAKBdBNyE8D3v5cKs2ct?=
 =?us-ascii?Q?kE484nRCHGyoSwZpsARaH4//zpqmoHGFiKy7YWbbRU1bI15S/CIMlCQgLPFp?=
 =?us-ascii?Q?pxkhaPgLnJUvGXuavRsHK1IENRkuUUTQgkSE8V1x/Zk0xuoNPzloryJ6imZK?=
 =?us-ascii?Q?FxC4/eKXnzZJoUj9uG0yJ6bbnNPpBpftGq8QEK3bFbZih3HmjyZQ2xh4KvZF?=
 =?us-ascii?Q?8kGMcbzYiYc5zsYW4KUkn8FAXKyjGqf0vbXlH5fBnhsS22BjMZiHIY92/MQR?=
 =?us-ascii?Q?P5Kzbyljv70sC7C7jxckPY85m2MdRJFmEuDAWTHxyNXUjYSytSTPcjQCiS0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c6b2aa-e400-49f8-e963-08dbf5f40595
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 00:41:02.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB4956
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Inochi Amaoto wrote:
>> Add missing clocks of uart node for CV1800B and CV1812H.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> ---
>>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 21 ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>> index c5642dd7cbbd..3f290a515011 100644
>> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>> @@ -5,6 +5,7 @@
>>   */
>>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/clock/sophgo,cv1800.h>
>>
>>  / {
>>  	#address-cells = <1>;
>> @@ -136,7 +137,9 @@ uart0: serial@4140000 {
>>  			compatible = "snps,dw-apb-uart";
>>  			reg = <0x04140000 0x100>;
>>  			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
>> -			clocks = <&osc>;
>> +			clock-frequency = <25000000>;
>> +			clocks = <&clk CLK_UART0>, <&clk CLK_APB_UART0>;
>> +			clock-names = "baudclk", "apb_pclk";
>>  			reg-shift = <2>;
>>  			reg-io-width = <4>;
>>  			status = "disabled";
>
>Hi Inochi,
>
>When there is a proper "baudclk" defined the driver should get the rate
>(frequency) from that and the manually defined clock-frequency should not be
>needed.
>
>/Emil
>

OK, thanks, I will remove this.
