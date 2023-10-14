Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DA17C9546
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 18:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjJNQOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 12:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjJNQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 12:14:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004CFCC;
        Sat, 14 Oct 2023 09:14:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E75CC433C9;
        Sat, 14 Oct 2023 16:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697300043;
        bh=T+Ckd8zWYYhSedCQa0VE1OhK/ZgzZAoqKinofheowtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ENAysTNx0uQ5O3vtXV418DXtYa/4RTkPcISF2LNwi7HyjghwFD2a1g8/cnubY4v+O
         NJmorzLKS3C5udWAc6arcv+g1umwhVYKVb1Uu+8epkBhEI955NwqhZVcjwRzCatd3A
         tL2DO3Of1ph0NsnmOMxIU+cYClH4NAaWhKLJVIxYwQF1loPB6yEXoEvYYxH2gFnfbP
         aMn1CcE2MEK7uAfJbaSjNHFjFOF8Hy+wbpRvVaNSl9XuhWz8Jt/qcaRl6WYbb2HAZ4
         eRe1poNd1+d7+OIytemw6WGiHTMlljlPIGefr2qFu1w9dlo56gdHV42vPrUBHLxVzV
         mg8zbLzccuINg==
Date:   Sat, 14 Oct 2023 17:14:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: Add device tree support for silabs,si7005
Message-ID: <20231014171417.3a3448a1@jic23-huawei>
In-Reply-To: <20231012-topic-si7005_devicetree-v1-0-6c8a6fa7b3ec@gmail.com>
References: <20231012-topic-si7005_devicetree-v1-0-6c8a6fa7b3ec@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 22:07:06 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This series adds device tree support for the IIO humidity sensor si7005
> and extends the trivial-devices binding to document the addition.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (2):
>       iio: si7005: Add device tree support
>       dt-bindings: trivial-devices: add silabs,si7005
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  drivers/iio/humidity/si7005.c                          | 7 +++++++
>  2 files changed, 9 insertions(+)
> ---
> base-commit: 401644852d0b2a278811de38081be23f74b5bb04
> change-id: 20231012-topic-si7005_devicetree-644b61b62178
> 
> Best regards,

Applied to the togreg branch of iiog.it and pushed out as testing for
0-day to take a look at it.

I'll note though that I would expect the fallback path for i2c bindings
to have worked here in which it matches the 'device' bit of the compatible
(ignoring the vendor) with entries in the i2c_device_id table.

I prefer explicit support like you have added here though as that
avoids clashes when different manufacturers use the same part number etc.

Thanks,

Jonathan
