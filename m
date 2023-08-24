Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB43787C26
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbjHXXyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbjHXXy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB6919BE;
        Thu, 24 Aug 2023 16:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E58846206E;
        Thu, 24 Aug 2023 23:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C45EC433C7;
        Thu, 24 Aug 2023 23:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692921264;
        bh=OxK2+MP8e8tARBoIM2dWRgGfyxwZp6MH/GWc5Zd/Wtc=;
        h=Date:From:To:Cc:Subject:From;
        b=hD9MpVxBcrDVeXbhKTDSDHc18nI0xVC/3OqLrk4qd6lwktjtA8o9i/QBJj5PP2dns
         Z1VixJ3wzS5K4WXW337B2i/UyuUE2L7RbaHOooCYD0PKHcN9W+D3SPKn8q9g5F54hd
         2w9BDuJsnR6TbVSMv7DMCErsQryndK9uv3o3C/Hk8kuqAnbpjpcfk1/jWH+sR1LuqM
         N3kYerUpNirk5jHj0GxfZAy6/6psxoXqQVtmuCbOlqUkt3k/V/K7OCLmRswLiR31he
         fEyfSiwZkPu1RWVIiuMojRI+NeHBZdNq0u6Rve/cTugkEZlJisouVbLKL7T0lfkzpP
         i/TbHDGXu4o/g==
Date:   Fri, 25 Aug 2023 01:54:19 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.5] media fixes
Message-ID: <20230825015419.0848a4bc@coco.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-4

For a potential array out-of-bounds at the mediatek's vcodec driver.

Thanks!
Mauro

The following changes since commit 2908042a37b56d6a9a595eca946e187e9d2df39a:

  media: imx: imx7-media-csi: Fix applying format constraints (2023-08-09 13:31:37 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-4

for you to fetch changes up to e7f2e65699e2290fd547ec12a17008764e5d9620:

  media: vcodec: Fix potential array out-of-bounds in encoder queue_setup (2023-08-23 09:56:08 +0200)

----------------------------------------------------------------
media fixes for v6.5-rc8

----------------------------------------------------------------
Wei Chen (1):
      media: vcodec: Fix potential array out-of-bounds in encoder queue_setup

 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 2 ++
 1 file changed, 2 insertions(+)

