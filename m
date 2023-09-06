Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F7B793A90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjIFLCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbjIFLCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:02:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5688A1BB;
        Wed,  6 Sep 2023 04:01:48 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8E58610FC;
        Wed,  6 Sep 2023 13:00:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693998019;
        bh=N42PrMhNFpBpVcotTxriEP2qoUFpOMZJHFS7+bFjaok=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SbEUUI5pMyrnXwxJU2xkWGB3vQ9UYQV+etGxjYlcPOicAP8wxjjuhmJVpuAwShP0P
         insCddr5SyORhex+i/cBhj/ab6frUvXj32AYwauuM7NJD9lkKwYaQOROz3ipbOVZkq
         as2PDOk7YKPIXjBau6fIXyVdcaBAU4Ag979FcxfU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230906093531.GO7971@pendragon.ideasonboard.com>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com> <20230905233118.183140-4-paul.elder@ideasonboard.com> <502fc7b1-a32d-6901-3a45-d2aa0e0c3849@linaro.org> <20230906083237.GL7971@pendragon.ideasonboard.com> <a3ed9856-a87b-5cf6-26b5-ff2b19234a8a@linaro.org> <20230906090058.GB17308@pendragon.ideasonboard.com> <59e07c6a-6f1b-0cc7-dddc-96d2a4050843@linaro.org> <20230906093531.GO7971@pendragon.ideasonboard.com>
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8365-pumpkin: Add overlays for thp7312 cameras
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Wed, 06 Sep 2023 12:01:43 +0100
Message-ID: <169399810391.277971.691693692840899613@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Laurent Pinchart (2023-09-06 10:35:31)
> On Wed, Sep 06, 2023 at 11:21:31AM +0200, Krzysztof Kozlowski wrote:
> > On 06/09/2023 11:00, Laurent Pinchart wrote:
> > >>> has a regulator@0. There are similar instances for clocks.
> > >>>
> > >>> I understand why it may not be a good idea, and how the root node is
> > >>> indeed not a bus. In some cases, those regulators and clocks are gr=
ouped
> > >>> in a regulators or clocks node that has a "simple-bus" compatible. =
I'm
> > >>> not sure if that's a good idea, but at least it should validate.
> > >>>
> > >>> What's the best practice for discrete board-level clocks and regula=
tors
> > >>> in overlays ? How do we ensure that their node name will not confli=
ct
> > >>> with the board to which the overlay is attached ?
> > >>
> > >> Top-level nodes (so under /) do not have unit addresses. If they hav=
e -
> > >> it's an error, because it is not a bus. Also, unit address requires =
reg.
> > >> No reg? No unit address. DTC reports this as warnings as well.
> > >=20
> > > I agree with all that, but what's the recommended practice to add
> > > top-level clocks and regulators in overlays, in a way that avoids
> > > namespace clashes with the base board ?
> >=20
> > Whether you use regulator@0 or regulator-0, you have the same chances of
> > clash.
>=20
> No disagreement there. My question is whether there's a recommended
> practice to avoid clashes, or if it's an unsolved problem that gets
> ignored for now because there's only 36h in a day and there are more
> urgent things to do.

Should an overlay add these items to a simple-bus specific to that
overlay/device that is being supported?

That would 'namespace' the added fixed-clocks/fixed-regulators etc...

But maybe it's overengineering or mis-using the simple-bus.

And the items are still not on a 'bus' with an address - they just exist
on a presumably externally provided board....

--
Kieran
