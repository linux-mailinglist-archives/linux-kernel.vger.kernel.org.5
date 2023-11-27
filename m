Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6250A7FAB79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjK0U2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjK0U1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:27:38 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2987E19A6;
        Mon, 27 Nov 2023 12:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1701116852; bh=wjGIuleQ8kD0z2aVCMJjHMNPVmJYR139BLY4d6XpI1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CITmsuf4OwScTPbofNMOSgAtZ0drI/A4I02RxAI8Q9XCGQdfw8Gjn+WBillie3caD
         E5iR5ev6U/j/hvZOmRcTns+y0IavwYPaRysGzBKB6OUZwCyRkp36FWeFNF1qhkWbRg
         GE9GZ06SNeLT41ez/Go5UlAPQVoL/XsYOlZYg24s=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Stephan Gerhold <stephan@gerhold.net>
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
Subject: Re: [PATCH 1/4] dt-bindings: remoteproc: qcom: wcnss: Add WCN3680B compatible
Date:   Mon, 27 Nov 2023 21:27:30 +0100
Message-ID: <5919350.DvuYhMxLoT@z3ntu.xyz>
In-Reply-To: <ZWT3APJlNQaKVyJU@gerhold.net>
References: <20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz>
 <1868698.tdWV9SEqCh@z3ntu.xyz> <ZWT3APJlNQaKVyJU@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 27. November 2023 21:07:28 CET Stephan Gerhold wrote:
> On Sat, Nov 25, 2023 at 01:25:22PM +0100, Luca Weiss wrote:
> > On Montag, 16. Oktober 2023 16:44:28 CET Stephan Gerhold wrote:
> > > On Mon, Oct 16, 2023 at 03:16:14PM +0200, Loic Poulain wrote:
> > > > On Mon, 16 Oct 2023 at 07:35, Krzysztof Kozlowski
> > > > 
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > > On 15/10/2023 22:03, Luca Weiss wrote:
> > > > > > Add a compatible for the iris subnode in the WCNSS PIL.
> > > > > > 
> > > > > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > > > > ---
> > > > > > 
> > > > > >  Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > > >  | 1
> > > > > >  +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > > 
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > > > b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > > > index 45eb42bd3c2c..0e5e0b7a0610 100644
> > > > > > ---
> > > > > > a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yam
> > > > > > l
> > > > > > +++
> > > > > > b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yam
> > > > > > l
> > > > > > 
> > > > > > @@ -111,6 +111,7 @@ properties:
> > > > > >            - qcom,wcn3660
> > > > > >            - qcom,wcn3660b
> > > > > >            - qcom,wcn3680
> > > > > > 
> > > > > > +          - qcom,wcn3680b
> > > > > 
> > > > > Looks like this should be made as compatible with qcom,wcn3680 (so
> > > > > with
> > > > > fallback).
> > > > 
> > > > Yes, agree, let's do a regular fallback as there is nothing 'b'
> > > > specific in the driver:
> > > > `compatible = "qcom,wcn3680b", "qcom,wcn3680";`
> > > > 
> > > > And yes, we should also have done that for qcom,wcn3660b...
> > > 
> > > I don't think this would have worked properly for qcom,wcn3660b:
> > >  - It's not compatible with "qcom,wcn3660", because they have different
> > >  
> > >    regulator voltage requirements. wcn3660(a?) needs vddpa with
> > >    2.9-3.0V, but wcn3660b needs 3.3V. That's why wcn3660b uses the
> > >    wcn3680_data in qcom_wcnss.iris.c. Otherwise if you would run an
> > >    older kernel that knows "qcom,wcn3660" but not "qcom,wcn3660b" it
> > >    would apply the wrong voltage.
> > >  
> > >  - It's not compatible with "qcom,wcn3680" either because that is used
> > >  
> > >    as indication if 802.11ac is supported (wcn3660b doesn't).
> > > 
> > > The main question here is: What does the current "qcom,wcn3680"
> > > compatible actually represent? It's defined with vddpa = 3.3V in the
> > > 
> > > driver, which would suggest that:
> > >  1. It's actually meant to represent WCN3680B, which needs 3.3V vddpa
> > >  
> > >     like WCN3660B, or
> > >  
> > >  2. WCN3680(A?) has different requirements than WCN3660(A?) and also
> > >  
> > >     needs 3.3V vddpa. But then what is the difference between
> > >     WCN3680(A?) and WCN3680B? Is there even a variant without ...B?
> > > 
> > > There is public documentation for WCN3660B and WCN3680B but the non-B
> > > variants are shrouded in mystery.
> > 
> > Hi Stephan (and everyone),
> > 
> > Do you have a suggestion how to move this patchset forward? Is the
> > fallback
> > compatible that was suggested okay for the wcn3680b situation?
> > 
> >   compatible = "qcom,wcn3680b", "qcom,wcn3680";
> > 
> > If so, I'll make v2 with that implemented.
> 
> Personally, I would just go with what exists already and use the
> existing "qcom,wcn3680" compatible as-is. No one has provided evidence
> that there is actually something like a WCN3680(A), without a 'B' at the
> end. Also, all existing users of the "qcom,wcn3680" compatible upstream
> actually seem to refer to WCN3680B (I'm quite sure apq8039-t2 has
> WCN3680B, MSM8974 isn't entirely clear but iirc you mentioned there was
> some schematic of a MSM8974 device which says WCN3680B as well).
> 
> It would be nice to have the compatible perfectly correct and complete,
> but I see no point to extend it with additional information that we
> can't properly verify.
> 
> Or do you actually need a different compatible to customize something in
> the driver?

No it should be fine with qcom,wcn3680.

I'll send v2 in the coming days then, thanks for your input!

Regards
Luca

> 
> Thanks,
> Stephan




