Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1C87653A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjG0MXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjG0MXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:23:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48CD30DE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 852CE61E5D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE65C43391;
        Thu, 27 Jul 2023 12:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460575;
        bh=XqmcTAiY+BiwnJlz6u+bhjQNMtUWIMhQY5vMcnQzKYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=edmpIhh9/zOz8c3Mz30U1afccEQTPCL6DHC3YBBQiO2xYnVwD7EhwYAteRBbLVKuM
         cUHgueW9jN6EraLMXaxlJKDJOVV9mfdVftH9CVKwORWIsT6bM9NNXStzKyXM4Y6IEj
         OUFYirJK2CEBT/OHRzNiAb1YY1gemQEpxasIOQWluGBsg2nPTmmSgmOi99X8ZaPOb6
         bsOULhcUsqNSSB5HKlhC+dJ1MaUzUawV4TPApZQrh1+1aPkFq8APF3slpy3unG2HR/
         Df9jAw75mtZKspNDyAtr3pxQhNu7n2fS/9hItvLZ5o520BgfCz1HUlsDyAFPH6w9mQ
         f+wgD4j5Eed7g==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Yangtao Li <frank.li@vivo.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: xgene_pmu: Convert to devm_platform_ioremap_resource()
Date:   Thu, 27 Jul 2023 13:22:31 +0100
Message-Id: <169045921048.3247578.10292473789741531939.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230704093556.17926-1-frank.li@vivo.com>
References: <20230704093556.17926-1-frank.li@vivo.com>
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

On Tue, 4 Jul 2023 17:35:55 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf: xgene_pmu: Convert to devm_platform_ioremap_resource()
      https://git.kernel.org/will/c/c47ea342d85d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
