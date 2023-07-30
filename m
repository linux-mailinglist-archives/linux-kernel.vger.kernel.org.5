Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1782768406
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 08:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjG3Get (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 02:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3Ges (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 02:34:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC5719B2;
        Sat, 29 Jul 2023 23:34:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACBC360B68;
        Sun, 30 Jul 2023 06:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68578C433C7;
        Sun, 30 Jul 2023 06:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690698886;
        bh=Z5v1Wq8+4+Vexd0JNyIgN2hruFf3+DV45YQaU/siC00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfOz+w3YBGyGQs6WfX9nF3KLzKFD/cH8igmsQGy4U4ap0zoCl/ZTUymjCOaCqCwN/
         vY8jyR+hDs+hhjjpojF7Yo6DF6nekZBClPG00dKYAU777T1sYSVwTLC4kbKGWi5xW8
         G7qeLdLt9imqB1jXSHzOzcaz7GoI9BWqfUhw4zvlQpOPXbVtROf9xrZ3k5PH+/gz6s
         Kf9tpAQO4Jv9/8VDmB4WPnoNHQ8Hvm3BdxLvQCKUjmP+azU6R3Z/s63f60fJxS8eN0
         pYaqMGxePN36BbVRmPDEVTdRHFbltdYbxprWEVB6OCzVEc/1EFz+tKEMbQs/PPWTPU
         gezjhrWMzFm1A==
Date:   Sun, 30 Jul 2023 14:34:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        S.Riedmueller@phytec.de, S.Mueller-Klieser@phytec.de,
        upstream@phytec.de
Subject: Re: [PATCH v2 1/3] ARM: dts: imx6: phytec: fix RTC interrupt level
Message-ID: <20230730063434.GY151430@dragon>
References: <20230719114328.2239818-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719114328.2239818-1-andrej.picej@norik.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 01:43:26PM +0200, Andrej Picej wrote:
> RTC interrupt level should be set to "LOW". This was revealed by the
> introduction of commit:
> 
>   f181987ef477 ("rtc: m41t80: use IRQ flags obtained from fwnode")
> 
> which changed the way IRQ type is obtained.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Applied as a fix with tag:

  Fixes: 800d595151bb ("ARM: dts: imx6: Add initial support for phyBOARD-Mira")

Shawn
