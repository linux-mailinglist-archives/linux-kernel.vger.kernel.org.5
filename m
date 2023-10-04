Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CAC7B7800
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbjJDGjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbjJDGjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:39:33 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAEFC9;
        Tue,  3 Oct 2023 23:39:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8BDBF5C01F0;
        Wed,  4 Oct 2023 02:39:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 04 Oct 2023 02:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696401565; x=1696487965; bh=lU
        GfhBqBuGOF2WqH7B7CEbLvJivN4dqqF6NaBJOOyGc=; b=F/pP0QCxETm3L6/AwZ
        r++e+vOKdYBxHRNi/24gX/PUhZlp94ZHqYyGJDUtbagBYI4HypFhAmobV7td6fuY
        VnqQ8sYuNWr9HGnE1rxLd1/RiQuWcbno0I10cKn6tK7ebTOnV0UmOG/Qcka5Kt9Z
        evQpZxB/0JDcrJpAM48EiZKGDQ5zhlIVHwdlljFJqb699214uh6SG9bzeXQU29IO
        68Q/AYiYjyZkmOzq0DoWvZbfI98F7YKe7ZvcaO50hgUu75kYdSBdIY+y0DkX+F7e
        ErYXHAG9qJUjstsD1IlVNLuMyhj4nB7nrFQ4gnXs1qOuQaoLHLNggNBDSqmtRHLP
        3s8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696401565; x=1696487965; bh=lUGfhBqBuGOF2
        WqH7B7CEbLvJivN4dqqF6NaBJOOyGc=; b=SLlJ/J4nDcvutfkF/Dlyn5SjbJwcX
        LYDg7FaKfHcislS/3s117WArk1UJlE4MYsVALW72Z9zn3SrWUXZAsi2nV7RRFDmA
        +ql0tUVWzVDsB5zVxeIg5Z+DCihkoh3euiQ8G7SPXiVS4ffr5f2RMoLspgChwcj6
        C4IImM0ZsHNZkFhdEFhA+GJsOmJ8XhNM36CevpOj6rNWH7m3NAnoXNSgMcKu5wYh
        mdFkBfsllMrQEErvyLis3EqMfXxj8aydMWbe2pBJFBiBcEdMO7qD0RML2rQMb5tp
        M7CaIlotPxfCt2eaylZRIjLJfpvFVtSUDRDwG9Rxd9W35WY9ll+33nkig==
X-ME-Sender: <xms:nQgdZc-uV1ze1z9EFl1HMNzhSJOvIV-vqS_c6OXHCSyObCUX2EwC9A>
    <xme:nQgdZUuELQm_uP6ELoI3JgxwswRFhai5n2e-fLr0uuH989-jQnTczyhwi9G-o13E_
    o87RFC2cigNqQ>
X-ME-Received: <xmr:nQgdZSAOwcO9TnvPcfF13wavRVkjrJ3UTQxmdHsQv8KMjLJywT9fZxpDaXPbR2hIqNLOUjKabl5199JunBb6RFhx9EsFAJs8OF6xtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedugddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:nQgdZccvR9ZvxHfZ8db1mbQgqjR3h_Ghd6Bw8hofrGQtNGdgXU-TvA>
    <xmx:nQgdZRPm8wqcX4X_DiCKCDXy0zvyu-BEkbF9cLlt9_Vpp9vdjsZv2w>
    <xmx:nQgdZWmk-N751P95kEbITDNEXaa_fkc_VFuFwUaFVNn6YlsIUpKIGQ>
    <xmx:nQgdZVltsKGk0xGfqVCGDjzx48jnsezGLvT98iNSXfCo4zbqwSe-2w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Oct 2023 02:39:24 -0400 (EDT)
Date:   Wed, 4 Oct 2023 08:39:23 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: Re: linux-next: manual merge of the phy-next tree with the usb tree
Message-ID: <2023100415-thinly-condense-9c9c@gregkh>
References: <20231004130034.7b1c5b89@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004130034.7b1c5b89@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 01:00:34PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the phy-next tree got a conflict in:
> 
>   Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> 
> between commit:
> 
>   df55d4f814f9 ("dt-bindings: phy: qcom,qmp-usb: Add SDX75 USB3 PHY")
> 
> from the usb tree and commit:
> 
>   15c83637402c ("dt-bindings: phy: migrate QMP USB PHY bindings to qcom,sc8280xp-qmp-usb3-uni-phy.yaml")
> 
> from the phy-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> index d58dd744d5d2,bbdb28cd8029..000000000000
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> @@@ -20,8 -24,14 +24,15 @@@ properties
>         - qcom,qcm2290-qmp-usb3-phy
>         - qcom,sa8775p-qmp-usb3-uni-phy
>         - qcom,sc8280xp-qmp-usb3-uni-phy
> +       - qcom,sdm845-qmp-usb3-uni-phy
> +       - qcom,sdx55-qmp-usb3-uni-phy
> +       - qcom,sdx65-qmp-usb3-uni-phy
>  +      - qcom,sdx75-qmp-usb3-uni-phy
>         - qcom,sm6115-qmp-usb3-phy
> +       - qcom,sm8150-qmp-usb3-uni-phy
> +       - qcom,sm8250-qmp-usb3-uni-phy
> +       - qcom,sm8350-qmp-usb3-uni-phy
> + 
>   
>     reg:
>       maxItems: 1
> @@@ -75,10 -87,17 +88,18 @@@ allOf
>           compatible:
>             contains:
>               enum:
> +               - qcom,ipq6018-qmp-usb3-phy
> +               - qcom,ipq8074-qmp-usb3-phy
>                 - qcom,ipq9574-qmp-usb3-phy
> +               - qcom,msm8996-qmp-usb3-phy
> +               - qcom,msm8998-qmp-usb3-phy
> +               - qcom,sdx55-qmp-usb3-uni-phy
> +               - qcom,sdx65-qmp-usb3-uni-phy
>  +              - qcom,sdx75-qmp-usb3-uni-phy
>       then:
>         properties:
> +         clocks:
> +           maxItems: 4
>           clock-names:
>             items:
>               - const: aux

Looks good to me, thanks!

greg k-h
