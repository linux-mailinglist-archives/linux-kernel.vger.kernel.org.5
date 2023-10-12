Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F6E7C776F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442591AbjJLTxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344092AbjJLTxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:53:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF933B7;
        Thu, 12 Oct 2023 12:53:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC183C433C7;
        Thu, 12 Oct 2023 19:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697140420;
        bh=vdUo+JTbMkvfRT17jgp9PVZf+MEVNsEg2boEzxqpBtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iy5DEFk8QIFNrmfI/9jIySRWAZdZAZ04JHrcirtkERRTrrZ6hWC+R6d5razVm5GQB
         asuHH8KFcZ12edeYbOC9HkW9j2CAaNfBDyr0ISycf6044uqcB/1sYVhv6f6SGi9DGs
         ym6PFNcNY+EdV1Y538xCY/gPjqAnFgZE1OTR3iye2NB5abyYX5GCyXq41skvxzd0rG
         22Qc3npVSgg21KkBhTCVLJP4/tgwE+4F5BOjqdt0iqp1hhDDIG7WYNVgGsCYe/tnLb
         mNuQR1LvWVB6If8Rc/AFHCgoIJ9iXHE1vjC4Eo0CQRj45vE5+uQ+BfQiSFLbh/tuqt
         +JFHs+rcug05A==
Received: (nullmailer pid 1580600 invoked by uid 1000);
        Thu, 12 Oct 2023 19:53:37 -0000
Date:   Thu, 12 Oct 2023 14:53:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 2/9] dt-bindings: pinctrl: pinctrl-single: add
 marvell,pxa1908-padconf compatible
Message-ID: <20231012195337.GA1579632-robh@kernel.org>
References: <20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr>
 <20231010-pxa1908-lkml-v6-2-b2fe09240cf8@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010-pxa1908-lkml-v6-2-b2fe09240cf8@skole.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 07:27:19PM +0200, Duje Mihanović wrote:
> Add the "marvell,pxa1908-padconf" compatible to allow migrating to a
> separate pinctrl driver later.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> index 45a307d3ce16..0f7e16a28990 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> @@ -32,6 +32,10 @@ properties:
>                - ti,omap4-padconf
>                - ti,omap5-padconf
>            - const: pinctrl-single
> +      - items:
> +          - enum:
> +              - marvell,pxa1908-padconf

Just add this to the existing enum above.

Rob
