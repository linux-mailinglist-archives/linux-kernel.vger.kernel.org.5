Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDBB80DB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbjLKU1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345056AbjLKU1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:27:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFEAD8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:27:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6F2C433C8;
        Mon, 11 Dec 2023 20:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702326472;
        bh=uoUe1SK04pnPdhRGfZu/gYgD60t7X8b8OsmTtn5lOM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFVUvge+E3oRIBXvZ/cZM2u8i3HLGIc/J1oejmwV7N4GAunPW3jdPBGa7qZR+6fyH
         RDAgR2LIZwtirdRkV77MHxsqPtZLwWClwbh0xELuUl32Jha1hKOdrRZ61DDtOnrBiq
         lxgIX2AcGlZR7QIBnkGP0FLMfH3nfW+FjguZsIT6aJsTCB1lgHpnGnXfatEmnCdzZR
         Rvv01YanAvR8jky4t51aF9Q4ktMOKxO28kg2Y58XdYBfLolhL/6p1xvWmjyqY5ST8R
         Y2HFMD6DW8Leo8HP+Y+t8cEXIm8lWyTeHN4GCzqLQ2nJBPGfXD25nyAoe4AEZMpETo
         h03oUgLsR6z3Q==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zenghui Yu <yuzenghui@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, broonie@kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] arm64: Delete the zero_za macro
Date:   Mon, 11 Dec 2023 20:27:32 +0000
Message-Id: <170230068713.139476.766825737476261782.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231205160140.1438-1-yuzenghui@huawei.com>
References: <20231205160140.1438-1-yuzenghui@huawei.com>
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

On Wed, 6 Dec 2023 00:01:40 +0800, Zenghui Yu wrote:
> zero_za was introduced in commit ca8a4ebcff44 ("arm64/sme: Manually encode
> SME instructions") but doesn't appear to have any in kernel user. Drop it.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Delete the zero_za macro
      https://git.kernel.org/arm64/c/86d1921c9d5a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
