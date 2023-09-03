Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF325790BB2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbjICLta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjICLt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:49:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960FC124;
        Sun,  3 Sep 2023 04:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C220DCE0A37;
        Sun,  3 Sep 2023 11:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F4DC433C8;
        Sun,  3 Sep 2023 11:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693741762;
        bh=RZnKWRxJBDwWPohSlK1fxgk7fJ1IGWszvjrh7ebV0A8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aT09363HQEh05bl0Wp0uD4mkvdHNAENtlb3wg6zlYpJdaRtIHLD5RnEOHzOKl6g9X
         LSAMnXZKhw5fEjxg+NfSmevfdkiMIggVCLEqZ68T0bRroZFb587kO0j33e5EvQsGzP
         IYBMQRLhbd4CdawHPrbD086e23ug548OfX2A27ikTKszh+98mecvI2NBC4Fwtou61m
         rpYFMELey3cS51R4b+wq9WQ/SZ/eklP9wSRaJi/cIS5b1b++xfDY56o4VpceaOARjv
         RuVndIS3W98S8TQxMTfknzi21+sFR78k+HIrNu2PfH9RalCEVp2rHexgt9Z+/9eRmi
         RvSMDciMxWjFw==
Date:   Sun, 3 Sep 2023 12:49:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] iio: adc: adding support for MCP3564 ADC
Message-ID: <20230903124949.2074e5ad@jic23-huawei>
In-Reply-To: <20230829154133.40716-3-marius.cristea@microchip.com>
References: <20230829154133.40716-1-marius.cristea@microchip.com>
        <20230829154133.40716-3-marius.cristea@microchip.com>
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

On Tue, 29 Aug 2023 18:41:33 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip family of 153.6 ksps,
> Low-Noise 16/24-Bit Delta-Sigma ADCs with an SPI interface
> (Microchip's  MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R,
> MCP3464R, MCP3561, MCP3562, MCP3564, MCP3561R,
> MCP3562R and MCP3564R analog to digital converters).
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>

LGTM

Series applied to the togreg branch of iio.git.
Note I'll be rebasing that branch of rc1 once available and in the
meantime it will only be visible as testing.

Note there was a trailing space in the docs file.  Fixed that up.
Thanks,

Jonathan

