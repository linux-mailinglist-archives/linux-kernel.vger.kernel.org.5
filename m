Return-Path: <linux-kernel+bounces-21594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF7D829197
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6131F245DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D18B656;
	Wed, 10 Jan 2024 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rTT0JthN"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2088.outbound.protection.outlook.com [40.92.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B314A04;
	Wed, 10 Jan 2024 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egqP6ObkvJSAX96Uq0blMo2/NYXcIgBSLvJ2W2oK64X6Q1EC+Ihd2P02FHm/HpxbIW/zwjfTF40By/srLI2eDt024Br7GziIWeEu5oc74ZboWMf+blQ/uq0j5YOxu5EGeVJiE4rb9kbVI3nSWI8D0eNOQk2tsK3dc2iG9tFPJAReQqQizpd+02O2LOP7glNyYkL/u/k9p1getKbp5lZhDd2hw5Mwh0euK/Vk5tMg/YBuAPEBKvQ+/gx7sTvekjM5valBsEFqdFH/CdjmygzwbU2s9dvORqHD3re51e+/pZw/JZ+a08Nf72Rc9BjFbWwRo2ek/E3oE6A67r1x4hcvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1VuauG0cMc9sxG48xp+zU6+ooo5HVTi7SaXCW2sSdc=;
 b=dU4UQB8BIjrokWRtlhBfc4QWthay1abKQ/jVuwTvz7/l38xOaDrJakZ/7eBp+gnQNKuDrxKiqE7nMbTG4cRjNatsKSV15ohXegMiShL2hLZanE7yQNHRPDuGd3dE5aXOflsRxf4juhbPwKrEWXpEbebNMiy2K/f1x7ofO+DpSMvjWHi25qHfkAxO42+Ovf/K91xT6S2iqVIxsKfnkmfn99Wrs/YK8J4Y/2Iz6IoDe18RkQpiN2HwSntAh9V0QEtDq/xA/GOZVLOWaimT8zZBahsWo5pXxVKG5R4dtlJU+x63jbQRhZlKOXXg3FV6hSRisyWYAXcJnqNFSSjpO3qEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1VuauG0cMc9sxG48xp+zU6+ooo5HVTi7SaXCW2sSdc=;
 b=rTT0JthNKfiCYr053pcMAZ1kfrPjkfdt84EPSwt9zk1XLYdVAcVCqRphAhRpV82kpbCdhbvECMyVUA8rFsX7SpP+uukH6W1aPf2QBmxedToIPAJLcX8SEH2O6saq0RGFj8zPvEkVteyQJOhZjzxvcYAnlCayK5kybyFHpYcij0xSS7iTFDtR1648jKOUbFbs6iBy1sL5G7Mu854qD40UQrvzmyVoxKic3hv1G3O0hUjFUGwC9ieVvN7F/1sG1nCiPhB6ztL8xvLu5TjWuIchtI9JD+in3W/Ekv+Nn8vaHMyFQA9GwqVsv1VP5a75Vx+7CzhJ47SYhfHZVOYlXI75nw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN1P287MB2616.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:210::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 00:44:30 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 00:44:29 +0000
Message-ID:
 <MA0P287MB28223C0D5BD8E2A6A042A7BEFE692@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 10 Jan 2024 08:44:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] dt-bindings: soc: sophgo: Add Sophgo system
 control module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1704694903.git.unicorn_wang@outlook.com>
 <acebc88db3e5fcd2a2607b56842af7443a6e1289.1704694903.git.unicorn_wang@outlook.com>
 <cc7cc943-7242-4fd1-9b56-3ece0a418e05@linaro.org>
 <MA0P287MB2822E54A6DD36F914DB56E98FE6B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <1e1ef0a0-6639-4a4d-9b4e-50bcee3fb3c5@linaro.org>
 <MA0P287MB2822C1F51E9F03137EF42093FE6A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <60abfdcc-3d61-4df1-b77b-23d4a5d26a46@linaro.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <60abfdcc-3d61-4df1-b77b-23d4a5d26a46@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [6xfKtfKUaY9H4hRvKBn/6tWn9UQHkpyt]
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <0cbf6438-7f9c-4010-bec6-543f4010133d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN1P287MB2616:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f192a5-439d-4e16-74de-08dc11754dc1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G8xKHnSOJxfvjcPJCQadhaYNdVa4UwZblys8OXiB8M+93ujtfju2TOH/BWiG+0BkSFWGzDYNNTrelPXnBtgEgs9QNH0cEkY77kkdGrnrBti0BSbRV50idTfBJRUDrh8t3499YPqiRDZTwVKWXbklHsceRDf0+AIXJBEc9HMsu3EikO7g1v6B6ng+xMpp2T1rZzLrooWRwp7CkFByjc882DtPLJZt85RLkngnFVsvabSYjGgqQkBPhUWKcYVRFyBDdDYZle3TMRBZptLgDkI//h3tmWPQnDQ14jzq7L3HWDqfp4uVGPGVHDS4LQWxCj7E9CAiYE4mcpjWlsdDK2Wvg08ipdd+y7ugB8nnCntNuyIPeJdP6LhihuKOrEv6lLS8bYVH4v52wCW/rHiq+ywb+B47+ZEpnoJ5yqu4b6sMEoDFeSU80cKj+nVEGcOY8lhY/gvjYI7HBGTg60M2qAk3qxT/tRag21QfSaqV4ETqRMDhROi3v6m/5qjRZwOqOBJGoEzK2iSMryS6ChsE1coVrFyY2d34AHBdHxNqr4+oNWC5eCt2P1BuodnScDjZBDZxSqEV5AeEl2SuN/G/22YTgEBrfpZ7o3SvIwrF0qWPR3uIJK0Zniv++6/dBui6sc+DFJz9GQKp9BOnbCz+/uuwOA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnV6RG9KdTJ4a1lTNzgwZmZvTnNyU2xEazhabFNTd0tUa01pOVh2RFdjL1Jt?=
 =?utf-8?B?RDlyMW5BV2lneHpGcWxRRUhlRFlMb1NaRzdrWFUyT2dxWXVadE1vR1o2bEla?=
 =?utf-8?B?NGZnZ0RyQk1laUJhQ1dVRnh3alZMa0hGT21RT3J2YzFsd3ErM1ZvYkV0L0lo?=
 =?utf-8?B?eFpjUE1BOUxRWFB3bTk1NURQbUpDSEI2SXdQWU1CNG1XVW94Y0tYZ3AvcUtk?=
 =?utf-8?B?eUdONTVscGFMU1drY3R2QzlSNmUvcXEvRlpJQW45Q0dkR2tJV1RhZmJXQUNO?=
 =?utf-8?B?UHQrS1UyMTRkUFZTVUdnSWI1MmsyeVordEpDU2V5eXdqTTk2VGNlZ2V2QUFq?=
 =?utf-8?B?eklMUHZmRXY3QzVvS0lNd2RDM0xWKy9UVmR1RzJLN1VqWFlmbCthYnkvR3pw?=
 =?utf-8?B?RGVvbnF4OVlZd3c2ak9DelJrRi9IZ24rdldNbmE5VWRyRTlubEZBS3gxVWRs?=
 =?utf-8?B?TzNqTUU0c3E2Y0RETEZ5RFI4UzNXUlVxNGl3Y1Bxcy9EOFJzRVRXRWtlV2k2?=
 =?utf-8?B?b0xiak4wVmRmbWF4bWNiUTRCaWprWjVySGVlYXh1SU12RVBhMnNFYWZBdmxS?=
 =?utf-8?B?ekJCdG1jeVZ6QTBmZ09CV2pNTGMxWjBsMFFUVWY3dktVNzBKZ0ZHeDVDbmxn?=
 =?utf-8?B?STAxSG1BRC9zQ05MNjU1NmVkU0cyNmxiL0FubE9SOUpSM0g3RXRBa1puMGhj?=
 =?utf-8?B?VUhiM21XaWxkK2dUbUVMNmlRMEx5M3U1SWxjQnhCOWplT2lPRFJYcVFZSmd2?=
 =?utf-8?B?ZjhhN3lsdytvSlJsdm9KRGV1eG84MXJNWHY5WjlEay9TbExRbUxXRzh1QVJW?=
 =?utf-8?B?NURySFkvazVhMTl4MW81YkwzdWVaQkJaTHVwY0p1VC9LNHU4N1RMUVhCVzNM?=
 =?utf-8?B?Q1hWcEZjdjYvdVVOTjI0MjhWZmRVTkZITWVhbDFQUjhVVklZNFN0RHA3SXVV?=
 =?utf-8?B?WnpET3hmbzNJYUM5bWNoSjdjY1kxZDFqODhOdU5Kd2YyVFVVRTNmSElONldR?=
 =?utf-8?B?SjZENk5IR0RxYk1KbVJreUtjQ3RqZ3MwVGYwQ08vbFNIdTBWL3ZlNHZsWkZT?=
 =?utf-8?B?cG5wTW4rRW1jYjQrNU5UTjk0cmNGVHVPQWlhNDhWS0M0VU5lN1NySGFlTEV0?=
 =?utf-8?B?Q1R6ZTNWMHAvMStjSkJLamhsRmdaZXViRVo1UDBKbEErVHhwYlJKVEZOYzNT?=
 =?utf-8?B?N0w2bU1hNzdNR0trZFhRYmYzZ1REYXkraVIzbEMvcWZ6NExGK3A2V0lWamxW?=
 =?utf-8?B?RExDQlZNYWxSMnMyKzIvenNKeHdNNGEvQVFxWDU1SGhGL0ZMQjROT2Z0bzcy?=
 =?utf-8?B?T0F3QlpZT3NnRk5QUWQ5ckQrMWVUaHpzcE5WWW5SWHdMbkpPZXZNVm1mNlZG?=
 =?utf-8?B?WXh1OTJQRnowSmZ3NDVKU3EyMTArM2tDc1JtT0pLK1N5TG5ydy9oOUJCdDNv?=
 =?utf-8?B?OGNwM1Ruc3lDVkt3Nk01ZGN1aHVRN09DSFJnK1RVc2VBSUtRejYyalkwdWw3?=
 =?utf-8?B?RmRVcURZOVpsQzR5anpRNm9qblQyUzRDanRTNlZYdExBNjVsdnc2U3p3RFVD?=
 =?utf-8?B?bEgrd3o2d3hsV1NhVXpoQzg0S09MS0pqOEhkNGtKaTNKY1VPVmZWMzE4OHJq?=
 =?utf-8?Q?jXGqwR6gS6+rLR3nX1hUT53tyUREQtakw/ClID3Y5rp0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f192a5-439d-4e16-74de-08dc11754dc1
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 00:44:29.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB2616


On 2024/1/9 16:56, Krzysztof Kozlowski wrote:
> On 09/01/2024 09:52, Chen Wang wrote:
>> On 2024/1/9 3:36, Krzysztof Kozlowski wrote:
>>> On 08/01/2024 08:20, Chen Wang wrote:
>>>> On 2024/1/8 15:03, Krzysztof Kozlowski wrote:
>>>>> On 08/01/2024 07:48, Chen Wang wrote:
>>>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>>>
>>>>>> Add documentation to describe Sophgo System Controller for SG2042.
>>>>>>
>>>>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>> ---
>>>>>>     .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 34 +++++++++++++++++++
>>>>>>     1 file changed, 34 insertions(+)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..1ec1eaa55598
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>>>> @@ -0,0 +1,34 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Sophgo SG2042 SoC system controller
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Chen Wang <unicorn_wang@outlook.com>
>>>>>> +
>>>>>> +description:
>>>>>> +  The Sophgo SG2042 SoC system controller provides register information such
>>>>>> +  as offset, mask and shift that can be used by other modules, such as clocks.
>>>>> "offset, mask and shift" is not a register information stored in
>>>>> syscons. Are you really sure, that your system controller hardware
>>>>> stores offsets of some other registers?
>>>>>
>>>>> Show as some example of such offsets, masks and shifts provided by this
>>>>> hardware.
>>>> The system control module is defined here:
>>>> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/system-control.rst.
>>>> It contains some registers related to pll and gates.
>>> I do not see there registers providing shifts and offsets... just values.
>>>
>>>> Some other clocks registars are defined in
>>>> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/clock.rst.
>>>>
>>>> memory-map is defined in
>>>> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/mmap.rst
>>> Please fix the wording because it does not make sense. System controller
>>> does not provide register information. Your datasheet provides register
>>> information.
>> Could it be that what I said "that can be used by other modules, such as
> modules as Linux modules should not be involved in this description.
>
>> clocks." may cause misunderstanding. I plan to change it to "The Sophgo
>> SG2042 SoC system controller provides register information such as
>> offset, mask and shift to configure related modules such as clock." Is
>> this better?
>>
> Still does not make sense. To provide "offset" means that some other
> hardware reads sophgo module to get the value of offset. That's not the
> case here.

I'm probably starting to understand what you mean. How about changing it 
to the following?

The Sophgo system controller is a registers block, providing multiple 
low level platform functions like chip configuration, clock control, etc.

>
> Best regards,
> Krzysztof
>

