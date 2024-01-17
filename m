Return-Path: <linux-kernel+bounces-28659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5350083017D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C63A1C21913
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6D12B8F;
	Wed, 17 Jan 2024 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5brpQU4A"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E3134A1;
	Wed, 17 Jan 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481262; cv=fail; b=X9DtI/welAA5kWv2r9ZSfN6+6RmEpJwyD0bKrzQ8ZpdV9zLc0ncgeI6weBhVZ+p2E8FtZK26TbcZTQBDf6a+JjU/nleN4dJJnUkQTLZMfjfjtV46U9UWZfLs7hcj1Dx5fZ5PTyiMwcSBwmV5tzGEy5OabwwDVxFusJICURBlS48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481262; c=relaxed/simple;
	bh=OzTSlggQGUiMJodxngaf3FMjCASXJXmzBTqjqYD9DVw=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=qvuOIzugIEBL6qp7Hz4OjQbHi9VSgfKo/EOwGLo0Ck9vMSwnY4z/r/BDRDMyTVHQe6F023ZhcIyarpNPS5iVWPZMKtZ7Ws6qzvWHfQJNSkg7AeTjC9KPi4BV3m+FLq1gFwS6ULSRwNOM3nu+CjrlsUAMdV1BmN26xRIzHVx4EXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5brpQU4A; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K59OZRC5j6g4AeiYk8ZFWyhQXsJZg5lqy1HBj3T4fWHGenRUZdYIg50j14Ttqlxywj4VTAZRf+RkBRqbbeZ13TGeEx1Bg9k7jIMJ0rtli4Kugux4F+raSgHnqTQDYPOckAR6pKu9QKudSISVvwCepyFnGhOVn4pxnU0UFGiVwDA/3yb18QUMeZ2Gp+VbuJ9dzHSoZTUYaiLC6K0Ct2fwpB0aL5Wc00Bhdh3RCvUkjaQj6t4oIw1NRv+2vWxsm1JZrBRcZ35KaJI8kSs1Sp2do6vR3huAHi1IeZYWw1pS9KGex6qtgvE/r2bK+SdhE0jCqKkcGS2pATjyjyctazK7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73QnEBwNUStZMAUbRZ/Z89fnWkHlQsOPilswqYzmXVE=;
 b=fHkB1TJ80hbThZAEY86opH0IrsxpDsEHoL9LPjJ2TFwz5BVkWnqw6HRsHGYpGsX/XnAaJq8s+JoMTTk865uJnqlYnr3oDvqZ8MWO5fk4o6/9Ew21IqcsxGmei3NdriCIGZXRWGInohOGOlS2/6ozvvubier+NcSt66CRN9wADKSsBevq6jBsvdMeTzWIAsge5Z3YSsmbkkU28NP7hLHBNQglrbQUQA58gK52QK8PbA7XaMPppAXHsjVdJbjsvrQaP0OOwx+GrBDY1GN0neyqtaO65QZQ2rhytKz4QzGrIS/TA86VcMhMCRpuwu3hFdGKYwqF1u+8toBt9Zn4X6urDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73QnEBwNUStZMAUbRZ/Z89fnWkHlQsOPilswqYzmXVE=;
 b=5brpQU4A+5PKUs+sgjOxXlu59qJEvm1K9B3vuZQYqW3ddN6IAUY+cdeMHWa7ILpgwoad5TxQmjeMpKxcmpKU4CAxf7ID3nlp51E6uDaxt6qnAh36GNhOrD77u/vRTyp4mUQJe1hs9V0sKd2p10wzr8NFFf5MvrjnU4KdRUCmAV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 08:47:37 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Wed, 17 Jan 2024
 08:47:37 +0000
Message-ID: <ccd2a553-2f0e-4690-9c08-ebc10f247761@amd.com>
Date: Wed, 17 Jan 2024 09:47:16 +0100
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
X-ClientProxiedBy: VI1PR0102CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::33) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fdb73a-0e28-487c-a503-08dc1738f4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9IlWfhiHHmz2kH6pJ8sA5leWGrnsePqqJUIhJ7nGYHmo7zuFV/zB6OLttf12SReAM3p/RLREwHAJIGipWsuDJyRctPoIHEaevU7WsmKF1F+DMzK/uGrBB+nP/rhTQnpamHlEsvkusdczPPPkk2xGzeehxLnEKnbOxuMVFSLSkJvwov2Flpz6+6mZ+EQUUw+dIQ0ke+3Mk5xZCQR2QDr7xluBJ8P3vGwEBr57jZcBgH2zIimsWuFPnbwS8OjzcOyN42Q29B7gGiAP+7JVQJGq18CTPmNGo/3fHM2JeOEcnw2GoBC7ZZnnP30KTfWor2QC+6ivChKjU5cg7yBooVLFJOHAB9GfKy7/JLR6qmkcNKf6KPKBhspWgZQSF8rh1a4Uc2KAlkildKYnaxpTBEaIRwoh9bMprBmpuFdm1fi1rT1R9Me2XftCOQeOgxhUTdH0zCdJMDP88BopAUYfW+gME20ZsfFsbVpXtoZ0EkEsjsYoZWPAFBAAvuPJFY8P3YEC2b9j/yjz/gV1T3Ys3h/esjwZt+uzRu/yyINReypn2A0P3rud0/zmIPohcn33Ff7awsE/JbI2DjM6QICzsPSvmfi081E2ZxlBGeIHSYzlwyw/i0Ifi8n8QzAp6wMANfo3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(53546011)(6666004)(6506007)(6512007)(2616005)(38100700002)(5660300002)(44832011)(7416002)(4326008)(8676002)(41300700001)(2906002)(8936002)(966005)(6486002)(478600001)(316002)(54906003)(66476007)(66556008)(66946007)(36756003)(15974865002)(31696002)(86362001)(31686004)(84970400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2N2a09Bb0hiaDJzbUZtOXNTZTI2ejE4aFNuSkJsWnhaVVdYcGxLVE5qK2xO?=
 =?utf-8?B?M2hiS1lYTEdYN1pUYm9JOG1KMDd2N0lNMUhScDQ0Y1QrR0RKNUx4K3BKNUNo?=
 =?utf-8?B?enh1VGhmZms2VUhXT2k0RXZ5OFZzNDhCajZTRDYyWlNsYmt5SGZDaGFUdWd0?=
 =?utf-8?B?Mnl5Si9keVlLc0JvOU9jbnZadVN5Q0o4MzhHVndkeE5HNTJMMVdNYzZGRlJ6?=
 =?utf-8?B?V1V4aEN2R1NNTitod0lvOVhYbjNKVFRuNUc2OVBtVFBNRUU0STRFS3g0NXJl?=
 =?utf-8?B?WWMzbUZ2cHJndDBrNlljemZ5TGxxYXFGdVNQcHM2WnZodU5yNmxaL0lXYUdo?=
 =?utf-8?B?TGRmYWJuaFEvVXlYb0tKOUJHdXBwOHg4aEtJZ2s1cTZVNHZZSUZxUFJDMW5N?=
 =?utf-8?B?RnJyVmJ6aW9SSDZHL0FScXowSndNRDMySE1VVFpYbTBIeHQ3YkhiRUZqR3FS?=
 =?utf-8?B?OWJLS21rKy82RW1VSzFQdmNkNG5XUWsxUkZYZ2JxZEpIcmFBSlo1UXltM0V1?=
 =?utf-8?B?RDBJYy84cS9aMUFBUjYwOFIxeVZrdk9OcS9oWS8yYXorZXZNV3VtbFkydEJI?=
 =?utf-8?B?cG92eU90S2pNOEgvTkJmNXR6YU1mbVJhekFJZFlOK01saFhUcE5NNkNpc1Zx?=
 =?utf-8?B?c0N6b0pnckMzNzRPVFcyUFFBMDh4cjhHbEQ0TDlXbkdCdEkya0RSYk5ROUFl?=
 =?utf-8?B?T0ZUZkVQeHJpQlFNSnJwWXAzSld0WmFSSk96NFl1YWhsU2FaV1FkUVpnRGRh?=
 =?utf-8?B?Vmg0UHpmdDdoRS9aN1ZzZllkMC9lNGw2eUo3dExMT0NyZHUxT2VIQ2R4T0da?=
 =?utf-8?B?a1RTRkhqMnNqZGxjZzFjTjY5ZE9TTUUyUzFQZUtCeExWRFYwd3M3dGg5eW91?=
 =?utf-8?B?ckoyQzkrMlNGK1RYeTIwalI4aVRyMGtVZlIyZGdLUHUwUm5OeS90L2dicDBC?=
 =?utf-8?B?ZUpTamh5VXYxOERlTHYzQlhETGNTWGpRcDJ4cjdGdU9VWmhNNEtOTTU3V3kz?=
 =?utf-8?B?d3M5bm9EM1ZySTQrL1pPZ2RpRlRpVHdTYW5lU0xLeVBnMVJkM25ST1BSSUtN?=
 =?utf-8?B?VEU0aFRwTVhQK0pFMVU0dmFjUkdKeGFCVWQ2cGtUVXZscUlFTmlzSWRreCt1?=
 =?utf-8?B?eXNkT3VsYmVUaTV3WU9NR0g5bUZPamhaeDc4ZlBvY0M4ak5RaDZ1VDhXQ2xB?=
 =?utf-8?B?dzVuV1hCQVZpcWd1QndUUUttSmZObVdPcEMzOWVnOW83N25Wb1R5bWR6Q0RU?=
 =?utf-8?B?ZTlsV3F1ZEY0eWFKR0lYeEFjM0F4Yk1RRTQ0Q3RpZEt6angzTVp6dlEwNEVZ?=
 =?utf-8?B?T3prdXhhdENqMjlhV0VGTE1BTGZqWHRmM2lpamNwdVkrdEdoakM1bE5yUXR6?=
 =?utf-8?B?c0VjdVlIZXlvUnFUVkJaMGZLQXdSYXhoN1pWZldkMzMyNXJYUWdLdGRaRkhK?=
 =?utf-8?B?WmVMT2Ntb2RscW5vYTRPMHdWWTE5eHdFRldUTGZPczRjSlRkYkMyMzdKUG0y?=
 =?utf-8?B?R2tBTks4STZBWG8zMWhiU3RZelBKRExERjgyOGova0w2L0ZWaHRZUGF5MVNN?=
 =?utf-8?B?Z3NkME9UUkV2a0t0Q1lZODd4aEU3UU0wclppRGxQZHRkcFh0ZTdSNXRPMW1v?=
 =?utf-8?B?a2lFdWE0OFJ6VUE4RVkwd3o3VUZVditLbnJ2N2NTbUJ5cHJVSnhJbzhFRElP?=
 =?utf-8?B?Sk5zb2lvdnBaWHp4bzliZTkyYWp2bEx5cDcxbENWRkkxTVE1M1lKYXpURGNZ?=
 =?utf-8?B?cjJ4UzVXaGJFTzZjVWFiYkExYzZIbnhWN0l6SlBqVkhmbE0zcjlRMWQwSjF6?=
 =?utf-8?B?eG12bkRGWjExOEdzdWkwN2hncU5OOXVYeU5vdlpTSTRtWHdzU2h5YUY3M2ZW?=
 =?utf-8?B?Q2pjZE1ReEROaGJEdmdKczhmYXVWZ00zNFBlRExUNUQwU2VyM2hNZmVoT2Zp?=
 =?utf-8?B?VUJYL2ljS1VXS1B6TEZYZlFRdUFOeXNobzJneHNIYzU1SDM4VzhYNEZaZmJU?=
 =?utf-8?B?N3N1S2h0TXBYWGE2TU1FTGg2bWRQM3M1UDVHaGFNSGk4aVBJL3BkVDlGcTZo?=
 =?utf-8?B?OW1vUjdGK3J5Y0JwcExydUc5UDd4bUtHTlpDSEpqYStuZndKdHozV3ZteVZM?=
 =?utf-8?Q?UCJRgraT3ms3sZvKMVlAogCwU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fdb73a-0e28-487c-a503-08dc1738f4c8
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:47:37.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8oakYxRPfbThyZ4tGTE+Aem2n5a/cF/gwDLe3tx7KhEGrVFUwJB2yTgt5S0xAO6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894



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

you are right her but it fails on fpga-region-10.

Thanks,
Michal



