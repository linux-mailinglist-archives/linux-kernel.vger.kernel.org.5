Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FDD7848EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHVSBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjHVSBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:01:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE96CC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D73C618CB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF09C433C8;
        Tue, 22 Aug 2023 18:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692727299;
        bh=hBTOuyz8Nt7hcba2eNXqyX4Y0J/02IjEk3pmEmSZmiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jaswbUAThItRiQaPaN86kz78ooHgBPVR7pMuCG0iCNo6cDVi3p8C6ofUIDeGwFkMM
         km08vrAWMl8Suls+uELLTFoU/dQR67nRINxgGbm0wpiIW+WGdD+ZPfti3lI55S8696
         PPSxezV/h09e25GJoUjLicck+wfQJhc5kkT1YoGJvm6p9V6LYdzysLL1BdqPud1tp/
         3MHTVBcSxN/GvBumzi3vfjtDXZdreZpL5RSNdkC+X1idaPcER7PSCfbqti22VHi6C+
         7tpi5Hg1zx/ff9I7VT3dcef/T9KIjIrpcwhJVMvpBaAaXysKcX/r9Mf4PAiK1UwaGb
         rmFa5DOv2tmFA==
Date:   Tue, 22 Aug 2023 11:01:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: fix NULL pointer on
 hw reset
Message-ID: <20230822110138.10252779@kernel.org>
In-Reply-To: <5465c1609b464cc7407ae1530c40821dcdf9d3e6.1692634266.git.daniel@makrotopia.org>
References: <5465c1609b464cc7407ae1530c40821dcdf9d3e6.1692634266.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 17:12:44 +0100 Daniel Golle wrote:
> Changes since v1:
>  * remove unneeded {} initialization for stack allocated memory

s/stack/.bss/, FWIW, thanks for updating!
