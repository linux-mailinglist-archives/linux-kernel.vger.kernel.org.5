Return-Path: <linux-kernel+bounces-158409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922D18B1F70
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46EC1C23122
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A4E20DF7;
	Thu, 25 Apr 2024 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="MKzKkyFk"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E9A1CFA9;
	Thu, 25 Apr 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041775; cv=fail; b=M56I/o/S+mARzPw9+HRFHMTlxrum577T4quEBrDMgt403ftB3Wg0W9BnR0ktM6Ed5HHCrHjJtEysN9OHxi+QvGbHvc9nrTzXAdtoSMY68dI7sLpTXeZY5i7Hor0cphQFYGHXcK2FlvLGg2hEKLsEG4PBsOHnQAu7FNpBJI3+f7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041775; c=relaxed/simple;
	bh=mrOm59xfa6uhmiR9Z8gMRUO+H2HPiZq+kOv4LVdrFhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pTuPHPAWG64VfjHhPETP/rhRKMc9WaD+GPu1UWXirZ4WThcmmkhLS6CNeWVB44OagU6nZ7KJSpCZSGcSBf4Sx8NcP1J04vqMRknDe0sF+o02m2lcqwBgjzLgycS/xGBDMYjcw05U8yKDmAPHUwBJvxzC227Vd7/5nuZTdfh69TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=MKzKkyFk; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PAgENX028039;
	Thu, 25 Apr 2024 11:42:14 +0100
Received: from ma0pr01cu009.outbound.protection.outlook.com (mail-southindiaazlp17010001.outbound.protection.outlook.com [40.93.131.1])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xnxsfs4cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:42:14 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4iKiqTl9LBLz92ny+M3ngxN6goI5jbuau3EkudeyflRT4AGwiO7N1sOR57gnHAcn4TwDLJTQCxxOnQ11qDyhoFTRw6Xx+PsZu1ymqEIS4dkZ3E8/5ayOFPiIiUzSohIW53SWMB6+d1Sb5qEJ2pjTWzmIm5EsKn+D/YbTlywFWN41EvuwUEq9ZhlS6r67TDiFP3CR9Vcaq5AcsK14pA50v++gd3rpYbOPfQ+htaIZUhTemlYhfA8OkL4wAElpt9tOEqbVYl8SBbBPsSmNhV20N1Z2Igv/WBECBdO5QSJbKRroM576l1LxvoR9Na281Kgirjm8/J0gB0zUWIJnyZpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU8cgZ9oi4XTfbHkZ2cp1p6eFmxvEWuZGMf7AXnLaJQ=;
 b=S/Rxiw8ePN7JQ7gJsT+C9xaTwd34Tacpcj4v8YtzxAR2/Tq3mTllddkag80NU/4XlCPgsohu+E118TgkNFC5ellQZdsT2Lhr+J3RDPgrYfYFMd8KdNA+F0RxFHWifG2jNC+b91Gj3MvFmfNZ/3Lsdwr++OVKvkzVrHx6YCd6KobD3iZfnlvEMyR4OFtKATuziZ5xdx7+7q6wEu/V6P+x1Qh/ab23EatAWyWcgfceQ9vy1iu1jyq2gOxXsvxC+phAuhNTocOmIHmHUZyXtL9F0PGIPBHZS13LxP3VUquRUjmyjOEyKxLdeAGTyZaQJo+THvGliJHqRYFiAfeFdg1KRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU8cgZ9oi4XTfbHkZ2cp1p6eFmxvEWuZGMf7AXnLaJQ=;
 b=MKzKkyFk8FWXWAeKsNO53MehGLk3yQF0MUYF+zkQ/V0/jBR3k3A5fddo5RLPfZnPweLm42CcNnw2mhDHurHrUYtxSO2IB7x+N2diYesBUzKEGzBRdm3Wle499R1lDlOfA2oRKtskvTEQk6OC+kAS3R0PpAgXD8tNap+YAUJP6/c=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by MA0PR01MB7441.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 10:42:08 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 10:42:08 +0000
Message-ID: <a5282012-d38c-4a02-9292-8eab156ddb98@blaize.com>
Date: Thu, 25 Apr 2024 11:41:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] arm64: Add initial support for Blaize BLZP1600 CB2
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "olof@lixom.net" <olof@lixom.net>, Neil Jones <neil.jones@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        James Cowgill <james.cowgill@blaize.com>,
        "heiko.stuebner@cherry.de" <heiko.stuebner@cherry.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "macromorgan@hotmail.com" <macromorgan@hotmail.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "u-kumar1@ti.com" <u-kumar1@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
 <20240425091403.17483-5-nikolaos.pasaloukos@blaize.com>
 <9b24ffdf-1247-4164-9841-6063106d76ea@linaro.org>
Content-Language: en-GB
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
In-Reply-To: <9b24ffdf-1247-4164-9841-6063106d76ea@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::15) To MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:12a::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB10184:EE_|MA0PR01MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: ff497718-c6c7-4836-a612-08dc65145af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|376005|1800799015|7416005|366007|921011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R0F6VG9XOWxvNnNYdE5zQk1OSmZtTW9mbGtYL1VsUkl3Z3RJN2ZZRFhPV3hs?=
 =?utf-8?B?OW4wQVcyTUZaOVhkYVVBa0JoaFNwSG1QWnR4eFo3VUFTcEE4SjhDYVZLWlFa?=
 =?utf-8?B?NXl4cE51aVBMSkVXb2NOeE5uczU4dGlVa09vN2dlYkQ0dzNaN3ViRUF0UWV0?=
 =?utf-8?B?Y0Vzc2VXK2JOYTNUUlBQOGg1QmFGSkFOeUdXQjFTeXRycmZpczdtcnBteVI2?=
 =?utf-8?B?T1FRMEN2djN4SmN1V3E2N3Y2TnlvUjkzMlk3UHRuL2hSd01tMVQ3ZGNPVnpK?=
 =?utf-8?B?WUtHc2hKWXgrTGNjOUYvZ0djVkpUZDk4UmpsbXZUTGYwMm5lZEl4YmEvcnNi?=
 =?utf-8?B?NjBXZlVKWkYvZGdmVEdheG00YXRwUGZiMUl0dkIvZWpvMGJGSHE4QVEzNFNF?=
 =?utf-8?B?OWxSenBpMW1ZL1Q1WDhWdm4xNGVBR0FEWXNBVGRTTWtqNkFGWkUyK0VOTHo5?=
 =?utf-8?B?bS9TT0xKelNZNEVjR3RQT1lKcm9nVDhkcmpkUU56c203T0ZqNEw5ang0OWVn?=
 =?utf-8?B?V3JoNVQybGk4c2NVZzJpbzBNZ0RNWGJFY3lnVktsM3VlWTY2T21GQk5udXU0?=
 =?utf-8?B?cHpJYUtYU2ZnL0I5NEJSRFRjcnNlaG5Jd0puVkk3MDFWRFRLbHluSzgwYjM0?=
 =?utf-8?B?TWcySlZ1andGc1pWV2RmYndHcHVpbVhoOFVhUGtiUFJPVDVaYlZyTWV2RDNj?=
 =?utf-8?B?QUN2NkVucnR6ZFZsYkNCV09SZVFZT2diZklNdDE2ZUxhNFdHRHkwTERNaGwv?=
 =?utf-8?B?dW95Vm0yNklQcWtRNjd1R3dxZnpmcnhZVVBOS3M3NnhiYy9tR1F3V25mdnVw?=
 =?utf-8?B?dVlqOTZPWnUwMmhPVDdRdmlrVlJsUmplYnBSOHFnaktkZ1dEQ0h2a1RkcDdX?=
 =?utf-8?B?TXdnVnBhZXhIT0wxdjVkWVVUSStIMWhNWWFRMVBON2NBQmE1cmY0WWt5UVdr?=
 =?utf-8?B?ZDMxZm5QeFpWKytnQmlUK2RxVitKL0tzTzVKelE0c0lERnoxSHZDN044UytQ?=
 =?utf-8?B?YTBrdW51dkxTWloybmhtbUUwdE9uV2Z1Sm1VYWRoTitJazFLV2dPMGR4eXVi?=
 =?utf-8?B?czB3aDhYaXBKRzBBbng1Z2l1YlFPNkNZWTRaTFRoUmJHK3VTSE9NUjl1akFD?=
 =?utf-8?B?bkJaSGZVV0pScGpYaFdKblZzTkY0SkVXRzdydDJDciswVThad25sYTVwMUx5?=
 =?utf-8?B?RklRN0dOclViSFRZSHhzSmlyeUN3dDlFN2dDazhUMGdlN3RjbG5SY0N4K0g4?=
 =?utf-8?B?dnIvNVBIRGJGYzRQNkphRFErTVJubkhieG83alZCZFA0U2FpZ1dZVkVKRjRM?=
 =?utf-8?B?U3E3YzYvL0hTZExWYUgwWTQyY2hTOVUzc0VWcXZqZGlDOXlDZmlwWUZNczBY?=
 =?utf-8?B?bXM1TUtDWWg5Wi96V0w3V1lldVNWWEtKMStUSFJoRTQxWHR0ZnlqN1ZHcTRM?=
 =?utf-8?B?azhTb203bjZNRzZQbEtLblNRbko1SmxETWtoVDB1b1dkV1RWeWROV0N0anhm?=
 =?utf-8?B?aDdNOVp2cHFMM2ZSSnVGeWVOUTVIOXY1MVJvY0prd0lHY0hUdXRuQ0sxblZn?=
 =?utf-8?B?MEFsRDRtRUhnSkpCSnFySnBzZGdaUkNwRncyRThNTk5hYStQN25kVmNRRjUw?=
 =?utf-8?B?VXFWeFgycHpjb2hLUk9adFZJZlRlWTZ4VnhnMElVbEduOFNVelhVQnY1Y0Jh?=
 =?utf-8?B?Y3NxZW1EdFNKSzBjUlR6YWdSS0RkZkhkRytsT0dSVStscEIvVU9WdFUxdDhJ?=
 =?utf-8?Q?xYqPFQrukForSWqyqcRrABy1mEwan/+syLFyZCU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZzhFaXUzNHorbmVQVENyNnVzTkdENng2QmJMYXZadDRpVDRkYmk4VE96NVg5?=
 =?utf-8?B?R0RtendFSDdHc1RNNXU3SmVLdHJUSTg2Q3VSRk9sWjhJR0RmUzRvVC9nV3Iy?=
 =?utf-8?B?VHFaUGVDczZJZ3ZuN216Y1pLU3NHSm1wZVVhRmwzR3I4QndQQmZlQzlsdXY2?=
 =?utf-8?B?NEdHMEJyL3JUYVNhTHNiRkRSdjhZNHdLMitQRC96M3B5NUpaWFFLaHpBcjRY?=
 =?utf-8?B?WUw3a1ZQbHdLMmRkSFVib1NnY0orblhMbStMbU5KUlVlNVhvU2pLK3ZubG9X?=
 =?utf-8?B?OEI4OVhZY2tRWG0rRlh0d1AyeVkyTnNmMkR6Ymg5eTZTL0Z0azlIaUpPWldn?=
 =?utf-8?B?UTdDNjNyZ2JSeDl1Vk9xWXoycHpCRUxEQm5rTWc0Q0hvNFM5UUllV1N1bC8y?=
 =?utf-8?B?VCtzV1pkTHNpUkR3RFhqVG9zMkZybFB5ZjdWNDFxVm1WeHE2Um9lVEhTZUla?=
 =?utf-8?B?WGFyZnE5N25Ta2p6aDl5Ull4a0pHamtuYnR5VUIrbmhvU01LZDdwcGlPeGFj?=
 =?utf-8?B?WnJ6QnppTDF0eVFRSjJQOFFxb2RzL1poR1ZOU3hSb1E2NDFld2h2VGMzN1Q3?=
 =?utf-8?B?YkR1Y3RLaC9weFg4aDdjd0hTQmJMd3RaZ3VPYmhlcjBEQmxqQVRsdWlTWjdT?=
 =?utf-8?B?MTNxdEsxeUNYMTIzTFdOM1VxejVkQktlZVpUdzg2TGJVNlpOMVhxRUx2ajVC?=
 =?utf-8?B?US8zRWNzZ0JZZFgxa1N1dlYveGZoaFhVWFNiQ0hORG1lSk14ZVJjdXFuMk9L?=
 =?utf-8?B?MTJxN1NoMGdLZE5FV09yMHJIc1U5Rjl2K3NaOExJVVRGRTRZT0lVQ05RcXZk?=
 =?utf-8?B?UkFTV1lTQUovVUx0NjU5OEZTa3dHM1Zpa1gvUlRpWnBMRHZldC9SME4zL2NU?=
 =?utf-8?B?U084RUxxWGcvZThzUjBQSVNjeXNFcVpRUU93ZFZjcHRrUnRsSCtKOFY3S3hZ?=
 =?utf-8?B?ekVodDNrdlRzL1JaOWp2bkRWUVN1VkJEaUczNEFSSVQzQ1dLS2JWdGMxZ3FV?=
 =?utf-8?B?UHlSZEtmMGlORFlpdnZKSVNWaDBzRDVqc1BucFl1aSs4OW11WW43bFE5UE5F?=
 =?utf-8?B?R0dJV1ZadTlsbmt1UDVDc1JaWm1CQWtXNGZFY2NzUkNxU2ZxSDhTbTNPb2Rx?=
 =?utf-8?B?bkw0WmpJOFo4QXhzdHNvU2hOZ0tMUjRBVlF1cXZyd3hSNTVIbGZkVlNZdEFK?=
 =?utf-8?B?RHRlQkVUVzhDNXY0N1JXT0xVR0IyL3RIMVkvMGtnam9xbU9SUTlQWk9CZzAy?=
 =?utf-8?B?eUQ3YVJJZHprZmZwSTBOK0NXRVF2bXVYemlHWncvQytkTi9kQVo3N2o3dXBs?=
 =?utf-8?B?Q0lEdi9WMXdKa2ZJZ0x4dGRJeDdPQ0pYUHJiQUdMNUxPZ0c0Nm9kRGJWaGRh?=
 =?utf-8?B?azZoRmt4WTdDZDRqVVVNUGY1WDkvblRsVnJLZmQwTmZqaHhVVnEwZFJQLzVZ?=
 =?utf-8?B?cStIQmR3ekVORGVpbEtqbjk2YkFwSEUvMm13NTdvUGwxSm5NRERUWFdFZlV0?=
 =?utf-8?B?Ni9Rcmc2bG5BTTlQNTNTVDdPc2ZFMkJQcUVERjU2ZDRnS3pFakZFOVR4RW00?=
 =?utf-8?B?WElWVCthdU1NM2NkbFRuVkN6eTZyTkZEbWoveXI4RitlbjBZb0h4VEZBVWlJ?=
 =?utf-8?B?YW1NdURIK2ZKcmxYZWVCWHlFUzFscTBxZGpSY1VvV2lFUkRubWxTaVJJV01D?=
 =?utf-8?B?TFhDK0xkdjBOOHh6eWRDU1VybHhYTUdaeDk0L09OS2RxU01yUE0zOXFZVDN6?=
 =?utf-8?B?WThFWTBKcUcrWDJmU1hxK1VGR2xjWW1wVE1iWnIxcjRmUG5DS1FreVlqSlJL?=
 =?utf-8?B?QjAyWEZ6Q3R0alZQd2hZL3dCUnhQYzZWRkQySEd6QWVUSmxnem8wT0pXREJI?=
 =?utf-8?B?YStlNVA4OUJXRVBLT1lpUjRNeEdZS2FxOG5qcjByWEREQVNSeUlvekkvSUNO?=
 =?utf-8?B?TUk0SnptbmRRK2R5MWZVaXdrRzh1K0FNOHlwR0xSVU5tMURxN1o1c1lDK3gr?=
 =?utf-8?B?SzRBSzJFbXJvTnlQQWZ0U2dKMmNkZ0tQUVgyRUt0eGd6ZThBdG04WmIwZzNr?=
 =?utf-8?B?SnhLNW9XazdZS3JZa2cwbktoTHZFRGtsVXlyMk9RbGFZcHI3YTErTWw4Z2xq?=
 =?utf-8?B?Ry9kKzVjajFSNWVRaytDZHRKaS9IRk92aE8yTVZVUlpZckpwZWJOUEYwbU93?=
 =?utf-8?B?VjA4N3NjQ3VzUnQwRVVuTU1RRDBRQzdUZ0xIWExnZDQrOUs0RUtVS212TnNW?=
 =?utf-8?Q?1J/xfIqFKyL5o/5UxpSAaM4on/6Ty/v25o8QsFx7lg=3D?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff497718-c6c7-4836-a612-08dc65145af3
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 10:42:08.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpin4ZZl4z3eWJ9rSkCIwaY9Yz0XPx59ph5wobT0jel/xse5bENgiINsUsc+SM2klQdLEaRSptm8iA+daZfGUojpyOLBT4ZokhyAG47l1sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7441
X-Proofpoint-GUID: WcEJ6CLi5XsRTELj0J6dvkD-qoic-GgA
X-Proofpoint-ORIG-GUID: WcEJ6CLi5XsRTELj0J6dvkD-qoic-GgA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_10,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2404010002 definitions=main-2404250077

On 25/04/2024 10:21, Krzysztof Kozlowski wrote:
> On 25/04/2024 11:15, Niko Pasaloukos wrote:
>> Adds support for the Blaize CB2 development board based on
>> BLZP1600 SoC. This consists of a Carrier-Board-2 and a SoM.
> 
> Subject: missing dts prefix.
> 
> 
> ...
> 
>> +
>> +/ {
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <2>;
>> +	#size-cells = <1>;
>> +
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		cpu0: cpu@0 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			reg = <0x0 0x0>;
>> +			next-level-cache = <&l2>;
>> +		};
>> +
>> +		cpu1: cpu@1 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			reg = <0x0 0x1>;
>> +			next-level-cache = <&l2>;
>> +		};
>> +
>> +		l2: l2-cache0 {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-unified;
>> +		};
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = /* Physical Secure PPI */
>> +			     <GIC_PPI 13 (GIC_CPU_MASK_RAW(0x3) |
>> +					  IRQ_TYPE_LEVEL_LOW)>,
>> +			     /* Physical Non-Secure PPI */
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0x3) |
>> +					  IRQ_TYPE_LEVEL_LOW)>,
>> +			     /* Hypervisor PPI */
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0x3) |
>> +					  IRQ_TYPE_LEVEL_LOW)>,
>> +			     /* Virtual PPI */
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0x3) |
>> +					  IRQ_TYPE_LEVEL_LOW)>;
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0", "arm,psci-0.2";
>> +		method = "smc";
>> +	};
>> +
>> +	pmu {
> 
> Nodes in top-level look randomly ordered. Any reason why not using DTS
> coding style in this regard?
> 
>> +		compatible = "arm,cortex-a53-pmu";
>> +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-affinity = <&cpu0>, <&cpu1>;
>> +	};
>> +
>> +	sram@0 {
>> +		/*
>> +		 * On BLZP1600 there is no general purpose (non-secure) SRAM.
>> +		 * A small DDR memory space has been reserved for general use.
>> +		 */
>> +		compatible = "mmio-sram";
>> +		reg = <0x0 0x00000000 0x00001000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0x0 0x00000000 0x1000>;
> 
> ranges follow reg
> 
>> +
>> +		/* SCMI reserved buffer space on DDR space */
>> +		scmi0_shm: scmi-sram@800 {
>> +			compatible = "arm,scmi-shmem";
>> +			reg = <0x800 0x80>;
>> +		};
>> +	};
>> +
>> +	firmware {
>> +		scmi {
>> +			compatible = "arm,scmi-smc";
>> +			arm,smc-id = <0x82002000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			shmem = <&scmi0_shm>;
>> +
>> +			scmi_clk: protocol@14 {
>> +				reg = <0x14>;
>> +				#clock-cells = <1>;
>> +			};
>> +
>> +			scmi_rst: protocol@16 {
>> +				reg = <0x16>;
>> +				#reset-cells = <1>;
>> +			};
>> +		};
>> +	};
>> +
>> +	soc {
> 
> This does not cause dtbs_check W=1 warnings? Surprising a bit... This
> should cause big fat warning, so I have doubts patchset was tested.
> 
> 
> Best regards,
> Krzysztof
> 

No it doesn't cause any warnings. I did:
make arch=arm64 dt_binding_check
make arch=arm64 dtbs_check W=1
I don't get any warnings. Could you please let me know what kind of
warning I should get? Am I doing something wrong and I don't get
the warning?

Kind regards,
Niko

