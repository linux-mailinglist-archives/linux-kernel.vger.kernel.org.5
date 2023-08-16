Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D76C77E8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345523AbjHPS0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345544AbjHPSZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C032102
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:25:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 982D664E15
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E1BC433CA;
        Wed, 16 Aug 2023 18:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692210340;
        bh=NVIO9mQ7Sul835zV4M+ab2QePvs6SlNuDEAVCUPvwKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnXg3q8h3h+NaBnVLSqq7//1YT9liViGFT/C4Pu1vN9x4LFbLYb6ZwIEasPYW+Duz
         Ui0lvYQC71kFCtFJ4DaVM2Zb/7/wZTCCq7Hh+qaBUJHL9OmEd9tzXUysX8feVMEghz
         QVDC4D1D/C9aJwZZIffNgxI4VdulkNolsH2pZ09VObWdcMTOUJdKUqavenfy6XviyM
         P/0OauVeYr8d0Q3/oT31R9gCpdJ3IDWweTp/OHQknW6cS7vhEAyb7x9QfQ//0hfRiR
         RRP/DComBUNiOMAHi02RYUBl0P7fmNCCyixd/+4sfwu7jaeXeQDbBVgj6NpdDB1QX+
         Ah49dORRIWY1Q==
From:   Will Deacon <will@kernel.org>
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, James Clark <james.clark@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] arm64: sysreg: Generate C compiler warnings on {read,write}_sysreg_s arguments
Date:   Wed, 16 Aug 2023 19:25:25 +0100
Message-Id: <169219366150.1947685.9640471201961433232.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230815140639.614769-1-james.clark@arm.com>
References: <20230815140639.614769-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 15:06:39 +0100, James Clark wrote:
> Evaluate the register before the asm section so that the C compiler
> generates warnings when there is an issue with the register argument.
> 
> This will prevent possible future issues such as the one seen here [1]
> where a missing bracket caused the shift and addition operators to be
> evaluated in the wrong order, but no warning was emitted. The GNU
> assembler has no warning for when expressions evaluate differently to C
> due to different operator precedence, but the C compiler has some
> warnings that may suggest something is wrong. For example in this case
> the following warning would have been emitted:
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: sysreg: Generate C compiler warnings on {read,write}_sysreg_s arguments
      https://git.kernel.org/arm64/c/18b8f57a7f51

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
