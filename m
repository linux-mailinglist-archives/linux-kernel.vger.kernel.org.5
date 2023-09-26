Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8767AF457
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjIZTpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjIZTpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:45:06 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239369D;
        Tue, 26 Sep 2023 12:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695757490; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jXSrUcK2o/FH3CfTg/97oEh+BuZB/tFimVp+6h7hUeqzUL7hPLzUjKZyqfHMqCfp3Y
    gWkrVurgg6RXP4seFErpF3bRR7moAAGX0mrC14pCtWpS3PwIKghpvzcgu7WRdAxiZPDg
    bYS70xiyu5jVv69iaZinaeGyI1qBNp3LRlcnvqXMIBXwDJLdfSB48P6WtFjxipUAj4D6
    XmV8HRKko5kG53SSIdC7GorpVtbucko5DDeP9fvYBllXJKVXua4YyM7C4Eobj/qqi5N9
    xd36cpJAexK82FOcq3LqzaAhCWk1NpANoY+Mlmn6saJd5gkut53O3gJsAAwrRqTwauH9
    NMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695757490;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3hCfeejR0RMdvcsPH6Vkd2tSR0FFy+vOCp0jepSALE8=;
    b=lNYBKs1oVSSybSSEa9i9v3Ui3SdKw1bCRXQ+rSFe/U6H8UX0DaRA3mivNJGgfclekX
    IAfB2sg0a+BZOH3blNzyQUbG+jzH/v+xqGpCmQ4qTRVBwZpNxwhrlNXLkq5+jz73Y7TI
    JEOKcGpWdM6kOM0NePkZuvhRgdMuURxS4pBvJqwjSWyXuAwisVAwG3lmlIV/Mg5RnzAa
    X4EMcbtwdpuwL2s2RSQ7gHrQ1eBwn+e0AaXjI8k8udWfkOL1deLZ17mFyExj3B3vJduq
    gyUJj45GnlyAEbsmTrKt6VYczmURlVT6/w4pZoN8mTZjRtD719k5+TH39Zh/E97aMVe5
    6Jfw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695757490;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3hCfeejR0RMdvcsPH6Vkd2tSR0FFy+vOCp0jepSALE8=;
    b=iQB4l8nAZwpbOT0i1258e9ad8oCT135fI0qqRRwabctZMvFVlS+ubVrGXYu+sTLut0
    4kih2JxNCj5wiNiAazdL0bwhIc8NnqXp5Q1mLJMEM2X3NYi+R+QOIyAEwRTJkwv0NDJc
    6rHn4OHnoHXRbyYvxFlPMfGcv6/k3Xi21MPDAui3SIFy1OdngBCUvq2XQfibhvnuoQrR
    j5YuWsq79FhR5XRjcl54KPuzI69pkBYyTvi8EW6zTG69NVtt/ZDkXfdQHLoCvUodhkdG
    sR4/zcu9QKUApC1XXvA2BIDD/7yI/fhjutsa/nbWIhfW4kz0GI4GEPCEE2Dfgp7lZdnY
    tj1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695757490;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3hCfeejR0RMdvcsPH6Vkd2tSR0FFy+vOCp0jepSALE8=;
    b=N0u4+WvGTTpWYb5yiIqzmOuix0dsshPZO+pYgcftpy+avSD7eRpqOKKFSrpvh9kBND
    XsHyJovw3r/unBnWRbCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QJiogOb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 21:44:50 +0200 (CEST)
Date:   Tue, 26 Sep 2023 21:44:49 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        Markuss Broks <markuss.broks@gmail.com>
Subject: Re: [PATCH 12/13] arm64: dts: qcom: msm8916-samsung-j5: Add sound
 and modem
Message-ID: <ZRM0sRgw1j6IJi3Y@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-12-398eec74bac9@gerhold.net>
 <9d0ad1cf-77d5-4704-9861-4eaae4cbec42@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0ad1cf-77d5-4704-9861-4eaae4cbec42@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 09:04:22PM +0200, Konrad Dybcio wrote:
> On 26.09.2023 18:51, Stephan Gerhold wrote:
> > From: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
> > 
> > Enable sound and modem for the Samsung J5 smartphones. The setup is
> > similar to most MSM8916 devices, i.e.:
> > 
> >  - QDSP6 audio
> >  - Speaker/earpiece/headphones/microphones via digital/analog codec
> >    in MSM8916/PM8916
> >  - WWAN Internet via BAM-DMUX
> > 
> > except:
> > 
> >  - There is no secondary microphone, so a different "model" is used to
> >    differentiate that in the UCM configuration.
> >  - Samsung-specific audio jack detection (not supported yet)
> > 
> > Co-developed-by: Markuss Broks <markuss.broks@gmail.com>
> > Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> > Signed-off-by: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
> > [Stephan: Add consistent commit message]
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi | 15 +++++++++++++++
> >  arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts         |  4 ++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
> > index fe59be3505fe..2caa820b0c26 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
> > @@ -1,6 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  
> >  #include "msm8916-pm8916.dtsi"
> > +#include "msm8916-modem-qdsp6.dtsi"
> > +
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/input/input.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > @@ -135,6 +137,10 @@ &blsp_uart2 {
> >  	status = "okay";
> >  };
> >  
> > +&mpss_mem {
> > +	reg = <0x0 0x86800000 0x0 0x5800000>;
> > +};
> > +
> >  &pm8916_resin {
> >  	status = "okay";
> >  	linux,code = <KEY_VOLUMEDOWN>;
> > @@ -154,6 +160,15 @@ &sdhc_2 {
> >  	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
> >  };
> >  
> > +&sound {
> > +	model = "msm8916-1mic";
> That's.. vague.. Is that intended?
> 

msm8916-modem-qdsp6.dtsi defines model = "msm8916" by default since we
have a standard UCM configuration that configures the typical audio
mixer setup when all outputs/inputs are connected to the digital/analog
codec of the SoC/PMIC. "msm8916-1mic" is exactly the same just with the
SecondaryMic disabled.

Unfortunately these names are effectively limited to 15 chars
(everything after will be cut off), so there is extremely limited
potential for more expressive names. :(

> I also noticed only now that random patches have status
> at random places in the property tree.. Removing the disablement
> would aid that as well (wink wink)!
> 

Hm, I think I could do the status = "okay" in msm8916-modem-qdsp6.dtsi.
I don't think it should be enabled by default in the SoC dtsi but there
it would probably be fine. :)

Thanks,
Stephan

