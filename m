Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC02D77C1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjHNU7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjHNU6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2729DD;
        Mon, 14 Aug 2023 13:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75FA462AEA;
        Mon, 14 Aug 2023 20:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C04C433C9;
        Mon, 14 Aug 2023 20:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692046723;
        bh=yKyh1POq9pQ5e8pz6n4/ZL/qelVLVe5GIcHE7fW6qSA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RZYLmntd/ztP1pvYixvJF6Q9EgZrIuPzTNcvRtzzVYNEmdMqkEabztNqInRrjq3ce
         DvP6Ob8cj425h4YKdKiZM4mcecYnQaRXFRSGpYrcE1o6mYFLvxI7VSPFL1f1TInqxH
         UklVSOMaFh256t91zKZurVJU1TrO2Fq+KBImwRRNgLHIkgYOVsC27EOKQVMxNr7xbu
         zlrsmI8STFJXUki57ouz3+DBNzn0m4vgyWRf0vYhK8wDrIQ/ak+6CSpLG/5RpNdKeM
         NHcWX9EsVNcYKzLXLBnToyzp5FHabU/YL7DBnNc0WSjSILeaPLdKeQbyy6tiKBfEBE
         MixiTlZcuDKug==
From:   Mark Brown <broonie@kernel.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>
In-Reply-To: <20230810091247.70149-1-krzysztof.kozlowski@linaro.org>
References: <20230810091247.70149-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next 1/3] spi: sc18is602: fix
 Wvoid-pointer-to-enum-cast warning
Message-Id: <169204672180.88731.7885325194720692579.b4-ty@kernel.org>
Date:   Mon, 14 Aug 2023 21:58:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 11:12:45 +0200, Krzysztof Kozlowski wrote:
> 'id' is an enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
> 
>   spi-sc18is602.c:269:12: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: sc18is602: fix Wvoid-pointer-to-enum-cast warning
      commit: 0f9440a646fd1245a9206f171a4de25e6b092d42
[2/3] spi: pxa2xx: fix Wvoid-pointer-to-enum-cast warning
      commit: 94d6cf7e72a3ef90d7e16d770c3dc1b9cd40d8dd
[3/3] spi: amd: fix Wvoid-pointer-to-enum-cast warning
      commit: 675b8e35b5cbf4aaa1339079f44b88b9f1bb2f1b

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

