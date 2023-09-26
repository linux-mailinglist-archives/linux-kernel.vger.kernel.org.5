Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427CB7AF54D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjIZUgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjIZUgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:36:35 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F165411D;
        Tue, 26 Sep 2023 13:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695760583; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=roJkjRPytFe+ilRPDRBnAwnfATFMlU6JKNGkPnkXDJbldCHMQIew/MqqE9SPzYb4ar
    VePz7nWkWd1AvQV5JdmD0b3ZDO0dStQcJBGFWdG6risllwSnLfKj6bW06EaperZ85856
    xnoBggYGThfb1THQTTkUxzaycaLKZMZU9Un7DNqtzMB4/gVw2D6PTTSZOD0f40U1h3p8
    GWH3TWUCE6XhEYydjXvoEGORq3rS9f8ixYxlL6McJPvGPeukHPbQWxpjrSNp1z6JO00A
    3M3601IfDbftsqMMklJvLIQXyY2dY7CTvjG+UO8DCihSBUEaqpFFlykRqiFoEuwZNi4y
    HT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695760583;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=OJrtho2IVaxqErbZWEznLM2Z5nnZpsNCEW0/xMDGh5o=;
    b=MGyIvS9j+Q++hoqb5muSnWVf3OJ5838/pfiuB5vPN55GpZUmE+LfQoWdCaCnv3I6Fr
    NimjOCMgzCN00gQBaunS7M6CPCj8MQ0rDpwAl4VvzCAU9pNY+uwXFB9dG0ykPCVDEj+W
    BUUtp5wfLRy0gMmK4gL7jEF6S7syEzO0jsFoJn/PxtyD35LmJdYDQGIvVg8IDvkPEMM2
    DxVgQWEazAWLEHlXrv3NGUmzeFj3ywlZxWkfVJKK0VhBZsOvf8Gdc/tCDJly/hsFaSV5
    EQEMplmotGErQzU6hYRO8Id4mL3GVyIo2z1vD6QNc1n6cPO9DT7taCdaIgO1CI5f5MJe
    /NGw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695760583;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=OJrtho2IVaxqErbZWEznLM2Z5nnZpsNCEW0/xMDGh5o=;
    b=M0/oHz7yATE3swJ4RIi+YsO6iOqPBQrgnobuxAWgbxZ53Y3vnPpOTHnFdwtzrRIQkq
    qEH/Dbjprh0z8DwP5b+KR4GUMIdTTktNxaKm8fA6lFFYHft4BRZkY2K9UraQd75le3/a
    GYlnu6oaETd/yZtQwvnqWvriShnEQJ+N3rG50uAzRLqj0yyzTlxRYS1qGzMMD0gBLX4S
    cot6Lz7yTtD7qFNq5uFWNfjf4NI623hZiXCh3PwB9qtEwxKHk1BUK3TOEgiSk8VyQFPV
    De9Qo3esLP4CR2XnrOzTVXWAh40BmdjFmvWAH1RMqAHUI/XUQSGTJHYMP85j/Dg79b0w
    ynoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695760583;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=OJrtho2IVaxqErbZWEznLM2Z5nnZpsNCEW0/xMDGh5o=;
    b=IticiGBVOhZeFF0AUEGfJwYNVp30y32eUCcGu4HX01JJUV8Sx026X9WI21ryqNIK04
    XlE44b3l8fFwb1lxsDBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QKaNgTq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 22:36:23 +0200 (CEST)
Date:   Tue, 26 Sep 2023 22:36:16 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: Re: [PATCH 04/13] arm64: dts: qcom: msm8916-samsung-a2015: Add sound
 and modem
Message-ID: <ZRNAwO-f2dpNJs5x@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-4-398eec74bac9@gerhold.net>
 <2c9eda54-a90e-483a-abc2-865d82854b80@linaro.org>
 <ZRMwdRo9hAm4BO5E@gerhold.net>
 <278ac134-992e-460a-b37a-60a746eab107@linaro.org>
 <ZRM6dJXNvx93jFrM@gerhold.net>
 <9b9a9c0d-8a09-48a4-b996-554d7e1b9340@linaro.org>
 <ZRM-u3gIoOsHVp7c@gerhold.net>
 <4d8292ca-c5fe-4270-8d93-66b721903528@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8292ca-c5fe-4270-8d93-66b721903528@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:29:29PM +0200, Konrad Dybcio wrote:
> On 26.09.2023 22:27, Stephan Gerhold wrote:
> > On Tue, Sep 26, 2023 at 10:18:22PM +0200, Konrad Dybcio wrote:
> >> On 26.09.2023 22:09, Stephan Gerhold wrote:
> >>> On Tue, Sep 26, 2023 at 09:56:12PM +0200, Konrad Dybcio wrote:
> >>>> [...]
> >>>>
> >>>>>>> +
> >>>>>>>  &blsp_i2c2 {
> >>>>>>>  	status = "okay";
> >>>>>>>  
> >>>>>>> @@ -243,6 +258,13 @@ &gpu {
> >>>>>>>  	status = "okay";
> >>>>>>>  };
> >>>>>>>  
> >>>>>>> +&lpass {
> >>>>>>> +	dai-link@3 {
> >>>>>>> +		reg = <MI2S_QUATERNARY>;
> >>>>>>> +		qcom,playback-sd-lines = <1>;
> >>>>>>> +	};
> >>>>>>> +};
> >>>>>> Is that not status = reserved?
> >>>>>>
> >>>>>
> >>>>> Correct. This is here to simplify switching to the modem-bypass audio
> >>>>> routing if someone does not need (or want) the modem. The direct audio
> >>>>> path with the LPASS drivers tends to be more reliable and configurable
> >>>>> (especially wrt bit formats, sampling rates, latency, channels etc).
> >>>>> I know that at some point this helped someone who tried to use an old
> >>>>> phone as some kind of portable musical instrument / synthesizer.
> >>>>>
> >>>>> It's not too obvious that these definitions would be needed when making
> >>>>> those changes (because devices using the standard SD lines (i.e <0>) do
> >>>>> not need it). If you forget about this you get non-functional audio with
> >>>>> no error or any hint what could be wrong.
> >>>>>
> >>>>> To simplify switching between the different audio routing options, the
> >>>>> lk2nd bootloader actually has an option to do this transformation in the
> >>>>> DTB automagically during boot. It's sort of like a DTB overlay that
> >>>>> disables the QDSP6 audio path and enables this node instead. The DAI
> >>>>> links are also adjusted where necessary.
> >>>>>
> >>>>> Do you think a comment would help here?
> >>>> I'd say a comment would be necessary here :D
> >>>>
> >>>
> >>> No problem, I will try to add something simple.
> >>>
> >>>> While I understand this use-case, I believe this is better suited
> >>>> for an actual DTBO or something entirely kept inside lk2nd.
> >>>> Otherwise this looks very confusing to an outside reader.
> >>>>
> >>>
> >>> Translating from the QDSP6 audio setup to the LPASS one is mostly simple
> >>> but not entirely trivial (especially the patching needed for the DAI
> >>> links). Main blocker for DTBOs is that you can only add or change, but
> >>> AFAIK there is no mechanism to _delete_ or fully recreate nodes.
> >> Correct.
> >>
> >>>
> >>> I guess I could maybe derive this from the QDSP6 definitions using
> >>> custom magic code, but the code complexity for that is much higher than
> >>> adding these nodes here for completeness.
> >> I hate to be the bearer of bad news, but this is probably more
> >> of a "do we reasonably want this upstream" type question, as
> >> you'll probably get some grumpy emails about upstream not caring
> >> about what's outside the mainline tree..
> >>
> > 
> > IMHO this is hardly a "downstream" type of situation. The whole point of
> > the magic in lk2nd is to make the life for the mainline code base easier
> > and simpler, while still allowing the "bypass modem audio" feature with
> > an unmodified kernel.
> > 
> > Before implementing it like this I used to have this directly in the
> > kernel tree, by duplicating each device into a normal XYZ.dts and
> > "XYZ-no-modem.dts". If you apply this to the total of ~45 different
> > MSM8916/MSM8939 DTBs I would like to get upstream this options gets
> > extremely ugly. :'D
> Maybe a kernel module parameter could be somehow useful here?
> 

Maybe, but ultimately this affecs multiple modules that do not
necessarily know about each other. You need to enable the &lpass node
but also adjust the DAI links in the &sound node to refer to the lpass
DAIs instead of q6afe/q6routing. Implementing this in the kernel would
be complexity everyone would have to carry, while in lk2nd it's local to
the devices that can actually make use of it.

With the device tree we have the flexibility to adjust it based on
device-specifics (RAM size, display panels, broken CPU cores, ...).
I think it's perfectly fine if the bootloader makes good use of this
capability to keep Linux code simple and focused.

Thanks,
Stephan
