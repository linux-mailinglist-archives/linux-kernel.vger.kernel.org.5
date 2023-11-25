Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC217F8C57
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKYQV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKYQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:21:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAF19F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 08:22:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36919C433C8;
        Sat, 25 Nov 2023 16:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700929324;
        bh=47slQ7C1k9AETzS9asZhacrAtG9GZsJQSECZIsdAGjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hBUlDWDBADGfqaINi7P44RSLl1DHvL1kAkuCDYaDJ1K1oYFoFYGZP8xO9r33MoOEP
         o/nlZv20qLVTDGLVY09grPf1KLBw740Eig6hefAJ0Ak1OhroWuQv8wBbJfLmbto8vq
         ydDaDAWC2IE8zkuiyvfoW0QUMPoXnm4+PoIcYeLNRmbdp3O99BXnnyCcO51dtVR+Mb
         AGPeddIo+cZWuhqso81ECejiUT3qHRiJnSuP7uOJXSCOP58ilvlcdFxIOqtsw2rlzg
         Ez0Nr7mdg7CvnyRAxNWpXYaVFM1QpDJRin33jq/NiXqRIs5dxIQQxIsrP7DNeFE1jf
         wXIdo8otFungQ==
Date:   Sat, 25 Nov 2023 16:21:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc:     <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iio: adc: ad7091r: Alloc IIO device before
 generic probe
Message-ID: <20231125162155.2a3f980f@jic23-huawei>
In-Reply-To: <0a648afb9a06471380a7993b20cb44a9026c8248.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
        <0a648afb9a06471380a7993b20cb44a9026c8248.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 13:41:59 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Rework ad7091r probe functions so the IIO device is allocated before
> the generic device probe function is called.
> This change is needed for a follow up patch that passes a pointer to the
> IIO device to a couple of regmap callback functions.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Why the gmail sign off? That's unusual enough that if it makes sense I'd like
to see a comment below the --- on why.

Patch is fine, though I'll need to read further for why this is needed!

Jonathan
