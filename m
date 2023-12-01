Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667E3800385
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377517AbjLAGH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjLAGHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:07:25 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2320193
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:07:31 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77d8c38ea78so89914485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701410851; x=1702015651; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kgy5hlcvWH3mv4+OMDEYg4gGuadNVhIN6Sw8oNb6ClE=;
        b=MprJc8WCS3au6vGnDxfd3X5nt9Lzyovn8sGqZPtTb3RH5vp5Jaa9UiRmNZd/QRwKFs
         xzT5G+6+UDFF1NRNx1iWfDDrMSpMPtTrTEGIfqkTzdQrGVQZbu41QHLM9AMRxliDmhX1
         mpR2ODU+RbBUE3rUIS0v88FZbPLneqp9DiK6udeZE9QuGGx5YcHRYW6b66aLq3z8sV1Z
         hxfaf13MtVd7+cvPI4QI1+646esMflrm3oVnvOoPE1pVrpUftnVCeGRVj7XeJiN5C8Vr
         N2OKBcG6vgY9gh53uco53JQ29aQ40k8ue+GEWPMMj9PWha4DpRXQgYDydPkzOgRCjuCW
         KeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701410851; x=1702015651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kgy5hlcvWH3mv4+OMDEYg4gGuadNVhIN6Sw8oNb6ClE=;
        b=KqDlxu8i+Tn1PklStuwijHGr1ehu395MIFDIi7R11M3cUERiqQcMTRUHfSGeGir25q
         XjGk7HmMFEoLl5dSCr6HcyypxBU9Hq9JsJPdv0FcHAdc1cnzl9KyTM7H9JZAWI9Nspyz
         5xM41fOweZ9z5iPiXf1xMF1GZt3rtI8OWGKrpPBKgL44Vo1ZlZfHoaXVb17rt/W1BGKN
         ngiba1hqC9NV1fljGFXracpSJ/XeCQ5dOPq/0bcsGxpG/dZffPQFuumjcxL2tl1BlD7Q
         iFMQHQPAq/8lPbeJ7IchweABcsBO+wB5w4J2W1El6j9CgnoW+1tYOUeXJKQi0WOG9GPv
         cOxg==
X-Gm-Message-State: AOJu0YxZGVkkMnK6gWNMCu5r7MOXP1OYL8CLGz8m1cGNMAtkU4xIeEuW
        9bgLv7bL+EJFTNKRnEYqmIiR
X-Google-Smtp-Source: AGHT+IHu2ksyKFCtF20WA7pQITHq93w/lCv7QCJfM5F0X7XunthNNyJrRVZbimdwRtLy0LpBiPTuQw==
X-Received: by 2002:a05:620a:34d:b0:77d:cd41:1254 with SMTP id t13-20020a05620a034d00b0077dcd411254mr7559516qkm.12.1701410850808;
        Thu, 30 Nov 2023 22:07:30 -0800 (PST)
Received: from thinkpad ([117.213.102.92])
        by smtp.gmail.com with ESMTPSA id d23-20020a05620a159700b0077d749de2a3sm1199149qkk.67.2023.11.30.22.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 22:07:30 -0800 (PST)
Date:   Fri, 1 Dec 2023 11:37:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_vpernami@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
Message-ID: <20231201060716.GJ4009@thinkpad>
References: <20231127-refclk_always_on-v3-0-26d969fa8f1d@quicinc.com>
 <20231127-refclk_always_on-v3-1-26d969fa8f1d@quicinc.com>
 <78815f1b-7390-40de-8afd-ac71806f4051@linaro.org>
 <24fae40a-453b-b14c-923f-88758a246aa7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24fae40a-453b-b14c-923f-88758a246aa7@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 02:49:18PM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 11/28/2023 2:26 PM, Krzysztof Kozlowski wrote:
> > On 27/11/2023 13:13, Krishna chaitanya chundru wrote:
> > > Document qcom,refclk-always-on property which is needed in some platforms
> > > to supply refclk even in PCIe low power states.
> > > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml        | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> > > index 2c3d6553a7ba..c747c9f35795 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> > > @@ -93,6 +93,13 @@ properties:
> > >     "#phy-cells":
> > >       const: 0
> > > +  qcom,refclk-always-on:
> > > +    type: boolean
> > > +    description: In some platform where PCIe switch is connected, pcie switch due to some design
> > You received a comment to use proper wrapping: 80. Please implement it.
> I will update this.
> > > +      limitation fails to propage clkreq signal to the host and due to that host will not send
> > > +      refclk, which  results in linkdown in L1.2 or L1.1 exit initiated by EP.
> > > +      This property if set keeps refclk always on even in Low power states.
> > The property name suggests that's the state of hardware - refclk is
> > always on. Description suggests you want to instruct OS to do something.
> > 
> > Again, third time (once from Bjorn, once from Dmitry), rephrase property
> > name and description to describe the hardware issue. I see description
> > improved, but not the property name. Again in the end of description you
> 
> Both bjorn and Dmitry gave comments to change the description only, and not
> the property name,
> 
> correct if I am wrong.
> 
> > say what Linux should do. Bindings do not describe Linux OS.
> 
> I will remove the last line in the next patch.
> 

You should name the property as, "qcom,keep-refclk-always-on"

Also, no need to stuff the binding with "why this property is required", that
info should be part of the patch description. Just describe what this property
means in binding.

- Mani

> - Krishna Chaitanya.
> 
> > 
> > Best regards,
> > Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
