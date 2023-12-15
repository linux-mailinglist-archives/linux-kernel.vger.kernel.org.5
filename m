Return-Path: <linux-kernel+bounces-801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE62E81465F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BBC2863BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52610208D7;
	Fri, 15 Dec 2023 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J2CgtAdu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B12208A0;
	Fri, 15 Dec 2023 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPeMJiFPVX8spnxJnUQOITY4SNdqnc73JBFlzt44Dckds8IFdG66qqYqU+ldwcX7qMeUMoxvwuBAJokP7fDolVBUpA8qyl0w64qUEKSALW55uuhfqh9DCDtasdUAGusoi2fgRuANm758L76w00hLKiawZvO3ZhJZoBuudc82HDVOQBga44OBWYlBWh9/0hXheUKPEtxveiQQ5HQC2gYY4wAnYFv4GU/8ZgaoUnZcA0xRpLpH0xDogP3wlgmLTNOsXTUN/9fenC2xUT41CiiZu4l6s+MpauS4IbM9dayA3Em7EuEnTNNUwAfNKFt+fSjStG//3KuVPPhfq5g0AKj+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwDXZ9f1oyJfdgZQV7h/w2EpKs43RP2brx2869K5HpY=;
 b=nNTWlkdrNutFwkMcDkamQ0Gcezp7hUCKLXF5xRlZIHZIv17ce//AFsIPETWkkptKdwcghFcE7wiFt+lbpFrqCSJNetEPaImvfiwfpMKr8+zUabEhcCAcxJjZ4q47K2BM4RoAqMw0IelpjbfO24f1RBXzChAleYjY2Fdsg1pVaAwPNThkPltqNUiTJ5iuPGsZxJi8WOxufCCJ71tWAXKFx4bH86jfZpXYY1va2luxs2V8dwBt6AgebVzj5YHD/sba1TpehOoeB224cvzvEAfVSHIU2ew3YbRk/4/UG5AfWnDJ0iFdA6xD/I4NpTNboWtSnnrOfvWBbGVBYuTpQ0uomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwDXZ9f1oyJfdgZQV7h/w2EpKs43RP2brx2869K5HpY=;
 b=J2CgtAduFFSjVSSd7cu5I5fOVNjWA0ZoIB0DF1GrTjFc5DJs+xpXw9gl+/GEH7dtRRGgIISqpoXYkE8Ftb6nql10GjFWu6I2vJQvgR2BLsA3/wJvkb+yzA5/cC4r+QWvFchltctIktMQJeNcvYarNJIY+XLbQ0nZxE5v+yQGx7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 11:09:05 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 11:09:05 +0000
Message-ID: <e9ee989a-aa48-46a7-9035-765cfd7b808b@amd.com>
Date: Fri, 15 Dec 2023 12:08:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: xilinx: remove excess kernel doc
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Srinivas Neeli <srinivas.neeli@amd.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Marc Zyngier <maz@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 kernel test robot <lkp@intel.com>
References: <20231215090943.9245-1-brgl@bgdev.pl>
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
In-Reply-To: <20231215090943.9245-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0182.namprd05.prod.outlook.com
 (2603:10b6:a03:330::7) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH0PR12MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 7436fc7c-e6f0-44ac-af01-08dbfd5e3fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yjs3bg+LnzV2Q/RgQ5t7ZkmvjtFoxhAMFasEwpvPs3PymVkY+hv94KhtBoYxjSogS8BCjScBtllPhvD37716wPvb+7onfFVz754Fq4bXMuZkl1mB6+SPbPRiMwS6hpG0YL8wjJ1l7R3bCyAdvsZbJYuq39JCnunz14jaRLMoRmLGYeQXTR61GU4V3/+PV5n5zxCK3shKiqdzVmmyiY6YTrxWodHa7d7srwotaOqqQvQhLEaQDM6GlG9aQWyzOJmP+5GeivKNp1jiS7BLDCqlfXUvW+qi7ImvsGmU3NpfeBp/WpXqgshH+/bfFHhd6QcvOeXWQEsBVJutFNlBc+VWwqHKZGBOvxF20aZaXVr1DjuI/nfGOKJ5jRhLaUAh/uvTsxfQyNif0Hsdgrbh3Rk85/2QVgEtKK5uQbtW5FhxYZ3AgQqz8Iq7Obv6yDZNhAFQppWHhTXxg8M/0iBPb9kUGbFgvSp0DyWGzCX10HF0yn9C+htfU8sjjmocdQG/v2CAwgzEt9uSxzvEmMyQiWBqzBbgmRtJbeLvOI7Dg3nzFMfBJnW/x1FEBkyEF+1mRxt0cWwMmsWlDhrMae47p4q14Wuwr73C92FzLjwdAUscwWGCRjKtfcxrXWeoW/RX6sR4JHDbRndCVmu0zTejNGsshQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6486002)(86362001)(31696002)(53546011)(6506007)(6512007)(26005)(36756003)(2616005)(966005)(478600001)(2906002)(83380400001)(6666004)(44832011)(8936002)(31686004)(41300700001)(8676002)(66556008)(110136005)(54906003)(66476007)(66946007)(316002)(5660300002)(38100700002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnhXZDM2TUUwWDUyOENHTVdZcFFhbWxhdk9hc1kyQlhtZTBEcDFrNVd4M3I0?=
 =?utf-8?B?bFlMRWprZU96QjQ1VlE3aWFKV2kzTjNrYVo3RFFyOE1FVmtMNnRJZWR4eWRs?=
 =?utf-8?B?QVUxdnRleTJxazNiR3RSYS9OdGpsSVp6c0JMalpDYTBvTUFRbWo5L2praHhS?=
 =?utf-8?B?M2hEWWRGb3BCVDJ5ZHNJTzlMVVY3TmRtSjFVZ2FxYWpoZTlEQ3B1bjUvVENU?=
 =?utf-8?B?UWRvY1hNSE95R0htOWFCQ0IrOGQ4bk4zNFI0bkx5RWFnazdqc1VPeUxzUkpD?=
 =?utf-8?B?cFNVbDNtanIzajJlWlNtN1J2QWJIQVFjNVN1UVRsWWx0RlZjU3VXUVlYM21Z?=
 =?utf-8?B?L1RqT25QaUtIbFhsTURteVBGMkFDcUs0MWp2eWs4N0EyU3B6TkdtOHVCQWhp?=
 =?utf-8?B?dWZGZDBYZHl5TVRmd2M4RFBYL2QySm8vSkJxMnJrWmlBei9IRlNaNHU3dDZH?=
 =?utf-8?B?cWRBVXRUUS9NVko4SzFid0lJbnFicVVFK2txRmVITjhLV3JsMVNLd0F6MHNY?=
 =?utf-8?B?bGhSOHpWbUdsTnhqQW9TaHBoYUpMbU03M09lQzhQWE9ZeEtNS1YvMHNMQnJD?=
 =?utf-8?B?ZDB1bXhpNkxVSXF0VDBwYnF2Zlo4RThoVDIvVEVHdjduZVh0Q0R3WHFKbWlp?=
 =?utf-8?B?ZjdmODg0TmNrWk92VUlQanJyS1dYRkd0OEdzcnJ1U21RR0p0WDBsK3p5NDhF?=
 =?utf-8?B?RDluSW9Td2ptTnRnRnVJeHk5MXJnT2oyTERQSTFXbXhxQ2c5MG9jZG1VVDU0?=
 =?utf-8?B?UDNrYmpFUlBnOG9MQ1FxcnFvT2Z2M1psZTJCU1J1c1V3WVBnLzRqWmpDRkxt?=
 =?utf-8?B?UmFuNHFVVkgrTHBUQVJWa2xaMUcxR1J2RzJPSHY5VmFqekgzdnd4eTVtNFc3?=
 =?utf-8?B?N25DSW14QVNXYlJtb2pCUDA1SnRWMFIwUDF1dlpKSnRwcWdJemJjT2lEcG5a?=
 =?utf-8?B?dkRTMDZndmpGcHNJcGVNQndaN2hVL0pWdkJQWDkwQ2VqSmhmQkF2ek41Nzhx?=
 =?utf-8?B?YVQrZFVKZktMMXZqVUhPMUozL2psSXBIS3MwRHlpWDJmaHY5UHg1MlJ4TnVj?=
 =?utf-8?B?NVpNekpOV3h1SzhoY0hQejlqNDdoc290VjdKb1hrN3lvOG9jd2U4ZEZ0WjdI?=
 =?utf-8?B?bmFlQ1hLNmJMZ253YS9yUWp6T3d3UjJScnVjS0FhMjdraXN2S0xvaGY5aU9Q?=
 =?utf-8?B?SXhXUjNHVVpsTmc5NzNHakhDVmd5am05SDhhNUFkS2VPd1RURitoc2p1anZq?=
 =?utf-8?B?NHhZbk1SOGxJZ0w3VjE3OWNMbTRXdTh5RUZrR3ZuQjlob0ZGSnRJZlZ4clNX?=
 =?utf-8?B?TnFYcnR2ODA5ZzZuQ3ZZQWZZZTdxNkR1WUdiQmNKV3hkaTd3RWlEOTVSM3I5?=
 =?utf-8?B?eTFjbWpRZjlKTzJmSk1VYkRpRnJmUDF4TU0yOXZCb2dTamdLN3ZSb2dQOVdC?=
 =?utf-8?B?WXRycDUzdGdNZGFQY2RzOWJQYldFMVl2TnJLemhKdldMems4Z1dwZnkvTWoy?=
 =?utf-8?B?Y2VQSThuSUhHTlNwa091d0hnWnNMQkpXRTk2YVgxaVFpT1V0cnpoL1BoTXBs?=
 =?utf-8?B?dmVKb2tFMnJEOExxSnVGbWFWQm5xTWxUNTVtRkxRQ21DSmhabDBHY1hHUzZB?=
 =?utf-8?B?bjd1bXlzanY4WGh2clU3eVlJd3Zvb3NLVTZibnBLNnJiQWFJWmNCQ1FEbUVB?=
 =?utf-8?B?cE1pTFVtMlM1YzZoY0NaY0Z6Y0w0TUt1QTgzUEJ0ZGIxNlZRaG9YTXNuMXdD?=
 =?utf-8?B?SWRJK3p1SUJGS1pKMkJYL3VobFlFZDgxallrY1U3N1d4Ri9mVFYwbElrZGxh?=
 =?utf-8?B?cmVYSWNJK3N1TlpoYnhYSFBBZExqUDVOd20xZWdmUnpZemJ0NHFyaTNESEVr?=
 =?utf-8?B?QjVtSVN4blhEMXhrcGllNDBya2VHdU5MaGVVRTRDdW5yaE5Fd0RpTzNMUFk5?=
 =?utf-8?B?TmNQRXZES0VMTVJxKytyWFRQMDgrZ25oNlplZjlzc1hHUnViMlJ2SUx4UGQ1?=
 =?utf-8?B?VU44czlHU0wzdnJRQlB1WFU1bUhXcStwV09qN2FvUm9lNE5lQ25CektsVUtQ?=
 =?utf-8?B?Q1FQVDJ3bG9VTEduWUhiTnhoMGpiQi9Jd2ozdHZET09hQ2E5SzM5ZXZwQ3FN?=
 =?utf-8?Q?SGRBrr6+lM4hZ5r3z67OCT976?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7436fc7c-e6f0-44ac-af01-08dbfd5e3fd7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 11:09:04.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DX87toxku0HDpGzcevY5mKng/Uf5AC14HOjfEODFZWyjBUxgnCyNCecmfnFyYO04
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417



On 12/15/23 10:09, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The irqchip field has been removed from struct xgpio_instance so remove
> the doc as well.
> 
> Fixes: b4510f8fd5d0 ("gpio: xilinx: Convert to immutable irq_chip")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312150239.IyuTVvrL-lkp@intel.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/gpio/gpio-xilinx.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index 823198368250..7348df385198 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -52,7 +52,6 @@
>    * @dir: GPIO direction shadow register
>    * @gpio_lock: Lock used for synchronization
>    * @irq: IRQ used by GPIO device
> - * @irqchip: IRQ chip
>    * @enable: GPIO IRQ enable/disable bitfield
>    * @rising_edge: GPIO IRQ rising edge enable/disable bitfield
>    * @falling_edge: GPIO IRQ falling edge enable/disable bitfield

Interesting because kernel-doc is not reporting any issue but issue is there.

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

