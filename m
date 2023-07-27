Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6600A7653AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjG0MXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjG0MXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9B02D54
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B91761E5C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D51C433CB;
        Thu, 27 Jul 2023 12:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460576;
        bh=PxyRxSAhxteMU1sFxDjKeQ1Ix+SGzLl/PSwg/bBEb1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ld3unA/Z9sHugWKW1MKI3hC2j4hZnSf/xdSKHt2tD98kXf46nvOgenLyQ9TaGDHaR
         +Y9X75fun4tW8yL+ifgrOgOqNrhub8l/wWp+QoJIp7Kr3alMh9X3FfWowmp5Zl18yT
         ltKikF+SBPLw4qWInuhhrGlkFMoUlx9Wshj7z9eG3CQucGYytubFG7/w4llScN5Gdm
         VPjQtytMJY06Kpy+HIJhZJmjqq4aqp44mWWpJaptdVnf63iEXiSnNS8QGhtcsUiluI
         CO7/B7GvAJ+UkbDqLd6muVBcHDvij3qsrT+kqsdclvaVZyPrcbLZRThPZn3N5KbzF2
         98SlmxhOJFu9g==
From:   Will Deacon <will@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: vdso: remove two .altinstructions related symbols
Date:   Thu, 27 Jul 2023 13:22:32 +0100
Message-Id: <169045756463.823776.3068563828483029738.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230726173619.3732-1-jszhang@kernel.org>
References: <20230726173619.3732-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 01:36:19 +0800, Jisheng Zhang wrote:
> The two symbols __alt_instructions and __alt_instructions_end are not
> used, remove them.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: vdso: remove two .altinstructions related symbols
      https://git.kernel.org/arm64/c/a96a7a7ddf95

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
