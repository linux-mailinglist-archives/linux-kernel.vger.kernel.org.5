Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A737D2E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjJWJW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjJWJWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:22:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C023E5;
        Mon, 23 Oct 2023 02:22:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD316C433C7;
        Mon, 23 Oct 2023 09:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698052955;
        bh=xxhC5tOtxby4AByoAAFFDBGX/Us33zQDixBhJoDvltw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=igPp2sPf71coRtoTSYGvAhHlyCODDTYxnsD9qka8dU8z56NxtsqLpddIKRAGFPNPh
         TitVR6LyvEnKUBnFBRJcoYA7CK/hNZHVPXwiljdT94LCgFad0oOUzDUC/YWJ6zQp5J
         /gjXvKxc077C9Oqf33Wqt9BxZzQ5sYxUHBcbRuFxo7ZpYWZUHuyqjPCyp3wvWsrJhd
         esgYrDnhOIm8YuNGMrtxLxI/sAQoW1kRfth6AG4CuJCSjpjOXMiN0RcUSQq2TRUKyI
         p6r2DFWAjgoke9CSko6H3T/0G/oKszeEZ3dlZsDhY6+p//89eXR26DGtOtrI1lRthx
         z6uxbD4DxwaYg==
Date:   Mon, 23 Oct 2023 10:22:31 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: max8925: Convert to DT schema format
Message-ID: <20231023092231.GB8909@google.com>
References: <20230930202743.214631-1-sebastian.reichel@collabora.com>
 <169627477713.2386676.2358148175794895273.robh@kernel.org>
 <20231020232121.ude4ciuweyoqh2ws@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020232121.ude4ciuweyoqh2ws@mercury.elektranox.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2023, Sebastian Reichel wrote:

> Hi Lee,
> 
> On Mon, Oct 02, 2023 at 02:26:17PM -0500, Rob Herring wrote:
> > On Sat, 30 Sep 2023 22:27:43 +0200, Sebastian Reichel wrote:
> > > Convert the binding to DT schema format.
> > > 
> > > The sub-functions of this MFD device do not have their own compatible
> > > string and are thus described directly in the MFD binding document
> > > after being converted to YAML.
> > > 
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > > Changes since PATCHv2:
> > >  * https://lore.kernel.org/all/20230922233142.1479677-1-sebastian.reichel@collabora.com/
> > >  * Add unevaluatedProperties: false to regulators subnode (Krzysztof Kozlowski)
> > >  * Use "pmic" for nodename (Krzysztof Kozlowski)
> > > 
> > > Changes since PATCHv1:
> > >  * https://lore.kernel.org/all/20210413153407.GA1707829@robh.at.kernel.org/
> > >  * Update License to GPL OR BSD
> > >  * Add missing type references pointed out by Rob
> > > ---
> > >  .../leds/backlight/max8925-backlight.txt      |  10 --
> > >  .../devicetree/bindings/mfd/max8925.txt       |  64 --------
> > >  .../bindings/mfd/maxim,max8925.yaml           | 145 ++++++++++++++++++
> > >  .../bindings/power/supply/max8925_battery.txt |  18 ---
> > >  4 files changed, 145 insertions(+), 92 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/leds/backlight/max8925-backlight.txt
> > >  delete mode 100644 Documentation/devicetree/bindings/mfd/max8925.txt
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max8925.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/power/supply/max8925_battery.txt
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> I expect this will go through your tree and I don't need an
> immutable branch, since all further fixes on the binding would
> go into your tree anyways.
> 
> Also please note, that I put you in as maintainer, since the
> original people working on max8925 long vanished and you are the
> maintainer of MFD (and backlight). Please tell me if you have a
> better suggestion.

That's not my email address. :)

-- 
Lee Jones [李琼斯]
