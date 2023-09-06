Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57F793AD9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbjIFLOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjIFLOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:14:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B30DCFF;
        Wed,  6 Sep 2023 04:14:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (ftip006315900.acc1.colindale.21cn-nte.bt.net [81.134.214.249])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BFC44283;
        Wed,  6 Sep 2023 13:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693998769;
        bh=AQq3rEfJzkraL3WBQ5gV4/xZ6makPLqqmlJnfXoE3io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2N+FLau4PxGx+LQpHMmqzlTxOuTtEhXfFZiohfI+g33WDbMPqaGhdPhTVhEP2jyp
         wN5w0kRIT+mUBr/4d2mODnoWE/QoCjfuh+MVl72PMk7Q+gNduK0uydH2T5K4uIOxIu
         ENZsc1WHRFAd13ZUaSWyF7zxJRIRo/mdo5rNWYG8=
Date:   Wed, 6 Sep 2023 14:14:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8365-pumpkin: Add overlays
 for thp7312 cameras
Message-ID: <20230906111429.GC17308@pendragon.ideasonboard.com>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-4-paul.elder@ideasonboard.com>
 <502fc7b1-a32d-6901-3a45-d2aa0e0c3849@linaro.org>
 <20230906083237.GL7971@pendragon.ideasonboard.com>
 <a3ed9856-a87b-5cf6-26b5-ff2b19234a8a@linaro.org>
 <20230906090058.GB17308@pendragon.ideasonboard.com>
 <59e07c6a-6f1b-0cc7-dddc-96d2a4050843@linaro.org>
 <20230906093531.GO7971@pendragon.ideasonboard.com>
 <169399810391.277971.691693692840899613@ping.linuxembedded.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169399810391.277971.691693692840899613@ping.linuxembedded.co.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 12:01:43PM +0100, Kieran Bingham wrote:
> Quoting Laurent Pinchart (2023-09-06 10:35:31)
> > On Wed, Sep 06, 2023 at 11:21:31AM +0200, Krzysztof Kozlowski wrote:
> > > On 06/09/2023 11:00, Laurent Pinchart wrote:
> > > >>> has a regulator@0. There are similar instances for clocks.
> > > >>>
> > > >>> I understand why it may not be a good idea, and how the root node is
> > > >>> indeed not a bus. In some cases, those regulators and clocks are grouped
> > > >>> in a regulators or clocks node that has a "simple-bus" compatible. I'm
> > > >>> not sure if that's a good idea, but at least it should validate.
> > > >>>
> > > >>> What's the best practice for discrete board-level clocks and regulators
> > > >>> in overlays ? How do we ensure that their node name will not conflict
> > > >>> with the board to which the overlay is attached ?
> > > >>
> > > >> Top-level nodes (so under /) do not have unit addresses. If they have -
> > > >> it's an error, because it is not a bus. Also, unit address requires reg.
> > > >> No reg? No unit address. DTC reports this as warnings as well.
> > > > 
> > > > I agree with all that, but what's the recommended practice to add
> > > > top-level clocks and regulators in overlays, in a way that avoids
> > > > namespace clashes with the base board ?
> > > 
> > > Whether you use regulator@0 or regulator-0, you have the same chances of
> > > clash.
> > 
> > No disagreement there. My question is whether there's a recommended
> > practice to avoid clashes, or if it's an unsolved problem that gets
> > ignored for now because there's only 36h in a day and there are more
> > urgent things to do.
> 
> Should an overlay add these items to a simple-bus specific to that
> overlay/device that is being supported?
> 
> That would 'namespace' the added fixed-clocks/fixed-regulators etc...
> 
> But maybe it's overengineering or mis-using the simple-bus.

You would still need to name the node that groups the regulators and
clocks in a way that wouldn't clash between multiple overlays and the
base board. It would be nice to have nodes that are "private" to an
overlay.

> And the items are still not on a 'bus' with an address - they just exist
> on a presumably externally provided board....

-- 
Regards,

Laurent Pinchart
