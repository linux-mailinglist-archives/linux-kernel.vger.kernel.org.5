Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9612C807B6F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377576AbjLFWhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjLFWhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:37:31 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D8F10DF;
        Wed,  6 Dec 2023 14:37:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6JyozQ8p5YhsqFhJhftPUbNe7KOYUI3MqSEcEaqbEtCgTwi3tNM5s8Vi4EcKV1gU6+/PCN4AofnSK7U5dSEVP9EkD6www1CJQoDRs1dPJ/GPGSke8Mjd8HzUG8Dpeo4r11cIlan7gymTtD8riup0VkDrPjLOtv2gFgHVRJJJY95JAvNqvdjXsY8Jh5dJ8ujP64CNxyEwrHPl0XZYuzV2nn+8Xc0X7ryNSsSIjdpAOJbN4QreVwMO/U111+6b2mnHM5n4jcdp2vS3DQFap9g3eZ4z87q5lrVeAAhTJsng+9bRX7feZb5chvLx26fOIIEMUMYdQS3f/HZ29KkvO5bAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsZJtAoJ0xnEWV88RrrvLt8ZNqbDbo5bMDWVz+35dMA=;
 b=GX574YLeNrRWBEkvO83vOovbNCq2JwBJuHTNDHCXMTQrmj6nHpeLD8tqfDRsExFUgyyt/+Wm2brQ8RQ6GNg8oKJMr96mvZyaVCRERXnmk7Snc5eoUK4hc7uLTnjl0FV1cEyQ82g254UTXKTviGr8g4Iu0NSdf6lE1KAVMYraMzGfecNhRyMTrnOzhl/x9KWqyvSb/LLGap8bgUmIvC9CZPYE1jKaLD4r+WvXgCs4mCHjyBrmVXqrznbsXxmrdlRDzjX4609HrWtHwvDtL4SmM5hN1AJf7Z5e8WPrvd6w5DrNV2rXHyDILeO7W5VVeCn0/csoUyt6tfZLgK37G3wzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsZJtAoJ0xnEWV88RrrvLt8ZNqbDbo5bMDWVz+35dMA=;
 b=1k2wy9tH8qmmV5Sn5uSc4HdYgo8SZ8qEGO4EZpwV2ImcDh/3JeoL7HXf/Ony3stPF6BlLyD79JH34PjWrORBx2wqVD8XDtcANl0vSiH871kLw0UFy4W8HKseil1EQLKOVSF9BPkFwzGg1LiFU6ykAzqweCZEVHo1/YdZhQwzYy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 22:37:31 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 22:37:31 +0000
Message-ID: <ab598071-ad8b-472f-98b8-81e3cc9865b7@amd.com>
Date:   Wed, 6 Dec 2023 16:37:28 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] dt-bindings: mailbox: add Versal IPI bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shubhrajyoti.datta@amd.com,
        michal.simek@amd.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ben.levinsky@amd.com
References: <20231130011936.3753814-1-tanmay.shah@amd.com>
 <20231206150927.GA2140113-robh@kernel.org>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20231206150927.GA2140113-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: f93e45b3-27b8-4f80-6a09-08dbf6abee71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocPtcYp9CbkB+L9m9d0x/2FkluLFohOYsvqr38W6JJe5UIwNQ0r1syzLHY9JmumWkOenLIIQi5RosfwbZUzCtnsjPg1kpF2ojgZleJwVXH74agda1ebdWZ7IsL8eLcwZNcyPguc3UgL5OV3bk8t8PUvKjqBvxmCko7SPKSwqNj6rrblf8vQLItCaZ1HvLv74GuP8ySeGjuj0DPA5Hp46nU1FhUEeKilKOrKQmxVS3fGQNkuNL2+MQWOXlwBWxxHK1G2b/WQQtkqE+5PhJZtBe7v6kNk9+XNs8KiW2+JlfxnqPCx4gZICJQ/4XV/r2eVFYQbcyOp+3TW1udYJLGoQjj4Io1zbuGTEo2t1an9yPwp7b/rfrnHn6xHVRSWIQj2Pj/ZfcLwdFFTQeuORk0HimnS4ZWnEADS9fs0xwg8E7McuiwwX1B81OTf2jWNBb8VSeHUhtycpz5xvTxMAOSEX6sH6PgP3eOmPywdqCTvk3cP163wn6M4IFQ2Qz5nEpRXD2mNZQz64I+/CwGSE7N33GXTCENJCWGjfhnWKCBRtzv8ZJh/wdQyFAQte997I1wCWUdl4owXHXZmt6u8jkALw4hDNxyqCB1tkrNIX0hE1CXm+BJELp79do9pJmIMQQeqX5nUUnX0TfL0iLnXL8qmlSB9Gvlfmr0fO7vHxCipHG9J3If24M6l1Pfdqs/fl6ezx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6512007)(2616005)(316002)(83380400001)(6916009)(26005)(66476007)(478600001)(66946007)(66556008)(6486002)(966005)(6506007)(53546011)(6666004)(5660300002)(15650500001)(31696002)(44832011)(38100700002)(2906002)(31686004)(4326008)(86362001)(41300700001)(36756003)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm5xM2dGWTNYcG5qRHVyakVPOU9oZ2hGdmJsd0xGZDJSZTRWcFQrTzZFWElX?=
 =?utf-8?B?cGN6STBYaEQyRE9DZlJPVlhIUE5wZVVEbW5MQTYwWWJlUkx1NTg1c2UvN2lH?=
 =?utf-8?B?V0VzNlh0WkI1blI5dCthUk5JWVJ0KzF6WW1VaFVqak9lWFpqME1UcExObDFN?=
 =?utf-8?B?QTN3dFFDUTl0V0Jub2xNMjNjVmR4Um83cCsxSEVBUk9KUnVvb3VZZ3JRc1JW?=
 =?utf-8?B?NU1YcnpQbzVqRS9aRDVrY0YwN3luSGVHQ3Nyc2hTUk9QbWhGdFN5V1FqWGFk?=
 =?utf-8?B?RlAwZXhFcHhaVVdRWVowbytrTVZLcnRGTHZaRHM5eGdKQjg4a3NDdWoxRUlZ?=
 =?utf-8?B?N043ZENzV1dsRVYxcm1CU1BOT0xCMmR0RFp0UlBncW5ObnE2SU5MT05nYkVl?=
 =?utf-8?B?R09ZTTBvMzJuT2RRbWxZU2huVTRGYWM4d0plSjJIcmFYWStFU3hEeCtDMmNZ?=
 =?utf-8?B?cUhBK0txMCtRNTFselhzMzA4ZmFOSGFBWDVmbXlEOWpHek1zTkJEdkx4eWFh?=
 =?utf-8?B?T1hEbnJFcTJNZVpNQkJUTnRjNEtBTTJHVlY0c0lCMHJ5amdmQVlTRHl6cHVJ?=
 =?utf-8?B?aktFNXlMQkJuTlFqQXE0eWtUY3gySy82RllGMWhsd1dqdjVYam5zUXlEK01Q?=
 =?utf-8?B?VWdwQTB2am5KQ05SZFdUYStnMkZzazNnK3Fpckc2L0xKUlBaUzBQSXk3RzlK?=
 =?utf-8?B?TkRDOHJYM2JlMXhvelAwaUhSWEllOW9DVldYMzRReUZQZEVBS28zcjF3N1hs?=
 =?utf-8?B?Uk15S2ZvTlFSTmJKMmpPOG05eWNOakdpdHl2QUs1bm51WVZYUWptQTNaQmoz?=
 =?utf-8?B?SVRKcTVHYjZaNEV2Uy9NS01XOGFFbElQcFkvN2RTL3prWVl6bFlaUWVmUTNO?=
 =?utf-8?B?cTczeVEyNnlVV0hpTUM0RThEcU5mR2xqZVdTNXJLTFUwTzByU0lMWHdzeW5n?=
 =?utf-8?B?MjVDNVRGVXJZa2xpdTdJdTIzNmh0bldMS1FidHJwQlV4eUErVnZLRlMrR1lL?=
 =?utf-8?B?dFdTVlZMZlU3QTJ6Qmg1SUNWVnM2VjR4ZXJwayt5bnc2cXMxUEYyU28yK0dL?=
 =?utf-8?B?aUdKajJOVWVaaUs0QzNUK2FZdnFEOXJmZkVlcTF1eVhrMkhGU3pEQWtrdHpZ?=
 =?utf-8?B?TnNXbzI3dzNNNDJOTWVOdldBTVUrQ1VkUnVMMm1iUitVd3I5d0lPK0JIdThF?=
 =?utf-8?B?SnI3OVpPUEl0aWdONitObWxidXhIRzV1RXN4a0J5REt6L09ISyttL2FlUmUw?=
 =?utf-8?B?RmpSdnFVWUNLZkZ2WkxXRFpZSjJJSkJENWt1aWI1eDdrM1NkaFFxRW5CQlo1?=
 =?utf-8?B?RnYrZ3NFTUdZZlNLWDl2QWVKNXAwUTZnRDJRbW8yUWRieEFUaW00Ymx2ZEFx?=
 =?utf-8?B?M2VMUFpNSXBsTSsrNWg3WmJjMlFReU5lWHNzd29mWjlQNDJRQVZobm9OcnIx?=
 =?utf-8?B?NThKVWdUS255bEIxREExVEhRRGI2V2NnYnBKaFZIN2d5VFZnd2RTanVEUmZa?=
 =?utf-8?B?eW9nVk5CYm52dGp3TnZYblBFTjhvT3U3cDZ4NG93UXNIUWpSWkZxZ3VBYTl1?=
 =?utf-8?B?VFVrWCtlYWsyRGprS3BDcUdxeUE4RmppZy80Z0NIVDIvVUltVnVlMlV3SnZU?=
 =?utf-8?B?VVpIbHJUVWNsNFZyVDQxOVRJYUVya2ZTajBHYUpkQ3IwdlpydVZrUG5rejUr?=
 =?utf-8?B?VjBjR2liZTFFdExjMUJvdC9sQzVTdW8zVUR0ZTg0SHlrM0VUVXJMUEg2WXpO?=
 =?utf-8?B?c0lGZzRlaGx4RnBaQ0RJeHZrT3hyZnlpSDVBekNmL20yaFdjVHEzdWdEQVlR?=
 =?utf-8?B?ZTViN2hqWDY4MmYwMStDMGpIRHQveEtXQjdrR0ZIbEtzZXlPS0NqVlFXRmsz?=
 =?utf-8?B?T2VMdjRKbnZneGxiaktqVWhHOFNTRnloWUtGUUtjUCtoZk83d28wZ0dHWXZo?=
 =?utf-8?B?RG5PL01QT1ZXUHFYeDZnRzVDTExvSllwR2ZMbFkzQVlDZXZ6Q0s0VUIrMkUr?=
 =?utf-8?B?QzVyU3ZRdFBMYWlmSEtlL2pHVEZ4TUVRekR4NEVHaS94VzVEWlN2RUZLVHRW?=
 =?utf-8?B?RGZuNzVqcFZBV0FDb0JLTkpxamFGOUNIY1BIcy9WY2R1cnFtZCt6NnNnbkFB?=
 =?utf-8?Q?GYwKJLJm/u0SNqCysR6SJmqIh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93e45b3-27b8-4f80-6a09-08dbf6abee71
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 22:37:30.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dvnLOiKLKVTpR/WK1idHvioAVN5jiNRv+x4l4YYW5lzjl2txKU5fY0+R2Io3MVl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/23 9:09 AM, Rob Herring wrote:
> On Wed, Nov 29, 2023 at 05:19:36PM -0800, Tanmay Shah wrote:
> > Add documentation for AMD-Xilinx Versal platform Inter Processor Interrupt
> > controller. These bindings are different from previous
> > xlnx,zynqmp-ipi-mailbox bindings and hence introduced in separate file.
> > However, same existing driver will be extended for devices that are based
> > on Versal bindings.
>
> Looks to me like the binding doc could be shared.

Hi Rob,

Thanks for reviews.

Next revision I will share bindings doc.

>
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> >  .../mailbox/xlnx,versal-ipi-mailbox.yaml      | 174 ++++++++++++++++++
> >  1 file changed, 174 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,versal-ipi-mailbox.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,versal-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,versal-ipi-mailbox.yaml
> > new file mode 100644
> > index 000000000000..4408b59d392d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/xlnx,versal-ipi-mailbox.yaml
> > @@ -0,0 +1,174 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mailbox/xlnx,versal-ipi-mailbox.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx IPI(Inter Processor Interrupt) mailbox controller
> > +
> > +description: |
> > +  The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
> > +  messaging between two IPI agents. Each IPI agent owns registers used for
> > +  notification and buffers for message.
> > +
> > +               +-------------------------------------+
> > +               | Xilinx IPI Controller               |
> > +               +-------------------------------------+
> > +    +--------------------------------------------------+
> > +  TF-A                   |                     |
> > +                         |                     |
> > +                         |                     |
> > +    +--------------------------+               |
> > +                         |                     |
> > +                         |                     |
> > +    +--------------------------------------------------+
> > +              +------------------------------------------+
> > +              |  +----------------+   +----------------+ |
> > +  Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
> > +              |  |  Registers     |   |  (optional)    | |
> > +              |  |                |   |                | |
> > +              |  +----------------+   +----------------+ |
> > +              |                                          |
> > +              | Xilinx IPI Agent Block                   |
> > +              +------------------------------------------+
> > +
> > +maintainers:
> > +  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: xlnx,versal-ipi-mailbox
> > +
> > +  method:
> > +    description: |
> > +      The method of calling the PM-API firmware layer.
> > +      Permitted values are.
> > +      - "smc" : SMC
> > +      - "hvc" : HVC
>
> The schema already says this, no need to do so twice.

Ok I will remove from description.


>
> > +
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum:
> > +      - smc
> > +      - hvc
> > +    default: smc
> > +
> > +  '#address-cells':
> > +    const: 2
> > +
> > +  '#size-cells':
> > +    const: 2
> > +
> > +  reg:
> > +    minItems: 1
> > +    items:
> > +      - description: Host IPI agent control registers
> > +      - description: Host IPI agent optional message buffers
> > +
> > +  reg-names:
> > +    minItems: 1
> > +    items:
> > +      - const: ctrl
> > +      - const: msg
> > +
> > +  xlnx,ipi-id:
> > +    description: |
> > +      Remote Xilinx IPI agent ID of which the mailbox is connected to.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> Any value 0-2^32 is valid?

No there are some limit on what is valid IPI ID. I will put valid range.


>
> Place vendor properties last.
Ack.
>
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  ranges: true
> > +
> > +patternProperties:
> > +  '^mailbox@[0-9a-f]+$':
> > +    description: Internal ipi mailbox node
> > +    type: object
> > +
> > +    properties:
> > +
> > +      compatible:
> > +        const: xlnx,versal-ipi-dest-mailbox
> > +
> > +      xlnx,ipi-id:
> > +        description:
> > +          Remote Xilinx IPI agent ID of which the mailbox is connected to.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
>
> Any value 0-2^32 is valid?

Here as well. I will put valid range.


>
> > +
> > +      '#mbox-cells':
> > +        const: 1
> > +        description:
> > +          It contains tx(0) or rx(1) channel IPI id number.
> > +
> > +      reg:
> > +        minItems: 1
> > +        items:
> > +          - description: Host IPI agent control registers
> > +          - description: Host IPI agent optional message buffers
>
> Same description as the parent? But the parent is not a mailbox (No 
> #mbox-cells)? 

Thanks. Yes it should say Remote IPI agent. I will fix this in next revision.


>
> > +
> > +      reg-names:
> > +        minItems: 1
> > +        items:
> > +          - const: ctrl
> > +          - const: msg
> > +
> > +    additionalProperties: false
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - reg-names
> > +      - xlnx,ipi-id
> > +      - "#mbox-cells"
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +  - reg
> > +  - reg-names
> > +  - xlnx,ipi-id
>
> Same order as 'properties'.

Ack.


>
> > +
> > +examples:
> > +  - |
> > +    #include<dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    amba {
>
> bus {

Ack.


> > +      #address-cells = <0x2>;
> > +      #size-cells = <0x2>;
> > +      zynqmp-mailbox@ff300000 {
> > +        compatible = "xlnx,versal-ipi-mailbox";
> > +        interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> > +        xlnx,ipi-id = <0>;
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +        reg = <0x0 0xff300000 0x0 0x1000>,
> > +              <0x0 0xff990000 0x0 0x1ff>;
> > +        reg-names = "ctrl", "msg";
> > +        ranges;
> > +
> > +        /* buffered IPI */
> > +        mailbox@ff340000 {
> > +          compatible = "xlnx,versal-ipi-dest-mailbox";
> > +          reg = <0x0 0xff340000 0x0 0x1000>,
> > +                <0x0 0xff990400 0x0 0x1ff>;
> > +          reg-names = "ctrl", "msg";
> > +          #mbox-cells = <1>;
> > +          xlnx,ipi-id = <4>;
> > +        };
> > +
> > +        /* bufferless IPI */
> > +        mailbox@ff370000 {
> > +          compatible = "xlnx,versal-ipi-dest-mailbox";
> > +          reg = <0x0 0xff370000 0x0 0x1000>;
> > +          reg-names = "ctrl";
> > +          #mbox-cells = <1>;
> > +          xlnx,ipi-id = <7>;
> > +        };
> > +      };
> > +    };
> > +
> > +...
> > 
> > base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
> > -- 
> > 2.25.1
> > 
