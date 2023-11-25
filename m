Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6F7F8ABD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjKYMZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjKYMZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:25:20 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162CBBB;
        Sat, 25 Nov 2023 04:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1700915123; bh=/neb3ai8t+JZrai5HMokEXT4feRyamGmrHQtOs/DwgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b3JDi/QHwcg4Y2Gx9dp9m8udMhODcQr0cSVQQ4mfzARcHgUVwIyHP8dDL0uuVnNvC
         cnB8MFiKKDYpPQApdqCko/NBmsLOipd5yNgAZyywRw8lqGDRAXX/tnjycOTV2s7ynU
         A5xGSRLZKUahHpD7z2gQKIZUDYl0+MjSvCa31xyw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Loic Poulain <loic.poulain@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Date:   Sat, 25 Nov 2023 13:25:22 +0100
Message-ID: <1868698.tdWV9SEqCh@z3ntu.xyz>
In-Reply-To: <ZS1MTAHq6GLW6RAK@gerhold.net>
References: <20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz>
 <CAMZdPi-S2_UQO-rD38-thwta-YgH3W78Ecd1Du7Q_US=J7k0ew@mail.gmail.com>
 <ZS1MTAHq6GLW6RAK@gerhold.net>
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

On Montag, 16. Oktober 2023 16:44:28 CET Stephan Gerhold wrote:
> On Mon, Oct 16, 2023 at 03:16:14PM +0200, Loic Poulain wrote:
> > On Mon, 16 Oct 2023 at 07:35, Krzysztof Kozlowski
> > 
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > On 15/10/2023 22:03, Luca Weiss wrote:
> > > > Add a compatible for the iris subnode in the WCNSS PIL.
> > > > 
> > > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > > ---
> > > > 
> > > >  Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml | 1
> > > >  +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > index 45eb42bd3c2c..0e5e0b7a0610 100644
> > > > --- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > 
> > > > @@ -111,6 +111,7 @@ properties:
> > > >            - qcom,wcn3660
> > > >            - qcom,wcn3660b
> > > >            - qcom,wcn3680
> > > > 
> > > > +          - qcom,wcn3680b
> > > 
> > > Looks like this should be made as compatible with qcom,wcn3680 (so with
> > > fallback).
> > 
> > Yes, agree, let's do a regular fallback as there is nothing 'b'
> > specific in the driver:
> > `compatible = "qcom,wcn3680b", "qcom,wcn3680";`
> > 
> > And yes, we should also have done that for qcom,wcn3660b...
> 
> I don't think this would have worked properly for qcom,wcn3660b:
> 
>  - It's not compatible with "qcom,wcn3660", because they have different
>    regulator voltage requirements. wcn3660(a?) needs vddpa with
>    2.9-3.0V, but wcn3660b needs 3.3V. That's why wcn3660b uses the
>    wcn3680_data in qcom_wcnss.iris.c. Otherwise if you would run an
>    older kernel that knows "qcom,wcn3660" but not "qcom,wcn3660b" it
>    would apply the wrong voltage.
> 
>  - It's not compatible with "qcom,wcn3680" either because that is used
>    as indication if 802.11ac is supported (wcn3660b doesn't).
> 
> The main question here is: What does the current "qcom,wcn3680"
> compatible actually represent? It's defined with vddpa = 3.3V in the
> driver, which would suggest that:
> 
>  1. It's actually meant to represent WCN3680B, which needs 3.3V vddpa
>     like WCN3660B, or
> 
>  2. WCN3680(A?) has different requirements than WCN3660(A?) and also
>     needs 3.3V vddpa. But then what is the difference between
>     WCN3680(A?) and WCN3680B? Is there even a variant without ...B?
> 
> There is public documentation for WCN3660B and WCN3680B but the non-B
> variants are shrouded in mystery.

Hi Stephan (and everyone),

Do you have a suggestion how to move this patchset forward? Is the fallback 
compatible that was suggested okay for the wcn3680b situation?

  compatible = "qcom,wcn3680b", "qcom,wcn3680";

If so, I'll make v2 with that implemented.

Regards
Luca

> 
> Thanks,
> Stephan




