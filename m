Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE2D7CABCF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjJPOpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPOpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:45:05 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571D8AB;
        Mon, 16 Oct 2023 07:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1697467480; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VQJg1RsTctPWMnunyunfLHy2rLs7zNB/CNL3uh76kEa1fZsXzKvAIpoB8tkgfT2RNu
    2rKoWE5OPZRMM+BCSsYTpW6khc3tI1nH5N/1qJvDzfiYK5GlaTi3KbQDrkyeKDVWVMet
    1A1bt/1meFjCYzuxWdYQsfyFAp9nQzs0T0qZM/x0FXBuhDfVWajh7E4FKGpP9uMECv4W
    pH58fRwShTyIYR2EyKDqYwcy2HpGDlymYkPPDw1nmu2fhIAsnjXpQGKzZKO94ZNvNJKO
    fhFeTMVj1meRxgiTyIgbwlDTjaiOswOuukT4Wc/XkYJFpqDhiQrrmpvh4S/2EAVFvBfv
    REow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1697467480;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xX5hBwIyyt+mobzNXbEEyEPguKjaJlDcotBwI7v0tiw=;
    b=n+Mfk6c1CeBShSjZ88173Z2R7ZIK1RjEdPw3nYDGYcW1wK28Gt5wqklMEffbVD8iV6
    vkvS7zxhGbuoPoAMPbESIGocsGxi+axSxo35rbLCka5+DEJFF18Xd+u0t6QCLVkZvrrP
    gcwp26JgNliUepXjbaDE8CEUI+8yF6e+sZ7c140P8ZvM5ztoWB5t6qma0hERztyvDMHR
    0tdEUBIP/RCR/hx2iOYUnNFGWWSMGx+FAbyNvbmvOrK6kjGrHx7DI4yjdIbWBqxcLq/x
    JpWL4ayjasaa4YLb1lIcnpJ2VFYTBRrMxtFsGtcA3ENaBTcGij1fb4H9Iv60gY0JgjLM
    ic7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1697467480;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xX5hBwIyyt+mobzNXbEEyEPguKjaJlDcotBwI7v0tiw=;
    b=G+2o7R0QMJJBT+YXg8vDQQQxGzsXPhWuM22xgxnzxP2fhmYCupPM4yKQPOdo0U5/Up
    MhRXevKhGuT76C/ItYHomUyvnv9EWLUe2MK3Bj4kJ4xWCzRV0H0w6Z6iXXMUokyHGaHQ
    w0GLCb15rSUmK6bQ8BG9LeDYy3dv+ftDmBdLsz/sQ/9hxS9yMKJiVvLbS5u6Al4ttAkf
    nuZsNP0hcx2KQjItQL7vm763usWbbpKa8F/hoIIjRr5nbDk65f/vR8OMz5Hrb6T1Eiu8
    QMp+UHCm8n1iy0tPNJvRI4UlQKaXhMwwt5HEjoqtPCQqw/oIvP0NOYLotbfj9+ZdK0AB
    I8yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1697467480;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xX5hBwIyyt+mobzNXbEEyEPguKjaJlDcotBwI7v0tiw=;
    b=69+eKkTf5LWsB5y5p8U21qGYEfe9j1pEpjC8AFafAYiu3jM8pCAKLCE28qCC2LfAbd
    s/WryFLK3a7YggE0SUCw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9GEid25O
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 16 Oct 2023 16:44:39 +0200 (CEST)
Date:   Mon, 16 Oct 2023 16:44:28 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>,
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
Message-ID: <ZS1MTAHq6GLW6RAK@gerhold.net>
References: <20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz>
 <20231015-fp3-wcnss-v1-1-1b311335e931@z3ntu.xyz>
 <ffca099a-bf05-4973-885d-b049a45d466f@linaro.org>
 <CAMZdPi-S2_UQO-rD38-thwta-YgH3W78Ecd1Du7Q_US=J7k0ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZdPi-S2_UQO-rD38-thwta-YgH3W78Ecd1Du7Q_US=J7k0ew@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 03:16:14PM +0200, Loic Poulain wrote:
> On Mon, 16 Oct 2023 at 07:35, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 15/10/2023 22:03, Luca Weiss wrote:
> > > Add a compatible for the iris subnode in the WCNSS PIL.
> > >
> > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > ---
> > >  Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > index 45eb42bd3c2c..0e5e0b7a0610 100644
> > > --- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > @@ -111,6 +111,7 @@ properties:
> > >            - qcom,wcn3660
> > >            - qcom,wcn3660b
> > >            - qcom,wcn3680
> > > +          - qcom,wcn3680b
> >
> > Looks like this should be made as compatible with qcom,wcn3680 (so with
> > fallback).
> 
> Yes, agree, let's do a regular fallback as there is nothing 'b'
> specific in the driver:
> `compatible = "qcom,wcn3680b", "qcom,wcn3680";`
> 
> And yes, we should also have done that for qcom,wcn3660b...
> 

I don't think this would have worked properly for qcom,wcn3660b:

 - It's not compatible with "qcom,wcn3660", because they have different
   regulator voltage requirements. wcn3660(a?) needs vddpa with
   2.9-3.0V, but wcn3660b needs 3.3V. That's why wcn3660b uses the
   wcn3680_data in qcom_wcnss.iris.c. Otherwise if you would run an
   older kernel that knows "qcom,wcn3660" but not "qcom,wcn3660b" it
   would apply the wrong voltage.

 - It's not compatible with "qcom,wcn3680" either because that is used
   as indication if 802.11ac is supported (wcn3660b doesn't).

The main question here is: What does the current "qcom,wcn3680"
compatible actually represent? It's defined with vddpa = 3.3V in the
driver, which would suggest that:

 1. It's actually meant to represent WCN3680B, which needs 3.3V vddpa
    like WCN3660B, or

 2. WCN3680(A?) has different requirements than WCN3660(A?) and also
    needs 3.3V vddpa. But then what is the difference between
    WCN3680(A?) and WCN3680B? Is there even a variant without ...B?

There is public documentation for WCN3660B and WCN3680B but the non-B
variants are shrouded in mystery.

Thanks,
Stephan
