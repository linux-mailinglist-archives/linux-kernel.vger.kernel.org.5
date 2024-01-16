Return-Path: <linux-kernel+bounces-27530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578B982F1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AF8285CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9971C2A9;
	Tue, 16 Jan 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yqIF/vRv"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E128C11;
	Tue, 16 Jan 2024 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFPDXcyPcKq7rki8zK+ZpvohFiELpDWSSfLkEUehbcMk//CYQGG3XQU6RzhGsnfc+NFZJp0j+3Gz6ZQTSpavLSQ4GFcNi8/ILI/2hcf1xOvmUo5sZNl3GSUQd0xHZramYzQb8r0mBFKl50YuTegr3HjDibRuFiUjREuzEQzglGi8xTjIQ+hyHDUq66QFiSzUTqlaRrqBVktL0KpRgGgZ1/d9HF5Ga2APAMQen1VWFBFoJugzL5Ab+AlmOFJ4LOqJddh8wm/z5a2W4Gr/+UQvvnorDvxToTeHrol/pMQ63OTHLMIemUKeoyVgMEowxC044JnOHz+FZrtGyHQdvVVpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgeEXL2Dq4bNUeqgvmM61tj41XsxiShzQn+KHibLhsQ=;
 b=UpbDs9P4/NGcni7UlC0WGC2WNLV7qpMh9lFCgmXRzOnK1wNebGH8+7zNLIIRKfChA3QLyT8Uk+FLbo52/YvCTfAdnATaQDNkBV5L8GAkqpnJQ/2YnRT+fSNT/g2xJK7mrNX8Vgm3RAEQVfSStGSMO/7u9fXCIustJ76SJmI782/W/6y68q05Qg8hPfxwbD9QIZGTiklrAZKPTpZgLCpjdGzeS3Py5ejfyPQGr5iRsxqfbkn6mCJNJGvkU8HQjBtbLNqpztQrg3x9GGQBBc31NcxR4OymY8VVqh3CTHx5g1IxJ+swzI4B1LZWXV+13wVdE9UG8yH0TnemHb399KfPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgeEXL2Dq4bNUeqgvmM61tj41XsxiShzQn+KHibLhsQ=;
 b=yqIF/vRvMfBWZrTBIrfp2/gVy+hDsqNs1tSnn77WcMses9NjphmnTz+Djmx0lnMpzm46mbU1DZmAFOtKh/DSMfJ0YW49Kv4Ym/nHn8D3foyX7knzy6bFUNgGPsweyJUMaaTHxevlz4KMBi3CZYU6IvmAFNxa8M+RZaJNAppPUVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Tue, 16 Jan
 2024 15:36:28 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 15:36:28 +0000
Message-ID: <7c76ac86-40d3-4c55-a0a8-0b83fe971bd0@amd.com>
Date: Tue, 16 Jan 2024 16:36:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Dragan Cvetic <dragan.cvetic@amd.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, git@amd.com
References: <20240116111135.3059-1-dragan.cvetic@amd.com>
 <20240116111135.3059-2-dragan.cvetic@amd.com>
 <107e9496-8b2f-4de2-9396-945a7c822493@linaro.org>
Content-Language: en-US
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
In-Reply-To: <107e9496-8b2f-4de2-9396-945a7c822493@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::15) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: bd75978e-1cc6-470b-7078-08dc16a8e7c4
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z8pfjD9mCwDVd9wFaiWaJnWzA8auDRxXIPwTWt3c1GFOaG3csACc5or3hrBqssKT4SizwgVkRJsepRqMvywG5lpObfooncxp9VQ6O6/AYP+J26Qa5mpMo6wHkxQv9zJL18yQTX8CPh2SEkzC6IsufkGQcruvQiKPM/W8CAredxsM/FcF+RpKSIKqqr2WG89vV0mQXr8/rQfvikKpk7aqTFQH4WbyM10O26Gy5HK8omFl4hi7inFOn6MjLSvc+ScSzRedYgLnW/KRD4ZZpxIDbjFtn81/9HgL2BrpiTxQFGDyrXlPEForRf2I4hmKRA7AUiYu7ECS48OCKPatn5tDGb1x1nFxqgNMZtD7dRtDfxp/5yyQrTjQvZ5Zo/rmEMJN2uwch6kyYLV3rjFYI+NgCw+fIWdaT+XNeUNhwJyeyqI/RZhGPx8pclUiarlRxWDwcSjXMJPBUzb2kYdnPHDUrgffPnQpSqFh2+jnFc8OG8ENTCKKgmoxLPeJgKq97htov0rNjg92ttg8/EH/G1s3kpeV03cf20e5pIA1jGXqIbC6/bvi+E65vVZ/0kqfOsQ/1OAb7/JYBuC7q5h+dwU+hc7znNvjLPDxktQcRguputHiYJ19VWMuAHXz4TdbZ0Z0q6U50vaIpNC7lCiYxdP46boWd+MPcAZlY78LOtS6LWvscJOOshsgwQj0/D17Z7hY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(5660300002)(86362001)(31696002)(31686004)(38100700002)(4326008)(8936002)(8676002)(44832011)(41300700001)(66946007)(66556008)(316002)(66476007)(110136005)(83380400001)(2906002)(2616005)(26005)(66899024)(36756003)(478600001)(6486002)(6506007)(6666004)(6512007)(966005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnJQQStMQWplU2x2K2xOYVovVVlXQ2RLc1ZtUmpKNHZodXlkcnV1WjllUDBl?=
 =?utf-8?B?WVJoa1B4cGJWNzZETXJDOWZvM1ZVakxxZUo2aEczaDdHYmpXSEUydzBuclRi?=
 =?utf-8?B?UHM4UkRjU1JCY2lLcmo3Mmdubm5KTzlUNDVJZkZpUWV3SXNUL3BMdDNwUE1S?=
 =?utf-8?B?emZWcTZ1UUhYNXh2bDl2RXcyUHgxSXdDeGFvdWxmbWEwc3FJSW40dC96UUhP?=
 =?utf-8?B?MjVnbmF4dXVCL1Jhd3p5dm9RSzQ3djEvUlNqMlRWNUx1KzNpZEhVaU9QWEJT?=
 =?utf-8?B?ak5HKzBpVEZCUEljZjYvbXkzNlhHcWpTOFh3aDBmQklXTXZxRDFuekdFMVdI?=
 =?utf-8?B?Y3ZBUjcxQytvaE5OakNmZ09obCtKTGxHR2wrbmR2OTF5cm1sMnhIVWwyTDNw?=
 =?utf-8?B?a1RtZUxaWk5YdTRza0psU3FXTDE4T25wTWYzemdmSEt3djlpcDZ3ZEVqVTRH?=
 =?utf-8?B?aWliWkdYQldjWkR5Vm4ydXBHV2prS2VEK3JDM0ExUVR0eE14V2pUUG94Sk9h?=
 =?utf-8?B?QlhUdnlnVExSRSs5djJCdmdxZ3dOMGorL0puY3UxRldhNDV1Y2pya1FZZ1Fs?=
 =?utf-8?B?cm1JRG51SmtJSHFWbndoS0FPMytLMFZpZ3Q4NzJOUUxsUWZoMDNYUjR4NnFy?=
 =?utf-8?B?anp0TGRMck0rYkRIdlpYdFhDUUZobHlNUkVwQWdVUWhNaFFEWmM1YVlxSzNB?=
 =?utf-8?B?b3hLM2pLODd6QytSY3hqbHlTa1pjb1pRbDNmYkEvaENFMXpSZnp3WUJQaHdL?=
 =?utf-8?B?aVhYa3hwUUprK2JHMUJkdXlsa1JlNzFmc1lvcUlpNW5UWFhRSGVsZTNKUTZN?=
 =?utf-8?B?a1J6Wldwa0ZVbldWdzJjcjFFdCt5bVR5cjRmQTk1ZmUvYlF5aEM4R0dYSVF5?=
 =?utf-8?B?aThwWWN0T3dMK1daL2dSUEpVaEY2ZkdDZXNxMFFaQmgvdWducUlrRTFwUC9H?=
 =?utf-8?B?d1FyVGZsTjFad01HWW5UZTh1Q3hQNmFUcldrWGdkSDFDUTl1bXE3QlJxZC92?=
 =?utf-8?B?QzB1bEdTRDBNSHdBNllmS0J3UVZGQzYxU3g3YnhXcHJIYzlaZTdycnRtRGRU?=
 =?utf-8?B?UDZYZjdJQ0J6dVZxWDlNM3dBWjJ4TmRKQnJ6UlU5dTZCajdGaU9ad21lZEJC?=
 =?utf-8?B?b1VFeG1FazZYYUpVanZXVUNqdmk2V3BwZmpoM2hNaG55UEN6K0hTMlFoZWo5?=
 =?utf-8?B?RXh1R1JFem9WMnptOVM2RWJ1cnJycGZLbzJ1VkJPQXV4ZVo1TnhBSEV6a0dJ?=
 =?utf-8?B?bEY3MUtwUkI5NVg1Q294TEJZV1J4N0s3YUFuRFFabTNoR3RqcS9PbXJGb3ZZ?=
 =?utf-8?B?ajZCOFNiT1B4NmZyQ0xyK2ZiKytpd3VNZTUxUFJvUWxtTHl5R1czWmRMMisy?=
 =?utf-8?B?YTlhQ3M5MDhMdERiYUg3UDdNVmc5enBCaE1nV2wwb0NyV3E5UTdGemtYRWFr?=
 =?utf-8?B?WDBrY0hRckEybmlwVzl4aTg5alNuTkUveUhiSDg2cjYxclNRUlV5bWxEYjhI?=
 =?utf-8?B?NGNOc0xOSk9vcFlJQ2JmSzNoQ1haNWZsY3p5ZUxpWUN5TjJmcUVPMS9jbXdX?=
 =?utf-8?B?UzZvNVpmMFJLNW0xNk9PeCs3Mm4yUkZkci9IcWhNWG8zRCtqWnozV3dSRHkx?=
 =?utf-8?B?aUlvcmw1YWFUMVZpa1dnc2R3V05JSUNxVExBN0FWZk1qQWdiVkFkZGtDam43?=
 =?utf-8?B?L3p5SjRhbWJmbDkxbzZRZmliZ3BmVEgvcWRkRkIvSXl0dTB6Nk9tTEJuaENV?=
 =?utf-8?B?M2o1NFp6T0ZVV2ZHRHdwQkk0Q0Z1Y08vNkV6c3llYnMvbUl5bHU3OWhZSWJN?=
 =?utf-8?B?Zm5mY3VKUmVoaTRvK3QyZ3A4ZklxSnErWGZreFkxSXlkdmdZWExreFZhSkg5?=
 =?utf-8?B?NHpRMDlobER4OEl3KzhvUGg0QzJWMXB6OEphQ3l4N0Z3L29OK2VycEhZcXJw?=
 =?utf-8?B?OW9VVlNFMSt6M0g4eTRIcENoSHordlkra2dsQ2IvWFAwK1VYZDFsN1dGOUpD?=
 =?utf-8?B?U1dydnhsNWZZLytNMm5OOUdFanlqVGpRVHJiRWtrK0ZwQkV6bkVYcjd6VStM?=
 =?utf-8?B?ajJkL0ZPcExNempNMHhKZTdNRDlWYlFtRkJkV2hkUmVqeXBYdk1RcGpjTlJa?=
 =?utf-8?Q?GuiphTYOUda0PZTMX6/KD3sx3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd75978e-1cc6-470b-7078-08dc16a8e7c4
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 15:36:28.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBKlF+AGRFNk5deFoaQorw/8/jCHTZMO+w76X5z4QcgTsaRo++e7fgwfvvhb++Z5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783



On 1/16/24 16:20, Krzysztof Kozlowski wrote:
> On 16/01/2024 12:11, Dragan Cvetic wrote:
>> Convert AMD (Xilinx) sd-fec bindings to yaml format, so it can validate
>> dt-entries as well as any future additions to yaml.
>> Conversion txt to yamal is done "one to one", no new changes in txt file
>> has been made.
>>
>> Reviewed-by: Michal Simek <michal.simek@amd.com>
> 
> Where? Please provide a link. Judging by amount of issues here, I have
> some doubts, because I know Michal writes good schema. :)

I reviewed it internally. But yes, I didn't provide this line.
And never said that 2/2 should be separate patch too. :-)

> 
>> Signed-off-by: Dragan Cvetic <dragan.cvetic@amd.com>
> 
> All your patches were marked as spam. Please work with your IT to
> resolve it, otherwise your future submissions might get ignored by me,
> because I will just not see them.
> 
>> ---
>>   .../devicetree/bindings/misc/xlnx,sd-fec.txt  |  58 --------
>>   .../devicetree/bindings/misc/xlnx,sd-fec.yaml | 132 ++++++++++++++++++
>>   2 files changed, 132 insertions(+), 58 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
>>   create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
>>
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
> 
> Looks like you either based it on some downstream tree (don't do this)
> or used random list of recipients (also don't do this).
> 
> Please reach to other AMD folks to explain you how patches should be
> submitted. There are a lot of experienced guys there, so use them.
> 
>> diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
>> deleted file mode 100644
>> index e3289634fa30..000000000000
>> --- a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
>> +++ /dev/null
>> @@ -1,58 +0,0 @@
>> -* Xilinx SDFEC(16nm) IP *
>> -
> 
> ...
> 
>> -	};
>> diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
>> new file mode 100644
>> index 000000000000..05bc01cb5075
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
>> @@ -0,0 +1,132 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/misc/xlnx,sd-fec.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx SDFEC(16nm) IP
>> +
>> +maintainers:
>> +  - Cvetic, Dragan <dragan.cvetic@amd.com>
>> +  - Erim, Salih <salih.erim@amd.com>
>> +
>> +description: |
>> +  The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
>> +  which provides high-throughput LDPC and Turbo Code implementations.
>> +  The LDPC decode & encode functionality is capable of covering a range of
>> +  customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
>> +  principally covers codes used by LTE. The FEC Engine offers significant
>> +  power and area savings versus implementations done in the FPGA fabric.
>> +
>> +properties:
>> +  compatible:
>> +    const: xlnx,sd-fec-1.1
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    description: List of clock specifiers.
> 
> Drop description, it's obvious. Do you see it anywhere in existing code?
> 
>> +    additionalItems: true
> 
> Drop, you cannot have it.
> 
>> +    minItems: 2
>> +    maxItems: 8
> 
> Drop maxItems, not needed.
> 
>> +    items:
>> +      - description: Main processing clock for processing core.
> 
> Drop trailing full-stops.
> 
>> +      - description: AXI4-Lite memory-mapped slave interface clock.
>> +      - description: Control input AXI4-Stream Slave interface clock.
>> +      - description: DIN AXI4-Stream Slave interface clock.
>> +      - description: Status output AXI4-Stream Master interface clock.
>> +      - description: DOUT AXI4-Stream Master interface clock.
>> +      - description: DIN_WORDS AXI4-Stream Slave interface clock
>> +      - description: DOUT_WORDS AXI4-Stream Master interface clock
>> +
>> +  clock-names:
>> +    additionalItems: true
> 
> Nope
> 
>> +    minItems: 2
>> +    maxItems: 8
> 
> Nope
> 
>> +    items:
>> +      - const: core_clk
>> +      - const: s_axi_aclk
>> +      - enum:
>> +          - s_axis_ctrl_aclk
>> +          - s_axis_din_aclk
>> +          - m_axis_status_aclk
>> +          - m_axis_dout_aclk
>> +          - s_axis_din_words_aclk
>> +          - m_axis_dout_words_aclk
> 
> Why order is not enforced?

Let me comment this one. Based on my discussion with Dragan IP itself is 
configurable and only the first two clocks are in all combinations. But based on 
his description that last 6 clocks can be present in some of them.
It means order is not really fixed and any combination is possible.
That's why I have suggested him to use this description because I didn't find 
any better one.
I actually tested this schema here but didn't get a feedback on it yet.
https://lore.kernel.org/r/3e86244a840a45c970289ba6d2fa700a74f5b259.1705051222.git.michal.simek@amd.com

It means not sure about not defining maxItems but when I don't do it it is not 
passing dtbs_check.

Thanks,
Michal



