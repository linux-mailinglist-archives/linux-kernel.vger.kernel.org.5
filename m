Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA912766B24
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjG1K5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjG1K5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:57:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D72B212B;
        Fri, 28 Jul 2023 03:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF247620DC;
        Fri, 28 Jul 2023 10:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FBDC433C7;
        Fri, 28 Jul 2023 10:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690541829;
        bh=oR1c5p2hF7jaFfgpWSSGeo2YJDx6IyU4ZO1WQJ7Iz7A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=M1t89vjEZRW6pIWTkgFfaoxnJvsjcqWZZcJK6PrA4OE15KJ2fp6cE2xRcSQzJCeOp
         4uLcJ3p9WiFURHno6dnM4W4WUBOG8KA+vcSHETNAThr7Bk9sskwTn8v/RfT95NeqpC
         yFg6u6Hhz65tiFaswV0EN0/TpsNPQ3bcqBpzLXy6Ansd2nSg0cC6q3jxNkm667hIe3
         GBjs6HcAiOEMzJVtRqLoMD6xy/8TkLGTlDedrtc7v5U8QT+DxRVDl+k/1Gf/9AMa1y
         Vvw0r/aUiqa/TGQhacgcDUFoLRa87vRyONunOvsByqwmHbGXKOxwSQJEG6Nna+iYMG
         uwksedTEJrQrw==
From:   Lee Jones <lee@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
In-Reply-To: <20230719090430.1925182-1-arnd@kernel.org>
References: <20230719090430.1925182-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH] mfd: rz-mtu3: link time dependencies
Message-Id: <169054182650.337347.17531123476992287995.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 11:57:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 11:02:23 +0200, Arnd Bergmann wrote:
> The new set of drivers for RZ/G2L MTU3a tries to enable compile-testing the
> individual client drivers even when the MFD portion is disabled but gets it
> wrong, causing a link failure when the core is in a loadable module but the
> other drivers are built-in:
> 
> x86_64-linux-ld: drivers/pwm/pwm-rz-mtu3.o: in function `rz_mtu3_pwm_apply':
> pwm-rz-mtu3.c:(.text+0x4bf): undefined reference to `rz_mtu3_8bit_ch_write'
> x86_64-linux-ld: pwm-rz-mtu3.c:(.text+0x509): undefined reference to `rz_mtu3_disable'
> 
> [...]

Applied, thanks!

[1/1] mfd: rz-mtu3: link time dependencies
      commit: 36a676ed76ae1f8dedbb093e1db1662458e00b6a

--
Lee Jones [李琼斯]

