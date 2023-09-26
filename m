Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4658B7AF4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbjIZURs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjIZURr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:17:47 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A8120;
        Tue, 26 Sep 2023 13:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695759457; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Gd2+GX7jicTOYyGDuJ+V+AktN7HvaAPB7C6faEsx8mxol2lCeLqyRKwUchUkTQK/3V
    M84NSLhXYVxzeTwIibP+jftyQBBgwgsPXB1me51s8D29EFxnQ/0PdivNXPy8gDldazGx
    KzSueGJh0bOOzN0auc0QaPpIDd4QIfDMoyL7jrnrVgTvYFIBcgvIFh5TI6IjBHEP+Yf7
    Pmvwe8bZHvM1KFZZRSNNU4OzTbSs+53lHhZh8nQo6xLwYnCuxMnR68nQ9OvXUCIN6zIG
    mXUiKMK2c92kxdAV0WBpYDDozQvfQoyABr3M6CGdyBkSbc72doY9SvDQLsp/BkCyCD11
    4HLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695759457;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=gXP9+C6uV2gAxP9cx2kOiZiHz5Y6eAXv91fPvZhh35U=;
    b=QX+Qtds5nmHZjfflrA8oiEN2teA+EiMCpxwvbbj//1DIINo43b42XXLKfbkVyPhFtv
    C5NA+nRJ/8eTS8+uuXopLuuS+Pi908S47cVADWCbnVPPattydk5d/krljK6yK7BPjAND
    7R0vI4DvTrba5eNvA0SGKCAjzAeLJU1MFKCN5AkFWVMnOTBFVgJTryYLrhagp+vlnssG
    QKpzlqlPvBy/E5pGajBLTD/b1HgWCoGbkuuvyP8NzaKS+xQ7d6CW7EBDRDATt22BZgGS
    g/emyg93ZJTpdpKpKXczCx7R1HPJIHsBAJlRQyPZrPF3sAKlHnSMBPYvPdVCzTySFDRv
    hMOQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695759457;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=gXP9+C6uV2gAxP9cx2kOiZiHz5Y6eAXv91fPvZhh35U=;
    b=eN4ybnc1ebaw6IEGAYV9fsaRFEbn0hL8jaYE1ogGVzJFiLwefD/xNr6AZ8YmgXfdJP
    uaWgjnrk/mJPeoYM/cDWCwEbeAP0NtqauugUpG1PbOjkiDl0DCWEUdAI2GmTBdGsM8+L
    Es8hNQbzxjgSvYcw5+WTMG1uag06EaJGa1MEMhKnJ6JErMQarXDhg0J9dQ3JTMAsiWGn
    VLYrDoEvcSBywyySQp1/NukccV7AJSmFcZjE8FI1dlZv2ZSFElFCOb9eOJyPlne4+yrc
    CF6KXHl5h2sIsY87h0Om248KzXKCccAUxYvvd6UpN3pO3qmsANCezhkut+7dBqlyp0pn
    hlBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695759457;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=gXP9+C6uV2gAxP9cx2kOiZiHz5Y6eAXv91fPvZhh35U=;
    b=S8jZrobbnQXGh6ZKHuq9A7XtHhvfl/EW/RDZhc/O0feR6BkIvQw5XsdP1CD/Nl2emV
    4ANU6Ku0mzIkNh94BzAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QKHbgSJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 22:17:37 +0200 (CEST)
Date:   Tue, 26 Sep 2023 22:17:35 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 03/13] arm64: dts: qcom: msm8916: Add common
 msm8916-modem-qdsp6.dtsi
Message-ID: <ZRM8XzmAz8RAqkUg@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-3-398eec74bac9@gerhold.net>
 <45665b43-3be9-4f27-aa88-12cdef56346d@linaro.org>
 <ZRMrqsZ0QeDNFHFj@gerhold.net>
 <1be747ae-1d80-4ebc-9841-c0e98e64a0d1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be747ae-1d80-4ebc-9841-c0e98e64a0d1@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:01:21PM +0200, Konrad Dybcio wrote:
> On 26.09.2023 21:06, Stephan Gerhold wrote:
> > On Tue, Sep 26, 2023 at 08:49:24PM +0200, Konrad Dybcio wrote:
> >> On 26.09.2023 18:51, Stephan Gerhold wrote:
> >>> Most MSM8916/MSM8939 devices use very similar setups for the modem,
> >>> because most of the device-specific details are abstracted by the modem
> >>> firmware. There are several definitions (status switches, DAI links
> >>> etc) that will be exactly the same for every board.
> >>>
> >>> Introduce a common msm8916-modem-qdsp6.dtsi include that can be used to
> >>> simplify enabling the modem for such devices. By default the
> >>> digital/analog codec in the SoC/PMIC is used, but boards can define
> >>> additional codecs using the templates for Secondary and Quaternary
> >>> MI2S.
> >>>
> >>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> >>> ---
> >> I'd rather see at least one usage so that you aren't introducing
> >> effectively non-compiled code..
> >>
> > 
> > There are 10 usages in the rest of the patch series.
> > Is that enough? :D
> > 
> > IMHO it doesn't make sense to squash this with one of the device
> > patches, especially considering several of them are primarily authored
> > by others.
> I see..
> 
> Well, I guess I don't have better counter-arguments, but please
> consider this the next time around.
> 

Will do!

> [...]
> 
> >>> +&lpass_codec {
> >>> +	status = "okay";
> >>> +};
> >> Any reason for it to stay disabled?
> >>
> > 
> > You mean in msm8916.dtsi?
> Yes
> 
> > For the SoC dtsi we don't make assumptions
> > what devices use or not. There could be devices that ignore the internal
> > codec entirely. If there is nothing connected to the codec lpass_codec
> > should not be enabled (e.g. the msm8916-ufi.dtsi devices).
> See my reply to patch 5
> 
> [...]
> 

Let's continue discussing that there I guess. :D

> >>> +	sound_dai_secondary: mi2s-secondary-dai-link {
> >>> +		link-name = "Secondary MI2S";
> >>> +		status = "disabled"; /* Needs extra codec configuration */
> >> Hmm.. Potential good user of /omit-if-no-ref/?
> >>
> > 
> > AFAICT /omit-if-no-ref/ is for phandle references only. Basically it
> > would only work if you would somewhere reference the phandle:
> > 
> > 	list-of-sound-dais = <&sound_dai_primary &sound_dai_secondary>;
> > 
> > But this doesn't exist so /omit-if-no-ref/ cannot be used here.
> Ahh right, this is the one we don't reference.. Too bad,
> would be a nice fit :/
> 
> I only see one usage of it though (patch 7), perhaps it could
> be kept local to that one?
> 

This patch series just contains the initial set of
msm8916-modem-qdsp6.dtsi users (for devices which are already upstream).
We probably have like 20 more that still need to be upstreamed. :D

sound_dai_secondary is fairly rare, but there is at least one more user
that will probably end up upstream soon.

I think the overhead of these template notes is absolutely negligible
compared to all the (potentially) unused SoC nodes we have. :D

Thanks,
Stephan
