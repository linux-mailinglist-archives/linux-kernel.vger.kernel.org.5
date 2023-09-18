Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93EF7A533F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjIRTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRTrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:47:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728548F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:47:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85BBC433C9;
        Mon, 18 Sep 2023 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695066467;
        bh=ewvdOKMJiJkXoXzc+h132xxTW89f9qi+QEhmHjAqHsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RfTEKuAy8jLjjuWXkRdfn/hGnmvYFUCfWoPOiIQ/XZYIGIGYuZR7PNwQ+UbGSSYcU
         kXH2kUhNHsCrhF/ymroD3V808e5Q+hss4Zmj8l/Rxs3W+/2FR9yFHM+UVuFp4pbVW4
         UAjvVQU/1IGvwK+wRMFt3TgDu7Und3b6+6MKi7nlzIeQKexugEhJZiwyTPZ5ow65XW
         zJSOL7gIZ1ub5Gch+g7PHZ8+fNUxcyoqs57G9F6LBfyf++GKeoH04jQBtPuDlcA7a4
         ohvadedFu6yUU5onAzhDYDcXmAVXjSFwGWXQrlEXnaL6Bshpcoyfd0Z6GCN7g/tzRm
         U77lQjwzOq1vQ==
Received: (nullmailer pid 1577852 invoked by uid 1000);
        Mon, 18 Sep 2023 19:47:44 -0000
Date:   Mon, 18 Sep 2023 14:47:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        William-tw Lin <william-tw.lin@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/3] dt-bindings: hwinfo: Add mtk-socinfo driver
Message-ID: <20230918194744.GA1572413-robh@kernel.org>
References: <20230915152607.18116-1-william-tw.lin@mediatek.com>
 <20230915152607.18116-4-william-tw.lin@mediatek.com>
 <3e7bc476-ffc7-fb07-8e64-246427da736c@linaro.org>
 <9acc8d99-e3db-3df8-4051-21d95450b28d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9acc8d99-e3db-3df8-4051-21d95450b28d@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:47:53AM +0200, AngeloGioacchino Del Regno wrote:
> Il 17/09/23 10:26, Krzysztof Kozlowski ha scritto:
> > On 15/09/2023 17:26, William-tw Lin wrote:
> > > dt-binding documentation for mtk-socinfo driver.
> > 
> > Here and in subject, drop driver and instead descrbe hardware.
> > 
> > > mtk-socinfo driver provides SoC-related information.
> > > Such information includes manufacturer information, SoC name,
> > > SoC segment name, and SoC marketing name.
> > > 
> > > Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
> > > ---
> > >   .../bindings/hwinfo/mtk-socinfo.yaml          | 48 +++++++++++++++++++
> > >   1 file changed, 48 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
> > > new file mode 100644
> > > index 000000000000..74f03f1dc404
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
> > 
> > Nothing improved.
> > 
> > This is a friendly reminder during the review process.
> > 
> > It seems my previous comments were not fully addressed. Maybe my
> > feedback got lost between the quotes, maybe you just forgot to apply it.
> > Please go back to the previous discussion and either implement all
> > requested changes or keep discussing them.
> > 
> > Thank you.
> > 
> > > @@ -0,0 +1,48 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/hwinfo/mtk-socinfo.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: MediaTek SoC ChipID
> > > +
> > > +maintainers:
> > > +  - William Lin <william-tw.lin@mediatek.com>
> > > +  - Matthias Brugger <matthias.bgg@gmail.com>
> > > +  - Kevin Hilman <khilman@kernel.org>
> > > +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > +
> > > +description:
> > > +  MediaTek SoCs store various product information in eFuses, including
> > > +  Chip ID and Revision fields, usable to identify the manufacturer,
> > > +  SoC version, plus segment and marketing names.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: mediatek,socinfo
> > 
> > What happened to compatibles? No, this is just wrong and no explained.
> > You ignored other comments as well. Really, that's not the way to go.
> > 
> 
> Practically, having different compatibles for each SoC is not needed, as
> the only thing that changes between SoCs is the eFuse(s) that you read to
> get the information - and that's all.
> 
> So ... we either use this driver with devicetree, giving it the right eFuses
> to read from, or we duplicate the mtk-efuse driver, or we statically assign
> the eFuses in the driver itself and we set compatibles like
> "mediatek,mt8195-socinfo" to select that... ideas?

So this one is just a virtual device to instantiate a driver and there 
is no socinfo hw block? If so, that's definitely a NAK. Either 
instantiate your socinfo driver from the efuse driver or register as a 
socinfo provider in it.

Rob
