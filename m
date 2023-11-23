Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E9F7F60BE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjKWNsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345529AbjKWNst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:48:49 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BE91B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:48:55 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507a5f2193bso940286e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1700747334; x=1701352134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYJ9RINpWO/etmrdmn1FP6FlQ9EPAx5C4AtYkJeamEI=;
        b=cuNGAaXJmWlRWqjJena6EFfVjKGaTvWz50yhLoPjEGVBOVDyrKuDtQAO2HT57j7tHQ
         KnbtiC8F+y86KMXPGZ5Vz6Eoiee/j0izmlHp/DrfhkIZt/C+oCqtBUnsyWaiazNB7vaB
         GDhgUMMzUIG+wmW+QS0seAE97+h3JBUuvBJP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747334; x=1701352134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYJ9RINpWO/etmrdmn1FP6FlQ9EPAx5C4AtYkJeamEI=;
        b=Thltvn/uqedt7S8L4bMqv3f3s8vemJU8tXJY52lOMHse4FpOKEFdL8mLEzkedZkRIl
         tT8VS0Ya15eBV1MnHMZIoY4VbVUm20gyVsbmB/yKwHSeqz9CCTU2aWt4cCzM3235DTI+
         gM9/C7903ohQ6DwlL6trLBIerj4SRjfWCPPfXFNMqKeZfJVIHC3W4x4EdJwG98Xkqn70
         vaq4aihFqyZXFRyoZJwx7cT9vBRiAEZRUAoVdTlUFQohrmOR0Y5/NZsd8WgJs0rb/yCU
         5PV0PmtqyN9sXUSTxftXG1mpzecxwLuqK0PCi/5MW6CwQ0DmEMXTmKL/kIAADjj1AzOd
         heVw==
X-Gm-Message-State: AOJu0Yzxf3T4LFgD5Jzs+vOTQ23DBG5RJ3O208NH9HOG1B8pLhMsiU9B
        961mFDjIuh0q+8etSekwa6tucA==
X-Google-Smtp-Source: AGHT+IG4CVoPRUAn77ky2ffnCHCPrIVvxiwyxMrF5VOgYS9HaFefUSItqzrdzQkf09aJ01Bo2N1g3g==
X-Received: by 2002:a19:7512:0:b0:50a:a31c:39b1 with SMTP id y18-20020a197512000000b0050aa31c39b1mr865785lfe.9.1700747333878;
        Thu, 23 Nov 2023 05:48:53 -0800 (PST)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t6-20020a056512068600b005094486b705sm199933lfe.16.2023.11.23.05.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 05:48:53 -0800 (PST)
Message-ID: <b8df5f0c-a3cd-4cad-b1c6-db89686464fc@rasmusvillemoes.dk>
Date:   Thu, 23 Nov 2023 14:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Content-Language: en-US, da
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Peter Rosin <peda@axentia.se>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <e731c0a9-7a5c-41c3-87aa-d6937b99d01a@rasmusvillemoes.dk>
 <20231123103802.GA30056@wunner.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20231123103802.GA30056@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 11.38, Lukas Wunner wrote:
> On Thu, Nov 23, 2023 at 11:07:16AM +0100, Rasmus Villemoes wrote:
>> On 22/11/2023 15.53, Lukas Wunner wrote:
>>> But if that patch gets accepted, we'd have *three* different modes:
>>> RS-232, RS-485, RS-422.  A single GPIO seems insufficient to handle that.
>>> You'd need at least two GPIOs.
>>
>> I don't see Crescent introducing any new gpio that needs to be handled.
>> In fact, I can't even see why from the perspective of the software that
>> rs422 isn't just rs232; there's no transmit enable pin that needs to be
>> handled. But maybe the uart driver does something different in rs422
>> mode; I assume he must have some update of some driver, since otherwise
>> the new rs422 bit should be rejected by the core. So I can't really see
>> the whole picture of that rs422 story.
> 
> The question is, could we conceivably have the need to support
> switching between the three modes RS-232, RS-485, RS-422.
> If yes, then the GPIO mux interface should probably allow for that.
> 
> As a case in point, the Siemens IOT 2040 has two serial ports
> which can be set to either of those three modes.  The signals
> are routed to the same D-sub socket, but the pins used are
> different.  See page 46 and 47 of this document:
> 
> https://cache.industry.siemens.com/dl/files/658/109741658/att_899623/v1/iot2000_operating_instructions_enUS_en-US.pdf
> 
> The driver for this product is 8250_exar.c.  It's an Intel-based
> product, so no devicetree, but it shows that such use cases exist.

OK. I did look at the mux-controller/mux-consumer bindings, but couldn't
really make heads or tails of it, and there aren't a whole lot of
examples in-tree. Also, the C API seems ... not quite what is needed
here. I realize that's not really anything to do with the best way to
describe the hardware, but that, plus the fact that the serial core
already handles a number of gpios controlling circuitry related to
rs485, was what made me go for one extra gpio.

How would a mux-consumer description look?

  mux-states = <&mux 0>, <&mux 1>;
  mux-state-names = "rs485", "rs232";

or should that be mux-controls? Would that be enough so that we're sure
that if and when a rs422 state is needed that could easily be
represented here?

Now implementation-wise, there's the complication that switching the mux
to/from rs485 mode must be done after/before the driver's ->rs485_config
is called, to avoid the transceiver temporarily being activated (thus
blocking/disturbing other traffic). That plus the need to mux_*_deselect
the old mode means the consumer (serial core in this case) ends up with
quite a lot of bookkeeping, and even more so taking error path into
consideration.

Rasmus

