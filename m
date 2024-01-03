Return-Path: <linux-kernel+bounces-15848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93B6823442
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D862870F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A7E1C6B5;
	Wed,  3 Jan 2024 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ORSG1kp1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171591C68C;
	Wed,  3 Jan 2024 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBqQ7XCI6EbtlVNfNB8yTnWR4OfUkiv3JobrudoTWQjzulJNdE5VAUsq0P0lmyTiFSuFF3FAEwNun0qRQsRyl7jmvJeM1EHMUA1Fo8oxJJ3jRYXIeXS/2/l3nfu8y5YTtcN19Z4ddqIcqCY4R/y3y3UX6cEnXLSnYg/jr9pGzauevrp7c/1VTcm04UZOQ7OwbUS7DkPcOZIz+mxUocYVMlrDzo+ZYuajlidNDjgHwMNMQqIpF+VKUOSKGa82LWTrjgv2GzJ/T2QAFoWwdA9XQl7Ax+i0RTqPAlTHSadkvoN8vK+hNDamTaJX1HdvoMbOQoGJxgCtRQoGNvq9RPEZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SK7mCdkoj0N6wkcjU4H7NjUBVzcz/jI/mdjmr4nGObc=;
 b=oFPya2mjEa9V0+yhMBlSrxAuLb/co3a5MAnIsEkSUihDr3mQYtNPqboIbvB1AaldYgc+u4BdCRJKtzt0wcywpZ1Fz8IH1alWSRoYQblMdpNsOosiKk2HQT0Kz1tOdKJI51HdDocCKgD7tmQycIseLIi0+tqrY5poEkVbTP9eUp/ANvMhhPZt19zGu9ZOSrEYPRyR3DiI/g1b7JFswfWT1a9ntQXD4EtdPK9o6D//kIToz4HfJm0VnYZ+4NR3RGweC6mm7kjSGTLX75hXod9uSJqS3wVqiGQvR8sTlNA1SKOgifgwRFFLfeD+9CFAQ3S+q9XwH8Z6Xi79U0D4WIVoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SK7mCdkoj0N6wkcjU4H7NjUBVzcz/jI/mdjmr4nGObc=;
 b=ORSG1kp1PGKoo9enfJY9fgh1gtYn40x67wRKkHXBMNpxtC9rWdDn8PvR+O57Hsm6TyMWvNiyNBHqErKExHb0occMKnPIS5danSGVqRTo0+7kpZ7o4dD1i8umI3zQR4P6mohRCgujzCCxaFjIz/4KBSNJFO1Mt0ZobBhYGa9or4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 18:19:25 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 18:19:25 +0000
Message-ID: <ceacb4a6-7768-43b4-a3e7-ed8e8665f5f6@amd.com>
Date: Wed, 3 Jan 2024 12:19:22 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 2/3] dts: zynqmp: add properties for TCM in remoteproc
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: "andersson@kernel.org" <andersson@kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>, "Levinsky, Ben"
 <ben.levinsky@amd.com>,
 "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231215235725.1247350-1-tanmay.shah@amd.com>
 <20231215235725.1247350-3-tanmay.shah@amd.com> <ZZWfUkrQc58+GATN@p14s>
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZZWfUkrQc58+GATN@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:806:130::7) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 823068f0-c5f9-41d2-f7cc-08dc0c888428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8KRKc07OlDX+0Th+z77BsmeBWe1Uy6XcTF/GTsZgjU1ZuBtT3uPO5n6oy3LnmSHwiW8HGVmtHx7Wpvy9QYPPIdR9TLyPdab2p5MyIseQ7hj19jXGoCgdTmHQDnW+ycSJTxcwwp/WrbVvhMIFwSbZWS6nkz447xhfn+Cc4PtVWi93UTE1WVfWrz5exRrpOaGxd/HlyYOff6rujIMQI7ZE+FGSbnofqYjby7h+S/l4nvN8d63U6BbctI9VllP1TvtzlyT926OnrQUfKrSQM95dCTYvOzAE3DV95EXNJRfQtutYBp/RK4lBN7wKCes3Ux7/a3/KxKVI0FoNkRerykhns5Spx0N70aM68lTabQ/IgczFH05XCPtOXkOjl5I4qsA9jNg9rZ5FnJu/FOu6NTZ2HyGVodDccFGHdDUYfPfchV9pxGK5ZftEczE5shijyUcacksPt0vLgp2E2RjcJ/gEJsrsEYol1xSWO5gtXwoCP+J7afBcyL1767ccmk8tPdzH6wj+g1IlmST9BfT9P7MpD2RkLOGy+jnOINZ6wsE7n84KyUqON5nPbLrQNhJADwUkNyBD7dJSh+427oQVYFRCL+iNLhkS4yIUTJxPg70vwUi4IwRJ1zPBSpQyOi526qKFhnLdumWJomcisf11R66hSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(38100700002)(31696002)(86362001)(36756003)(66946007)(6512007)(83380400001)(53546011)(26005)(2616005)(6916009)(54906003)(5660300002)(6486002)(66556008)(478600001)(6666004)(2906002)(66476007)(316002)(6506007)(44832011)(8936002)(41300700001)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW5SWGFvcUxYbEt6UzZyRitGMjVIZU9CclRKTFd2ZzBhQVJWdXRPT1hQZXZS?=
 =?utf-8?B?Nmxya2M3WnFZYkV6c3dPTWFpOGIwVGdjYzBkcWdaQVdGZTYyc2NXR2ZqbCta?=
 =?utf-8?B?RGpEMXVOVldIWTZpc2hNdkZqamtWZHJZMVJPUk9XcCtTcUlhS0NLOThOa2lq?=
 =?utf-8?B?eU9IL0o1RHNiaTJVbTZJWTR1ZEt5eG5veERrdVNXZTZZMVpqZGVpYWM1VTdR?=
 =?utf-8?B?Wmhoa0lEYXlFV3YvdEJPYVo1K2lITXpIYlNSTDN1djZGakoyZ3p2VGVwc2Zy?=
 =?utf-8?B?RzVmN1hEamRyRE0yaisvdTB2S2lXWUJpZHBJRDQzZTNkZTU2Tk9mSmFsNEVI?=
 =?utf-8?B?b2RxaHVpK29HREViN1pQUk82aytUMkRjQlV1alp1cXg3aXFkaXgxV3BzRFRG?=
 =?utf-8?B?emFJNVVFOFFVNHh2S1BnZUdaOVk5OFdxd0VVNmlJK3pYSjhyVEFsOEhPNGpx?=
 =?utf-8?B?UjRsSGhqSitGeUw3bVdneW1BWHZNTGpQZVh4SnZvbmlKR2pwYVB4d1FMbkUw?=
 =?utf-8?B?YzJpdVNXWGpjRkpHSTlsaGNWd3NzUjlCbTRDWUdERW12a2NMSGRUY3B5U0Jl?=
 =?utf-8?B?UG9zUWl0ZjRJUnBaZmdnZ2tjSUlSdHNmVWxSU1FCdXVUVHgyMjFwNUx5SzRZ?=
 =?utf-8?B?L1g0b1JOTTdjNkpQaHFsYTkycS9mVG1qeXBqNlI3aE1PNC9DS3VXWHpSRXNa?=
 =?utf-8?B?ejlLOW5VU2UxeUtCVlVyUDNhOTduRzZFYlk0ZU5ZQ1FJS0V5eTlVZ1hWVk16?=
 =?utf-8?B?MTJnaGxuWi90dmVBS2tXQThsZXh5Z2dkdWRjQmtlY3g5UG9UYTRrOEJPd29X?=
 =?utf-8?B?aWtoTE5zQ0h5MVZLM1pKK0VSM1FXSUVrOENaSHBiN2s5SmJCZjR6czZEMDJu?=
 =?utf-8?B?d3FNa2dtY0xzVzRFYUQ5anQ1RWlEZVY3SXptOXFiSW1IVU50b0dlNnBqR3NP?=
 =?utf-8?B?STJpZnVkVk9Xcko4MkwxTEFhQ1g0M1R5UGpneVBNdktYbkprdG40SVF0T1J4?=
 =?utf-8?B?M093SXVnMDZ2NjMvRkszWEFvVFlIOElmcXRsRytKQ0Npd2VUUUQ1Z0xaNDl3?=
 =?utf-8?B?djFWNXdmRTZZQU9WajVESG85SVdwYmtUajQwVHMxdFRUbDcxa2lIcWFGNUV4?=
 =?utf-8?B?ZS9wZm4vTCtqQS9OTzN4Wjh3ZkVTb0dsY1Q4SlBMODZKR0ZlY1pHOHNRZkh3?=
 =?utf-8?B?SHM3a0FUcktTVnkvWVhvS0hNRWYxNy9RRVczblpNbkxHc1luNFFRUXVwVGpQ?=
 =?utf-8?B?SkZoeVB6V3llZVlVTXFGWExoRnpEbGF2ck92RDRaQnRrNi84cW85VUxqeGMx?=
 =?utf-8?B?djBNSTRKZGdnNWpNQThwUTZTWitKelBLUjVQZXpodmMzK3puSHE5c1M3ckhD?=
 =?utf-8?B?MEJIcG91eTRNZHJiNFBLVUdnQldTVHhSM01xdmJCNzBjbmpXcXN3dkdVbjUv?=
 =?utf-8?B?V0lRT3JJQ0dUbjk0UklEZ3hpMHd2eG1hNFVISGx1b1BxalV6MmlLNVJ5bHNl?=
 =?utf-8?B?dGQ2di9ReEhwc3VFUHVoM0J4Zk5tbGhleFkyTEJBMnZzVjJuQjkwbWpMMFVJ?=
 =?utf-8?B?Q2hMWklHRFRYOElFaTRJUWZCNjBXWkg2dGVlSW44NUdjeXFoOWd3L1B1T3J3?=
 =?utf-8?B?eUpxb0wxOEc2NTRrZlJ5cHdvZDdpL3llQjZPNVVoTTRQdkp5SUVsSkt2b0hD?=
 =?utf-8?B?ZEJGa1dqNWx0MkhoQU5GWDdFMkU1WnMrQkxWa1RSSG5SUU5RQ1NwZXJ3T3Bx?=
 =?utf-8?B?YnMzWjFoS3RVTHI1Sm9ZMHIzMXZQTUFDdVdZRk1NZ3k5VmVpd2xhWWdEeGFo?=
 =?utf-8?B?eS9WU2xma202SEpyMWd3em9HVjVBb3hrd0lBYkZsaEtpMlRMMlBmaFVVQjEy?=
 =?utf-8?B?OUpLaGZyVjNuUlF4SmluaXpBdC81aTBMRTBMWEo1ZjRSSGZkbkJnemg4dE12?=
 =?utf-8?B?UDBZbTVlbmVIRjlTYmcybGdldUhBcCtIOUx6QnN0S215Z1VoQTlyMnNETW9P?=
 =?utf-8?B?Z3crSlc4MzM0SWx5c29FQnU1dnVnVmZhTjFNRnRzMS8rbmRhSVhZcEoxNk1F?=
 =?utf-8?B?YVRZa1VSQjI2RWo0aGw1aGVvUU1ySWRpUW9lakRuRGF5Y3lINjF2ekRVR1pJ?=
 =?utf-8?Q?hF0Ah4j71utK3t9f8wyeTSde+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823068f0-c5f9-41d2-f7cc-08dc0c888428
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 18:19:25.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LAv94oHvXnChqcvQY2fWGbTAGQcyKEWPN/aFZhDSZl13J25OJ9kHeYnyeK3o/oh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317


On 1/3/24 11:54 AM, Mathieu Poirier wrote:
> Hi Tanmay,
>
> On Fri, Dec 15, 2023 at 03:57:24PM -0800, Tanmay Shah wrote:
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
> >  .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |  8 +++
> >  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 60 +++++++++++++++++--
> >  2 files changed, 63 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> > index c8f71a1aec89..495ca94b45db 100644
> > --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> > +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> > @@ -14,6 +14,14 @@ / {
> >  	compatible = "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
> >  };
> >  
> > +&rproc_split {
> > +	status = "okay";
> > +};
> > +
> > +&rproc_lockstep {
> > +	status = "disabled";
> > +};
> > +
> >  &eeprom {
> >  	#address-cells = <1>;
> >  	#size-cells = <1>;
> > diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > index b61fc99cd911..602e6aba7ac5 100644
> > --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > @@ -247,19 +247,69 @@ fpga_full: fpga-full {
> >  		ranges;
> >  	};
> >  
> > -	remoteproc {
> > +	rproc_lockstep: remoteproc@ffe00000 {
> >  		compatible = "xlnx,zynqmp-r5fss";
> >  		xlnx,cluster-mode = <1>;
> >  
> > -		r5f-0 {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +
> > +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x20000>,
> > +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x20000>,
> > +			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
> > +			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
>
> As far as I can tell, in lockstep mode the last two entries are not needed.
> This is also contrasting with that is in the bindings, which is quite confusing.

Hi Mathieu,

Yes I agree. I think it should be same as of bindings example.

However, I will have to test and make sure no impact on driver. I will fix it in next revision.

Meanwhile, are you going to review driver changes as well or do you want to wait for next revision ?

Tanmay


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
> >  			compatible = "xlnx,zynqmp-r5f";
> > -			power-domains = <&zynqmp_firmware PD_RPU_0>;
> > +			reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
> > +			reg-names = "atcm", "btcm";
> > +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> > +					<&zynqmp_firmware PD_R5_0_ATCM>,
> > +					<&zynqmp_firmware PD_R5_0_BTCM>;
> >  			memory-region = <&rproc_0_fw_image>;
> >  		};
> >  
> > -		r5f-1 {
> > +		r5f@1 {
> >  			compatible = "xlnx,zynqmp-r5f";
> > -			power-domains = <&zynqmp_firmware PD_RPU_1>;
> > +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> > +			reg-names = "atcm", "btcm";
> > +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> > +					<&zynqmp_firmware PD_R5_1_ATCM>,
> > +					<&zynqmp_firmware PD_R5_1_BTCM>;
> >  			memory-region = <&rproc_1_fw_image>;
> >  		};
> >  	};
> > -- 
> > 2.25.1
> > 

