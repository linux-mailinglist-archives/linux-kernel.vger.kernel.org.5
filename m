Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F077CA350
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjJPJER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjJPJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:04:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554A6DE;
        Mon, 16 Oct 2023 02:04:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7C2C433C8;
        Mon, 16 Oct 2023 09:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697447053;
        bh=dExRp4ue+HwGoPfiYWXRdNthCDI/2BlliyqJLiwYqaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vDQoeLyxrYag18/YbNgFMAWyg8UqsTIvw7KCXILbbNfXF/Ma5XbAHyj4asibNORTn
         1NEJukqBWKtpSVRYkbwCjWXSFlCNFTUoODkgWHp1XS555Bi4NByLjSuy78TkKFxhBd
         QWHK/P769cawiLoJYS56XzdQMlCakkMmK2AX2vKJiYfGoZAmWUCbCBt5KMvU2B2MrA
         IbBpllmHCXQhFby3CYsctybZ7mPtT774fX5GPq/tj+bqzvGggIGCuGiTVBoGAR+JuD
         zMK4cKhZhHw/kVO1N2viNzveDxzYSXK4CfK91L8RdayLd3Sovwr/dIse6JyjYV6zUO
         xNH1xsbnCL0jg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qsJWB-0003UZ-1A;
        Mon, 16 Oct 2023 11:04:07 +0200
Date:   Mon, 16 Oct 2023 11:04:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-crd: fix eDP phy compatible
Message-ID: <ZSz8h6fc7R3CiioE@hovoldconsulting.com>
References: <20231016080658.6667-1-johan+linaro@kernel.org>
 <CAA8EJpoPSHfRMgzs69Z-Zk0L8z8_8sveh22pj4ZOAwyAPvesHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoPSHfRMgzs69Z-Zk0L8z8_8sveh22pj4ZOAwyAPvesHQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:53:02AM +0300, Dmitry Baryshkov wrote:
> On Mon, 16 Oct 2023 at 11:07, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > The sc8280xp Display Port PHYs can be used in either DP or eDP mode and
> > this is configured using the devicetree compatible string which defaults
> > to DP mode in the SoC dtsi.
> >
> > Override the default compatible string for the CRD eDP PHY node so that
> > the eDP settings are used.
> >
> > Fixes: 4a883a8d80b5 ("arm64: dts: qcom: sc8280xp-crd: Enable EDP")
> > Cc: stable@vger.kernel.org      # 6.3
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > index 772953dc428e..31a2a2d27f4e 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > @@ -458,6 +458,8 @@ mdss0_dp3_out: endpoint {
> >  };
> >
> >  &mdss0_dp3_phy {
> > +       compatible = "qcom,sc8280xp-edp-phy";
> 
> Same question here as the one I've sent for Konrad's patch. Is it the
> same PHY type, just being repurposed for eDP or is it a different PHY
> type?

Just replied in the other thread:

	https://lore.kernel.org/lkml/ZSz7---IW_7Oj2Zr@hovoldconsulting.com/

Johan
