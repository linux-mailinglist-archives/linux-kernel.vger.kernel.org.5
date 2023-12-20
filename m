Return-Path: <linux-kernel+bounces-7076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B622181A154
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31175B22F65
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76553D3B6;
	Wed, 20 Dec 2023 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TOQsrn52"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632743D3AE;
	Wed, 20 Dec 2023 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKijD9tKzSCNHGgIiAD4lD5UuoOT2WUQTr60PDXwmLCXvKaXax5SoavjjVZgl67Vx/TZYMzoWTjhF3tXp7/AbQGULQ8+3KpSqHXTbzCufFpK4AbW9uytch7NIH/Ds0rl9Tmx0QhPAjc1FMwfzmjvjsGYmm4AcHquKbGDrBQ0/+PfES7Z2f0OBCrsWF5a/d8nfj3zRIWuXHmxioW6exyar2N7lFj+iWmg+1Nut1+W8ZnEy3AK5aX6zbtzR2BGyDk0uqyT4i3+yDYuLYzOu5Jqxw3LBMvRCmRx/fu/tx5zFI6U3vmY0gGgsMhe2BDpS0VnUmgK9dRDuNIxCD7tBOfqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzdcLfCsm9YvPGwQMnkMN5aN2rocfsjti+/mPk23cNA=;
 b=lSpunEQiECIyXVRE+YxUuOj2EXcJTwelTQpxGgI/xszEwDARZR7XOOYdU5THz8cdfd6AlCfHJpQB/BUXd4TCG9TwT+U/Mt39+X6BVeYChETy4U0A/yUvq/4ah4F/UjJGBxXlOi2iTL78NekaJRxnzy05Yq6nmkyLnZuLGKEJpJpdyvUa2teXzY2syV7tU/qQ8xuChwnuaBZ4YiR6UMpjPBarsojG2TrGB7kF9vJQbu4Dpfukhkdhc7Tjrwvza8eejsHEEHmRj7z7C4oerOSopqplhto2+NgdUE87bNQcU02c0dH7bhBXO1EOL8uu696h/RzdHGrSmtFlUyNtXu3SUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzdcLfCsm9YvPGwQMnkMN5aN2rocfsjti+/mPk23cNA=;
 b=TOQsrn52RE2/4gic1rXYukrd8vyLI82PxwVDoqw2RoQUg4wxH+QIa7Llf1zb0k6gy2Pd6gizUHf1TDp3AuI7nGV6ueV5HJbZ2hTsD7jd6uCEJQ2AbmGKOm17uJRwvbRD2RLOFLKB5eVTvctTYaqMOLA5oGlNQkffOwmaU6nwTUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 14:45:05 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 14:45:04 +0000
Message-ID: <e9e9777d-f8c1-48cd-b433-0292c77f6d57@amd.com>
Date: Wed, 20 Dec 2023 08:45:01 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 2/3] dts: zynqmp: add properties for TCM in remoteproc
To: Michal Simek <michal.simek@amd.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231215235725.1247350-1-tanmay.shah@amd.com>
 <20231215235725.1247350-3-tanmay.shah@amd.com>
 <6ab19ceb-38ed-4e4c-aabc-a959bc123cf2@amd.com>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <6ab19ceb-38ed-4e4c-aabc-a959bc123cf2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:5:40::25) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: d19e6217-d755-449b-ee23-08dc016a40c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TUeHoE1QTpI+vZTXbHR78sFFoazPuwE3X/HJdvdU0y3nUuzY2k2Y50t8GlGqCW1SRbU5jDvjr3LvgBQSv+aMuXgGjbRRO5pmqdUvZ0Dbdk/a9p7wkpKakfYN+Q5rZe09Rcq40X09+s7zSTIDOUhIMBc2/Hmgu7QajV1N3ZiVA5HMYVHwniyOsCHNvGnhVnbOohtdpx/m8x2JulBhY2Fbko+oWYtLeODuVZPNXaURpO4dT+XpIFyEj+fA/Wo5IOwEIu2ObcQgvIvGnRwwUWuTJAwuSC1q36DzMUn91pOUhN/8TB93I5YvT0hKG7nwMbftevvLXn7LapVUZ7mR6Rq6RO+yKltcWpNZa1eYzKPyEWSn8jvYApsN12JpWXOQLADoWzhrdP8ayCPPI7jJ/Fat7iDQ1qGZ/OL+xwlA3wxEg+kOrPkupcV2dyyohHydUzkrtxNhvaOB9ZDaWBKTXqY1CKm3yHa3tCBHr8HLQ+hLHXRLYiJGuGQFL6wQD6QhNGSkH0gmyB0U0fhus+a0ZGPt/38N1ivk29QIqiJCu8bsfegv/MddoFPZZlcmN7MjYPZXtE3iichRzoRN7AW7iaPlmv3mstoJWeghCjtLjFezqXUc3HRCJHt4xFw4BnYgg4SwdaNtd1kojlSdvaYa4MGSMw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6512007)(38100700002)(53546011)(26005)(6506007)(41300700001)(86362001)(31696002)(36756003)(83380400001)(2616005)(5660300002)(2906002)(6636002)(8936002)(8676002)(4326008)(31686004)(316002)(66946007)(66556008)(66476007)(478600001)(6486002)(6666004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alRMV1dSaktGZWk2NE91NExHM3Uza1dRRnhSK0ZvOFgvZ1c3OFhPTTQ4NWRk?=
 =?utf-8?B?Q3I0TXpqMU1EOTFUc3dMcFJjYmc2aFZhVFdTRzdlbW1JRVJtRVpSRk55eDhx?=
 =?utf-8?B?OTNFaENNbExFMkRLa2IvRE1LeWR5YTdxbXFtUnRFSStySzNXNzFDcDd2VHZy?=
 =?utf-8?B?YVh0YmM0VTNmd2paeWQ1KzRxTXIzekkrMFlSZ0wvRDhuendZbTV6YXNpUWJB?=
 =?utf-8?B?MnNzR1ZMWmFHa1VmRCtNc1IweUQyb0dtNk9VbjdKdFR4NWZiUlluZkd5Mmpk?=
 =?utf-8?B?VXNZMWRMZjcxdmp4VHJtR2Z6aTdMd1JVdjlPcXFaZFlPdWlqV21ROVZhYy9v?=
 =?utf-8?B?L0tJSk81YnlMSTVuOFFhdm8xRWFHcGxMS3VRUkhHbUU0WEQrbmpvMTZ6V3l1?=
 =?utf-8?B?ZWQzOXpyU2NkTE01ZE1EcU1yMDh6a1NYbEh2VzVlR0lHQkVNZTU5MklwaEEr?=
 =?utf-8?B?Y1cwbjRvcW1BMWxNTzA5QTRXaEM3ODc2QjRaYXVsVldCcTZoZ3lMcHZNbE11?=
 =?utf-8?B?REl3dk10dFlFcjU5MGpOdTl1V0NEeVRMNVRaMHYzMHV2RVp6QVczVFpBaCtj?=
 =?utf-8?B?Smw3a25OUFR0WXRpQmFGNzA4Q2VKdFVHeW05cCszRlZUYi85WDFyVEhmM3Z3?=
 =?utf-8?B?anp3c3NFMFNKUzBncVREMzJCMXUzbXRpU0EvYklpZFBvTlNFSVZucVJiN0Vr?=
 =?utf-8?B?aHcrdVV3UHcrTUNPY3U0Rkt5TEtoVm5DRkw1VGZ1Vm53em9Kc3NLODdyZ2wy?=
 =?utf-8?B?MmtFbnMzdTlLcE50dG80YTZuSEtZcGY0c2VQMFBXcytwZEhvek1CZVB0UGJ3?=
 =?utf-8?B?Tk44WVpIcjhrZWk5em1BbW9kTld5MkxCNnh1aTlHRzl4NnRLcjZUNVM4Wlly?=
 =?utf-8?B?OUZHd01TZ0NGdkY0cldKdlZLaXM1NDgydjZ0SWRoZzhhSGNVY0xoSjZsM0c5?=
 =?utf-8?B?alVTbG0xT25YUGpnclVIdUsvN3RiL2xhVUg0RUQydDRaZndSZlRzVEFzSDJx?=
 =?utf-8?B?ZGJnV3NBdk84U0NoMVdZZHp3NWN6SmJUVWU0NHJoTDIydlJ0WmEzMVU5R3JH?=
 =?utf-8?B?QlBORUNMR1VRcC9GaThVNVkvQmpQeFUvVHZ2bFNhSmtJbTMzZU1GKy9taXIw?=
 =?utf-8?B?UlkweDBWa3N0QkxxOGRnczgwUGxHUEowQ0JaNXBLTGE4d3UyU3Q5cXQ3Znla?=
 =?utf-8?B?OFBxTERuTnZGVDM5K1YwajB4cU5RZElEMjdoMGhOWjNHa1ppSStXWkpTQ05h?=
 =?utf-8?B?MHA3UzU4TDlTYzNwYyttcjNqTGNXRVRCdzlZcmUzVUNyNHIra3cvUzFpdHEy?=
 =?utf-8?B?ODhsUWxDREJYQ25zSmU0TEY2cFAzemNqeXh5dzl2TEw4VkUyeGU1K1B2VDR3?=
 =?utf-8?B?NzRDejdlYjJoUkg1VjBuQnJBYVU3Qk1oK21hVFovdHFkQWhiYk9XVWFhNml5?=
 =?utf-8?B?Y2tHQzNNQk1JZGhOWFdSMDBDQkk0TGxLdXZoOWFEUWxoaWp4SGRZOXAxbit6?=
 =?utf-8?B?bGVPbEhBemlHRWZ0d1drWk4vZzAyTmNkcHVvZ2o0SmdkSEpESktsM0Z2RXlQ?=
 =?utf-8?B?aVAzMHI2R2JDcEdTZi9NRmdpa0FBMXdxV21qNlFaNGRRcExrL0xqMmJ4ZHA5?=
 =?utf-8?B?ZmxrWjg1bmcvZVZDOS9tZkFDTnE5RXZ6d21CbHJYcm5JODJaRU9jZ3UwQUxB?=
 =?utf-8?B?cGFIb3EvK1ViOGhsbDVmUG90UXU3S1gvVEFOZmFZOTBIL3lDeVJyVmxDUmxz?=
 =?utf-8?B?Q3diekhMUGVLak9NdWFTM0pWc3dTV1h0V1RXR0Y1OE9pTDNSTy96K3lPNFQ3?=
 =?utf-8?B?Mnp2Q0pRbDFBYVV6eTBkWldDK3NYTURyOFQ5UFpUSzIzbG9HOWZ6dWVkQzZZ?=
 =?utf-8?B?ZzUyZnk5U2VzTy9RdVdnd21FK20za1lQWkloeG9ueFhGczNjZThPUWt3OTNt?=
 =?utf-8?B?d1dzTHlQWGd6bGU2dUJuK1JQS21lVmdONkRPUEVkLzcrNWRWYUFaRkpYN2Q1?=
 =?utf-8?B?Yy9rYUlBeDdraVI5N3ZVUE5GcmRFMXZnalRvVkdOUDFOdnNCR2dmTE9LTzNx?=
 =?utf-8?B?YzZwenQ4UmtDK0FGSXFPVVp5M1lsU3hqdHNySXVpbnAvdnRuL0dlb0VwK1Ba?=
 =?utf-8?Q?jbgAvqeEINNhuAbjmGD5iB5p6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19e6217-d755-449b-ee23-08dc016a40c2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:45:04.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K31QPcrOQc0C2caPZ6tzqETCOtmCUH2B73PsCEjZJ3oEaBfgkU3pFd5o46wpHsFe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194


On 12/20/23 7:14 AM, Michal Simek wrote:
>
> On 12/16/23 00:57, Tanmay Shah wrote:
> > Add properties as per new bindings in zynqmp remoteproc node
> > to represent TCM address and size.
> > 
> > This patch also adds alternative remoteproc node to represent
> > remoteproc cluster in split mode. By default lockstep mode is
> > enabled and users should disable it before using split mode
> > dts. Both device-tree nodes can't be used simultaneously one
> > of them must be disabled. For zcu102-1.0 and zcu102-1.1 board
> > remoteproc split mode dts node is enabled and lockstep mode
> > dts is disabled.
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> >   .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |  8 +++
> >   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 60 +++++++++++++++++--
> >   2 files changed, 63 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> > index c8f71a1aec89..495ca94b45db 100644
> > --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> > +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> > @@ -14,6 +14,14 @@ / {
> >   	compatible = "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
> >   };
> >   
> > +&rproc_split {
> > +	status = "okay";
> > +};
> > +
> > +&rproc_lockstep {
> > +	status = "disabled";
> > +};
> > +
> >   &eeprom {
> >   	#address-cells = <1>;
> >   	#size-cells = <1>;
> > diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > index b61fc99cd911..602e6aba7ac5 100644
> > --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > @@ -247,19 +247,69 @@ fpga_full: fpga-full {
> >   		ranges;
> >   	};
> >   
> > -	remoteproc {
> > +	rproc_lockstep: remoteproc@ffe00000 {
> >   		compatible = "xlnx,zynqmp-r5fss";
> >   		xlnx,cluster-mode = <1>;
> >   
> > -		r5f-0 {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +
> > +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x20000>,
> > +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x20000>,
> > +			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
> > +			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
> > +
> > +		r5f@0 {
> > +			compatible = "xlnx,zynqmp-r5f";
> > +			reg = <0x0 0x0 0x0 0x20000>, <0x0 0x20000 0x0 0x20000>;
> > +			reg-names = "atcm", "btcm";
> > +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> > +					<&zynqmp_firmware PD_R5_0_ATCM>,
> > +					<&zynqmp_firmware PD_R5_0_BTCM>;
> > +			memory-region = <&rproc_0_fw_image>;
> > +		};
> > +
> > +		r5f@1 {
> > +			compatible = "xlnx,zynqmp-r5f";
> > +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> > +			reg-names = "atcm", "btcm";
> > +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> > +					<&zynqmp_firmware PD_R5_1_ATCM>,
> > +					<&zynqmp_firmware PD_R5_1_BTCM>;
> > +			memory-region = <&rproc_1_fw_image>;
> > +		};
> > +	};
> > +
> > +	rproc_split: remoteproc-split@ffe00000 {
> > +		status = "disabled";
> > +		compatible = "xlnx,zynqmp-r5fss";
> > +		xlnx,cluster-mode = <0>;
> > +
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +
> > +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> > +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> > +			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
> > +			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
> > +
> > +		r5f@0 {
> >   			compatible = "xlnx,zynqmp-r5f";
> > -			power-domains = <&zynqmp_firmware PD_RPU_0>;
> > +			reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
> > +			reg-names = "atcm", "btcm";
> > +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> > +					<&zynqmp_firmware PD_R5_0_ATCM>,
> > +					<&zynqmp_firmware PD_R5_0_BTCM>;
> >   			memory-region = <&rproc_0_fw_image>;
> >   		};
> >   
> > -		r5f-1 {
> > +		r5f@1 {
> >   			compatible = "xlnx,zynqmp-r5f";
> > -			power-domains = <&zynqmp_firmware PD_RPU_1>;
> > +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> > +			reg-names = "atcm", "btcm";
> > +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> > +					<&zynqmp_firmware PD_R5_1_ATCM>,
> > +					<&zynqmp_firmware PD_R5_1_BTCM>;
> >   			memory-region = <&rproc_1_fw_image>;
> >   		};
> >   	};
>
> Acked-by: Michal Simek <michal.simek@amd.com>
>
> Let me know if you want me to take this via my tree.

Hi Michal,

Thanks for reviews. I will ping you once driver changes are approved.

Or Mathieu can take this in remoteproc tree, either way is fine.

But I would like to wait till driver changes are approved.

Tanmay

>
> Thanks,
> Michal

