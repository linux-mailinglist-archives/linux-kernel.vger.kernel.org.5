Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7F8751E19
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjGMKDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjGMKDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:03:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A7D2D58;
        Thu, 13 Jul 2023 03:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C4D619DD;
        Thu, 13 Jul 2023 10:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA63C433C8;
        Thu, 13 Jul 2023 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689242567;
        bh=ObO6lF804ZW//+RWdhD3dXH0O8MP2/EpWAQUtvd2CfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHpS82kOZaSf3CEjUEAzhOE0C9ccmEA5KmYiN2LNrdNpHCkiNfx6utk8dZjdfLCUe
         p6G3fy2GRtmpRu5jkeMnGSvkzGRFV1Bx1ps1hcQbcwbnH4UnCdWd+uJ/JhvCjqgqql
         +gAjLLg67ZPnY2EH0ypSkWqkAzArCySNwH3xOR9FahsqWOQHRYnBk4Heg/4+LathUh
         PloNI7X57J2mmerqOJJs/oJtjOHuV+kgciDVOveGaSyXaiZ7pwHoV6vI8GxvR909vS
         6UdUPfxGV8GXPr6P+d/O1bzNNZN6//AF4U2JfbVi7zGEjWVOohWcvxOZYb+mJk22HL
         eR1YIMM2bHN5A==
Date:   Thu, 13 Jul 2023 11:02:41 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v10 2/5] leds: provide devm_of_led_get_optional()
Message-ID: <20230713100241.GI10768@google.com>
References: <20230624084217.3079205-1-jjhiblot@traphandler.com>
 <20230624084217.3079205-3-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230624084217.3079205-3-jjhiblot@traphandler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2023, Jean-Jacques Hiblot wrote:

> This version of devm_of_led_get() doesn't fail if a LED is not found.
> Instead it returns a NULL pointer.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/leds/led-class.c | 25 +++++++++++++++++++++++++
>  include/linux/leds.h     |  2 ++
>  2 files changed, 27 insertions(+)

What Markus said isn't wrong, but isn't a blocker either.  He's just
repeating Linus' preferences with respect to commit logs.  Ideally you
should be explaining what the problem is and what this patch does to
solve it in a manner that is more directing and less explanatory in the
past tense.

-- 
Lee Jones [李琼斯]
