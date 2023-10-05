Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269F37BA30D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjJEPvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjJEPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:50:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1173A78923;
        Thu,  5 Oct 2023 07:13:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7E2C43397;
        Thu,  5 Oct 2023 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696515221;
        bh=QpGmCqU0pUYx3+Z24KLDIJS/wI6gYoTWqGYIY7fYRaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mY+hJD0MBcdzVOEqUF+5VxIfvCUs8WK+NVgBaobb0A3SFm+PSIpJe3nucjLjrRBox
         Uzk/ZeufQph9nYnqcJmeoojK+igOxPidJaeE6+kURBSE3summTGVE2+Oat3ooLJt/j
         BMurimxaWy8lznH4RROlLimfOtbvvHPz76/OEgU2evc284gz4IuzFpRR8FJlpw1Ts1
         LGyjBfr8O1X9pvG3nqoQogDuRnLh6I77H6urjQ0r59Za/h32mFof/GqjDqkRWZCKpX
         tziMOwrhYIJpdYTaSFkLx4EmBARfdbftBEgxpql5AlpBiVnrX8GCBmad9vuezakvyJ
         YUrgiywq7fx5g==
Date:   Thu, 5 Oct 2023 15:13:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     David Lechner <dlechner@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-staging@lists.linux.dev, Axel Haslam <ahaslam@baylibre.com>,
        Apelete Seketeli <aseketeli@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: Re: [PATCH v3 01/27] dt-bindings: iio: resolver: add devicetree
 bindings for ad2s1210
Message-ID: <20231005151343.6703ad69@jic23-huawei>
In-Reply-To: <169625993628.1746950.6393858750841663279.robh@kernel.org>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-1-fa4364281745@baylibre.com>
        <169625993628.1746950.6393858750841663279.robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2023 10:18:56 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri, 29 Sep 2023 12:23:06 -0500, David Lechner wrote:
> > From: David Lechner <david@lechnology.com>
> > 
> > From: David Lechner <dlechner@baylibre.com>
> > 
> > This adds new DeviceTree bindings for the Analog Devices, Inc. AD2S1210
> > resolver-to-digital converter.
> > 
> > Co-developed-by: Apelete Seketeli <aseketeli@baylibre.com>
> > Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > 
> > v3 changes:
> > * Expanded top-level description of A0/A1 lines.
> > * Added required voltage -supply properties. (I did not pick up Rob's
> >   Reviewed-by since I wasn't sure if this was trivial enough.)
> > 
> > v2 changes:
> > * Add Co-developed-by:
> > * Remove extraneous quotes on strings
> > * Remove extraneous pipe on some multi-line descriptions
> > 
> >  .../bindings/iio/resolver/adi,ad2s1210.yaml        | 177 +++++++++++++++++++++
> >  1 file changed, 177 insertions(+)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Jonathan
