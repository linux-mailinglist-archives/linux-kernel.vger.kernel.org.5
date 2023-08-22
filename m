Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2259784389
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjHVOLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjHVOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:11:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD77ECD8;
        Tue, 22 Aug 2023 07:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BED8265846;
        Tue, 22 Aug 2023 14:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EA2C433C8;
        Tue, 22 Aug 2023 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713403;
        bh=Yrio1+MIXekBbT7kfTvlmqJb0m4Lpl2n4vkxBi00PvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MT3SeEBDslGb+2TtMUzNhq2BN0eRSFYe5l1uI435qxp/llbpjCnmj6Q+kHIQwlfHe
         fkZ2lceokb5vflfrN50dev4Pw6Z1ytJ0ixdIRjAACYB1zqXgOT1sa/dwtys80rMCM/
         tta5sU29d2lXvCuUxu5xgEv/jL17SGaElEEzIMrfkR31Jx+fzjT4qAdHJ4Pjs4KQej
         vow7pKJe23lyoPULxs5pu2WgYREbQIz4QobnCbCt/LP0TvlHtWL6wu56Di5GRaS/MM
         0vj3fx9l+CX741gV1PTbhyhQgtqtAua+6Pa3s6qFVuHPtZsVP/8METZQh80whaatEk
         9LdzOsyDvIY5Q==
Date:   Tue, 22 Aug 2023 19:39:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        JaeHun Jung <jh0801.jung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: phy: samsung,usb3-drd-phy: Add
 Exynos850 support
Message-ID: <ZOTBtz/DBTXSsulS@matsya>
References: <20230819031731.22618-1-semen.protsenko@linaro.org>
 <20230819031731.22618-3-semen.protsenko@linaro.org>
 <517510a4-ab77-c34e-0fcb-33761786936f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <517510a4-ab77-c34e-0fcb-33761786936f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-08-23, 09:11, Krzysztof Kozlowski wrote:
> On 19/08/2023 05:17, Sam Protsenko wrote:
> > Document Exynos850 compatible. USB 2.0 DRD PHY on Exynos850 has two
> > clocks (ref and phy), which is already described in bindings.
> > 
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> 
> You should probably split the patchset between separate subsystems, so
> Greg and Vinod can easily pick up their parts.

Yes I agree :-) if there is NO dependency pls split them!

> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof

-- 
~Vinod
