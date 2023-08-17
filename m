Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A909D77F0BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348333AbjHQGtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348318AbjHQGtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:49:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3ED2102;
        Wed, 16 Aug 2023 23:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B3126354F;
        Thu, 17 Aug 2023 06:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3674CC433C7;
        Thu, 17 Aug 2023 06:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692254953;
        bh=IXkYdBLbsI0GT2XCBMpjBzrs3RyZNpqPqwpMedObAkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aavae2FT9YcL1IbLaajyDjX9dc2XMi7AbcRA8DxGdOppq9U4HV/NYwweRXQgi8b9r
         rWK4rTLYdigupkioEo+u2uwQp2EDr5uMff8LvPkhWY66xoo+4OZjIu5Vikk2EyI9Is
         KEK42u8YBCGDz7ZF9wlZtcqVH73sqOzF/xAN2VyOKPCqb5dZ+dt5XmO0mJRj5cQWuG
         Kkwo5Oqt/EKCFWaJB5PuMaOkYQkMcurK4leafPqYNLi7o1R2WkBBMegEdYBGAkehoQ
         fJ475Hkq5BG3E8F3kEfm/plJHEWk4oWJ4Yc4IhTrAgVwxqNcE6Ugta8hWwEJ1ugmLT
         /NOtd37ku8kTg==
Date:   Thu, 17 Aug 2023 12:19:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Nitin Rawat <quic_nitirawa@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, agross@kernel.org, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for
 SC7280
Message-ID: <ZN3C5EFFyT5ewdtS@matsya>
References: <20230816154841.2183-1-quic_nitirawa@quicinc.com>
 <20230816154841.2183-2-quic_nitirawa@quicinc.com>
 <CAA8EJpoMFCbHuZcEN3-cxFN94QTG6wfNb52vfwuw6qLOfmdFyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoMFCbHuZcEN3-cxFN94QTG6wfNb52vfwuw6qLOfmdFyg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-08-23, 23:31, Dmitry Baryshkov wrote:
> On Wed, 16 Aug 2023 at 18:50, Nitin Rawat <quic_nitirawa@quicinc.com> wrote:
> >
> > Document the QMP UFS PHY compatible for SC7280.
> >
> > Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> > ---
> >  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> > index d981d77e82e4..ad78da9c2c1a 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> > @@ -31,6 +31,7 @@ properties:
> >        - qcom,sm8350-qmp-ufs-phy
> >        - qcom,sm8450-qmp-ufs-phy
> >        - qcom,sm8550-qmp-ufs-phy
> > +      - qcom,sc7280-qmp-ufs-phy
> >
> >    reg:
> >      maxItems: 1
> > @@ -110,6 +111,7 @@ allOf:
> >                - qcom,sm8250-qmp-ufs-phy
> >                - qcom,sm8350-qmp-ufs-phy
> >                - qcom,sm8550-qmp-ufs-phy
> > +              - qcom,sc7280-qmp-ufs-phy
> 
> Please keep both lists sorted.

Yes please

-- 
~Vinod
