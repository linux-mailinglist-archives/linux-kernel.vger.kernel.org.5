Return-Path: <linux-kernel+bounces-3392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918BB816BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DBB1C22D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486931944C;
	Mon, 18 Dec 2023 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dprmlS32"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388919442
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ky9EmSvw5f1HhWM77QeerytFPXghiyeSehep1G4bltXrjyLN/NvLlW38+QskJ2kp50ChKycTMwQXKCDNMvXdrowzs2kOBKru9OfbfZ/O+4CNYu2Jvv1o0vG2qBZVrEI9ob0vx5Ttp1gltqau2cn3YtKUmu+LTXdDms2wFAdabNypSCccdNg3gR2jP75cOyA1JvkvvHuuik5cm2MxbSrTLUmz0ILY/0V9to/b8Lg+txujVcoA3d08p16VX9/BrdDMTgecIeBxmtMMd9BrG5dkWq63sCwL2w0mkoghHCbajjXPcHIOuoFkj/aqpPX+Ic9dK5FpEJ6q0dJJkQ6NNWIHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05trh6xhkdjv87YjXQLcYCN+Swba1nAVJ48ieAh+0EM=;
 b=RIcUJw2TMHWDOPiXW4Mh4HIv/+pEurU9iMeCbNRvMCURfrRDwUZjKwBWKI6s19wZ0wGUHf5WtYFrx/XNeU3pIU7XJkDmHMbBMppctYY+vKcpZ0ISd9wuxOOk4FIkVPy+8El5vvRzw5/l8j0LFxxDGhvRjs96BBQw7p8wJStX71xfzOl3PdC1e7stYHc4bYVkmTe30HL3TBKxrjv9fF6ZZXkNoqtYVutAVS9DNcQ3tUZO/5ONc523bYF6HCE6VKGBRmLjpuEfykLwlpEM0Hv6tchvmWRdIozCGr85jBtLZLVlfyCvHxWEjS5GoVwLKQqT1FJEBvNpuFJ+iL2qIiZW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05trh6xhkdjv87YjXQLcYCN+Swba1nAVJ48ieAh+0EM=;
 b=dprmlS32142WhANzZFPlu8NxAdkheyS4cKCL7nrkSuPzGW331+tNqBEfBpQxjWGESmaDiPXyumUyEmBEJ6jvue4Elqor/3Q8Huro5aeoW05fTGN84JHoPIGZbTJ5uCIgCXmeJ5VJIJHZjvbcupUxfqXb1XWqFLqFFrRUGADBv2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 10:57:00 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 10:57:00 +0000
Message-ID: <d07b5884-c7c1-482a-a911-a0b7a75100d3@amd.com>
Date: Mon, 18 Dec 2023 11:56:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] add platform check in event manager driver
Content-Language: en-US
To: Jay Buddhabhatti <jay.buddhabhatti@amd.com>, gregkh@linuxfoundation.org,
 sai.krishna.potthuri@amd.com, linus.walleij@linaro.org,
 nava.kishore.manne@amd.com, dhaval.r.shah@amd.com, robh@kernel.org,
 marex@denx.de, roman.gushchin@linux.dev, arnd@arndb.de,
 shubhrajyoti.datta@amd.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231218094009.13528-1-jay.buddhabhatti@amd.com>
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
In-Reply-To: <20231218094009.13528-1-jay.buddhabhatti@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0053.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::42) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bdcde1-3d33-4f12-ceb9-08dbffb80ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j4+8PLGmv2vntvboLH/OEhHFQ9gdriW8cyFa0t7N0Pgefuezdih0g3AtLzciGb/VGoQliSqHbyxrCQo5tsZDdkn2unGf6mx+45bGhZ4zykrHxJdbrkvqQqOiQPibbJaFEUgaGwVsKcQ/2/bEU4xXv1zvMIphY6GrIgLcqeK5OZAmSIR6x0obx1WUV8Mb+T3Jfyx0oCcThFIu3YsfzAxBISr3YGvKJ4oy0vN72h5vpPO9EuTvCtNftKtjiNsvF0GMltK//mHh2HOG57xr+mwFKIgb3K2zlgyfVSugTtSvnXyVsQOV7tX0rA5Q0smrjKTa6/DbDzlEFfXVUnUUbhnk/llaZKP1RT4vAWAMHaRvCiPb9cGJ1hfZ2K+DSDSp0gZrOO5k/kRuhqtZ4Cmz37y1PoqMz4rBiW//4SuJwbOqtb4MEGOPALkkX+5kYt07pg0sdH47IxYrg749U8/mvY+G19sAHjqowbKfpxW90ve/uXrA7LkAZuS5B2IaKIC+V4rTxknVBkVRswHMHe+YgeUu4I2j37vuo8Vj9fSorLgV1Fz2yn5mtBzR4y65+QS2/4v/ClwFMbzqPXZ26Py5xJqrfCQgOOhm6bWbIl3mW9wzGQT3zgvMLhmedQOam7XHlSxrzUFulq0tCZadBcI8ERMCPybCffXeWo6gDkOiiqEIaG8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(921008)(31686004)(26005)(2906002)(4744005)(6666004)(44832011)(6506007)(2616005)(66556008)(66946007)(4326008)(316002)(6636002)(36756003)(66476007)(53546011)(6512007)(5660300002)(83380400001)(41300700001)(8676002)(8936002)(6486002)(38100700002)(478600001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU1uZERMSGo0cDlWcE1PQlczaEJsQXhIZXhVaWFRcWQ4Q3hZYk5XUlI4b1JK?=
 =?utf-8?B?SjVWSDFSeGU4UmFONzhna1pEbUZ0WjdXaFBPcHBhSS83Z1VzSFU3QWlWRzBm?=
 =?utf-8?B?RUszLzdodlE2cVN1OTJJNmFzclllZDVVM2h5U0dvUHVOdERQS082WFdyWGUw?=
 =?utf-8?B?U0Z5aDhJREhSSzVmdklpSCtTamNmMUdTcWRXOGVqZVRCWXZOV1JHdjlXaERT?=
 =?utf-8?B?N0JuTkcxSzc3SzZ5aFZ3TFM0MjNNd3BTd2Y2TlpYbFl4SGN4ZTE1RSsycFdJ?=
 =?utf-8?B?WmRqa0JxUElzUlpybUtnbkIzWnBDbnNuQjlnRjJ0bXM0WjgraDVGaTNPQmZI?=
 =?utf-8?B?cjAzcXNpeGNwbHVVZGtUZFM4d2JsMGQ5QkViZ2dYYVQ4aXQ3SytscHZ2NzF5?=
 =?utf-8?B?VkdNNnZueVFXT1EycEwrZGFvWnpMSVBNbjBSTGd6bkZuTm9Fc01QdzlqUE53?=
 =?utf-8?B?SFF3aHZ6OHpnNWNveEJLV0Y0c0QyRDI1NlYrbkRacHhTU2RRQzlVVjlpblkr?=
 =?utf-8?B?M0Q2OHR6RUY3aHVoRU05V1pCWlo4dDN3NGRoNUZPeTRqcUVtL0dDM3h3OURF?=
 =?utf-8?B?Q3RrbVphWU9pby80OEgwRDd1MzE0WnZVNVRySm1RdThieGxsaTZGRENVZUJO?=
 =?utf-8?B?eEZSa0hLdHpZaXpDNUR3ejAyYVNoWGRpQWhDS3FLQ1VQWXk1cU9KcVQrTElm?=
 =?utf-8?B?bmJrR1pNY0NlUm1QamgrSjZnVUE2aTkrODRVOG9sd3BOb2xheUJXbUhDWk1u?=
 =?utf-8?B?aERtaCs4bzVSSzRHdVNOQmpBSi8zQlJLTzl5RXVmaExrWXdPeWhxQWRiOGht?=
 =?utf-8?B?SkZ1MFBqeXlOc1ZtR2tmS3AzMHpORUpwaVNQL1lScUV3dUFEUUxrRWNHeHNR?=
 =?utf-8?B?VzZvVjJtSjl1YTM1MGl3cjBILzFSbmIrb1I4QnFiWXpaSHIwMWNDZVQvNUdj?=
 =?utf-8?B?c2wxTkJTcmp4MHMzSU1IMC9OZExUeWNsWGdRUzcwWEdLeEVCK0NuWFdzSldC?=
 =?utf-8?B?YUw0bTdIdm9oZTJjZkZUYTdvRmhSeWM1R2NNUEd1TDlKeDROMUg1ZTAvKzI1?=
 =?utf-8?B?bElNNnc3NHIrTzh3cElnc0ozRFo3L0RYNEp3RUhhNitXcjdoNVhHRHkvK1Z2?=
 =?utf-8?B?aklEbk5wZllLTHlaTERzbFY3aklKa1c3Z3RJS3RIL3dCWVVaOTZSdkRZamNL?=
 =?utf-8?B?ZmV5Z2h5NmpyR2NGWDFyMG9TNXZRc1NhZVFkcHpYY3NyNDFQUEF1OWxWSUNJ?=
 =?utf-8?B?bFJSeTVaS3ZqOWlHdFc3Nzh6MXFDek9rQWlHaGY2Z1d4UXhiSWYxZDhUa1dJ?=
 =?utf-8?B?MGZ4bWFpOUUwMFBMTjl2YSs0Qi94K1ZEU2VwVlcvMjRoSCtUcmVmYWl1aHEv?=
 =?utf-8?B?ZmtxaXZYZlVMUEM4ZXZwb2ZjQmJON0R3L2FOV1pzckhJZ1F6K1AydzhHUFdv?=
 =?utf-8?B?VlYvUmFGUHYrSlpWbUVocXJycHhRWFk2c2JNbHp5RGdjS3BWckl3NzlnUU1E?=
 =?utf-8?B?QjB3aW1RaVNRUU0zUGxNZVg1NHk0alFOQ2J3LzltczErV1dpOXNPa2daS3Fl?=
 =?utf-8?B?OHNaTjZxenFyWXdYbFpsNmFkZFp4Nmp6ZlJoWGk1WWZoTC82Rm1JT2EyWlhJ?=
 =?utf-8?B?aExURFc2NGJoR0ptOXNYTFhYMUd6anZTWkhiL2RsYmZQWHhKc0pncmlHbnds?=
 =?utf-8?B?MEErRUNkVkhhak1maFBmUWc1UUN5YnBqUkczQjdoeDlnL3QvRVdXTkc2Vkpo?=
 =?utf-8?B?L3dxbnhKeEJNeDNieWt4VHNPWFBGeG0yVnNxMFhGU1BTdjFBd25KcHd5VTgr?=
 =?utf-8?B?T2hZWDhjajhTeXpRVVc0QnA1aEdVenU1a3ZXNkNnWC9zNHYxSyt5b1dsVlhl?=
 =?utf-8?B?Q3lyclIxNVh1NVpnbmM0SXo3SGxMdnUvMTh0MVltNHM1Z0NKTTNsKzJ0d3Nz?=
 =?utf-8?B?TUZ1djc2TDJvd0RyWWVsL3FPVHMzSWYzTDNhdGxkK2dDZlNTS3B0RGF5MzI2?=
 =?utf-8?B?ZXBCaFhvSzd4YktHSFRpaStiTjJuZWllOWtXTlFJeDkwbVdHYTNqNHQzRnF0?=
 =?utf-8?B?a1N1bEcrMTBaTU1qT0FPaHR1V21JeWU5RDVaMXg2RUpsTFdHNVROU2JBTFhP?=
 =?utf-8?Q?lBlksACXP3E3gFfBijHXsEiM3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bdcde1-3d33-4f12-ceb9-08dbffb80ef7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 10:56:59.9140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7vc0G5W/WlRwKMYZ36P8NPla24VN6B00b1/PASATyO183OkMYi0EWo9JE5ai/q3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037



On 12/18/23 10:40, Jay Buddhabhatti wrote:
> Some error event IDs for Versal and Versal NET are different.
> Both the platforms should access their respective error event
> IDs so use sub_family_code to check for Versal or Versal NET
> platform and check error IDs for respective platforms.
> 
> Jay Buddhabhatti (2):
>    firmware: xilinx: Export function to use in other module
>    drivers: soc: xilinx: add check for platform
> 
>   drivers/firmware/xilinx/zynqmp.c        |  3 ++-
>   drivers/soc/xilinx/xlnx_event_manager.c | 25 ++++++++++++++++++++-----
>   include/linux/firmware/xlnx-zynqmp.h    | 22 ++++++++++++++++++----
>   3 files changed, 40 insertions(+), 10 deletions(-)
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

