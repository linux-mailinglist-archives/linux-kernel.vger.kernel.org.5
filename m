Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB89A7D3FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjJWTOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJWTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:14:08 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55886A9;
        Mon, 23 Oct 2023 12:14:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C020A5C0386;
        Mon, 23 Oct 2023 15:14:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 23 Oct 2023 15:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1698088445; x=1698174845; bh=lc3S9TTGK9
        rhmxndKwt6atJudUhqWg09GVrYzllrfJk=; b=JztcOqK2Yiw4NqJWal1Z9xTYrX
        ynULjTI9BYC7bBcPXIqsYg6lo5/ZmyawSe+hudV1pHw/ERuA7cPykQ440B0y202E
        a8wOZbATjAgQAXiIkT00T4dx6Hv+Dit61xAuau1qHLv5ejO42pBEGFpdlC5Q+LOF
        RJF9jWEDYsuFMpOCMne9dWGPdTZG9Fd8H1k6Z7pw4JweZBavUlY8qAU4qXQHoXLY
        occWO6VfCEEetjaAC8m4KNhjZ+6YZt2KeERiuvTNmQkkvukMoS0VhH6govH93SuV
        tZ+udSLKo16z11gFKe0m18B2VHFrlccMZ5E+5C061BV1ITKPk0mdnBLWOF4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698088445; x=1698174845; bh=lc3S9TTGK9rhm
        xndKwt6atJudUhqWg09GVrYzllrfJk=; b=Stwr+MhP4LcUFxYsrLvPAQXm3R5+v
        bntRuCFePsMropUbn2cNUT37JLaa2rT7nG6U1j4d1QWFTvLQGJDH2TZTu3YlgHgc
        2Bh/fvWB5zGtLGdC4NEf442H5hz3ZdCf/hFGeYroS99c8I2XlWsbC/KvYCcwK5JJ
        wDsf2wJBL+6eBNE0WDu7yDRsrZxTfKkHZMtuKjwhrolubgd1kQiQ/SdnJrXLlwz+
        4JYgEWMwJFtSmNCyyN1gv12w2Wjsy17gf5t1eFqg9SSrRnsFMHKgJirJH8e5W4pR
        hjExTq2zVKkiOC/yop6E8YqC1eNoY7BqfGu1JJO2H9KSP55/PHj2DcGwQ==
X-ME-Sender: <xms:_cU2ZTtFNBV431yNembFLRQ3dplayHCTWmu2I5q6JvU8IyvkdsKPRg>
    <xme:_cU2ZUeYzkHR-qX6g6mZH-eXWhJItNk3ZmZYrOkySLaY5voFOJ4hdjnobYiynJsUw
    Z1eQPYUi7HoBW2E4oc>
X-ME-Received: <xmr:_cU2ZWz4mozMnIb_biIAsn6qqnm99gyYVG6DWfQLpJ3I4L-4Nl9EiZLQDq4ppsYsrpIyATbBSM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdeuteekleeuudfgueethe
    dtuddthfdtleffgefhieehfeeigedvtdeuveetiedunecuffhomhgrihhnpehkvghrnhgv
    lhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:_cU2ZSM6oAnMeGdKqQpp9uYNR38z2nbxKXIjU1ETgSsm-vW8IXBRkQ>
    <xmx:_cU2ZT_3-ztyhvBVD3s79_UZUL7uq9YWBnH0fVtKdO6jIFwNanhe9Q>
    <xmx:_cU2ZSV8ZfsjuBgx8OdIphB1n9sN8HvvFnbiEPDrPMeVuVaZjAZIwQ>
    <xmx:_cU2Zfa7I6N_IKVEAFuzRHIBnt6Ov_bTezUq6iO45_DUfO7uec7sZw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 15:14:04 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/5] MIPS: Fix kernel in XKPHYS
Date:   Mon, 23 Oct 2023 20:13:55 +0100
Message-Id: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series fixes support for loading kernel to XKPHYS space.
It is derived from "MIPS: use virtual addresses from xkphys for MIPS64" [1].

Boot tested on boston and QEMU with loading address set to 0xa800000090000000.
QEMU patch on the way.

Gregory and Vladimir, do let me know if I missed anything.

Thanks
- Jiaxun

[1]: https://lore.kernel.org/lkml/20231004161038.2818327-3-gregory.clement@bootlin.com/

Jiaxun Yang (5):
  MIPS: Export higher/highest relocation functions in uasm
  MIPS: genex: Fix except_vec_vi for kernel in XKPHYS
  MIPS: Fix set_uncached_handler for ebase in XKPHYS
  MIPS: Handle mips_cps_core_entry within lower 4G
  MIPS: Allow kernel base to be set from Kconfig for all platforms

 arch/mips/Kconfig               | 18 +++++++++++++----
 arch/mips/include/asm/mips-cm.h |  1 +
 arch/mips/include/asm/uasm.h    |  2 ++
 arch/mips/kernel/genex.S        | 19 +++++++++++++----
 arch/mips/kernel/smp-cps.c      | 27 +++++++++++++++++++------
 arch/mips/kernel/traps.c        | 36 +++++++++++++++++++++++----------
 arch/mips/mm/uasm.c             |  6 ++++--
 7 files changed, 82 insertions(+), 27 deletions(-)

-- 
2.34.1

