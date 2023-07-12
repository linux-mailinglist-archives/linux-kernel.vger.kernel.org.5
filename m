Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBD67511CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjGLU2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGLU2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:28:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D375EAC;
        Wed, 12 Jul 2023 13:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 584E86190E;
        Wed, 12 Jul 2023 20:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D182C433C7;
        Wed, 12 Jul 2023 20:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689193721;
        bh=876vMbdDchntAjuToedm5xOzqNo7Ul0MnYeWWTPdCMY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eACfpRiSuGFNCoKwHUokCNLHShdTqUaEB+yMCm7UodrZnAWyb7kRAGYvG6KlYUDbv
         rDl1Up2Vy9PWNfTaIIcUB6IrXQ4zUdbsCZZUs/s+nmYGC/Gvr2b9nQ8Ysnxl2l1xhz
         ExXxkoXpDMqS1KBlwTe9yU3BTZ29tp5H0WoWuXg6TFV6wwRusqzIMo1fBfZn9oHmZT
         f0QYpk700Sb5x7hEM59rBSw1WvJsf7hriq9NVeV4tsv2TkzFkRN3w4TlwrhpAk/KUF
         Tge3u9Audc6b+N8Ea5awJtdxVlLWvebui2j3Vj6hxjZBXCc5nxitFop6B/mjMRJdz0
         4Py4QeqjGhFtQ==
Message-ID: <b8e21ba1-900d-6731-579d-e18c37a97a71@kernel.org>
Date:   Wed, 12 Jul 2023 22:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8916-samsung-serranove: Add
 RT5033 PMIC with charger
Content-Language: en-US
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230619203743.8136-1-jahau.ref@rocketmail.com>
 <20230619203743.8136-1-jahau@rocketmail.com>
 <02fe7c1e-cb6a-14bc-73fc-04956a2b8396@kernel.org>
 <3376e14a-4fc7-160e-509e-8dcbe627ef62@rocketmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <3376e14a-4fc7-160e-509e-8dcbe627ef62@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 21:50, Jakob Hauser wrote:
> Hi Krzysztof,
> 
> Cc: Rob, Chanwoo & MyungJoo
> 
> On 11.07.23 08:13, Krzysztof Kozlowski wrote:
> ...
>> This appeared in today's next next-20230711 and causes new warnings
>>
>> msm8916-samsung-serranove.dtb: extcon@14: 'connector' does not match any
>> of the regexes: 'pinctrl-[0-9]+'
>> https://krzk.eu/#/builders/90/builds/40/steps/17/logs/stdio
>>
>> The commit mentions rt5033, but that is not the schema being here
>> tested, so clearly this is wrong or bindings were not updated.
>>
>> Please fix (and test your future patches).
> 
> The implementation you see in this patch follows the guidance of yours 
> and Rob’s. I already expressed my discontent about it before.
> 
> To solve the message, the dt-bindings of extcon device sm5502-muic [1] 
> would need to be changed to allow a "connector" sub-node. That’s not the 
> right approach.
> 
> I still have the impression that the current implementation is based on 
> misunderstandings. I do think Rob’s comment that excon phandle being 
> deprecated [2] is valid for the USB subsystem. Your suggestion to check 
> "ports graph", "orientation" and "usb-role-switch" applies to USB 
> subsystem as well [3]. Rob took the time to add more explanation [4] but 
> it’s still about handling connectors in the more strict sense, which is 
> circling around UBS subsystem.
> 
> These discussions led to a strangely mixed-up result. I was pushed to 
> implement the USB subsystem connector approach upon an excton subsystem 
> device. As the standard USB connector approach didn’t fit, we switched 
> to a vendor-specific connector phandle [5]. In fact it’s kind of a 
> workaround for the extcon phandle.
> 
> The extcon device sm5504 is a real piece of hardware. It’s not handled 
> by USB subsystem but by extcon subsystem. The excton subsystem has a 
> method implemented to get the device by phandle [6].

I am not sure if we discuss the same problem. My email was about the DTS
and bindings, not whether this works in Linux drivers. From your reply I
feel that this patch might actually not work? This would be quite
confusing...

You added new child node "connector" to the siliconmitus,sm5504-muic, so
all I would expect that we miss here only updating that binding.
Assuming that your code was working...

> 
> I therefore propose to use the phandle of the extcon subsystem.

extcon in the bindings? Then we would be back to square one.

> I mean 
> extcon subsystem, not USB subsystem. In case you disagree, I kindly ask 
> you to take more time to answer in more detail and especially 
> case-related.

Assuming your patch works, I think above is quite specific answer - new
property is missing in sm5504 binding.


> And specifically to Krzysztof I ask for more politeness in 
> your way of communicating. I understand you’re answering hundreds of 
> requests a day but the communication we had in the past weeks is really 
> frustrating.

Sorry to hear that, please accept my apologies. I went through all my
replies to you in past few weeks and could not find any particular
impolite behavior from my side.

> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml?h=v6.5-rc1
> [2] 
> https://lore.kernel.org/linux-pm/cover.1677620677.git.jahau@rocketmail.com/T/#m1f57a36d534e677f84158e6886c1340e036ab5c6
> [3] 
> https://lore.kernel.org/linux-pm/cover.1682636929.git.jahau@rocketmail.com/T/#m7672ad05590e4123ba5622bc59a9b4dcc0f70e3a
> [4] 
> https://lore.kernel.org/linux-pm/cover.1682636929.git.jahau@rocketmail.com/T/#m65db0709f0ad3feac6c289f65be5a351cacd2835
> [5] 
> https://lore.kernel.org/linux-pm/20230506155435.3005-1-jahau@rocketmail.com/T/#m2aa652c41bad93d60042d831c6397e7838d3cbfc
> [6] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/extcon/extcon.c?h=v6.5-rc1#n1417


Best regards,
Krzysztof

