Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B934F7BE55D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377054AbjJIPt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376524AbjJIPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:49:56 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CA69C;
        Mon,  9 Oct 2023 08:49:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 606F8E0007;
        Mon,  9 Oct 2023 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696866592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sAgw6JmSJvT+dqBBnIW1pDl+6OyMUlGt9saFaoElUaI=;
        b=Eq+uU17wkxvKwqFJK280G81zvfK3zfB+2V5a9Ef0aioRCZBPEg2NqszZ72MF6RV3aicw7X
        GwehBz+sh4yTqoE3ebsPc3wAEwJ4S+7XCzHhU8McZ4au942SdW8teCtSqZdexW28M4iwnB
        TqVLhS9sR0Vk2U21N4kEerQ2CUdRSVJt78toroIlU9UGQDDhf7/hwnvvagcmxCTEPKih59
        wxMjZyB62iIEwmf0czMzpHEWjHG6TO/WFAZR1WK03YHHPC38FM6REWnkXOtOgpAssmc+lN
        /Chz6p2eHA2NAd6eNQ4IfoPoY+KPLCnSh40O3f85ckxnGswlmH+4UIopV891WQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 07/11] dt-bindings: mfd: syscon: Document EyeQ5 OLB
In-Reply-To: <20231006165438.GA4061751-robh@kernel.org>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-8-gregory.clement@bootlin.com>
 <20231006165438.GA4061751-robh@kernel.org>
Date:   Mon, 09 Oct 2023 17:49:50 +0200
Message-ID: <87h6mzbxsx.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Wed, Oct 04, 2023 at 06:10:34PM +0200, Gregory CLEMENT wrote:
>> Document Mobileye EyeQ5 compatibles for OLB registers that are
>> misceallanous SoC related registers.
>
> typo.
>
> Please state what OLB is and what kind of things are in this block. IOW, 
> convince me this is not just a skeleton placeholder until you add a 
> bunch of providers in a real binding.

I understand your concern. First OLB stands for Other Logic Block which
does not say much about it!

It is used to expose SoC specific configuration such as for example
reset, clock or pinctrl. We have a few series nearly ready to be send to
add support for them, each of them will use this block. So declaring
this block since the beginning avoid to have dependencies between these
series and they will only depend of this current initial series.

Is it OK for you ?

Besides fixing the typo I can add the following explanation to the
commit log: "It is used to expose SoC specific configuration such as for
example reset, clock or pinctrl"

Gregory


>
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> index 8103154bbb52..70bc6e8d15ba 100644
>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> @@ -53,6 +53,7 @@ properties:
>>                - mediatek,mt8135-pctl-a-syscfg
>>                - mediatek,mt8135-pctl-b-syscfg
>>                - mediatek,mt8365-syscfg
>> +              - mobileye,eyeq5-olb
>>                - microchip,lan966x-cpu-syscon
>>                - microchip,sparx5-cpu-syscon
>>                - mstar,msc313-pmsleep
>> -- 
>> 2.40.1
>> 

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
