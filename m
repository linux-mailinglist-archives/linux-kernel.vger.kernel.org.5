Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958CA767F0B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjG2MPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjG2MPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:15:18 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3573E12B;
        Sat, 29 Jul 2023 05:15:17 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id BC43F420F1;
        Sat, 29 Jul 2023 17:15:08 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690632910; bh=t6O6r0my3q48G//1Zw6FmJEBbStmiUYLpvTOF1ZBdp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X+ZXQIz4sIkhwpOaTKW3W5xwx+c87U/xiMNYH+ry4mg9NQytmMnvez32Uh7gtbLjt
         My6BJ2VC4gURKlh0EgEin5434kgBY2Gtv/EEZKHSoFkYNvAiZVm+svlEacEWVwUoX/
         gC6pplxzuxggvyOUnJPorBm3ibBhNfoqFGIcM8/MdqkE8Ag1RYgqBwK02J82p7Bb6i
         C/qILfppzpvVkOm/ItIhb9p823igTUmKjFv6HFHDU3xW9uM2ooqxM1BHYedvaGp98Y
         ir1VCvDfqSNf4ZqpyjK54lMeLvroEqeUIxvAj5feikABvD7Q6KjKy8pR/wILVkbB28
         SIFj1CIiadEsw==
MIME-Version: 1.0
Date:   Sat, 29 Jul 2023 17:15:06 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Conor Dooley <conor@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: power: supply: Add pm8916 VM-BMS
In-Reply-To: <20230729-splatter-garland-495a414c323e@spud>
References: <20230728-pm8916-bms-lbc-v1-0-56da32467487@trvn.ru>
 <20230728-pm8916-bms-lbc-v1-1-56da32467487@trvn.ru>
 <20230729-facecloth-trembling-3311ca245505@spud>
 <25e933dc3f28fd73a9b76f172dacfdb2@trvn.ru>
 <20230729-splatter-garland-495a414c323e@spud>
Message-ID: <0b41a93ee82674e65a3801f5a37edd5a@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley писал(а) 29.07.2023 17:10:
> On Sat, Jul 29, 2023 at 05:06:14PM +0500, Nikita Travkin wrote:
>> Conor Dooley писал(а) 29.07.2023 15:03:
>> > On Fri, Jul 28, 2023 at 10:19:30PM +0500, Nikita Travkin wrote:
> 
>> >> +  interrupt-names:
>> >> +    items:
>> >> +      - const: fifo
>> >
>> > Same here, but do you really need a name, when you have only one
>> > interrupt?
>> >
>>
>> Hm, thinking of this more, the hardware actually has more than one
>> interrupt, even though this one seems to be the only really useful
>> one. Would a better way forward be to list all of them
> 
> Yes.
> 
>> (and fix
>> the driver to get the value by it's name)
> 
> It's not a fix to do that, the order of the interrupts is not variable,
> so there's nothing wrong with using the indices. You can do it if you
> like.
> 
>> or it would be
>> acceptable to leave the names here and extend the list at a later
>> date when (if ever) other interrupts are needed?
> 
> If you know what they are, please describe them now, even if the driver
> does not use them (yet).
> 

Thanks for the clarification! Will make sure both drivers have all
interrupts described in v2

Nikita

> Thanks,
> Conor.
