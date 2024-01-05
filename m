Return-Path: <linux-kernel+bounces-17960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC65825610
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71D12850B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0E347A4;
	Fri,  5 Jan 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y7JQVlXo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA2634CEA;
	Fri,  5 Jan 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELA+/u5XerNnhWZtkosc7FTxqh6wZo1EqryGVg97Hv/Kl6tOrtRehcpoWiHmu797pAE2JXJAHiWHMkpg6Ct0ftfKIyaoWxul2OH7oxbjJ3WxFY7oehKDjxyerJs9XqLO1G1pbqXdn2F7uqEMFH9d7r2s8TLRAHa7n2ZlSnzdnVGanzIIUgUodylwpkUXgi04MKfYcwMr7lt1hu/TP25154lPHOgy2jP1iZmNWXoNbx2iP1Ni0rtedXHDpYBLSAKVjd82qjnTiRTiR/x2lysFanesCQVMlcd4JZPYjDM/cV/CLRMvHJ8S3auwv49ixDqhp/jUTIJNdji+dZTgGI7l5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCa9Z57O5TSEPYmdDQI2svQz2X2wm7Q5XWeieXQruMU=;
 b=hbPsKopFjx956LoYZy58HF8PE1OpfVOuObrgKwWpGFwcR7qmeYIxnV/1U4LcmYjwwktgc7g4842rkithQacQg16PkqaaW3ERXuJdLCckJcmqVvgBgYjfbkO2N22KxDS+QvIApmiH40RAzVU6aN96H63Crs1lbS97sGeQawlurlpdls7++LFwZ/l7m6AO8vIKKQL5aX2y6dh969uuOo7uHcHIjGTVSakLaNULrfLAZf9ac+z9JwQ88Z/PoyPgYoN2OIY4a61SNNDMBprK7mg7oruxq58SblVKnPybCaiQQovlrKpFlOYHxdeWmWBGvUIFsdXSBVmLbxormDPTFDFelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCa9Z57O5TSEPYmdDQI2svQz2X2wm7Q5XWeieXQruMU=;
 b=y7JQVlXor2fe+8gjl7RChkYmkLKgbjh4DVRNG9BqGeOa40hWiKOzxtdk+i6In2UEE4sPbYpuTpJVPrzqBDmjusRSaBCDjY0IzUMKdvThamxgJOwee+H5JBKIwFvhIryKV8IJ6jbxesbGvK9pbnWK1Ouce4pdywSi8AQb4E94a8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:44:55 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:44:55 +0000
Message-ID: <e35a446c-ab18-452b-9d44-b73ce3ca3856@amd.com>
Date: Fri, 5 Jan 2024 15:44:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: riscv: cpus: Add AMD MicroBlaze V compatible
Content-Language: en-US
To: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
 Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
References: <mhng-78b77d96-e318-45f5-9032-4a1bee73afcd@palmer-ri-x1c9a>
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
In-Reply-To: <mhng-78b77d96-e318-45f5-9032-4a1bee73afcd@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::28) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ0PR12MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ee51f3-7145-44a5-98f8-08dc0dfce193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iEwnGKgDQXDBiQkVbENNUhu0O8QHbQUkxPT+utSfwpklNcPztvsRZrbejKwpVDDF2mizrxCU8tNrOKYghII3abxFNCpb4ZrN8A/+cbgKiApU+AA+BQgXM9BBXJ/QIYE20L5OwIyTVBwCv1P0DRRNDsvczehRplUs0M+82l262xi5DAUNzx7zhANrlQCRNe6pyDOz4jVZV6bPcnC3re76U6i0yOA5ixA1gcQ3krzkYjdsylOc1g5hPPo/M9SFs5+4XC8ExZo5Zwmm9k0mAUcpYa91xarrfdbNyj3l6sN8BuNHujSc2eCALh1t4oXpFGZumEkNiYFDWnzb8O/V0flJEAXBp+pITxdtC4HS5GVIEByrwTr8//Jg2VolY+a0cxAWmazHczrS4fc1gEtRdp/cFSiTg9Twz4SsDb/ChE1SBpI6NQ5sXw+v6GeuWbPDsQ6SZVJnRc6nIpVv8R/iKLbUGZ44SW4AKTOHbvFHt11NGQjXDDyccXX1V8P8zpP53hx6O7Q6hwQExbX5OC4L9xgZUX8LJ9SRAfsB9T4dYu3GoVCI3rbZ1DdzRPrzj1Klw9VMiFFVvmECo5ZZjL67KYQ+N8eFO3lI8AT1zHiz6aPuZ0TD2UGpTMBp3Tt0KkejNHH9huwLSoKKwVnfcZsEoN55Aw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(38100700002)(6486002)(110136005)(316002)(4326008)(8676002)(8936002)(66946007)(66556008)(66476007)(83380400001)(2616005)(5660300002)(26005)(41300700001)(86362001)(31696002)(36756003)(7416002)(4744005)(2906002)(31686004)(6666004)(6506007)(53546011)(478600001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3JzRjdSQWJzQ2ZRNDZZT3pZcDU0cmJXSVlQcFg5dDhlN0FuUnNnakJ6VTFD?=
 =?utf-8?B?OExjQXkxNmJhVkJlc01idWhwV21qa3FwU3g5dUQxd2w3M1lRRE5tRDJWK3Q2?=
 =?utf-8?B?NWpiV3JVRWNsWlJvYTBvME1EOE01Y000dHFtR0Z0UTRTcXFkc3E2ZElPOHh0?=
 =?utf-8?B?QndyblFGNkVTdHJPNjEyVzhpTVBFeGhmSFh5NzJrNmE1TmtZWkJwekY4RlBW?=
 =?utf-8?B?eVN0TTdHT3JNUk45VG9kTEt0Rm1WRW1Zem9BdGdLZE1aRkd1SE1zUGF2a1I1?=
 =?utf-8?B?NWtvb1F5ZWVrZG8vT0k5WlYxVkNDeHZLRHBkUWFSejBOUkU0bjBnUVhmWmwz?=
 =?utf-8?B?RUU0VXFibUFBd1dwKzNQM2RUUWFZOW9zWjQra0srMXpvZ0Y3OGE1UGpjRHZC?=
 =?utf-8?B?UnoyY0RObm14RkFLOVVxdldsTnU0RjVuRkVCMG0zclJ6d3BNdzYyU1hkZ0x0?=
 =?utf-8?B?QzY2TTRWWFQvSUNCRlk1TjRZbUZta29MTmRuU1JQalUyR3IvUWsxaWs2R1VP?=
 =?utf-8?B?MWdRTEluMGlwZFFKRlJsSndnbGhTRDRMTklpUGxDUSthUUUwemtvUytmb0ZO?=
 =?utf-8?B?NnpnanFyWnVYSUZ3MFFrZFl5bnMvaUZKZmxpQWhMZFk2MVhaeVI3UmdGTjMy?=
 =?utf-8?B?WVdSYmR4Q0x2WHAvWXBaeUM4WnhDbjJ6bnRwc2hPUzhWajE1bVBPMUM0S3Va?=
 =?utf-8?B?RUtyTzdabTBvcDJXcmFLVEZVdkZSZGRMZFFkcENDOHBmNjZPM3lFMjZ5Z2Fx?=
 =?utf-8?B?d1JaSExaTTNOcUMwU0l3UzJOVUViSG1iQ0JzNkxCekJNenJLMWY4Y2d3bW9P?=
 =?utf-8?B?N2kvQzZhaGZsZmNqQlYwaDBqUXFNbG1ML0pyTHJ6N2tqSlhLK3lZZjUxeEVU?=
 =?utf-8?B?cmpGNW8ySTIzSUc4NEtudCsyYTh5Rnk4VFl1T3hJYTJ2M0ZiQ0UxVCszRXp3?=
 =?utf-8?B?bmNNQlVSOVBXTnptQTkzNWNHOHRZT25VZnRjQkFDUjhVZUtWYlhEelBrYmZ3?=
 =?utf-8?B?RS85MXU5WXJzQzFmYjFEZFJSRnQzT0RxeEdpTGxKblJEdnFJVG96MXdqSzBW?=
 =?utf-8?B?UXNYVnVzTHRueE5BQWVzZGZFbnBBQnhURmtzSUFBMmR0R0gwc3oyUExybzda?=
 =?utf-8?B?ZjJqcmdqZXFzOVlBRGQ4MzNNZ3VXOC8wb1NyRXlrYjhLY0Zpd3JrVjFYWEsw?=
 =?utf-8?B?bGUrQ0hhSHNvWVFoalVrdEhxOXFJYXhQWEE3ZjhIWHFsNVl3OU1YcmFwamc3?=
 =?utf-8?B?Zkg4cjI3R2tTVGhKdUR3QzRNUmJvc3dyOFBMQWp2Y3diZUx5clFKSy9TTFN1?=
 =?utf-8?B?S09YN3grQzFDQUxDRElzRk5ZRUhlM1dJeHJxUjBiaG9oWlIvVU9VelB1R1o1?=
 =?utf-8?B?VENaNWlWZnJrWXkvQ1RFQzVMaE9JU0d5emdwaWptek9QeTBqVkJ2cVJPQmV3?=
 =?utf-8?B?ZHh0dmxrK1RJV2tNTytEbXl4NTlyaEhYRWFsRU5sbG5oYTgySmxRWWU5K256?=
 =?utf-8?B?VlB2dnF5ZGFIS0tSYVkrYmNsUkk5MDBVcEM1N292bXRXZDY4S1FzSnJ2R2pW?=
 =?utf-8?B?T2R2ZjVRcTZCWWZuK2ZSTmEyVGpFazhxbVZTZURYT0NneHlZTU0vaW1ndDhT?=
 =?utf-8?B?R0c3RTZMRERvQlpzSkI4d29taWVJWFgxclRieWJEWkM2QkVRSmxzc01jNTFS?=
 =?utf-8?B?YmpwZkJoRnlxN1pBUmEvanh4SW1BVG9rL3lEem9Ud2VjZTFmME5iOW9FbE9p?=
 =?utf-8?B?UUFTQ21XM05JVXZvM1RHTW5IZmtGb0FXNzU4MHVOWkF3c0hsNjRTNStKUkNS?=
 =?utf-8?B?WHowQ3VoNGloeW5sc0lrRXY0TE02WGZMK0tKWWlEMENsWkUvQ29OWXFJRitQ?=
 =?utf-8?B?OHhNY1MyaFR3YW1iTkNIaWJOWTRuWDI4Mi9Vc1k1Y3FRQ3dRVUxWV25wQXZl?=
 =?utf-8?B?WlFWVDUza0lvWTUyODFGaHpQeHRRUmd0Y0cySEsvVmhsVGw1SHdwcmgxN3Ax?=
 =?utf-8?B?VEppQkFUbUZwUjNocVQxWWc3R00zZ3ZSWjZjYU1RU0ZpNDQvT0VFVXVFcmFM?=
 =?utf-8?B?dFVhdEhNRndoUkwxdWtubWw5ZzNVU05PclhvUHBYRUgzbDJrcUdXeFdSR1NX?=
 =?utf-8?Q?ZIe6FKF8/vCZlVbShcwzoQ91S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ee51f3-7145-44a5-98f8-08dc0dfce193
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:44:55.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+kU7ozSx2r0OhtHkq9mQ1Jib6Xn1Vghlx1ZKQVrs0h5bd0iSj/uzwU+AeewbpQe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084



On 12/20/23 16:15, Palmer Dabbelt wrote:
> On Thu, 09 Nov 2023 09:15:09 PST (-0800), Conor Dooley wrote:
>> On Mon, Nov 06, 2023 at 12:37:47PM +0100, Michal Simek wrote:
>>> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
>>> It is hardware compatible with classic MicroBlaze processor.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> I thought I had already done so, but must have forgot to actually send
>> the email.
> 
> Conor asked me to pick it up, it's over staged for testing.  Pretty much
> no chance it fails anything, so should show up on for-next soon.

Palmer: Any update on this?

Thanks,
Michal

