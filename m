Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BBD77F231
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348958AbjHQI3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348954AbjHQI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:29:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A22D71;
        Thu, 17 Aug 2023 01:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14D0F65687;
        Thu, 17 Aug 2023 08:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5753C433C7;
        Thu, 17 Aug 2023 08:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692260948;
        bh=MS5YatjvWycFkJSyn7pKl1OKX1cKBb8jXFaiI08H3mw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I5AzgtGon6w6+HzDj9C5HwIq0O+aowFprTQZzluvCLNfbimkWJ6lC4+gP2VumWo8a
         Ek1qqfPkYinv8pvTkZ8EFyOAA4hGqO2CGtSue+rvsuuK8m9RDe2Iw9WgmFXh172zk+
         gknBmaxccteR3R2In+PABtHHNBcuLYSNyQ5wb0fkCW7qrutKgpKXRhiPQieGVBnVji
         1JY01lufOuQb9TqK5DDGCbnIHkRLWQ10JryJd0zX5C+fg1i8FQ4Cneg3P7sLHIAILX
         c9R1cOTYx/gzm63dyiyjxbpSKnBFn0gwaZ+mZQCH1I3r5dj+w9GItf2Ye8qilwQOoh
         zQP2nADb5LItQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230728153731.3742339-1-jjhiblot@traphandler.com>
References: <20230728153731.3742339-1-jjhiblot@traphandler.com>
Subject: Re: [RESEND] [PATCH v11 0/4] Add a multicolor LED driver for
 groups of monochromatic LEDs
Message-Id: <169226094648.909741.7259440757333532401.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 09:29:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 17:37:27 +0200, Jean-Jacques Hiblot wrote:
> Resending this series as the v11 didn't apply cleanly.
> The patch adding devm_krealloc_array() has been dropped because this function is now available.
> 
> Below is the original cover-letter.
> 
> 
> 
> [...]

Applied, thanks!

[1/4] leds: provide devm_of_led_get_optional()
      commit: afb48153220d35f330d0d979792920a31f7d9a81
[2/4] leds: class: store the color index in struct led_classdev
      commit: c7d80059b086c4986cd994a1973ec7a5d75f8eea
[3/4] dt-bindings: leds: Add binding for a multicolor group of LEDs
      commit: 099c52d9448c1ca832b4695e982221a521282b94
[4/4] leds: Add a multicolor LED driver to group monochromatic LEDs
      commit: 37d0849ed3927f7c4be6f5ee030730f9aa7439c0

--
Lee Jones [李琼斯]

