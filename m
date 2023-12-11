Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C9280C158
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjLKGbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjLKGbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:31:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6976E9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 22:31:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96050C433C7;
        Mon, 11 Dec 2023 06:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702276274;
        bh=1UR/8Pgn6x9/GIOen//ufXC9UJE3MESdFkpeRuRU6eY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Id1d1h9cPtfeRpQh1xeNBJ7U16PgqN5ObnLGNB3xt4Z5F3Xv8RLsyLlV7Dh2ccO6H
         px37LqnMNQbLXatiUKgNjWZd5T/OqoXec89+sYipmc8iN/qWucaU1T5HJBJDL9z5N4
         Zre26yqquDl3RBofbZofoU/uc0w6coVBJvuxDjwkIGdSkYO6DfIbQ/0QItE+yKfZh4
         uk2xzqjWZzS9gsOMPFAKM0CGODsYOzOSKC1EGRllmjNG0JvllzfB96Hijt54EEuweL
         2aAyWFMpEvT/iVVvRj8RUmpBtwMFQBv5O5zEK9hM5TeijIaCrAkHLUKYwbHR1sBNuJ
         E+mTG07AAJaFQ==
Date:   Mon, 11 Dec 2023 12:01:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: Drop undocumented examples
Message-ID: <ZXasrcpZ+ChRsKpz@matsya>
References: <20231122235050.2966280-1-robh@kernel.org>
 <CAL_JsqKrpWoHxU1=FaCkJCg-E5G6JjudjsiUvv4cdQVyKM88KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKrpWoHxU1=FaCkJCg-E5G6JjudjsiUvv4cdQVyKM88KQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-12-23, 14:59, Rob Herring wrote:
> On Wed, Nov 22, 2023 at 5:50 PM Rob Herring <robh@kernel.org> wrote:
> >
> > The compatibles "ti,omap-sdma" and "ti,dra7-dma-crossbar" aren't documented
> > by a schema which causes warnings:
> >
> > Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /example-0/dma-controller@48000000: failed to match any schema with compatible: ['ti,omap-sdma']
> > Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-dma-crossbar']
> >
> > As no one has cared to fix them, just drop them.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/dma/dma-controller.yaml   | 15 ---------------
> >  .../devicetree/bindings/dma/dma-router.yaml       | 11 -----------
> >  2 files changed, 26 deletions(-)
> 
> Vinod, Can you pick this up please.
> 
> As pointed out, examples don't document anything. "ti,omap-sdma" is
> not documented at all (though in use). "ti,dra7-dma-crossbar" is
> documented in dma/ti-dma-crossbar.txt and there's still an example
> there.

Sure, queued up now

-- 
~Vinod
