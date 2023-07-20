Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C3675B433
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjGTQ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGTQ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E506123;
        Thu, 20 Jul 2023 09:29:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10E2E61B77;
        Thu, 20 Jul 2023 16:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E376C433C8;
        Thu, 20 Jul 2023 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689870596;
        bh=vq8H8MuRdT8JCy9+BLPg0kOAxafD5sox594B5wyMovY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcSsjoIP45IJWk8hN+tZVKyy9d0dWCKEDAAkhUE5ugSw+zYqVH3rw8+78aBDeyju0
         XP8UZhe6gOnX9/zFC4bVpkPSh+RaqHahKLwUHKsRsM5kmB2A8zgOsdbS2VwKRQ1YhN
         jB0WSYvvcBzJKe7jRVAedREiMMgMbtIDzdzMp5Lzv6j9FBc08hAziucnW1J23E5YUu
         734yEYv38hkdxCHOEaI7hu04LFHtqkoj4v4XcGGa1i4eN2T3YjqOOFqFC9q4R+heMe
         w4t/jTu28elNqwqmDojcXzJZgwKdMLW1bV+DJ/7vzLwdAftL0drN00zlHnPnNzFKxx
         wOhXvMI4ClMpg==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v1 0/3] riscv: dts: starfive: jh71x0: Add temperature sensor nodes and thermal-zones
Date:   Thu, 20 Jul 2023 17:29:48 +0100
Message-Id: <20230720-embroider-kindle-421180f7b886@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718034937.92999-1-hal.feng@starfivetech.com>
References: <20230718034937.92999-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=618; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=XYK3GgqdqOYIaRTM344ts3ulEzHjEr/ZzZ2UIiONiWs=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCk7E34z/ttU4S8SKP9A4/CP01/Val6K2JhLvs2SE/qWO bPkTP2VjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExk/TqG/7XLH4snHP9pqx7P pcVs+bv7pPizRSFZbNlKtR0SOfM+HmP4wxXxpKzgz/auM9WeculTW0KdXBO9ubadf7JEJj2S4UQ TLwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 18 Jul 2023 11:49:34 +0800, Hal Feng wrote:
> These patches add temperature sensor nodes and thermal-zones for the
> StarFive JH71X0 SoC. I have tested them on the BeagleV Starlight board
> and StarFive VisionFive 1 / 2 board. Thanks.
> 
> Best regards,
> Hal
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/3] riscv: dts: starfive: jh7100: Add temperature sensor node and thermal-zones
      https://git.kernel.org/conor/c/0417c587420f
[2/3] riscv: dts: starfive: jh7110: Add temperature sensor node and thermal-zones
      https://git.kernel.org/conor/c/54ab0b6b85d4

Thanks,
Conor.
