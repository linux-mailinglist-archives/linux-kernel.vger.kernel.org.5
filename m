Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268D8789C90
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjH0JUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjH0JUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBADD8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 02:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11151613B3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 09:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB91C433C7;
        Sun, 27 Aug 2023 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693128011;
        bh=lJYorIVcx536GtzJ3KF/sKB2zw1hE7/RD53xYbdv9mU=;
        h=From:To:Cc:Subject:Date:From;
        b=dw2RQQm0M2ed8Q21whUMu3KnZhYWM+ImII71/0xNRHz0WkbPSJmFOeTd/HmXPiqfW
         7CiL1W54uzpxiIUiGsKkhQW8447gI+iu5wkk9AbF03GX+2yeh5wBODgcxlCSfkksgO
         XKE14xB93xgTLeDdvVcetXHvVNU9kirv0GYtOxbyZ+synRtcJUo7fyu3sK5NJq/k4p
         DIfcj12ZEmBYeYrI/qc02hgb6b8FLKav+rFgE6F0CW/lUgetuJYOv/GAEgmMKyGmew
         CUshTBOa53v9ZbbV80dqfJUiIpfFA2r2No72fM4/WKsf5vFDELAJ/OkfTZ1Xy92pNF
         s88a7rY94tCdg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] riscv: errata: improve T-Head CMO
Date:   Sun, 27 Aug 2023 17:08:11 +0800
Message-Id: <20230827090813.1353-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a renew of Icenowy patch series[1], patch1 is necessary to
make T-Head C910 powered SoCs CMO work correctly. patch2 is to name
those instructions following thead-extension-spec.

Icenowy Zheng (2):
  riscv: errata: fix T-Head dcache.cva encoding
  riscv: errata: prefix T-Head mnemonics with th.

 arch/riscv/include/asm/errata_list.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.40.1

