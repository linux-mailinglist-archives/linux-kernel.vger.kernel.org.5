Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1568B7BBEA2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjJFSYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjJFSYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:24:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2098C2;
        Fri,  6 Oct 2023 11:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWakINuh19Sakc3u5JfFpIQCzJ8/ainMCeQqZcEiXmqwAAtiq3RcEdjhiHcsOagMV1Ms+iel6mLYJjY+atkcyO9+ns+B3AzZy/1+XaDb0zaw1SlbhbRuFM4WNod1G053oMwCzOaMWQYuz3EIi97oc7yWCiNpEZddGcDksnk46I6uQcs4qL4x5TpYIchSdEEet/5NFVbK+U54R/P44Oobp8XHqM84e5NoI4NQOf6krqEtqQJadRC+4QV0oSoWo53ybP5jgd15gEGdo58dM8ythW0/jO7kClnbqASqvUpyS9/NRaz2+2OFdiQxP/3sLNUJPU9eqY0tHV0QcpZF2jzSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k1FDFL0IIbqh0oPdF7xZEKzNU3VqaS5Es7s01Wbl6E=;
 b=X9B6CAk1HJmt6FNAPiRYzazrM+TnNxVjkFxYlEHxPFOjeevmxBJtEHurNpTTPF8OjlE+tLewjliHdRbeTKq7JTjOeMscUoWjFiVdY6edmIRvCDPrggOKAWg+EoZm1WcXqWX5cLQ+tcqsogiY6j0ELdcb7FQsigPJBPrkFaJlnvQ1IGMKTVoSC2CC2IprIKszCNzDoPxcu+H7kZhxeY0yaOydaymT7L7aeDCLGSG/AavfD8nIm4GLasa7mutHK/guLhBwNcJaVayECQy//9Du5Ztg68M/tj0KJd8og9r2WipZMPxe3F86hWOxzfKhc/VQlN7gIi2FPVtU00cuvMbJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k1FDFL0IIbqh0oPdF7xZEKzNU3VqaS5Es7s01Wbl6E=;
 b=y9WvyswBEox7jL4cG1nj2X//ad8RQfOZf/wnWb/kmVrNaJV//ao3aNZ7eKv7Bj0sJARNAkZu92/jFbYMs3wwcqmdltrSKdYlGI+oOuj12ibTFy2yXgvr8ZSOnU/6K1Lq3isc/xmhf5hxvnFgvE9zsQiPjmwM7xjiaWfPUubtgVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.42; Fri, 6 Oct
 2023 18:24:09 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::8304:46bd:5017:3dcb]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::8304:46bd:5017:3dcb%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 18:24:09 +0000
Message-ID: <cd1e8583-67a5-4b50-b1bb-304d14d3c170@amd.com>
Date:   Fri, 6 Oct 2023 13:24:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: zynqmp: add destination mailbox
 compatible
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com,
        shubhrajyoti.datta@amd.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231005170825.3521669-1-tanmay.shah@amd.com>
 <20231006175348.GA4076821-robh@kernel.org>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20231006175348.GA4076821-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::26) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f8dc21-dafc-409d-6938-08dbc6996e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5uBzHmlJCiSfd0g0wVqCC7pogMIbU1DB7BYiP81YND6sFeDooR4nDsjm+hhG8bVKCtXNKaF/sqy3erDvGC3b5+L6kwnY1BftXYpmjbpPnpUB/xeiyNdQ5Vm0ep6lfqwW01Tm1ht8eIQz/HK+9XCRkPs73RF12hLjjOxTNxyg1qkOALeKRYqCMaSttbCKar4mT3fPggRkJsB61obtNHo9FCXEj1SOkaj6PivyzizE4bJhAoJKx3A4X70l+86qB1s/TOHau4+IvEvuxK83B07zcLWX8LKLfyWFEmliOYw0JITdpTmMGfIckgdo/IzMxHeFeOF/E8ht25i4shCz5B8XMXY/7sgcHfkr0mlQP8NA4UJFwncNZUnftvYaf0BKzI7cLS8yR2uIlcKIy2N3R0CvDuzCUe24hR5wRnDVROK3wCuutSe8iPifyBVaQi2TlmqO7pFQmHyzZUfyEcrvGpaoJt8NXMINsN4BobQZ5yqKCNvb+v7LFrrAFPjFL8OGpqDmrYpo2/XzI6r0blbxp78T1o+F7NhkacK9vJOgiRLW+UCtI9rLHiv+4h+LSP94ZdlYWw4Yo4RlrrTx5KW1o4HgZs0OH5X77hE3gtm4HYMMXJS34Bl3Hq07ERGdUwpBnKXQDm56+AMqLAcxBMdSxIWdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(6486002)(6506007)(6512007)(6666004)(53546011)(15650500001)(2616005)(26005)(83380400001)(2906002)(6916009)(5660300002)(4326008)(44832011)(8676002)(316002)(66946007)(36756003)(66476007)(66556008)(8936002)(41300700001)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2tPUHZDcU9ycnBCUnF2WkpmeW5GYW9haHBwUVdOWG9LYm92alV5UTBVUFN0?=
 =?utf-8?B?WGlCWlRjNU1BNjYvMUtGM1c2WFNycWdHcU1FbURMaFpwdnBwZlhrY1BKZ01O?=
 =?utf-8?B?QWtOcUNmenU2S01Mc0FpSTRWbXgzRDBnSXh1OWduZUdRNnRlamZqcjJrek95?=
 =?utf-8?B?a0wyeW92cEJKZFd0aVJYTStVQ3psWTNJbHp0ZTVpZXplK0tsWkp4bDhxUXJ2?=
 =?utf-8?B?ZGIvZm14amg3RGp1R2R4TFpub0Z1MWorNFZTU0t4NTFwcWZFcCtPc0dLV1Ay?=
 =?utf-8?B?QklFYktOaE1PZ0k4Z01xM3NhMnFrb2hwZTlWRGY4MUpFRHFRdmE0bFMwWUVy?=
 =?utf-8?B?TGRJTXRLeG1JMTBKczdtOE5tMHlJTkZUK25LWFI4a1RLY0s3KzFwV3F0aFpW?=
 =?utf-8?B?OHJ1UGltZG45WFpoVjY1K29kOHduclhqUVN1OVFLYUVSWDY1clJ1ZVZreVBy?=
 =?utf-8?B?aDdLVmpXRWM2a1h2am9ZSm9jUnhlbnhmVVMzd0MxZnpNalE2bHRSQWQ5YTl4?=
 =?utf-8?B?OWJ6Y1FhM3JpcUgyM0pxUm54U2ppQmo2ZGw3czQ3NFQ1VzVWaFFQOHZzU21L?=
 =?utf-8?B?VGFBWDNXTjhiQ1czL0dxL0tqSHVRdEd5WHdvU2xyYk42ZWFIdkJXeVd0WVpG?=
 =?utf-8?B?T3dkTmQ1cHdmamZaTWV2T3VoK2lGU2ZLL24vL2dzL1dIa0ExaXc3aWJDOWNt?=
 =?utf-8?B?bXRjRjNBekVKbUVJRmlTNG80bXF4ZXcxVmVHaWx5S3FvLzEvYm92TG0yTS9v?=
 =?utf-8?B?Zm5SZWV4UTNzclJVTlBVcHZlcUNwcjdlbDNueHFkcTVuQUZpVEtLRHNaYnlj?=
 =?utf-8?B?bklJTzFLQTlPbWFNai9IczRlQ1VKbWtxeFVnbEwzUmJ5bE5oRUhGYUxTUzhF?=
 =?utf-8?B?bWNzSmtiZGlWRHZXOSsrWTZXL21vNi9wWVhaV25KdXE3eWNPcDVQNHpOakJV?=
 =?utf-8?B?WUhtMHhjVjJCRDhVdE5uWGJWTHl2ZitHeFhzUEZtajNBSE15cHVjbWx4TzBR?=
 =?utf-8?B?UXYwekJLRllPRmdxUGNqUWVxSWRYdkhNQ250Z3dUbXprcllsV2NlOXhZb2cw?=
 =?utf-8?B?b3VyOW5MbXhrdTVGZm4xTlljY2F0UlRzMjZndnZpYlNTSDVzOWgzSVFycUJP?=
 =?utf-8?B?dzRyL3MwemhKQmEzRXNDZ1dFOHI1OE54Q3NySE1xVXJjUHo5R0dFdHd5OVJ2?=
 =?utf-8?B?MytCdFpJOFVCRXVFU25qb1VqMFU0QkwxU2IwZ3ZaVi80K24zOEdTdHRiMlVa?=
 =?utf-8?B?QW40UkszUDFZMCtNMjNPY2hrQU1NQzFGWGpJU0JpWkl5b1JCcmc1UVlTVi9K?=
 =?utf-8?B?OUxPU0dzem9uaHNCNGpOUTZucjRqSGVOSkdQQ1FDckptWkg4M0FueSt3N2Rr?=
 =?utf-8?B?MHNWcmNITWFnTml2dmlVc1ljZ1dmc2d6VVBHTDVyMnhuQXdiSjFzUFdRR1Qr?=
 =?utf-8?B?V1g3ZGx5c1d2bXJ2c0lWRUpDb2sreXhyZ3gzN1U4RFYxOEFqZFRnT0RZbGZQ?=
 =?utf-8?B?NXV1R05STDYvc3FZdThINlNyaU5UK2VSSTBvRllrcGRhUEZDV1VmMnF0aGZm?=
 =?utf-8?B?UUtOMGo2MGNxZDhWM3V5S3h2em5KUXBzK3VBanhteGxINVhVeVNHWERQeUZH?=
 =?utf-8?B?RmFXdDJMYmc5WHdSUzZpZ1NLL05vRE1ZUjJWU0pSMjhGY1lXeDhoQ0NYNEdL?=
 =?utf-8?B?aFY0ZnYzV0tyWHFJa1MwMTZVTDdZL3hHZGQvUjhiSE40d01kK0Q3Z095cWZF?=
 =?utf-8?B?Mm9pdTVTaGIwM3B0RUZUekNJRGlsMlZGRWFqWFJtaXJmNHhQZ3Uvdzk5K3ZE?=
 =?utf-8?B?eGtmaE9UdDRuUXRPVUcrS3NWMktuWlNrc1N1RzhTcEQ3REVVRnJSNVlVdEhm?=
 =?utf-8?B?YnN5U1pFU1cyVWVMRzQyVXNCb2s3ODdQLy9yR2xSc21WR0RodXl3RjB1NXhL?=
 =?utf-8?B?TDBmNVZ3YVBkNHdpTlJIUDd5UzBLOXRGSUZTeHFKZGJ3cloyRDV0VzAzd2U0?=
 =?utf-8?B?ckF3NFBSeHBSVWJZUmFPdUc1R05EMFduOGkxTERDdW81NnlmUXNtZm83aHpV?=
 =?utf-8?B?T25JOTFCRWtUYSt5ZWYwZElLUHdPOUkzbHloUGFWTFRaNmpIZmR6ajdvVGlr?=
 =?utf-8?Q?PlvIFr4zisY/MBwME1s49ojlA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f8dc21-dafc-409d-6938-08dbc6996e54
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:24:09.1125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcocV7HnSnEKHC337tNzaY/PZF4YZwO16WoCIwLoQswxKbrDx/L0+dBSH2fq+YY2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/6/23 12:53 PM, Rob Herring wrote:
> On Thu, Oct 05, 2023 at 10:08:24AM -0700, Tanmay Shah wrote:
> > Current dt-bindings does not contain compatible property
> > for child mailbox node. Child mailbox nodes are used
> > to represent destination (remote) IPI agents. The compatible
> > property for all destination mailboxes must be required.
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> >  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml           | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> > index aeaddbf574b0..8b15a0532120 100644
> > --- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> > +++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> > @@ -74,6 +74,10 @@ patternProperties:
> >      type: object  # DT nodes are json objects
> >      additionalProperties: false
> >      properties:
> > +
> > +      compatible:
> > +        const: xlnx,zynqmp-ipi-dest-mailbox
> > +
> >        xlnx,ipi-id:
> >          description:
> >            Remote Xilinx IPI agent ID of which the mailbox is connected to.
> > @@ -95,6 +99,7 @@ patternProperties:
> >            - const: remote_response_region
> >  
> >      required:
> > +      - compatible
>
> A new required property is an ABI break, but nothing about that in the 
> commit msg.


Hi Rob,

Thanks for reviews. This does not break backward compatibility yet as

relative zynqmp mailbox driver isn't expecting compatible property.

But, any new functionality should consider using it.

I will explain this in commit message in next revision. Other than that, I hope it's

correct to add such compatible property to identify the node.


Thanks,

Tanmay

>
> >        - reg
> >        - reg-names
> >        - "#mbox-cells"
> > @@ -124,6 +129,7 @@ examples:
> >          ranges;
> >  
> >          mailbox: mailbox@ff9905c0 {
> > +          compatible = "xlnx,zynqmp-ipi-dest-mailbox";
> >            reg = <0x0 0xff9905c0 0x0 0x20>,
> >                  <0x0 0xff9905e0 0x0 0x20>,
> >                  <0x0 0xff990e80 0x0 0x20>,
> > 
> > base-commit: 7d730f1bf6f39ece2d9f3ae682f12e5b593d534d
> > -- 
> > 2.25.1
> > 
