Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C017653A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjG0MXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjG0MWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661B430E2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E38A61E39
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70803C433C9;
        Thu, 27 Jul 2023 12:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460564;
        bh=1HbvCy5K6zW2MhGrIyO5dLh0MPU7Af1XyC/kwljiFfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2uPYOC0Js0kk8x7OhvSVMeIMiRPYWECx8B1RluEbdlPRkYEOxDLXEdF+4NNLrw1M
         edmJr1SI7TKoReB40RriZ8xgcSkk6VV6gfMTb1kp1GxBch4Gcz6JngkG0iXnmtt8JJ
         UrlcqrPMpwhNCthwwYsBJT5g2Y73GvLmjnH7BPbzRiRLdYmoDJ38b/CexSRsrAznFi
         rRwcKxJbJJXqpqqnac80ubgaB6d+2+ozORNte1BTe2UKAU1JDHo/3K/AXDKSugCaTU
         TS7o0wMl1IPDjX/DDCJ73qVY4uFMLd8TFVZpsjBe/VIUTnTtRX+e3ByUJug+vXe1TU
         cNALWIncjmZ2Q==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, david@redhat.com
Subject: Re: [PATCH] arm64/mm: Add pte_rdonly() helper
Date:   Thu, 27 Jul 2023 13:22:25 +0100
Message-Id: <169045301616.2141519.7699050168238587282.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230713092004.693749-1-anshuman.khandual@arm.com>
References: <20230713092004.693749-1-anshuman.khandual@arm.com>
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

On Thu, 13 Jul 2023 14:50:04 +0530, Anshuman Khandual wrote:
> This replaces open coding PTE_RDONLY check with a new helper pte_rdonly().
> No functional change is intended here.
> 
> 

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Add pte_rdonly() helper
      https://git.kernel.org/arm64/c/d0ba961217e0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
