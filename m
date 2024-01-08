Return-Path: <linux-kernel+bounces-19259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F81D826A7E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF7D1C21BA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2208B1118D;
	Mon,  8 Jan 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eewPH5uH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D01170D;
	Mon,  8 Jan 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cusiZ2twATJLBti4jTySsJ+nAVTZYOl6//w4PDxH/jNZeov+6D8dej6eKWG3KaT/cZzWpO8COMP3QEBK2GCfsk7ZGVmFAd9pu1hlzDkvkNZcT+yOpg2p9vBJh5JYMkR93QfjZjimB9iTUYX+PmtU9qFQK/hzA0WM88EQcWqbjzEa1t3PxoeFK3W08KuthfhI6IsU1TvirRuTwJCrMg+Vps425Kq2ADvr7yji+AzfLt20N8KTik8m8JVZSROZ4M6UjRGOzfbEZOsBRnDSwpBGdbm+JDzqAz5vPgFlb9sOzFMPhQ0TdJtI4N0cgFpANAq/6vJjn9gZ+17X8CsfUDPdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yLn0ppBF1v3U6RkbdzfnaKh/Esb+RsGXmm4dQeoA6U=;
 b=PxlYKUZD15ZVXPh37SZNRWcfJbH1XXAl6qlAxYhynAxM2JTT0mmL2yIC+jyIuildmkoj3GdGPDZTRSVk3izqtzuzdDotAhKGQ1R3awBaflC0Vb5ZTk2I8xJDTnEAzNc7ni8MVdJuQaqBlgOlJiWpepZMpNUkGkgVrB+AyVv7v2+ys2BFw5cg5vjb4iOPZ8GwotDMEiinbthWVXVNYT7N62AopGJFTMIBxmofKQU6OQOTf/zoBMNR/ltIpAODg5CSPZNlTdr3crG//pB6kqXMuKity8VdUvp/OZv/PPxLYC4phGnI8RXaLquIfr847OQGtmgdEwLJkOM6Zj5fO9QPVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yLn0ppBF1v3U6RkbdzfnaKh/Esb+RsGXmm4dQeoA6U=;
 b=eewPH5uHcBs5/Mc9bMAtJV9kvAJeTmkt0qCYGafCDmbXmWaPPfsUfJ0F7mvZj23LjrblQ7hKgTOv3eSUtLMNJftwtnuEDYnnUT9h3IQOVwTvFjHm082mS1pik8aIvUYsRf64LfqKNTGSv+p9w7ZK2fg9SD7r/rxx/ARppvr+yuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 09:16:32 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 09:16:32 +0000
Message-ID: <4bcac34b-72a0-464e-91cd-d9e924073619@amd.com>
Date: Mon, 8 Jan 2024 10:16:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: fpga: Convert bridge binding to yaml
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, kishore Manne <nava.kishore.manne@amd.com>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
 <ab6a9a0e-ab03-4d35-9e43-c90c22dbcb1d@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <ab6a9a0e-ab03-4d35-9e43-c90c22dbcb1d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0045.eurprd03.prod.outlook.com
 (2603:10a6:803:118::34) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cc70b4-c77d-4857-7292-08dc102a80f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IfS8DMGklDdkKkyQLiK0T24N+qgCx2mjRMfmAZpTK44u8YIFTGz35IBSy0uX8Tk8pBjjwgdPA0V2sQOo3s6fL3YXYDpqMReb9jBjPiD9lrR8J/jWQAnZTwCv9uOQzbfOfPbCtUxYxurD1lJbxegtPNryQVMdVLlE/bgw3crjLsLN7g7ZcVjQNkxeubUAJrWFl2lEySBxzr7yqUi8LqVOYlDKZFCccXMYummY4FU75pEMnvmZVNVGX4+wpwhMZfIy4f8QCJrznQ0FqNn0UclDRqGj7PZdYV4B1JwasBeIArd0iBBs7FSjtjSXV3O7ZDHReXk3k+BMK10hgR1PANEk46DPq9wT5iA3ULe102XzdiziUvKqjsIPfUA/Y5Xx5I+7C8wG3hW7Lc1FksVO2SYfKdjg+Fiecl09LOq4GoUCI/2S8DU7Mq63GO70CHFtSs4zu+3TM/2qhlS5KmWrmAEva7qOcKk/Lv7CnMuj+8wSk+E/Y12wXD0Oh1Dykcp/T0lQ6fF72fEy1BcWkunwa+3yir4JQFn+fNmmvww+/26Gzgl7azzV5mWT/v+FrL5N4j1+ozJQo9BJM8KgNSDvELtOAQDttXZnMVjBT00n/HzUvsIGcLy6o4kuxL6vEP/2vitz4aKP39+hlEjs+pOi3Gwg3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(7416002)(4744005)(2906002)(6486002)(2616005)(26005)(66476007)(66556008)(66946007)(41300700001)(31686004)(86362001)(31696002)(36756003)(5660300002)(4326008)(316002)(54906003)(6506007)(53546011)(6666004)(6512007)(44832011)(966005)(478600001)(8936002)(38100700002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NndIUjhTbzgyZGpTWW5CSWNrajFkUlhGa0dTank4NEl2RWdkcklWM2tGRTR3?=
 =?utf-8?B?K2lYRXliN0NNc3phdW5FRGJXd0Y2K0ZyQzJsTWp0VnVEZUhvVm1mWTE2R0lz?=
 =?utf-8?B?cHNUMXRLUkl0QWFoUk9hNGsxZGgyNFgzVzlNcmJGQjFRVGYvTmttR2R6VWFl?=
 =?utf-8?B?elNJOVVuM0o3QTVYemZ6eWxBdmZFT2dsd3kyUUVIS1JaekpjTGF3SmxkcTVW?=
 =?utf-8?B?czRNOGdLcEdRWUdZNjl2enYyZ3NTdE5GMm1LNnNGY1NteVhQOHUwZEx4TEpL?=
 =?utf-8?B?ck5HelY2bWwxaFVaREFTMklmUmY1NFpTdFVYMDVHY2JxZHpmajRFVFVuODdD?=
 =?utf-8?B?WFJ3cnhQblhINmVIeVFaOFJNZ05GeHVteG5HTXlMb2RoMENmaS9iaEo1ZTd0?=
 =?utf-8?B?b09tNkdSOXV3Y2QyVTduZkI0ZGlpN1FSdmpqb3ljUktPd0pnY0dQTGdOUWdH?=
 =?utf-8?B?VkJPcVJnNUZiamtNUFdwS0hvNWk3UXpSdFJONnl3VGRUNSs2d3lrV2ZLVElX?=
 =?utf-8?B?dzQ5bGFpVisybkcyb1ZyamRIdURMTGN4SG1mRTdzRjFsaVVxUFlMUEpmM3Aw?=
 =?utf-8?B?MVhoRVowZHdKc3JtSnBXSVBuazQxVzEwWG5KS1lMcjQyQ3gwTmxkWW5ZemJI?=
 =?utf-8?B?Qmg5TXhhNzhMTjVWeVJqMEtISVZhUldjUk5mWWpKdWFnaVRsckE1eWZoL1dm?=
 =?utf-8?B?YUlma2hCQ2xMbGhJcmpXa0J1N2VBd3VVV3Q3eXVFQ1RwQUlRRE5PV3kxaWV5?=
 =?utf-8?B?YnZJUEpEdkp1ek12K2c5elh3NEd4U0xMUjZVZ1BFR1BXengrek1EdFdSR3FJ?=
 =?utf-8?B?cGdSdzQ1VStTemxxa2Y0SUN4dHpKV3duYzlNWXJpN04yb0QwWWZNMXhTTmVp?=
 =?utf-8?B?bnR0b0loVHJrZGxyV2xIODF3TzZxd1FMMXdVVTl2cTNnalRrVWdwc2plTXg5?=
 =?utf-8?B?V0NYWnJ6VkNaMm9uYmQ1cEkyMTQ2MmRjckNSRG1zWXlEQjJUK3J3dEQ5dCtN?=
 =?utf-8?B?UjgzWmt5a0h3SVhKb1VKSzltWWJ3YndEaFM1RWdIbmZmNWZYaDhoRkV0REFw?=
 =?utf-8?B?ZGViQ09nVFdSR3Z6Y1NRWjRORUV6Unp5UENFcmJYRVQvaFBzZkVIdEtWUGR5?=
 =?utf-8?B?WVRqM3ZEMzdTWFhtWmtwcmpaZVZtMmJmSEtjWWZaRkRaZWdXUW94VmxPbTJM?=
 =?utf-8?B?ZXB4Ti8wTDFCZkJCMG5JR3NNYjZuczh2VDJkMzd3WkxVczY5TGZvUGFJS0My?=
 =?utf-8?B?STdVMjJNdDVaOE1JdmV0SStzN0FBK3ZubzdCdm5xQS9DT1duTlBQWmw5OWhC?=
 =?utf-8?B?cUsvOGdFWElCeUowK2VWUmUyRDhBOTlCdjlqbzc2enVmcXdhUUU3Z24xd1J1?=
 =?utf-8?B?dHN1WHpKQXd2QTUzSzQvQ00ydjR1akxibWxwZDZ0OHZoaFhrQ2k4TVVZSDI4?=
 =?utf-8?B?QTJyazlxVGVuUmtQWndhMm03bjdGN0t4cU1hVThkWStaOWE1TUpGdVVaV08v?=
 =?utf-8?B?YUJxK1JWVGNSL0M0ZmlHWm1ud1JERW9xS2dVN0c1Zk9ZUGN1U3gxejBXOWF3?=
 =?utf-8?B?SytVVTA5Smh4UGVaTFF2TzdNVkhaNTlYelQ4dkNadnRLSnBwaDFoZ1M0SWV5?=
 =?utf-8?B?UHRhMkxtZTNISU05bGJhZit3K0VSTGl6aHNtRzdib3hxSEV3V1lDRUxUbm90?=
 =?utf-8?B?bTRvbjdjWStnZ2EvSDZnWlJ2S2VKU3pYSUg4VnJKNGJ3NW1kWEdOWHI4RTRq?=
 =?utf-8?B?K2FNbi9nT1E2MitTY0Q5eU1GMlFPTXJqNlZCUjNXRHUwUEgyclpnZ3lLMDN5?=
 =?utf-8?B?Y0hmUXRhdzBITFlxWHJjT0VTbDliOElrNkFDUjlKazhYcVZpKzA3dmZMTzdI?=
 =?utf-8?B?dG5ENEU3WkxkelVMMWFYOXBkRGdQK2RVVnI4Q0ZFaHlFaDVDMzFXZTQrVlM4?=
 =?utf-8?B?a2xIMTUxWGIrR1ozMHNsSDFlTm54TmRUT1NHbTByK3RGdm5WTTlSL0lSSkpC?=
 =?utf-8?B?b0lCSGRiYUdaQ2I1Unh3cXc5dkpBYWNZUm9Ld1lwMDFBcWFHVlhRRlh3bm9u?=
 =?utf-8?B?NXJNZ1ZqY0tYd1hPc2c0b0FQRWFKb2FQR3daOHpjcGl2TW9ob2lDaytTWHgy?=
 =?utf-8?Q?YVD4NQMs7xKBiC8S4OrwKTLtX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cc70b4-c77d-4857-7292-08dc102a80f6
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 09:16:32.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2Mtx3gEJSkdxCJzmeIBys5u1C8KEL2vRcRYHQtL6ZWPOTQ+VH5C5VgJAB0EXeHC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224



On 1/8/24 10:09, Krzysztof Kozlowski wrote:
> On 05/01/2024 17:04, Michal Simek wrote:
>> Convert the generic fpga bridge DT binding to json-schema.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
>> +$id: http://devicetree.org/schemas/fpga/fpga-bridge.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: FPGA Bridge
>> +
>> +maintainers:
>> +  - Michal Simek <michal.simek@amd.com>
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^fpga-bridge(@.*)?$"
> 
> Not sure, but maybe we need to allow fpga-bridge-1? Could we have more
> than one bridge on given system?

Yilun: Any comment on this?

> 
> Anyway, looks fine:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks,
Michal

