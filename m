Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E8E793AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbjIFLXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjIFLXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:23:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD59BA8;
        Wed,  6 Sep 2023 04:23:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D7FC433C7;
        Wed,  6 Sep 2023 11:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693999398;
        bh=2cHacCoKsTGvLrvk3gCo6G7FHK+qUqCgjYnX8jmR7Dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/xqTkkdHC5oM02n41XHX2EbeUu8Jh1xaGw2Y3HfWE/gLZ2UB1f/X+TJutvHrP2jr
         HmQbZvBkRhbKMj51LJrGoTdkMJO3nkV+cNBziwt8arBvvoUUt34piGjJ1/1f1eu3lv
         cnrURRK/sAB/rMUbADh3EGSf2lcfFsmwVfjPCQNokUGfi1yjZz3zUqsWGcoj3OkPn6
         QA7Wh1dGcTpnzJJyDokgiPL8FaHgLpVuwLr6Wn+jpTmB5Ev2ZJ6wZFpV56OcXp6ZY2
         i9n3fy7AGkQPLse1DpOjmYRN1Hj1Tz5HM+pp2575vQPUk8A6WV9PlZt88ir3GvKalj
         hBG4W9dteX5GA==
Received: (nullmailer pid 992201 invoked by uid 1000);
        Wed, 06 Sep 2023 11:23:16 -0000
Date:   Wed, 6 Sep 2023 06:23:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Fang Xiang <fangxiang3@xiaomi.com>, Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: arm,gic-v3:
 Add dma-noncoherent property
Message-ID: <169399939583.992143.8154908772821151447.robh@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230906094139.16032-1-lpieralisi@kernel.org>
 <20230906094139.16032-2-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906094139.16032-2-lpieralisi@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Sep 2023 11:41:38 +0200, Lorenzo Pieralisi wrote:
> The GIC v3 specifications allow redistributors and ITSes interconnect
> ports used to access memory to be wired up in a way that makes the
> respective initiators/memory observers non-coherent.
> 
> Add the standard dma-noncoherent property to the GICv3 bindings to
> allow firmware to describe the redistributors/ITSes components and
> interconnect ports behaviour in system designs where the redistributors
> and ITSes are not coherent with the CPU.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/interrupt-controller/arm,gic-v3.yaml    | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

