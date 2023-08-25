Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30097787D65
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbjHYB64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbjHYB6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:58:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC78E1BD8;
        Thu, 24 Aug 2023 18:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B3606311D;
        Fri, 25 Aug 2023 01:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE80C433C7;
        Fri, 25 Aug 2023 01:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692928717;
        bh=Ye93l/vYXIE6CzcjkMPU9NMl2srnKnjNzI3BvSNb86w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z95eYsZK8CqUJN7DWMuOQULLFKuBclOmhjzV5zDdgPYvC+YERs4ChG+PF2zdLGNXJ
         E8Dx2zcr+RYjMMcR0u8AwSb4zXl1oAZgfk55bp9RBwxEUuYgg1Kh/aZaUvBR79DICh
         TzOv0ElD4sSbbYwPP8gumcSdUs0Pde5wwK6vaiWdmJvP7ByilCeZr+rSdh6Ql6Tv+x
         SLs40C6OMwzyRSPnoGLCHjOai9x1qyKV75Y3sJBSnZ38SyxhyAenEM9m5CMFhS7ToN
         RkcCha58V406j8CVyvl0xIoHEA9Ew+ZV3Ozn70YcER1GZpIkKsmQZVicYu4v2JTeEt
         j5KxlkiheOhtA==
Date:   Thu, 24 Aug 2023 18:58:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>
Subject: Re: linux-next: manual merge of the mlx5-next tree with Linus' tree
Message-ID: <20230824185836.5d40fafd@kernel.org>
In-Reply-To: <20230825110536.41195860@canb.auug.org.au>
References: <20230815123725.4ef5b7b9@canb.auug.org.au>
        <20230825110536.41195860@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 11:05:36 +1000 Stephen Rothwell wrote:
> Was the second part of this resolution (i.e. the update to
> drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c) missed, or
> deemed unnecessary after the mlx5-next tree was merged into the
> net-next tree?

Ugh, I should have caught it. Let me apply your fix from the list.
