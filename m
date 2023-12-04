Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA888035C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344922AbjLDN7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjLDN7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:59:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC484F2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:59:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C17C433C8;
        Mon,  4 Dec 2023 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701698369;
        bh=isgD4mMOA0as7oH+Mok9vL3AUe3om/TUtSL0dMQF8Hw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cRdfsI7HPmvTeIVhshhx/n3A3qJpRQDGNfx4oeukEGhwbZos3s8gZS8zs7s07PRrz
         Nif1ILicVHf/NZ/I/51IgZ8vS+WtiYis2nMmH88Q4wtISsWgji3sZ830G8KPlqHqYk
         cLmiVBaoaZMv0ohRy96S8zAnLwOjE0XKcztX7lR8KTKZNdFDPaNBi0C6IEQ3e02cUZ
         PzWMjNlNe8U68gmu/eomcqJwe4VfOFr8triYokUwFeu2PF2u/NjJyn/B3OCESUbQzO
         3Bq732g9oOobslralYhgH6VAPH9SLQk9vt4ash+tZwZoK8AqKyBU2shxhXYMCbBFBM
         +tXcwCOnkUeUw==
Date:   Mon, 4 Dec 2023 13:59:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/3] iio: light: add support for VEML6075 UVA and UVB
 light sensor
Message-ID: <20231204135920.16c7e826@jic23-huawei>
In-Reply-To: <20231110-veml6075-v3-0-6ee46775b422@gmail.com>
References: <20231110-veml6075-v3-0-6ee46775b422@gmail.com>
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

On Mon, 27 Nov 2023 18:34:27 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This series adds support for the Vishay VEML6075 ultraviolet sensor,
> which offers UVA and UVB measurement channels and I2C communication.
> 
> The device bindings and a simple example are also provided.
> 
> This driver has been tested with a Gravity VEML6075 UV Sensor Module in
> open air conditions.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Hi Javier,

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find anything we missed.

Thanks,

Jonathan
