Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666167AF42F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjIZTfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjIZTfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:35:40 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8ADE;
        Tue, 26 Sep 2023 12:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695756925; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ACcTc/7xLVKm9MQagXeedFOflcfO7CeyZW1ewfiKuOIZUPFAygewerJwbkzjwZxrm6
    bjly+24xw+ZI05iwmDuLPb3Hcdm8yONZUiq1+vJtafH4EI/Lr4WeD+DnHwDjcKJClRnl
    Ze4MdAdQGu29srE5eqT+9hFDoJ+glRBYvUgEQ0Aeyj505rrOiT47IfygoyNHWnPmXHiQ
    f1or1j46OsSg4bcN+Jdyqsm8qoRz+Odiew1Wp6ZusKA1bFsdUDZQiHsRi5awX/aan1Q1
    3dp8il9MbiTUMQ0fcr+JJNSrXa0lyzHnSO5ZOtiUlxAjx4aixEupW5fTs7eoHbtpXSDt
    2oZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695756925;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2f7d9Y0ED9nXfENKGMQIn0vTxb4lnSJrmVirloDnY4o=;
    b=gtcOhIk/t+B5pJFUou2qF847Hk277QYdD92W8TNYEyLbXfR+0qsgJzh4BueTODuBDi
    uq3qzL9NYhIYgIVazBiABkjvl1OGO0FwzKT1XPHZ48so0WZtY23AD7tofyUhBmlXq2Ne
    mzf5pmPdPDCAVuHF5I1g2yx7XHnav9kODooh3OIuBCyKTGdHTx5NuMZF/u0+8JzUJY06
    4NWMMdzALyiDdbU9TX7xP0Bu7rU9227OkAfQKbbe3z0oKyC8b9WRrHj1+rBMuZT9vJjj
    9KmoGCb+6xcWQOTgNjItjbfrBgbW+zWqPkG+xQO7zcBdw9yYmCsC86HcK2BV44WdgHmG
    pVCg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695756925;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2f7d9Y0ED9nXfENKGMQIn0vTxb4lnSJrmVirloDnY4o=;
    b=H0dq7A1QC/g2HwSQXIi1o9I4cwNJfD6gywZH/HKTNQKpgwEfMumDuMuuQa825TpGyp
    3bxlj+71G0GpotptWqlQDpg3LKcK74ghdxU8v3t7aQLmTg5TtFiBTMkXsiZXOfpCEqbv
    P1uhZdZGTUPlxJF5fQV4d705n57coZzlQvXKMRSUcRj6lXUFltwT0RUgmS/Nh/3Hnt+a
    C+Rq6zRAZWesZ7h8uTu/dPSmlWGMGLxQZD1jxO/dpeQ2DqSnNp+wYMygul15B+vwStfp
    sDT5nXQzqZe1JmO3hb4okskml9fEjLgusxRlnvmykKIeImi7wRn/GqBBIJ/JWtnqh6aq
    dIgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695756925;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2f7d9Y0ED9nXfENKGMQIn0vTxb4lnSJrmVirloDnY4o=;
    b=G7Yq9N7I+LagQsF0yojR+vQkjETgk88pyFv2bFdAPoirTGXcwLMeXVG9p1UY7HbLIZ
    A7vIFa0vWxhXC2bNf2Cg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QJZOgNo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 21:35:24 +0200 (CEST)
Date:   Tue, 26 Sep 2023 21:35:23 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: Re: [PATCH 07/13] arm64: dts: qcom: msm8916-alcatel-idol347: Add
 sound and modem
Message-ID: <ZRMye1HeiUno5N_p@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-7-398eec74bac9@gerhold.net>
 <cb78cd52-c638-4977-a762-365a6fe5f723@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb78cd52-c638-4977-a762-365a6fe5f723@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:58:12PM +0200, Konrad Dybcio wrote:
> On 26.09.2023 18:51, Stephan Gerhold wrote:
> > From: Vincent Knecht <vincent.knecht@mailoo.org>
> > 
> > Enable sound and modem for the Alcatel Idol 3 (4.7"). The setup is
> > similar to most MSM8916 devices, i.e.:
> > 
> >  - QDSP6 audio
> >  - Microphones via digital/analog codec in MSM8916/PM8916
> >  - WWAN Internet via BAM-DMUX
> > 
> > except:
> > 
> >  - Stereo NXP TFA9890 codecs for speakers on Quaternary MI2S
> >    - These are also used as earpieces at the top/bottom.
> >  - Asahi Kasei AK4375 headphone codec on Secondary MI2S
> >  -> Primary MI2S is not used for playback
> > 
> > Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> > [Stephan: minor cleanup, add consistent commit message]
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> > There are some trivial conflicts unless
> > https://lore.kernel.org/linux-arm-msm/20230921-msm8916-rmem-fixups-v1-3-34d2b6e721cf@gerhold.net/
> > is applied first. But given that there are important fixups for the
> > dynamic reserved memory changes in that series it should preferably
> > get applied before this one anyway.
> > ---
> >  .../boot/dts/qcom/msm8916-alcatel-idol347.dts      | 164 +++++++++++++++++++++
> >  1 file changed, 164 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> > index fade93c55299..ef5fc9289754 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> > +++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> > @@ -3,6 +3,8 @@
> >  /dts-v1/;
> >  
> >  #include "msm8916-pm8916.dtsi"
> > +#include "msm8916-modem-qdsp6.dtsi"
> > +
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/input/input.h>
> >  #include <dt-bindings/leds/common.h>
> > @@ -22,6 +24,19 @@ chosen {
> >  		stdout-path = "serial0";
> >  	};
> >  
> > +	reserved-memory {
> > +		/delete-node/ reserved@86680000;
> > +		/delete-node/ rmtfs@86700000;
> Deleting with a label reference is strongly preferred to avoid
> mistakes.
> 

I would say the opposite applies here. The deletions are based on the
assumption that the nodes are at the address that are listed here. If
you would move rmtfs somewhere else the adjustments made here must be
re-evaulated.

/delete-node/ throws an error if the referenced name does not exist,
so it's exactly the indication we need if someone makes changes to the
original node in the SoC dtsi.

Note that this is different from property assignments, i.e.

	/ {
		reserved-memory {
			rmtfs@86700000 {
				status = "disabled";
			};
		};
	};

instead of

	&rmtfs {
		status = "disabled";
	};

because here there would not be an error if the node is renamed.

> [...]
> 
> >  
> > +&q6afedai {
> > +	dai@18 {
> > +		reg = <SECONDARY_MI2S_RX>;
> > +		qcom,sd-lines = <0>;
> > +	};
> > +	dai@22 {
> Missing newline above
> 

Thanks, will fix this!

> 
> > +
> > +&sound_dai_primary {
> > +	status = "disabled";
> > +};
> > +
> Hm, gives me an idea to sprinkle a bit more /omit-if-no-ref/ in
> patch 3..
> 

(See reply in patch 3, /omit-if-no-ref/ sadly only works for phandle
 references...)

Thanks,
Stephan
