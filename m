Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A969D7854E3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjHWKHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjHWKHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:07:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA30C93;
        Wed, 23 Aug 2023 03:06:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 21E2F5A4;
        Wed, 23 Aug 2023 12:05:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692785138;
        bh=wxAvkJUYw4KdN2Mb1F0ed7BLqCHwW/jLls5dR63y9Tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cyc8zM//wg/hYM4bq9qJukTYHGx3FoDF1hbSGNQC5nT9sA38RDvWIhB2JmcaZsgsn
         z4ISz3ZNV34edf/m5WCgloDK07kwH7zJpYNBp1D+S6Va5L9OEkZIaFnpRkXohJSnBj
         Y+woov6dDfI5vUqhReVfe636rA5cCutbCzFMa1oc=
Date:   Wed, 23 Aug 2023 13:07:02 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: display: panel: add common
 dual-display schema
Message-ID: <20230823100702.GK4143@pendragon.ideasonboard.com>
References: <20230823081500.84005-1-krzysztof.kozlowski@linaro.org>
 <20230823083427.GB4143@pendragon.ideasonboard.com>
 <61ae58eb-d56c-59c1-81d7-b51322468680@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61ae58eb-d56c-59c1-81d7-b51322468680@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:35:24AM +0200, Krzysztof Kozlowski wrote:
> On 23/08/2023 10:34, Laurent Pinchart wrote:
> > Hi Krzysztof,
> > 
> > Thank you for the patch.
> > 
> > On Wed, Aug 23, 2023 at 10:14:58AM +0200, Krzysztof Kozlowski wrote:
> >> Add schema with common properties shared among dual display panel ICs.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> v2: https://lore.kernel.org/all/20230502120036.47165-1-krzysztof.kozlowski@linaro.org/
> >> v1: https://lore.kernel.org/all/20230416153929.356330-1-krzysztof.kozlowski@linaro.org/
> >>
> >> Changes since v2:
> >> 1. New Patch
> >> ---
> >>  .../display/panel/panel-common-dual.yaml      | 46 +++++++++++++++++++
> >>  1 file changed, 46 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml b/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
> >> new file mode 100644
> >> index 000000000000..83fcd643b5f5
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
> >> @@ -0,0 +1,46 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/display/panel/panel-common-dual.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Common Properties for Dual-Display Panels
> >> +
> >> +maintainers:
> >> +  - Thierry Reding <thierry.reding@gmail.com>
> >> +  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >> +
> >> +description:
> >> +  Properties common for Panel IC supporting dual display panels.
> > 
> > Could you elaborate on what you mean by dual display panels ? From what
> > I understand of the patch series, this seems to be what I have called
> > dual port panels, that is panels that have two input ports to double the
> > bandwidth, but still operate as one display.
> 
> Indeed, looks like that. I don't have the datasheets so I am trying to
> get some pieces of information. Judging by the usage of these panels -
> Qualcomm DSI with qcom,dual-dsi-mode - it indeed is one panel with two
> links.
> 
> I would need to rephrase it.

Thanks :-)

Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.yaml
may be of interest to you, it's a bridge with two LVDS inputs. On the
other side, I've used
Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml which
is an LVDS encoder with a single output, but with the ability to operate
in dual link mode by coupling two encoder instances.

-- 
Regards,

Laurent Pinchart
