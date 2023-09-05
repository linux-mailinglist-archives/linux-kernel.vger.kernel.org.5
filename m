Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2D792C1A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353901AbjIERGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348040AbjIEQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 12:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F861FC8;
        Tue,  5 Sep 2023 09:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DB0760A53;
        Tue,  5 Sep 2023 16:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F1CC433C9;
        Tue,  5 Sep 2023 16:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693929677;
        bh=1MRrvt8swStnNdURSNPWWp1DvQ4Gdk5ryJCx4I5tPeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0VHBKH4388LVzaJyxpJ6Khn/d0c2d7BzRd4oftcGYzmRUXc84YNAusTuC8jsY+1P
         5spvdxniLYUo9wNu33Oh1I1CbjHGuhc6VUeExJlNy4R4YxtD8sjwbVv+pxlcSK+ZIo
         O3175YxkfIe89surYzFZAjWGrstTSjejBAUC/Oefe5sxUZEfDQ4HdoZ1LMUrUIIruW
         K10SC4y+LDV7v/+6DpTXudTO+KJeYtVHQzwmIOTYNFVFAgbcGPTq8gV/WKdmk7fEy+
         MU1c4OOgwwXtPL6GZVG/CdGnWKpPvgRNg9/c9SPwrQcbq3ifnuTy40ANOHGa9ZIjuC
         Lut3khK3v4RSg==
From:   Will Deacon <will@kernel.org>
To:     linux-cxl@vger.kernel.org, Jeongtae Park <jtp.park@samsung.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: CXL: fix mismatched number of counters mask
Date:   Tue,  5 Sep 2023 17:01:11 +0100
Message-Id: <169392547905.32747.11280768202750996250.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230905123309.775854-1-jtp.park@samsung.com>
References: <CGME20230905123044epcas2p2b1052956527cf63a03e2895d4b93e7e1@epcas2p2.samsung.com> <20230905123309.775854-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2023 21:33:09 +0900, Jeongtae Park wrote:
> The number of Count Units field is described as 6 bits long
> in the CXL 3.0 specification. However, its mask value was
> only declared as 5 bits long.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf: CXL: fix mismatched number of counters mask
      https://git.kernel.org/arm64/c/7625df9f4b25

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
