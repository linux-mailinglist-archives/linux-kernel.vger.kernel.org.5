Return-Path: <linux-kernel+bounces-27708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B81E82F47F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125C81C23940
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB681CF8F;
	Tue, 16 Jan 2024 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kcM1kEJK"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F61CF81;
	Tue, 16 Jan 2024 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430583; cv=fail; b=sz4QllIpKHvD54MULIPHuinnbAxv/Zb24EGL+F17v4rSi3yQzhCNAW6GYbApz7WIVI1aL8+HHveggFSZ7tqq0AfRXIeofvcyEClhlM39qYIKDlvuauAkemfKzL5EgPhv1vayUHvPnKp1n7U7EkR0/5XkZz9u+iKiuMeI3Og3o6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430583; c=relaxed/simple;
	bh=d+rVmTXmb0DyxkDb6iHRoP2fHVN0C+wzZYcDgkdt/dg=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=neD3czmMHr+0A9NhY8HZkt/SBjfhEKABj/RxJjgH+eVtcbC/TZUo7rMcImkkESsxIzVFhvL+8Bz46Gu1m6XuzENDF0B4/2pIwrzkxXNcct8e0t8S8n7EqRRDqlmFfYeCw4nJBB+7ibEKJuwICl8SU5J+o5QpXs8fTr9pvV+h38Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kcM1kEJK; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giFF4nShbRbb+4ed3HWq2tsCyzLdPqp454FJdtK60jMqlX5LBC3UucBSNV3xMNRBRdnJRsh4GOBGcSAFlSwoP9bJBiGNTnsyv3lD3GKy56SMBKw5ZiVe1DmoxLJuVBuscLNTwq59rG1upZ9qPzJvlftqYHpASoKdn2HndTJInTYPy7fBEHT0cqICCrgdBdxmpeLM3mdNiAz1u9qYq5lTNAwQXtXtruuyNjH52qz23gY/HTIKM2nEaIsIe0tjrVSU8yh8MO89QGVA4F3IE/eOAB5u5b5x/tqHSrst+o5gVxDG0LY8bqpLkKg7TTGAcKVfwUfL48uHBxcvSqKT9GuBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JGkjFAlvSKwHxqT0fMv9tiEYJlNBr+i3jZyCAI6InM=;
 b=WpoBqN46+L1e630JAYcElFvoeWVFADR3GQgB6VIgzvUSpd3eiCvqOH/vzZuBbXQeGVIgcNiEYZVvA2yqa/OPlXA1ggCSxYYnu8fimcjs7Ezxj/LWPdWS96GjwZChEXZD6vDVhRabaVhejodfnlL5gDpEWEL1OnJhYKt+gahHJA4vpRVbfXG3Uc3TmyYpQwBBFGhJtN715sxtXrk3ifLdXY8hujbg17FUak9j4iDMnLxmTgIppoIPow+RGQlYh1Ko2iEd3JqqDfelQWOF74AYQDVaNEvl8HcofAWsUeqO39eALJSAZYd8+/qltozK1hVixbm+8l1Hnx2+0WX//Lx1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JGkjFAlvSKwHxqT0fMv9tiEYJlNBr+i3jZyCAI6InM=;
 b=kcM1kEJKCd0vnsb270c/BMpijZIXYEeZ6H4I5ay3qDYxUb8RfldcAU/DbwYbOzo9+KwgMZnmB7Xt5ubLgvKFWVdkrTp6r+ikPfk0K1vuuRiX6HWHyp69CifyIsAXCOPAHpeSQEg7d2oM0+R5VLeIp7BntykcAV7j34MkKl07FLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 18:42:58 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 18:42:58 +0000
Message-ID: <19955e50-5f6c-4248-937c-6d00684feeb1@amd.com>
Date: Tue, 16 Jan 2024 19:42:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: soc: xilinx: Add support for K26 rev2
 SOMs
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <3e86244a840a45c970289ba6d2fa700a74f5b259.1705051222.git.michal.simek@amd.com>
 <20240116180039.GA169201-robh@kernel.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240116180039.GA169201-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0040.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::29) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddd68b0-cc30-4d4e-5038-08dc16c2f576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h9zN6T0UqQWX7Go/27w5lEGruN+zwPQpk1T3g9jpmpKbWh0k8CaxclhtT9YNGWhKEvKgA7Rd53S9Dc3P7gZGSzxtoq30GqMnJ+oqH6YaL1JqHDb7/fLa6cwLl7tloLRIFs01GaqnU2NXBQ2eYf71PqPX8HzjRvcQ+zyqKbCKFRAHsyEgw6G4HjPNuYBcEmm0KKlg00bBiXHHOm591BCjOHhLjFJFMyIc7zl8J0l3O+1ck9q1S1sk+69MV881XL8WxytFcoo8M2SuJmeQKBaseG4sYoK+kC271fsAqgfFvu7Ro+NHMTRRZ9KuDNsq8hgSNPtUKWOcPpd+A6XaLE54/wY2kZDQOZMu3dzA9W/ZtcvxY8+rimYBm1+zDmLcURmPep2xZVuRkOIDiqUptlq33bm8vbDZq/tF8cw5fLE18lAvr12i8u/ZXX1xt8SkGE4yb3CvYYEcLhRUOLnHF+utNmNSrhne311tvkta2kVWBNDcb0Qp87+JlyGWPgtbm/2KWdyjTzzz+oRgfKPuqfGlhbU4GMRQQ2rIZPbaDmi0UrX7wSWCoIW6O1pg0SChJ0Vpzsin7UQz7OBZ6tM8MQia1ejrjLk7u4KOCJIIyO+irG+kLUAhDENexriBFhYF9Z9WolmC2/P0AsRHZYnKt19Viw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(6666004)(6512007)(6506007)(26005)(53546011)(2616005)(38100700002)(36756003)(86362001)(31696002)(2906002)(41300700001)(44832011)(4326008)(6486002)(5660300002)(83380400001)(316002)(478600001)(8936002)(8676002)(6916009)(66946007)(66476007)(66556008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjBOVUlnS0licENJQWtpVW00R2JJUzdsY3loczJYRnJ6MnJMaHg0aXAwa3Ra?=
 =?utf-8?B?TTU4OEtTYm84T29lRDVqcDd4a29yVkFTaGExc3l1UGkvZVdueTYzMVB5SGpY?=
 =?utf-8?B?UUhPZllGNXp1SDZCanF0a3lWbGFBeUFPbTd2eHF1VjRBZmtDRG5nVnJscE9a?=
 =?utf-8?B?Q0RnVnhCQUI4SElBYURaT2dScnV2Z2toMGlKUlo3VEtjZlFHZWcxaUc0WFAw?=
 =?utf-8?B?VGhvM0NtZi8wRGhkRFRhU2VwS3JJOERnNStMblROVCtLTVpUSVVGbHBCMGdP?=
 =?utf-8?B?aDhORGR0R3RWUWIwZC9FaWwxRlRjTXBsYnVYbEZoM0t3SHdZbXlJUmUvS0k0?=
 =?utf-8?B?R2pQUmVGZGd5YU1HU3FRTWovOGNNWGs2cUNVcmRxMEYzUjZOSlZHUEcrMVFk?=
 =?utf-8?B?ZlB4aThOY2N6NTIzcGxoQ3FBazVZNWo5c29xWDVuaTRic2RVbEMyOUM1dFdo?=
 =?utf-8?B?Y0IxSUVFQnZHWlVWbmVYR0V5Yk5mdGtqZWpjd1V2eDFFdW5jakdLbUZPeUht?=
 =?utf-8?B?K2RkSmNlVXY4aDQrekc1dXFudWplSlhnYUJ0blZrTzZLUmZwUFVqTVRXNThN?=
 =?utf-8?B?bVp4dzlRYmswZW5PVXgza1lsMlprc214K08xeXpuK3RzSzNHbkJlWjBqNkxX?=
 =?utf-8?B?OS80NFJOYU9qUkhqWVZKR29UZ0ZTSTJOeU1aRWZHUmNpV28yNitQWHY4ZVJp?=
 =?utf-8?B?elVydTMvUFVLVlVkMDh2aTBWTkYvMzkrU0RsMEV0WHYreEpkK2Q0TW5kanBr?=
 =?utf-8?B?aW9TTkk3ZTVFaGZDQjJQSGlnWXZvdkd6Yis3L0Q4NEMxWmtVTmoyYlZjdjNw?=
 =?utf-8?B?REhmeXM4TFZReDh1TG5rbThpZGhoZXdLK1p5MDZyaFczSTJqcDNpU1FSWTFW?=
 =?utf-8?B?WW9QcVZYdXB1Ly9YaHZaL2VuQnpmNGk3RjFrNEkzZXliUXVxSFlZYVh6QlRD?=
 =?utf-8?B?a21naFcvZktGQVVhS21FNWg5S2Q4S3l3M1lnYWRNSnJDQi8yZDB6WXlOQXd4?=
 =?utf-8?B?Z05EeW11cE5zZFQwQ1poSzIyZXlFWlJzV0prdUlKNTdvbTVOK2IxeGNHbnow?=
 =?utf-8?B?MkJUb0s4TmtUdEdHZ0dham5kUmNPd1hBejBtQ25CRVpVck9kZnFUUFBXbmMv?=
 =?utf-8?B?MnlMaDk5cEVWSVd0NXA0UkFnWEMyeTNDTnNLbFpwUlNiYkFPalhDNE03TzdN?=
 =?utf-8?B?TVJQYzREaitRK0d6a2pkaVlyT25ONEttR2VQTEpBY2YxdFRNeXkreHQ0OXBM?=
 =?utf-8?B?M1dhSWI2M0dLT3VraTZ2bTVOMzFIUUVURnhmVGdYblRMUnEyM1FSR2NQYVlV?=
 =?utf-8?B?V05RVnpZWkxXZkNkcE1Ec21ZdVFiL3IwaVpnTkh1UmM1MHhaanBpYXFWL3dG?=
 =?utf-8?B?UWltdGluL0FXS0tXQkFyR0NBbnVZdVBWcUZ3SWYzc1pjaU8xYTJvVTFoYjlK?=
 =?utf-8?B?c2RVWUNzRisvUVlOZU1OVHVFVW9CTWMvZWp0UEdVekhkOXp6cTQ0T2hHcjRS?=
 =?utf-8?B?MDZSa1d0K1hyZ2k3SEVIcWRwOUJHaXlDNS9kLy9oREd2QkVBejdYU3ZSYUpv?=
 =?utf-8?B?c09TczdFMlJ4cVhWTS9RK3RScktVTDJFdlpCM3lYdEppb1J3Nm1CbjNqUEJp?=
 =?utf-8?B?b2hTLy9pbVIrOEpsUXJnUDlpdVR6cTEvZzFWa3NNYWU3QlNrUjRqM2dXQ2lM?=
 =?utf-8?B?MDFqN05seWFldFVpTEJISG1vSGc5UGtMRGx6UmR2ZXY3Rk56eGpMbDhEVUIy?=
 =?utf-8?B?ODc4dGF5OVhxVlJLU2FZVEhQMVphdUdVcVVaenhTc1hSbVdkNlBkUHZOOHZH?=
 =?utf-8?B?bytlR2lXRy9qdldqYk5JbTJSZVhvY3JBV2ZwL04zM2lhUWpjanorZWRUTm9I?=
 =?utf-8?B?N3p2UjR3UmhpaklLSTQyQjdHRFhUOVgrTGloUTJhVmMvYnQyelFlZWR4N2NI?=
 =?utf-8?B?MFN4ajR3K2ZFNXNBRTNGYTJONks5d0hyUHRORnBOY05hNWV1bWxFV1Z4bEhz?=
 =?utf-8?B?TWVIdjZzTE5PSHNWZWM0TlI5dk9mSW9pc201NFBpeVk4OEZhMXVOWVU4Zi91?=
 =?utf-8?B?MFMwYnUxbm8zSy9JMmZvQlVZV3JvR0lpY0gxWkJoeCsvcVlxTmZnR3R6VEpM?=
 =?utf-8?Q?X1AWfJ67ZF/+WM7DXgxhZP+Cj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddd68b0-cc30-4d4e-5038-08dc16c2f576
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 18:42:58.0500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPbgJnR7h2kSCT7QyK94l/1iiP6Hds51aqprn8xS47aqY9xR+HgBDTYiGFjZVrez
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985



On 1/16/24 19:00, Rob Herring wrote:
> On Fri, Jan 12, 2024 at 10:20:29AM +0100, Michal Simek wrote:
>> Revision 2 is SW compatible with revision 1 but it is necessary to reflect
>> it in model and compatible properties which are parsed by user space.
>> Rev 2 has improved a power on boot reset and MIO34 shutdown glich
>> improvement done via an additional filter in the GreenPak chip.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Changes in v2:
>> - Support older combinations
>>
>> I want to support all versions we created:
>> All of them:
>> -rev2, -rev1, -revB, -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
>>
>> rev1:
>> -rev1, -revB, -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
>>
>> revB:
>> -revB, -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
>>
>> revA:
>> -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
>>
>> And also single one are permitted:
>> -revB, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
>> -rev1, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
>> -rev2, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
>>
>> I didn't find a way to pretty much all the time force that there must be
>> both "xlnx,zynqmp-smk-k26", "xlnx,zynqmp" that's why there is only
>> requested to have xlnx,zynqmp. If you find a way how to encode it please
>> let me know.
>>
>> ---
>>   .../bindings/soc/xilinx/xilinx.yaml           | 32 +++++++++++++------
>>   1 file changed, 22 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
>> index d4c0fe1fe435..39242efeec47 100644
>> --- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
>> +++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
>> @@ -117,20 +117,32 @@ properties:
>>             - const: xlnx,zynqmp
>>   
>>         - description: Xilinx Kria SOMs
>> +        additionalItems: true
>> +        maxItems: 6
>> +        minItems: 3
>>           items:
>> -          - const: xlnx,zynqmp-sm-k26-rev1
>> -          - const: xlnx,zynqmp-sm-k26-revB
>> -          - const: xlnx,zynqmp-sm-k26-revA
>> -          - const: xlnx,zynqmp-sm-k26
>> -          - const: xlnx,zynqmp
>> +          - enum:
>> +              - xlnx,zynqmp-sm-k26-rev2
>> +              - xlnx,zynqmp-sm-k26-rev1
>> +              - xlnx,zynqmp-sm-k26-revB
>> +              - xlnx,zynqmp-sm-k26-revA
>> +              - xlnx,zynqmp-sm-k26
>> +        contains:
>> +          const: xlnx,zynqmp
> 
> This allows:
> 
> xlnx,zynqmp-sm-k26-rev2, foo, xlnx,zynqmp, bar
> 
> You need the schema form of 'items' (no '-'). For multiple contains, you
> need 'allOf'. Like this:
> 
> items:
>    enum: [ all of them ]
> allOf:
>    - contains:
>        const: xlnx,zynqmp
>    - contains:
>        const: xlnx,zynqmp-sm-k26
> 
> 
> This of course has no enforcement of the order. Just no sane way to do
> that in json-schema.

Works for me. If below is fine I will send v3 version.

       - description: Xilinx Kria SOMs
         minItems: 3
         items:
           enum:
             - xlnx,zynqmp-sm-k26-rev2
             - xlnx,zynqmp-sm-k26-rev1
             - xlnx,zynqmp-sm-k26-revB
             - xlnx,zynqmp-sm-k26-revA
             - xlnx,zynqmp-sm-k26
             - xlnx,zynqmp
         allOf:
           - contains:
               const: xlnx,zynqmp
           - contains:
               const: xlnx,zynqmp-sm-k26

Thanks,
Michal

