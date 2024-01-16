Return-Path: <linux-kernel+bounces-27091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC7082EA37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE161C23081
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F081118F;
	Tue, 16 Jan 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z4S/KL2I"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3E11181;
	Tue, 16 Jan 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWMwLSgQJqTsbdAocdvyKbJ3vBJ7rqDjn/XWcVwWuAsaiH6gS36rZvxBi1MRIO656shlnB6Y7TD8z4RgmtoEVfAaIR1GdSOCAFR+ZpmEz2FaK8Xt9407tl8PM8KsCvs0avMk8qQ/KR+PtvrjLEZf72fZWbcDrNrb4wWNcS9YwwZ/SjGWRwWh0xEwan6VDXXWnXMaRihsU0JBCSHH5x0Jct07CGyXts60iJq9yNkAVR3tDCjGzVBiSNaTtstGoSf6i5isrSPh+q4D8i7Iz+gO9MJAXUHwVsZmHWBdHy+xGAKN+PaCjLdoVdAxCugwSKDnIfIkYh87gVuTgT+h0tCNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHo1oRw5TqAbKzpt1nqpS23lSBvx49xHPa1Wp4TREkA=;
 b=Zl1pCTcLf0tL/Z/tlSyn3xRWhffbqEQRYOgDS1SYW7wQ7cnRIxze9/mp9chxKWpsI/qXji0Q7HQJWFPefMPbE8LO4xd5r++wCfbWUyAj176JsSccoXpLTQV8E5KnoAqbXkmSDcAURuMENEKzhZR78vOjR3KFEMHanPuSrXd0N91o+J6fsF/kjyqReQmr0UIqX5anv+4szPB6flZQBswC7DCz1zS01H7L3UC2eIYxTCCU4tDL/mGKaeH309K7nOVOc8HgRyNGXGtW1TJOaO9XTcqrtGftG4WLHMdIOHTL2W9JdDwOz24lnQoXdB0ab0eSggyiEQl6i2UoRh06OGOnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHo1oRw5TqAbKzpt1nqpS23lSBvx49xHPa1Wp4TREkA=;
 b=z4S/KL2IuNyXKALprBq1yRWfS5C5GK0BpvyyEsgLJ8sW0Iu8/aEb8vUqkmEZI06FELhy8z6YtFzi9bCfIEgvo/7MTztcBZD5LDz/T17Intg4qf0Y4dNMKSPWq2xX1zy0fXchNkkpA0hS0WXaKTU71bK/7WTqeVefIqIRcKfOFHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 07:41:31 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 07:41:31 +0000
Message-ID: <ba079f5a-6b1c-4ab7-8dc9-d54e0286676e@amd.com>
Date: Tue, 16 Jan 2024 08:41:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: don't anchor DT_SCHEMA_FILES to bindings
 directory
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <git@andred.net>,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
References: <20240116062731.2810067-1-git@andred.net>
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
In-Reply-To: <20240116062731.2810067-1-git@andred.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0081.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::34) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b7fdc5-877d-4343-76f2-08dc16668eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UV3qmpho7PSci7iZcFAk02IOH2PMD0UvBUUO/efQfreTt+olbeZKsTwpAysYHOk7OQS8vpYgIV/ckK+IHd178IjatYS27PPPYBB/eHUEaafGcbj1ekgm1M10tWokAZcseNx4O9u8BnYPy471RSm47zBRd+RY5Jju5KRji4A9dW2+LW71EsZEo3a2ej6qIN0yJ7wMfzEJ5YHjKZvTRfaWt0DGub4Cgf/VirvmtDuaUkpmFelDta8YZIWRSkHprFOca5l6CREGOx176F6fUTYoskuLDwjO/WWRViuz5DnOJD1/isEewLDhFSFiAcjnKg98/ChBCdUlKXSWdoaW6chUaNqCrgnHqdNaY8OiZtctdRnNSq0B913ARN/EizD8ZO7YZftqje3ug8w7C+KWH3nWOSQzUJh2/1WVN8cOjUrq9ncFsA6mSegoj4uoJ/Ue1X6l4uHII/GwAka42to+e+67zWkA2qb98ocukmxbcbhoqXibRXaeOdaLzcKju2DOiSN9FFZJIsv3S2aGiXoSrrEdAUqLU9RxSXmZgww/ftO2NNeGj9I5J0AAkbBZtVUmgPOdmQjcganYcTW2eC3x3ZvVCrSMqpbkr2SY9z/My6U3M1YrBQH2KdFv/Opks6tH7tbj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(41300700001)(36756003)(86362001)(31696002)(38100700002)(83380400001)(2616005)(6512007)(26005)(6486002)(966005)(478600001)(2906002)(6506007)(66476007)(66946007)(66556008)(316002)(54906003)(6666004)(53546011)(44832011)(5660300002)(8676002)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVhUS3A5S1ZmOW9pU2FYUlV2eDJWOTlrRWtZUHhCYWVFSmViZlBGejRqQmNU?=
 =?utf-8?B?c2o3VG05eVc2SjFkYjVEZjU2WnBuQVJHVzBPK2MwMmdEQ2U2NmhtbGRYQjlt?=
 =?utf-8?B?V3gwVUdsYTBZbmtxZ20wek5DaTJyN2p1dm1uVHdrK05iZFlpWngvY1pESnBX?=
 =?utf-8?B?MTU1RFdNOUNtdWpBeTVDNXNJWUhmZ0V2Q0pyR3pHdHlUQ1dHQVZtd0RoNnk2?=
 =?utf-8?B?WDh3Y2RTd3RUM2FuMnducE0zSlVrYTJFeGYzUGJFRDEydXdVdzU1ZVJucERP?=
 =?utf-8?B?QWxpWkVXV1paZjZOUkdEU2JJdEF6SlpDVkt0UmNEZEV3WUVNQlBhUnZyTHZp?=
 =?utf-8?B?am1EMmQ5MXVKM1FTMG8ycUJ4N2ZyQTZQZEhrallvRkk2TlFVN0xkbzhsVHNv?=
 =?utf-8?B?TUpBWmdhNWdHcjRZYWp3eGhRcFZHdEEwcGlPZkdzWTRmZnR4UkNiVmlIbkVa?=
 =?utf-8?B?c3FzSmwyL255K3dWcWU4STBlditKTnlhNmlEYjlVSHJ4eXhXOVRrSnVTZUk3?=
 =?utf-8?B?NjlQZVdOdktpUmZxSHpwZ0ZQYXhvM2NLaE03NlRSaExScTFSOGFRQk8rN1Bi?=
 =?utf-8?B?bmFkZnA5Q2phb24xRDFRYlVHYVp4bWJXTmF4TjgwSWtQeDVxbmZhYnVBK0Zo?=
 =?utf-8?B?WERoMjhiSHpScDdIcGY2SU9TNFM1N1Q5YVJ5anlGZHRmUXExMTlhdXVkbFV5?=
 =?utf-8?B?bVpmR0N0Rzhud291QXBoZzV1V1dHOXVXRmcyUEU5OWpubmtBa0dGQTluVEdV?=
 =?utf-8?B?K3BNaHlYZ01lWFZaWEFhbHNxNk9ldnNQSWxnMEtUeXZFK0tKUkdabkhGK1NB?=
 =?utf-8?B?ai9oUG5aa2I3U3h4ZjQ1RWxVNS9XRExoTlV6S01oaDg4cmJDbW5kNFRjdklk?=
 =?utf-8?B?OXZKaldHTjFDbTVEWFFRUTZpUlZETG9aRnFyMFBWRU1ydVNuZlk4Yi9QVlZT?=
 =?utf-8?B?MFV6eHRUczN3TktKc1A5RDJPeTZCVStnUm40d1YwODJhd29HTEpBbGcyd2pk?=
 =?utf-8?B?Q2E4S0FhLzJYcVUwZW1IYmg1QllYNXlreW9SMTJ6eVo4REZPSC9rYk9Fa21H?=
 =?utf-8?B?UWtpeTV5Q08xR2Jpc3hCbUFPczYzc0d0TXdJTWVLeE5MaVh0aWMzalNWTUxL?=
 =?utf-8?B?eDl5Wi9hb1NMWDNiUnNOQU91WDZKdXQwQ0cxRzcyZVE4KytGK1F0Qk1Za1RY?=
 =?utf-8?B?UW8zcndCSzUxS0k4RUFob0VPd1d1OUtGMUJqTTJMWEtWWjRYR1VXbXM4bmRr?=
 =?utf-8?B?akZBWFZmVlBkOEdBeThHUXZpTVFvaEMxR3hsZ243VzFGcTRBd3lSYVNFQVUy?=
 =?utf-8?B?aHdUVTJGL01HMG1qTFBXNWtDLzMvcmt6QmNtbVhabHBPeGxqSkUwcHBpQlp3?=
 =?utf-8?B?cEt2T3NXNlMxQWdRLzFyVitRTnhUYm5JR1ZRT3dmV1FZeGIxdnEzdUtjSUpG?=
 =?utf-8?B?bW15OUdLaTBJaDBrRnVjaE9VUEM1NDVmQVh4QjRuWEFGN0R1bXBBSmNUUVh3?=
 =?utf-8?B?TVIxM3krUGJxWG1qeUJoQ1lSbWRqTnhsTUF0MVRTNDRIT2xqdWZmQ0FQQkwy?=
 =?utf-8?B?UHFRbW01UW44bzNqWFRkdjE1dWdZNW5YdkZZVEpEWVJjVElYblBBSGdvNitX?=
 =?utf-8?B?aUVQY3lkY2ZJc050MjB6UkdaSTdmSlVxUW84OGhxOWg4NHhpUkZJdGVHZkhp?=
 =?utf-8?B?U0NvckZzV0NsN2lJZ0h0OXJuUnNTQ0lZU2lQTkVBcHRnYkNQanQvbHQwZ2hs?=
 =?utf-8?B?Mjg1VGkwR3R6dzRqS3NTSXU0bjJhQnZPQ0trNWVmcjhObDZweXAveUplMDFu?=
 =?utf-8?B?S2Exc2gwM2RrNW1wbDRSTDRPZ2cyUmhJTFhnT1luUk1aRjhDMmJqZ3pOdENh?=
 =?utf-8?B?cVdlS3BISStSQ1M0WVdNQnBuN2toSXVZNVRPcnNzcGg3SjhSMkFhRVErUTNL?=
 =?utf-8?B?VWVmbnE0R1I2eGpnQXFSaTJxZ1Z0OU1kVStVMkJBMit2bVN3VDNVcFVzbE1a?=
 =?utf-8?B?dlRHckxaeFRLdFhJZ2JSeUxIK1FaM2NVNWw2N3lTQWRBdGhxUzUwRHRzbklF?=
 =?utf-8?B?RVdMOUZKVVV5a3grcVlPUTQ1S3dHQlg5VmpndTBxZDdHZ0wwTHA5T2F1bkNR?=
 =?utf-8?Q?fC4nyjNKUTHKOlxurESeG9jcO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b7fdc5-877d-4343-76f2-08dc16668eaf
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 07:41:31.6917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie/A+uRvxxizkVZXy7yxB086+lBknn/Sthw1sNybaT+QGZuM3FzdTBaTI1opKg3v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246



On 1/16/24 07:27, André Draszik wrote:
> From: André Draszik <andre.draszik@linaro.org>
> 
> Commit 5e3ef4546819 ("dt-bindings: ignore paths outside kernel for
> DT_SCHEMA_FILES") anchored all searches to the bindings directory
> (since bindings only exist below that), but it turns out this is not
> always desired.
> 
> Just anchor to the base kernel source directory and while at it, break
> the overly long line for legibility.
> 
> Reported-by: Michal Simek <michal.simek@amd.com>
> Closes: https://lore.kernel.org/all/827695c3-bb33-4a86-8586-2c7323530398@amd.com/
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>   Documentation/devicetree/bindings/Makefile | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 2323fd5b7cda..129cf698fa8a 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -28,7 +28,10 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
>   find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
>   		-name 'processed-schema*' \)
>   
> -find_cmd = $(find_all_cmd) | sed 's|^$(srctree)/$(src)/||' | grep -F -e "$(subst :," -e ",$(DT_SCHEMA_FILES))" | sed 's|^|$(srctree)/$(src)/|'
> +find_cmd = $(find_all_cmd) | \
> +		sed 's|^$(srctree)/||' | \
> +		grep -F -e "$(subst :," -e ",$(DT_SCHEMA_FILES))" | \
> +		sed 's|^|$(srctree)/|'
>   CHK_DT_DOCS := $(shell $(find_cmd))
>   
>   quiet_cmd_yamllint = LINT    $(src)


Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

