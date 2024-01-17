Return-Path: <linux-kernel+bounces-28631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7351983010B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D751B1F25401
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E14D272;
	Wed, 17 Jan 2024 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bej8C9JO"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870FBD26B;
	Wed, 17 Jan 2024 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478843; cv=fail; b=Kat9QvwXoV3b4xAiwZqmqg68m294BEQ2n8ZHDQz8k/HvT2oXsRFnfch4HfflDjQxYcVE14tn2w/Np1lV7p3nw63i9VbtHV6Ve3ANFedUgaiJU+4MF3kSZCqpACFmfb26wkxh0IYSsitVwxcUyyQVBnd8hVldDFPUZ4bEbSxF7ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478843; c=relaxed/simple;
	bh=bmJZo7pnlSVE2qxDNP9u92S3xDnKMbFV2xdlx8tP0o4=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=O85a1W9HEiOdE1ZV+3vbf9xC3exTZfUIP0ATqyp2BkU/4PnRdD/txfn4ZAjp7EXjoGuMiHLtMIDKsxbe2dTZCvH2JCW4zojINP89aqTfnqWgUAW1ROlarb4WwL8ldFZTuWiVa90zxx51esrTfyRpHI91g6bOBwkGtIt8rWFm1o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bej8C9JO; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZVHDkoDxk2AzTuhm/RFmEZ3ldaPgUc+5MmpCzWSEhtV/MqNvzX0FTeSn5yVThbn6vcjFOrXs7OJ9Epp7Cmqf6Bk8a16WV2gXHQS1WIJrgpFp3ezMcBkv0BteHKebaWSTXwdrekPvbTErxFhVHa/c4IQvfxTtVzRvzgqlFYx2NyNeDv5acOYYkajUBp69wOnSgsr7+7pMyOYZllzcJq1A5GmlqBVaS8MYh2KxJOWtmjM42j3p5O97qu3WKS8zkZT/EApDcrQXXwKNAK26CZbNe72oK2w3PGTAw7UTe2MicE+U6CoMu6vOe8AfDxcZn/a4PG6q/YTpeZz1hfcPhHfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9+49inD7YyF7CZ2EMRUgnGzOjUpCfb9CD4UWBWFyoo=;
 b=OfCTy4ZMg2yF1i0M9pvwmHFHtq7uR/SzZNZM5xUhT1ZSpv9PXlcArQSKLTVlRejvytP6fYGZxFqd4Jg9wN4BRRKV6Mc9stPisceuhjNKBOYpuhK6ehj0nc+qyIBF8gh84hhfr0dQNzeFQG6xFO5b5HZ3S9JQmaEoprCav5nthhtXraSYOvaozN6kuAEwL4hHSVF42ip2UbSp/hzome1POF5T1YCtfXzlZPIYAnrBTt3fpEDn5HHcdQnLx6Cfi4mwPkbQbrwWIjyk4nNYAjUmws0rog/YoAwk/pkso/6cjWfLikWZkMWBzjRZ8Fut9CGMv2fcJil968OCFngTqtQzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9+49inD7YyF7CZ2EMRUgnGzOjUpCfb9CD4UWBWFyoo=;
 b=Bej8C9JO9+tGh9urDwR0IeLxt8wiN1Dq2GDrEl7CfkkKam25BPiXwD8Z9d27ry1HCYdqXoVIUrRjUXzliHqjlC/a3MqsmccHhO31VJ4xvbmhtzl6AOE4RSYNVa67NhFpXpQnp/mCYnFchi7qYpK8TkFmPJQ5Sft6jaql8D7q7dY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 08:07:19 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Wed, 17 Jan 2024
 08:07:18 +0000
Message-ID: <66fbb19e-72cc-4fb9-9069-abc351b1525a@amd.com>
Date: Wed, 17 Jan 2024 09:07:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: fpga: Convert fpga-region binding to yaml
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
 <devicetree@vger.kernel.org>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <2a48c720bf0efce77d68a0bef10b47671b35506b.1705413862.git.michal.simek@amd.com>
 <3aef2fc5-f213-42e0-9b72-619364ef6c76@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <3aef2fc5-f213-42e0-9b72-619364ef6c76@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0179.eurprd09.prod.outlook.com
 (2603:10a6:800:120::33) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b03b47-4363-4914-cbf6-08dc173352f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CXPGcDE6mW6Q26qdXmD8Day06q7mJ+L+J15N7sxSIIyb8TAOsUplod6SnfJ/H5ERg+LghE/cECqg6XAzEevDGlLPADf7vBlEENVMa2wyBEYMH3VQcpppgwmW1HogdZA6aIbF81oUdiHAjF+ffPmPAS48ObKqk76+9Jf9p8JXxePxw0a6CVmDN3pnZSh00ff+lnYiCciGAHVWPSerZQKPPlVcRQlvLPr9rJzdSwqT+7qevKO1nJzj/f4X0cR0NEr7867AqIiCjEoauNRRC7AgoPago/pNr5M/1KrUZ+X8TCTXKzwAsVg1SIYTRyT9FFKa+KXXYHtCqRHXNCb5jLtN5cb5x6c0NT7sFTYwiBRWXdeBhZ+BAHoQZb2+EXZkQRO0xJ7R/bPRUGEckkaoox4xeHIhDRJmF5Wo6WPADHfC9oYo2EzCcKdsjJq3OZzQZ2gLbxUHFgVkRzzS2+ZilNcbVpgpj11XKwTrHa1IhckWHu+Zs/1DSUmYMTlX9KKNfY10DX8I+pOSse0v3lq1OpWeubP7eT/gIZRQQdb/BVHwU9onwTnv2pfEnwHtPt3IC3xpGnXUu6slfRz7Lq8ShUIE3ohvfj423iKKCaVTwV4g2tZpp3IxLiZ0CJOZ/CFGP2cmCsbHUv9H1VPp/qNmlngCigZtd0/nKdNv5v7Mw3lSrK0duFmh1181Fkk3Svj5gt46
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(451199024)(186009)(31686004)(84970400001)(6506007)(53546011)(6512007)(6666004)(2616005)(26005)(38100700002)(15974865002)(36756003)(86362001)(31696002)(8676002)(2906002)(8936002)(41300700001)(44832011)(4326008)(966005)(6486002)(83380400001)(5660300002)(7416002)(316002)(478600001)(66556008)(54906003)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1BScFpnQmZkYXovbXpQdEhTdkg5RitOODNxOWd0YnpQNTlJK2YxNW84bkJE?=
 =?utf-8?B?V2w2QlZ5a2p0YjhzR1Nha0xLamRTQndnK1BmYUJ0S2NMTzVqZEdoMEZkbWRI?=
 =?utf-8?B?L0pzWG9LV3hpdFVzYlArV2NSaU4zMUJ1dlRNdzczc2h0dGlCNFNzWW1OMGVB?=
 =?utf-8?B?YzB2djBvTjdhR3B6UjNQL0ZuS1JOK3prbUs2ZVk3RFo1VXZFbTh1aEN1ajV3?=
 =?utf-8?B?bkxlT21GcFlqRHlyenVMS0RTa2diY3MwRGFyOWVEU09BNnRRbFZEZkp2cXZP?=
 =?utf-8?B?NFMyUFg1NmRtV0VMdittWkFienBmWXpFbUhkWS9MbnVIbUVLRktBTVFsVTVx?=
 =?utf-8?B?eGNDNm0vSlpiK2FjaHBsK1pZbjNtNi9Ya1pnejVXMnFHVWVxQldsRGhBZ0R5?=
 =?utf-8?B?UnU0aU1hNzdLZ2VvRVB1eGxaQmNITGhneEsrTkJZc1BVcmpZSEpCaGx3dzNP?=
 =?utf-8?B?QU5BcTRJK0NXODRKUW5yV1JURy96cHpsRDdWU0hEMmZJWkNVaW1hNktqdXVp?=
 =?utf-8?B?dmcwTTVyTUdqVm44akppYkV1QVBNdGRRSFdJdWFQRzBIVHVLK0ZFK2x0MDRI?=
 =?utf-8?B?cW16bTBaNHZqWThwK0xNTzN2YzFyWmZxYjVVQ0xMbm4yYUhhMml0dDVURXA1?=
 =?utf-8?B?Wm5GMGFjZDI5Vyt0SVI4K3p4WGwvMnYzaWEwcFdYMG1YcmY3RnkxU1dYczNl?=
 =?utf-8?B?Tk5JZUVGY3FoMXBIWFB4YVZLMkoreCtMVC9yVDdRZXI5MmVsRmxPb0xuZ044?=
 =?utf-8?B?ajMxbTkxSFoycXZ3ZjhJcWI4TG01RHB5aUtIWHJQVks2UDZ2R0ZZN3BwbXhI?=
 =?utf-8?B?Yy8rRGJocERibEVONThWTlkvblJDYTVLa1ROdnczYjZNdVpxaUlUb2lHdXFP?=
 =?utf-8?B?Z09wL2xnZkxoc3Y3Uk93R1RHdjhKUmtvRlJ0dFcwN0lML2tLd043YllWM2JB?=
 =?utf-8?B?REtNaWlaZkMvV0phL2FuU2ZWdjlORktVRENUYWx5Q01uZERMYXF3ZG1DSXAv?=
 =?utf-8?B?bWJ4a3VzTDJRTFJHL3NoeGQwdS9QanZZdFlxd3hOWTh3U252aUhEVnVlYlFF?=
 =?utf-8?B?bGVVOW5RMWtlUnhsQ0ErOGJIb3pXbUEvY2xlWm1QRXB4UzVqU0tHUWdOeSty?=
 =?utf-8?B?YWhWSlRRVTVoS1FaWU9oSW1RNUpibm9VTnU5NndzUVBmNGZpLzVJcHZrakkv?=
 =?utf-8?B?cGNHbHJIblJXWTU2ZkUwdlVoTHlJZDJtVjRTUU5vM0VQd0Vzc1ZrMTZCbE9h?=
 =?utf-8?B?RXdvMDJRa1BqY1IxSXh4QS9jT0wvdG82RGJLb0pmTHRLM1IrMnRLcDNYYk82?=
 =?utf-8?B?M1ZpN3pBekd1VFV0VjduUXplNmhRSUh4OTZ2Q2pLcVhHRWFGQ1I5YTQ3R1Yv?=
 =?utf-8?B?Z29ZaWxlc3F0UWNxLzlvQ2dUQ1lMYit5RjhxcW00SWZ5TEZacTlKSDVuRE0y?=
 =?utf-8?B?dUVSME1sRnBuRXJZSHJOTDhSei9tVDU1UHh2dDNuVjdKSjVKT0g5TEJDNzNN?=
 =?utf-8?B?dHlBbVBwc085cnAzM3FRVU1adks5NDBka05WM0ZrRjFxZ2dqSzJBOTlyaXlS?=
 =?utf-8?B?YVpTZ1FJMmlwQlNjN1NDTWlzTkQ2MXlIbHFyVXpIRmpkalMxd3A4R1JEOGM2?=
 =?utf-8?B?VG5ROXRNY28xdU1JcnFkSnM3MGNCdUVNK0wwL25qNHU3alBhcElzUTZ2bFVE?=
 =?utf-8?B?RG1ySGQ1UmpCK2M5MmMyaGFSVWhNalVtTzA3QlBtcnI5NlpXbVo5ck5XczN4?=
 =?utf-8?B?WkR5VHV3Mm9sa2U4SDlheVFUOG9OQ3MzTXpLVEpJdDhjSFBLbyt3eVh6dGVG?=
 =?utf-8?B?ZUswb2tHTlVRS0dZR1BkQnpXOFRIQmlUSFl5WDJ1cXZPcXVkM2twZHFyRGFZ?=
 =?utf-8?B?SFFIQWNrSlYxeGNnNTU1QThVbUd1Mk1OcTEyRVlWLzJrWk52T0lvUWNhTk1v?=
 =?utf-8?B?ZlJHenB6by9kM2dyYjhvSERWUE9XSUV1Y1YvUDlLbld5aklwaUR3d2VhVVpK?=
 =?utf-8?B?ejJ5eHRCelVhRlhPd3kyZGRtQkFNMURZSjNGaENWRW5TN1AwcDFYbE9PdXg3?=
 =?utf-8?B?dDdyOGV5a1NaeWFyV2RVbkNGSDNGTHUzTER3TklaWHVjTXg0RE5XOTZwd1Fl?=
 =?utf-8?Q?cA2dI7M1KLbK9jByArVLMMx60?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b03b47-4363-4914-cbf6-08dc173352f7
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:07:18.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gavx1gx67E42VnyEP9rZlt6j/jnoQofhM/33LqvwgmCjRB3qpWBmE2ywjEI9n9RK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482



On 1/17/24 08:52, Krzysztof Kozlowski wrote:
> On 16/01/2024 15:04, Michal Simek wrote:
>> Convert the generic fpga region DT binding to json-schema.
>> There are some differences compare to txt version.
>> 1. DT overlay can't be described in example that's why directly include
>> information from overlay to node which was referenced. It is visible in
>> example with /* DT Overlay contains: &... */
>>
>> 2. All example have been rewritten to be simpler and describe only full
>> reconfiguration and partial reconfiguration with one bridge.
>> Completely drop the case where fpga region can inside partial
>> reconfiguration region which is already described in description
>>
>> 3. Fixed some typos in descriptions compare to txt version but most of it
>> is just c&p from txt file.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
> 
> ...
> 
>> +  --
>> +  [1] www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug_partrecon.pdf
>> +  [2] tspace.library.utoronto.ca/bitstream/1807/67932/1/Byma_Stuart_A_201411_MAS_thesis.pdf
>> +  [3] https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^fpga-region(-[0-9]|[1-9][0-9]+)?$"
> 
> I think you miss here one set of (). Please look at my previous pattern
> and test yours. This should fail, e.g. on fpga-region-0

I will look at this one.

> 
>> +
>> +  compatible:
>> +    const: fpga-region
>> +
>> +  "#address-cells": true
>> +  "#size-cells": true
>> +
>> +  config-complete-timeout-us:
>> +    description:
>> +      The maximum time in microseconds time for the FPGA to go to operating
>> +      mode after the region has been programmed.
>> +
>> +  encrypted-fpga-config:
>> +    type: boolean
>> +    description:
>> +      Set if the bitstream is encrypted.
>> +
>> +  external-fpga-config:
>> +    type: boolean
>> +    description:
>> +      Set if the FPGA has already been configured prior to OS boot up.
>> +
>> +  firmware-name:
>> +    maxItems: 1
>> +    description:
>> +      Should contain the name of an FPGA image file located on the firmware
>> +      search path. If this property shows up in a live device tree it indicates
>> +      that the FPGA has already been programmed with this image.
>> +      If this property is in an overlay targeting an FPGA region, it is
>> +      a request to program the FPGA with that image.
>> +
>> +  fpga-bridges:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      Should contain a list of phandles to FPGA Bridges that must be
>> +      controlled during FPGA programming along with the parent FPGA bridge.
>> +      This property is optional if the FPGA Manager handles the bridges.
>> +      If the fpga-region is  the child of an fpga-bridge, the list should not
>> +      contain the parent bridge.
>> +
>> +  fpga-mgr:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Should contain a phandle to an FPGA Manager.  Child FPGA Regions
>> +      inherit this property from their ancestor regions.  An fpga-mgr property
>> +      in a region will override any inherited FPGA manager.
>> +
>> +  partial-fpga-config:
>> +    type: boolean
>> +    description:
>> +      Set if partial reconfiguration is to be done, otherwise full
>> +      reconfiguration is done.
>> +
>> +  region-freeze-timeout-us:
>> +    description:
>> +      The maximum time in microseconds to wait for bridges to successfully
>> +      become disabled before the region has been programmed.
>> +
>> +  region-unfreeze-timeout-us:
>> +    description:
>> +      The maximum time in microseconds to wait for bridges to successfully
>> +      become enabled after the region has been programmed.
>> +
>> +patternProperties:
>> +  "@(0|[1-9a-f][0-9a-f]*)$":
>> +    type: object
> 
> You put (0|[...) to disallow @0001? I personally would not care, dtc
> handles this, and the pattern is confusing. Just @[0-9a-z]+$

This is actually taken from dtschema/schemas/simple-bus.yaml to allow all nodes 
with regs.

> 
>> +
>> +  "^[^@]+$": true
> 
> I dislike it. How is this binding supposed to be used? If in standalone
> way, then you allow any property so what's the point of this schema? If
> fpga-bridge.yaml is referenced by other device-specific binding, then
> all properties will be evaluated here, so the same: you allow any property.
> 
> Depending on the usage, this might be just like other generic, common
> schemas, so end with "additionalPropeties: true".

ok. I am fine with it.

Thanks,
Michal

