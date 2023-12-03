Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52856802734
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 21:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjLCUM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 15:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCUM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 15:12:26 -0500
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3ECC0;
        Sun,  3 Dec 2023 12:12:31 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1701634342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iNJjh+X6J9Z2/8EV0arL00UpbZzQdKWDMWVJrQFp4PA=;
        b=ljIX4selP/ND8AJ6It0KkxBLOqBtyjfUs3s0T0C6UA8PdapcWO8fuZos8pLiUl3M7doWqt
        /V3Gz0oO6Ih2UIXol5JsGXO8vk003riVjOyRrAN+PVlz0hp0BlO4Ft9fddsrzin2+bA4t7
        xMp6H6/iz5K4jOThAsmVxrHzXL5ONg7OCm0clj6JmtpBJA8yEj0437Bc6a9uc+kyfyvbDM
        mRMHYfdiVuJz63EWuVpppTT0RNTqL/nA+M4FL35JgJDjKrEgZGb7LhhZsGm8mIvchOplBw
        yWchPPfzmaYRYzwb+xnNetndCxJqr4s8r1Kz+uNFwx8t7FkfAwXdJLYqk9NgAA==
Date:   Sun, 03 Dec 2023 21:12:17 +0100
From:   Dragan Simic <dsimic@manjaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] docs: dt-bindings: add DTS Coding Style document
In-Reply-To: <83b413441a953e8f2bc56adf09511a80@manjaro.org>
References: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
 <63ec18b2758a9e385f446fb00b60ee69@manjaro.org>
 <0bcc0679-b883-4435-8843-cc830122c0e1@linaro.org>
 <83b413441a953e8f2bc56adf09511a80@manjaro.org>
Message-ID: <7021717e2e747b9c119b7c5091b60bdf@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a brief reminder about my suggestions below, which seemingly didn't 
find their way into the v4.  At least the first one, which improves the 
opening sentence, is worth including, IMHO.


On 2023-11-29 12:37, Dragan Simic wrote:
> On 2023-11-29 11:43, Krzysztof Kozlowski wrote:
>> On 28/11/2023 21:00, Dragan Simic wrote:
>>> 
>>> I went through the language of the entire patch, after the notice 
>>> that
>>> the v4 would no longer accept language improvements.  My wording- and
>>> grammar-related suggestions are available inline below.
>> 
>> Thanks. I want to finish this at some point and it might not happen if
>> grammar fixes will be coming every patch revision. Then after we 
>> finish
>> review, new feedback will appear about using British or American
>> spelling (which reminds me old quote/email about which variant of
>> English is most popular in Linux kernel: the incorrect one).
> 
> Ah, that's a good one. :)  Basically, both English variants should be
> fine, but a single document should obviously use only one variant.
> 
>>>> +=====================================
>>>> +Devicetree Sources (DTS) Coding Style
>>>> +=====================================
>>>> +
>>>> +When writing Devicetree Sources (DTS) please observe below 
>>>> guidelines.
>>>>  They
>>> 
>>> The sentence above should be replaced with: "The following guidelines
>>> are to be followed when writing Devicetree Source (DTS) files."
>> 
>> Are you sure? It's passive and I was taught it is discouraged for
>> writing. See for example:
>> https://www.hamilton.edu/academics/centers/writing/seven-sins-of-writing/1
> 
> Hmm, you're right, passive voice is usually not the best choice.
> Here's my take two for the suggested replacement sentence, which is
> actually a simplified version:
> 
> "This document contains the guidelines for writing Devicetree Source
> (DTS) files."
> 
>>>> +should be considered complementary to any rules expressed already 
>>>> in
>>>> Devicetree
>>>> +Specification and dtc compiler (including W=1 and W=2 builds).
>>> 
>>> A definite article ("the") should be added before "Devicetree
>> 
>> ack
>> 
>>> Specification" and "dtc".  Also, "Specification" in "Devicetree
>>> Specification" should be capitalized.
>> 
>> It was.
> 
> Oh, sorry, I see now.  IIRC, it wasn't capitalized in some places, so
> I made a mistake here.
> 
>>>> +
>>>> +Individual architectures and sub-architectures can add additional
>>>> rules, making
>>>> +the style stricter.
>>> 
>>> "Sub-architectures" should be replaced with "subarchitectures".  "Can
>> 
>> A hint, you can write such review feedback as:
>> s/sub-architectures/subarchitectures/
> 
> Sure, but I specifically wanted to be less terse, as a way to be 
> respectful.
> 
>> BTW, my language spelling points "subarchitectures" as mistake, but
>> sure, ack.
> 
> Using hyphens or not is almost always debatable, but modern English in
> general leans toward not using them.
> 
>>>> +3. Unit addresses shall use lowercase hex, without leading zeros
>>>> (padding).
>>> 
>>> "Lowercase hex" should be replaced with "lowercase hexadecimal 
>>> digits".
>>> 
>>>> +
>>>> +4. Hex values in properties, e.g. "reg", shall use lowercase hex.  
>>>> The
>>>> address
>>>> +   part can be padded with leading zeros.
>>> 
>>> "Hex values" should be replaced with "Hexadecimal values".  
>>> "Lowercase
>>> hex" should be replaced with "lowercase hexadecimal digits".
>> 
>> ack, but that's quite picky. We are (software) engineers so we are
>> supposed to know the slang.
> 
> Sure, but this document is of a bit formal nature, so using slightly
> more formal language can only be helpful.
> 
>>>> +2. Nodes without unit addresses shall be ordered alpha-numerically 
>>>> by
>>>> the node
>>>> +   name.  For a few types of nodes, they can be ordered by the main
>>>> property
>>>> +   (e.g. pin configuration states ordered by value of "pins"
>>>> property).
>>> 
>>> "Alpha-numerically" should be replaced with "alphabetically".
>> 
>> Are you sure? Does alphabetical order include numbers?
> 
> That's a good question, which also crossed my mind while writing the
> suggestions down.  A more correct word would be "lexicographically",
> with something like ", with the already defined valid characters
> making the symbol set and the ACSII character set defining the
> ordering, " serving as an additional explanation.
> 
> This would be a rather formal, but also very precise definition of the
> applied ordering.
> 
>>>> +3. When extending nodes in the board DTS via &label, the entries 
>>>> shall
>>>> be
>>>> +   ordered either alpha-numerically or by keeping the order from 
>>>> DTSI
>>>> (choice
>>>> +   depending on sub-architecture).
>>> 
>>> "Alpha-numerically" should be replaced with "alphabetically".
>> 
>> Similar concern
> 
> I agree.  We could use "lexicographically" instead, with the precise
> definition already established earlier in the document.
> 
>>>> +board DTS, not in the SoC or SoM DTSI.  A partial exception is a
>>>> common
>>>> +external reference SoC-input clock, which could be coded as a
>>>> fixed-clock in
>>> 
>>> "SoC-input" should be replaced with "SoC input".
>> 
>> ack, thanks!
> 
> Thank you once again for working on this document!
