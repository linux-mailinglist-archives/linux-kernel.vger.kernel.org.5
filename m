Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BEA802F21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjLDJra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjLDJrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:47:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D517100
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:47:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091F9C433C7;
        Mon,  4 Dec 2023 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701683251;
        bh=NH8cg+cJw4u4aOtEuZrNuL2Wt2x8+s9YJY7ecsjb6ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3cpLYDtpuujRrytU+r+NrUsaHBHcnRvBvd/wD2QIZWlJ0pCHCdE+wMaXeAUqTMbz
         WzA6BS4CRxyA9k/S91yLilxMmS6zLQesCjvLEPdk+7F1gzVGrxsNtVhaUegSsKLNwW
         8AbX8f9MQkN/0aWQcyrGY1zsAFqs3z18/puJphsqLeHOsq1hFnnH23D8XktRc0v++K
         +o9px/Zh6SXyQuDqHGo27ZdlLkonr2DuoF5NcaXvxF6ncD9B7JLqg8QfaF/Wbb4928
         RHImSJN11QqULHdiBE1XFB3mz3ZGqrrdpEZhBo9wEMe6rImO5p6YQQj54HW/aF8OGf
         qvCjqbuph1i1g==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rA5Yg-0000N9-3D;
        Mon, 04 Dec 2023 10:48:11 +0100
Date:   Mon, 4 Dec 2023 10:48:10 +0100
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
Message-ID: <ZW2gWhzMV0FiB9oM@hovoldconsulting.com>
References: <20231130172834.12653-1-johan+linaro@kernel.org>
 <20231201144320.GA977713-robh@kernel.org>
 <ZWoQXHnQbJuoxmw0@hovoldconsulting.com>
 <CAL_JsqKh=MG_8TtKap5LvUY-u=KTdGrpb-Sf7MAd1JNqQGue8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKh=MG_8TtKap5LvUY-u=KTdGrpb-Sf7MAd1JNqQGue8Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 01:51:06PM -0600, Rob Herring wrote:
> On Fri, Dec 1, 2023 at 10:56 AM Johan Hovold <johan@kernel.org> wrote:
> > On Fri, Dec 01, 2023 at 08:43:20AM -0600, Rob Herring wrote:

> > > This is fine, but I prefer these MFDs have 1 complete example rather
> > > than piecemeal examples for each child device.
> >
> > Yeah, this is not ideal. The closest thing we've got are the examples
> > in:
> >
> >         Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> >
> > Are you suggesting eventually dropping the examples from the child node
> > bindings and adding (several) complete examples in the parent one?
> 
> Yes, but if the child nodes are truly reused across multiple PMICs
> then, it is probably a worthwhile exception. There's not a great deal
> of reuse on most MFDs.

Yes, they are indeed reused by multiple PMICs in this case.
 
> > I guess there would need to be more than one if you want to cover all
> > the various child nodes with real examples.
> 
> We don't want examples to be exhaustive permutations of every
> possibility either.

Not every possible permutation but I guess we'd want coverage of all the
various child nodes still (i.e. the child node examples that would have
been removed).

Johan
