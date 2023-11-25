Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4C57F8CC1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjKYR2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjKYR17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:27:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50334127
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:28:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20319C433C8;
        Sat, 25 Nov 2023 17:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700933285;
        bh=SdEIJH9TzgPXfaP1Q2Dpkp+FAEfYhe/GjdmyR7hDB+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SbQK1jgydoMznxVji1B2PXND/RwJ/X1wxjP/8wICn9krvA2d74vnYLrabHpMu0QjE
         Rm5m3ybwhM1S+daLt0AqhBj1djVoe8E4wjf+6AvOvNc1eSN8gpLg61hyTIDwxDXUdE
         Xfc4mqe5jESNPIgeOoKq3vJeRx/T9Zk8rxc86d1gp8LIWGMzyZxxYdAfAZG9w8nh9v
         RAfM0aUsTPMR5rFn77Tm0AcIT/9KHHcftFqu4pT15XB+PaRuzMye0bsnc4jXMar2UQ
         N2U/0YS1Bxm4W3uzGLZENfXGmj01l9ev3ZY6QoIqnwev29aR4mArPjcn3xjBJN9F25
         ATwXeUnNLoCwQ==
Date:   Sat, 25 Nov 2023 17:27:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Crt Mori <cmo@melexis.com>, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: temperature: add MLX90635 device
 bindings
Message-ID: <20231125172758.04b0254e@jic23-huawei>
In-Reply-To: <ea997987-6a84-445c-a806-527d766569b1@kernel.org>
References: <cover.1700648164.git.cmo@melexis.com>
        <2e8b4a7d3ef4bc1c53bd0a849e4c31eaf2477f6b.1700648165.git.cmo@melexis.com>
        <99d1808a-da04-4bc1-a1f7-cbd269adbbf0@kernel.org>
        <CAKv63uv87srZ3gJxFASuGWV6cULXkN=gYi_L=BCcd3dgOFQEfw@mail.gmail.com>
        <ea997987-6a84-445c-a806-527d766569b1@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 13:35:19 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 22/11/2023 13:28, Crt Mori wrote:
> >>> +  Since measured object emissivity effects Infra Red energy emitted,
> >>> +  emissivity should be set before requesting the object temperature.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: melexis,mlx90635  
> >>
> >> It's the same as mlx90632. Add it there (as enum).
> >>  
> > 
> > Properties are the same, but then you can't have much differences for
> > a temperature sensor. It has a bit worse relative measurement error
> > outside of the human body range and overall different DSP, register
> > map, even physical size - it's 1.8x1.8 mm compared to 90632 3x3 mm. I
> > was not sure how it qualifies for adding it as another enum, but I
> > went with the feeling that if it can reuse the driver, then it is an
> > enum, otherwise it is a new file. And I could not reuse anything from
> > 90632.
> > 
> > Thanks for quick feedback and best regards,  
> 
> Driver is independent choice. There is no need for new binding file if
> everything is the same from bindings point of view.
> 
> Best regards,
> Krzysztof
> 
> 

We got this wrong in the past in IIO and it's a slow effort to merge
the various very similar bindings.  For now we are mostly keeping
to within a vendor though unless a driver supports parts from multiple
vendors.  It potentially gets too confusing to maintain otherwise.

This one is easy case though so definitely merge as Krzystof suggested!

Jonathan
