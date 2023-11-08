Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD807E530A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbjKHKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjKHKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:07:10 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252DE172D;
        Wed,  8 Nov 2023 02:07:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5U5SmiSL3bNCLmNVmF67OWmVZSEvvyN0vr3KHsuA8Sxc3AziXzcAeOTbptS8j7xBgzO5Hhwp7FUP8oyElALxvsPveJi/iETdDONIqwCnPAk6KzveBMB6s/NeDifgVLRP1gc7alKSFuU+c/FVGxIqptjb3AAHtJZJypV3Akx2utioqsD6y12E6adtLoJBATfykpISra2jY0/jcyEXk8wSQ4sKZIIhmUBS3YS8t1PUOslM1C2+mvxWIoHGlRFEPDdZyp8MJR70fop0MPYsIWtV0Rf5JfliI5w+lsFVrBU1ujQDJFacKB93/TReRZYHZZo8qNY+JK8F3RCWR6pmPic5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/xEdmP+m2yygFgNeb5WPUWY3T1paXOeOjQJUzX7xZI=;
 b=bxAcdIvlD6uWoEjg1AkBDbbyXsISjl0pS4jzWY/qTA2OQMieV1qOvCVL426LGK6wQWO0oQkUbckxvZDX+JPTS9EV1BEvDaxdHZLYujYTPLugm3GNRjPNBTZ+H2AHdhhDWX2ZLWeuacpEdatETEgmD0B1fgMtEiOvwWbDrtyiSzYLUEMuDqw8ZBeDju9C+QJHvRz3ehKJ+ZIKFE4WEtP9n6ijOLKWFxGwRqX2vLcL+Tp6mLDFwiyKr0BoY4jzThsRn+RptW6Q+7u2pCDlp+w1Ztsxo18Eay9Ze3ZViZr8Urmtn1lrRy/PCo6w47t1eukaKaqLmLzr09oEuhY+wZAWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/xEdmP+m2yygFgNeb5WPUWY3T1paXOeOjQJUzX7xZI=;
 b=xy+MeL6LfBLM5kB44UgvClfrBG2zZQ3xEcxIL7UVZc5SD0Jc1BSVflEwi8LFMsnDaM9Rq7wBtEdqa9Tp3IO/RShnk6WU1d2W0yVEBcgbw9jF6JeyalF16oUZ6zRUShQxDOP4nsR4XOHWe47UUrDKm6k7qkrOCJ39E1Y/6wz+LJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 10:07:06 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 10:07:06 +0000
Message-ID: <8b17622b-de1a-4075-9527-8755f5e4dc14@amd.com>
Date:   Wed, 8 Nov 2023 11:06:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
 <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
 <20231107-expensive-jitters-92e454f77ea8@spud>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231107-expensive-jitters-92e454f77ea8@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0236.eurprd08.prod.outlook.com
 (2603:10a6:802:15::45) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 2117ddf6-3721-4204-da69-08dbe04275fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: il9mXwjHp20y9gOxsG2M5p4ii9yBG/rj0MDG9TM9icj5tJqsZSPLspnba2utV8g8Y6LsTcWSeod2BGUTCDaiE8RcprSJZ2au3ZTUKJxdKySiSEAGxlUBqrvMBDnrDpP1Z/HL8ptPaMJpHch1rpiJ53dBGxO3RsNJYxSkFwvxDBgA/IrcYfXac6dh11iMFAC4uMQMbS8uSx7uz560IQ0fytlh0l61pScc1P7udjHxd9GSgeqm7Db8apA3wC3v7z4Hl+Dz2dmesWmxQvu8cGva+IfSXUBQqZP8zVdD5+wg4GwF6ww0JmZMJoPnSU/eXjeC7PiZA9wStlmVRT01jwQObZRTc0030i51ILKb8yydCDdl3GYJD5cBf2J6JQ3JDo7FKzInjfzPGP5yZ6kNuk65Di6LsBgVA5v2Jwj5iJiJA+dgH/oqT9lZZT6crXSDWSVIIRdv1xT6WGE+XeAoD/gOQzpx50wU6SzhO5j8rJm+1M280GgDLIxFfuNmhnMElUfmuEWsOde5fT+zeCqqSrv1XYZ5cXkRrNiptddIdqebfNWaASCKZ9KU9OPs/UaUUS7EkfngvhwcNjQLUBcKzvTzNHwox3961V+CKRKPSX8z2BEwnHoBdZLxqifDhaY/Wom9FAiPwBHgl2NiwrtWp48YkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(26005)(2616005)(38100700002)(8936002)(44832011)(316002)(6916009)(4326008)(54906003)(8676002)(2906002)(41300700001)(5660300002)(36756003)(478600001)(53546011)(6512007)(66476007)(6666004)(66946007)(66556008)(6506007)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blZoTTJ2cW41L0htdHRQaHBXR1orSFowMGhsOUkwZk15SHdLcndadFVKaVNo?=
 =?utf-8?B?RHpCWXFGeUEwcXFySjV6MGhWYXJQNG9QV0lnbXoxKzdiK01zNnRLSGRYSk4z?=
 =?utf-8?B?bjFseGJpTjFWOTRlZ3M2WkJDczVFUndISXVEbWJJWFFGSFYrZEhTZ1F1bFJZ?=
 =?utf-8?B?VkM0OHY4RWttamFYWjY2NXlJTGxLNk9ldTEvZUhzbis4TVVFZlhYSjVqN0lR?=
 =?utf-8?B?WGsxaFBsSURzd3NuSjFGNHl2MEFMdXpIM2t3TGdpYlV6Y0hDNEl2UXlOZTF6?=
 =?utf-8?B?K2hJb2gzTEYrUlFUc0NCeGxSc0d4TU1raldBdEdCTDUvaE9JYjFWYzF0Ulk1?=
 =?utf-8?B?L3prUVhTUUhQTzI4RWluWW84S0NQU1ZEWTMxR0tjNVgyYjdabW9nOWxXYkZY?=
 =?utf-8?B?ZTZ5Z1E5TGx2bFp4ZEp5aUxUcE5IcVZJcUhCK1lmLytGUnYxaDk4cWF1V3JQ?=
 =?utf-8?B?MG1OTHRocEVCUVF5Zy9LZ3B2SVFMREYrdi9nNTFoSEREK1M0WTRBZTRiRkpZ?=
 =?utf-8?B?UzdhdElXQ25ROWlUYi9hU0w3V3FZa2VqSlpVYklhZ2VzclpoKytFNVNpajdT?=
 =?utf-8?B?MnB5ZWJxSkNUZmZJak80R3hQUm9rYnorVTJicG5MVVJPektTSHp2VTZucXJ4?=
 =?utf-8?B?NlFDTm1WdDBjWGEwUTFuM1RUTkVmZkJDOXl6QXZQbElzVVNLTXBBVDhIQVFQ?=
 =?utf-8?B?YUtDdEhqa01rV0VnOVpVZVhYWGQ2WWhtTWhXK3FiMXd4NE81MkE2Q1hiaGhx?=
 =?utf-8?B?Z2txdmJuYStSdlZvaHpkRFhuOStEY0NlTFBua0NZZnl3bDhORUExNDRPMzFH?=
 =?utf-8?B?RDVwSExuMnpnV0lTdkpLUFM5MG01Qlg5djFtQTFQdWhrUXhMUGRTNjM5bEVp?=
 =?utf-8?B?VnZnRytCWnlzQ0c0ZkVwNElDTVdFbWJ6QXlBdTRUOC9pMUJtWDBKQ1VQVXp5?=
 =?utf-8?B?Y0FFVEdZVlFNWFRldGNGbW9JRFhmcDRhZlN0aVViUTV6ajBRRzdBaXgyNVFB?=
 =?utf-8?B?ZEVieHRCYUNLK3VRQ3dlYWhZVVdMSFZXLzI3MCtqRmIreEhSc2M1M2NmdkJE?=
 =?utf-8?B?ZklLWERSVmY5dHVhOVR0TWZZelMybHUxR05DMUwydmJ6dDVMTXJMRTRhQzk3?=
 =?utf-8?B?YWl0UVlJeW4ramtFK1ZCL3h6TDFjWFQ5eENXQW9LdjVudG1zLzlOM2MvSU8x?=
 =?utf-8?B?UFk0N2FXdkovZE5BTnF3T0FWVUhmTlZ1RnljZUJsMzZJMXlxTFRiSURhVElY?=
 =?utf-8?B?WDJqTnYvRmFrSGZHRElnK1QyOGdvck5uMHVnQUFVR2FLWXNHdkZLcHl3U0RK?=
 =?utf-8?B?ekMwczJOc1dkcUsyVWtlN1ZQWHYwOVNpV2tibTVjR2pkV0E5WkZ2S3pZUzhm?=
 =?utf-8?B?aEtGcS94cE02aTVKUm5RNXRScExHTmFMTm5HMmhLcWZKWkpKUDBmUlF5bGpM?=
 =?utf-8?B?bjljekE3M0lobXQ3ZXhkOEF5YzFoTWM3VWJLNGZxZHZyejEyWEQrV3FtR3Qw?=
 =?utf-8?B?ajVRYWdYc2tsbzBoek0yVEkvNGxhRStzeHF4SGh4VmVVUW9OWTF0VHdLaE1L?=
 =?utf-8?B?aHg4VDBZMkVmTUxOakdKZHIwQmdDQjFpQjVYMDM4YmJMVTRac1BOdkxuS25F?=
 =?utf-8?B?S2FkcDBnS0lRTHF3UnRHMHg5V1hNVGVQMXo1Wm9haDRPVjZpSGtRZW56NzhK?=
 =?utf-8?B?aCtWU0xSdnpXQVVhVE16WnVwRjZlcVo4RWwyTThENUcvMEdKclZ5L3EwbUtK?=
 =?utf-8?B?blF5RDdpTXI0ODdkUXhYbkVHRG9RbmhRK0J4VjRzMEZBWmhKNC9NL3JpTS9a?=
 =?utf-8?B?aUM0VTA2WkZmRUJWUnp4UnFQeFQycmxidVlOdWhaZEI2N211R3JxdC9pbzcw?=
 =?utf-8?B?d2tlc3hJMDdDS01yNGcyajUrYzZxSG93TmxObHFVVStONCtGZFZGaFd1NDly?=
 =?utf-8?B?V1ZDNlptaWxjaEwxQlZSUG9YWEo4VmtIVCtUZDJxVGhwa2xHM2czMG1Ud2Jk?=
 =?utf-8?B?aWExblArcW90elI3b1lSaFlOMUhGYjJuWGNxYk9JYjN6UGNEYlVpRkQ5bnNh?=
 =?utf-8?B?dTNRS094dldGYTBtQ3VSRkpZaThlaXR5Y3hpL0pCdk9oMC95SURjL28raEpR?=
 =?utf-8?Q?hUhC425Cbi4XDOVjGPS5fAPzF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2117ddf6-3721-4204-da69-08dbe04275fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:07:06.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCNfOJqbE66mUPpcLHr8RW1oE/1JJOSOzVXDMDc2oeZzVAqVYg+5sgJW3bUUKjoW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/23 22:18, Conor Dooley wrote:
> On Tue, Nov 07, 2023 at 12:09:58PM +0100, Michal Simek wrote:
>>
>>
>> On 11/6/23 18:07, Conor Dooley wrote:
>>> On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:
>>>> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
>>>> It is hardware compatible with classic MicroBlaze processor. Processor can
>>>> be used with standard AMD/Xilinx IPs including interrupt controller and
>>>> timer.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>>    .../devicetree/bindings/soc/amd/amd.yaml      | 26 +++++++++++++++++++
>>>
>>> Bindings for SoCs (and by extension boards with them) usually go to in
>>> $arch/$vendor.yaml not into soc/$vendor/$vendor.yaml. Why is this any
>>> different?
>>
>> I actually found it based on tracking renesas.yaml which describes one of
>> risc-v board. No problem to move it under bindings/riscv/
> 
> That one is kinda a special case, as it contains arm/arm64/riscv.

If they are kinda a special case then what are we?
All AMD/Xilinx platforms(ZynqMP/Versal/Versal NET) can have 
arm/arm64/riscv/microblaze cpus(riscv/microblaze as soft cores) in the same 
board (IIRC I have also seen xtensa soft core on our chips too).

Thanks,
Michal

