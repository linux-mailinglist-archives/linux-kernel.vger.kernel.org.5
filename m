Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E047F94B0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjKZRsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZRsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:48:24 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C1DD;
        Sun, 26 Nov 2023 09:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=P+MMY/H9HFvWRq/TZPXfzpfMq3RLmEgdkEE9wrSqusE=; b=ZK1Xn+aVbP+grqplmNoNPl/JFs
        tdqVCS3ZE4Jt1ffDtrPn4OMhzm4zhF1OO/YzWxla+LZx6dFXZPsIuvOEz/1WMe8lk47VLg12prwn2
        Tl1HVsDqUmWdr6SlgvLkVUkqNY0LGcaMsQis5uj6R/afxgJMm+a5uq60ZNlRtVNdWnaU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r7JEr-001GJ7-Ig; Sun, 26 Nov 2023 18:48:13 +0100
Date:   Sun, 26 Nov 2023 18:48:13 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] docs: dt-bindings: add DTS Coding Style document
Message-ID: <4fa1e860-48bd-456b-ab0b-88215c2b8d1b@lunn.ch>
References: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
 <a3b65c90-afc9-4caf-8744-112369a838d2@lunn.ch>
 <15292222-39b3-4e9e-a6c1-26fba8f5efcd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15292222-39b3-4e9e-a6c1-26fba8f5efcd@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 11:38:38AM +0100, Krzysztof Kozlowski wrote:
> On 25/11/2023 20:47, Andrew Lunn wrote:
> >> +=====================================
> >> +Devicetree Sources (DTS) Coding Style
> >> +=====================================
> >> +
> >> +When writing Devicetree Sources (DTS) please observe below guidelines.  They
> >> +should be considered complementary to any rules expressed already in Devicetree
> >> +Specification and dtc compiler (including W=1 and W=2 builds).
> >> +
> >> +Individual architectures and sub-architectures can add additional rules, making
> >> +the style stricter.
> > 
> > It would be nice to add a pointer where such rules are documented.
> 
> Subsystem profile or any other place. The generic doc should not point
> to specific ones.

That is not so friendly for a developer. A reviewer points out that a
file is not consistent with the coding style. So they go away and fix
it, as described here. They then get a second review which say, no,
you to do X, Y and Z, despite them actually following the coding
style.

Maybe add to the paragraph above:

These further restrictions are voluntary, until added to this
document.

This should encourage those architectures to document their coding
style.

> The root node is a bit special, but other than that mixing nodes with
> and without unit address is discouraged practice.

If the root node is special, maybe it needs a few rules of its own?
All properties without an address come first, then properties with
addresses. Sorting within these classes follow the normal rules
already stated?

> >> +Indentation
> >> +-----------
> >> +
> >> +1. Use indentation according to :ref:`codingstyle`.
> >> +2. For arrays spanning across lines, it is preferred to align the continued
> >> +   entries with opening < from the first line.
> >> +3. Each entry in arrays with multiple cells (e.g. "reg" with two IO addresses)
> >> +   shall be enclosed in <>.
> >> +
> >> +Example::
> >> +
> >> +	thermal-sensor@c271000 {
> >> +		compatible = "qcom,sm8550-tsens", "qcom,tsens-v2";
> >> +		reg = <0x0 0x0c271000 0x0 0x1000>,
> >> +		      <0x0 0x0c222000 0x0 0x1000>;
> >> +	};
> > 
> > I'm not sure i understand this. Is this example correct?
> > 
> >                 gpio-fan,speed-map = <0    0
> >                                       3000 1
> >                                       6000 2>;
> > 
> > It exists a lot in todays files.
> 
> Depends on the binidng. Is it matrix? If yes, then it is not correct.

It seems to me, rules 2 and 3 should be swapped. You can only align
the <, if you have <. So logically, the rule about having < should
come first.

     Andrew
