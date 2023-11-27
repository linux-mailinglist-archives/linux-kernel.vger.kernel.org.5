Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07C37FAAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjK0UHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0UHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:07:52 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AA5C2;
        Mon, 27 Nov 2023 12:07:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701115655; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=j9Dnl2feQikME50AveMe2VIAx+6WIxyk5Llq+7xwrjbq9aMuX3z7kdJAXfMxwW1KtC
    CAVylr5ngDTnNNO2xjhpt79kSn6boZ/0dUHzRMWC31behifoXmSJyjGgoLtyQ0gCyvcs
    Vv+5Bn2ealkVw+E9A121ocxqwwsOYPI0at8y+S26ookxj5w1WHW3wCQv+iKgdi/I7rF4
    fNH2loc48rcDq2gM9wv7TDO/GqGCsQcZqBCzTztGZC+mPPHg/NbD8oM/slg6hTGGd9Pe
    QXuaLTsjdAFi2jxtd/+gRAjcIKYBB7tfTl8X1hkNFVjVK6FLLCtUw9BTxOJHUqruwyhd
    j91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701115655;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=v/YEJb75BXKWSsirkyffSVuJJ2grcB36hXol/hZ9KLk=;
    b=ZUgtJtWVyz1PjQtKX6lm0GUT9hBwESh1E5gah98jsmbEc7ehf0xhPVP1G19nLczlBF
    3jPVGJYJJF1NDEizh8WNKW06potRqC4tw1XH4UzPs28c709Ed9DO8RBdlypTtWP+e4yP
    X8oeacDrZoiZ0hZWRpJIG54WuKI7/M3wUirPstf4s1m5K9j3R7E5gRRjjUd/QfXzoSMO
    At7X/39SC+s9mVikv39qV7LmILmvqpZRi46brLanKwlc0BYh25SszAjD8pD5ma1MYI67
    2BbnTl0m1TfTEn4HTXn2LT18a9rwqvFU3KyH3X7CWWZCmPRAD6oeA9s14roqpOU0quJQ
    IR2A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701115655;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=v/YEJb75BXKWSsirkyffSVuJJ2grcB36hXol/hZ9KLk=;
    b=dRxXjHWOUI2KreqKJg9Mf2I/iqUZv7koheEFKJpWNrOs7lAldQgkxmEXgXLSJBlJbL
    cYsWaSoPlQpU4yQl0adBeOr7TcaKFL3qUjJ7LTw7LX80tr4o0ak3HBUtJIr/JDKpTAM2
    a0oCh563ChFQHR+f/yV8iUrYBen9q/2DPbIUwtRUrT0j8aQT6WLjsJINGtOr35Y4NwtR
    0843PRDOC9GGb4brb4XmP0NkbNAGgXqBP6j8fWh/clczSOhNLGxdioh4tu44NSRCI4Bv
    h7+YHuHM73gsEt+HToEejFcWMx7a1hpBNxYhxDiCaxJWxKSj3oAGzz79TjFZ8aU2HV55
    8Xqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701115655;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=v/YEJb75BXKWSsirkyffSVuJJ2grcB36hXol/hZ9KLk=;
    b=wMD+7x0VImS6FeN3bgL/Mo5n0Z4sHlIqS2YxbdSBRy6fgGL2ul2mfpAM10fSiQvVGr
    6mQoRDwJA0e0TXX+TgDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8paF1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id t3efe7zARK7XjVD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 27 Nov 2023 21:07:33 +0100 (CET)
Date:   Mon, 27 Nov 2023 21:07:28 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: remoteproc: qcom: wcnss: Add WCN3680B
 compatible
Message-ID: <ZWT3APJlNQaKVyJU@gerhold.net>
References: <20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz>
 <CAMZdPi-S2_UQO-rD38-thwta-YgH3W78Ecd1Du7Q_US=J7k0ew@mail.gmail.com>
 <ZS1MTAHq6GLW6RAK@gerhold.net>
 <1868698.tdWV9SEqCh@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1868698.tdWV9SEqCh@z3ntu.xyz>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 01:25:22PM +0100, Luca Weiss wrote:
> On Montag, 16. Oktober 2023 16:44:28 CET Stephan Gerhold wrote:
> > On Mon, Oct 16, 2023 at 03:16:14PM +0200, Loic Poulain wrote:
> > > On Mon, 16 Oct 2023 at 07:35, Krzysztof Kozlowski
> > > 
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > On 15/10/2023 22:03, Luca Weiss wrote:
> > > > > Add a compatible for the iris subnode in the WCNSS PIL.
> > > > > 
> > > > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > > > ---
> > > > > 
> > > > >  Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml | 1
> > > > >  +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > > b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > > index 45eb42bd3c2c..0e5e0b7a0610 100644
> > > > > --- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > > 
> > > > > @@ -111,6 +111,7 @@ properties:
> > > > >            - qcom,wcn3660
> > > > >            - qcom,wcn3660b
> > > > >            - qcom,wcn3680
> > > > > 
> > > > > +          - qcom,wcn3680b
> > > > 
> > > > Looks like this should be made as compatible with qcom,wcn3680 (so with
> > > > fallback).
> > > 
> > > Yes, agree, let's do a regular fallback as there is nothing 'b'
> > > specific in the driver:
> > > `compatible = "qcom,wcn3680b", "qcom,wcn3680";`
> > > 
> > > And yes, we should also have done that for qcom,wcn3660b...
> > 
> > I don't think this would have worked properly for qcom,wcn3660b:
> > 
> >  - It's not compatible with "qcom,wcn3660", because they have different
> >    regulator voltage requirements. wcn3660(a?) needs vddpa with
> >    2.9-3.0V, but wcn3660b needs 3.3V. That's why wcn3660b uses the
> >    wcn3680_data in qcom_wcnss.iris.c. Otherwise if you would run an
> >    older kernel that knows "qcom,wcn3660" but not "qcom,wcn3660b" it
> >    would apply the wrong voltage.
> > 
> >  - It's not compatible with "qcom,wcn3680" either because that is used
> >    as indication if 802.11ac is supported (wcn3660b doesn't).
> > 
> > The main question here is: What does the current "qcom,wcn3680"
> > compatible actually represent? It's defined with vddpa = 3.3V in the
> > driver, which would suggest that:
> > 
> >  1. It's actually meant to represent WCN3680B, which needs 3.3V vddpa
> >     like WCN3660B, or
> > 
> >  2. WCN3680(A?) has different requirements than WCN3660(A?) and also
> >     needs 3.3V vddpa. But then what is the difference between
> >     WCN3680(A?) and WCN3680B? Is there even a variant without ...B?
> > 
> > There is public documentation for WCN3660B and WCN3680B but the non-B
> > variants are shrouded in mystery.
> 
> Hi Stephan (and everyone),
> 
> Do you have a suggestion how to move this patchset forward? Is the fallback 
> compatible that was suggested okay for the wcn3680b situation?
> 
>   compatible = "qcom,wcn3680b", "qcom,wcn3680";
> 
> If so, I'll make v2 with that implemented.
> 

Personally, I would just go with what exists already and use the
existing "qcom,wcn3680" compatible as-is. No one has provided evidence
that there is actually something like a WCN3680(A), without a 'B' at the
end. Also, all existing users of the "qcom,wcn3680" compatible upstream
actually seem to refer to WCN3680B (I'm quite sure apq8039-t2 has
WCN3680B, MSM8974 isn't entirely clear but iirc you mentioned there was
some schematic of a MSM8974 device which says WCN3680B as well).

It would be nice to have the compatible perfectly correct and complete,
but I see no point to extend it with additional information that we
can't properly verify.

Or do you actually need a different compatible to customize something in
the driver?

Thanks,
Stephan
