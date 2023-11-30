Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C937FEA17
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbjK3IB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjK3IB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:01:26 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6242510CE;
        Thu, 30 Nov 2023 00:01:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCzWyxUUBpna++fsdFRJNMe7aX5GHSSWSUdgZvG8oULDHy/w4xxKX32HKHTpBfGiiIxNgJCbI8vZIx0l8BCij9pLsc2BAyLnKGmHAg31JCJLuLN/mvgW3sVHAuXXCZbcmqEgLr4qUEf6M55TxbMuiRq/YVmu2Sic4dFC79LWXphQ8eBExsmdVxD2WME06aTcyf9CySDDLL5EY4hza0TtjOoKc1euyC2B36qO0geXFBU6eZHTIQOmAed4Zr+PmnjuL0af3zC+OFWazZomjVJHL+f6YlqzOcfKqgSQyhSoynRc0VklBEqtCFjaGXnFTQgIVH9v5Z5gl/RUsFYDAyg9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kvZ/r6BCEsfdeFs6f5wrcJNnzps0RUbdEaggd0VhLc=;
 b=gg9T7msI1q/7jiLsk/w+6Z3ebkEFeYV2NgeKZGumAAyYKqCRnySOZMEYdOU6d6H/fnEGoYt3CPVndPiggBiIcPZtsIUkb9u1Z4v+xiu118tLMvqf6FhMpODCqHpot0OiyAqpuLp1Sgp2DIJLvfJDV9205sSIbnGaGzRDiFPqzZH1z+uRF3lXDmEAS2kXaqGUosE3RlbEIaA0e2CCNxQuz+Lrb3hmP0hP25vKdbd9P6+jMUI1+/dj+8iEOQtM7tIsP7lLxSgrtNfc0vMBtniL7FTqA+rwx4TfCDjZxLaJlurP7TwPKfF3tYwjE2/7LV3qb+cqddZwCn5SA/NvqRLyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kvZ/r6BCEsfdeFs6f5wrcJNnzps0RUbdEaggd0VhLc=;
 b=qBH8WsueqOuqjQLyCuX3aHTFELT+ySXEoNeZR9FO0YKMmcEWHdmrQuSHVGjhZODHh7UdLOJaFk/OzLte2qrJqWZvtu676BgzQL5FR3Wl3IXhWkcRE8HC4x5/4YSzaIn/f7HhiqrwMjYWL+Sk2jfYbOd4iO0Ql0wUKcROsHwyIPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 08:01:29 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 08:01:29 +0000
Message-ID: <6410439d-cc02-408f-bc8e-3d8e808b8e47@amd.com>
Date:   Thu, 30 Nov 2023 09:01:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: xilinx: Apply overlays to base dtbs
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230911214751.2202913-1-robh@kernel.org>
 <2eaa2e1d-b6cf-4032-af28-5e8f6428e95f@amd.com>
 <CAL_JsqLUKyNU7vrYhVzdTKKExXN8-Dyy8cEFd6PNW=b03VDOvg@mail.gmail.com>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAL_JsqLUKyNU7vrYhVzdTKKExXN8-Dyy8cEFd6PNW=b03VDOvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0139.eurprd07.prod.outlook.com
 (2603:10a6:802:16::26) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4f97e1-e4a8-4828-217c-08dbf17a8e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/UWWgGkMycjgnvx2v/m8U7AI5PU8YCv4mYSMBDWqfV3P/SEvPyVPa/U0T83pRHYm0rtuxRVayN03XLFzKizb55Tog4kEJe63JfCKhNMsaryfzhBACRp7YAD9VFzi8xOnHVHn0F8eH16U1yC4JeblVlyIP7hBkL8S/eUhrTc1qs7ZRayQl13iK9j025H6TfeqkWLEVxef6xUIrVx0gXGkNelhgVwmpBzEiZIZiwSWHL3L5Hg1VVW9iLNpZkBgUetWYW51sZBka5ZKFQlIL3v+zt0vm+mh578CCcAqF97Tj7oMzCBv8C5jdIz3MYNgRUW0oZSpr+41gw/FyByHgf1xiLxzaIJe9xl09twvafEd66rwaTRz4Cecfgp1ZWg2cGRVG4VJTH8fYwVtJfbo3qSchQvNvkNWH/j7FXT0MsirvvYDpmXE6+46FG3m7CoaTzlrh6aIW7pjy925VORg+tpx0+gkPZqeFG8lvMmPN/fryKoThW+gzF9/gPFETAPdbM6CO8AWOeeFRpSzEf8oIqTiUInogaRX6PrTMmbxRXXmFrJZ0xxWTuu6RFZa+xBHxVs3IDZU1LNN5Q56/SRYb1+m6OgjVL6ORpTKw+w7+Q8DJR0C0VLZdBTcUnE2BxIMqaSqzkHMZYC3DbiiJocQPRjmtWxovSFVJAcwt/H7IfmaFtMDD3KxnLsZZuTy7pNPl0i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(31686004)(316002)(202311291699003)(86362001)(6486002)(66556008)(5660300002)(66946007)(8676002)(8936002)(36756003)(44832011)(4326008)(6916009)(83380400001)(26005)(6506007)(6512007)(6666004)(54906003)(2616005)(478600001)(19627235002)(66476007)(53546011)(31696002)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUd5VG9nMzhMNFh5SDRnT0JjTGhwY01SWVM1cm1SeDVUK1hIem5IVHRJZHNr?=
 =?utf-8?B?dTBjT0dGVFMxay82SFNQRzd0Y0xKSE5MVTUycXVZMUxSbzNTN2J5R0lCeTZ3?=
 =?utf-8?B?elBLMFJSMU1QdnpoMW9WNEgxMEd1YUhWMm5WcFp1UkNrU3l2akNySFl4QnRt?=
 =?utf-8?B?MkJxeWh6V1o5dk9QY2dxZjRCL1pmcEpxNWdPSU1OWnJueFFXc2NJMkRITlg3?=
 =?utf-8?B?NkFQemJQdGJuUUxPYzNnTnFHb2h3b1l6aHlaTlpkTUlLOUN3Wk9xbFBEekNn?=
 =?utf-8?B?Zml6bWFnRFFxRDQwMjNVeFJPdzR5S1lNVXdCZzFvYWZLWXM5SVAvdkpnQVFr?=
 =?utf-8?B?VWREYWxsN1hvSW5CUGxBNHJpcGhQa0UrYXZIQ01Bc0tTcWY2U01yR2lmNWEv?=
 =?utf-8?B?U2hJTjVQZkpaT1Z0NmRwUTFWa0c3NW9nQmJ0b1BLb2Z4ay9FNnR4OUFiTGo1?=
 =?utf-8?B?VkE1Y1FUVG4rYmdEclVUMFQyTFVLN3YxWDVaQit0bXorV084UlFUYWs4VnBH?=
 =?utf-8?B?VExrTHZqdmVHcThEK2pTS2FNYmdnVzM5aWkrb0lYRC9hV3NMUWRjcEFEcXAz?=
 =?utf-8?B?ZFRBcG1NeEw3c2VLcXp6eVAvM1pXZjV4b2RqMlZJdUZ2RGovVkdoRnVWeDEr?=
 =?utf-8?B?S2dkdlR4c1lwd3FkcFJwMXdtVHh5MHRDK3l2S25sVmZYblFjbjlZQU9pbEs4?=
 =?utf-8?B?OUtISzhhREl4cytCRGVmcW1Cd29NM0VFemZlWVpMUHJhMUZwRXR2STFraWdo?=
 =?utf-8?B?TFZUckliQVZ2RWIzVE1tNGV1V2N1aXlGbTJuS1ZzaFduc1V4aFdIRDhPL21Y?=
 =?utf-8?B?QWdiZ3hrR2pzdG1HUy9IN0V4U0xTM0JVbUlYbTBRcEJoVnhJM0w3MzBvaUw3?=
 =?utf-8?B?Tm1vQ3FVUXpFcVpsY1RtbkNQb1BvUEhUVi80ZEUwWEZIWS9WYTZKeWEydnFP?=
 =?utf-8?B?RTdZMUx2KzZFV1lEd0xOUjRpdUprdUs1cStPaEhGd2VIU0VNcU5mM04xN2tk?=
 =?utf-8?B?QTJOMGNycE42TTQwWkdsNTVlUzZLcHJtc3JFcnlCQkNIaFRSNVlLMzBhUEU2?=
 =?utf-8?B?Mm9yLytUTFRwdmZhQ3poTHVRSlVtMWFQQ09YSFU3Z2swMFRTdUVsWUx0WElM?=
 =?utf-8?B?a3NBUEIzZVRZclZHMzBCVVA2VzZGMVVqYjg2YnplOGR6bXJMR0o5dGF0b1R1?=
 =?utf-8?B?VDhQQjRSd05GWGZJclR2Vmc5NEt1OHV1VWJ0UzYzS3E0UlZ5K2ZBZkw4WXVz?=
 =?utf-8?B?d0ZHeE92TlFYZnJzdG9JQmpwSGpsR1cvYmV6c2lmWjJDWlIyckw2dGZuM0Nw?=
 =?utf-8?B?b09PZm5waU5rKzNmc1dORlRqZ3JLZVFialhWalI2UkN6dG1KZ1dYUWRtSDNp?=
 =?utf-8?B?elJYUDZjTG55WGtGaUhhcmdwaXc2WE9NTC8zZ3FsUmxUd0IxWGZWcGVWU0sw?=
 =?utf-8?B?ejBPZ1EzZ0k1Vm5ETTVEbktHdXJUd1g2OGErVk5RbDdtbUgzZkZyMEd6ZjlQ?=
 =?utf-8?B?dGpGd0MxUmZ5LzQ1WExSVzRGdzE5djVFdUlzK1VqZlBsRG9BbUwxS0IveUNH?=
 =?utf-8?B?bXJLbDZZOVorRU1UYXFCNzczWWpjaEs0dUQ3TGZXTmVscWg2SndOYlIzZldq?=
 =?utf-8?B?VlpVcHVhTkRhaUNlK0laSE93MHpUWHF2Syt4RTF5SVJaU1JIbndHZ2ZLRFhG?=
 =?utf-8?B?QVJFU3liTVU1ZHRLaWlBSkhJd0dSQ1IwQU5Ldk1qa05jeHdUSTlhWmY2bDJR?=
 =?utf-8?B?eGs3d2tnSzNpOG5TZGhraW5lencwM3VFdmVvMnNxYUIrajhpN2lsWGVqa3Vv?=
 =?utf-8?B?aGZhNDY4YmVDWlo4SDBPVkIwMUhIRW5qVnIrQjM1MGllQW9MeDhyckJqVWxH?=
 =?utf-8?B?UklFL25yK0d2UStOdzBjZ2hnWEMzR29CRDNuNFRSSmlWZEl2QkZhZytBS28w?=
 =?utf-8?B?UEJGL1lkVFVxMjFRMzFMam1Pb1VqYW1mU2RxN2lqYm9kKzVUOWZYNDl1UnJy?=
 =?utf-8?B?WHBHNkFEWmxzYmpFczlnb3JNZ0x2ZzRpQnkyZW1BNzhZWmE2VmlXQWhzWGVm?=
 =?utf-8?B?clVmbWdvZWp1WVpoWVY0Z1hYbUJjRU1LMGJVZDBkanpUOTZmeVlnRmlIS3k1?=
 =?utf-8?Q?+ftuVKxh5vsTg4WEGXNQZ7KOL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4f97e1-e4a8-4828-217c-08dbf17a8e5b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 08:01:28.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDmqykDcnD3WintDzFk4Y5xWdgJA5xDZvgrHZbimw+Ip/Tza2/fDyYyYxBwKIpkf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/23 17:13, Rob Herring wrote:
> On Mon, Sep 18, 2023 at 5:56 AM Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 9/11/23 23:47, Rob Herring wrote:
>>> DT overlays in tree need to be applied to a base DTB to validate they
>>> apply, to run schema checks on them, and to catch any errors at compile
>>> time. Defining the "-dtbs" variable is not enough as the combined DT must
>>> be added to dtbs-y.
>>>
>>> zynqmp-sck-kr-g-revA.dtso and zynqmp-sck-kr-g-revB.dtso don't exist, so drop
>>> them.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>    arch/arm64/boot/dts/xilinx/Makefile | 9 ++++-----
>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
>>> index 5e40c0b4fa0a..1068b0fa8e98 100644
>>> --- a/arch/arm64/boot/dts/xilinx/Makefile
>>> +++ b/arch/arm64/boot/dts/xilinx/Makefile
>>> @@ -22,11 +22,10 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA.dtb
>>>    dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA.dtb
>>>
>>>    zynqmp-sm-k26-revA-sck-kv-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
>>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kv-g-revA.dtb
>>>    zynqmp-sm-k26-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
>>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kv-g-revB.dtb
>>>    zynqmp-smk-k26-revA-sck-kv-g-revA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
>>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kv-g-revA.dtb
>>>    zynqmp-smk-k26-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
>>> -
>>> -zynqmp-sm-k26-revA-sck-kr-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kr-g-revA.dtbo
>>> -zynqmp-sm-k26-revA-sck-kr-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kr-g-revB.dtbo
>>> -zynqmp-smk-k26-revA-sck-kr-g-revA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kr-g-revA.dtbo
>>> -zynqmp-smk-k26-revA-sck-kr-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kr-g-revB.dtbo
>>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kv-g-revB.dtb
>>
>> Applied.
> 
> Why is this in next still, but not in Linus' tree?

I was OOO and didn't send pull request to Arnd. I will do it for 6.8. It means 
in 2-3 weeks from now.

Thanks,
Michal
