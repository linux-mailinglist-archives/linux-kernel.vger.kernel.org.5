Return-Path: <linux-kernel+bounces-6947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1B2819FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B74282EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB132CCB4;
	Wed, 20 Dec 2023 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S9gY4mCE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180225545;
	Wed, 20 Dec 2023 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNeyco9AL6h3iH4xsoeftu8JOLq1iEeFZTByBLG5lZ9y5OqDCb1vhOp3tzQRuGWeF8vPZA5NGNT8cYppk2p9OvlFuZ+QsfgKF7AKceDcwElIz/2cXU+3ca+vpS1kDpJyh0WCwTzOZN2hYrr6s84Nf0m9EjlBu6LbE8obOZ9P4VY9jIUmgwGSCwH+HsJpf8bzrOlDx5UzJRK0INoc3gxKUmul+HwvsJQq/yMtVvV6WtpQpnyCFGAlz4059Kmq78KlQyFnR8D04xv18e4GXorT1vd878m9wi+vzDYpqqoWEtoBW0DKPw0raczW9P+WOHrDAQkuRAc+ukxTIjtwgdlQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogIzZFG52wwwqrXbxP9ptVZkqAv9oQcQSrKxwyZPw4o=;
 b=Ek64UnUA8wHgPPeBgfXySgOs/koo/6bJMYF5XpfBnNsV1PMLNM2147bsAx5f1O7rxLXyH04ZV8PMiGupMHHyAq2A+flH3N3vcnc0xbHKs635yhyaFkiagKjFpv3bVr/R6tQsLXjsYiOqBEE9Y4//EPmuPObJje0QAYBUCzlSxIfISVh8COpuVN5a+YUYFmV/Vtq6RjwtpGlAhtCPrFtZT5xvOlbh/olN0/TXstLX+QGu6xujW/49Jj6YsrjcubeDf6MguhVRYKhAC4EeHHKyFl+/cCEwg8EouFSvp7iqS0/awautH7nq0eVrM+UCfwF4kpRCrYpTzt5E2bWXLGTaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogIzZFG52wwwqrXbxP9ptVZkqAv9oQcQSrKxwyZPw4o=;
 b=S9gY4mCEntWbVKXk2Cj9UW/NmojLJaUkDaWrIedWzS9my4hfPsJ4jK7KyPdh7eN+MRhl9Jz8/QNe2Uxz9P2F9NUeozkU/z64eNT6yfNjkdRw4MDhAxKXnOM8Tn2mRxHVSKfxzyq/kYoabijMooRWYQJkohGF6mB7BRoiOcuBC2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 13:14:52 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 13:14:52 +0000
Message-ID: <6ab19ceb-38ed-4e4c-aabc-a959bc123cf2@amd.com>
Date: Wed, 20 Dec 2023 14:14:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] dts: zynqmp: add properties for TCM in remoteproc
Content-Language: en-US
To: Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231215235725.1247350-1-tanmay.shah@amd.com>
 <20231215235725.1247350-3-tanmay.shah@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231215235725.1247350-3-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0182.eurprd09.prod.outlook.com
 (2603:10a6:800:120::36) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: e633ae34-8659-49f8-ea24-08dc015da69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YaWSu+CpuJ4jBvVxy10RD7812SIaEtGdDuxaJig01nsZialJs0aZNzCYxvmhwknxDb1gm++T+MGFd5Dz/2s72sK3huYmGgl4diaxb4IjerqBli0UObhmkN+eVbVCM7bNmjwXBT9K/cM36YH9iugAK0o173uc+pXzt/PYVMxXm6ssvcL6ilJSaS5r4pjaR7VumbpY9ttKiHf0hhC1q2JtI/Xjeid2XnMyOmbaFUeV094D6pLOQ+wyoj++t8FV3tcCuF1NxCYeWkZrlNJq7vvjqZPPcVoBA3Sug1QcmHN6L0ChSFZusecD26tepZichXNEv2Xs7mAZTk41/kS9kYApnhMX//FxABW+soTPnbsmHxiR+dByaXug7WgpHG1/azr4eXTjw28swWGR5k9pgBduPbBK4/uU82VK4+4J9YQVTn7hhhwTOYfRzd92hl2BbVORvEzXUT4/IQwbPlmWDExieeyyepDhNU6YahyqdLc4/tQfBnJZc/ua1KK5Hyb+kQ60pAXkW/0WGDXlkABztKGUoBlFncIghpMCc+jI69UVdsHgsret3HReYl3NEQHhVv2D6djDM+V87yCkYtUfG31rQLdtYquA6smNe4/mmJoUOJfG2LmHjZjkCqKYm+NXlMkpPJAfy9n8Guzu2/4GLaQCsg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31696002)(38100700002)(2616005)(316002)(26005)(83380400001)(5660300002)(41300700001)(4326008)(44832011)(8936002)(2906002)(8676002)(478600001)(6506007)(6486002)(66476007)(6666004)(6512007)(66556008)(6636002)(66946007)(53546011)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWJVVG80SE5YSTdOcjRJZ0ZqMXRZdlNqSWZhR1FjQk1lSkpjTHRlblhlQmFo?=
 =?utf-8?B?ZERnRWpQK0dFdWJtUGMxOWdMbE1RLzhTL3BIK3RHaEpRNXo5WDliVElHYmxL?=
 =?utf-8?B?WWFXZGNnakI1TjMyN1JvRXFiNHNyR1ZLeGxOUmJQQkxQT2o2aHlGVnFNTUFl?=
 =?utf-8?B?SDBWVUFWc3RvR0pZWmJMNGU4blFoMWtacjYvOVhTYVRVU0lTOE5BeVZDQjJm?=
 =?utf-8?B?ek80WDdyOHhOK3JZRG9iSlFHYkJJb1QwOU1jYzZ5SnRpREhVUTZjUU4yTDdp?=
 =?utf-8?B?bEszRTYzSGlUY2QyMlZLRm9wNTNxNzhOWXlKSWtHV3k1S2tTWDQxYmZlVFZl?=
 =?utf-8?B?cWkzOHJaeXRoNnIybFVuL1RLeWxDeER1Qzh3N0VnVWZlc3JVSkppRTdnTVl1?=
 =?utf-8?B?bE5SVjlRMXQ4aFJSeUhGOFYxNnpXb1dyZTdOR05yVnBIdFEyZktVUEZDWUhB?=
 =?utf-8?B?bUJMK0pKNjI1VVErT1Y0SS9CMmxiby8wUi8rYUhFS2NCY01zUjRIbi9pL1dV?=
 =?utf-8?B?cTFWamQvaDdNbnkxREdTd3lDZmhoZGNiL0tBQmFhcS9qNTM3REoxTTBEZHl2?=
 =?utf-8?B?MEVsSGROZ0dObUo4TW9Bc1dENldMWXh5TnIxWHV4NXFXRzhXK0JGV2M2Z3dR?=
 =?utf-8?B?YTNzcEpOcEdTV1hDSlhNeHRWd0U4QUxrVERXOVFQVTZyLzhaQ0tMcFROSU0x?=
 =?utf-8?B?Q005aWZtcXl0SXRrTVdQUDlaaTVuSDVacTFDYXdGYXlVTE5QSzhMb1FoMUxq?=
 =?utf-8?B?L21VTE5YdktLdEE3bU5CT1YvWklPZTVRSHBqOHg0bEdyblRReE9sL2QrZzFs?=
 =?utf-8?B?ZlF3UlpkeGtzcGxRc0FuOFJrTXdrblc3ZWRzdXU4TFR0RkVPTnF3RDJTUjBZ?=
 =?utf-8?B?bTZIcC9wUm90WTRMcXlweUlxSm1lcGs3M3pWMExZd1ZSRitxblMxY1o1QzVF?=
 =?utf-8?B?b3ltQUlPM3MyWitlMEpYc1UwbjdDQUJUZnpLMDhOTmV6Y2FkTXdHSlJ5Q1Rn?=
 =?utf-8?B?em1DRjJkSlIxQ0d2QlV3YUYxY2hjRDQzWHgrRFBaeDcyaC9XbTdleUlzdDdR?=
 =?utf-8?B?UlZST1BWOEh2a2ZKbnZaU1ZwK1lEWHpUR3BzbmZhRFd1aFlueTJUVXo4OGc5?=
 =?utf-8?B?U0FkMkNCQ2FueWhCbE5wRlo3c0IzcHFIclQ4YVRlZS8yVytmSGU4dmhvOTRD?=
 =?utf-8?B?cVhTYW41cXJXREhwYnRxd0RPV1BBVTlBWVVuQTYvcU9QN05lK0VyL00yM0dN?=
 =?utf-8?B?L2tTWWRUbi94elpuU3hkNzR0WFFpQzREL0lsZWVFZ0dDNFQ4L0tkVWNqRUpu?=
 =?utf-8?B?OW15c3lIeC9jSFBOTVZ5Z055VHBVMGFjOStKQnJ1bTFVcGorZUgwaUpSbjNt?=
 =?utf-8?B?SEl0MytlcjVRa3d2eEZqa2hvQm9JVVNhZk5GMFdaOElxY0Y2YzRvamZUbTZ1?=
 =?utf-8?B?VU5NdmxiNjM3QzNUWmFGN0E5NXZUbkE3eG43cmg5dlBsNXVuQ255akdZVUFo?=
 =?utf-8?B?U3pyRzhQaWs3RktWRmpmblgxcDBUOFN2OVZTY1ZWMXlVTjZNV2hpUUJ5N3No?=
 =?utf-8?B?TENNL1hCUUhDbWs0UERFdHRYT0NtR2V0dnRZWUoxQW0wc2QyRWZTNWtwME96?=
 =?utf-8?B?NHdKQXhMaklHNFcyNWswdmFsTG9TTWdxN2Z2MnUxWldwVlNxRktKbGg2Sk1R?=
 =?utf-8?B?Q0FUSEVGMmE1ejlJWEJTYXBRQmpGL0c5TWx2bElHR0pSaHcxL2s2bndkZE92?=
 =?utf-8?B?OUlCdHV4TkZ2YXV5ekswMVVhNzhZL0cwMVRpdS9xc0FWM2VtbldjUEtPLzNj?=
 =?utf-8?B?dVBxSEYwTm5panYwR1ZnRTR0R0MyaWJ2WER5c1BsVEhuSTc1N1Q1bnZXcndy?=
 =?utf-8?B?RkJoRDRnT2p1bmplTlpPR0FUU0Z6cW93OUFyWllhVVhYeXVzSzdiYi9hcHdU?=
 =?utf-8?B?Y1hGMmhEYTBEZVYwbktmQ2psVEJNSWNNcitIa3VzM1o2dGRaM09KZElqZ1l1?=
 =?utf-8?B?dDF5djJ5R1c0UXdqSFk2WFBBVWMxMkF5NEowZUEwRHNIbVVGa1hOSEdFT1pX?=
 =?utf-8?B?V2h0UjBJcWpiZUF4d1Q4RmVoSU5RODhzeTNHRHl2UEtFRVRKRFNMbmppLzB5?=
 =?utf-8?Q?BZredkxkxKKaALC4gxV/LgYbp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e633ae34-8659-49f8-ea24-08dc015da69f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 13:14:52.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OY5GB+FfM2Ft7vBiwE3Mm706clRTMAFeXdu8Y5toINn/alBklzbMQX0WAEQzVPRX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798



On 12/16/23 00:57, Tanmay Shah wrote:
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
>   .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |  8 +++
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 60 +++++++++++++++++--
>   2 files changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> index c8f71a1aec89..495ca94b45db 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> @@ -14,6 +14,14 @@ / {
>   	compatible = "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
>   };
>   
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
> index b61fc99cd911..602e6aba7ac5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -247,19 +247,69 @@ fpga_full: fpga-full {
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
> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x20000>,
> +			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
> +			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
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

Let me know if you want me to take this via my tree.

Thanks,
Michal

