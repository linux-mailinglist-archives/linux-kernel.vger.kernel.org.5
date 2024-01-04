Return-Path: <linux-kernel+bounces-16621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B08D824150
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C670EB2340F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9DE219E7;
	Thu,  4 Jan 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iWYH1tzy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1378B2137D;
	Thu,  4 Jan 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/sGD66i67H+iz9Em5A95iYqmTzTgCEXCF7O+uAb2BwkHWtQ9vDgt9VTbordr+rgCHek2FZNtdGDPsA4MwPvU9NJZe4zyD4NKRoUcnYikUJ74pEKBR8dSwzmHnwZcwuSoC/PB9A8glYt2zXCJg99k7KoaUv7+fouyBzO5r/uCEeXOfgsVIIlNIesNUfRBEFAJu8n5XTBkkBCwXeWJSR7myvSnR6cZO95FtitkdiEwvdlMjorgG7vrH/jSPuf60gyTMfi/LBkSfx0kNBxluJkDUkPZ1bbijyJA/IPC8Br3OzMQcIDQGOuhPo+MN5QP8KNvHohXkiWPy6C62dkcbvWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWXwMHn/6u4+YZ0udmmvdEZw7F1v1yv60sMt6nFio64=;
 b=e33NCeWfklWX7gdew2G3O8Atot0PPYb+UN3St81iEstOp2Xe6E9Eb3TOgKdeWlFxYn9V5g0VgtBT1iix0PNHYNfHRmiMBuEp+JkeHbl1ApUzdraq/eAkFqkFsXWkb2ocBluTdX9sDajSIF9sZzt9jna1ygDaWRnoaZrvjZjWrNs16oZ4is8+yKE61t4NsUsd051Cm3xmYj5csBPyPG3ofBUy86pyqM7YpWenTiOA93hPFg5ofdOwe8WPLtjNmtLZWpfKG/bojuC/RMSoY0XDBMX0ggzufwpL0drNEHD25RvsDGJfAFUWkGiElM63VRcoYV8+Zo4HDR2U6fbNrgclSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWXwMHn/6u4+YZ0udmmvdEZw7F1v1yv60sMt6nFio64=;
 b=iWYH1tzyly2kTx6IXs92oTtn0KO941kOjDmvtiphFZdGIiIbSN+4b7Hkwc9F395bnx7tQsZlkJYtUpX9AnmlQhbznbB+AMNKq0JsD0WBWNrWdOct3gNSTsRgirJ/wKHykY/HMnjAvWzKZTp1RldJhpPzlFIDqgHvMIuvQhfaLoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 12:10:46 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 12:10:46 +0000
Message-ID: <ece668a0-bca1-4045-a259-6a3f2280f59d@amd.com>
Date: Thu, 4 Jan 2024 13:10:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: security: tpm: Convert TPM tis spi to yaml
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Peter Huewe <peterhuewe@gmx.de>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org
References: <0f59acbb394cd09ae2a7950d8c01f8e40abf9f34.1704272496.git.michal.simek@amd.com>
 <d70a035b-b21f-42b1-a2e5-5a2341bb48e6@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <d70a035b-b21f-42b1-a2e5-5a2341bb48e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0175.eurprd09.prod.outlook.com
 (2603:10a6:800:120::29) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 55adac5b-381e-4e02-5eb5-08dc0d1e2e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U0WxO13sZQDoiwCLbC6XVao9R9DL+YwT1kXKM58yRLwNJJxVG/amz3vGrV3aUcGDV+Gu1lCW+u6FVkPURXdYkv/43vPWXag7ghUPXKIBNLJhj8H+CgU+Q+5VXtbekanLEGGvE9YlS62Ss3YjXRBWumAgDYS62Jy6m8AcGXBvVt0Pgyfcvv15sFnI3BTw9aheqybIWiTW9qXZ3O1Rrv4jO3cq3gnluTuzFullC9l4fYEzNkOj+54k2Fpq2sntDiWy026j+d5jwLe2R36FBMDVywfRQONRZ9X60/glz8a5CTwBziBnEeHzWM6DKfoMn2y3xrILhFroGXujNdOjW6BaB4bXrPUneH0vSCEpfOe3lXgKQDjWe9NC3jv40Xm70LnZKzsCnZUiwwrVMWOPGb8o36js8sURbjKSaXvEHMkymGmi4EwWAC6twFv6AA/EHWUK75GLZkS9oLVf1r/D+sJMsbuGCLM4lsFYU30V/E2Ub6/3+SSCf2HUr/eYIrMuhcY9JXvhoXoUdKhNF1ilCxKMpWv71jQX47I34cUIbJPufWoDMypChFoMvEjpt+5SniInr/u+R5Km9e737N3H24HHu3i+YOcgeLJojp8hUiI04bynH2UIFnK0yWm5PVjK8mMg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(966005)(36756003)(478600001)(44832011)(4744005)(5660300002)(7416002)(41300700001)(53546011)(31696002)(6512007)(6506007)(2906002)(6666004)(4326008)(26005)(66946007)(2616005)(316002)(54906003)(66556008)(8676002)(66476007)(8936002)(31686004)(6486002)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODFad0Y5eXEyWW1KNW9VU2R2bWg0bkI2N0pHdEt5L09wT2NoM0FUdUNNNVIw?=
 =?utf-8?B?Zk5qNzIxY0U1L1NQb0lTT2h2SW1DaHRpYXY5SjB2Tnd2S1Aycit5WURSbVRI?=
 =?utf-8?B?YjJnNTJnZ2ZLVTdXb1JsRnRRTWVGV0dCbHpZNitpc2NkTndiUU54RWRWVmNJ?=
 =?utf-8?B?aHY0RzFiRWhwWlpRSklFVGdnUXlib1I4eFhJSUdaWmRkUEdCdUpXelBLL0Nt?=
 =?utf-8?B?MnlCVzV0RkJSSEZwc1pYZlg4SXBhS1ZzaXNYRHhIYWg4RG9qQnF3M01qcm5n?=
 =?utf-8?B?NUJPa2FKL3FwU1FTbHVKeGtaRFkzWFMzZnF2OWMrZlJFaUh4UjNEL0w3SEZC?=
 =?utf-8?B?TGpMa1pmUHREUklWeFJ2MEZhL2JEUS8xMnlVMWE2dzczSmtPWkdjRmJRZWFU?=
 =?utf-8?B?bkoyTFFIYytnamk5NkhUZ3dUeGF4Z25kMUdlNDNuY0Nna25DZmFwNmIxcTQz?=
 =?utf-8?B?R1ppNkxDUGJHQWFXY0srV1BWbnowN20rRWs0YmtHY2Y3TVlJTm4yZVhjdWV4?=
 =?utf-8?B?M2poM1VxdFRqVy9CYlFFUDNlTCt3aXJhaFZsT0VCVWlJbWI0cGxEQ21ZbGJI?=
 =?utf-8?B?UGZOaUZTWkZxY3ZRUEM3RlVGRlF5Y2dzakRudU1hZWtDQWJGVWV3THRISzhS?=
 =?utf-8?B?RVluV2VhMEFqRTVtTVJKU2JLUTBwcWlzd0NZWWpNWXQ4NkVyOUFyaHd6L0Nw?=
 =?utf-8?B?bzdETmZjdkZkOXp6UCtEMmtXZnVXMDR2ZDQrWitsYzZTWUE1V21zN0JTK3Vo?=
 =?utf-8?B?a2ZabnRpTkg3RHVSdk1tUEJyc0RQdzk2emtWeFppOHJHZTdHWFBnTkxxVnUy?=
 =?utf-8?B?VzRHV3hpcDlCVjdUSlcwYmJtVUpHUUU1eGg5cE5mUlI0LzJvVGdMdlAvTjh6?=
 =?utf-8?B?TjdUbHRRQ0tWd2lEZ09CUXZmbVpGenQ4bXp4RFB6Z2ZXQmJ3a1hsQjg0V1I5?=
 =?utf-8?B?dTNhM3VZcWVUUGJLcVpuSmsvSkozcThDbUdFbURpdVhQakJ5SXQwcWxxOXRx?=
 =?utf-8?B?MGM2bGxGTjJrNVFGVk5jRXkwcFlSaUJ5NTJTK092dVJLZHdaYzRRa2xucUNp?=
 =?utf-8?B?ZzRRZ1duTHJUblJJTzk1bFprdzQ5ZmM0RFp5emdaSHNHUTVibUxDVjlrODVC?=
 =?utf-8?B?d1paWGxpTFVnZnZhOWtHdHdRVlNlUk5sL3ZkVERUTkpVdWlZRmo1bE81ditq?=
 =?utf-8?B?TkN2bjFxWHl3SGFKRnhKSGdoV29zeklKMGRzTDFmSVpOano1UEpQQUlhSHpO?=
 =?utf-8?B?L01FYVdWY05NRFVwYlNaWXRnb0t6RnFBQ3Rid2l0cE9PU2MzdzNjbkJSS2s2?=
 =?utf-8?B?c1FGY01IZmIvQXEvd0R4cUo3bnc4SkNQM3ZoN3hEUTBxRjg3MHhJekZSMU8r?=
 =?utf-8?B?SGRiUS9oMFBILytjN1lmdnlQdUVyWnh1K0VDNDZWNm9HVEdhcUF6WlRjRlVG?=
 =?utf-8?B?Smx6dFZzSndKTFdDSWM3K28zalZzbFdtQXJzK3RWTTNCK2pxeFFqay9FdVM3?=
 =?utf-8?B?ZndLdW9CcjF1aUNjQlFUdVhFbU9tOHFDV2U0MXFrSDBobEt3WkF2anltM3BN?=
 =?utf-8?B?bUU4VG5QS0duREhMN2U5TmpxOVV6SmFFcjN3UExSOVQ1dG9Nbit0UjFSRzNh?=
 =?utf-8?B?anZOL3Q4NVVSOWx3THJvdDFGdnRvbml0N1BBc3V6bWo0RG9NbTgrVnVWYlpC?=
 =?utf-8?B?RkhEcUprbXd1NFdSL3VoZTJpd3JQbEwra2hpWkVUeForU0MycGorWEhuTjNO?=
 =?utf-8?B?WllKd1k0WDEzN2xqWkhZKzVUOEFMaWdpT0JqbFRsaFNhK2N2YmZBendoNzVD?=
 =?utf-8?B?TDlDVmx1QzVjOW04dmJoamQzalJPZzdPUGhXdUMyQmlFam5Lb1N1blAyWWxl?=
 =?utf-8?B?S2VSRUJlRlJvVW52MWdxQVlmN2M4bVhSWEQ2QTVabFlBMW9CWThXcXgrbnRi?=
 =?utf-8?B?WWt2Q3QwWDR0b3hUUWVBcGlNS1RTQUlCd1hjUEJrWmNUYXpCTldhTkd4M0ZC?=
 =?utf-8?B?YTlxUjIvSWFPN0laQVptTmkvbndOL013UzB2UFZkdVM3b0h4ai94ZGxhcUhW?=
 =?utf-8?B?YUJSMlZZMjBZRmpOanYxVjhCdUExL1VBSmEwZ3BaRm16SUZxZW5yQTk4VG0v?=
 =?utf-8?Q?MrluEy5QIS+sFp4mFoQehsOdz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55adac5b-381e-4e02-5eb5-08dc0d1e2e69
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 12:10:46.0804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkGP+mrtLpo8M/MEIkIJ2jut+thTw8HvNP1CLI33TQ3n0AC3j7qmLXRS3FxYmGXX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676



On 1/4/24 08:55, Krzysztof Kozlowski wrote:
> On 03/01/2024 10:01, Michal Simek wrote:
>> Convert binding from txt to yaml. Enforce that node name starts with tpm@
>> which should be generic enough for these devices.
>> Deprecating tcg,tpm_tis-spi because it is using "_" which shouldn't be used
>> by in compatible string that's why infineon compatible string is used for
>> file name too.
>> Also add current TPM maintainers and maintainers of this dt binding too.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> https://lore.kernel.org/all/953fd4c7519030db88e5b5e12ab6307414ebdd21.1702806810.git.lukas@wunner.de/

g8. Works for me. Please ignore this patch.

Thanks,
Michal

