Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0265763D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjGZR0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGZR0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:26:17 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F651FDA;
        Wed, 26 Jul 2023 10:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690392374; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=q6X5h8Fwa4huGbMCWO2FtTBI8+0PCWdL3S5qjNNNPkdPilwYLIEKLGZEubfdeShcnZ
    qMaroeRlUzLT+UpJwKPfHF6pJhM8v2x/X2Q43kzrKlTduz2FOLlc7uqQsfZ+SM97zpGQ
    0yWbCuRvMqNTZ26TfpYDFaZUFc8bhIhiQIOx+QZ23oVG/0X0X7ilrr5Uo/jC6ppeYf/9
    /2ior4NH4WYeqw6JNuPIMFy8h31SGgok0cedLMw3mrYWc7OUahKcUUBAAGuZ3Vrlmhe3
    kgFg9CUEqJM9D90dxEFjJ40EL9pRJiSqlyMJmN2J/g2pkr0yGz3navVOBLLt2DswE/CQ
    uKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690392374;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wnFrsFevLv+W25WxW5m3+d6JiTPQB16nSEq3hHRGu+g=;
    b=nmpsZGsYKjvwcRo9RCEYr+Teue1KIVzB1PBt0obP1rTuHkneTVCXneE+qTNOTo7Nm8
    icHpaKYknG1lcDPe4eyW1ZEzWt6rwAJZHOHIufSGTFGpT1ZA6gPYrqjabAtJe1lKACya
    K0iMFelRv5WY7DgoXcRCpfM4IiMiIe1dvoVNEFJYhLneASNG/VjQuc18IoCc/EM47hY8
    VV7JffgZZy/q237xqucDfUtviwx/tYqDICJoeE6iEaR4vClunr3lQY0dV6QRlpZLQWf0
    43IVrPos6YK3whbOMtBdQlbkb+JZcnDT7UOvptwErqz6u7xYtIATrA4x/yLAIJ2Z2Rf3
    Ox4Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690392374;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wnFrsFevLv+W25WxW5m3+d6JiTPQB16nSEq3hHRGu+g=;
    b=CLMr1ziN0eoLOPeZ49YQqhrJdib5PT6QCdzRPnSYbr6HWZvpJzeAD/xGATdeM5U//1
    fIQZL4i/nfc2Ecgqz8Aj/1gJiRTj4pwGGhyXNYW/8xgi7ePQMcxYphQBN2SckJvvQAno
    /SrbnNEBzTaNUP7/3ECLVbSlghdhp8Wu1noiksHLuwwPo3wKQgv6ZlGHDvYB14Smg2QY
    XVhItYU5V6WV3gResVIxDNG+QiqUAGHwiH+d2V54i/+TMSm5utm6tIguhHR30EDab7X2
    LiX3kMh8oZpK1GbBpKokCXxtckKbxbILsfuYwTULp4mpKI6Tt7Pf7QzkQ8Vsiv+AtKVK
    eG+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690392374;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wnFrsFevLv+W25WxW5m3+d6JiTPQB16nSEq3hHRGu+g=;
    b=J1xy1RwPEn3FM+D+27b6X7IAeP8Kyj6Vhob4Dn6iJnC+G51KPPj+mQuOHdDv2hUo6f
    L6kWB2wzTINtLf3PNgAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z6QHQE8Fg
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 26 Jul 2023 19:26:14 +0200 (CEST)
Date:   Wed, 26 Jul 2023 19:26:13 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] interconnect: qcom: qcm2290: Set AB coefficients
Message-ID: <ZMFXNZbYdpnFVsoV@gerhold.net>
References: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
 <20230726-topic-icc_coeff-v1-2-31616960818c@linaro.org>
 <ZMFVZJa647SNwrJX@gerhold.net>
 <5667c93a-408f-3802-b168-f3a145dfcb43@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5667c93a-408f-3802-b168-f3a145dfcb43@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:20:27PM +0200, Konrad Dybcio wrote:
> On 26.07.2023 19:18, Stephan Gerhold wrote:
> > On Wed, Jul 26, 2023 at 06:25:44PM +0200, Konrad Dybcio wrote:
> >> Some buses need additional manual adjustments atop the usual
> >> calculations. Fill in the missing coefficients.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > 
> > What about the funny util-fact/vrail-comp on the mas-apps-proc node
> > downstream?
> Can't see it neither on msm-5.4 (with the icc API) nor in the 4.19 (msmbus)
> device tree.
> 

Not sure where to get up-to-date device trees nowadays. The AOSP repo
I was looking at has this commit where it was added:
https://android.googlesource.com/kernel/msm-extra/devicetree/+/02f8c342b23c20a5cf967df649814be37a08227c%5E%21/#F0

Stephan
