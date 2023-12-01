Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4DF80072F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378026AbjLAJfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378116AbjLAJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:34:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851CA1717
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:34:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DEFC433C7;
        Fri,  1 Dec 2023 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701423294;
        bh=YCR6MYhh9g03oC/cYfebkjnUExaJ803XaV1NGuO6J4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HfaEgf92hVnYoQxm+r7YT5RTyUpmLkBWTao220AIMOeVFbGedRB3sCzjBW6Dw5g1o
         pimvKggU5SEfRIGvF5cX0T4twBk2rCgLGbxslb7yYhzGP1F7iNQfiqE+c4K80lX9Ad
         oGXdn5u7pIhjSh+h/+laH/FX+imqbuilE6GDol5QCO0BNbKTcwQBGsYktfjrJR/7Ib
         2I/QGFbnR0yuVstraPOikyFUPEgxZfoal6VD3hDoagaWEHzITxZIr8oiKTia3eOlQJ
         Irh9w+E9rBbGzz9s4oCLr+dFbLyDG1r24D7AkacTiqhDwlK2ZUjZ7bOwFwS1tBcUG3
         LeSLVp22NnvrA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r8zvl-0003GP-1F;
        Fri, 01 Dec 2023 10:35:29 +0100
Date:   Fri, 1 Dec 2023 10:35:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: thermal: qcom-spmi-adc-tm5/hc: clean up
 examples
Message-ID: <ZWmo4byuaU6VAYmn@hovoldconsulting.com>
References: <20231130174114.13122-1-johan+linaro@kernel.org>
 <20231130174114.13122-3-johan+linaro@kernel.org>
 <5fca9859-35bd-4138-a461-203bee36c8e1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fca9859-35bd-4138-a461-203bee36c8e1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:28:48AM +0100, Krzysztof Kozlowski wrote:
> On 30/11/2023 18:41, Johan Hovold wrote:
> > Clean up the examples by adding newline separators, moving 'reg'
> > properties after 'compatible' and dropping unused labels.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml          |  5 +++--
> >  .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml | 10 ++++++----
> >  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> This and previous patch are both trivial cleanups, so probably should be
> squashed together. Anyway:

I didn't want to mix too many things in one patch, and as I just
mentioned in another reply, I consider the "spmi" parent node name to be
more than just a naming cleanup as calling the node "spmi" indicates
that these "devices" are SPMI devices themselves, rather than part of an
SPMI PMIC.

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks again.

Johan
