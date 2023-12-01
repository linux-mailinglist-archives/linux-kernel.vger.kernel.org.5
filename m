Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F86080110E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378523AbjLAQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjLAQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:47:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FB1F1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:48:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B125C433C8;
        Fri,  1 Dec 2023 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701449285;
        bh=8sMbd6mi2mj87HGmh87batrSeTGY2fLhxpZz+q6caBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eV9nbcis9yjo11yFJxro674gDs6Nfps35naoLGXl05FYu7SdvXh/oJ0gQN/FXRe1e
         euC70GQID5vcLaXK6CkVr4FfafEkR4CVZzOifgDWjIVPo/yG1UpZeVjk4F0cRX8sdd
         x+qujdUr53RdSin6031VsWLZb6U8K4ZOJVcuWcELZuQEvz3LllvcBhVKRhe14h78Bz
         MAB769pdptvulk+10x2MH75ssmwDN0TaS7mHp+wzgyiJVGq72lmJ7SihZfVh82wLQY
         5q63PB1rW1NH9w4V0j7klEavilHb/JsdFNAKldNyPswHObuDktms76eUsj6DLgRYUL
         2vbFSAxwvPXOQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r96gz-0003J8-1E;
        Fri, 01 Dec 2023 17:48:41 +0100
Date:   Fri, 1 Dec 2023 17:48:41 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix
 example regulator node
Message-ID: <ZWoOaRLZGXMhwC_r@hovoldconsulting.com>
References: <20231130172547.12555-1-johan+linaro@kernel.org>
 <20231130172547.12555-3-johan+linaro@kernel.org>
 <20231201144017.GA974717-robh@kernel.org>
 <b2400218-12d6-4d51-ab42-78412f616d88@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2400218-12d6-4d51-ab42-78412f616d88@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:42:38PM +0100, Krzysztof Kozlowski wrote:
> On 01/12/2023 15:40, Rob Herring wrote:
> > On Thu, Nov 30, 2023 at 06:25:45PM +0100, Johan Hovold wrote:
> >> The example regulator child nodes do not have unit addresses so drop the
> >> incorrect '#address-cells' and '#size-cells' properties from the parent
> >> node.
 
> >>        regulators {
> >> -        #address-cells = <1>;
> >> -        #size-cells = <0>;
> >> -
> > 
> > It's the right fix, but I have to wonder why these are not schema 
> > errors? Seems like something in the schemas needs fixing.
> 
> Good point. The fix is just not sufficient.  This binding explicitly
> allow it, so it should be removed there as well.

Ah, I missed that. Now fixed up in v2.

Johan
