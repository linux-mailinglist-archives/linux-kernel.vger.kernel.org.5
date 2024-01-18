Return-Path: <linux-kernel+bounces-30098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A038831932
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F8B1F2641A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E480224B42;
	Thu, 18 Jan 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xZ/Q3mK6"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E26241E2;
	Thu, 18 Jan 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581278; cv=fail; b=i2HDE9Zye5WajSK8jE3ujlfNCaadc2ixooDYdbpBexdhyNsKfv4G4G7V8h8nNiPVXxhuz8rm0wPc0wij3ZtuTFEREuMru9D5m7bFolJmuY8JiIoCp9HcU2X2aTnJvwXP655L01AQ7AqfPjTW+XspNPJmCRM8kXQAimWzYOpMPZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581278; c=relaxed/simple;
	bh=XRyM0j9y607GLT1+S1791SME9g+p0IgcZNwLohzB9cg=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=ZVULxoTF7QEFBenq+fPp5eMJBE+SZoQFIFF1vv1AHg0bo9JsTVl0jk0WiQyig9CCn3hfCDlODKkRc7/ueXjfciXQNkf20MkqnMYlyJitpxtowGhyxx97kwN1JHKM3/va/tHqzJPHKdjJoIno6Z+6Im5Stz0Na21tWh5l7NCawLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xZ/Q3mK6; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGAjcZWzv/16hUJrADgH9ImjjF7JL1Jnu/P0vj1FXVVdT37qZHo2WdMrIpNs3XpoqX6pEGuoRke8RTAyA6BbWEoHDjNLBOMmfzsieg7LdnG7lAYVoKiwQ78JDmF1rKXQ5AZArY/pR/BktF7fAjRBCKVbMBIHr4+WYtG0Uzd4gY4w+5tgt0EJAWqy9o0xaEQ2jM0PydJzRXvLokA+7JTKAzlzgv2+y6ebnKwuF5NVNvNKU+n1sqsqe38LktaxKX7b4/nMP6HZ71AD1chbESXgHN7YzI6xDbOIYoeEkcPAKVfE0HXALRR8xpG3c4vDhX+zpnIqWYA5hHqbht3GA9qcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXa8teuA01TyjkJDJQwnrno64tz8iWkOacD4Q2IbyMQ=;
 b=En5ZnWRFtQFap5NUdqPvaN1lQ7Udb7OeOr3wKeamb2W96s5j2P5tLlm1ULim/7/mdkd0mPBcpJRo/LYkF3h3xg7Ruvorrj1/EEU18WO2BF+adJ6exO5Ps3cRUjeigSfiZhzaXwG6bZOaxqPzL9R1y/ZORLq7QccR5YoR8atADo3gh3J5CPaB2LMUzTkhl+mUVIHuh9yMPVcRZOZNNiUHdxDrFdeUYmvaaQP/GoAIvJJl0RroIl8gUD/TlDJXndIpnoXBGRi2cVRjxnUaLbeDcTXEBinCOynTO7iLu3pcpjSQStEGqsNmaG31XAqwUsCdmeWAPMpY2ogatW27tbcx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXa8teuA01TyjkJDJQwnrno64tz8iWkOacD4Q2IbyMQ=;
 b=xZ/Q3mK6R+kfHJWy7PVNfnW2BFfhoSOS60zqErmuQspS+nBbucB4PwhcA3Xz4pug9aJp/Z/qTXtZPQs8795eXj8EREgYYlDM/xt+r/bOK6npYrT7GBkezSDGBxhENIxgfnf7Huf+6hUVG/RrCj9y0RCrifIpnJGToGxOxmLyxuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 12:34:31 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 12:34:31 +0000
Message-ID: <1aa2c865-3a9b-441a-ba61-b551f3f7a832@amd.com>
Date: Thu, 18 Jan 2024 13:34:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: fpga: Convert fpga-region binding to yaml
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <4d87561dcbfab9e4818d7ad99caf89938774a839.1705491050.git.michal.simek@amd.com>
 <20240117214722.GA3176505-robh@kernel.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240117214722.GA3176505-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:803:64::19) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cbb858f-54f5-40a9-0949-08dc1821d1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yYtb0HyGbkjtc0Qgshyn0sYf++ztOR17WzowkY4U+nkwQ/V6ba1VWrOEYxmp22G13Uf5RECG5sz9PZU47j+JHm2JgJHSitfh/C83LnyWKMaHXPDgyF4pivEvBoqhDPeXIen+56DR2McDS06o66HHo3ujzCRiLiLkQ8FZYxJJ3CzhrE8ReQIY7esfHc0LmpIz+4N0WJSjQjvhfPTe8NRuisjglueSX9FWoGtHv2fXJUTJ6PMIb1KZDeovbAY9cqOAGMILXB6WABr5R6sjCdj9fq8HHlkYQ+hihRw6HEjXNZkEyzKOMTHz1q4CxC6cMO58OiZrnsucDjKaX53WZkAWscUnsNJR6TRriRfa3+WwWO4TwYGYiYTBLhIq67DVCNfXC4/ODgD2IY3otjjpA8mQfduUdbmzCXjKl1qwkBUFKzFZSlD7GLzTII5KIaeiFMOHfv+GFzaiwootcqi5Yn6qy1+3bf9OXne0Iy4FKEVIxJhhbNKxjrMtuzqLOssBGJ7xugUtk0xJFYFbTFFqbm8YOS1oNRRZYNxM6TofB+WIyPBkKfmDzeV0IARRg4SBVzFJ6opu+pfIBWJHaUbo+79kO366ujXvI4kadtLT6fJMM8BWHcb5lmToZU4L1dhdPPfKxq9HBdANEkAilO8+j6zkV1d6oX65BG+mLXZR9zx8Wrhmbf9SWDyTeq2ntvUziRdeCla2UA36Tuv86sFKC4G29w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(64100799003)(1800799012)(31686004)(84970400001)(6666004)(966005)(6486002)(4326008)(83380400001)(26005)(8676002)(8936002)(5660300002)(53546011)(6916009)(316002)(6512007)(6506007)(54906003)(66556008)(66946007)(66476007)(478600001)(44832011)(2616005)(38100700002)(30864003)(2906002)(7416002)(41300700001)(15974865002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmhmMnJyUGRQSFlSWlhRanJLUXRDVjZBVTVtczh5Z3E0U2wwS0pYQkZKeDls?=
 =?utf-8?B?RkRCSkg1bURTT2RtdFRCN1NkOHN6TUNCWVNoTXB2ei81QWkxTmNIVkNFTGsz?=
 =?utf-8?B?WVR2MFNRN2p0Zkg5dUI5d0h3bU5vWTV6cDQzNFVQamIycDRpUVNnYkJ4N2lr?=
 =?utf-8?B?WUk5emQwNG8xeVRJVlRHWHJKbDFhYkFDZ1VjWXF6Tzl2QkJ3T0VPRDJpQzFm?=
 =?utf-8?B?anNWcmNUQW5rMWlDOUdXdThuakJCYW9PbUJaRkxSY3pEemhjWEJzV3JqeGJF?=
 =?utf-8?B?OFphdHRSRkUrd2lPSFQ5ckgrd0hPWU9TUnk0K1NRdzd4Sy9tN0dPeDlyMnZR?=
 =?utf-8?B?U2NEYzhzMlRub0xpRzdydWcwYklrb1pWa2pjdE5TR0F1c2VmQnBZQk1vTXF1?=
 =?utf-8?B?c0Zla04zZ0hSa0FpaXp2VURWMXlaYkZ6Z0Z4K1duUVNoekxsZ0V1Ym1xbUpZ?=
 =?utf-8?B?WU4vZCtqT3NKZ3RWSnZHM1UrTGxJT0NPRHhtTlFDWmtkWHNodHNhbVJ6THdB?=
 =?utf-8?B?NU1TaFd0VWR1eWRob0xvd3ZMaFNDQ3grZ3J5T04ySnh1ZnhZTHBGTUNlcFUv?=
 =?utf-8?B?c3FtZEJzYVBBU0NQRFg0K0F2dDBkVTE2bFhrcWxUUHZRakRsQS80VzNQVGR0?=
 =?utf-8?B?WitpT2FmS1ZXbE1BbUpvRm1YNEJoVTIyUzM5czU1ajc5TGpYK2RsVnNRbSta?=
 =?utf-8?B?SktTOTlRZjdtZzQ5TzFIUkRVeUpCdHdiQVRzdDRCbmZOV1RSUXk0eHBGMVlw?=
 =?utf-8?B?Yml4ckxyRU1qOSswdjRYbnJXalRybVNkLytZYlFsdzFESnJLWHU5TTMrLzla?=
 =?utf-8?B?MG9lUnFEdGR0bW1NL2ZxekU2SVhTNnM3L1F1eUdIUnh3VUFTNVE4OWdXQXVK?=
 =?utf-8?B?clV1MTRycktiT0hyUTFIcWpaMzhWQjRnNWNPYmNZTU54SDNNcVNyaDU2L2t6?=
 =?utf-8?B?aGpPenFzMS93VTdLMCtSMDVibjFZYjB0cmVaZklRdmxicjMrY2ZQNW9ET2ZX?=
 =?utf-8?B?NVFiaXdFcUdwN0ZpTGJuU2IxTm4xbXk0Q1Z1cit4MGt3Tkd3d0RlWlh3Uk0w?=
 =?utf-8?B?aVN4d3dNTFdPN0N0dWxqeXBnbFU0dzhEYWp3cFlaZlNha2ZsTThQd3pBL1hi?=
 =?utf-8?B?OSt6T01GQkRJdUhqNXFDWHU2OHFxOEJsa0FrVmxtaFlUZmM0TWJDZ3QvR28y?=
 =?utf-8?B?S2svN3pxNzl5VGJOUTI4dUFJem1WM2ROcTlDZldkdllpZXpxVVdWMHByUCs1?=
 =?utf-8?B?TzVYSU4vMUtTMVA4MmhWQWkvaTdpN0syWkRoZUpuTXcvUU1iRWpEcVRTeHJL?=
 =?utf-8?B?V2QxSVBPeStydUlNUC9vWW9DNUhwYURnY0FBUXVBdHhWRk5IRU9TWmluby9s?=
 =?utf-8?B?dnp0TUlPNEN2V0FsY1VGemR5RzNEc1JjWk10clVXVS9MN2tnbHNYNHlyWXI1?=
 =?utf-8?B?Ti81cGh2dG1nc0VXOGhBYWpKMUhvOWYrYXg1UmhwVUpLVlMzL3FCN0ZiSHVa?=
 =?utf-8?B?Vi9lRVdFbUNDdU5vZUJQWGw0b2pIMTBpbnA3QTR5VElHR0tQckF5RldPcUE4?=
 =?utf-8?B?Z2RRZEs4K2hxK0tUV010aEZmWWF4clE2ZDlGbzNhYnR4Z3FGTUVwYUxPeDhD?=
 =?utf-8?B?MnordzhsKzNIS3AvKzZDSWFoOW5BTU5XM0V3OVdRb0Z2cHJ1MkF1WmJ1cUY0?=
 =?utf-8?B?blJISUl4dXZGdFBnYWlmZW5mUWhIcC9WSHVSczZIUjd1WnhKWUFYSUJBNUxj?=
 =?utf-8?B?Q29WTzFZMXl6bS9Lc0NzR2dFZFdXWlczK3V0S2o1aWxxSWt2NGdUbU1SV2Vp?=
 =?utf-8?B?MHJlRk5Ha1NoV1dwY1FWSFRBSnFVbmg0VEw3bHlvTTRVYkJNVmI1dWVIN0N4?=
 =?utf-8?B?TWtZRWs4eXJjOEM1OFR0eHlKODZYNVBveEd6bjBncVM2WlhDK3ZJUHR0N1Zk?=
 =?utf-8?B?YW9STTRBek9kRktkcU1oeWVJOXNIYWZNR1VnaVpJYXJYL0haY0JQUXZOZ1Nu?=
 =?utf-8?B?ZTQ3Qm5oWEZwR1orR2lMZnA2UE1zVlpzYzh1ZFZlSWFEdWxHdVhMeUUvc0xB?=
 =?utf-8?B?ODRCZWFvMHpNQytMQ3kwc3loTWR1MHAybjY5Zm5wMFk5cTRBaitHTThhcTIz?=
 =?utf-8?Q?fZ16EmO9aEvqOapiNpDtYqjiT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbb858f-54f5-40a9-0949-08dc1821d1d4
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 12:34:31.4702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRrdvquHMCSem7KcOuSWm21QfndOiZoJ98ZoGXWb55axbOS9RadtJRHgRSBogazN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130



On 1/17/24 22:47, Rob Herring wrote:
> On Wed, Jan 17, 2024 at 12:30:58PM +0100, Michal Simek wrote:
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
>>
>> Changes in v3:
>> - drop fpga bridge and mgr descriptions in example
>> - use additionalProperties: true
>> - use fixed-factor-clock instead
>> - fixed matching pattern
>>
>> Changes in v2:
>> - Fix typo in subject
>> - Fix comment in bridge example
>> - Change license back to gpl-2.0 only
>> - Do not define firware-name type and add maxItems 1
>> - Make fpga-bridge phandle-array
>> - Drop ranges property because of missing reg property of fpga-region
>> - Also describe case with fixed clock node and axi bus
>> - Fix fpga-region names in example
>>
>> Please let me know if there is a way to describe overlays to dt root to be
>> able to reference fpga region back.
> 
> No. Overlays are somewhat outside the scope of schema. Certainly not
> supported in the examples. When the dts files are free of warnings I'll
> worry about overlays. :)
> 
>> ---
>>   .../devicetree/bindings/fpga/fpga-region.txt  | 479 ------------------
>>   .../devicetree/bindings/fpga/fpga-region.yaml | 351 +++++++++++++
>>   2 files changed, 351 insertions(+), 479 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.txt
>>   create mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.yaml
> 
> 
>> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.yaml b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
>> new file mode 100644
>> index 000000000000..fb6fe6f43fa8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
>> @@ -0,0 +1,351 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/fpga/fpga-region.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: FPGA Region
>> +
>> +maintainers:
>> +  - Michal Simek <michal.simek@amd.com>
>> +
>> +description: |
>> +  CONTENTS
>> +   - Introduction
>> +   - Terminology
>> +   - Sequence
>> +   - FPGA Region
>> +   - Supported Use Models
>> +   - Constraints
>> +
>> +
>> +  Introduction
>> +  ============
>> +
>> +  FPGA Regions represent FPGA's and partial reconfiguration regions of FPGA's in
>> +  the Device Tree.  FPGA Regions provide a way to program FPGAs under device tree
>> +  control.
>> +
>> +  The documentation hits some of the high points of FPGA usage and
>> +  attempts to include terminology used by both major FPGA manufacturers.  This
>> +  document isn't a replacement for any manufacturers specifications for FPGA
>> +  usage.
>> +
>> +
>> +  Terminology
>> +  ===========
>> +
>> +  Full Reconfiguration
>> +   * The entire FPGA is programmed.
>> +
>> +  Partial Reconfiguration (PR)
>> +   * A section of an FPGA is reprogrammed while the rest of the FPGA is not
>> +     affected.
>> +   * Not all FPGA's support PR.
>> +
>> +  Partial Reconfiguration Region (PRR)
>> +   * Also called a "reconfigurable partition"
>> +   * A PRR is a specific section of an FPGA reserved for reconfiguration.
>> +   * A base (or static) FPGA image may create a set of PRR's that later may
>> +     be independently reprogrammed many times.
>> +   * The size and specific location of each PRR is fixed.
>> +   * The connections at the edge of each PRR are fixed.  The image that is loaded
>> +     into a PRR must fit and must use a subset of the region's connections.
>> +   * The busses within the FPGA are split such that each region gets its own
>> +     branch that may be gated independently.
>> +
>> +  Persona
>> +   * Also called a "partial bit stream"
>> +   * An FPGA image that is designed to be loaded into a PRR.  There may be
>> +     any number of personas designed to fit into a PRR, but only one at a time
>> +     may be loaded.
>> +   * A persona may create more regions.
>> +
>> +  FPGA Bridge
>> +   * FPGA Bridges gate bus signals between a host and FPGA.
>> +   * FPGA Bridges should be disabled while the FPGA is being programmed to
>> +     prevent spurious signals on the cpu bus and to the soft logic.
>> +   * FPGA bridges may be actual hardware or soft logic on an FPGA.
>> +   * During Full Reconfiguration, hardware bridges between the host and FPGA
>> +     will be disabled.
>> +   * During Partial Reconfiguration of a specific region, that region's bridge
>> +     will be used to gate the busses.  Traffic to other regions is not affected.
>> +   * In some implementations, the FPGA Manager transparently handles gating the
>> +     buses, eliminating the need to show the hardware FPGA bridges in the
>> +     device tree.
>> +   * An FPGA image may create a set of reprogrammable regions, each having its
>> +     own bridge and its own split of the busses in the FPGA.
>> +
>> +  FPGA Manager
>> +   * An FPGA Manager is a hardware block that programs an FPGA under the control
>> +     of a host processor.
>> +
>> +  Base Image
>> +   * Also called the "static image"
>> +   * An FPGA image that is designed to do full reconfiguration of the FPGA.
>> +   * A base image may set up a set of partial reconfiguration regions that may
>> +     later be reprogrammed.
>> +
>> +      ----------------       ----------------------------------
>> +      |  Host CPU    |       |             FPGA               |
>> +      |              |       |                                |
>> +      |          ----|       |       -----------    --------  |
>> +      |          | H |       |   |==>| Bridge0 |<==>| PRR0 |  |
>> +      |          | W |       |   |   -----------    --------  |
>> +      |          |   |       |   |                            |
>> +      |          | B |<=====>|<==|   -----------    --------  |
>> +      |          | R |       |   |==>| Bridge1 |<==>| PRR1 |  |
>> +      |          | I |       |   |   -----------    --------  |
>> +      |          | D |       |   |                            |
>> +      |          | G |       |   |   -----------    --------  |
>> +      |          | E |       |   |==>| Bridge2 |<==>| PRR2 |  |
>> +      |          ----|       |       -----------    --------  |
>> +      |              |       |                                |
>> +      ----------------       ----------------------------------
>> +
>> +  Figure 1: An FPGA set up with a base image that created three regions.  Each
>> +  region (PRR0-2) gets its own split of the busses that is independently gated by
>> +  a soft logic bridge (Bridge0-2) in the FPGA.  The contents of each PRR can be
>> +  reprogrammed independently while the rest of the system continues to function.
>> +
>> +
>> +  Sequence
>> +  ========
>> +
>> +  When a DT overlay that targets an FPGA Region is applied, the FPGA Region will
>> +  do the following:
>> +
>> +   1. Disable appropriate FPGA bridges.
>> +   2. Program the FPGA using the FPGA manager.
>> +   3. Enable the FPGA bridges.
>> +   4. The Device Tree overlay is accepted into the live tree.
>> +   5. Child devices are populated.
>> +
>> +  When the overlay is removed, the child nodes will be removed and the FPGA Region
>> +  will disable the bridges.
>> +
>> +
>> +  FPGA Region
>> +  ===========
>> +
>> +  FPGA Regions represent FPGA's and FPGA PR regions in the device tree.  An FPGA
>> +  Region brings together the elements needed to program on a running system and
>> +  add the child devices:
>> +
>> +   * FPGA Manager
>> +   * FPGA Bridges
>> +   * image-specific information needed to the programming.
>> +   * child nodes
>> +
>> +  The intended use is that a Device Tree overlay (DTO) can be used to reprogram an
>> +  FPGA while an operating system is running.
>> +
>> +  An FPGA Region that exists in the live Device Tree reflects the current state.
>> +  If the live tree shows a "firmware-name" property or child nodes under an FPGA
>> +  Region, the FPGA already has been programmed.  A DTO that targets an FPGA Region
>> +  and adds the "firmware-name" property is taken as a request to reprogram the
>> +  FPGA.  After reprogramming is successful, the overlay is accepted into the live
>> +  tree.
>> +
>> +  The base FPGA Region in the device tree represents the FPGA and supports full
>> +  reconfiguration.  It must include a phandle to an FPGA Manager.  The base
>> +  FPGA region will be the child of one of the hardware bridges (the bridge that
>> +  allows register access) between the cpu and the FPGA.  If there are more than
>> +  one bridge to control during FPGA programming, the region will also contain a
>> +  list of phandles to the additional hardware FPGA Bridges.
>> +
>> +  For partial reconfiguration (PR), each PR region will have an FPGA Region.
>> +  These FPGA regions are children of FPGA bridges which are then children of the
>> +  base FPGA region.  The "Full Reconfiguration to add PRR's" example below shows
>> +  this.
>> +
>> +  If an FPGA Region does not specify an FPGA Manager, it will inherit the FPGA
>> +  Manager specified by its ancestor FPGA Region.  This supports both the case
>> +  where the same FPGA Manager is used for all of an FPGA as well the case where
>> +  a different FPGA Manager is used for each region.
>> +
>> +  FPGA Regions do not inherit their ancestor FPGA regions' bridges.  This prevents
>> +  shutting down bridges that are upstream from the other active regions while one
>> +  region is getting reconfigured (see Figure 1 above).  During PR, the FPGA's
>> +  hardware bridges remain enabled.  The PR regions' bridges will be FPGA bridges
>> +  within the static image of the FPGA.
>> +
>> +
>> +  Supported Use Models
>> +  ====================
>> +
>> +  In all cases the live DT must have the FPGA Manager, FPGA Bridges (if any), and
>> +  a FPGA Region.  The target of the Device Tree Overlay is the FPGA Region.  Some
>> +  uses are specific to an FPGA device.
>> +
>> +   * No FPGA Bridges
>> +     In this case, the FPGA Manager which programs the FPGA also handles the
>> +     bridges behind the scenes.  No FPGA Bridge devices are needed for full
>> +     reconfiguration.
>> +
>> +   * Full reconfiguration with hardware bridges
>> +     In this case, there are hardware bridges between the processor and FPGA that
>> +     need to be controlled during full reconfiguration.  Before the overlay is
>> +     applied, the live DT must include the FPGA Manager, FPGA Bridges, and a
>> +     FPGA Region.  The FPGA Region is the child of the bridge that allows
>> +     register access to the FPGA.  Additional bridges may be listed in a
>> +     fpga-bridges property in the FPGA region or in the device tree overlay.
>> +
>> +   * Partial reconfiguration with bridges in the FPGA
>> +     In this case, the FPGA will have one or more PRR's that may be programmed
>> +     separately while the rest of the FPGA can remain active.  To manage this,
>> +     bridges need to exist in the FPGA that can gate the buses going to each FPGA
>> +     region while the buses are enabled for other sections.  Before any partial
>> +     reconfiguration can be done, a base FPGA image must be loaded which includes
>> +     PRR's with FPGA bridges.  The device tree should have an FPGA region for each
>> +     PRR.
>> +
>> +  Constraints
>> +  ===========
>> +
>> +  It is beyond the scope of this document to fully describe all the FPGA design
>> +  constraints required to make partial reconfiguration work[1] [2] [3], but a few
>> +  deserve quick mention.
>> +
>> +  A persona must have boundary connections that line up with those of the partition
>> +  or region it is designed to go into.
>> +
>> +  During programming, transactions through those connections must be stopped and
>> +  the connections must be held at a fixed logic level.  This can be achieved by
>> +  FPGA Bridges that exist on the FPGA fabric prior to the partial reconfiguration.
>> +
>> +  --
>> +  [1] www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug_partrecon.pdf
>> +  [2] tspace.library.utoronto.ca/bitstream/1807/67932/1/Byma_Stuart_A_201411_MAS_thesis.pdf
>> +  [3] https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^fpga-region(-([0-9]|[1-9][0-9]+))?$"
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
>> +required:
>> +  - compatible
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - fpga-mgr
>> +
>> +additionalProperties: true
> 
> Why? This should only be used if another schema is going to include this
> one. That's not the case here.

In v2 we discussed this with Krzysztof. I used pattern properties from 
simple-bus.yaml in v2.

https://lore.kernel.org/all/b2dd8bcd-1e23-4b68-b7b7-c01b034fc1fe@linaro.org/

> 
> 'type: object' would be acceptable here as that says only nodes can be
> added.

What do you think should be patternProperties in this case?

I played with it a little bit but all nodes with @ are likely object type.
But what to do with others?
There are nodes as you see in examples like fixed-factor-clock nodes which are 
also object type.

Standard property like firmware-name or encrypted-fpga-config are coming via 
overlay for sure. Others are not permitted. That's why others then listed 
properties likely must be type object. Is there an elegant way to encode it?

> 
>> +
>> +examples:
>> +  - |
>> +    /*
>> +     * Full Reconfiguration without Bridges with DT overlay
>> +     */
>> +    fpga_region0: fpga-region {
> 
> Drop unused labels.

Actually it is kind of used. I kept it to be able to reference something in 
comment below.

> 
>> +      compatible = "fpga-region";
>> +      #address-cells = <1>;
>> +      #size-cells = <1>;
>> +      fpga-mgr = <&fpga_mgr0>;
>> +
>> +      /* DT Overlay contains: &fpga_region0 */
>> +      firmware-name = "zynq-gpio.bin";
>> +      gpio@40000000 {
>> +        compatible = "xlnx,xps-gpio-1.00.a";
>> +        reg = <0x40000000 0x10000>;
> 
> This example implies this is a translatable address, but the lack of
> 'ranges' in the parent prevents that. In turn, that means unit-addresses
> should be accepted in the parent node name as well.

v1 contains ranges property and it was removed based on Krzysztof comment that 
fpga-region has no unit address that's why ranges shouldn't be used.

https://lore.kernel.org/all/c3c92468-a1db-498b-b4a2-7926b84cb5ea@linaro.org/

Thanks,
Michal

