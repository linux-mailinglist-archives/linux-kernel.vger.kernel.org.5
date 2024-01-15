Return-Path: <linux-kernel+bounces-25791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C36F82D5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9668E1F21D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF85DDAF;
	Mon, 15 Jan 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ltPaxDcU"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C072D308;
	Mon, 15 Jan 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh19wP7W2WlE0LhJj/NbzwHuZ/4XMMIVGgn1kSy+vuWUc5JuFxCFnvyJ69KuUdI4FUe3Bb/9L14LFF+N29G7ORQ57bZlAFVKUaa3SeXlxV4LA/gKaW669FwFIBTwfs42fHSwqZlpBs/PzmuWZZAp5xU/I7bBVttoqOvm8I62XQTxpfKg1bjQUKNfaKwZlo1wZAfgZT5jvNlK3q1OUmvCoEr04tfPFGjoXAUffEwTCG52owuszJSoWXOE6Flj8sv37ns9uWWOrVvb6g3gDXCeE+kJ37AL0nN2mtjkbiqgVZnXJmdK6Um6YUCCud1e2nXuQQgpyt26Md0q5cp8dhdqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecXMdI++1WY/Ecdw43rfL0enzxWaY7HDT2csK0XTTa4=;
 b=B1JEMzfahP+UFIQ0Dz7+cFQO87jjKXi46cELwVPEaMn22nRj8wPvwPgQ10gxG8m1sTqREpyx4kal1x87QwPyxEckHG4hbTmtypvmtvTQNGR02LPw8UpioYW17WFC6u54HQnndkzjPFdIjx9S1lfjvVQw96U7OMwprcAS19cl8qVZjUbScy6Y+MS49SEZ5Gt+WzttwWzAQeeCTGWNljOmt7rqUjpZIuFDEMwiQtRgPCLRG4QcAjczCIvK2hETMZTI0buVJR3mSbg+2nAyBxG9hqC0S5YTNCkQ0s9RXrvM0VrP5gNaL1qe0WgntObZwRd9Vb/zC9Uj7FYg80ahcLPcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecXMdI++1WY/Ecdw43rfL0enzxWaY7HDT2csK0XTTa4=;
 b=ltPaxDcU4eFz+Jvn23zyash9JtE3Cv/YzJhAQplyPEGekB2im80r6yEVHyWSE2m6scGJ/BbdebN/+zwUX3hwkvG9iM8LfoyociM4cpnPXXmF23jvscYPArr4Pqidzzw5ZnPQm8/WDq56x3Nk+dEZQkO18PHqVB5MAaMQGEDGq24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Mon, 15 Jan
 2024 09:24:31 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 09:24:31 +0000
Message-ID: <50d68d85-b03b-4407-977d-adf054a840ab@amd.com>
Date: Mon, 15 Jan 2024 10:24:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] dts: zynqmp: add properties for TCM in remoteproc
Content-Language: en-US
To: Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240110213504.3626468-1-tanmay.shah@amd.com>
 <20240110213504.3626468-3-tanmay.shah@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240110213504.3626468-3-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0069.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::22) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BL0PR12MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: 539f7375-e066-49a0-7488-08dc15abc785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H4BEfcmmb23crjGkLd8SxmQp5oYCB+rhhQSQj4RTRA1KwRxh1TQEmxj9iqzMKTmKCTyGJWzMeB+0xfsF7ftpQZLcYw081R5ev1f+iZQKDDnwDe8riQ+sxI//ZUEnBBhSXZcV7VhiLrCCasqoWILMJRl80ZCaeGf4rrlgVMnGZyfGX1jEcEzr+AkRJoYKSGsW/7TQhsG7IlQcAGTqPfKD/gMOdmtMI84nozo9pNpkA20NUT8LHMeg8ZGQSHr/saweYU51GIE2WX5ZzX/g+QCqL6OLPVeAd0Ee80tNt/NMarnphStpcXhaOW6rHtsUS+oo9mINn+4ZshCo0/ZSgJWetLfa0qkruNDwUUX/Sj7YrJpOWYyWVGI6yEI/mJNEnTvLDZrM4sMDPkMCChoD1T6MS3gbi4ci3XeO/vTuJ3m7FouCiFVsejCo2xBNNjecvJVBp0r+wzC0Rnyvxtv5nhZ7CaeVX+hjtlaMhhsfyhSZj9YHsEAtiw43CeRtV6kgv4md4lCtpUVuzyEyuigvuLYGfiP9ZLWrIkl154gHifqzH4QcdYl/D2sy+qMZIxt79ZKWbPQYFHMDD9qlDjpoIliNNfW1MQwg0u//ih2tbbaq0twMZekDeScZZhdI8QGTiqYWk53uCjYISvAkkTQS4QEu9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8676002)(5660300002)(4326008)(8936002)(2906002)(83380400001)(26005)(2616005)(38100700002)(31696002)(86362001)(31686004)(53546011)(6506007)(6636002)(6512007)(316002)(36756003)(6666004)(478600001)(44832011)(66476007)(66946007)(66556008)(6486002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDFOamtRWWNPU1NUUUNkdURqdWt6azdGV0NTVGpiSHVCU2JScGkzUjgrZVJq?=
 =?utf-8?B?a2d0aWNnMWlLQndPaXNXSkM1Q01RbHVuZEZQM3dDY3ZJVVFWZDYxZnk1b0oy?=
 =?utf-8?B?VW9mTGgxTFBuSncrQnR2eGZnYmxGQ0FmRVQ5eXdEQWlERWJ3RUhKaEl5Q1My?=
 =?utf-8?B?WUgyK3VUMnFoU0k4Rnlud1JESEFUbWIrWDVqazMxaGpnei9PdkdaNjZranBJ?=
 =?utf-8?B?QTc4Rjhza1RBZ24vYUdaVkFyTFdmOUFBNFc4MnNqWWViZ2Y1b1RtbjRISVpq?=
 =?utf-8?B?U1JoUytORE5rTmFWWjYzK0RBdWdwRlp6OHhZSjJ5Q2NFVDlqU3FucXB3UEYz?=
 =?utf-8?B?MjdJVFNGRnZNQ2FzQWxrQ1VZVjZ0RHp3QVlRVWFvc09UM00zczJZQ0lkV2da?=
 =?utf-8?B?QmhibWo2SzZZREM5b1lBbC81UGUwOWRHSHlkVGNTcU0reUZ2Z3JHOE0zZWdQ?=
 =?utf-8?B?bllYZUJ5MU94d2FLOThld0tScVhtTEorS1VVUE12Z2tSam8xeVoyNWxQMlN4?=
 =?utf-8?B?VzVZMXlnZHRsenV3UjhoRXpsU3lWNG1Sdm1CWDVFeXZGc3VsdTBHTkR2eW5s?=
 =?utf-8?B?bTNPR2ViQWllcUt2YUpoQklDODJBam1BalRRTGIxdmtNU00vcXdObWZYMnRE?=
 =?utf-8?B?dGxDa2tLeVFkUG1hU2lDQXJHT0VqNmtNN01md0FsSzZpc0I1cmJkVktKRENS?=
 =?utf-8?B?VGtYRVdoTXNKWGhGZVorTnRBMTN3aUhjMmJWNWtuWHAxQU94cWNrNkQ1emlU?=
 =?utf-8?B?M1A4ZStrZGNxSml0dURiTG94cU5NYzJsMTZHaU5nMm9TZVd3NWxoM0llcENk?=
 =?utf-8?B?b0VTVTlQV0JPNGtDbitBS1I3ZThsdHVYUy9PeStHSHJKVm1BWDhQeXFsb0cr?=
 =?utf-8?B?cHdxZmVLK0k2T29zc0lUU0xmMERoVERoeWJTWTRnSnlOU3JWQWlQZmVyejBH?=
 =?utf-8?B?TFBmUXJZZVdHK3kxS0FKY3hTd04zZjdnaXJrRmFzUkZHdE9XZmJHbWozdmJi?=
 =?utf-8?B?L0FuTXdJSWRhcGZxRFZJL2xOelZxbmZCVkZUdmNPb2NhZTVBZGZPQ0p6UVZl?=
 =?utf-8?B?UlY0VC8wQWc2TGxLQ2piQSt1cllTZDlsL040bnYzVHQ5dkxBUXUzblFkSGtk?=
 =?utf-8?B?Y2pZbFNvRVFXRkJSVldxa1Q1K3crNThCYUNLdUh2M1NjNHJRYWIrbENtMTRh?=
 =?utf-8?B?dnhFNXZKNjVEakovNFhENjVWZWZKMmhmSXVWVGNPeVR5c1RPQzRhNmZLTEk4?=
 =?utf-8?B?RkNGSUxtN3hjcXBVbWRxTVpTU2xBak9BeW13ME44NzhsbEVlNjdXMXM3QjdM?=
 =?utf-8?B?c1p6eW5MWi9pdXJ1T1pNbkg3QkcwcitCN2pleit3K1dWZ1VROVJjODBTTkw2?=
 =?utf-8?B?WG1kc05BbWVGazhPRVduVVZqQUxJeGs4R24zL3RNM1JKTzViUVJXZkJ4aDNq?=
 =?utf-8?B?R2wwT3hOMVc2NTFwaTdZNU52WUQrbzhDc3RmbG1vbS95cXFRV3ArUE53bThi?=
 =?utf-8?B?L3NWQ3ZIZlNiN3lLQ01zSUk0akJPekJnWkpZbU5HKzF0Q3VoM2VoQXBRRkgr?=
 =?utf-8?B?QVRaU2kyMlZEN1BpTEZ5QVVGM2EyY2ZEWUgxTVkwSnptS1NFbzVLWW1oeXZZ?=
 =?utf-8?B?ZWRLbHV1R3g2TEZVZ2JwbTEvalk1WDNkYmgzV0hmdTFvQlo0anhEb0hKRXFm?=
 =?utf-8?B?akN5WnJXeW1QOC9KZzlXWEtXd2wvTTlzM3pIRlRCVzFLeDNIVS8xc0ptalVG?=
 =?utf-8?B?eUFCY3ExOW9xNkoyWW5rMjQ3QzlUdUNTZ2ZHY3FsVmVxVllnN3hoVFJZaThz?=
 =?utf-8?B?Mk1nUXo3eGp0M1RHeGV0SUpFRzBucld1VjZvWjhuRU1EMnczZVNhbnFYYnZR?=
 =?utf-8?B?SlNrbndtRDV5dWg1cFdGcS9EWUxYcmEzb1JpZWgxTW5waVl0VTIyMEl3WjFq?=
 =?utf-8?B?ckRZYnU4a244enc1V0JjMUkwNXNUL3FFSmFzZlpvOWswRmNPYlpYRHR3OHlv?=
 =?utf-8?B?a0FHUElsUjFsSDdDdzdrQlQ4NE1Qc1dNT1BtU1lBUlRxRW55V2pITThiTXZy?=
 =?utf-8?B?TVFnRWd1Z1hzNXV2TzRPQTUyZGlYVUd2S2dzZlNUcnNPYllXSXRVK2d4aE9M?=
 =?utf-8?Q?NdOVjEhHtA2gDeKtxhH07r8k6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539f7375-e066-49a0-7488-08dc15abc785
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:24:31.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b618Sm+Nh57kY8YhQJKkf6mXhz9/CKwu3rRNEQ1XJXl/nBRJRjUtLPL/KkH0Cfn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4882



On 1/10/24 22:35, Tanmay Shah wrote:
> Add properties as per new bindings in zynqmp remoteproc node
> to represent TCM address and size.
> 
> This patch also adds alternative remoteproc node to represent
> remoteproc cluster in split mode. By default lockstep mode is
> enabled and users should disable it before using split mode
> dts. Both device-tree nodes can't be used simultaneously one
> of them must be disabled. For zcu102-1.0 and zcu102-1.1 board
> remoteproc split mode dts node is enabled and lockstep mode
> dts is disabled.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v9:
>    - fix rproc lockstep dts
> 
> 
>   .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |  8 +++
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 58 +++++++++++++++++--
>   2 files changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> index c8f71a1aec89..495ca94b45db 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> @@ -14,6 +14,14 @@ / {
>   	compatible = "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
>   };
> +&rproc_split {
> +	status = "okay";
> +};
> +
> +&rproc_lockstep {
> +	status = "disabled";
> +};
> +
>   &eeprom {
>   	#address-cells = <1>;
>   	#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index b61fc99cd911..cfdd1f68501f 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -247,19 +247,67 @@ fpga_full: fpga-full {
>   		ranges;
>   	};
>   
> -	remoteproc {
> +	rproc_lockstep: remoteproc@ffe00000 {
>   		compatible = "xlnx,zynqmp-r5fss";
>   		xlnx,cluster-mode = <1>;
>   
> -		r5f-0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x20000>,
> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x20000>;
> +
> +		r5f@0 {
> +			compatible = "xlnx,zynqmp-r5f";
> +			reg = <0x0 0x0 0x0 0x20000>, <0x0 0x20000 0x0 0x20000>;
> +			reg-names = "atcm", "btcm";
> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> +					<&zynqmp_firmware PD_R5_0_ATCM>,
> +					<&zynqmp_firmware PD_R5_0_BTCM>;
> +			memory-region = <&rproc_0_fw_image>;
> +		};
> +
> +		r5f@1 {
> +			compatible = "xlnx,zynqmp-r5f";
> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> +			reg-names = "atcm", "btcm";
> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
> +			memory-region = <&rproc_1_fw_image>;
> +		};
> +	};
> +
> +	rproc_split: remoteproc-split@ffe00000 {
> +		status = "disabled";
> +		compatible = "xlnx,zynqmp-r5fss";
> +		xlnx,cluster-mode = <0>;
> +
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> +			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
> +			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
> +
> +		r5f@0 {
>   			compatible = "xlnx,zynqmp-r5f";
> -			power-domains = <&zynqmp_firmware PD_RPU_0>;
> +			reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
> +			reg-names = "atcm", "btcm";
> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> +					<&zynqmp_firmware PD_R5_0_ATCM>,
> +					<&zynqmp_firmware PD_R5_0_BTCM>;
>   			memory-region = <&rproc_0_fw_image>;
>   		};
>   
> -		r5f-1 {
> +		r5f@1 {
>   			compatible = "xlnx,zynqmp-r5f";
> -			power-domains = <&zynqmp_firmware PD_RPU_1>;
> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> +			reg-names = "atcm", "btcm";
> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
>   			memory-region = <&rproc_1_fw_image>;
>   		};
>   	};

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

