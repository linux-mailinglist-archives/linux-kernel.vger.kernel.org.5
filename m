Return-Path: <linux-kernel+bounces-19132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EB082687E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675B01C2193B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3065B8BED;
	Mon,  8 Jan 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GMOOX7pc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2078.outbound.protection.outlook.com [40.92.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448B8BEB;
	Mon,  8 Jan 2024 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lseZgpbPQzhxoQGZ55uuHlrCh7tT6+OCitZXZyNpAGET7JpZtjzWAyT3lrq3BenKLWaSVgGCgS1iB44QyIDmHUSmAOZW/Gg3EzKjq6O+1Ik/iUpO+uy6lCO+F7ZrgJM+t2t1pefHDlJsFsSC1KNxKXgnZtbG5BFFScyTlbfipVNXrZdoX2xChhTzAI3raRz/bLVfeySZWg5rUbOKqSsrByilSOD4sD7MFSg/Nf0f0WP/P4gAJoXYQLXJWNAJWGEnGxIA5cKwNEoMNe+ADCd7g66Tt7/GcIXXWQ+y3/+Uw07nUCnYpNFtX6NF6huXLBMWgapazdzeuQGnzA+6urU5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9yfH5vj45SJzh5JnMwN3e1M6n9BdsxY8ZaK+OWan1w=;
 b=G0wsk/SU3XiwfiO7CPS7OMRLIhf5qr1WhVwzN3lX1SK8HxS/q657mPxY2ReR3cr3rh4aJiDUEX73Y7dbDEdO6J/gv/0VmXfiCjqwe/GVk6FkfKDHqBCwSkpkUK++y1yiL3H3YqUwgf54J5/pzLc4agKElYT3FhpOUF9Z1h8SoshaOw/PT7YystYnUATRYWeILvJkb3pWU0ccrp9oSQy/SEN/nQtZIJJHw53+wvo1pASsh6IEYRuV04Mxv28yBOcte0DyE8vQ0CeMdgIyEos1blKFvWyeclq9q+VKvjZIYmzxIQnDCLV3MNSfuCWnvtDF0+hear7XjwCmcTwldgdMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9yfH5vj45SJzh5JnMwN3e1M6n9BdsxY8ZaK+OWan1w=;
 b=GMOOX7pcMCrZun2f+gsVwMKvhTePDO/ofi/hWDsypn/Iz6oevhJiZh9SqJ6Oq3Vf26SXke9fAxQvcRB3dlkQ5NzTVJELKLsOKCBYWtngLhDnFtklnhJGPAOzb2z+SAfeFDyVlmTtN3P236Q/NAV8yNSczgNjin06oqFa1wKsfTPg7GA4KsvnPs6uS0L4E2CGVTmYsB1HGfTKnfH/a0Z6CuUpSPqrWDsIkwlafDyrgTpRPnL2eMyy7mj0tIoK0TkO5Ytwt87EHPJFSi7OM0HCDHNBZKisoVlR+bOhuL085LqEZV1gBQqyB36IzqVIRF4Mh2qoZMlHcMeKCH1eYqDLHw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB2595.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 07:20:52 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 07:20:51 +0000
Message-ID:
 <MA0P287MB2822E54A6DD36F914DB56E98FE6B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 8 Jan 2024 15:20:46 +0800
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
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cc7cc943-7242-4fd1-9b56-3ece0a418e05@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [pvh8ncbL6CckRfDfZ6tJGYQQknwrYUtV]
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <b5eff2fe-70e0-48a9-88b2-ce832fb21909@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB2595:EE_
X-MS-Office365-Filtering-Correlation-Id: e717d7ad-9743-4701-077f-08dc101a583e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UApF7vB4N1KNlSUBrI2dlRZkCSREiOW2zLGA88/z7i23/JZU9J5a4eX2UHPum6bcw8hcLHrAzCp5HxtBIk6NbE0HLSYY5K+Va9QzxYYWKfXtdx1rD6Uo0Rk3C9L2S2U/YVqEjV1h3sJH3yeOcWMiK5mE5zR81SSGLK22LBBnHimjqMkIRNZBV8gEimqF9b8OLaXMlfBSrCe2ADriiAwa1x/To46KExjxU96wzlGtYcfUWZRqF1vW0JdQ6pg47stJefkPsrPYNtTx4BVu4GV5Sx+s29cKEvAqV59rA0ZbZ0CePog88Ay6ddZFJvLoGFlQnt5oaokgdy1qt4vyVjd+Ru7YcMDL7ftHsGfinAPOf0055QnRyHgpMv3xaFgRG8HgNl+0pc/VMQufleVBqYzHTFgnqe0aqf6eCh6Z3LTy4IdhVizXyp7wLXJn8qEYx1W79f+xx1zlWZFTFyGuTX52TNt0O6JpEmeSxaOrofx9ubtSzjyp7a8qnBn7wua1FBO2IUH3/xOKBPtdkRXPA+J+/h+7pU/QHJ/C3FnBkdK+3CzBGsNMPkGCz/HcfQ6H+O+etTtearkcHVbT7p9oSBdWQ94XYgh4Y4Ai926+ZidymJ4CbdagKH9EPaQ2mWejr+y07kebCSK9WecQr2lya8VDEw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjZWakd5RTR6eVRCSXFxRXJQN01WZzhSM09kTkl4RWIwZTBzVysrNWsrU1pZ?=
 =?utf-8?B?b09xTVRWSzh4azhPY0tiWjhGWk9JeFhJZGFNUFRJL2lxOVVsN0owWVBadW1j?=
 =?utf-8?B?VHY3UnpremQ5RW51UUphVkpGZUNmY09yRGJIZjRlRkxMKy9QVzdDVDRpNnRx?=
 =?utf-8?B?em96N2h6cy8rRFpxNjExcHpMQ0djeVJCZjkyK2xaZkRMY2NGTGtPN09NNDQx?=
 =?utf-8?B?VVpDNUtVdDJTaXBuVWJTdUJRQTJSVVhFMUNsblg5aUNlNE9nSktOQ2JCQkZP?=
 =?utf-8?B?Y09SRis0WjBDeDU3dlB6Tm1TaDhUejdBYjNuUVQ3dWlBK1BUVEN3eE5WUWUw?=
 =?utf-8?B?N1c2STFNNEZLR0t4SDM0a2RYZUl5OGIxQVAySHVzdmdxNWkvY0FPTHFEekUz?=
 =?utf-8?B?VzVrZ25nWU9FRytjcUFzZk1WaDVTdW9vY1JEMWo3VkVVU2dGQlJ4emdXQUtC?=
 =?utf-8?B?cGtob1FKMzFBRk83WlIxZ2htOGcrZ2VINEdIZmxwaDk2WnB3ZlJJd2JHcmtn?=
 =?utf-8?B?QmxiRU9DRThudmpIeFR2SU1GV2Z5MUlqbVZ5ZUNGcThHK1BqeURKSGUwTUFk?=
 =?utf-8?B?TmRwUWNwYklqRVVadGNWVFhsZ092TXdYZUZSM0ZaUHdqOC85dXhiaHY4UmVx?=
 =?utf-8?B?M243Q1ovN0gwTUlLeFlxeDhmWVczMWp5OVN3MG9IcEI2dG1VVTQ5bUhnWlpn?=
 =?utf-8?B?T25QNkZ3a3diVFdwWTBMZUJ3Q2pXeFVXRzJrSUdtZU11RGRhKzcrT3o0OUpE?=
 =?utf-8?B?cXNPMGxEODJLUEhUbUd2cTRBdUdkcVd4dld5dVdRTCszdjJqcVZvWTZ0YWtI?=
 =?utf-8?B?bEtGa1BYU1lBU3VrTVJINnJEdnhrYnNCQzNjSzg0U0o2b0Y2TFBlbm5WcmQ3?=
 =?utf-8?B?VFVnQi9oRGFZdDZlblFtcTVuU2E0SEh2UlZFbGVaTkFVOGJIYlF4VnhOL2dn?=
 =?utf-8?B?VEhwVmxZdmVVSkMxdjJ1Vm11SWcyeGp4aHV1UEZuVHo4UHh3NXR3RFJVZ01a?=
 =?utf-8?B?TU93MWZmNzdMdTBhMnNSZ1NRNWwrbnY4aXdtaVQ2TW1Mc09LTWJaUHZJV21y?=
 =?utf-8?B?ajU2ZWxmc2RmR2x1cW5PK3U5OTBURGtnbE8xSVJYWnlDc01KaW15Ly9zMnlD?=
 =?utf-8?B?cXNpdC9oVFRBZFQ3SWhqYWoxTkZnQTlVanNWTEpsYk9SeVRzQmFWVWlTcWlY?=
 =?utf-8?B?Y3VnN2RhbHd0a3B4bEZhaDBGc3k1RHZPZVNIVUNPSEpIL0RiSXpkQVJuVFZ2?=
 =?utf-8?B?eTlUVVlvM0NTTUY5Nk5nell2SEF0NHdSZHJQMlZWaENhZUpyc2ZMZ3F1SWVL?=
 =?utf-8?B?UWo4am1RMkVQVFBLSjNXNnorelpQSHFnT0ZoblU0ZHg1WEVrUHF4YjBaUlZ2?=
 =?utf-8?B?ZXpmSGc4d3h4dU92QUVuQW5IdEFpSXc2VGk0blIxWXVlcHhhcFhzandEOE9q?=
 =?utf-8?B?Ym1aTkxPejArc1hWS1kvS0ZIN04vRXFySFErTTZJeUNGWk45ai93RkIyK1dZ?=
 =?utf-8?B?UlZTakFBQ0o3NW5ZZlRkbi8wUzNobnBXRStwSWdlc3VFLzVCRDZibTdmNnp0?=
 =?utf-8?B?eDk0ZjUxZzRQUDl3b2FPc1dvb2g1ZmR0dS9xVTFmOHhiZEc0SzFCNHE2N2FL?=
 =?utf-8?Q?Ne26g8ZlK+9XHK+Y62rj+EKjTJKit4J9cpWqFq7J71bw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e717d7ad-9743-4701-077f-08dc101a583e
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 07:20:51.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2595


On 2024/1/8 15:03, Krzysztof Kozlowski wrote:
> On 08/01/2024 07:48, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add documentation to describe Sophgo System Controller for SG2042.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 34 +++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>> new file mode 100644
>> index 000000000000..1ec1eaa55598
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>> @@ -0,0 +1,34 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo SG2042 SoC system controller
>> +
>> +maintainers:
>> +  - Chen Wang <unicorn_wang@outlook.com>
>> +
>> +description:
>> +  The Sophgo SG2042 SoC system controller provides register information such
>> +  as offset, mask and shift that can be used by other modules, such as clocks.
> "offset, mask and shift" is not a register information stored in
> syscons. Are you really sure, that your system controller hardware
> stores offsets of some other registers?
>
> Show as some example of such offsets, masks and shifts provided by this
> hardware.

The system control module is defined here: 
https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/system-control.rst. 
It contains some registers related to pll and gates.

Some other clocks registars are defined in 
https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/clock.rst.

memory-map is defined in 
https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/mmap.rst

>
>
> Best regards,
> Krzysztof
>

