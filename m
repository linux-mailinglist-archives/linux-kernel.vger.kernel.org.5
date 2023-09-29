Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F7C7B3395
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjI2N3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjI2N3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:29:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C555B9C;
        Fri, 29 Sep 2023 06:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL+RDXWWSi2B7SPJ/IkjjUfH8snj4P+F7mKwWokaKbro0KWa2Qz5ZjBsyM69no3j9SMNPI+v4nxTrtW/VdAbCjAZeDVNUayi8/V7sHN+yHJuG0LXBnaKZTG6B7gHWW1cWfSq4+P0CFa0cp2J55+1GTXHodxoqsL9pVTFk7o/frLRwqdCUfi0d/5FXh0T9I5h+vcJQ4o3NBeVd2mhPaFq1dW7KuIOGZyUpk0xZ88c+GrK/kK8VQqbS3fiHx0OGbRMcdIHKNg8TwsUPSpwhpZrWX4rVMklGRgQez27hLrdeerOl/GL3RxNpFuZB65w2Cme0ECH3QnoGJZEB/VvKTNoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9Pq2+eoPVZCaISVG5xYIYcEuLvsbKIT9Iq5Xrg8EgY=;
 b=azfRQRpCnVPw6hH2sEvA1dHQ20NYijHxCy+flWoI6dz4M1glsE3NLBdelUS2k9j/xsKUf0B/mE6RyLfgMfoJmRzxwezHGq1sm8LdqMUPGNfKKKdrW7jxZg5RCBqvBIMikIYNsjJEyGHkrqGYV3Q/LFRQKsF+pG7KE9CLvp1Wg0pEjESmpbN6ZaZr4YTKqJO1BAVcIyu5ae7qrcv3Ehf7mWzdNDe9T7F1v4XZH+hQkTIdROuHbalkf987eBalZUa8VYU6SqVk7MxR7Tr4OPF4R0y3O3MzqNMvu4b3xtPyZh8fN1lm17AlPVea1r9b0NOYkZymwg+8nalu7riR4fJjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9Pq2+eoPVZCaISVG5xYIYcEuLvsbKIT9Iq5Xrg8EgY=;
 b=mEfcguh6W7cAkBz2JdU9BaKNTYhc5tF1pXM1dHMxE5BwBSUafahLGTVNj+nS8A4uS0aogu9r8K06PDEaAtmKYOP5dl/gGDZLMcDZEDGOsfgabbQ0r5u0n2nBGmzjesl0J0YMJMNaFj9HVCN4l1OVb40hVEXA8JWs14wfB9lyma0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 13:29:07 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c%3]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 13:29:07 +0000
Message-ID: <30e381f6-8f7c-a654-255f-ac8410d4fed0@amd.com>
Date:   Fri, 29 Sep 2023 08:29:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arm/arm64: dts: Removed undocumented and unused
 "pl022,hierarchy" property
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, soc@kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230928190859.1072420-1-robh@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230928190859.1072420-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:806:125::9) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM6PR12MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b65e35e-ed82-4942-95fd-08dbc0f00e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyIvrZezHKM26xqC/AaRRQXbtuCMrtFeD1N+8PwZSCB/3ngJpgVvs/1c+9qtvb4wYoSfjpIzqJ26f/8dLMBqS6VAz1S/62lz4uZum4KXneQXDczbVUNXSpv73y/XpfurDJjdh1otado4NIN+Wvgpq8YBm84U+8DssJGPJXIAmH7DApmRfq6q9KzFeAIPaS9yimbGyu7e+GLI5Qu0ZIiDGkWSXgCQxUA77zqfk7lWCiPXyD1Z2n//BjpS/rI02h9tEw1ZBI2hQ/v/JrYQ3kTLa+Ohz35BDaYfSOgZvh4zISRRcQAUau5TtfADBq7WW0cfw6o9dJ2hJFKg7WH8vW9m4eOjilGl/yVLlsA/NTXgpN8/TVnYdGbwoomYn+vQh+qn10Wi+6ekEmFYRNZqsr2GzCSLsN9DZYm1zmA0IeE+de1l/fksHqaasAwtwz3fD/u/o3O33+Oksw17JwwhzfN5t93r5P3k/j0bHD+f/jLO7IsTgRpYE2KBod1DPdg+g6/ynKZdJz6bWNDkmRffwNFdSAxhyAap7SVyQbu/jpFVv150BiisRvizxCAD1ACMmH/5zmy3bhg8Kr5KXpPK3HQrBO5Vwl692QWaZo0p6ybeV+jGt/UDcU+c2SFz/sWC7TSMRY52DyREkpefLwnkvrmP9lje0ZC3kKp7ABKvfdAVctM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6506007)(6486002)(5660300002)(66946007)(6666004)(7416002)(83380400001)(38100700002)(316002)(921005)(6512007)(53546011)(66476007)(2616005)(26005)(66556008)(110136005)(4326008)(41300700001)(8936002)(478600001)(8676002)(31696002)(86362001)(2906002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RCtYSzRnVEhLQ1MweTU5aDgvY3R3Y3ZtbFNUdjFLc1Q1SHJZQm1LbDRLM1Zn?=
 =?utf-8?B?Z2NKSFFiZnBvUzJDVi9xR0tWTGlPa3VTY3NBVnlHZEVXcmE0eUtEcGh2K1lw?=
 =?utf-8?B?cjRQZWpZTGtWOWFIS3FDb1h0ZzA3eVNGakExNGhaNWhVR0xCaXhNNldTOEdM?=
 =?utf-8?B?SzlwT2lZSE9XSGNjeXcvdDdhdTNsV1o5dXFWeGNudmlnUkJVdFVIOUgxLytH?=
 =?utf-8?B?SzhUbWF4OGJLOWFhcSt0dnZ4SHdhaGgwbHI5WVNhMUdnNVhvVXQzODRHM2NH?=
 =?utf-8?B?VjNRNUNxRzdqbFY1SzRXR1E2NDZNcFRTRitOTzliSDZtLzl4VDA1VytXdkxT?=
 =?utf-8?B?V0JaVmtMMHhTcm91QTltanRocjVCL29mMkpqUHVBS0o3WFJyRWJiSCtxcjlB?=
 =?utf-8?B?eldSOG5pS3AwdTdJWnNGeG0xWi9nTWtmb205amszY3QySFF3NEl3aXovK0RF?=
 =?utf-8?B?eWlRZVZjckdKQ0Z3eER1TkVKVDFuTlExaGZBNnIrNStmcWZZekVsaTh5UUZY?=
 =?utf-8?B?R1Rya0szWDdjdVJsTVZsQjV1OVdrQ2FaNkVSaUdvamVJaVdXcHBFMVZBSDc5?=
 =?utf-8?B?elhSeTdwSVV4TE1QM2VvSXltTmdqZzlRNUlhbzNobVZhRFVmSGR1U0RsYVo3?=
 =?utf-8?B?ZmU0eVJDVnd4UE1YR0lsR01nUkJMMEVaSXI1cURLNjlsSS9uMFNtMmMvYS9X?=
 =?utf-8?B?K0lvK0VCQ0xPU2M5UnZ5MDhPNmhHVDhhTDM0L09xeEN5ZVJFRlRQRHpzbkZ2?=
 =?utf-8?B?MU9CN1I3Q2xpMlVaOVVUOGl2em0yeTJMVlZ2TGhaRWttaW1qODdMcit3Sjhp?=
 =?utf-8?B?OGhyL3Q0cldLVmFXS1VHbWVoUS9FRTJkV3UvZWxYL2hnZkJDODVIeVhzSkxD?=
 =?utf-8?B?aStkUjdVWHdraGZlLzhhZ1BOWjc1VWFtc2Y2Qmd0bmtuYXowUUdZRmxLSnVZ?=
 =?utf-8?B?TjZPeTBYZ1RXNGxJWk1KenZzRk9hbTNxZUZZTmRzZTNpNVBReHVHM3l0Nksr?=
 =?utf-8?B?dkVNZ1BjZDdwamY3YmRGSU8raUF3MHNOK1dPUFBzaHNWR0hlZmtUUExyeG0z?=
 =?utf-8?B?aHdzYlRKRVB2WHErTGJ2MVBFbVY5R3dnM083Q1h4Ylh2cEFMalVLVHlNbjlS?=
 =?utf-8?B?cldBcWl0RW0ySVdROHBhbEF6Yk53dlRVeHVRYjJYUWh4UVlYNERsdTA0azFz?=
 =?utf-8?B?a1pSZFFLb0RzNFRKZGhVWFlXZkFwdFBibTB1SlhVN2hDNzZoZFp1R2Nsa1dO?=
 =?utf-8?B?Mjk4T1ZGZ2tjaHRpaEM4TDZTQ1NESUJiV29xRFB3T1dSYXZTRng1UWZKSm1w?=
 =?utf-8?B?M1pTMDNJc3VBSVkvMXgvZ0pWUno3OWJ2MEdVcVRVU2ZLNVJSWkR6Ymhhem1k?=
 =?utf-8?B?M2NiUnhaSURUSVhsUXk3Tm5yWlgvWS9xQlU5ZWRzOWdEM1pRL0tuOWhRUHRY?=
 =?utf-8?B?bkNQMmNjcHhoM3luM1JJWnFtZGIrYUY0bjA2LzRlUU0zWC9SL0UzbzgxMUxi?=
 =?utf-8?B?bnVpc2ZaTHRuTisvK3A4NDZoMUpLMUdhMlZ1U255ZTgxeWJjMnRDK3RzZDZG?=
 =?utf-8?B?bkhRdWE5OW9CUVh6bjFQVE1tZDVYZUV4UVhnUy9QSDJQRVp6cDJ4NUhwTUVm?=
 =?utf-8?B?VEY2VFZ4U2ZlNmZsVXF2VENOOW0vanBFVElDS1dLN2RVWVZIYXlFS1lucnFK?=
 =?utf-8?B?TmhvMmF0VzZEUDhkYkRJSDFYZ1ZBazNadHBNMEdpWTNOaERubDl3WXpSSWVL?=
 =?utf-8?B?a091VTdDWkRRcExua0d5cGNNMmc5WWpTVFp2VXJOYW9CckFrZlg5SjNNZVIy?=
 =?utf-8?B?MjlSU2dVMitkaEpBQ0xVYlJHZlRGYW1FQ1dOREVmb2FlRHlQdXprNVpCRHJy?=
 =?utf-8?B?eklyY00xRzZrL1orSWw1ekZocnQ5Y1dIcklOWmMrcm9FTTEwTDhHamRvVjcz?=
 =?utf-8?B?d0d6cnBuYVVsV1ZRUktCYlI3dExrOGV6cXcvbmdjU3hya0pHR2xvZDBNTFky?=
 =?utf-8?B?MUYwZm1GVFF3b3BlZU12NTl1M2NhRWFFbWQ4azJZV3FpMWNDTUlVTkdsSE15?=
 =?utf-8?B?RTNUdHFMdnZYWnkwVFpmVDNJdTk3NXRrQmw0Y2hHQUk1QkZxN1ZGZU9FUHNX?=
 =?utf-8?Q?Lk6R1ScN2UFiYwYEEKu1DICMW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b65e35e-ed82-4942-95fd-08dbc0f00e88
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 13:29:07.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4I9HPnelxUHxBCGsSbvq1swmb3ntoULAdxXDlFFUAK48BPqvBGt3bUFjvpo9sba1vXU9zYeqLUTTH7/ONxfOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 14:08, Rob Herring wrote:
> The "pl022,hierarchy" is not documented, all instances use are 0 and
> isn't handled in the kernel driver, so let's just remove it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> Arnd, Please apply this directly.
> 
>   arch/arm/boot/dts/st/spear1310-evb.dts              | 2 --
>   arch/arm/boot/dts/st/spear1340-evb.dts              | 2 --
>   arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts    | 1 -
>   arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts    | 1 -
>   arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts | 2 --
>   5 files changed, 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/spear1310-evb.dts b/arch/arm/boot/dts/st/spear1310-evb.dts
> index 05408df38203..18191a87f07c 100644
> --- a/arch/arm/boot/dts/st/spear1310-evb.dts
> +++ b/arch/arm/boot/dts/st/spear1310-evb.dts
> @@ -352,7 +352,6 @@ stmpe610@0 {
>   					#size-cells = <0>;
>   					spi-max-frequency = <1000000>;
>   					spi-cpha;
> -					pl022,hierarchy = <0>;
>   					pl022,interface = <0>;
>   					pl022,slave-tx-disable;
>   					pl022,com-mode = <0>;
> @@ -385,7 +384,6 @@ flash@1 {
>   					spi-max-frequency = <12000000>;
>   					spi-cpol;
>   					spi-cpha;
> -					pl022,hierarchy = <0>;
>   					pl022,interface = <0>;
>   					pl022,slave-tx-disable;
>   					pl022,com-mode = <0x2>;
> diff --git a/arch/arm/boot/dts/st/spear1340-evb.dts b/arch/arm/boot/dts/st/spear1340-evb.dts
> index 7700f2afc128..cea624fc745c 100644
> --- a/arch/arm/boot/dts/st/spear1340-evb.dts
> +++ b/arch/arm/boot/dts/st/spear1340-evb.dts
> @@ -445,7 +445,6 @@ flash@0 {
>   					spi-max-frequency = <12000000>;
>   					spi-cpol;
>   					spi-cpha;
> -					pl022,hierarchy = <0>;
>   					pl022,interface = <0>;
>   					pl022,slave-tx-disable;
>   					pl022,com-mode = <0x2>;
> @@ -461,7 +460,6 @@ stmpe610@1 {
>   					spi-max-frequency = <1000000>;
>   					spi-cpha;
>   					reg = <1>;
> -					pl022,hierarchy = <0>;
>   					pl022,interface = <0>;
>   					pl022,slave-tx-disable;
>   					pl022,com-mode = <0>;
> diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
> index 21149acb6b31..1a65f1ec183d 100644
> --- a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
> +++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
> @@ -64,7 +64,6 @@ sdcard0: sdcard@0 {
>   		reg = <0>;
>   		spi-max-frequency = <20000000>;
>   		voltage-ranges = <3200 3400>;
> -		pl022,hierarchy = <0>;
>   		pl022,interface = <0>;
>   		pl022,com-mode = <0x0>;
>   		pl022,rx-level-trig = <0>;
> diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
> index 99205ae1b46b..52f8d36295a8 100644
> --- a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
> +++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
> @@ -76,7 +76,6 @@ sdcard0: sdcard@0 {
>   		reg = <0>;
>   		spi-max-frequency = <20000000>;
>   		voltage-ranges = <3200 3400>;
> -		pl022,hierarchy = <0>;
>   		pl022,interface = <0>;
>   		pl022,com-mode = <0x0>;
>   		pl022,rx-level-trig = <0>;
> diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
> index fbf0392b8371..dec5a110f1e8 100644
> --- a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
> +++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
> @@ -113,7 +113,6 @@ slic@0 {
>   		spi-max-frequency = <5000000>;
>   		spi-cpha;
>   		spi-cpol;
> -		pl022,hierarchy = <0>;
>   		pl022,interface = <0>;
>   		pl022,slave-tx-disable = <0>;
>   		pl022,com-mode = <0>;
> @@ -137,7 +136,6 @@ at25@0 {
>   		at25,page-size = <64>;
>   		spi-cpha;
>   		spi-cpol;
> -		pl022,hierarchy = <0>;
>   		pl022,interface = <0>;
>   		pl022,slave-tx-disable = <0>;
>   		pl022,com-mode = <0>;
