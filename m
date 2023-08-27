Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7455878A0EB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjH0SZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjH0SYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEE8126;
        Sun, 27 Aug 2023 11:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A55D2612E6;
        Sun, 27 Aug 2023 18:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A9FC433C7;
        Sun, 27 Aug 2023 18:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693160677;
        bh=5LBr0PUCmQUw1b5oIphP5l65FL+oB8K9EFBppnUTIQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i+IgHp01Yj9sln+/4F7qP4HnOCeycQNohYsUfTG4fOFpkh/v0LBlP8DazmShN5+lQ
         rnmcwAKEV2tzBRBzyqByE549+M3kbTgumCpKieKHFhcooueXCMneb2YUNl8gt7ZGBK
         fQcL7U2lZKK0yfHVzAMuXu1+F1Dyzg3OkuFuX2Ns02+Hk0oR6iGWdtRlaoTTyNRyNP
         8TFHD2gPkqJG6cOUXjKrAroqkKSJ+jp8Z7GqZK82uedSRZpkyoegRpSEr+Cl0kDUjM
         ttK49IddKAhlTITVp5EZXr69yKbUFcXyyv5DLEQN3KJ942FP+RRT1xZn/dyYDyRcr+
         Ce8sCWQ3yjCUw==
Date:   Sun, 27 Aug 2023 19:24:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: adc: mcp3911: add support for
 the whole MCP39xx family
Message-ID: <20230827192404.34956e39@jic23-huawei>
In-Reply-To: <ZN4VrLPKhQIVLxfP@smile.fi.intel.com>
References: <20230817120518.153728-1-marcus.folkesson@gmail.com>
        <ZN4VrLPKhQIVLxfP@smile.fi.intel.com>
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

On Thu, 17 Aug 2023 15:42:20 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Aug 17, 2023 at 02:05:13PM +0200, Marcus Folkesson wrote:
> > Microchip does have many similar chips, add those to the compatible
> > string as the driver support is extended.  
> 
> With properly formed cover letter (and using --base) a maintainer may safe
> their time by utilizing some features of `b4`. I.e. the
> 
> 	b4 -slt -M ...
> 
> will treat the series as a PR with summary in cover letter taking into merge
> commit. This is really cool feature and from now on I will require people to
> submit the series with mandatory cover-letter and --base in use.
> 
> BUT. I'm not the maintainer here, so up to Jonathan to decide.
> 
Not today, but I'll keep the option in mind.  Thanks for highlighting it.

Jonathan


