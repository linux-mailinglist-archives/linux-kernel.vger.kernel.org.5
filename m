Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E696580114A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378586AbjLAQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjLAQ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:56:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E72D103
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:56:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030EEC433C8;
        Fri,  1 Dec 2023 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701449785;
        bh=g0hUWXr8fHBF5LwtM2iV9DHeqn7uI/hSTUcU8M5jINU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hr/5f5Ne90EKG/RivDinI9FUJrZflIYvW3jITrzd6O2RcfkXYA9UfliyWhvhrLo0B
         cbbPcY6QULpXuIqFoWKPC+2IFa36C/w1S3rnJdiyTYN/81XtIg/2XNTwBW4ydobYsK
         LhnusVk7zGhVkzgPpoJsKjejWGOa9aHW3yDI0jMEKTtDYV5lrARypLuoTRUw51dXzG
         mmDjWG1W4o/r/tRoaDgg/0Dk04MvpNMLkuyOpVLWkbBMtt/I0Jq0lsx22weJZg5KjE
         0Dkh+MJNDIzYIxhi+yzEZIOpqAmgEuaD7KTtOywb+6qk9z4F+tH/E2oP4q7KEdYquY
         tn8VwnSHiQqvg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r96p2-0003LO-1g;
        Fri, 01 Dec 2023 17:57:01 +0100
Date:   Fri, 1 Dec 2023 17:57:00 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: clean up example
Message-ID: <ZWoQXHnQbJuoxmw0@hovoldconsulting.com>
References: <20231130172834.12653-1-johan+linaro@kernel.org>
 <20231201144320.GA977713-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201144320.GA977713-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:43:20AM -0600, Rob Herring wrote:
> On Thu, Nov 30, 2023 at 06:28:34PM +0100, Johan Hovold wrote:
> > The Multi-Purpose Pin controller block is part of an SPMI PMIC (which in
> > turns sits on an SPMI bus) and uses a single value for the register
> > property that corresponds to its base address.
> > 
> > Clean up the example by adding a parent PMIC node with proper
> > '#address-cells' and '#size-cells' properties, dropping the incorrect
> > second register value, adding some newline separators and increasing the
> > indentation to four spaces.
> 
> This is fine, but I prefer these MFDs have 1 complete example rather 
> than piecemeal examples for each child device.

Yeah, this is not ideal. The closest thing we've got are the examples
in:

	Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml

Are you suggesting eventually dropping the examples from the child node
bindings and adding (several) complete examples in the parent one?

I guess there would need to be more than one if you want to cover all
the various child nodes with real examples.

Johan
