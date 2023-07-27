Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227B2764316
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjG0AqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjG0AqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:46:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4F2681;
        Wed, 26 Jul 2023 17:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 190F061CE5;
        Thu, 27 Jul 2023 00:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CE5C433C8;
        Thu, 27 Jul 2023 00:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690418776;
        bh=XkwRq7pZHHODXckSU9WR2mbl4iHE4QL86vb50DaqmdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAkcFaRIwXisi5DPWwDYmWZbQdBYp19Y7fE2RnAOpnQIqmqETLzDJv7DJItmZieaD
         vsqB1i2dT6+E4d9X4r4U39xOYiePQs4YLW1mLwTiljqAr9MG2rn23HSuWv0n6d3weO
         SywfCVqO99uCWle+g36RURkP3mZiGLjRp76rKwFIUMw/DnN8DwmoVKVWkNl+a4CF23
         PQ/T7il6Jk/pERKAf7jZx52tU82YWJfQASEVN0crngNJ8q6H5nCHQHTJ6q1CMc6lDE
         9DfDwqZ+csQvBnLVhFsEl8+b/OYq8DprldJXG8DArfI0gZqRJpSVO6v/XSbn2H8IVo
         C+nvb2a0x7wtw==
Date:   Thu, 27 Jul 2023 02:46:13 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 29/30] usb: ehci-exynos: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230727004613.yzvx6x66mi3fffii@intel.intel>
References: <20230726113816.888-1-frank.li@vivo.com>
 <20230726113816.888-29-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726113816.888-29-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On Wed, Jul 26, 2023 at 07:38:15PM +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
