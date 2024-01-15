Return-Path: <linux-kernel+bounces-26265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E7C82DDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD748282D90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6532617BC5;
	Mon, 15 Jan 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fBK9V2Bk"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF42E17C60;
	Mon, 15 Jan 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh5HDPdWUMzGFMVlpb3jmNyJFYVeWhS+E3xC8JF38JJOj3GxMk0zgcuWlw6TGuH4BU1tTfzXGC69lBAdJL7ioLgiIwhWjxEnw78MogI8qnJOdFrfFeLmZZHAFzUNcYB2+wYkJD3YNlUx0psPmcquf7/qaE+dN06HaZ91Wp97vUaVtulxFY0ar6XoDv/NdLtLwj4xveEqwCS2FTPbHkKiuzSO1Pk/kvMshtyezjtlqcREsfUButYJJXoP22X0aON63g10HPw6VUFeTyFeR5QK5oJGVNCT2+DvKGSOAmJcIamiou8ctVTI24LLyFlsUr+Wbd/XNoMLu4wOLhaSVkWqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpuuO3Wnhfqse2C8nZa4baMQiW84oVk5Btl2zE2yjNs=;
 b=S7SJAapKvackhHtpNhR4g2YN84THBvhSJmTW9CrIN6fN528kfMyKptkui/yDkp6jCMXuggMYb3qTMsbHGbtuClzykoQbn8Z0gdNBIQdNqlVzjVctmkYZSXcfTkrkqKM9EcFyxFNoXNRJWwBYoEuEnsTyvTMSWnVOpRvXqbVHMku3p7aqQesOhHUSA9aHoQFY14+JM8dg1GD2luvrJKw+y1Yysu491sUuJNuImwpMvoH6RgFOCWbSCPl/Pq9mCECnbc8Btf/KO3OjE/XDoGAiZG1oCbAzjO0LRaOefNxDjHW1lIilPcx//2UQCQEFC42fJlHP6rqqV+3C/lB+pd3h/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpuuO3Wnhfqse2C8nZa4baMQiW84oVk5Btl2zE2yjNs=;
 b=fBK9V2BkM+jB1YjCVy5IUIdqSklyr8goR/ZmsMl7mcse1O3d+DkWSiTjk2C6E0Hjh9p6HMeO4jvZ6oUm24MpQTpk1ia0u5WTZYSxgvPJYNbpexm4E4YuFop674RvHhPSCq0ll6apXEOqEj+O7up9Xr0K6OWRFdYwRsluzeyRrM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 16:38:00 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 16:38:00 +0000
Message-ID: <ffd6f60e-fea9-4426-a981-badd3c68cd4d@amd.com>
Date: Mon, 15 Jan 2024 17:37:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ignore paths outside kernel for
 DT_SCHEMA_FILES
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20231220145537.2163811-1-andre.draszik@linaro.org>
 <170432630603.2042234.10993333941885772911.robh@kernel.org>
 <827695c3-bb33-4a86-8586-2c7323530398@amd.com>
 <bcd89ef7a43eb7d652f045c029d8e108adf7ba32.camel@linaro.org>
 <20240115-fragment-clean-95ef01dd8b20@spud>
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
In-Reply-To: <20240115-fragment-clean-95ef01dd8b20@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:a03:100::36) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|PH0PR12MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 756643c7-5121-421a-d688-08dc15e855de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nuuNoifCV6cKopchRRXL/WltjFT1KhPoFagJcT59XXhezFrp/xrazjsM5JLbG8m/PofkRzkG2332AhxNCnqKILcQXBo5HmbIDhTjmCeZzwpn+uwHRScIXHmxDEjh9m+3o91p3PkXia7CJKdNmDS47A5AIBVrDK/cVPk+Na9lC0xuUXUj8WHnvpBm5tEf0/MMqmyGSkfnRMOvk615w3ejsu3+eYy3jlD/11Sihxk/m5WDz3gdZs73gLRURn6pgb6Q47wl5yTn4GP7RkbSJS/N+PybXqSpk/CWXaLPmbJjjqjJRvxBicQXePr9frGmsqnVc8FVq7l8Fm0bBijDri7zlKPqOA/hrYjrklJJ7B8wy07Ab2NEK7cjdWa9Vo2hN/AcoyaBQNV06pMV+dgaKD+eXbfRQDuS+s4Q5yVmPFe0xxWBPZ4EkumLAUssVBDN5iTjcx8bnhVH2GFwrUMXfjxhSK4XNPvrXGyGq3O/v4E8+98wFud/1wzq6RIujubUPfPhwB6klyu+jmfaOTxwNCdYvQgSZ3siyL8RTjc8OPLu9x/ppsKNA861Y3Mt/jo3EZMyfwqf5VSTCpRUDHOOMNiM5ZmNbogqU3BIK54F8Fz0oF5UiYPOSIkBHeWCXm9SoPXDr8zc3BRL5wDQGaVcOHEUtQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(6666004)(478600001)(53546011)(6506007)(6512007)(2616005)(26005)(31696002)(86362001)(36756003)(38100700002)(2906002)(44832011)(41300700001)(4326008)(7416002)(5660300002)(83380400001)(8676002)(6486002)(66946007)(66556008)(66476007)(54906003)(8936002)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEo3VHYyekJVbGZseHY1QjBZM1p5QWVmWnp4R091WkcrbjNBeHBqejROSzIx?=
 =?utf-8?B?eFNHV1VmWDQzcXJNOUZDenZseU5EajRhRGlyVW1mLzVvZWV0eXFyaFhZRVF5?=
 =?utf-8?B?ZFBlQTVTcmhCWUNoMlE2eVhwcWhoamJxMUwvbWJiK291OHh2a3lKbWNZMXZW?=
 =?utf-8?B?cEhveFhKT1lsSG5DcHpkV09UcXQzRVZuU3VISTJaR25HNEVwZjdvcjZHc1R0?=
 =?utf-8?B?ejhXUEVicDhKTHEvV3VaR2g3djc0NHBvdFFlci96cTVLS0Ura3hiK1c3TGJV?=
 =?utf-8?B?bGI4YWlqRC9CMm9QRXk0eHNmNmR1SnZteUhDRzBtVnRReHlzUGx6VndJUFBa?=
 =?utf-8?B?RHBCMFFyYTdMWk4yeWIyQTNmU0VNUXpib09oK0dEK3BPa3FFVWthenh1YWR0?=
 =?utf-8?B?SEhsbVBnaE5XTVRnUWxlNHM1VWVFNE1zSklDemxiN1EyMFdXUlROaVBWZXE2?=
 =?utf-8?B?K2tQUFhFZVNOWlk5QVRsbXRDd01XUUtVY00xcDFEY1NqTm9nYmM2dUhTME44?=
 =?utf-8?B?TjBNYnFaUjlKZGRrWFNNQ3EwWDhHUDRaYXZVbXZwYnJtejFaWmszekpZQW1y?=
 =?utf-8?B?dng0N2JsZzJQd2RaeXNNSDFBN1RVRUNqd2ViT1N0azdlZUw0d1dsYWNSOE01?=
 =?utf-8?B?Y0ZYdlZEUitmcjZkSFltY2hUT3hveUFIZWZuS0J0Wmp1bXFJUndiNEs2ZXF1?=
 =?utf-8?B?cHB5K2MzYXF6V0xnYmNnWVo2WDZsUk1wcmdPemZxWTZtOHZyUUlZZkdCODBi?=
 =?utf-8?B?aEZKZDRRbGhzNFRHMG5KM1dKUnJGNW5BMk4wTkpuTEZ0dGc0aUJDTjJLdFd1?=
 =?utf-8?B?aGpVOWR5V2t0MTRkS3NTcUdQOUtWT3RyQVQ4WGJzUGViVE1qaXFJRzlpUmVL?=
 =?utf-8?B?ZDgzc2ptTGV4T3BkQ0hTemNvTUw3YXo0K3lvMTBPSVJHL050anpvMlhLTmV5?=
 =?utf-8?B?NFR3SmdaYWJBck9EeXFFSDkzZ0lEYjBHQ1R4clJmVjJTamY3WVBCalorTEYy?=
 =?utf-8?B?azd6WFhrYlg3dVFidDc3VzVaQ2ZETDRKUjFmelVyLzcwa01Ra3VaMVl6SVBU?=
 =?utf-8?B?YTcxL081SlZBTlBGK2xXdVhHUXRvZGlPbTAzMDJucmZvQS9hS1ZqMVNDOXB6?=
 =?utf-8?B?cUUxZUFBNDllTjhoakVWRkpLZVNmOWdac0FIYXU3bHdkakNQMWVYQkhwUTBt?=
 =?utf-8?B?bXVBUzVqRmFzZUZpZlAvMzBPbStSclIzTlpyejdDaDVMc3B1Z1lwYVNpTnE1?=
 =?utf-8?B?Y1pnQWRMbzV1d2l0b3ozSFJRZkNPT1ArUk0zcmFOL0xwd2hURXZ6UlU4WXpD?=
 =?utf-8?B?UGRqeGJUdG90RzY3SnlzMHRJVmNkM3pqMzBmcEtqYVZ2S0R2QUtBVDZpemhm?=
 =?utf-8?B?Z1ZUWUZVNG5nUUFMNEVZeC8ra1czY3FQaHkyOFNGSllWdGFaTFBzS3NjSEpB?=
 =?utf-8?B?MmxZUENXVjBoZmxBVGFDQXcxV1cyMEg2VnRFUkNMQnA0ME4xQXVWako5T0hK?=
 =?utf-8?B?dFdVc3ZUOEhnemZmSHUrSkhpcnVKMVVOZEVGdHhVZGxvVXZGSm1BTVNsN0RE?=
 =?utf-8?B?OWQ4MkV0T2JEY2lzUHdoTUFXSWw4SjNTT2M4K2h5REI4anpMYnhBU3Irbndr?=
 =?utf-8?B?ZGR0ZlI5VGhBY2RDeVp0YVovUVhoU0t5UGdmWDFxazFNUzhtN0pyVnprWW0y?=
 =?utf-8?B?TUhEMjlMelpESGcxNWluYko3SnRTMUJFQW53UmVVWEw1YVhZcHV1MlY5d1kz?=
 =?utf-8?B?N2xCZ2ppSUFDZFRNKzNLb1hZWlNQMjdnQy91ZjEvVGErejRabHVkMnBSVUZx?=
 =?utf-8?B?RGxiRFJQSzVwUjA4YnJqWTVlaUVhVDAvREsyM3ltN0Z5aHNXcHJEN0JMdERo?=
 =?utf-8?B?ekZWbjAraGtrcThsQStvN05vSkt1ZG9FQlRvaHRkVnUyOVZIY0FrblB5M1dW?=
 =?utf-8?B?L01wYzROaHErU0RSUmxwQTc1RUZGVkVTb3B3MHEySDRjczVyZWdXRWtndk5Q?=
 =?utf-8?B?ZUJZWVcrNzdnRDUxZDlrajJ2azFlTzYyTzFWclVRZEc2am5QVW5mZHpHUlRk?=
 =?utf-8?B?dVdHTks4Qm9sWVZNakI1eGVMcm9oVTkreUNqbGI5aUh6cjNiZS9kcmd1TmNB?=
 =?utf-8?Q?trWJ1VW3wuKH52Ff/pcu9xWWu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756643c7-5121-421a-d688-08dc15e855de
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 16:37:59.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRwdc/cNsghdsYd1vnO8z9XYnntY/Gw8d3SdRUP79Fn3QmcmZ+ZB8dCzjsp6Us+S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5401



On 1/15/24 17:29, Conor Dooley wrote:
> On Mon, Jan 15, 2024 at 09:40:37AM +0000, André Draszik wrote:
>> Hi,
>>
>> On Mon, 2024-01-15 at 10:20 +0100, Michal Simek wrote:
>>> This patch is causing issue for me. Look at log below.
>>> I am running it directly on the latest linux-next/master.
>>>
>>> Thanks,
>>> Michal
>>>
>>> $ make DT_SCHEMA_FILES="Documentation/devicetree/bindings/arm/arm,cci-400.yaml"
>>> dt_binding_check
>>
>> It'll work if you drop the 'Documentation/devicetree/bindings' part from the path, as
>> it is implied since bindings can only be in that directory anyway:
>>
>>      make DT_SCHEMA_FILES="arm/arm,cci-400.yaml" dt_binding_check
>>      make DT_SCHEMA_FILES="arm,cci-400.yaml" dt_binding_check
>>
>> both work.
> 
> Requiring that is pretty user unfriendly though I think, passing the
> full path from the root directory of the kernel tree would be my
> assumption of the "default".

I am using full path like this for years.
I can fix my scripts but would be good to consider correct path inside the 
kernel is something what this patch should also allow.
Because path above is correct and it is not outside of the kernel that's why at 
least commit message should be massage a little bit.
I will let Rob to decide.

Thanks,
Michal

