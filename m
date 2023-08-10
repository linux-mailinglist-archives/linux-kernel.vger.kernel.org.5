Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D6A777C81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbjHJPnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjHJPnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:43:49 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A471BF7;
        Thu, 10 Aug 2023 08:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691682225; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pZ/U0FDAsikixXEDl16B8edPAiIW/AVQC4mKgzbu9ajR5qY73nqrCu8p5yWX+jFBUo
    iTfVRw5LdvZltrtubwXe95JCbzItPa/f61UlaZMAIEH/j8i8tL4mL+zHZ09kVEGYjNrw
    X/5JKxa5o7t2Mymy/q1eWtKYj2+wXIimCVQYq0X557jmsRzvc7BRTAqVdJIv/2runTri
    CKN6lguZmWHdMdTM1eJSVj+SNCDMRPEu0DI+GGhv7qOiw5XUtvo8JEsXkIJEVDCL0SSr
    0HwJqcf1AAj/28+YVzS5gsDi3aVeZ8BFwAs3eV0E33xnkWfxux44qSXlWKR0N/9mQKGL
    cfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691682225;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MtNjCQzJde8vqudWRkg4Eu8X+nYDGy8Gp0lQrH7ECrk=;
    b=VjQkYHT7cRcu7En288Gh2fIRkcZm7isKfgvmprho/tfoHXseYxKYQcSy80z9UqbxhA
    YNLMbIIYssdVvQXZCzw3QPyankRbtWqrGsPo5Wv+Mqle5LsnN5/jiid5cR7JtWaPwh78
    VaISyrxqjy2oxp1HRASoYd+ZHBHlu0bV9Nu3Pcdx8AioX5B46wB9CCMkGnxmYgTA7i7+
    yhNWvJZFQ0Gunq2zYW2KroRm0j9RHe50wuTbUH6GN4iNucmU4kWhD9HBlsC0ZeIYcwXB
    B2OHIsydaHOGGJRjlHaHvQmuObPJ4o06OYRn/LkFXtuoUcm39e8vyREAUzogs9iQB47L
    bzLQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691682225;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MtNjCQzJde8vqudWRkg4Eu8X+nYDGy8Gp0lQrH7ECrk=;
    b=GkuAMFl/ItowKNjY0Un2F9+Pbn0homDM2+4TuYjc3asPJCybr9Ae/AbOlbH8s5PIec
    IW5rNf75exLKstY0UkJ23eghbSIoYhBcEgR2YTbH3juPZDchDF7AfA7sBEl3G/etICnm
    AR9ULWjf5wZEnQmSDspULxrKvFLQ6qf3K91LDes9oSDdYeM1Nwm9nQIwBmOO729+LMqi
    iAX/4WG9YgVdfohCatkQmkMc5n162xD/blixZK6TyXc7vbWWWwPhV7XGk/N/SyWjgg9N
    alHusiVVRPgpgZ86pcvPThHxiIydZy5E4dbQaouZEDkHSU2+KdcjY0m/FIALylV0QQGl
    ktBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691682225;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MtNjCQzJde8vqudWRkg4Eu8X+nYDGy8Gp0lQrH7ECrk=;
    b=MPSYGkFRBXoEwM9Es6RzO6V5RleHPVYpJKXJEPloQtJqk+iXhsQYZ2me5fE3imkhrz
    DIZbt7ulaEj0R+VyIFBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z7AFhjrT0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Aug 2023 17:43:45 +0200 (CEST)
Date:   Thu, 10 Aug 2023 17:43:39 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, loic.poulain@linaro.org, rfoss@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom:
 apq8016-sbc-d3-camera-mezzanine: Move default ov5640 to a standalone dts
Message-ID: <ZNUFq8CY5U0ei_Cj@gerhold.net>
References: <20230809202343.1098425-1-bryan.odonoghue@linaro.org>
 <20230809202343.1098425-6-bryan.odonoghue@linaro.org>
 <ZNT9nLaSBZvm1HNe@gerhold.net>
 <d839ef44-3427-88b8-513e-a84b24cc6929@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d839ef44-3427-88b8-513e-a84b24cc6929@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:26:34PM +0100, Bryan O'Donoghue wrote:
> On 10/08/2023 16:11, Stephan Gerhold wrote:
> > Hi,
> > 
> > just some nitpicks. Some of them were present before already but maybe
> > you can prepend or append another cleanup patch while at it. :)
> > 
> > On Wed, Aug 09, 2023 at 09:23:42PM +0100, Bryan O'Donoghue wrote:
> > > At the moment we define a single ov5640 sensor in the apq8016-sbc and
> > > disable that sensor.
> > > 
> > > The sensor mezzanine for this is a D3 Engineering Dual ov5640 mezzanine
> > > card. Move the definition from the apq8016-sbc where it shouldn't be to a
> > > standalone dts.
> > > 
> > 
> > I wonder what would be required to implement this using a DT overlay,
> > rather than a standalone separate DT? Seems like there are some .dtso
> > files in upstream Linux.
> > 
> > I'm also fine with the separate DTB personally, though.
> 
> So, we've discussed that previously and its a good model, which I like and
> which works well for RPI as an example.
> 
> AFAIK though the runtime dtbo overlay is still missing at least one upstream
> commit and the state of dtbo in qcom bootloaders is variable, probably good
> in LK, good in u-boot and then I'd say nothing doing.
> 

AFAIU there is work going on (at Linaro?) to move the qcom RBs to use
U-Boot, so I guess that would be the easiest common base to work with.
There is an U-Boot port for DB410c as well.

> I'm hoping to transition the mezzanine dtb files to something "generic" for
> boards that support 96 boards interfaces.
> 
> Its a bit out of scope for this series as, all I really want to do here is
> fixup obvious errors as I find them in camss and its dtbs.
> 

Right, yeah I think it's fine to have the separate DTB for now. I was
always confused about the disabled camera parts in apq8016-sbc, having
it in a separate DTB is definitely less confusing. :)

> So anyway the idea would be to define labels in the core board dts files for
> stuff like "powerdown-gpios = <&tlmm 34 GPIO_ACTIVE_HIGH>;" I'm not sure
> that's really feasible until its tried though.

Handling the GPIOs sounds complicated... I think it would be also okay
to have board-specific mezzanine overlays as a first step though. (i.e.
one for DB410c, others for other compatible 96boards).

> 
> Basically any mezzanine board would ideally only be defined once, with
> 96boards supporting baseboards providing the necessary additional detail on
> pins and regulators for the mezzanine to consume..
> 
> Come to think of it though you'd have to #include "myboard.dts" so maybe,
> probably, that idea not feasible.
> 
> dtbo would be better still but like I say I'm not presupposing a decent
> bootloader that can apply the overlay.
> 
> I/we will look again at dtbo since its just a neater model really.
> 

Thanks, I'm looking forward to seeing what you come up with. :D
Stephan

