Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DC780DB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345015AbjLKU1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345008AbjLKU1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:27:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D291D98
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:27:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5172C433C8;
        Mon, 11 Dec 2023 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702326465;
        bh=+f+K1J2zjMnV4XxDy3cuCWY6rDx5LO4Cp2MLoIwdP08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jToo/cEQ3vlKq7uXuK6pQ0GhiYMB+ee4x2MXGN1GDctBWWy9YToDQi9E/NJqpDNn5
         PeO30kk9waFSFEfgmxpTMjF1HztAPVRYsYfEXZb7tnwSCrWuXxPsQekKAJ4EB6Q3ah
         qfGSeDXlNd/plAfuamlpsjPZwetCcjXv/tZ6QcGfVEaUqRkizOxAM2i8OOvw6igspA
         xCBSbfxxea++rr2rzEaIhq6UXKQNn6jEkI8NB2lyc8+QVaH08KGPY0Hjvl5HFYf8+6
         sFUNqH9Ap3B7J5zMnnXu+EYsLYchLw/XKmuKfnSECYoSTVC4YmWmP/mpyRukVxo8q1
         UFNC3jjQSiwfw==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Improve output for skipped TPIDR2 ABI test
Date:   Mon, 11 Dec 2023 20:27:29 +0000
Message-Id: <170229604354.42938.7367909798766410585.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231124-kselftest-arm64-tpidr2-skip-v1-1-e05d0ccef101@kernel.org>
References: <20231124-kselftest-arm64-tpidr2-skip-v1-1-e05d0ccef101@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 15:22:21 +0000, Mark Brown wrote:
> When TPIDR2 is not supported the tpidr2 ABI test prints the same message
> for each skipped test:
> 
>   ok 1 skipped, TPIDR2 not supported
> 
> which isn't ideal for test automation software since it tracks kselftest
> results based on the string used to describe the test. This is also not
> standard KTAP output, the expected format is:
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Improve output for skipped TPIDR2 ABI test
      https://git.kernel.org/arm64/c/33c1a7785a41

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
