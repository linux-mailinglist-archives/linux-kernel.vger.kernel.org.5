Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA076BEA1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjHAUmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHAUmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:42:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0A2106
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA2E616FA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 20:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A64C433C9;
        Tue,  1 Aug 2023 20:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690922514;
        bh=UmykxjBF+sC4aN4OQ8EfvIYebgfE0K7LxRs85fn43fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeH44eSsG9xcFFrj+wih+yefO4Nd1y2oXU/izkvZNGEVLYMWas4UYdN/krVJ8IDvk
         2oRZC/YX+ezOMpzKcC5UWEA7B6X5lcsA9lBf8n3NPEfAHNEQo9Ume5RAXLLySBhEGN
         avE9yqBmEpeYKzGzoFqIZ3Dco0dtnqVtKk8ud5pxmmyDzHk32Tfyz3hUZ5AwIKovqU
         xND8qoW6cRRFcDU2/d4yXsKlcJhtRu+MSHyAFl54PIYfO/pCVpFmb29eEUo8QgwIZS
         jR8VkCgdvvCbY2R/xNAJkDUm6+BNfajHsdploQkOYiC8Slm+HffWvtIPRwvbpbXpr/
         ALP1Xuhl83fMA==
From:   Will Deacon <will@kernel.org>
To:     Dawei Li <set_pte_at@outlook.com>, joro@8bytes.org,
        robin.murphy@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Change vmid alloc strategy from bitmap to ida
Date:   Tue,  1 Aug 2023 21:41:47 +0100
Message-Id: <169087904450.1290857.11726985177314533259.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <TYCP286MB2323E0C525FF9F94E3B07C7ACA35A@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2323E0C525FF9F94E3B07C7ACA35A@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul 2023 00:16:21 +0800, Dawei Li wrote:
> For current implementation of vmid allocation of arm smmu-v3, a per-smmu
> devide bitmap of 64K bits(8K bytes) is allocated on behalf of possible VMID
> range, which is two pages for some architectures. Besides that, its memory
> consumption is 'static', despite of how many VMIDs are allocated actually.
> 
> That's memory inefficient and lack of scalability.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Change vmid alloc strategy from bitmap to ida
      https://git.kernel.org/will/c/1672730cffaf

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
