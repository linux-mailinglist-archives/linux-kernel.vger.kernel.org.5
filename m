Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD227AF514
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbjIZU2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjIZU2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:28:06 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207B311D;
        Tue, 26 Sep 2023 13:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695760067; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WwJcfkj9Vika/BX8i/Ehci3wAkcXI9ofc5vM6KaWcVsHdfaSJWDJst18UUuBw4rAl4
    3IeS2x8kMd6rez/wNPY5Oyb9SRk2bNNeUpoBQMYB25l3hoJ1kFvNrPSKE+OWJclMCmah
    g/iU9eKHzET+AUPSljiKGglGk+CDVupsEC84umVBCjA7ZfBdQojzoMsN9AK4WTx2PhcM
    yMJuhPVZB4acrgcfZRi0tj2wNizpzIQ1SEgwlUwp4jTOt15KN7jNf4+y2uvW0lkKeYCo
    cjRiPIZECE+L88orqcUF2jKdXpbtsC4tNbs+r9mkr1xBkqFL9oVBNOVdKjZsX6OHtjD2
    wQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695760067;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=g35Lh2GJzAJUqsn5VlMrTQiOMORsZeGa5L9BhrdzDUI=;
    b=tVGQ3+kC7lrTNJZ3uqM2638KHw4dyfrJQbYaTivFoqlrFZTN7gtXQfUEbVCWZrsZZ6
    Qfx7zF2GW6Q0yWBn/xpOp5uor/CnQ0bwwBtVAMbfu38bw7hz2/NpQFxxCX3s3OCml/ky
    2/Aj98dwjz5EyIUjkuec1bu9apVHXUxDvOMjfzhB/H2OqAT2LPdX9GKvCJ3kqm5mX/Z/
    MVgBlUshEPIjDr2hzlFT63KeLUu91JEQbPqCe1X0AHG2Yhu7kHS/hhZLiO8rUGym8Fv+
    T29lkc0SGm3kuO1tJ6ZHzZqoY261w6OxgNPS9F2ZkwVqOEX90aaJEkejKbP/wKn3ckNW
    gAVA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695760067;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=g35Lh2GJzAJUqsn5VlMrTQiOMORsZeGa5L9BhrdzDUI=;
    b=G/NjKECKAIl6Eti4mvt0PW3qzKmXZE8OzXalLnwlUK1yzcIXiQ0/bfOj+DKZe1HF8w
    IPdhXxCJQ86JWc7difuIy/agoFpwMgi327NR9onfVFezUOZ8hxDS8UOwzkAv7MH7fiaL
    omDwfM6M0tCkp3nlnfb4aZWqSBDeBJPvDv+ftVQMVqLAZhqRCDYbyNhqT5pAl1DaNttG
    /fIvqBcESWwhV6vmYLD8u9QF2HWMqgHljhZUFoeaMtDB4N422eZw/hIKBspVvoyjp12V
    ArTjiWAVI9mR9CBnqzxsEdWHAJoVJnAUaX31oZZxGG40szvJr1rIZwN+qk1qqeL8IHC3
    vkDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695760067;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=g35Lh2GJzAJUqsn5VlMrTQiOMORsZeGa5L9BhrdzDUI=;
    b=8JguGCEnxCdDYW6bT67D82kacdIvuFrBVVky9Sx11Aht2E9EyKLxsOPvk2Lrs/cQm3
    clcVtzWCtL3NIoY4s9Dg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QKRkgTE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 22:27:46 +0200 (CEST)
Date:   Tue, 26 Sep 2023 22:27:39 +0200
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
Message-ID: <ZRM-u3gIoOsHVp7c@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-4-398eec74bac9@gerhold.net>
 <2c9eda54-a90e-483a-abc2-865d82854b80@linaro.org>
 <ZRMwdRo9hAm4BO5E@gerhold.net>
 <278ac134-992e-460a-b37a-60a746eab107@linaro.org>
 <ZRM6dJXNvx93jFrM@gerhold.net>
 <9b9a9c0d-8a09-48a4-b996-554d7e1b9340@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b9a9c0d-8a09-48a4-b996-554d7e1b9340@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:18:22PM +0200, Konrad Dybcio wrote:
> On 26.09.2023 22:09, Stephan Gerhold wrote:
> > On Tue, Sep 26, 2023 at 09:56:12PM +0200, Konrad Dybcio wrote:
> >> [...]
> >>
> >>>>> +
> >>>>>  &blsp_i2c2 {
> >>>>>  	status = "okay";
> >>>>>  
> >>>>> @@ -243,6 +258,13 @@ &gpu {
> >>>>>  	status = "okay";
> >>>>>  };
> >>>>>  
> >>>>> +&lpass {
> >>>>> +	dai-link@3 {
> >>>>> +		reg = <MI2S_QUATERNARY>;
> >>>>> +		qcom,playback-sd-lines = <1>;
> >>>>> +	};
> >>>>> +};
> >>>> Is that not status = reserved?
> >>>>
> >>>
> >>> Correct. This is here to simplify switching to the modem-bypass audio
> >>> routing if someone does not need (or want) the modem. The direct audio
> >>> path with the LPASS drivers tends to be more reliable and configurable
> >>> (especially wrt bit formats, sampling rates, latency, channels etc).
> >>> I know that at some point this helped someone who tried to use an old
> >>> phone as some kind of portable musical instrument / synthesizer.
> >>>
> >>> It's not too obvious that these definitions would be needed when making
> >>> those changes (because devices using the standard SD lines (i.e <0>) do
> >>> not need it). If you forget about this you get non-functional audio with
> >>> no error or any hint what could be wrong.
> >>>
> >>> To simplify switching between the different audio routing options, the
> >>> lk2nd bootloader actually has an option to do this transformation in the
> >>> DTB automagically during boot. It's sort of like a DTB overlay that
> >>> disables the QDSP6 audio path and enables this node instead. The DAI
> >>> links are also adjusted where necessary.
> >>>
> >>> Do you think a comment would help here?
> >> I'd say a comment would be necessary here :D
> >>
> > 
> > No problem, I will try to add something simple.
> > 
> >> While I understand this use-case, I believe this is better suited
> >> for an actual DTBO or something entirely kept inside lk2nd.
> >> Otherwise this looks very confusing to an outside reader.
> >>
> > 
> > Translating from the QDSP6 audio setup to the LPASS one is mostly simple
> > but not entirely trivial (especially the patching needed for the DAI
> > links). Main blocker for DTBOs is that you can only add or change, but
> > AFAIK there is no mechanism to _delete_ or fully recreate nodes.
> Correct.
> 
> > 
> > I guess I could maybe derive this from the QDSP6 definitions using
> > custom magic code, but the code complexity for that is much higher than
> > adding these nodes here for completeness.
> I hate to be the bearer of bad news, but this is probably more
> of a "do we reasonably want this upstream" type question, as
> you'll probably get some grumpy emails about upstream not caring
> about what's outside the mainline tree..
> 

IMHO this is hardly a "downstream" type of situation. The whole point of
the magic in lk2nd is to make the life for the mainline code base easier
and simpler, while still allowing the "bypass modem audio" feature with
an unmodified kernel.

Before implementing it like this I used to have this directly in the
kernel tree, by duplicating each device into a normal XYZ.dts and
"XYZ-no-modem.dts". If you apply this to the total of ~45 different
MSM8916/MSM8939 DTBs I would like to get upstream this options gets
extremely ugly. :'D

Thanks,
Stephan
