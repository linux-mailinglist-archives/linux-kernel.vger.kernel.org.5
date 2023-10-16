Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAAB7CA15A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjJPIMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJPIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:12:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB870A2;
        Mon, 16 Oct 2023 01:12:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8683DC433C8;
        Mon, 16 Oct 2023 08:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697443956;
        bh=fz3Cis1kkhATM4ksmtk3ODcDUPlOx3/y5Yb4JqsZbG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvM7F7Aa4XQpxQb39kdmZ1vntDfcoRxNTLmAYGiKga+udMNamimeO46Mi9ZyFrk+z
         ME9FPRwaZ+HAB+HuCOpK27MUERmNB+EHJzQAz+qvoWKi/l3sRevukZr2Cj286rMrWy
         LJjmxwGrKxHI+qGcfMcI3Q+gS2x0KsBCsPotuqkosaL91JLENBE5MVFO/hmUOIFggd
         W0afhsR1u3HmH6fAPTKLdQT0SwJqzqBM3w8Pgu6KxLXbKXrtDw47JJqfHoiKluRHP9
         cLsmAKUTRtunZmPcP8X/hH5Y/EVJOUjBte+EIsKKjGUZE7Vd4WyyuiiNaNRWxrv9f+
         jv1piMsVjAovQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qsIiE-0001mM-2o;
        Mon, 16 Oct 2023 10:12:30 +0200
Date:   Mon, 16 Oct 2023 10:12:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: Use the correct DP PHY
 compatible
Message-ID: <ZSzwbmE_grD-giRp@hovoldconsulting.com>
References: <20230929-topic-x13s_edpphy-v1-1-ce59f9eb4226@linaro.org>
 <ZRqFYWtEcuSCauCf@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRqFYWtEcuSCauCf@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 10:54:57AM +0200, Johan Hovold wrote:
> On Fri, Sep 29, 2023 at 06:02:57PM +0200, Konrad Dybcio wrote:
> > The DP PHY needs different settings when an eDP display is used.
> > Make sure these apply on the X13s.
> 
> Good catch. This looks to be more in line with what Bjorn intended.
> 
> You should fix up sc8280xp-crd and sa8295p-adp.dts as well however.

As we discussed off-list, some of the ADP DP PHYs are apparently just
confusingly named "eDP" for some reason so that does not need fixing.

I sent a fix for the CRD here:

	https://lore.kernel.org/all/20231016080658.6667-1-johan+linaro@kernel.org/

> >  &mdss0_dp3_phy {
> > +	compatible = "qcom,sc8280xp-edp-phy";
> 
> Nit: Can you add a newline here after the compatible, please?

Would you mind respinning this one with an added newline here for
consistency, though?

> >  	vdda-phy-supply = <&vreg_l6b>;
> >  	vdda-pll-supply = <&vreg_l3b>;
 
Johan
