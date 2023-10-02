Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AE67B56AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbjJBPTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbjJBPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:19:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C15BA9;
        Mon,  2 Oct 2023 08:18:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8BBC433C8;
        Mon,  2 Oct 2023 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696259939;
        bh=lmDK/17Fngc1kg4dfIW5twFn4x3TYjYfw27f9xOXV1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCqYIcaiElzr8NzJqqWeOZ6uFrUZ4guUWrhzXOHEBrJ83s8Qh+S8YDapmP89FXX3u
         an1BWeXkh5f88xSZbwUkpHQRgtF/8vWB0IPHLamfOve3aFziV8Gc2IaXYdRCrTEedZ
         a5c602MEKoFhQ7dM141hFfQFPRidntjWvowpxamXzNkG9Q9BCKP+5ToY2l/eWbUn7D
         0S3TOnbctyds9RXe/rn/K7Vy9b+SwEJESDaEInLyGIm1XCCj+mFbsGemYDbwvugeTQ
         cRxG/pU/lPZeBzAsrsajKnjv54IhI3VTCFaGSF3cjbFnPOMy3bI3t9F65cpPeSeioq
         4RyJnIwSZYKcQ==
Received: (nullmailer pid 1747003 invoked by uid 1000);
        Mon, 02 Oct 2023 15:18:56 -0000
Date:   Mon, 2 Oct 2023 10:18:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     Philip Molloy <pmolloy@baylibre.com>,
        linux-staging@lists.linux.dev, Axel Haslam <ahaslam@baylibre.com>,
        Apelete Seketeli <aseketeli@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: Re: [PATCH v3 01/27] dt-bindings: iio: resolver: add devicetree
 bindings for ad2s1210
Message-ID: <169625993628.1746950.6393858750841663279.robh@kernel.org>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
 <20230929-ad2s1210-mainline-v3-1-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929-ad2s1210-mainline-v3-1-fa4364281745@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 29 Sep 2023 12:23:06 -0500, David Lechner wrote:
> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> This adds new DeviceTree bindings for the Analog Devices, Inc. AD2S1210
> resolver-to-digital converter.
> 
> Co-developed-by: Apelete Seketeli <aseketeli@baylibre.com>
> Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v3 changes:
> * Expanded top-level description of A0/A1 lines.
> * Added required voltage -supply properties. (I did not pick up Rob's
>   Reviewed-by since I wasn't sure if this was trivial enough.)
> 
> v2 changes:
> * Add Co-developed-by:
> * Remove extraneous quotes on strings
> * Remove extraneous pipe on some multi-line descriptions
> 
>  .../bindings/iio/resolver/adi,ad2s1210.yaml        | 177 +++++++++++++++++++++
>  1 file changed, 177 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

