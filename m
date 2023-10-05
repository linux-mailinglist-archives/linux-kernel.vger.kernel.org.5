Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C673A7BA268
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjJEPfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJEPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:35:00 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2ED7E215;
        Thu,  5 Oct 2023 07:52:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DFD4C0019;
        Thu,  5 Oct 2023 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696517512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HdkjYjuKh7Ji4lb7KqXewrgDVwOnf7O66EhYWKJOBkM=;
        b=l4UMpspOAJhsvhsVbcCxJS7ZbEOg0kNwnb/vJ5QBBFofMvJV+z60lKL2SaONi8OJY2GQwR
        APR72vTtKaVR8zGdkncyRWihT7qV58yyfrljkOR/QB+oufMAMBCv/RVcHKdciNw7OLx/4v
        Mvm5HOsAHJyTqVbfzLZ+JLNY968YIGwZVSDOAJeaN9Xyk+Sq1jB2wZ7jUpBHsQrDGkKJ5C
        nIWDyl+eKfYNTau2WF/2m6CPwQZa+FosdxnJNMiWYBPngf+RK8sBcJb6lI/guoxjLJXWXc
        x4m7CHftYsP7kz59YiVhOETk4Hke2u/BAb3Xqeq63nB4V2XyRn0xe8lnSvuWpA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 05/11] dt-bindings: mips: cpu: Add I-Class I6500
 Multiprocessor Core
In-Reply-To: <hu5ksk2gw7zbbeiwi4unfo242qm2wfn36bpgea5inlamn4kqrf@magwi4w7gp3x>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-6-gregory.clement@bootlin.com>
 <hu5ksk2gw7zbbeiwi4unfo242qm2wfn36bpgea5inlamn4kqrf@magwi4w7gp3x>
Date:   Thu, 05 Oct 2023 16:51:50 +0200
Message-ID: <87sf6pcebd.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Serge(y),

> On Wed, Oct 04, 2023 at 06:10:32PM +0200, Gregory CLEMENT wrote:
>> The MIPS Warrior I-class I6500 was announced by Imagination
>> Technologies in 2016 and is used in the Mobileye SoC EyeQ5.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
>> index cf382dea3922..87fd2842ba68 100644
>> --- a/Documentation/devicetree/bindings/mips/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/mips/cpus.yaml
>> @@ -39,6 +39,7 @@ properties:
>>        - mti,mips24KEc
>>        - mti,mips14KEc
>>        - mti,mips14Kc
>
>> +      - mti,i6500
>
> Since the CPU core vendor is Imagination Technologies thus it would
> be more appropriate to have the "img," prefix. Wouldn't it?

According to Documentation/devicetree/bindings/vendor-prefixes.yaml

"^mti,.*":
    description: Imagination Technologies Ltd. (formerly MIPS
    Technologies Inc.)

So I think it's OK.

Gregory

>
> -Serge(y)
>
>>  
>>    reg:
>>      maxItems: 1
>> -- 
>> 2.40.1
>> 

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
