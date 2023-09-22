Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D3A7ABBFD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjIVWvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjIVWvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:51:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED0AB;
        Fri, 22 Sep 2023 15:51:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB70C433C8;
        Fri, 22 Sep 2023 22:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695423076;
        bh=+IgQHS0uZ5whJ86T+o1t0MM1hBYBpdeCcn6J2sibHpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRYz0gV96XVqgdZIDZIECV4fPJq4hhVnvurXeBnWxH95oT4N9BoPVUW+WqK9Onc/k
         0VoSthzX8qL7QAvEQOquiwoSD/RxihT7BrZJpLipPABvym5/03+cc8FGa7z9Rp++KD
         D2qvsX94BKWZj4MaF1cu0FNVYJV0c/O8zjY8SpcgVEY4MsS0xs2mOjT00j3q3BI6zA
         yDWlSrx9PAvnaXpJFpiyPp8Q5TziPN7ozaoUwga6T4ayEoXReqrw2JBpTIBJVrtUFm
         hBEom1FGZvoeJhKjzef6RLFAe76R4FQQoXAxNuQSX2c/5pLb0qHuNqWpGT6KBJk9KW
         e4i+y7sZTpHuA==
Received: (nullmailer pid 4076004 invoked by uid 1000);
        Fri, 22 Sep 2023 22:51:11 -0000
Date:   Fri, 22 Sep 2023 17:51:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        openbmc@lists.ozlabs.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-aspeed@lists.ozlabs.org,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: aspeed-wdt: Add
 aspeed,reset-mask property
Message-ID: <169542307112.4075948.15645605897080315437.robh@kernel.org>
References: <20230922104231.1434-4-zev@bewilderbeest.net>
 <20230922104231.1434-5-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922104231.1434-5-zev@bewilderbeest.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Sep 2023 03:42:33 -0700, Zev Weiss wrote:
> This property configures the Aspeed watchdog timer's reset mask, which
> controls which peripherals are reset when the watchdog timer expires.
> Some platforms require that certain devices be left untouched across a
> reboot; aspeed,reset-mask can now be used to express such constraints.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../bindings/watchdog/aspeed-wdt.txt          | 18 +++-
>  include/dt-bindings/watchdog/aspeed-wdt.h     | 92 +++++++++++++++++++
>  2 files changed, 109 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/watchdog/aspeed-wdt.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

