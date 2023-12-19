Return-Path: <linux-kernel+bounces-4724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CDE818130
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29412856F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9EA881E;
	Tue, 19 Dec 2023 05:53:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A6849C;
	Tue, 19 Dec 2023 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id B23E724DFED;
	Tue, 19 Dec 2023 13:53:01 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 19 Dec
 2023 13:53:01 +0800
Received: from [192.168.151.176] (172.16.6.8) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 19 Dec
 2023 13:53:00 +0800
Message-ID: <60d091af-95d0-6f26-d535-4c3d8f38b5c1@starfivetech.com>
Date: Tue, 19 Dec 2023 13:52:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] dt-bindings: mailbox: starfive: Add StarFive Meu
 Mailbox Driver
To: Conor Dooley <conor@kernel.org>
CC: <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>,
	<jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231218061201.98136-1-joshua.yeong@starfivetech.com>
 <20231218061201.98136-3-joshua.yeong@starfivetech.com>
 <20231218-pawing-unripe-e45ad62ff8c7@spud>
Content-Language: en-US
From: Joshua Yeong <joshua.yeong@starfivetech.com>
In-Reply-To: <20231218-pawing-unripe-e45ad62ff8c7@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS081.cuchost.com (172.16.6.41) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag


On 18/12/2023 7:17 PM, Conor Dooley wrote:
> On Mon, Dec 18, 2023 at 02:12:00PM +0800, Joshua Yeong wrote:
>> The StarFive Meu Mailbox allow communication between AP and SCP cores
>> through mailbox doorbell.
>>
>> Co-developed-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
>> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
>> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
>> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
>> ---
>>   .../bindings/mailbox/starfive-meu.yaml        | 66 +++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mailbox/starfive-meu.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/starfive-meu.yaml b/Documentation/devicetree/bindings/mailbox/starfive-meu.yaml
>> new file mode 100644
>> index 000000000000..dbc5cfdb90ff
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/starfive-meu.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mailbox/starfive-meu.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive MEU Mailbox Controller
>> +
>> +maintainers:
>> +  - Jee Heng Sia <jeeheng.sia@starfivetech.com>
>> +  - Joshua Yeong <joshua.yeong@starfivetech.com>
>> +
>> +description: |
>> +  StarFive's Message-Exchange-Unit (MEU) is a mailbox controller that has 62
>> +  independent doorbells. Each MEU channel consist of 31 doorbells and consist of
>> +  a pair of Tx/Rx links that shall communicates with remote processor. The
>> +  sender set the bit in the SET register to indicate data readiness for the
>> +  receiver. An interrupt will be raised whenever receiving notification doorbell
>> +  from remote processor. The receiver will clear the bit in the CLR register
>> +  upon handling the doorbell notification. The sender should poll the STAT
>> +  register before starting any transaction to ensure all on-going doorbells are
>> +  processed.
> What is/are the consumer(s) of this mailbox?
> Is part of your RPMI implementation?
>
> Cheers,
> Conor.

Yes, it would be part of StarFive RPMI implementation.

Regards,
Joshua

>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - starfive,jh8100-meu
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    items:
>> +      - description: mailbox0
>> +      - description: mailbox1
>> +
>> +  '#mbox-cells':
>> +    description: represents index of the mailbox/doorbell paired channel
>> +      channel  0 - 30 for mailbox0 doorbell
>> +      channel 31 - 61 for mailbox1 doorbell
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - '#mbox-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        meu: mailbox@1f370000 {
>> +            compatible = "starfive,jh8100-meu";
>> +            reg = <0x0 0x1f370000 0 0x8000>;
>> +            interrupts = <170>, /* Mailbox0 */
>> +                         <171>; /* Mailbox1 */
>> +            #mbox-cells = <1>;
>> +        };
>> +    };
>> +
>> +...
>> -- 
>> 2.25.1
>>

